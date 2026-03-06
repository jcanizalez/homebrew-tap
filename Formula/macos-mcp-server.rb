class MacosMcpServer < Formula
  desc "Native macOS MCP server - 31 tools for AI agents to control your Mac"
  homepage "https://github.com/jcanizalez/macos-mcp-server"
  url "https://github.com/jcanizalez/macos-mcp-server/releases/download/v0.1.0/macos-mcp-server-0.1.0-universal-apple-darwin.tar.gz"
  sha256 "52181e9b7b790172b658e68ae58b13ec860f03db1b833c934ef3336afe84ebdb"
  license "MIT"

  depends_on :macos

  def install
    bin.install "macos-mcp-server"
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
