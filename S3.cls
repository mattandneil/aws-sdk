/**
* Salesforce Apex SDK for AWS S3
 * 
 * Amazon Web Services documentation:
 * https://docs.aws.amazon.com/AmazonS3/latest/API/s3-api.pdf
 * https://docs.aws.amazon.com/AmazonS3/latest/API/index.html
 */
global class S3
{
    private S3()
    {
        //
    }
    
    /**
     * Creates a new bucket. To create a bucket, you must register with Amazon S3 and have a valid
     * AWS Access Key ID to authenticate requests. Anonymous requests are never allowed to create
     * buckets. By creating the bucket, you become the bucket owner.
     * 
     * https://docs.aws.amazon.com/AmazonS3/latest/API/API_CreateBucket.html
     */
    global class CreateBucket implements HttpCalloutMock
    {
        global CreateBucketResponse call(CreateBucketRequest request)
        {
            if (Test.isRunningTest()) Test.setMock(HttpCalloutMock.class, this);
            System.Callable sdk = (System.Callable)Type.forName('AWS.SDK').newInstance();
            return (CreateBucketResponse)sdk.call(CreateBucketRequest.class.getName(),
            (Map<String,Object>)Json.deserializeUntyped(Json.serialize(request, true)));
        }
        
        public HttpResponse respond(HttpRequest request)
        {
            HttpResponse response = new HttpResponse();
            response.setStatusCode(200);
            response.setHeader('Server', 'AmazonS3');
            response.setHeader('x-amz-request-id', 'ABCDEF1234567890');
            response.setHeader('Content-Length', '0');
            response.setHeader('x-amz-id-2', 'abcdefghijklmnopqrstuvwxyz123456789012345678901234ABCDEFGHIJKLMNOPQRSTUVWXYZ');
            response.setHeader('Date', 'Wed, 25 Dec 2019 23:59:59 GMT');
            response.setHeader('Location', '/bucket');
            return response;
        }
    }
    
    /**
     * https://docs.aws.amazon.com/AmazonS3/latest/API/API_CreateBucket.html#API_CreateBucket_RequestSyntax
     */
    global class CreateBucketRequest
    {
        /**
         * The name of the bucket to create.
         * Required: Yes
         */
        global String url = 'callout:S3';
        
        /**
         * The canned ACL to apply to the bucket.
         * Valid Values: private | public-read | public-read-write | authenticated-read
         * https://docs.aws.amazon.com/AmazonS3/latest/dev/acl-overview.html#CannedACL
         */
        global String acl;

        /**
         * Specifies whether you want S3 Object Lock to be enabled for the new bucket.
         */
        global Boolean bucketObjectLockEnabled;

        /**
         * Allows grantee the read, write, read ACP, and write ACP permissions on the bucket.
         */
        global String grantFullControl;

        /**
         * Allows grantee to list the objects in the bucket.
         */
        global String grantRead;

        /**
         * Allows grantee to read the bucket ACL.
         */
        global String grantReadAcp;

        /**
         * Allows grantee to create, overwrite, and delete any object in the bucket.
         */
        global String grantWrite;

        /**
         * Allows grantee to write the ACL for the applicable bucket.
         */
        global String grantWriteAcp;

        /**
         * Root level tag for the CreateBucketConfiguration parameters.
         * Required: Yes
         */
        global CreateBucketConfiguration createBucketConfiguration;
    }
    
    /**
     * https://docs.aws.amazon.com/AmazonS3/latest/API/API_CreateBucket.html#API_CreateBucket_ResponseSyntax
     */
    global class CreateBucketResponse
    {
        /**
         * Specifies the Region where the bucket will be created.
         * If you are creating a bucket on the US East (N. Virginia) Region (us-east-1), you do not need to specify the location.
         */
        global String location;
    }
    
    /**
     * Deletes the bucket. All objects (including all object versions and delete markers) in the
     * bucket must be deleted before the bucket itself can be deleted.
     * 
     * https://docs.aws.amazon.com/AmazonS3/latest/API/API_DeleteBucket.html
     */
    global class DeleteBucket implements HttpCalloutMock
    {
        global DeleteBucketResponse call(DeleteBucketRequest request)
        {
            if (Test.isRunningTest()) Test.setMock(HttpCalloutMock.class, this);
            System.Callable sdk = (System.Callable)Type.forName('AWS.SDK').newInstance();
            return (DeleteBucketResponse)sdk.call(DeleteBucketRequest.class.getName(),
            (Map<String,Object>)Json.deserializeUntyped(Json.serialize(request, true)));
        }
        
        public HttpResponse respond(HttpRequest request)
        {
            HttpResponse response = new HttpResponse();
            response.setStatusCode(204);
            response.setHeader('Server', 'AmazonS3');
            response.setHeader('x-amz-request-id', 'ABCDEF1234567890');
            response.setHeader('x-amz-id-2', 'abcdefghijklmnopqrstuvwxyz123456789012345678901234ABCDEFGHIJKLMNOPQRSTUVWXYZ');
            response.setHeader('Date', 'Wed, 25 Dec 2019 23:59:59 GMT');
            return response;
        }
    }
    
    /**
     * https://docs.aws.amazon.com/AmazonS3/latest/API/API_DeleteBucket.html#API_DeleteBucket_RequestSyntax
     */
    global class DeleteBucketRequest
    {
        /**
         * Specifies the bucket being deleted.
         * Required: Yes
         */
        global String url = 'callout:S3';
    }
    
    /**
     * https://docs.aws.amazon.com/AmazonS3/latest/API/API_DeleteBucket.html#API_DeleteBucket_ResponseSyntax
     */
    global class DeleteBucketResponse
    {
        //
    }
    
    /**
     * Removes the null version (if there is one) of an object and inserts a delete marker, which
     * becomes the latest version of the object. If there isn't a null version, Amazon S3 does not
     * remove any objects.
     * 
     * https://docs.aws.amazon.com/AmazonS3/latest/API/API_DeleteObject.html
     */
    global class DeleteObject implements HttpCalloutMock
    {
        global DeleteObjectResponse call(DeleteObjectRequest request)
        {
            if (Test.isRunningTest()) Test.setMock(HttpCalloutMock.class, this);
            System.Callable sdk = (System.Callable)Type.forName('AWS.SDK').newInstance();
            return (DeleteObjectResponse)sdk.call(DeleteObjectRequest.class.getName(),
            (Map<String,Object>)Json.deserializeUntyped(Json.serialize(request, true)));
        }
        
        public HttpResponse respond(HttpRequest request)
        {
            HttpResponse response = new HttpResponse();
            response.setStatusCode(204);
            response.setHeader('Server', 'AmazonS3');
            response.setHeader('x-amz-id-2', 'abcdefghijklmnopqrstuvwxyz123456789012345678901234ABCDEFGHIJKLMNOPQRSTUVWXYZ');
            response.setHeader('x-amz-delete-marker', 'true');
            response.setHeader('x-amz-version-id', '1234567890abcdef1234567890abcdef');
            response.setHeader('x-amz-request-id', 'ABCDEF1234567890');
            response.setHeader('x-amz-request-charged', 'requester');
            return response;
        }
    }
    
    /**
     * Removes the null version (if there is one) of an object and inserts a delete marker, which
     * becomes the latest version of the object. If there isn't a null version, Amazon S3 does not
     * remove any objects.
     * 
     * https://docs.aws.amazon.com/AmazonS3/latest/API/API_DeleteObject.html#API_DeleteObject_RequestSyntax
     */
    global class DeleteObjectRequest
    {
        /**
         * The bucket name of the bucket containing the object.
         */
        global String url = 'callout:S3';

        /**
         * Key name of the object to delete.
         */
        // key handled by endpoint

        /**
         * VersionId used to reference a specific version of the object.
         */
        global String versionId;

        /**
         * Indicates whether S3 Object Lock should bypass Governance-mode restrictions to process this operation.
         */
        global Boolean bypassGovernanceRetention;

        /**
         * The concatenation of the authentication device's serial number, a space, and the value that is displayed on your authentication device.
         * Required to permanently delete a versioned object if versioning is configured with MFA delete enabled.
         */
        global String mfa;

        /**
         * Confirms that the requester knows that they will be charged for the request.
         * Bucket owners need not specify this parameter in their requests.
         * Valid Values: requester
         */
        global String requestPayer;
    }
    
    /**
     * https://docs.aws.amazon.com/AmazonS3/latest/API/API_DeleteObject.html#API_DeleteObject_ResponseSyntax
     */
    global class DeleteObjectResponse
    {
        /**
         * Specifies whether the versioned object that was permanently deleted was (true) or was not (false) a delete marker.
         */
        global Boolean deleteMarker;

        /**
         * If present, indicates that the requester was successfully charged for the request.
         * Valid Values: requester
         */
        global String requestCharged;

        /**
         * Returns the version ID of the delete marker created as a result of the DELETE operation.
         */
        global String versionId;
    }
    
    /**
     * This operation enables you to delete multiple objects from a bucket using a single HTTP
     * request. If you know the object keys that you want to delete, then this operation provides a
     * suitable alternative to sending individual delete requests, reducing per-request overhead.
     * 
     * https://docs.aws.amazon.com/AmazonS3/latest/API/API_DeleteObjects.html
     */
    global class DeleteObjects implements HttpCalloutMock
    {
        global DeleteObjectsResponse call(DeleteObjectsRequest request)
        {
            if (Test.isRunningTest()) Test.setMock(HttpCalloutMock.class, this);
            System.Callable sdk = (System.Callable)Type.forName('AWS.SDK').newInstance();
            return (DeleteObjectsResponse)sdk.call(DeleteObjectsRequest.class.getName(),
            (Map<String,Object>)Json.deserializeUntyped(Json.serialize(request, true)));
        }
        
        public HttpResponse respond(HttpRequest request)
        {
            HttpResponse response = new HttpResponse();
            response.setStatusCode(204);
            response.setHeader('Content-Type', 'application/xml');
            response.setHeader('Server', 'AmazonS3');
            response.setHeader('x-amz-id-2', 'abcdefghijklmnopqrstuvwxyz123456789012345678901234ABCDEFGHIJKLMNOPQRSTUVWXYZ');
            response.setHeader('x-amz-delete-marker', 'true');
            response.setHeader('x-amz-version-id', '1234567890abcdef1234567890abcdef');
            response.setHeader('x-amz-request-id', 'ABCDEF1234567890');
            response.setHeader('x-amz-request-charged', 'requester');
            response.setBody('<?xml version="1.0" encoding="UTF-8"?>\n'
                + '<DeleteResult xmlns="http://s3.amazonaws.com/doc/2006-03-01/">'
                +     '<Deleted>'
                +        '<Key>/file.ext</Key>'
                +     '</Deleted>'
                + '</DeleteResult>'
            );
            return response;
        }
    }
    
    /**
     * https://docs.aws.amazon.com/AmazonS3/latest/API/API_DeleteObjects.html#API_DeleteObjects_RequestSyntax
     */
    global class DeleteObjectsRequest
    {
        /**
         * The bucket name containing the objects to delete.
         * When using this API with an access point, you must direct requests to the access point hostname. The
         * access point hostname takes the form AccessPointName-AccountId.s3-accesspoint.Region.amazonaws.com.
         * When using this operation using an access point through the AWS SDKs, you provide the
         * access point ARN in place of the bucket name. For more information about access point
         * ARNs, see Using Access Points in the Amazon Simple Storage Service Developer Guide.
         * Required: Yes
         */
        global String url = 'callout:S3';

        /**
         * Specifies whether you want to delete this object even if it has a Governance-type Object
         * Lock in place. You must have sufficient permissions to perform this operation.
         */
        global Boolean bypassGovernanceRetention;

        /**
         * The concatenation of the authentication device's serial number, a space, and the value
         * that is displayed on your authentication device. Required to permanently delete a
         * versioned object if versioning is configured with MFA delete enabled.
         */
        global String mfa;

        /**
         * Confirms that the requester knows that they will be charged for the request. Bucket
         * owners need not specify this parameter in their requests. For information about
         * downloading objects from requester pays buckets, see Downloading Objects in Requestor
         * Pays Buckets in the Amazon S3 Developer Guide.
         * Valid Values: requester
         */
        global String requestPayer;

        /**
         * Root level tag for the Delete parameters.
         * Required: Yes
         */
        global Deletes deletes = new Deletes();
    }
    
    /**
     * https://docs.aws.amazon.com/AmazonS3/latest/API/API_DeleteObjects.html#API_DeleteObjects_ResponseSyntax
     */
    global class DeleteObjectsResponse
    {
        /**
         * If present, indicates that the requester was successfully charged for the request.
         * Valid Values: requester
         */
        global String requestCharged;

        /**
         * The following data is returned in XML format by the service.
         * 
         */
        global List<DeletedObject> deleted;

        /**
         * Container for a failed delete operation that describes the object that Amazon S3
         * attempted to delete and the error it encountered.
         * Type: Array of Error data types
         */
        global List<Error> error;
    }
    
    /**
     * Retrieves objects from Amazon S3. To use GET, you must have READ access to the object. If you
     * grant READ access to the anonymous user, you can return the object without using an
     * authorization header.
     * 
     * https://docs.aws.amazon.com/AmazonS3/latest/API/API_GetObject.html
     */
    global class GetObject implements HttpCalloutMock
    {
        global GetObjectResponse call(GetObjectRequest request)
        {
            if (Test.isRunningTest()) Test.setMock(HttpCalloutMock.class, this);
            System.Callable sdk = (System.Callable)Type.forName('AWS.SDK').newInstance();
            return (GetObjectResponse)sdk.call(GetObjectRequest.class.getName(),
            (Map<String,Object>)Json.deserializeUntyped(Json.serialize(request, true)));
        }
        
        public HttpResponse respond(HttpRequest request)
        {
            HttpResponse response = new HttpResponse();
            response.setStatusCode(200);
            response.setHeader('x-amz-delete-marker', 'true');
            response.setHeader('accept-ranges', 'bytes');
            response.setHeader('x-amz-expiration', 'expiry-date="Wed, 25 Dec 2019 23:59:59 GMT", rule-id="picture-deletion-rule"');
            response.setHeader('x-amz-restore', 'ongoing-request="false", expiry-date="Wed, 25 Dec 2019 23:59:59 +0000"');
            response.setHeader('Last-Modified', 'Wed, 25 Dec 2019 23:59:59 GMT');
            response.setHeader('Content-Length', '123');
            response.setHeader('ETag', '"1234567890abcdef1234567890abcdef"');
            response.setHeader('x-amz-missing-meta', '123');
            response.setHeader('x-amz-version-id', 'abcdefghijk1234567890ABCDEFGHIJK');
            response.setHeader('Cache-Control', 'No-cache');
            response.setHeader('Content-Disposition', 'attachment; filename=testing.txt');
            response.setHeader('Content-Encoding', 'x-gzip');
            response.setHeader('Content-Language', 'mi, en');
            response.setHeader('Content-Range', 'bytes 0-9/443');
            response.setHeader('Content-Type', 'text/plain');
            response.setHeader('Expires', 'Wed, 25 Dec 2019 23:59:59 +0000');
            response.setHeader('x-amz-website-redirect-location', 'http://www.example.com/');
            response.setHeader('x-amz-server-side-encryption', 'aws:kms');
            response.setHeader('x-amz-server-side-encryption-customer-algorithm', 'AES256');
            response.setHeader('x-amz-server-side-encryption-customer-key-MD5', 'abcdefghijklmnop12345678');
            response.setHeader('x-amz-server-side-encryption-aws-kms-key-id', '1234abcd-12ab-34cd-56ef-1234567890ab');
            response.setHeader('x-amz-storage-class', 'REDUCED_REDUNDANCY');
            response.setHeader('x-amz-request-charged', 'requester');
            response.setHeader('x-amz-replication-status', 'REPLICA');
            response.setHeader('x-amz-mp-parts-count', '1');
            response.setHeader('x-amz-tagging-count', '1');
            response.setHeader('x-amz-object-lock-mode', 'GOVERNANCE');
            response.setHeader('x-amz-object-lock-retain-until-date', 'Wed, 25 Dec 2019 23:59:59 GMT');
            response.setHeader('x-amz-object-lock-legal-hold', 'OFF');
            response.setBodyAsBlob(Blob.valueOf('achoo'));
            return response;
        }
    }
    
    /**
     * https://docs.aws.amazon.com/AmazonS3/latest/API/API_GetObject.html#API_GetObject_RequestSyntax
     */
    global class GetObjectRequest
    {
        /**
         * The bucket name containing the object.
         * When using this API with an access point, you must direct requests to the access point
         * hostname. The access point hostname takes the form AccessPointName-AccountId.s3-
         * accesspoint.Region.amazonaws.com. When using this operation using an access point through
         * the AWS SDKs, you provide the access point ARN in place of the bucket name. For more
         * information about access point ARNs, see Using Access Points in the Amazon Simple Storage
         * Service Developer Guide.
         * Required: Yes
         */
        global String url = 'callout:S3';

        /**
         * Return the object only if its entity tag (ETag) is the same as the one specified,
         * otherwise return a 412 (precondition failed).
         */
        global String ifMatch;

        /**
         * Return the object only if it has been modified since the specified time, otherwise return
         * a 304 (not modified).
         */
        global Datetime ifModifiedSince;

        /**
         * Return the object only if its entity tag (ETag) is different from the one specified,
         * otherwise return a 304 (not modified).
         */
        global String ifNoneMatch;

        /**
         * Return the object only if it has not been modified since the specified time, otherwise
         * return a 412 (precondition failed).
         */
        global Datetime ifUnmodifiedSince;

        /**
         * Key of the object to get.
         */
        // key handled by endpoint

        /**
         * Part number of the object being read. This is a positive integer between 1 and 10,000.
         * Effectively performs a 'ranged' GET request for the part specified. Useful for
         * downloading just a part of an object.
         */
        global Integer partNumber;

        /**
         * Downloads the specified range bytes of an object.
         * For more information about the HTTP Range header,
         * see https://www.w3.org/Protocols/rfc2616/rfc2616-sec14.html#sec14.35.
         */
        global String range;

        /**
         * Sets the Cache-Control header of the response.
         */
        global String responseCacheControl;

        /**
         * Sets the Content-Disposition header of the response
         */
        global String responseContentDisposition;

        /**
         * Sets the Content-Encoding header of the response.
         */
        global String responseContentEncoding;

        /**
         * Sets the Content-Language header of the response.
         */
        global String responseContentLanguage;

        /**
         * Sets the Content-Type header of the response.
         */
        global String responseContentType;

        /**
         * Sets the Expires header of the response.
         */
        global Datetime responseExpires;

        /**
         * VersionId used to reference a specific version of the object.
         */
        global String versionId;

        /**
         * Confirms that the requester knows that they will be charged for the request.
         * Bucket owners need not specify this parameter in their requests.
         * Valid Values: requester
         */
        global String requestPayer;

        /**
         * Specifies the algorithm to use to when encrypting the object (for example, AES256).
         */
        global String serverSideEncryptionCustomerAlgorithm;

        /**
         * Specifies the customer-provided encryption key for Amazon S3 to use in encrypting data.
         * This value is used to store the object and then it is discarded; Amazon S3 does not store the encryption key.
         * The key must be appropriate for use with the algorithm specified in the x-amz-server-side​-encryption​-customer-algorithm header.
         */
        global Blob serverSideEncryptionCustomerKey;

        /**
         * Specifies the 128-bit MD5 digest of the encryption key according to RFC 1321.
         * Amazon S3 uses this header for a message integrity check to ensure that the encryption key was transmitted without error.
         */
        global Blob serverSideEncryptionCustomerKeyMD5;
    }
    
    /**
     * https://docs.aws.amazon.com/AmazonS3/latest/API/API_GetObject.html#API_GetObject_ResponseSyntax
     */
    global class GetObjectResponse
    {
        /**
         * Indicates that a range of bytes was specified.
         */
        global String acceptRanges;

        /**
         * Specifies caching behavior along the request/reply chain.
         */
        global String cacheControl;

        /**
         * Specifies presentational information for the object.
         */
        global String contentDisposition;

        /**
         * Specifies what content encodings have been applied to the object and thus what decoding mechanisms must be
         * applied to obtain the media-type referenced by the Content-Type header field.
         */
        global String contentEncoding;

        /**
         * The language the content is in.
         */
        global String contentLanguage;

        /**
         * Size of the body in bytes.
         */
        global Integer contentLength;

        /**
         * The portion of the object returned in the response.
         */
        global String contentRange;

        /**
         * A standard MIME type describing the format of the object data.
         */
        global String contentType;

        /**
         * An ETag is an opaque identifier assigned by a web server to a specific version of a resource found at a URL.
         */
        global String etag;

        /**
         * The date and time at which the object is no longer cacheable.
         */
        global Datetime expires;

        /**
         * Last modified date of the object
         */
        global Datetime lastModified;

        /**
         * Specifies whether the object retrieved was (true) or was not (false) a Delete Marker.
         * If false, this response header does not appear in the response.
         */
        global Boolean deleteMarker;

        /**
         * If the object expiration is configured (see PUT Bucket lifecycle), the response includes this header.
         * It includes the expiry-date and rule-id key-value pairs providing object expiration information.
         * The value of the rule-id is URL encoded.
         */
        global String expiration;

        /**
         * This is set to the number of metadata entries not returned in x-amz-meta headers.
         * This can happen if you create metadata using an API like SOAP that supports more flexible metadata than the REST API.
         * For example, using SOAP, you can create metadata whose values are not legal HTTP headers.
         */
        global Integer missingMeta;

        /**
         * The count of parts this object has.
         */
        global Integer mpPartsCount;

        /**
         * Indicates whether this object has an active legal hold. This field is only returned if you have permission to view an object's legal hold status.
         * Valid Values: ON | OFF
         */
        global String objectLockLegalHold;

        /**
         * The Object Lock mode currently in place for this object.
         * Valid Values: GOVERNANCE | COMPLIANCE
         */
        global String objectLockMode;

        /**
         * The date and time when this object's Object Lock will expire.
         */
        global Datetime objectLockRetainUntilDate;

        /**
         * Amazon S3 can return this if your request involves a bucket that is either a source or destination in a replication rule.
         * Valid Values: COMPLETE | PENDING | FAILED | REPLICA
         */
        global String replicationStatus;

        /**
         * If present, indicates that the requester was successfully charged for the request.
         * Valid Values: requester
         */
        global String requestCharged;

        /**
         * Provides information about object restoration operation and expiration time of the restored object copy.
         */
        global String restore;
        
        /**
         * The server-side encryption algorithm used when storing this object in Amazon S3 (for example, AES256, aws:kms).
         * Valid Values: AES256 | aws:kms
         */
        global String serverSideEncryption;

        /**
         * If present, specifies the ID of the AWS Key Management Service (AWS KMS) symmetric customer managed customer master key (CMK) that was used for the object.
         */
        global String serverSideEncryptionAwsKmsKeyId;

        /**
         * If server-side encryption with a customer-provided encryption key was requested,
         * the response will include this header confirming the encryption algorithm used.
         */
        global String serverSideEncryptionCustomerAlgorithm;
        
        /**
         * If server-side encryption with a customer-provided encryption key was requested, the response will include
         * this header to provide round-trip message integrity verification of the customer-provided encryption key.
         */
        global Blob serverSideEncryptionCustomerKeyMD5;

        /**
         * Provides storage class information of the object.
         * Amazon S3 returns this header for all objects except for Standard storage class objects.
         * Valid Values: STANDARD | REDUCED_REDUNDANCY | STANDARD_IA | ONEZONE_IA | INTELLIGENT_TIERING | GLACIER | DEEP_ARCHIVE
         */
        global String storageClass;

        /**
         * The number of tags, if any, on the object.
         */
        global Integer taggingCount;

        /**
         * Version of the object.
         */
        global String versionId;

        /**
         * If the bucket is configured as a website, redirects requests for this object to another object in the same
         * bucket or to an external URL. Amazon S3 stores the value of this header in the object metadata.
         */
        global String websiteRedirectLocation;

        /**
         * The following data is returned in binary format by the service.
         */
        global Blob body;
    }

    /**
     * The HEAD operation retrieves metadata from an object without returning the object itself.
     * This operation is useful if you're only interested in an object's metadata. To use HEAD, you
     * must have READ access to the object.
     * 
     * https://docs.aws.amazon.com/AmazonS3/latest/API/API_HeadObject.html
     */
    global class HeadObject implements HttpCalloutMock
    {
        global HeadObjectResponse call(HeadObjectRequest request)
        {
            if (Test.isRunningTest()) Test.setMock(HttpCalloutMock.class, this);
            System.Callable sdk = (System.Callable)Type.forName('AWS.SDK').newInstance();
            return (HeadObjectResponse)sdk.call(HeadObjectRequest.class.getName(),
            (Map<String,Object>)Json.deserializeUntyped(Json.serialize(request, true)));
        }
        
        public HttpResponse respond(HttpRequest request)
        {
            HttpResponse response = new HttpResponse();
            response.setStatusCode(304);
            response.setHeader('accept-ranges', 'bytes');
            response.setHeader('Cache-Control', 'No-cache');
            response.setHeader('Content-Disposition', 'attachment; filename=testing.txt');
            response.setHeader('Content-Encoding', 'x-gzip');
            response.setHeader('Content-Language', 'mi, en');
            response.setHeader('Content-Length', '123');
            response.setHeader('Content-Type', 'application/json');
            response.setHeader('ETag', '"1234567890abcdef1234567890abcdef"');
            response.setHeader('Expires', 'Wed, 25 Dec 2019 23:59:59 GMT');
            response.setHeader('Last-Modified', 'Wed, 25 Dec 2019 23:59:59 +0000');
            response.setHeader('x-amz-delete-marker', 'true');
            response.setHeader('x-amz-expiration', 'expiry-date="Wed, 25 Dec 2019 23:59:59 GMT", rule-id="picture-deletion-rule"');
            response.setHeader('x-amz-missing-meta', '123');
            response.setHeader('x-amz-mp-parts-count', '123');
            response.setHeader('x-amz-object-lock-legal-hold', 'OFF');
            response.setHeader('x-amz-object-lock-mode', 'GOVERNANCE');
            response.setHeader('x-amz-object-lock-retain-until-date', 'Wed, 25 Dec 2019 23:59:59 GMT');
            response.setHeader('x-amz-replication-status', 'COMPLETE');
            response.setHeader('x-amz-request-charged', 'requester');
            response.setHeader('x-amz-restore', 'ongoing-request="false", expiry-date="Wed, 25 Dec 2019 23:59:59 GMT"');
            return response;
        }
    }

    /**
     * https://docs.aws.amazon.com/AmazonS3/latest/API/API_HeadObject.html#API_HeadObject_RequestSyntax
     */
    global class HeadObjectRequest
    {
        /**
         * The name of the bucket containing the object.
         */
        global String url = 'callout:S3';

        /**
         * Return the object only if its entity tag (ETag) is the same as
         * the one specified, otherwise return a 412 (precondition failed).
         */
        global String ifMatch;

        /**
         * Return the object only if it has been modified since the
         * specified time, otherwise return a 304 (not modified).
         */
        global Datetime ifModifiedSince;

        /**
         * Return the object only if it has not been modified since the
         * specified time, otherwise return a 412 (precondition failed).
         */
        global String ifNoneMatch;
        
        /**
         * Return the object only if its entity tag (ETag) is different
         * from the one specified, otherwise return a 304 (not modified).
         */
        global Datetime ifUnmodifiedSince;

        /**
         * The object key.
         */
        // key handled by endpoint

        /**
         * Part number of the object being read. This is a positive integer between 1 and 10,000.
         * Effectively performs a 'ranged' HEAD request for the part specified. Useful querying
         * about the size of the part and the number of parts in this object.
         */
        global Integer partNumber;

        /**
         * Downloads the specified range bytes of an object.
         * For more information about the HTTP Range header,
         * see http://www.w3.org/Protocols/rfc2616/rfc2616-sec14.html#sec14.35.
         */
        global String range;

        /**
         * VersionId used to reference a specific version of the object.
         */
        global String versionId;

        /**
         * Confirms that the requester knows that they will be charged for the request.
         * Bucket owners need not specify this parameter in their requests.
         * Valid Values: requester
         */
        global String requestPayer;

        /**
         * Specifies the algorithm to use to when encrypting the object (for example, AES256).
         */
        global String serverSideEncryptionCustomerAlgorithm;

        /**
         * Specifies the customer-provided encryption key for Amazon S3 to use in encrypting data.
         * This value is used to store the object and then it is discarded; Amazon S3 does not store the encryption key.
         * The key must be appropriate for use with the algorithm specified in the x-amz-server-side​-encryption​-customer-algorithm header.
         */
        global Blob serverSideEncryptionCustomerKey;

        /**
         * Specifies the 128-bit MD5 digest of the encryption key according to RFC 1321.
         * Amazon S3 uses this header for a message integrity check to ensure that the encryption key was transmitted without error.
         */
        global Blob serverSideEncryptionCustomerKeyMD5;
    }

    /**
     * https://docs.aws.amazon.com/AmazonS3/latest/API/API_HeadObject.html#API_HeadObject_ResponseSyntax
     */
    global class HeadObjectResponse
    {
        /**
         * Indicates that a range of bytes was specified.
         */
        global String acceptRanges;

        /**
         * Specifies caching behavior along the request/reply chain.
         */
        global String cacheControl;

        /**
         * Specifies presentational information for the object.
         */
        global String contentDisposition;

        /**
         * Specifies what content encodings have been applied to the object and thus what decoding mechanisms must be applied to obtain the media-type referenced by the Content-Type header field.
         */
        global String contentEncoding;

        /**
         * The language the content is in.
         */
        global String contentLanguage;

        /**
         * Size of the body in bytes.
         */
        global Integer contentLength;

        /**
         * A standard MIME type describing the format of the object data.
         */
        global String contentType;

        /**
         * An ETag is an opaque identifier assigned by a web server to a specific version of a resource found at a URL.
         */
        global String etag;

        /**
         * The date and time at which the object is no longer cacheable.
         */
        global Datetime expires;

        /**
         * Last modified date of the object
         */
        global Datetime lastModified;

        /**
         * Specifies whether the object retrieved was (true) or was not (false) a Delete Marker. If false, this response header does not appear in the response.
         */
        global Boolean deleteMarker;

        /**
         * If the object expiration is configured (see PUT Bucket lifecycle), the response includes this header. It includes the expiry-date and rule-id key-value pairs providing object expiration information. The value of the rule-id is URL encoded.
         */
        global String expiration;

        /**
         * This is set to the number of metadata entries not returned in x-amz-meta headers. This can happen if you create metadata using an API like SOAP that supports more flexible metadata than the REST API. For example, using SOAP, you can create metadata whose values are not legal HTTP headers.
         */
        global Integer missingMeta;

        /**
         * The count of parts this object has.
         */
        global Integer mpPartsCount;

        /**
         * Specifies whether a legal hold is in effect for this object.
         * This header is only returned if the requester has the s3:GetObjectLegalHold permission.
         * This header is not returned if the specified version of this object has never had a legal hold applied.
         * For more information about S3 Object Lock, see Object Lock.
         * https://docs.aws.amazon.com/AmazonS3/latest/dev/object-lock.html
         * Valid Values: ON | OFF
         */
        global String objectLockLegalHold;

        /**
         * The Object Lock mode, if any, that's in effect for this object.
         * This header is only returned if the requester has the s3:GetObjectRetention permission.
         * For more information about S3 Object Lock, see Object Lock.
         * https://docs.aws.amazon.com/AmazonS3/latest/dev/object-lock.html
         * Valid Values: GOVERNANCE | COMPLIANCE
         */
        global String objectLockMode;

        /**
         * The date and time when the Object Lock retention period expires.
         * This header is only returned if the requester has the s3:GetObjectRetention permission.
         */
        global Datetime objectLockRetainUntilDate;

        /**
         * Amazon S3 can return this header if your request involves a bucket that is either a source or destination in a replication rule.
         * Valid Values: COMPLETE | PENDING | FAILED | REPLICA
         */
        global String replicationStatus;

        /**
         * If present, indicates that the requester was successfully charged for the request.
         * Valid Values: requester
         */
        global String requestCharged;

        /**
         * If the object is an archived object (an object whose storage class is GLACIER), the response includes this
         * header if either the archive restoration is in progress (see RestoreObject or an archive copy is already restored.
         * If an archive copy is already restored, the header value indicates when Amazon S3 is scheduled to delete the object copy.
         * For example: x-amz-restore: ongoing-request="false", expiry-date="Fri, 23 Dec 2012 00:00:00 GMT"
         * If the object restoration is in progress, the header returns the value ongoing-request="true".
         * For more information about archiving objects, see Transitioning Objects: General Considerations.
         * https://docs.aws.amazon.com/AmazonS3/latest/dev/object-lifecycle-mgmt.html#lifecycle-transition-general-considerations
         */
        global String restore;
    }
    
    /**
     * Returns a list of all buckets owned by the authenticated sender of the request.
     * 
     * https://docs.aws.amazon.com/AmazonS3/latest/API/API_ListBuckets.html
     */
    global class ListBuckets implements HttpCalloutMock
    {
        global ListBucketsResponse call(ListBucketsRequest request)
        {
            if (Test.isRunningTest()) Test.setMock(HttpCalloutMock.class, this);
            System.Callable sdk = (System.Callable)Type.forName('AWS.SDK').newInstance();
            return (ListBucketsResponse)sdk.call(ListBucketsRequest.class.getName(),
            (Map<String,Object>)Json.deserializeUntyped(Json.serialize(request, true)));
        }
        
        public HttpResponse respond(HttpRequest request)
        {
            HttpResponse response = new HttpResponse();
            response.setStatusCode(200);
            response.setHeader('Transfer-Encoding', 'chunked');
            response.setHeader('Server', 'AmazonS3');
            response.setHeader('x-amz-request-id', 'ABCDEF1234567890');
            response.setHeader('x-amz-id-2', 'abcdefghijklmnopqrstuvwxyz123456789012345678901234ABCDEFGHIJKLMNOPQRSTUVWXYZ');
            response.setHeader('Date', 'Wed, 25 Dec 2019 23:59:59 GMT');
            response.setHeader('Content-Type', 'application/xml');
            response.setBody('<?xml version="1.0" encoding="UTF-8"?>\n'
                + '<ListAllMyBucketsResult xmlns="http://s3.amazonaws.com/doc/2006-03-01/">'
                +     '<Owner>'
                +         '<DisplayName>testowner</DisplayName>'
                +         '<ID>11223344556677889900aabbccddeeff11223344556677889900aabbccddeeff</ID>'
                +     '</Owner>'
                +     '<Buckets>'
                +         '<Bucket>'
                +             '<Name>testbucket1</Name>'
                +             '<CreationDate>2019-12-25T23:59:59.000Z</CreationDate>'
                +         '</Bucket>'
                +         '<Bucket>'
                +             '<Name>testbucket2</Name>'
                +             '<CreationDate>2020-01-01T23:59:59.000Z</CreationDate>'
                +         '</Bucket>'
                +     '</Buckets>'
                + '</ListAllMyBucketsResult>'
            );
            return response;
        }
    }
    
    /**
     * https://docs.aws.amazon.com/AmazonS3/latest/API/API_ListBuckets.html#API_ListBuckets_RequestSyntax
     */
    global class ListBucketsRequest
    {
        /**
         * The request does not use any URI parameters.
         */
        global String url = 'callout:S3';
    }
    
    /**
     * https://docs.aws.amazon.com/AmazonS3/latest/API/API_ListBuckets.html#API_ListBuckets_ResponseSyntax
     */
    global class ListBucketsResponse
    {
        /**
         * Root level tag for the ListBucketsOutput parameters.
         * Required: Yes
         */
        global ListBucketsResponse() {}

        /**
         * The list of buckets owned by the requestor.
         * Type: Array of Bucket data types
         */
        global List<Bucket> buckets;

        /**
         * The owner of the buckets listed.
         * Type: Owner data type
         */
        global Owner owner;
    }
    
    /**
     * Returns some or all (up to 1,000) of the objects in a bucket. You can use the request
     * parameters as selection criteria to return a subset of the objects in a bucket. A 200 OK
     * response can contain valid or invalid XML. Be sure to design your application to parse the
     * contents of the response and handle it appropriately.
     * 
     * https://docs.aws.amazon.com/AmazonS3/latest/API/API_ListObjects.html
     */
    global class ListObjects implements HttpCalloutMock
    {
        global ListObjectsResponse call(ListObjectsRequest request)
        {
            if (Test.isRunningTest()) Test.setMock(HttpCalloutMock.class, this);
            System.Callable sdk = (System.Callable)Type.forName('AWS.SDK').newInstance();
            return (ListObjectsResponse)sdk.call(ListObjectsRequest.class.getName(),
            (Map<String,Object>)Json.deserializeUntyped(Json.serialize(request, true)));
        }
        
        public HttpResponse respond(HttpRequest request)
        {
            HttpResponse response = new HttpResponse();
            response.setStatusCode(200);
            response.setHeader('Transfer-Encoding', 'chunked');
            response.setHeader('Server', 'AmazonS3');
            response.setHeader('x-amz-request-id', 'ABCDEF1234567890');
            response.setHeader('x-amz-id-2', 'abcdefghijklmnopqrstuvwxyz123456789012345678901234ABCDEFGHIJKLMNOPQRSTUVWXYZ=');
            response.setHeader('x-amz-bucket-region', 'eu-west-2');
            response.setHeader('Date', 'Wed, 25 Dec 2019 23:59:59 GMT');
            response.setHeader('Content-Type', 'application/xml');
            response.setBody('<?xml version="1.0" encoding="UTF-8"?>\n'
                + '<ListBucketResult xmlns="http://s3.amazonaws.com/doc/2006-03-01/">'
                +     '<Name>testbucket</Name>'
                +     '<Prefix>prefix/</Prefix>'
                +     '<Marker>marker</Marker>'
                +     '<MaxKeys>1000</MaxKeys>'
                +     '<Delimiter>/</Delimiter>'
                +     '<IsTruncated>true</IsTruncated>'
                +     '<Contents>'
                +         '<Key>prefix/file1.ext</Key>'
                +         '<LastModified>2019-01-01T23:59:59.000Z</LastModified>'
                +         '<ETag>&quot;11223344556677889900aabbccddeeff&quot;</ETag>'
                +         '<Size>123</Size>'
                +         '<Owner>'
                +             '<ID>11223344556677889900aabbccddeeff11223344556677889900aabbccddeeff</ID>'
                +         '</Owner>'
                +         '<StorageClass>STANDARD</StorageClass>'
                +     '</Contents>'
                +     '<Contents>'
                +         '<Key>prefix/file2.ext</Key>'
                +         '<LastModified>2019-02-02T23:59:59.000Z</LastModified>'
                +         '<ETag>&quot;11223344556677889900aabbccddeeff&quot;</ETag>'
                +         '<Size>456</Size>'
                +         '<Owner>'
                +             '<ID>11223344556677889900aabbccddeeff11223344556677889900aabbccddeeff</ID>'
                +         '</Owner>'
                +         '<StorageClass>STANDARD</StorageClass>'
                +     '</Contents>'
                +     '<CommonPrefixes>'
                +         '<Prefix>prefix/folder1/</Prefix>'
                +     '</CommonPrefixes>'
                +     '<CommonPrefixes>'
                +         '<Prefix>prefix/folder2/</Prefix>'
                +     '</CommonPrefixes>'
                + '</ListBucketResult>'
            );
            return response;
        }
    }
    
    /**
     * https://docs.aws.amazon.com/AmazonS3/latest/API/API_ListObjects.html#API_ListObjects_RequestSyntax
     */
    global class ListObjectsRequest
    {
        /**
         * The name of the bucket containing the objects.
         * Required: Yes
         */
        global String url = 'callout:S3';
        
        /**
         * A delimiter is a character you use to group keys.
         */
        global String delimiter;

        /**
         * Requests Amazon S3 to encode the object keys in the response and specifies the encoding method to use.
         * An object key may contain any Unicode character; however, XML 1.0 parser cannot parse some characters,
         * such as characters with an ASCII value from 0 to 10. For characters that are not supported in XML 1.0,
         * you can add this parameter to request that Amazon S3 encode the keys in the response.
         * Valid Values: url
         */
        global String encodingType;

        /**
         * Specifies the key to start with when listing objects in a bucket.
         */
        global String marker;

        /**
         * Sets the maximum number of keys returned in the response.
         * The response might contain fewer keys but will never contain more.
         */
        global Integer maxKeys;

        /**
         * Limits the response to keys that begin with the specified prefix.
         */
        global String prefix;

        /**
         * Confirms that the requester knows that she or he will be charged for the list objects request.
         * Bucket owners need not specify this parameter in their requests.
         * Valid Values: requester
         */
        global String requestPayer;
    }
    
    /**
     * https://docs.aws.amazon.com/AmazonS3/latest/API/API_ListObjects.html#API_ListObjects_ResponseSyntax
     */
    global class ListObjectsResponse
    {
        /**
         * Root level tag for the ListObjectsOutput parameters.
         */
        // ListObjectsOutput handled by root element
        
        /**
         * All of the keys rolled up in a common prefix count as a single return when calculating the number of returns.
         * A response can contain CommonPrefixes only if you specify a delimiter.
         * CommonPrefixes contains all (if there are any) keys between Prefix and the next occurrence of the string specified by the delimiter.
         * CommonPrefixes lists keys that act like subdirectories in the directory specified by Prefix.
         * For example, if the prefix is notes/ and the delimiter is a slash (/) as in notes/summer/july, the common prefix is notes/summer/.
         * All of the keys that roll up into a common prefix count as a single return when calculating the number of returns.
         */
        global List<CommonPrefix> commonPrefixes;
        
        /**
         * Metadata about each object returned.
         */
        global List<Content> contents;

        /**
         * Causes keys that contain the same string between the prefix and the first occurrence of the
         * delimiter to be rolled up into a single result element in the CommonPrefixes collection.
         * These rolled-up keys are not returned elsewhere in the response. Each
         * rolled-up result counts as only one return against the MaxKeys value.
         */
        global String delimiter;
        
        /**
         * Encoding type used by Amazon S3 to encode object keys in the response.
         */
        global String encodingType;
        
        /**
         * A flag that indicates whether Amazon S3 returned all of the results that satisfied the search criteria.
         */
        global Boolean isTruncated;
        
        /**
         * Indicates where in the bucket listing begins.
         * Marker is included in the response if it was sent with the request.
         */
        global String marker;
        
        /**
         * The maximum number of keys returned in the response body.
         */
        global Integer maxKeys;
        
        /**
         * Bucket name.
         */
        global String name;
        
        /**
         * When response is truncated (the IsTruncated element value in the response is true), you can use the key name
         * in this field as marker in the subsequent request to get next set of objects. Amazon S3 lists objects in
         * alphabetical order Note: This element is returned only if you have delimiter request parameter specified.
         * If response does not include the NextMaker and it is truncated, you can use the value of the last
         * Key in the response as the marker in the subsequent request to get the next set of object keys.
         */
        global String nextMarker;

        /**
         * Keys that begin with the indicated prefix.
         */
        global String prefix;
    }
    
    /**
     * Adds an object to a bucket.
     * You must have WRITE permissions on a bucket to add an object to it.
     * 
     * https://docs.aws.amazon.com/AmazonS3/latest/API/API_PutObject.html
     */
    global class PutObject implements HttpCalloutMock
    {
        global PutObjectResponse call(PutObjectRequest request)
        {
            if (Test.isRunningTest()) Test.setMock(HttpCalloutMock.class, this);
            System.Callable sdk = (System.Callable)Type.forName('AWS.SDK').newInstance();
            return (PutObjectResponse)sdk.call(PutObjectRequest.class.getName(),
            (Map<String,Object>)Json.deserializeUntyped(Json.serialize(request, true)));
        }
        
        public HttpResponse respond(HttpRequest request)
        {
            HttpResponse response = new HttpResponse();
            response.setStatusCode(200);
            response.setHeader('ETag', '"1234567890abcdef1234567890abcdef"');
            response.setHeader('x-amz-expiration', 'expiry-date="Wed, 25 Dec 2019 23:59:59 GMT", rule-id="picture-deletion-rule"');
            response.setHeader('x-amz-request-charged', 'requester');
            response.setHeader('x-amz-server-side-encryption', 'aws:kms');
            response.setHeader('x-amz-server-side-encryption-aws-kms-key-id', 'arn:aws:kms:us-east-1:123456789012:key/11223344-5566-7788-9900-aabbccddeeff');
            response.setHeader('x-amz-server-side-encryption-context', 'abcdefghijklmnop12345678');
            response.setHeader('x-amz-server-side-encryption-customer-algorithm', 'AES256');
            response.setHeader('x-amz-server-side-encryption-customer-key-MD5', 'abcdefghijklmnop12345678');
            response.setHeader('x-amz-version-id', 'abcdefghijk1234567890ABCDEFGHIJK');
            return response;
        }
    }
    
    /**
     * Adds an object to a bucket. You must have WRITE permissions on a bucket to add an object to it.
     * 
     * https://docs.aws.amazon.com/AmazonS3/latest/API/API_PutObject.html#API_PutObject_RequestSyntax
     */
    global class PutObjectRequest
    {
        /**
         * Bucket name to which the PUT operation was initiated.
         */
        global String url = 'callout:S3';
        
        /**
         * Can be used to specify caching behavior along the request/reply chain.
         * For more information, see http://www.w3.org/Protocols/rfc2616/rfc2616-sec14.html#sec14.9.
         */
        global String cacheControl;

        /**
         * Specifies presentational information for the object.
         * For more information, see http://www.w3.org/Protocols/rfc2616/rfc2616-sec19.html#sec19.5.1.
         */
        global String contentDisposition;

        /**
         * Specifies what content encodings have been applied to the object and thus what decoding mechanisms must be
         * applied to obtain the media-type referenced by the Content-Type header field. For more information,
         * see http://www.w3.org/Protocols/rfc2616/rfc2616-sec14.html#sec14.11.
         */
        global String contentEncoding;

        /**
         * The language the content is in.
         */
        global String contentLanguage;

        /**
         * Size of the body in bytes. This parameter is useful when the size of the body cannot be determined
         * automatically. For more information, see http://www.w3.org/Protocols/rfc2616/rfc2616-sec14.html#sec14.13.
         */
        // contentLength handled by named credential

        /**
         * The base64-encoded 128-bit MD5 digest of the message (without the headers) according to RFC 1864. This header
         * can be used as a message integrity check to verify that the data is the same data that was originally sent.
         * Although it is optional, we recommend using the Content-MD5 mechanism as an end-to-end integrity check.
         * For more information about REST request authentication, see REST Authentication.
         */
        // contentMD5 handled by named credential

        /**
         * A standard MIME type describing the format of the contents.
         * For more information, see http://www.w3.org/Protocols/rfc2616/rfc2616-sec14.html#sec14.17.
         */
        global String contentType;

        /**
         * The date and time at which the object is no longer cacheable.
         * For more information, see http://www.w3.org/Protocols/rfc2616/rfc2616-sec14.html#sec14.21.
         */
        global Datetime expires;

        /**
         * Object key for which the PUT operation was initiated.
         */
        // key handled by endpoint
        
        /**
         * The canned ACL to apply to the object. For more information, see Canned ACL.
         * https://docs.aws.amazon.com/AmazonS3/latest/dev/acl-overview.html#CannedACL
         * Valid Values: | private-read | private-read-write | authenticated-read | aws-exec-read | bucket-owner-read | bucket-owner-full-control
         */
        global String acl;

        /**
         * Gives the grantee READ, READ_ACP, and WRITE_ACP permissions on the object.
         */
        global String grantFullControl;

        /**
         * Allows grantee to read the object data and its metadata.
         */
        global String grantRead;

        /**
         * Allows grantee to read the object ACL.
         */
        global String grantReadAcp;

        /**
         * Allows grantee to write the ACL for the applicable object.
         */
        global String grantWriteAcp;

        /**
         * Specifies whether a legal hold will be applied to this object.
         * For more information about S3 Object Lock, see Object Lock.
         * https://docs.aws.amazon.com/AmazonS3/latest/dev/object-lock.html
         * Valid Values: ON | OFF
         */
        global String objectLockLegalHold;

        /**
         * The Object Lock mode that you want to apply to this object.
         * Valid Values: GOVERNANCE | COMPLIANCE
         */
        global String objectLockMode;

        /**
         * The date and time when you want this object's Object Lock to expire.
         */
        global Datetime objectLockRetainUntilDate;

        /**
         * Confirms that the requester knows that they will be charged for the request.
         * Bucket owners need not specify this parameter in their requests.
         * Valid Values: requester
         */
        global String requestPayer;

        /**
         * The server-side encryption algorithm used when storing this object in Amazon S3 (for example, AES256, aws:kms).
         * Valid Values: AES256 | aws:kms
         */
        global String serverSideEncryption;

        /**
         * If x-amz-server-side-encryption is present and has the value of aws:kms, this header specifies the ID of the AWS
         * Key Management Service (AWS KMS) symmetrical customer managed customer master key (CMK) that was used for the object.
         * If the value of x-amz-server-side-encryption is aws:kms, this header specifies the ID of the symmetric customer managed
         * AWS KMS CMK that will be used for the object. If you specify x-amz-server-side-encryption:aws:kms, but do not provide
         * x-amz-server-side-encryption-aws-kms-key-id, Amazon S3 uses the AWS managed CMK in AWS to protect the data.
         */
        global String serverSideEncryptionAwsKmsKeyId;

        /**
         * Specifies the AWS KMS Encryption Context to use for object encryption.
         * The value of this header is a base64-encoded UTF-8 string holding JSON with the encryption context key-value pairs.
         * https://docs.aws.amazon.com/kms/latest/developerguide/concepts.html#encrypt_context
         */
        global Blob serverSideEncryptionContext;

        /**
         * Specifies the algorithm to use to when encrypting the object (for example, AES256).
         */
        global String serverSideEncryptionCustomerAlgorithm;

        /**
         * Specifies the customer-provided encryption key for Amazon S3 to use in encrypting data.
         * This value is used to store the object and then it is discarded; Amazon S3 does not store the encryption key.
         * The key must be appropriate for use with the algorithm specified in the x-amz-server-side​-encryption​-customer-algorithm header.
         */
        global Blob serverSideEncryptionCustomerKey;

        /**
         * Specifies the 128-bit MD5 digest of the encryption key according to RFC 1321.
         * Amazon S3 uses this header for a message integrity check to ensure that the encryption key was transmitted without error.
         */
        global Blob serverSideEncryptionCustomerKeyMD5;

        /**
         * If you don't specify, Standard is the default storage class. Amazon S3 supports other storage classes.
         * Valid Values: STANDARD | REDUCED_REDUNDANCY | STANDARD_IA | ONEZONE_IA | INTELLIGENT_TIERING | GLACIER | DEEP_ARCHIVE
         */
        global String storageClass;

        /**
         * The tag-set for the object. The tag-set must be encoded as URL Query parameters. (For example, "Key1=Value1")
         */
        global String tagging;

        /**
         * If the bucket is configured as a website, redirects requests for this object to another object in the same
         * bucket or to an external URL. Amazon S3 stores the value of this header in the object metadata.
         * For information about object metadata, see Object Key and Metadata.
         * https://docs.aws.amazon.com/AmazonS3/latest/dev/UsingMetadata.html
         * In the following example, the request header sets the redirect to an object (anotherPage.html) in the same bucket: x-amz-website-redirect-location: /anotherPage.html
         * In the following example, the request header sets the object redirect to another website: x-amz-website-redirect-location: http://www.example.com/
         * For more information about website hosting in Amazon S3, see Hosting Websites on Amazon S3 https://docs.aws.amazon.com/AmazonS3/latest/dev/WebsiteHosting.html
         * and How to Configure Website Page Redirects. https://docs.aws.amazon.com/AmazonS3/latest/dev/how-to-page-redirect.html
         */
        global String websiteRedirectLocation;

        /**
         * The request accepts the following binary data.
         */
        global Blob body;
    }
    
    /**
     * https://docs.aws.amazon.com/AmazonS3/latest/API/API_PutObject.html#API_PutObject_ResponseSyntax
     */
    global class PutObjectResponse
    {
        /**
         * Entity tag for the uploaded object.
         */
        global String etag;

        /**
         * If the expiration is configured for the object (see PutBucketLifecycleConfiguration), the response includes this header.
         * It includes the expiry-date and rule-id key-value pairs that provide information about object expiration.
         * The value of the rule-id is URL encoded.
         */
        global String expiration;

        /**
         * If present, indicates that the requester was successfully charged for the request.
         * Valid Values: requester
         */
        global String requestCharged;

        /**
         * If you specified server-side encryption either with an AWS KMS customer master key (CMK) or Amazon S3-managed
         * encryption key in your PUT request, the response includes this header. It confirms the encryption algorithm
         * that Amazon S3 used to encrypt the object.
         * Valid Values: AES256 | aws:kms
         */
        global String serverSideEncryption;

        /**
         * If x-amz-server-side-encryption is present and has the value of aws:kms, this header specifies the ID of the
         * AWS Key Management Service (AWS KMS) symmetric customer managed customer master key (CMK) that was used for the object.
         */
        global String serverSideEncryptionAwsKmsKeyId;

        /**
         * If present, specifies the AWS KMS Encryption Context to use for object encryption. The value of this
         * header is a base64-encoded UTF-8 string holding JSON with the encryption context key-value pairs.
         * https://docs.aws.amazon.com/kms/latest/developerguide/concepts.html#encrypt_context
         */
        global Blob serverSideEncryptionContext;

        /**
         * If server-side encryption with a customer-provided encryption key was requested,
         * the response will include this header confirming the encryption algorithm used.
         */
        global String serverSideEncryptionCustomerAlgorithm;

        /**
         * If server-side encryption with a customer-provided encryption key was requested, the response will include
         * this header to provide round-trip message integrity verification of the customer-provided encryption key.
         */
        global Blob serverSideEncryptionCustomerKeyMD5;

        /**
         * Version of the object.
         */
        global String versionId;
    }
    
    /**
     * Container for the owner's display name and ID.
     * 
     * https://docs.aws.amazon.com/AmazonS3/latest/API/API_Owner.html
     */
    global class Owner
    {
        /**
         * Container for the display name of the owner.
         * Type: String
         * Required: No
         */
        global String displayName;

        /**
         * Container for the ID of the owner.
         * Type: String
         * Required: No
         */
        global String id;
    }
    
    /**
     * In terms of implementation, a Bucket is a resource. An Amazon S3 bucket name is globally
     * unique, and the namespace is shared by all AWS accounts.
     * 
     * https://docs.aws.amazon.com/AmazonS3/latest/API/API_Bucket.html
     */
    global class Bucket
    {
        /**
         * Date the bucket was created.
         * Type: Timestamp
         * Required: No
         */
        global Datetime creationDate;

        /**
         * The name of the bucket.
         * Type: String
         * Required: No
         */
        global String name;
    }
    
    /**
     * An object consists of data and its descriptive metadata.
     * 
     * https://docs.aws.amazon.com/AmazonS3/latest/API/API_Object.html
     */
    global class Content
    {
        /**
         * The entity tag is an MD5 hash of the object. ETag reflects only changes to the contents of an object, not its metadata.
         */
        global String etag;
        
        /**
         * The name that you assign to an object. You use the object key to retrieve the object.
         */
        global String key;

        /**
         * The date the Object was Last Modified
         */
        global Datetime lastModified;
        
        /**
         * The owner of the object
         */
        global Owner owner;
        
        /**
         * Size in bytes of the object
         */
        global Integer size;

        /**
         * The class of storage used to store the object.
         * Valid Values: STANDARD | REDUCED_REDUNDANCY | GLACIER | STANDARD_IA | ONEZONE_IA | INTELLIGENT_TIERING | DEEP_ARCHIVE
         */
        global String storageClass;
    }

    /**
     * https://docs.aws.amazon.com/AmazonS3/latest/API/API_CreateBucket.html#AmazonS3-CreateBucket-request-CreateBucketConfiguration
     */
    global class CreateBucketConfiguration
    {
        /**
         * Specifies the Region where the bucket will be created. If you don't specify a Region, the
         * bucket is created in the US East (N. Virginia) Region (us-east-1).
         * Type: String
         * Valid Values: af-south-1 | ap-east-1 | ap-northeast-1 | ap-northeast-2 | ap-northeast-3
         * | ap-south-1 | ap-southeast-1 | ap-southeast-2 | ca-central-1 | cn-north-1
         * | cn-northwest-1 | EU | eu-central-1 | eu-north-1 | eu-south-1 | eu-west-1
         * | eu-west-2 | eu-west-3 | me-south-1 | sa-east-1 | us-east-2 | us-gov-east-1
         * | us-gov-west-1 | us-west-1 | us-west-2
         * Required: No
         */
        global String locationConstraint;
    }

    /**
     * Container for all (if there are any) keys between Prefix and the next occurrence of the
     * string specified by a delimiter. CommonPrefixes lists keys that act like subdirectories in
     * the directory specified by Prefix. For example, if the prefix is notes/ and the delimiter is
     * a slash (/) as in notes/summer/july, the common prefix is notes/summer/.
     * 
     * https://docs.aws.amazon.com/AmazonS3/latest/API/API_CommonPrefix.html
     */
    global class CommonPrefix
    {
        /**
         * Container for the specified common prefix.
         * Type: String
         * Required: No
         */
        global String prefix;
    }

    /**
     * Object Identifier is unique value to identify objects.
     * 
     * https://docs.aws.amazon.com/AmazonS3/latest/API/API_ObjectIdentifier.html
     */
    global class ObjectIdentifier
    {
        /**
         * Key name of the object to delete.
         * Type: String
         * Length Constraints: Minimum length of 1.
         * Required: Yes
         */
        global String key;

        /**
         * VersionId for the specific version of the object to delete.
         * Type: String
         * Required: No
         */
        global String versionId;
    }

    /**
     * Information about the deleted object.
     * 
     * https://docs.aws.amazon.com/AmazonS3/latest/API/API_DeletedObject.html
     */
    global class DeletedObject
    {
        /**
         * Specifies whether the versioned object that was permanently deleted was (true) or was not
         * (false) a delete marker. In a simple DELETE, this header indicates whether (true) or not
         * (false) a delete marker was created.
         * Type: Boolean
         * Required: No
         */
        global Boolean deleteMarker;

        /**
         * The version ID of the delete marker created as a result of the DELETE operation. If you
         * delete a specific object version, the value returned by this header is the version ID of
         * the object version deleted.
         * Type: String
         * Required: No
         */
        global String deleteMarkerVersionId;

        /**
         * The name of the deleted object.
         * Type: String
         * Length Constraints: Minimum length of 1.
         * Required: No
         */
        global String key;

        /**
         * The version ID of the deleted object.
         * Type: String
         * Required: No
         */
        global String versionId;
    }

    /**
     * https://docs.aws.amazon.com/AmazonS3/latest/API/API_DeleteObjects.html#API_DeleteObjects_RequestSyntax
     * 
     * Root level tag for the Delete parameters.
     */
    global class Deletes
    {
        /**
         * The objects to delete.
         * Type: Array of ObjectIdentifier data types
         * Required: Yes
         */
        global List<ObjectIdentifier> objects = new List<ObjectIdentifier>();

        /**
         * Element to enable quiet mode for the request. When you add this element, you must set its value to true.
         * Type: Boolean
         * Required: No
         */
        global Boolean quiet = false;
    }

    /**
     * Container for all error elements.
     * 
     * https://docs.aws.amazon.com/AmazonS3/latest/API/API_Error.html
     */
    global class Error
    {
        /**
         * The error code is a string that uniquely identifies an error condition. It is meant to be
         * read and understood by programs that detect and handle errors by type.
         * Type: String
         * Required: No
         */
        global String code;

        /**
         * The error key.
         * Type: String
         * Length Constraints: Minimum length of 1.
         * Required: No
         */
        global String key;

        /**
         * The error message contains a generic description of the error condition in English. It is
         * intended for a human audience. Simple programs display the message directly to the end
         * user if they encounter an error condition they don't know how or don't care to handle.
         * Sophisticated programs with more exhaustive error handling and proper
         * internationalization are more likely to ignore the error message.
         * Type: String
         * Required: No
         */
        global String message;

        /**
         * The version ID of the error.
         * Type: String
         * Required: No
         */
        global String versionId;
    }
    
}