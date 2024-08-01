using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using CTS_BE.BAL.Services.Pension;
using CTS_BE.Controllers;
using Xunit;
using FluentAssertions;
using FluentAssertions.Execution;
using Moq;
using CTS_BE.DAL.Interfaces.Pension;
using AutoMapper;
using CTS_BE.Helper.Authentication;

namespace CTS_BE.Tests.BAL.Services
{
    public class PesionerDetailsServiceTests
    {
        [Fact]
        public void PensionerDetailsService_Add_CanAdd()
        {
            // Arrange
            Mock<IPensionerDetailsRepository> mockPensionerDetailsRepository = new();
            Mock<IPpoIdSequenceRepository> mockPpoIdSequenceRepository = new();
            Mock<IClaimService> mockClaimService = new();
            Mock<IMapper> mockMapper = new();
            PensionerDetailsService pensionerDetailsService = new(
                    mockPensionerDetailsRepository.Object,
                    mockPpoIdSequenceRepository.Object,
                    mockClaimService.Object,
                    mockMapper.Object
                );

            int result = pensionerDetailsService.Add(1, 2);
            
            result.Should().Be(3);
        }
    }
}