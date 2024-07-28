Instructions can be found [here](INSTRUCTIONS.md)

*Please update this file with your summary/instructions*

# Implementation 

I did use google a bit to help me figure this out. I am a bit rusty with node and HTML, but I managed to figure it out. The goal was to get this running in one of the cloud providers. 

## Backend Locally 

I started with the backend. I wanted to make sure that I could run this locally first by doing an `npm install` initially. When I ran that I got the following error `echo "Error: no test specified" && exit 1` in the terminal. Sure I was only supposed to deploy this, but considering the fact that I'd probably not pass the take home, I went into package.json and looked at the `scripts` section in the code. 
```
   "scripts": {
    "test": "echo \"Error: no test specified\" && exit 1"
  },
```

Based on this I knew that the application would not run so I went ahead and replace that with the following: 
```
  "scripts": {
    "start" : "node index.js",
    "test": "echo \"Error: no test specified\" && exit 1"
  },
```

This being `"start" : "node index.js"` to get the code running. I went to the browser at the localhost:3000/api address and I got: `{"message":"Hello World!"}`. 

Success! 

## Frontend Locally 

Went and opened the file from the frontend folder by right clicking and open with, I chose Safari, and opened the file. 

I got the >Hello from Frontend! message, with `{"message":"Hello World!"}`. To fix this I added in `<div id="apiResult"></div>` then changed: 

``` 
fetch('http://localhost:3000/api') .then(response => response.text()) .then(data => { document.body.innerHTML += <p>${data}</p>; });

``` 

to: 

```
    fetch('http://localhost:3000/api')
      .then(response => response.json())
      .then(data => {
        document.getElementById('apiResult').innerHTML += `<p>${data.message}</p>`;
      });
```

Now I was getting Hello from Frontend with Hello World in a div below that. 


## Running Locally 

Now that I got the two folders working correctly, I added in two dockerfiles in each folder. I then setup a docker-compose.yaml which can be run by doing: `docker-compose up --build`. 

Once this is running you can access the two sites via:

`http://localhost:3000/api`
`http://localhost`

I also added .env files, so when the time comes and deployments need to be done they can be added for the different environments. 

This will have to be added to the `scripts` block in the package.json to start from development, test, prod, etc. Because there was no need for a database for this project I left them blank. 

## Docker Swarm 

To deploy with docker swarm simply build the images locally and or in a repo if you prefer to do this locally: 
`docker build -t my-backend:latest ./backend` 
`docker build -t my-frontend:latest ./frontend`

or to a repo 

`docker tag backend:latest <registry>/backend:latest`
`docker tag backend:latest <registry>/frontend:latest`

then if going to a repo: 

`docker push <registry>/backend:latest`
`docker push <registry>/frontend:latest`


If running locally: 
`docker swarm init` 
`docker stack deploy -c docker-swarm.yml`
to terminate the swarm: 
`docker swarm leave --force` 

## Github Actions, EKS, Terraform

I was setting up github actions to run this in EKS, but I did run out of time. As you can see I had the beginnings of something really neat, but because I couldn't get my auth files working correctly, but I figured that I would show some what of a kubernetes example as well. 

## Thoughts, musings conclusion 

I really liked this project, and I probably spent a lot more time on it than I needed to, but thank you it was a lot of fun! Few things I did think about with this project: 
* Lambda deployment for api could've been another option for the express side of things, but this might need a bit of a rewrite to get that working. 
* Could deploy the frontend in s3. 
* I liked the little tricks and caveats on this
* I probably could've put a database behind this, but I was only supposed to spend an hour 
* I didn't do the `scripts` block with the different ways to start test, prod, dev, etc, I probably could've done that but I didn't, maybe I will futz around with this more 
* I want to get the kubernetes stuff working, so I might just work on this outside of the time that I was alotted. 
