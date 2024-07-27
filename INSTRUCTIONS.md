# Pagos - DevOps Take-home assignment

## Objective

We’d like to give you an opportunity to show your DevOps abilities in a small exercise. This assignment should be relatively simple; please don't spend more than one or two hours on it (scope it down if needed). The goal of this exercise is to deploy a simple frontend and backend application using any method or tools of your choice. Keep in mind, you’ll need to extend your solution during future interview sessions.

Please ask any questions you need to clarify the expectations of the submission.

We look forward to seeing your approach and implementation.


## Provided resources

- A simple static frontend application (HTML), located [here](/frontend/)
- A simple backend application using Node.js (JS), located [here](/backend/)


## Task

1. Setup and Deployment
    - Deploy both the provided frontend and backend applications.
    - For the backend project there are a couple environment variables to provide (they can be found [here](/backend/.env.example)). The values of them do not matter, but keep in mind that we consider `DB_USERNAME` and `DB_PASSWORD` to be sensitive.
    - Use any container orchestration tool (e.g., Kubernetes, Docker Swarm), or deployment method of your choice. It is ok to run this completely locally. **Please do not spend any money on this assignment.**
2. Configuration
    - Ensure the frontend can communicate with the backend.
    - Include any necessary configuration files (e.g., Dockerfile, Kubernetes manifests, CI/CD pipeline definitions, Terraform code).
3. Documentation
    - Provide a README file with instructions on:
      - Short summary of your approach
      - Steps to reproduce the deployment (keep in mind that we should easily be able to reproduce your work)
      - How to access the deployed applications.
      - Any assumptions or decisions made during the process.


## Goal

By following these instructions, you should be able to demonstrate your skills in deploying and managing a frontend and backend application. With this in mind, it is ok to modify the frontend and backend application if you feel that it is needed to demonstrate your skills. The samples above are there for guidence only. 


### Evaluation criterias
   - **Completeness:** The frontend and backend applications are successfully deployed and can communicate with each other.
   - **Clarity:** Clear and concise documentation on the deployment process.
   - **Best Practices:** Usage of best practices in deployment, security, and configuration management.
  

## How to submit

ZIP the project directory with your changes and attach it in the provided submission form. 


## Useful resources

https://www.heroku.com/

https://vercel.com/

https://aws.amazon.com/free/

https://github.com/features/actions

https://minikube.sigs.k8s.io/

https://github.com/hashicorp/terraform


