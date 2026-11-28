{ ... }:
{

  environment.etc."claude-code/managed-settings.json".text = builtins.toJSON {
    permissions = {
      deny = [
        "Read(~/.config/sops/**)"
        "Read(//run/secrets/**)"
        "Read(//run/secrets.d/**)"
        "Read(//var/lib/sops-nix/**)"
        "Bash(sops:*)"
      ];
      ask = [
        "Bash(ssh:*)"
        "Bash(scp:*)"
      ];
      disableBypassPermissionsMode = "disable";
    };
  };

  environment.etc."claude-code/CLAUDE.md".text = ''
    ## Secrets
    - Never read, print, decrypt or copy secret values: `~/.config/sops/`, `/run/secrets*`, `/var/lib/sops-nix/`, private keys, or decrypted `secrets.yaml` (`sops` in any form). Encrypted files and secret names are fine.
    - To check that a secret is set up, look only at metadata (`ls -l`, `test -s`, unit status), never the contents.
    - Output from anything that uses secrets (journal, curl, docker logs, env, `systemctl show`) can contain them. Filter for the lines you need instead of dumping and masking. If something looks like a token, topic or credential, stop and tell me instead of repeating it.
    - If a task needs a secret value, ask me to run the command.

    ## Other machines
    - Ask before running anything on another host (ssh, scp, remote rebuilds), and show the exact command first.
  '';

}
