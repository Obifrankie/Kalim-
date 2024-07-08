# PLEASE READ THROUGH THE WHOLEPAGE BEFORE YOU START DEPLOYING THE SOLUTION

#### PLEASE NOTE AS A FIRST STEP I ADVISE THAT YOU FIRST UPDATE YOU DESIRED VALUES IN THE BACKEND.TF THIS IS SO TERRAFORM CAN USE A REMOTE BACKEND FOR THE FILE. THE VALUES THAT WOULD BE PROVIDED ARE SENSITIVE VALUES SO I WILL OT HARD CODE IT IN THE SCRIPT.


 PLEASE MAKE SURE YOU HAVE PROPERLY CONFIGURED BACKEND.TF WITH YOUR DESIRED VALUES TO GET TO BACKEND.TF CLICK ON THE INFRASTRUCTURE FOLDER THEN YOU WOULD SEE BACKEND.TF THEN UPDATE IT WITH YOUR DESIRED CONFIGURATIONS.

#### AGAIN TO GET TO BACKEND.TF THIS IS THE FOLDER STRUCTURE
Aws-infra --> BACKEND.TF

AFTER UPDATING BACKEND.TF PLEASE CONTINUE WITH THE REST OF THE STEPS IN THE README


NOTE STEPS TO DEPLOY THE APPLICATION WILL EXPLAIN FURTHER BELOW

- Update backend.tf with you desired parameters
- In Backend.tf specify the values for the following ;

   bucket this is the name of the s3 bucket where terraform should store the remote backend 

   key this is the name you want to give the state file. The standard name is terraform.tfstate i suggest you use it as well

   region this is the default region you want your resources to deploy to

   profile this is the default profile terraform should use to create your services in aws

- Create the AWS_ACCESS_KEY_ID secret
- Create the AWS_SECRET_ACCESS_KEY secret 
- Create the DOCKER_PASSWORD secret 
- Create the DOCKER_USERNAME secret 
- Create the EC2_USERNAME secret (by default this is ubuntu)
- Create the TAG secret (you can use latest as a default value) 
- DEPLOY Aws-infra 
- COPY THE IP address of the frontend and and use it to create the FRONTEND_EC2_HOST secret 
- COPY THE IP address of the backend and and use it to create the BACKEND_EC2_HOST secret 
- COPY the whole content of the generated-key.pem file and go and use it to create the EC2_PRIVATE_KEY secret
- DEPLOY THE BACKEND 
- DEPLOY THE FRONTEND

To achieve the current deployment, I had two major user story to fulfil 

- create a CI/CD pipeline for the docker containers.
- create a pipeline for my terraform scripts.

For the CI/CD pipeline for the docker containers I was provided with some constraints and criteria to try and achieve with the code deployment 

- To seperate frontend from backend 
- To make deployment possible across different environments

For the pipeline for my terraform scripts I was also provided with some constraints and criteria to try and achieve with the deployment 

- To use IaC
- To allow for multiple personal accounts 
- To allow the application scale automatically 

P.S. you would need to create secret calues in your github secrets


![Secret Values](screenshots/image1.png)

- AWS_ACCESS_KEY_ID this is the access key for an AWS user. the pipeline will need it to create the resources on AWS

- AWS_SECRET_ACCESS_KEY this is the secret access key for an AWS user. the pipeline will need it to create the resources on AWS

- BACKEND_EC2_HOST this is the IP address of the backend instance 

- DOCKER_PASSWORD this is the password for a chosen docker hub where the pipeline would push and pull the docker images to/fom

- DOCKER_USERNAME this is the username for the chosen docker hub where the pipeline would push and pull the docker images to/fom

- EC2_PRIVATE_KEY this is the key the pipeline would use to SSH into the instances and deploy the images. This key is being created by the terraform script you just need to copy the private key from the file it creates and use it to create the secret. The name of key file that terraform would create would be generated-key.pem. That is the name I specified in the script for terraform to name it 

- EC2_USERNAME this is the username the pipeline would use to ssh into your instances if you are using my deafilt script without making any changes to it. The EC2_USERNAME is going to be ubuntu

- FRONTEND_EC2_HOST this is the IP address of the frontend instance 

- TAG this is the value that the pipeline would use to tag your images 

Here are some key take aways I like to point out before continuing with the process I took to achieve this deployment 

- The javascript package.json file is missing the build section which tells node how to properly build the package without this section, node does not properly build the package and I did not add this section myself because for one I don't know if this was by design, by choice or by ommission.

- The code base did not come with a .jar file, I dont also now if this was done purposely or by ommision but I had to build the code base myself using the ./mvnw clean verify command. This would have been an issue for me if i did not have a system that had a java environment but I was lucky enough to have a java environment.


So to achieve my desired solution I had two major options that suits the deployment use case 

- Use an EKS cluster on AWS (Or any managed kubernetes offering on other major cloud providers)

- Or use a EC2 instances with Auto-Scaling and load balancing 

I want for the second option which is use a EC2 instances with Auto-Scaling and load balancing for two major reasons

- For simplicity sake, I prefer to keep things as easy possible and avoid over-complicating things when they should not be

- Cost since this is just a test deployment. I dont want to inquire the costs that is involved in creating a Kubernetes Cluster 

## ORDER TO DEPLOY APPLICATION

- First you wuould have to manually trigger the Aws-infra deployment. I would explain this further in the INFRASTRUCTURE section below.

- DEPLOY BACKEND APPLICATION 

- DEPLOY FRONT END APPLICATION 


