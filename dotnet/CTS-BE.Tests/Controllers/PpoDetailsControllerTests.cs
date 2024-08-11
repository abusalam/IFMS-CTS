using CTS_BE.DTOs;
using CTS_BE.Helper;
using System.Text.Json;
using FluentAssertions;
using FluentAssertions.Execution;

namespace CTS_BE.Tests.Controllers
{
    public class PpoDetailsControllerTests : BaseControllerTests
    {
 
        [Fact]
        public async Task PensionController_ControlPensionerDetailsCreate_CanCreate()
        {
            // Arrange
            PensionerEntryDTO pensionerEntryDTO = new() {
                ReceiptId = 1,
                PpoNo = $"PPO-{Random.Shared.Next(10000, 99999)}",
                PpoType = 'P',
                PpoSubType = 'N',
                CategoryId = 31,
                PensionerName = "John Doe",
                DateOfBirth = DateOnly.FromDateTime(DateTime.Parse("1990-07-30")),
                Gender = 'M',
                MobileNumber = "9876543210",
                EmailId = "CnTqS@example.com",
                PensionerAddress = "Pune",
                IdentificationMark = "Mole",
                PanNo = "ABCDE1234F",
                AadhaarNo = "123456789012",
                DateOfRetirement = DateOnly.FromDateTime(DateTime.Parse("2014-07-30")),
                DateOfCommencement = DateOnly.FromDateTime(DateTime.Parse("2024-07-30")),
                BasicPensionAmount = 10000,
                CommutedPensionAmount = 1000,
                EnhancePensionAmount = 10000,
                ReducedPensionAmount = 9000,
                Religion = 'H'
            };
            PrintOut("Request => " + JsonSerializer.Serialize(pensionerEntryDTO));

            // Act
            var response = await this.GetHttpClient()
                .PostAsJsonAsync("/api/v1/ppo/details", pensionerEntryDTO);
            var responseContentStream = await response.Content.ReadAsStreamAsync();
            PrintOut("Response => " + response.Content.ReadAsStringAsync().Result);
             var responseData = JsonSerializer
                .Deserialize<JsonAPIResponse<PensionerResponseDTO>>(
                        responseContentStream,
                        GetJsonSerializerOptions()
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