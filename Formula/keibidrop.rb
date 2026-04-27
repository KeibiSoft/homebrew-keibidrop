class Keibidrop < Formula
  desc "End-to-end encrypted peer-to-peer file sharing with FUSE virtual filesystem"
  homepage "https://github.com/KeibiSoft/KeibiDrop"
  license "MPL-2.0"

  version "0.1.1"

  depends_on "macfuse" => :recommended

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/KeibiSoft/KeibiDrop/releases/download/v#{version}/keibidrop-#{version}-darwin-arm64.tar.gz"
      sha256 "9e28c357e6a1eb1b5ba6664a83674752b84b57a114352782c4b80e2dd16b96e7"
    else
      url "https://github.com/KeibiSoft/KeibiDrop/releases/download/v#{version}/keibidrop-#{version}-darwin-amd64.tar.gz"
      sha256 "5504c81a25f78f5c2aa6a6ee92351de1d0e43622cd9b67ac9a1d6bcc4d01918e"
    end
  end

  on_linux do
    url "https://github.com/KeibiSoft/KeibiDrop/releases/download/v#{version}/keibidrop-#{version}-linux-amd64.tar.gz"
    sha256 "0caf4aa7e20f4ae4076d24570d30b91a0fe1e1d64c7259158808d520c740b892"
    depends_on "libfuse2" => :recommended
  end

  def install
    bin.install "keibidrop" if File.exist?("keibidrop")
    bin.install "keibidrop-cli" if File.exist?("keibidrop-cli")
    bin.install "kd" if File.exist?("kd")
  end

  def caveats
    on_macos do
      <<~EOS
        KeibiDrop uses macFUSE for virtual folder support (optional).
        If not already installed: brew install macfuse

        Quick start:
          keibidrop              # Launch desktop UI
          kd start               # Start CLI daemon
          keibidrop-cli          # Interactive REPL
      EOS
    end
    on_linux do
      <<~EOS
        KeibiDrop uses FUSE for virtual folder support (optional).
        If not already installed: sudo apt install libfuse2

        Quick start:
          keibidrop              # Launch desktop UI
          kd start               # Start CLI daemon
          keibidrop-cli          # Interactive REPL
      EOS
    end
  end

  test do
    assert_match "kd", shell_output("#{bin}/kd help")
  end
end
