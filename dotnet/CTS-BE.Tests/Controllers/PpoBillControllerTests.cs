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
        public async Task PpoBillController_GenerateFirstPensionBill_CanGenerate()
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

        [Fact]
        public async Task PpoBillController_SaveFirstPensionBill_CanSave()
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
            JsonAPIResponse<InitiateFirstPensionBillResponseDTO>? saveFirstBill = await CallPostAsJsonAsync<InitiateFirstPensionBillResponseDTO, InitiateFirstPensionBillDTO>(
                $"/api/v1/ppo/first-bill",
                initiateFirstPensionBillDTO
            );

            // Assert
            saveFirstBill?.ApiResponseStatus.Should().Be(Enum.APIResponseStatus.Success);
        }

        [Fact]
        public async Task PpoBillController_SaveRegularPensionBill_CanSave()
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
            _ = await CallPostAsJsonAsync<InitiateFirstPensionBillResponseDTO, InitiateFirstPensionBillDTO>(
                $"/api/v1/ppo/first-bill",
                initiateFirstPensionBillDTO
            );

            PpoBillEntryDTO ppoBillEntryDTO = new () {
                PpoId = ppoId,
                ToDate = DateOnly.FromDateTime(DateTime.Now)
            };

            // Act
            JsonAPIResponse<PpoBillSaveResponseDTO>? saveRegularBill = await CallPostAsJsonAsync<PpoBillSaveResponseDTO, PpoBillEntryDTO>(
                $"/api/v1/ppo/pension-bill",
                ppoBillEntryDTO
            );

            // Assert
            saveRegularBill?.ApiResponseStatus.Should().Be(Enum.APIResponseStatus.Success);
        }
    }
}