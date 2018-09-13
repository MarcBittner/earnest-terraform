# splunk_ring
Before running:
- Obtain DATA AWS access and secret key
- Generate AWS instance ssh key, and put it in ~/.ssh/splunk.pem
- Update variables in variables.tf
- Update Splunk secret key id necessary in bash_scripts/base.sh:3
- Obtain Splunk license and place in bash_scripts; rename the key to be Splunk.License.lic

First Run and selecting workspace
- terraform init 
- terraform workspace select [WORKSPACE_NAME]

Currently supported workspaces:
- default (production)
- security (dev)

Run:
- terraform plan (to verify all is resolved and looks good)
- terraform apply (to build)

Verification:
- Login to Cluster master at splunk-master.ring.local:8000 and verify all indexers are checking in
- Login to deployment server at splunk-deployment.ring.local:8000 and verify the SHs, HFWDs, Master are checking in and have apps deployed

Follow-up tasks:
- Change all default password
- Setup Monitoring console
- Distribute base config bundle from the master

To Add New Workspace:
 - terraform workspace new {WORKSPACE_NAME}
 - update variables.tf and update any mapping 
 - run terraform plan and verify everything is working

 States Management:
 - All states are managed in one location (currently the data aws account)
 - Each workspaces will its own state located in the s3 bucket in a seperate directory
 - With state locks, only one user can be making a change at a time
