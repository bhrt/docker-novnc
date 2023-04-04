#!/bin/bash
set -ex

if [ "" != "$WAIT_FOR_URL" ]; then
  IFS=';' read -ra ADDR <<< "$WAIT_FOR_URL"
  for WAIT_URL in "${ADDR[@]}"; do
      /home/psidev/scripts/wait-for-it.sh $WAIT_URL -s -t 0 -- echo "$WAIT_URL available"
      sleep $DELAY_AFTER_WAIT
  done

fi

RUN_FLUXBOX=${RUN_FLUXBOX:-yes}
RUN_XTERM=${RUN_XTERM:-yes}

case $RUN_FLUXBOX in
  false|no|n|0)
    rm -f /app/conf.d/fluxbox.conf
    ;;
esac

case $RUN_XTERM in
  false|no|n|0)
    rm -f /app/conf.d/xterm.conf
    ;;
esac

exec supervisord -c /app/supervisord.conf
