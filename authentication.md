# Project Az (Python-based Azure CLI) Samples - Authentication

# Logging in and out
> Note, we do not currently support government or private clouds, such as Azure Stack.  Don't worry, we're working on it
  
Log in with username and password 
```
az login -u alice@bobco.com -p Password123
```

Log in with username, prompt for password
```
az login -u alice@bobco.com
Password: ********
```

Log in with device authentication.  After you enter the code and click **confirm** 
on the web page, the CLI will automatically exit back to the prompt 
```
az login
To sign in, use a web browser to open the page https://aka.ms/devicelogin. Enter the code BG3NVHPMB to authenticate.
```

Log in with a service principal
```
az login --service-principal -u http://sample-cli-login -p Test1234 --tenant 54826b22-38d6-4fb2-bad9-b7b93a3e9c5a
```

To logout
```
az logout
```

# Creating a new service principal
If you want to execute a script as part of a workflow, such as a `cron` job, 
you will need to create a service principal identity.  Once you have created
your new identity, make sure you follow the instructions returned to give it 
access to your subscription.
```
az account create-sp
```

# Managing subscriptions
> Note, we do not currently support government or private clouds, such as Azure Stack.  Don't worry, we're working on it

List all your subscriptions
```
az account list
```

View current default subscription
```
az account list --query [?isDefault]
```

Set your default subscription
```
$ az account set 'MySub'
$ az account set 'dec3cbaa-81bb-4ea0-zzzz-e27a20ef4089'
```

To remove all access credentials
```
az account clear
```
