class Boxquell < Formula
  desc "MicroVM sandboxes for coding agents with an explicit network allowlist"
  homepage "https://github.com/Boxquell/boxquell"
  version "0.1.0"
  license any_of: ["MIT", "Apache-2.0"]

  on_macos do
    on_arm do
      url "https://github.com/Boxquell/boxquell/releases/download/v0.1.0/boxquell-v0.1.0-aarch64-apple-darwin.tar.gz"
      sha256 "3ed1b0696fe6ba7027fb9512dfbff22d3c0e28a622cf65477c89a625192a3d55"
    end
    on_intel do
      url "https://github.com/Boxquell/boxquell/releases/download/v0.1.0/boxquell-v0.1.0-x86_64-apple-darwin.tar.gz"
      sha256 "7e1af1feb6e6799fa28eca35e444208fd73eb0389137d8c5b1f38d764279622c"
    end
    # Packs the system images; Homebrew keeps it out of the PATH, boxquell finds it there.
    depends_on "e2fsprogs"
  end

  on_linux do
    on_intel do
      url "https://github.com/Boxquell/boxquell/releases/download/v0.1.0/boxquell-v0.1.0-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "b2383b06cdfbbc47068389fb33aebe28a97e1ae37bf15c2b0595cd01c695270a"
    end
  end

  def install
    bin.install "boxquell"
    generate_completions_from_executable(bin/"boxquell", "completions")
  end

  def caveats
    <<~EOS
      Boxquell runs sandboxes on libkrun, which comes from another tap on macOS:
        brew tap slp/krun && brew install libkrun
      On Linux install libkrun and libkrunfw from your distribution.
      Building a system image needs Docker. Then:
        boxquell doctor
        boxquell os build debian
    EOS
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/boxquell --version")
  end
end
