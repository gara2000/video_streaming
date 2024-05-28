terraform-apply:
	@echo "----------terraform: Building the infrastructure--------------"
	{ \
		cd terraform ; \
		terraform init ; \
		terraform apply -var-file tfvars/common.tfvars \
						-var-file tfvars/frontend.tfvars \
						-var-file tfvars/streamer.tfvars \
						-var-file tfvars/bastion.tfvars \
						-auto-approve ; \
	}

terraform-destroy:
	@echo "----------terraform: Destroying the infrastructure------------"
	{ \
		cd terraform ; \
		terraform destroy -auto-approve ; \
	}