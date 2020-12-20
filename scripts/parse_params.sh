#/bin/bash
cp ../config/torrc_bridge.example ../config/torrc_bridge
sed -i "s/TOKEN1/$TF_VAR_ORPORT/g" ../config/torrc_bridge
sed -i "s/TOKEN2/$TF_VAR_OBFS4PORT/g" ../config/torrc_bridge
sed -i "s/TOKEN3/$BANDWIDTH/g" ../config/torrc_bridge
cp ../ansible/example.plugin.aws_ec2.yaml ../ansible/plugin.aws_ec2.yaml
sed -i "s@TOKEN1@$AWS_ACCESS_KEY@g" ../ansible/plugin.aws_ec2.yaml
sed -i "s@TOKEN2@$AWS_SECRET_ACCESS_KEY@g" ../ansible/plugin.aws_ec2.yaml



