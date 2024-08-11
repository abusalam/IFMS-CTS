using System;
using System.Collections.Generic;
using System.Linq;
using System.Text.Json;
using System.Threading.Tasks;
using CTS_BE.DTOs;
using CTS_BE.Helper;
using FluentAssertions;
using FluentAssertions.Execution;
using Xunit;

namespace CTS_BE.Tests.Controllers
{
    public class PpoReceiptControllerTests : BaseControllerTests
    {
        [Fact]
        public async Task PensionController_ControlManualPpoReceiptsCreate_CanCreate()
        {
            // Arrange
            ManualPpoReceiptEntryDTO manualPpoReceiptEntryDTO = new() {
                PpoNo = $"PPO-{Random.Shared.Next(10000, 99999)}",
                PensionerName = "John Doe",
                DateOfCommencement = DateOnly.FromDateTime(DateTime.Parse("2024-07-30")),
                MobileNumber = "9876543210",
                ReceiptDate = DateOnly.FromDateTime(DateTime.Parse("2024-07-30")),
                PsaCode = 'A',
                PpoType = 'N'
            };
            // PrintOut("RequestInConsole:" + JsonSerializer.Serialize(manualPpoReceiptEntryDTO));

            // Act
            var response = await this.GetHttpClient()
                .PostAsJsonAsync("/api/v1/manual-ppo/receipts", manualPpoReceiptEntryDTO);
            var responseContentStream = await response.Content.ReadAsStreamAsync();
            // PrintOut("ResponseInConsole:" + response.Content.ReadAsStringAsync().Result);
            var responseData = JsonSerializer
                .Deserialize<JsonAPIResponse<ManualPpoReceiptResponseDTO>>(
                        responseContentStream,
                        GetJsonSerializerOptions()
                    );

            ManualPpoReceiptResponseDTO? responseResult = responseData?.Result;
            responseResult.FillFrom(manualPpoReceiptEntryDTO);


            // Assert
            using (new AssertionScope())
            responseData.Should().NotBeNull();
            responseData.Should().BeOfType<JsonAPIResponse<ManualPpoReceiptResponseDTO>>();
            responseData?.ApiResponseStatus.Should().Be(Enum.APIResponseStatus.Success);
            responseData?.Message.Should().Be("PPO Received Successfully!");
            responseData?.Result.Should().BeEquivalentTo(responseResult);
        }
       
    }
}