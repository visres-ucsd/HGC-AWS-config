## Overview
This document describes the steps necessary to creating a GPU-enabled EC2 instance with S3 access.

1. Create IAM Policy and Role for S3 access
2. Create Instance
3. (Optional) Create template from previous instance

## 1. Create IAM Policy and Role for S3 access
The AWS documentation for performing this can be found at https://aws.amazon.com/premiumsupport/knowledge-center/ec2-instance-access-s3-bucket/.

Once the instance is ready, you can verify that this role was successfully applied by entering the command `aws configure list`. If the results are all `<not set>` or `None`, then the role was not applied.

## 2. Create Instance
When creating the EC2 instance, select these options:
- **AMI:** Amazon Linux 2 DLAMI GPU Tensorflow 2.7.0
- **Instance Type:** p2.xlarge or p3.2xlarge
- **Key Pair:** Create new key pair or use existing one.
- **Security Group:** [If using Jupyter](https://dataschool.com/data-modeling-101/running-jupyter-notebook-on-an-ec2-server/). Avoid using `0.0.0.0` if possible.
- **Configure Storage:** 60 GB (or more depending on workload. Wasn't able to rescale without terminating and restarting so safer to go with more)
- **Advanced details > IAM instance profile:** Select role created in Step 1. Needed to be able to access S3.

## 3. (Optional) Create template from previous instance
Creating a template streamlines the instance launch process.

- Go to EC2 > Launch templates > Create launch template
- Follow steps for creating template from previous. Match options from Step 2.
- **NOTE:** If you update the launch template, be sure to set the new version as the default version. AWS does not automatically default to the most recent version and will prefer whichever version was already the default.
