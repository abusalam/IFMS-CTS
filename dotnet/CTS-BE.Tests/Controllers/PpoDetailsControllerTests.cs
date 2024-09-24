using CTS_BE.DTOs;
using CTS_BE.Helper;
using FluentAssertions;
using FluentAssertions.Execution;
using CTS_BE.Factories.Pension;

namespace CTS_BE.Tests.Controllers
{
    public class PpoDetailsControllerTests : BaseControllerTests
    {
 
        [Fact]
        public async Task PensionController_ControlPensionerDetailsCreate_CanCreate()
        {
            // Arrange
            PensionerEntryDTO pensionerEntryDTO = new PensionerFactory().Create();
            var ppoReceipt = new PpoReceiptFactory().Create();
            pensionerEntryDTO.PpoNo = ppoReceipt.PpoNo;
            ppoReceipt.DateOfCommencement = pensionerEntryDTO.DateOfCommencement;
            _ = await CallPostAsJsonAsync<ManualPpoReceiptResponseDTO, ManualPpoReceiptEntryDTO>(
                    "/api/v1/manual-ppo/receipts",
                    ppoReceipt
                );

            // Act
            var responseData = 
                await CallPostAsJsonAsync<PensionerResponseDTO, PensionerEntryDTO>(
                    "/api/v1/ppo/details",
                    pensionerEntryDTO
                );

            PensionerResponseDTO? responseResult = responseData?.Result;
            responseResult.FillFrom(pensionerEntryDTO);


            // Assert
            using (new AssertionScope())
            responseData.Should().NotBeNull();
            responseData.Should().BeOfType<JsonAPIResponse<PensionerResponseDTO>>();
            responseData?.ApiResponseStatus.Should().Be(Enum.APIResponseStatus.Success);
            responseData?.Message.Should().Be("PPO Details saved sucessfully!");
            responseData?.Result.Should().BeEquivalentTo(responseResult);
        }


    }
}