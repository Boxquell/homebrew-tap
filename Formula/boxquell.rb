class Boxquell < Formula
  desc "MicroVM sandboxes for coding agents with an explicit network allowlist"
  homepage "https://github.com/Boxquell/boxquell"
  version "0.1.1"
  license any_of: ["MIT", "Apache-2.0"]

  on_macos do
    on_arm do
      url "https://github.com/Boxquell/boxquell/releases/download/v0.1.1/boxquell-v0.1.1-aarch64-apple-darwin.tar.gz"
      sha256 "2903beb3cf1f6ac5dd785f03f1141bbd96f5ea47f6ee9ab9e9e98a308fc8bc23"
    end
    on_intel do
      url "https://github.com/Boxquell/boxquell/releases/download/v0.1.1/boxquell-v0.1.1-x86_64-apple-darwin.tar.gz"
      sha256 "4c044abc88ce875a395a8ca7a1ba8e09f497c5763ad8cf2b4779be3398b05307"
    end
    # Packs the system images; Homebrew keeps it out of the PATH, boxquell finds it there.
    depends_on "e2fsprogs"
  end

  on_linux do
    on_intel do
      url "https://github.com/Boxquell/boxquell/releases/download/v0.1.1/boxquell-v0.1.1-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "9892276376f6c26eaf77c431a140d30b8945aafa1dca9e2e6a76a37762608c6f"
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
