# Ogre: Deploy multiple TOR bridges instantly

## But exactly, what is Ogre?

Well, Ogre is an open source TOR project that creates a bunch of bridges in the AWS cloud almost instantly thanks to Terraform and Ansible :+1:

![alt text](PTN/Salvavidas/image/ogre.png)

Bridges are very useful if TOR is blocked in your country. They are an alternative entry point to the TOR network much harder to detect than the usual entry nodes, but you don’t know if a Government or an interested third party has created them to monitorize TOR users activity.

With Ogre you avoid this by creating your *own* self hosted TOR bridges instantly! Just resolve a bunch of instances and you are good to go!

## Dependencies

- [A free AWS account](https://aws.amazon.com/es/premiumsupport/knowledge-center/create-and-activate-aws-account/)
- [Terraform 0.13 installed](https://github.com/hashicorp/terraform/tree/v0.13.5) 
- [Ansible 2.9 installed](https://stackoverflow.com/questions/60523088/how-to-install-ansible-2-9-on-ubuntu-18-04-and-utilize-python3)

## Usage

The only file that the user has to modify is the `.env`, which looks like this:

```
AWS_ACCESS_KEY= 
AWS_SECRET_ACCESS_KEY= 
TF_VAR_COUNT=1 #number of bridges
TF_VAR_ORPORT=443 
TF_VAR_OBFS4PORT=9999
TF_VAR_MACHINE_TYPE=t2.micro #the t2.micro is the free tier machine type
TF_VAR_AWS_ZONE=eu-west-2 #whre do you want to create them
BANDWIDTH= 50 #in KBytes, minimum is 50 KB
```

In order to get the AWS access keys:

**account name** > **My Security Credentials** > **Access keys (access key ID and secret access key)** > **Create Access Key**. And either download the file (rootkey.csv) or show the keys in order to copy them to the environment variables AWS_ACCESS_KEY, AWS_SECRET_ACCESS_KEY in the .env file.

