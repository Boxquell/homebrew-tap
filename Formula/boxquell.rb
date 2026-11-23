class Boxquell < Formula
  desc "MicroVM sandboxes for coding agents with an explicit network allowlist"
  homepage "https://github.com/Boxquell/boxquell"
  version "0.0.1"
  license any_of: ["MIT", "Apache-2.0"]

  on_macos do
    on_arm do
      url "https://github.com/Boxquell/boxquell/releases/download/v0.0.1/boxquell-v0.0.1-aarch64-apple-darwin.tar.gz"
      sha256 "8460832edf590bdb7e432d8978cf263fa7cfffe60d8ba6aa44f10472da8aacba"
    end
    on_intel do
      url "https://github.com/Boxquell/boxquell/releases/download/v0.0.1/boxquell-v0.0.1-x86_64-apple-darwin.tar.gz"
      sha256 "47f659047a72ce5ca3c55fad107b5e0dd1aeab3fe2c0051d6584d616f7bf5e34"
    end
    # Packs the system images; Homebrew keeps it out of the PATH, boxquell finds it there.
    depends_on "e2fsprogs"
  end

  on_linux do
    on_intel do
      url "https://github.com/Boxquell/boxquell/releases/download/v0.0.1/boxquell-v0.0.1-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "5bb080f6ecb87c2d1f6cc4a2784acbaa6d032e09c253c303696b4f7238635244"
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
