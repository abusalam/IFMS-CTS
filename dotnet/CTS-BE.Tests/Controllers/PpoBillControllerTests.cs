using CTS_BE.DTOs;
using CTS_BE.Factories.Pension;
using CTS_BE.Helper;
using CTS_BE.PensionEnum;
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

            PensionStatusEntryDTO pensionStatusEntryDTO = new () {
                PpoId = ppoId,
                StatusFlag = PensionStatusFlag.PpoApproved,
                StatusWef = DateOnly.FromDateTime(DateTime.Now)
            };
            _ = await CallPostAsJsonAsync<PensionStatusEntryDTO, PensionStatusEntryDTO>(
                "/api/v1/ppo/status",
                pensionStatusEntryDTO
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

            PensionStatusEntryDTO pensionStatusEntryDTO = new () {
                PpoId = ppoId,
                StatusFlag = PensionStatusFlag.PpoApproved,
                StatusWef = DateOnly.FromDateTime(DateTime.Now)
            };
            _ = await CallPostAsJsonAsync<PensionStatusEntryDTO, PensionStatusEntryDTO>(
                "/api/v1/ppo/status",
                pensionStatusEntryDTO
            );

            InitiateFirstPensionBillDTO initiateFirstPensionBillDTO = new () {
                PpoId = ppoId,
                ToDate = DateOnly.FromDateTime(DateTime.Now)
            };
            _ = await CallPostAsJsonAsync<InitiateFirstPensionBillResponseDTO, InitiateFirstPensionBillDTO>(
                $"/api/v1/ppo/first-bill",
                initiateFirstPensionBillDTO
            );

            int year = DateTime.Now.Year;
            int month = DateTime.Now.Month;

            PpoBillEntryDTO ppoBillEntryDTO = new () {
                PpoId = ppoId,
                Year = year,
                Month = month,
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

        [Fact]
        public async Task PpoBillController_GetFirstPensionBillByPpoId_CanGet()
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

            PensionStatusEntryDTO pensionStatusEntryDTO = new () {
                PpoId = ppoId,
                StatusFlag = PensionStatusFlag.PpoApproved,
                StatusWef = DateOnly.FromDateTime(DateTime.Now)
            };
            _ = await CallPostAsJsonAsync<PensionStatusEntryDTO, PensionStatusEntryDTO>(
                "/api/v1/ppo/status",
                pensionStatusEntryDTO
            );
            
            InitiateFirstPensionBillDTO initiateFirstPensionBillDTO = new () {
                PpoId = ppoId,
                ToDate = DateOnly.FromDateTime(DateTime.Now)
            };

            _ = await CallPostAsJsonAsync<InitiateFirstPensionBillResponseDTO, InitiateFirstPensionBillDTO>(
                $"/api/v1/ppo/first-bill",
                initiateFirstPensionBillDTO
            );

            // Act
            var firstBill = await CallGetAsJsonAsync<PpoBillResponseDTO>(
                $"/api/v1/ppo/first-bill/{ppoId}"
            );

            // Assert
            using (new AssertionScope())
            firstBill?.ApiResponseStatus.Should().Be(Enum.APIResponseStatus.Success);
            firstBill?.Result?.Pensioner.PpoId.Should().Be(ppoId);

        }
    
        [Fact]
        public async Task PpoBillController_GetAllPposForRegularBill_CanGet()
        {
            // Arrange
            int year = DateTime.Now.Year;
            int month = DateTime.Now.Month;

            // Act
            var firstBill = await CallGetAsJsonAsync<PpoListResponseDTO>(
                $"/api/v1/ppo/pension-bill/{year}/{month}/ppos"
            );
            // Assert
            using (new AssertionScope())
            firstBill?.ApiResponseStatus.Should().Be(Enum.APIResponseStatus.Success);
            firstBill?.Result.Should().NotBeNull();
            firstBill?.Result?.PpoList.Count.Should().BeGreaterThan(0);
        }

        [Fact]
        public async Task PpoBillController_GetAllRegularPensionBills_CanGet()
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

            PensionStatusEntryDTO pensionStatusEntryDTO = new () {
                PpoId = ppoId,
                StatusFlag = PensionStatusFlag.PpoApproved,
                StatusWef = DateOnly.FromDateTime(DateTime.Now)
            };
            _ = await CallPostAsJsonAsync<PensionStatusEntryDTO, PensionStatusEntryDTO>(
                "/api/v1/ppo/status",
                pensionStatusEntryDTO
            );

            InitiateFirstPensionBillDTO initiateFirstPensionBillDTO = new () {
                PpoId = ppoId,
                ToDate = DateOnly.FromDateTime(DateTime.Now)
            };
            _ = await CallPostAsJsonAsync<PpoBillSaveResponseDTO, InitiateFirstPensionBillDTO>(
                $"/api/v1/ppo/first-bill",
                initiateFirstPensionBillDTO
            );

            int year = DateTime.Now.Year;
            int month = DateTime.Now.Month;

            PpoBillEntryDTO ppoBillEntryDTO = new () {
                PpoId = ppoId,
                Month = month,
                Year = year,
                ToDate = DateOnly.FromDateTime(DateTime.Now)
            };

            _ = await CallPostAsJsonAsync<PpoBillSaveResponseDTO, PpoBillEntryDTO>(
                $"/api/v1/ppo/pension-bill",
                ppoBillEntryDTO
            );


            // Act
            var firstBill = await CallGetAsJsonAsync<RegularBillListResponseDTO>(
                $"/api/v1/ppo/pension-bill/{year}/{month}/regular-bills"
            );

            // Assert
            using (new AssertionScope())
            firstBill?.ApiResponseStatus.Should().Be(Enum.APIResponseStatus.Success);
            firstBill?.Result.Should().NotBeNull();
            firstBill?.Result?.RegularBillCount.Should().BeGreaterThan(0);
        }
    }
}