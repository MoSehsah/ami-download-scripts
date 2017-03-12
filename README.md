# AMI to VM Conversion & Download Scripts

This project is to convert AWS AMI to VMware VM and Save it to S3 and then download.


### Installing

* Create a new directory to work inside through the whole tutorial.

* Install Python

* Install Pip

```
curl https://bootstrap.pypa.io/get-pip.py -O
sudo -H python get-pip.py
```
* Install AWS CLI & AWS Shell

```
sudo -H pip install awscli --upgrade --ignore-installed six
sudo -H pip install aws-shell --upgrade --ignore-installed six
```

* Install jmespath

```
brew tap jmespath/jmespath
brew install jp
```
if you aren't using Mac then download from here [JP Releases](https://github.com/jmespath/jp/releases)

* Configure AWS CLI
  * Go to this page [AWS IAM Users](https://console.aws.amazon.com/iam/home#/users)
  * Click on your user from the list
  * Go to "Security Credentials" tab
  * Click the Button "Create New Access Key"
  * Copy "Access key ID" and "Secret access key"
  * Run the Command below and enter your "Access key ID" and "Secret access key" and "eu-west-1" for the default region name and leave the default output format.

  ```
  aws configure
  ```
  * Make sure that everything went well by running the command below
  ```
  aws ec2 describe-instances
  ```

  * Create a new keypair using the below command
  ```
  aws ec2 create-key-pair --key-name MyKeyPair --query 'KeyMaterial' --> MyKeyPair.pem
  ```

* Create S3 Bucket
  * Create a bucket in [Amazon S3 Console](https://console.aws.amazon.com/s3/)
  * Give it a name and keep it
  * Select the same region that has your instance
  * Choose Create. When the bucket is created, the details pane opens with the Permissions section expanded.
  * Choose Add More Permissions.
  * For Grantee, type vm-import-export@amazon.com.
  * Select Upload/Delete and View Permissions.
  * Save

* run the script
```
./runExportInstance.sh
```


## Authors

* **Sehsah** - *Initial work* -
