using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.VisualStudio.TestPlatform.TestHost;
using Microsoft.AspNetCore.Mvc.Testing;
using Microsoft.Extensions.Configuration;
using Microsoft.Extensions.DependencyInjection;
using CTS_BE.DAL;
using Microsoft.AspNetCore.TestHost;
using Microsoft.Extensions.DependencyInjection.Extensions;
using Microsoft.EntityFrameworkCore;
using Microsoft.AspNetCore.Authentication;

namespace CTS_BE.Tests
{
    internal class PensionWebAppFactory : WebApplicationFactory<Program>
    {
        override protected void ConfigureWebHost(Microsoft.AspNetCore.Hosting.IWebHostBuilder builder)
        {
            builder.ConfigureTestServices(services =>
            {
                // Remove the existing DbContextOptions
                services.RemoveAll(typeof(DbContextOptions<PensionDbContext>));

                // Register a new DBContext that will use our test connection string
                string? connString = GetConnectionString();
                services.AddNpgsql<PensionDbContext>(connString);

                // Add the authentication handler
                services.AddAuthentication(defaultScheme: "TestScheme")
                    .AddScheme<AuthenticationSchemeOptions, TestAuthHandler>(
                        "TestScheme", options => { });

                // Delete the database (if exists) to ensure we start clean
                PensionDbContext dbContext = CreateDbContext(services);
                dbContext.Database.EnsureDeleted();
            });
        }

        private static string? GetConnectionString()
        {
            var configuration = new ConfigurationBuilder()
                .AddUserSecrets<PensionWebAppFactory>()
                .Build();

            var connString = configuration.GetConnectionString("DBConnection");
            return connString;
        }

        private static PensionDbContext CreateDbContext(IServiceCollection services)
        {
            var serviceProvider = services.BuildServiceProvider();
            var scope = serviceProvider.CreateScope();
            var dbContext = scope.ServiceProvider.GetRequiredService<PensionDbContext>();
            return dbContext;
        }    
    }
}

// https://juliocasal.com/blog/Dont-Unit-Test-Your-AspNetCore-API