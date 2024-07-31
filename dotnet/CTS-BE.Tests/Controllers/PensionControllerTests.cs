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

        [Fact]
        public async Task PensionController_ControlEchoRequestInResponse_CanEchoDateOnlyFromPayload()
        {
            // Arrange
            var content = new DateOnlyDTO() {
                    DateOnly = DateOnly.FromDateTime(DateTime.Parse("2024-07-29")) 
                };

            // Act
            var response = await this.GetHttpClient()
                .PostAsJsonAsync("/api/v1/date-only", content);
            var responseContentStream = await response.Content.ReadAsStreamAsync();
            var responseData = JsonSerializer
                .Deserialize<JsonAPIResponse<DateOnlyDTO>>(
                        responseContentStream,
                        new JsonSerializerOptions {
                            PropertyNamingPolicy = JsonNamingPolicy.CamelCase,
                            WriteIndented = true
                        }
                    );
            // PrintOut(response.Content.ReadAsStringAsync().Result);

            // Assert
            using (new AssertionScope())
            responseData.Should().NotBeNull();
            responseData.Should().BeOfType<JsonAPIResponse<DateOnlyDTO>>();
            responseData?.ApiResponseStatus.Should().Be(Enum.APIResponseStatus.Success);
            responseData?.Message.Should().Be("Writing DateOnly");
            responseData?.Result?.Should().BeEquivalentTo(content);
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
            // PrintOut("RequestInConsole:" + JsonSerializer.Serialize(pensionStatusEntryDTO));

            // Act
            var response = await this.GetHttpClient()
                .PostAsJsonAsync("/api/v1/echo", pensionStatusEntryDTO);
            var responseContentStream = await response.Content.ReadAsStreamAsync();
            // PrintOut("ResponseInConsole:" + response.Content.ReadAsStringAsync().Result);
            var responseData = JsonSerializer
                .Deserialize<JsonAPIResponse<object>>(
                        responseContentStream,
                        new JsonSerializerOptions {
                            PropertyNamingPolicy = JsonNamingPolicy.CamelCase,
                            WriteIndented = true
                        }
                    );
            // PrintOut("ResponseData => " + JsonSerializer.Serialize(responseData));
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
        public async Task PensionController_ControlManualPpoReceiptsCreate_CanCreate()
        {
            // Arrange
            ManualPpoReceiptEntryDTO manualPpoReceiptEntryDTO = new() {
                PpoNo = $"PPO-{Random.Shared.Next(10000, 99999)}",
                PensionerName = "John Doe",
                DateOfCommencement = DateOnly.FromDateTime(DateTime.Parse("2024-07-30")),
                MobileNumber = "9876543210",
                ReceiptDate = DateOnly.FromDateTime(DateTime.Parse("2024-07-30")),
                PsaCode = 'A',
                PpoType = 'N'
            };
            // PrintOut("RequestInConsole:" + JsonSerializer.Serialize(manualPpoReceiptEntryDTO));

            // Act
            var response = await this.GetHttpClient()
                .PostAsJsonAsync("/api/v1/manual-ppo/receipts", manualPpoReceiptEntryDTO);
            var responseContentStream = await response.Content.ReadAsStreamAsync();
            // PrintOut("ResponseInConsole:" + response.Content.ReadAsStringAsync().Result);
            var responseData = JsonSerializer
                .Deserialize<JsonAPIResponse<ManualPpoReceiptResponseDTO>>(
                        responseContentStream,
                        new JsonSerializerOptions {
                            PropertyNamingPolicy = JsonNamingPolicy.CamelCase,
                            WriteIndented = true
                        }
                    );

            ManualPpoReceiptResponseDTO? responseResult = responseData?.Result;
            responseResult.FillFrom(manualPpoReceiptEntryDTO);


            // Assert
            using (new AssertionScope())
            responseData.Should().NotBeNull();
            responseData.Should().BeOfType<JsonAPIResponse<ManualPpoReceiptResponseDTO>>();
            responseData?.ApiResponseStatus.Should().Be(Enum.APIResponseStatus.Success);
            responseData?.Message.Should().Be("PPO Received Successfully!");
            responseData?.Result.Should().BeEquivalentTo(responseResult);
        }
        
        [Fact]
        public async Task PensionController_ControlPensionerDetailsCreate_CanCreate()
        {
            // Arrange
            PensionerEntryDTO pensionerEntryDTO = new() {
                PpoNo = $"PPO-{Random.Shared.Next(10000, 99999)}",
                PpoType = 'P',
                PsaType = 'A',
                PpoSubType = 'N',
                PpoCategory = 'C',
                PpoSubCategory = 'N',
                PensionerName = "John Doe",
                DateOfBirth = DateOnly.FromDateTime(DateTime.Parse("1990-07-30")),
                Gender = 'M',
                MobileNumber = "9876543210",
                EmailId = "CnTqS@example.com",
                PensionerAddress = "Pune",
                IdentificationMark = "Mole",
                PanNo = "ABCD1234E",
                AadhaarNo = "123456789012",
                DateOfRetirement = DateOnly.FromDateTime(DateTime.Parse("2034-07-30")),
                DateOfCommencement = DateOnly.FromDateTime(DateTime.Parse("2024-07-30")),
                BasicPensionAmount = 10000,
                CommutedPensionAmount = 1000,
                EnhancePensionAmount = 10000,
                ReducedPensionAmount = 9000,
                Religion = 'H'
            };
            // PrintOut("Request => " + JsonSerializer.Serialize(pensionerEntryDTO));

            // Act
            var response = await this.GetHttpClient()
                .PostAsJsonAsync("/api/v1/ppo/details", pensionerEntryDTO);
            var responseContentStream = await response.Content.ReadAsStreamAsync();
            // PrintOut("Response => " + response.Content.ReadAsStringAsync().Result);
             var responseData = JsonSerializer
                .Deserialize<JsonAPIResponse<PensionerResponseDTO>>(
                        responseContentStream,
                        new JsonSerializerOptions {
                            PropertyNamingPolicy = JsonNamingPolicy.CamelCase,
                            WriteIndented = true
                        }
                    );

            PensionerResponseDTO? responseResult = responseData?.Result;
            responseResult.FillFrom(pensionerEntryDTO);


            // Assert
            using (new AssertionScope())
            responseData.Should().NotBeNull();
            responseData.Should().BeOfType<JsonAPIResponse<PensionerResponseDTO>>();
            responseData?.ApiResponseStatus.Should().Be(Enum.APIResponseStatus.Success);
            responseData?.Message.Should().Be("PPO Details saved sucessfully!");
            responseData?.Result.Should().BeEquivalentTo(responseResult);
        }
    }
}