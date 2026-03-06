class MacosMcpServer < Formula
  desc "Native macOS MCP server - 31 tools for AI agents to control your Mac"
  homepage "https://github.com/jcanizalez/macos-mcp-server"
  url "https://github.com/jcanizalez/macos-mcp-server/archive/refs/tags/v1.1.1.tar.gz"
  sha256 "a45c9df90365632eb5f2bc1ed3316abacc6886bc5cb2fe3cc212e07385a6e092"
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
      macOS permissions required (dialogs trigger automatically on first launch):

      1. Accessibility: System Settings > Privacy & Security > Accessibility
      2. Screen Recording: System Settings > Privacy & Security > Screen Recording
      3. Automation: System Settings > Privacy & Security > Automation

      Add your terminal app or AI client (e.g. Claude Desktop, Cursor, VS Code).

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
