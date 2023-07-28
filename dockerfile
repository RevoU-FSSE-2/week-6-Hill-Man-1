FROM node:20-alpine3.17

# FROM : Image We Want to Build From
# Node : We will Create an Image Node
# 20-alpine3.17 : Version of Node 

WORKDIR /usr/src/app

# Create a Directory to Hold the Application Code Inside the Image

COPY package*.json ./

# COPY : That All Files Will Be Copy
# * : All Files With Package Prefix Names With json Extensions Into /app or The Directory We Created in WORKDIR

RUN npm install

# Installing the Node Package Manager (NPM)


COPY . .

# To bundle your app's source code inside the Docker image

EXPOSE 3001

# to Bind to Port 3001 we have to use EXPOSE

CMD [ "node","practice.js" ]

# Define the Command to Run Your App Using CMD Which Defines Your Runtime. Here We Will Use Node practice.js to Start Your Server






