#/usr/bin/env bash
_idc_completions()
{
  if [ "${#COMP_WORDS[@]}" != "2" ]; then
    return
  fi

  # Keep the suggestions in a local variable
  local suggestions=($(compgen -W "url open drush mailhog:open mailhog:url sql:connect sql:port xdebug host:insert sync sync:db sync:files images:pull composer" -- "${COMP_WORDS[1]}"))

  COMPREPLY=("${suggestions[@]}")
}

complete -F _idc_completions itkdev-docker-compose
complete -F _idc_completions idc