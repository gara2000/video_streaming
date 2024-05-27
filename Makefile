terraform-apply:
	@echo "----------terraform: Building the infrastructure--------------"
	{ \
		cd terraform ; \
		terraform init ; \
		terraform apply -var-file common.tfvars -var-file frontend.tfvars -var-file streamer.tfvars -auto-approve ; \
	}

terraform-destroy:
	@echo "----------terraform: Destroying the infrastructure------------"
	{ \
		cd terraform ; \
		terraform destroy -auto-approve ; \
	}