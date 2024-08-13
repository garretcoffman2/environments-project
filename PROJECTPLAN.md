# environments-project

- The basic idea was to create a git repository users can clone and use github workflows to manually deploy and destroy a development, staging, and production environment, each of which contain an EKS kubernetes cluster to be used to run github runners exclusivee to the environment. 
- Name of project = environments-project.
- Comments explaining what each block of code does.
- Tags and variable names that give insight.
- Follow best practices as much as possible.
- Use terraform modules and variable files when possible.
- Creation of all workflows, terraform files, etc. 
- Desired workflows: 
    terraform-state-bucket.yml - Manually run and uses terraform to create s3 bucket for each environment.
    terraform-state-bucket-destroy.yml - Run later manually and uses terraform to destroy s3 bucket for each environment.
    terraform-runner-deploy.yml - Manually run to create the vpc and EKS cluster for each environment, and then configure the cluser to be github runners with a name that is relevent to the environment.
    terraform-runner-destroy.yml - Manually run to destroy the vpc and EKS cluster for each environment.
    terraform-monitoring.yml - Manually run to create and configure a Grafana instance and adds prometheus reporting to the 3 EKS clusters.
    terraform-monitoring-destroy.yml - Manually run to destroy all resources related to the Grafana instance.
    terraform-deploy-all.yml - Manually run to call terraform-state-bucket.yml, terraform-runner-deploy.yml, and terraform-monitoring.yml.
    terraform-destroy-all.yml Manually run to call terraform-runner-destroy.yml, terraform-monitoring-destroy.yml.

