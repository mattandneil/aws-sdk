<a style="float: right;" href="https://githubsfdeploy.herokuapp.com?owner=mattandneil&amp;repo=aws-sdk&amp;ref=master">
    <img alt="Deploy to Salesforce" src="https://raw.githubusercontent.com/mattandneil/aws-sdk/master/README1.png" width="150" />
</a>

# Amazon Web Services SDK for Salesforce Apex

The AWS SDK for Salesforce makes it easy for developers to access Amazon Web Services in Apex<br/>code, and build robust applications and software using services like Amazon S3, Amazon EC2, etc.

Get started by installing the package: <a href="https://login.salesforce.com/packaging/installPackage.apexp?p0=04tKf000000Y1qb"><b>/packaging/installPackage.apexp?p0=04tKf000000Y1qb</b></a>

###### Sign up then go to your AWS Console > Security Credentials > Access Keys:

<img src="https://raw.githubusercontent.com/mattandneil/aws-sdk/master/README2.png" />

#### Create a Named Credential

- **Name**: S3
- **URL**: https://s3.us-east-1.amazonaws.com/
- **Identity Type**: Named Principal
- **Auth Protocol**: AWS Signature V4
- **AWS Access Key ID**: [your key here]
- **AWS Secret Access Key**: [your secret here]
- **AWS Region**: us-east-1
- **AWS Service**: s3

## Amazon Simple Notification Service (SNS) SDK

SNS is an infrastructure for delivering messages. Publishers communicate asynchronously with subscribers by producing and sending a message to a topic. Subscribers include web servers / email addresses / Amazon SQS queues / AWS Lambda functions.

<img src="https://raw.githubusercontent.com/mattandneil/aws-sdk/master/README3.png" />

###### Create a topic:

    // Example: https://sns.us-east-1.amazonaws.com/
    AWS.SNS.CreateTopicRequest request = new AWS.SNS.CreateTopicRequest();
    request.url = 'callout:Your_SNS_Cred';
    request.name = 'Your_Topic';
    AWS.SNS.CreateTopicResponse response = new AWS.SNS.CreateTopic().call(request);
    String topic = response.createTopicResult.topicArn;

###### Publish messages:

    // Example: https://sns.us-east-1.amazonaws.com/
    AWS.SNS.PublishRequest request = new AWS.SNS.PublishRequest();
    request.url = 'callout:Your_SNS_Cred';
    request.message = 'Test_Message';
    request.topicArn = 'arn:aws:sns:us-east-1:123456789012:Your_Topic';
    AWS.SNS.PublishResponse response = new AWS.SNS.Publish().call(request);

## Amazon Simple Storage Service (S3) SDK

The [Apex client](https://github.com/mattandneil/aws-sdk/blob/master/S3.cls) manipulates both buckets and contents. You can create and destroy objects, given the bucket name and the object key.

<img src="https://raw.githubusercontent.com/mattandneil/aws-sdk/master/README4.png" />

###### Create a bucket:

    // Example: https://s3.us-east-1.amazonaws.com/bucket
    AWS.S3.CreateBucketRequest request = new AWS.S3.CreateBucketRequest();
    request.url = 'callout:Your_S3_Cred/bucket';
    AWS.S3.CreateBucketResponse response = new AWS.S3.CreateBucket().call(request);

###### Adding an object to a bucket:

    // Example: https://s3.us-east-1.amazonaws.com/bucket/key.txt
    AWS.S3.PutObjectRequest request = new AWS.S3.PutObjectRequest();
    request.url = 'callout:Your_S3_Cred/bucket/key.txt';
    request.body = Blob.valueOf('test_body');
    AWS.S3.PutObjectResponse response = new AWS.S3.PutObject().call(request);

###### View an object:

    // Example: https://s3.us-east-1.amazonaws.com/bucket/key.txt
    AWS.S3.GetObjectRequest request = new AWS.S3.GetObjectRequest();
    request.url = 'callout:Your_S3_Cred/bucket/key.txt';
    AWS.S3.GetObjectResponse response = new AWS.S3.GetObject().call(request);
    System.debug(response.body); // 'test_body'

###### List bucket contents:

    // Example: https://s3.us-east-1.amazonaws.com/bucket
    AWS.S3.ListObjectsRequest request = new AWS.S3.ListObjectsRequest();
    request.url = 'callout:Your_S3_Cred/bucket';
    AWS.S3.ListObjectsResponse response = new AWS.S3.ListObjects().call(request);

###### Delete an object:

    // Example: https://s3.amazonaws.com/bucket/key.txt
    AWS.S3.DeleteObjectRequest request = new AWS.S3.DeleteObjectRequest();
    request.url = 'callout:Your_S3_Cred/bucket/key.txt';
    AWS.S3.DeleteObjectResponse response = new AWS.S3.DeleteObject().call(request);

## Amazon Elastic Cloud Compute (EC2) SDK

EC2 provides scalable computing capacity in the cloud. The [Apex client](https://github.com/mattandneil/aws-sdk/blob/master/EC2.cls) calls services to launch instances, terminate instances, etc. The API responds synchronously, but bear in mind that the the instance state transitions take time.

<img src="https://raw.githubusercontent.com/mattandneil/aws-sdk/master/README5.png" />

###### Describe running instances:

    // Example: https://ec2.amazonaws.com/
    AWS.EC2.DescribeInstancesRequest request = new AWS.EC2.DescribeInstancesRequest();
    request.url = 'callout:Your_EC2_Cred';
    AWS.EC2.DescribeInstancesResponse response = new AWS.EC2.DescribeInstances().call(request);

###### Launch a new instance:

    // Example: https://ec2.amazonaws.com/
    AWS.EC2.RunInstancesRequest request = new AWS.EC2.RunInstancesRequest();
    request.url = 'callout:Your_EC2_Cred';
    request.imageId = 'ami-08111162';
    AWS.EC2.RunInstancesResponse response = new AWS.EC2.RunInstances().call(request);

###### Terminate an existing instance:

    // Example: https://ec2.amazonaws.com/
    AWS.EC2.TerminateInstancesRequest request = new AWS.EC2.TerminateInstancesRequest();
    request.url = 'callout:Your_EC2_Cred';
    request.instanceId = new List<String>{'i-01234567890abcdef'};
    request.dryRun = true;
    AWS.EC2.TerminateInstancesResponse response = new AWS.EC2.TerminateInstances().call(request);

