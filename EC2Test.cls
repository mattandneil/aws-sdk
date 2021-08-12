@IsTest class EC2Test
{
    @IsTest static void testDescribeInstancesRequest()
    {
        // arrange
        EC2.DescribeInstancesRequest request = new EC2.DescribeInstancesRequest();
        request.url = 'callout:test';
        request.instanceId = new List<String>{'i-01234567890abcdef'};
        request.filter = new List<EC2.Filter>();
        request.filter.add(new EC2.Filter());
        request.filter[0].name = 'instance-state-name';
        request.filter[0].value = new List<String>{'running'};
        request.dryRun = false;
        request.maxResults = 1;
        request.nextToken = 'abcdefghijklmnopqr1234567890ABCDEFGHIJKLMNOPQRST';
        
        // act
        HttpRequest http = request(request);
        Map<String,Object> params = params(http);
        
        // assert
        System.assertEquals('POST', http.getMethod());
        System.assertEquals('callout:test', http.getEndpoint());
        System.assertEquals('application/x-www-form-urlencoded', http.getHeader('Content-Type'));
        System.assertEquals('i-01234567890abcdef', params.get('InstanceId.1'));
        System.assertEquals('instance-state-name', params.get('Filter.1.Name'));
        System.assertEquals('running', params.get('Filter.1.Value.1'));
        System.assertEquals('false', params.get('DryRun'));
        System.assertEquals('1', params.get('MaxResults'));
        System.assertEquals('abcdefghijklmnopqr1234567890ABCDEFGHIJKLMNOPQRST', params.get('NextToken'));
    }
    
    @IsTest static void testDescribeInstancesResponse()
    {
        // act
        EC2.DescribeInstancesRequest request = new EC2.DescribeInstancesRequest();
        EC2.DescribeInstancesResponse response = new EC2.DescribeInstances().call(request);
        
        // assert
        System.assertEquals('11223344-5566-7788-9900-aabbccddeeff', response.requestId);
        System.assertEquals('r-01234567890abcdef', response.reservationSet[0].reservationId);
        System.assertEquals('123456789012', response.reservationSet[0].ownerId);
        System.assertEquals(null, response.reservationSet[0].groupSet);
        System.assertEquals('i-0abcdef1234567890', response.reservationSet[0].instancesSet[0].instanceId);
        System.assertEquals('ami-12345678', response.reservationSet[0].instancesSet[0].imageId);
        System.assertEquals(48, response.reservationSet[0].instancesSet[0].instanceState.code);
        System.assertEquals('terminated', response.reservationSet[0].instancesSet[0].instanceState.name);
        System.assertEquals(null, response.reservationSet[0].instancesSet[0].privateDnsName);
        System.assertEquals(null, response.reservationSet[0].instancesSet[0].dnsName);
        System.assertEquals('User initiated (2020-12-25 23:59:59 GMT)', response.reservationSet[0].instancesSet[0].reason);
        System.assertEquals(0, response.reservationSet[0].instancesSet[0].amiLaunchIndex);
        System.assertEquals(null, response.reservationSet[0].instancesSet[0].productCodes);
        System.assertEquals('m1.small', response.reservationSet[0].instancesSet[0].instanceType);
        System.assertEquals(Datetime.newInstanceGmt(2020, 12, 25, 23, 59, 59), response.reservationSet[0].instancesSet[0].launchTime);
        System.assertEquals('us-east-1b', response.reservationSet[0].instancesSet[0].placement.availabilityZone);
        System.assertEquals(null, response.reservationSet[0].instancesSet[0].placement.groupName);
        System.assertEquals('default', response.reservationSet[0].instancesSet[0].placement.tenancy);
        System.assertEquals('disabled', response.reservationSet[0].instancesSet[0].monitoring.state);
        System.assertEquals(null, response.reservationSet[0].instancesSet[0].groupSet);
        System.assertEquals('Client.UserInitiatedShutdown', response.reservationSet[0].instancesSet[0].stateReason.code);
        System.assertEquals('Client.UserInitiatedShutdown: User initiated shutdown', response.reservationSet[0].instancesSet[0].stateReason.message);
        System.assertEquals('x86_64', response.reservationSet[0].instancesSet[0].architecture);
        System.assertEquals('ebs', response.reservationSet[0].instancesSet[0].rootDeviceType);
        System.assertEquals('/dev/xvda', response.reservationSet[0].instancesSet[0].rootDeviceName);
        System.assertEquals(null, response.reservationSet[0].instancesSet[0].blockDeviceMapping);
        System.assertEquals('hvm', response.reservationSet[0].instancesSet[0].virtualizationType);
        System.assertEquals(null, response.reservationSet[0].instancesSet[0].clientToken);
        System.assertEquals('xen', response.reservationSet[0].instancesSet[0].hypervisor);
        System.assertEquals(null, response.reservationSet[0].instancesSet[0].networkInterfaceSet);
        System.assertEquals(false, response.reservationSet[0].instancesSet[0].ebsOptimized);
        System.assertEquals(1, response.reservationSet[0].instancesSet[0].cpuOptions.coreCount);
        System.assertEquals(1, response.reservationSet[0].instancesSet[0].cpuOptions.threadsPerCore);
        System.assertEquals('open', response.reservationSet[0].instancesSet[0].capacityReservationSpecification.capacityReservationPreference);
        System.assertEquals(false, response.reservationSet[0].instancesSet[0].hibernationOptions.configured);
        // System.assertEquals(false, response.reservationSet[0].instancesSet[0].enclaveOptions); // enclaveOptions not in docs
        System.assertEquals('pending', response.reservationSet[0].instancesSet[0].metadataOptions.state);
        System.assertEquals('optional', response.reservationSet[0].instancesSet[0].metadataOptions.httpTokens);
        System.assertEquals(1, response.reservationSet[0].instancesSet[0].metadataOptions.httpPutResponseHopLimit);
        System.assertEquals('enabled', response.reservationSet[0].instancesSet[0].metadataOptions.httpEndpoint);
    }
    
    @IsTest static void testDescribeRegionsRequest()
    {
        // arrange
        EC2.DescribeRegionsRequest request = new EC2.DescribeRegionsRequest();
        request.url = 'callout:ec2';
        request.allRegions = true;
        request.dryRun = false;
        request.filter = new List<EC2.Filter>();
        request.filter.add(new EC2.Filter());
        request.filter[0].name = 'region-name';
        request.filter[0].value = new List<String>{'us-east-1', 'us-east-2'};
        request.regionName = new List<String>{'us-east-1', 'us-east-2'};
        
        // act
        HttpRequest http = request(request);
        Map<String,Object> params = params(http);
        
        System.assertEquals('POST', http.getMethod());
        System.assertEquals('callout:ec2', http.getEndpoint());
        System.assertEquals('application/x-www-form-urlencoded', http.getHeader('Content-Type'));
        System.assertEquals('2016-11-15', params.get('Version'));
        System.assertEquals('DescribeRegions', params.get('Action'));
        System.assertEquals('true', params.get('AllRegions'));
        System.assertEquals('region-name', params.get('Filter.1.Name'));
        System.assertEquals('us-east-1', params.get('Filter.1.Value.1'));
        System.assertEquals('us-east-2', params.get('Filter.1.Value.2'));
    }
    
    @IsTest static void testDescribeRegionsResponse()
    {
        // act
        EC2.DescribeRegionsRequest request = new EC2.DescribeRegionsRequest();
        EC2.DescribeRegionsResponse response = new EC2.DescribeRegions().call(request);
        
        // assert
        System.assertEquals('11223344-5566-7788-9900-aabbccddeeff', response.requestId);
        System.assertEquals('eu-north-1', response.regionInfo[0].regionName);
        System.assertEquals('ec2.eu-north-1.amazonaws.com', response.regionInfo[0].regionEndpoint);
        System.assertEquals('opt-in-not-required', response.regionInfo[0].optInStatus);
        System.assertEquals('ap-south-1', response.regionInfo[1].regionName);
        System.assertEquals('ec2.ap-south-1.amazonaws.com', response.regionInfo[1].regionEndpoint);
        System.assertEquals('opt-in-not-required', response.regionInfo[1].optInStatus);
    }
    
    @IsTest static void testRunInstancesRequest()
    {
        // arrange
        EC2.RunInstancesRequest request = new EC2.RunInstancesRequest();
        request.url = 'callout:ec2';
        request.additionalInfo = 'additional';
        request.blockDeviceMapping = new List<EC2.BlockDeviceMapping>();
        request.capacityReservationSpecification = new EC2.CapacityReservationSpecification();
        request.clientToken = 'clientToken';
        request.cpuOptions = new EC2.CpuOptions();
        request.creditSpecification = new EC2.CreditSpecification();
        request.disableApiTermination = false;
        request.dryRun = true;
        request.ebsOptimized = false;
        request.elasticGpuSpecification = new List<EC2.ElasticGpuSpecification>();
        request.elasticInferenceAccelerator = new List<EC2.ElasticInferenceAccelerator>();
        request.hibernationOptions = new EC2.HibernationOptions();
        request.iamInstanceProfile = new EC2.IamInstanceProfileSpecification();
        request.imageId = 'ami-08111162';
        request.instanceInitiatedShutdownBehavior = 'terminate';
        request.instanceMarketOptions = new EC2.InstanceMarketOptions();
        request.instanceType = 't1.micro';
        request.ipv6Address = new List<EC2.InstanceIpv6Address>();
        request.ipv6AddressCount = 2;
        request.kernelId = 'kernelId';
        request.keyName = 'keyName';
        request.launchTemplate = new EC2.LaunchTemplateSpecification();
        request.licenseSpecification = new List<EC2.LicenseConfiguration>();
        request.maxCount = 1;
        request.metadataOptions = new EC2.InstanceMetadataOptions();
        request.minCount = 1;
        request.monitoring = new EC2.RunInstancesMonitoringEnabled();
        request.networkInterface = new List<EC2.InstanceNetworkInterfaceSpecification>();
        request.placement = new EC2.Placement();
        request.privateIpAddress = '11.22.33.44';
        request.ramdiskId = 'ramdiskId';
        request.securityGroup = new List<String>{'123'};
        request.securityGroupId = new List<String>{'123'};
        request.subnetId = 'subnetId';
        request.tagSpecification = new List<EC2.TagSpecification>();
        request.userData = Blob.valueOf('#!/bin/bash\nshutdown -h now');
        
        // act
        HttpRequest http = request(request);
        Map<String,Object> params = params(http);
        
        System.assertEquals('POST', http.getMethod());
        System.assertEquals('callout:ec2', http.getEndpoint());
        System.assertEquals('application/x-www-form-urlencoded', http.getHeader('Content-Type'));
        System.assertEquals('2016-11-15', params.get('Version'));
        System.assertEquals('RunInstances', params.get('Action'));
        System.assertEquals('additional', params.get('AdditionalInfo'));
        System.assertEquals('clientToken', params.get('ClientToken'));
        System.assertEquals('ami-08111162', params.get('ImageId'));
        System.assertEquals('terminate', params.get('InstanceInitiatedShutdownBehavior'));
        System.assertEquals('t1.micro', params.get('InstanceType'));
        System.assertEquals('kernelId', params.get('KernelId'));
        System.assertEquals('keyName', params.get('KeyName'));
        System.assertEquals('1', params.get('MaxCount'));
        System.assertEquals('1', params.get('MinCount'));
        System.assertEquals('11.22.33.44', params.get('PrivateIpAddress'));
        System.assertEquals('ramdiskId', params.get('RamdiskId'));
        System.assertEquals('123', params.get('SecurityGroup.1'));
        System.assertEquals('123', params.get('SecurityGroupId.1'));
        System.assertEquals('subnetId', params.get('SubnetId'));
        System.assertEquals('IyEvYmluL2Jhc2gKc2h1dGRvd24gLWggbm93', params.get('UserData'));
    }
    
    @IsTest static void testRunInstancesResponse()
    {
        // act
        EC2.RunInstancesRequest request = new EC2.RunInstancesRequest();
        EC2.RunInstancesResponse response = new EC2.RunInstances().call(request);
        
        // assert
        System.assertEquals('11223344-5566-7788-9900-aabbccddeeff', response.requestId);
        System.assertEquals('r-0abcdef1234567890', response.reservationId);
        System.assertEquals('123456789012', response.ownerId);
        System.assertEquals(null, response.groupSet);
        System.assertEquals('i-0abcdef1234567890', response.instancesSet[0].instanceId);
        System.assertEquals('ami-12345678', response.instancesSet[0].imageId);
        System.assertEquals(0, response.instancesSet[0].instanceState.code);
        System.assertEquals('pending', response.instancesSet[0].instanceState.name);
        System.assertEquals('ip-172-11-22-33.ec2.internal', response.instancesSet[0].privateDnsName);
        System.assertEquals(null, response.instancesSet[0].dnsName);
        System.assertEquals(null, response.instancesSet[0].reason);
        System.assertEquals(0, response.instancesSet[0].amiLaunchIndex);
        System.assertEquals(null, response.instancesSet[0].productCodes);
        System.assertEquals('m1.small', response.instancesSet[0].instanceType);
        System.assertEquals(Datetime.newInstanceGmt(2019, 12, 25, 23, 59, 59), response.instancesSet[0].launchTime);
        System.assertEquals('us-east-1b', response.instancesSet[0].placement.availabilityZone);
        System.assertEquals(null, response.instancesSet[0].placement.groupName);
        System.assertEquals('default', response.instancesSet[0].placement.tenancy);
        System.assertEquals('disabled', response.instancesSet[0].monitoring.state);
        System.assertEquals('subnet-a1b2c3d4', response.instancesSet[0].subnetId);
        System.assertEquals('vpc-a1b2c3d4', response.instancesSet[0].vpcId);
        System.assertEquals('172.11.22.33', response.instancesSet[0].privateIpAddress);
        System.assertEquals(true, response.instancesSet[0].sourceDestCheck);
        System.assertEquals('sg-a1b2c3d4', response.instancesSet[0].groupSet[0].groupId);
        System.assertEquals('default', response.instancesSet[0].groupSet[0].groupName);
        System.assertEquals('pending', response.instancesSet[0].stateReason.code);
        System.assertEquals('pending', response.instancesSet[0].stateReason.message);
        System.assertEquals('x86_64', response.instancesSet[0].architecture);
        System.assertEquals('ebs', response.instancesSet[0].rootDeviceType);
        System.assertEquals('/dev/xvda', response.instancesSet[0].rootDeviceName);
        System.assertEquals(null, response.instancesSet[0].blockDeviceMapping);
        System.assertEquals('hvm', response.instancesSet[0].virtualizationType);
        System.assertEquals(null, response.instancesSet[0].clientToken);
        System.assertEquals('eni-0abcdef1234567890', response.instancesSet[0].networkInterfaceSet[0].networkInterfaceId);
        System.assertEquals('subnet-a1b2c3d4', response.instancesSet[0].networkInterfaceSet[0].subnetId);
        System.assertEquals('vpc-a1b2c3d4', response.instancesSet[0].networkInterfaceSet[0].vpcId);
        System.assertEquals(null, response.instancesSet[0].networkInterfaceSet[0].description);
        System.assertEquals('123456789012', response.instancesSet[0].networkInterfaceSet[0].ownerId);
        System.assertEquals('in-use', response.instancesSet[0].networkInterfaceSet[0].status);
        System.assertEquals('1a:2b:3c:4d:5e:6f', response.instancesSet[0].networkInterfaceSet[0].macAddress);
        System.assertEquals('172.11.22.33', response.instancesSet[0].networkInterfaceSet[0].privateIpAddress);
        System.assertEquals('ip-172-11-22-33.ec2.internal', response.instancesSet[0].networkInterfaceSet[0].privateDnsName);
        System.assertEquals(true, response.instancesSet[0].networkInterfaceSet[0].sourceDestCheck);
        System.assertEquals('sg-a1b2c3d4', response.instancesSet[0].groupSet[0].groupId);
        System.assertEquals('default', response.instancesSet[0].groupSet[0].groupName);
        System.assertEquals('eni-attach-0abcdef1234567890', response.instancesSet[0].networkInterfaceSet[0].attachment.attachmentId);
        System.assertEquals(0, response.instancesSet[0].networkInterfaceSet[0].attachment.deviceIndex);
        System.assertEquals(Datetime.newInstanceGmt(2019, 12, 25, 23, 59, 59), response.instancesSet[0].networkInterfaceSet[0].attachment.attachTime);
        System.assertEquals(true, response.instancesSet[0].networkInterfaceSet[0].attachment.deleteOnTermination);
        System.assertEquals('172.11.22.33', response.instancesSet[0].networkInterfaceSet[0].privateIpAddressesSet[0].privateIpAddress);
        System.assertEquals('ip-172-11-22-33.ec2.internal', response.instancesSet[0].networkInterfaceSet[0].privateIpAddressesSet[0].privateDnsName);
        System.assertEquals(true, response.instancesSet[0].networkInterfaceSet[0].privateIpAddressesSet[0].primary);
        System.assertEquals(null, response.instancesSet[0].networkInterfaceSet[0].ipv6AddressesSet);
        System.assertEquals('interface', response.instancesSet[0].networkInterfaceSet[0].interfaceType);
        System.assertEquals(false, response.instancesSet[0].ebsOptimized);
        System.assertEquals(1, response.instancesSet[0].cpuOptions.coreCount);
        System.assertEquals(1, response.instancesSet[0].cpuOptions.threadsPerCore);
        System.assertEquals('open', response.instancesSet[0].capacityReservationSpecification.capacityReservationPreference);
        // System.assertEquals(false, response.instancesSet[0].enclaveOptions); // enclaveOptions not in docs
        System.assertEquals('pending', response.instancesSet[0].metadataOptions.state);
        System.assertEquals('optional', response.instancesSet[0].metadataOptions.httpTokens);
        System.assertEquals(1, response.instancesSet[0].metadataOptions.httpPutResponseHopLimit);
        System.assertEquals('enabled', response.instancesSet[0].metadataOptions.httpEndpoint);
    }
    
    @IsTest static void testTerminateInstancesRequest()
    {
        // arrange
        EC2.TerminateInstancesRequest request = new EC2.TerminateInstancesRequest();
        request.url = 'callout:ec2';
        request.dryRun = true;
        request.instanceId = new List<String>{'i-01234567890abcdef'};
        
        // act
        HttpRequest http = request(request);
        Map<String,Object> params = params(http);
        
        // assert
        System.assertEquals('POST', http.getMethod());
        System.assertEquals('callout:ec2', http.getEndpoint());
        System.assertEquals('application/x-www-form-urlencoded', http.getHeader('Content-Type'));
        System.assertEquals('2016-11-15', params.get('Version'));
        System.assertEquals('TerminateInstances', params.get('Action'));
        System.assertEquals('true', params.get('DryRun'));
        System.assertEquals('i-01234567890abcdef', params.get('InstanceId.1'));
    }
    
    @IsTest static void testTerminateInstancesResponse()
    {
        // act
        EC2.TerminateInstancesRequest request = new EC2.TerminateInstancesRequest();
        EC2.TerminateInstancesResponse response = new EC2.TerminateInstances().call(request);
        
        // assert
        System.assertEquals('11223344-5566-7788-9900-aabbccddeeff', response.requestId);
        System.assertEquals('i-01234567890abcdef', response.instancesSet[0].instanceId);
        System.assertEquals(32, response.instancesSet[0].currentState.code);
        System.assertEquals('shutting-down', response.instancesSet[0].currentState.name);
        System.assertEquals(16, response.instancesSet[0].previousState.code);
        System.assertEquals('running', response.instancesSet[0].previousState.name);
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