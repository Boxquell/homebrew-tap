class Boxquell < Formula
  desc "MicroVM sandboxes for coding agents with an explicit network allowlist"
  homepage "https://github.com/Boxquell/boxquell"
  version "0.1.3"
  license any_of: ["MIT", "Apache-2.0"]

  on_macos do
    on_arm do
      url "https://github.com/Boxquell/boxquell/releases/download/v0.1.3/boxquell-v0.1.3-aarch64-apple-darwin.tar.gz"
      sha256 "0afeb70e79a666a2232315eac312464710aaaa56432f1693653e5500863a89e2"
    end
    on_intel do
      url "https://github.com/Boxquell/boxquell/releases/download/v0.1.3/boxquell-v0.1.3-x86_64-apple-darwin.tar.gz"
      sha256 "7939604169d31ce62ca72ea2375dccc0257fc3364eb6376f869ffc88b84a37b0"
    end
    # Packs the system images; Homebrew keeps it out of the PATH, boxquell finds it there.
    depends_on "e2fsprogs"
  end

  on_linux do
    on_intel do
      url "https://github.com/Boxquell/boxquell/releases/download/v0.1.3/boxquell-v0.1.3-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "30de402e3c2c60414195810365a1f9a42c73fcb584eb30d489577e9acdd06d02"
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
