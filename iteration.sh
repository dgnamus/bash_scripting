#!/bin/bash

# Example 1
i=1

while [[ $i -le 3 ]]; do
    echo "Iteration $i"
    i=$((i+1)
done

# Example 2
for i in {1..3}; do
    echo "Iteration $i"
done

# Example 3
i=3

until [[ $i -eq 0 ]]; do
    echo "Iteration $i"
    i=$((i-1))
done

# Example 4
for i in $(seq 1 3); do
    echo "Iteration $i"
done

# Example 5
seq 1 3 | while read i; do
    echo "Iteration $i"
done

# Example 6
while read fds.txt; do
    echo "Iteration $i"
done


