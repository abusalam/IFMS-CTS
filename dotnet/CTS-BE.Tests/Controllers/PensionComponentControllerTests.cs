using CTS_BE.DTOs;
using CTS_BE.Factories.Pension;
using CTS_BE.Helper;
using FluentAssertions;
using FluentAssertions.Execution;

namespace CTS_BE.Tests.Controllers
{
    public class PensionComponentControllerTests : BaseControllerTests
    {
        [Fact]
        public async Task PensionComponentController_CreateComponent_CanCreate()
        {
            // Arrange
            PensionBreakupEntryDTO pensionBreakupEntryDTO = new ComponentFactory().Create();

            // Act
            JsonAPIResponse<PensionBreakupResponseDTO>? responseData = await CallPostAsJsonAsync<
                PensionBreakupResponseDTO,
                PensionBreakupEntryDTO
            >("/api/v1/pension-component", pensionBreakupEntryDTO);

            // Assert
            using (new AssertionScope())
                responseData.Should().NotBeNull();
            responseData?.Result.Should().NotBeNull();
            responseData?.ApiResponseStatus.Should().Be(Enum.APIResponseStatus.Success);
        }

        [Fact]
        public async Task PensionComponentController_CreateComponentRate_CanCreate()
        {
            // Arrange
            ComponentRateEntryDTO componentRateEntryDTO = new ComponentRateFactory().Create();

            // Act
            JsonAPIResponse<ComponentRateResponseDTO>? responseData = await CallPostAsJsonAsync<
                ComponentRateResponseDTO,
                ComponentRateEntryDTO
            >($"/api/v1/pension-component/rate", componentRateEntryDTO);

            // Assert
            using (new AssertionScope())
                responseData.Should().NotBeNull();
            responseData?.Result.Should().NotBeNull();
            responseData?.ApiResponseStatus.Should().Be(Enum.APIResponseStatus.Success);
        }

        [Fact]
        public async Task PensionComponentController_GetComponentRatesByCategoryId_CanGet()
        {
            // Arrange
            ComponentRateEntryDTO componentRateEntryDTO = new ComponentRateFactory().Create();
            long categoryId = componentRateEntryDTO.CategoryId;

            _ = await CallPostAsJsonAsync<ComponentRateResponseDTO, ComponentRateEntryDTO>(
                $"/api/v1/pension-component/rate",
                componentRateEntryDTO
            );

            // Act
            JsonAPIResponse<TableResponseDTO<ComponentRateResponseDTO>>? responseData =
                await CallGetAsJsonAsync<TableResponseDTO<ComponentRateResponseDTO>>(
                    $"/api/v1/pension-component/{categoryId}/rates"
                );

            // Assert
            using (new AssertionScope())
                responseData.Should().NotBeNull();
            responseData?.Result.Should().NotBeNull();
            responseData?.Result?.Data.Should().NotBeEmpty();
            responseData?.Result?.DataCount.Should().BeGreaterThan(0);
            responseData?.ApiResponseStatus.Should().Be(Enum.APIResponseStatus.Success);
        }

        [Fact]
        public async Task PensionComponentController_GetComponents_CanGet()
        {
            // Arrange
            PensionBreakupEntryDTO pensionBreakupEntryDTO = new ComponentFactory().Create();

            _ = await CallPostAsJsonAsync<PensionBreakupResponseDTO, PensionBreakupEntryDTO>(
                "/api/v1/pension-component",
                pensionBreakupEntryDTO
            );

            // Act
            JsonAPIResponse<TableResponseDTO<PensionBreakupResponseDTO>>? responseData =
                await CallGetAsJsonAsync<TableResponseDTO<PensionBreakupResponseDTO>>(
                    $"/api/v1/pension-components"
                );

            // Assert
            using (new AssertionScope())
                responseData.Should().NotBeNull();
            responseData?.Result.Should().NotBeNull();
            responseData?.Result?.Data.Should().NotBeEmpty();
            responseData?.Result?.DataCount.Should().BeGreaterThan(0);
            responseData?.ApiResponseStatus.Should().Be(Enum.APIResponseStatus.Success);
        }
    }
}
