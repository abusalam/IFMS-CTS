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

        private readonly PensionerBankAcEntryDTO bankAccountEntryDTO = new() {
            BankAcNo = "1234567890",
            IfscCode = "SBI12345678",
            BranchCode = 531,
            BankCode = 2,
            AccountHolderName = "John Doe"
        };

        [Fact]
        public async Task PensionController_ControlPensionerBankAccountsCreate_CanCreate()
        {
            // Arrange


            // Act

            var responseData = await TryToCreateBankAccount(
                1, 
                Enum.APIResponseStatus.Success, 
                "Bank account details saved sucessfully!"
            );
            var responseDataExists = await TryToCreateBankAccount(
                1,
                Enum.APIResponseStatus.Error,
                "Bank Account already exists!"
            );

            // Assert
            using (new AssertionScope())
            
            responseData.Should().NotBeNull();
            responseDataExists.Should().NotBeNull();

            responseData?.ApiResponseStatus.Should().Be(Enum.APIResponseStatus.Success);
            responseDataExists?.ApiResponseStatus.Should().Be(Enum.APIResponseStatus.Error);

            responseData.Should().BeOfType<JsonAPIResponse<PensionerBankAcResponseDTO>>();
            responseDataExists.Should().BeOfType<JsonAPIResponse<PensionerBankAcResponseDTO>>();

            responseData?.Result.Should().BeEquivalentTo(bankAccountEntryDTO);
            responseDataExists?.Result?.DataSource?.GetType().GetProperty("Message")?
                .GetValue(responseDataExists.Result.DataSource)
                .Should().Be("Bank Account already exists!");

            responseData?.Message.Should().Be("Bank account details saved sucessfully!");
            responseDataExists?.Message.Should().Be("Bank Account already exists!");
        }

        private async Task<JsonAPIResponse<PensionerBankAcResponseDTO>?> TryToCreateBankAccount(
                int ppoId,
                Enum.APIResponseStatus apiResponseStatus,
                string message
            )
        {
            // Arrange
            PrintOut("Request => " + JsonSerializer.Serialize(bankAccountEntryDTO));

            // Act
            var response = await this.GetHttpClient()
                .PostAsJsonAsync($"/api/v1/ppo/{ppoId}/bank-accounts", bankAccountEntryDTO);
            var responseContentStream = await response.Content.ReadAsStreamAsync();
            PrintOut("Response => " + response.Content.ReadAsStringAsync().Result);

            JsonAPIResponse<PensionerBankAcResponseDTO>? responseData = JsonSerializer
                .Deserialize<JsonAPIResponse<PensionerBankAcResponseDTO>>(
                        responseContentStream,
                        GetJsonSerializerOptions()
                    );
            return responseData;
        }
    
    }
}