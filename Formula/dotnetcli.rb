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
    bin.install
  end

  test do
    system "#{bin}/dotnet", "--version"
  end
end