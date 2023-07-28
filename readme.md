# DOCKER

## WHAT IS DOCKER?
Docker, a subset of the Moby project, is a software framework for building, running, and managing containers on servers and the cloud. The term "docker" may refer to either the tools (the commands and a daemon) or to the Dockerfile file format.

It used to be that when you wanted to run a web application, you bought a server, installed Linux, set up a LAMP stack, and ran the app. If your app got popular, you practiced good load balancing by setting up a second server to ensure the application wouldn't crash from too much traffic.

Times have changed, though, and instead of focusing on single servers, the Internet is built upon arrays of inter-dependent and redundant servers in a system commonly called "the cloud". Thanks to innovations like Linux kernel namespaces and cgroups, the concept of a server could be removed from the constraints of hardware and instead became, essentially, a piece of software. These software-based servers are called containers, and they're a hybrid mix of the Linux OS they're running on plus a hyper-localized runtime environment (the contents of the container).

**For a more complete explanation about Docker, you can go to the following website ["About Docker"](https://www.docker.com/)**

## FIRST STEP
### Install Docker Desktop
1. In The First Step Open Your Browser And Go To The Desktop Docker Web Page. After That On The Start Page Of The Website You Will Find A Button Then Download According To Your Operating System. Like The Following Example, I Use The Windows Operating System, So On The Initial Page Of The Website You Will See A Download Button With The Windows Operating System.
<br>
![download_docker](/Screenshot/1%20install%20docker%20desktop.png)
<br>

2. After The Download Is Complete Open And Install Docker Desktop. After The Installer Is Open Click The Ok Button And After That Docker Desktop Will Install Automatically And We Only Need To Wait Until The Install Process Is Complete. After The Installation Is Complete You Will See A Screen Like The Following
- **Installation Start**
<br>
    ![install_docker](/Screenshot/2a%20install.png)
<br>
- **Installation Finish**
<br>
    ![finish_installation_docker](/Screenshot/2b%20finish%20install.png)
<br>
- **Docker Desktop**
  ![docker_desktop](/Screenshot/3b%20docker%20desktop1.png)
  <br>

1. There Are 2 Ways To Make Sure The Docker System Is Running, The First Is After We Open Docker Desktop, Make Sure The Docker Icon Provides Information With The Running Status As Shown In The Image Below With The Icon At The Bottom Right.
<br>
   **The First Way To Check Docker Running And See That Docker Has Been Successfully Installed**
   <br>
   ![icon_docker_running](/Screenshot/3.%20docker%20dekstop.png)
   <br>
    **The Second Way To Check Docker Running And See That Docker Has Been Successfully Installed**
    The second way open your CLI after that type the command `docker --version` , `docker -v` or `docker version` I usually use the `docker version` command because the information displayed is quite complete, apart from giving info about the Docker version, it will also display the client and server versions as shown below.
    <br>
    ![docker--version](/Screenshot/4.%20docker%20version.png)
    ![docker_version](/Screenshot/4b%20docker%20version.png)

## SECOND STEP
### Dockerhub, Create JS File, dockerfile, package.json
#### dockerhub
After You Have Successfully Installed And Run Docker Desktop You Can Download The Image Which Will Be Stored In Your Docker As You Can See Here I Tried To Find The node.js Image. And As You Can See There Is A "Docker Pull Node" Command. If You Write This Command Into Your CLI, Docker Will Download And Save The node.Js Image In Your Docker. But Here We Will Not Save The Existing Image But How To Create A node.js Image
   <br>
   **Docker Hub**
   ![docker_hub](/Screenshot/5.%20dockerhub.png)
   <br>
   
#### Create JS File
The First Step Is To Create A Node.Js Image, I Have A Java Script File That Contains The Following

**Java Script Content**

```javascript
const http = require('http');

const hostname = '0.0.0.0';
const port = 3001;

const server = http.createServer((req, res) => {
    res.statusCode = 200;
    res.setHeader('Content-Type', 'text/plain');
    res.end('Hello World');
});

server.listen(port, hostname, () => {
    console.log(`Server running at http://${hostname}:${port}/`);
});
```

#### Create dockerfile
After You Create javascript You Can Move to Create dockerfile In Your Text Editor, As You Can See Here, I Use Visual Studio Code As A Text Editor. To Create A Dockerfile, You Only Need To Create A New File Named "Dockerfile" With The Following Code.

**Dockerfile Content**
```dockerfile
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
    
