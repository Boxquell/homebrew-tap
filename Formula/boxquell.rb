class Boxquell < Formula
  desc "MicroVM sandboxes for coding agents with an explicit network allowlist"
  homepage "https://github.com/Boxquell/boxquell"
  version "0.1.5"
  license any_of: ["MIT", "Apache-2.0"]

  on_macos do
    on_arm do
      url "https://github.com/Boxquell/boxquell/releases/download/v0.1.5/boxquell-v0.1.5-aarch64-apple-darwin.tar.gz"
      sha256 "eface34fb05fbb4db485d57c15bf6d8fdb61b60337582f4705307ee76233617e"
    end
    on_intel do
      url "https://github.com/Boxquell/boxquell/releases/download/v0.1.5/boxquell-v0.1.5-x86_64-apple-darwin.tar.gz"
      sha256 "d3bb3003f417548ea0459d9b289951bc9b2e92f4eef4647966faffb5a606b8f4"
    end
    # Packs the system images; Homebrew keeps it out of the PATH, boxquell finds it there.
    depends_on "e2fsprogs"
  end

  on_linux do
    on_intel do
      url "https://github.com/Boxquell/boxquell/releases/download/v0.1.5/boxquell-v0.1.5-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "dad952414a184ed08af10426050a8c3c5e6897a353063c742379d3d17e475a71"
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
