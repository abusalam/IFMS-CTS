using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using CTS_BE.BAL.Services.Pension;
using CTS_BE.DAL.Entities.Pension;
using FluentAssertions;
using Moq;
using Xunit;

namespace CTS_BE.Tests.BAL.Services
{
    public class PensionCalculatorTests
    {
        [Theory]
        [InlineData(1000, 0, 0, 'P', "DA Rate is 0")]
        [InlineData(1000, 100, 10, 'P', "DA Rate is 10")]
        [InlineData(1000, 1000, 0, 'A', "Basic Pension is 1000")]
        [InlineData(1000, 500, 500, 'A', "Medical Relief is 500")]
        public void PensionCalculator_CalculatePerMonthBreakupAmount(
            int basicPensionAmount,
            int totalPensionAmount,
            int rateAmount,
            char rateType,
            string because
        )
        {
            // Arrange
            ComponentRate componentRate = new() {
                RateAmount = rateAmount,
                RateType = rateType
            };
            // Act
            long result = PensionCalculator.CalculatePerMonthBreakupAmount(
                componentRate, basicPensionAmount
                );
            // Assert
            result.Should().Be(totalPensionAmount, because);
        }

        [Theory]
        [InlineData("2005-01-01", 1, "Effective date is 2009-01-01")]
        [InlineData("2009-01-01", 1, "Effective date is 2009-01-01")]
        [InlineData("2012-01-01", 1, "Effective date is 2009-01-01")]
        [InlineData("2020-01-01", 3, "Effective date is 2019-10-01")]
        [InlineData("2023-08-01", 4, "Effective date is 2022-07-01")]
        [InlineData("2026-10-01", 5, "Effective date is 2025-12-01")]
        public void PensionCalculator_CalculateEffectiveRate(string forDate, int expectedId, string because) {
            // Arrange
            List<ComponentRate> componentRates = new() {
                new() {
                    Id = 1,
                    CategoryId = 1,
                    BreakupId = 1,
                    RateAmount = 10,
                    RateType = 'P',
                    EffectiveFromDate = DateOnly.Parse("2009-01-01"),
                },
                new() {
                    Id = 2,
                    CategoryId = 1,
                    BreakupId = 1,
                    RateAmount = 20,
                    RateType = 'P',
                    EffectiveFromDate = DateOnly.Parse("2014-01-01"),
                },
                new() {
                    Id = 3,
                    CategoryId = 1,
                    BreakupId = 1,
                    RateAmount = 30,
                    RateType = 'P',
                    EffectiveFromDate = DateOnly.Parse("2019-10-01"),
                },
                new() {
                    Id = 4,
                    CategoryId = 1,
                    BreakupId = 1,
                    RateAmount = 40,
                    RateType = 'P',
                    EffectiveFromDate = DateOnly.Parse("2022-07-01"),
                },
                new() {
                    Id = 5,
                    CategoryId = 1,
                    BreakupId = 1,
                    RateAmount = 50,
                    RateType = 'P',
                    EffectiveFromDate = DateOnly.Parse("2025-12-01"),
                },

            };
            // Act
            ComponentRate? result = PensionCalculator.CalculateEffectiveRate (
                componentRates,
                1,
                DateOnly.Parse(forDate)
                );
            // Assert
            result.Id.Should().Be(expectedId, because);
        }

    }
}