class Keibidrop < Formula
  desc "End-to-end encrypted peer-to-peer file sharing with FUSE virtual filesystem"
  homepage "https://github.com/KeibiSoft/KeibiDrop"
  version "0.1.0-beta"
  license "MPL-2.0"

  depends_on "macfuse"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/KeibiSoft/KeibiDrop/releases/download/v#{version}/keibidrop-#{version}-darwin-arm64.tar.gz"
      sha256 "PLACEHOLDER_ARM64_SHA256"
    else
      url "https://github.com/KeibiSoft/KeibiDrop/releases/download/v#{version}/keibidrop-#{version}-darwin-amd64.tar.gz"
      sha256 "PLACEHOLDER_AMD64_SHA256"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/KeibiSoft/KeibiDrop/releases/download/v#{version}/keibidrop-#{version}-linux-arm64.tar.gz"
      sha256 "PLACEHOLDER_LINUX_ARM64_SHA256"
    else
      url "https://github.com/KeibiSoft/KeibiDrop/releases/download/v#{version}/keibidrop-#{version}-linux-amd64.tar.gz"
      sha256 "PLACEHOLDER_LINUX_AMD64_SHA256"
    end
  end

  def install
    bin.install "keibidrop" if File.exist?("keibidrop")
    bin.install "keibidrop-cli" if File.exist?("keibidrop-cli")
    bin.install "kd" if File.exist?("kd")
  end

  def caveats
    <<~EOS
      KeibiDrop requires macFUSE for virtual folder support.
      If not already installed: brew install macfuse

      Quick start:
        keibidrop              # Launch desktop UI
        kd start               # Start CLI daemon
        kd show fingerprint    # Get your fingerprint
    EOS
  end

  test do
    assert_match "kd", shell_output("#{bin}/kd help")
  end
end
