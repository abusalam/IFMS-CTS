using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.EntityFrameworkCore;
namespace CTS_BE.Tests
{
    public class DatabaseFixture : IDisposable
    {
        private readonly DbContext _context;

        // Constructor is called only once before all tests
        public DatabaseFixture()
        {
            // Create random database name suffix as a safety measure
            var id = Guid.NewGuid().ToString().Replace("-", "");

            // Create a template database name and store it for later use
            TemplateDatabaseName = $"my_db_tmpl_{id}";

            // Create connection string and store it for later use
            Connection = $"Host=my_host;Database={TemplateDatabaseName};Username=my_user;Password=my_pw";

            // Configure DbContext
            var optionsBuilder = new DbContextOptionsBuilder();
            optionsBuilder.UseNpgsql(Connection);

            // Create instance of you application's DbContext
            _context = new MyApplicationDbContext(optionsBuilder.Options);

            // Create database schema
            _context.Database.EnsureCreated();

            // todo: Insert common data here

            // Close template database connection, we will not need it for now
            _context.Database.CloseConnection();
        }

        // We'll use this later
        public string TemplateDatabaseName { get; }

        // We'll use this later
        public string Connection { get; }

        // Dispose is called only once after all tests
        public void Dispose()
        {
            // Remove template database
            _context.Database.EnsureDeleted();
        }
    }

    internal class MyApplicationDbContext : DbContext
    {
        public MyApplicationDbContext(DbContextOptions options) : base(options)
        {
        }
    }
}

// https://dev.to/davidkudera/creating-new-postgresql-db-for-every-xunit-test-2h73