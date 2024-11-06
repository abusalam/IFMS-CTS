using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using CTS_BE.DTOs;
using CTS_BE.Factories.Pension;
using CTS_BE.Helper;
using FluentAssertions;
using FluentAssertions.Execution;
using Xunit;

namespace CTS_BE.Tests.Controllers
{
    public class NomineeControllerTests : BaseControllerTests
    {
        [Fact]
        public async Task NomineeController_RegisterNomineeDetails_CanRegister()
        {
            // Arrange
            ManualPpoReceiptEntryDTO? ppoReceipt = new PpoReceiptFactory().Create();
            PensionerEntryDTO pensionerEntryDTO = new PensionerFactory().Create();
            NomineeEntryDTO? nomineeDetails = new NomineeFactory().Create();
            pensionerEntryDTO.PpoNo = ppoReceipt.PpoNo;
            ppoReceipt.DateOfCommencement = pensionerEntryDTO.DateOfCommencement;
            _ = await CallPostAsJsonAsync<ManualPpoReceiptResponseDTO, ManualPpoReceiptEntryDTO>(
                    "/api/v1/manual-ppo/receipts",
                    ppoReceipt
                );

            JsonAPIResponse<PensionerResponseDTO>? pensionerData =
                await CallPostAsJsonAsync<PensionerResponseDTO, PensionerEntryDTO>(
                    "/api/v1/ppo/details",
                    pensionerEntryDTO
                );
            nomineeDetails.PpoId = pensionerData?.Result?.PpoId ?? 0;


            // Act
            JsonAPIResponse<NomineeResponseDTO>? responseData =
                await CallPostAsJsonAsync<NomineeResponseDTO, NomineeEntryDTO>(
                    "/api/v1/ppo/nominee",
                    nomineeDetails
                );

            // Assert
            using (new AssertionScope())
            responseData.Should().NotBeNull();
            responseData.Should().BeOfType<JsonAPIResponse<NomineeResponseDTO>>();
            responseData?.ApiResponseStatus.Should().Be(Enum.APIResponseStatus.Success);
        }


        [Fact]
        public async Task NomineeController_UpdateNomineeDetailsById_CanUpdate()
        {
            // Arrange
            ManualPpoReceiptEntryDTO? ppoReceipt = new PpoReceiptFactory().Create();
            PensionerEntryDTO pensionerEntryDTO = new PensionerFactory().Create();
            NomineeEntryDTO? nomineeDetails = new NomineeFactory().Create();
            pensionerEntryDTO.PpoNo = ppoReceipt.PpoNo;
            ppoReceipt.DateOfCommencement = pensionerEntryDTO.DateOfCommencement;
            _ = await CallPostAsJsonAsync<ManualPpoReceiptResponseDTO, ManualPpoReceiptEntryDTO>(
                    "/api/v1/manual-ppo/receipts",
                    ppoReceipt
                );

            JsonAPIResponse<PensionerResponseDTO>? pensionerData =
                await CallPostAsJsonAsync<PensionerResponseDTO, PensionerEntryDTO>(
                    "/api/v1/ppo/details",
                    pensionerEntryDTO
                );
            nomineeDetails.PpoId = pensionerData?.Result?.PpoId ?? 0;

            JsonAPIResponse<NomineeResponseDTO>? nomineeDetailsData =
                await CallPostAsJsonAsync<NomineeResponseDTO, NomineeEntryDTO>(
                    "/api/v1/ppo/nominee",
                    nomineeDetails
                );
            NomineeEntryDTO nomineeDetailsUpdate = new NomineeFactory().Create();
            nomineeDetailsUpdate.PpoId = pensionerData?.Result?.PpoId ?? 0;

            // Act
            JsonAPIResponse<NomineeResponseDTO>? responseData =
                await CallPutAsJsonAsync<NomineeResponseDTO, NomineeEntryDTO>(
                    "/api/v1/ppo/nominee/" + nomineeDetailsData?.Result?.Id,
                    nomineeDetailsUpdate
                );

            // Assert
            using (new AssertionScope())
            responseData.Should().NotBeNull();
            responseData.Should().BeOfType<JsonAPIResponse<NomineeResponseDTO>>();
            responseData?.ApiResponseStatus.Should().Be(Enum.APIResponseStatus.Success);
        }

