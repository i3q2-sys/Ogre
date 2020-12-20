include .env
export $(shell sed 's/=.*//' .env)	
init:    #initialize terraform, only necessary fist time b4 terraform execution or if changes done in terraform configuration  
	docker-compose run infra bash -c "cd && pwd && cd /root/terraform && terraform init"
	
prepare-infra: #plan b4 apply
	docker-compose run infra bash -c "cd /root/scripts && chmod 700 parse_params.sh && ./parse_params.sh && cd /root/terraform && terraform plan -out plan"
	 
apply-infra:
	docker-compose run infra bash -c "chmod 600 /root/terraform/${TF_VAR_KEY_NAME}.pem && cd /root/terraform && terraform apply  --auto-approve \"plan\" && sleep 20 && ansible-playbook -u ubuntu --private-key /root/terraform/${TF_VAR_KEY_NAME}.pem -i /root/ansible/plugin.aws_ec2.yaml /root/ansible/ConfigBridgePlaybook.yaml && cd /root/terraform && terraform output"
	
destroy-infra: #carefull with this command, check if the instances to be destroyed are correct
	docker-compose run infra bash -c " cd /root/useful_files && rm -rf * && cd .. && cd /root/terraform && terraform destroy"

list-infra:
	docker-compose run infra bash -c "ansible-inventory /root/ansible/plugin.aws_ec2.yaml"

