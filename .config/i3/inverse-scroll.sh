#!/bin/bash

# Get id of touchpad and the id of the field corresponding to
# natural scrolling
id=`xinput list | grep "TouchPad" | cut -d'=' -f2 | cut -d'[' -f1`
natural_scrolling_id=`xinput list-props $id | \
                      grep "Natural Scrolling Enabled (" \
                      | cut -d'(' -f2 | cut -d')' -f1`

# Set the property to true
xinput --set-prop $id $natural_scrolling_id 1
#xinput --set-prop 14 280 1
