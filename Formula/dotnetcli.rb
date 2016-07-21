class Dotnetcli < Formula
  desc "Microsoft .NET Cli Preview2"
  homepage "https://github.com/dotnet/cli"
  url "https://github.com/dotnet/cli/archive/rel/1.0.0-preview2.zip"
  version "1.0.0-preview2-003121"
  sha256 "847fb53054913e57e6daa5a76e1873aab227de0ba475e797796c12512bd9412a"

  depends_on "openssl"
  depends_on "cmake" => :build

  def install
    system "git init"
    system "git remote add -t rel/1.0.0-preview2 -f origin https://github.com/dotnet/cli.git"
    system "git checkout -f rel/1.0.0-preview2"
    system "./build.sh", "--targets", "Prepare,Compile"
    system "mkdir -p /usr/local/share/dotnet"
    system "cp -n ./artifacts/*/stage2/dotnet /usr/local/share/dotnet/dotnet"
    system "cp -R -n ./artifacts/*/stage2/shared/. /usr/local/share/dotnet/shared"
    system "cp -R -n ./artifacts/*/stage2/sdk/. /usr/local/share/dotnet/sdk"
    system "cp -R -n ./artifacts/*/stage2/host/. /usr/local/share/dotnet/host"
    system "mkdir -p #{bin}"
    system "ln -s /usr/local/share/dotnet/dotnet #{bin}/dotnet"
  end

  test do
    system "#{bin}/dotnet", "--version"
  end

  # bottle do
  #   cellar :any
  #   root_url "https://github.com/brthor/homebrew-dotnet-cli/releases/download/1.0.0-preview2-003121"
  #   sha256 "41da60a0fbab6b5ad981f72731957acc1b025b210d339af69e6daa74fd54bfe9" => :yosemite
  #   sha256 "41da60a0fbab6b5ad981f72731957acc1b025b210d339af69e6daa74fd54bfe9" => :el_capitan
  # end
end
