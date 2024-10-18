using CTS_BE.DTOs;
using CTS_BE.Factories.Pension;
using CTS_BE.Helper;
using FluentAssertions;
using FluentAssertions.Execution;


namespace CTS_BE.Tests.Controllers
{
    public class PpoSanctionDetailsControllerTests : BaseControllerTests
    {
        [Fact]
        public async Task PpoSanctionDetailsController_CreateSanctionDetails_CanCreate()
        {
            // Arrange
            ManualPpoReceiptEntryDTO? ppoReceipt = new PpoReceiptFactory().Create();
            PensionerEntryDTO pensionerEntryDTO = new PensionerFactory().Create();
            PpoSanctionDetailsEntryDTO? sanctionDetails = new PpoSanctionDetailsFactory().Create();
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
            sanctionDetails.PpoId = pensionerData?.Result?.PpoId ?? 0;
            sanctionDetails.EmployeeName = pensionerData?.Result?.PensionerName ?? string.Empty;
            sanctionDetails.EmployeeDob = pensionerData?.Result?.DateOfBirth;


            // Act
            JsonAPIResponse<PpoSanctionDetailsResponseDTO>? responseData =
                await CallPostAsJsonAsync<PpoSanctionDetailsResponseDTO, PpoSanctionDetailsEntryDTO>(
                    "/api/v1/ppo/sanction",
                    sanctionDetails
                );

            // Assert
            using (new AssertionScope())
            responseData.Should().NotBeNull();
            responseData.Should().BeOfType<JsonAPIResponse<PpoSanctionDetailsResponseDTO>>();
            responseData?.ApiResponseStatus.Should().Be(Enum.APIResponseStatus.Success);
        }


        [Fact]
        public async Task PpoSanctionDetailsController_UpdateSanctionDetailsById_CanUpdate()
        {
            // Arrange
            ManualPpoReceiptEntryDTO? ppoReceipt = new PpoReceiptFactory().Create();
            PensionerEntryDTO pensionerEntryDTO = new PensionerFactory().Create();
            PpoSanctionDetailsEntryDTO sanctionDetails = new PpoSanctionDetailsFactory().Create();
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
            sanctionDetails.PpoId = pensionerData?.Result?.PpoId ?? 0;
            sanctionDetails.EmployeeName = pensionerData?.Result?.PensionerName ?? string.Empty;
            sanctionDetails.EmployeeDob = pensionerData?.Result?.DateOfBirth;

            JsonAPIResponse<PpoSanctionDetailsResponseDTO>? sanctionDetailsData =
                await CallPostAsJsonAsync<PpoSanctionDetailsResponseDTO, PpoSanctionDetailsEntryDTO>(
                    "/api/v1/ppo/sanction",
                    sanctionDetails
                );

            PpoSanctionDetailsEntryDTO sanctionDetailsUpdate = new PpoSanctionDetailsFactory().Create();
            sanctionDetailsUpdate.PpoId = pensionerData?.Result?.PpoId ?? 0;
            sanctionDetailsUpdate.EmployeeName = pensionerData?.Result?.PensionerName ?? string.Empty;
            sanctionDetailsUpdate.EmployeeDob = pensionerData?.Result?.DateOfBirth;

            // Act
            JsonAPIResponse<PpoSanctionDetailsResponseDTO>? responseData =
                await CallPutAsJsonAsync<PpoSanctionDetailsResponseDTO, PpoSanctionDetailsEntryDTO>(
                    "/api/v1/ppo/sanction/" + sanctionDetailsData?.Result?.Id,
                    sanctionDetailsUpdate
                );

            // Assert
            using (new AssertionScope())
            responseData.Should().NotBeNull();
            responseData.Should().BeOfType<JsonAPIResponse<PpoSanctionDetailsResponseDTO>>();
            responseData?.ApiResponseStatus.Should().Be(Enum.APIResponseStatus.Success);
        }


        [Fact]
        public async Task PpoSanctionDetailsController_GetSanctionDetailsById_CanGet()
        {
            // Arrange
            ManualPpoReceiptEntryDTO? ppoReceipt = new PpoReceiptFactory().Create();
            PensionerEntryDTO pensionerEntryDTO = new PensionerFactory().Create();
            PpoSanctionDetailsEntryDTO sanctionDetails = new PpoSanctionDetailsFactory().Create();
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
            sanctionDetails.PpoId = pensionerData?.Result?.PpoId ?? 0;
            sanctionDetails.EmployeeName = pensionerData?.Result?.PensionerName ?? string.Empty;
            sanctionDetails.EmployeeDob = pensionerData?.Result?.DateOfBirth;

            JsonAPIResponse<PpoSanctionDetailsResponseDTO>? sanctionDetailsData =
                await CallPostAsJsonAsync<PpoSanctionDetailsResponseDTO, PpoSanctionDetailsEntryDTO>(
                    "/api/v1/ppo/sanction",
                    sanctionDetails
                );


            // Act
            JsonAPIResponse<PpoSanctionDetailsResponseDTO>? responseData =
                await CallGetAsJsonAsync<PpoSanctionDetailsResponseDTO>(
                    "/api/v1/ppo/sanction/" + sanctionDetailsData?.Result?.Id
                );

            // Assert
            using (new AssertionScope())
            responseData.Should().NotBeNull();
            responseData.Should().BeOfType<JsonAPIResponse<PpoSanctionDetailsResponseDTO>>();
            responseData?.ApiResponseStatus.Should().Be(Enum.APIResponseStatus.Success);
        }
    }
}