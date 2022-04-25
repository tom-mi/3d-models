#!/bin/bash

set -eu
mogrify -strip -resize 1024x1024\> $@
