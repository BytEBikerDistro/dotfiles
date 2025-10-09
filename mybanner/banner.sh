#!/bin/bash

# Prevent running twice in same session
if [[ -n "$BANNER_SHOWN" ]]; then
    return 0 2>/dev/null || exit 0
fi
export BANNER_SHOWN=1

# === ASCII Art ===
cat << "EOF" | lolcat

                          _______
                         | ___  o|
                         |[_-_]_ |
      ______________     |[_____]|
     |.------------.|    |[_____]|
     ||            ||    |[====o]|
     ||            ||    |[_.--_]|
     ||            ||    |[_____]|
     ||            ||    |      :|
     ||____________||    |      :|
 .==.|""  ......    |.==.|      :|
 |::| '-.________.-' |::||      :|
 |''|  (__________)-.|''||______:|
 `""`_.............._\""`______
    /:::::::::::'':::\`;'-.-.  `\
   /::=========.:.-::"\ \ \--\   \
   \`""""""""""""""""`/  \ \__)   \
jgs `""""""""""""""""`    '========'


EOF

# === Your Name in Rainbow Box ===
toilet -f standard -F border "TERMUX" | lolcat
