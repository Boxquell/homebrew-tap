class Boxquell < Formula
  desc "MicroVM sandboxes for coding agents with an explicit network allowlist"
  homepage "https://github.com/Boxquell/boxquell"
  version "0.1.2"
  license any_of: ["MIT", "Apache-2.0"]

  on_macos do
    on_arm do
      url "https://github.com/Boxquell/boxquell/releases/download/v0.1.2/boxquell-v0.1.2-aarch64-apple-darwin.tar.gz"
      sha256 "53f6e8052bdb7ecfa7eb7350e461400bec13a0f900e3518032632becdb81c3ea"
    end
    on_intel do
      url "https://github.com/Boxquell/boxquell/releases/download/v0.1.2/boxquell-v0.1.2-x86_64-apple-darwin.tar.gz"
      sha256 "e1ea011f8955b9854c3d318dfc1553934240a03a15310ab703919ce70d4a5b57"
    end
    # Packs the system images; Homebrew keeps it out of the PATH, boxquell finds it there.
    depends_on "e2fsprogs"
  end

  on_linux do
    on_intel do
      url "https://github.com/Boxquell/boxquell/releases/download/v0.1.2/boxquell-v0.1.2-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "dced419d784583efa3f6a2b7f92e10c06408bc8082c1bc57e8466503549b3c24"
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