        [Fact]
        public async Task NomineeController_DaleteNomineeDetailsById_CanDalete()
        {
            // Arrange
            ManualPpoReceiptEntryDTO? ppoReceipt = new PpoReceiptFactory().Create();
            PensionerEntryDTO pensionerEntryDTO = new PensionerFactory().Create();
            NomineeEntryDTO? nomineeDetails = new NomineeFactory().Create();
            pensionerEntryDTO.PpoNo = ppoReceipt.PpoNo;
            ppoReceipt.DateOfCommencement = pensionerEntryDTO.DateOfCommencement;
            _ = await CallPostAsJsonAsync<ManualPpoReceiptResponseDTO, ManualPpoReceiptEntryDTO>(
                    "/api/v1/manual-ppo/receipts",
                    ppoReceipt
                );

            JsonAPIResponse<PensionerResponseDTO>? pensionerData =
                await CallPostAsJsonAsync<PensionerResponseDTO, PensionerEntryDTO>(
                    "/api/v1/ppo/details",
                    pensionerEntryDTO
                );
            nomineeDetails.PpoId = pensionerData?.Result?.PpoId ?? 0;

            JsonAPIResponse<NomineeResponseDTO>? nomineeDetailsData =
                await CallPostAsJsonAsync<NomineeResponseDTO, NomineeEntryDTO>(
                    "/api/v1/ppo/nominee",
                    nomineeDetails
                );

            // Act
            JsonAPIResponse<NomineeResponseDTO>? responseData =
                await CallDeleteAsJsonAsync<NomineeResponseDTO>(
                    "/api/v1/ppo/nominee/" + nomineeDetailsData?.Result?.Id
                );

            // Assert
            using (new AssertionScope())
            responseData.Should().NotBeNull();
            responseData.Should().BeOfType<JsonAPIResponse<NomineeResponseDTO>>();
            responseData?.ApiResponseStatus.Should().Be(Enum.APIResponseStatus.Success);
        }

        [Fact]
        public async Task NomineeController_GetNomineeDetailsById_CanGet()
        {
            // Arrange
            ManualPpoReceiptEntryDTO? ppoReceipt = new PpoReceiptFactory().Create();
            PensionerEntryDTO pensionerEntryDTO = new PensionerFactory().Create();
            NomineeEntryDTO? nomineeDetails = new NomineeFactory().Create();
            pensionerEntryDTO.PpoNo = ppoReceipt.PpoNo;
            ppoReceipt.DateOfCommencement = pensionerEntryDTO.DateOfCommencement;
            _ = await CallPostAsJsonAsync<ManualPpoReceiptResponseDTO, ManualPpoReceiptEntryDTO>(
                    "/api/v1/manual-ppo/receipts",
                    ppoReceipt
                );

            JsonAPIResponse<PensionerResponseDTO>? pensionerData =
                await CallPostAsJsonAsync<PensionerResponseDTO, PensionerEntryDTO>(
                    "/api/v1/ppo/details",
                    pensionerEntryDTO
                );
            nomineeDetails.PpoId = pensionerData?.Result?.PpoId ?? 0;

            JsonAPIResponse<NomineeResponseDTO>? nomineeDetailsData =
                await CallPostAsJsonAsync<NomineeResponseDTO, NomineeEntryDTO>(
                    "/api/v1/ppo/nominee",
                    nomineeDetails
                );

            // Act
            JsonAPIResponse<NomineeResponseDTO>? responseData =
                await CallGetAsJsonAsync<NomineeResponseDTO>(
                    "/api/v1/ppo/nominee/" + nomineeDetailsData?.Result?.Id
                );

            // Assert
            using (new AssertionScope())
            responseData.Should().NotBeNull();
            responseData.Should().BeOfType<JsonAPIResponse<NomineeResponseDTO>>();
            responseData?.ApiResponseStatus.Should().Be(Enum.APIResponseStatus.Success);
        }

        [Fact]
        public async Task NomineeController_GetNomineesByPpoId_CanGet()
        {
            // Arrange
            ManualPpoReceiptEntryDTO? ppoReceipt = new PpoReceiptFactory().Create();
            PensionerEntryDTO pensionerEntryDTO = new PensionerFactory().Create();
            NomineeEntryDTO? nomineeDetails = new NomineeFactory().Create();
            pensionerEntryDTO.PpoNo = ppoReceipt.PpoNo;
            ppoReceipt.DateOfCommencement = pensionerEntryDTO.DateOfCommencement;
            _ = await CallPostAsJsonAsync<ManualPpoReceiptResponseDTO, ManualPpoReceiptEntryDTO>(
                    "/api/v1/manual-ppo/receipts",
                    ppoReceipt
                );

            JsonAPIResponse<PensionerResponseDTO>? pensionerData =
                await CallPostAsJsonAsync<PensionerResponseDTO, PensionerEntryDTO>(
                    "/api/v1/ppo/details",
                    pensionerEntryDTO
                );
            nomineeDetails.PpoId = pensionerData?.Result?.PpoId ?? 0;

            JsonAPIResponse<NomineeResponseDTO>? nomineeDetailsData =
                await CallPostAsJsonAsync<NomineeResponseDTO, NomineeEntryDTO>(
                    "/api/v1/ppo/nominee",
                    nomineeDetails
                );

            // Act
            JsonAPIResponse<TableResponseDTO<NomineeResponseDTO>>? responseData =
                await CallGetAsJsonAsync<TableResponseDTO<NomineeResponseDTO>>(
                    $"/api/v1/ppo/{nomineeDetails.PpoId}/nominees"
                );

            // Assert
            using (new AssertionScope())
            responseData.Should().NotBeNull();
            responseData.Should().BeOfType<JsonAPIResponse<TableResponseDTO<NomineeResponseDTO>>>();
            responseData?.Result?.Data.Should().NotBeEmpty();
            responseData?.Result?.DataCount.Should().BeGreaterThan(0);
            responseData?.ApiResponseStatus.Should().Be(Enum.APIResponseStatus.Success);
        }
    }
}