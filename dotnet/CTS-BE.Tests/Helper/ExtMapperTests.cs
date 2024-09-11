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
    public class TestTargetObject {
        public int Id;
        public int FinancialYear;
        public readonly string? TreasuryCode;
        public int PpoId;
        public readonly int StatusFlag;
        public bool ActiveFlag;
        public string? DataSource;

        public TestTargetObject(string? treasuryCode, int statusFlag)
        {
            TreasuryCode = treasuryCode;
            StatusFlag = statusFlag;
        }
    }
    public class TestSourceObject {
        public string? TreasuryCode;
        public int PpoId;
        public int StatusFlag;
        public bool ActiveFlag;
        public DateOnly StatusWef;
        public int? DataSource;
    }
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
                CreatedBy = 39,
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
                targetEntity.CreatedBy.Should().Be(39);
                targetEntity.UpdatedAt.Should().Be(null);
                targetEntity.UpdatedBy.Should().Be(null);
                targetEntity.ActiveFlag.Should().Be(true);
            }
        
        }
    
    
        [Fact]
        public void ExtMapper_FillFrom_NullArgTest()
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
                CreatedBy = 39,
                UpdatedAt = null,
                UpdatedBy = null,
                ActiveFlag = true
            };

            // Act
            targetEntity.FillFrom<PpoStatusFlag, PensionStatusDTO>(null);

            // Assert
            using (new AssertionScope())
            {
                targetEntity.Id.Should().Be(6);
                targetEntity.FinancialYear.Should().Be(2024);
                targetEntity.TreasuryCode.Should().Be("BAA");
                targetEntity.PpoId.Should().Be(2);
                targetEntity.StatusFlag.Should().Be(12);
                targetEntity.StatusWef.Should().Be(DateOnly.FromDateTime(DateTime.Parse("2024-07-20")));
                targetEntity.CreatedAt.Should().Be(dateTime);
                targetEntity.CreatedBy.Should().Be(39);
                targetEntity.UpdatedAt.Should().Be(null);
                targetEntity.UpdatedBy.Should().Be(null);
                targetEntity.ActiveFlag.Should().Be(true);
            }
        
        }        
        
                [Fact]
        public void ExtMapper_FillFrom_NullSourceTest()
        {
            // Arrange
            DateTime dateTime = DateTime.Now;
            PpoStatusFlag? targetEntity = null;
            PensionStatusDTO srcDTO = new()
            {
                DataSource = null,
                StatusFlag = 2,
                StatusWef = DateOnly.FromDateTime(DateTime.Parse("2024-07-25")),
            };
            // Act
            targetEntity.FillFrom(srcDTO);

            // Assert
            using (new AssertionScope())
            {
                targetEntity.Should().BeNull();
            }
        
        } 

        [Fact]
        public void ExtMapper_FillFrom_CanWriteCheckTest()
        {
            // Arrange
            TestTargetObject targetEntity = new (null,  12) {
                Id = 6,
                FinancialYear = 2024,
                PpoId = 2,
                ActiveFlag = true,
                DataSource = "CanFailMe"
            };
            TestSourceObject srcDTO = new()
            {
                DataSource = 10,
                TreasuryCode = "BAA",
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
                targetEntity.TreasuryCode.Should().BeNull();
                targetEntity.PpoId.Should().Be(2);
                targetEntity.StatusFlag.Should().Be(12);
                targetEntity.ActiveFlag.Should().Be(true);
                targetEntity.DataSource.Should().Be(
                    "CanFailMe",
                    "target should not be updated if type is wrong"
                );
                // targetEntity.Invoking(ext => ext.FillFrom(srcDTO))
                // .Should().Throw<ArgumentException>();
            }
        
        }
    
    }
}