string="One Two Three"

# Without ""
for element in ${string}; do
    echo ${element}
done

#With ""
for element in "${string}"; do
    echo ${element}
done

# You wouldn't use double quotes in a case like this one:
readonly SERVERS="server1 server2 server3"
for server in ${SERVERS}; do  # (it's meant for this line)
    echo "${server}.kodekloud.com"
done
