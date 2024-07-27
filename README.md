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

## Github Actions 

I wanted to deploy this in AWS because that is what I am most familiar with. 
