#!/bin/sh

### Perform a WAN speedtest with iperf3, using https://github.com/R0GGER/public-iperf3-servers/tree/main

if command -v iperf3 >/dev/null 2>&1; then
  ## Parse North America server list, selecting a random server
  get_iperf_server() {
    SERVER_LIST="https://export.iperf3serverlist.net/unparsed_iperf3_servers.json"

    if curl --output /dev/null --silent --head --fail "$SERVER_LIST"; then
      curl --silent "$SERVER_LIST" | jq -r '.[] | select( .COUNTRY | contains("US")) | ."IP/HOST"' | shuf -n1 | cut -d ' ' -f 2-5
    else
      echo "Unable to fetch iperf server"
      return 1
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
