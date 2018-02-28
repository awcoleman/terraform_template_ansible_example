#=============================================

Example for AWS VPC with private subnet and NAT instance as bastion host.

Useful for testing software in isolation.

Entire project: awcoleman 2018. Apache License Version 2.0.

#=============================================

Use:

#Set IAM key creds as env vars
export AWS_ACCESS_KEY_ID='MY_ACCESS_KEY_HERE'
 export AWS_SECRET_ACCESS_KEY='MY_SECRET_HERE'

#Put your own variables in terraform.tfvars
#You MUST add an RSA key, such as
cat > terraform.tfvars << "EOF"
key_path = "~/.ssh/rsa-ansible-20180209.priv"
key_pub_path = "~/.ssh/rsa-ansible-20180209.pub"
key_name = "awc_rsa-ansible-20180209"
EOF

terraform init   #download provider plugins needed

terrform plan

terraform apply

#Apply creates for ansible these files: flat_inventory setupvariables.yml

ansible-playbook -i flat_inventory provision.yml

#Can check the ansible work manually with:
ssh -J $(cat ssh_proxyjump) $(cat ssh_server01)


#When done, cleanup with:
terraform destroy

#=============================================
