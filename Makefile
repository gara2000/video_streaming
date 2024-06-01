terraform-apply:
	@echo "----------Terraform: Building the infrastructure--------------"
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
	@echo "----------Terraform: Destroying the infrastructure------------"
	{ \
		cd terraform ; \
		terraform destroy -auto-approve ; \
	}

ansible-lint:
	@echo "----------Ansible: install required roles --------------------"
	{ \
		cd ansible ; \
		ansible-lint ; \
	}

ansible-install:
	@echo "----------Ansible: install required roles --------------------"
	{ \
		cd ansible ; \
		ansible-galaxy install -r requirements.yml --force ; \
	}

ansible-frontend:
	@echo "----------Ansible: Configure Frontend server--------------------"
	{ \
		cd ansible ; \
		ansible-playbook frontend.yml ; \
	}

ansible-ping:
	@echo "----------Ansible: Configure Frontend server--------------------"
	{ \
		cd ansible ; \
		ansible-playbook test_ping.yml ; \
	}

ansible-all: ansible-lint ansible-install ansible-frontend