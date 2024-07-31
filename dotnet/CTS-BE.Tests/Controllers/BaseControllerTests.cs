using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Xunit;

namespace CTS_BE.Tests.Controllers
{
    public class BaseControllerTests
    {
        private readonly PensionWebAppFactory _application;
        private readonly HttpClient _client;
        public BaseControllerTests()
        {
            _application = new();
            _client = _application.CreateClient();
            _client.DefaultRequestHeaders.Add("Authorization", "Bearer eyJhbGciOiJIUzUxMiIsInR5cCI6IkpXVCJ9.eyJhcHBsaWNhdGlvbiI6IntcIklkXCI6MyxcIk5hbWVcIjpcIkNUU1wiLFwiTGV2ZWxzXCI6W3tcIklkXCI6OCxcIk5hbWVcIjpcIlRyZWFzdXJ5XCIsXCJTY29wZVwiOltcIkRBQVwiXX1dLFwiUm9sZXNcIjpbe1wiSWRcIjoyNyxcIk5hbWVcIjpcImNsZXJrXCIsXCJQZXJtaXNzaW9uc1wiOltcImNhbi1yZWNlaXZlLWJpbGxcIl19XX0iLCJuYW1laWQiOiIzOSIsIm5hbWUiOiJDVFMgQ2xlcmsiLCJuYmYiOjE3MTc5OTY2OTksImV4cCI6MTcxODA4MzA5OSwiaWF0IjoxNzE3OTk2Njk5fQ.tLMRXKlXb2eyiE2ApSRgFgbX9EjvPbGNi1dgp_UpGadv-UitDdS4su2ZV6B4kp4Rf0TXjDQHTW7YvNkwciQVQg");
        }
        public HttpClient GetHttpClient() => _client;

        public static void PrintOut(string textToWriteOnConsole){
            // Console.BackgroundColor = ConsoleColor.DarkGreen;
            Console.ForegroundColor = ConsoleColor.DarkMagenta;
            Console.Out.WriteLine(textToWriteOnConsole);
            Console.ResetColor();
        }
    }
}