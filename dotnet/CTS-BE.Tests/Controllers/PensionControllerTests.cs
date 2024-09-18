using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Xunit;
using FluentAssertions;
using FluentAssertions.Execution;
using CTS_BE.DTOs;
using System.Net.Http.Json;
using System.Text.Json;
using System.Diagnostics;
using CTS_BE.Helper;
using CTS_BE.PensionEnum;

namespace CTS_BE.Tests.Controllers
{
    public class PensionControllerTests : BaseControllerTests
    {
        [Fact]
        public async Task PensionController_Echo_CanEcho()
        {
            // Arrange
            PensionStatusEntryDTO pensionStatusEntryDTO = new() {
                PpoId = 10,
                StatusFlag = PensionStatusFlag.PpoRunning,
                StatusWef = DateOnly.FromDateTime(DateTime.Parse("2024-07-25"))
            };

            // Act
            var responseData = await CallPostAsJsonAsync<Object, PensionStatusEntryDTO>(
                "/api/v1/echo",
                pensionStatusEntryDTO
            );

            // Assert
            using (new AssertionScope())
            responseData.Should().NotBeNull();
            responseData.Should().BeOfType<JsonAPIResponse<Object>>();
            responseData?.ApiResponseStatus.Should().Be(Enum.APIResponseStatus.Success);
            responseData?.Message.Should().Be("Echoing Request");
            responseData?.Result?.ToString().Should().Be(
                    JsonSerializer.Serialize(pensionStatusEntryDTO)
                );
        }

        [Fact]
        public async Task PensionController_SetDateOnly_CanSetDateOnly()
        {
            // Arrange
            var content = new DateOnlyDTO() {
                DateOnly = DateOnly.FromDateTime(DateTime.Parse("2024-07-29")) 
            };

            // Act
            var responseData = await CallPostAsJsonAsync<DateOnlyDTO, DateOnlyDTO>(
                "/api/v1/date-only",
                content
            );

            // Assert
            using (new AssertionScope())
            responseData.Should().NotBeNull();
            responseData.Should().BeOfType<JsonAPIResponse<DateOnlyDTO>>();
            responseData?.ApiResponseStatus.Should().Be(Enum.APIResponseStatus.Success);
            responseData?.Message.Should().Be("Writing DateOnly");
            responseData?.Result?.Should().BeEquivalentTo(content);
        }

        [Fact]
        public async Task PensionController_GetDateOnly_CanGetDateOnly()
        {
            // Arrange

            // Act
            var response = await CallGetAsJsonAsync<DateOnly>(
                "/api/v1/date-only"
            );

            // Assert
            using (new AssertionScope())
            response?.Should().NotBeNull();
            response?.Should().BeOfType<JsonAPIResponse<DateOnly>>();
            response?.ApiResponseStatus.Should().Be(Enum.APIResponseStatus.Success);
            response?.Message.Should().Be("Reading DateOnly");
            response?.Result.Should().Be(DateOnly.FromDateTime(DateTime.Now));
        }
    
    }
}