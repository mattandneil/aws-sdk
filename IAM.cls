/**
* Salesforce Apex SDK for AWS IAM
 * 
 * Amazon Web Services documentation:
 * https://docs.aws.amazon.com/IAM/latest/APIReference/index.html
 * https://docs.aws.amazon.com/IAM/latest/APIReference/iam-api.pdf
 */
global class IAM
{
    private IAM()
    {
        //
    }
    
    /**
     * Creates a new role for your AWS account. For more information about roles, go to IAM Roles.
     * The number and size of IAM resources in an AWS account are limited. For more information, see
     * IAM and STS Quotas in the IAM User Guide.
     * 
     * https://docs.aws.amazon.com/IAM/latest/APIReference/API_CreateRole.html
     */
    global class CreateRole implements HttpCalloutMock
    {
        global CreateRoleResponse call(CreateRoleRequest request)
        {
            if (Test.isRunningTest()) Test.setMock(HttpCalloutMock.class, this);
            System.Callable sdk = (System.Callable)Type.forName('AWS.SDK').newInstance();
            return (CreateRoleResponse)sdk.call(CreateRoleRequest.class.getName(),
            (Map<String,Object>)Json.deserializeUntyped(Json.serialize(request, true)));
        }
        
        global HttpResponse respond(HttpRequest request)
        {
            HttpResponse response = new HttpResponse();
            response.setStatusCode(200);
            response.setHeader('Content-Type', 'text/xml');
            response.setBody(''
                + '<CreateRoleResponse xmlns="https://iam.amazonaws.com/doc/2010-05-08/">'
                + '  <CreateRoleResult>'
                + '    <Role>'
                + '      <Path>/</Path>'
                + '      <AssumeRolePolicyDocument>%7B%22Version%22%3A%222012-10-17%22%2C%22Statement%22%3A%5B%7B%22Effect%22%3A%22Allow%22%2C%22Principal%22%3A%7B%22Service%22%3A%5B%22lambda.amazonaws.com%22%5D%7D%2C%22Action%22%3A%5B%22sts%3AAssumeRole%22%5D%7D%5D%7D</AssumeRolePolicyDocument>'
                + '      <RoleId>1234567890ABCDEFGHIJK</RoleId>'
                + '      <RoleName>Test</RoleName>'
                + '      <Arn>arn:aws:iam::123456789012:role/Test</Arn>'
                + '      <Tags>'
                + '        <member>'
                + '          <Value>value</Value>'
                + '          <Key>key</Key>'
                + '        </member>'
                + '      </Tags>'
                + '      <CreateDate>2020-01-01T23:59:59Z</CreateDate>'
                + '    </Role>'
                + '  </CreateRoleResult>'
                + '  <ResponseMetadata>'
                + '    <RequestId>11223344-5566-7788-9900-aabbccddeeff</RequestId>'
                + '  </ResponseMetadata>'
                + '</CreateRoleResponse>'
            );
            return response;
        }
    }

    /**
     * https://docs.aws.amazon.com/IAM/latest/APIReference/API_CreateRole.html#API_CreateRole_RequestParameters
     */
    global class CreateRoleRequest
    {
        global String url = 'callout:IAM';
        
        /**
         * The trust relationship policy document that grants an entity permission to assume the
         * role.
         * In IAM, you must provide a JSON policy that has been converted to a string. However, for
         * AWS CloudFormation templates formatted in YAML, you can provide the policy in JSON or
         * YAML format. AWS CloudFormation always converts a YAML policy to JSON format before
         * submitting it to IAM.
         * The regex pattern used to validate this parameter is a string of characters consisting of
         * the following:
         * - Any printable ASCII character ranging from the space character (\u0020) through the end
         *   of the ASCII character range
         * - The printable characters in the Basic Latin and Latin-1 Supplement character set
         *   (through \u00FF)
         * - The special characters tab (\u0009), line feed (\u000A), and carriage return (\u000D)
         * Upon success, the response includes the same trust policy in JSON format.
         * Type: String
         * Length Constraints: Minimum length of 1. Maximum length of 131072.
         * Pattern: [\u0009\u000A\u000D\u0020-\u00FF]+
         * Required: Yes
         */
        global String assumeRolePolicyDocument;

        /**
         * A description of the role.
         * Type: String
         * Length Constraints: Maximum length of 1000.
         * Pattern: [\p{L}\p{M}\p{Z}\p{S}\p{N}\p{P}]*
         * Required: No
         */
        global String description;

        /**
         * The maximum session duration (in seconds) that you want to set for the specified role. If
         * you do not specify a value for this setting, the default maximum of one hour is applied.
         * This setting can have a value from 1 hour to 12 hours.
         * Anyone who assumes the role from the AWS CLI or API can use the DurationSeconds API
         * parameter or the duration-seconds CLI parameter to request a longer session. The
         * MaxSessionDuration setting determines the maximum duration that can be requested using
         * the DurationSeconds parameter. If users don't specify a value for the DurationSeconds
         * parameter, their security credentials are valid for one hour by default. This applies
         * when you use the AssumeRole* API operations or the assume-role* CLI operations but does
         * not apply when you use those operations to create a console URL. For more information,
         * see Using IAM Roles in the IAM User Guide.
         * Type: Integer
         * Valid Range: Minimum value of 3600. Maximum value of 43200.
         * Required: No
         */
        global Integer maxSessionDuration;

        /**
         * The path to the role. For more information about paths, see IAM Identifiers in the IAM
         * User Guide.
         * This parameter is optional. If it is not included, it defaults to a slash (/).
         * This parameter allows (through its regex pattern) a string of characters consisting of
         * either a forward slash (/) by itself or a string that must begin and end with forward
         * slashes. In addition, it can contain any ASCII character from the ! (\u0021) through the
         * DEL character (\u007F), including most punctuation characters, digits, and upper and
         * lowercased letters.
         * Type: String
         * Length Constraints: Minimum length of 1. Maximum length of 512.
         * Pattern: (\u002F)|(\u002F[\u0021-\u007F]+\u002F)
         * Required: No
         */
        global String path;

        /**
         * The ARN of the policy that is used to set the permissions boundary for the role.
         * Type: String
         * Length Constraints: Minimum length of 20. Maximum length of 2048.
         * Required: No
         */
        global String permissionsBoundary;

        /**
         * The name of the role to create.
         * IAM user, group, role, and policy names must be unique within the account. Names are not
         * distinguished by case. For example, you cannot create resources named both "MyResource"
         * and "myresource".
         * Type: String
         * Length Constraints: Minimum length of 1. Maximum length of 64.
         * Pattern: [\w+=,.@-]+
         * Required: Yes
         */
        global String roleName;

        /**
         * A list of tags that you want to attach to the newly created role. Each tag consists of a
         * key name and an associated value. For more information about tagging, see Tagging IAM
         * Identities in the IAM User Guide.
         * Type: Array of Tag objects
         * Array Members: Maximum number of 50 items.
         * Required: No
         */
        global Tags tags;
    }

    /**
     * https://docs.aws.amazon.com/IAM/latest/APIReference/API_CreateRole.html#API_CreateRole_ResponseElements
     */
    global class CreateRoleResponse
    {
        global CreateRoleResult createRoleResult;
    }
    
    global class CreateRoleResult
    {
        /**
         * A structure containing details about the new role.
         * Type: Role object
         */
        global Role role;
    }

    /**
     * Deletes the specified role. The role must not have any policies attached. For more
     * information about roles, go to Working with Roles.
     * 
     * https://docs.aws.amazon.com/IAM/latest/APIReference/API_DeleteRole.html
     */
    global class DeleteRole implements HttpCalloutMock
    {
        global DeleteRoleResponse call(DeleteRoleRequest request)
        {
            if (Test.isRunningTest()) Test.setMock(HttpCalloutMock.class, this);
            System.Callable sdk = (System.Callable)Type.forName('AWS.SDK').newInstance();
            return (DeleteRoleResponse)sdk.call(DeleteRoleRequest.class.getName(),
            (Map<String,Object>)Json.deserializeUntyped(Json.serialize(request, true)));
        }
        
        global HttpResponse respond(HttpRequest request)
        {
            HttpResponse response = new HttpResponse();
            response.setStatusCode(200);
            response.setHeader('Content-Type', 'text/xml');
            response.setBody(''
                + '<DeleteRoleResponse xmlns="https://iam.amazonaws.com/doc/2010-05-08/">'
                + '  <ResponseMetadata>'
                + '    <RequestId>11223344-5566-7788-9900-aabbccddeeff</RequestId>'
                + '  </ResponseMetadata>'
                + '</DeleteRoleResponse>'
            );
            return response;
        }
    }

    /**
     * https://docs.aws.amazon.com/IAM/latest/APIReference/API_DeleteRole.html#API_DeleteRole_RequestParameters
     */
    global class DeleteRoleRequest
    {
        global String url = 'callout:IAM';

        /**
         * The name of the role to delete.
         * This parameter allows (through its regex pattern) a string of characters consisting of
         * upper and lowercase alphanumeric characters with no spaces. You can also include any of
         * the following characters: _+=,.@-
         * Type: String
         * Length Constraints: Minimum length of 1. Maximum length of 64.
         * Pattern: [\w+=,.@-]+
         * Required: Yes
         */
        global String roleName;
    }

    /**
     * https://docs.aws.amazon.com/IAM/latest/APIReference/API_DeleteRole.html#API_DeleteRole_Example_1_Response
     */
    global class DeleteRoleResponse
    {
        //
    }

    /**
     * Retrieves information about the specified role, including the role's path, GUID, ARN, and the
     * role's trust policy that grants permission to assume the role. For more information about
     * roles, see Working with Roles.
     * 
     * https://docs.aws.amazon.com/IAM/latest/APIReference/API_GetRole.html
     */
    global class GetRole implements HttpCalloutMock
    {
        global GetRoleResponse call(GetRoleRequest request)
        {
            if (Test.isRunningTest()) Test.setMock(HttpCalloutMock.class, this);
            System.Callable sdk = (System.Callable)Type.forName('AWS.SDK').newInstance();
            return (GetRoleResponse)sdk.call(GetRoleRequest.class.getName(),
            (Map<String,Object>)Json.deserializeUntyped(Json.serialize(request, true)));
        }
        
        public HttpResponse respond(HttpRequest request)
        {
            HttpResponse response = new HttpResponse();
            response.setStatusCode(200);
            response.setHeader('Content-Type', 'text/xml');
            response.setBody(''
                + '<GetRoleResponse xmlns="https://iam.amazonaws.com/doc/2010-05-08/">'
                + '  <GetRoleResult>'
                + '    <Role>'
                + '      <Path>/</Path>'
                + '      <AssumeRolePolicyDocument>%7B%22Version%22%3A%222012-10-17%22%2C%22Statement%22%3A%5B%7B%22Effect%22%3A%22Allow%22%2C%22Principal%22%3A%7B%22Service%22%3A%22lambda.amazonaws.com%22%7D%2C%22Action%22%3A%22sts%3AAssumeRole%22%7D%5D%7D</AssumeRolePolicyDocument>'
                + '      <MaxSessionDuration>3600</MaxSessionDuration>'
                + '      <RoleId>ABCDEFGHIJK1234567890</RoleId>'
                + '      <RoleLastUsed/>'
                + '      <RoleName>Streams-JavaScript</RoleName>'
                + '      <Arn>arn:aws:iam::123456789012:role/Streams-JavaScript</Arn>'
                + '      <CreateDate>2020-01-01T23:59:59Z</CreateDate>'
                + '    </Role>'
                + '  </GetRoleResult>'
                + '  <ResponseMetadata>'
                + '    <RequestId>11223344-5566-7788-9900-aabbccddeeff</RequestId>'
                + '  </ResponseMetadata>'
                + '</GetRoleResponse>'
            );
            return response;
        }
    }

    /**
     * https://docs.aws.amazon.com/IAM/latest/APIReference/API_GetRole.html#API_GetRole_RequestParameters
     */
    global class GetRoleRequest
    {
        global String url = 'callout:IAM';

        /**
         * The name of the IAM role to get information about.
         * This parameter allows (through its regex pattern) a string of characters consisting of
         * upper and lowercase alphanumeric characters with no spaces. You can also include any of
         * the following characters: _+=,.@-
         * Type: String
         * Length Constraints: Minimum length of 1. Maximum length of 64.
         * Pattern: [\w+=,.@-]+
         * Required: Yes
         */
        global String roleName;
    }

    /**
     * https://docs.aws.amazon.com/IAM/latest/APIReference/API_GetRole.html#API_GetRole_ResponseElements
     */
    global class GetRoleResponse
    {
        global GetRoleResult getRoleResult;
    }
    
    global class GetRoleResult
    {
        /**
         * A structure containing details about the IAM role.
         * Type: Role object
         */
        global Role role;
    }

    /**
     * Contains information about an IAM role. This structure is returned as a response element in
     * several API operations that interact with roles.
     * 
     * https://docs.aws.amazon.com/IAM/latest/APIReference/API_Role.html
     */
    global class Role
    {
        /**
         * The Amazon Resource Name (ARN) specifying the role. For more information about ARNs and
         * how to use them in policies, see IAM Identifiers in the IAM User Guide guide.
         * Type: String
         * Length Constraints: Minimum length of 20. Maximum length of 2048.
         * Required: Yes
         */
        global String arn;

        /**
         * The policy that grants an entity permission to assume the role.
         * Type: String
         * Length Constraints: Minimum length of 1. Maximum length of 131072.
         * Pattern: [\u0009\u000A\u000D\u0020-\u00FF]+
         * Required: No
         */
        global String assumeRolePolicyDocument;

        /**
         * The date and time, in ISO 8601 date-time format, when the role was created.
         * Type: Timestamp
         * Required: Yes
         */
        global Datetime createDate;

        /**
         * A description of the role that you provide.
         * Type: String
         * Length Constraints: Maximum length of 1000.
         * Pattern: [\p{L}\p{M}\p{Z}\p{S}\p{N}\p{P}]*
         * Required: No
         */
        global String description;

        /**
         * The maximum session duration (in seconds) for the specified role. Anyone who uses the AWS
         * CLI, or API to assume the role can specify the duration using the optional
         * DurationSeconds API parameter or duration-seconds CLI parameter.
         * Type: Integer
         * Valid Range: Minimum value of 3600. Maximum value of 43200.
         * Required: No
         */
        global Integer maxSessionDuration;

        /**
         * The path to the role. For more information about paths, see IAM Identifiers in the IAM
         * User Guide.
         * Type: String
         * Length Constraints: Minimum length of 1. Maximum length of 512.
         * Pattern: (\u002F)|(\u002F[\u0021-\u007F]+\u002F)
         * Required: Yes
         */
        global String path;

        /**
         * The ARN of the policy used to set the permissions boundary for the role.
         * For more information about permissions boundaries, see Permissions Boundaries for IAM
         * Identities in the IAM User Guide.
         * Type: AttachedPermissionsBoundary object
         * Required: No
         */
        global AttachedPermissionsBoundary permissionBoundary;

        /**
         * The stable and unique string identifying the role. For more information about IDs, see
         * IAM Identifiers in the IAM User Guide.
         * Type: String
         * Length Constraints: Minimum length of 16. Maximum length of 128.
         * Pattern: [\w]+
         * Required: Yes
         */
        global String roleId;

        /**
         * Contains information about the last time that an IAM role was used. This includes the
         * date and time and the Region in which the role was last used. Activity is only reported
         * for the trailing 400 days. This period can be shorter if your Region began supporting
         * these features within the last year. The role might have been used more than 400 days
         * ago. For more information, see Regions Where Data Is Tracked in the IAM User Guide.
         * Type: RoleLastUsed object
         * Required: No
         */
        global RoleLastUsed roleLastUsed;

        /**
         * The friendly name that identifies the role.
         * Type: String
         * Length Constraints: Minimum length of 1. Maximum length of 64.
         * Pattern: [\w+=,.@-]+
         * Required: Yes
         */
        global String roleName;
        
        /**
         * A list of tags that are attached to the specified role. For more information about
         * tagging, see Tagging IAM Identities in the IAM User Guide.
         * Type: Array of Tag objects
         * Array Members: Maximum number of 50 items.
         * Required: No
         */
        global List<Tag> tags;
    }

    /**
     * Contains information about an attached permissions boundary. An attached permissions boundary
     * is a managed policy that has been attached to a user or role to set the permissions boundary.
     * 
     * https://docs.aws.amazon.com/IAM/latest/APIReference/API_AttachedPermissionsBoundary.html
     */
    global class AttachedPermissionsBoundary
    {
        /**
         * The ARN of the policy used to set the permissions boundary for the user or role.
         * Type: String
         * Length Constraints: Minimum length of 20. Maximum length of 2048.
         * Required: No
         */
        global String permissionsBoundaryArn;

        /**
         * The permissions boundary usage type that indicates what type of IAM resource is used as
         * the permissions boundary for an entity. This data type can only have a value of Policy.
         * Type: String
         * Valid Values: PermissionsBoundaryPolicy
         * Required: No
         */
        global String permissionsBoundaryType;
    }

    /**
     * Contains information about the last time that an IAM role was used. This includes the date
     * and time and the Region in which the role was last used. Activity is only reported for the
     * trailing 400 days. This period can be shorter if your Region began supporting these features
     * within the last year. The role might have been used more than 400 days ago. For more
     * information, see Regions Where Data Is Tracked in the IAM User Guide.
     * 
     * https://docs.aws.amazon.com/IAM/latest/APIReference/API_RoleLastUsed.html
     */
    global class RoleLastUsed
    {
        /**
         * The date and time, in ISO 8601 date-time format that the role was last used.
         * This field is null if the role has not been used within the IAM tracking period. For more
         * information about the tracking period, see Regions Where Data Is Tracked in the IAM User
         * Guide.
         * Type: Timestamp
         * Required: No
         */
        global Datetime lastUsedDate;

        /**
         * The name of the AWS Region in which the role was last used.
         * Type: String
         * Required: No
         */
        global String region;
    }
    
    global class Tags
    {
        global List<Tag> entry;
    }

    /**
     * A structure that represents user-provided metadata that can be associated with a resource
     * such as an IAM user or role. For more information about tagging, see Tagging IAM Identities
     * in the IAM User Guide.
     * 
     * https://docs.aws.amazon.com/IAM/latest/APIReference/API_Tag.html
     */
    global class Tag
    {
        /**
         * The key name that can be used to look up or retrieve the associated value. For example,
         * Department or Cost Center are common choices.
         * Type: String
         * Length Constraints: Minimum length of 1. Maximum length of 128.
         * Pattern: [\p{L}\p{Z}\p{N}_.:/=+\-@]+
         * Required: Yes
         */
        global String key;

        /**
         * The value associated with this tag. For example, tags with a key name of Department could
         * have values such as Human Resources, Accounting, and Support. Tags with a key name of
         * Cost Center might have values that consist of the number associated with the different
         * cost centers in your company. Typically, many resources have tags with the same key name
         * but with different values.
         * Type: String
         * Length Constraints: Minimum length of 0. Maximum length of 256.
         * Pattern: [\p{L}\p{Z}\p{N}_.:/=+\-@]*
         * Required: Yes
         */
        global String value;
    }
}