/**
* Salesforce Apex SDK for AWS Lambda
 * 
 * Amazon Web Services documentation:
 * https://docs.aws.amazon.com/lambda/latest/dg/index.html
 * https://docs.aws.amazon.com/lambda/latest/dg/lambda-dg.pdf
 */
global class Lambda
{
    private Lambda()
    {
        //
    }
    
    /**
     * Creates a Lambda function. To create a function, you need a deployment package and an
     * execution role. The deployment package contains your function code. The execution role grants
     * the function permission to use AWS services, such as Amazon CloudWatch Logs for log streaming
     * and AWS X-Ray for request tracing.
     * 
     * https://docs.aws.amazon.com/lambda/latest/dg/API_CreateFunction.html
     */
    global class CreateFunction implements HttpCalloutMock
    {
        global CreateFunctionResponse call(CreateFunctionRequest request)
        {
            if (Test.isRunningTest()) Test.setMock(HttpCalloutMock.class, this);
            System.Callable sdk = (System.Callable)Type.forName('AWS.SDK').newInstance();
            return (CreateFunctionResponse)sdk.call(CreateFunctionRequest.class.getName(),
            (Map<String,Object>)Json.deserializeUntyped(Json.serialize(request, true)));
        }
        
        public HttpResponse respond(HttpRequest request)
        {
            HttpResponse response = new HttpResponse();
            response.setStatusCode(200);
            response.setHeader('Content-Type', 'application/json');
            response.setBody(''
                + '{'
                +     '"Description": "",'
                +     '"TracingConfig":'
                +     '{'
                +         '"Mode": "PassThrough"'
                +     '},'
                +     '"VpcConfig": null,'
                +     '"RevisionId": "11223344-5566-7788-9900-aabbccddeeff",'
                +     '"LastModified": "2020-01-01T23:59:59.000+0000",'
                +     '"FileSystemConfigs": null,'
                +     '"FunctionName": "Test",'
                +     '"Runtime": "nodejs10.x",'
                +     '"Version": "$LATEST",'
                +     '"LastUpdateStatus": "Successful",'
                +     '"Layers": null,'
                +     '"FunctionArn": "arn:aws:lambda:us-east-1:123456789012:function:Test",'
                +     '"KMSKeyArn": null,'
                +     '"MemorySize": 128,'
                +     '"LastUpdateStatusReason": null,'
                +     '"DeadLetterConfig": null,'
                +     '"Timeout": 3,'
                +     '"Handler": "call",'
                +     '"CodeSha256": "abcdefghijklmnopqrstuvwxyz1234567890ABCDEFGH",'
                +     '"Role": "arn:aws:iam::123456789012:role/Test",'
                +     '"MasterArn": null,'
                +     '"CodeSize": 154,'
                +     '"State": "Active",'
                +     '"StateReason": null,'
                +     '"Environment": null,'
                +     '"StateReasonCode": null,'
                +     '"LastUpdateStatusReasonCode": null'
                + '}'
            );
            return response;
        }
    }

    /**
     * https://docs.aws.amazon.com/lambda/latest/dg/API_CreateFunction.html#API_CreateFunction_RequestSyntax
     */
    global class CreateFunctionRequest
    {
        global String url = 'callout:Lambda';
        
        /**
         * The code for the function.
         * Type: FunctionCode object
         * Required: Yes
         */
        global FunctionCode code;

        /**
         * A dead letter queue configuration that specifies the queue or topic where Lambda sends
         * asynchronous events when they fail processing. For more information, see Dead Letter
         * Queues.
         * Type: DeadLetterConfig object
         * Required: No
         */
        global DeadLetterConfig deadLetterConfig;

        /**
         * A description of the function.
         * Type: String
         * Length Constraints: Minimum length of 0. Maximum length of 256.
         * Required: No
         */
        global String description;

        /**
         * A function's environment variable settings.
         * Type: Environment object
         * Required: No
         */
        global Environment environment;

        /**
         * Connection settings for an Amazon EFS file system.
         * Type: Array of FileSystemConfig objects
         * Array Members: Maximum number of 1 item.
         * Required: No
         */
        global List<FileSystemConfig> fileSystemConfigs;

        /**
         * The name of the Lambda function.
         * Name formats
         * - Function name - my-function.
         * - Function ARN - arn:aws:lambda:us-west-2:123456789012:function:my-function.
         * - Partial ARN - 123456789012:function:my-function.
         * The length constraint applies only to the full ARN. If you specify only the function
         * name, it is limited to 64 characters in length.
         * Type: String
         * Length Constraints: Minimum length of 1. Maximum length of 140.
         * (arn:(aws[a-zA-Z-]*)?:lambda:)?([a-z]{2}(-gov)?-[a-z]+-\d{1}:)?(\d{12}:)?(function:)?([a-zA-Z0-9-_]+)(:(\$LATEST|[a-zA-Z0-9-_]+))?
         * Required: Yes
         */
        global String functionName;

        /**
         * The name of the method within your code that Lambda calls to execute your function. The
         * format includes the file name. It can also include namespaces and other qualifiers,
         * depending on the runtime. For more information, see Programming Model.
         * Type: String
         * Length Constraints: Maximum length of 128.
         * Pattern: [^\s]+
         * Required: Yes
         */
        global String handler;

        /**
         * The ARN of the AWS Key Management Service (AWS KMS) key that's used to encrypt your
         * function's environment variables. If it's not provided, AWS Lambda uses a default service
         * key.
         * Type: String
         * Pattern: (arn:(aws[a-zA-Z-]*)?:[a-z0-9-.]+:.*)|()
         * Required: No
         */
        global String kmsKeyArn;

        /**
         * A list of function layers to add to the function's execution environment. Specify each
         * layer by its ARN, including the version.
         * Type: Array of strings
         * Length Constraints: Minimum length of 1. Maximum length of 140.
         * Pattern: arn:[a-zA-Z0-9-]+:lambda:[a-zA-Z0-9-]+:\d{12}:layer:[a-zA-Z0-9-_]+:[0-9]+
         * Required: No
         */
        global List<String> layers;

        /**
         * The amount of memory that your function has access to. Increasing the function's memory
         * also increases its CPU allocation. The default value is 128 MB. The value must be a
         * multiple of 64 MB.
         * Type: Integer
         * Valid Range: Minimum value of 128. Maximum value of 3008.
         * Required: No
         */
        global Integer memorySize;

        /**
         * Set to true to publish the first version of the function during creation.
         * Type: Boolean
         * Required: No
         */
        global Boolean publish;

        /**
         * The Amazon Resource Name (ARN) of the function's execution role.
         * Pattern: arn:(aws[a-zA-Z-]*)?:iam::\d{12}:role/?[a-zA-Z_0-9+=,.@\-_/]+
         * Required: Yes
         */
        global String role;

        /**
         * The identifier of the function's runtime.
         * Type: String
         * Valid Values: nodejs10.x | nodejs12.x | java8 | java11 | python2.7 | python3.6
         * | python3.7 | python3.8 | dotnetcore2.1 | dotnetcore3.1 | go1.x | ruby2.5 | ruby2.7
         * | provided
         * Required: Yes
         */
        global String runtime;

        /**
         * A list of tags to apply to the function.
         * Type: String to string map
         * Required: No
         */
        global Map<String,String> tags;

        /**
         * The amount of time that Lambda allows a function to run before stopping it. The default
         * is 3 seconds. The maximum allowed value is 900 seconds.
         * Type: Integer
         * Valid Range: Minimum value of 1.
         * Required: No
         */
        global Integer timeout;

        /**
         * Set Mode to Active to sample and trace a subset of incoming requests with AWS X-Ray.
         * Type: TracingConfig object
         * Required: No
         */
        global TracingConfig tracingConfig;

        /**
         * For network connectivity to AWS resources in a VPC, specify a list of security groups and
         * subnets in the VPC. When you connect a function to a VPC, it can only access resources
         * and the internet through that VPC. For more information, see VPC Settings.
         * Type: VpcConfig object
         * Required: No
         */
        global VpcConfig vpcConfig;
    }

    /**
     * https://docs.aws.amazon.com/lambda/latest/dg/API_CreateFunction.html#API_CreateFunction_ResponseSyntax
     */
    global class CreateFunctionResponse
    {
        /**
         * The SHA256 hash of the function's deployment package.
         * Type: String
         */
        global String codeSha256;

        /**
         * The size of the function's deployment package, in bytes.
         * Type: Long
         */
        global Long codeSize;

        /**
         * The dead-letter queue for failed asynchronous invocations.
         * Type: DeadLetterConfig object
         */
        global DeadLetterConfig deadLetterConfig;

        /**
         * The function's description.
         * Type: String
         * Length Constraints: Minimum length of 0. Maximum length of 256.
         */
        global String description;

        /**
         * The function's environment variables.
         * Type: EnvironmentResponse object
         */
        global Environment environment;

        /**
         * Connection settings for an Amazon EFS file system.
         * Type: Array of FileSystemConfig objects
         * Array Members: Maximum number of 1 item.
         */
        global List<FileSystemConfig> fileSystemConfig;

        /**
         * The function's Amazon Resource Name (ARN).
         * Type: String
         * Pattern: arn:(aws[a-zA-Z-]*)?:lambda:[a-z]{2}(-gov)?-[a-z]+-\d{1}:\d{12}:function:[a-zA-Z0-9-_\.]+(:(\$LATEST|[a-zA-Z0-9-_]+))?
         */
        global String functionArn;

        /**
         * The name of the function.
         * Type: String
         * Length Constraints: Minimum length of 1. Maximum length of 170.
         * Pattern: (arn:(aws[a-zA-Z-]*)?:lambda:)?([a-z]{2}(-gov)?-[a-z]+-\d{1}:)?(\d{12}:)?(function:)?([a-zA-Z0-9-_\.]+)(:(\$LATEST|[a-zA-Z0-9-_]+))?
         */
        global String functionName;

        /**
         * The function that Lambda calls to begin executing your function.
         * Type: String
         * Length Constraints: Maximum length of 128.
         * Pattern: [^\s]+
         */
        global String handler;

        /**
         * The KMS key that's used to encrypt the function's environment variables. This key is only
         * returned if you've configured a customer managed CMK.
         * Type: String
         * Pattern: (arn:(aws[a-zA-Z-]*)?:[a-z0-9-.]+:.*)|()
         */
        global String kmsKeyArn;

        /**
         * The date and time that the function was last updated, in ISO-8601 format
         * (YYYY-MM-DDThh:mm:ss.sTZD).
         * Type: String
         */
        global String lastModified;

        /**
         * The status of the last update that was performed on the function. This is first set to
         * Successful after function creation completes.
         * Type: String
         * Valid Values: Successful | Failed | InProgress
         */
        global String lastUpdateStatus;

        /**
         * The reason for the last update that was performed on the function.
         * Type: String
         */
        global String lastUpdateStatusReason;

        /**
         * The reason code for the last update that was performed on the function.
         * Type: String
         * Valid Values: EniLimitExceeded | InsufficientRolePermissions | InvalidConfiguration
         * | InternalError | SubnetOutOfIPAddresses | InvalidSubnet | InvalidSecurityGroup
         */
        global String lastUpdateStatusReasonCode;

        /**
         * The function's layers.
         * Type: Array of Layer objects
         */
        global List<Layer> layers;

        /**
         * For Lambda@Edge functions, the ARN of the master function.
         * Type: String
         * Pattern: arn:(aws[a-zA-Z-]*)?:lambda:[a-z]{2}(-gov)?-[a-z]+-\d{1}:\d{12}:function:[a-zA-Z0-9-_]+(:(\$LATEST|[a-zA-Z0-9-_]+))?
         */
        global String masterArn;

        /**
         * The memory that's allocated to the function.
         * Type: Integer
         * Valid Range: Minimum value of 128. Maximum value of 3008.
         */
        global Integer memorySize;

        /**
         * The latest updated revision of the function or alias.
         * Type: String
         */
        global String revisionId;

        /**
         * The function's execution role.
         * Type: String
         * Pattern: arn:(aws[a-zA-Z-]*)?:iam::\d{12}:role/?[a-zA-Z_0-9+=,.@\-_/]+
         */
        global String role;

        /**
         * The runtime environment for the Lambda function.
         * Type: String
         * Valid Values: nodejs10.x | nodejs12.x | java8 | java11 | python2.7 | python3.6
         * | python3.7 | python3.8 | dotnetcore2.1 | dotnetcore3.1 | go1.x | ruby2.5 | ruby2.7
         * | provided
         */
        global String runtime;

        /**
         * The current state of the function. When the state is Inactive, you can reactivate the
         * function by invoking it.
         * Type: String
         * Valid Values: Pending | Active | Inactive | Failed
         */
        global String state;

        /**
         * The reason for the function's current state.
         * Type: String
         */
        global String stateReason;

        /**
         * The reason code for the function's current state. When the code is Creating, you can't
         * invoke or modify the function.
         * Type: String
         * Valid Values: Idle | Creating | Restoring | EniLimitExceeded
         * | InsufficientRolePermissions | InvalidConfiguration | InternalError
         * | SubnetOutOfIPAddresses | InvalidSubnet | InvalidSecurityGroup
         */
        global String stateReasonCode;

        /**
         * The amount of time in seconds that Lambda allows a function to run before stopping it.
         * Type: Integer
         * Valid Range: Minimum value of 1.
         */
        global Integer timeout;

        /**
         * The function's AWS X-Ray tracing configuration.
         * Type: TracingConfigResponse object
         */
        global TracingConfig tracingConfig;

        /**
         * The version of the Lambda function.
         * Type: String
         * Length Constraints: Minimum length of 1. Maximum length of 1024.
         * Pattern: (\$LATEST|[0-9]+)
         */
        global String version;

        /**
         * The function's networking configuration.
         * Type: VpcConfigResponse object
         */
        global VpcConfig vpcConfig;
    }

    /**
     * https://docs.aws.amazon.com/lambda/latest/dg/API_DeleteFunction.html
     * 
     * Deletes a Lambda function. To delete a specific function version, use the
     * Qualifier parameter. Otherwise, all versions and aliases are deleted.
     * 
     * To delete Lambda event source mappings that invoke a function, use DeleteEventSourceMapping. For AWS services
     * and resources that invoke your function directly, delete the trigger in the service where you originally configured it.
     */
    global class DeleteFunction implements HttpCalloutMock
    {
        global DeleteFunctionResponse call(DeleteFunctionRequest request)
        {
            if (Test.isRunningTest()) Test.setMock(HttpCalloutMock.class, this);
            System.Callable sdk = (System.Callable)Type.forName('AWS.SDK').newInstance();
            return (DeleteFunctionResponse)sdk.call(DeleteFunctionRequest.class.getName(),
            (Map<String,Object>)Json.deserializeUntyped(Json.serialize(request, true)));
        }
        
        public HttpResponse respond(HttpRequest request)
        {
            HttpResponse response = new HttpResponse();
            response.setStatusCode(204);
            response.setBody('');
            return response;
        }
    }

    /**
     * https://docs.aws.amazon.com/lambda/latest/dg/API_DeleteFunction.html#API_DeleteFunction_RequestSyntax
     */
    global class DeleteFunctionRequest
    {
        global String url = 'callout:Lambda';
        
        /**
         * The name of the Lambda function or version.
         * Name formats
         * - Function name - my-function (name-only), my-function:1 (with version).
         * - Function ARN - arn:aws:lambda:us-west-2:123456789012:function:my-function.
         * - Partial ARN - 123456789012:function:my-function.
         * You can append a version number or alias to any of the formats. The length constraint
         * applies only to the full ARN. If you specify only the function name, it is limited to 64
         * characters in length.
         * Length Constraints: Minimum length of 1. Maximum length of 140.
         * Pattern: (arn:(aws[a-zA-Z-]*)?:lambda:)?([a-z]{2}(-gov)?-[a-z]+-\d{1}:)?(\d{12}:)?(function:)?([a-zA-Z0-9-_]+)(:(\$LATEST|[a-zA-Z0-9-_]+))?
         * Required: Yes
         */
        global String functionName;

        /**
         * Specify a version to delete. You can't delete a version that's referenced by an alias.
         * Length Constraints: Minimum length of 1. Maximum length of 128.
         * Pattern: (|[a-zA-Z0-9$_-]+)
         */
        global String qualifier;
    }

    /**
     * https://docs.aws.amazon.com/lambda/latest/dg/API_DeleteFunction.html#API_DeleteFunction_RequestSyntax#API_DeleteFunction_ResponseSyntax
     */
    global class DeleteFunctionResponse
    {
        //
    }

    /**
     * Invokes a Lambda function. You can invoke a function synchronously (and wait for the response),
     * or asynchronously. To invoke a function asynchronously, set InvocationType to Event.
     * 
     * https://docs.aws.amazon.com/lambda/latest/dg/API_Invoke.html
     */
    global class Invoke implements HttpCalloutMock
    {
        global InvokeResponse call(InvokeRequest request)
        {
            if (Test.isRunningTest()) Test.setMock(HttpCalloutMock.class, this);
            System.Callable sdk = (System.Callable)Type.forName('AWS.SDK').newInstance();
            return (InvokeResponse)sdk.call(InvokeRequest.class.getName(),
            (Map<String,Object>)Json.deserializeUntyped(Json.serialize(request, true)));
        }
        
        public HttpResponse respond(HttpRequest request)
        {
            HttpResponse response = new HttpResponse();
            response.setStatusCode(200);
            response.setHeader('X-Amz-Log-Result', 'abcdefghijklmnop12345678');
            response.setHeader('X-Amz-Function-Error', 'xAmzFunctionError');
            response.setHeader('X-Amz-Executed-Version', 'xAmzExecutedVersion');
            response.setBody('"2020/01/01/[$LATEST]abcdef1234567890abcdef1234567890"');
            return response;
        }
    }
    
    /**
     * https://docs.aws.amazon.com/lambda/latest/dg/API_Invoke.html#API_Invoke_RequestSyntax
     */
    global class InvokeRequest
    {
        global String url = 'callout:Lambda';
        
        /**
         * Up to 3583 bytes of base64-encoded data about the invoking client to pass to the function
         * in the context object.
         */
        global Blob clientContext;

        /**
         * The name of the Lambda function, version, or alias.
         * Name formats
         * - Function name - my-function (name-only), my-function:v1 (with alias).
         * - Function ARN - arn:aws:lambda:us-west-2:123456789012:function:my-function.
         * - Partial ARN - 123456789012:function:my-function.
         * You can append a version number or alias to any of the formats. The length constraint
         * applies only to the full ARN. If you specify only the function name, it is limited to 64
         * characters in length.
         * Length Constraints: Minimum length of 1. Maximum length of 170.
         * Pattern: (arn:(aws[a-zA-Z-]*)?:lambda:)?([a-z]{2}(-gov)?-[a-z]+-\d{1}:)?(\d{12}:)?(function:)?([a-zA-Z0-9-_\.]+)(:(\$LATEST|[a-zA-Z0-9-_]+))?
         * Required: Yes
         */
        global String functionName;

        /**
         * Choose from the following options.
         * - RequestResponse (default) - Invoke the function synchronously. Keep the connection open
         *   until the function returns a response or times out. The API response includes the
         *   function response and additional data.
         * - Event - Invoke the function asynchronously. Send events that fail multiple times to the
         *   function's dead-letter queue (if it's configured). The API response only includes a
         *   status code.
         * - DryRun - Validate parameter values and verify that the user or role has permission to
         *   invoke the function.
         * Valid Values: Event | RequestResponse | DryRun
         */
        global String invocationType;

        /**
         * Set to Tail to include the execution log in the response.
         * Valid Values: None | Tail
         */
        global String logType;

        /**
         * Specify a version or alias to invoke a published version of the function.
         * Length Constraints: Minimum length of 1. Maximum length of 128.
         * Pattern: (|[a-zA-Z0-9$_-]+)
         */
        global String qualifier;

        /**
         * The JSON that you want to provide to your Lambda function as input.
         */
        global Blob payload;
    }

    /**
     * https://docs.aws.amazon.com/lambda/latest/dg/API_Invoke.html#API_Invoke_ResponseSyntax
     */
    global class InvokeResponse
    {
        /**
         * The HTTP status code is in the 200 range for a successful request. For the
         * RequestResponse invocation type, this status code is 200. For the Event invocation type,
         * this status code is 202. For the DryRun invocation type, the status code is 204.
         */
        global Integer statusCode;

        /**
         * The version of the function that executed. When you invoke a function with an alias, this
         * indicates which version the alias resolved to.
         * Length Constraints: Minimum length of 1. Maximum length of 1024.
         * Pattern: (\$LATEST|[0-9]+)
         */
        global String executedVersion;

        /**
         * If present, indicates that an error occurred during function execution. Details about the
         * error are included in the response payload.
         */
        global String functionError;

        /**
         * The last 4 KB of the execution log, which is base64 encoded.
         */
        global Blob logResult;

        /**
         * The response from the function, or an error object.
         */
        global Blob payload;
    }
    
    /**
     * The code for the Lambda function. You can specify either an object in Amazon S3, or upload a
     * deployment package directly.
     * 
     * https://docs.aws.amazon.com/lambda/latest/dg/API_FunctionCode.html
     */
    global class FunctionCode
    {
        /**
         * An Amazon S3 bucket in the same AWS Region as your function. The bucket can be in a
         * different AWS account.
         * Type: String
         * Length Constraints: Minimum length of 3. Maximum length of 63.
         * Pattern: ^[0-9A-Za-z\.\-_]*(?<!\.)$
         * Required: No
         */
        global String s3Bucket;

        /**
         * The Amazon S3 key of the deployment package.
         * Type: String
         * Length Constraints: Minimum length of 1. Maximum length of 1024.
         * Required: No
         */
        global String s3Key;

        /**
         * For versioned objects, the version of the deployment package object to use.
         * Type: String
         * Length Constraints: Minimum length of 1. Maximum length of 1024.
         * Required: No
         */
        global String s3ObjectVersion;

        /**
         * The base64-encoded contents of the deployment package. AWS SDK and AWS CLI clients handle
         * the encoding for you.
         * Type: Base64-encoded binary data object
         * Required: No
         */
        global Blob zipFile;
    }

    /**
     * The dead-letter queue for failed asynchronous invocations.
     * 
     * https://docs.aws.amazon.com/lambda/latest/dg/API_DeadLetterConfig.html
     */
    global class DeadLetterConfig
    {
        /**
         * The Amazon Resource Name (ARN) of an Amazon SQS queue or Amazon SNS topic.
         * Type: String
         * Pattern: (arn:(aws[a-zA-Z-]*)?:[a-z0-9-.]+:.*)|()
         * Required: No
         */
        global String targetArn;
    }

    /**
     * The results of an operation to update or read environment variables. If the operation is
     * successful, the response contains the environment variables. If it failed, the response
     * contains details about the error.
     * 
     * https://docs.aws.amazon.com/lambda/latest/dg/API_Environment.html
     * https://docs.aws.amazon.com/lambda/latest/dg/API_EnvironmentResponse.html
     */
    global class Environment
    {
        /**
         * Error messages for environment variables that couldn't be applied.
         * Type: EnvironmentError object
         * Required: No
         */
        global EnvironmentError error;

        /**
         * Environment variable key-value pairs.
         * Type: String to string map
         * Key Pattern: [a-zA-Z]([a-zA-Z0-9_])+
         * Required: No
         */
        global Map<String,String> variables;
    }

    /**
     * Error messages for environment variables that couldn't be applied.
     * 
     * https://docs.aws.amazon.com/lambda/latest/dg/API_EnvironmentError.html
     */
    global class EnvironmentError
    {
        /**
         * The error code.
         * Type: String
         * Required: No
         */
        global String errorCode;

        /**
         * The error message.
         * Type: String
         * Required: No
         */
        global String message;
    }

    /**
     * An AWS Lambda layer
     * 
     * https://docs.aws.amazon.com/lambda/latest/dg/API_Layer.html
     * https://docs.aws.amazon.com/lambda/latest/dg/configuration-layers.html
     */
    global class Layer
    {
        /**
         * The Amazon Resource Name (ARN) of the function layer.
         * Type: String
         * Length Constraints: Minimum length of 1. Maximum length of 140.
         * Pattern: arn:[a-zA-Z0-9-]+:lambda:[a-zA-Z0-9-]+:\d{12}:layer:[a-zA-Z0-9-_]+:[0-9]+
         */
        global String arn;

        /**
         * The size of the layer archive in bytes.
         * Type: Long
         * Required: No
         */
        global Long codeSize;
    }
    
    /**
     * Details about the connection between a Lambda function and an Amazon EFS file system.
     * 
     * https://docs.aws.amazon.com/lambda/latest/dg/API_FileSystemConfig.html#SSS-Type-FileSystemConfig-Arn
     */
    global class FileSystemConfig
    {
        /**
         * The Amazon Resource Name (ARN) of the Amazon EFS access point that provides access to the
         * file system.
         * Type: String
         * Length Constraints: Maximum length of 200.
         * Pattern: arn:aws[a-zA-Z-]*:elasticfilesystem:[a-z]{2}((-gov)|(-iso(b?)))?-[a-z]+-\d{1}:\d{12}:access-point/fsap-[a-f0-9]{17}
         * Required: Yes
         */
        global String arn;

        /**
         * The path where the function can access the file system, starting with /mnt/.
         * Type: String
         * Length Constraints: Maximum length of 160.
         * Pattern: ^/mnt/[a-zA-Z0-9-_.]+$
         * Required: Yes
         */
        global String localMountPath;
    }

    /**
     * The function's AWS X-Ray tracing configuration. To sample and record incoming requests, set
     * Mode to Active.
     * 
     * https://docs.aws.amazon.com/lambda/latest/dg/API_TracingConfigResponse.html
     */
    global class TracingConfig
    {
        /**
         * The tracing mode.
         * Type: String
         * Valid Values: Active | PassThrough
         * Required: No
         */
        global String mode;
    }

    /**
     * The VPC security groups and subnets that are attached to a Lambda function.
     * 
     * https://docs.aws.amazon.com/lambda/latest/dg/API_VpcConfig.html
     * https://docs.aws.amazon.com/lambda/latest/dg/API_VpcConfigResponse.html
     */
    global class VpcConfig
    {
        /**
         * A list of VPC security groups IDs.
         * Type: Array of strings
         * Array Members: Maximum number of 5 items.
         * Required: No
         */
        global List<String> securityGroupIds;

        /**
         * A list of VPC subnet IDs.
         * Type: Array of strings
         * Array Members: Maximum number of 16 items.
         * Required: No
         */
        global List<String> subnetIds;

        /**
         * The ID of the VPC.
         * Type: String
         * Required: No
         */
        global String vpcId;
    }
}