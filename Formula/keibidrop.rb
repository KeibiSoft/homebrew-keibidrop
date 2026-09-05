class Keibidrop < Formula
  desc "End-to-end encrypted peer-to-peer file sharing with FUSE virtual filesystem"
  homepage "https://github.com/KeibiSoft/KeibiDrop"
  license "MPL-2.0"

  version "0.4.4"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/KeibiSoft/KeibiDrop/releases/download/v#{version}/keibidrop-#{version}-darwin-arm64.tar.gz"
      sha256 "3bb4efd27f3eaabfed1993e0a51466e75600abb9612d3ce2e1bc73090ac3de1e"
    else
      url "https://github.com/KeibiSoft/KeibiDrop/releases/download/v#{version}/keibidrop-#{version}-darwin-amd64.tar.gz"
      sha256 "b43a245c4649de21c100ff7b0061b4c737a8ab9c815859f3b183a4ae133551eb"
    end
  end

  on_linux do
    url "https://github.com/KeibiSoft/KeibiDrop/releases/download/v#{version}/keibidrop-#{version}-linux-amd64.tar.gz"
    sha256 "e6e7d11ccd2fcc5ec4adc8c40c2724b3b2b45bd69637a30570d2200c57094ad2"
  end

  def install
    # Tarball extracts into keibidrop-VERSION/ subdirectory
    subdir = Dir["keibidrop-*"].first
    if subdir && File.directory?(subdir)
      Dir.chdir(subdir) do
        bin.install "keibidrop" if File.exist?("keibidrop")
        bin.install "keibidrop-cli" if File.exist?("keibidrop-cli")
        bin.install "kd" if File.exist?("kd")
        bin.install "kdmcp" if File.exist?("kdmcp")
      end
    else
      bin.install "keibidrop" if File.exist?("keibidrop")
      bin.install "keibidrop-cli" if File.exist?("keibidrop-cli")
      bin.install "kd" if File.exist?("kd")
      bin.install "kdmcp" if File.exist?("kdmcp")
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
