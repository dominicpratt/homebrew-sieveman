cask "sieveman-bbedit" do
  version "0.4.1"
  sha256 "4cdd841d734e651936823b8ff62b5fc7bcb7cca393c35650468772b166114e21"

  url "https://github.com/dominicpratt/sieveman/archive/refs/tags/v#{version}.tar.gz"
  name "sieveman BBEdit Integration"
  desc "Download/upload Sieve scripts from BBEdit's Scripts menu via sieveman"
  homepage "https://github.com/dominicpratt/sieveman/tree/main/contrib/bbedit"

  depends_on formula: "dominicpratt/sieveman/sieveman"

  postflight do
    system_command "#{staged_path}/sieveman-#{version}/contrib/bbedit/install.sh"
  end

  uninstall script: {
    executable: "sieveman-#{version}/contrib/bbedit/uninstall.sh",
  }

  zap trash: "~/.config/sieveman/bbedit.conf"

  caveats <<~EOS
    Add your ManageSieve credentials to:
      ~/.config/sieveman/bbedit.conf
    (created from a template on first install)

    Then look for "Sieveman" under BBEdit's Scripts menu.
  EOS
end
