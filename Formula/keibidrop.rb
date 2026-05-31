class Keibidrop < Formula
  desc "End-to-end encrypted peer-to-peer file sharing with FUSE virtual filesystem"
  homepage "https://github.com/KeibiSoft/KeibiDrop"
  license "MPL-2.0"

  version "0.3.2"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/KeibiSoft/KeibiDrop/releases/download/v#{version}/keibidrop-#{version}-darwin-arm64.tar.gz"
      sha256 "e1be3c8aeae305ba8cb4b0e024bbbcd4af81ce91a34f2f4e4db34f82fedf673d"
    else
      url "https://github.com/KeibiSoft/KeibiDrop/releases/download/v#{version}/keibidrop-#{version}-darwin-amd64.tar.gz"
      sha256 "7164edf180c1abecb2c07735c2c3ac97de1dce5207eb313506a1dae9b148d05a"
    end
  end

  on_linux do
    url "https://github.com/KeibiSoft/KeibiDrop/releases/download/v#{version}/keibidrop-#{version}-linux-amd64.tar.gz"
    sha256 "cd4d591e5c9492bbceb6e39c4e56b3c7c95b500ee2511a7e65c479632035b74c"
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
