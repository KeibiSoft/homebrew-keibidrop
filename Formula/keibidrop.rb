class Keibidrop < Formula
  desc "End-to-end encrypted peer-to-peer file sharing with FUSE virtual filesystem"
  homepage "https://github.com/KeibiSoft/KeibiDrop"
  license "MPL-2.0"

  version "0.4.7"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/KeibiSoft/KeibiDrop/releases/download/v#{version}/keibidrop-#{version}-darwin-arm64.tar.gz"
      sha256 "c79acfc618e8fedffa3b1d1b0e145fd1f56390a26c39db074ab10ca683479cb4"
    else
      url "https://github.com/KeibiSoft/KeibiDrop/releases/download/v#{version}/keibidrop-#{version}-darwin-amd64.tar.gz"
      sha256 "746325b89c2763c3ceefb8ccb602502b86efc20273c8a76d69b692c8c543dc06"
    end
  end

  on_linux do
    url "https://github.com/KeibiSoft/KeibiDrop/releases/download/v#{version}/keibidrop-#{version}-linux-amd64.tar.gz"
    sha256 "b1f4a85cc7bc86a6f291cb20ba47f7860234d745621923c56190890240294fa5"
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
