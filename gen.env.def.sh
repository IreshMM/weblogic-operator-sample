#!/usr/bin/env bash

sed -n 's/\([A-Z_]\+=\).*/\1/p' .env > .env.def