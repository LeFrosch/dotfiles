# Source: https://github.com/yangwao/omf-theme-slavic-cat

_COLOR_ORANGE='178'
_COLOR_BLUE='117' #123
_COLOR_GREEN='106' #112
_COLOR_YELLOW='186' #192
_COLOR_PINK='198'
_COLOR_GREY='059'
_COLOR_WHITE='253'
_COLOR_PURPLE='141'
_COLOR_LILAC='147'

directory() {
    echo -n "%F{$_COLOR_BLUE}%c%f"
}

triangle() {
    echo -n "%F{$_COLOR_PURPLE}⫸%f"
}

rainbow() {
    echo -n "%F{$1}彡ミ%f"
}

gitBranchName() {
    echo -n $(git rev-parse --abbrev-ref HEAD 2>/dev/null)
}

gitStatusCodes() {
    STATUS=$(git status --porcelain 2>/dev/null | sed -E 's/(^.{3}).*/\1/')

    if [[ $STATUS =~ "D" ]]; then
        rainbow "$_COLOR_PINK"
    fi
    if [[ $STATUS =~ "R" ]]; then
        rainbow "$_COLOR_ORANGE"
    fi
    if [[ $STATUS =~ "C" ]]; then
        rainbow "$_COLOR_WHITE"
    fi
    if [[ $STATUS =~ "A" ]]; then
        rainbow "$_COLOR_GREEN"
    fi
    if [[ $STATUS =~ "U" ]]; then
        rainbow "$_COLOR_BLUE"
    fi
    if [[ $STATUS =~ "M" ]]; then
        rainbow "$_COLOR_LILAC"
    fi
    if [[ $STATUS =~ "\?" ]]; then
        rainbow "$_COLOR_GREY"
    fi
}

exitcode() {
  local LAST_EXIT_CODE=$?
  if [[ $LAST_EXIT_CODE -ne 0 ]]; then
    local EXIT_CODE_PROMPT=' '
    EXIT_CODE_PROMPT+="%{$fg[red]%}-%{$reset_color%}"
    EXIT_CODE_PROMPT+="%{$fg_bold[red]%}$LAST_EXIT_CODE%{$reset_color%}"
    EXIT_CODE_PROMPT+="%{$fg[red]%}-%{$reset_color%}"
    echo "$EXIT_CODE_PROMPT"
  fi
}

gitInfo() {
    if [[ -n $(gitBranchName) ]]; then
        echo -n "@ $(gitBranchName)"

        if [[ ! $(git config oh-my-zsh.hide-info) ]]; then
            if [[ -n $(gitStatusCodes) ]]; then
                echo -n "%F{$_COLOR_PINK} ●%f (^._.^)ﾉ"
                gitStatusCodes
            else
                echo "%F{$_COLOR_GREEN} ○"
            fi
        fi
    fi
}

vimInfo() {
    case $ZVM_MODE in
    $ZVM_MODE_NORMAL)
        echo -n "n"
    ;;
    $ZVM_MODE_INSERT)
        echo -n "%F{$_COLOR_GREEN}i%f"
    ;;
    $ZVM_MODE_VISUAL)
        echo -n "%F{$_COLOR_PINK}v%f"
    ;;
    $ZVM_MODE_VISUAL_LINE)
        echo -n "%F{$_COLOR_PINK}v%f"
    ;;
    $ZVM_MODE_REPLACE)
        echo -n "%F{$_COLOR_PINK}r%f"
    ;;
  esac
}

PROMPT='[$(vimInfo)] $(directory) $(gitInfo)
$(triangle)  '
RPROMPT='%(?.%F{$_COLOR_GREEN}$?%f.%F{$_COLOR_ORANGE}$?%f)'
