/**
* Salesforce Apex SDK for AWS EC2
 * 
 * Amazon Web Services documentation:
 * https://docs.aws.amazon.com/sns/latest/api/index.html
 * https://docs.aws.amazon.com/sns/latest/api/sns-api.pdf
 */
global class SNS
{
    private SNS()
    {
        //
    }
    
    /**
     * Verifies an endpoint owner's intent to receive messages by validating the token sent to the
     * endpoint by an earlier Subscribe action. If the token is valid, the action creates a new
     * subscription and returns its Amazon Resource Name (ARN). This call requires an AWS signature
     * only when the AuthenticateOnUnsubscribe flag is set to "true".
     * 
     * https://docs.aws.amazon.com/sns/latest/api/API_ConfirmSubscription.html
     */
    global class ConfirmSubscription implements HttpCalloutMock
    {
        global ConfirmSubscriptionResponse call(ConfirmSubscriptionRequest request)
        {
            if (Test.isRunningTest()) Test.setMock(HttpCalloutMock.class, this);
            System.Callable sdk = (System.Callable)Type.forName('AWS.SDK').newInstance();
            return (ConfirmSubscriptionResponse)sdk.call(ConfirmSubscriptionRequest.class.getName(),
            (Map<String,Object>)Json.deserializeUntyped(Json.serialize(request, true)));
        }
        
        public HttpResponse respond(HttpRequest request)
        {
            HttpResponse response = new HttpResponse();
            response.setStatusCode(200);
            response.setHeader('Content-Type', 'text/xml');
            response.setBody(''
                + '<ConfirmSubscriptionResponse xmlns="http://sns.amazonaws.com/doc/2010-03-31/">'
                +   '<ConfirmSubscriptionResult>'
                +     '<SubscriptionArn>arn:aws:sns:us-east-1:123456789012:Test:11223344-5566-7788-9900-aabbccddeeff</SubscriptionArn>'
                +   '</ConfirmSubscriptionResult>'
                +   '<ResponseMetadata>'
                +     '<RequestId>11223344-5566-7788-9900-aabbccddeeff</RequestId>'
                +   '</ResponseMetadata>'
                + '</ConfirmSubscriptionResponse>'
            );
            return response;
        }
    }

    /**
     * https://docs.aws.amazon.com/sns/latest/api/API_ConfirmSubscription.html#API_ConfirmSubscription_RequestParameters
     */
    global class ConfirmSubscriptionRequest
    {
        global String url = 'callout:SNS';

        /**
         * Disallows unauthenticated unsubscribes of the subscription. If the value of this
         * parameter is true and the request has an AWS signature, then only the topic owner and the
         * subscription owner can unsubscribe the endpoint. The unsubscribe action requires AWS
         * authentication.
         * Type: String
         * Required: No
         */
        global String authenticateOnUnsubscribe;

        /**
         * Short-lived token sent to an endpoint during the Subscribe action.
         * Type: String
         * Required: Yes
         */
        global String token;

        /**
         * The ARN of the topic for which you wish to confirm a subscription.
         * Type: String
         * Required: Yes
         */
        global String topicArn;
    }

    /**
     * https://docs.aws.amazon.com/sns/latest/api/API_ConfirmSubscription.html#API_ConfirmSubscription_ResponseElements
     */
    global class ConfirmSubscriptionResponse
    {
        global ConfirmSubscriptionResult confirmSubscriptionResult;
    }
    
    global class ConfirmSubscriptionResult
    {
        /**
         * The ARN of the created subscription.
         * Type: String
         */
        global String subscriptionArn;
    }
    
    
    
    /**
     * https://docs.aws.amazon.com/sns/latest/api/API_CreateTopic.html
     */
    global class CreateTopic implements HttpCalloutMock
    {
        global CreateTopicResponse call(CreateTopicRequest request)
        {
            if (Test.isRunningTest()) Test.setMock(HttpCalloutMock.class, this);
            System.Callable sdk = (System.Callable)Type.forName('AWS.SDK').newInstance();
            return (CreateTopicResponse)sdk.call(CreateTopicRequest.class.getName(),
            (Map<String,Object>)Json.deserializeUntyped(Json.serialize(request, true)));
        }
        
        public HttpResponse respond(HttpRequest request)
        {
            HttpResponse response = new HttpResponse();
            response.setStatusCode(200);
            response.setHeader('x-amzn-RequestId', '11223344-5566-7788-9900-aabbccddeeff');
            response.setHeader('Content-Length', '311');
            response.setHeader('Date', 'Wed, 25 Dec 2019 23:59:59 GMT');
            response.setHeader('Content-Type', 'text/xml');
            response.setBody(''
                + '<CreateTopicResponse xmlns="http://sns.amazonaws.com/doc/2010-03-31/">'
                +   '<CreateTopicResult>'
                +     '<TopicArn>arn:aws:sns:us-east-1:123456789012:Test</TopicArn>'
                +   '</CreateTopicResult>'
                +   '<ResponseMetadata>'
                +     '<RequestId>11223344-5566-7788-9900-aabbccddeeff</RequestId>'
                +   '</ResponseMetadata>'
                + '</CreateTopicResponse>'
            );
            return response;
        }
    }

    /**
     * https://docs.aws.amazon.com/sns/latest/api/API_CreateTopic.html#API_CreateTopic_RequestParameters
     */
    global class CreateTopicRequest
    {
        global String url = 'callout:SNS';
        
        /**
         * A map of attributes with their corresponding values.
         * The following lists the names, descriptions, and values of the special request parameters
         * that the CreateTopic action uses:
         * - DeliveryPolicy – The policy that defines how Amazon SNS retries failed deliveries to
         *   HTTP/S endpoints.
         * - DisplayName – The display name to use for a topic with SMS subscriptions.
         * - Policy – The policy that defines who can access your topic. By default, only the topic
         *   owner can publish or subscribe to the topic.
         * The following attribute applies only to server-side-encryption:
         * - KmsMasterKeyId - The ID of an AWS-managed customer master key (CMK) for Amazon SNS or a
         * custom CMK. For more information, see Key Terms. For more examples, see KeyId in the AWS
         * Key Management Service API Reference.
         * Type: String to string map
         * Required: No
         */
        global Attributes attributes;
        
        /**
         * The name of the topic you want to create.
         * Constraints: Topic names must be made up of only uppercase and lowercase ASCII letters,
         * numbers, underscores, and hyphens, and must be between 1 and 256 characters long.
         * Type: String
         * Required: Yes
         */
        global String name;

        /**
         * The list of tags to add to a new topic.
         * Type: Array of Tag objects
         * Required: No
         */
        global Tags tags;
    }

    /**
     * https://docs.aws.amazon.com/sns/latest/api/API_CreateTopic.html#API_CreateTopic_ResponseElements
     */
    global class CreateTopicResponse
    {
        global CreateTopicResult createTopicResult;
    }
    
    global class CreateTopicResult
    {
        /**
         * The Amazon Resource Name (ARN) assigned to the created topic.
         */
        global String topicArn;
    }
    
    /**
     * https://docs.aws.amazon.com/sns/latest/api/API_DeleteTopic.html
     */
    global class DeleteTopic implements HttpCalloutMock
    {
        global DeleteTopicResponse call(DeleteTopicRequest request)
        {
            if (Test.isRunningTest()) Test.setMock(HttpCalloutMock.class, this);
            System.Callable sdk = (System.Callable)Type.forName('AWS.SDK').newInstance();
            return (DeleteTopicResponse)sdk.call(DeleteTopicRequest.class.getName(),
            (Map<String,Object>)Json.deserializeUntyped(Json.serialize(request, true)));
        }
        
        public HttpResponse respond(HttpRequest request)
        {
            HttpResponse response = new HttpResponse();
            response.setStatusCode(200);
            response.setHeader('Content-Type', 'text/xml');
            response.setBody(''
                + '<DeleteTopicResponse xmlns="http://sns.amazonaws.com/doc/2010-03-31/">'
                +   '<ResponseMetadata>'
                +     '<RequestId>11223344-5566-7788-9900-aabbccddeeff</RequestId>'
                +   '</ResponseMetadata>'
                + '</DeleteTopicResponse>'
            );
            return response;
        }
    }

    /**
     * https://docs.aws.amazon.com/sns/latest/api/API_DeleteTopic.html#API_DeleteTopic_RequestParameters
     */
    global class DeleteTopicRequest
    {
        global String url = 'callout:SNS';

        /**
         * The ARN of the topic you want to delete.
         */
        global String topicArn;
    }
    
    /**
     * https://docs.aws.amazon.com/sns/latest/api/API_DeleteTopic.html#API_DeleteTopic_Example_1_Response
     */
    global class DeleteTopicResponse
    {
        //
    }
    
    /**
     * https://docs.aws.amazon.com/sns/latest/api/API_ListTopics.html
     */
    global class ListTopics implements HttpCalloutMock
    {
        global ListTopicsResponse call(ListTopicsRequest request)
        {
            if (Test.isRunningTest()) Test.setMock(HttpCalloutMock.class, this);
            System.Callable sdk = (System.Callable)Type.forName('AWS.SDK').newInstance();
            return (ListTopicsResponse)sdk.call(ListTopicsRequest.class.getName(),
            (Map<String,Object>)Json.deserializeUntyped(Json.serialize(request, true)));
        }
        
        public HttpResponse respond(HttpRequest request)
        {
            HttpResponse response = new HttpResponse();
            response.setStatusCode(200);
            response.setHeader('Content-Type', 'text/xml');
            response.setBody(''
                + '<ListTopicsResponse xmlns="http://sns.amazonaws.com/doc/2010-03-31/">'
                +   '<ListTopicsResult>'
                +     '<Topics>'
                +       '<member>'
                +         '<TopicArn>arn:aws:sns:us-east-1:123456789012:Test</TopicArn>'
                +       '</member>'
                +     '</Topics>'
                +   '</ListTopicsResult>'
                +   '<ResponseMetadata>'
                +     '<RequestId>11223344-5566-7788-9900-aabbccddeeff</RequestId>'
                +   '</ResponseMetadata>'
                + '</ListTopicsResponse>'
            );
            return response;
        }
    }

    
    
    /**
     * https://docs.aws.amazon.com/sns/latest/api/API_ListTopics.html#API_ListTopics_RequestParameters
     */
    global class ListTopicsRequest
    {
        global String url = 'callout:SNS';
        
        /**
         * Token returned by the previous ListTopics request.
         * Type: String
         * Required: No
         */
        global String nextToken;
    }

    /**
     * https://docs.aws.amazon.com/sns/latest/api/API_ListTopics.html#API_ListTopics_ResponseElements
     */
    global class ListTopicsResponse
    {
        global ListTopicsResult listTopicsResult;
    }
    
    global class ListTopicsResult
    {
        /**
         * Token to pass along to the next ListTopics request.
         * This element is returned if there are additional topics to retrieve.
         */
        global String nextToken;

        /**
         * A list of topic ARNs.
         */
        global List<Topic> topics;
    }

    /**
     * https://docs.aws.amazon.com/sns/latest/api/API_Publish.html
     */
    global class Publish implements HttpCalloutMock
    {
        global PublishResponse call(PublishRequest request)
        {
            if (Test.isRunningTest()) Test.setMock(HttpCalloutMock.class, this);
            System.Callable sdk = (System.Callable)Type.forName('AWS.SDK').newInstance();
            return (PublishResponse)sdk.call(PublishRequest.class.getName(),
            (Map<String,Object>)Json.deserializeUntyped(Json.serialize(request, true)));
        }
        
        public HttpResponse respond(HttpRequest request)
        {
            HttpResponse response = new HttpResponse();
            response.setStatusCode(200);
            response.setHeader('Content-Type', 'text/xml');
            response.setBody(''
                + '<PublishResponse xmlns="http://sns.amazonaws.com/doc/2010-03-31/">'
                +   '<PublishResult>'
                +     '<MessageId>11223344-5566-7788-9900-aabbccddeeff</MessageId>'
                +   '</PublishResult>'
                +   '<ResponseMetadata>'
                +     '<RequestId>11223344-5566-7788-9900-aabbccddeeff</RequestId>'
                +   '</ResponseMetadata>'
                + '</PublishResponse>'
            );
            return response;
        }
        
        
    }

    /**
     * https://docs.aws.amazon.com/sns/latest/api/API_Publish.html#API_Publish_RequestParameters
     */
    global class PublishRequest
    {
        global String url = 'callout:SNS';

        /**
         * The message you want to send.
         * 
         * If you are publishing to a topic and you want to send the same message to all transport
         * protocols, include the text of the message as a String value. If you want to send
         * different messages for each transport protocol, set the value of the MessageStructure
         * parameter to json and use a JSON object for the Message parameter. See the Examples
         * section for the format of the JSON object.
         * 
         * Constraints:
         * - With the exception of SMS, messages must be UTF-8 encoded strings and at most 256 KB
         *   in size (262,144 bytes, not 262,144 characters).
         * - For SMS, each message can contain up to 140 characters. This character limit depends on
         *   the encoding schema. For example, an SMS message can contain 160 GSM characters, 140
         *   ASCII characters, or 70 UCS-2 characters.
         * - If you publish a message that exceeds this size limit, Amazon SNS sends the message as
         *   multiple messages, each fitting within the size limit. Messages aren't truncated
         *   mid-word but are cut off at whole-word boundaries.
         * - The total size limit for a single SMS Publish action is 1,600 characters.
         * 
         * JSON-specific constraints:
         * - Keys in the JSON object that correspond to supported transport protocols must have
         *   simple JSON string values.
         * - The values will be parsed (unescaped) before they are used in outgoing messages.
         * - Outbound notifications are JSON encoded (meaning that the characters will be reescaped
         *   for sending).
         * - Values have a minimum length of 0 (the empty string, "", is allowed).
         * - Values have a maximum length bounded by the overall message size (so, including
         *   multiple protocols may limit message sizes).
         * - Non-string values will cause the key to be ignored.
         * - Keys that do not correspond to supported transport protocols are ignored.
         * - Duplicate keys are not allowed.
         * - Failure to parse or validate any key or value in the message will cause the Publish
         *   call to return an error (no partial delivery).
         * Type: String
         * Required: Yes
         */
        global String message;

        /**
         * Message attributes for Publish action.
         * Type: String to MessageAttributeValue object map
         * Required: No
         */
        global MessageAttributes messageAttributes;

        /**
         * Set MessageStructure to json if you want to send a different message for each protocol.
         * For example, using one publish action, you can send a short message to your SMS
         * subscribers and a longer message to your email subscribers. If you set MessageStructure
         * to json, the value of the Message parameter must:
         * - be a syntactically valid JSON object; and
         * - contain at least a top-level JSON key of "default" with a value that is a string.
         * You can define other top-level keys that define the message you want to send to a
         * specific transport protocol (e.g., "http").
         * Valid value: json
         * Type: String
         * Required: No
         */
        global String messageStructure;

        /**
         * The phone number to which you want to deliver an SMS message. Use E.164 format.
         * If you don't specify a value for the PhoneNumber parameter, you must specify a value for
         * the TargetArn or TopicArn parameters.
         * Type: String
         * Required: No
         */
        global String phoneNumber;

        /**
         * Optional parameter to be used as the "Subject" line when the message is delivered to
         * email endpoints. This field will also be included, if present, in the standard JSON
         * messages delivered to other endpoints.
         * Constraints: Subjects must be ASCII text that begins with a letter, number, or
         * punctuation mark; must not include line breaks or control characters; and must be less
         * than 100 characters long.
         * Type: String
         * Required: No
         */
        global String subject;

        /**
         * If you don't specify a value for the TargetArn parameter, you must specify a value for
         * the PhoneNumber or TopicArn parameters.
         * Type: String
         * Required: No
         */
        global String targetArn;

        /**
         * The topic you want to publish to.
         * If you don't specify a value for the TopicArn parameter, you must specify a value for the
         * PhoneNumber or TargetArn parameters.
         * Type: String
         * Required: No
         */
        global String topicArn;
    }
    
    /**
     * https://docs.aws.amazon.com/sns/latest/api/API_Publish.html#API_Publish_ResponseElements
     */
    global class PublishResponse
    {
        global PublishResult publishResult;
    }
    
    global class PublishResult
    {
        /**
         * Unique identifier assigned to the published message.
         * Length Constraint: Maximum 100 characters
         * Type: String
         */
        global String messageId;
    }
    
    /**
     * https://docs.aws.amazon.com/sns/latest/api/API_ListSubscriptions.html
     */
    global class ListSubscriptions implements HttpCalloutMock
    {
        global ListSubscriptionsResponse call(ListSubscriptionsRequest request)
        {
            if (Test.isRunningTest()) Test.setMock(HttpCalloutMock.class, this);
            System.Callable sdk = (System.Callable)Type.forName('AWS.SDK').newInstance();
            return (ListSubscriptionsResponse)sdk.call(ListSubscriptionsRequest.class.getName(),
            (Map<String,Object>)Json.deserializeUntyped(Json.serialize(request, true)));
        }
        
        public HttpResponse respond(HttpRequest request)
        {
            HttpResponse response = new HttpResponse();
            response.setStatusCode(200);
            response.setHeader('Content-Type', 'text/xml');
            response.setBody(''
                + '<ListSubscriptionsResponse xmlns="http://sns.amazonaws.com/doc/2010-03-31/">'
                +   '<ListSubscriptionsResult>'
                +     '<Subscriptions>'
                +       '<member>'
                +         '<Owner>123456789012</Owner>'
                +         '<Protocol>email</Protocol>'
                +         '<Endpoint>email1@example.com</Endpoint>'
                +         '<SubscriptionArn>arn:aws:sns:us-east-1:123456789012:Test1:11223344-5566-7788-9900-aabbccddeeff</SubscriptionArn>'
                +         '<TopicArn>arn:aws:sns:us-east-1:123456789012:Test1</TopicArn>'
                +       '</member>'
                +       '<member>'
                +         '<Owner>123456789012</Owner>'
                +         '<Protocol>json</Protocol>'
                +         '<Endpoint>email2@example.com</Endpoint>'
                +         '<SubscriptionArn>arn:aws:sns:us-east-1:123456789012:Test2:11223344-5566-7788-9900-aabbccddeeff</SubscriptionArn>'
                +         '<TopicArn>arn:aws:sns:us-east-1:123456789012:Test2</TopicArn>'
                +       '</member>'
                +     '</Subscriptions>'
                +     '<NextToken>abcdefghijklmnopqr1234567890ABCDEFGHIJKLMNOPQRST</NextToken>'
                +   '</ListSubscriptionsResult>'
                +   '<ResponseMetadata>'
                +     '<RequestId>11223344-5566-7788-9900-aabbccddeeff</RequestId>'
                +   '</ResponseMetadata>'
                + '</ListSubscriptionsResponse>'
            );
            return response;
        }
    }

    /**
     * https://docs.aws.amazon.com/sns/latest/api/API_ListSubscriptions.html#API_ListSubscriptions_RequestParameters
     */
    global class ListSubscriptionsRequest
    {
        global String url = 'callout:SNS';
        
        /**
         * Token returned by the previous ListSubscriptions request.
         * Type: String
         * Required: No
         */
        global String nextToken;
    }

    /**
     * https://docs.aws.amazon.com/sns/latest/api/API_ListSubscriptions.html#API_ListSubscriptions_ResponseElements
     */
    global class ListSubscriptionsResponse
    {
        global ListSubscriptionsResult listSubscriptionsResult;
    }
    
    global class ListSubscriptionsResult
    {
        /**
         * Token to pass along to the next ListSubscriptions request. This element is returned if
         * there are more subscriptions to retrieve.
         * Type: String
         */
        global String nextToken;

        /**
         * A list of subscriptions.
         * Type: Array of Subscription objects
         */
        global List<Subscription> subscriptions;
    }
    
    /**
     * https://docs.aws.amazon.com/sns/latest/api/API_Subscribe.html
     */
    global class Subscribe implements HttpCalloutMock
    {
        global SubscribeResponse call(SubscribeRequest request)
        {
            if (Test.isRunningTest()) Test.setMock(HttpCalloutMock.class, this);
            System.Callable sdk = (System.Callable)Type.forName('AWS.SDK').newInstance();
            return (SubscribeResponse)sdk.call(SubscribeRequest.class.getName(),
            (Map<String,Object>)Json.deserializeUntyped(Json.serialize(request, true)));
        }
        
        public HttpResponse respond(HttpRequest request)
        {
            HttpResponse response = new HttpResponse();
            response.setStatusCode(200);
            response.setHeader('Content-Type', 'text/xml');
            response.setBody(''
                + '<SubscribeResponse xmlns="http://sns.amazonaws.com/doc/2010-03-31/">'
                +   '<SubscribeResult>'
                +     '<SubscriptionArn>pending confirmation</SubscriptionArn>'
                +   '</SubscribeResult>'
                +   '<ResponseMetadata>'
                +     '<RequestId>11223344-5566-7788-9900-aabbccddeeff</RequestId>'
                +   '</ResponseMetadata>'
                + '</SubscribeResponse>'
            );
            return response;
        }
    }

    /**
     * https://docs.aws.amazon.com/sns/latest/api/API_Subscribe.html#API_Subscribe_RequestParameters
     */
    global class SubscribeRequest
    {
        global String url = 'callout:SNS';
        
        /**
         * A map of attributes with their corresponding values.
         * The following lists the names, descriptions, and values of the special request parameters
         * that the SetTopicAttributes action uses:
         * - DeliveryPolicy – The policy that defines how Amazon SNS retries failed deliveries to
         *   HTTP/S endpoints.
         * - FilterPolicy – The simple JSON object that lets your subscriber receive only a subset
         *   of messages, rather than receiving every message published to the topic.
         * - RawMessageDelivery – When set to true, enables raw message delivery to Amazon SQS or
         *   HTTP/S endpoints. This eliminates the need for the endpoints to process JSON
         *   formatting, which is otherwise created for Amazon SNS metadata.
         * - RedrivePolicy – When specified, sends undeliverable messages to the specified Amazon
         *   SQS dead-letter queue. Messages that can't be delivered due to client errors (for
         *   example, when the subscribed endpoint is unreachable) or server errors (for example,
         *   when the service that powers the subscribed endpoint becomes unavailable) are held in
         *   the dead-letter queue for further analysis or reprocessing.
         * Type: String to string map
         * Required: No
         */
        global Attributes attributes;

        /**
         * The endpoint that you want to receive notifications. Endpoints vary by protocol:
         * - For the http protocol, the (public) endpoint is a URL beginning with http://
         * - For the https protocol, the (public) endpoint is a URL beginning with https://
         * - For the email protocol, the endpoint is an email address
         * - For the email-json protocol, the endpoint is an email address
         * - For the sms protocol, the endpoint is a phone number of an SMS-enabled device
         * - For the sqs protocol, the endpoint is the ARN of an Amazon SQS queue
         * - For the application protocol, the endpoint is the EndpointArn of a mobile app and device.
         * - For the lambda protocol, the endpoint is the ARN of an Amazon Lambda function.
         * Type: String
         * Required: No
         */
        global String endpoint;

        /**
         * The protocol you want to use. Supported protocols include:
         * - http – delivery of JSON-encoded message via HTTP POST
         * - https – delivery of JSON-encoded message via HTTPS POST
         * - email – delivery of message via SMTP
         * - email-json – delivery of JSON-encoded message via SMTP
         * - sms – delivery of message via SMS
         * - sqs – delivery of JSON-encoded message to an Amazon SQS queue
         * - application – delivery of JSON-encoded message to an EndpointArn for a mobile app and device.
         * - lambda – delivery of JSON-encoded message to an Amazon Lambda function.
         * Type: String
         * Required: Yes
         */
        global String protocol;

        /**
         * Sets whether the response from the Subscribe request includes the subscription ARN, even
         * if the subscription is not yet confirmed.
         * - If you have the subscription ARN returned, the response includes the ARN in all cases,
         *   even if the subscription is not yet confirmed.
         * - If you don't have the subscription ARN returned, in addition to the ARN for confirmed
         *   subscriptions, the response also includes the pending subscription ARN value for
         *   subscriptions that aren't yet confirmed. A subscription becomes confirmed when the
         *   subscriber calls the ConfirmSubscription action with a confirmation token.
         * If you set this parameter to true, .
         * The default value is false.
         * Type: Boolean
         * Required: No
         */
        global String returnSubscriptionArn;

        /**
         * The ARN of the topic you want to subscribe to.
         * Type: String
         * Required: Yes
         */
        global String topicArn;
    }

    /**
     * https://docs.aws.amazon.com/sns/latest/api/API_Subscribe.html#API_Subscribe_ResponseElements
     */
    global class SubscribeResponse
    {
        global SubscribeResult subscribeResult;
    }
    
    global class SubscribeResult
    {
        /**
         * The ARN of the subscription if it is confirmed, or the string "pending confirmation" if
         * the subscription requires confirmation. However, if the API request parameter
         * ReturnSubscriptionArn is true, then the value is always the subscription ARN, even if the
         * subscription requires confirmation.
         * Type: String
         */
        global String SubscriptionArn;
    }
    
    /**
     * A wrapper type for the attributes of an Amazon SNS subscription.
     * 
     * https://docs.aws.amazon.com/sns/latest/api/API_Subscription.html
     */
    global class Subscription
    {
        /**
         * The subscription's endpoint (format depends on the protocol).
         * Type: String
         * Required: No
         */
        global String endpoint;

        /**
         * The subscription's owner.
         * Type: String
         * Required: No
         */
        global String owner;

        /**
         * The subscription's protocol.
         * Type: String
         * Required: No
         */
        global String protocol;

        /**
         * The subscription's ARN.
         * Type: String
         * Required: No
         */
        global String subscriptionArn;

        /**
         * The ARN of the subscription's topic.
         * Type: String
         * Required: No
         */
        global String topicArn;
    }
    
    global class MessageAttributes
    {
        /**
         * MessageAttributes.entry.N.Name (key)
         * MessageAttributes.entry.N.Value (value)
         */
        global List<MessageAttribute> entry;
    }

    global class MessageAttribute
    {
        global String name;
        global MessageAttributeValue value;
    }
    
    /**
     * The user-specified message attribute value. For string data types, the value attribute has
     * the same restrictions on the content as the message body. For more information, see Publish.
     * 
     * https://docs.aws.amazon.com/sns/latest/api/API_MessageAttributeValue.html
     */
    global class MessageAttributeValue
    {
        /**
         * Binary type attributes can store any binary data, for example, compressed data, encrypted
         * data, or images.
         * Type: Base64-encoded binary data object
         * Required: No
         */
        global Blob binaryValue;

        /**
         * Amazon SNS supports the following logical data types: String, String.Array, Number, and
         * Binary. For more information, see Message Attribute Data Types.
         * Type: String
         * Required: Yes
         */
        global String dataType;

        /**
         * Strings are Unicode with UTF8 binary encoding. For a list of code values, see ASCII
         * Printable Characters.
         * Type: String
         * Required: No
         */
        global String stringValue;
    }
    
    global class Attributes
    {
        /**
         * Attributes.entry.N.key (key)
         * Attributes.entry.N.value (value)
         */
        global List<Attribute> entry;
    }
    
    global class Attribute
    {
        global String key;
        global String value;
    }

    global class Tags
    {
        global List<Tag> member;
    }

    /**
     * The list of tags to be added to the specified topic.
     * 
     * https://docs.aws.amazon.com/sns/latest/api/API_Tag.html
     */
    global class Tag
    {
        /**
         * The required key portion of the tag.
         * Type: String
         * Length Constraints: Minimum length of 1. Maximum length of 128.
         * Required: Yes
         */
        global String key;

        /**
         * The optional value portion of the tag.
         * Type: String
         * Length Constraints: Minimum length of 0. Maximum length of 256.
         * Required: Yes
         */
        global String value;
    }
    
    /**
     * A wrapper type for the topic's Amazon Resource Name (ARN). To retrieve a topic's attributes,
     * use GetTopicAttributes.
     * 
     * https://docs.aws.amazon.com/sns/latest/api/API_Topic.html
     */
    global class Topic
    {
        /**
         * The topic's ARN.
         * Type: String
         * Required: No
         */
        global String topicArn;
    }
}