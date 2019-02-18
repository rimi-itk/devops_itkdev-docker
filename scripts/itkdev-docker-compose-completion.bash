#/usr/bin/env bash
_idc_completions()
{
  if [ "${#COMP_WORDS[@]}" != "2" ]; then
    return
  fi

  # Keep the suggestions in a local variable
  local suggestions=($(compgen -W "url open drush sql:connect sql:port xdebug host:insert composer" -- "${COMP_WORDS[1]}"))


  for i in "${!suggestions[@]}"; do
    suggestions[$i]="$(printf '%*s' "-$COLUMNS"  "${suggestions[$i]}")"
  done

  COMPREPLY=("${suggestions[@]}")
}

complete -F _idc_completions itkdev-docker-compose idc
