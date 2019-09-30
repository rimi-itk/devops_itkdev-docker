#/usr/bin/env bash
_idc_completions()
{
  local cur
  _get_comp_words_by_ref -n : cur

  if [ "${#COMP_WORDS[@]}" != "2" ]; then
    return
  fi

  # Keep the suggestions in a local variable
  local suggestions=($(compgen -W "url open drush traefik:start traefik:stop traefik:open traefik:url mailhog:open mailhog:url sql:connect sql:port xdebug hosts:insert sync sync:db sync:files images:pull composer" -- "${COMP_WORDS[1]}"))

  COMPREPLY=("${suggestions[@]}")

  __ltrim_colon_completions "$cur"
}

complete -F _idc_completions itkdev-docker-compose
complete -F _idc_completions idc
