//
// Enter the "name" tag prefix you want for this Instance
//
Name_Tag = "CICD"
//
// Set the address range you want.
// Each requested subnet will get an equal amount of space within this
// address range so be sure to your request will allow all for that.
//
CIDR_Required = "10.0.0.0/16"
//
// Enter the IP address of the github enterprise server followed by '/32'
//
GHE_CIDR = "44.228.201.109/32"
//
// Enter the numbr of public and private subnets
// Each will be created in a each different availability zone.
// If you specify more subnets than the available number of availability 
// zones it will automaticaly reduce the number of networks to match the 
// number of availability zones.
//
num_Public_Subnets = 2
num_Private_Subnets = 2

//
// Enter the keypair you want to use for the bastion servers
//
Keypair = "CircleCI.testing"
//
// Enter your AWS CLI profile to use for this build
//
AWS_Profile = "cx_eng"
