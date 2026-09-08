class Keibidrop < Formula
  desc "End-to-end encrypted peer-to-peer file sharing with FUSE virtual filesystem"
  homepage "https://github.com/KeibiSoft/KeibiDrop"
  license "MPL-2.0"

  version "0.4.6"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/KeibiSoft/KeibiDrop/releases/download/v#{version}/keibidrop-#{version}-darwin-arm64.tar.gz"
      sha256 "95b7a53573a69144c714f6dac856893c52edbbc51df3b1fb9855e355a4b22b12"
    else
      url "https://github.com/KeibiSoft/KeibiDrop/releases/download/v#{version}/keibidrop-#{version}-darwin-amd64.tar.gz"
      sha256 "b9b37f92bc051f4ab134c3f6c53b660a4fb6acf2f297c10972b77a9ff8b1400b"
    end
  end

  on_linux do
    url "https://github.com/KeibiSoft/KeibiDrop/releases/download/v#{version}/keibidrop-#{version}-linux-amd64.tar.gz"
    sha256 "f8bc9317412158bae20c226c3fc706d3780620aa40d13cfe3a093557ee275f81"
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
