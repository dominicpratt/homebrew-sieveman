cask "sieveman-vscode" do
  version "0.2.0"
  sha256 "f44756b0e73b2a3f2e8b51aac3036bd4d9f2bd439618f416c8b0969bb343fbc9"

  url "https://github.com/dominicpratt/sieveman/releases/download/v0.5.1/sieveman-vscode-#{version}.vsix"
  name "Sieveman for VS Code"
  desc "Download/upload Sieve scripts via sieveman, .sieve highlighting"
  homepage "https://github.com/dominicpratt/sieveman/tree/main/contrib/vscode"

  depends_on formula: "dominicpratt/sieveman/sieveman"
  container type: :naked

  postflight do
    system_command! "code", args: ["--install-extension", staged_path.to_s, "--force"]
  end

  uninstall script: {
    executable: "code",
    args:       ["--uninstall-extension", "dominicpratt.sieveman-vscode"],
  }

  caveats <<~EOS
    Requires the "code" command on PATH. If `code --version` doesn't work
    in your terminal, run "Shell Command: Install 'code' command in PATH"
    from VS Code's Command Palette first.
  EOS
end
