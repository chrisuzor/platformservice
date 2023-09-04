FROM mcr.microsoft.com/dotnet/sdk:7.0 AS build-env
WORKDIR /app


COPY ["PlatformService.csproj", "./"]
RUN dotnet restore "PlatformService.csproj"
COPY . .

RUN dotnet build "PlatformService.csproj" -c Release -o out


FROM mcr.microsoft.com/dotnet/aspnet:7.0
WORKDIR /app
COPY --from=build-env /app/out .
ENTRYPOINT ["dotnet", "PlatformService.dll"]
