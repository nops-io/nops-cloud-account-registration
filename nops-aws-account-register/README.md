# Nops Account Registration Automation
- Description of each files and folders are as follows

### cloudformation-single-acc-register
- This folder containes cloudformation template for single aws account register to nops
  
### lambda_functions
- This folder containes python code for lambda function which registers aws accounts to nops.

### terraform-multi-acc-register-via-stacksets
- This folder is a terraform module which deploys cloudformation stacksets.
- Cloudformation stacksets deploys the cloudformation template in all accounts defined in OU.

### terraform-single-acc-register
- This folder is a terraform module which is alternative for single aws account registration via cloudformation.
- Clients who wants to manage all resource via terraform can use this module.
