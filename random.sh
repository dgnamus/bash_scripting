#!/usr/bin/env bash

# Illustration of a block of code that won't run
if [[ 3 > 4 ]]; then
    echo "you will never reach this line of code"
fi

# case statement
case word in
    pattern1)
        Statements(s)
        ;;
    pattern2)
        Statement(s)
        ;;
    *)
        Default condition to be executed
        ;;
esac

