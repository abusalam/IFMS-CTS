using System;
using System.Collections.Generic;
using System.Linq;
using System.Text.Json;
using System.Threading.Tasks;
using Bogus;
using CTS_BE.BAL.Services.Pension;
using CTS_BE.DAL.Repositories.Pension;
using CTS_BE.DTOs;
using CTS_BE.Helper;
using CTS_BE.Tests.Factory;
using FluentAssertions;
using FluentAssertions.Execution;
using NPOI.SS.Formula.Functions;

namespace CTS_BE.Tests.Controllers
{
    public class PpoBankAccountControllerTests : BaseControllerTests
    {

        [Fact]
        public async Task FakerTest()
        {
            PrintOut(new PpoReceiptFactory().Create(),false, true);
            PrintOut(new PensionerFactory().Create(),false, true);
            PrintOut(new BankAccountFactory().Create(),false, true);
            await Task.CompletedTask;
        }

        [Fact]
        public async Task PensionController_ControlPensionerBankAccountsCreate_CanCreate()
        {
            // Arrange
            Random rand = new();
            PensionerEntryDTO pensionerEntryDTO = new PensionerFactory().Create();
            ManualPpoReceiptEntryDTO? ppoReceipt = new PpoReceiptFactory().Create();
            pensionerEntryDTO.PpoNo = ppoReceipt.PpoNo;
            _ = await CallPostAsJsonAsync<ManualPpoReceiptResponseDTO, ManualPpoReceiptEntryDTO>(
                    "/api/v1/manual-ppo/receipts",
                    ppoReceipt
                );
            JsonAPIResponse<PensionerResponseDTO>? pensionerResponse = await CallPostAsJsonAsync<PensionerResponseDTO, PensionerEntryDTO>(
                "/api/v1/ppo/details",
                pensionerEntryDTO
            );
            
            int? ppoId = pensionerResponse?.Result?.PpoId;
            PensionerBankAcEntryDTO bankAccountEntryDTO = new BankAccountFactory().Create();


            // Act
            JsonAPIResponse<PensionerBankAcResponseDTO>? responseData = await CallPostAsJsonAsync<PensionerBankAcResponseDTO, PensionerBankAcEntryDTO>(
                $"/api/v1/ppo/{ppoId}/bank-accounts",
                bankAccountEntryDTO
            );
            JsonAPIResponse<PensionerBankAcResponseDTO>? responseDataExists = await CallPostAsJsonAsync<PensionerBankAcResponseDTO, PensionerBankAcEntryDTO>(
                $"/api/v1/ppo/{ppoId}/bank-accounts",
                bankAccountEntryDTO
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
    
    }
}