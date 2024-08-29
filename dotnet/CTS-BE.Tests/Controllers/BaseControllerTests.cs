using System;
using System.Collections.Generic;
using System.Linq;
using System.Text.Json;
using System.Threading.Tasks;
using CTS_BE.Helper;
using Newtonsoft.Json;
using NuGet.Protocol;
using Xunit;
using Xunit.Abstractions;

[assembly: CollectionBehavior(DisableTestParallelization = true)]

namespace CTS_BE.Tests.Controllers
{
    public class BaseControllerTests : ITestCollectionOrderer
    {
        private readonly PensionWebAppFactory _application;
        private readonly HttpClient _client;
        private readonly JsonSerializerOptions _jsonSerializerOptions;
        public BaseControllerTests()
        {
            _application = new();
            _client = _application.CreateClient();
            _client.DefaultRequestHeaders.Add("Authorization", "Bearer eyJhbGciOiJIUzUxMiIsInR5cCI6IkpXVCJ9.eyJhcHBsaWNhdGlvbiI6IntcIklkXCI6MyxcIk5hbWVcIjpcIkNUU1wiLFwiTGV2ZWxzXCI6W3tcIklkXCI6OCxcIk5hbWVcIjpcIlRyZWFzdXJ5XCIsXCJTY29wZVwiOltcIkRBQVwiXX1dLFwiUm9sZXNcIjpbe1wiSWRcIjoyNyxcIk5hbWVcIjpcImNsZXJrXCIsXCJQZXJtaXNzaW9uc1wiOltcImNhbi1yZWNlaXZlLWJpbGxcIl19XX0iLCJuYW1laWQiOiIzOSIsIm5hbWUiOiJDVFMgQ2xlcmsiLCJuYmYiOjE3MTc5OTY2OTksImV4cCI6MTcxODA4MzA5OSwiaWF0IjoxNzE3OTk2Njk5fQ.tLMRXKlXb2eyiE2ApSRgFgbX9EjvPbGNi1dgp_UpGadv-UitDdS4su2ZV6B4kp4Rf0TXjDQHTW7YvNkwciQVQg");
            _jsonSerializerOptions = new JsonSerializerOptions {
                    PropertyNamingPolicy = JsonNamingPolicy.CamelCase,
                    WriteIndented = true
                };
        }
        public HttpClient GetHttpClient() => _client;
        public JsonSerializerOptions GetJsonSerializerOptions() => _jsonSerializerOptions;

        public static void PrintOut(object? dataObject, bool noPrettyPrint = true, bool isRequest = false, string message = "") {
            // Console.WriteLine("Environment: [" + Environment.GetEnvironmentVariables().ToJson().ToString() + "]");
            
            if(Environment.GetEnvironmentVariable("CI", EnvironmentVariableTarget.Process) == "true") return;

            string textToWriteOnConsole = noPrettyPrint ? message : JsonConvert.SerializeObject(
                dataObject,
                Formatting.Indented
            );
            
            // Console.BackgroundColor = ConsoleColor.DarkGreen;
            Console.ForegroundColor = ConsoleColor.DarkMagenta;
            Console.Out.WriteLine((isRequest ? "Request => " : "Response => ") + textToWriteOnConsole);
            Console.ResetColor();
        }

        protected async Task<JsonAPIResponse<TRespDTO>?> CallPostAsJsonAsync<TRespDTO, TEntryDTO>(
            string url,
            TEntryDTO dataEntryDTO
        )
        {
            PrintOut(dataEntryDTO, false, true);

            HttpResponseMessage? response = await this.GetHttpClient()
                .PostAsJsonAsync(url, dataEntryDTO);
            Stream? responseContentStream = await response.Content.ReadAsStreamAsync();

            JsonAPIResponse<TRespDTO>? responseData = null;
            try {

                responseData = System.Text.Json.JsonSerializer
                    .Deserialize<JsonAPIResponse<TRespDTO>>(
                            responseContentStream,
                            GetJsonSerializerOptions()
                        );
            }
            catch(Exception ex) {
                PrintOut(
                    null,
                    true,
                    false,
                    "Exception: " + ex.Message
                );
                PrintOut(
                    null,
                    true,
                    false,
                    "Stream: " + response.Content.ReadAsStringAsync().Result
                );
            }

            PrintOut(responseData, false, false);
            return responseData;
        }

        public IEnumerable<ITestCollection> OrderTestCollections(
            IEnumerable<ITestCollection> testCollections
        ) => testCollections.OrderBy(
            collection => collection.DisplayName
        );
    }
}