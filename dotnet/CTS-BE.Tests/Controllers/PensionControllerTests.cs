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
                        GetJsonSerializerOptions()
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
                        GetJsonSerializerOptions()
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
                        GetJsonSerializerOptions()
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
                ReceiptId = 1,
                PpoNo = $"PPO-{Random.Shared.Next(10000, 99999)}",
                PpoType = 'P',
                PpoSubType = 'N',
                CategoryId = 31,
                PensionerName = "John Doe",
                DateOfBirth = DateOnly.FromDateTime(DateTime.Parse("1990-07-30")),
                Gender = 'M',
                MobileNumber = "9876543210",
                EmailId = "CnTqS@example.com",
                PensionerAddress = "Pune",
                IdentificationMark = "Mole",
                PanNo = "ABCDE1234F",
                AadhaarNo = "123456789012",
                DateOfRetirement = DateOnly.FromDateTime(DateTime.Parse("2014-07-30")),
                DateOfCommencement = DateOnly.FromDateTime(DateTime.Parse("2024-07-30")),
                BasicPensionAmount = 10000,
                CommutedPensionAmount = 1000,
                EnhancePensionAmount = 10000,
                ReducedPensionAmount = 9000,
                Religion = 'H'
            };
            PrintOut("Request => " + JsonSerializer.Serialize(pensionerEntryDTO));

            // Act
            var response = await this.GetHttpClient()
                .PostAsJsonAsync("/api/v1/ppo/details", pensionerEntryDTO);
            var responseContentStream = await response.Content.ReadAsStreamAsync();
            PrintOut("Response => " + response.Content.ReadAsStringAsync().Result);
             var responseData = JsonSerializer
                .Deserialize<JsonAPIResponse<PensionerResponseDTO>>(
                        responseContentStream,
                        GetJsonSerializerOptions()
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

        [Theory]
        [InlineData(1, Enum.APIResponseStatus.Success, "Bank account details saved sucessfully!")]
        [InlineData(1, Enum.APIResponseStatus.Error, "Error: Bank account details not saved! Check DataSource for more details!")]
        public async Task PensionController_ControlPensionerBankAccountsCreate_CanCreate(
                int ppoId,
                Enum.APIResponseStatus apiResponseStatus,
                string message
            )
        {
            // Arrange
            PensionerBankAcDTO bankAccountEntryDTO = new() {
                BankAcNo = "1234567890",
                IfscCode = "SBI12345678",
                BranchCode = 531,
                BankCode = 2,
                AccountHolderName = "John Doe"
            };

            PrintOut("Request => " + JsonSerializer.Serialize(bankAccountEntryDTO));

            // Act
            var response = await this.GetHttpClient()
                .PostAsJsonAsync($"/api/v1/ppo/{ppoId}/bank-accounts", bankAccountEntryDTO);
            var responseContentStream = await response.Content.ReadAsStreamAsync();
            PrintOut("Response => " + response.Content.ReadAsStringAsync().Result);

            var responseData = JsonSerializer
                .Deserialize<JsonAPIResponse<PensionerBankAcDTO>>(
                        responseContentStream,
                        GetJsonSerializerOptions()
                    );

            // Assert
            using (new AssertionScope())
            responseData.Should().NotBeNull();
            responseData?.ApiResponseStatus.Should().Be(apiResponseStatus);
            responseData.Should().BeOfType<JsonAPIResponse<PensionerBankAcDTO>>();
            if(apiResponseStatus == Enum.APIResponseStatus.Success) {
                responseData?.Result.Should().BeEquivalentTo(bankAccountEntryDTO);
            } else {
                responseData?.Result?.DataSource?.GetType().GetProperty("Message")?
                    .GetValue(responseData.Result.DataSource)
                    .Should().Be("Bank Account already exists!");
            }
            responseData?.Message.Should().Be(message);
        }
    
    }
}