using System;
using System.Collections.Generic;
using System.Linq;
using System.Text.Json;
using System.Threading.Tasks;
using CTS_BE.DTOs;
using CTS_BE.Helper;
using CTS_BE.Tests.Factory;
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
            ManualPpoReceiptEntryDTO manualPpoReceiptEntryDTO = new PpoReceiptFactory().Create();

            // Act
            JsonAPIResponse<ManualPpoReceiptResponseDTO>? responseData = 
                await CallPostAsJsonAsync<ManualPpoReceiptResponseDTO, ManualPpoReceiptEntryDTO>(
                    "/api/v1/manual-ppo/receipts",
                    manualPpoReceiptEntryDTO
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