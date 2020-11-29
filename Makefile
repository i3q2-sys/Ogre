include .env
export $(shell sed 's/=.*//' .env)

init:    #initialize terraform, only necessary fist time b4 terraform execution or if changes done in terraform configuration  
	cd terraform && terraform init
	ansible-galaxy collection install amazon.aws --ignore-errors
	pip3 install boto3
	pip3 install botocore

prepare-infra: #plan b4 apply
	 cd scripts && chmod 700 parse_params.sh && ./parse_params.sh
	 cd terraform && terraform plan -out plan

apply-infra:
	chmod 600 ./terraform/${TF_VAR_KEY_NAME}.pem
	cd terraform && terraform apply  --auto-approve "plan"
	sleep 20
	ansible-playbook -u ubuntu --private-key ./terraform/${TF_VAR_KEY_NAME}.pem -i ./ansible/plugin.aws_ec2.yaml ./ansible/ConfigBridgePlaybook.yaml
	cd terraform && terraform output

destroy-infra: #carefull with this command, check if the instances to be destroyed are correct
	cd terraform  && terraform destroy

list-infra:
	ansible-inventory ./ansible/plugin.aws_ec2.yaml

