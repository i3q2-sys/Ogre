# Ogre: Deploy multiple TOR bridges in the AWS cloud instantly

![alt text](https://github.com/i3q2-sys/PTN/blob/main/Salvavidas/image/ogre.png)


## But, exactly, what is Ogre?

Well, Ogre is an open source TOR project that creates a bunch of bridges in the AWS cloud almost instantly thanks to Terraform and Ansible :+1:

Bridges are very useful if TOR is blocked in your country. They are an alternative entry point to the TOR network much harder to detect than the usual entry nodes, but you don’t know if a Government or an interested third party has created them to monitorize TOR users activity.

With Ogre you avoid this by creating your *own* self hosted TOR bridges instantly! Just resolve a bunch of instances and you are good to go!

## Dependencies

- [A free AWS account](https://aws.amazon.com/es/premiumsupport/knowledge-center/create-and-activate-aws-account/)
- [Terraform 0.13 installed](https://github.com/hashicorp/terraform/tree/v0.13.5) 
- [Ansible 2.9 installed](https://docs.ansible.com/ansible/latest/roadmap/ROADMAP_2_9.html)

## Usage
Firstly, you have to generate the .env file. In order to do that you have execute:
`cp example.env .env`

The only file that the user has to modify is the newly created `.env`, which looks like this:

```
AWS_ACCESS_KEY=
AWS_SECRET_ACCESS_KEY=
TF_VAR_COUNT=1
TF_VAR_ORPORT=9999                  #this cannot be a well known port
TF_VAR_OBFS4PORT=443                #this can be a well known port
TF_VAR_MACHINE_TYPE=t2.micro        #the t2.micro is the free tier machine type
TF_VAR_AWS_ZONE=eu-west-2           #region where you want to create them
BANDWIDTH= 50                       #in KBytes, minimum is 50 KB
TF_VAR_KEY_NAME=                    #here you hace to put the .pem key (without the .pem) for the SSH connection
ANSIBLE_HOST_KEY_CHECKING=False     #do not touch
```

Get the AWS access keys:

**account name** > **My Security Credentials** > **Access keys (access key ID and secret access key)** > **Create Access Key**. And either download the file (rootkey.csv) or show the keys in order to copy them to the environment variables AWS_ACCESS_KEY, AWS_SECRET_ACCESS_KEY in the .env file.

Get the SSH .pem key:



Then simply go to the directory of the repository and type:

```
make init 
make prepare-infra 
make apply-infra 
```

That's it! Now you have your own tor bridges!

Now just install the [TOR browser](https://www.torproject.org/download/)
Go to options > 

