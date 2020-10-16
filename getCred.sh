dockercfg=$(mktemp /tmp/dockercfg.XXXXX)
storetype=$(jq -r .credsStore < ~/.docker/config.json)
(
    echo '{'
    echo '    "auths": {'
    for registry in $(docker-credential-$storetype list | jq -r 'to_entries[] | .key'); do
        if [ ! -z $FIRST ]; then
            echo '        },'
        fi
        FIRST=true
        credential=$(echo $registry | docker-credential-$storetype get | jq -jr '"\(.Username):\(.Secret)"' | base64)
        echo '        "'$registry'": {'
        echo '            "auth": "'$credential'"'
    done
    echo '        }'
    echo '    }'
    echo '}'
) > $dockercfg

# remove temporary docker config.json when shell script exits
# trap "rm -f $dockercfg" EXIT
