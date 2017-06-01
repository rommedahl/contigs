#!/usr/bin/env bash
sort -n | awk ' { a[i++]=$1; }
    END { x=int((i+1)/2); if (x < (i+1)/2) print (a[x-1]+a[x])/2; else print a[x-1]; }'