using CTS_BE.DTOs;
using CTS_BE.Factories.Pension;
using CTS_BE.Helper;
using FluentAssertions;
using FluentAssertions.Execution;

namespace CTS_BE.Tests.Controllers
{
    public class PpoBillControllerTests : BaseControllerTests
    {
        [Fact]
        public async Task PpoBillController_CanGenerateFirstPensionBill()
        {
            // Arrange
            PensionerEntryDTO pensionerEntryDTO = new PensionerFactory().Create();
            ManualPpoReceiptEntryDTO? ppoReceipt = new PpoReceiptFactory().Create();
            pensionerEntryDTO.PpoNo = ppoReceipt.PpoNo;
            ppoReceipt.DateOfCommencement = pensionerEntryDTO.DateOfCommencement;
            _ = await CallPostAsJsonAsync<ManualPpoReceiptResponseDTO, ManualPpoReceiptEntryDTO>(
                    "/api/v1/manual-ppo/receipts",
                    ppoReceipt
                );
            JsonAPIResponse<PensionerResponseDTO>? pensioner = await CallPostAsJsonAsync<PensionerResponseDTO, PensionerEntryDTO>(
                "/api/v1/ppo/details",
                pensionerEntryDTO
            );
            
            int ppoId = pensioner?.Result?.PpoId ?? 0;
            PensionerBankAcEntryDTO bankAccountEntryDTO = new BankAccountFactory().Create();
            _ = await CallPostAsJsonAsync<PensionerBankAcResponseDTO, PensionerBankAcEntryDTO>(
                $"/api/v1/ppo/{ppoId}/bank-accounts",
                bankAccountEntryDTO
            );
            InitiateFirstPensionBillDTO initiateFirstPensionBillDTO = new () {
                PpoId = ppoId,
                ToDate = DateOnly.FromDateTime(DateTime.Now)
            };

            // Act
            JsonAPIResponse<InitiateFirstPensionBillResponseDTO>? generateFirstBill = await CallPostAsJsonAsync<InitiateFirstPensionBillResponseDTO, InitiateFirstPensionBillDTO>(
                $"/api/v1/ppo/first-bill-generate",
                initiateFirstPensionBillDTO
            );

            // Assert
            using (new AssertionScope())
            generateFirstBill?.ApiResponseStatus.Should().Be(Enum.APIResponseStatus.Success);
        }
    }
}