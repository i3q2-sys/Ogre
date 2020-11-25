include .env
export $(shell sed 's/=.*//' .env)

parse-vars:
	cd scripts && chmod 700 parse_params.sh && ./parse_params.sh

terraform-init:    #initialize terraform, only necessary fist time b4 terraform execution or if changes done in terraform configuration  
	cd terraform && terraform init
terraform-plan: #plan b4 apply
	cd terraform && terraform plan -out plan
terraform-apply:
	cd terraform && terraform apply "plan"
terraform-destroy: #carefull with this command, check if the instances to be destroyed are correct
	cd terraform  && terraform destroy
