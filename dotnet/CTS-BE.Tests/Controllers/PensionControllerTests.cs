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
        public async Task PensionController_ControlEchoRequestInResponse_CanEchoDateOnly()
        {
            // Arrange
            PensionStatusDTO pensionStatusDTO = new() {
                StatusFlag = 1,
                StatusWef = DateOnly.FromDateTime(DateTime.Parse("2024-07-29"))
            };
            string request = JsonSerializer.Serialize(pensionStatusDTO);

            // Act
            var response = await this.GetHttpClient().GetFromJsonAsync<APIResponse<DateOnly>>("/api/v1/date-only");

            // Assert
            using (new AssertionScope())
            response?.Should().NotBeNull();
            response?.Should().BeOfType<APIResponse<DateOnly>>();
            response?.apiResponseStatus.Should().Be(Enum.APIResponseStatus.Success);
            response?.result.Should().Be(DateOnly.FromDateTime(DateTime.Now));
        }

        [Fact]
        public async Task PensionController_ControlEchoRequestInResponse_CanEchoDateOnlyFromPayload()
        {
            // Arrange
            var content = JsonContent.Create(
                    new {
                        dateOnly = DateOnly.FromDateTime(DateTime.Parse("2024-07-29")) 
                    }
                );

            // Act
            var response = await this.GetHttpClient().PostAsync("/api/v1/date-only", content);
            var responseContentStream = await response.Content.ReadAsStreamAsync();
            var responseData = JsonSerializer.Deserialize<JsonAPIResponse<object>>(responseContentStream);
            // Console.Out.WriteLine(response.Content.ReadAsStringAsync().Result);

            // Assert
            using (new AssertionScope())
            responseData.Should().NotBeNull();
            responseData.Should().BeOfType<JsonAPIResponse<object>>();
            responseData?.apiResponseStatus.Should().Be(Enum.APIResponseStatus.Success);
            responseData?.message.Should().Be("Writing DateOnly");
            responseData?.result?.ToString().Should().Be(JsonSerializer.Serialize(content.Value));
        }

        [Fact]
        public async Task PensionController_ControlEchoRequestInResponse_CanEchoRequestFromPayload()
        {
            // Arrange
            PensionStatusEntryDTO pensionStatusEntryDTO = new() {
                PpoId = 10,
                StatusFlag = 12,
                StatusWef = DateOnly.FromDateTime(DateTime.Parse("2024-07-25"))
            };
            // Console.Out.WriteLine("RequestInConsole:" + JsonSerializer.Serialize(pensionStatusEntryDTO));

            // Act
            var response = await this.GetHttpClient().PostAsJsonAsync("/api/v1/echo", pensionStatusEntryDTO);
            var responseContentStream = await response.Content.ReadAsStreamAsync();
            // Console.Out.WriteLine("ResponseInConsole:" + response.Content.ReadAsStringAsync().Result);
            var responseData = JsonSerializer.Deserialize<JsonAPIResponse<PensionStatusEntryDTO>>(responseContentStream);

            // Assert
            using (new AssertionScope())
            responseData.Should().NotBeNull();
            responseData.Should().BeOfType<JsonAPIResponse<PensionStatusEntryDTO>>();
            responseData?.apiResponseStatus.Should().Be(Enum.APIResponseStatus.Success);
            responseData?.message.Should().Be("Echoing Request");
            responseData?.result.Should().BeEquivalentTo(pensionStatusEntryDTO);
        }
    }
}