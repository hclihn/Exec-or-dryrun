DRY_RUN=false

function dryrun_exec() {
  CMD=""
  for i in "$@"; do
      if [[ ${i} =~ [[:space:]] ]]; then
          i=\"${i}\"
      fi
      if [[ -z "${CMD}" ]]; then
        CMD="${i}"
      else 
        CMD="${CMD} ${i}"
      fi
  done
  if ${DRY_RUN}; then
      echo "DRY RUN: '${CMD}'"
  elif ! "$@"; then
      echo "ERROR: Failed to execute '${CMD}'!"
      exit 1
  fi
}

DRY_RUN=true
dryrun_exec bash -c "(cd /home/runner/Exec-or-dryrun; find -P . \
  -not -type d -exec ls -l '{}' 2>/dev/null \; )"

echo -e "\nExec:"
DRY_RUN=false
dryrun_exec bash -c "(cd /home/runner/Exec-or-dryrun; find -P . \
  -not -type d -exec ls -l '{}' 2>/dev/null \; )"