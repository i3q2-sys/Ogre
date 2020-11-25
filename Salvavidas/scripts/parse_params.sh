#/bin/bash
cp ../config/torrc_bridge.example ../config/torrc_bridge
sed -i "s/TOKEN1/$TF_VAR_ORPORT/g" ../config/torrc_bridge
sed -i "s/TOKEN2/$TF_VAR_OBFS4PORT/g" ../config/torrc_bridge


