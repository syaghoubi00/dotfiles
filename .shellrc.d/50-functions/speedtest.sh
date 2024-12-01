#!/bin/sh

### Perform a WAN speedtest with iperf3, using https://github.com/R0GGER/public-iperf3-servers/tree/main

if command -v iperf3 >/dev/null 2>&1; then
  ## Parse North America server list, selecting a random server
  get_iperf_server() {
    ## TODO: Find constant API endpoint to pull list from
    server_list="https://db.iperf3serverlist.net/api/v1/db/public/shared-view/956847fb-43b7-4404-b048-440518fbc763/rows/export/csv"

    if curl --output /dev/null --silent --head --fail "$server_list"; then
      curl --silent "$server_list" |
        tail -n +2 |
        cut -d , -f 1 |
        sort -R |
        head -n 1
    else
      echo "Unable to fetch iperf server - the source URL may need to be updated"
    fi
  }

  speedtest_upload() {
    echo "Upload Speed:"
    get_iperf_server | xargs iperf3 "$@"
  }

  speedtest_download() {
    echo "Download Speed:"
    get_iperf_server | xargs iperf3 --reverse "$@"
  }

  speedtest() {
    speedtest_upload "$@"
    speedtest_download "$@"
  }
fi
