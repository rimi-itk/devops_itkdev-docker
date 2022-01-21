#/usr/bin/env bash
_idc_completions()
{
  local cur
  _get_comp_words_by_ref -n : cur

  if [ "${#COMP_WORDS[@]}" != "2" ]; then
    return
  fi

  # Keep the suggestions in a local variable
  local suggestions=($(compgen -W "dory:start dory:stop url open drush nfs:enable template:install traefik:start traefik:stop traefik:open traefik:url mailhog:open mailhog:url sql:connect sql:port sql:open xdebug xdebug2 xdebug3 hosts:insert sync sync:db sync:files images:pull composer version bin/console" -- "${COMP_WORDS[1]}"))

  COMPREPLY=("${suggestions[@]}")

  __ltrim_colon_completions "$cur"
}

complete -F _idc_completions itkdev-docker-compose
complete -F _idc_completions idc
