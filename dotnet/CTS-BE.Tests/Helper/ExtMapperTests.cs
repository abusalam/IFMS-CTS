using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Xunit;
using FluentAssertions;
using FluentAssertions.Execution;
using System.Dynamic;
using CTS_BE.Helper;
using CTS_BE.DAL.Entities.Pension;
using CTS_BE.DTOs;

namespace CTS_BE.Tests.Helper
{
    public class ExtMapperTests
    {
        [Fact]
        public void ExtMapper_FillFrom_CanFill()
        {
            // Arrange
            DateTime dateTime = DateTime.Now;
            PpoStatusFlag targetEntity = new (){
                Id = 6,
                FinancialYear = 2024,
                TreasuryCode = "BAA",
                PpoId = 2,
                StatusFlag = 12,
                StatusWef = DateOnly.FromDateTime(DateTime.Parse("2024-07-20")),
                CreatedAt = dateTime,
                CreatedBy = null,
                UpdatedAt = null,
                UpdatedBy = null,
                ActiveFlag = true
            };


            PensionStatusDTO srcDTO = new()
            {
                StatusFlag = 2,
                StatusWef = DateOnly.FromDateTime(DateTime.Parse("2024-07-25")),
            };

            // Act
            targetEntity.FillFrom(srcDTO);

            // Assert
            using (new AssertionScope())
            {
                targetEntity.Id.Should().Be(6);
                targetEntity.FinancialYear.Should().Be(2024);
                targetEntity.TreasuryCode.Should().Be("BAA");
                targetEntity.PpoId.Should().Be(2);
                targetEntity.StatusFlag.Should().Be(2);
                targetEntity.StatusWef.Should().Be(DateOnly.FromDateTime(DateTime.Parse("2024-07-25")));
                targetEntity.CreatedAt.Should().Be(dateTime);
                targetEntity.CreatedBy.Should().Be(null);
                targetEntity.UpdatedAt.Should().Be(null);
                targetEntity.UpdatedBy.Should().Be(null);
                targetEntity.ActiveFlag.Should().Be(true);
            }
        
        }
    }
}