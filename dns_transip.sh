#!/bin/sh

api=/root/.composer/vendor/bin/tipctl
# Usage: add  _acme-challenge.www.domain.com   "XKrxpRBosdIKFzxW_CT3KLZNf6q0HG9i01zxXp5CPBs"
# Used to add txt record
dns_transip_add() { 
	fulldomain=$1
	txtvalue=$2
	_debug "adding $fulldomain, with value $txtvalue"
	_debug "First detect the root zone"
	domain=$(_get_root "$fulldomain")
	host=$(echo $fulldomain | sed -e "s/\.$domain//g")
	if $?; then
		_err "invalid domain"
		return 1
	fi
	_debug "$api domain:dns:adddnsentry -- $domain \"$host\" 3600 \"$txtvalue\""
	$api -- domain:dns:adddnsentry $domain "$host" 3600 TXT "$txtvalue"
}

# Usage: fulldomain txtvalue
# Used to remove the txt record after validation
dns_transip_rm() { 
        fulldomain=$1
        txtvalue=$2
        _debug "adding $fulldomain, with value $txtvalue"
        _debug "First detect the root zone"
	domain=$(_get_root "$fulldomain")
	host=$(echo $fulldomain | sed -e "s/\.$domain//g")
        if $?; then
                _err "invalid domain"
                return 1
        fi

        $api -- domain:dns:removednsentry $domain "$host" 3600 TXT "$txtvalue"
}


_get_root() {
	fulldomain=$1
	host=$1
	domains=$($api domain:getall | jq -r '.[].name')
	for d in $domains
	do
		host=$(echo $host | sed -e "s/\.$d//g")
		if [ $fulldomain != $host ]
		then
			echo $d
			return 0
		fi
	done
	if [ "$host" = "$fulldomain" ]
	then
		return 1
	fi
}
