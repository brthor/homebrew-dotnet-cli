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
    system "cp -a ./artifacts/*/stage2/. #{bin}"
  end

  test do
    system "#{bin}/dotnet", "--version"
  end

  bottle do
    cellar :any
    root_url "https://github.com/brthor/homebrew-dotnet-cli/releases/download/1.0.0-preview2-003121"
    sha256 "41da60a0fbab6b5ad981f72731957acc1b025b210d339af69e6daa74fd54bfe9" => :yosemite
    sha256 "41da60a0fbab6b5ad981f72731957acc1b025b210d339af69e6daa74fd54bfe9" => :el_capitan
  end
end
