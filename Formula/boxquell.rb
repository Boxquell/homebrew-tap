class Boxquell < Formula
  desc "MicroVM sandboxes for coding agents with an explicit network allowlist"
  homepage "https://github.com/Boxquell/boxquell"
  version "0.0.2"
  license any_of: ["MIT", "Apache-2.0"]

  on_macos do
    on_arm do
      url "https://github.com/Boxquell/boxquell/releases/download/v0.0.2/boxquell-v0.0.2-aarch64-apple-darwin.tar.gz"
      sha256 "5c7b4b3d6ddf30bd1cfb299e4a33da7eb50b623e86f809983c2dd61d6062df18"
    end
    on_intel do
      url "https://github.com/Boxquell/boxquell/releases/download/v0.0.2/boxquell-v0.0.2-x86_64-apple-darwin.tar.gz"
      sha256 "f86be2fa1d3a21c05b9f4bd2f21a125c963099f264870b2cf779fd67658a9550"
    end
    # Packs the system images; Homebrew keeps it out of the PATH, boxquell finds it there.
    depends_on "e2fsprogs"
  end

  on_linux do
    on_intel do
      url "https://github.com/Boxquell/boxquell/releases/download/v0.0.2/boxquell-v0.0.2-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "390d39fdd2ec70402b229d499e13736d38eb49627e1d42270393cdbd4cc22445"
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
