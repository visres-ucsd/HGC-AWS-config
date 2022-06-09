## Overview
For getting data onto an S3 bucket, you can set up a managed SFTP server through AWS.

Here is an [AWS Blog on this topic with more details](https://aws.amazon.com/blogs/aws/new-aws-transfer-for-sftp-fully-managed-sftp-service-for-amazon-s3/), but in general the process goes as follows:
1. Create S3 bucket
2. Create SFTP server through AWS Transfer Family
    - You will need to create an S3 access policy to the bucket and role for this.
3. Use SFTP to transfer data to S3.

Pricing:
- \$.30/hr of server uptime
- \$0.04 per GB of transfer (upload/download)
