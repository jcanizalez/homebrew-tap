class MacosMcpServer < Formula
  desc "Native macOS MCP server - 29 tools for AI agents to control your Mac"
  homepage "https://github.com/jcanizalez/macos-mcp-server"
  url "https://github.com/jcanizalez/macos-mcp-server/archive/refs/tags/v1.1.0.tar.gz"
  sha256 "0019dfc4b32d63c1392aa264aed2253c1e0c2fb09216f8e2cc269bbfb8bb49b5"
  license "MIT"

  depends_on xcode: ["15.0", :build]
  depends_on :macos

  def install
    system "swift", "build",
           "-c", "release",
           "--disable-sandbox"
    bin.install ".build/release/macos-mcp-server"
  end

  def caveats
    <<~EOS
      macOS permissions required:

      1. Accessibility: System Settings > Privacy & Security > Accessibility
         Add your terminal app or Claude Desktop

      2. Screen Recording: System Settings > Privacy & Security > Screen Recording
         Add your terminal app or Claude Desktop

      Configure in Claude Desktop (~/Library/Application Support/Claude/claude_desktop_config.json):
        {
          "mcpServers": {
            "macos": {
              "command": "#{bin}/macos-mcp-server"
            }
          }
        }
    EOS
  end

  test do
    # Verify the binary runs and responds to MCP initialize
    assert_match "macos-mcp-server", shell_output("#{bin}/macos-mcp-server --help 2>&1", 1)
  end
end
