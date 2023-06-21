#Shortcut creator


virginia:
	terraform init && terraform apply -var-file regions/virginia.vars   -auto-approve

virginia-destroy:
	terraform init && terraform destroy -var-file regions/virginia.vars   -auto-approve


london:
	terraform init && terraform apply -var-file regions/london.vars   -auto-approve

london-destroy:
	terraform init && terraform destroy -var-file regions/london.vars   -auto-approve


ohio:
	terraform init && terraform apply -var-file regions/ohio.vars   -auto-approve

ohio-destroy:
	terraform init && terraform destroy -var-file regions/ohio.vars   -auto-approve


oregon:
	terraform init && terraform apply -var-file regions/oregon.vars   -auto-approve

oregon-destroy:
	terraform init && terraform destroy -var-file regions/oregon.vars   -auto-approve


all:
	make virginia && make ohio && make oregon && make london

destroy-all:
	make virginia-destroy && make ohio-destroy && make oregon-destroy && make london-destroy