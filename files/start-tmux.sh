#!/bin/bash

tmux new-session \; \
  split-window -v \; \
  select-pane -t 0 \; \
  split-window -h \; \
  select-pane -t 0 \; \
