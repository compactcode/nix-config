#!/bin/bash

kitty @ send-text --match-tab title:"$1" "$2" >/dev/null
