using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Xunit;
using FluentAssertions;
using FluentAssertions.Execution;
using CTS_BE.DTOs;
using System.Net.Http.Json;
using System.Text.Json;
using System.Diagnostics;
using CTS_BE.Helper;

namespace CTS_BE.Tests.Controllers
{
    public class PensionControllerTests : BaseControllerTests
    {
        [Fact]
        public async Task PensionController_Echo_CanEcho()
        {
            // Arrange
            PensionStatusEntryDTO pensionStatusEntryDTO = new() {
                PpoId = 10,
                StatusFlag = 12,
                StatusWef = DateOnly.FromDateTime(DateTime.Parse("2024-07-25"))
            };
            PrintOut("RequestInConsole:" + JsonSerializer.Serialize(pensionStatusEntryDTO));

            // Act
            var response = await this.GetHttpClient()
                .PostAsJsonAsync("/api/v1/echo", pensionStatusEntryDTO);
            var responseContentStream = await response.Content.ReadAsStreamAsync();
            // PrintOut("ResponseInConsole:" + response.Content.ReadAsStringAsync().Result);
            var responseData = JsonSerializer
                .Deserialize<JsonAPIResponse<object>>(
                        responseContentStream,
                        GetJsonSerializerOptions()
                    );
            PrintOut("ResponseData => " + JsonSerializer.Serialize(responseData));
            // Assert
            using (new AssertionScope())
            responseData.Should().NotBeNull();
            responseData.Should().BeOfType<JsonAPIResponse<object>>();
            responseData?.ApiResponseStatus.Should().Be(Enum.APIResponseStatus.Success);
            responseData?.Message.Should().Be("Echoing Request");
            responseData?.Result?.ToString().Should().Be(
                    JsonSerializer.Serialize(pensionStatusEntryDTO)
                );
        }

        [Fact]
        public async Task PensionController_SetDateOnly_CanSetDateOnly()
        {
            // Arrange
            var content = new DateOnlyDTO() {
                    DateOnly = DateOnly.FromDateTime(DateTime.Parse("2024-07-29")) 
                };
            PrintOut("RequestInConsole:" + JsonSerializer.Serialize(content));

            // Act
            var response = await this.GetHttpClient()
                .PostAsJsonAsync("/api/v1/date-only", content);
            var responseContentStream = await response.Content.ReadAsStreamAsync();
            var responseData = JsonSerializer
                .Deserialize<JsonAPIResponse<DateOnlyDTO>>(
                        responseContentStream,
                        GetJsonSerializerOptions()
                    );
            PrintOut("ResponseData => " + response.Content.ReadAsStringAsync().Result);

            // Assert
            using (new AssertionScope())
            responseData.Should().NotBeNull();
            responseData.Should().BeOfType<JsonAPIResponse<DateOnlyDTO>>();
            responseData?.ApiResponseStatus.Should().Be(Enum.APIResponseStatus.Success);
            responseData?.Message.Should().Be("Writing DateOnly");
            responseData?.Result?.Should().BeEquivalentTo(content);
        }

        [Fact]
        public async Task PensionController_GetDateOnly_CanGetDateOnly()
        {
            // Arrange

            // Act
            var response = await this.GetHttpClient()
                .GetFromJsonAsync<JsonAPIResponse<DateOnly>>("/api/v1/date-only");

            // Assert
            using (new AssertionScope())
            response?.Should().NotBeNull();
            response?.Should().BeOfType<JsonAPIResponse<DateOnly>>();
            response?.ApiResponseStatus.Should().Be(Enum.APIResponseStatus.Success);
            response?.Message.Should().Be("Reading DateOnly");
            response?.Result.Should().Be(DateOnly.FromDateTime(DateTime.Now));
        }
    
    }
}