```
- FROM node:20-alpine3.17 is that we will create an image node with the latest LTS version. You can see the version of the node image on the dockerhub website.
- WORKDIR /usr/src/app create a directory to hold the application code inside the image, this will be the working directory for your application
- COPY package*.json ./  All Files With Package Prefix Names With json Extensions Into /app or The Directory We Created in WORKDIR. here it only has one file with a name that starts with package but if we have a developer who wants to use to save the image that we have created they will automatically have two files with the start of package namely "package.json" and "package-lock.json" so the meaning of COPY package*.json is to make it easier for other developers so they don't need to change the existing dockerfile
- RUN npm install 
- COPY . . To bundle your app's source code inside the Docker image, use the COPY instruction. Dot (".") means that all packages in the source code and all files will be copied
- EXPOSE 3001 to connect the port on the node we have to do it by EXPOSE (Port on node.js that we created) as you can see I wrote EXPOSE 3001 port 3001 got from the node.js file that we created earlier you can see it in the previous section in the section node. js file
- Define Commands to Run Your Application Using CMD That Defines Your Runtime. Here we will use Node practice.js (because I use my node.js file with the name practice.js, the command I wrote is Node practice, js, you can name the file whatever you want) to Start Your Server

#### Create package.json
create a new file with the name package.json and follow the command as follows

**Package.json Content**
```javascript
{
    "author": "Hilman S",
    "name": "practice_docker_app",
    "version": "1.0.0",
    "description": "Node.js on Docker",
    "scripts":
    {
    "start": "node practice.js"
    }
}
```

You Can Fill In The Package.Json File With A Description Of Your Image Here I Fill In Some Details Such As The Name Of The Creator Of The Image File, Your Image Name, What Version It Is, And A Description Of Your Image And The Most Important Part In package.json Is The "scripts" Section :
```javascript
{
"start": "node practice.js"
}
```
Because This Command Functions To Create An Image Based On Your Javascript File If This Command Is Not Executed Then It Is Likely That Your Image Will Not Work

## THIRD STEP
### Building Image
Now Is The Time For You To Open The CLI Because Now We Will Use The CLI To Create The Image And Make Sure Your Docker Is Running So That There Are No Problems When We Create The Image

#### First Step
Build Your Image Using The Following Command, But Before You Do The Following Command Make Sure You Are In The Directory Containing The Files From Your Dockerfile And Image

``
docker build . -t <your username>/node-web-app
``

As You Can See Here I Will Create An Image With The Name docker_image_practice. After That All We Need Is To Press The Enter Key On The Keyboard And Wait For The Image Build Process To Finish. When It's Finished The Display On Your CLI Will Be Like The Following

![docker_build_image](/Screenshot/6.%20docker%20build.png)

When Finished We Can See The Image That We Created Using The Command

``
docker images
``

You Will See The Image That Has Been Created If It Has Not Appeared You Can Repeat The Steps Above.

![docker_images](/Screenshot/7.%20docker%20images.png)

You Can Also See The Running Image Via The Desktop Docker With The Following Display. You Only Need To Open The Desktop Docker Application And Select The Images Menu On The Left

![docker_images_desktop](/Screenshot/7a.%20docker%20images%20dekstop.png)

#### Second Step

Now We Will Run The Container From The Image So We Can Open It In A Browser. Type The Following Command In Your CLI

``
docker run -p 3001:3001 -d <your username>/node-web-app
``

The Command Above Is To Determine The Port That We Will Access Which Will Be Connected To The Port That We Have Created In The Javascript File Here I Use Port 4001 Which Is Used As The Local Port And 3001 Is The Port Of The Image That Was Created. If Successful You Will See Your CLI Display As Follows.

![docker_run](/Screenshot/8.%20docker%20run%20container.png)

And We Can See Whether Our Container Is Running Or Not Just By Typing The Following Command

``
docker container ls
``

And You Will See the Running Container

![docker_container](/Screenshot/9.%20docker%20container.png)

You Can Also See The Running Container Via The Desktop Docker With The Following Display. You Only Need To Open The Desktop Docker Application And Select The Container Menu On The Left

![docker_container_desktop](/Screenshot/9a.%20docker%20container%20desktop.png)

#### Final Step
And This Is The Last Step To See If The Image That We Have Created Has Been Successfully Created And The Container That Has Successfully Run You Just Need To Open Your Browser And Type localhost:4001 The Meaning Of 4001 Is The Port That We Created When Running The Container And You Will See The Display Of Image That We Created Earlier.

![image_show](/Screenshot/10.%20browser.png)
