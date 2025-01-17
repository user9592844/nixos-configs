{ pkgs, lib, config, ... }:

{
  programs.fish = {
    enable = true;
    interactiveShellInit = ''
      set fish_greeting # Disable greeting
      starship init fish | source
    '';
    # source (/home/user0/.nix-profile/bin/starship init fish --print-full-init | psub)
    functions = {
      # GCC Aliases
      gcc = ''
        function gcc
          command gcc -Wall -Wextra -Werror -Wpedantic $argv
        end
      '';
      gcc-asm = ''
        function gcc-asm
          command gcc -c $argv
        end
      '';
      gcc-com = ''
        function gcc-com
          command gcc -S $argv
        end
      '';
      gcc-pre = ''
        function gcc-pre
          command gcc -E $argv
        end
      '';

      # G++ Aliases
      "g++" = ''
        function g++
          command g++ -Wall -Wextra -Werror -Wpedantic $argv
        end
      '';
      "g++-asm" = ''
        function g++-asm
          command g++ -c $argv
        end
      '';
      "g++-com" = ''
        function g++-com
          command g++ -S $argv
        end
      '';
      "g++-pre" = ''
        function g++-pre
          command g++ -E $argv
        end
      '';

      # Git Aliases
      gita = ''
        function gita
          git add $argv
        end
      '';

      gitb = ''
        function gitb
          git branch $argv
        end
      '';

      gitc = ''
        function gitc
          git checkout $argv
        end
      '';

      gitd = ''
        function gitd
          git branch -D $argv
        end
      '';

      gitf = ''
        function gitf
          git fetch --prune --recurse-submodules $argv
        end
      '';

      gitl = ''
        function gitl
          git log $argv
        end
      '';

      gitr = ''
        function gitr
          git restore $argv
        end
      '';

      gits = ''
        function gits
          git status $argv
        end
      '';

      gitv = ''
        function gitv
          git version $argv
        end
      '';

      gcom = ''
        function gcom
          git commit $argv
        end
      '';

      gpul = ''
        function gpul
          git pull $argv
        end
      '';

      gpus = ''
        function gpus
          git push --recurse-submodules=on-demand $argv
        end
      '';

      gsub = ''
        function gsub
          git submodule $argv
        end
      '';

      # Grep Aliases
      grep = ''
        function grep
          command grep --color=auto $argv
        end
      '';

      egrep = ''
        function egrep
          egrep --color=auto $argv
        end
      '';

      fgrep = ''
        function fgrep
          fgrep --color=auto $argv
        end
      '';

      # Ripgrep Aliases
      rg = ''
        function rg
          command rg --color=auto -Suuu $argv
        end
      '';

      erg = ''
        function erg
          command erg --color=auto $argv
        end
      '';

      # List Directory Aliases
      ls = ''
        function ls
          lsd $argv
        end
      '';

      ll = ''
        function ll
          ls -la $argv
        end
      '';

      "l." = ''
        function l.
          ll -d \.\*
        end
      '';

    };
  };
}
