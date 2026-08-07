cask "sieveman-vscode" do
  version "0.2.0"
  sha256 "f44756b0e73b2a3f2e8b51aac3036bd4d9f2bd439618f416c8b0969bb343fbc9"

  url "https://github.com/dominicpratt/sieveman/releases/download/v0.5.1/sieveman-vscode-#{version}.vsix"
  name "Sieveman for VS Code"
  desc "Download/upload Sieve scripts via sieveman, .sieve highlighting"
  homepage "https://github.com/dominicpratt/sieveman/tree/main/contrib/vscode"

  depends_on formula: "dominicpratt/sieveman/sieveman"
  container type: :naked

  # Homebrew sanitizes the PATH used by system_command/uninstall script, so
  # a bare "code" doesn't resolve even when it's on the user's own PATH.
  # This is the fixed location both the official visual-studio-code cask
  # and a direct download from code.visualstudio.com install to.
  code_bin = "/Applications/Visual Studio Code.app/Contents/Resources/app/bin/code"

  postflight do
    unless File.executable?(code_bin)
      opoo "#{code_bin} not found - install VS Code first, then run " \
           "`code --install-extension` yourself with the file in " \
           "#{staged_path}."
      next
    end
    system_command code_bin, args: ["--install-extension", staged_path.to_s, "--force"], must_succeed: true
  end

  uninstall script: {
    executable: code_bin,
    args:       ["--uninstall-extension", "dominicpratt.sieveman-vscode"],
  }

  caveats <<~EOS
    Requires VS Code to be installed at /Applications/Visual Studio Code.app.
  EOS
end
