## Setup xUnit testing and code coverage on Docker Linux Containers

Reference [Use code coverage for unit testing - .NET | Microsoft Learn](https://learn.microsoft.com/en-us/dotnet/core/testing/unit-testing-code-coverage?tabs=linux)

### Run the following if you are setting up testing for the first time for your project

```sh
docker-compose exec dotnet-test dotnet new xunit -n CTS-BE.Tests
docker-compose exec dotnet-test dotnet add CTS-BE.Tests/CTS-BE.Tests.csproj reference CTS-BE/CTS-BE.csproj
docker-compose exec dotnet-test sh -c "cd CTS-BE.Tests && dotnet add package coverlet.msbuild"
docker-compose exec dotnet-test dotnet new sln -n XUnit.Coverage
docker-compose exec dotnet-test sh -c "dotnet sln XUnit.Coverage.sln add **/*.csproj --in-root"
docker-compose exec dotnet-test sh -c "cd CTS-BE.Tests && dotnet add package Moq --version 4.20.70"
docker-compose exec dotnet-test sh -c "cd CTS-BE.Tests && dotnet add package FluentAssertions --version 6.12.0"
docker-compose exec dotnet-test dotnet build
```

### Generate Code Coverage report
```sh
docker-compose exec dotnet-test dotnet test /p:CollectCoverage=true /p:CoverletOutputFormat=cobertura
docker-compose exec dotnet-test reportgenerator \
         -reports:"./CTS-BE.Tests/coverage.cobertura.xml" \
         -targetdir:"coveragereport" \
         -reporttypes:Html
```
Now you can see the code coverage report on [http://apitests.docker.test](http://apitests.docker.test)