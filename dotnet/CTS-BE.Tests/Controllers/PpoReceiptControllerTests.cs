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
        public async Task PpoReceiptController_CreatePpoReceipt_CanCreate()
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
       
        [Fact]
        public async Task PpoReceiptController_UpdatePpoReceipt_CanUpdate()
        {
            // Arrange
            ManualPpoReceiptEntryDTO manualPpoReceiptEntryDTO = new PpoReceiptFactory().Create();
            JsonAPIResponse<ManualPpoReceiptResponseDTO>? savedReceipt = 
                await CallPostAsJsonAsync<ManualPpoReceiptResponseDTO, ManualPpoReceiptEntryDTO>(
                    "/api/v1/manual-ppo/receipts",
                    manualPpoReceiptEntryDTO
                );

            ManualPpoReceiptEntryDTO receiptUpdateDTO = new PpoReceiptFactory().Create();

            // Act
            JsonAPIResponse<ManualPpoReceiptResponseDTO>? responseData = 
                await CallPutAsJsonAsync<ManualPpoReceiptResponseDTO, ManualPpoReceiptEntryDTO>(
                    $"/api/v1/manual-ppo/receipt/{savedReceipt?.Result?.Id ?? 0}",
                    receiptUpdateDTO
                );

            ManualPpoReceiptResponseDTO? responseResult = responseData?.Result;
            responseResult.FillFrom(receiptUpdateDTO);

            // Assert
            using (new AssertionScope())
            responseData.Should().NotBeNull();
            responseData.Should().BeOfType<JsonAPIResponse<ManualPpoReceiptResponseDTO>>();
            responseData?.ApiResponseStatus.Should().Be(Enum.APIResponseStatus.Success);
            responseData?.Result.Should().BeEquivalentTo(responseResult);
        }

        [Fact]
        public async Task PpoReceiptController_GetPpoReceiptById_CanGet()
        {
            // Arrange
            ManualPpoReceiptEntryDTO manualPpoReceiptEntryDTO = new PpoReceiptFactory().Create();
            JsonAPIResponse<ManualPpoReceiptResponseDTO>? savedReceipt = 
                await CallPostAsJsonAsync<ManualPpoReceiptResponseDTO, ManualPpoReceiptEntryDTO>(
                    "/api/v1/manual-ppo/receipts",
                    manualPpoReceiptEntryDTO
                );

            // Act
            JsonAPIResponse<ManualPpoReceiptResponseDTO>? responseData = 
                await CallGetAsJsonAsync<ManualPpoReceiptResponseDTO>(
                    $"/api/v1/manual-ppo/receipt/{savedReceipt?.Result?.Id ?? 0}"
                );

            ManualPpoReceiptResponseDTO? responseResult = responseData?.Result;
            responseResult.FillFrom(manualPpoReceiptEntryDTO);

            // Assert
            using (new AssertionScope())
            responseData.Should().NotBeNull();
            responseData.Should().BeOfType<JsonAPIResponse<ManualPpoReceiptResponseDTO>>();
            responseData?.ApiResponseStatus.Should().Be(Enum.APIResponseStatus.Success);
            responseData?.Result.Should().BeEquivalentTo(responseResult);
        }

        [Fact]
        public async Task PpoReceiptController_GetPpoReceiptByTreasuryReceiptNo_CanGet()
        {
            // Arrange
            ManualPpoReceiptEntryDTO manualPpoReceiptEntryDTO = new PpoReceiptFactory().Create();
            JsonAPIResponse<ManualPpoReceiptResponseDTO>? savedReceipt = 
                await CallPostAsJsonAsync<ManualPpoReceiptResponseDTO, ManualPpoReceiptEntryDTO>(
                    "/api/v1/manual-ppo/receipts",
                    manualPpoReceiptEntryDTO
                );

            // Act
            JsonAPIResponse<ManualPpoReceiptResponseDTO>? responseData = 
                await CallGetAsJsonAsync<ManualPpoReceiptResponseDTO>(
                    $"/api/v1/manual-ppo/receipts/{savedReceipt?.Result?.TreasuryReceiptNo ?? "null"}"
                );

            ManualPpoReceiptResponseDTO? responseResult = responseData?.Result;
            responseResult.FillFrom(manualPpoReceiptEntryDTO);

            // Assert
            using (new AssertionScope())
            responseData.Should().NotBeNull();
            responseData.Should().BeOfType<JsonAPIResponse<ManualPpoReceiptResponseDTO>>();
            responseData?.ApiResponseStatus.Should().Be(Enum.APIResponseStatus.Success);
            responseData?.Result.Should().BeEquivalentTo(responseResult);
        }
       
    }
}