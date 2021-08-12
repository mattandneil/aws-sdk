@IsTest class SNSTest
{
    @IsTest static void testConfirmSubscriptionRequest()
    {
        // arrange
        SNS.ConfirmSubscriptionRequest request = new SNS.ConfirmSubscriptionRequest();
        request.url = 'callout:sns';
        request.authenticateOnUnsubscribe = 'true';
        request.token = '1234567890abcdef1234567890abcdef1234567890abcdef1234567890abcdef1234567890abcdef1234567890abcdef1234567890abcdef1234567890abcdef1234567890abcdef1234567890abcdef1234567890abcdef1234567890abcdef1234567890abcdef1234567890abcdef';
        request.topicArn = 'arn:aws:sns:us-east-1:123456789012:Test';
        
        // act
        HttpRequest http = request(request);
        Map<String,String> params = params(http);
        
        // assert
        System.assertEquals('POST', http.getMethod());
        System.assertEquals('callout:sns', http.getEndpoint());
        System.assertEquals('ConfirmSubscription', params.get('Action'));
        System.assertEquals('true', params.get('AuthenticateOnUnsubscribe'));
        System.assertEquals('1234567890abcdef1234567890abcdef1234567890abcdef1234567890abcdef1234567890abcdef1234567890abcdef1234567890abcdef1234567890abcdef1234567890abcdef1234567890abcdef1234567890abcdef1234567890abcdef1234567890abcdef1234567890abcdef', params.get('Token'));
        System.assertEquals('arn:aws:sns:us-east-1:123456789012:Test', params.get('TopicArn'));
    }
    
    @IsTest static void testConfirmSubscriptionResponse()
    {
        // act
        SNS.ConfirmSubscriptionRequest request = new SNS.ConfirmSubscriptionRequest();
        SNS.ConfirmSubscriptionResponse response = new SNS.ConfirmSubscription().call(request);
        
        // assert
        System.assertEquals('arn:aws:sns:us-east-1:123456789012:Test:11223344-5566-7788-9900-aabbccddeeff', response.confirmSubscriptionResult.subscriptionArn);
    }
    
    @IsTest static void testCreateTopicRequest()
    {
        // arrange
        SNS.CreateTopicRequest request = new SNS.CreateTopicRequest();
        request.url = 'callout:sns';
        request.name = 'Test';
        request.attributes = new SNS.Attributes();
        request.attributes.entry = new List<SNS.Attribute>();
        request.attributes.entry.add(new SNS.Attribute());
        request.attributes.entry[0].key = 'kkk';
        request.attributes.entry[0].value = 'vvv';
        request.tags = new SNS.Tags();
        request.tags.member = new List<SNS.Tag>();
        request.tags.member.add(new SNS.Tag());
        request.tags.member[0].key = 'kkk';
        request.tags.member[0].value = 'vvv';
        
        // act
        HttpRequest http = request(request);
        Map<String,String> params = params(http);
        
        // assert
        System.assertEquals('POST', http.getMethod());
        System.assertEquals('callout:sns', http.getEndpoint());
        System.assertEquals('CreateTopic', params.get('Action'));
        System.assertEquals('Test', params.get('Name'));
        System.assertEquals('kkk', params.get('Attributes.Entry.1.Key'));
        System.assertEquals('vvv', params.get('Attributes.Entry.1.Value'));
        System.assertEquals('kkk', params.get('Tags.Member.1.Key'));
        System.assertEquals('vvv', params.get('Tags.Member.1.Value'));
    }
    
    @IsTest static void testCreateTopicResponse()
    {
        // act
        SNS.CreateTopicRequest request = new SNS.CreateTopicRequest();
        SNS.CreateTopicResponse response = new SNS.CreateTopic().call(request);
        
        // assert
        System.assertEquals('arn:aws:sns:us-east-1:123456789012:Test', response.createTopicResult.topicArn);
    }
    
    @IsTest static void testDeleteTopicRequest()
    {
        // arrange
        SNS.DeleteTopicRequest request = new SNS.DeleteTopicRequest();
        request.url = 'callout:sns';
        request.topicArn = 'arn:aws:sns:us-east-1:123456789012:Test';
        
        // act
        HttpRequest http = request(request);
        Map<String,String> params = params(http);
        
        // assert
        System.assertEquals('POST', http.getMethod());
        System.assertEquals('callout:sns', http.getEndpoint());
        System.assertEquals('DeleteTopic', params.get('Action'));
        System.assertEquals('arn:aws:sns:us-east-1:123456789012:Test', params.get('TopicArn'));
    }
    
    @IsTest static void testDeleteTopicResponse()
    {
        // act
        SNS.DeleteTopicRequest request = new SNS.DeleteTopicRequest();
        SNS.DeleteTopicResponse response = new SNS.DeleteTopic().call(request);
        
        // assert
        System.assertEquals('{}', Json.serialize(response));
    }
    
    @IsTest static void testListTopicsRequest()
    {
        // arrange
        SNS.ListTopicsRequest request = new SNS.ListTopicsRequest();
        request.url = 'callout:sns';
        request.nextToken = 'abcdefghijklmnopqr1234567890ABCDEFGHIJKLMNOPQRST';

        // act
        HttpRequest http = request(request);
        Map<String,String> params = params(http);

        // assert
        System.assertEquals('POST', http.getMethod());
        System.assertEquals('callout:sns', http.getEndpoint());
        System.assertEquals('ListTopics', params.get('Action'));
        System.assertEquals('abcdefghijklmnopqr1234567890ABCDEFGHIJKLMNOPQRST', params.get('NextToken'));
    }
    
    @IsTest static void testListTopicsResponse()
    {
        // act
        SNS.ListTopicsRequest request = new SNS.ListTopicsRequest();
        SNS.ListTopicsResponse response = new SNS.ListTopics().call(request);
        
        // assert
        System.assertEquals('arn:aws:sns:us-east-1:123456789012:Test', response.listTopicsResult.topics[0].topicArn);
    }
    
    @IsTest static void testPublishRequest()
    {
        // arrange
        SNS.PublishRequest request = new SNS.PublishRequest();
        request.url = 'callout:sns';
        request.message = 'Test';
        request.messageAttributes = new SNS.MessageAttributes();
        request.messageAttributes.entry = new List<SNS.MessageAttribute>();
        request.messageAttributes.entry.add(new SNS.MessageAttribute());
        request.messageAttributes.entry[0].name = 'name';
        request.messageAttributes.entry[0].value = new SNS.MessageAttributeValue();
        request.messageAttributes.entry[0].value.dataType = 'String';
        request.messageAttributes.entry[0].value.stringValue = 'Value';
        request.messageAttributes.entry[0].value.binaryValue = EncodingUtil.base64Decode('xpdf');
        request.messageStructure = 'json';
        request.phoneNumber = '+1.1234567890';
        request.subject = 'Test';
        request.targetArn = 'arn:aws:sns:us-east-1:123456789012:Test';
        request.topicArn = 'arn:aws:sns:us-east-1:123456789012:Test';
        
        // act
        HttpRequest http = request(request);
        Map<String,String> params = params(http);
        
        // assert
        System.assertEquals('POST', http.getMethod());
        System.assertEquals('callout:sns', http.getEndpoint());
        System.assertEquals('Publish', params.get('Action'));
        System.assertEquals('Test', params.get('Message'));
        System.assertEquals('name', params.get('MessageAttributes.Entry.1.Name'));
        System.assertEquals('String', params.get('MessageAttributes.Entry.1.Value.DataType'));
        System.assertEquals('Value', params.get('MessageAttributes.Entry.1.Value.StringValue'));
        System.assertEquals('xpdf', params.get('MessageAttributes.Entry.1.Value.BinaryValue'));
        System.assertEquals('json', params.get('MessageStructure'));
        System.assertEquals('+1.1234567890', params.get('PhoneNumber'));
        System.assertEquals('Test', params.get('Subject'));
        System.assertEquals('arn:aws:sns:us-east-1:123456789012:Test', params.get('TopicArn'));
        System.assertEquals('arn:aws:sns:us-east-1:123456789012:Test', params.get('TargetArn'));
    }
    
    @IsTest static void testPublishResponse()
    {
        // act
        SNS.PublishRequest request = new SNS.PublishRequest();
        SNS.PublishResponse response = new SNS.Publish().call(request);
        
        // assert
        System.assertEquals('11223344-5566-7788-9900-aabbccddeeff', response.publishResult.messageId);
        
    }
    
    @IsTest static void testListSubscriptionsRequest()
    {
        // arrange
        SNS.ListSubscriptionsRequest request = new SNS.ListSubscriptionsRequest();
        request.url = 'callout:sns';
        request.nextToken = 'abcdefghijklmnopqr1234567890ABCDEFGHIJKLMNOPQRST';
        
        // act
        HttpRequest http = request(request);
        Map<String,String> params = params(http);
        
        // assert
        System.assertEquals('POST', http.getMethod());
        System.assertEquals('callout:sns', http.getEndpoint());
        System.assertEquals('ListSubscriptions', params.get('Action'));
        System.assertEquals('abcdefghijklmnopqr1234567890ABCDEFGHIJKLMNOPQRST', params.get('NextToken'));
    }
    
    @IsTest static void testListSubscriptionsResponse()
    {
        // act
        SNS.ListSubscriptionsRequest request = new SNS.ListSubscriptionsRequest();
        SNS.ListSubscriptionsResponse response = new SNS.ListSubscriptions().call(request);
        
        // assert
        System.assertEquals('123456789012', response.listSubscriptionsResult.subscriptions[0].owner);
        System.assertEquals('email', response.listSubscriptionsResult.subscriptions[0].protocol);
        System.assertEquals('email1@example.com', response.listSubscriptionsResult.subscriptions[0].endpoint);
        System.assertEquals('arn:aws:sns:us-east-1:123456789012:Test1:11223344-5566-7788-9900-aabbccddeeff', response.listSubscriptionsResult.subscriptions[0].subscriptionArn);
        System.assertEquals('arn:aws:sns:us-east-1:123456789012:Test1', response.listSubscriptionsResult.subscriptions[0].topicArn);
        System.assertEquals('abcdefghijklmnopqr1234567890ABCDEFGHIJKLMNOPQRST', response.listSubscriptionsResult.nextToken);
        
        System.assertEquals('123456789012', response.listSubscriptionsResult.subscriptions[1].owner);
        System.assertEquals('json', response.listSubscriptionsResult.subscriptions[1].protocol);
        System.assertEquals('email2@example.com', response.listSubscriptionsResult.subscriptions[1].endpoint);
        System.assertEquals('arn:aws:sns:us-east-1:123456789012:Test2:11223344-5566-7788-9900-aabbccddeeff', response.listSubscriptionsResult.subscriptions[1].subscriptionArn);
        System.assertEquals('arn:aws:sns:us-east-1:123456789012:Test2', response.listSubscriptionsResult.subscriptions[1].topicArn);
        System.assertEquals('abcdefghijklmnopqr1234567890ABCDEFGHIJKLMNOPQRST', response.listSubscriptionsResult.nextToken);
    }
    
    @IsTest static void testSubscribeRequest()
    {
        // arrange
        SNS.SubscribeRequest request = new SNS.SubscribeRequest();
        request.url = 'callout:sns';
        request.attributes = new SNS.Attributes();
        request.attributes.entry = new List<SNS.Attribute>();
        request.attributes.entry.add(new SNS.Attribute());
        request.attributes.entry[0].key = 'kkk';
        request.attributes.entry[0].value = 'vvv';
        request.endpoint = 'email@example.com';
        request.protocol = 'email-json';
        request.returnSubscriptionArn = 'true';
        request.topicArn = 'arn:aws:sns:us-east-1:123456789012:Test';
        
        // act
        HttpRequest http = request(request);
        Map<String,String> params = params(http);
        
        // assert
        System.assertEquals('POST', http.getMethod());
        System.assertEquals('callout:sns', http.getEndpoint());
        System.assertEquals('Subscribe', params.get('Action'));
        System.assertEquals('kkk', params.get('Attributes.Entry.1.Key'));
        System.assertEquals('vvv', params.get('Attributes.Entry.1.Value'));
        System.assertEquals('email@example.com', params.get('Endpoint'));
        System.assertEquals('email-json', params.get('Protocol'));
        System.assertEquals('true', params.get('ReturnSubscriptionArn'));
        System.assertEquals('arn:aws:sns:us-east-1:123456789012:Test', params.get('TopicArn'));
    }
    
    @IsTest static void testSubscribeResponse()
    {
        // act
        SNS.SubscribeRequest request = new SNS.SubscribeRequest();
        SNS.SubscribeResponse response = new SNS.Subscribe().call(request);
        
        // assert
        System.assertEquals('pending confirmation', response.subscribeResult.SubscriptionArn);
    }
    
    static Map<String,String> params(HttpRequest request)
    {
        return new PageReference('/?' + request.getBody()).getParameters().clone();
    }
    
    static HttpRequest request(Object args)
    {
        try
        {
            Type reflector = typeForInstance(args);
            Callable sdk = (Callable)Type.forName('AWS.SDK').newInstance();
            Test.setMock(HttpCalloutMock.class, new Mock());
            sdk.call(reflector.getName(), (Map<String,Object>)
            Json.deserializeUntyped(Json.serialize(args)));
        }
        catch (Exception e)
        {
            if (e.getMessage() != 'callout:test') throw e;
        }

        return request;
    }
    
    static HttpRequest request;
    
    public class Mock implements HttpCalloutMock
    {
        public HttpResponse respond(HttpRequest httpRequest)
        {
            request  = httpRequest;
            throw new CalloutException('callout:test');
        }
    }
    
    /**
     * Type of instance, invented by Rob Strunk:
     * https://twitter.com/mattandneil/status/1222505404443348994
     */
    static public Type typeForInstance(Object instance)
    {
        try
        {
            // attempt runtime cast
            instance = (Type)(Object)instance;
            return Type.class;
        }
        catch (TypeException e)
        {
            String name = e.getMessage().substringBetween(' type ', ' to ');
            return Type.forName(name);
        }
    }
}