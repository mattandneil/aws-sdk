@IsTest public class S3Test
{
    @IsTest static void testCreateBucketRequest()
    {
        // arrange
        S3.CreateBucketRequest request = new S3.CreateBucketRequest();
        request.url = 'callout:s3/bucket';
        request.acl = 'private-read';
        request.bucketObjectLockEnabled = false;
        request.grantFullControl = 'emailAddress="test@example.com"';
        request.grantRead = 'emailAddress="test@example.com"';
        request.grantReadAcp = 'emailAddress="test@example.com"';
        request.grantWrite = 'emailAddress="test@example.com"';
        request.grantWriteAcp = 'emailAddress="test@example.com"';
        request.createBucketConfiguration = new S3.CreateBucketConfiguration();
        request.createBucketConfiguration.locationConstraint = 'us-east-2';
        
        // act
        HttpRequest http = request(request);
        Map<String,String> params = params(http);
        
        // assert
        System.assertEquals('PUT', http.getMethod());
        System.assertEquals('callout:s3/bucket', http.getEndpoint());
        System.assertEquals('application/xml', http.getHeader('Content-Type'));
        System.assertEquals('emailAddress="test@example.com"', http.getHeader('x-amz-grant-write-acp'));
        System.assertEquals('emailAddress="test@example.com"', http.getHeader('x-amz-grant-write'));
        System.assertEquals('emailAddress="test@example.com"', http.getHeader('x-amz-grant-read-acp'));
        System.assertEquals('emailAddress="test@example.com"', http.getHeader('x-amz-grant-read'));
        System.assertEquals('emailAddress="test@example.com"', http.getHeader('x-amz-grant-full-control'));
        System.assertEquals('<?xml version="1.0" encoding="UTF-8"?><CreateBucketConfiguration><LocationConstraint>us-east-2</LocationConstraint></CreateBucketConfiguration>', http.getBody());
    }
    
    @IsTest static void testCreateBucketResponse()
    {
        // act
        S3.CreateBucketRequest request = new S3.CreateBucketRequest();
        S3.CreateBucketResponse response = new S3.CreateBucket().call(request);
        
        // assert
        System.assertEquals('/bucket', response.location);
    }
    
    @IsTest static void testDeleteBucketRequest()
    {
        // arrange
        S3.DeleteBucketRequest request = new S3.DeleteBucketRequest();
        request.url = 'callout:s3/bucket';
        
        // act
        HttpRequest http = request(request);
        Map<String,Object> params = params(http);
        
        // assert
        System.assertEquals('DELETE', http.getMethod());
        System.assertEquals('callout:s3/bucket', http.getEndpoint());
    }
    
    @IsTest static void testDeleteBucketResponse()
    {
        // act
        S3.DeleteBucketRequest request = new S3.DeleteBucketRequest();
        S3.DeleteBucketResponse response = new S3.DeleteBucket().call(request);
        
        // assert
        System.assertEquals('{}', Json.serialize(response));
    }
    
    @IsTest static void testDeleteObjectRequest()
    {
        // arrange
        S3.DeleteObjectRequest request = new S3.DeleteObjectRequest();
        request.url = 'callout:s3/bucket/key.ext';
        request.versionId = 'abcdefghijklmnop1234567890abcdef';
        request.bypassGovernanceRetention = true;
        request.mfa = '123 456';
        request.requestPayer = 'requester';
        
        // act
        HttpRequest http = request(request);
        Map<String,String> params = params(http);
        
        // assert
        System.assertEquals('DELETE', http.getMethod());
        System.assertEquals('callout:s3/bucket/key.ext?versionId=abcdefghijklmnop1234567890abcdef', http.getEndpoint());
        System.assertEquals('123 456', http.getHeader('x-amz-mfa'));
        System.assertEquals('requester', http.getHeader('x-amz-request-payer'));
        System.assertEquals('true', http.getHeader('X-Amz-Bypass-Governance-Retention'));
    }
    
    @IsTest static void testDeleteObjectResponse()
    {
        // act
        S3.DeleteObjectRequest request = new S3.DeleteObjectRequest();
        S3.DeleteObjectResponse response = new S3.DeleteObject().call(request);
        
        // assert
        System.assertEquals('1234567890abcdef1234567890abcdef', response.versionId);
        System.assertEquals(true, response.deleteMarker);
        System.assertEquals('requester', response.requestCharged);
    }
    
    @IsTest static void testDeleteObjectsRequest()
    {
        // arrange
        S3.DeleteObjectsRequest request = new S3.DeleteObjectsRequest();
        request.url = 'callout:s3/bucket';
        request.mfa = '123 456';
        request.requestPayer = 'requester';
        request.bypassGovernanceRetention = true;
        request.deletes = new S3.Deletes();
        request.deletes.objects = new List<S3.ObjectIdentifier>();
        request.deletes.objects.add(new S3.ObjectIdentifier());
        request.deletes.objects[0].key = '/item.txt';
        
        // act
        HttpRequest http = request(request);
        Map<String,String> params = params(http);
        
        // assert
        System.assertEquals('POST', http.getMethod());
        System.assertEquals('callout:s3/bucket?delete=', http.getEndpoint());
        System.assertEquals('123 456', http.getHeader('x-amz-mfa'));
        System.assertEquals('requester', http.getHeader('x-amz-request-payer'));
        System.assertEquals('true', http.getHeader('X-Amz-Bypass-Governance-Retention'));
        System.assertEquals('<?xml version="1.0" encoding="UTF-8"?><Delete><Quiet>false</Quiet><Object><Key>/item.txt</Key></Object></Delete>', http.getBody());
    }
    
    @IsTest static void testDeleteObjectsResponse()
    {
        // act
        S3.DeleteObjectsRequest request = new S3.DeleteObjectsRequest();
        S3.DeleteObjectsResponse response = new S3.DeleteObjects().call(request);
        
        // assert
        System.assertEquals('requester', response.requestCharged);
        System.assertEquals('/file.ext', response.deleted[0].key);
    }
    
    @IsTest static void testGetObjectRequest()
    {
        // arrange
        S3.GetObjectRequest request = new S3.GetObjectRequest();
        request.url = 'callout:s3/bucket/key.ext';
        request.ifMatch = '"1234567890abcdef1234567890abcdef"';
        request.ifModifiedSince = Datetime.newInstanceGmt(2019, 12, 25, 23, 59, 59);
        request.ifNoneMatch = '"1234567890abcdef1234567890abcdef"';
        request.ifUnmodifiedSince = Datetime.newInstanceGmt(2019, 12, 25, 23, 59, 59);
        request.partNumber = 123;
        request.range = 'bytes=0-9';
        request.responseCacheControl = 'No-cache';
        request.responseContentDisposition = 'attachment; filename=testing.txt';
        request.responseContentEncoding = 'x-gzip';
        request.responseContentLanguage = 'mi, en';
        request.responseContentType = 'text/plain';
        request.responseExpires = Datetime.newInstanceGmt(2019, 12, 25, 23, 59, 59);
        request.versionId = 'abcdefghijklmnop1234567890abcdef';
        request.requestPayer = 'requester';
        request.serverSideEncryptionCustomerAlgorithm = 'AES256';
        request.serverSideEncryptionCustomerKey = EncodingUtil.base64Decode('abcdefghijklmnop12345678');
        request.serverSideEncryptionCustomerKeyMD5 = EncodingUtil.base64Decode('abcdefghijklmnop12345678');
        
        // act
        HttpRequest http = request(request);
        Map<String,String> params = params(http);
        
        // assert
        System.assertEquals('GET', http.getMethod());
        System.assertEquals('callout:s3/bucket/key.ext?partNumber=123&response-cache-control=No-cache&response-content-disposition=attachment%3B%20filename%3Dtesting.txt&response-content-encoding=x-gzip&response-content-language=mi%2C%20en&response-content-type=text%2Fplain&response-expires=2019-12-25T23%3A59%3A59.000Z&versionId=abcdefghijklmnop1234567890abcdef', http.getEndpoint());
        System.assertEquals('bytes=0-9', http.getHeader('Range'));
        System.assertEquals('"1234567890abcdef1234567890abcdef"', http.getHeader('If-Match'));
        System.assertEquals('Wed, 25 Dec 2019 23:59:59 +0000', http.getHeader('If-Modified-Since'));
        System.assertEquals('"1234567890abcdef1234567890abcdef"', http.getHeader('If-None-Match'));
        System.assertEquals('Wed, 25 Dec 2019 23:59:59 +0000', http.getHeader('If-Unmodified-Since'));
        System.assertEquals('requester', http.getHeader('x-amz-request-payer'));
        System.assertEquals('AES256', http.getHeader('x-amz-server-side-encryption-customer-algorithm'));
        System.assertEquals('abcdefghijklmnop12345678', http.getHeader('x-amz-server-side-encryption-customer-key'));
        System.assertEquals('abcdefghijklmnop12345678', http.getHeader('x-amz-server-side-encryption-customer-key-md5'));
    }
    
    @IsTest static void testGetObjectResponse()
    {
        // act
        S3.GetObjectRequest request = new S3.GetObjectRequest();
        S3.GetObjectResponse response = new S3.GetObject().call(request);
        
        // assert
        System.assertEquals('bytes', response.acceptRanges);
        System.assertEquals('No-cache', response.cacheControl);
        System.assertEquals('attachment; filename=testing.txt', response.contentDisposition);
        System.assertEquals('x-gzip', response.contentEncoding);
        System.assertEquals('mi, en', response.contentLanguage);
        System.assertEquals(123, response.contentLength);
        System.assertEquals('bytes 0-9/443', response.contentRange);
        System.assertEquals('text/plain', response.contentType);
        System.assertEquals('"1234567890abcdef1234567890abcdef"', response.etag);
        System.assertEquals(Datetime.newInstanceGmt(2019, 12, 25, 23, 59, 59), response.expires);
        System.assertEquals(Datetime.newInstanceGmt(2019, 12, 25, 23, 59, 59), response.lastModified);
        System.assertEquals(true, response.deleteMarker);
        System.assertEquals('expiry-date="Wed, 25 Dec 2019 23:59:59 GMT", rule-id="picture-deletion-rule"', response.expiration);
        System.assertEquals(123, response.missingMeta);
        System.assertEquals(1, response.mpPartsCount);
        System.assertEquals('OFF', response.objectLockLegalHold);
        System.assertEquals('GOVERNANCE', response.objectLockMode);
        System.assertEquals(Datetime.newInstanceGmt(2019, 12, 25, 23, 59, 59), response.objectLockRetainUntilDate);
        System.assertEquals('REPLICA', response.replicationStatus);
        System.assertEquals('requester', response.requestCharged);
        System.assertEquals('ongoing-request="false", expiry-date="Wed, 25 Dec 2019 23:59:59 +0000"', response.restore);
        System.assertEquals('aws:kms', response.serverSideEncryption);
        System.assertEquals('1234abcd-12ab-34cd-56ef-1234567890ab', response.serverSideEncryptionAwsKmsKeyId);
        System.assertEquals('AES256', response.serverSideEncryptionCustomerAlgorithm);
        System.assertEquals(EncodingUtil.base64Decode('abcdefghijklmnop12345678'), response.serverSideEncryptionCustomerKeyMD5);
        System.assertEquals('REDUCED_REDUNDANCY', response.storageClass);
        System.assertEquals(1, response.taggingCount);
        System.assertEquals('abcdefghijk1234567890ABCDEFGHIJK', response.versionId);
        System.assertEquals('http://www.example.com/', response.websiteRedirectLocation);
        System.assertEquals(Blob.valueOf('achoo'), response.body);
    }
    
    @IsTest static void testHeadObjectRequest()
    {
        // arrange
        S3.HeadObjectRequest request = new S3.HeadObjectRequest();
        request.url = 'callout:s3/bucket/key.ext';
        request.ifMatch = '"1234567890abcdef1234567890abcdef"';
        request.ifModifiedSince = Datetime.newInstanceGmt(2019, 12, 25, 23, 59, 59);
        request.ifNoneMatch = '"1234567890abcdef1234567890abcdef"';
        request.ifUnmodifiedSince = Datetime.newInstanceGmt(2019, 12, 25, 23, 59, 59);
        request.partNumber = 123;
        request.range = 'bytes=0-9';
        request.versionId = 'abcdefghijklmnop1234567890abcdef';
        request.requestPayer = 'requester';
        request.serverSideEncryptionCustomerAlgorithm = 'AES256';
        request.serverSideEncryptionCustomerKey = EncodingUtil.base64Decode('abcdefghijklmnop12345678');
        request.serverSideEncryptionCustomerKeyMD5 = EncodingUtil.base64Decode('abcdefghijklmnop12345678');
        
        // act
        HttpRequest http = request(request);
        Map<String,String> params = params(http);
        
        // assert
        System.assertEquals('HEAD', http.getMethod());
        System.assertEquals('callout:s3/bucket/key.ext?partNumber=123&versionId=abcdefghijklmnop1234567890abcdef', http.getEndpoint());
        System.assertEquals('"1234567890abcdef1234567890abcdef"', http.getHeader('If-Match'));
        System.assertEquals('Wed, 25 Dec 2019 23:59:59 +0000', http.getHeader('If-Modified-Since'));
        System.assertEquals('"1234567890abcdef1234567890abcdef"', http.getHeader('If-None-Match'));
        System.assertEquals('Wed, 25 Dec 2019 23:59:59 +0000', http.getHeader('If-Unmodified-Since'));
        System.assertEquals('bytes=0-9', http.getHeader('Range'));
        System.assertEquals('requester', http.getHeader('x-amz-request-payer'));
        System.assertEquals('AES256', http.getHeader('x-amz-server-side-encryption-customer-algorithm'));
        System.assertEquals('abcdefghijklmnop12345678', http.getHeader('x-amz-server-side-encryption-customer-key'));
        System.assertEquals('abcdefghijklmnop12345678', http.getHeader('x-amz-server-side-encryption-customer-key-md5'));
    }
    
    @IsTest static void testHeadObjectResponse()
    {
        // act
        S3.HeadObjectRequest request = new S3.HeadObjectRequest();
        S3.HeadObjectResponse response = new S3.HeadObject().call(request);
        
        // assert
        System.assertEquals('bytes', response.acceptRanges);
        System.assertEquals('No-cache', response.cacheControl);
        System.assertEquals('attachment; filename=testing.txt', response.contentDisposition);
        System.assertEquals('x-gzip', response.contentEncoding);
        System.assertEquals('mi, en', response.contentLanguage);
        System.assertEquals(123, response.contentLength);
        System.assertEquals('application/json', response.contentType);
        System.assertEquals('"1234567890abcdef1234567890abcdef"', response.etag);
        System.assertEquals(Datetime.newInstanceGmt(2019, 12, 25, 23, 59, 59), response.expires);
        System.assertEquals(Datetime.newInstanceGmt(2019, 12, 25, 23, 59, 59), response.lastModified);
        System.assertEquals(true, response.deleteMarker);
        System.assertEquals('expiry-date="Wed, 25 Dec 2019 23:59:59 GMT", rule-id="picture-deletion-rule"', response.expiration);
        System.assertEquals(123, response.missingMeta);
        System.assertEquals(123, response.mpPartsCount);
        System.assertEquals('OFF', response.objectLockLegalHold);
        System.assertEquals('GOVERNANCE', response.objectLockMode);
        System.assertEquals(Datetime.newInstanceGmt(2019, 12, 25, 23, 59, 59), response.objectLockRetainUntilDate);
        System.assertEquals('COMPLETE', response.replicationStatus);
        System.assertEquals('requester', response.requestCharged);
        System.assertEquals('ongoing-request="false", expiry-date="Wed, 25 Dec 2019 23:59:59 GMT"', response.restore);
    }
    
    @IsTest static void testListBucketsRequest()
    {
        // arrange
        S3.ListBucketsRequest request = new S3.ListBucketsRequest();
        
        // act
        HttpRequest http = request(request);
        Map<String,Object> params = params(http);
        
        // assert
        System.assertEquals('GET', http.getMethod());
        System.assertEquals('callout:S3', http.getEndpoint());
    }
    
    @IsTest static void testListBucketsResponse()
    {
        // act
        S3.ListBucketsRequest request = new S3.ListBucketsRequest();
        S3.ListBucketsResponse response = new S3.ListBuckets().call(request);
        
        // assert
        System.assertEquals('testowner', response.owner.displayName);
        System.assertEquals('11223344556677889900aabbccddeeff11223344556677889900aabbccddeeff', response.owner.id);
        System.assertEquals('testbucket1', response.buckets[0].name);
        System.assertEquals(Datetime.newInstanceGmt(2019, 12, 25, 23, 59, 59), response.buckets[0].creationDate);
        System.assertEquals('testbucket2', response.buckets[1].name);
        System.assertEquals(Datetime.newInstanceGmt(2020, 01, 01, 23, 59, 59), response.buckets[1].creationDate);
    }
    
    @IsTest static void testListObjectsRequest()
    {
        // arrange
        S3.ListObjectsRequest request = new S3.ListObjectsRequest();
        request.delimiter = '/';
        request.encodingType = 'url';
        request.marker = 'after space';
        request.maxKeys = 40;
        request.prefix = 'folder/';
        request.requestPayer = 'requester';
        
        // act
        HttpRequest http = request(request);
        Map<String,String> params = params(http);
        
        // assert
        System.assertEquals('GET', http.getMethod());
        System.assertEquals('callout:S3?delimiter=%2F&encodingType=url&marker=after%20space&maxKeys=40&prefix=folder%2F', http.getEndpoint());
    }
    
    @IsTest static void testListObjectsResponse()
    {
        // act
        S3.ListObjectsRequest request = new S3.ListObjectsRequest();
        S3.ListObjectsResponse response = new S3.ListObjects().call(request);
        
        // assert
        System.assertEquals('testbucket', response.name);
        System.assertEquals('prefix/', response.prefix);
        System.assertEquals('marker', response.marker);
        System.assertEquals(1000, response.maxKeys);
        System.assertEquals('/', response.delimiter);
        System.assertEquals(true, response.isTruncated);
        
        System.assertEquals('prefix/file1.ext', response.contents[0].key);
        System.assertEquals(Datetime.newInstanceGmt(2019, 01, 01, 23, 59, 59), response.contents[0].lastModified);
        System.assertEquals('"11223344556677889900aabbccddeeff"', response.contents[0].etag);
        System.assertEquals(123, response.contents[0].size);
        System.assertEquals('11223344556677889900aabbccddeeff11223344556677889900aabbccddeeff', response.contents[0].owner.id);
        System.assertEquals('STANDARD', response.contents[0].storageClass);
        
        System.assertEquals('prefix/file2.ext', response.contents[1].key);
        System.assertEquals(Datetime.newInstanceGmt(2019, 02, 02, 23, 59, 59), response.contents[1].lastModified);
        System.assertEquals('"11223344556677889900aabbccddeeff"', response.contents[1].etag);
        System.assertEquals(456, response.contents[1].size);
        System.assertEquals('11223344556677889900aabbccddeeff11223344556677889900aabbccddeeff', response.contents[1].owner.id);
        System.assertEquals('STANDARD', response.contents[1].storageClass);
        
        System.assertEquals('prefix/folder1/', response.commonPrefixes[0].prefix);
        System.assertEquals('prefix/folder2/', response.commonPrefixes[1].prefix);
    }
    
    @IsTest static void testPutObjectRequest()
    {
        // arrange
        S3.PutObjectRequest request = new S3.PutObjectRequest();
        request.url = 'callout:s3/bucket/key.txt';
        request.cacheControl = 'No-cache';
        request.contentDisposition = 'attachment; filename=testing.txt';
        request.contentEncoding = 'x-gzip';
        request.contentLanguage = 'mi, en';
        request.contentType = 'application/x-octet-stream';
        request.expires = Datetime.newInstanceGmt(2019, 12, 25, 23, 59, 59);
        request.acl = '';
        // request.contentMD5 = Crypto.generateDigest('MD5', Blob.valueOf('achoo'));
        request.grantFullControl = 'emailAddress="test@example.com"';
        request.grantRead = 'emailAddress="test@example.com"';
        request.grantReadAcp = 'emailAddress="test@example.com"';
        request.grantWriteAcp = 'emailAddress="test@example.com"';
        request.objectLockLegalHold = 'OFF';
        request.objectLockMode = 'COMPLIANCE';
        request.objectLockRetainUntilDate = Datetime.newInstanceGmt(2019, 12, 25, 23, 59, 59);
        request.requestPayer = 'requester';
        request.serverSideEncryption = 'aws:kms';
        request.serverSideEncryptionAwsKmsKeyId = '11223344-5566-7788-9900-aabbccddeeff';
        request.serverSideEncryptionContext = EncodingUtil.base64Decode('abcdefghijklmnop12345678');
        request.serverSideEncryptionCustomerKey = EncodingUtil.base64Decode('abcdefghijklmnop12345678');
        request.serverSideEncryptionCustomerKeyMD5 = EncodingUtil.base64Decode('abcdefghijklmnop12345678');
        request.serverSideEncryptionCustomerAlgorithm = 'AES256';
        request.storageClass = 'STANDARD';
        request.tagging = 'foo=bar';
        request.websiteRedirectLocation = 'http://www.example.com/';
        request.body = Blob.valueOf('achoo');
        
        // act
        HttpRequest http = request(request);
        Map<String,String> params = params(http);
        
        // assert
        System.assertEquals('PUT', http.getMethod());
        System.assertEquals('callout:s3/bucket/key.txt', http.getEndpoint());
        System.assertEquals('No-cache', http.getHeader('Cache-Control'));
        System.assertEquals('attachment; filename=testing.txt', http.getHeader('Content-Disposition'));
        System.assertEquals('x-gzip', http.getHeader('Content-Encoding'));
        System.assertEquals('mi, en', http.getHeader('Content-Language'));
        System.assertEquals('application/x-octet-stream', http.getHeader('Content-Type'));
        System.assertEquals('Wed, 25 Dec 2019 23:59:59 +0000', http.getHeader('Expires'));
        System.assertEquals('', http.getHeader('X-Amz-Acl'));
        System.assertEquals('emailAddress="test@example.com"', http.getHeader('x-amz-grant-full-control'));
        System.assertEquals('emailAddress="test@example.com"', http.getHeader('x-amz-grant-read'));
        System.assertEquals('emailAddress="test@example.com"', http.getHeader('x-amz-grant-read-acp'));
        System.assertEquals('emailAddress="test@example.com"', http.getHeader('x-amz-grant-write-acp'));
        System.assertEquals('OFF', http.getHeader('x-amz-object-lock-legal-hold'));
        System.assertEquals('COMPLIANCE', http.getHeader('x-amz-object-lock-mode'));
        System.assertEquals('2019-12-25T11:59:59.000Z', http.getHeader('x-amz-object-lock-retain-until-date'));
        System.assertEquals('requester', http.getHeader('x-amz-request-payer'));
        System.assertEquals('aws:kms', http.getHeader('x-amz-server-side-encryption'));
        System.assertEquals('11223344-5566-7788-9900-aabbccddeeff', http.getHeader('x-amz-server-side-encryption-aws-kms-key-id'));
        System.assertEquals('abcdefghijklmnop12345678', http.getHeader('x-amz-server-side-encryption-context'));
        System.assertEquals('abcdefghijklmnop12345678', http.getHeader('x-amz-server-side-encryption-customer-key'));
        System.assertEquals('abcdefghijklmnop12345678', http.getHeader('x-amz-server-side-encryption-customer-key-md5'));
        System.assertEquals('AES256', http.getHeader('x-amz-server-side-encryption-customer-algorithm'));
        System.assertEquals('STANDARD', http.getHeader('x-amz-storage-class'));
        System.assertEquals('foo=bar', http.getHeader('x-amz-tagging'));
        System.assertEquals('http://www.example.com/', http.getHeader('x-amz-website-redirect-location'));
        System.assertEquals(Blob.valueOf('achoo'), http.getBodyAsBlob());
    }
    
    @IsTest static void testPutObjectResponse()
    {
        // act
        S3.PutObjectRequest request = new S3.PutObjectRequest();
        S3.PutObjectResponse response = new S3.PutObject().call(request);
        
        // assert
        System.assertEquals('"1234567890abcdef1234567890abcdef"', response.etag);
        System.assertEquals('expiry-date="Wed, 25 Dec 2019 23:59:59 GMT", rule-id="picture-deletion-rule"', response.expiration);
        System.assertEquals('requester', response.requestCharged);
        System.assertEquals('aws:kms', response.serverSideEncryption);
        System.assertEquals('arn:aws:kms:us-east-1:123456789012:key/11223344-5566-7788-9900-aabbccddeeff', response.serverSideEncryptionAwsKmsKeyId);
        System.assertEquals(EncodingUtil.base64Decode('abcdefghijklmnop12345678'), response.serverSideEncryptionContext);
        System.assertEquals('AES256', response.serverSideEncryptionCustomerAlgorithm);
        System.assertEquals(EncodingUtil.base64Decode('abcdefghijklmnop12345678'), response.serverSideEncryptionCustomerKeyMD5);
        System.assertEquals('abcdefghijk1234567890ABCDEFGHIJK', response.versionId);
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