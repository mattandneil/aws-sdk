/**
* Salesforce Apex SDK for AWS EC2
 * 
 * Amazon Web Services documentation:
 * https://docs.aws.amazon.com/AWSEC2/latest/APIReference/ec2-api.pdf
 * https://docs.aws.amazon.com/AWSEC2/latest/APIReference/index.html
 */
global class EC2
{
    private EC2()
    {
        //
    }
    
    /**
     * Describes the specified instances or all instances.
     * 
     * https://docs.aws.amazon.com/AWSEC2/latest/APIReference/API_DescribeInstances.html
     */
    global class DescribeInstances implements HttpCalloutMock
    {
        global DescribeInstancesResponse call(DescribeInstancesRequest request)
        {
            if (Test.isRunningTest()) Test.setMock(HttpCalloutMock.class, this);
            System.Callable sdk = (System.Callable)Type.forName('AWS.SDK').newInstance();
            return (DescribeInstancesResponse)sdk.call(DescribeInstancesRequest.class.getName(),
            (Map<String,Object>)Json.deserializeUntyped(Json.serialize(request, true)));
        }
        
        global HttpResponse respond(HttpRequest request)
        {
            HttpResponse response = new HttpResponse();
            response.setStatusCode(200);
            response.setBody(''
                + '<DescribeInstancesResponse xmlns="http://ec2.amazonaws.com/doc/2016-11-15/">'
                +     '<requestId>11223344-5566-7788-9900-aabbccddeeff</requestId>'
                +     '<reservationSet>'
                +         '<item>'
                +             '<reservationId>r-01234567890abcdef</reservationId>'
                +             '<ownerId>123456789012</ownerId>'
                +             '<groupSet/>'
                +             '<instancesSet>'
                +                 '<item>'
                +                     '<instanceId>i-0abcdef1234567890</instanceId>'
                +                     '<imageId>ami-12345678</imageId>'
                +                     '<instanceState>'
                +                         '<code>48</code>'
                +                         '<name>terminated</name>'
                +                     '</instanceState>'
                +                     '<privateDnsName/>'
                +                     '<dnsName/>'
                +                     '<reason>User initiated (2020-12-25 23:59:59 GMT)</reason>'
                +                     '<amiLaunchIndex>0</amiLaunchIndex>'
                +                     '<productCodes/>'
                +                     '<instanceType>m1.small</instanceType>'
                +                     '<launchTime>2020-12-25T23:59:59.000Z</launchTime>'
                +                     '<placement>'
                +                         '<availabilityZone>us-east-1b</availabilityZone>'
                +                         '<groupName/>'
                +                         '<tenancy>default</tenancy>'
                +                     '</placement>'
                +                     '<monitoring>'
                +                         '<state>disabled</state>'
                +                     '</monitoring>'
                +                     '<groupSet/>'
                +                     '<stateReason>'
                +                         '<code>Client.UserInitiatedShutdown</code>'
                +                         '<message>Client.UserInitiatedShutdown: User initiated shutdown</message>'
                +                     '</stateReason>'
                +                     '<architecture>x86_64</architecture>'
                +                     '<rootDeviceType>ebs</rootDeviceType>'
                +                     '<rootDeviceName>/dev/xvda</rootDeviceName>'
                +                     '<blockDeviceMapping/>'
                +                     '<virtualizationType>hvm</virtualizationType>'
                +                     '<clientToken/>'
                +                     '<hypervisor>xen</hypervisor>'
                +                     '<networkInterfaceSet/>'
                +                     '<ebsOptimized>false</ebsOptimized>'
                +                     '<cpuOptions>'
                +                         '<coreCount>1</coreCount>'
                +                         '<threadsPerCore>1</threadsPerCore>'
                +                     '</cpuOptions>'
                +                     '<capacityReservationSpecification>'
                +                         '<capacityReservationPreference>open</capacityReservationPreference>'
                +                     '</capacityReservationSpecification>'
                +                     '<hibernationOptions>'
                +                         '<configured>false</configured>'
                +                     '</hibernationOptions>'
                +                     '<enclaveOptions>'
                +                         '<enabled>false</enabled>'
                +                     '</enclaveOptions>'
                +                     '<metadataOptions>'
                +                         '<state>pending</state>'
                +                         '<httpTokens>optional</httpTokens>'
                +                         '<httpPutResponseHopLimit>1</httpPutResponseHopLimit>'
                +                         '<httpEndpoint>enabled</httpEndpoint>'
                +                     '</metadataOptions>'
                +                 '</item>'
                +             '</instancesSet>'
                +         '</item>'
                +     '</reservationSet>'
                + '</DescribeInstancesResponse>'
            );
            return response;
        }
    }

    /**
     * https://docs.aws.amazon.com/AWSEC2/latest/APIReference/API_DescribeInstances.html#API_DescribeInstances_RequestParameters
     */
    global class DescribeInstancesRequest
    {
        global String url = 'callout:EC2';
        
        /**
         * Checks whether you have the required permissions for the action, without actually making
         * the request, and provides an error response. If you have the required permissions, the
         * error response is DryRunOperation. Otherwise, it is UnauthorizedOperation.
         * Type: Boolean
         * Required: No
         */
        global Boolean dryRun = false;

        /**
         * The filters.
         * - affinity - The affinity setting for an instance running on a Dedicated Host
         *   (default | host).
         * - architecture - The instance architecture (i386 | x86_64 | arm64).
         * - availability-zone - The Availability Zone of the instance.
         * - block-device-mapping.attach-time - The attach time for an EBS volume mapped to the
         *   instance, for example, 2010-09-15T17:15:20.000Z.
         * - block-device-mapping.delete-on-termination - A Boolean that indicates whether the EBS
         *   volume is deleted on instance termination.
         * - block-device-mapping.device-name - The device name specified in the block device
         *   mapping (for example, /dev/sdh or xvdh).
         * - block-device-mapping.status - The status for the EBS volume (attaching | attached |
         *   detaching | detached).
         * - block-device-mapping.volume-id - The volume ID of the EBS volume.
         * - client-token - The idempotency token you provided when you launched the instance.
         * - dns-name - The public DNS name of the instance.
         * - group-id - The ID of the security group for the instance. EC2-Classic only.
         * - group-name - The name of the security group for the instance. EC2-Classic only.
         * - hibernation-options.configured - A Boolean that indicates whether the instance is
         *   enabled for hibernation. A value of true means that the instance is enabled for
         *   hibernation.
         * - host-id - The ID of the Dedicated Host on which the instance is running, if applicable.
         * - hypervisor - The hypervisor type of the instance (ovm | xen). The value xen is used for
         *   both Xen and Nitro hypervisors.
         * - iam-instance-profile.arn - The instance profile associated with the instance. Specified
         *   as an ARN.
         * - image-id - The ID of the image used to launch the instance.
         * - instance-id - The ID of the instance.
         * - instance-lifecycle - Indicates whether this is a Spot Instance or a Scheduled Instance
         *   (spot | scheduled).
         * - instance-state-code - The state of the instance, as a 16-bit unsigned integer. The high
         *   byte is used for internal purposes and should be ignored. The low byte is set based on
         *   the state represented. The valid values are: 0 (pending), 16 (running),
         *   32 (shutting-down), 48 (terminated), 64 (stopping), and 80 (stopped).
         * - instance-state-name - The state of the instance (pending | running | shutting-down |
         *   terminated | stopping | stopped).
         * - instance-type - The type of instance (for example, t2.micro).
         * - instance.group-id - The ID of the security group for the instance.
         * - instance.group-name - The name of the security group for the instance.
         * - ip-address - The public IPv4 address of the instance.
         * - kernel-id - The kernel ID.
         * - key-name - The name of the key pair used when the instance was launched.
         * - launch-index - When launching multiple instances, this is the index for the instance in
         *   the launch group (for example, 0, 1, 2, and so on).
         * - launch-time - The time when the instance was launched.
         * - metadata-options.http-tokens - The metadata request authorization state (optional |
         *   required)
         * - metadata-options.http-put-response-hop-limit - The http metadata request put response
         *   hop limit (integer, possible values 1 to 64)
         * - metadata-options.http-endpoint - Enable or disable metadata access on http endpoint
         *   (enabled | disabled)
         * - monitoring-state - Indicates whether detailed monitoring is enabled (disabled |
         *   enabled).
         * - network-interface.addresses.private-ip-address - The private IPv4 address associated
         *   with the network interface.
         * - network-interface.addresses.primary - Specifies whether the IPv4 address of the network
         *   interface is the primary private IPv4 address.
         * - network-interface.addresses.association.public-ip - The ID of the association of an
         *   Elastic IP address (IPv4) with a network interface.
         * - network-interface.addresses.association.ip-owner-id - The owner ID of the private IPv4
         *   address associated with the network interface.
         * - network-interface.association.public-ip - The address of the Elastic IP address (IPv4)
         *   bound to the network interface.
         * - network-interface.association.ip-owner-id - The owner of the Elastic IP address (IPv4)
         *   associated with the network interface.
         * - network-interface.association.allocation-id - The allocation ID returned when you
         *   allocated the Elastic IP address (IPv4) for your network interface.
         * - network-interface.association.association-id - The association ID returned when the
         *   network interface was associated with an IPv4 address.
         * - network-interface.attachment.attachment-id - The ID of the interface attachment.
         * - network-interface.attachment.instance-id - The ID of the instance to which the network
         *   interface is attached.
         * - network-interface.attachment.instance-owner-id - The owner ID of the instance to which
         *   the network interface is attached.
         * - network-interface.attachment.device-index - The device index to which the network
         *   interface is attached.
         * - network-interface.attachment.status - The status of the attachment (attaching |
         *   attached | detaching | detached).
         * - network-interface.attachment.attach-time - The time that the network interface was
         *   attached to an instance.
         * - network-interface.attachment.delete-on-termination - Specifies whether the attachment
         *   is deleted when an instance is terminated.
         * - network-interface.availability-zone - The Availability Zone for the network interface.
         * - network-interface.description - The description of the network interface.
         * - network-interface.group-id - The ID of a security group associated with the network
         *   interface.
         * - network-interface.group-name - The name of a security group associated with the network
         *   interface.
         * - network-interface.ipv6-addresses.ipv6-address - The IPv6 address associated with the
         *   network interface.
         * - network-interface.mac-address - The MAC address of the network interface.
         * - network-interface.network-interface-id - The ID of the network interface.
         * - network-interface.owner-id - The ID of the owner of the network interface.
         * - network-interface.private-dns-name - The private DNS name of the network interface.
         * - network-interface.requester-id - The requester ID for the network interface.
         * - network-interface.requester-managed - Indicates whether the network interface is being
         *   managed by AWS.
         * - network-interface.status - The status of the network interface (available) | in-use).
         * - network-interface.source-dest-check - Whether the network interface performs
         *   source/destination checking. A value of true means that checking is enabled, and false
         *   means that checking is disabled. The value must be false for the network interface to
         *   perform network address translation (NAT) in your VPC.
         * - network-interface.subnet-id - The ID of the subnet for the network interface.
         * - network-interface.vpc-id - The ID of the VPC for the network interface.
         * - owner-id - The AWS account ID of the instance owner.
         * - placement-group-name - The name of the placement group for the instance.
         * - placement-partition-number - The partition in which the instance is located.
         * - platform - The platform. To list only Windows instances, use windows.
         * - private-dns-name - The private IPv4 DNS name of the instance.
         * - private-ip-address - The private IPv4 address of the instance.
         * - product-code - The product code associated with the AMI used to launch the instance.
         * - product-code.type - The type of product code (devpay | marketplace).
         * - ramdisk-id - The RAM disk ID.
         * - reason - The reason for the current state of the instance (for example, shows "User
         *   Initiated [date]" when you stop or terminate the instance). Similar to the
         *   state-reason-code filter.
         * - requester-id - The ID of the entity that launched the instance on your behalf (for
         *   example, AWS Management Console, Auto Scaling, and so on).
         * - reservation-id - The ID of the instance's reservation. A reservation ID is created any
         *   time you launch an instance. A reservation ID has a one-to-one relationship with an
         *   instance launch request, but can be associated with more than one instance if you
         *   launch multiple instances using the same launch request. For example, if you launch one
         *   instance, you get one reservation ID. If you launch ten instances using the same launch
         *   request, you also get one reservation ID.
         * - root-device-name - The device name of the root device volume (for example, /dev/sda1).
         * - root-device-type - The type of the root device volume (ebs | instance-store).
         * - source-dest-check - Indicates whether the instance performs source/destination
         *   checking. A value of true means that checking is enabled, and false means that checking
         *   is disabled. The value must be false for the instance to perform network address
         *   translation (NAT) in your VPC.
         * - spot-instance-request-id - The ID of the Spot Instance request.
         * - state-reason-code - The reason code for the state change.
         * - state-reason-message - A message that describes the state change.
         * - subnet-id - The ID of the subnet for the instance.
         * - tag:<key> - The key/value combination of a tag assigned to the resource. Use the tag
         *   key in the filter name and the tag value as the filter value. For example, to find all
         *   resources that have a tag with the key Owner and the value TeamA, specify tag:Owner for
         *   the filter name and TeamA for the filter value.
         * - tag-key - The key of a tag assigned to the resource. Use this filter to find all
         *   resources that have a tag with a specific key, regardless of the tag value.
         * - tenancy - The tenancy of an instance (dedicated | default | host).
         * - virtualization-type - The virtualization type of the instance (paravirtual | hvm).
         * - vpc-id - The ID of the VPC that the instance is running in.
         * Type: Array of Filter objects
         * Required: No
         */
        global List<Filter> filter;

        /**
         * The instance IDs.
         * Default: Describes all your instances.
         * Type: Array of strings
         * Required: No
         */
        global List<String> instanceId;

        /**
         * The maximum number of results to return in a single call. To retrieve the remaining
         * results, make another call with the returned NextToken value. This value can be between 5
         * and 1000. You cannot specify this parameter and the instance IDs parameter in the same
         * call.
         * Type: Integer
         * Required: No
         */
        global Integer maxResults;

        /**
         * The token to request the next page of results.
         * Type: String
         * Required: No
         */
        global String nextToken;
    }

    /**
     * https://docs.aws.amazon.com/AWSEC2/latest/APIReference/API_DescribeInstances.html#API_DescribeInstances_ResponseElements
     */
    global class DescribeInstancesResponse
    {
        /**
         * The token to use to retrieve the next page of results. This value is null when there are
         * no more results to return.
         * Type: String
         */
        global String nextToken;

        /**
         * The ID of the request.
         * Type: String
         */
        global String requestId;

        /**
         * Information about the reservations.
         * Type: Array of Reservation objects
         */
        global List<Reservation> reservationSet;
    }
    
    /**
     * Describes the Regions that are enabled for your account, or all Regions.
     * 
     * https://docs.aws.amazon.com/AWSEC2/latest/APIReference/API_DescribeRegions.html
     */
    global class DescribeRegions implements HttpCalloutMock
    {
        global DescribeRegionsResponse call(DescribeRegionsRequest request)
        {
            if (Test.isRunningTest()) Test.setMock(HttpCalloutMock.class, this);
            System.Callable sdk = (System.Callable)Type.forName('AWS.SDK').newInstance();
            return (DescribeRegionsResponse)sdk.call(DescribeRegionsRequest.class.getName(),
            (Map<String,Object>)Json.deserializeUntyped(Json.serialize(request, true)));
        }

        public HttpResponse respond(HttpRequest request)
        {
            HttpResponse response = new HttpResponse();
            response.setStatusCode(200);
            response.setBody(''
                + '<DescribeRegionsResponse xmlns="http://ec2.amazonaws.com/doc/2016-11-15/">'
                +     '<requestId>11223344-5566-7788-9900-aabbccddeeff</requestId>'
                +     '<regionInfo>'
                +         '<item>'
                +             '<regionName>eu-north-1</regionName>'
                +             '<regionEndpoint>ec2.eu-north-1.amazonaws.com</regionEndpoint>'
                +             '<optInStatus>opt-in-not-required</optInStatus>'
                +         '</item>'
                +         '<item>'
                +             '<regionName>ap-south-1</regionName>'
                +             '<regionEndpoint>ec2.ap-south-1.amazonaws.com</regionEndpoint>'
                +             '<optInStatus>opt-in-not-required</optInStatus>'
                +         '</item>'
                +     '</regionInfo>'
                + '</DescribeRegionsResponse>'
            );
            return response;
        }
    }

    /**
     * https://docs.aws.amazon.com/AWSEC2/latest/APIReference/API_DescribeRegions.html#API_DescribeRegions_RequestParameters
     */
    global class DescribeRegionsRequest
    {
        global String url = 'callout:EC2';

        /**
         * Indicates whether to display all Regions, including Regions that are disabled for your
         * account.
         * Type: Boolean
         * Required: No
         */
        global Boolean allRegions;

        /**
         * Checks whether you have the required permissions for the action, without actually making
         * the request, and provides an error response. If you have the required permissions, the
         * error response is DryRunOperation. Otherwise, it is UnauthorizedOperation.
         * Type: Boolean
         * Required: No
         */
        global Boolean dryRun = false;

        /**
         * The filters.
         * - endpoint - The endpoint of the Region (for example, ec2.us-east-1.amazonaws.com).
         * - opt-in-status - The opt-in status of the Region (opt-in-not-required | opted-in |
         *   not-opted-in).
         * - region-name - The name of the Region (for example, us-east-1).
         * Type: Array of Filter objects
         * Required: No
         */
        global List<Filter> filter;

        /**
         * The names of the Regions. You can specify any Regions, whether they are enabled and
         * disabled for your account.
         * Type: Array of strings
         * Required: No
         */
        global List<String> regionName;
    }

    /**
     * https://docs.aws.amazon.com/AWSEC2/latest/APIReference/API_DescribeRegions.html#API_DescribeRegions_ResponseElements
     */
    global class DescribeRegionsResponse
    {
        /**
         * Information about the Regions.
         * Type: Array of Region objects
         */
        global List<Region> regionInfo;

        /**
         * The ID of the request.
         * Type: String
         */
        global String requestId;
    }

    /**
     * Launches the specified number of instances using an AMI for which you have permissions.
     * 
     * https://docs.aws.amazon.com/AWSEC2/latest/APIReference/API_RunInstances.html
     */
    global class RunInstances implements HttpCalloutMock
    {
        global RunInstancesResponse call(RunInstancesRequest request)
        {
            if (Test.isRunningTest()) Test.setMock(HttpCalloutMock.class, this);
            System.Callable sdk = (System.Callable)Type.forName('AWS.SDK').newInstance();
            return (RunInstancesResponse)sdk.call(RunInstancesRequest.class.getName(),
            (Map<String,Object>)Json.deserializeUntyped(Json.serialize(request, true)));
        }
        
        public HttpResponse respond(HttpRequest request)
        {
            HttpResponse response = new HttpResponse();
            response.setStatusCode(200);
            response.setBody(''
                + '<RunInstancesResponse xmlns="http://ec2.amazonaws.com/doc/2016-11-15/">'
                +     '<requestId>11223344-5566-7788-9900-aabbccddeeff</requestId>'
                +     '<reservationId>r-0abcdef1234567890</reservationId>'
                +     '<ownerId>123456789012</ownerId>'
                +     '<groupSet/>'
                +     '<instancesSet>'
                +         '<item>'
                +             '<instanceId>i-0abcdef1234567890</instanceId>'
                +             '<imageId>ami-12345678</imageId>'
                +             '<instanceState>'
                +                 '<code>0</code>'
                +                 '<name>pending</name>'
                +             '</instanceState>'
                +             '<privateDnsName>ip-172-11-22-33.ec2.internal</privateDnsName>'
                +             '<dnsName></dnsName>'
                +             '<reason></reason>'
                +             '<amiLaunchIndex>0</amiLaunchIndex>'
                +             '<productCodes/>'
                +             '<instanceType>m1.small</instanceType>'
                +             '<launchTime>2019-12-25T23:59:59.000Z</launchTime>'
                +             '<placement>'
                +                 '<availabilityZone>us-east-1b</availabilityZone>'
                +                 '<groupName></groupName>'
                +                 '<tenancy>default</tenancy>'
                +             '</placement>'
                +             '<monitoring>'
                +                 '<state>disabled</state>'
                +             '</monitoring>'
                +             '<subnetId>subnet-a1b2c3d4</subnetId>'
                +             '<vpcId>vpc-a1b2c3d4</vpcId>'
                +             '<privateIpAddress>172.11.22.33</privateIpAddress>'
                +             '<sourceDestCheck>true</sourceDestCheck>'
                +             '<groupSet>'
                +                 '<item>'
                +                     '<groupId>sg-a1b2c3d4</groupId>'
                +                     '<groupName>default</groupName>'
                +                 '</item>'
                +             '</groupSet>'
                +             '<stateReason>'
                +                 '<code>pending</code>'
                +                 '<message>pending</message>'
                +             '</stateReason>'
                +             '<architecture>x86_64</architecture>'
                +             '<rootDeviceType>ebs</rootDeviceType>'
                +             '<rootDeviceName>/dev/xvda</rootDeviceName>'
                +             '<blockDeviceMapping/>'
                +             '<virtualizationType>hvm</virtualizationType>'
                +             '<clientToken></clientToken>'
                +             '<hypervisor>xen</hypervisor>'
                +             '<networkInterfaceSet>'
                +                 '<item>'
                +                     '<networkInterfaceId>eni-0abcdef1234567890</networkInterfaceId>'
                +                     '<subnetId>subnet-a1b2c3d4</subnetId>'
                +                     '<vpcId>vpc-a1b2c3d4</vpcId>'
                +                     '<description></description>'
                +                     '<ownerId>123456789012</ownerId>'
                +                     '<status>in-use</status>'
                +                     '<macAddress>1a:2b:3c:4d:5e:6f</macAddress>'
                +                     '<privateIpAddress>172.11.22.33</privateIpAddress>'
                +                     '<privateDnsName>ip-172-11-22-33.ec2.internal</privateDnsName>'
                +                     '<sourceDestCheck>true</sourceDestCheck>'
                +                     '<groupSet>'
                +                         '<item>'
                +                             '<groupId>sg-a1b2c3d4</groupId>'
                +                             '<groupName>default</groupName>'
                +                         '</item>'
                +                     '</groupSet>'
                +                     '<attachment>'
                +                         '<attachmentId>eni-attach-0abcdef1234567890</attachmentId>'
                +                         '<deviceIndex>0</deviceIndex>'
                +                         '<status>attaching</status>'
                +                         '<attachTime>2019-12-25T23:59:59.000Z</attachTime>'
                +                         '<deleteOnTermination>true</deleteOnTermination>'
                +                     '</attachment>'
                +                     '<privateIpAddressesSet>'
                +                         '<item>'
                +                             '<privateIpAddress>172.11.22.33</privateIpAddress>'
                +                             '<privateDnsName>ip-172-11-22-33.ec2.internal</privateDnsName>'
                +                             '<primary>true</primary>'
                +                         '</item>'
                +                     '</privateIpAddressesSet>'
                +                     '<ipv6AddressesSet/>'
                +                     '<interfaceType>interface</interfaceType>'
                +                 '</item>'
                +             '</networkInterfaceSet>'
                +             '<ebsOptimized>false</ebsOptimized>'
                +             '<cpuOptions>'
                +                 '<coreCount>1</coreCount>'
                +                 '<threadsPerCore>1</threadsPerCore>'
                +             '</cpuOptions>'
                +             '<capacityReservationSpecification>'
                +                 '<capacityReservationPreference>open</capacityReservationPreference>'
                +             '</capacityReservationSpecification>'
                +             '<enclaveOptions>'
                +                 '<enabled>false</enabled>'
                +             '</enclaveOptions>'
                +             '<metadataOptions>'
                +                 '<state>pending</state>'
                +                 '<httpTokens>optional</httpTokens>'
                +                 '<httpPutResponseHopLimit>1</httpPutResponseHopLimit>'
                +                 '<httpEndpoint>enabled</httpEndpoint>'
                +             '</metadataOptions>'
                +         '</item>'
                +     '</instancesSet>'
                + '</RunInstancesResponse>'
            );
            return response;
        }
    }
    
    /**
     * https://docs.aws.amazon.com/AWSEC2/latest/APIReference/API_RunInstances.html#API_RunInstances_RequestParameters
     */
    global class RunInstancesRequest
    {
        global String url = 'callout:EC2';
        
        /**
         * Reserved.
         * Type: String
         * Required: No
         */
        global String additionalInfo;

        /**
         * The block device mapping entries.
         * Type: Array of BlockDeviceMapping objects
         * Required: No
         */
        global List<BlockDeviceMapping> blockDeviceMapping;

        /**
         * Information about the Capacity Reservation targeting option. If you do not specify this
         * parameter, the instance's Capacity Reservation preference defaults to open, which enables
         * it to run in any open Capacity Reservation that has matching attributes (instance type,
         * platform, Availability Zone).
         * Type: CapacityReservationSpecification object
         * Required: No
         */
        global CapacityReservationSpecification capacityReservationSpecification;

        /**
         * Unique, case-sensitive identifier you provide to ensure the idempotency of the request.
         * If you do not specify a client token, a randomly generated token is used for the request
         * to ensure idempotency.
         * For more information, see Ensuring Idempotency.
         * Constraints: Maximum 64 ASCII characters
         * Type: String
         * Required: No
         */
        global String clientToken;

        /**
         * The CPU options for the instance. For more information, see Optimizing CPU options in the
         * Amazon Elastic Compute Cloud User Guide.
         * Type: CpuOptionsRequest object
         * Required: No
         */
        global CpuOptions cpuOptions;

        /**
         * The credit option for CPU usage of the burstable performance instance. Valid values are
         * standard and unlimited. To change this attribute after launch, use
         * ModifyInstanceCreditSpecification. For more information, see Burstable performance
         * instances in the Amazon Elastic Compute Cloud User Guide.
         * Default: standard (T2 instances) or unlimited (T3/T3a instances)
         * Type: CreditSpecificationRequest object
         * Required: No
         */
        global CreditSpecification creditSpecification;

        /**
         * If you set this parameter to true, you can't terminate the instance using the Amazon EC2
         * console, CLI, or API; otherwise, you can. To change this attribute after launch, use
         * ModifyInstanceAttribute. Alternatively, if you set InstanceInitiatedShutdownBehavior to
         * terminate, you can terminate the instance by running the shutdown command from the
         * instance.
         * Default: false
         * Type: Boolean
         * Required: No
         */
        global Boolean disableApiTermination;

        /**
         * Checks whether you have the required permissions for the action, without actually making
         * the request, and provides an error response. If you have the required permissions, the
         * error response is DryRunOperation. Otherwise, it is UnauthorizedOperation.
         * Type: Boolean
         * Required: No
         */
        global Boolean dryRun = false;

        /**
         * Indicates whether the instance is optimized for Amazon EBS I/O. This optimization
         * provides dedicated throughput to Amazon EBS and an optimized configuration stack to
         * provide optimal Amazon EBS I/O performance. This optimization isn't available with all
         * instance types. Additional usage charges apply when using an EBS-optimized instance.
         * Default: false
         * Type: Boolean
         * Required: No
         */
        global Boolean ebsOptimized;

        /**
         * An elastic GPU to associate with the instance. An Elastic GPU is a GPU resource that you
         * can attach to your Windows instance to accelerate the graphics performance of your
         * applications. For more information, see Amazon EC2 Elastic GPUs in the Amazon Elastic
         * Compute Cloud User Guide.
         * Type: Array of ElasticGpuSpecification objects
         * Required: No
         */
        global List<ElasticGpuSpecification> elasticGpuSpecification;

        /**
         * An elastic inference accelerator to associate with the instance. Elastic inference
         * accelerators are a resource you can attach to your Amazon EC2 instances to accelerate
         * your Deep Learning (DL) inference workloads.
         * You cannot specify accelerators from different generations in the same request.
         * Type: Array of ElasticInferenceAccelerator objects
         * Required: No
         */
        global List<ElasticInferenceAccelerator> elasticInferenceAccelerator;

        /**
         * Indicates whether an instance is enabled for hibernation. For more information, see
         * Hibernate your instance in the Amazon Elastic Compute Cloud User Guide.
         * Type: HibernationOptionsRequest object
         * Required: No
         */
        global HibernationOptions hibernationOptions;

        /**
         * The IAM instance profile.
         * Type: IamInstanceProfileSpecification object
         * Required: No
         */
        global IamInstanceProfileSpecification iamInstanceProfile;

        /**
         * The ID of the AMI. An AMI ID is required to launch an instance and must be specified here
         * or in a launch template.
         * Type: String
         * Required: No
         */
        global String imageId;

        /**
         * Indicates whether an instance stops or terminates when you initiate shutdown from the
         * instance (using the operating system command for system shutdown).
         * Default: stop
         * Type: String
         * Valid Values: stop | terminate
         * Required: No
         */
        global String instanceInitiatedShutdownBehavior;

        /**
         * The market (purchasing) option for the instances.
         * Type: InstanceMarketOptionsRequest object
         * Required: No
         */
        global InstanceMarketOptions instanceMarketOptions;
        
        /**
         * The instance type. For more information, see Instance types in the Amazon Elastic Compute
         * Cloud User Guide.
         * Default: m1.small
         * Type: String
         * Valid Values: t1.micro | t2.nano | t2.micro | t2.small | t2.medium | t2.large | t2.xlarge
         * | t2.2xlarge | t3.nano | t3.micro | t3.small | t3.medium | t3.large | t3.xlarge
         * | t3.2xlarge | t3a.nano | t3a.micro | t3a.small | t3a.medium | t3a.large | t3a.xlarge
         * | t3a.2xlarge | m1.small | m1.medium | m1.large | m1.xlarge | m3.medium | m3.large
         * | m3.xlarge | m3.2xlarge | m4.large | m4.xlarge | m4.2xlarge | m4.4xlarge | m4.10xlarge
         * | m4.16xlarge | m2.xlarge | m2.2xlarge | m2.4xlarge | cr1.8xlarge | r3.large | r3.xlarge
         * | r3.2xlarge | r3.4xlarge | r3.8xlarge | r4.large | r4.xlarge | r4.2xlarge | r4.4xlarge
         * | r4.8xlarge | r4.16xlarge | r5.large | r5.xlarge | r5.2xlarge | r5.4xlarge | r5.8xlarge
         * | r5.12xlarge | r5.16xlarge | r5.24xlarge | r5.metal | r5a.large | r5a.xlarge
         * | r5a.2xlarge | r5a.4xlarge | r5a.8xlarge | r5a.12xlarge | r5a.16xlarge | r5a.24xlarge
         * | r5d.large | r5d.xlarge | r5d.2xlarge | r5d.4xlarge | r5d.8xlarge | r5d.12xlarge
         * | r5d.16xlarge | r5d.24xlarge | r5d.metal | r5ad.large | r5ad.xlarge | r5ad.2xlarge
         * | r5ad.4xlarge | r5ad.8xlarge | r5ad.12xlarge | r5ad.16xlarge | r5ad.24xlarge | r6g.metal
         * | r6g.medium | r6g.large | r6g.xlarge | r6g.2xlarge | r6g.4xlarge | r6g.8xlarge
         * | r6g.12xlarge | r6g.16xlarge | x1.16xlarge | x1.32xlarge | x1e.xlarge | x1e.2xlarge
         * | x1e.4xlarge | x1e.8xlarge | x1e.16xlarge | x1e.32xlarge | i2.xlarge | i2.2xlarge
         * | i2.4xlarge | i2.8xlarge | i3.large | i3.xlarge | i3.2xlarge | i3.4xlarge | i3.8xlarge
         * | i3.16xlarge | i3.metal | i3en.large | i3en.xlarge | i3en.2xlarge | i3en.3xlarge
         * | i3en.6xlarge | i3en.12xlarge | i3en.24xlarge | i3en.metal | hi1.4xlarge | hs1.8xlarge
         * | c1.medium | c1.xlarge | c3.large | c3.xlarge | c3.2xlarge | c3.4xlarge | c3.8xlarge
         * | c4.large | c4.xlarge | c4.2xlarge | c4.4xlarge | c4.8xlarge | c5.large | c5.xlarge
         * | c5.2xlarge | c5.4xlarge | c5.9xlarge | c5.12xlarge | c5.18xlarge | c5.24xlarge
         * | c5.metal | c5a.large | c5a.xlarge | c5a.2xlarge | c5a.4xlarge | c5a.8xlarge
         * | c5a.12xlarge | c5a.16xlarge | c5a.24xlarge | c5d.large | c5d.xlarge | c5d.2xlarge
         * | c5d.4xlarge | c5d.9xlarge | c5d.12xlarge | c5d.18xlarge | c5d.24xlarge | c5d.metal
         * | c5n.large | c5n.xlarge | c5n.2xlarge | c5n.4xlarge | c5n.9xlarge | c5n.18xlarge
         * | c6g.metal | c6g.medium | c6g.large | c6g.xlarge | c6g.2xlarge | c6g.4xlarge
         * | c6g.8xlarge | c6g.12xlarge | c6g.16xlarge | cc1.4xlarge | cc2.8xlarge | g2.2xlarge
         * | g2.8xlarge | g3.4xlarge | g3.8xlarge | g3.16xlarge | g3s.xlarge | g4dn.xlarge
         * | g4dn.2xlarge | g4dn.4xlarge | g4dn.8xlarge | g4dn.12xlarge | g4dn.16xlarge | g4dn.metal
         * | cg1.4xlarge | p2.xlarge | p2.8xlarge | p2.16xlarge | p3.2xlarge | p3.8xlarge
         * | p3.16xlarge | p3dn.24xlarge | d2.xlarge | d2.2xlarge | d2.4xlarge | d2.8xlarge
         * | f1.2xlarge | f1.4xlarge | f1.16xlarge | m5.large | m5.xlarge | m5.2xlarge | m5.4xlarge
         * | m5.8xlarge | m5.12xlarge | m5.16xlarge | m5.24xlarge | m5.metal | m5a.large
         * | m5a.xlarge | m5a.2xlarge | m5a.4xlarge | m5a.8xlarge | m5a.12xlarge | m5a.16xlarge
         * | m5a.24xlarge | m5d.large | m5d.xlarge | m5d.2xlarge | m5d.4xlarge | m5d.8xlarge
         * | m5d.12xlarge | m5d.16xlarge | m5d.24xlarge | m5d.metal | m5ad.large | m5ad.xlarge
         * | m5ad.2xlarge | m5ad.4xlarge | m5ad.8xlarge | m5ad.12xlarge | m5ad.16xlarge
         * | m5ad.24xlarge | h1.2xlarge | h1.4xlarge | h1.8xlarge | h1.16xlarge | z1d.large
         * | z1d.xlarge | z1d.2xlarge | z1d.3xlarge | z1d.6xlarge | z1d.12xlarge | z1d.metal
         * | u-6tb1.metal | u-9tb1.metal | u-12tb1.metal | u-18tb1.metal | u-24tb1.metal | a1.medium
         * | a1.large | a1.xlarge | a1.2xlarge | a1.4xlarge | a1.metal | m5dn.large | m5dn.xlarge
         * | m5dn.2xlarge | m5dn.4xlarge | m5dn.8xlarge | m5dn.12xlarge | m5dn.16xlarge
         * | m5dn.24xlarge | m5n.large | m5n.xlarge | m5n.2xlarge | m5n.4xlarge | m5n.8xlarge
         * | m5n.12xlarge | m5n.16xlarge | m5n.24xlarge | r5dn.large | r5dn.xlarge | r5dn.2xlarge
         * | r5dn.4xlarge | r5dn.8xlarge | r5dn.12xlarge | r5dn.16xlarge | r5dn.24xlarge | r5n.large
         * | r5n.xlarge | r5n.2xlarge | r5n.4xlarge | r5n.8xlarge | r5n.12xlarge | r5n.16xlarge
         * | r5n.24xlarge | inf1.xlarge | inf1.2xlarge | inf1.6xlarge | inf1.24xlarge | m6g.metal
         * | m6g.medium | m6g.large | m6g.xlarge | m6g.2xlarge | m6g.4xlarge | m6g.8xlarge
         * | m6g.12xlarge | m6g.16xlarge
         * Required: No
         */
        global String instanceType;

        /**
         * [EC2-VPC] The IPv6 addresses from the range of the subnet to associate with the primary
         * network interface. You cannot specify this option and the option to assign a number of
         * IPv6 addresses in the same request. You cannot specify this option if you've specified a
         * minimum number of instances to launch.
         * You cannot specify this option and the network interfaces option in the same request.
         * Type: Array of InstanceIpv6Address objects
         * Required: No
         */
        global List<InstanceIpv6Address> ipv6Address;

        /**
         * [EC2-VPC] The number of IPv6 addresses to associate with the primary network interface.
         * Amazon EC2 chooses the IPv6 addresses from the range of your subnet. You cannot specify
         * this option and the option to assign specific IPv6 addresses in the same request. You can
         * specify this option if you've specified a minimum number of instances to launch.
         * You cannot specify this option and the network interfaces option in the same request.
         * Type: Integer
         * Required: No
         */
        global Integer ipv6AddressCount;

        /**
         * The ID of the kernel.
         * Type: String
         * Required: No
         */
        global String kernelId;

        /**
         * The name of the key pair. You can create a key pair using CreateKeyPair or ImportKeyPair.
         * Type: String
         * Required: No
         */
        global String keyName;

        /**
         * The launch template to use to launch the instances. Any parameters that you specify in
         * RunInstances override the same parameters in the launch template. You can specify either
         * the name or ID of a launch template, but not both.
         * Type: LaunchTemplateSpecification object
         * Required: No
         */
        global LaunchTemplateSpecification launchTemplate;

        /**
         * The license configurations.
         * Type: Array of LicenseConfigurationRequest objects
         * Required: No
         */
        global List<LicenseConfiguration> licenseSpecification;

        /**
         * The maximum number of instances to launch. If you specify more instances than Amazon EC2
         * can launch in the target Availability Zone, Amazon EC2 launches the largest possible
         * number of instances above MinCount.
         * Constraints: Between 1 and the maximum number you're allowed for the specified instance
         * type. For more information about the default limits, and how to request an increase, see
         * How many instances can I run in Amazon EC2 in the Amazon EC2 FAQ.
         * Type: Integer
         * Required: Yes
         */
        global Integer maxCount = 1;

        /**
         * The metadata options for the instance. For more information, see Instance metadata and
         * user data.
         * Type: InstanceMetadataOptionsRequest object
         * Required: No
         */
        global InstanceMetadataOptions metadataOptions;

        /**
         * The minimum number of instances to launch. If you specify a minimum that is more
         * instances than Amazon EC2 can launch in the target Availability Zone, Amazon EC2 launches
         * no instances.
         * Constraints: Between 1 and the maximum number you're allowed for the specified instance
         * type. For more information about the default limits, and how to request an increase, see
         * How many instances can I run in Amazon EC2 in the Amazon EC2 General FAQ.
         * Type: Integer
         * Required: Yes
         */
        global Integer minCount = 1;

        /**
         * Specifies whether detailed monitoring is enabled for the instance.
         * Type: RunInstancesMonitoringEnabled object
         * Required: No
         */
        global RunInstancesMonitoringEnabled monitoring;

        /**
         * The network interfaces to associate with the instance. If you specify a network
         * interface, you must specify any security groups and subnets as part of the network
         * interface.
         * Type: Array of InstanceNetworkInterfaceSpecification objects
         * Required: No
         */
        global List<InstanceNetworkInterfaceSpecification> networkInterface;

        /**
         * The placement for the instance.
         * Type: Placement object
         * Required: No
         */
        global Placement placement;

        /**
         * [EC2-VPC] The primary IPv4 address. You must specify a value from the IPv4 address range
         * of the subnet.
         * Only one private IP address can be designated as primary. You can't specify this option
         * if you've specified the option to designate a private IP address as the primary IP
         * address in a network interface specification. You cannot specify this option if you're
         * launching more than one instance in the request.
         * You cannot specify this option and the network interfaces option in the same request.
         * Type: String
         * Required: No
         */
        global String privateIpAddress;

        /**
         * The ID of the RAM disk to select. Some kernels require additional drivers at launch.
         * Check the kernel requirements for information about whether you need to specify a RAM
         * disk. To find kernel requirements, go to the AWS Resource Center and search for the
         * kernel ID.
         * Type: String
         * Required: No
         */
        global String ramdiskId;

        /**
         * [EC2-Classic, default VPC] The names of the security groups. For a nondefault VPC, you
         * must use security group IDs instead.
         * If you specify a network interface, you must specify any security groups as part of the
         * network interface.
         * Default: Amazon EC2 uses the default security group.
         * Type: Array of strings
         * Required: No
         */
        global List<String> securityGroup;

        /**
         * The IDs of the security groups. You can create a security group using
         * CreateSecurityGroup.
         * If you specify a network interface, you must specify any security groups as part of the
         * network interface.
         * Type: Array of strings
         * Required: No
         */
        global List<String> securityGroupId;

        /**
         * [EC2-VPC] The ID of the subnet to launch the instance into.
         * If you specify a network interface, you must specify any subnets as part of the network interface.
         * Type: String
         * Required: No
         */
        global String subnetId;

        /**
         * The tags to apply to the resources during launch. You can only tag instances and volumes
         * on launch. The specified tags are applied to all instances or volumes that are created
         * during launch. To tag a resource after it has been created, see CreateTags.
         * Type: Array of TagSpecification objects
         * Required: No
         */
        global List<TagSpecification> tagSpecification;

        /**
         * The user data to make available to the instance. For more information, see Running
         * commands on your Linux instance at launch (Linux) and Adding User Data (Windows). If you
         * are using a command line tool, base64-encoding is performed for you, and you can load the
         * text from a file. Otherwise, you must provide base64-encoded text. User data is limited
         * to 16 KB.
         * Type: String
         * Required: No
         */
        global Blob userData;
    }

    /**
     * https://docs.aws.amazon.com/AWSEC2/latest/APIReference/API_RunInstances.html#API_RunInstances_ResponseElements
     */
    global class RunInstancesResponse
    {
        /**
         * [EC2-Classic only] The security groups.
         * Type: Array of GroupIdentifier objects
         */
        global List<GroupIdentifier> groupSet;

        /**
         * The instances.
         * Type: Array of Instance objects
         */
        global List<Instance> instancesSet;

        /**
         * The ID of the AWS account that owns the reservation.
         * Type: String
         */
        global String ownerId;

        /**
         * The ID of the requester that launched the instances on your behalf (for example, AWS
         * Management Console or Auto Scaling).
         * Type: String
         */
        global String requesterId;

        /**
         * The ID of the request.
         * Type: String
         */
        global String requestId;

        /**
         * The ID of the reservation.
         * Type: String
         */
        global String reservationId;
    }

    /**
     * Shuts down the specified instances. This operation is idempotent; if you terminate an
     * instance more than once, each call succeeds.
     * 
     * https://docs.aws.amazon.com/AWSEC2/latest/APIReference/API_TerminateInstances.html
     */
    global class TerminateInstances implements HttpCalloutMock
    {
        global TerminateInstancesResponse call(TerminateInstancesRequest request)
        {
            if (Test.isRunningTest()) Test.setMock(HttpCalloutMock.class, this);
            System.Callable sdk = (System.Callable)Type.forName('AWS.SDK').newInstance();
            return (TerminateInstancesResponse)sdk.call(TerminateInstancesRequest.class.getName(),
            (Map<String,Object>)Json.deserializeUntyped(Json.serialize(request, true)));
        }
        
        public HttpResponse respond(HttpRequest request)
        {
            HttpResponse response = new HttpResponse();
            response.setStatusCode(200);
            response.setBody(''
                + '<TerminateInstancesResponse xmlns="http://ec2.amazonaws.com/doc/2016-11-15/">'
                +     '<requestId>11223344-5566-7788-9900-aabbccddeeff</requestId>'
                +     '<instancesSet>'
                +         '<item>'
                +             '<instanceId>i-01234567890abcdef</instanceId>'
                +             '<currentState>'
                +                 '<code>32</code>'
                +                 '<name>shutting-down</name>'
                +             '</currentState>'
                +             '<previousState>'
                +                 '<code>16</code>'
                +                 '<name>running</name>'
                +             '</previousState>'
                +         '</item>'
                +     '</instancesSet>'
                + '</TerminateInstancesResponse>'
            );
            return response;
        }
    }

    /**
     * https://docs.aws.amazon.com/AWSEC2/latest/APIReference/API_TerminateInstances.html#API_TerminateInstances_RequestParameters
     */
    global class TerminateInstancesRequest
    {
        global String url = 'callout:EC2';
        
        /**
         * Checks whether you have the required permissions for the action, without actually making
         * the request, and provides an error response. If you have the required permissions, the
         * error response is DryRunOperation. Otherwise, it is UnauthorizedOperation.
         * Type: Boolean
         * Required: No
         */
        global Boolean dryRun = false;

        /**
         * The IDs of the instances.
         * Constraints: Up to 1000 instance IDs. We recommend breaking up this request into smaller
         * batches.
         * Type: Array of strings
         * Required: Yes
         */
        global List<String> instanceId;
    }

    /**
     * https://docs.aws.amazon.com/AWSEC2/latest/APIReference/API_TerminateInstances.html#API_TerminateInstances_ResponseElements
     */
    global class TerminateInstancesResponse
    {
        /**
         * Information about the terminated instances.
         * Type: Array of InstanceStateChange objects
         */
        global List<InstanceStateChange> instancesSet;

        /**
         * The ID of the request.
         * Type: String
         */
        global String requestId;
    }

    /**
     * Describes an instance state change.
     * 
     * https://docs.aws.amazon.com/AWSEC2/latest/APIReference/API_InstanceStateChange.html
     */
    global class InstanceStateChange
    {
        /**
         * The current state of the instance.
         * Type: InstanceState object
         * Required: No
         */
        global InstanceState currentState;

        /**
         * The ID of the instance.
         * Type: String
         * Required: No
         */
        global String instanceId;

        /**
         * The previous state of the instance.
         * Type: InstanceState object
         * Required: No
         */
        global InstanceState previousState;
    }
    
    /**
     * A filter name and value pair that is used to return a more specific list of results from a
     * describe operation. Filters can be used to match a set of resources by specific criteria,
     * such as tags, attributes, or IDs. The filters supported by a describe operation are
     * documented with the describe operation. For example:
     * 
     * https://docs.aws.amazon.com/AWSEC2/latest/APIReference/API_Filter.html
     */
    global class Filter
    {
        /**
         * The name of the filter. Filter names are case-sensitive.
         * Type: String
         * Required: No
         */
        global String name;

        /**
         * The filter values. Filter values are case-sensitive.
         * Type: Array of strings
         * Required: No
         */
        global List<String> value; // NOT values per docs
    }
    
    /**
     * Describes a block device mapping.
     * 
     * https://docs.aws.amazon.com/AWSEC2/latest/APIReference/API_BlockDeviceMapping.html
     */
    global class BlockDeviceMapping
    {
        /**
         * The device name (for example, /dev/sdh or xvdh).
         * Type: String
         * Required: No
         */
        global String deviceName;

        /**
         * Parameters used to automatically set up EBS volumes when the instance is launched.
         * Type: EbsBlockDevice object
         * Required: No
         */
        global EbsBlockDevice ebs;

        /**
         * Suppresses the specified device included in the block device mapping of the AMI.
         * Type: String
         * Required: No
         */
        global String noDevice;

        /**
         * The virtual device name (ephemeralN). Instance store volumes are numbered starting from
         * 0. An instance type with 2 available instance store volumes can specify mappings for
         * ephemeral0 and ephemeral1. The number of available instance store volumes depends on the
         * instance type. After you connect to the instance, you must mount the volume.
         * NVMe instance store volumes are automatically enumerated and assigned a device name.
         * Including them in your block device mapping has no effect.
         * Constraints: For M3 instances, you must specify instance store volumes in the block
         * device mapping for the instance. When you launch an M3 instance, we ignore any instance
         * store volumes specified in the block device mapping for the AMI.
         * Type: String
         * Required: No
         */
        global String virtualName;
    }

    /**
     * Describes the credit option for CPU usage of a T2, T3, or T3a instance.
     * 
     * https://docs.aws.amazon.com/AWSEC2/latest/APIReference/API_CreditSpecification.html
     * https://docs.aws.amazon.com/AWSEC2/latest/APIReference/API_CreditSpecificationRequest.html
     */
    global class CreditSpecification
    {
        /**
         * The credit option for CPU usage of a T2 or T3 instance. Valid values are standard and
         * unlimited.
         * Type: String
         * Required: No
         */
        global String cpuCredits;
    }

    /**
     * A specification for an Elastic Graphics accelerator.
     * 
     * https://docs.aws.amazon.com/AWSEC2/latest/APIReference/API_ElasticGpuSpecification.html
     * https://docs.aws.amazon.com/AWSEC2/latest/APIReference/API_ElasticGpuSpecificationResponse.html
     */
    global class ElasticGpuSpecification
    {
        /**
         * The type of Elastic Graphics accelerator. For more information about the values to
         * specify for Type, see Elastic Graphics Basics, specifically the Elastic Graphics
         * accelerator column, in the Amazon Elastic Compute Cloud User Guide for Windows Instances.
         * Type: String
         * Required: Yes
         */
        global String type;
    }

    /**
     * Describes an elastic inference accelerator.
     * 
     * https://docs.aws.amazon.com/AWSEC2/latest/APIReference/API_ElasticInferenceAccelerator.html
     */
    global class ElasticInferenceAccelerator
    {
        /**
         * The number of elastic inference accelerators to attach to the instance.
         * Default: 1
         * Type: Integer
         * Valid Range: Minimum value of 1.
         * Required: No
         */
        global Integer count;

        /**
         * The type of elastic inference accelerator. The possible values are eia1.medium,
         * eia1.large, eia1.xlarge, eia2.medium, eia2.large, and eia2.xlarge.
         * Type: String
         * Required: Yes
         */
        global String type;
    }

    /**
     * Indicates whether your instance is configured for hibernation. This parameter is valid only
     * if the instance meets the hibernation prerequisites. For more information, see Hibernate your
     * instance in the Amazon Elastic Compute Cloud User Guide.
     * 
     * https://docs.aws.amazon.com/AWSEC2/latest/APIReference/API_HibernationOptions.html
     * https://docs.aws.amazon.com/AWSEC2/latest/APIReference/API_HibernationOptionsRequest.html
     */
    global class HibernationOptions
    {
        /**
         * If this parameter is set to true, your instance is enabled for hibernation; otherwise, it
         * is not enabled for hibernation.
         * Type: Boolean
         * Required: No
         */
        global Boolean configured;
    }

    /**
     * Describes an IAM instance profile.
     * 
     * https://docs.aws.amazon.com/AWSEC2/latest/APIReference/API_IamInstanceProfileSpecification.html
     */
    global class IamInstanceProfileSpecification
    {
        /**
         * The Amazon Resource Name (ARN) of the instance profile.
         * Type: String
         * Required: No
         */
        global String arn;

        /**
         * The Amazon Resource Name (ARN) of the instance profile.
         * Type: String
         * Required: No
         */
        global String name;
    }

    /**
     * Describes the market (purchasing) option for the instances.
     * 
     * https://docs.aws.amazon.com/AWSEC2/latest/APIReference/API_InstanceMarketOptionsRequest.html
     */
    global class InstanceMarketOptions
    {
        /**
         * The market type.
         * Type: String
         * Valid Values: spot
         * Required: No
         */
        global String marketType;

        /**
         * The options for Spot Instances.
         * Type: SpotMarketOptions object
         * Required: No
         */
        global SpotMarketOptions spotOptions;
    }

    /**
     * The options for Spot Instances.
     * 
     * https://docs.aws.amazon.com/AWSEC2/latest/APIReference/API_SpotMarketOptions.html
     */
    global class SpotMarketOptions
    {
        /**
         * The required duration for the Spot Instances (also known as Spot blocks), in minutes.
         * This value must be a multiple of 60 (60, 120, 180, 240, 300, or 360).
         * Type: Integer
         * Required: No
         */
        global Integer blockDurationMinutes;

        /**
         * The behavior when a Spot Instance is interrupted. The default is terminate.
         * Type: String
         * Valid Values: hibernate | stop | terminate
         * Required: No
         */
        global String instanceInterruptionBehaviour;

        /**
         * The maximum hourly price you're willing to pay for the Spot Instances. The default is
         * the On-Demand price.
         * Type: String
         * Required: No
         */
        global String maxPrice;

        /**
         * The Spot Instance request type. For RunInstances, persistent Spot Instance requests are
         * only supported when InstanceInterruptionBehavior is set to either hibernate or stop.
         * Type: String
         * Valid Values: one-time | persistent
         * Required: No
         */
        global String spotInstanceType;

        /**
         * The end date of the request. For a one-time request, the request remains active until all
         * instances launch, the request is canceled, or this date is reached. If the request is
         * persistent, it remains active until it is canceled or this date and time is reached. The
         * default end date is 7 days from the current date.
         * Type: Timestamp
         * Required: No
         */
        global Datetime validUntil;
    }
    
    /**
     * The launch template to use. You must specify either the launch template ID or launch template
     * name in the request, but not both.
     * 
     * https://docs.aws.amazon.com/AWSEC2/latest/APIReference/API_LaunchTemplateSpecification.html
     */
    global class LaunchTemplateSpecification
    {
        /**
         * The ID of the launch template.
         * Type: String
         * Required: No
         */
        global String launchTemplateId;

        /**
         * The name of the launch template.
         * Type: String
         * Required: No
         */
        global String launchTemplateName;

        /**
         * The version number of the launch template.
         * Default: The default version for the launch template.
         * Type: String
         * Required: No
         */
        global String version;
    }

    /**
     * Describes a license configuration.
     * 
     * https://docs.aws.amazon.com/AWSEC2/latest/APIReference/API_LicenseConfiguration.html
     * https://docs.aws.amazon.com/AWSEC2/latest/APIReference/API_LicenseConfigurationRequest.html
     */
    global class LicenseConfiguration
    {
        /**
         * The Amazon Resource Name (ARN) of the license configuration.
         * Type: String
         * Required: No
         */
        global String licenseConfigurationArn;
    }

    /**
     * The metadata options for the instance.
     * 
     * https://docs.aws.amazon.com/AWSEC2/latest/APIReference/API_InstanceMetadataOptionsRequest.html
     * https://docs.aws.amazon.com/AWSEC2/latest/APIReference/API_InstanceMetadataOptionsResponse.html
     */
    global class InstanceMetadataOptions
    {
        /**
         * This parameter enables or disables the HTTP metadata endpoint on your instances. If the
         * parameter is not specified, the default state is enabled.
         * Type: String
         * Valid Values: disabled | enabled
         * Required: No
         */
        global String httpEndpoint;

        /**
         * The desired HTTP PUT response hop limit for instance metadata requests. The larger the
         * number, the further instance metadata requests can travel.
         * Default: 1
         * Possible values: Integers from 1 to 64
         * Type: Integer
         * Required: No
         */
        global Integer httpPutResponseHopLimit;

        /**
         * The state of token usage for your instance metadata requests. If the parameter is not
         * specified in the request, the default state is optional.
         * If the state is optional, you can choose to retrieve instance metadata with or without a
         * signed token header on your request. If you retrieve the IAM role credentials without a
         * token, the version 1.0 role credentials are returned. If you retrieve the IAM role
         * credentials using a valid signed token, the version 2.0 role credentials are returned.
         * If the state is required, you must send a signed token header with any instance metadata
         * retrieval requests. In this state, retrieving the IAM role credential always returns the
         * version 2.0 credentials; the version 1.0 credentials are not available.
         * Type: String
         * Valid Values: optional | required
         * Required: No
         */
        global String httpTokens;

        /**
         * The state of the metadata option changes.
         * - pending - The metadata options are being updated and the instance is not ready to process
         *   metadata traffic with the new selection.
         * - applied - The metadata options have been successfully applied on the instance.
         * Type: String
         * Valid Values: pending | applied
         * Required: No
         */
        global String state;
    }

    /**
     * Describes the monitoring of an instance.
     * 
     * https://docs.aws.amazon.com/AWSEC2/latest/APIReference/API_RunInstancesMonitoringEnabled.html
     */
    global class RunInstancesMonitoringEnabled
    {
        /**
         * Indicates whether detailed monitoring is enabled. Otherwise, basic monitoring is enabled.
         * Type: Boolean
         * Required: Yes
         */
        global Boolean enabled;
    }

    /**
     * Describes a network interface.
     * 
     * https://docs.aws.amazon.com/AWSEC2/latest/APIReference/API_InstanceNetworkInterfaceSpecification.html
     */
    global class InstanceNetworkInterfaceSpecification
    {
        /**
         * Indicates whether to assign a public IPv4 address to an instance you launch in a VPC. The
         * public IP address can only be assigned to a network interface for eth0, and can only be
         * assigned to a new network interface, not an existing one. You cannot specify more than
         * one network interface in the request. If launching into a default subnet, the default
         * value is true.
         * Type: Boolean
         * Required: No
         */
        global Boolean associatePublicIpAddress;

        /**
         * If set to true, the interface is deleted when the instance is terminated. You can specify
         * true only if creating a new network interface when launching an instance.
         * Type: Boolean
         * Required: No
         */
        global Boolean deleteOnTermination;

        /**
         * The description of the network interface. Applies only if creating a network interface
         * when launching an instance.
         * Type: String
         * Required: No
         */
        global String description;

        /**
         * The position of the network interface in the attachment order. A primary network
         * interface has a device index of 0.
         * If you specify a network interface when launching an instance, you must specify the
         * device index.
         * Type: Integer
         * Required: No
         */
        global Integer deviceIndex;

        /**
         * The type of network interface. To create an Elastic Fabric Adapter (EFA), specify efa.
         * For more information, see Elastic Fabric Adapter in the Amazon Elastic Compute Cloud User
         * Guide.
         * If you are not creating an EFA, specify interface or omit this parameter.
         * Valid values: interface | efa
         * Type: String
         * Required: No
         */
        global String interfaceType;

        /**
         * A number of IPv6 addresses to assign to the network interface. Amazon EC2 chooses the
         * IPv6 addresses from the range of the subnet. You cannot specify this option and the
         * option to assign specific IPv6 addresses in the same request. You can specify this option
         * if you've specified a minimum number of instances to launch.
         * Type: Integer
         * Required: No
         */
        global Integer ipv6AddressCount;

        /**
         * One or more IPv6 addresses to assign to the network interface. You cannot specify this
         * option and the option to assign a number of IPv6 addresses in the same request. You
         * cannot specify this option if you've specified a minimum number of instances to launch.
         * Type: Array of InstanceIpv6Address objects
         * Required: No
         */
        global List<InstanceIpv6Address> ipv6Addresses;

        /**
         * The ID of the network interface
         * If you are creating a Spot Fleet, omit this parameter because you can’t specify a network
         * interface ID in a launch specification.
         * Type: String
         * Required: No
         */
        global String networkInterfaceId;

        /**
         * The private IPv4 address of the network interface. Applies only if creating a network
         * interface when launching an instance. You cannot specify this option if you're launching
         * more than one instance in a RunInstances request.
         * Type: String
         * Required: No
         */
        global String privateIpAddress;

        /**
         * One or more private IPv4 addresses to assign to the network interface. Only one private
         * IPv4 address can be designated as primary. You cannot specify this option if you're
         * launching more than one instance in a RunInstances request.
         * Type: Array of PrivateIpAddressSpecification objects
         * Required: No
         */
        global List<PrivateIpAddressSpecification> privateIpAddresses;

        /**
         * The number of secondary private IPv4 addresses. You can't specify this option and specify
         * more than one private IP address using the private IP addresses option. You cannot
         * specify this option if you're launching more than one instance in a RunInstances request.
         * Type: Integer
         * Required: No
         */
        global Integer secondaryPrivateIpAddressCount;

        /**
         * The IDs of the security groups for the network interface. Applies only if creating a
         * network interface when launching an instance.
         * Type: Array of strings
         * Required: No
         */
        global List<String> groups;

        /**
         * The ID of the subnet associated with the network interface. Applies only if creating a
         * network interface when launching an instance.
         * Type: String
         * Required: No
         */
        global String subnetId;
    }

    /**
     * The tags to apply to a resource when the resource is being created.
     * 
     * https://docs.aws.amazon.com/AWSEC2/latest/APIReference/API_TagSpecification.html
     */
    global class TagSpecification
    {
        /**
         * The type of resource to tag. Currently, the resource types that support tagging on
         * creation are: capacity-reservation | client-vpn-endpoint | dedicated-host
         * | export-image-task | export-instance-task | fleet | fpga-image | host-reservation
         * | import-image-task | import-snapshot-task | instance | ipv4pool-ec2 | ipv6pool-ec2
         * | key-pair | launch-template | natgateway | spot-fleet-request | placement-group
         * | prefix-list | snapshot | traffic-mirror-filter | traffic-mirror-session
         * | traffic-mirror-target | transit-gateway | transit-gateway-attachment
         * | transit-gateway-route-table | vpc-endpoint (for interface and gateway endpoints)
         * | vpc-endpoint-service (for AWS PrivateLink) | volume | vpc-flow-log.
         * To tag a resource after it has been created, see CreateTags.
         * Type: String
         * Valid Values: client-vpn-endpoint | customer-gateway | dedicated-host | dhcp-options
         * | elastic-ip | elastic-gpu | export-image-task | export-instance-task | fleet
         * | fpga-image | host-reservation | image | import-image-task | import-snapshot-task
         * | instance | internet-gateway | key-pair | launch-template
         * | local-gateway-route-table-vpc-association | natgateway | network-acl
         * | network-interface | placement-group | reserved-instances | route-table | security-group
         * | snapshot | spot-fleet-request | spot-instances-request | subnet | traffic-mirror-filter
         * | traffic-mirror-session | traffic-mirror-target | transit-gateway
         * | transit-gateway-attachment | transit-gateway-multicast-domain
         * | transit-gateway-route-table | volume | vpc | vpc-peering-connection | vpn-connection
         * | vpn-gateway | vpc-flow-log
         * Required: No
         */
        global String resourceType;

        /**
         * The tags to apply to the resource.
         * Type: Array of Tag objects
         * Required: No
         */
        global List<Tag> tags;
    }

    /**
     * Describes a block device for an EBS volume.
     * 
     * https://docs.aws.amazon.com/AWSEC2/latest/APIReference/API_EbsBlockDevice.html
     */
    global class EbsBlockDevice
    {
        /**
         * Indicates whether the EBS volume is deleted on instance termination. For more
         * information, see Preserving Amazon EBS volumes on instance termination in the Amazon
         * Elastic Compute Cloud User Guide.
         * Type: Boolean
         * Required: No
         */
        global Boolean deleteOnTermination;

        /**
         * Indicates whether the encryption state of an EBS volume is changed while being restored
         * from a backing snapshot. The effect of setting the encryption state to true depends on
         * the volume origin (new or from a snapshot), starting encryption state, ownership, and
         * whether encryption by default is enabled. For more information, see Amazon EBS Encryption
         * in the Amazon Elastic Compute Cloud User Guide.
         * In no case can you remove encryption from an encrypted volume.
         * Encrypted volumes can only be attached to instances that support Amazon EBS encryption.
         * For more information, see Supported instance types.
         * This parameter is not returned by DescribeImageAttribute.
         * Type: Boolean
         * Required: No
         */
        global Boolean encrypted;

        /**
         * The number of I/O operations per second (IOPS) that the volume supports. For io1 volumes,
         * this represents the number of IOPS that are provisioned for the volume. For gp2 volumes,
         * this represents the baseline performance of the volume and the rate at which the volume
         * accumulates I/O credits for bursting. For more information, see Amazon EBS volume types
         * in the Amazon Elastic Compute Cloud User Guide.
         * Constraints: Range is 100-16,000 IOPS for gp2 volumes and 100 to 64,000IOPS for io1
         * volumes in most Regions. Maximum io1 IOPS of 64,000 is guaranteed only on Nitro-based
         * instances. Other instance families guarantee performance up to 32,000 IOPS. For more
         * information, see Amazon EBS Volume Types in the Amazon Elastic Compute Cloud User Guide.
         * Condition: This parameter is required for requests to create io1 volumes; it is not used
         * in requests to create gp2, st1, sc1, or standard volumes.
         * Type: Integer
         * Required: No
         */
        global Integer iops;

        /**
         * Identifier (key ID, key alias, ID ARN, or alias ARN) for a customer managed CMK under
         * which the EBS volume is encrypted.
         * This parameter is only supported on BlockDeviceMapping objects called by RunInstances,
         * RequestSpotFleet, and RequestSpotInstances.
         * Type: String
         * Required: No
         */
        global String kmsKeyId;

        /**
         * The ID of the snapshot.
         * Type: String
         * Required: No
         */
        global String snapshotId;

        /**
         * The size of the volume, in GiB.
         * Default: If you're creating the volume from a snapshot and don't specify a volume size,
         * the default is the snapshot size.
         * Constraints: 1-16384 for General Purpose SSD (gp2), 4-16384 for Provisioned IOPS SSD
         * (io1), 500-16384 for Throughput Optimized HDD (st1), 500-16384 for Cold HDD (sc1), and
         * 1-1024 for Magnetic (standard) volumes. If you specify a snapshot, the volume size must
         * be equal to or larger than the snapshot size.
         * Type: Integer
         * Required: No
         */
        global Integer volumeSize;

        /**
         * The volume type. If you set the type to io1, you must also specify the Iops parameter. If
         * you set the type to gp2, st1, sc1, or standard, you must omit the Iops parameter.
         * Default: gp2
         * Type: String
         * Valid Values: standard | io1 | gp2 | sc1 | st1
         * Required: No
         */
        global String volumeType;
    }

    /**
     * Describes a target Capacity Reservation.
     * 
     * https://docs.aws.amazon.com/AWSEC2/latest/APIReference/API_CapacityReservationTarget.html
     * https://docs.aws.amazon.com/AWSEC2/latest/APIReference/API_CapacityReservationTargetResponse.html
     */
    global class CapacityReservationTarget
    {
        /**
         * The ID of the Capacity Reservation.
         * Type: String
         * Required: No
         */
        global String capacityReservationId;
    }

    /**
     * Describes a secondary private IPv4 address for a network interface.
     * 
     * https://docs.aws.amazon.com/AWSEC2/latest/APIReference/API_PrivateIpAddressSpecification.html
     */
    global class PrivateIpAddressSpecification
    {
        /**
         * Indicates whether the private IPv4 address is the primary private IPv4 address. Only one
         * IPv4 address can be designated as primary.
         * Type: Boolean
         * Required: No
         */
        global Boolean primary;

        /**
         * The private IPv4 addresses.
         * Type: String
         * Required: No
         */
        global String privateIpAddress;
    }
    
    /**
     * Describes a Region.
     * 
     * https://docs.aws.amazon.com/AWSEC2/latest/APIReference/API_Region.html
     */
    global class Region
    {
        /**
         * The Region opt-in status. The possible values are opt-in-not-required, opted-in, and
         * not-opted-in.
         * Type: String
         * Required: No
         */
        global String optInStatus;

        /**
         * The Region service endpoint.
         * Type: String
         * Required: No
         */
        global String regionEndpoint;

        /**
         * The name of the Region.
         * Type: String
         * Required: No
         */
        global String regionName;
    }
    
    /**
     * Describes a reservation.
     * 
     * https://docs.aws.amazon.com/AWSEC2/latest/APIReference/API_Reservation.html
     */
    global class Reservation
    {
        /**
         * [EC2-Classic only] The security groups.
         * Type: Array of GroupIdentifier objects
         * Required: No
         */
        global List<GroupIdentifier> groupSet;

        /**
         * The instances.
         * Type: Array of Instance objects
         * Required: No
         */
        global List<Instance> instancesSet;

        /**
         * The ID of the AWS account that owns the reservation.
         * Type: String
         * Required: No
         */
        global String ownerId;

        /**
         * The ID of the requester that launched the instances on your behalf (for example, AWS
         * Management Console or Auto Scaling).
         * Type: String
         * Required: No
         */
        global String requesterId;

        /**
         * The ID of the reservation.
         * Type: String
         * Required: No
         */
        global String reservationId;
    }

    /**
     * Describes a security group.
     * 
     * https://docs.aws.amazon.com/AWSEC2/latest/APIReference/API_GroupIdentifier.html
     */
    global class GroupIdentifier
    {
        /**
         * The ID of the security group.
         * Type: String
         * Required: No
         */
        global String groupId;

        /**
         * The name of the security group.
         * Type: String
         * Required: No
         */
        global String groupName;
    }

    /**
     * Describes an instance.
     * 
     * https://docs.aws.amazon.com/AWSEC2/latest/APIReference/API_Instance.html
     */
    global class Instance
    {
        /**
         * The AMI launch index, which can be used to find this instance in the launch group.
         * Type: Integer
         * Required: No
         */
        global Integer amiLaunchIndex;

        /**
         * The architecture of the image.
         * Type: String
         * Valid Values: i386 | x86_64 | arm64
         * Required: No
         */
        global String architecture;

        /**
         * Any block device mapping entries for the instance.
         * Type: Array of InstanceBlockDeviceMapping objects
         * Required: No
         */
        global List<InstanceBlockDeviceMapping> blockDeviceMapping;

        /**
         * The ID of the Capacity Reservation.
         * Type: String
         * Required: No
         */
        global String capacityReservationId;

        /**
         * Information about the Capacity Reservation targeting option.
         * Type: CapacityReservationSpecificationResponse object
         * Required: No
         */
        global CapacityReservationSpecification capacityReservationSpecification;

        /**
         * The idempotency token you provided when you launched the instance, if applicable.
         * Type: String
         * Required: No
         */
        global String clientToken;

        /**
         * The CPU options for the instance.
         * Type: CpuOptions object
         * Required: No
         */
        global CpuOptions cpuOptions;

        /**
         * (IPv4 only) The public DNS name assigned to the instance. This name is not available
         * until the instance enters the running state. For EC2-VPC, this name is only available
         * if you've enabled DNS hostnames for your VPC.
         * Type: String
         * Required: No
         */
        global String dnsName;

        /**
         * Indicates whether the instance is optimized for Amazon EBS I/O. This optimization
         * provides dedicated throughput to Amazon EBS and an optimized configuration stack to
         * provide optimal I/O performance. This optimization isn't available with all instance
         * types. Additional usage charges apply when using an EBS Optimized instance.
         * Type: Boolean
         * Required: No
         */
        global Boolean ebsOptimized;

        /**
         * The Elastic GPU associated with the instance.
         * Type: Array of ElasticGpuAssociation objectsRequired: No
         * Required: No
         */
        global List<ElasticGpuAssociation> elasticGpuAssociationSet;

        /**
         * The elastic inference accelerator associated with the instance.
         * Type: Array of ElasticInferenceAcceleratorAssociation objects
         * Required: No
         */
        global List<ElasticInferenceAcceleratorAssociation> elasticInferenceAcceleratorAssociationSet;

        /**
         * Specifies whether enhanced networking with ENA is enabled.
         * Type: Boolean
         * Required: No
         */
        global Boolean enaSupport;

        /**
         * The security groups for the instance.
         * Type: Array of GroupIdentifier objects
         * Required: No
         */
        global List<GroupIdentifier> groupSet;

        /**
         * Indicates whether the instance is enabled for hibernation.
         * Type: HibernationOptions object
         * Required: No
         */
        global HibernationOptions hibernationOptions;

        /**
         * The hypervisor type of the instance. The value xen is used for both Xen and Nitro
         * hypervisors.
         * Type: String
         * Valid Values: ovm | xen
         * Required: No
         */
        global String hypervisor;
        
        /**
         * The IAM instance profile associated with the instance, if applicable.
         * Type: IamInstanceProfile object
         * Required: No
         */
        global IamInstanceProfile iamInstanceProfile;

        /**
         * The ID of the AMI used to launch the instance.
         * Type: String
         * Required: No
         */
        global String imageId;

        /**
         * The ID of the instance.
         * Type: String
         * Required: No
         */
        global String instanceId;

        /**
         * Indicates whether this is a Spot Instance or a Scheduled Instance.
         * Type: String
         * Valid Values: spot | scheduled
         * Required: No
         */
        global String instanceLifecycle;

        /**
         * The current state of the instance.
         * Type: InstanceState object
         * Required: No
         */
        global InstanceState instanceState;

        /**
         * The instance type.
         * Type: String
         * Valid Values: t1.micro | t2.nano | t2.micro | t2.small | t2.medium | t2.large | t2.xlarge
         * | t2.2xlarge | t3.nano | t3.micro | t3.small | t3.medium | t3.large | t3.xlarge
         * | t3.2xlarge | t3a.nano | t3a.micro | t3a.small | t3a.medium | t3a.large | t3a.xlarge
         * | t3a.2xlarge | m1.small | m1.medium | m1.large | m1.xlarge | m3.medium | m3.large
         * | m3.xlarge | m3.2xlarge | m4.large | m4.xlarge | m4.2xlarge | m4.4xlarge | m4.10xlarge
         * | m4.16xlarge | m2.xlarge | m2.2xlarge | m2.4xlarge | cr1.8xlarge | r3.large | r3.xlarge
         * | r3.2xlarge | r3.4xlarge | r3.8xlarge | r4.large | r4.xlarge | r4.2xlarge | r4.4xlarge
         * | r4.8xlarge | r4.16xlarge | r5.large | r5.xlarge | r5.2xlarge | r5.4xlarge | r5.8xlarge
         * | r5.12xlarge | r5.16xlarge | r5.24xlarge | r5.metal | r5a.large | r5a.xlarge
         * | r5a.2xlarge | r5a.4xlarge | r5a.8xlarge | r5a.12xlarge | r5a.16xlarge | r5a.24xlarge
         * | r5d.large | r5d.xlarge | r5d.2xlarge | r5d.4xlarge | r5d.8xlarge | r5d.12xlarge
         * | r5d.16xlarge | r5d.24xlarge | r5d.metal | r5ad.large | r5ad.xlarge | r5ad.2xlarge
         * | r5ad.4xlarge | r5ad.8xlarge | r5ad.12xlarge | r5ad.16xlarge | r5ad.24xlarge | r6g.metal
         * | r6g.medium | r6g.large | r6g.xlarge | r6g.2xlarge | r6g.4xlarge | r6g.8xlarge
         * | r6g.12xlarge | r6g.16xlarge | x1.16xlarge | x1.32xlarge | x1e.xlarge | x1e.2xlarge
         * | x1e.4xlarge | x1e.8xlarge | x1e.16xlarge | x1e.32xlarge | i2.xlarge | i2.2xlarge
         * | i2.4xlarge | i2.8xlarge | i3.large | i3.xlarge | i3.2xlarge | i3.4xlarge | i3.8xlarge
         * | i3.16xlarge | i3.metal | i3en.large | i3en.xlarge | i3en.2xlarge | i3en.3xlarge
         * | i3en.6xlarge | i3en.12xlarge | i3en.24xlarge | i3en.metal | hi1.4xlarge | hs1.8xlarge
         * | c1.medium | c1.xlarge | c3.large | c3.xlarge | c3.2xlarge | c3.4xlarge | c3.8xlarge
         * | c4.large | c4.xlarge | c4.2xlarge | c4.4xlarge | c4.8xlarge | c5.large | c5.xlarge
         * | c5.2xlarge | c5.4xlarge | c5.9xlarge | c5.12xlarge | c5.18xlarge | c5.24xlarge
         * | c5.metal | c5a.large | c5a.xlarge | c5a.2xlarge | c5a.4xlarge | c5a.8xlarge
         * | c5a.12xlarge | c5a.16xlarge | c5a.24xlarge | c5d.large | c5d.xlarge | c5d.2xlarge
         * | c5d.4xlarge | c5d.9xlarge | c5d.12xlarge | c5d.18xlarge | c5d.24xlarge | c5d.metal
         * | c5n.large | c5n.xlarge | c5n.2xlarge | c5n.4xlarge | c5n.9xlarge | c5n.18xlarge
         * | c6g.metal | c6g.medium | c6g.large | c6g.xlarge | c6g.2xlarge | c6g.4xlarge
         * | c6g.8xlarge | c6g.12xlarge | c6g.16xlarge | cc1.4xlarge | cc2.8xlarge | g2.2xlarge
         * | g2.8xlarge | g3.4xlarge | g3.8xlarge | g3.16xlarge | g3s.xlarge | g4dn.xlarge
         * | g4dn.2xlarge | g4dn.4xlarge | g4dn.8xlarge | g4dn.12xlarge | g4dn.16xlarge | g4dn.metal
         * | cg1.4xlarge | p2.xlarge | p2.8xlarge | p2.16xlarge | p3.2xlarge | p3.8xlarge
         * | p3.16xlarge | p3dn.24xlarge | d2.xlarge | d2.2xlarge | d2.4xlarge | d2.8xlarge
         * | f1.2xlarge | f1.4xlarge | f1.16xlarge | m5.large | m5.xlarge | m5.2xlarge | m5.4xlarge
         * | m5.8xlarge | m5.12xlarge | m5.16xlarge | m5.24xlarge | m5.metal | m5a.large
         * | m5a.xlarge | m5a.2xlarge | m5a.4xlarge | m5a.8xlarge | m5a.12xlarge | m5a.16xlarge
         * | m5a.24xlarge | m5d.large | m5d.xlarge | m5d.2xlarge | m5d.4xlarge | m5d.8xlarge
         * | m5d.12xlarge | m5d.16xlarge | m5d.24xlarge | m5d.metal | m5ad.large | m5ad.xlarge
         * | m5ad.2xlarge | m5ad.4xlarge | m5ad.8xlarge | m5ad.12xlarge | m5ad.16xlarge
         * | m5ad.24xlarge | h1.2xlarge | h1.4xlarge | h1.8xlarge | h1.16xlarge | z1d.large
         * | z1d.xlarge | z1d.2xlarge | z1d.3xlarge | z1d.6xlarge | z1d.12xlarge | z1d.metal
         * | u-6tb1.metal | u-9tb1.metal | u-12tb1.metal | u-18tb1.metal | u-24tb1.metal | a1.medium
         * | a1.large | a1.xlarge | a1.2xlarge | a1.4xlarge | a1.metal | m5dn.large | m5dn.xlarge
         * | m5dn.2xlarge | m5dn.4xlarge | m5dn.8xlarge | m5dn.12xlarge | m5dn.16xlarge
         * | m5dn.24xlarge | m5n.large | m5n.xlarge | m5n.2xlarge | m5n.4xlarge | m5n.8xlarge
         * | m5n.12xlarge | m5n.16xlarge | m5n.24xlarge | r5dn.large | r5dn.xlarge | r5dn.2xlarge
         * | r5dn.4xlarge | r5dn.8xlarge | r5dn.12xlarge | r5dn.16xlarge | r5dn.24xlarge | r5n.large
         * | r5n.xlarge | r5n.2xlarge | r5n.4xlarge | r5n.8xlarge | r5n.12xlarge | r5n.16xlarge
         * | r5n.24xlarge | inf1.xlarge | inf1.2xlarge | inf1.6xlarge | inf1.24xlarge | m6g.metal
         * | m6g.medium | m6g.large | m6g.xlarge | m6g.2xlarge | m6g.4xlarge | m6g.8xlarge
         * | m6g.12xlarge | m6g.16xlarge
         * Required: No
         */
        global String instanceType;

        /**
         * The global IPv4 address assigned to the instance, if applicable.
         * Type: String
         * Required: No
         */
        global String ipAddress;

        /**
         * The kernel associated with this instance, if applicable.
         * Type: String
         * Required: No
         */
        global String kernelId;

        /**
         * The name of the key pair, if this instance was launched with an associated key pair.
         * Type: String
         * Required: No
         */
        global String keyName;

        /**
         * The time the instance was launched.
         * Type: Timestamp
         * Required: No
         */
        global Datetime launchTime;

        /**
         * The license configurations.
         * Type: Array of LicenseConfiguration objects
         * Required: No
         */
        global List<LicenseConfiguration> licenseSet;

        /**
         * The metadata options for the instance.
         * Type: InstanceMetadataOptionsResponse object
         * Required: No
         */
        global InstanceMetadataOptions metadataOptions;

        /**
         * The monitoring for the instance.
         * Type: Monitoring object
         * Required: No
         */
        global Monitoring monitoring;

        /**
         * [EC2-VPC] The network interfaces for the instance.
         * Type: Array of InstanceNetworkInterface objects
         * Required: No
         */
        global List<InstanceNetworkInterface> networkInterfaceSet;

        /**
         * The Amazon Resource Name (ARN) of the Outpost.
         * Type: String
         * Required: No
         */
        global String outpostArn;

        /**
         * The location where the instance launched, if applicable.
         * Type: Placement object
         * Required: No
         */
        global Placement placement;

        /**
         * The value is Windows for Windows instances; otherwise blank.
         * Type: String
         * Valid Values: Windows
         * Required: No
         */
        global String platform;

        /**
         * (IPv4 only) The private DNS hostname name assigned to the instance. This DNS hostname can
         * only be used inside the Amazon EC2 network. This name is not available until the instance
         * enters the running state.
         * [EC2-VPC] The Amazon-provided DNS server resolves Amazon-provided private DNS hostnames
         * if you've enabled DNS resolution and DNS hostnames in your VPC. If you are not using the
         * Amazon-provided DNS server in your VPC, your custom domain name servers must resolve the
         * hostname as appropriate.
         * Type: String
         * Required: No
         */
        global String privateDnsName;

        /**
         * The private IPv4 address assigned to the instance.
         * Type: String
         * Required: No
         */
        global String privateIpAddress;

        /**
         * The product codes attached to this instance, if applicable.
         * Type: Array of ProductCode objects
         * Required: No
         */
        global List<ProductCode> productCodes;

        /**
         * The RAM disk associated with this instance, if applicable.
         * Type: String
         * Required: No
         */
        global String ramdiskId;

        /**
         * The reason for the most recent state transition. This might be an empty string.
         * Type: String
         * Required: No
         */
        global String reason;

        /**
         * The device name of the root device volume (for example, /dev/sda1).
         * Type: String
         * Required: No
         */
        global String rootDeviceName;

        /**
         * The root device type used by the AMI. The AMI can use an EBS volume or an instance store
         * volume.
         * Type: String
         * Valid Values: ebs | instance-store
         * Required: No
         */
        global String rootDeviceType;

        /**
         * Specifies whether to enable an instance launched in a VPC to perform NAT. This controls
         * whether source/destination checking is enabled on the instance. A value of true means
         * that checking is enabled, and false means that checking is disabled. The value must be
         * false for the instance to perform NAT. For more information, see NAT Instances in the
         * Amazon Virtual Private Cloud User Guide.
         * Type: Boolean
         * Required: No
         */
        global Boolean sourceDestCheck;

        /**
         * If the request is a Spot Instance request, the ID of the request.
         * Type: String
         * Required: No
         */
        global String spotInstanceRequestId;

        /**
         * Specifies whether enhanced networking with the Intel 82599 Virtual Function interface is
         * enabled.
         * Type: String
         * Required: No
         */
        global String sriovNetSupport;

        /**
         * The reason for the most recent state transition.
         * Type: StateReason object
         * Required: No
         */
        global StateReason stateReason;

        /**
         * [EC2-VPC] The ID of the subnet in which the instance is running.
         * Type: String
         * Required: No
         */
        global String subnetId;

        /**
         * Any tags assigned to the instance.
         * Type: Array of Tag objects
         * Required: No
         */
        global List<Tag> tagSet;

        /**
         * The virtualization type of the instance.
         * Type: String
         * Valid Values: hvm | paravirtual
         * Required: No
         */
        global String virtualizationType;

        /**
         * [EC2-VPC] The ID of the VPC in which the instance is running.
         * Type: String
         * Required: No
         */
        global String vpcId;
    }

    /**
     * Describes a block device mapping.
     * 
     * https://docs.aws.amazon.com/AWSEC2/latest/APIReference/API_InstanceBlockDeviceMapping.html
     */
    global class InstanceBlockDeviceMapping
    {
        /**
         * The device name (for example, /dev/sdh or xvdh).
         * Type: String
         * Required: No
         */
        global String deviceName;

        /**
         * Parameters used to automatically set up EBS volumes when the instance is launched.
         * Type: EbsInstanceBlockDevice object
         * Required: No
         */
        global EbsInstanceBlockDevice ebs;
    }

    /**
     * Describes an instance's Capacity Reservation targeting option. You can specify only one
     * parameter at a time. If you specify CapacityReservationPreference and
     * CapacityReservationTarget, the request fails.
     * 
     * https://docs.aws.amazon.com/AWSEC2/latest/APIReference/API_CapacityReservationSpecification.html
     */
    global class CapacityReservationSpecification
    {
        /**
         * Indicates the instance's Capacity Reservation preferences. Possible preferences include:
         * - open - The instance can run in any open Capacity Reservation that has matching
         *   attributes (instance type, platform, Availability Zone).
         * - none - The instance avoids running in a Capacity Reservation even if one is available.
         *   The instance runs as an On-Demand Instance.
         * Type: String
         * Valid Values: open | none
         * Required: No
         */
        global String capacityReservationPreference;

        /**
         * Information about the targeted Capacity Reservation.
         * Type: CapacityReservationTarget object
         * Required: No
         */
        global CapacityReservationTarget capacityReservationTarget;
    }

    /**
     * The CPU options for the instance. Both the core count and threads per core must be specified
     * in the request.
     * 
     * https://docs.aws.amazon.com/AWSEC2/latest/APIReference/API_CpuOptions.html
     * https://docs.aws.amazon.com/AWSEC2/latest/APIReference/API_CpuOptionsRequest.html
     */
    global class CpuOptions
    {
        /**
         * The number of CPU cores for the instance.
         * Type: Integer
         * Required: No
         */
        global Integer coreCount;

        /**
         * The number of threads per CPU core. To disable multithreading for the instance, specify a
         * value of 1. Otherwise, specify the default value of 2.
         * Type: Integer
         * Required: No
         */
        global Integer threadsPerCore;
    }

    /**
     * Describes the association between an instance and an Elastic Graphics accelerator.
     * 
     * https://docs.aws.amazon.com/AWSEC2/latest/APIReference/API_ElasticGpuAssociation.html
     */
    global class ElasticGpuAssociation
    {
        /**
         * The ID of the association.
         * Type: String
         * Required: No
         */
        global String elasticGpuAssociationId;

        /**
         * The state of the association between the instance and the Elastic Graphics accelerator.
         * Type: String
         * Required: No
         */
        global String elasticGpuAssociationState;

        /**
         * The time the Elastic Graphics accelerator was associated with the instance.
         * Type: String
         * Required: No
         */
        global String elasticGpuAssociationTime;

        /**
         * The ID of the Elastic Graphics accelerator.
         * Type: String
         * Required: No
         */
        global String elasticGpuId;
    }

    /**
     * Describes the association between an instance and an elastic inference accelerator.
     * 
     * https://docs.aws.amazon.com/AWSEC2/latest/APIReference/API_ElasticInferenceAcceleratorAssociation.html
     */
    global class ElasticInferenceAcceleratorAssociation
    {
        /**
         * The Amazon Resource Name (ARN) of the elastic inference accelerator.
         * Type: String
         * Required: No
         */
        global String elasticInferenceAcceleratorArn;

        /**
         * The ID of the association.
         * Type: String
         * Required: No
         */
        global String elasticInferenceAcceleratorAssociationId;

        /**
         * The state of the elastic inference accelerator.
         * Type: String
         * Required: No
         */
        global String elasticInferenceAcceleratorAssociationState;

        /**
         * The time at which the elastic inference accelerator is associated with an instance.
         * Type: Timestamp
         * Required: No
         */
        global Datetime elasticInferenceAcceleratorAssociationTime;
    }

    /**
     * Describes an IAM instance profile.
     * 
     * https://docs.aws.amazon.com/AWSEC2/latest/APIReference/API_IamInstanceProfile.html
     */
    global class IamInstanceProfile
    {
        /**
         * The Amazon Resource Name (ARN) of the instance profile.
         * Type: String
         * Required: No
         */
        global String arn;

        /**
         * The ID of the instance profile.
         * Type: String
         * Required: No
         */
        global String id;
    }

    /**
     * Describes the current state of an instance.
     * 
     * https://docs.aws.amazon.com/AWSEC2/latest/APIReference/API_InstanceState.html
     */
    global class InstanceState
    {
        /**
         * The state of the instance as a 16-bit unsigned integer.
         * The high byte is all of the bits between 2^8 and (2^16)-1, which equals decimal values
         * between 256 and 65,535. These numerical values are used for internal purposes and should
         * be ignored.
         * The low byte is all of the bits between 2^0 and (2^8)-1, which equals decimal values
         * between 0 and 255.
         * The valid values for instance-state-code will all be in the range of the low byte and
         * they are:
         * - 0 : pending
         * - 16 : running
         * - 32 : shutting-down
         * - 48 : terminated
         * - 64 : stopping
         * - 80 : stopped
         * You can ignore the high byte value by zeroing out all of the bits above 2^8 or 256 in
         * decimal.
         * Type: Integer
         * Required: No
         */
        global Integer code;

        /**
         * The current state of the instance.
         * Type: String
         * Valid Values: pending | running | shutting-down | terminated | stopping | stopped
         * Required: No
         */
        global String name;
    }

    /**
     * Describes the monitoring of an instance.
     * 
     * https://docs.aws.amazon.com/AWSEC2/latest/APIReference/API_Monitoring.html
     */
    global class Monitoring
    {
        /**
         * Indicates whether detailed monitoring is enabled. Otherwise, basic monitoring is enabled.
         * Type: String
         * Valid Values: disabled | disabling | enabled | pending
         * Required: No
         */
        global String state;
    }

    /**
     * Describes a network interface.
     * 
     * https://docs.aws.amazon.com/AWSEC2/latest/APIReference/API_InstanceNetworkInterface.html
     */
    global class InstanceNetworkInterface
    {
        /**
         * The association information for an Elastic IPv4 associated with the network interface.
         * Type: InstanceNetworkInterfaceAssociation object
         * Required: No
         */
        global InstanceNetworkInterfaceAssociation association;

        /**
         * The network interface attachment.
         * Type: InstanceNetworkInterfaceAttachment object
         * Required: No
         */
        global InstanceNetworkInterfaceAttachment attachment;

        /**
         * The description.
         * Type: String
         * Required: No
         */
        global String description;

        /**
         * One or more security groups.
         * Type: Array of GroupIdentifier objects
         * Required: No
         */
        global List<GroupIdentifier> groupSet;

        /**
         * Describes the type of network interface.
         * Valid values: interface | efa
         * Type: String
         * Required: No
         */
        global String interfaceType;

        /**
         * One or more IPv6 addresses associated with the network interface.
         * Type: Array of InstanceIpv6Address objects
         * Required: No
         */
        global List<InstanceIpv6Address> ipv6AddressesSet;

        /**
         * The MAC address.
         * Type: String
         * Required: No
         */
        global String macAddress;

        /**
         * The ID of the network interface.
         * Type: String
         * Required: No
         */
        global String networkInterfaceId;

        /**
         * The ID of the AWS account that created the network interface.
         * Type: String
         * Required: No
         */
        global String ownerId;

        /**
         * The private DNS name.
         * Type: String
         * Required: No
         */
        global String privateDnsName;

        /**
         * The IPv4 address of the network interface within the subnet.
         * Type: String
         * Required: No
         */
        global String privateIpAddress;

        /**
         * One or more private IPv4 addresses associated with the network interface.
         * Type: Array of InstancePrivateIpAddress objects
         * Required: No
         */
        global List<InstancePrivateIpAddress> privateIpAddressesSet;

        /**
         * Indicates whether to validate network traffic to or from this network interface.
         * Type: Boolean
         * Required: No
         */
        global Boolean sourceDestCheck;

        /**
         * The status of the network interface.
         * Type: String
         * Valid Values: available | associated | attaching | in-use | detaching
         * Required: No
         */
        global String status;

        /**
         * The ID of the subnet.
         * Type: String
         * Required: No
         */
        global String subnetId;

        /**
         * The ID of the VPC.
         * Type: String
         * Required: No
         */
        global String vpcId;
    }

    /**
     * Describes the placement of an instance.
     * 
     * https://docs.aws.amazon.com/AWSEC2/latest/APIReference/API_Placement.html
     */
    global class Placement
    {
        /**
         * The affinity setting for the instance on the Dedicated Host. This parameter is not
         * supported for the ImportInstance command.
         * This parameter is not supported by CreateFleet.
         * Type: String
         * Required: No
         */
        global String affinity;

        /**
         * The Availability Zone of the instance.
         * If not specified, an Availability Zone will be automatically chosen for you based on the
         * load balancing criteria for the Region.
         * This parameter is not supported by CreateFleet.
         * Type: String
         * Required: No
         */
        global String availabilityZone;

        /**
         * The name of the placement group the instance is in.
         * Type: String
         * Required: No
         */
        global String groupName;

        /**
         * The ID of the Dedicated Host on which the instance resides. This parameter is not
         * supported for the ImportInstance command.
         * This parameter is not supported by CreateFleet.
         * Type: String
         * Required: No
         */
        global String hostId;

        /**
         * The ARN of the host resource group in which to launch the instances. If you specify a
         * host resource group ARN, omit the Tenancy parameter or set it to host.
         * This parameter is not supported by CreateFleet.
         * Type: String
         * Required: No
         */
        global String hostResourceGroupArn;

        /**
         * The number of the partition the instance is in. Valid only if the placement group
         * strategy is set to partition.
         * This parameter is not supported by CreateFleet.
         * Type: Integer
         * Required: No
         */
        global Integer partitionNumber;
        
        /**
         * Reserved for future use.
         * This parameter is not supported by CreateFleet.
         * Type: String
         * Required: No
         */
        global String spreadDomain;

        /**
         * The tenancy of the instance (if the instance is running in a VPC). An instance with a
         * tenancy of dedicated runs on single-tenant hardware. The host tenancy is not supported
         * for the ImportInstance command.
         * This parameter is not supported by CreateFleet.
         * Type: String
         * Valid Values: default | dedicated | host
         * Required: No
         */
        global String tenancy;
    }

    /**
     * Describes a product code.
     * 
     * https://docs.aws.amazon.com/AWSEC2/latest/APIReference/API_ProductCode.html
     */
    global class ProductCode
    {
        /**
         * The product code.
         * Type: String
         * Required: No
         */
        global String productCode;

        /**
         * The type of product code.
         * Type: String
         * Valid Values: devpay | marketplace
         * Required: No
         */
        global String type;
    }

    /**
     * Describes a state change.
     * 
     * https://docs.aws.amazon.com/AWSEC2/latest/APIReference/API_StateReason.html
     */
    global class StateReason
    {
        /**
         * The reason code for the state change.
         * Type: String
         * Required: No
         */
        global String code;

        /**
         * The message for the state change.
         * - Server.InsufficientInstanceCapacity: There was insufficient capacity available to
         *   satisfy the launch request.
         * - Server.InternalError: An internal error caused the instance to terminate during launch.
         * - Server.ScheduledStop: The instance was stopped due to a scheduled retirement.
         * - Server.SpotInstanceShutdown: The instance was stopped because the number of Spot
         *   requests with a maximum price equal to or higher than the Spot price exceeded available
         *   capacity or because of an increase in the Spot price.
         * - Server.SpotInstanceTermination: The instance was terminated because the number of Spot
         * requests with a maximum price equal to or higher than the Spot price exceeded available
         * capacity or because of an increase in the Spot price.
         * - Client.InstanceInitiatedShutdown: The instance was shut down using the shutdown -h
         *   command from the instance.
         * - Client.InstanceTerminated: The instance was terminated or rebooted during AMI creation.
         * - Client.InternalError: A client error caused the instance to terminate during launch.
         * - Client.InvalidSnapshot.NotFound: The specified snapshot was not found.
         * - Client.UserInitiatedHibernate: Hibernation was initiated on the instance.
         * - Client.UserInitiatedShutdown: The instance was shut down using the Amazon EC2 API.
         * - Client.VolumeLimitExceeded: The limit on the number of EBS volumes or total storage was
         *   exceeded. Decrease usage or request an increase in your account limits.
         * Type: String
         * Required: No
         */
        global String message;
    }

    /**
     * Describes a tag.
     * 
     * https://docs.aws.amazon.com/AWSEC2/latest/APIReference/API_Tag.html
     */
    global class Tag
    {
        /**
         * The key of the tag.
         * Constraints: Tag keys are case-sensitive and accept a maximum of 127 Unicode characters.
         * May not begin with aws:.
         * Type: String
         * Required: No
         */
        global String key;

        /**
         * The value of the tag.
         * Constraints: Tag values are case-sensitive and accept a maximum of 255 Unicode
         * characters.
         * Type: String
         * Required: No
         */
        global String value;
    }

    /**
     * Describes a parameter used to set up an EBS volume in a block device mapping.
     * 
     * https://docs.aws.amazon.com/AWSEC2/latest/APIReference/API_EbsInstanceBlockDevice.html
     */
    global class EbsInstanceBlockDevice
    {
        /**
         * The time stamp when the attachment initiated.
         * Type: Timestamp
         * Required: No
         */
        global Datetime attachTime;

        /**
         * Indicates whether the volume is deleted on instance termination.
         * Type: Boolean
         * Required: No
         */
        global Boolean deleteOnTermination;
        
        /**
         * The attachment state.
         * Type: String
         * Valid Values: attaching | attached | detaching | detached
         * Required: No
         */
        global String status;

        /**
         * The ID of the EBS volume.
         * Type: String
         * Required: No
         */
        global String volumeId;
    }

    /**
     * Describes association information for an Elastic IP address (IPv4).
     * 
     * https://docs.aws.amazon.com/AWSEC2/latest/APIReference/API_InstanceNetworkInterfaceAssociation.html
     */
    global class InstanceNetworkInterfaceAssociation
    {
        /**
         * The ID of the owner of the Elastic IP address.
         * Type: String
         * Required: No
         */
        global String ipOwnerId;

        /**
         * The global DNS name.
         * Type: String
         * Required: No
         */
        global String globalDnsName;

        /**
         * The global IP address or Elastic IP address bound to the network interface.
         * Type: String
         * Required: No
         */
        global String globalIp;
    }

    /**
     * Describes a network interface attachment.
     * 
     * https://docs.aws.amazon.com/AWSEC2/latest/APIReference/API_InstanceNetworkInterfaceAttachment.html
     */
    global class InstanceNetworkInterfaceAttachment
    {
        /**
         * The ID of the network interface attachment.
         * Type: String
         * Reqxuired: No
         */
        global String attachmentId;

        /**
         * The time stamp when the attachment initiated.
         * Type: Timestamp
         * Required: No
         */
        global Datetime attachTime;

        /**
         * Indicates whether the network interface is deleted when the instance is terminated.
         * Type: Boolean
         * Required: No
         */
        global Boolean deleteOnTermination;

        /**
         * The index of the device on the instance for the network interface attachment.
         * Type: Integer
         * Required: No
         */
        global Integer deviceIndex;

        /**
         * The attachment state.
         * Type: String
         * Valid Values: attaching | attached | detaching | detached
         * Required: No
         */
        global String status;
    }

    /**
     * Describes an IPv6 address.
     * 
     * https://docs.aws.amazon.com/AWSEC2/latest/APIReference/API_InstanceIpv6Address.html
     * https://docs.aws.amazon.com/AWSEC2/latest/APIReference/API_InstanceIpv6AddressRequest.html
     */
    global class InstanceIpv6Address
    {
        /**
         * The IPv6 address.
         * Type: String
         * Required: No
         */
        global String ipv6Address;
    }

    /**
     * Describes a private IPv4 address.
     * 
     * https://docs.aws.amazon.com/AWSEC2/latest/APIReference/API_InstancePrivateIpAddress.html
     */
    global class InstancePrivateIpAddress
    {
        /**
         * The association information for an Elastic IP address for the network interface.
         * Type: InstanceNetworkInterfaceAssociation object
         * Required: No
         */
        global InstanceNetworkInterfaceAssociation association;

        /**
         * Indicates whether this IPv4 address is the primary private IP address of the network interface.
         * Type: Boolean
         * Required: No
         */
        global Boolean primary;

        /**
         * The private IPv4 DNS name.
         * Type: String
         * Required: No
         */
        global String privateDnsName;

        /**
         * The private IPv4 address of the network interface.
         * Type: String
         * Required: No
         */
        global String privateIpAddress;
    }
    
    
}