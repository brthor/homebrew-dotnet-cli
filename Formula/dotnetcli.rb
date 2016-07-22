class Dotnetcli < Formula
  desc "Microsoft .NET Cli Preview2"
  homepage "https://github.com/dotnet/cli"
  url "https://github.com/dotnet/cli/archive/rel/1.0.0-preview2.zip"
  version "1.0.0-preview2-003122"
  sha256 "847fb53054913e57e6daa5a76e1873aab227de0ba475e797796c12512bd9412a"

  depends_on "openssl"
  depends_on "cmake" => :build

  def install
    # Build
    # git hacks here are to get the .git metadata directory which isn't present in the github source zip
    system "git init"
    system "git remote add -t rel/1.0.0-preview2 -f origin https://github.com/dotnet/cli.git"
    system "git checkout -f rel/1.0.0-preview2"
    system "./build.sh", "--targets", "Prepare,Compile"

    # SxS Placement
    opt_share.mkpath
    system "cp #{buildpath}/artifacts/*/stage2/dotnet #{opt_share}/dotnet"
    system "cp -R #{buildpath}/artifacts/*/stage2/shared/. #{opt_share}/shared"
    system "cp -R #{buildpath}/artifacts/*/stage2/sdk/. #{opt_share}/sdk"
    system "cp -R #{buildpath}/artifacts/*/stage2/host/. #{opt_share}/host"

    # binplace
    bin.mkpath
    system "ln -s #{opt_share}/dotnet #{bin}/dotnet"
  end

  test do
    system "#{bin}/dotnet", "--version"
  end
end
