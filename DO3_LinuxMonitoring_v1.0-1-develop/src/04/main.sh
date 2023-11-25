#!/bin/bash

chmod +x ./functions.sh
source ./functions.sh
source ./colors.conf

amount_arg=$#
choose_color $amount_arg $column1_background $column1_font_color $column2_background $column2_font_color
