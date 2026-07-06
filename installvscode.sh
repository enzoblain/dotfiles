#!/bin/bash

cat vscode/extensions.txt | xargs -L 1 code --install-extension
cp -R vscode/User/* ~/Library/Application\ Support/Code/User/