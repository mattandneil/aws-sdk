@IsTest class LambdaTest
{
    
    // String endpoint = 'https://lambda.us-east-1.amazonaws.com';
    // AWS.Lambda.DeleteFunctionRequest request = new AWS.Lambda.DeleteFunctionRequest(endpoint);
    // request.functionName = 'Streams-JavaScript-v48c';
    // AWS.Lambda.DeleteFunctionResponse response = new AWS.Lambda.DeleteFunction().call(request);
    // System.debug(response);
    
    // String endpoint = 'https://lambda.us-east-1.amazonaws.com';
    // AWS.Lambda.CreateFunctionRequest request = new AWS.Lambda.CreateFunctionRequest(endpoint);
    // request.functionName = 'Streams-JavaScript-v48c';
    // request.role = 'arn:aws:iam::586904665160:role/Streams-JavaScript-v48';
    // request.handler = 'main.handler';
    // request.runtime = 'nodejs10.x';
    // request.code = new AWS.Lambda.FunctionCode();
    // request.code.zipFile = EncodingUtil.base64Decode('UEsDBAoAAAAAAAAAAAAZnfy6WwAAAFsAAAAHAAAAbWFpbi5qc2V4cG9ydHMuaGFuZGxlciA9IGFzeW5jIGZ1bmN0aW9uKGV2ZW50LCBjb250ZXh0KSB7cmV0dXJuIHtldmVudDogZXZlbnQsIGNvbnRleHQ6IGNvbnRleHR9IH1QSwECCgAKAAAAAAAAAAAAGZ38ulsAAABbAAAABwAAAAAAAAAAAAAAAAAAAAAAbWFpbi5qc1BLBQYAAAAAAQABADUAAACAAAAAAAA=');
    // AWS.Lambda.CreateFunctionResponse response = new AWS.Lambda.CreateFunction().call(request);
    // System.debug(Json.serializePretty(response));
    
    // String endpoint = 'https://lambda.us-east-1.amazonaws.com';
    // AWS.Lambda.InvokeRequest request = new AWS.Lambda.InvokeRequest(endpoint);
    // request.clientContext = Blob.valueOf('{}');
    // request.functionName = 'Streams-JavaScript-v48c';
    // request.invocationType = 'RequestResponse';
    // request.logType = 'None';
    // request.qualifier = null;
    // request.payload = Blob.valueOf('{}');
    // AWS.Lambda.InvokeResponse response = new AWS.Lambda.Invoke().call(request);
    // System.debug(response);
    
    @IsTest static void testCreateFunction()
    {
        // arrange
        Lambda.CreateFunctionRequest request = new Lambda.CreateFunctionRequest();
        request.url = 'callout:lambda';
        request.code = new Lambda.FunctionCode();
        request.role = 'arn:aws:iam::586904665160:role/Streams-Lambda';
        request.handler = 'main.handler';
        request.functionName = 'achoo';
        request.runtime = 'nodejs10.x';
        
        // assemble deployable package
        request.code.zipFile = Blob.valueOf('');
        
        // act
        Lambda.CreateFunctionResponse response = new Lambda.CreateFunction().call(request);
        
        // assert
        System.assertEquals('', response.description);
        System.assertEquals('PassThrough', response.tracingConfig.mode);
        System.assertEquals('11223344-5566-7788-9900-aabbccddeeff', response.revisionId);
        System.assertEquals('2020-01-01T23:59:59.000+0000', response.lastModified);
        System.assertEquals('Test', response.functionName);
        System.assertEquals('nodejs10.x', response.runtime);
        System.assertEquals('$LATEST', response.version);
        System.assertEquals('Successful', response.lastUpdateStatus);
        System.assertEquals('arn:aws:lambda:us-east-1:123456789012:function:Test', response.functionArn);
        System.assertEquals(128, response.memorySize);
        System.assertEquals(3, response.timeout);
        System.assertEquals('call', response.handler);
        System.assertEquals('abcdefghijklmnopqrstuvwxyz1234567890ABCDEFGH', response.codeSha256);
        System.assertEquals('arn:aws:iam::123456789012:role/Test', response.role);
        System.assertEquals(154, response.codeSize);
        System.assertEquals('Active', response.state);
    }
    
    @IsTest static void testDeleteFunction()
    {
        // arrange
        Lambda.DeleteFunctionRequest request = new Lambda.DeleteFunctionRequest();
        request.url = 'callout:lambda';
        request.functionName = 'Test';
        request.qualifier = 'V99';
        
        // act
        Lambda.DeleteFunctionResponse response = new Lambda.DeleteFunction().call(request);
        
        // assert
        System.assertEquals('{}', Json.serialize(response));
    }
    
    @IsTest static void testInvoke()
    {
        // arrange
        Lambda.InvokeRequest request = new Lambda.InvokeRequest();
        request.url = 'callout:lambda';
        request.clientContext = Blob.valueOf('Test');
        request.functionName = 'Test';
        request.invocationType = 'DryRun';
        request.logType = 'Tail';
        request.qualifier = 'V99';
        request.payload = Blob.valueOf('{}');
        
        // act
        Lambda.InvokeResponse response = new Lambda.Invoke().call(request);
        
        // assert
        System.assertEquals(200, response.statusCode);
        System.assertEquals(EncodingUtil.base64Decode('abcdefghijklmnop12345678'), response.logResult);
        System.assertEquals('xAmzFunctionError', response.functionError);
        System.assertEquals('xAmzExecutedVersion', response.executedVersion);
        System.assertEquals(Blob.valueOf('"2020/01/01/[$LATEST]abcdef1234567890abcdef1234567890"'), response.payload);
    }
    
}