# homebrew-dotnet-cli
dotnet cli tap/formulas for OSX homebrew package manager

# Getting Started

```bash
brew tap brthor/homebrew-dotnet-cli

# Homebrew doesn't let us link openssl as a dependency so this step is unfortunately necessary
brew install openssl && brew link --force openssl

brew install dotnetcli

dotnet new
dotnet restore
dotnet run 
:)
```
