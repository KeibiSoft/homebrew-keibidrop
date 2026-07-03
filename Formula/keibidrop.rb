class Keibidrop < Formula
  desc "End-to-end encrypted peer-to-peer file sharing with FUSE virtual filesystem"
  homepage "https://github.com/KeibiSoft/KeibiDrop"
  license "MPL-2.0"

  version "0.3.6"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/KeibiSoft/KeibiDrop/releases/download/v#{version}/keibidrop-#{version}-darwin-arm64.tar.gz"
      sha256 "c329f0f2e995822023fff4de8b8d4027eb990f729991ac397aef181e9a80df13"
    else
      url "https://github.com/KeibiSoft/KeibiDrop/releases/download/v#{version}/keibidrop-#{version}-darwin-amd64.tar.gz"
      sha256 "0768e7e26e7db350ed77fe18983c329963eb92b05a2742282fd417c702053aa9"
    end
  end

  on_linux do
    url "https://github.com/KeibiSoft/KeibiDrop/releases/download/v#{version}/keibidrop-#{version}-linux-amd64.tar.gz"
    sha256 "577fcdc17f87836c11d292dfb13d11e6ea3aab021c5b708e7942be5013829d70"
  end

  def install
    # Tarball extracts into keibidrop-VERSION/ subdirectory
    subdir = Dir["keibidrop-*"].first
    if subdir && File.directory?(subdir)
      Dir.chdir(subdir) do
        bin.install "keibidrop" if File.exist?("keibidrop")
        bin.install "keibidrop-cli" if File.exist?("keibidrop-cli")
        bin.install "kd" if File.exist?("kd")
      end
    else
      bin.install "keibidrop" if File.exist?("keibidrop")
      bin.install "keibidrop-cli" if File.exist?("keibidrop-cli")
      bin.install "kd" if File.exist?("kd")
    end
  end

  def caveats
    on_macos do
      <<~EOS
        KeibiDrop uses macFUSE for virtual folder support (optional).
        Download from https://macfuse.github.io/ if not already installed.

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
