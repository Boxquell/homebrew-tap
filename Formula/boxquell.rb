class Boxquell < Formula
  desc "MicroVM sandboxes for coding agents with an explicit network allowlist"
  homepage "https://github.com/Boxquell/boxquell"
  version "0.1.4"
  license any_of: ["MIT", "Apache-2.0"]

  on_macos do
    on_arm do
      url "https://github.com/Boxquell/boxquell/releases/download/v0.1.4/boxquell-v0.1.4-aarch64-apple-darwin.tar.gz"
      sha256 "53289829f61dd33e38286cfb9bb4183c95c38814220b2ff068ffe00157b9a9d6"
    end
    on_intel do
      url "https://github.com/Boxquell/boxquell/releases/download/v0.1.4/boxquell-v0.1.4-x86_64-apple-darwin.tar.gz"
      sha256 "8b5dcd060da563f85a5aceac83b3646a32ca7b6e8966769644b6aa28fd9701c9"
    end
    # Packs the system images; Homebrew keeps it out of the PATH, boxquell finds it there.
    depends_on "e2fsprogs"
  end

  on_linux do
    on_intel do
      url "https://github.com/Boxquell/boxquell/releases/download/v0.1.4/boxquell-v0.1.4-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "c7939dc6352763533c3e2dda911dff136052597128aa2cbd31a3d938233cebff"
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
