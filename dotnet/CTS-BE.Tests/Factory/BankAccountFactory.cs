using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Bogus;
using CTS_BE.DTOs;

namespace CTS_BE.Tests.Factory
{
    public class BankAccountFactory
    {
        private readonly Faker<PensionerBankAcEntryDTO> _faker;
        public BankAccountFactory()
        {
            _faker = new Faker<PensionerBankAcEntryDTO>()
                // .StrictMode(true)
                .RuleFor(d => d.PayMode, f => f.PickRandom('Q','B'))
                .RuleFor(d => d.BankAcNo, f => f.Random.Replace("################"))
                .RuleFor(d => d.IfscCode, f => f.Random.Replace("????#######"))
                .RuleFor(d => d.BranchCode, 531)
                .RuleFor(d => d.BankCode, 2)
                .RuleFor(d => d.AccountHolderName, f => f.Person.FullName);
        }

        public PensionerBankAcEntryDTO Create()
        {
            return _faker.Generate();
        }
    }
}