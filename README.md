# Ogre: Deploy multiple TOR bridges in the AWS cloud instantly

![alt text](https://github.com/i3q2-sys/PTN/blob/main/image/ogre.png)


## But, exactly, what is Ogre?

Well, Ogre is an open source TOR project that creates a bunch of bridges in the AWS cloud almost instantly thanks to Terraform and Ansible :+1:

Bridges are very useful if TOR is blocked in your country. They are an alternative entry point to the TOR network much harder to detect than the usual entry nodes, but you don’t know if a Government or an interested third party has created them to monitorize TOR users activity.

With Ogre you avoid this by creating your *own* self hosted TOR bridges instantly! Just resolve a bunch of instances and you are good to go!

## Dependencies

- [A free AWS account](https://aws.amazon.com/es/premiumsupport/knowledge-center/create-and-activate-aws-account/)
- [Docker](https://docs.docker.com/engine/install/ubuntu/) 
- [Docker Compose](https://docs.docker.com/compose/install/)

## Usage
Firstly, you have to generate the .env file. In order to do that you have execute:
`cp example.env .env`

The only file that the user has to modify is the newly created `.env`, which looks like this:

```
AWS_ACCESS_KEY=
AWS_SECRET_ACCESS_KEY=
TF_VAR_COUNT=1                      #number of bridges you want to deploy
TF_VAR_ORPORT=9999                  #this cannot be a well known port
TF_VAR_OBFS4PORT=443                #this can be a well known port
TF_VAR_MACHINE_TYPE=t2.micro        #the t2.micro is the free tier machine type
TF_VAR_AWS_ZONE=eu-west-2           #region where you want to create them
BANDWIDTH= 50                       #in KBytes, minimum is 50 KB
TF_VAR_KEY_NAME=                    #here you have to put the .pem key (without the .pem) for the SSH connection
ANSIBLE_HOST_KEY_CHECKING=False     #do not touch
```

> Get the AWS access keys:

**account name** > **My Security Credentials** > **Access keys (access key ID and secret access key)** > **Create Access Key**. And either download the file (rootkey.csv) or show the keys in order to copy them to the environment variables AWS_ACCESS_KEY, AWS_SECRET_ACCESS_KEY in the .env file.


> Get the SSH .pem key:

Write EC2 in the search bar > **Network & Security** > **Key Pairs** > **create key pair**, download it (.pem) and put it into the Terraform folder.


Then type:

```
make init 
make prepare-infra 
make apply-infra 
```

That's it! Now you have your own tor bridges!

If you want to destroy the created infrastructure just type <br>
`make destroy-infra`

Now just install the [TOR browser](https://www.torproject.org/download/)<br>
Go to options > Tor > Bridges and check Use a bridge and Provide a Bridge, where you have to enter the following:<br>

`Bridge obfs4 <IP ADDRESS>:<PORT> <FINGERPRINT> cert=<CERTIFICATE> iat-mode=0`

Where:
- **IP ADDRESS** is the bridge IP (returned to you by Terraform)
- **PORT** is the ORPORT you have configured in the .env
- **FINGERPRINT** (returned to you by Ansible)
- **CERTIFICATE** (returned to you by Ansible)

To get all the necessary info go to the useful_files directory.

- In the fingerprint_bridge_<IP_v4> you have the Fingerprint (not OgreMinion)
- In the nline_bridge_<IP_v4> you have the line you have to put into the tor browser with the cert already attached
- The IPv4 is in the name of the files

![alt text](https://github.com/i3q2-sys/PTN/blob/main/image/tor_3.png)



