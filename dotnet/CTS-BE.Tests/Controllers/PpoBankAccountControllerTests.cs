using System;
using System.Collections.Generic;
using System.Linq;
using System.Text.Json;
using System.Threading.Tasks;
using CTS_BE.DTOs;
using CTS_BE.Helper;
using FluentAssertions;
using FluentAssertions.Execution;

namespace CTS_BE.Tests.Controllers
{
    public class PpoBankAccountControllerTests : BaseControllerTests
    {
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