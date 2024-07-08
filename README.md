# PLEASE READ THROUGH THE WHOLEPAGE BEFORE YOU START DEPLOYING THE SOLUTION

#### PLEASE NOTE AS A FIRST STEP I ADVISE THAT YOU FIRST UPDATE YOU DESIRED VALUES IN THE BACKEND.TF THIS IS SO TERRAFORM CAN USE A REMOTE BACKEND FOR THE FILE. THE VALUES THAT WOULD BE PROVIDED ARE SENSITIVE VALUES SO I WILL NOT HARD CODE IT IN THE SCRIPT.


 PLEASE MAKE SURE YOU HAVE PROPERLY CONFIGURED BACKEND.TF in the Azure-infra directory WITH YOUR DESIRED VALUES.
 TO GET TO BACKEND.TF for the Azure-infra CLICK ON THE Azure-infra FOLDER THEN YOU WOULD SEE BACKEND.TF THEN UPDATE IT WITH YOUR DESIRED CONFIGURATIONS.

#### AGAIN TO GET TO BACKEND.TF THIS IS THE FOLDER STRUCTURE
Azure-infra --> BACKEND.TF

AFTER UPDATING Azure-infra/BACKEND.TF PLEASE CONTINUE WITH THE REST OF THE STEPS IN THE README

### NOTE STEPS TO DEPLOY THE APPLICATION WILL EXPLAIN FURTHER BELOW

 #### Update Azure-infra/backend.tf with you desired parameters
- **resource_group_name** this is the name of the resorces group you want to store your terraform state file. It does not have to be the same resources group the project is using (I advice you use a different resource group so the lifecycle of the terraform state with not be the same as the lifecycle of the project)

- **storage_account_name** this is the name you want to give the storage account 

- **container_name** this is the name of the container 

- **key** tis is the name of the terraform state file itself the default name most organization use is *terraform.tfstate*

***If the pipeline is configured properly and set up to authenticate with azure all you need to do is update the values as liste above and it would handle the rest but if you can't setup your pipeline to authenticate which is a proper most free teir accounts face. You would need to create the resource group, storage account, bucket manually on the cloud then use the values from the cloud and update the Azure-infra/backend.tf file***

#### Create private key 
To keep the infrastructue as secure as we can. I am not going to attache my own public key to the repo. It is best we create a new public key when deploying. Below are the steps to create a public key and use it in the code 

- First please pull the repo 
- change in to the Azure/infra directory in the repo 
- run ```ssh-keygen -t rsa -b 4096 -f vm``` i suggest not to change the file name and run the code as is so you wont bother with updating the admin-ssh in scale set resource block

The command ablove would create public and private keys called vm.pub and vm respectfully 

#### Sign into Azure 

We are also going to setup our pipeline to authenticate into Azure but jsut to be allow for flexibility. We are also going to login into Azure in our local environment. We are doing this because for most Azure free tier and student accounts we cannot properly configure a pipeline to authenticate to it, this is because they cannot create service principals on the command line. And this is because this type of accounts don't have proper priviledges to Microsoft Entra ID for their tenants.

So to setup your local environment to authenticate against your tenant.
- run ```az login```
- run ``` az account show``` to confirm the account 


#### Configure a service principal for the pipeline

If you happen to have full access to Microsoft Entra ID we are going to create a service principal. We are doing this so we can get our pipelines to be able to create and destroy infrastructure on our behalf. ***If you dont have full access to Microsoft Entra ID no problem just pull the repo and run the terraform code(terraform init. terraform plan, terraform apply)from your local environment***

Below are the steps to configure the service principal for the pipelines 

- run ```az login```
- run ```az ad sp create-for-rbac --name "myServicePrincipal" --role contributor --scopes /subscriptions/<your-subscription-id> --sdk-auth```

please update the following values in the command above with your own desired values 
***myServicePrincipal*** this is the name you want to give the service principal  
***<your-subscription-id>*** this is the subscription id of the tenant you want to this principal to authenticate against. You can view your subscriptionID bu running ```az account show```. This would produce a json output the tenant ID is the value for the ID key.

- Copy the output of this command and store it we would need it to create our secret values in github

 #### Configure Pipeline Secret Values 
 The Next step is to configure the secret values for the pipeline. This what the pipeline would use to authenticate against docker, github, and azure 

- Navigate to Settings of this current repo -> Secrets and variables -> Actions.
- Click on New repository secret and add the following secrets:
- Create the AZURE_CLIENT_ID secret ***Your Service Principal’s clientId***
- Create the AZURE_CLIENT_SECRET secret ***Your Service Principal’s clientSecret***
- Create the AZURE_SUBSCRIPTION_ID secret ***Your Azure Subscription ID***
- Create the AZURE_TENANT_ID secret ***Your Azure Tenant ID***
- Create the DOCKER_PASSWORD secret ***Your passowrd for your docker hub***
- Create the DOCKER_USERNAME secret ***Your username for docker hub***
- Create the TAG secret ***this is the value you want to use and tag your images you can use latest as a default value**
- Create the BACKEND_LB_PUB_IP secret ***This is the public Ip of the backend load balancer  you can get it from the Azure console***
- Create the FRONTEND_LB_PUB_IP secret ***This is the public Ip of the frontend load balancer  you can get it from the Azure console***
- Create the VM_PRIVATE_KEY secret ***This is the content of the public key in our case the public key is named vm.pub(assuming you left the default values in the Create private key section). Copy the contents of vm.pub and use it to creeate the secret***
- Create the VM_USERNAME secret ***This is the username that we setup for the virtual machines in our case it is adminuser(assuming nothing was changed in the terraform code)***
- Create the FRONTEND_PORT secret ***This is the value of the port that we using to ssh into the server. Please go to Azure then click on the resource group that terraform created and then click on load




