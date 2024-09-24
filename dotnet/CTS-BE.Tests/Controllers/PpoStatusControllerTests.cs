using CTS_BE.DTOs;
using CTS_BE.Enum;
using CTS_BE.Factories.Pension;
using CTS_BE.Helper;
using CTS_BE.PensionEnum;
using FluentAssertions;
using FluentAssertions.Execution;

namespace CTS_BE.Tests.Controllers
{
    public class PpoStatusControllerTests : BaseControllerTests
    {
        [Fact]
        public async Task PpoStatusController_SetPpoStatusFlag_CanSet()
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

            // Act
            var responseData = await CallPostAsJsonAsync<PensionStatusEntryDTO, PensionStatusEntryDTO>(
                "/api/v1/ppo/status",
                pensionStatusEntryDTO
            );

            // Assert
            using (new AssertionScope())
            responseData.Should().NotBeNull();
            responseData?.ApiResponseStatus.Should().Be(APIResponseStatus.Success);
        }


        [Fact]
        public async Task PpoStatusController_GetPpoStatusFlagByPpoId_CanGet()
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

            // Act
            var responseData = await CallGetAsJsonAsync<PensionStatusEntryDTO>(
                $"/api/v1/ppo/{ppoId}/status/{PensionStatusFlag.PpoApproved}"
            );

            // Assert
            using (new AssertionScope())
            responseData.Should().NotBeNull();
            responseData?.ApiResponseStatus.Should().Be(APIResponseStatus.Success);
        }

        [Fact]
        public async Task PpoStatusController_ClearPpoStatusFlagByPpoId_CanClear()
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

            // Act
            var responseData = await CallDeleteAsJsonAsync<PensionStatusEntryDTO>(
                $"/api/v1/ppo/{ppoId}/status/{PensionStatusFlag.PpoApproved}"
            );


            // Assert
            using (new AssertionScope())
            responseData.Should().NotBeNull();
            responseData?.ApiResponseStatus.Should().Be(APIResponseStatus.Success);
        }
    }
}