STEPS TO DEPLOY THE APPLICATION
- Create the AWS_ACCESS_KEY_ID secret
- Create the AWS_SECRET_ACCESS_KEY secret 
- Create the DOCKER_PASSWORD secret 
- Create the DOCKER_USERNAME secret 
- Create the EC2_USERNAME secret (by default this is ubuntu)
- Create the TAG secret (you can use latest as a default value) 
- DEPLOY INFRASTRUCTURE 
- COPY THE IP address of the frontend and and use it to create the FRONTEND_EC2_HOST secret 
- COPY THE IP address of the backend and and use it to create the BACKEND_EC2_HOST secret 
- COPY the whole content of the generated-key.pem file and go and use it to create the EC2_PRIVATE_KEY secret
- DEPLOY THE BACKEND 
- DEPLOY THE FRONTEND


## CREATE INFRASTRUCTURE

To build the infrastructure I used terraform as my preffered IaC tool. I split the terraform scripts into different .tf files for it to be easily readable 
- compute.tf contains the script for building compute realted resources 
- network.tf contains the script for building network realted resources
- backend.tf contains the script to setup the remote backend resources
- main.tf is used to specify required providers
- variable.tf contains the script for my variables

All the terraform script is in a folder called INFRASTRUCTURE. So to build or modify the architecture please goto the INFRASTRUCTURE folder in the repo

The following are resources created to achieve my proposed deployment 

- 2 EC2
- 2 load balancers
- 1 internet gateway
- 2 security groups 
- 2 subnets 
- 2 auto-saling groups 


Initially I used a nategateway for the backend instances to prevent it from assesing the public internet, my plan was to route all traffic to it through the Frontend instance but again to make things straight forward I made the Backend Instance public since security was not started as one of my criterias and I can easily route traffic through the public instance on my next iteration of the project.


To create the Infrastructure using the pipeline you would have to manually trigger the pipeline I decided that this pipeline should run on a manual trigger instead of automatically because I feel this suits this pipeline better. The option to run this pipeline automatically is also there but I have commented it out, we can uncomment it any time we want. All the terraform code for the Infrastructure is in the folder called INFRASTRUCTURE.

- To run the terraform pipeline simply click on the .github/workflow folder 
- Click on create-infra.yml
- At the top you would see a VIEW RUNS button 
- Click the view runs button 
- This would take you to tha actions tab
- Click Run workflow

Again making the pipeline for the terraform to be manually trigger was a choice I made if you want it to be triggered automatically do the following steps

-  To run the terraform pipeline simply click on the .github/workflow folder
- Click the edit button 
- Remove the comments on push -> branches -> main 
- Then comment workflow_dispatch 

The steps above would chabe the pipeline from a manual trigger to automatically trigger if any changes happen in the INFRASTRUCTURE folder which is where all the terraform scripts are kept.



## NEXT STEPS AFTER CREATING INFRASTRUCTURE 

After you have created the infrastructure using the steps above.
- COPY THE IP address of the frontend and and use it to create the FRONTEND_EC2_HOST secret 

- COPY THE IP address of the backend and and use it to create the BACKEND_EC2_HOST secret 

- COPY the whole content of the generated-key.pem file and go and use it to create the EC2_PRIVATE_KEY secret


## BACKEND

To build the backend I created a Dockerfile in the BACKEND folder to handle the Dockerfile to build the backend images. This is done to make things more organizable.

Then I created a pipeline called backend.yml to automatically build and deploy the backend images to the EC2 instances 

To build the backend, you would have to commit any new changes to the BACKEND folder in the repo and this would automatically triger the build and release for the backend images 

- I created a simple readme file in BACKEND folder in the repo so you can commit any changes to this readme.md file in the BACKEND folder and this would automatically trigger the pipeline 

- You can as well make any changes to the Dockerfile in the BACKEND folder in the repo and this would also trigger the pipeline to build the docker image, deploy to dockerhub, pull it from docker hub and deploy it to the backend instance.


## FRONTEND

To build the frontend images I created a Dockerfile but in order to differentiate frontend from backed I created a fRONTEND folder to handle the Dockerfile to build the frontend images. This is done to make things more organizable.

Then I created a pipeline called frontend.yml to automatically build and deploy the frontend images to the EC2 instances 

To build the frontend, you would have to commit any new changes to the FRONTEND folder in the repo and this would automatically triger the build and release for the frontend images 

- I created a simple readme file in FRONTEND folder in the repo so you can commit any changes to this readme.md file in the FRONTEND folder and this would automatically trigger the pipeline 

- You can as well make any changes to the Dockerfile in the FRONTEND folder in the repo and this would also trigger the pipeline to build the docker image deploy, to dockerhub pull it from docker hub and deploy it to the frontend instance.

P.S. Note that the frontend image is not properly build because I commented out the line that build the code in the Dockerfile this is because as I pointed out earlier the package.json is missing the build specification so the code cannot properly build. Whne the package.json is updated with the correct build specification please go to the Dockerfile in the frontend folder and remove the comment on RUN npm run build and # COPY --from=build /app/build /usr/share/nginx/html. After doing this commit the code to github this would automatically trigger the pipeline and build and release the code to the instance.


## DESTROY INFRASTRUCTURE

To destroy the whole infrastructure just manually trigger the destroy0infra.yml pipeline

- Click on .github/workflow
- Click on destroy-infra.yml
- Click view all runs
- Click Run worklow
- This would automatically destroy all the infrastructure 







## MONITORING

To monitor the instances I wrote an ansiblee playbook to setup cloudwatch on the instances but since I need to copy ssh keys to the instance for ansible to be able to ssh to the instance I will not implement the ansible steps fully because it involves some manual processes and I am more focused on automation with this project. 

I can fully optimize the ansible playbook in one more iteration.

The Ansible playbook can be found in the Ansible folder
