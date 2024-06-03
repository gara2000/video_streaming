terraform-apply:
	@echo "----------Terraform: Building the infrastructure--------------"
	{ \
		cd terraform ; \
		terraform init ; \
		terraform apply -var-file tfvars/common.tfvars \
						-var-file tfvars/frontend.tfvars \
						-var-file tfvars/streamer.tfvars \
						-var-file tfvars/bastion.tfvars \
						-var-file tfvars/ansible.tfvars \
						-auto-approve ; \
	}

terraform-destroy:
	@echo "----------Terraform: Destroying the infrastructure------------"
	{ \
		cd terraform ; \
		terraform destroy -var-file tfvars/common.tfvars \
						-var-file tfvars/frontend.tfvars \
						-var-file tfvars/streamer.tfvars \
						-var-file tfvars/bastion.tfvars \
						-var-file tfvars/ansible.tfvars \
						-auto-approve ; \
	}

terraform-reapply: terraform-destroy terraform-apply

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

ansible-streamer:
	@echo "----------Ansible: Configure Frontend server--------------------"
	{ \
		cd ansible ; \
		ansible-playbook streamer.yml ; \
	}

ansible-nat:
	@echo "----------Ansible: Configure Frontend server--------------------"
	{ \
		cd ansible ; \
		ansible-playbook setup_nat.yml ; \
	}

ansible-ping:
	@echo "----------Ansible: Configure Frontend server--------------------"
	{ \
		cd ansible ; \
		ansible-playbook tests\test_ping.yml ; \
	}

ansible-config: ansible-install ansible-nat ansible-frontend ansible-streamer

ansible-test: ansible-lint ansible-ping

ansible-all: ansible-lint ansible-install ansible-frontend

reconstruct: terraform-reapply ansible-config