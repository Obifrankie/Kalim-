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

Here are some key take aways I like to point out before continuing with the process I took to achieve this deployment 

- The javascript package.json file is missing the build section which tells node how to properly build the package without this section, node does not properly build the package and I did not add this section myself because for one I don't know if this was by design, by choice or by ommission.

- The code base did not come with a .jar file, I dont also now if this was done purposely or by ommision but I had to build the code base myself using the ./mvnw clean verify command. This would have been an issue for me if i did not have a system that had a java environment but I was lucky enough to have a java environment.


So to achieve my desired solution I had two major options that suits the deployment use case 

- Use an EKS cluster on AWS (Or any managed kubernetes offering on other major cloud providers)

- Or use a EC2 instances with Auto-Scaling and load balancing 

I want for the second option which is use a EC2 instances with Auto-Scaling and load balancing for two major reasons

- For simplicity sake, I prefer to keep things as easy possible and avoid over-complicating things when they should not be

- Cost since this is just a test deployment. I dont want to inquire the costs that is involved in creating a Kubernetes Cluster 


SAMPLE DEPLOYMENT

The following are resources created to achieve my proposed deployment 

- 2 EC2
- 2 load balancers
- 1 internet gateway
- 2 security groups 
- 2 subnets 
- 2 auto-saling groups 


Initially I used a nategateway for the backend instances to prevent it from assesing the public internet, my plan was to route all traffic to it through the Frontend instance but again to make things straight forward I made the Backend Instance public since security was not started as one of my criterias and I can easily route traffic through the public instance on my next iteration of the project.


To create the Infrastructure using the pipeline you would have to manually trigger the pipeline I decided that this pipeline should run on a manual trigger instead of automatically because I feel this suits this pipeline better. The infrastructure folder contains all the terraform files needed for the project. The create-infra.yml pipeline monitors this folder  