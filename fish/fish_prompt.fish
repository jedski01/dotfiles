# Based of lambda theme with some modifications with color
# using github dark dimmed colors
function fish_prompt
  # Cache exit status
  set -l last_status $status

  # Just calculate these once, to save a few cycles when displaying the prompt
  if not set -q __fish_prompt_hostname
    set -g __fish_prompt_hostname (uname -n|cut -d . -f 1)
  end
  if not set -q __fish_prompt_char
    switch (id -u)
      case 0
        set -g __fish_prompt_char '#'
      case '*'
        set -g __fish_prompt_char 'λ'
    end
  end

  # Setup colors
  set -l normal (set_color normal)
  set -l turquoise (set_color 95e6cb)
  set -l orange (set_color ffa759)
  set -l red (set_color ff3333)
  set -l blue (set_color 73d0ff)
  set -l limegreen (set_color bae67e)
  set -l purple (set_color f27983)
  set -l fg (set_color cbccc6)

  # Configure __fish_git_prompt
  set -g __fish_git_prompt_char_stateseparator ' '
  set -g __fish_git_prompt_color ffb9a5
  set -g __fish_git_prompt_color_flags df5f00
  set -g __fish_git_prompt_color_prefix cbccc6
  set -g __fish_git_prompt_color_suffix cbccc6
  set -g __fish_git_prompt_showdirtystate true
  set -g __fish_git_prompt_showuntrackedfiles true
  set -g __fish_git_prompt_showstashstate true
  set -g __fish_git_prompt_show_informative_status true

  set -l current_user (whoami)

  ##
  ## Line 1
  ##
  echo -n $orange'╭─'$blue$current_user$fg' at '$orange$__fish_prompt_hostname$fg' in '$limegreen(pwd|sed "s=$HOME=⌁=")$turquoise
  __fish_git_prompt " (%s)"
  echo

  ##
  ## Line 2
  ##
  echo -n $orange'╰'

  # Disable virtualenv's default prompt
  set -g VIRTUAL_ENV_DISABLE_PROMPT true

  # support for virtual env name
  if set -q VIRTUAL_ENV
    echo -n "($turquoise"(basename "$VIRTUAL_ENV")"$fg)"
  end

  ##
  ## Support for vi mode
  ##
  set -l lambdaViMode "$THEME_LAMBDA_VI_MODE"

  # Do nothing if not in vi mode
  if test "$fish_key_bindings" = fish_vi_key_bindings
      or test "$fish_key_bindings" = fish_hybrid_key_bindings
    if test -z (string match -ri '^no|false|0$' $lambdaViMode)
      set_color --bold
      echo -n $fg'─['
      switch $fish_bind_mode
        case default
          set_color red
          echo -n 'n'
        case insert
          set_color green
          echo -n 'i'
        case replace_one
          set_color green
          echo -n 'r'
        case replace
          set_color cyan
          echo -n 'r'
        case visual
          set_color magenta
          echo -n 'v'
      end
      echo -n $fg']'
    end
  end

  ##
  ## Rest of the prompt
  ##
  echo -n $orange'─'$fg$__fish_prompt_char $normal
end
