#!/usr/bin/env sh

#list priority A tasks | strip all but the first line | remove colour codes (special characters)

todo.sh -d ~/.config/todo.txt/config lsp a | head -n 1 | sed "s,\x1B\[[0-9;]*[a-zA-Z],,g" | sed 's/\r$//'

