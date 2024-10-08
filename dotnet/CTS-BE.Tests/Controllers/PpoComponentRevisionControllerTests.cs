using CTS_BE.DTOs;
using CTS_BE.Factories.Pension;
using CTS_BE.Helper;
using CTS_BE.PensionEnum;
using FluentAssertions;
using FluentAssertions.Execution;

namespace CTS_BE.Tests.Controllers
{
    public class PpoComponentRevisionControllerTests : BaseControllerTests
    {

        [Fact]
        public async Task PpoComponentRevisionController_GetAllPposForComponentRevisions_CanGetAsync()
        {
            // Arrange
            PensionerEntryDTO pensionerEntryDTO = new PensionerFactory().Create();
            ManualPpoReceiptEntryDTO? ppoReceipt = new PpoReceiptFactory().Create();
            pensionerEntryDTO.PpoNo = ppoReceipt.PpoNo;
            pensionerEntryDTO.CategoryId = 30;
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


            PpoBillEntryDTO ppoBillEntryDTO = new () {
                PpoId = ppoId,
                ToDate = DateOnly.FromDateTime(DateTime.Now)
            };

            _ = await CallPostAsJsonAsync<PpoBillSaveResponseDTO, PpoBillEntryDTO>(
                $"/api/v1/ppo/pension-bill",
                ppoBillEntryDTO
            );


            // Act
            JsonAPIResponse<TableResponseDTO<PpoComponentRevisionPpoListItemDTO>>? responseData 
                = await CallGetAsJsonAsync<TableResponseDTO<PpoComponentRevisionPpoListItemDTO>>(
                    $"/api/v1/ppo/component-revision/ppos"
                );

            // Assert
            using (new AssertionScope())
            responseData?.Result.Should().NotBeNull();
            responseData?.Result?.DataCount.Should().BeGreaterThan(0);
            responseData?.ApiResponseStatus.Should().Be(Enum.APIResponseStatus.Success);
        }


        [Fact]
        public async Task PpoComponentRevisionController_CreateSinglePpoComponentRevision_CanCreateAsync()
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

            PpoComponentRevisionEntryDTO ppoComponentRevisionEntryDTO = new () {
                RateId = 39,
                FromDate = DateOnly.Parse("2016-01-01"),
                AmountPerMonth = 10000
            };

            // Act
            JsonAPIResponse<PpoComponentRevisionResponseDTO>? responseData = await CallPostAsJsonAsync<PpoComponentRevisionResponseDTO, PpoComponentRevisionEntryDTO>(
                $"/api/v1/ppo/{ppoId}/component-revision",
                ppoComponentRevisionEntryDTO
            );
            

            // Assert
            using (new AssertionScope())
            responseData?.Result.Should().NotBeNull();
            responseData?.ApiResponseStatus.Should().Be(Enum.APIResponseStatus.Success);
        }

        [Fact]
        public async Task PpoComponentRevisionController_UpdatePpoComponentRevisionById_CanUpdateAsync()
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

            PpoComponentRevisionEntryDTO ppoComponentRevisionEntryDTO = new () {
                RateId = 39,
                FromDate = DateOnly.Parse("2016-01-01"),
                AmountPerMonth = 10000
            };
            JsonAPIResponse<PpoComponentRevisionResponseDTO>? savedRevision = await CallPostAsJsonAsync<PpoComponentRevisionResponseDTO, PpoComponentRevisionEntryDTO>(
                $"/api/v1/ppo/{ppoId}/component-revision",
                ppoComponentRevisionEntryDTO
            );

            PpoComponentRevisionEntryDTO revisionUpdateDTO = new () {
                RateId = 39,
                FromDate = DateOnly.Parse("2016-02-01"),
                AmountPerMonth = 15000
            };

            // Act
            JsonAPIResponse<PpoComponentRevisionResponseDTO>? responseData = await CallPutAsJsonAsync<PpoComponentRevisionResponseDTO, PpoComponentRevisionEntryDTO>(
                $"/api/v1/ppo/{savedRevision?.Result?.Id ?? 0}/component-revision",
                revisionUpdateDTO
            );

            // Assert
            using (new AssertionScope())
            responseData?.Result.Should().NotBeNull();
            responseData?.ApiResponseStatus.Should().Be(Enum.APIResponseStatus.Success);
        }

        [Fact]
        public async Task PpoComponentRevisionController_GetPpoComponentRevisionsByPpoId_CanGetAsync()
        {
            // Arrange
            PensionerEntryDTO pensionerEntryDTO = new PensionerFactory().Create();
            ManualPpoReceiptEntryDTO? ppoReceipt = new PpoReceiptFactory().Create();
            pensionerEntryDTO.PpoNo = ppoReceipt.PpoNo;
            pensionerEntryDTO.CategoryId = 30;
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


            PpoBillEntryDTO ppoBillEntryDTO = new () {
                PpoId = ppoId,
                ToDate = DateOnly.FromDateTime(DateTime.Now)
            };

            _ = await CallPostAsJsonAsync<PpoBillSaveResponseDTO, PpoBillEntryDTO>(
                $"/api/v1/ppo/pension-bill",
                ppoBillEntryDTO
            );


            // Act
            JsonAPIResponse<IEnumerable<PpoComponentRevisionResponseDTO>>? responseData = await CallGetAsJsonAsync<IEnumerable<PpoComponentRevisionResponseDTO>>(
                $"/api/v1/ppo/{ppoId}/component-revision"
            );

            // Assert
            using (new AssertionScope())
            responseData?.Result.Should().NotBeNullOrEmpty();
            responseData?.ApiResponseStatus.Should().Be(Enum.APIResponseStatus.Success);
        }

        [Fact]
        public async Task PpoComponentRevisionController_DeletePpoComponentRevisionById_CanDeleteAsync()
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

            PpoComponentRevisionEntryDTO ppoComponentRevisionEntryDTO = new () {
                RateId = 39,
                FromDate = DateOnly.Parse("2016-01-01"),
                AmountPerMonth = 10000
            };
            JsonAPIResponse<PpoComponentRevisionResponseDTO>? savedRevision = await CallPostAsJsonAsync<PpoComponentRevisionResponseDTO, PpoComponentRevisionEntryDTO>(
                $"/api/v1/ppo/{ppoId}/component-revision",
                ppoComponentRevisionEntryDTO
            );

            // Act
            JsonAPIResponse<PpoComponentRevisionResponseDTO>? responseData = await CallDeleteAsJsonAsync<PpoComponentRevisionResponseDTO>(
                $"/api/v1/ppo/{savedRevision?.Result?.Id ?? 0}/component-revision"
            );

            // Assert
            using (new AssertionScope())
            responseData?.Result.Should().NotBeNull();
            responseData?.ApiResponseStatus.Should().Be(Enum.APIResponseStatus.Success);
        }
    }
}