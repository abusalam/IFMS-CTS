using CTS_BE.DTOs;
using CTS_BE.Factories.Pension;
using CTS_BE.Helper;
using FluentAssertions;
using FluentAssertions.Execution;

namespace CTS_BE.Tests.Controllers
{
    public class PensionCategoryControllerTests : BaseControllerTests
    {
        [Fact]
        public async Task PensionCategoryController_CreatePrimaryCategory_CanCreate()
        {

            // Arrange
            PensionPrimaryCategoryEntryDTO pensionPrimaryCategoryEntryDTO = new PrimaryCategoryFactory().Create();


            // Act
            JsonAPIResponse<PensionPrimaryCategoryResponseDTO>? responseData
                = await CallPostAsJsonAsync<PensionPrimaryCategoryResponseDTO, PensionPrimaryCategoryEntryDTO>(
                    "/api/v1/pension/primary-category",
                    pensionPrimaryCategoryEntryDTO
                );

            // Assert
            using (new AssertionScope())
            responseData.Should().NotBeNull();
            responseData?.Result.Should().NotBeNull();
            responseData?.ApiResponseStatus.Should().Be(Enum.APIResponseStatus.Success);
        }

        [Fact]
        public async Task PensionCategoryController_CreateSubCategory_CanCreate()
        {
            // Arrange
            PensionSubCategoryEntryDTO pensionSubCategoryEntryDTO = new SubCategoryFactory().Create();

            // Act
            JsonAPIResponse<PensionSubCategoryResponseDTO>? responseData
                = await CallPostAsJsonAsync<PensionSubCategoryResponseDTO, PensionSubCategoryEntryDTO>(
                    $"/api/v1/pension/sub-category",
                    pensionSubCategoryEntryDTO
                );

            // Assert
            using (new AssertionScope())
            responseData.Should().NotBeNull();
            responseData?.Result.Should().NotBeNull();
            responseData?.ApiResponseStatus.Should().Be(Enum.APIResponseStatus.Success);
        }

        [Fact]
        public async Task PensionCategoryController_CreateCategory_CanCreate()
        {
            // Arrange
            PensionPrimaryCategoryEntryDTO pensionPrimaryCategoryEntryDTO = new PrimaryCategoryFactory().Create();
            PensionSubCategoryEntryDTO pensionSubCategoryEntryDTO = new SubCategoryFactory().Create();
            JsonAPIResponse<PensionPrimaryCategoryResponseDTO>? primaryCategory
                = await CallPostAsJsonAsync<PensionPrimaryCategoryResponseDTO, PensionPrimaryCategoryEntryDTO>(
                    "/api/v1/pension/primary-category",
                    pensionPrimaryCategoryEntryDTO
                );
            JsonAPIResponse<PensionSubCategoryResponseDTO>? subCategory
                = await CallPostAsJsonAsync<PensionSubCategoryResponseDTO, PensionSubCategoryEntryDTO>(
                    $"/api/v1/pension/sub-category",
                    pensionSubCategoryEntryDTO
                );

            PensionCategoryEntryDTO pensionCategoryEntryDTO = new () {
                PrimaryCategoryId = primaryCategory?.Result?.Id ?? 0,
                SubCategoryId = subCategory?.Result?.Id ?? 0
            };

            // Act
            JsonAPIResponse<PensionCategoryResponseDTO>? responseData
                = await CallPostAsJsonAsync<PensionCategoryResponseDTO, PensionCategoryEntryDTO>(
                    $"/api/v1/pension/category",
                    pensionCategoryEntryDTO
                );

            // Assert
            using (new AssertionScope())
            responseData.Should().NotBeNull();
            responseData?.Result.Should().NotBeNull();
            responseData?.ApiResponseStatus.Should().Be(Enum.APIResponseStatus.Success);
        }

        [Fact]
        public async Task PensionCategoryController_GetCategoryById_CanGet()
        {
            // Arrange
            long categoryId = 30;

            // Act
            JsonAPIResponse<PensionCategoryResponseDTO>? responseData
                = await CallGetAsJsonAsync<PensionCategoryResponseDTO>(
                    $"/api/v1/pension/category/{categoryId}"
                );

            // Assert
            using (new AssertionScope())
            responseData.Should().NotBeNull();
            responseData?.Result.Should().NotBeNull();
            responseData?.ApiResponseStatus.Should().Be(Enum.APIResponseStatus.Success);
        }
    }
}