@IsTest class IAMTest
{
    
    @IsTest static void testCreateRoleRequest()
    {
        // arrange
        IAM.CreateRoleRequest request = new IAM.CreateRoleRequest();
        request.url = 'callout:iam';
        request.roleName = 'Test';
        request.assumeRolePolicyDocument = '{"Version":"2012-10-17","Statement":[{"Effect":"Allow","Principal":{"Service":["lambda.amazonaws.com"]},"Action":["sts:AssumeRole"]}]}';
        request.description = 'Test';
        request.tags = new IAM.Tags();
        request.tags.entry = new List<IAM.Tag>();
        request.tags.entry.add(new IAM.Tag());
        request.tags.entry[0].key = 'kkk';
        request.tags.entry[0].value = 'vvv';

        // act
        HttpRequest http = request(request);
        Map<String,String> params = params(http);
        
        // assert
        System.assertEquals('POST', http.getMethod());
        System.assertEquals('callout:iam', http.getEndpoint());
        System.assertEquals('CreateRole', params.get('Action'));
        System.assertEquals('Test', params.get('RoleName'));
        System.assertEquals('{"Version":"2012-10-17","Statement":[{"Effect":"Allow","Principal":{"Service":["lambda.amazonaws.com"]},"Action":["sts:AssumeRole"]}]}', params.get('AssumeRolePolicyDocument'));
        System.assertEquals('Test', params.get('Description'));
        System.assertEquals('kkk', params.get('Tags.Entry.1.Key'));
        System.assertEquals('vvv', params.get('Tags.Entry.1.Value'));
    }
    
    @IsTest static void testCreateRoleResponse()
    {
        // act
        IAM.CreateRoleRequest request = new IAM.CreateRoleRequest();
        IAM.CreateRoleResponse response = new IAM.CreateRole().call(request);
        
        // assert
        System.assertEquals('%7B%22Version%22%3A%222012-10-17%22%2C%22Statement%22%3A%5B%7B%22Effect%22%3A%22Allow%22%2C%22Principal%22%3A%7B%22Service%22%3A%5B%22lambda.amazonaws.com%22%5D%7D%2C%22Action%22%3A%5B%22sts%3AAssumeRole%22%5D%7D%5D%7D', response.createRoleResult.role.assumeRolePolicyDocument);
        System.assertEquals('1234567890ABCDEFGHIJK', response.createRoleResult.role.roleId);
        System.assertEquals('Test', response.createRoleResult.role.roleName);
        System.assertEquals('arn:aws:iam::123456789012:role/Test', response.createRoleResult.role.arn);
        System.assertEquals('key', response.createRoleResult.role.tags[0].key);
        System.assertEquals('value', response.createRoleResult.role.tags[0].value);
        System.assertEquals(Datetime.newInstanceGmt(2020, 01, 01, 23, 59, 59), response.createRoleResult.role.createDate);
    }
    
    @IsTest static void testRoleDeleteRequest()
    {
        // arrange
        IAM.DeleteRoleRequest request = new IAM.DeleteRoleRequest();
        request.url = 'callout:iam';
        request.roleName = 'Test';
        
        // act
        HttpRequest http = request(request);
        Map<String,String> params = params(http);
        
        // assert
        System.assertEquals('POST', http.getMethod());
        System.assertEquals('callout:iam', http.getEndpoint());
        System.assertEquals('DeleteRole', params.get('Action'));
        System.assertEquals('Test', params.get('RoleName'));
    }
    
    @IsTest static void testRoleDeleteResponse()
    {
        // act
        IAM.DeleteRoleRequest request = new IAM.DeleteRoleRequest();
        IAM.DeleteRoleResponse response = new IAM.DeleteRole().call(request);
        
        // assert
        System.assertEquals('{}', Json.serialize(response));
    }
    
    @IsTest static void testGetRoleRequest()
    {
        // arrange
        IAM.GetRoleRequest request = new IAM.GetRoleRequest();
        request.url = 'callout:iam';
        request.roleName = 'Test';
        
        // act
        HttpRequest http = request(request);
        Map<String,String> params = params(http);
        
        // assert
        System.assertEquals('POST', http.getMethod());
        System.assertEquals('callout:iam', http.getEndpoint());
        System.assertEquals('GetRole', params.get('Action'));
        System.assertEquals('Test', params.get('RoleName'));
    }
    
    @IsTest static void testGetRoleResponse()
    {
        // act
        IAM.GetRoleRequest request = new IAM.GetRoleRequest();
        IAM.GetRoleResponse response = new IAM.GetRole().call(request);
        
        // assert
        System.assertEquals('%7B%22Version%22%3A%222012-10-17%22%2C%22Statement%22%3A%5B%7B%22Effect%22%3A%22Allow%22%2C%22Principal%22%3A%7B%22Service%22%3A%22lambda.amazonaws.com%22%7D%2C%22Action%22%3A%22sts%3AAssumeRole%22%7D%5D%7D', response.getRoleResult.role.assumeRolePolicyDocument);
        System.assertEquals(3600, response.getRoleResult.role.maxSessionDuration);
        System.assertEquals('ABCDEFGHIJK1234567890', response.getRoleResult.role.roleId);
        System.assertEquals('Streams-JavaScript', response.getRoleResult.role.roleName);
        System.assertEquals('arn:aws:iam::123456789012:role/Streams-JavaScript', response.getRoleResult.role.arn);
        System.assertEquals(Datetime.newInstanceGmt(2020, 01, 01, 23, 59, 59), response.getRoleResult.role.createDate);
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