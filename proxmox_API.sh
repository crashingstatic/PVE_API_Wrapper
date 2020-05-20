#!/bin/bash
# Created by: Aaron Sawyer (@CrashingStatic)
# 2020-05-20

PROXURL="https://URLGOESHERE:8006"
APINODE=""
TARGETNODE=""

USERNAME=""

# read -p "Username?: " USERNAME
echo -n "Password?: "
read -s PASSWORD

curl -k -d "username=$USERNAME@pve&password=$PASSWORD"  "$PROXURL/api2/json/access/ticket" > API.json

echo "Access will only be good for 2 hours. New API tickets are generated every time this script is run, renewing access."

COOKIE=$(jq --raw-output '.data.ticket' API.json | sed 's/^/PVEAuthCookie=/')

CSRFTOKEN=$(jq --raw-output '.data.CSRFPreventionToken' API.json | sed 's/^/CSRFPreventionToken:/')

rm API.json

echo "Testing auth credentials..."

curl  --silent --insecure --cookie "$COOKIE" "$PROXURL/api2/json/nodes/$TARGETNODE/status" | jq '.'

read -n1 -p "Did it work? Press any key to continue..."

while true
do
	read -p "HTTP Method? [$DEFAULT_METHOD]: " METHOD
	[[ -z $METHOD ]] && METHOD=$DEFAULT_METHOD
    DEFAULT_METHOD=$METHOD
	echo -e "\nLeave API URL blank to quit\n"
	read -p "URL (as given by PVE Docs)?: " API_CALL
	[[ -z "$API_CALL" ]] && exit

    # Find and replace section in case user directly copy and pasted from PVE API Docs
    # Would have put in a case statement, but multiple variables can show in API documentation
    if [[ "$API_CALL" == *'{node}'* ]]; then
        DEFAULT_TARGETNODE="$TARGETNODE"
        read -p "Target Node? [$DEFAULT_TARGETNODE]: " TARGETNODE
        [[ -z $TARGETNODE ]] && TARGETNODE="$DEFAULT_TARGETNODE"
        API_CALL=$(echo "$API_CALL" | sed "s#{node}#$TARGETNODE#g")
    fi
    if [[ "$API_CALL" == *'{vmid}'* ]]; then
        DEFAULT_VMID="$VMID"
        read -p "VM ID? [$DEFAULT_VMID]: " VMID
        [[ -z $VMID ]] && VMID="$DEFAULT_VMID"
        API_CALL=$(echo "$API_CALL" | sed "s#{vmid}#$VMID#g")
    fi
    if [[ "$API_CALL" == *'{flag}'* ]]; then
        DEFAULT_FLAG="$FLAG"
        read -p "FLAG? [$FDEFAULT_LAG]: " FLAG
        [[ -z $FLAG ]] && FLAG="$DEFAULT_FLAG"
        API_CALL=$(echo "$API_CALL" | sed "s#{flag}#$FLAG#g")
    fi
    if [[ "$API_CALL" == *'{realm}'* ]]; then
        DEFAULT_REALM="$REALM"
        read -p "REALM? [$DEFAULT_REALM]: " REALM
        [[ -z $REALM ]] && REALM="$DEFUALT_REALM"
        API_CALL=$(echo "$API_CALL" | sed "s#{realm}#$REALM#g")
    fi
    if [[ "$API_CALL" == *'{groupid}'* ]]; then
        DEFAULT_GROUPID="$GROUPID"
        read -p "GROUPID? [$DEFAULT_GROUPID]: " GROUPID
        [[ -z $GROUPID ]] && GROUPID="$DEFUALT_GROUPID"
        API_CALL=$(echo "$API_CALL" | sed "s#{groupid}#$GROUPID#g")
    fi
    if [[ "$API_CALL" == *'{roleid}'* ]]; then
        DEFAULT_ROLEID="$ROLEID"
        read -p "ROLEID? [$DEFAULT_ROLEID]: " ROLEID
        [[ -z $ROLEID ]] && ROLEID="$DEFUALT_ROLEID"
        API_CALL=$(echo "$API_CALL" | sed "s#{roleid}#$ROLEID#g")
    fi
    if [[ "$API_CALL" == *'{userid}'* ]]; then
        DEFAULT_USERID="$USERID"
        read -p "USERID? [$DEFAULT_USERID]: " USERID
        [[ -z $USERID ]] && USERID="$DEFUALT_USERID"
        API_CALL=$(echo "$API_CALL" | sed "s#{userid}#$USERID#g")
    fi
    if [[ "$API_CALL" == *'{tokenid}'* ]]; then
        DEFAULT_TOKENID="$TOKENID"
        read -p "TOKENID? [$DEFAULT_TOKENID]: " TOKENID
        [[ -z $TOKENID ]] && TOKENID="$DEFUALT_TOKENID"
        API_CALL=$(echo "$API_CALL" | sed "s#{tokenid}#$TOKENID#g")
    fi
    if [[ "$API_CALL" == *'{name}'* ]]; then
        DEFAULT_NAME="$NAME"
        read -p "NAME? [$DEFAULT_NAME]: " NAME
        [[ -z $NAME ]] && NAME="$NAME"
        API_CALL=$(echo "$API_CALL" | sed "s#{name}#$NAME#g")
    fi
    if [[ "$API_CALL" == *'{id}'* ]]; then
        DEFAULT_GENERIC_ID="$GENERIC_ID"
        read -p "ID? [$DEFAULT_GENERIC_ID]: " GENERIC_ID
        [[ -z $GENERIC_ID ]] && GENERIC_ID="$DEFUALT_GENERIC_ID"
        API_CALL=$(echo "$API_CALL" | sed "s#{id}#$GENERIC_ID#g")
    fi
    if [[ "$API_CALL" == *'{group}'* ]]; then
        DEFAULT_GROUP="$GROUP"
        read -p "GROUP? [$DEFAULT_GROUP]: " GROUP
        [[ -z $GROUP ]] && GROUP="$DEFAULT_GROUP"
        API_CALL=$(echo "$API_CALL" | sed "s#{group}#$GROUP#g")
    fi
    if [[ "$API_CALL" == *'{pos}'* ]]; then
        DEFAULT_POS="$POS"
        read -p "POS? [$DEFAULT_POS]: " POS
        [[ -z $POS ]] && POS="$DEFAULT_POS"
        API_CALL=$(echo "$API_CALL" | sed "s#{pos}#$POS#g")
    fi
    if [[ "$API_CALL" == *'{cidr}'* ]]; then
        DEFAULT_CIDR="$CIDR"
        read -p "CIDR? [$DEFAULT_CIDR]: " CIDR
        [[ -z $CIDR ]] && CIDR="$DEFAULT_CIDR"
        API_CALL=$(echo "$API_CALL" | sed "s#{cidr}#$CIDR#g")
    fi
    if [[ "$API_CALL" == *'{sid}'* ]]; then
        DEFAULT_SID="$SID"
        read -p "SID? [$DEFAULT_SID]: " SID
        [[ -z $SID ]] && SID="$DEFAULT_SID"
        API_CALL=$(echo "$API_CALL" | sed "s#{sid}#$SID#g")
    fi
    if [[ "$API_CALL" == *'{controller}'* ]]; then
        DEFAULT_CONTROLLER="$CONTROLLER"
        read -p "CONTROLLER? [$DEFAULT_CONTROLLER]: " CONTROLLER
        [[ -z $CONTROLLER ]] && CONTROLLER="$DEFAULT_CONTROLLER"
        API_CALL=$(echo "$API_CALL" | sed "s#{controller}#$CONTROLLER#g")
    fi
    if [[ "$API_CALL" == *'{vnet}'* ]]; then
        DEFAULT_VNET="$VNET"
        read -p "VNET? [$DEFAULT_VNET]: " VNET
        [[ -z $VNET ]] && VNET="$DEFAULT_VNET"
        API_CALL=$(echo "$API_CALL" | sed "s#{vnet}#$VNET#g")
    fi
    if [[ "$API_CALL" == *'{zone}'* ]]; then
        DEFAULT_ZONE="$ZONE"
        read -p "ZONE? [$DEFAULT_ZONE]: " ZONE
        [[ -z $ZONE ]] && ZONE="$DEFAULT_ZONE"
        API_CALL=$(echo "$API_CALL" | sed "s#{zone}#$ZONE#g")
    fi
    if [[ "$API_CALL" == *'{monid}'* ]]; then
        DEFAULT_MONID="$MONID"
        read -p "MONID? [$DEFAULT_MONID]: " MONID
        [[ -z $MONID ]] && MONID="$DEFAULT_MONID"
        API_CALL=$(echo "$API_CALL" | sed "s#{monid}#$MONID#g")
    fi
    if [[ "$API_CALL" == *'{osdid}'* ]]; then
        DEFAULT_OSDID="$OSDID"
        read -p "OSDID? [$DEFAULT_OSDID]: " OSDID
        [[ -z $OSDID ]] && OSDID="$DEFAULT_OSDID"
        API_CALL=$(echo "$API_CALL" | sed "s#{osdid}#$OSDID#g")
    fi
    if [[ "$API_CALL" == *'{pciid}'* ]]; then
        DEFAULT_PCIID="$PCIID"
        read -p "PCIID? [$DEFAULT_PCIID]: " PCIID
        [[ -z $PCIID ]] && PCIID="$DEFAULT_PCIID"
        API_CALL=$(echo "$API_CALL" | sed "s#{pciid}#$PCIID#g")
    fi
    if [[ "$API_CALL" == *'{snapname}'* ]]; then
        DEFAULT_SNAPNAME="$SNAPNAME"
        read -p "SNAPNAME? [$DEFAULT_SNAPNAME]: " SNAPNAME
        [[ -z $SNAPNAME ]] && SNAPNAME="$DEFAULT_SNAPNAME"
        API_CALL=$(echo "$API_CALL" | sed "s#{snapname}#$SNAPNAME#g")
    fi
    if [[ "$API_CALL" == *'{iface}'* ]]; then
        DEFAULT_IFACE="$IFACE"
        read -p "IFACE? [$DEFAULT_IFACE]: " IFACE
        [[ -z $IFACE ]] && IFACE="$DEFAULT_IFACE"
        API_CALL=$(echo "$API_CALL" | sed "s#{iface}#$IFACE#g")
    fi
    if [[ "$API_CALL" == *'{service}'* ]]; then
        DEFAULT_SERVICE="$SERVICE"
        read -p "SERVICE? [$DEFAULT_SERVICE]: " SERVICE
        [[ -z $SERVICE ]] && SERVICE="$DEFAULT_SERVICE"
        API_CALL=$(echo "$API_CALL" | sed "s#{service}#$SERVICE#g")
    fi
    if [[ "$API_CALL" == *'{storage}'* ]]; then
        DEFAULT_STORAGE="$STORAGE"
        read -p "STORAGE? [$DEFAULT_STORAGE]: " STORAGE
        [[ -z $STORAGE ]] && STORAGE="$DEFAULT_STORAGE"
        API_CALL=$(echo "$API_CALL" | sed "s#{storage}#$STORAGE#g")
    fi
    if [[ "$API_CALL" == *'{volume}'* ]]; then
        DEFAULT_VOLUME="$VOLUME"
        read -p "VOLUME? [$DEFAULT_VOLUME]: " VOLUME
        [[ -z $VOLUME ]] && VOLUME="$DEFAULT_VOLUME"
        API_CALL=$(echo "$API_CALL" | sed "s#{volume}#$VOLUME#g")
    fi
    if [[ "$API_CALL" == *'{upid}'* ]]; then
        DEFAULT_UPID="$UPID"
        read -p "UPID? [$DEFAULT_UPID]: " UPID
        [[ -z $UPID ]] && UPID="$DEFAULT_UPID"
        API_CALL=$(echo "$API_CALL" | sed "s#{upid}#$UPID#g")
    fi
    if [[ "$API_CALL" == *'{poolid}'* ]]; then
        DEFAULT_POOLID="$POOLID"
        read -p "POOLID? [$DEFAULT_POOLID]: " POOLID
        [[ -z $POOLID ]] && POOLID="$DEFAULT_POOLID"
        API_CALL=$(echo "$API_CALL" | sed "s#{poolid}#$POOLID#g")
    fi


	data=()
	DATA="null"
	while true
	do
        	read -p "DATA?: " DATA
        	[[ -z $DATA ]] && break
        	data+=("$DATA")
	done

	CMD=""

	for i in "${data[@]}"
	do
        	CMD="$CMD --data-urlencode $i"
	done

	echo "curl --silent --insecure --cookie COOKIE --header CSRFTOKEN -X $METHOD $CMD $PROXURL$API_CALL"
	curl --silent --insecure --cookie "$COOKIE" --header "$CSRFTOKEN" -X "$METHOD" "$CMD" "$PROXURL$API_CALL" | jq '.'
done