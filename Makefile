#Shortcut creator


virginia:
	terraform init && terraform apply -var-file regions/virginia.vars   -auto-approve

virginia-destroy:
	terraform init && terraform destroy -var-file regions/virginia.vars   -auto-approve