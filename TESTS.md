# Testing IoP Message Protocol

In order to create a software that is compatible with IoP Message Protocol specification, we define the set of tests that the software must pass. If a software passes the given set of tests, it might be compatible with the protocol. If it does not pass all the tests, it is not compatible.

## Notation

  * `[X,Y,Z]` is an ordered array of three elements X, Y, and Z. Thus `[X,Y,Z] != [Y,Z,X]`.
  * `(X,Y,Z)` is a set of of three elements X, Y, and Z. Thus `(X,Y,Z) == (Y,Z,X)`.


## HomeNet Node Tests

The tests in this section are intended for testing of IoP HomeNet Node software. 

### HN00xxx - General Protocol Tests

#### HN00001 - Invalid Message Header 

##### Prerequisites/Inputs

###### Inputs:
  
  * Node's IP address
  * Node's primary port

##### Description 

The test sends a message to the node that does not represent a valid Protobuf message for IoP protocol.

###### Step 1:
The test connects to the primary port of the node ands sends binary data:

`46 84 21 46 87`

and reads the response.


##### Acceptance Criteria

###### Step 1:
Node replies with *Response*:

  * `Response.status == ERROR_PROTOCOL_VIOLATION`
  
and then the node closes the connection.




  
#### HN00002 - Invalid Message Body

##### Prerequisites/Inputs

###### Inputs:

  * Node's IP address
  * Node's primary port

##### Description 

The test sends a message to the node that does not represent a valid Protobuf message for IoP protocol.

###### Step 1:
The test connects to the primary port of the node and sends binary data:

`0D 04 00 00 00 FF FF FF FF`

and reads the response.



##### Acceptance Criteria

###### Step 1:
Node replies with *Response*:

  * `Response.status == ERROR_PROTOCOL_VIOLATION`

and then the node closes the connection.

  




#### HN00003 - Disconnection of Inactive TCP Client from Primary Port - No Message

##### Prerequisites/Inputs

###### Inputs:

  * Node's IP address
  * Node's primary port

##### Description 

The test connects to the node and does not send any message. This should be detected as an inactive connection by the node after a while.
 
###### Step 1:
The test connects to the primary port of the node and waits 500 seconds. The test then attempts to send *PingRequest*:

  * `Message.id := 1`
  * `SingleRequest.version := [1,0,0]`
  * `PingRequest.payload = "test"`

and reads the response.


##### Acceptance Criteria

###### Step 1:

Node disconnects the test and the attempt to send *PingRequest* or read the response fails.







#### HN00004 - Disconnection of Inactive TCP Client from Primary Port - Incomplete Header

##### Prerequisites/Inputs

###### Inputs:
  * Node's IP address
  * Node's primary port

##### Description 

The test sends incomplete message header to the node and waits. This should be detected as an inactive connection by the node after a while. 

###### Step 1:

The test connects to the primary port of the node and creates the following *PingRequest*:

  * `Message.id := 1`
  * `SingleRequest.version := [1,0,0]`
  * `PingRequest.payload = "test"`

but it only sends first 4 bytes of this message to the node and then it waits 500 seconds. Then it attempts to send the rest of the message and reads the response.


##### Acceptance Criteria

###### Step 1:

Node disconnects the test and this prevents the test to send the second part of the message or read a response.








#### HN00005 - Disconnection of Inactive TCP Client from Primary Port - Incomplete Message

##### Prerequisites/Inputs

###### Inputs:
  * Node's IP address
  * Node's primary port

##### Description 

The test sends an incomplete message body to the node and waits. This should be detected as an inactive connection by the node after a while.

###### Step 1:

The test connects to the primary port of the node and creates the following *PingRequest*:

  * `Message.id := 1`
  * `SingleRequest.version := [1,0,0]`
  * `PingRequest.payload = "test"`

but it only sends first 6 bytes of this message to the node and then it waits 500 seconds. Then it attempts to send the rest of the message and reads the response.


##### Acceptance Criteria

###### Step 1:

Node disconnects the test and this prevents the test to send the second part of the message or read a response.








#### HN00006 - Disconnection of Inactive TCP Client from Non-Customer Port - No Message

##### Prerequisites/Inputs

###### Inputs:
  * Node's IP address
  * Node's clNonCustomer port

##### Description 

The tests connects to the node and sends no message. This should be detected as an inactive connection by the node after a while.

###### Step 1:
The test creates a TLS connection to the clNonCustomer port of the node and waits 180 seconds. Then it sends *PingRequest*:

  * `Message.id := 1`
  * `SingleRequest.version := [1,0,0]`
  * `PingRequest.payload = "test"`

and reads the response.


##### Acceptance Criteria

###### Step 1:

Node disconnects the test and the attempt to send *PingRequest* or read the response fails.









#### HN00007 - Disconnection of Inactive TCP Client from Non-Customer Port - Incomplete Header

##### Prerequisites/Inputs

###### Inputs:
  * Node's IP address
  * Node's clNonCustomer port

##### Description 

The test sends incomplete message header to the node and waits. This should be detected as an inactive connection by the node after a while.

###### Step 1:
The test creates a TLS connection to the clNonCustomer port of the node and creates the following *PingRequest*:

  * `Message.id := 1`
  * `SingleRequest.version := [1,0,0]`
  * `PingRequest.payload = "test"`

but it only sends first 4 bytes of this message to the node and then it waits 180 seconds. Then it attempts to send the rest of the message and reads the response.


##### Acceptance Criteria

###### Step 1:

Node disconnects the test and this prevents the test to send the second part of the message or read a response.










#### HN00008 - Disconnection of Inactive TCP Client from Non-Customer Port - Incomplete Message

##### Prerequisites/Inputs

###### Inputs:
  * Node's IP address
  * Node's clNonCustomer port

##### Description 

The test sends an incomplete message body to the node and waits. This should be detected as an inactive connection by the node after a while.

###### Step 1:

The test creates a TLS connection to the clNonCustomer port of the node and creates the following *PingRequest*:

  * `Message.id := 1`
  * `SingleRequest.version := [1,0,0]`
  * `PingRequest.payload = "test"`

but it only sends first 6 bytes of this message to the node and then it waits 180 seconds. Then it attempts to send the rest of the message and reads the response.

##### Acceptance Criteria

###### Step 1:

Node disconnects the test and this prevents the test to send the second part of the message or read a response.






#### HN00009 - Disconnection of Inactive TCP Client from Non-Customer Port - No TLS Handshake

##### Prerequisites/Inputs

###### Inputs:
  * Node's IP address
  * Node's clNonCustomer port

##### Description 

The test connects to TLS encrypted port of the node and does not initiate TLS handshake and waits. This should be detected as an inactive connection by the node after a while.

###### Step 1:

The test creates a TCP connection to the clNonCustomer port and does not initiate TLS handshake. Then it waits 180 seconds. Then it attempts to initiate the TLS handshake.

##### Acceptance Criteria

###### Step 1:

Node disconnects the test before it attempts to initiate the TLS handshake and the test will then be unable to complete it.







#### HN00010 - Message Too Large

##### Prerequisites/Inputs

###### Inputs:
  * Node's IP address
  * Node's primary port

##### Description 

The test sends a message larger than the protocol's maximal message size limit of 1 MB.

###### Step 1:
The test connects to the primary port and sends *PingRequest*:

  * `Message.id := 1234`
  * `SingleRequest.version := [1,0,0]`
  * `PingRequest.payload` is set to a sequence of 1,048,576 times 'a'

and reads the response. Then it sends *PingRequest*:

  * `Message.id := 1`
  * `SingleRequest.version := [1,0,0]`
  * `PingRequest.payload := "Hello"`

and reads the response.


##### Acceptance Criteria

###### Step 1:

Node replies with *Response*:
  
  * `Response.status == ERROR_PROTOCOL_VIOLATION`

and then the node closes the connection, so that sending the second *PingRequest* or receiving a response to it fails.














### HN01xxx - Node Primary Port Functionality Tests

#### HN01001 - Primary Port Ping

##### Prerequisites/Inputs

###### Inputs:
  * Node's IP address
  * Node's primary port

##### Description 

The test sends a ping request to the node and expects to receive a ping response.

###### Step 1:
The test connects to the primary port of the node and sends *PingRequest*:

  * `Message.id := 1234`
  * `SingleRequest.version := [1,0,0]`
  * `PingRequest.payload := "Hello"`

and reads the response.

##### Acceptance Criteria

###### Step 1:
Node replies with *PingResponse*:
  
  * `Message.id == 1234`
  * `Response.status == STATUS_OK`
  * `PingResponse.payload == "Hello"`
  * `PingResponse.clock` does not differ more than 10 minutes from the test's machine clock.




#### HN01002 - Primary Port Ping - Invalid Version Format

##### Prerequisites/Inputs

###### Inputs:
  * Node's IP address
  * Node's primary port

##### Description 

The test sends a ping request with invalid protocol version. The version must be 3 bytes long, but the client sends 2 bytes only.

###### Step 1:
The test connects to the primary port of the node and sends *PingRequest*:

  * `Message.id := 1`
  * `SingleRequest.version := [1,0]`
  * `PingRequest.payload := "Hello"`

and reads the response. Then it sends *PingRequest*:

  * `Message.id := 2`
  * `SingleRequest.version := [1,0,0]`
  * `PingRequest.payload := "Hello"`

and reads the response.



##### Acceptance Criteria

###### Step 1:

Node replies with *Response*:
  
  * `Message.id == 1`
  * `Response.status == ERROR_PROTOCOL_VIOLATION`

and then the node closes the connection, so that sending the second *PingRequest* or receiving a response to it fails.










#### HN01003 - Primary Port Ping - Invalid Version Value

##### Prerequisites/Inputs

###### Inputs:
  * Node's IP address
  * Node's primary port

##### Description 

The test sends a ping request with invalid protocol version 0.0.0.

###### Step 1:
The test connects to the primary port of the node and sends *PingRequest*:

  * `Message.id := 1`
  * `SingleRequest.version := [0,0,0]`
  * `PingRequest.payload := "Hello"`

and reads the response. Then it sends *PingRequest*:

  * `Message.id := 2`
  * `SingleRequest.version := [1,0,0]`
  * `PingRequest.payload := "Hello"`

and reads the response.



##### Acceptance Criteria

###### Step 1:
Node replies with *Response*:
  
  * `Message.id == 1`
  * `Response.status == ERROR_PROTOCOL_VIOLATION`

and then the node closes the connection, so that sending the second *PingRequest* or receiving a response to it fails.








#### HN01004 - List Roles

##### Prerequisites/Inputs

###### Inputs:
  * Node's IP address
  * Node's primary port

##### Description 

The test requests list of node's roles.

###### Step 1:
The test connects to the primary port of the node and sends *ListRolesRequest*:

  * `Message.id := 1`
  * `SingleRequest.version := [1,0,0]`

and reads the response.

##### Acceptance Criteria

###### Step 1:
Node replies with *ListRolesResponse*:
  
  * `Message.id == 1`
  * `Response.status == STATUS_OK`
  * *ListRolesResponse.roles* contains 6 items, one for each role with following properties:
    * *PRIMARY* - `isTcp == true`, `isTls == false`
    * *ND_NEIGHBOR* - `isTcp == true`, `isTls == false`
    * *ND_COLLEAGUE* - `isTcp == true`, `isTls == false`
    * *CL_NON_CUSTOMER* - `isTcp == true`, `isTls == true`
    * *CL_CUSTOMER* - `isTcp == true`, `isTls == true`
    * *CL_APP_SERVICE* - `isTcp == true`, `isTls == true`
  * Intersection of the set of port numbers of *primary*, *ndNeighbor*, and *ndColleague* roles and the set of port numbers of *clNonCustomer*, *clCustomer*, and *clAppService* roles must be empty (i.e. no client only role is served on the same port as a node role; this also means that no port is used for both TLS and non-TLS service).







#### HN01005 - Home Node Request - Bad Role

##### Prerequisites/Inputs

###### Inputs:
  * Node's IP address
  * Node's primary port

##### Description 

The test sends home node request to the primary port, but *HomeNodeRequestRequest* requires clNonCustomer port to be used.

###### Step 1:

The test connects to the primary port of the node and sends *StartConversationRequest*:

  * `Message.id := 1`
  * `StartConversationRequest.supportedVersions := [[1,0,0]]`
  * `StartConversationRequest.publicKey` set to the test identity's 32 byte long public key
  * `StartConversationRequest.clientChallenge` set to 32 byte random challenge; `$ClientChallenge := StartConversationRequest.clientChallenge`
 
and reads the response. Then it sends *HomeNodeRequestRequest*:

  * `Message.id := 2`
  * `HomeNodeRequestRequest.contract` is uninitialized

and reads the response.


##### Acceptance Criteria

###### Step 1:

Node replies with *StartConversationResponse*:
  
  * `Message.id == 1`
  * `Response.status == STATUS_OK`
  * `ConversationResponse.signature` is a valid signature of $ClientChallenge
  * `StartConversationResponse.clientChallenge == $ClientChallenge`

Node replies with *Response*:
  
  * `Message.id == 2`
  * `Response.status == ERROR_BAD_ROLE`







#### HN01006 - Check-In - Bad Role

##### Prerequisites/Inputs

###### Inputs:
  * Node's IP address
  * Node's primary port

##### Description 

The test sends check-in request to the primary port, but *CheckInRequest* requires clCustomer port to be used.

###### Step 1:

The test connects to the primary port of the node and sends *StartConversationRequest*:

  * `Message.id := 1`
  * `StartConversationRequest.supportedVersions := [[1,0,0]]`
  * `StartConversationRequest.publicKey` set to the test identity's 32 byte long public key
  * `StartConversationRequest.clientChallenge` set to 32 byte random challenge; `$ClientChallenge := StartConversationRequest.clientChallenge`
 
and reads the response from the node in form of *StartConversationResponse*:

  * `$Challenge := StartConversationResponse.challenge`

Then it sends *CheckInRequest*:

  * `Message.id := 2`
  * `CheckInRequest.challenge := $Challenge`
  * `ConversationRequest.signature` is set to a signature of `CheckInRequest` part of the message using the test's identity private key
  
and reads the response.


##### Acceptance Criteria

###### Step 1:

Node replies with *StartConversationResponse*:
  
  * `Message.id == 1`
  * `Response.status == STATUS_OK`
  * `ConversationResponse.signature` is a valid signature of $ClientChallenge
  * `StartConversationResponse.clientChallenge == $ClientChallenge`

Node replies with *Response*:
  
  * `Message.id == 2`
  * `Response.status == ERROR_BAD_ROLE`






#### HN01007 - Verify Identity - Bad Role

##### Prerequisites/Inputs

###### Inputs:
  * Node's IP address
  * Node's primary port

##### Description 

The test sends verify identity request to the primary port, but *VerifyIdentityRequest* requires clNonCustomer port to be used.

###### Step 1:

The test connects to the primary port of the node and sends *StartConversationRequest*:

  * `Message.id := 1`
  * `StartConversationRequest.supportedVersions := [[1,0,0]]`
  * `StartConversationRequest.publicKey` set to the test identity's 32 byte long public key
  * `StartConversationRequest.clientChallenge` set to 32 byte random challenge; `$ClientChallenge := StartConversationRequest.clientChallenge`
 
and reads the response from the node in form of *StartConversationResponse*:

  * `$Challenge := StartConversationResponse.challenge`

Then it sends *VerifyIdentityRequest*:

  * `Message.id := 2`
  * `VerifyIdentityRequest.challenge := $Challenge`
  * `ConversationRequest.signature` is set to a signature of `VerifyIdentityRequest` part of the message using the test's identity private key
  
and reads the response.


##### Acceptance Criteria

###### Step 1:

Node replies with *StartConversationResponse*:
  
  * `Message.id == 1`
  * `Response.status == STATUS_OK`
  * `ConversationResponse.signature` is a valid signature of $ClientChallenge
  * `StartConversationResponse.clientChallenge == $ClientChallenge`

Node replies with *Response*:
  
  * `Message.id == 2`
  * `Response.status == ERROR_BAD_ROLE`








#### HN01008 - Get Identity Information - Bad Role

##### Prerequisites/Inputs

###### Inputs:
  * Node's IP address
  * Node's primary port

##### Description 

The test sends *GetIdentityInformationRequest* to the primary port, but it requires clNonCustomer or clCustomer port to be used.

###### Step 1:

The test connects to the primary port of the node and sends *GetIdentityInformationRequest*:

  * `Message.id := 1`
  * `SingleRequest.version := [1,0,0]`
  * `GetIdentityInformationRequest.identityNetworkId` is set to SHA256 of test's identity public key
  * `GetIdentityInformationRequest.includeProfileImage := false`
  * `GetIdentityInformationRequest.includeThumbnailImage := false`
  * `GetIdentityInformationRequest.includeApplicationServices := false`
 
and reads the response.


##### Acceptance Criteria

###### Step 1:

Node replies with *Response*:
  
  * `Message.id == 1`
  * `Response.status == ERROR_BAD_ROLE`








#### HN01009 - Call Identity Application Service - Bad Role

##### Prerequisites/Inputs

###### Inputs:
  * Node's IP address
  * Node's primary port

##### Description 

The test sends *CallIdentityApplicationServiceRequest* to the primary port, but it requires clNonCustomer or clCustomer port to be used.

###### Step 1:

The test connects to the primary port of the node and sends *CallIdentityApplicationServiceRequest*:

  * `Message.id := 1`
  * `CallIdentityApplicationServiceRequest.identityNetworkId := SHA256("test")`
  * `CallIdentityApplicationServiceRequest.serviceName := "Test Service"`
 
and reads the response.


##### Acceptance Criteria

###### Step 1:

Node replies with *Response*:
  
  * `Message.id == 1`
  * `Response.status == ERROR_BAD_ROLE`







#### HN01010 - Incoming Call Notification - Protocol Violation

##### Prerequisites/Inputs

###### Inputs:
  * Node's IP address
  * Node's primary port

##### Description 

The test sends *IncomingCallNotificationRequest* to the primary port, which is violation of the protocol.

###### Step 1:

The test connects to the primary port of the node and sends *IncomingCallNotificationRequest*:

  * `Message.id := 1`
  * `IncomingCallNotificationRequest.callerPublicKey` is set to the test's identity public key
  * `IncomingCallNotificationRequest.serviceName := "Test Service"`
  * `IncomingCallNotificationRequest.calleeToken := SHA256("test")`

 
and reads the response. Then it sends *PingRequest*:

  * `Message.id := 2`
  * `SingleRequest.version := [1,0,0]`
  * `PingRequest.payload := "Hello"`

and reads the response.



##### Acceptance Criteria

###### Step 1:

Node replies with *Response*:
  
  * `Message.id == 1`
  * `Response.status == ERROR_PROTOCOL_VIOLATION`

and then the node closes the connection, so that sending the second *PingRequest* or receiving a response to it fails.






#### HN01011 - Application Service Send Message - Bad Role

##### Prerequisites/Inputs

###### Inputs:
  * Node's IP address
  * Node's primary port

##### Description 

The test sends *ApplicationServiceSendMessageRequest* to the primary port, but it requires clAppService port to be used.

###### Step 1:

The test connects to the primary port of the node and sends *ApplicationServiceSendMessageRequest*:

  * `Message.id := 1`
  * `ApplicationServiceSendMessageRequest.token := SHA256("test")`
  * `ApplicationServiceSendMessageRequest.message := "Test message"`
 
and reads the response.


##### Acceptance Criteria

###### Step 1:

Node replies with *Response*:
  
  * `Message.id == 1`
  * `Response.status == ERROR_BAD_ROLE`








#### HN01012 - Application Service Receive Message Notification - Protocol Violation

##### Prerequisites/Inputs

###### Inputs:
  * Node's IP address
  * Node's primary port

##### Description 

The test sends *ApplicationServiceReceiveMessageNotificationRequest* to the primary port, which is violation of the protocol.

###### Step 1:

The test connects to the primary port of the node and sends *ApplicationServiceReceiveMessageNotificationRequest*:

  * `Message.id := 1`
  * `ApplicationServiceReceiveMessageNotificationRequest.message := "Test message"`

 
and reads the response. Then it sends *PingRequest*:

  * `Message.id := 2`
  * `SingleRequest.version := [1,0,0]`
  * `PingRequest.payload := "Hello"`

and reads the response.



##### Acceptance Criteria

###### Step 1:

Node replies with *Response*:
  
  * `Message.id == 1`
  * `Response.status == ERROR_PROTOCOL_VIOLATION`

and then the node closes the connection, so that sending the second *PingRequest* or receiving a response to it fails.









#### HN01013 - Application Service Receive Message Notification Response - Bad Role

##### Prerequisites/Inputs

###### Inputs:
  * Node's IP address
  * Node's primary port

##### Description 

The test sends *ApplicationServiceReceiveMessageNotificationResponse* to the primary port, which is violation of the protocol.

###### Step 1:

The test connects to the primary port of the node and sends *ApplicationServiceReceiveMessageNotificationResponse*:

  * `Message.id := 1`


and reads the response. Then it sends *PingRequest*:

  * `Message.id := 2`
  * `SingleRequest.version := [1,0,0]`
  * `PingRequest.payload := "Hello"`

and reads the response.



##### Acceptance Criteria

###### Step 1:

The node closes the connection, so that sending the second *PingRequest* or receiving a response to it fails.








#### HN01014 - Profile Stats - Bad Role

##### Prerequisites/Inputs

###### Inputs:
  * Node's IP address
  * Node's primary port

##### Description 

The test sends *ProfileStatsRequest* to the primary port, but it requires clNonCustomer or clCustomer port to be used.

###### Step 1:

The test connects to the primary port of the node and sends *ProfileStatsRequest*:

  * `Message.id := 1`
  * `SingleRequest.version := [1,0,0]`
 
and reads the response.


##### Acceptance Criteria

###### Step 1:

Node replies with *Response*:
  
  * `Message.id == 1`
  * `Response.status == ERROR_BAD_ROLE`





#### HN01015 - Profile Search - Bad Role

##### Prerequisites/Inputs

###### Inputs:
  * Node's IP address
  * Node's primary port

##### Description 

The test sends *ProfileSearchRequest* to the primary port, but it requires clNonCustomer or clCustomer port to be used.

###### Step 1:

The test connects to the primary port of the node and sends *ProfileSearchRequest*:

  * `Message.id := 1`
  * `ProfileSearchRequest.includeHostedOnly := false`
  * `ProfileSearchRequest.includeThumbnailImages := true`
  * `ProfileSearchRequest.maxResponseRecordCount := 100`
  * `ProfileSearchRequest.maxTotalRecordCount := 1000`
  * `ProfileSearchRequest.type := ""`
  * `ProfileSearchRequest.name := ""`
  * `ProfileSearchRequest.latitude := NO_LOCATION`
  * `ProfileSearchRequest.longitude := NO_LOCATION`
  * `ProfileSearchRequest.radius := 0`
  * `ProfileSearchRequest.extraData := ""`

and reads the response.


##### Acceptance Criteria

###### Step 1:

Node replies with *Response*:
  
  * `Message.id == 1`
  * `Response.status == ERROR_BAD_ROLE`





#### HN01016 - Profile Search Part - Bad Role

##### Prerequisites/Inputs

###### Inputs:
  * Node's IP address
  * Node's primary port

##### Description 

The test sends *ProfileSearchPartRequest* to the primary port, but it requires clNonCustomer or clCustomer port to be used.

###### Step 1:

The test connects to the primary port of the node and sends *ProfileSearchPartRequest*:

  * `Message.id := 1`
  * `ProfileSearchPartRequest.recordIndex := 0`
  * `ProfileSearchPartRequest.recordCount := 10`
 
and reads the response.


##### Acceptance Criteria

###### Step 1:

Node replies with *Response*:
  
  * `Message.id == 1`
  * `Response.status == ERROR_BAD_ROLE`







#### HN01017 - Add Related Identity - Bad Role

##### Prerequisites/Inputs

###### Inputs:
  * Node's IP address
  * Node's primary port

##### Description 

The test sends *AddRelatedIdentityRequest* to the primary port, but it requires clCustomer port to be used.

###### Step 1:

The test connects to the primary port of the node and sends *AddRelatedIdentityRequest*:

  * `Message.id := 1`
  * `AddRelatedIdentityRequest.cardApplication` is uninitialized
  * `AddRelatedIdentityRequest.signedCard` is uninitialized
 
and reads the response.


##### Acceptance Criteria

###### Step 1:

Node replies with *Response*:
  
  * `Message.id == 1`
  * `Response.status == ERROR_BAD_ROLE`





#### HN01018 - Remove Related Identity - Bad Role

##### Prerequisites/Inputs

###### Inputs:
  * Node's IP address
  * Node's primary port

##### Description 

The test sends *RemoveRelatedIdentityRequest* to the primary port, but it requires clCustomer port to be used.

###### Step 1:

The test connects to the primary port of the node and sends *RemoveRelatedIdentityRequest*:

  * `Message.id := 1`
  * `RemoveRelatedIdentityRequest.applicationId` is uninitialized
 
and reads the response.


##### Acceptance Criteria

###### Step 1:

Node replies with *Response*:
  
  * `Message.id == 1`
  * `Response.status == ERROR_BAD_ROLE`











### HN02xxx - Node Client Non-Customer Port Functionality Tests

#### HN02001 - Client Non-Customer Port Ping

##### Prerequisites/Inputs

###### Inputs:
  * Node's IP address
  * Node's clNonCustomer port

##### Description 
The test sends a ping request to the node and expects to receive a ping response.

###### Step 1:

The test establishes a TLS connection to the clNonCustomer port of the node and sends *PingRequest*:

  * `Message.id := 1`
  * `SingleRequest.version := [1,0,0]`
  * `PingRequest.payload := "Hello"`

and reads the response.

##### Acceptance Criteria

###### Step 1:

Node replies with *PingResponse*:
  
  * `Message.id == 1`
  * `Response.status == STATUS_OK`
  * `PingResponse.payload == "Hello"`
  * `PingResponse.clock` does not differ more than 10 minutes from the test's machine clock.









#### HN02002 - Invalid Role Request - List Roles

##### Prerequisites/Inputs

###### Inputs:
  * Node's IP address
  * Node's clNonCustomer port

##### Description 

The test requests a list of node's roles on its clNonCustomer port, but *ListRolesRequest* request requires the primary port to be used.

###### Step 1:

The test establishes a TLS connection to the clNonCustomer port of the node and sends *ListRolesRequest*:

  * `Message.id := 1`
  * `SingleRequest.version := [1,0,0]`
  
and reads the response.


##### Acceptance Criteria

###### Step 1:
Node replies with *Response*:
  
  * `Message.id == 1`
  * `Response.status == ERROR_BAD_ROLE`







#### HN02003 - Start Conversation

##### Prerequisites/Inputs

###### Inputs:
  * Node's IP address
  * Node's clNonCustomer port

##### Description 

The test starts conversation with the node.

###### Step 1:
The test establishes a TLS connection to the clNonCustomer port of the node and sends *StartConversationRequest*:

  * `Message.id := 1`
  * `StartConversationRequest.supportedVersions := [[1,0,0]]`
  * `StartConversationRequest.publicKey` set to the test identity's 32 byte long public key
  * `StartConversationRequest.clientChallenge` set to 32 byte random challenge; `$ClientChallenge := StartConversationRequest.clientChallenge`

and reads the response
  
##### Acceptance Criteria

###### Step 1:
Node replies with *StartConversationResponse*:
  
  * `Message.id == 1`
  * `Response.status == STATUS_OK`
  * `ConversationResponse.signature` is a valid signature of $ClientChallenge
  * `StartConversationResponse.version == [1,0,0]`
  * `StartConversationResponse.publicKey.Length == 32`
  * `StartConversationResponse.challenge.Length == 32`
  * `StartConversationResponse.clientChallenge == $ClientChallenge`












#### HN02004 - Start Conversation - Unsupported Version

##### Prerequisites/Inputs

###### Inputs:
  * Node's IP address
  * Node's clNonCustomer port

##### Description 

The test starts the conversation with the node but no version of the protocol is supported by both sides.

###### Step 1:

The test establishes a TLS connection to the clNonCustomer port of the node and sends *StartConversationRequest*:

  * `Message.id := 1`
  * `StartConversationRequest.supportedVersions := [[255,255,255], [255,255,254]]`
  * `StartConversationRequest.publicKey` set to the test identity's 32 byte long public key
  * `StartConversationRequest.clientChallenge` set to 32 byte random challenge
  
and reads the response.
  
##### Acceptance Criteria

###### Step 1:
Node replies with *Response*:
  
  * `Message.id == 1`
  * `Response.status == ERROR_UNSUPPORTED`







#### HN02005 - Home Node Request

##### Prerequisites/Inputs

###### Prerequisites:
  * Node's database is empty.

###### Inputs:
  * Node's IP address
  * Node's clNonCustomer port

##### Description 

The test identity establishes a home node agreement with the node. Note that the home node contract is empty at this stage.

###### Step 1:
The test establishes a TLS connection to the clNonCustomer port of the node and sends *StartConversationRequest*:

  * `Message.id := 1`
  * `StartConversationRequest.supportedVersions := [[1,0,0]]`
  * `StartConversationRequest.publicKey` set to the test identity's 32 byte long public key
  * `StartConversationRequest.clientChallenge` set to 32 byte random challenge; `$ClientChallenge := StartConversationRequest.clientChallenge`
  
and reads the response. Then it sends *HomeNodeRequestRequest*:

  * `Message.id := 2`
  * `HomeNodeRequestRequest.contract` is uninitialized

and reads the response.

  
##### Acceptance Criteria

###### Step 1:
Node replies with *StartConversationResponse*:
  
  * `Message.id == 1`
  * `Response.status == STATUS_OK`
  * `ConversationResponse.signature` is a valid signature of $ClientChallenge
  * `StartConversationResponse.version == [1,0,0]`
  * `StartConversationResponse.publicKey.Length == 32`
  * `StartConversationResponse.challenge.Length == 32`
  * `StartConversationResponse.clientChallenge == $ClientChallenge`

Node replies with *HomeNodeRequestResponse*:

  * `Message.id == 2`
  * `Response.status == STATUS_OK`








#### HN02006 - Home Node Request - Bad Conversation Status

##### Prerequisites/Inputs

###### Inputs:
  * Node's IP address
  * Node's clNonCustomer port

##### Description 

The test sends *HomeNodeRequestRequest* to the node without starting the conversation first.

###### Step 1:
The test establishes a TLS connection to the clNonCustomer port of the node and sends *HomeNodeRequestRequest*:

  * `Message.id := 1`
  * `HomeNodeRequestRequest.contract` is uninitialized
  
and reads the response.
  
##### Acceptance Criteria

###### Step 1:
Node replies with *Response*:
  
  * `Message.id == 1`
  * `Response.status == ERROR_BAD_CONVERSATION_STATUS`







#### HN02007 - Home Node Request - Quota Exceeded

##### Prerequisites/Inputs

###### Prerequisites:
  * Node is configured to host 1 identity at maximum.
  * Node's database is empty.

###### Inputs:
  * Node's IP address
  * Node's clNonCustomer port

##### Description 

The test identity #1 establishes a home node agreement with the node. Then the test tries to establish a home node agreement for its identity #2, which should fail due to the node's quota.

###### Step 1:
The test establishes a TLS connection to the clNonCustomer port of the node and sends *StartConversationRequest*:

  * `Message.id := 1`
  * `StartConversationRequest.supportedVersions := [[1,0,0]]`
  * `StartConversationRequest.publicKey` set to the test's identity #1 32 byte long public key
  * `StartConversationRequest.clientChallenge` set to 32 byte random challenge; `$ClientChallenge1 := StartConversationRequest.clientChallenge`
  
and reads the response. Then it sends *HomeNodeRequestRequest*:

  * `Message.id := 2`
  * `HomeNodeRequestRequest.contract` is uninitialized
  
and reads the response.
  
###### Step 2:
The test then closes the connection and creates a new TLS connection to the clNonCustomer port and sends *StartConversationRequest*:

  * `Message.id := 1`
  * `StartConversationRequest.supportedVersions := [[1,0,0]]`
  * `StartConversationRequest.publicKey` set to the test's identity #2 32 byte long public key
  * `StartConversationRequest.clientChallenge` set to 32 byte random challenge; `$ClientChallenge2 := StartConversationRequest.clientChallenge`

and reads the response. Then it sends *HomeNodeRequestRequest*:

  * `Message.id := 2`
  * `HomeNodeRequestRequest.contract` is uninitialized

and reads the response.
  
##### Acceptance Criteria


###### Step 1:

Node replies with *StartConversationResponse*:

  * `Message.id == 1`
  * `Response.status == STATUS_OK`
  * `ConversationResponse.signature` is a valid signature of $ClientChallenge1
  * `StartConversationResponse.clientChallenge == $ClientChallenge1`


Node replies with *HomeNodeRequestResponse*:

  * `Message.id == 2`
  * `Response.status == STATUS_OK`


###### Step 2:
Node replies with *StartConversationResponse*:

  * `Message.id == 1`
  * `Response.status == STATUS_OK`
  * `ConversationResponse.signature` is a valid signature of $ClientChallenge2
  * `StartConversationResponse.clientChallenge == $ClientChallenge2`

Node replies with *Response*:

  * `Message.id == 2`
  * `Response.status == ERROR_QUOTA_EXCEEDED`












#### HN02008 - Home Node Request - Already Exists

##### Prerequisites/Inputs

###### Prerequisites:
  * Node's database is empty.

###### Inputs:
  * Node's IP address
  * Node's clNonCustomer port

##### Description 

The test establishes a home node agreement with the node. Then it tries to establish a new agreement with the same identity, which should fail.

###### Step 1:
The test establishes a TLS connection to the clNonCustomer port of the node and sends *StartConversationRequest*:

  * `Message.id := 1`
  * `StartConversationRequest.supportedVersions := [[1,0,0]]`
  * `StartConversationRequest.publicKey` set to the test's identity 32 byte long public key
  * `StartConversationRequest.clientChallenge` set to 32 byte random challenge; `$ClientChallenge1 := StartConversationRequest.clientChallenge`
  
and reads the response. Then it sends *HomeNodeRequestRequest*:

  * `Message.id := 2`
  * `HomeNodeRequestRequest.contract` is uninitialized

and reads the response.
 
###### Step 2:
The test then closes the connection and creates a new TLS connection to the clNonCustomer port and sends *StartConversationRequest*:

  * `Message.id := 1`
  * `StartConversationRequest.supportedVersions := [[1,0,0]]`
  * `StartConversationRequest.publicKey` set to the test's identity 32 byte long public key
  * `StartConversationRequest.clientChallenge` set to 32 byte random challenge; `$ClientChallenge2 := StartConversationRequest.clientChallenge`

and reads the response. Then it sends *HomeNodeRequestRequest*:

  * `Message.id := 2`
  * `HomeNodeRequestRequest.contract` is uninitialized

and reads the response.

##### Acceptance Criteria


###### Step 1:
Node replies with *StartConversationResponse*:

  * `Message.id == 1`
  * `Response.status == STATUS_OK`
  * `ConversationResponse.signature` is a valid signature of $ClientChallenge1
  * `StartConversationResponse.clientChallenge == $ClientChallenge1`

Node replies with *HomeNodeRequestResponse*:

  * `Message.id == 2`
  * `Response.status == STATUS_OK`


###### Step 2:
Node replies with *StartConversationResponse*:

  * `Message.id == 1`
  * `Response.status == STATUS_OK`
  * `ConversationResponse.signature` is a valid signature of $ClientChallenge2
  * `StartConversationResponse.clientChallenge == $ClientChallenge2`
                                                                  
Node replies with *Response*:

  * `Message.id == 2`
  * `Response.status == ERROR_ALREADY_EXISTS`








#### HN02009 - Verify Identity

##### Prerequisites/Inputs

###### Inputs:
  * Node's IP address
  * Node's clNonCustomer

##### Description 

The test establishes a conversation with the node and verifies its public key by signing a challenge.

###### Step 1:
The test establishes a TLS connection to the clNonCustomer port of the node and sends *StartConversationRequest*:

  * `Message.id := 1`
  * `StartConversationRequest.supportedVersions := [[1,0,0]]`
  * `StartConversationRequest.publicKey` set to the test's identity 32 byte long public key
  * `StartConversationRequest.clientChallenge` set to 32 byte random challenge; `$ClientChallenge := StartConversationRequest.clientChallenge`
  
and reads the response from the node in form of *StartConversationResponse*:

  * `$Challenge := StartConversationResponse.challenge`

Then it sends *VerifyIdentityRequest*:

  * `Message.id := 2`
  * `VerifyIdentityRequest.challenge := $Challenge`
  * `ConversationRequest.signature` is set to a signature of `VerifyIdentityRequest` part of the message using the test's identity private key
  
and reads the response.

  
##### Acceptance Criteria


###### Step 1:
Node replies with *StartConversationResponse*:

  * `Message.id == 1`
  * `Response.status == STATUS_OK`
  * `ConversationResponse.signature` is a valid signature of $ClientChallenge
  * `StartConversationResponse.clientChallenge == $ClientChallenge`

Node replies with *VerifyIdentityResponse*:

  * `Message.id == 2`
  * `Response.status == STATUS_OK`








#### HN02010 - Verify Identity - Invalid Signature

##### Prerequisites/Inputs

###### Inputs:
  * Node's IP address
  * Node's clNonCustomer

##### Description 

The test establishes a conversation with the node and tries to verify its public key by signing a challenge, but it provides invalid signature.

###### Step 1:
The test establishes a TLS connection to the clCustomer port of the node and sends *StartConversationRequest*:

  * `Message.id := 1`
  * `StartConversationRequest.supportedVersions := [[1,0,0]]`
  * `StartConversationRequest.publicKey` set to the test's identity 32 byte long public key
  * `StartConversationRequest.clientChallenge` set to 32 byte random challenge; `$ClientChallenge := StartConversationRequest.clientChallenge`
  
and reads the response from the node in form of *StartConversationResponse*:
  
  * `$Challenge := StartConversationResponse.challenge`

Then it sends *VerifyIdentityRequest*:

  * `Message.id := 2`
  * `VerifyIdentityRequest.challenge := $Challenge`
  * `ConversationRequest.signature` is set to a signature of `VerifyIdentityRequest` part of the message using the test's identity private key, but the first byte of the signature is XORed with 0x12 to make the signature invalid.
  
and reads the response.

  
##### Acceptance Criteria


###### Step 1:
Node replies with *StartConversationResponse*:

  * `Message.id == 1`
  * `Response.status == STATUS_OK`
  * `ConversationResponse.signature` is a valid signature of $ClientChallenge
  * `StartConversationResponse.clientChallenge == $ClientChallenge`


Node replies with *Response*:

  * `Message.id == 2`
  * `Response.status == ERROR_INVALID_SIGNATURE`







#### HN02011 - Verify Identity - Invalid Challenge

##### Prerequisites/Inputs

###### Prerequisites:
  * Node's database is empty.
  
###### Inputs:
  * Node's IP address
  * Node's clNonCustomer

##### Description 

The test establishes a conversation with the node and tries to verify its public key by signing a challenge, but it provides invalid challenge.

###### Step 1:
The test establishes a TLS connection to the clCustomer port of the node and sends *StartConversationRequest*:

  * `Message.id := 1`
  * `StartConversationRequest.supportedVersions := [[1,0,0]]`
  * `StartConversationRequest.publicKey` set to the test's identity 32 byte long public key
  * `StartConversationRequest.clientChallenge` set to 32 byte random challenge; `$ClientChallenge := StartConversationRequest.clientChallenge`
  
and reads the response from the node in form of *StartConversationResponse*:
  
  * `$Challenge := StartConversationResponse.challenge`

Then it sends *VerifyIdentityRequest*:

  * `Message.id := 2`
  * `VerifyIdentityRequest.challenge := $Challenge`, but the first byte of the challenge is XORed with 0x12 to make the challenge invalid
  * `ConversationRequest.signature` is set to a signature of `VerifyIdentityRequest` part of the message using the test's identity private key
  
and reads the response.

  
##### Acceptance Criteria


###### Step 1:
Node replies with *StartConversationResponse*:

  * `Message.id == 1`
  * `Response.status == STATUS_OK`
  * `ConversationResponse.signature` is a valid signature of $ClientChallenge
  * `StartConversationResponse.clientChallenge == $ClientChallenge`


Node replies with *Response*:

  * `Message.id == 2`
  * `Response.status == ERROR_INVALID_VALUE`
  * `Response.details == "challenge"`








#### HN02012 - Verify Identity - Bad Conversation Status

##### Prerequisites/Inputs

###### Inputs:
  * Node's IP address
  * Node's clNonCustomer port

##### Description 

The test sends verify identity request to the node without starting the conversation first.

###### Step 1:
The test establishes a TLS connection to the clNonCustomer port of the node and sends *VerifyIdentityRequest*:

  * `Message.id := 1`
  * `VerifyIdentityRequest.challenge` is uninitialized
  
and reads the response.
  
##### Acceptance Criteria

###### Step 1:
Node replies with *Response*:
  
  * `Message.id == 1`
  * `Response.status == ERROR_BAD_CONVERSATION_STATUS`








#### HN02013 - Parallel Verify Identity Requests

##### Prerequisites/Inputs
###### Inputs:
  * Node's IP address
  * Node's clNonCustomer port

##### Description 

The test verifies its identity and then it verifies its identity again in a second parallel connection. Then it verifies that the first connection is still active by sending a ping.

###### Step 1:
The test establishes a TLS connection to the clNonCustomer port of the node and sends *StartConversationRequest*:

  * `Message.id := 1`
  * `StartConversationRequest.supportedVersions := [[1,0,0]]`
  * `StartConversationRequest.publicKey` set to the test's identity 32 byte long public key
  * `StartConversationRequest.clientChallenge` set to 32 byte random challenge; `$ClientChallenge1 := StartConversationRequest.clientChallenge`

and reads the response from the node in form of *StartConversationResponse*:

  * `$Challenge := StartConversationResponse.challenge`

Then it sends *VerifyIdentityRequest*:

  * `Message.id := 2`
  * `VerifyIdentityRequest.challenge := $Challenge`
  * `ConversationRequest.signature` is set to a signature of `VerifyIdentityRequest` part of the message using the test's identity private key
  
and reads the response.

###### Step 2:
With the first connection left open, the test establishes a new TLS connection to the clNonCustomer port of the node and sends *StartConversationRequest*:

  * `Message.id := 1`
  * `StartConversationRequest.supportedVersions := [[1,0,0]]`
  * `StartConversationRequest.publicKey` set to the test's identity 32 byte long public key
  * `StartConversationRequest.clientChallenge` set to 32 byte random challenge; `$ClientChallenge2 := StartConversationRequest.clientChallenge`

and reads the response from the node in form of *StartConversationResponse*:

  * `$Challenge := StartConversationResponse.challenge`

Then it sends *VerifyIdentityRequest*:

  * `Message.id := 2`
  * `VerifyIdentityRequest.challenge := $Challenge`
  * `ConversationRequest.signature` is set to a signature of `VerifyIdentityRequest` part of the message using the test's identity private key
  
and reads the response.

###### Step 3:

Using the first connection the test attempts to send *PingRequest*:

  * `Message.id := 3`
  * `SingleRequest.version := [1,0,0]`
  * `PingRequest.payload = "test"`
  
and reads the response.


##### Acceptance Criteria


###### Step 1:
Node replies with *StartConversationResponse*:

  * `Message.id == 1`
  * `Response.status == STATUS_OK`
  * `ConversationResponse.signature` is a valid signature of $ClientChallenge1
  * `StartConversationResponse.clientChallenge == $ClientChallenge1`

Node replies with *VerifyIdentityResponse*:

  * `Message.id == 2`
  * `Response.status == STATUS_OK`


###### Step 2:
Node replies with *StartConversationResponse*:

  * `Message.id == 1`
  * `Response.status == STATUS_OK`
  * `ConversationResponse.signature` is a valid signature of $ClientChallenge2
  * `StartConversationResponse.clientChallenge == $ClientChallenge2`

Node replies with *VerifyIdentityResponse*:

  * `Message.id == 2`
  * `Response.status == STATUS_OK`

###### Step 3:

Node replies with *PingResponse*:
  
  * `Message.id == 3`
  * `Response.status == STATUS_OK`
  * `PingResponse.payload == "test"`










#### HN02014 - Check-In - Bad Role

##### Prerequisites/Inputs

###### Prerequisites:
  * Node's clNonCustomer port != clCustomer port

###### Inputs:
  * Node's IP address
  * Node's clNonCustomer port

##### Description 

The test sends check-in request to the clNonCustomer port, but *CheckInRequest* requires clCustomer port to be used.

###### Step 1:

The test connects to the primary port of the node and sends *StartConversationRequest*:

  * `Message.id := 1`
  * `StartConversationRequest.supportedVersions := [[1,0,0]]`
  * `StartConversationRequest.publicKey` set to the test identity's 32 byte long public key
  * `StartConversationRequest.clientChallenge` set to 32 byte random challenge; `$ClientChallenge := StartConversationRequest.clientChallenge`
 
and reads the response from the node in form of *StartConversationResponse*:

  * `$Challenge := StartConversationResponse.challenge`

Then it sends *CheckInRequest*:

  * `Message.id := 2`
  * `CheckInRequest.challenge := $Challenge`
  * `ConversationRequest.signature` is set to a signature of `CheckInRequest` part of the message using the test's identity private key
  
and reads the response.


##### Acceptance Criteria

###### Step 1:

Node replies with *StartConversationResponse*:

  * `Message.id == 1`
  * `Response.status == STATUS_OK`
  * `ConversationResponse.signature` is a valid signature of $ClientChallenge
  * `StartConversationResponse.clientChallenge == $ClientChallenge`

Node replies with *Response*:
  
  * `Message.id == 2`
  * `Response.status == ERROR_BAD_ROLE`








#### HN02015 - Get Identity Information - Uninitialized

##### Prerequisites/Inputs

###### Prerequisites:
  * Node's database is empty.

###### Inputs:
  * Node's IP address
  * Node's clNonCustomer port

##### Description 

The test establishes a home node agreement with the node and attempts to query its details, which should fail as the new profile is not initialized yet.

###### Step 1:
The test establishes a TLS connection to the clNonCustomer port of the node and sends *StartConversationRequest*:

  * `Message.id := 1`
  * `StartConversationRequest.supportedVersions := [[1,0,0]]`
  * `StartConversationRequest.publicKey` set to the test's identity 32 byte long public key
  * `StartConversationRequest.clientChallenge` set to 32 byte random challenge; `$ClientChallenge := StartConversationRequest.clientChallenge`
  
and reads the response from the node in form of *StartConversationResponse*:

  * `$Challenge := StartConversationResponse.challenge`

Then it sends *HomeNodeRequestRequest*:

  * `Message.id := 2`
  * `HomeNodeRequestRequest.contract` is uninitialized
  
and reads the response. The test it sends *GetIdentityInformationRequest*:

  * `Message.id := 3`
  * `SingleRequest.version := [1,0,0]`
  * `GetIdentityInformationRequest.identityNetworkId` is set to SHA256 of test's identity public key
  * `GetIdentityInformationRequest.includeProfileImage := false`
  * `GetIdentityInformationRequest.includeThumbnailImage := false`
  * `GetIdentityInformationRequest.includeApplicationServices := false`
  
and reads the response.

  
##### Acceptance Criteria


###### Step 1:
Node replies with *StartConversationResponse*:

  * `Message.id == 1`
  * `Response.status == STATUS_OK`
  * `ConversationResponse.signature` is a valid signature of $ClientChallenge
  * `StartConversationResponse.clientChallenge == $ClientChallenge`

Node replies with *HomeNodeRequestResponse*:

  * `Message.id == 2`
  * `Response.status == STATUS_OK`

Node replies with *Response*:

  * `Message.id == 3`
  * `Response.status == ERROR_UNINITIALIZED`








#### HN02016 - Get Identity Information - Unknown Identity

##### Prerequisites/Inputs

###### Prerequisites:
  * Node's database is empty.

###### Inputs:
  * Node's IP address
  * Node's clNonCustomer port

##### Description 

The test queries details about identity that is not hosted on the node.

###### Step 1:
The test establishes a TLS connection to the clNonCustomer port of the node and sends *GetIdentityInformationRequest*:

  * `Message.id := 1`
  * `SingleRequest.version := [1,0,0]`
  * `GetIdentityInformationRequest.identityNetworkId := SHA256("test")`
  * `GetIdentityInformationRequest.includeProfileImage := false`
  * `GetIdentityInformationRequest.includeThumbnailImage := false`
  * `GetIdentityInformationRequest.includeApplicationServices := false`
  
and reads the response. 
  
##### Acceptance Criteria


###### Step 1:
Node replies with *Response*:

  * `Message.id == 1`
  * `Response.status == ERROR_NOT_FOUND`










#### HN02017 - Verify Identity, Update Profile - Bad Role

##### Prerequisites/Inputs
###### Prerequisites:
  * Node's clNonCustomer port != clCustomer port

###### Inputs:
  * Node's IP address
  * Node's clNonCustomer port

##### Description 

The test verifies its identity on clNonCustomer port. Then it attempts to update its profile, which requires clCustomer port and Authenticated status.


###### Step 1:

The test establishes a TLS connection to the clNonCustomer port of the node and sends *StartConversationRequest*:

  * `Message.id := 1`
  * `StartConversationRequest.supportedVersions := [[1,0,0]]`
  * `StartConversationRequest.publicKey` set to the test's identity 32 byte long public key
  * `StartConversationRequest.clientChallenge` set to 32 byte random challenge; `$ClientChallenge := StartConversationRequest.clientChallenge`

and reads the response from the node in form of *StartConversationResponse*:

  * `$Challenge := StartConversationResponse.challenge`


Then it sends *HomeNodeRequestRequest*:

  * `Message.id := 2`
  * `HomeNodeRequestRequest.contract` is uninitialized
  
and reads the response. Then it sends *VerifyIdentityRequest*:

  * `Message.id := 3`
  * `VerifyIdentityRequest.challenge := $Challenge`
  * `ConversationRequest.signature` is set to a signature of `VerifyIdentityRequest` part of the message using the test's identity private key

and reads the response. Then it sends *UpdateProfileRequest*:

  * `Message.id := 4`
  * `UpdateProfileRequest.setVersion := true`
  * `UpdateProfileRequest.setName := true`
  * `UpdateProfileRequest.setImage := false`
  * `UpdateProfileRequest.setLocation := true`
  * `UpdateProfileRequest.setExtraData := false`
  * `UpdateProfileRequest.version := [1,0,0]`
  * `UpdateProfileRequest.name := "Test Identity"`
  * `UpdateProfileRequest.image` is unintialized
  * `UpdateProfileRequest.latitude := 0`
  * `UpdateProfileRequest.longitude := 0`
  * `UpdateProfileRequest.extraData` is unintialized

and reads the response.


##### Acceptance Criteria


###### Step 1:
Node replies with *StartConversationResponse*:

  * `Message.id == 1`
  * `Response.status == STATUS_OK`
  * `ConversationResponse.signature` is a valid signature of $ClientChallenge
  * `StartConversationResponse.clientChallenge == $ClientChallenge`

Node replies with *HomeNodeRequestResponse*:

  * `Message.id == 2`
  * `Response.status == STATUS_OK`

Node replies with *VerifyIdentityResponse*:

  * `Message.id == 3`
  * `Response.status == STATUS_OK`

Node replies with *Response*:

  * `Message.id == 4`
  * `Response.status == ERROR_BAD_ROLE`









#### HN02018 - Call Identity Application Service - Unauthorized 1

##### Prerequisites/Inputs

###### Inputs:
  * Node's IP address
  * Node's clNonCustomer port

##### Description 

The test sends *CallIdentityApplicationServiceRequest* to the node without starting the conversation first.

###### Step 1:
The test establishes a TLS connection to the clNonCustomer port of the node and sends *CallIdentityApplicationServiceRequest*:

  * `Message.id := 1`
  * `CallIdentityApplicationServiceRequest.identityNetworkId := SHA256("test")`
  * `CallIdentityApplicationServiceRequest.serviceName := "Test Service"`
  
and reads the response.
  
##### Acceptance Criteria

###### Step 1:
Node replies with *Response*:
  
  * `Message.id == 1`
  * `Response.status == ERROR_UNAUTHORIZED`







#### HN02019 - Call Identity Application Service - Unauthorized 2

##### Prerequisites/Inputs

###### Inputs:
  * Node's IP address
  * Node's clNonCustomer port

##### Description 

The test sends *CallIdentityApplicationServiceRequest* to the node without verifying its identity firts.

###### Step 1:
The test establishes a TLS connection to the clNonCustomer port of the node and sends *StartConversationRequest*:

  * `Message.id := 1`
  * `StartConversationRequest.supportedVersions := [[1,0,0]]`
  * `StartConversationRequest.publicKey` set to the test's identity 32 byte long public key
  * `StartConversationRequest.clientChallenge` set to 32 byte random challenge; `$ClientChallenge := StartConversationRequest.clientChallenge`

and reads the response. Then it sends *CallIdentityApplicationServiceRequest*:

  * `Message.id := 2`
  * `CallIdentityApplicationServiceRequest.identityNetworkId := SHA256("test")`
  * `CallIdentityApplicationServiceRequest.serviceName := "Test Service"`
  
and reads the response.
  
##### Acceptance Criteria

###### Step 1:
Node replies with *StartConversationResponse*:

  * `Message.id == 1`
  * `Response.status == STATUS_OK`
  * `ConversationResponse.signature` is a valid signature of $ClientChallenge
  * `StartConversationResponse.clientChallenge == $ClientChallenge`

Node replies with *Response*:
  
  * `Message.id == 2`
  * `Response.status == ERROR_UNAUTHORIZED`








#### HN02020 - Call Identity Application Service - Invalid Id

##### Prerequisites/Inputs

###### Inputs:
  * Node's IP address
  * Node's clNonCustomer

##### Description 

The test tries to call identity that is not hosted on the node.

###### Step 1:

The test establishes a TLS connection to the clNonCustomer port of the node and sends *StartConversationRequest*:

  * `Message.id := 1`
  * `StartConversationRequest.supportedVersions := [[1,0,0]]`
  * `StartConversationRequest.publicKey` set to the test's identity 32 byte long public key
  * `StartConversationRequest.clientChallenge` set to 32 byte random challenge; `$ClientChallenge := StartConversationRequest.clientChallenge`
  
and reads the response from the node in form of *StartConversationResponse*:

  * `$Challenge := StartConversationResponse.challenge`

Then it sends *VerifyIdentityRequest*:

  * `Message.id := 2`
  * `VerifyIdentityRequest.challenge := $Challenge`
  * `ConversationRequest.signature` is set to a signature of `VerifyIdentityRequest` part of the message using the test's identity private key
  
and reads the response. Then it sends *CallIdentityApplicationServiceRequest*:

  * `Message.id := 3`
  * `CallIdentityApplicationServiceRequest.identityNetworkId := SHA256("test")`
  * `CallIdentityApplicationServiceRequest.serviceName := "Test Service"`
  
and reads the response.

  
##### Acceptance Criteria


###### Step 1:
Node replies with *StartConversationResponse*:

  * `Message.id == 1`
  * `Response.status == STATUS_OK`
  * `ConversationResponse.signature` is a valid signature of $ClientChallenge
  * `StartConversationResponse.clientChallenge == $ClientChallenge`

Node replies with *VerifyIdentityResponse*:

  * `Message.id == 2`
  * `Response.status == STATUS_OK`

Node replies with *Response*:
  
  * `Message.id == 3`
  * `Response.status == ERROR_INVALID_VALUE`
  * `Response.details == "identityNetworkId"`







#### HN02021 - Call Identity Application Service - Uninitialized

##### Prerequisites/Inputs

###### Inputs:
  * Node's IP address
  * Node's clNonCustomer

##### Description 

The test tries to call identity which profile has not been initialized yet.

###### Step 1:

The test creates a first identity and establishes a TLS connection to the clNonCustomer port of the node and sends *StartConversationRequest*:

  * `Message.id := 1`
  * `StartConversationRequest.supportedVersions := [[1,0,0]]`
  * `StartConversationRequest.publicKey` set to the test's identity 32 byte long public key
  * `StartConversationRequest.clientChallenge` set to 32 byte random challenge; `$ClientChallenge1 := StartConversationRequest.clientChallenge`

and reads the response from the node in form of *StartConversationResponse*:

  * `$Challenge := StartConversationResponse.challenge`


Then it sends *HomeNodeRequestRequest*:

  * `Message.id := 2`
  * `HomeNodeRequestRequest.contract` is uninitialized
  
and reads the response and then closes the connection.


###### Step 2:
The test creates a second identity and using it it establishes a TLS connection to the clNonCustomer port of the node and sends *StartConversationRequest*:

  * `Message.id := 1`
  * `StartConversationRequest.supportedVersions := [[1,0,0]]`
  * `StartConversationRequest.publicKey` set to the test's identity 32 byte long public key
  * `StartConversationRequest.clientChallenge` set to 32 byte random challenge; `$ClientChallenge2 := StartConversationRequest.clientChallenge`
  
and reads the response from the node in form of *StartConversationResponse*:

  * `$Challenge := StartConversationResponse.challenge`

Then it sends *VerifyIdentityRequest*:

  * `Message.id := 2`
  * `VerifyIdentityRequest.challenge := $Challenge`
  * `ConversationRequest.signature` is set to a signature of `VerifyIdentityRequest` part of the message using the test's identity private key
  
and reads the response. Then it sends *CallIdentityApplicationServiceRequest*:

  * `Message.id := 3`
  * `CallIdentityApplicationServiceRequest.identityNetworkId` is set to network ID of the first identity
  * `CallIdentityApplicationServiceRequest.serviceName := "Test Service"`
  
and reads the response.

  
##### Acceptance Criteria

###### Step 1:
Node replies with *StartConversationResponse*:

  * `Message.id == 1`
  * `Response.status == STATUS_OK`
  * `ConversationResponse.signature` is a valid signature of $ClientChallenge1
  * `StartConversationResponse.clientChallenge == $ClientChallenge1`

Node replies with *HomeNodeRequestResponse*:

  * `Message.id == 2`
  * `Response.status == STATUS_OK`


###### Step 2:
Node replies with *StartConversationResponse*:

  * `Message.id == 1`
  * `Response.status == STATUS_OK`
  * `ConversationResponse.signature` is a valid signature of $ClientChallenge2
  * `StartConversationResponse.clientChallenge == $ClientChallenge2`

Node replies with *VerifyIdentityResponse*:

  * `Message.id == 2`
  * `Response.status == STATUS_OK`

Node replies with *Response*:
  
  * `Message.id == 3`
  * `Response.status == ERROR_UNINITIALIZED`











#### HN02022 - Start Conversation - Invalid Challenge

##### Prerequisites/Inputs

###### Inputs:
  * Node's IP address
  * Node's clNonCustomer port

##### Description 

The test starts the conversation with the node but it sends invalid client challenge in the requests.

###### Step 1:

The test establishes a TLS connection to the clNonCustomer port of the node and sends *StartConversationRequest*:

  * `Message.id := 1`
  * `StartConversationRequest.supportedVersions := [[1,0,0]]`
  * `StartConversationRequest.publicKey` set to the test identity's 32 byte long public key
  * `StartConversationRequest.clientChallenge` set to 4 byte random challenge
  
and reads the response.
  
##### Acceptance Criteria

###### Step 1:
Node replies with *Response*:
  
  * `Message.id == 1`
  * `Response.status == ERROR_INVALID_VALUE`
  * `Response.details == "clientChallenge"`








#### HN02023 - Profile Stats

##### Prerequisites/Inputs

###### Inputs:
  * Node's IP address
  * Node's clNonCustomer port

##### Description 

The test creates 10 new identities and establishes home node contracts for all of them. Then it asks the node for profile statistics.


###### Step 1:

The test creates 8 identities with following identity types:

  * 2x "Type A"
  * 3x "Type B"
  * 1x "Type Alpha"
  * 1x "Type A B"
  * 1x "Type Beta"

and then with each identity it connects to clNonCustomer port and establishes a home node contract. 

The test establishes a new TLS connection to clNonCustomer and sends *ProfileStatsRequest*:

  * `Message.id := 1`
  * `SingleRequest.version := [1,0,0]`

and reads the response.


###### Step 2:

The test creates 2 more identities with following identity types:

  * 1x `Type A B`
  * 1x `Type C`

and then with each identity it connects to clNonCustomer port and establishes a home node contract. 

Then it reuses the previous connection used for sending *ProfileStatsRequest* and sends *ProfileStatsRequest*:

  * `Message.id := 2`
  * `SingleRequest.version := [1,0,0]`

and reads the response.


  
##### Acceptance Criteria

###### Step 1:

Test successfully establishes the home node contracts.

Node replies with *ProfileStatsResponse*:
  
  * `Message.id == 1`
  * `Response.status == STATUS_OK`
  * `ProfileStatsResponse.stats.Count == 5`
  * `ProfileStatsResponse.stats == 
    (
      {identityType == "Type A", count == 2},
      {identityType == "Type B", count == 3},
      {identityType == "Type Alpha", count == 1},
      {identityType == "Type A B", count == 1},
      {identityType == "Type Beta", count == 1}
    )`


###### Step 2:

Test successfully establishes the home node contracts.

Node replies with *ProfileStatsResponse*:
  
  * `Message.id == 2`
  * `Response.status == STATUS_OK`
  * `ProfileStatsResponse.stats.Count == 6`
  * `ProfileStatsResponse.stats == 
    (
      {identityType == "Type A", count == 2},
      {identityType == "Type B", count == 3},
      {identityType == "Type Alpha", count == 1},
      {identityType == "Type A B", count == 2},
      {identityType == "Type Beta", count == 1}
      {identityType == "Type C", count == 1},
    )`






#### HN02024 - Profile Stats - No Stats

##### Prerequisites/Inputs

###### Inputs:
  * Node's IP address
  * Node's clNonCustomer port

##### Description 

The test asks the node for profile statistics when node has an empty database.


###### Step 1:

The test establishes a new TLS connection to clNonCustomer and sends *ProfileStatsRequest*:

  * `Message.id := 1`
  * `SingleRequest.version := [1,0,0]`

and reads the response.


  
##### Acceptance Criteria

###### Step 1:

Node replies with *ProfileStatsResponse*:
  
  * `Message.id == 1`
  * `Response.status == STATUS_OK`
  * `ProfileStatsResponse.stats.Count == 0`






#### HN02025 - Profile Search - Bad Conversation Status

##### Prerequisites/Inputs

###### Inputs:
  * Node's IP address
  * Node's clNonCustomer port

##### Description 

The test sends *ProfileSearchRequest* request to the node without starting the conversation first.

###### Step 1:

The test connects to the primary port of the node and sends *ProfileSearchRequest*:

  * `Message.id := 1`
  * `ProfileSearchRequest.includeHostedOnly := false`
  * `ProfileSearchRequest.includeThumbnailImages := true`
  * `ProfileSearchRequest.maxResponseRecordCount := 100`
  * `ProfileSearchRequest.maxTotalRecordCount := 1000`
  * `ProfileSearchRequest.type := ""`
  * `ProfileSearchRequest.name := ""`
  * `ProfileSearchRequest.latitude := NO_LOCATION`
  * `ProfileSearchRequest.longitude := NO_LOCATION`
  * `ProfileSearchRequest.radius := 0`
  * `ProfileSearchRequest.extraData := ""`

and reads the response.


##### Acceptance Criteria

###### Step 1:

Node replies with *Response*:
  
  * `Message.id == 1`
  * `Response.status == ERROR_BAD_CONVERSATION_STATUS`





#### HN02026 - Profile Search Part - Bad Conversation Status

##### Prerequisites/Inputs

###### Inputs:
  * Node's IP address
  * Node's clNonCustomer port

##### Description 

The test sends *ProfileSearchPartRequest* request to the node without starting the conversation first.

###### Step 1:

The test connects to the primary port of the node and sends *ProfileSearchPartRequest*:

  * `Message.id := 1`
  * `ProfileSearchPartRequest.recordIndex := 0`
  * `ProfileSearchPartRequest.recordCount := 10`
 
and reads the response.


##### Acceptance Criteria

###### Step 1:

Node replies with *Response*:
  
  * `Message.id == 1`
  * `Response.status == ERROR_BAD_CONVERSATION_STATUS`











### HN03xxx - Node Client Customer Port Functionality Tests

#### HN03001 - Check-In - Not Hosted Identity

##### Prerequisites/Inputs

###### Prerequisites:
  * Node's database is empty.

###### Inputs:
  * Node's IP address
  * Node's clCustomer port

##### Description 

The test tries to perform a check-in process with an identity that has no home node agreement with the node.

###### Step 1:
The test establishes a TLS connection to the clCustomer port of the node and sends *StartConversationRequest*:

  * `Message.id := 1`
  * `StartConversationRequest.supportedVersions := [[1,0,0]]`
  * `StartConversationRequest.publicKey` set to the test's identity 32 byte long public key
  * `StartConversationRequest.clientChallenge` set to 32 byte random challenge; `$ClientChallenge := StartConversationRequest.clientChallenge`

and reads the response from the node in form of *StartConversationResponse*:

  * `$Challenge := StartConversationResponse.challenge`

Then it sends *CheckInRequest*:

  * `Message.id := 2`
  * `CheckInRequest.challenge := $Challenge`
  * `ConversationRequest.signature` is set to a signature of `CheckInRequest` part of the message using the test's identity private key
  
and reads the response.

  
##### Acceptance Criteria


###### Step 1:
Node replies with *StartConversationResponse*:

  * `Message.id == 1`
  * `Response.status == STATUS_OK`
  * `ConversationResponse.signature` is a valid signature of $ClientChallenge
  * `StartConversationResponse.clientChallenge == $ClientChallenge`

Node replies with *Response*:

  * `Message.id == 2`
  * `Response.status == ERROR_NOT_FOUND`








#### HN03002 - Home Node Request - Bad Role

##### Prerequisites/Inputs

###### Prerequisites:
  * Node's clNonCustomer port != clCustomer port

###### Inputs:
  * Node's IP address
  * Node's clCustomer port

##### Description 

The test sends home node request to the clCustomer port, but *HomeNodeRequestRequest* requires clNonCustomer port to be used.

###### Step 1:

The test establishes a TLS connection to the clCustomer port of the node and sends *StartConversationRequest*:

  * `Message.id := 1`
  * `StartConversationRequest.supportedVersions := [[1,0,0]]`
  * `StartConversationRequest.publicKey` set to the test identity's 32 byte long public key
  * `StartConversationRequest.clientChallenge` set to 32 byte random challenge; `$ClientChallenge := StartConversationRequest.clientChallenge`
 
and reads the response. Then it sends *HomeNodeRequestRequest*:

  * `Message.id := 2`
  * `HomeNodeRequestRequest.contract` is uninitialized

and reads the response.


##### Acceptance Criteria

###### Step 1:

Node replies with *StartConversationResponse*:

  * `Message.id == 1`
  * `Response.status == STATUS_OK`
  * `ConversationResponse.signature` is a valid signature of $ClientChallenge
  * `StartConversationResponse.clientChallenge == $ClientChallenge`

Node replies with *Response*:
  
  * `Message.id == 2`
  * `Response.status == ERROR_BAD_ROLE`






#### HN03003 - Verify Identity - Bad Role

##### Prerequisites/Inputs

###### Prerequisites:
  * Node's clNonCustomer port != clCustomer port

###### Inputs:
  * Node's IP address
  * Node's clCustomer port

##### Description 

The test sends verify identity request to the clCustomer port, but *VerifyIdentityRequest* requires clNonCustomer port to be used.

###### Step 1:

The test establishes a TLS connection to the clCustomer port of the node and sends *StartConversationRequest*:

  * `Message.id := 1`
  * `StartConversationRequest.supportedVersions := [[1,0,0]]`
  * `StartConversationRequest.publicKey` set to the test identity's 32 byte long public key
  * `StartConversationRequest.clientChallenge` set to 32 byte random challenge; `$ClientChallenge := StartConversationRequest.clientChallenge`
 
and reads the response from the node in form of *StartConversationResponse*:

  * `$Challenge := StartConversationResponse.challenge`

Then it sends *VerifyIdentityRequest*:

  * `Message.id := 2`
  * `VerifyIdentityRequest.challenge := $Challenge`
  * `ConversationRequest.signature` is set to a signature of `VerifyIdentityRequest` part of the message using the test's identity private key
  
and reads the response.


##### Acceptance Criteria

###### Step 1:

Node replies with *StartConversationResponse*:

  * `Message.id == 1`
  * `Response.status == STATUS_OK`
  * `ConversationResponse.signature` is a valid signature of $ClientChallenge
  * `StartConversationResponse.clientChallenge == $ClientChallenge`

Node replies with *Response*:
  
  * `Message.id == 2`
  * `Response.status == ERROR_BAD_ROLE`







#### HN03004 - Check-In - Bad Conversation Status

##### Prerequisites/Inputs

###### Inputs:
  * Node's IP address
  * Node's clCustomer port

##### Description 

The test sends check-in request to the node without starting the conversation first.

###### Step 1:
The test establishes a TLS connection to the clCustomer port of the node and sends *CheckInRequest*:

  * `Message.id := 1`
  * `CheckInRequest.challenge := SHA256("test")`
  
and reads the response.
  
##### Acceptance Criteria

###### Step 1:
Node replies with *Response*:
  
  * `Message.id == 1`
  * `Response.status == ERROR_BAD_CONVERSATION_STATUS`







#### HN03005 - Add Related Identity - Unauthorized

##### Prerequisites/Inputs

###### Inputs:
  * Node's IP address
  * Node's clCustomer port

##### Description

The test sends *AddRelatedIdentityRequest* to the node without checking-in first.

###### Step 1:

The test connects to the primary port of the node and sends *AddRelatedIdentityRequest*:

  * `Message.id := 1`
  * `AddRelatedIdentityRequest.cardApplication` is uninitialized
  * `AddRelatedIdentityRequest.signedCard` is uninitialized
 
and reads the response.


##### Acceptance Criteria

###### Step 1:

Node replies with *Response*:
  
  * `Message.id == 1`
  * `Response.status == ERROR_UNAUTHORIZED`






#### HN03006 - Remove Related Identity - Unauthorized

##### Prerequisites/Inputs

###### Inputs:
  * Node's IP address
  * Node's clCustomer port

##### Description

The test sends *RemoveRelatedIdentityRequest* to the node without checking-in first.

###### Step 1:

The test connects to the primary port of the node and sends *RemoveRelatedIdentityRequest*:

  * `Message.id := 1`
  * `RemoveRelatedIdentityRequest.applicationId` is uninitialized
 
and reads the response.


##### Acceptance Criteria

###### Step 1:

Node replies with *Response*:
  
  * `Message.id == 1`
  * `Response.status == ERROR_UNAUTHORIZED`












### HN04xxx - Node Combined Client Customer and Non-Customer Port Functionality Tests

#### HN04001 - Check-In - Different Customer and Non-Customer Ports

##### Prerequisites/Inputs

###### Prerequisites:
  * Node's database is empty.
  * Node's clNonCustomer port != clCustomer port

###### Inputs:
  * Node's IP address
  * Node's clNonCustomer port
  * Node's clCustomer port

##### Description 

The test establishes a home node agreement with the node. Then it performs the check-in process.

###### Step 1:
The test establishes a TLS connection to the clNonCustomer port of the node and sends *StartConversationRequest*:

  * `Message.id := 1`
  * `StartConversationRequest.supportedVersions := [[1,0,0]]`
  * `StartConversationRequest.publicKey` set to the test's identity 32 byte long public key
  * `StartConversationRequest.clientChallenge` set to 32 byte random challenge; `$ClientChallenge1 := StartConversationRequest.clientChallenge`
  
and reads the response. Then it sends *HomeNodeRequestRequest*:

  * `Message.id := 2`
  * `HomeNodeRequestRequest.contract` is uninitialized
  
and reads the response.
  
###### Step 2:
The test then closes the connection and establishes a TLS connection to the clCustomer port of the node and sends *StartConversationRequest*:

  * `Message.id := 1`
  * `StartConversationRequest.supportedVersions := [[1,0,0]]`
  * `StartConversationRequest.publicKey` set to the test's identity 32 byte long public key
  * `StartConversationRequest.clientChallenge` set to 32 byte random challenge; `$ClientChallenge2 := StartConversationRequest.clientChallenge`

and reads the response from the node in form of *StartConversationResponse*:

  * `$Challenge := StartConversationResponse.challenge`

Then it sends *CheckInRequest*:

  * `Message.id := 2`
  * `CheckInRequest.challenge := $Challenge`
  * `ConversationRequest.signature` is set to a signature of `CheckInRequest` part of the message using the test's identity private key
  
and reads the response.

  
##### Acceptance Criteria


###### Step 1:
Node replies with *StartConversationResponse*:

  * `Message.id == 1`
  * `Response.status == STATUS_OK`
  * `ConversationResponse.signature` is a valid signature of $ClientChallenge1
  * `StartConversationResponse.clientChallenge == $ClientChallenge1`

Node replies with *HomeNodeRequestResponse*:

  * `Message.id == 2`
  * `Response.status == STATUS_OK`


###### Step 2:
Node replies with *StartConversationResponse*:

  * `Message.id == 1`
  * `Response.status == STATUS_OK`
  * `ConversationResponse.signature` is a valid signature of $ClientChallenge2
  * `StartConversationResponse.clientChallenge == $ClientChallenge2`

Node replies with *CheckInResponse*:

  * `Message.id == 2`
  * `Response.status == STATUS_OK`







#### HN04002 - Check-In - Same Customer and Non-Customer Ports

##### Prerequisites/Inputs

###### Prerequisites:
  * Node's database is empty.
  * Node's clNonCustomer port == clCustomer port

###### Inputs:
  * Node's IP address
  * Node's clNonCustomer/clCustomer port

##### Description 

The test establishes a home node agreement with the node and continues with the check-in process on the same port.

###### Step 1:
The test establishes a TLS connection to the clCustomer port of the node and sends *StartConversationRequest*:

  * `Message.id := 1`
  * `StartConversationRequest.supportedVersions := [[1,0,0]]`
  * `StartConversationRequest.publicKey` set to the test's identity 32 byte long public key
  * `StartConversationRequest.clientChallenge` set to 32 byte random challenge; `$ClientChallenge := StartConversationRequest.clientChallenge`
  
and reads the response from the node in form of *StartConversationResponse*:

  * `$Challenge := StartConversationResponse.challenge`

Then it sends *HomeNodeRequestRequest*:

  * `Message.id := 2`
  * `HomeNodeRequestRequest.contract` is uninitialized
  
and reads the response. The test it sends *CheckInRequest*:

  * `Message.id := 3`
  * `CheckInRequest.challenge := $Challenge`
  * `ConversationRequest.signature` is set to a signature of `CheckInRequest` part of the message using the test's identity private key
  
and reads the response.

  
##### Acceptance Criteria


###### Step 1:
Node replies with *StartConversationResponse*:

  * `Message.id == 1`
  * `Response.status == STATUS_OK`
  * `ConversationResponse.signature` is a valid signature of $ClientChallenge
  * `StartConversationResponse.clientChallenge == $ClientChallenge`

Node replies with *HomeNodeRequestResponse*:

  * `Message.id == 2`
  * `Response.status == STATUS_OK`

Node replies with *CheckInResponse*:

  * `Message.id == 3`
  * `Response.status == STATUS_OK`








#### HN04003 - Check-In - Invalid Signature

##### Prerequisites/Inputs

###### Prerequisites:
  * Node's database is empty.

###### Inputs:
  * Node's IP address
  * Node's clNonCustomer port
  * Node's clCustomer port

##### Description 

The test establishes a home node agreement with the node. Then it performs the check-in process but it uses invalid signature.

###### Step 1:
The test establishes a TLS connection to the clNonCustomer port of the node and sends *StartConversationRequest*:

  * `Message.id := 1`
  * `StartConversationRequest.supportedVersions := [[1,0,0]]`
  * `StartConversationRequest.publicKey` set to the test's identity 32 byte long public key
  * `StartConversationRequest.clientChallenge` set to 32 byte random challenge; `$ClientChallenge1 := StartConversationRequest.clientChallenge`
  
and reads the response. Then it sends *HomeNodeRequestRequest*:

  * `Message.id := 2`
  * `HomeNodeRequestRequest.contract` is uninitialized
  
and reads the response.
  
###### Step 2:
The test then closes the connection and establishes a TLS connection to the clCustomer port of the node and sends *StartConversationRequest*:

  * `Message.id := 1`
  * `StartConversationRequest.supportedVersions := [[1,0,0]]`
  * `StartConversationRequest.publicKey` set to the test's identity 32 byte long public key
  * `StartConversationRequest.clientChallenge` set to 32 byte random challenge; `$ClientChallenge2 := StartConversationRequest.clientChallenge`

and reads the response from the node in form of *StartConversationResponse*:

  * `$Challenge := StartConversationResponse.challenge`

Then it sends *CheckInRequest*:

  * `Message.id := 2`
  * `CheckInRequest.challenge := $Challenge`
  * `ConversationRequest.signature` is set to a signature of `CheckInRequest` part of the message using the test's identity private key, but the first byte of the signature is XORed with 0x12 to make the signature invalid.
  
and reads the response.

  
##### Acceptance Criteria


###### Step 1:
Node replies with *StartConversationResponse*:

  * `Message.id == 1`
  * `Response.status == STATUS_OK`
  * `ConversationResponse.signature` is a valid signature of $ClientChallenge1
  * `StartConversationResponse.clientChallenge == $ClientChallenge1`

Node replies with *HomeNodeRequestResponse*:

  * `Message.id == 2`
  * `Response.status == STATUS_OK`


###### Step 2:
Node replies with *StartConversationResponse*:

  * `Message.id == 1`
  * `Response.status == STATUS_OK`
  * `ConversationResponse.signature` is a valid signature of $ClientChallenge2
  * `StartConversationResponse.clientChallenge == $ClientChallenge2`

Node replies with *Response*:

  * `Message.id == 2`
  * `Response.status == ERROR_INVALID_SIGNATURE`








#### HN04004 - Check-In - Invalid Challenge

##### Prerequisites/Inputs

###### Prerequisites:
  * Node's database is empty.

###### Inputs:
  * Node's IP address
  * Node's clNonCustomer port
  * Node's clCustomer port

##### Description 

The test establishes a home node agreement with the node. Then it performs the check-in process but it uses invalid challenge.

###### Step 1:
The test establishes a TLS connection to the clNonCustomer port of the node and sends *StartConversationRequest*:

  * `Message.id := 1`
  * `StartConversationRequest.supportedVersions := [[1,0,0]]`
  * `StartConversationRequest.publicKey` set to the test's identity 32 byte long public key
  * `StartConversationRequest.clientChallenge` set to 32 byte random challenge; `$ClientChallenge1 := StartConversationRequest.clientChallenge`
  
and reads the response. Then it sends *HomeNodeRequestRequest*:

  * `Message.id := 2`
  * `HomeNodeRequestRequest.contract` is uninitialized
  
and reads the response.
  
###### Step 2:
The test then closes the connection and establishes a TLS connection to the clCustomer port of the node and sends *StartConversationRequest*:

  * `Message.id := 1`
  * `StartConversationRequest.supportedVersions := [[1,0,0]]`
  * `StartConversationRequest.publicKey` set to the test's identity 32 byte long public key
  * `StartConversationRequest.clientChallenge` set to 32 byte random challenge; `$ClientChallenge2 := StartConversationRequest.clientChallenge`

and reads the response from the node in form of *StartConversationResponse*:

  * `$Challenge := StartConversationResponse.challenge`

Then it sends *CheckInRequest*:

  * `Message.id := 2`
  * `CheckInRequest.challenge := $Challenge`, but the first byte of the challenge is XORed with 0x12 to make the challenge invalid
  * `ConversationRequest.signature` is set to a signature of `CheckInRequest` part of the message using the test's identity private key
  
and reads the response.

  
##### Acceptance Criteria


###### Step 1:
Node replies with *StartConversationResponse*:

  * `Message.id == 1`
  * `Response.status == STATUS_OK`
  * `ConversationResponse.signature` is a valid signature of $ClientChallenge1
  * `StartConversationResponse.clientChallenge == $ClientChallenge1`

Node replies with *HomeNodeRequestResponse*:

  * `Message.id == 2`
  * `Response.status == STATUS_OK`


###### Step 2:
Node replies with *StartConversationResponse*:

  * `Message.id == 1`
  * `Response.status == STATUS_OK`
  * `ConversationResponse.signature` is a valid signature of $ClientChallenge2
  * `StartConversationResponse.clientChallenge == $ClientChallenge2`

Node replies with *Response*:

  * `Message.id == 2`
  * `Response.status == ERROR_INVALID_VALUE`
  * `Response.details == "challenge"`












#### HN04005 - Cancel Home Node Agreement, Register Again and Check-In

##### Prerequisites/Inputs
###### Prerequisites:
  * Node's database is empty.

###### Inputs:
  * Node's IP address
  * Node's clNonCustomer port
  * Node's clCustomer port

##### Description 

The test cancels home node agreement for its hosted identity. It then attempts to check-in the identity, which should fail because it is no longer hosted on the node. Then it establishes a new home node agreement and then it checks-in.

###### Step 1:
The test establishes a home node agreement using clNonCustomer port and then it closes the connection.

###### Step 2:
The test establishes a TLS connection to the clCustomer port of the node and sends *StartConversationRequest*:

  * `Message.id := 1`
  * `StartConversationRequest.supportedVersions := [[1,0,0]]`
  * `StartConversationRequest.publicKey` set to the test's identity 32 byte long public key
  * `StartConversationRequest.clientChallenge` set to 32 byte random challenge; `$ClientChallenge1 := StartConversationRequest.clientChallenge`

and reads the response from the node in form of *StartConversationResponse*:

  * `$Challenge := StartConversationResponse.challenge`

Then it sends *CheckInRequest*:

  * `Message.id := 2`
  * `CheckInRequest.challenge := $Challenge`
  * `ConversationRequest.signature` is set to a signature of `CheckInRequest` part of the message using the test's identity private key
  
and reads the response. Then it sends *CancelHomeNodeAgreementRequest*:

  * `Message.id := 3`
  * `CancelHomeNodeAgreementRequest.redirectToNewHomeNode := false`
  * `CancelHomeNodeAgreementRequest.newHomeNodeNetworkId` is uninitialized

and reads the response.


###### Step 3:
The test closes the connection and establishes a new TLS connection to the clCustomer port and sends *StartConversationRequest*:

  * `Message.id := 1`
  * `StartConversationRequest.supportedVersions := [[1,0,0]]`
  * `StartConversationRequest.publicKey` set to the test's identity 32 byte long public key
  * `StartConversationRequest.clientChallenge` set to 32 byte random challenge; `$ClientChallenge2 := StartConversationRequest.clientChallenge`

and reads the response from the node in form of *StartConversationResponse*:

  * `$Challenge := StartConversationResponse.challenge`

Then it sends *CheckInRequest*:

  * `Message.id := 2`
  * `CheckInRequest.challenge := $Challenge`
  * `ConversationRequest.signature` is set to a signature of `CheckInRequest` part of the message using the test's identity private key
  
and reads the response and closes the connection. 

###### Step 4:

The test establishes a TLS connection to the clNonCustomer port of the node and sends *StartConversationRequest*:

  * `Message.id := 1`
  * `StartConversationRequest.supportedVersions := [[1,0,0]]`
  * `StartConversationRequest.publicKey` set to the test identity's 32 byte long public key
  * `StartConversationRequest.clientChallenge` set to 32 byte random challenge; `$ClientChallenge3 := StartConversationRequest.clientChallenge`
  
and reads the response. Then it sends *HomeNodeRequestRequest*:

  * `Message.id := 2`
  * `HomeNodeRequestRequest.contract` is uninitialized

and reads the response.



###### Step 5:
The test closes the connection and establishes a new TLS connection to the clCustomer port and sends *StartConversationRequest*:

  * `Message.id := 1`
  * `StartConversationRequest.supportedVersions := [[1,0,0]]`
  * `StartConversationRequest.publicKey` set to the test's identity 32 byte long public key
  * `StartConversationRequest.clientChallenge` set to 32 byte random challenge; `$ClientChallenge4 := StartConversationRequest.clientChallenge`

and reads the response from the node in form of *StartConversationResponse*:

  * `$Challenge := StartConversationResponse.challenge`

Then it sends *CheckInRequest*:

  * `Message.id := 2`
  * `CheckInRequest.challenge := $Challenge`
  * `ConversationRequest.signature` is set to a signature of `CheckInRequest` part of the message using the test's identity private key
  
and reads the response. 

  
##### Acceptance Criteria


###### Step 1:
The test successfully establishes a home node agreement for its identity.

###### Step 2:
Node replies with *StartConversationResponse*:

  * `Message.id == 1`
  * `Response.status == STATUS_OK`
  * `ConversationResponse.signature` is a valid signature of $ClientChallenge1
  * `StartConversationResponse.clientChallenge == $ClientChallenge1`

Node replies with *CheckInResponse*:

  * `Message.id == 2`
  * `Response.status == STATUS_OK`

Node replies with *CancelHomeNodeAgreementResponse*:

  * `Message.id == 3`
  * `Response.status == STATUS_OK`
  
  
###### Step 3:
Node replies with *StartConversationResponse*:

  * `Message.id == 1`
  * `Response.status == STATUS_OK`
  * `ConversationResponse.signature` is a valid signature of $ClientChallenge2
  * `StartConversationResponse.clientChallenge == $ClientChallenge2`

Node replies with *Response*:

  * `Message.id == 2`
  * `Response.status == ERROR_NOT_FOUND`

###### Step 4:
Node replies with *StartConversationResponse*:

  * `Message.id == 1`
  * `Response.status == STATUS_OK`
  * `ConversationResponse.signature` is a valid signature of $ClientChallenge3
  * `StartConversationResponse.clientChallenge == $ClientChallenge3`

Node replies with *HomeNodeRequestResponse*:

  * `Message.id == 2`
  * `Response.status == STATUS_OK`
  
###### Step 5:
Node replies with *StartConversationResponse*:

  * `Message.id == 1`
  * `Response.status == STATUS_OK`
  * `ConversationResponse.signature` is a valid signature of $ClientChallenge4
  * `StartConversationResponse.clientChallenge == $ClientChallenge4`

Node replies with *CheckInRequest*:

  * `Message.id == 2`
  * `Response.status == STATUS_OK`









#### HN04006 - Home Node Agreement, Update Profile, Get Identity Information 

##### Prerequisites/Inputs

###### Prerequisites:
  * Node's database is empty.
  * "images/HN04006.jpg" file exists and contains JPEG image with size less than 20 kb

###### Inputs:
  * Node's IP address
  * Node's clNonCustomer port
  * Node's clCustomer port

##### Description 

The test establishes a home node agreement with the node. Then it checks-in and initializes its profile. Then it queries its profile. Then it updates it again and queries it once more.

###### Step 1:
The test establishes a TLS connection to the clNonCustomer port of the node and sends *StartConversationRequest*:

  * `Message.id := 1`
  * `StartConversationRequest.supportedVersions := [[1,0,0]]`
  * `StartConversationRequest.publicKey` set to the test's identity 32 byte long public key; `$PublicKey := StartConversationRequest.publicKey`
  * `StartConversationRequest.clientChallenge` set to 32 byte random challenge; `$ClientChallenge1 := StartConversationRequest.clientChallenge`
  
and reads the response. Then it sends *HomeNodeRequestRequest*:

  * `Message.id := 2`
  * `HomeNodeRequestRequest.contract` is uninitialized
  
and reads the response.
  
###### Step 2:
The test then closes the connection and establishes a TLS connection to the clCustomer port of the node and sends *StartConversationRequest*:

  * `Message.id := 1`
  * `StartConversationRequest.supportedVersions := [[1,0,0]]`
  * `StartConversationRequest.publicKey := $PublicKey`
  * `StartConversationRequest.clientChallenge` set to 32 byte random challenge; `$ClientChallenge2 := StartConversationRequest.clientChallenge`

and reads the response from the node in form of *StartConversationResponse*:

  * `$Challenge := StartConversationResponse.challenge`

Then it sends *CheckInRequest*:

  * `Message.id := 2`
  * `CheckInRequest.challenge := $Challenge`
  * `ConversationRequest.signature` is set to a signature of `CheckInRequest` part of the message using the test's identity private key
  
and reads the response. Then it sends *UpdateProfileRequest*:

  * `Message.id := 3`
  * `UpdateProfileRequest.setVersion := true`
  * `UpdateProfileRequest.setName := true`
  * `UpdateProfileRequest.setImage := false`
  * `UpdateProfileRequest.setLocation := true`
  * `UpdateProfileRequest.setExtraData := false`
  * `UpdateProfileRequest.version := [1,0,0]`
  * `UpdateProfileRequest.name := "Test Identity"`
  * `UpdateProfileRequest.image` is unintialized
  * `UpdateProfileRequest.latitude := 1`
  * `UpdateProfileRequest.longitude := 2`
  * `UpdateProfileRequest.extraData` is unintialized

and reads the response. Then it sends *GetIdentityInformationRequest*:

  * `Message.id := 4`
  * `SingleRequest.version := [1,0,0]`
  * `GetIdentityInformationRequest.identityNetworkId` is set to SHA256 of test's identity public key
  * `GetIdentityInformationRequest.includeProfileImage := false`
  * `GetIdentityInformationRequest.includeThumbnailImage := false`
  * `GetIdentityInformationRequest.includeApplicationServices := false`


and reads the response. Then it sends *UpdateProfileRequest*:

  * `Message.id := 5`
  * `UpdateProfileRequest.setVersion := false`
  * `UpdateProfileRequest.setName := true`
  * `UpdateProfileRequest.setImage := true`
  * `UpdateProfileRequest.setLocation := true`
  * `UpdateProfileRequest.setExtraData := true`
  * `UpdateProfileRequest.version` is unintialized
  * `UpdateProfileRequest.name := "Test Identity Renamed"`
  * `UpdateProfileRequest.image` is initialized with data loaded from "images/HN04006.jpg" file. `$ImageData := UpdateProfileRequest.image`
  * `UpdateProfileRequest.latitude := -1`
  * `UpdateProfileRequest.longitude := -2`
  * `UpdateProfileRequest.extraData := "a=b"` 

and reads the response. Then it sends *GetIdentityInformationRequest*:

  * `Message.id := 6`
  * `SingleRequest.version := [1,0,0]`
  * `GetIdentityInformationRequest.identityNetworkId` is set to SHA256 of test's identity public key
  * `GetIdentityInformationRequest.includeProfileImage := true`
  * `GetIdentityInformationRequest.includeThumbnailImage := true`
  * `GetIdentityInformationRequest.includeApplicationServices := false`


  
##### Acceptance Criteria


###### Step 1:
Node replies with *StartConversationResponse*:

  * `Message.id == 1`
  * `Response.status == STATUS_OK`
  * `ConversationResponse.signature` is a valid signature of $ClientChallenge1
  * `StartConversationResponse.clientChallenge == $ClientChallenge1`

Node replies with *HomeNodeRequestResponse*:

  * `Message.id == 2`
  * `Response.status == STATUS_OK`


###### Step 2:
Node replies with *StartConversationResponse*:

  * `Message.id == 1`
  * `Response.status == STATUS_OK`
  * `ConversationResponse.signature` is a valid signature of $ClientChallenge2
  * `StartConversationResponse.clientChallenge == $ClientChallenge2`

Node replies with *CheckInResponse*:

  * `Message.id == 2`
  * `Response.status == STATUS_OK`

Node replies with *UpdateProfileResponse*:

  * `Message.id == 3`
  * `Response.status == STATUS_OK`

Node replies with *GetIdentityInformationResponse*:

  * `Message.id == 4`
  * `Response.status == STATUS_OK`
  * `GetIdentityInformationResponse.isHosted == true`
  * `GetIdentityInformationResponse.isOnline == true`
  * `GetIdentityInformationResponse.identityPublicKey == $PublicKey`
  * `GetIdentityInformationResponse.name == "Test Identity"`
  * `GetIdentityInformationResponse.extraData == ""`
  * `GetIdentityInformationResponse.latitude == 1`
  * `GetIdentityInformationResponse.longitude == 2`

Node replies with *UpdateProfileResponse*:

  * `Message.id == 5`
  * `Response.status == STATUS_OK`

Node replies with *GetIdentityInformationResponse*:

  * `Message.id == 6`
  * `Response.status == STATUS_OK`
  * `GetIdentityInformationResponse.isHosted == true`
  * `GetIdentityInformationResponse.isOnline == true`
  * `GetIdentityInformationResponse.identityPublicKey == $PublicKey`
  * `GetIdentityInformationResponse.name == "Test Identity Renamed"`
  * `GetIdentityInformationResponse.extraData == "a=b"`
  * `GetIdentityInformationResponse.latitude == -1`
  * `GetIdentityInformationResponse.longitude == -2`
  * `GetIdentityInformationResponse.profileImage == $ImageData`
  * `GetIdentityInformationResponse.thumbnailImage` is non empty
















#### HN04007 - Update Profile - Invalid Initialization and Invalid Values

##### Prerequisites/Inputs

###### Prerequisites:
  * Node's database is empty.
  * "images/HN04007-too-big.jpg" file exists and contains JPEG image with size greater than 20 kb
  * "images/HN04007-not-image.jpg" file exists and contains a single byte 0x41

###### Inputs:
  * Node's IP address
  * Node's clNonCustomer port
  * Node's clCustomer port

##### Description 

The test establishes a home node agreement with the node. Then it checks-in and attempts to repeatedly update its profile, but always fails to fill in all required fields for the profile initialization. Then it tries to update the profile with invalid values. Then it initializes the profile correctly and it attempts to send empty update request.

###### Step 1:
The test establishes a TLS connection to the clNonCustomer port of the node and sends *StartConversationRequest*:

  * `Message.id := 1`
  * `StartConversationRequest.supportedVersions := [[1,0,0]]`
  * `StartConversationRequest.publicKey` set to the test's identity 32 byte long public key; `$PublicKey := StartConversationRequest.publicKey`
  * `StartConversationRequest.clientChallenge` set to 32 byte random challenge; `$ClientChallenge1 := StartConversationRequest.clientChallenge`
  
and reads the response. Then it sends *HomeNodeRequestRequest*:

  * `Message.id := 2`
  * `HomeNodeRequestRequest.contract` is uninitialized
  
and reads the response.
  
###### Step 2:
The test then closes the connection and establishes a TLS connection to the clCustomer port of the node and sends *StartConversationRequest*:

  * `Message.id := 1`
  * `StartConversationRequest.supportedVersions := [[1,0,0]]`
  * `StartConversationRequest.publicKey := $PublicKey`
  * `StartConversationRequest.clientChallenge` set to 32 byte random challenge; `$ClientChallenge2 := StartConversationRequest.clientChallenge`

and reads the response from the node in form of *StartConversationResponse*:

  * `$Challenge := StartConversationResponse.challenge`

Then it sends *CheckInRequest*:

  * `Message.id := 2`
  * `CheckInRequest.challenge := $Challenge`
  * `ConversationRequest.signature` is set to a signature of `CheckInRequest` part of the message using the test's identity private key
  
and reads the response. Then it sends *UpdateProfileRequest*:

  * `Message.id := 3`
  * `UpdateProfileRequest.setVersion := false`
  * `UpdateProfileRequest.setName := true`
  * `UpdateProfileRequest.setImage := false`
  * `UpdateProfileRequest.setLocation := true`
  * `UpdateProfileRequest.setExtraData := false`
  * `UpdateProfileRequest.version` is unintialized
  * `UpdateProfileRequest.name := "Test Identity"`
  * `UpdateProfileRequest.image` is unintialized
  * `UpdateProfileRequest.latitude := 1`
  * `UpdateProfileRequest.longitude := 2`
  * `UpdateProfileRequest.extraData` is unintialized

and reads the response. Then it sends *UpdateProfileRequest*:

  * `Message.id := 4`
  * `UpdateProfileRequest.setVersion := true`
  * `UpdateProfileRequest.setName := false`
  * `UpdateProfileRequest.setImage := false`
  * `UpdateProfileRequest.setLocation := true`
  * `UpdateProfileRequest.setExtraData := false`
  * `UpdateProfileRequest.version := [1,0,0]`
  * `UpdateProfileRequest.name` is unintialized
  * `UpdateProfileRequest.image` is unintialized
  * `UpdateProfileRequest.latitude := 1`
  * `UpdateProfileRequest.longitude := 2`
  * `UpdateProfileRequest.extraData` is unintialized

and reads the response. Then it sends *UpdateProfileRequest*:

  * `Message.id := 5`
  * `UpdateProfileRequest.setVersion := true`
  * `UpdateProfileRequest.setName := true`
  * `UpdateProfileRequest.setImage := false`
  * `UpdateProfileRequest.setLocation := false`
  * `UpdateProfileRequest.setExtraData := false`
  * `UpdateProfileRequest.version := [1,0,0]`
  * `UpdateProfileRequest.name := "Test Identity"`
  * `UpdateProfileRequest.image` is unintialized
  * `UpdateProfileRequest.latitude` is unintialized
  * `UpdateProfileRequest.longitude` is unintialized
  * `UpdateProfileRequest.extraData` is unintialized

and reads the response. Then it sends *UpdateProfileRequest*:

  * `Message.id := 6`
  * `UpdateProfileRequest.setVersion := true`
  * `UpdateProfileRequest.setName := true`
  * `UpdateProfileRequest.setImage := false`
  * `UpdateProfileRequest.setLocation := true`
  * `UpdateProfileRequest.setExtraData := false`
  * `UpdateProfileRequest.version := [0,0,0]`
  * `UpdateProfileRequest.name := "Test Identity"`
  * `UpdateProfileRequest.image` is unintialized
  * `UpdateProfileRequest.latitude := 1`
  * `UpdateProfileRequest.longitude := 2`
  * `UpdateProfileRequest.extraData` is unintialized

and reads the response. Then it sends *UpdateProfileRequest*:

  * `Message.id := 7`
  * `UpdateProfileRequest.setVersion := true`
  * `UpdateProfileRequest.setName := true`
  * `UpdateProfileRequest.setImage := false`
  * `UpdateProfileRequest.setLocation := true`
  * `UpdateProfileRequest.setExtraData := false`
  * `UpdateProfileRequest.version := [255,0,0]`
  * `UpdateProfileRequest.name := "Test Identity"`
  * `UpdateProfileRequest.image` is unintialized
  * `UpdateProfileRequest.latitude := 1`
  * `UpdateProfileRequest.longitude := 2`
  * `UpdateProfileRequest.extraData` is unintialized

and reads the response. Then it sends *UpdateProfileRequest*:

  * `Message.id := 8`
  * `UpdateProfileRequest.setVersion := true`
  * `UpdateProfileRequest.setName := true`
  * `UpdateProfileRequest.setImage := false`
  * `UpdateProfileRequest.setLocation := true`
  * `UpdateProfileRequest.setExtraData := false`
  * `UpdateProfileRequest.version := [1,0,0]`
  * `UpdateProfileRequest.name := ""`
  * `UpdateProfileRequest.image` is unintialized
  * `UpdateProfileRequest.latitude := 1`
  * `UpdateProfileRequest.longitude := 2`
  * `UpdateProfileRequest.extraData` is unintialized

and reads the response. Then it sends *UpdateProfileRequest*:

  * `Message.id := 9`
  * `UpdateProfileRequest.setVersion := true`
  * `UpdateProfileRequest.setName := true`
  * `UpdateProfileRequest.setImage := false`
  * `UpdateProfileRequest.setLocation := true`
  * `UpdateProfileRequest.setExtraData := false`
  * `UpdateProfileRequest.version := [1,0,0]`
  * `UpdateProfileRequest.name` is set to string containing 100x 'a'
  * `UpdateProfileRequest.image` is unintialized
  * `UpdateProfileRequest.latitude := 1`
  * `UpdateProfileRequest.longitude := 2`
  * `UpdateProfileRequest.extraData` is unintialized

and reads the response. Then it sends *UpdateProfileRequest*:

  * `Message.id := 10`
  * `UpdateProfileRequest.setVersion := true`
  * `UpdateProfileRequest.setName := true`
  * `UpdateProfileRequest.setImage := false`
  * `UpdateProfileRequest.setLocation := true`
  * `UpdateProfileRequest.setExtraData := false`
  * `UpdateProfileRequest.version := [1,0,0]`
  * `UpdateProfileRequest.name` is set to string containing 50x 'ɐ' (UTF8 code 0xc990), which consumes 2 bytes per character
  * `UpdateProfileRequest.image` is unintialized
  * `UpdateProfileRequest.latitude := 1`
  * `UpdateProfileRequest.longitude := 2`
  * `UpdateProfileRequest.extraData` is unintialized

and reads the response. Then it sends *UpdateProfileRequest*:

  * `Message.id := 11`
  * `UpdateProfileRequest.setVersion := true`
  * `UpdateProfileRequest.setName := true`
  * `UpdateProfileRequest.setImage := true`
  * `UpdateProfileRequest.setLocation := true`
  * `UpdateProfileRequest.setExtraData := false`
  * `UpdateProfileRequest.version := [1,0,0]`
  * `UpdateProfileRequest.name := "Test Identity"`
  * `UpdateProfileRequest.image` is initialized with image data loaded from "images/HN04007-too-big.jpg" file
  * `UpdateProfileRequest.latitude := 1`
  * `UpdateProfileRequest.longitude := 2`
  * `UpdateProfileRequest.extraData` is unintialized

and reads the response. Then it sends *UpdateProfileRequest*:

  * `Message.id := 12`
  * `UpdateProfileRequest.setVersion := true`
  * `UpdateProfileRequest.setName := true`
  * `UpdateProfileRequest.setImage := true`
  * `UpdateProfileRequest.setLocation := true`
  * `UpdateProfileRequest.setExtraData := false`
  * `UpdateProfileRequest.version := [1,0,0]`
  * `UpdateProfileRequest.name := "Test Identity"`
  * `UpdateProfileRequest.image` is initialized with image data loaded from "images/HN04007-not-image.jpg" file
  * `UpdateProfileRequest.latitude := 1`
  * `UpdateProfileRequest.longitude := 2`
  * `UpdateProfileRequest.extraData` is unintialized

and reads the response. Then it sends *UpdateProfileRequest*:

  * `Message.id := 13`
  * `UpdateProfileRequest.setVersion := true`
  * `UpdateProfileRequest.setName := true`
  * `UpdateProfileRequest.setImage := false`
  * `UpdateProfileRequest.setLocation := true`
  * `UpdateProfileRequest.setExtraData := true`
  * `UpdateProfileRequest.version := [1,0,0]`
  * `UpdateProfileRequest.name := "Test Identity"`
  * `UpdateProfileRequest.image` is uninitialized
  * `UpdateProfileRequest.latitude := 1`
  * `UpdateProfileRequest.longitude := 2`
  * `UpdateProfileRequest.extraData` is set to string containing 300x 'a'

and reads the response. Then it sends *UpdateProfileRequest*:

  * `Message.id := 14`
  * `UpdateProfileRequest.setVersion := true`
  * `UpdateProfileRequest.setName := true`
  * `UpdateProfileRequest.setImage := false`
  * `UpdateProfileRequest.setLocation := true`
  * `UpdateProfileRequest.setExtraData := true`
  * `UpdateProfileRequest.version := [1,0,0]`
  * `UpdateProfileRequest.name := "Test Identity"`
  * `UpdateProfileRequest.image` is uninitialized
  * `UpdateProfileRequest.latitude := 1`
  * `UpdateProfileRequest.longitude := 2`
  * `UpdateProfileRequest.extraData` is set to string containing 150x 'ɐ' (UTF8 code 0xc990), which consumes 2 bytes per character

and reads the response. Then it sends *UpdateProfileRequest*:

  * `Message.id := 15`
  * `UpdateProfileRequest.setVersion := true`
  * `UpdateProfileRequest.setName := true`
  * `UpdateProfileRequest.setImage := false`
  * `UpdateProfileRequest.setLocation := true`
  * `UpdateProfileRequest.setExtraData := false`
  * `UpdateProfileRequest.version := [1,0,0]`
  * `UpdateProfileRequest.name := "Test Identity"`
  * `UpdateProfileRequest.image` is uninitialized
  * `UpdateProfileRequest.latitude := 1`
  * `UpdateProfileRequest.longitude := 2`
  * `UpdateProfileRequest.extraData` is uninitialized

and reads the response. Then it sends *UpdateProfileRequest*:

  * `Message.id := 16`
  * `UpdateProfileRequest.setVersion := false`
  * `UpdateProfileRequest.setName := false`
  * `UpdateProfileRequest.setImage := false`
  * `UpdateProfileRequest.setLocation := false`
  * `UpdateProfileRequest.setExtraData := false`
  * `UpdateProfileRequest.version` is uninitialized
  * `UpdateProfileRequest.name` is uninitialized
  * `UpdateProfileRequest.image` is uninitialized
  * `UpdateProfileRequest.latitude` is unintialized
  * `UpdateProfileRequest.longitude` is unintialized
  * `UpdateProfileRequest.extraData` is uninitialized

and reads the response. Then it sends *UpdateProfileRequest*:

  * `Message.id := 17`
  * `UpdateProfileRequest.setVersion := false`
  * `UpdateProfileRequest.setName := false`
  * `UpdateProfileRequest.setImage := false`
  * `UpdateProfileRequest.setLocation := true`
  * `UpdateProfileRequest.setExtraData := false`
  * `UpdateProfileRequest.version` is uninitialized
  * `UpdateProfileRequest.name` is uninitialized
  * `UpdateProfileRequest.image` is uninitialized
  * `UpdateProfileRequest.latitude := -90,000,001`
  * `UpdateProfileRequest.longitude := 2`
  * `UpdateProfileRequest.extraData` is uninitialized

and reads the response. Then it sends *UpdateProfileRequest*:

  * `Message.id := 18`
  * `UpdateProfileRequest.setVersion := false`
  * `UpdateProfileRequest.setName := false`
  * `UpdateProfileRequest.setImage := false`
  * `UpdateProfileRequest.setLocation := true`
  * `UpdateProfileRequest.setExtraData := false`
  * `UpdateProfileRequest.version` is uninitialized
  * `UpdateProfileRequest.name` is uninitialized
  * `UpdateProfileRequest.image` is uninitialized
  * `UpdateProfileRequest.latitude := 0`
  * `UpdateProfileRequest.longitude := 180,000,001`
  * `UpdateProfileRequest.extraData` is uninitialized

and reads the response. Then it sends *UpdateProfileRequest*:

  * `Message.id := 19`
  * `UpdateProfileRequest.setVersion := false`
  * `UpdateProfileRequest.setName := false`
  * `UpdateProfileRequest.setImage := false`
  * `UpdateProfileRequest.setLocation := true`
  * `UpdateProfileRequest.setExtraData := false`
  * `UpdateProfileRequest.version` is uninitialized
  * `UpdateProfileRequest.name` is uninitialized
  * `UpdateProfileRequest.image` is uninitialized
  * `UpdateProfileRequest.latitude := -90,000,001`
  * `UpdateProfileRequest.longitude := 180,000,001`
  * `UpdateProfileRequest.extraData` is uninitialized

and reads the response.

  
##### Acceptance Criteria


###### Step 1:
Node replies with *StartConversationResponse*:

  * `Message.id == 1`
  * `Response.status == STATUS_OK`
  * `ConversationResponse.signature` is a valid signature of $ClientChallenge1
  * `StartConversationResponse.clientChallenge == $ClientChallenge1`

Node replies with *HomeNodeRequestResponse*:

  * `Message.id == 2`
  * `Response.status == STATUS_OK`


###### Step 2:
Node replies with *StartConversationResponse*:

  * `Message.id == 1`
  * `Response.status == STATUS_OK`
  * `ConversationResponse.signature` is a valid signature of $ClientChallenge2
  * `StartConversationResponse.clientChallenge == $ClientChallenge2`

Node replies with *CheckInResponse*:

  * `Message.id == 2`
  * `Response.status == STATUS_OK`

Node replies with *Response*:

  * `Message.id == 3`
  * `Response.status == ERROR_INVALID_VALUE`
  * `Response.details == "setVersion"`

Node replies with *Response*:

  * `Message.id == 4`
  * `Response.status == ERROR_INVALID_VALUE`
  * `Response.details == "setName"`

Node replies with *Response*:

  * `Message.id == 5`
  * `Response.status == ERROR_INVALID_VALUE`
  * `Response.details == "setLocation"`

Node replies with *Response*:

  * `Message.id == 6`
  * `Response.status == ERROR_INVALID_VALUE`
  * `Response.details == "version"`

Node replies with *Response*:

  * `Message.id == 7`
  * `Response.status == ERROR_INVALID_VALUE`
  * `Response.details == "version"`

Node replies with *Response*:

  * `Message.id == 8`
  * `Response.status == ERROR_INVALID_VALUE`
  * `Response.details == "name"`

Node replies with *Response*:

  * `Message.id == 9`
  * `Response.status == ERROR_INVALID_VALUE`
  * `Response.details == "name"`

Node replies with *Response*:

  * `Message.id == 10`
  * `Response.status == ERROR_INVALID_VALUE`
  * `Response.details == "name"`

Node replies with *Response*:

  * `Message.id == 11`
  * `Response.status == ERROR_INVALID_VALUE`
  * `Response.details == "image"`

Node replies with *Response*:

  * `Message.id == 12`
  * `Response.status == ERROR_INVALID_VALUE`
  * `Response.details == "image"`

Node replies with *Response*:

  * `Message.id == 13`
  * `Response.status == ERROR_INVALID_VALUE`
  * `Response.details == "extraData"`

Node replies with *Response*:

  * `Message.id == 14`
  * `Response.status == ERROR_INVALID_VALUE`
  * `Response.details == "extraData"`

Node replies with *UpdateProfileResponse*:

  * `Message.id == 15`
  * `Response.status == STATUS_OK`

Node replies with *Response*:

  * `Message.id == 16`
  * `Response.status == ERROR_INVALID_VALUE`
  * `Response.details == "set*"`

Node replies with *Response*:

  * `Message.id == 17`
  * `Response.status == ERROR_INVALID_VALUE`
  * `Response.details == "latitude"`

Node replies with *Response*:

  * `Message.id == 18`
  * `Response.status == ERROR_INVALID_VALUE`
  * `Response.details == "longitude"`

Node replies with *Response*:

  * `Message.id == 19`
  * `Response.status == ERROR_INVALID_VALUE`
  * `Response.details == "latitude"`









#### HN04008 - Verify Identity, Update Profile - Unauthorized

##### Prerequisites/Inputs
###### Prerequisites:
  * Node's database is empty.
  * Node's clNonCustomer port == clCustomer port

###### Inputs:
  * Node's IP address
  * Node's clNonCustomer/clCustomer port

##### Description 

The test verifies its identity on clNonCustomer/clCustomer port. Then it attempts to update its profile, which requires Authenticated status.


###### Step 1:
The test establishes a home node agreement using clNonCustomer port and then it closes the connection.

###### Step 2:
The test establishes a TLS connection to the clNonCustomer port of the node and sends *StartConversationRequest*:

  * `Message.id := 1`
  * `StartConversationRequest.supportedVersions := [[1,0,0]]`
  * `StartConversationRequest.publicKey` set to the test's identity 32 byte long public key
  * `StartConversationRequest.clientChallenge` set to 32 byte random challenge; `$ClientChallenge := StartConversationRequest.clientChallenge`

and reads the response from the node in form of *StartConversationResponse*:

  * `$Challenge := StartConversationResponse.challenge`

Then it sends *VerifyIdentityRequest*:

  * `Message.id := 2`
  * `VerifyIdentityRequest.challenge := $Challenge`
  * `ConversationRequest.signature` is set to a signature of `VerifyIdentityRequest` part of the message using the test's identity private key

and reads the response. Then it sends *UpdateProfileRequest*:

  * `Message.id := 3`
  * `UpdateProfileRequest.setVersion := true`
  * `UpdateProfileRequest.setName := true`
  * `UpdateProfileRequest.setImage := false`
  * `UpdateProfileRequest.setLocation := true`
  * `UpdateProfileRequest.setExtraData := false`
  * `UpdateProfileRequest.version := [1,0,0]`
  * `UpdateProfileRequest.name := "Test Identity"`
  * `UpdateProfileRequest.image` is unintialized
  * `UpdateProfileRequest.latitude := 0`
  * `UpdateProfileRequest.longitude := 0`
  * `UpdateProfileRequest.extraData` is unintialized

and reads the response.


##### Acceptance Criteria


###### Step 1:
The test successfully establishes a home node agreement for its identity.

###### Step 2:
Node replies with *StartConversationResponse*:

  * `Message.id == 1`
  * `Response.status == STATUS_OK`
  * `ConversationResponse.signature` is a valid signature of $ClientChallenge
  * `StartConversationResponse.clientChallenge == $ClientChallenge`

Node replies with *VerifyIdentityResponse*:

  * `Message.id == 2`
  * `Response.status == STATUS_OK`

Node replies with *Response*:

  * `Message.id == 3`
  * `Response.status == ERROR_UNAUTHORIZED`









#### HN04009 - Cancel Home Node Agreement - Redirection

##### Prerequisites/Inputs
###### Prerequisites:
  * Node's database is empty.

###### Inputs:
  * Node's IP address
  * Node's clNonCustomer port
  * Node's clCustomer port

##### Description 

The test cancels home node agreement for its hosted identity and sets up a redirect to a new home node. It then verifies that this redirect has been installed.

###### Step 1:
The test establishes a home node agreement using clNonCustomer port and then it closes the connection.

###### Step 2:
The test establishes a TLS connection to the clCustomer port of the node and sends *StartConversationRequest*:

  * `Message.id := 1`
  * `StartConversationRequest.supportedVersions := [[1,0,0]]`
  * `StartConversationRequest.publicKey` set to the test's identity 32 byte long public key
  * `StartConversationRequest.clientChallenge` set to 32 byte random challenge; `$ClientChallenge := StartConversationRequest.clientChallenge`

and reads the response from the node in form of *StartConversationResponse*:

  * `$Challenge := StartConversationResponse.challenge`

Then it sends *CheckInRequest*:

  * `Message.id := 2`
  * `CheckInRequest.challenge := $Challenge`
  * `ConversationRequest.signature` is set to a signature of `CheckInRequest` part of the message using the test's identity private key
  
and reads the response. Then it sends *CancelHomeNodeAgreementRequest*:

  * `Message.id := 3`
  * `CancelHomeNodeAgreementRequest.redirectToNewHomeNode := true`
  * `CancelHomeNodeAgreementRequest.newHomeNodeNetworkId := SHA256("test")`

and reads the response. Then it sends *GetIdentityInformationRequest*:

  * `Message.id := 4`
  * `SingleRequest.version := [1,0,0]`
  * `GetIdentityInformationRequest.identityNetworkId` is set to SHA256 of test's identity public key
  * `GetIdentityInformationRequest.includeProfileImage = false`
  * `GetIdentityInformationRequest.includeThumbnailImage = false`
  * `GetIdentityInformationRequest.includeApplicationServices = false`


##### Acceptance Criteria


###### Step 1:
The test successfully establishes a home node agreement for its identity.

###### Step 2:
Node replies with *StartConversationResponse*:

  * `Message.id == 1`
  * `Response.status == STATUS_OK`
  * `ConversationResponse.signature` is a valid signature of $ClientChallenge
  * `StartConversationResponse.clientChallenge == $ClientChallenge`

Node replies with *CheckInResponse*:

  * `Message.id == 2`
  * `Response.status == STATUS_OK`

Node replies with *CancelHomeNodeAgreementResponse*:

  * `Message.id == 3`
  * `Response.status == STATUS_OK`
  
Node replies with *GetIdentityInformationResponse*:

  * `Message.id == 4`
  * `Response.status == STATUS_OK`
  * `GetIdentityInformationResponse.isHosted == false`
  * `GetIdentityInformationResponse.isTargetHomeNodeKnown == true`
  * `GetIdentityInformationResponse.targetHomeNodeNetworkId == SHA256("test")`






#### HN04010 - Cancel Home Node Agreement - Invalid New Home Node Id

##### Prerequisites/Inputs
###### Prerequisites:
  * Node's database is empty.

###### Inputs:
  * Node's IP address
  * Node's clNonCustomer port
  * Node's clCustomer port

##### Description 

The test cancels home node agreement for its hosted identity and sets up a redirect to a new home node, but provides invalid new home node network identifier.

###### Step 1:
The test establishes a home node agreement using clNonCustomer port and then it closes the connection.

###### Step 2:
The test establishes a TLS connection to the clCustomer port of the node and sends *StartConversationRequest*:

  * `Message.id := 1`
  * `StartConversationRequest.supportedVersions := [[1,0,0]]`
  * `StartConversationRequest.publicKey` set to the test's identity 32 byte long public key
  * `StartConversationRequest.clientChallenge` set to 32 byte random challenge; `$ClientChallenge := StartConversationRequest.clientChallenge`

and reads the response from the node in form of *StartConversationResponse*:

  * `$Challenge := StartConversationResponse.challenge`

Then it sends *CheckInRequest*:

  * `Message.id := 2`
  * `CheckInRequest.challenge := $Challenge`
  * `ConversationRequest.signature` is set to a signature of `CheckInRequest` part of the message using the test's identity private key
  
and reads the response. Then it sends *CancelHomeNodeAgreementRequest*:

  * `Message.id := 3`
  * `CancelHomeNodeAgreementRequest.redirectToNewHomeNode := true`
  * `CancelHomeNodeAgreementRequest.newHomeNodeNetworkId := "test"`

and reads the response.


##### Acceptance Criteria


###### Step 1:
The test successfully establishes a home node agreement for its identity.

###### Step 2:
Node replies with *StartConversationResponse*:

  * `Message.id == 1`
  * `Response.status == STATUS_OK`
  * `ConversationResponse.signature` is a valid signature of $ClientChallenge
  * `StartConversationResponse.clientChallenge == $ClientChallenge`

Node replies with *CheckInResponse*:

  * `Message.id == 2`
  * `Response.status == STATUS_OK`

Node replies with *Response*:

  * `Message.id == 3`
  * `Response.status == ERROR_INVALID_VALUE`
  * `Response.details == "newHomeNodeNetworkId"`








#### HN04011 - Parallel Check-Ins

##### Prerequisites/Inputs
###### Prerequisites:
  * Node's database is empty.

###### Inputs:
  * Node's IP address
  * Node's clNonCustomer port
  * Node's clCustomer port

##### Description 

The test checks-in its identity and then it checks it in again in a second parallel connection. This should disconnect the first connection.

###### Step 1:
The test establishes a home node agreement using clNonCustomer port and then it closes the connection.

###### Step 2:
The test establishes a TLS connection to the clCustomer port of the node and sends *StartConversationRequest*:

  * `Message.id := 1`
  * `StartConversationRequest.supportedVersions := [[1,0,0]]`
  * `StartConversationRequest.publicKey` set to the test's identity 32 byte long public key
  * `StartConversationRequest.clientChallenge` set to 32 byte random challenge; `$ClientChallenge1 := StartConversationRequest.clientChallenge`

and reads the response from the node in form of *StartConversationResponse*:

  * `$Challenge := StartConversationResponse.challenge`

Then it sends *CheckInRequest*:

  * `Message.id := 2`
  * `CheckInRequest.challenge := $Challenge`
  * `ConversationRequest.signature` is set to a signature of `CheckInRequest` part of the message using the test's identity private key
  
and reads the response. 

###### Step 3:
With the first connection left open, the test establishes a new TLS connection to the clCustomer port of the node and sends *StartConversationRequest*:

  * `Message.id := 1`
  * `StartConversationRequest.supportedVersions := [[1,0,0]]`
  * `StartConversationRequest.publicKey` set to the test's identity 32 byte long public key
  * `StartConversationRequest.clientChallenge` set to 32 byte random challenge; `$ClientChallenge2 := StartConversationRequest.clientChallenge`

and reads the response from the node in form of *StartConversationResponse*:

  * `$Challenge := StartConversationResponse.challenge`

Then it sends *CheckInRequest*:

  * `Message.id := 2`
  * `CheckInRequest.challenge := $Challenge`
  * `ConversationRequest.signature` is set to a signature of `CheckInRequest` part of the message using the test's identity private key
  
and reads the response. 

###### Step 4:

Using the first connection the test attempts to send *PingRequest*:

  * `Message.id := 1`
  * `SingleRequest.version := [1,0,0]`
  * `PingRequest.payload = "test"`

and reads the response. 



##### Acceptance Criteria


###### Step 1:
The test successfully establishes a home node agreement for its identity.

###### Step 2:
Node replies with *StartConversationResponse*:

  * `Message.id == 1`
  * `Response.status == STATUS_OK`
  * `ConversationResponse.signature` is a valid signature of $ClientChallenge1
  * `StartConversationResponse.clientChallenge == $ClientChallenge1`

Node replies with *CheckInResponse*:

  * `Message.id == 2`
  * `Response.status == STATUS_OK`


###### Step 3:
Node replies with *StartConversationResponse*:

  * `Message.id == 1`
  * `Response.status == STATUS_OK`
  * `ConversationResponse.signature` is a valid signature of $ClientChallenge2
  * `StartConversationResponse.clientChallenge == $ClientChallenge2`

Node replies with *CheckInResponse*:

  * `Message.id == 2`
  * `Response.status == STATUS_OK`

###### Step 4:

The first connection should be disconnected and it should not be possible to send the request.













#### HN04012 - Update Profile - Unauthorized

##### Prerequisites/Inputs

###### Prerequisites:
  * Node's database is empty.

###### Inputs:
  * Node's IP address
  * Node's clNonCustomer port
  * Node's clCustomer port

##### Description 

The test asks to update its profile without performing a check-in process first. 

###### Step 1:
The test establishes a home node agreement using clNonCustomer port and then it closes the connection.

###### Step 2:
The test establishes a TLS connection to the clCustomer port of the node and sends *StartConversationRequest*:

  * `Message.id := 1`
  * `StartConversationRequest.supportedVersions := [[1,0,0]]`
  * `StartConversationRequest.publicKey` set to the test's identity 32 byte long public key
  * `StartConversationRequest.clientChallenge` set to 32 byte random challenge; `$ClientChallenge1 := StartConversationRequest.clientChallenge`

and reads the response.

Then it sends *UpdateProfileRequest*:

  * `Message.id := 2`
  * `UpdateProfileRequest.setVersion := true`
  * `UpdateProfileRequest.setName := true`
  * `UpdateProfileRequest.setImage := false`
  * `UpdateProfileRequest.setLocation := true`
  * `UpdateProfileRequest.setExtraData := false`
  * `UpdateProfileRequest.version := [1,0,0]`
  * `UpdateProfileRequest.name := "Test Identity"`
  * `UpdateProfileRequest.image` is unintialized
  * `UpdateProfileRequest.latitude := 0`
  * `UpdateProfileRequest.longitude := 0`
  * `UpdateProfileRequest.extraData` is unintialized

and reads the response. 

  
##### Acceptance Criteria


###### Step 1:
The test successfully establishes a home node agreement for its identity.

###### Step 2:
Node replies with *StartConversationResponse*:

  * `Message.id == 1`
  * `Response.status == STATUS_OK`
  * `ConversationResponse.signature` is a valid signature of $ClientChallenge
  * `StartConversationResponse.clientChallenge == $ClientChallenge`

Node replies with *Response*:

  * `Message.id == 2`
  * `Response.status == ERROR_UNAUTHORIZED`












#### HN04013 - Application Service Add, Remove, Query

##### Prerequisites/Inputs
###### Prerequisites:
  * Node's database is empty.

###### Inputs:
  * Node's IP address
  * Node's clNonCustomer port
  * Node's clCustomer port

##### Description 

The test checks-in its identity and then it adds/deletes/queries its application services. Some of the requests are valid and some are invalid.


###### Step 1:
The test establishes a home node agreement using clNonCustomer port and then it closes the connection.

###### Step 2:
The test establishes a TLS connection to the clCustomer port of the node and sends *StartConversationRequest*:

  * `Message.id := 1`
  * `StartConversationRequest.supportedVersions := [[1,0,0]]`
  * `StartConversationRequest.publicKey` set to the test's identity 32 byte long public key; `$PublicKey := StartConversationRequest.publicKey`
  * `StartConversationRequest.clientChallenge` set to 32 byte random challenge; `$ClientChallenge := StartConversationRequest.clientChallenge`

and reads the response from the node in form of *StartConversationResponse*:

  * `$Challenge := StartConversationResponse.challenge`

Then it sends *CheckInRequest*:

  * `Message.id := 2`
  * `CheckInRequest.challenge := $Challenge`
  * `ConversationRequest.signature` is set to a signature of `CheckInRequest` part of the message using the test's identity private key
  
and reads the response. Then it sends *UpdateProfileRequest*:

  * `Message.id := 3`
  * `UpdateProfileRequest.setVersion := true`
  * `UpdateProfileRequest.setName := true`
  * `UpdateProfileRequest.setImage := false`
  * `UpdateProfileRequest.setLocation := true`
  * `UpdateProfileRequest.setExtraData := false`
  * `UpdateProfileRequest.version := [1,0,0]`
  * `UpdateProfileRequest.name := "Test Identity"`
  * `UpdateProfileRequest.image` is unintialized
  * `UpdateProfileRequest.latitude := 0`
  * `UpdateProfileRequest.longitude := 0`
  * `UpdateProfileRequest.extraData` is unintialized

and reads the response. Then it sends *ApplicationServiceAddRequest*:

  * `Message.id := 4`
  * `ApplicationServiceAddRequest.serviceNames := ["a","b","c","d","a"]`

and reads the response. Then it sends *GetIdentityInformationRequest*:

  * `Message.id := 5`
  * `SingleRequest.version := [1,0,0]`
  * `GetIdentityInformationRequest.identityNetworkId:= SHA256($PublicKey)`
  * `GetIdentityInformationRequest.includeProfileImage := false`
  * `GetIdentityInformationRequest.includeThumbnailImage := false`
  * `GetIdentityInformationRequest.includeApplicationServices := true`

and reads the response. Then it sends *ApplicationServiceAddRequest*:

  * `Message.id := 6`
  * `ApplicationServiceAddRequest.serviceNames := ["c","d","a","e"]`

and reads the response. Then it sends *GetIdentityInformationRequest*:

  * `Message.id := 7`
  * `SingleRequest.version := [1,0,0]`
  * `GetIdentityInformationRequest.identityNetworkId:= SHA256($PublicKey)`
  * `GetIdentityInformationRequest.includeProfileImage := false`
  * `GetIdentityInformationRequest.includeThumbnailImage := false`
  * `GetIdentityInformationRequest.includeApplicationServices := true`

and reads the response. Then it sends *ApplicationServiceRemoveRequest*:

  * `Message.id := 8`
  * `ApplicationServiceRemoveRequest.serviceName := "a"`

and reads the response. Then it sends *GetIdentityInformationRequest*:

  * `Message.id := 9`
  * `SingleRequest.version := [1,0,0]`
  * `GetIdentityInformationRequest.identityNetworkId:= SHA256($PublicKey)`
  * `GetIdentityInformationRequest.includeProfileImage := false`
  * `GetIdentityInformationRequest.includeThumbnailImage := false`
  * `GetIdentityInformationRequest.includeApplicationServices := true`

and reads the response. Then it sends *ApplicationServiceRemoveRequest*:

  * `Message.id := 10`
  * `ApplicationServiceRemoveRequest.serviceName := "a"`

and reads the response. Then it sends *GetIdentityInformationRequest*:

  * `Message.id := 11`
  * `SingleRequest.version := [1,0,0]`
  * `GetIdentityInformationRequest.identityNetworkId:= SHA256($PublicKey)`
  * `GetIdentityInformationRequest.includeProfileImage := false`
  * `GetIdentityInformationRequest.includeThumbnailImage := false`
  * `GetIdentityInformationRequest.includeApplicationServices := true`

and reads the response. Then it sends *ApplicationServiceAddRequest*:

  * `Message.id := 12`
  * `ApplicationServiceAddRequest.serviceNames := ["d","1234567890-1234567890-1234567890-1234567890","a","e"]`

and reads the response. Then it sends *GetIdentityInformationRequest*:

  * `Message.id := 13`
  * `SingleRequest.version := [1,0,0]`
  * `GetIdentityInformationRequest.identityNetworkId:= SHA256($PublicKey)`
  * `GetIdentityInformationRequest.includeProfileImage := false`
  * `GetIdentityInformationRequest.includeThumbnailImage := false`
  * `GetIdentityInformationRequest.includeApplicationServices := true`

and reads the response. Then it sends *ApplicationServiceAddRequest*:

  * `Message.id := 14`
  * `ApplicationServiceAddRequest.serviceNames := ["a1","a2","a3","a4","a5","a6","a7","a8","a9","a10"]`

and reads the response. Then it sends *ApplicationServiceAddRequest*:

  * `Message.id := 15`
  * `ApplicationServiceAddRequest.serviceNames := ["b1","b2","b3","b4","b5","b6","b7","b8","b9","b10"]`

and reads the response. Then it sends *GetIdentityInformationRequest*:

  * `Message.id := 16`
  * `SingleRequest.version := [1,0,0]`
  * `GetIdentityInformationRequest.identityNetworkId:= SHA256($PublicKey)`
  * `GetIdentityInformationRequest.includeProfileImage := false`
  * `GetIdentityInformationRequest.includeThumbnailImage := false`
  * `GetIdentityInformationRequest.includeApplicationServices := true`

and reads the response. Then it sends *ApplicationServiceAddRequest*:

  * `Message.id := 17`
  * `ApplicationServiceAddRequest.serviceNames := ["c1","c2","c3","c4","c5","c6","c7","c8","c9","c10","d1","d2","d3","d4","d5","d6","d7","d8","d9","d10","e1","e2","e3","e4","e5","e6","e7","e8","e9","e10"]`

and reads the response. Then it sends *GetIdentityInformationRequest*:

  * `Message.id := 18`
  * `SingleRequest.version := [1,0,0]`
  * `GetIdentityInformationRequest.identityNetworkId:= SHA256($PublicKey)`
  * `GetIdentityInformationRequest.includeProfileImage := false`
  * `GetIdentityInformationRequest.includeThumbnailImage := false`
  * `GetIdentityInformationRequest.includeApplicationServices := true`

and reads the response.


                                      

##### Acceptance Criteria


###### Step 1:
The test successfully establishes a home node agreement for its identity.

###### Step 2:
Node replies with *StartConversationResponse*:

  * `Message.id == 1`
  * `Response.status == STATUS_OK`
  * `ConversationResponse.signature` is a valid signature of $ClientChallenge
  * `StartConversationResponse.clientChallenge == $ClientChallenge`

Node replies with *CheckInResponse*:

  * `Message.id == 2`
  * `Response.status == STATUS_OK`

Node replies with *UpdateProfileResponse*:

  * `Message.id == 3`
  * `Response.status == STATUS_OK`

Node replies with *ApplicationServiceAddResponse*:

  * `Message.id == 4`
  * `Response.status == STATUS_OK`

Node replies with *GetIdentityInformationResponse*:

  * `Message.id == 5`
  * `Response.status == STATUS_OK`
  * `GetIdentityInformationResponse.isHosted == true`
  * `GetIdentityInformationResponse.isOnline == true`
  * `GetIdentityInformationResponse.identityPublicKey == $PublicKey`
  * `GetIdentityInformationResponse.applicationServices == ("a","b","c","d")`

Node replies with *ApplicationServiceAddResponse*:

  * `Message.id == 6`
  * `Response.status == STATUS_OK`

Node replies with *GetIdentityInformationResponse*:

  * `Message.id == 7`
  * `Response.status == STATUS_OK`
  * `GetIdentityInformationResponse.isHosted == true`
  * `GetIdentityInformationResponse.isOnline == true`
  * `GetIdentityInformationResponse.identityPublicKey == $PublicKey`
  * `GetIdentityInformationResponse.applicationServices == ("a","b","c","d","e")`

Node replies with *ApplicationServiceRemoveResponse*:

  * `Message.id == 8`
  * `Response.status == STATUS_OK`

Node replies with *GetIdentityInformationResponse*:

  * `Message.id == 9`
  * `Response.status == STATUS_OK`
  * `GetIdentityInformationResponse.isHosted == true`
  * `GetIdentityInformationResponse.isOnline == true`
  * `GetIdentityInformationResponse.identityPublicKey == $PublicKey`
  * `GetIdentityInformationResponse.applicationServices == ("b","c","d","e")`

Node replies with *Response*:

  * `Message.id == 10`
  * `Response.status == ERROR_NOT_FOUND`

Node replies with *GetIdentityInformationResponse*:

  * `Message.id == 11`
  * `Response.status == STATUS_OK`
  * `GetIdentityInformationResponse.isHosted == true`
  * `GetIdentityInformationResponse.isOnline == true`
  * `GetIdentityInformationResponse.identityPublicKey == $PublicKey`
  * `GetIdentityInformationResponse.applicationServices == ("b","c","d","e")`

Node replies with *Response*:

  * `Message.id == 12`
  * `Response.status == ERROR_INVALID_VALUE`
  * `Response.details == "serviceNames[1]"`

Node replies with *GetIdentityInformationResponse*:

  * `Message.id == 13`
  * `Response.status == STATUS_OK`
  * `GetIdentityInformationResponse.isHosted == true`
  * `GetIdentityInformationResponse.isOnline == true`
  * `GetIdentityInformationResponse.identityPublicKey == $PublicKey`
  * `GetIdentityInformationResponse.applicationServices == ("b","c","d","e")`

Node replies with *ApplicationServiceAddResponse*:

  * `Message.id == 14`
  * `Response.status == STATUS_OK`

Node replies with *ApplicationServiceAddResponse*:

  * `Message.id == 15`
  * `Response.status == STATUS_OK`

Node replies with *GetIdentityInformationResponse*:

  * `Message.id == 16`
  * `Response.status == STATUS_OK`
  * `GetIdentityInformationResponse.isHosted == true`
  * `GetIdentityInformationResponse.isOnline == true`
  * `GetIdentityInformationResponse.identityPublicKey == $PublicKey`
  * `GetIdentityInformationResponse.applicationServices == ("b","c","d","e","a1","a2","a3","a4","a5","a6","a7","a8","a9","a10","b1","b2","b3","b4","b5","b6","b7","b8","b9","b10")`

Node replies with *Response*:

  * `Message.id == 17`
  * `Response.status == ERROR_QUOTA_EXCEEDED`

Node replies with *GetIdentityInformationResponse*:

  * `Message.id == 18`
  * `Response.status == STATUS_OK`
  * `GetIdentityInformationResponse.isHosted == true`
  * `GetIdentityInformationResponse.isOnline == true`
  * `GetIdentityInformationResponse.identityPublicKey == $PublicKey`
  * `GetIdentityInformationResponse.applicationServices == ("b","c","d","e","a1","a2","a3","a4","a5","a6","a7","a8","a9","a10","b1","b2","b3","b4","b5","b6","b7","b8","b9","b10")`










#### HN04014 - Check-In - Invalid Signature 2

##### Prerequisites/Inputs

###### Prerequisites:
  * Node's database is empty.

###### Inputs:
  * Node's IP address
  * Node's clNonCustomer port
  * Node's clCustomer port

##### Description 

The test establishes a home node agreement with the node. Then it performs the check-in process but it uses invalid signature.

###### Step 1:
The test establishes a TLS connection to the clNonCustomer port of the node and sends *StartConversationRequest*:

  * `Message.id := 1`
  * `StartConversationRequest.supportedVersions := [[1,0,0]]`
  * `StartConversationRequest.publicKey` set to the test's identity 32 byte long public key
  * `StartConversationRequest.clientChallenge` set to 32 byte random challenge; `$ClientChallenge1 := StartConversationRequest.clientChallenge`
  
and reads the response. Then it sends *HomeNodeRequestRequest*:

  * `Message.id := 2`
  * `HomeNodeRequestRequest.contract` is uninitialized
  
and reads the response.
  
###### Step 2:
The test then closes the connection and establishes a TLS connection to the clCustomer port of the node and sends *StartConversationRequest*:

  * `Message.id := 1`
  * `StartConversationRequest.supportedVersions := [[1,0,0]]`
  * `StartConversationRequest.publicKey` set to the test's identity 32 byte long public key
  * `StartConversationRequest.clientChallenge` set to 32 byte random challenge; `$ClientChallenge2 := StartConversationRequest.clientChallenge`

and reads the response from the node in form of *StartConversationResponse*:

  * `$Challenge := StartConversationResponse.challenge`

Then it sends *CheckInRequest*:

  * `Message.id := 2`
  * `CheckInRequest.challenge := $Challenge`
  * `ConversationRequest.signature` is set to a signature of `CheckInRequest` part of the message using the test's identity private key, but only the first 32 bytes of the signature are used to make the signature invalid.
  
and reads the response.

  
##### Acceptance Criteria


###### Step 1:
Node replies with *StartConversationResponse*:

  * `Message.id == 1`
  * `Response.status == STATUS_OK`
  * `ConversationResponse.signature` is a valid signature of $ClientChallenge1
  * `StartConversationResponse.clientChallenge == $ClientChallenge1`

Node replies with *HomeNodeRequestResponse*:

  * `Message.id == 2`
  * `Response.status == STATUS_OK`


###### Step 2:
Node replies with *StartConversationResponse*:

  * `Message.id == 1`
  * `Response.status == STATUS_OK`
  * `ConversationResponse.signature` is a valid signature of $ClientChallenge2
  * `StartConversationResponse.clientChallenge == $ClientChallenge2`

Node replies with *Response*:

  * `Message.id == 2`
  * `Response.status == ERROR_INVALID_SIGNATURE`








#### HN04015 - Check-In - Invalid Challenge 2

##### Prerequisites/Inputs

###### Prerequisites:
  * Node's database is empty.

###### Inputs:
  * Node's IP address
  * Node's clNonCustomer port
  * Node's clCustomer port

##### Description 

The test establishes a home node agreement with the node. Then it performs the check-in process but it uses invalid challenge.

###### Step 1:
The test establishes a TLS connection to the clNonCustomer port of the node and sends *StartConversationRequest*:

  * `Message.id := 1`
  * `StartConversationRequest.supportedVersions := [[1,0,0]]`
  * `StartConversationRequest.publicKey` set to the test's identity 32 byte long public key
  * `StartConversationRequest.clientChallenge` set to 32 byte random challenge; `$ClientChallenge1 := StartConversationRequest.clientChallenge`
  
and reads the response. Then it sends *HomeNodeRequestRequest*:

  * `Message.id := 2`
  * `HomeNodeRequestRequest.contract` is uninitialized
  
and reads the response.
  
###### Step 2:
The test then closes the connection and establishes a TLS connection to the clCustomer port of the node and sends *StartConversationRequest*:

  * `Message.id := 1`
  * `StartConversationRequest.supportedVersions := [[1,0,0]]`
  * `StartConversationRequest.publicKey` set to the test's identity 32 byte long public key
  * `StartConversationRequest.clientChallenge` set to 32 byte random challenge; `$ClientChallenge2 := StartConversationRequest.clientChallenge`

and reads the response from the node in form of *StartConversationResponse*:

  * `$Challenge := StartConversationResponse.challenge`

Then it sends *CheckInRequest*:

  * `Message.id := 2`
  * `CheckInRequest.challenge` is set to first 16 bytes of $Challenge
  * `ConversationRequest.signature` is set to a signature of `CheckInRequest` part of the message using the test's identity private key
  
and reads the response.

  
##### Acceptance Criteria


###### Step 1:
Node replies with *StartConversationResponse*:

  * `Message.id == 1`
  * `Response.status == STATUS_OK`
  * `ConversationResponse.signature` is a valid signature of $ClientChallenge1
  * `StartConversationResponse.clientChallenge == $ClientChallenge1`

Node replies with *HomeNodeRequestResponse*:

  * `Message.id == 2`
  * `Response.status == STATUS_OK`


###### Step 2:
Node replies with *StartConversationResponse*:

  * `Message.id == 1`
  * `Response.status == STATUS_OK`
  * `ConversationResponse.signature` is a valid signature of $ClientChallenge2
  * `StartConversationResponse.clientChallenge == $ClientChallenge2`

Node replies with *Response*:

  * `Message.id == 2`
  * `Response.status == ERROR_INVALID_VALUE`
  * `Response.details == "challenge"`













### HN05xxx - Application Service Calls Related Functionality Tests

#### HN05001 - Application Service Call

##### Prerequisites/Inputs

###### Prerequisites:
  * Node's database is empty.

###### Inputs:
  * Node's IP address
  * Node's primary port


##### Description 

The test simulates two clients exchanging couple of messages in an application service all.


###### Step 1:
The test creates two identities:

  * `$PubKeyCallee` set to public key of the first identity
  * `$PubKeyCaller` set to public key of the second identity
  * `$IdentityIdCallee := SHA256($PubKeyCallee)` is the network ID of the first identity
  * `$IdentityIdCaller := SHA256($PubKeyCaller)` is the network ID of the second identity

Then it connects to the node's primary port and obtains a list of server roles using *ListRolesRequest* 
and closes the connection. Then it uses the first identity and establishes a home node agreement over 
clNonCustomer port and then it closes the connection. Then it checks-in the first identity over clCustomer 
port. The test then initializes its profile using *UpdateProfileRequest*. Finally, it checks-in 
application service called "Test Service" using *ApplicationServiceAddRequest* and leaves the connection 
open. 


###### Step 2:
Using its second identity, the test establishes a new TLS connection to the node's clNonCustomer port 
and verifies its identity using *VerifyIdentityRequest*. Then it queries information about the first 
identity using *GetIdentityInformationRequest* and leaves the connection open.


###### Step 3:
Over the existing connection, the second identity sends *CallIdentityApplicationServiceRequest*:

  * `Message.id := 4`
  * `CallIdentityApplicationServiceRequest.identityNetworkId := $IdentityIdCallee`
  * `CallIdentityApplicationServiceRequest.serviceName := "Test Service"`


###### Step 4:
The first identity reads the incoming request *IncomingCallNotificationRequest*:

  * `$calleeToken := IncomingCallNotificationRequest.calleeToken`

to which it replies with *IncomingCallNotificationResponse*.

Then it establishes a new TLS connection to the clAppService port and sends *ApplicationServiceSendMessageRequest*:

  * `Message.id := 1`
  * `SingleRequest.version := [1,0,0]`
  * `ApplicationServiceSendMessageRequest.token := $calleeToken`
  * `ApplicationServiceSendMessageRequest.message` is uninitialized


###### Step 5:

The second identity reads the response in form of *CallIdentityApplicationServiceResponse*:

  * `$callerToken := CallIdentityApplicationServiceResponse.callerToken`

Then it establishes a new TLS connection to the clAppService port and sends *ApplicationServiceSendMessageRequest*:

  * `Message.id := 1`
  * `SingleRequest.version := [1,0,0]`
  * `ApplicationServiceSendMessageRequest.token := $callerToken`
  * `ApplicationServiceSendMessageRequest.message` is uninitialized

and reads the response. Then it terminates the connection to clNonCustomer port.


###### Step 6:

On clAppService port, the first identity reads *ApplicationServiceSendMessageResponse*.

###### Step 7:

The second identity sends *ApplicationServiceSendMessageRequest*:

  * `Message.id := 2`
  * `SingleRequest.version := [1,0,0]`
  * `ApplicationServiceSendMessageRequest.token := $callerToken`
  * `ApplicationServiceSendMessageRequest.message := "Message #1 to callee."`

And then it sends *ApplicationServiceSendMessageRequest*:

  * `Message.id := 3`
  * `SingleRequest.version := [1,0,0]`
  * `ApplicationServiceSendMessageRequest.token := $callerToken`
  * `ApplicationServiceSendMessageRequest.message := "Message #2 to callee."`

And then it sends *ApplicationServiceSendMessageRequest*:

  * `Message.id := 4`
  * `SingleRequest.version := [1,0,0]`
  * `ApplicationServiceSendMessageRequest.token := $callerToken`
  * `ApplicationServiceSendMessageRequest.message := "Message #3 to callee."`


###### Step 8:

On clAppService port, the first identity reads *ApplicationServiceReceiveMessageNotificationRequest* (#1 to callee).

Then it sends *ApplicationServiceReceiveMessageNotificationResponse*. 

Then it reads *ApplicationServiceReceiveMessageNotificationRequest* (#2 to callee).

Then it sends *ApplicationServiceReceiveMessageNotificationResponse*.

And then it sends *ApplicationServiceSendMessageRequest*:

  * `Message.id := 2`
  * `SingleRequest.version := [1,0,0]`
  * `ApplicationServiceSendMessageRequest.token := $calleeToken`
  * `ApplicationServiceSendMessageRequest.message := "Message #1 to CALLER."`

and waits 3 seconds.

Then it sends *PingRequest*:

  * `Message.id := 3`
  * `SingleRequest.version := [1,0,0]`
  * `PingRequest.payload = "test"`


Then it reads *ApplicationServiceReceiveMessageNotificationRequest* (#3 to callee).

Then it reads *PingResponse*.

Then it sends *ApplicationServiceReceiveMessageNotificationResponse*.

And then it sends *ApplicationServiceSendMessageRequest*:

  * `Message.id := 4`
  * `SingleRequest.version := [1,0,0]`
  * `ApplicationServiceSendMessageRequest.token := $calleeToken`
  * `ApplicationServiceSendMessageRequest.message := "Message #2 to CALLER."`

and waits 3 seconds.


###### Step 9:

The second identity reads *ApplicationServiceSendMessageResponse* (#1 to callee received).

Then it reads *ApplicationServiceSendMessageResponse* (#2 to callee received).

Then it reads *ApplicationServiceReceiveMessageNotificationRequest* (#1 to CALLER).

Then it sends *ApplicationServiceReceiveMessageNotificationResponse*.

Then it reads *ApplicationServiceSendMessageResponse* (#3 to callee received). 

Then it reads *ApplicationServiceReceiveMessageNotificationRequest* (#2 to CALLER).

Then it sends *ApplicationServiceReceiveMessageNotificationResponse*.


###### Step 10:

On clAppService, the first identity reads *ApplicationServiceSendMessageResponse* (#1 to CALLER received).

Then it reads *ApplicationServiceSendMessageResponse* (#2 to CALLER received).



  
##### Acceptance Criteria


###### Step 1:

The test successfully obtains list of ports on which the node provides its services. 
Then the test successfully establishes a home node agreement for its first identity.
Then the test successfully checks-in this identity and initializes its profile. 
Finally, the test successfully checks-in the application service.


###### Step 2:

The test successfully verifies its second identity and obtains information about the first 
identity. The first identity should be presented as online with "Test Service" application 
service ready to be used and its public key should be equal to $PubKeyCallee.


###### Step 3:

Nothing to check.


###### Step 4:

Node sends *IncomingCallNotificationRequest*:

  * `IncomingCallNotificationRequest.callerPublicKey == $PubKeyCaller`
  * `IncomingCallNotificationRequest.serviceName == "Test Service"`


###### Step 5:

Node replies with *CallIdentityApplicationServiceResponse*:

  * `Message.id == 4`
  * `Response.status == STATUS_OK`

Node replies with *ApplicationServiceSendMessageResponse*:

  * `Message.id == 1`
  * `Response.status == STATUS_OK`


###### Step 6:

Node replies with *ApplicationServiceSendMessageResponse*:

  * `Message.id == 1`
  * `Response.status == STATUS_OK`


###### Step 7:

Nothing to check.


###### Step 8:

Node sends *ApplicationServiceReceiveMessageNotificationRequest*:

  * `SingleRequest.version == [1,0,0]`
  * `ApplicationServiceReceiveMessageNotificationRequest.message == "Message #1 to callee."`

Node sends *ApplicationServiceReceiveMessageNotificationRequest*:

  * `SingleRequest.version == [1,0,0]`
  * `ApplicationServiceReceiveMessageNotificationRequest.message == "Message #2 to callee."`

Node sends *ApplicationServiceReceiveMessageNotificationRequest*:

  * `SingleRequest.version == [1,0,0]`
  * `ApplicationServiceReceiveMessageNotificationRequest.message == "Message #3 to callee."`

Node replies with *PingResponse*:
  
  * `Message.id == 3`
  * `Response.status == STATUS_OK`
  * `SingleResponse.version == [1,0,0]`
  * `PingResponse.payload == "test"`


###### Step 9:


Node replies with *ApplicationServiceSendMessageResponse*:

  * `Message.id == 2`
  * `SingleResponse.version == [1,0,0]`
  * `Response.status == STATUS_OK`

Node replies with *ApplicationServiceSendMessageResponse*:

  * `Message.id == 3`
  * `SingleResponse.version == [1,0,0]`
  * `Response.status == STATUS_OK`

Node sends *ApplicationServiceReceiveMessageNotificationRequest*:

  * `SingleRequest.version == [1,0,0]`
  * `ApplicationServiceReceiveMessageNotificationRequest.message == "Message #1 to CALLER."`

Node replies with *ApplicationServiceSendMessageResponse*:

  * `Message.id == 4`
  * `SingleResponse.version == [1,0,0]`
  * `Response.status == STATUS_OK`

Node sends *ApplicationServiceReceiveMessageNotificationRequest*:

  * `SingleRequest.version == [1,0,0]`
  * `ApplicationServiceReceiveMessageNotificationRequest.message == "Message #2 to CALLER."`



###### Step 10:

Node replies with *ApplicationServiceSendMessageResponse*:

  * `Message.id == 2`
  * `SingleResponse.version == [1,0,0]`
  * `Response.status == STATUS_OK`

Node replies with *ApplicationServiceSendMessageResponse*:

  * `Message.id == 4`
  * `SingleResponse.version == [1,0,0]`
  * `Response.status == STATUS_OK`









#### HN05002 - Application Service Call - Extensive Test

##### Prerequisites/Inputs

###### Prerequisites:
  * Node's database is empty.

###### Inputs:
  * Node's IP address
  * Node's primary port


##### Description 

The test simulates two clients exchanging a large number of messages in an application service call 
while processing and sending message in parallel.


###### Step 1:
The test creates two identities:

  * `$PubKeyCallee` set to public key of the first identity
  * `$PubKeyCaller` set to public key of the second identity
  * `$IdentityIdCallee := SHA256($PubKeyCallee)` is the network ID of the first identity
  * `$IdentityIdCaller := SHA256($PubKeyCaller)` is the network ID of the second identity

Then it connects to the node's primary port and obtains a list of server roles using *ListRolesRequest* 
and closes the connection. Then it uses the first identity and establishes a home node agreement over 
clNonCustomer port and then it closes the connection. Then it checks-in the first identity over clCustomer 
port. The test then initializes its profile using *UpdateProfileRequest*. Finally, it checks-in 
application service called "Test Service" using *ApplicationServiceAddRequest* and leaves the connection 
open. 


###### Step 2:
Using its second identity, the test establishes a new TLS connection to the node's clNonCustomer port 
and verifies its identity using *VerifyIdentityRequest* and sends *CallIdentityApplicationServiceRequest*:

  * `Message.id := 3`
  * `CallIdentityApplicationServiceRequest.identityNetworkId := $IdentityIdCallee`
  * `CallIdentityApplicationServiceRequest.serviceName := "Test Service"`


###### Step 3:
The first identity reads the incoming request *IncomingCallNotificationRequest*:

  * `$calleeToken := IncomingCallNotificationRequest.calleeToken`

to which it replies with *IncomingCallNotificationResponse*.

Then it establishes a new TLS connection to the clAppService port and sends *ApplicationServiceSendMessageRequest*:

  * `Message.id := 1`
  * `SingleRequest.version := [1,0,0]`
  * `ApplicationServiceSendMessageRequest.token := $calleeToken`
  * `ApplicationServiceSendMessageRequest.message` is uninitialized


###### Step 4:

The second identity reads the response in form of *CallIdentityApplicationServiceResponse*:

  * `$callerToken := CallIdentityApplicationServiceResponse.callerToken`

Then it establishes a new TLS connection to the clAppService port and sends *ApplicationServiceSendMessageRequest*:

  * `Message.id := 1`
  * `SingleRequest.version := [1,0,0]`
  * `ApplicationServiceSendMessageRequest.token := $callerToken`
  * `ApplicationServiceSendMessageRequest.message` is uninitialized

and reads the response. Then it terminates the connection to clNonCustomer port.


###### Step 5:

On clAppService port, the first identity reads *ApplicationServiceSendMessageResponse*.




###### Step 6:

Both identities then starts a message processing loop that will handle incoming messages 
over the established call. This means that for every *ApplicationServiceReceiveMessageNotificationRequest* 
message they receive, they will reply with corresponding *ApplicationServiceReceiveMessageNotificationResponse*.

Then each identity starts a message sending loop, in which each identity generates 100 
messages with random content of 4 to 10000 bytes and sends them to the other party with 
a random delay between 0 ms and 200 ms. 

The recipient of a such a message has to store it and when 1000 messages are received, 
it calculates an SHA256 hash from all messages concatenated together. Then the hashes 
are compared with their expected values counted in the sending loops.
                                  

  
##### Acceptance Criteria


###### Step 1:

The test successfully obtains list of ports on which the node provides its services. 
Then the test successfully establishes a home node agreement for its first identity.
Then the test successfully checks-in this identity and initializes its profile. 
Finally, the test successfully checks-in the application service.


###### Step 2:

The test successfully verifies its second identity.


###### Step 3:

Node sends *IncomingCallNotificationRequest*:

  * `IncomingCallNotificationRequest.callerPublicKey == $PubKeyCaller`
  * `IncomingCallNotificationRequest.serviceName == "Test Service"`


###### Step 4:

Node replies with *CallIdentityApplicationServiceResponse*:

  * `Message.id == 3`
  * `Response.status == STATUS_OK`

Node replies with *ApplicationServiceSendMessageResponse*:

  * `Message.id == 1`
  * `Response.status == STATUS_OK`


###### Step 5:

Node replies with *ApplicationServiceSendMessageResponse*:

  * `Message.id == 1`
  * `Response.status == STATUS_OK`


###### Step 6:

The final hashes of messages on both sides match their expected values.





#### HN05003 - Application Service Call - Extensive Test 2

##### Prerequisites/Inputs

###### Prerequisites:
  * Node's database is empty.

###### Inputs:
  * Node's IP address
  * Node's primary port


##### Description 

The test simulates three pairs of clients exchanging a large number of messages in an application 
service call while processing and sending message in parallel.

The implementation just runs the code of HN05002 in three parallel instances.


##### Acceptance Criteria

Same as in HN05002, just considering three pairs of clients.






#### HN05004 - Application Service Call - Extensive Test 3

##### Prerequisites/Inputs

###### Prerequisites:
  * Node's database is empty.

###### Inputs:
  * Node's IP address
  * Node's primary port


##### Description 

The test simulates two pairs of clients exchanging a large number of messages in an application 
service call while processing and sending message in parallel.

The implementation just runs the code of HN05002 in two parallel instances.

The difference over HN05003 here is that in this test the callee is the same for both pairs.


##### Acceptance Criteria

Same as in HN05002, just considering two pairs of clients.







#### HN05005 - Disconnection of Inactive TCP Client from AppService Port

##### Prerequisites/Inputs

###### Prerequisites:
  * Node's database is empty.

###### Inputs:
  * Node's IP address
  * Node's primary port


##### Description 

The test simulates two clients exchanging a couple of messages in an application service call 
and then they wait 180 seconds without sending a message, which is followed by an attempt 
to send next message. This should fail as the clients should be disconnected due to inactivity.


###### Step 1:

The test creates two identities:

  * `$PubKeyCallee` set to public key of the first identity
  * `$PubKeyCaller` set to public key of the second identity
  * `$IdentityIdCallee := SHA256($PubKeyCallee)` is the network ID of the first identity
  * `$IdentityIdCaller := SHA256($PubKeyCaller)` is the network ID of the second identity

Then it connects to the node's primary port and obtains a list of server roles using *ListRolesRequest* 
and closes the connection. Then it uses the first identity and establishes a home node agreement over 
clNonCustomer port and then it closes the connection. Then it checks-in the first identity over clCustomer 
port. The test then initializes its profile using *UpdateProfileRequest*. Finally, it checks-in 
application service called "Test Service" using *ApplicationServiceAddRequest* and leaves the connection 
open. 


###### Step 2:

Using its second identity, the test establishes a new TLS connection to the node's clNonCustomer port 
and verifies its identity using *VerifyIdentityRequest* and sends *CallIdentityApplicationServiceRequest*:

  * `Message.id := 3`
  * `CallIdentityApplicationServiceRequest.identityNetworkId := $IdentityIdCallee`
  * `CallIdentityApplicationServiceRequest.serviceName := "Test Service"`


###### Step 3:

The first identity reads the incoming request *IncomingCallNotificationRequest*:

  * `$calleeToken := IncomingCallNotificationRequest.calleeToken`

to which it replies with *IncomingCallNotificationResponse*.

Then it establishes a new TLS connection to the clAppService port and sends *ApplicationServiceSendMessageRequest*:

  * `Message.id := 1`
  * `SingleRequest.version := [1,0,0]`
  * `ApplicationServiceSendMessageRequest.token := $calleeToken`
  * `ApplicationServiceSendMessageRequest.message` is uninitialized


###### Step 4:

The second identity reads the response in form of *CallIdentityApplicationServiceResponse*:

  * `$callerToken := CallIdentityApplicationServiceResponse.callerToken`

Then it establishes a new TLS connection to the clAppService port and sends *ApplicationServiceSendMessageRequest*:

  * `Message.id := 1`
  * `SingleRequest.version := [1,0,0]`
  * `ApplicationServiceSendMessageRequest.token := $callerToken`
  * `ApplicationServiceSendMessageRequest.message` is uninitialized

and reads the response. Then it terminates the connection to clNonCustomer port.


###### Step 5:

On clAppService port, the first identity reads *ApplicationServiceSendMessageResponse*.


###### Step 6:

The second identity sends *ApplicationServiceSendMessageRequest*:

  * `Message.id := 2`
  * `SingleRequest.version := [1,0,0]`
  * `ApplicationServiceSendMessageRequest.token := $callerToken`
  * `ApplicationServiceSendMessageRequest.message := "Message #1 to callee."`


###### Step 7:

On clAppService port, the first identity reads *ApplicationServiceReceiveMessageNotificationRequest* (#1 to callee).

Then it sends *ApplicationServiceReceiveMessageNotificationResponse*. 

And then it sends *ApplicationServiceSendMessageRequest*:

  * `Message.id := 2`
  * `SingleRequest.version := [1,0,0]`
  * `ApplicationServiceSendMessageRequest.token := $calleeToken`
  * `ApplicationServiceSendMessageRequest.message := "Message #1 to CALLER."`


###### Step 8:

The second identity reads *ApplicationServiceSendMessageResponse* (#1 to callee received).

Then it reads *ApplicationServiceReceiveMessageNotificationRequest* (#1 to CALLER).

Then it sends *ApplicationServiceReceiveMessageNotificationResponse*. 


###### Step 9:

The first identity reads *ApplicationServiceSendMessageResponse* (#1 to CALLER received).

Then both identities do nothing for 180 seconds.


###### Step 10:

The second identity sends *ApplicationServiceSendMessageRequest*:

  * `Message.id := 3`
  * `SingleRequest.version := [1,0,0]`
  * `ApplicationServiceSendMessageRequest.token := $callerToken`
  * `ApplicationServiceSendMessageRequest.message := "Message #2 to callee."`

and reads the response. 


###### Step 11:

On clAppService, the first identity sends *ApplicationServiceSendMessageRequest*:

  * `Message.id := 3`
  * `SingleRequest.version := [1,0,0]`
  * `ApplicationServiceSendMessageRequest.token := $callerToken`
  * `ApplicationServiceSendMessageRequest.message := "Message #2 to CALLER."`

and reads the response. 


  
##### Acceptance Criteria


###### Step 1:

The test successfully obtains list of ports on which the node provides its services. 
Then the test successfully establishes a home node agreement for its first identity.
Then the test successfully checks-in this identity and initializes its profile. 
Finally, the test successfully checks-in the application service.


###### Step 2:

The test successfully verifies its second identity.


###### Step 3:

Node sends *IncomingCallNotificationRequest*:

  * `IncomingCallNotificationRequest.callerPublicKey == $PubKeyCaller`
  * `IncomingCallNotificationRequest.serviceName == "Test Service"`


###### Step 4:

Node replies with *CallIdentityApplicationServiceResponse*:

  * `Message.id == 3`
  * `Response.status == STATUS_OK`

Node replies with *ApplicationServiceSendMessageResponse*:

  * `Message.id == 1`
  * `Response.status == STATUS_OK`


###### Step 5:

Node replies with *ApplicationServiceSendMessageResponse*:

  * `Message.id == 1`
  * `Response.status == STATUS_OK`


###### Step 6:

Nothing to check.


###### Step 7:

Node sends *ApplicationServiceReceiveMessageNotificationRequest*:

  * `SingleRequest.version == [1,0,0]`
  * `ApplicationServiceReceiveMessageNotificationRequest.message == "Message #1 to callee."`


###### Step 8:

Node replies with *ApplicationServiceSendMessageResponse*:

  * `Message.id == 2`
  * `SingleResponse.version == [1,0,0]`
  * `Response.status == STATUS_OK`

Node sends *ApplicationServiceReceiveMessageNotificationRequest*:

  * `SingleRequest.version == [1,0,0]`
  * `ApplicationServiceReceiveMessageNotificationRequest.message == "Message #1 to CALLER."`


###### Step 9:

Node replies with *ApplicationServiceSendMessageResponse*:

  * `Message.id == 2`
  * `SingleResponse.version == [1,0,0]`
  * `Response.status == STATUS_OK`


###### Step 10:

Node disconnects the second identity and this prevents it to send the message or read a response.


###### Step 11:

Node disconnects the first identity and this prevents it to send the message or read a response.














#### HN05006 - Call Identity Application Service - Not Available 1

##### Prerequisites/Inputs

###### Inputs:
  * Node's IP address
  * Node's primary port

##### Description 

The test tries to call identity which is not online.

###### Step 1:

The test creates two identities:

  * `$PubKeyCallee` set to public key of the first identity
  * `$PubKeyCaller` set to public key of the second identity
  * `$IdentityIdCallee := SHA256($PubKeyCallee)` is the network ID of the first identity
  * `$IdentityIdCaller := SHA256($PubKeyCaller)` is the network ID of the second identity

Then it connects to the node's primary port and obtains a list of server roles using *ListRolesRequest* 
and closes the connection. Then it uses the first identity and establishes a home node agreement over 
clNonCustomer port and then it closes the connection. Then it checks-in the first identity over clCustomer 
port. The test then initializes its profile using *UpdateProfileRequest*. 


###### Step 2:

Using its second identity, the test establishes a new TLS connection to the node's clNonCustomer port 
and verifies its identity using *VerifyIdentityRequest* and sends *CallIdentityApplicationServiceRequest*:

  * `Message.id := 3`
  * `CallIdentityApplicationServiceRequest.identityNetworkId := $IdentityIdCallee`
  * `CallIdentityApplicationServiceRequest.serviceName := "Test Service"`

and reads the response.

##### Acceptance Criteria

###### Step 1:

The test successfully obtains list of ports on which the node provides its services. 
Then the test successfully establishes a home node agreement for its first identity.
Then the test successfully checks-in this identity and initializes its profile. 


###### Step 2:

The test successfully verifies its second identity.

Node replies with *Response*:

  * `Message.id == 3`
  * `Response.status == ERROR_NOT_AVAILABLE`






#### HN05007 - Call Identity Application Service - Not Available 2

##### Prerequisites/Inputs

###### Inputs:
  * Node's IP address
  * Node's primary port

##### Description 

The test tries to call identity which is online, but it does not reply to incoming call requests.

###### Step 1:

The test creates two identities:

  * `$PubKeyCallee` set to public key of the first identity
  * `$PubKeyCaller` set to public key of the second identity
  * `$IdentityIdCallee := SHA256($PubKeyCallee)` is the network ID of the first identity
  * `$IdentityIdCaller := SHA256($PubKeyCaller)` is the network ID of the second identity

Then it connects to the node's primary port and obtains a list of server roles using *ListRolesRequest* 
and closes the connection. Then it uses the first identity and establishes a home node agreement over 
clNonCustomer port and then it closes the connection. Then it checks-in the first identity over clCustomer 
port. The test then initializes its profile using *UpdateProfileRequest*. Finally, it checks-in 
application service called "Test Service" using *ApplicationServiceAddRequest* and leaves the connection 
open. 


###### Step 2:

Using its second identity, the test establishes a new TLS connection to the node's clNonCustomer port 
and verifies its identity using *VerifyIdentityRequest* and sends *CallIdentityApplicationServiceRequest*:

  * `Message.id := 3`
  * `CallIdentityApplicationServiceRequest.identityNetworkId := $IdentityIdCallee`
  * `CallIdentityApplicationServiceRequest.serviceName := "Test Service"`

and reads the response.


##### Acceptance Criteria

###### Step 1:

The test successfully obtains list of ports on which the node provides its services. 
Then the test successfully establishes a home node agreement for its first identity.
Then the test successfully checks-in this identity and initializes its profile. 
Finally, the test successfully checks-in the application service.


###### Step 2:

The test successfully verifies its second identity.

Node replies with *Response*:

  * `Message.id == 3`
  * `Response.status == ERROR_NOT_AVAILABLE`














#### HN05008 - Call Identity Application Service - Not Available 3

##### Prerequisites/Inputs

###### Inputs:
  * Node's IP address
  * Node's primary port

##### Description 

The test tries to call identity which is online, but it disconnects.

###### Step 1:

The test creates two identities:

  * `$PubKeyCallee` set to public key of the first identity
  * `$PubKeyCaller` set to public key of the second identity
  * `$IdentityIdCallee := SHA256($PubKeyCallee)` is the network ID of the first identity
  * `$IdentityIdCaller := SHA256($PubKeyCaller)` is the network ID of the second identity

Then it connects to the node's primary port and obtains a list of server roles using *ListRolesRequest* 
and closes the connection. Then it uses the first identity and establishes a home node agreement over 
clNonCustomer port and then it closes the connection. Then it checks-in the first identity over clCustomer 
port. The test then initializes its profile using *UpdateProfileRequest*. Finally, it checks-in 
application service called "Test Service" using *ApplicationServiceAddRequest* and leaves the connection 
open. 


###### Step 2:

Using its second identity, the test establishes a new TLS connection to the node's clNonCustomer port 
and verifies its identity using *VerifyIdentityRequest* and sends *CallIdentityApplicationServiceRequest*:

  * `Message.id := 3`
  * `CallIdentityApplicationServiceRequest.identityNetworkId := $IdentityIdCallee`
  * `CallIdentityApplicationServiceRequest.serviceName := "Test Service"`


###### Step 3:

After waiting 2 seconds, the first identity disconnects.


###### Step 4:

The second identity reads the response.


##### Acceptance Criteria

###### Step 1:

The test successfully obtains list of ports on which the node provides its services. 
Then the test successfully establishes a home node agreement for its first identity.
Then the test successfully checks-in this identity and initializes its profile. 
Finally, the test successfully checks-in the application service.


###### Step 2:

The test successfully verifies its second identity.

###### Step 3:

Nothing to check.

###### Step 4:

Node replies with *Response*:

  * `Message.id == 3`
  * `Response.status == ERROR_NOT_AVAILABLE`






#### HN05009 - Call Identity Application Service - Invalid Service Name

##### Prerequisites/Inputs

###### Inputs:
  * Node's IP address
  * Node's primary port

##### Description 

The test tries to call identity which is online, but it does not reply to incoming call requests.

###### Step 1:

The test creates two identities:

  * `$PubKeyCallee` set to public key of the first identity
  * `$PubKeyCaller` set to public key of the second identity
  * `$IdentityIdCallee := SHA256($PubKeyCallee)` is the network ID of the first identity
  * `$IdentityIdCaller := SHA256($PubKeyCaller)` is the network ID of the second identity

Then it connects to the node's primary port and obtains a list of server roles using *ListRolesRequest* 
and closes the connection. Then it uses the first identity and establishes a home node agreement over 
clNonCustomer port and then it closes the connection. Then it checks-in the first identity over clCustomer 
port. The test then initializes its profile using *UpdateProfileRequest*. Finally, it checks-in 
application service called "Test Service" using *ApplicationServiceAddRequest* and leaves the connection 
open. 


###### Step 2:

Using its second identity, the test establishes a new TLS connection to the node's clNonCustomer port 
and verifies its identity using *VerifyIdentityRequest* and sends *CallIdentityApplicationServiceRequest*:

  * `Message.id := 3`
  * `CallIdentityApplicationServiceRequest.identityNetworkId := $IdentityIdCallee`
  * `CallIdentityApplicationServiceRequest.serviceName := "Test Service Invalid"`

and reads the response.

##### Acceptance Criteria

###### Step 1:

The test successfully obtains list of ports on which the node provides its services. 
Then the test successfully establishes a home node agreement for its first identity.
Then the test successfully checks-in this identity and initializes its profile. 
Finally, the test successfully checks-in the application service.


###### Step 2:

The test successfully verifies its second identity.

Node replies with *Response*:

  * `Message.id == 3`
  * `Response.status == ERROR_INVALID_VALUE`
  * `Response.details == "serviceName"`








#### HN05010 - Call Identity Application Service - Rejected

##### Prerequisites/Inputs

###### Prerequisites:
  * Node's database is empty.

###### Inputs:
  * Node's IP address
  * Node's primary port


##### Description 

The test tries to call identity which is online, but it rejects the call.


###### Step 1:

The test creates two identities:

  * `$PubKeyCallee` set to public key of the first identity
  * `$PubKeyCaller` set to public key of the second identity
  * `$IdentityIdCallee := SHA256($PubKeyCallee)` is the network ID of the first identity
  * `$IdentityIdCaller := SHA256($PubKeyCaller)` is the network ID of the second identity

Then it connects to the node's primary port and obtains a list of server roles using *ListRolesRequest* 
and closes the connection. Then it uses the first identity and establishes a home node agreement over 
clNonCustomer port and then it closes the connection. Then it checks-in the first identity over clCustomer 
port. The test then initializes its profile using *UpdateProfileRequest*. Finally, it checks-in 
application service called "Test Service" using *ApplicationServiceAddRequest* and leaves the connection 
open. 


###### Step 2:

Using its second identity, the test establishes a new TLS connection to the node's clNonCustomer port 
and verifies its identity using *VerifyIdentityRequest* and sends *CallIdentityApplicationServiceRequest*:

  * `Message.id := 3`
  * `CallIdentityApplicationServiceRequest.identityNetworkId := $IdentityIdCallee`
  * `CallIdentityApplicationServiceRequest.serviceName := "Test Service"`


###### Step 3:

The first identity reads the incoming request *IncomingCallNotificationRequest*,
to which it replies with *Response*:

  * `Response.status == ERROR_REJECTED`


###### Step 4:

The second identity reads the response.


  
##### Acceptance Criteria


###### Step 1:

The test successfully obtains list of ports on which the node provides its services. 
Then the test successfully establishes a home node agreement for its first identity.
Then the test successfully checks-in this identity and initializes its profile. 
Finally, the test successfully checks-in the application service.


###### Step 2:

The test successfully verifies its second identity.


###### Step 3:

Node sends *IncomingCallNotificationRequest*:

  * `IncomingCallNotificationRequest.callerPublicKey == $PubKeyCaller`
  * `IncomingCallNotificationRequest.serviceName == "Test Service"`


###### Step 4:

Node replies with *Response*:

  * `Message.id == 3`
  * `Response.status == ERROR_REJECTED`














#### HN05011 - Callee Fails AppService Port Initialization - No Connection

##### Prerequisites/Inputs

###### Prerequisites:
  * Node's database is empty.

###### Inputs:
  * Node's IP address
  * Node's primary port


##### Description 

A customer client is being called by a caller and it accepts the call, but then it fails to 
connect to the clAppService port.


###### Step 1:

The test creates two identities:

  * `$PubKeyCallee` set to public key of the first identity
  * `$PubKeyCaller` set to public key of the second identity
  * `$IdentityIdCallee := SHA256($PubKeyCallee)` is the network ID of the first identity
  * `$IdentityIdCaller := SHA256($PubKeyCaller)` is the network ID of the second identity

Then it connects to the node's primary port and obtains a list of server roles using *ListRolesRequest* 
and closes the connection. Then it uses the first identity and establishes a home node agreement over 
clNonCustomer port and then it closes the connection. Then it checks-in the first identity over clCustomer 
port. The test then initializes its profile using *UpdateProfileRequest*. Finally, it checks-in 
application service called "Test Service" using *ApplicationServiceAddRequest* and leaves the connection 
open. 


###### Step 2:

Using its second identity, the test establishes a new TLS connection to the node's clNonCustomer port 
and verifies its identity using *VerifyIdentityRequest* and sends *CallIdentityApplicationServiceRequest*:

  * `Message.id := 3`
  * `CallIdentityApplicationServiceRequest.identityNetworkId := $IdentityIdCallee`
  * `CallIdentityApplicationServiceRequest.serviceName := "Test Service"`


###### Step 3:

The first identity reads the incoming request *IncomingCallNotificationRequest*:

  * `$calleeToken := IncomingCallNotificationRequest.calleeToken`

to which it replies with *IncomingCallNotificationResponse*.


###### Step 4:

The second identity reads the response in form of *CallIdentityApplicationServiceResponse*:

  * `$callerToken := CallIdentityApplicationServiceResponse.callerToken`

Then it establishes a new TLS connection to the clAppService port and sends *ApplicationServiceSendMessageRequest*:

  * `Message.id := 1`
  * `SingleRequest.version := [1,0,0]`
  * `ApplicationServiceSendMessageRequest.token := $callerToken`
  * `ApplicationServiceSendMessageRequest.message` is uninitialized

and reads the response. 


  
##### Acceptance Criteria


###### Step 1:

The test successfully obtains list of ports on which the node provides its services. 
Then the test successfully establishes a home node agreement for its first identity.
Then the test successfully checks-in this identity and initializes its profile. 
Finally, the test successfully checks-in the application service.


###### Step 2:

The test successfully verifies its second identity.


###### Step 3:

Node sends *IncomingCallNotificationRequest*:

  * `IncomingCallNotificationRequest.callerPublicKey == $PubKeyCaller`
  * `IncomingCallNotificationRequest.serviceName == "Test Service"`


###### Step 4:

Node replies with *CallIdentityApplicationServiceResponse*:

  * `Message.id == 3`
  * `Response.status == STATUS_OK`

Node replies with *Response*:

  * `Message.id == 1`
  * `Response.status == ERROR_NOT_FOUND`










#### HN05012 - Caller Fails AppService Port Initialization - No Connection

##### Prerequisites/Inputs

###### Prerequisites:
  * Node's database is empty.

###### Inputs:
  * Node's IP address
  * Node's primary port


##### Description 

A customer client is being called by a caller and it accepts the call, but then the caller fails to 
connect to the clAppService port.


###### Step 1:

The test creates two identities:

  * `$PubKeyCallee` set to public key of the first identity
  * `$PubKeyCaller` set to public key of the second identity
  * `$IdentityIdCallee := SHA256($PubKeyCallee)` is the network ID of the first identity
  * `$IdentityIdCaller := SHA256($PubKeyCaller)` is the network ID of the second identity

Then it connects to the node's primary port and obtains a list of server roles using *ListRolesRequest* 
and closes the connection. Then it uses the first identity and establishes a home node agreement over 
clNonCustomer port and then it closes the connection. Then it checks-in the first identity over clCustomer 
port. The test then initializes its profile using *UpdateProfileRequest*. Finally, it checks-in 
application service called "Test Service" using *ApplicationServiceAddRequest* and leaves the connection 
open. 


###### Step 2:

Using its second identity, the test establishes a new TLS connection to the node's clNonCustomer port 
and verifies its identity using *VerifyIdentityRequest* and sends *CallIdentityApplicationServiceRequest*:

  * `Message.id := 3`
  * `CallIdentityApplicationServiceRequest.identityNetworkId := $IdentityIdCallee`
  * `CallIdentityApplicationServiceRequest.serviceName := "Test Service"`


###### Step 3:

The first identity reads the incoming request *IncomingCallNotificationRequest*:

  * `$calleeToken := IncomingCallNotificationRequest.calleeToken`

to which it replies with *IncomingCallNotificationResponse*.


Then it establishes a new TLS connection to the clAppService port and sends *ApplicationServiceSendMessageRequest*:

  * `Message.id := 1`
  * `SingleRequest.version := [1,0,0]`
  * `ApplicationServiceSendMessageRequest.token := $calleeToken`
  * `ApplicationServiceSendMessageRequest.message` is uninitialized


###### Step 4:

The second identity reads the response in form of *CallIdentityApplicationServiceResponse*.


###### Step 5

The first identity reads the response.



  
##### Acceptance Criteria


###### Step 1:

The test successfully obtains list of ports on which the node provides its services. 
Then the test successfully establishes a home node agreement for its first identity.
Then the test successfully checks-in this identity and initializes its profile. 
Finally, the test successfully checks-in the application service.


###### Step 2:

The test successfully verifies its second identity.


###### Step 3:

Node sends *IncomingCallNotificationRequest*:

  * `IncomingCallNotificationRequest.callerPublicKey == $PubKeyCaller`
  * `IncomingCallNotificationRequest.serviceName == "Test Service"`


###### Step 4:

Node replies with *CallIdentityApplicationServiceResponse*:

  * `Message.id == 3`
  * `Response.status == STATUS_OK`


###### Step 5:

Node replies with *Response*:

  * `Message.id == 1`
  * `Response.status == ERROR_NOT_FOUND`










#### HN05013 - Application Service Callee Disconnects After Initialization

##### Prerequisites/Inputs

###### Prerequisites:
  * Node's database is empty.

###### Inputs:
  * Node's IP address
  * Node's primary port


##### Description 

A customer client is being called by a caller and it accepts the call and sends and initialization 
message over the clAppService port, but then it disconnects immediately.


###### Step 1:

The test creates two identities:

  * `$PubKeyCallee` set to public key of the first identity
  * `$PubKeyCaller` set to public key of the second identity
  * `$IdentityIdCallee := SHA256($PubKeyCallee)` is the network ID of the first identity
  * `$IdentityIdCaller := SHA256($PubKeyCaller)` is the network ID of the second identity

Then it connects to the node's primary port and obtains a list of server roles using *ListRolesRequest* 
and closes the connection. Then it uses the first identity and establishes a home node agreement over 
clNonCustomer port and then it closes the connection. Then it checks-in the first identity over clCustomer 
port. The test then initializes its profile using *UpdateProfileRequest*. Finally, it checks-in 
application service called "Test Service" using *ApplicationServiceAddRequest* and leaves the connection 
open. 


###### Step 2:

Using its second identity, the test establishes a new TLS connection to the node's clNonCustomer port 
and verifies its identity using *VerifyIdentityRequest* and sends *CallIdentityApplicationServiceRequest*:

  * `Message.id := 3`
  * `CallIdentityApplicationServiceRequest.identityNetworkId := $IdentityIdCallee`
  * `CallIdentityApplicationServiceRequest.serviceName := "Test Service"`


###### Step 3:

The first identity reads the incoming request *IncomingCallNotificationRequest*:

  * `$calleeToken := IncomingCallNotificationRequest.calleeToken`

to which it replies with *IncomingCallNotificationResponse*.

Then it establishes a new TLS connection to the clAppService port and sends *ApplicationServiceSendMessageRequest*:

  * `Message.id := 1`
  * `SingleRequest.version := [1,0,0]`
  * `ApplicationServiceSendMessageRequest.token := $calleeToken`
  * `ApplicationServiceSendMessageRequest.message` is uninitialized


###### Step 4:

The second identity reads the response in form of *CallIdentityApplicationServiceResponse*:

  * `$callerToken := CallIdentityApplicationServiceResponse.callerToken`

Then it establishes a new TLS connection to the clAppService port and sends *ApplicationServiceSendMessageRequest*:

  * `Message.id := 1`
  * `SingleRequest.version := [1,0,0]`
  * `ApplicationServiceSendMessageRequest.token := $callerToken`
  * `ApplicationServiceSendMessageRequest.message` is uninitialized

and reads the response. Then it terminates the connection to clNonCustomer port.


###### Step 5:

On clAppService port, the first identity reads *ApplicationServiceSendMessageResponse* and disconnects.


###### Step 6:

After waiting 2 seconds, the second identity sends *ApplicationServiceSendMessageRequest*:

  * `Message.id := 2`
  * `SingleRequest.version := [1,0,0]`
  * `ApplicationServiceSendMessageRequest.token := $callerToken`
  * `ApplicationServiceSendMessageRequest.message := "Message #1 to callee."`

and reads the response. 


  
##### Acceptance Criteria


###### Step 1:

The test successfully obtains list of ports on which the node provides its services. 
Then the test successfully establishes a home node agreement for its first identity.
Then the test successfully checks-in this identity and initializes its profile. 
Finally, the test successfully checks-in the application service.


###### Step 2:

The test successfully verifies its second identity.


###### Step 3:

Node sends *IncomingCallNotificationRequest*:

  * `IncomingCallNotificationRequest.callerPublicKey == $PubKeyCaller`
  * `IncomingCallNotificationRequest.serviceName == "Test Service"`


###### Step 4:

Node replies with *CallIdentityApplicationServiceResponse*:

  * `Message.id == 3`
  * `Response.status == STATUS_OK`

Node replies with *ApplicationServiceSendMessageResponse*:

  * `Message.id == 1`
  * `Response.status == STATUS_OK`


###### Step 5:

Node replies with *ApplicationServiceSendMessageResponse*:

  * `Message.id == 1`
  * `Response.status == STATUS_OK`


###### Step 6:

The client should be disconnected then and this should prevent sending the second message or receiving a response.










#### HN05014 - Application Service Callee Disconnects After Initialization 2

##### Prerequisites/Inputs

###### Prerequisites:
  * Node's database is empty.

###### Inputs:
  * Node's IP address
  * Node's primary port


##### Description 

A customer client is being called by a caller and it accepts the call and sends and initialization 
message over the clAppService port, but then it disconnects after a couple of seconds.


###### Step 1:

The test creates two identities:

  * `$PubKeyCallee` set to public key of the first identity
  * `$PubKeyCaller` set to public key of the second identity
  * `$IdentityIdCallee := SHA256($PubKeyCallee)` is the network ID of the first identity
  * `$IdentityIdCaller := SHA256($PubKeyCaller)` is the network ID of the second identity

Then it connects to the node's primary port and obtains a list of server roles using *ListRolesRequest* 
and closes the connection. Then it uses the first identity and establishes a home node agreement over 
clNonCustomer port and then it closes the connection. Then it checks-in the first identity over clCustomer 
port. The test then initializes its profile using *UpdateProfileRequest*. Finally, it checks-in 
application service called "Test Service" using *ApplicationServiceAddRequest* and leaves the connection 
open. 


###### Step 2:

Using its second identity, the test establishes a new TLS connection to the node's clNonCustomer port 
and verifies its identity using *VerifyIdentityRequest* and sends *CallIdentityApplicationServiceRequest*:

  * `Message.id := 3`
  * `CallIdentityApplicationServiceRequest.identityNetworkId := $IdentityIdCallee`
  * `CallIdentityApplicationServiceRequest.serviceName := "Test Service"`


###### Step 3:

The first identity reads the incoming request *IncomingCallNotificationRequest*:

  * `$calleeToken := IncomingCallNotificationRequest.calleeToken`

to which it replies with *IncomingCallNotificationResponse*.

Then it establishes a new TLS connection to the clAppService port and sends *ApplicationServiceSendMessageRequest*:

  * `Message.id := 1`
  * `SingleRequest.version := [1,0,0]`
  * `ApplicationServiceSendMessageRequest.token := $calleeToken`
  * `ApplicationServiceSendMessageRequest.message` is uninitialized


###### Step 4:

The second identity reads the response in form of *CallIdentityApplicationServiceResponse*:

  * `$callerToken := CallIdentityApplicationServiceResponse.callerToken`

Then it establishes a new TLS connection to the clAppService port and sends *ApplicationServiceSendMessageRequest*:

  * `Message.id := 1`
  * `SingleRequest.version := [1,0,0]`
  * `ApplicationServiceSendMessageRequest.token := $callerToken`
  * `ApplicationServiceSendMessageRequest.message` is uninitialized

and reads the response. Then it terminates the connection to clNonCustomer port.


###### Step 5:

On clAppService port, the first identity reads *ApplicationServiceSendMessageResponse*.


###### Step 6:

The second identity sends *ApplicationServiceSendMessageRequest*:

  * `Message.id := 2`
  * `SingleRequest.version := [1,0,0]`
  * `ApplicationServiceSendMessageRequest.token := $callerToken`
  * `ApplicationServiceSendMessageRequest.message := "Message #1 to callee."`


###### Step 7:

After waiting 2 seconds, the first identity disconnects from clAppService port.


###### Step 8:

The second identity reads the response and then it sends *ApplicationServiceSendMessageRequest*:

  * `Message.id := 3`
  * `SingleRequest.version := [1,0,0]`
  * `ApplicationServiceSendMessageRequest.token := $callerToken`
  * `ApplicationServiceSendMessageRequest.message := "Message #2 to callee."`

and reads the response.



  
##### Acceptance Criteria


###### Step 1:

The test successfully obtains list of ports on which the node provides its services. 
Then the test successfully establishes a home node agreement for its first identity.
Then the test successfully checks-in this identity and initializes its profile. 
Finally, the test successfully checks-in the application service.


###### Step 2:

The test successfully verifies its second identity.


###### Step 3:

Node sends *IncomingCallNotificationRequest*:

  * `IncomingCallNotificationRequest.callerPublicKey == $PubKeyCaller`
  * `IncomingCallNotificationRequest.serviceName == "Test Service"`


###### Step 4:

Node replies with *CallIdentityApplicationServiceResponse*:

  * `Message.id == 3`
  * `Response.status == STATUS_OK`

Node replies with *ApplicationServiceSendMessageResponse*:

  * `Message.id == 1`
  * `Response.status == STATUS_OK`


###### Step 5:

Node replies with *ApplicationServiceSendMessageResponse*:

  * `Message.id == 1`
  * `Response.status == STATUS_OK`


###### Step 6:

Nothing to check.


###### Step 7:

Nothing to check.


###### Step 8:

Node replies with *Response*:

  * `Message.id == 2`
  * `Response.status == ERROR_NOT_FOUND`


The client should be disconnected then and this should prevent sending the second message or receiving a response.



















#### HN05015 - Application Service Caller Uses Invalid Token

##### Prerequisites/Inputs

###### Prerequisites:
  * Node's database is empty.

###### Inputs:
  * Node's IP address
  * Node's primary port


##### Description 

A customer client is being called by a caller and it accepts the call and sends and initialization 
message over the clAppService port. The caller then uses an invalid caller's token to send a message.


###### Step 1:

The test creates two identities:

  * `$PubKeyCallee` set to public key of the first identity
  * `$PubKeyCaller` set to public key of the second identity
  * `$IdentityIdCallee := SHA256($PubKeyCallee)` is the network ID of the first identity
  * `$IdentityIdCaller := SHA256($PubKeyCaller)` is the network ID of the second identity

Then it connects to the node's primary port and obtains a list of server roles using *ListRolesRequest* 
and closes the connection. Then it uses the first identity and establishes a home node agreement over 
clNonCustomer port and then it closes the connection. Then it checks-in the first identity over clCustomer 
port. The test then initializes its profile using *UpdateProfileRequest*. Finally, it checks-in 
application service called "Test Service" using *ApplicationServiceAddRequest* and leaves the connection 
open. 


###### Step 2:

Using its second identity, the test establishes a new TLS connection to the node's clNonCustomer port 
and verifies its identity using *VerifyIdentityRequest* and sends *CallIdentityApplicationServiceRequest*:

  * `Message.id := 3`
  * `CallIdentityApplicationServiceRequest.identityNetworkId := $IdentityIdCallee`
  * `CallIdentityApplicationServiceRequest.serviceName := "Test Service"`


###### Step 3:

The first identity reads the incoming request *IncomingCallNotificationRequest*:

  * `$calleeToken := IncomingCallNotificationRequest.calleeToken`

to which it replies with *IncomingCallNotificationResponse*.

Then it establishes a new TLS connection to the clAppService port and sends *ApplicationServiceSendMessageRequest*:

  * `Message.id := 1`
  * `SingleRequest.version := [1,0,0]`
  * `ApplicationServiceSendMessageRequest.token := $calleeToken`
  * `ApplicationServiceSendMessageRequest.message` is uninitialized


###### Step 4:

The second identity reads the response in form of *CallIdentityApplicationServiceResponse*:

  * `$callerToken := CallIdentityApplicationServiceResponse.callerToken`

Then it establishes a new TLS connection to the clAppService port and sends *ApplicationServiceSendMessageRequest*:

  * `Message.id := 1`
  * `SingleRequest.version := [1,0,0]`
  * `ApplicationServiceSendMessageRequest.token := $callerToken`
  * `ApplicationServiceSendMessageRequest.message` is uninitialized

and reads the response. Then it terminates the connection to clNonCustomer port.


###### Step 5:

On clAppService port, the first identity reads *ApplicationServiceSendMessageResponse*.


###### Step 6:

The second identity sends *ApplicationServiceSendMessageRequest*:

  * `Message.id := 2`
  * `SingleRequest.version := [1,0,0]`
  * `ApplicationServiceSendMessageRequest.token := SHA256("test")`
  * `ApplicationServiceSendMessageRequest.message := "Message #1 to callee."`

and reads the response. Then it sends *ApplicationServiceSendMessageRequest*:

  * `Message.id := 3`
  * `SingleRequest.version := [1,0,0]`
  * `ApplicationServiceSendMessageRequest.token := $callerToken`
  * `ApplicationServiceSendMessageRequest.message := "Message #2 to callee."`

and reads the response.

###### Step 7:

The first identity sends *ApplicationServiceSendMessageRequest*:

  * `Message.id := 2`
  * `SingleRequest.version := [1,0,0]`
  * `ApplicationServiceSendMessageRequest.token := $calleeToken`
  * `ApplicationServiceSendMessageRequest.message := "Message #1 to CALLER."`

and reads the response. 


  
##### Acceptance Criteria


###### Step 1:

The test successfully obtains list of ports on which the node provides its services. 
Then the test successfully establishes a home node agreement for its first identity.
Then the test successfully checks-in this identity and initializes its profile. 
Finally, the test successfully checks-in the application service.


###### Step 2:

The test successfully verifies its second identity.


###### Step 3:

Node sends *IncomingCallNotificationRequest*:

  * `IncomingCallNotificationRequest.callerPublicKey == $PubKeyCaller`
  * `IncomingCallNotificationRequest.serviceName == "Test Service"`


###### Step 4:

Node replies with *CallIdentityApplicationServiceResponse*:

  * `Message.id == 3`
  * `Response.status == STATUS_OK`

Node replies with *ApplicationServiceSendMessageResponse*:

  * `Message.id == 1`
  * `Response.status == STATUS_OK`


###### Step 5:

Node replies with *ApplicationServiceSendMessageResponse*:

  * `Message.id == 1`
  * `Response.status == STATUS_OK`


###### Step 6:

Node replies with *Response*:

  * `Message.id == 2`
  * `Response.status == ERROR_NOT_FOUND`

The client should be disconnected then and this should prevent sending the second message or receiving a response.

###### Step 7:

The client should be disconnected then and this should prevent sending the message or receiving a response.












#### HN05016 - Application Service First Client Late Join

##### Prerequisites/Inputs

###### Prerequisites:
  * Node's database is empty.

###### Inputs:
  * Node's IP address
  * Node's primary port


##### Description 

A customer client is being called by a caller and it accepts the call, but neither of the clients 
manages to send an initialization message over the clAppService port on time.


###### Step 1:

The test creates two identities:

  * `$PubKeyCallee` set to public key of the first identity
  * `$PubKeyCaller` set to public key of the second identity
  * `$IdentityIdCallee := SHA256($PubKeyCallee)` is the network ID of the first identity
  * `$IdentityIdCaller := SHA256($PubKeyCaller)` is the network ID of the second identity

Then it connects to the node's primary port and obtains a list of server roles using *ListRolesRequest* 
and closes the connection. Then it uses the first identity and establishes a home node agreement over 
clNonCustomer port and then it closes the connection. Then it checks-in the first identity over clCustomer 
port. The test then initializes its profile using *UpdateProfileRequest*. Finally, it checks-in 
application service called "Test Service" using *ApplicationServiceAddRequest* and leaves the connection 
open. 


###### Step 2:

Using its second identity, the test establishes a new TLS connection to the node's clNonCustomer port 
and verifies its identity using *VerifyIdentityRequest* and sends *CallIdentityApplicationServiceRequest*:

  * `Message.id := 3`
  * `CallIdentityApplicationServiceRequest.identityNetworkId := $IdentityIdCallee`
  * `CallIdentityApplicationServiceRequest.serviceName := "Test Service"`


###### Step 3:

The first identity reads the incoming request *IncomingCallNotificationRequest*:

  * `$calleeToken := IncomingCallNotificationRequest.calleeToken`

to which it replies with *IncomingCallNotificationResponse*.


###### Step 4:

The second identity reads the response in form of *CallIdentityApplicationServiceResponse*:

  * `$callerToken := CallIdentityApplicationServiceResponse.callerToken`


###### Step 5:

The first identity establishes a new TLS connection to the clAppService port and waits 35 seconds 
and then it sends *ApplicationServiceSendMessageRequest*:

  * `Message.id := 1`
  * `SingleRequest.version := [1,0,0]`
  * `ApplicationServiceSendMessageRequest.token := $calleeToken`
  * `ApplicationServiceSendMessageRequest.message` is uninitialized


###### Step 6:

The second identity establishes a new TLS connection to the clAppService port and sends *ApplicationServiceSendMessageRequest*:

  * `Message.id := 1`
  * `SingleRequest.version := [1,0,0]`
  * `ApplicationServiceSendMessageRequest.token := $callerToken`
  * `ApplicationServiceSendMessageRequest.message` is uninitialized

and reads the response. 


###### Step 7:

The first identity reads the response.




  
##### Acceptance Criteria


###### Step 1:

The test successfully obtains list of ports on which the node provides its services. 
Then the test successfully establishes a home node agreement for its first identity.
Then the test successfully checks-in this identity and initializes its profile. 
Finally, the test successfully checks-in the application service.


###### Step 2:

The test successfully verifies its second identity.


###### Step 3:

Node sends *IncomingCallNotificationRequest*:

  * `IncomingCallNotificationRequest.callerPublicKey == $PubKeyCaller`
  * `IncomingCallNotificationRequest.serviceName == "Test Service"`


###### Step 4:

Node replies with *CallIdentityApplicationServiceResponse*:

  * `Message.id == 3`
  * `Response.status == STATUS_OK`


###### Step 5:

Nothing to check.


###### Step 6:


Node replies with *Response*:

  * `Message.id == 1`
  * `Response.status == ERROR_NOT_FOUND`


###### Step 7:

Node replies with *Response*:

  * `Message.id == 1`
  * `Response.status == ERROR_NOT_FOUND`












#### HN05017 - Application Service Second Client Late Join

##### Prerequisites/Inputs

###### Prerequisites:
  * Node's database is empty.

###### Inputs:
  * Node's IP address
  * Node's primary port


##### Description 

A customer client is being called by a caller and it accepts the call. Then the callee 
connects to clAppService port and sends the initialization message, but then the caller 
fails to send an initialization message over the clAppService port on time.


###### Step 1:

The test creates two identities:

  * `$PubKeyCallee` set to public key of the first identity
  * `$PubKeyCaller` set to public key of the second identity
  * `$IdentityIdCallee := SHA256($PubKeyCallee)` is the network ID of the first identity
  * `$IdentityIdCaller := SHA256($PubKeyCaller)` is the network ID of the second identity

Then it connects to the node's primary port and obtains a list of server roles using *ListRolesRequest* 
and closes the connection. Then it uses the first identity and establishes a home node agreement over 
clNonCustomer port and then it closes the connection. Then it checks-in the first identity over clCustomer 
port. The test then initializes its profile using *UpdateProfileRequest*. Finally, it checks-in 
application service called "Test Service" using *ApplicationServiceAddRequest* and leaves the connection 
open. 


###### Step 2:

Using its second identity, the test establishes a new TLS connection to the node's clNonCustomer port 
and verifies its identity using *VerifyIdentityRequest* and sends *CallIdentityApplicationServiceRequest*:

  * `Message.id := 3`
  * `CallIdentityApplicationServiceRequest.identityNetworkId := $IdentityIdCallee`
  * `CallIdentityApplicationServiceRequest.serviceName := "Test Service"`


###### Step 3:

The first identity reads the incoming request *IncomingCallNotificationRequest*:

  * `$calleeToken := IncomingCallNotificationRequest.calleeToken`

to which it replies with *IncomingCallNotificationResponse*.


Then it establishes a new TLS connection to the clAppService port and then it sends *ApplicationServiceSendMessageRequest*:

  * `Message.id := 1`
  * `SingleRequest.version := [1,0,0]`
  * `ApplicationServiceSendMessageRequest.token := $calleeToken`
  * `ApplicationServiceSendMessageRequest.message` is uninitialized


###### Step 4:

The second identity reads the response in form of *CallIdentityApplicationServiceResponse*:

  * `$callerToken := CallIdentityApplicationServiceResponse.callerToken`

Then it establishes a new TLS connection to the clAppService port and waits 35 seconds and then it sends *ApplicationServiceSendMessageRequest*:

  * `Message.id := 1`
  * `SingleRequest.version := [1,0,0]`
  * `ApplicationServiceSendMessageRequest.token := $callerToken`
  * `ApplicationServiceSendMessageRequest.message` is uninitialized

and reads the response. 


###### Step 5:

The first identity reads the response.




  
##### Acceptance Criteria


###### Step 1:

The test successfully obtains list of ports on which the node provides its services. 
Then the test successfully establishes a home node agreement for its first identity.
Then the test successfully checks-in this identity and initializes its profile. 
Finally, the test successfully checks-in the application service.


###### Step 2:

The test successfully verifies its second identity.


###### Step 3:

Node sends *IncomingCallNotificationRequest*:

  * `IncomingCallNotificationRequest.callerPublicKey == $PubKeyCaller`
  * `IncomingCallNotificationRequest.serviceName == "Test Service"`


###### Step 4:

Node replies with *CallIdentityApplicationServiceResponse*:

  * `Message.id == 3`
  * `Response.status == STATUS_OK`


Node replies with *Response*:

  * `Message.id == 1`
  * `Response.status == ERROR_NOT_FOUND`


###### Step 5:

Node replies with *Response*:

  * `Message.id == 1`
  * `Response.status == ERROR_NOT_FOUND`















#### HN05018 - Application Service Callee Closes Connection

##### Prerequisites/Inputs

###### Prerequisites:
  * Node's database is empty.

###### Inputs:
  * Node's IP address
  * Node's primary port


##### Description 

The test simulates two clients exchanging a couple of messages in an application service call 
and then the callee closes the connection, while the caller still wants to send a message.


###### Step 1:

The test creates two identities:

  * `$PubKeyCallee` set to public key of the first identity
  * `$PubKeyCaller` set to public key of the second identity
  * `$IdentityIdCallee := SHA256($PubKeyCallee)` is the network ID of the first identity
  * `$IdentityIdCaller := SHA256($PubKeyCaller)` is the network ID of the second identity

Then it connects to the node's primary port and obtains a list of server roles using *ListRolesRequest* 
and closes the connection. Then it uses the first identity and establishes a home node agreement over 
clNonCustomer port and then it closes the connection. Then it checks-in the first identity over clCustomer 
port. The test then initializes its profile using *UpdateProfileRequest*. Finally, it checks-in 
application service called "Test Service" using *ApplicationServiceAddRequest* and leaves the connection 
open. 


###### Step 2:

Using its second identity, the test establishes a new TLS connection to the node's clNonCustomer port 
and verifies its identity using *VerifyIdentityRequest* and sends *CallIdentityApplicationServiceRequest*:

  * `Message.id := 3`
  * `CallIdentityApplicationServiceRequest.identityNetworkId := $IdentityIdCallee`
  * `CallIdentityApplicationServiceRequest.serviceName := "Test Service"`


###### Step 3:

The first identity reads the incoming request *IncomingCallNotificationRequest*:

  * `$calleeToken := IncomingCallNotificationRequest.calleeToken`

to which it replies with *IncomingCallNotificationResponse*.

Then it establishes a new TLS connection to the clAppService port and sends *ApplicationServiceSendMessageRequest*:

  * `Message.id := 1`
  * `SingleRequest.version := [1,0,0]`
  * `ApplicationServiceSendMessageRequest.token := $calleeToken`
  * `ApplicationServiceSendMessageRequest.message` is uninitialized


###### Step 4:

The second identity reads the response in form of *CallIdentityApplicationServiceResponse*:

  * `$callerToken := CallIdentityApplicationServiceResponse.callerToken`

Then it establishes a new TLS connection to the clAppService port and sends *ApplicationServiceSendMessageRequest*:

  * `Message.id := 1`
  * `SingleRequest.version := [1,0,0]`
  * `ApplicationServiceSendMessageRequest.token := $callerToken`
  * `ApplicationServiceSendMessageRequest.message` is uninitialized

and reads the response. Then it terminates the connection to clNonCustomer port.


###### Step 5:

On clAppService port, the first identity reads *ApplicationServiceSendMessageResponse*.


###### Step 6:

The second identity sends *ApplicationServiceSendMessageRequest*:

  * `Message.id := 2`
  * `SingleRequest.version := [1,0,0]`
  * `ApplicationServiceSendMessageRequest.token := $callerToken`
  * `ApplicationServiceSendMessageRequest.message := "Message #1 to callee."`


###### Step 7:

On clAppService port, the first identity reads *ApplicationServiceReceiveMessageNotificationRequest* (#1 to callee).

Then it sends *ApplicationServiceReceiveMessageNotificationResponse*. 

And then it sends *ApplicationServiceSendMessageRequest*:

  * `Message.id := 2`
  * `SingleRequest.version := [1,0,0]`
  * `ApplicationServiceSendMessageRequest.token := $calleeToken`
  * `ApplicationServiceSendMessageRequest.message := "Message #1 to CALLER."`

and disconnects.


###### Step 8:

After a 5 second wait, the second identity reads *ApplicationServiceSendMessageResponse* (#1 to callee received).

Then it reads *ApplicationServiceReceiveMessageNotificationRequest* (#1 to CALLER).

Then it sends *ApplicationServiceReceiveMessageNotificationResponse*. 

Then it sends *ApplicationServiceSendMessageRequest*:

  * `Message.id := 3`
  * `SingleRequest.version := [1,0,0]`
  * `ApplicationServiceSendMessageRequest.token := $callerToken`
  * `ApplicationServiceSendMessageRequest.message := "Message #2 to callee."`

and reads the response. 


  
##### Acceptance Criteria


###### Step 1:

The test successfully obtains list of ports on which the node provides its services. 
Then the test successfully establishes a home node agreement for its first identity.
Then the test successfully checks-in this identity and initializes its profile. 
Finally, the test successfully checks-in the application service.


###### Step 2:

The test successfully verifies its second identity.


###### Step 3:

Node sends *IncomingCallNotificationRequest*:

  * `IncomingCallNotificationRequest.callerPublicKey == $PubKeyCaller`
  * `IncomingCallNotificationRequest.serviceName == "Test Service"`


###### Step 4:

Node replies with *CallIdentityApplicationServiceResponse*:

  * `Message.id == 3`
  * `Response.status == STATUS_OK`

Node replies with *ApplicationServiceSendMessageResponse*:

  * `Message.id == 1`
  * `Response.status == STATUS_OK`


###### Step 5:

Node replies with *ApplicationServiceSendMessageResponse*:

  * `Message.id == 1`
  * `Response.status == STATUS_OK`


###### Step 6:

Nothing to check.


###### Step 7:

Node sends *ApplicationServiceReceiveMessageNotificationRequest*:

  * `SingleRequest.version == [1,0,0]`
  * `ApplicationServiceReceiveMessageNotificationRequest.message == "Message #1 to callee."`


###### Step 8:

Node replies with *ApplicationServiceSendMessageResponse*:

  * `Message.id == 2`
  * `SingleResponse.version == [1,0,0]`
  * `Response.status == STATUS_OK`

Node sends *ApplicationServiceReceiveMessageNotificationRequest*:

  * `SingleRequest.version == [1,0,0]`
  * `ApplicationServiceReceiveMessageNotificationRequest.message == "Message #1 to CALLER."`


Node disconnects the second identity and this prevents it to either send *ApplicationServiceReceiveMessageNotificationResponse* 
or send *ApplicationServiceSendMessageRequest* message or read a response.










#### HN05019 - Application Service Callee Disconnects Administrative Connection

##### Prerequisites/Inputs

###### Prerequisites:
  * Node's database is empty.

###### Inputs:
  * Node's IP address
  * Node's primary port


##### Description 

A customer client is called using application service. It accepts the call and immediately 
disconnects from clCustomerPort. The caller receives notification about the accepted call 
and immediately disconnects from clNonCustomer port. Then they exchange messages over clAppService port.


###### Step 1:

The test creates two identities:

  * `$PubKeyCallee` set to public key of the first identity
  * `$PubKeyCaller` set to public key of the second identity
  * `$IdentityIdCallee := SHA256($PubKeyCallee)` is the network ID of the first identity
  * `$IdentityIdCaller := SHA256($PubKeyCaller)` is the network ID of the second identity

Then it connects to the node's primary port and obtains a list of server roles using *ListRolesRequest* 
and closes the connection. Then it uses the first identity and establishes a home node agreement over 
clNonCustomer port and then it closes the connection. Then it checks-in the first identity over clCustomer 
port. The test then initializes its profile using *UpdateProfileRequest*. Finally, it checks-in 
application service called "Test Service" using *ApplicationServiceAddRequest* and leaves the connection 
open. 


###### Step 2:

Using its second identity, the test establishes a new TLS connection to the node's clNonCustomer port 
and verifies its identity using *VerifyIdentityRequest* and sends *CallIdentityApplicationServiceRequest*:

  * `Message.id := 3`
  * `CallIdentityApplicationServiceRequest.identityNetworkId := $IdentityIdCallee`
  * `CallIdentityApplicationServiceRequest.serviceName := "Test Service"`


###### Step 3:

The first identity reads the incoming request *IncomingCallNotificationRequest*:

  * `$calleeToken := IncomingCallNotificationRequest.calleeToken`

to which it replies with *IncomingCallNotificationResponse* and disconnects and waits 3 seconds.


###### Step 4:

The second identity reads the response in form of *CallIdentityApplicationServiceResponse*:

  * `$callerToken := CallIdentityApplicationServiceResponse.callerToken`

and disconnects and waits 3 seconds.

###### Step 5:

The first identity establishes a new TLS connection to the clAppService port and sends *ApplicationServiceSendMessageRequest*:

  * `Message.id := 1`
  * `SingleRequest.version := [1,0,0]`
  * `ApplicationServiceSendMessageRequest.token := $calleeToken`
  * `ApplicationServiceSendMessageRequest.message` is uninitialized


###### Step 6:

The second identity establishes a new TLS connection to the clAppService port and sends *ApplicationServiceSendMessageRequest*:

  * `Message.id := 1`
  * `SingleRequest.version := [1,0,0]`
  * `ApplicationServiceSendMessageRequest.token := $callerToken`
  * `ApplicationServiceSendMessageRequest.message` is uninitialized

and reads the response. 


###### Step 7:

On clAppService port, the first identity reads *ApplicationServiceSendMessageResponse*.


###### Step 8:

The second identity sends *ApplicationServiceSendMessageRequest*:

  * `Message.id := 2`
  * `SingleRequest.version := [1,0,0]`
  * `ApplicationServiceSendMessageRequest.token := $callerToken`
  * `ApplicationServiceSendMessageRequest.message := "Message #1 to callee."`


###### Step 9:

The first identity reads *ApplicationServiceReceiveMessageNotificationRequest* (#1 to callee).

Then it sends *ApplicationServiceReceiveMessageNotificationResponse*. 

And then it sends *ApplicationServiceSendMessageRequest*:

  * `Message.id := 2`
  * `SingleRequest.version := [1,0,0]`
  * `ApplicationServiceSendMessageRequest.token := $calleeToken`
  * `ApplicationServiceSendMessageRequest.message := "Message #1 to CALLER."`


###### Step 10:

The second identity reads *ApplicationServiceSendMessageResponse* (#1 to callee received).

Then it reads *ApplicationServiceReceiveMessageNotificationRequest* (#1 to CALLER).

Then it sends *ApplicationServiceReceiveMessageNotificationResponse*. 


###### Step 11:

The first identity reads *ApplicationServiceSendMessageResponse* (#1 to CALLER received).



  
##### Acceptance Criteria


###### Step 1:

The test successfully obtains list of ports on which the node provides its services. 
Then the test successfully establishes a home node agreement for its first identity.
Then the test successfully checks-in this identity and initializes its profile. 
Finally, the test successfully checks-in the application service.


###### Step 2:

The test successfully verifies its second identity.


###### Step 3:

Node sends *IncomingCallNotificationRequest*:

  * `IncomingCallNotificationRequest.callerPublicKey == $PubKeyCaller`
  * `IncomingCallNotificationRequest.serviceName == "Test Service"`


###### Step 4:

Node replies with *CallIdentityApplicationServiceResponse*:

  * `Message.id == 3`
  * `Response.status == STATUS_OK`


###### Step 5:

Nothing to check.


###### Step 6:

Node replies with *ApplicationServiceSendMessageResponse*:

  * `Message.id == 1`
  * `Response.status == STATUS_OK`


###### Step 7:

Node replies with *ApplicationServiceSendMessageResponse*:

  * `Message.id == 1`
  * `Response.status == STATUS_OK`


###### Step 8:

Nothing to check.


###### Step 9:


Node sends *ApplicationServiceReceiveMessageNotificationRequest*:

  * `SingleRequest.version == [1,0,0]`
  * `ApplicationServiceReceiveMessageNotificationRequest.message == "Message #1 to callee."`


###### Step 10:

Node replies with *ApplicationServiceSendMessageResponse*:

  * `Message.id == 2`
  * `SingleResponse.version == [1,0,0]`
  * `Response.status == STATUS_OK`

Node sends *ApplicationServiceReceiveMessageNotificationRequest*:

  * `SingleRequest.version == [1,0,0]`
  * `ApplicationServiceReceiveMessageNotificationRequest.message == "Message #1 to CALLER."`


###### Step 11:

Node replies with *ApplicationServiceSendMessageResponse*:

  * `Message.id == 2`
  * `SingleResponse.version == [1,0,0]`
  * `Response.status == STATUS_OK`










#### HN05020 - Application Service Call - No Message Confirmation

##### Prerequisites/Inputs

###### Prerequisites:
  * Node's database is empty.

###### Inputs:
  * Node's IP address
  * Node's primary port


##### Description 

The test simulates two clients with an open application service call, in which the caller 
sends messages to the callee, but the callee does not confirm them. 


###### Step 1:

The test creates two identities:

  * `$PubKeyCallee` set to public key of the first identity
  * `$PubKeyCaller` set to public key of the second identity
  * `$IdentityIdCallee := SHA256($PubKeyCallee)` is the network ID of the first identity
  * `$IdentityIdCaller := SHA256($PubKeyCaller)` is the network ID of the second identity

Then it connects to the node's primary port and obtains a list of server roles using *ListRolesRequest* 
and closes the connection. Then it uses the first identity and establishes a home node agreement over 
clNonCustomer port and then it closes the connection. Then it checks-in the first identity over clCustomer 
port. The test then initializes its profile using *UpdateProfileRequest*. Finally, it checks-in 
application service called "Test Service" using *ApplicationServiceAddRequest* and leaves the connection 
open. 


###### Step 2:

Using its second identity, the test establishes a new TLS connection to the node's clNonCustomer port 
and verifies its identity using *VerifyIdentityRequest* and sends *CallIdentityApplicationServiceRequest*:

  * `Message.id := 3`
  * `CallIdentityApplicationServiceRequest.identityNetworkId := $IdentityIdCallee`
  * `CallIdentityApplicationServiceRequest.serviceName := "Test Service"`


###### Step 3:

The first identity reads the incoming request *IncomingCallNotificationRequest*:

  * `$calleeToken := IncomingCallNotificationRequest.calleeToken`

to which it replies with *IncomingCallNotificationResponse*.

Then it establishes a new TLS connection to the clAppService port and sends *ApplicationServiceSendMessageRequest*:

  * `Message.id := 1`
  * `SingleRequest.version := [1,0,0]`
  * `ApplicationServiceSendMessageRequest.token := $calleeToken`
  * `ApplicationServiceSendMessageRequest.message` is uninitialized


###### Step 4:

The second identity reads the response in form of *CallIdentityApplicationServiceResponse*:

  * `$callerToken := CallIdentityApplicationServiceResponse.callerToken`

Then it establishes a new TLS connection to the clAppService port and sends *ApplicationServiceSendMessageRequest*:

  * `Message.id := 1`
  * `SingleRequest.version := [1,0,0]`
  * `ApplicationServiceSendMessageRequest.token := $callerToken`
  * `ApplicationServiceSendMessageRequest.message` is uninitialized

and reads the response. Then it terminates the connection to clNonCustomer port.


###### Step 5:

On clAppService port, the first identity reads *ApplicationServiceSendMessageResponse*.


###### Step 6:

The second identity sends *ApplicationServiceSendMessageRequest* messages in a loop:

  * `Message.id := $i+1`
  * `SingleRequest.version := [1,0,0]`
  * `ApplicationServiceSendMessageRequest.token := $callerToken`
  * `ApplicationServiceSendMessageRequest.message := "Message #$i to callee."`

After each message sent by the second identity, the first identity always reads *ApplicationServiceReceiveMessageNotificationRequest* 
sent to it by the node. Then the second identity waits 10 seconds before sending the next round message.

After sending 20 messages, the second identity reads responses in a loop.


  
##### Acceptance Criteria


###### Step 1:

The test successfully obtains list of ports on which the node provides its services. 
Then the test successfully establishes a home node agreement for its first identity.
Then the test successfully checks-in this identity and initializes its profile. 
Finally, the test successfully checks-in the application service.


###### Step 2:

The test successfully verifies its second identity.


###### Step 3:

Node sends *IncomingCallNotificationRequest*:

  * `IncomingCallNotificationRequest.callerPublicKey == $PubKeyCaller`
  * `IncomingCallNotificationRequest.serviceName == "Test Service"`


###### Step 4:

Node replies with *CallIdentityApplicationServiceResponse*:

  * `Message.id == 3`
  * `Response.status == STATUS_OK`

Node replies with *ApplicationServiceSendMessageResponse*:

  * `Message.id == 1`
  * `Response.status == STATUS_OK`


###### Step 5:

Node replies with *ApplicationServiceSendMessageResponse*:

  * `Message.id == 1`
  * `Response.status == STATUS_OK`


###### Step 6:

Some messages are delivered successfully, but then the node disconnects both identities 
and thus prevents the second identity to send all 20 messages.









#### HN05021 - Application Service Call - Too Many Pending Messages

##### Prerequisites/Inputs

###### Prerequisites:
  * Node's database is empty.

###### Inputs:
  * Node's IP address
  * Node's primary port


##### Description 

The test simulates two clients with an open application service call, in which the caller 
sends too many messages to the callee without waiting for a confirmation. 


###### Step 1:

The test creates two identities:

  * `$PubKeyCallee` set to public key of the first identity
  * `$PubKeyCaller` set to public key of the second identity
  * `$IdentityIdCallee := SHA256($PubKeyCallee)` is the network ID of the first identity
  * `$IdentityIdCaller := SHA256($PubKeyCaller)` is the network ID of the second identity

Then it connects to the node's primary port and obtains a list of server roles using *ListRolesRequest* 
and closes the connection. Then it uses the first identity and establishes a home node agreement over 
clNonCustomer port and then it closes the connection. Then it checks-in the first identity over clCustomer 
port. The test then initializes its profile using *UpdateProfileRequest*. Finally, it checks-in 
application service called "Test Service" using *ApplicationServiceAddRequest* and leaves the connection 
open. 


###### Step 2:

Using its second identity, the test establishes a new TLS connection to the node's clNonCustomer port 
and verifies its identity using *VerifyIdentityRequest* and sends *CallIdentityApplicationServiceRequest*:

  * `Message.id := 3`
  * `CallIdentityApplicationServiceRequest.identityNetworkId := $IdentityIdCallee`
  * `CallIdentityApplicationServiceRequest.serviceName := "Test Service"`


###### Step 3:

The first identity reads the incoming request *IncomingCallNotificationRequest*:

  * `$calleeToken := IncomingCallNotificationRequest.calleeToken`

to which it replies with *IncomingCallNotificationResponse*.

Then it establishes a new TLS connection to the clAppService port and sends *ApplicationServiceSendMessageRequest*:

  * `Message.id := 1`
  * `SingleRequest.version := [1,0,0]`
  * `ApplicationServiceSendMessageRequest.token := $calleeToken`
  * `ApplicationServiceSendMessageRequest.message` is uninitialized


###### Step 4:

The second identity reads the response in form of *CallIdentityApplicationServiceResponse*:

  * `$callerToken := CallIdentityApplicationServiceResponse.callerToken`

Then it establishes a new TLS connection to the clAppService port and sends *ApplicationServiceSendMessageRequest*:

  * `Message.id := 1`
  * `SingleRequest.version := [1,0,0]`
  * `ApplicationServiceSendMessageRequest.token := $callerToken`
  * `ApplicationServiceSendMessageRequest.message` is uninitialized

and reads the response. Then it terminates the connection to clNonCustomer port.


###### Step 5:

On clAppService port, the first identity reads *ApplicationServiceSendMessageResponse*.


###### Step 6:

The second identity sends 21 *ApplicationServiceSendMessageRequest* messages in a loop:

  * `Message.id := $i+1`
  * `SingleRequest.version := [1,0,0]`
  * `ApplicationServiceSendMessageRequest.token := $callerToken`
  * `ApplicationServiceSendMessageRequest.message := "Message #$i to callee."`

After sending 21 messages it reads the response.



  
##### Acceptance Criteria


###### Step 1:

The test successfully obtains list of ports on which the node provides its services. 
Then the test successfully establishes a home node agreement for its first identity.
Then the test successfully checks-in this identity and initializes its profile. 
Finally, the test successfully checks-in the application service.


###### Step 2:

The test successfully verifies its second identity.


###### Step 3:

Node sends *IncomingCallNotificationRequest*:

  * `IncomingCallNotificationRequest.callerPublicKey == $PubKeyCaller`
  * `IncomingCallNotificationRequest.serviceName == "Test Service"`


###### Step 4:

Node replies with *CallIdentityApplicationServiceResponse*:

  * `Message.id == 3`
  * `Response.status == STATUS_OK`

Node replies with *ApplicationServiceSendMessageResponse*:

  * `Message.id == 1`
  * `Response.status == STATUS_OK`


###### Step 5:

Node replies with *ApplicationServiceSendMessageResponse*:

  * `Message.id == 1`
  * `Response.status == STATUS_OK`


###### Step 6:

Node replies with *Response*:
  
  * `Response.status == ERROR_NOT_FOUND`















#### HN05022 - Application Service Call - Sending Message Before Initialization Completes

##### Prerequisites/Inputs

###### Prerequisites:
  * Node's database is empty.

###### Inputs:
  * Node's IP address
  * Node's primary port


##### Description 

The test simulates two clients with an open application service call, in which the caller
sends a message to the callee before the callee sends its initialization message.


###### Step 1:

The test creates two identities:

  * `$PubKeyCallee` set to public key of the first identity
  * `$PubKeyCaller` set to public key of the second identity
  * `$IdentityIdCallee := SHA256($PubKeyCallee)` is the network ID of the first identity
  * `$IdentityIdCaller := SHA256($PubKeyCaller)` is the network ID of the second identity

Then it connects to the node's primary port and obtains a list of server roles using *ListRolesRequest* 
and closes the connection. Then it uses the first identity and establishes a home node agreement over 
clNonCustomer port and then it closes the connection. Then it checks-in the first identity over clCustomer 
port. The test then initializes its profile using *UpdateProfileRequest*. Finally, it checks-in 
application service called "Test Service" using *ApplicationServiceAddRequest* and leaves the connection 
open. 


###### Step 2:

Using its second identity, the test establishes a new TLS connection to the node's clNonCustomer port 
and verifies its identity using *VerifyIdentityRequest* and sends *CallIdentityApplicationServiceRequest*:

  * `Message.id := 3`
  * `CallIdentityApplicationServiceRequest.identityNetworkId := $IdentityIdCallee`
  * `CallIdentityApplicationServiceRequest.serviceName := "Test Service"`


###### Step 3:

The first identity reads the incoming request *IncomingCallNotificationRequest*:

  * `$calleeToken := IncomingCallNotificationRequest.calleeToken`

to which it replies with *IncomingCallNotificationResponse*.


###### Step 4:

The second identity reads the response in form of *CallIdentityApplicationServiceResponse*:

  * `$callerToken := CallIdentityApplicationServiceResponse.callerToken`

Then it establishes a new TLS connection to the clAppService port and sends *ApplicationServiceSendMessageRequest*:

  * `Message.id := 1`
  * `SingleRequest.version := [1,0,0]`
  * `ApplicationServiceSendMessageRequest.token := $callerToken`
  * `ApplicationServiceSendMessageRequest.message` is uninitialized

and then it sends *ApplicationServiceSendMessageRequest*:

  * `Message.id := 2`
  * `SingleRequest.version := [1,0,0]`
  * `ApplicationServiceSendMessageRequest.token := $callerToken`
  * `ApplicationServiceSendMessageRequest.message := "Message #1 to callee."`

and reads the response.



###### Step 5:

The first identity establishes a new TLS connection to the clAppService port and sends *ApplicationServiceSendMessageRequest*:

  * `Message.id := 1`
  * `SingleRequest.version := [1,0,0]`
  * `ApplicationServiceSendMessageRequest.token := $calleeToken`
  * `ApplicationServiceSendMessageRequest.message` is uninitialized

and reads the response.



  
##### Acceptance Criteria


###### Step 1:

The test successfully obtains list of ports on which the node provides its services. 
Then the test successfully establishes a home node agreement for its first identity.
Then the test successfully checks-in this identity and initializes its profile. 
Finally, the test successfully checks-in the application service.


###### Step 2:

The test successfully verifies its second identity.


###### Step 3:

Node sends *IncomingCallNotificationRequest*:

  * `IncomingCallNotificationRequest.callerPublicKey == $PubKeyCaller`
  * `IncomingCallNotificationRequest.serviceName == "Test Service"`


###### Step 4:

Node replies with *CallIdentityApplicationServiceResponse*:

  * `Message.id == 3`
  * `Response.status == STATUS_OK`

Node replies with *Response*:

  * `Message.id == 1`
  * `Response.status == ERROR_NOT_FOUND`


###### Step 5:

Node replies with *Response*:

  * `Message.id == 1`
  * `Response.status == ERROR_NOT_FOUND`













#### HN05023 - Application Service Call - Two Customers

##### Prerequisites/Inputs

###### Prerequisites:
  * Node's database is empty.

###### Inputs:
  * Node's IP address
  * Node's primary port


##### Description 

The test simulates two customer clients exchanging couple of messages in an application service all.


###### Step 1:
The test creates two identities:

  * `$PubKeyCallee` set to public key of the first identity
  * `$PubKeyCaller` set to public key of the second identity
  * `$IdentityIdCallee := SHA256($PubKeyCallee)` is the network ID of the first identity
  * `$IdentityIdCaller := SHA256($PubKeyCaller)` is the network ID of the second identity

Then it connects to the node's primary port and obtains a list of server roles using *ListRolesRequest* 
and closes the connection. Then it uses the first identity and establishes a home node agreement over 
clNonCustomer port and then it closes the connection. Then it checks-in the first identity over clCustomer 
port. The test then initializes its profile using *UpdateProfileRequest*. Finally, it checks-in 
application service called "Test Service" using *ApplicationServiceAddRequest* and leaves the connection 
open. 

Then it uses the second identity and establishes a home node agreement over clNonCustomer port and then 
it closes the connection. Then it checks-in the second identity over clCustomer port. The test then 
initializes its profile using *UpdateProfileRequest* and leaves the connection open. 



###### Step 2:
Over the existing connection, the second identity sends *CallIdentityApplicationServiceRequest*:

  * `Message.id := 4`
  * `CallIdentityApplicationServiceRequest.identityNetworkId := $IdentityIdCallee`
  * `CallIdentityApplicationServiceRequest.serviceName := "Test Service"`


###### Step 3:
The first identity reads the incoming request *IncomingCallNotificationRequest*:

  * `$calleeToken := IncomingCallNotificationRequest.calleeToken`

to which it replies with *IncomingCallNotificationResponse*.

Then it establishes a new TLS connection to the clAppService port and sends *ApplicationServiceSendMessageRequest*:

  * `Message.id := 1`
  * `SingleRequest.version := [1,0,0]`
  * `ApplicationServiceSendMessageRequest.token := $calleeToken`
  * `ApplicationServiceSendMessageRequest.message` is uninitialized


###### Step 4:

The second identity reads the response in form of *CallIdentityApplicationServiceResponse*:

  * `$callerToken := CallIdentityApplicationServiceResponse.callerToken`

Then it establishes a new TLS connection to the clAppService port and sends *ApplicationServiceSendMessageRequest*:

  * `Message.id := 1`
  * `SingleRequest.version := [1,0,0]`
  * `ApplicationServiceSendMessageRequest.token := $callerToken`
  * `ApplicationServiceSendMessageRequest.message` is uninitialized

and reads the response. 


###### Step 5:

On clAppService port, the first identity reads *ApplicationServiceSendMessageResponse*.

###### Step 6:

On clAppService port, the second identity sends *ApplicationServiceSendMessageRequest*:

  * `Message.id := 2`
  * `SingleRequest.version := [1,0,0]`
  * `ApplicationServiceSendMessageRequest.token := $callerToken`
  * `ApplicationServiceSendMessageRequest.message := "Message #1 to callee."`

And then it sends *ApplicationServiceSendMessageRequest*:

  * `Message.id := 3`
  * `SingleRequest.version := [1,0,0]`
  * `ApplicationServiceSendMessageRequest.token := $callerToken`
  * `ApplicationServiceSendMessageRequest.message := "Message #2 to callee."`

And then it sends *ApplicationServiceSendMessageRequest*:

  * `Message.id := 4`
  * `SingleRequest.version := [1,0,0]`
  * `ApplicationServiceSendMessageRequest.token := $callerToken`
  * `ApplicationServiceSendMessageRequest.message := "Message #3 to callee."`


###### Step 7:

On clAppService port, the first identity reads *ApplicationServiceReceiveMessageNotificationRequest* (#1 to callee).

Then it sends *ApplicationServiceReceiveMessageNotificationResponse*. 

Then it reads *ApplicationServiceReceiveMessageNotificationRequest* (#2 to callee).

Then it sends *ApplicationServiceReceiveMessageNotificationResponse*.

And then it sends *ApplicationServiceSendMessageRequest*:

  * `Message.id := 2`
  * `SingleRequest.version := [1,0,0]`
  * `ApplicationServiceSendMessageRequest.token := $calleeToken`
  * `ApplicationServiceSendMessageRequest.message := "Message #1 to CALLER."`

Then it reads *ApplicationServiceReceiveMessageNotificationRequest* (#3 to callee).

Then it sends *ApplicationServiceReceiveMessageNotificationResponse*.

And then it sends *ApplicationServiceSendMessageRequest*:

  * `Message.id := 4`
  * `SingleRequest.version := [1,0,0]`
  * `ApplicationServiceSendMessageRequest.token := $calleeToken`
  * `ApplicationServiceSendMessageRequest.message := "Message #2 to CALLER."`


###### Step 8:

On clAppService port, the second identity reads *ApplicationServiceSendMessageResponse* (#1 to callee received).

Then it reads *ApplicationServiceSendMessageResponse* (#2 to callee received).

Then it reads *ApplicationServiceReceiveMessageNotificationRequest* (#1 to CALLER).

Then it sends *ApplicationServiceReceiveMessageNotificationResponse*.

Then it reads *ApplicationServiceSendMessageResponse* (#3 to callee received). 

Then it reads *ApplicationServiceReceiveMessageNotificationRequest* (#2 to CALLER).

Then it sends *ApplicationServiceReceiveMessageNotificationResponse*.


###### Step 9:

On clAppService, the first identity reads *ApplicationServiceSendMessageResponse* (#1 to CALLER received).

Then it reads *ApplicationServiceSendMessageResponse* (#2 to CALLER received).



  
##### Acceptance Criteria


###### Step 1:

The test successfully obtains list of ports on which the node provides its services. 
Then the test successfully establishes a home node agreement for its first identity.
Then the test successfully checks-in this identity and initializes its profile. 
The test successfully checks-in the application service for the first identity.


For the second identity, the test successfully establishes a home node agreement.
Then the test successfully checks-in this identity and initializes its profile. 


###### Step 2:

Nothing to check.


###### Step 3:

Node sends *IncomingCallNotificationRequest*:

  * `IncomingCallNotificationRequest.callerPublicKey == $PubKeyCaller`
  * `IncomingCallNotificationRequest.serviceName == "Test Service"`


###### Step 4:

Node replies with *CallIdentityApplicationServiceResponse*:

  * `Message.id == 4`
  * `Response.status == STATUS_OK`

Node replies with *ApplicationServiceSendMessageResponse*:

  * `Message.id == 1`
  * `Response.status == STATUS_OK`


###### Step 5:

Node replies with *ApplicationServiceSendMessageResponse*:

  * `Message.id == 1`
  * `Response.status == STATUS_OK`


###### Step 6:

Nothing to check.


###### Step 7:

Node sends *ApplicationServiceReceiveMessageNotificationRequest*:

  * `SingleRequest.version == [1,0,0]`
  * `ApplicationServiceReceiveMessageNotificationRequest.message == "Message #1 to callee."`

Node sends *ApplicationServiceReceiveMessageNotificationRequest*:

  * `SingleRequest.version == [1,0,0]`
  * `ApplicationServiceReceiveMessageNotificationRequest.message == "Message #2 to callee."`

Node sends *ApplicationServiceReceiveMessageNotificationRequest*:

  * `SingleRequest.version == [1,0,0]`
  * `ApplicationServiceReceiveMessageNotificationRequest.message == "Message #3 to callee."`


###### Step 8:


Node replies with *ApplicationServiceSendMessageResponse*:

  * `Message.id == 2`
  * `SingleResponse.version == [1,0,0]`
  * `Response.status == STATUS_OK`

Node replies with *ApplicationServiceSendMessageResponse*:

  * `Message.id == 3`
  * `SingleResponse.version == [1,0,0]`
  * `Response.status == STATUS_OK`

Node sends *ApplicationServiceReceiveMessageNotificationRequest*:

  * `SingleRequest.version == [1,0,0]`
  * `ApplicationServiceReceiveMessageNotificationRequest.message == "Message #1 to CALLER."`

Node replies with *ApplicationServiceSendMessageResponse*:

  * `Message.id == 4`
  * `SingleResponse.version == [1,0,0]`
  * `Response.status == STATUS_OK`

Node sends *ApplicationServiceReceiveMessageNotificationRequest*:

  * `SingleRequest.version == [1,0,0]`
  * `ApplicationServiceReceiveMessageNotificationRequest.message == "Message #2 to CALLER."`



###### Step 9:

Node replies with *ApplicationServiceSendMessageResponse*:

  * `Message.id == 2`
  * `SingleResponse.version == [1,0,0]`
  * `Response.status == STATUS_OK`

Node replies with *ApplicationServiceSendMessageResponse*:

  * `Message.id == 4`
  * `SingleResponse.version == [1,0,0]`
  * `Response.status == STATUS_OK`










#### HN05024 - Application Service Callee Uses Same Connection Twice

##### Prerequisites/Inputs

###### Prerequisites:
  * Node's database is empty.

###### Inputs:
  * Node's IP address
  * Node's primary port


##### Description 

The test simulates a callee accepting calls from two different callers but only using 
one TCP connection to clAppService port, which is forbidden.


###### Step 1:

The test creates three identities:

  * `$PubKeyCallee` set to public key of the first identity
  * `$PubKeyCaller1` set to public key of the second identity
  * `$PubKeyCaller2` set to public key of the third identity
  * `$IdentityIdCallee := SHA256($PubKeyCallee)` is the network ID of the first identity
  * `$IdentityIdCaller1 := SHA256($PubKeyCaller1)` is the network ID of the second identity
  * `$IdentityIdCaller2 := SHA256($PubKeyCaller2)` is the network ID of the third identity

Then it connects to the node's primary port and obtains a list of server roles using *ListRolesRequest* 
and closes the connection. Then it uses the first identity and establishes a home node agreement over 
clNonCustomer port and then it closes the connection. Then it checks-in the first identity over clCustomer 
port. The test then initializes its profile using *UpdateProfileRequest*. Finally, it checks-in 
application service called "Test Service" using *ApplicationServiceAddRequest* and leaves the connection 
open. 


###### Step 2:

Using its second identity, the test establishes a new TLS connection to the node's clNonCustomer port 
and verifies its identity using *VerifyIdentityRequest* and sends *CallIdentityApplicationServiceRequest*:

  * `Message.id := 3`
  * `CallIdentityApplicationServiceRequest.identityNetworkId := $IdentityIdCallee`
  * `CallIdentityApplicationServiceRequest.serviceName := "Test Service"`

Using its third identity, the test establishes a new TLS connection to the node's clNonCustomer port 
and verifies its identity using *VerifyIdentityRequest* and sends *CallIdentityApplicationServiceRequest*:

  * `Message.id := 3`
  * `CallIdentityApplicationServiceRequest.identityNetworkId := $IdentityIdCallee`
  * `CallIdentityApplicationServiceRequest.serviceName := "Test Service"`


###### Step 3:

The first identity reads the incoming request *IncomingCallNotificationRequest*:

  * `$calleeToken1 := IncomingCallNotificationRequest.calleeToken`

to which it replies with *IncomingCallNotificationResponse*.

Then it reads the second incoming request *IncomingCallNotificationRequest*:

  * `$calleeToken2 := IncomingCallNotificationRequest.calleeToken`

to which it replies with *IncomingCallNotificationResponse*.


Then it establishes a new TLS connection to the clAppService port and sends *ApplicationServiceSendMessageRequest*:

  * `Message.id := 1`
  * `SingleRequest.version := [1,0,0]`
  * `ApplicationServiceSendMessageRequest.token := $calleeToken1`
  * `ApplicationServiceSendMessageRequest.message` is uninitialized


###### Step 4:

The second identity reads the response in form of *CallIdentityApplicationServiceResponse*:

  * `$callerToken := CallIdentityApplicationServiceResponse.callerToken`

Then it establishes a new TLS connection to the clAppService port and sends *ApplicationServiceSendMessageRequest*:

  * `Message.id := 1`
  * `SingleRequest.version := [1,0,0]`
  * `ApplicationServiceSendMessageRequest.token := $callerToken`
  * `ApplicationServiceSendMessageRequest.message` is uninitialized

and reads the response. 


###### Step 5:

On clAppService port, the first identity reads *ApplicationServiceSendMessageResponse*.


###### Step 6:

The second identity sends *ApplicationServiceSendMessageRequest*:

  * `Message.id := 2`
  * `SingleRequest.version := [1,0,0]`
  * `ApplicationServiceSendMessageRequest.token := $callerToken`
  * `ApplicationServiceSendMessageRequest.message := "Message #1 to callee."`



###### Step 7:

On clAppService port, the first identity reads *ApplicationServiceReceiveMessageNotificationRequest* (#1 to callee).

Then it sends *ApplicationServiceReceiveMessageNotificationResponse*. 

And then after 3 second wait, it sends *ApplicationServiceSendMessageRequest*:

  * `Message.id := 2`
  * `SingleRequest.version := [1,0,0]`
  * `ApplicationServiceSendMessageRequest.token := $calleeToken2`
  * `ApplicationServiceSendMessageRequest.message` is uninitialized

and reads the response.


###### Step 8:

The third identity reads the response.


###### Step 9:

The second identity reads *ApplicationServiceSendMessageResponse* (#1 to callee received).




  
##### Acceptance Criteria


###### Step 1:

The test successfully obtains list of ports on which the node provides its services. 
Then the test successfully establishes a home node agreement for its first identity.
Then the test successfully checks-in this identity and initializes its profile. 
Finally, the test successfully checks-in the application service.


###### Step 2:

The test successfully verifies its second identity.
The test successfully verifies its third identity.


###### Step 3:

Node sends *IncomingCallNotificationRequest*:

  * `IncomingCallNotificationRequest.callerPublicKey == $PubKeyCaller1`
  * `IncomingCallNotificationRequest.serviceName == "Test Service"`

Node sends *IncomingCallNotificationRequest*:

  * `IncomingCallNotificationRequest.callerPublicKey == $PubKeyCaller2`
  * `IncomingCallNotificationRequest.serviceName == "Test Service"`


###### Step 4:

Node replies with *CallIdentityApplicationServiceResponse*:

  * `Message.id == 3`
  * `Response.status == STATUS_OK`

Node replies with *ApplicationServiceSendMessageResponse*:

  * `Message.id == 1`
  * `Response.status == STATUS_OK`


###### Step 5:

Node replies with *ApplicationServiceSendMessageResponse*:

  * `Message.id == 1`
  * `Response.status == STATUS_OK`


###### Step 6:

Nothing to check.


###### Step 7:

Node sends *ApplicationServiceReceiveMessageNotificationRequest*:

  * `ApplicationServiceReceiveMessageNotificationRequest.message == "Message #1 to callee."`

Node replies with *Response*:

  * `Message.id == 2`
  * `Response.status == ERROR_NOT_FOUND`


###### Step 8:

Either the node replies with *ApplicationServiceSendMessageResponse*:

  * `Message.id == 1`
  * `SingleResponse.version == [1,0,0]`
  * `Response.status == ERROR_NOT_FOUND`

or the third client will be disconnected and will fail to read the response.


###### Step 9:

Node replies with *ApplicationServiceSendMessageResponse*:

  * `Message.id == 2`
  * `SingleResponse.version == [1,0,0]`
  * `Response.status == STATUS_OK`









#### HN05025 - Application Service Callee Uses Same Connection Twice 2

##### Prerequisites/Inputs

###### Prerequisites:
  * Node's database is empty.

###### Inputs:
  * Node's IP address
  * Node's primary port


##### Description 

The test simulates a callee accepting calls from two different callers but only using 
one TCP connection to clAppService port, which is forbidden. The difference over HN05024 
is that in this test, both calls are initialized properly and the callee mixes 
the connections after the initialization, not during the initialization.


###### Step 1:

The test creates three identities:

  * `$PubKeyCallee` set to public key of the first identity
  * `$PubKeyCaller1` set to public key of the second identity
  * `$PubKeyCaller2` set to public key of the third identity
  * `$IdentityIdCallee := SHA256($PubKeyCallee)` is the network ID of the first identity
  * `$IdentityIdCaller1 := SHA256($PubKeyCaller1)` is the network ID of the second identity
  * `$IdentityIdCaller2 := SHA256($PubKeyCaller2)` is the network ID of the third identity

Then it connects to the node's primary port and obtains a list of server roles using *ListRolesRequest* 
and closes the connection. Then it uses the first identity and establishes a home node agreement over 
clNonCustomer port and then it closes the connection. Then it checks-in the first identity over clCustomer 
port. The test then initializes its profile using *UpdateProfileRequest*. Finally, it checks-in 
application service called "Test Service" using *ApplicationServiceAddRequest* and leaves the connection 
open. 


###### Step 2:

Using its second identity, the test establishes a new TLS connection to the node's clNonCustomer port 
and verifies its identity using *VerifyIdentityRequest* and sends *CallIdentityApplicationServiceRequest*:

  * `Message.id := 3`
  * `CallIdentityApplicationServiceRequest.identityNetworkId := $IdentityIdCallee`
  * `CallIdentityApplicationServiceRequest.serviceName := "Test Service"`

Using its third identity, the test establishes a new TLS connection to the node's clNonCustomer port 
and verifies its identity using *VerifyIdentityRequest* and sends *CallIdentityApplicationServiceRequest*:

  * `Message.id := 3`
  * `CallIdentityApplicationServiceRequest.identityNetworkId := $IdentityIdCallee`
  * `CallIdentityApplicationServiceRequest.serviceName := "Test Service"`


###### Step 3:

The first identity reads the incoming request *IncomingCallNotificationRequest*:

  * `$calleeToken1 := IncomingCallNotificationRequest.calleeToken`

to which it replies with *IncomingCallNotificationResponse*.

Then it reads the second incoming request *IncomingCallNotificationRequest*:

  * `$calleeToken2 := IncomingCallNotificationRequest.calleeToken`

to which it replies with *IncomingCallNotificationResponse*.


Then it establishes a new TLS connection (FIRST connection) to the clAppService port and sends *ApplicationServiceSendMessageRequest*:

  * `Message.id := 1`
  * `SingleRequest.version := [1,0,0]`
  * `ApplicationServiceSendMessageRequest.token := $calleeToken1`
  * `ApplicationServiceSendMessageRequest.message` is uninitialized


Then it establishes a new TLS connection (SECOND connection) to the clAppService port and sends *ApplicationServiceSendMessageRequest*:

  * `Message.id := 1`
  * `SingleRequest.version := [1,0,0]`
  * `ApplicationServiceSendMessageRequest.token := $calleeToken2`
  * `ApplicationServiceSendMessageRequest.message` is uninitialized


###### Step 4:

The second identity reads the response in form of *CallIdentityApplicationServiceResponse*:

  * `$callerToken1 := CallIdentityApplicationServiceResponse.callerToken`

Then it establishes a new TLS connection to the clAppService port and sends *ApplicationServiceSendMessageRequest*:

  * `Message.id := 1`
  * `SingleRequest.version := [1,0,0]`
  * `ApplicationServiceSendMessageRequest.token := $callerToken1`
  * `ApplicationServiceSendMessageRequest.message` is uninitialized

and reads the response. 



The third identity reads the response in form of *CallIdentityApplicationServiceResponse*:

  * `$callerToken2 := CallIdentityApplicationServiceResponse.callerToken`

Then it establishes a new TLS connection to the clAppService port and sends *ApplicationServiceSendMessageRequest*:

  * `Message.id := 1`
  * `SingleRequest.version := [1,0,0]`
  * `ApplicationServiceSendMessageRequest.token := $callerToken2`
  * `ApplicationServiceSendMessageRequest.message` is uninitialized

and reads the response. 



###### Step 5:

On clAppService port, the first identity reads *ApplicationServiceSendMessageResponse*.
Then it reads *ApplicationServiceSendMessageResponse* again.


###### Step 6:

The second identity sends *ApplicationServiceSendMessageRequest*:

  * `Message.id := 2`
  * `SingleRequest.version := [1,0,0]`
  * `ApplicationServiceSendMessageRequest.token := $callerToken1`
  * `ApplicationServiceSendMessageRequest.message := "Message #1 to callee from caller1."`



###### Step 7:

From the FIRST connection, the first identity reads *ApplicationServiceReceiveMessageNotificationRequest* (#1 to callee).

Then it sends *ApplicationServiceReceiveMessageNotificationResponse*. 

And then after 3 second wait, it sends *ApplicationServiceSendMessageRequest*:

  * `Message.id := 2`
  * `SingleRequest.version := [1,0,0]`
  * `ApplicationServiceSendMessageRequest.token := $calleeToken2`
  * `ApplicationServiceSendMessageRequest.message := "Invalid Message"`

and reads the response.


###### Step 8:

After 3 second wait, the second identity sends *ApplicationServiceSendMessageRequest*:

  * `Message.id := 2`
  * `SingleRequest.version := [1,0,0]`
  * `ApplicationServiceSendMessageRequest.token := $callerToken1`
  * `ApplicationServiceSendMessageRequest.message := "Message #1 to callee from caller2."`

and reads the response.


###### Step 9:

The second identity reads *ApplicationServiceSendMessageResponse* (#1 to callee received).




  
##### Acceptance Criteria


###### Step 1:

The test successfully obtains list of ports on which the node provides its services. 
Then the test successfully establishes a home node agreement for its first identity.
Then the test successfully checks-in this identity and initializes its profile. 
Finally, the test successfully checks-in the application service.


###### Step 2:

The test successfully verifies its second identity.
The test successfully verifies its third identity.


###### Step 3:

Node sends *IncomingCallNotificationRequest*:

  * `IncomingCallNotificationRequest.callerPublicKey == $PubKeyCaller1`
  * `IncomingCallNotificationRequest.serviceName == "Test Service"`

Node sends *IncomingCallNotificationRequest*:

  * `IncomingCallNotificationRequest.callerPublicKey == $PubKeyCaller2`
  * `IncomingCallNotificationRequest.serviceName == "Test Service"`


###### Step 4:

Node replies with *CallIdentityApplicationServiceResponse*:

  * `Message.id == 3`
  * `Response.status == STATUS_OK`

Node replies with *ApplicationServiceSendMessageResponse*:

  * `Message.id == 1`
  * `Response.status == STATUS_OK`


Node replies with *CallIdentityApplicationServiceResponse*:

  * `Message.id == 3`
  * `Response.status == STATUS_OK`

Node replies with *ApplicationServiceSendMessageResponse*:

  * `Message.id == 1`
  * `Response.status == STATUS_OK`


###### Step 5:

Node replies with *ApplicationServiceSendMessageResponse*:

  * `Message.id == 1`
  * `Response.status == STATUS_OK`

Node replies with *ApplicationServiceSendMessageResponse*:

  * `Message.id == 1`
  * `Response.status == STATUS_OK`


###### Step 6:

Nothing to check.


###### Step 7:

Node sends *ApplicationServiceReceiveMessageNotificationRequest*:

  * `ApplicationServiceReceiveMessageNotificationRequest.message == "Message #1 to callee."`

Node replies with *Response*:

  * `Message.id == 2`
  * `Response.status == ERROR_NOT_FOUND`


###### Step 8:

Either the node replies with *ApplicationServiceSendMessageResponse*:

  * `Message.id == 1`
  * `SingleResponse.version == [1,0,0]`
  * `Response.status == ERROR_NOT_FOUND`

or the third client will be disconnected and will fail to read the response.


###### Step 9:

Node replies with *ApplicationServiceSendMessageResponse*:

  * `Message.id == 2`
  * `SingleResponse.version == [1,0,0]`
  * `Response.status == STATUS_OK`









### HN06xxx - Profile Search Related Functionality Tests

#### HN06001 - Profile Search - Simple Search

##### Prerequisites/Inputs

###### Prerequisites:
  * Node's database is empty.
  * "images/HN06001.jpg" file exists and contains JPEG image with size less than 20 kb

###### Inputs:
  * Node's IP address
  * Node's primary port


##### Description 

The test fills in the node's database with a newly created profiles and then performs several diffent search queries.


###### Step 1:

The test creates a primary identity which it uses for getting list of ports performing the search and then 
it creates the following identities, establishes home node agreements with the node, and initialize their profiles, 
for the sole purpose of being able to search among their profiles:

  * $profileInfo1 is `type := "Profile Type A", name := "Shanghai 1",   image := "images/HN06001.jpg", location := (31.23, 121.47),  extraData = null`
  * $profileInfo2 is `type := "Profile Type A", name := "Mumbai 1",     image := "images/HN06001.jpg", location := (18.96, 72.82),   extraData = "t=running,Cycling,ice hockey,water polo"`
  * $profileInfo3 is `type := "Profile Type A", name := "Karachi",      image := null,                 location := (24.86, 67.01),   extraData = "l=Karachi,PK;a=iop://185f8db32271fe25f561a6fc938b2e264306ec304eda518007d1764826381969;t=traveling,cycling,running"`
  * $profileInfo4 is `type := "Profile Type B", name := "Buenos Aires", image := "images/HN06001.jpg", location := (-34.61, -58.37), extraData = null`
  * $profileInfo5 is `type := "Profile Type B", name := "Shanghai 2",   image := null,                 location := (31.231, 121.47), extraData = "running"`
  * $profileInfo6 is `type := "Profile Type C", name := "Mumbai 2",     image := "images/HN06001.jpg", location := (18.961, 72.82),  extraData = "MTg1ZjhkYjMyMjcxZmUyNWY1NjFhNmZjOTM4YjJlMjY0MzA2ZWMzMDRlZGE1MTgwMDdkMTc2NDgyNjM4MTk2OQ=="`
  * $profileInfo7 is `type := "Profile Type C", name := "Mumbai 3",     image := null,                 location := (18.961, 72.82),  extraData = "t=running;l=Mumbai,IN"`



###### Step 2:

Using the primary identity, the test establishes a new TLS connection to the node's clNonCustomer port 
and sends *StartConversationRequest*:

  * `Message.id := 1`
  * `StartConversationRequest.supportedVersions := [[1,0,0]]`
  * `StartConversationRequest.publicKey` set to the test identity's 32 byte long public key
  * `StartConversationRequest.clientChallenge` set to 32 byte random challenge; `$ClientChallenge := StartConversationRequest.clientChallenge`
 
and reads the response.

Then it sends *ProfileSearchRequest* to find all test profiles:

  * `Message.id := 2`
  * `ProfileSearchRequest.includeHostedOnly := false`
  * `ProfileSearchRequest.includeThumbnailImages := true`
  * `ProfileSearchRequest.maxResponseRecordCount := 100`
  * `ProfileSearchRequest.maxTotalRecordCount := 100`
  * `ProfileSearchRequest.type := ""`
  * `ProfileSearchRequest.name := ""`
  * `ProfileSearchRequest.latitude := NO_LOCATION`
  * `ProfileSearchRequest.longitude := NO_LOCATION`
  * `ProfileSearchRequest.radius := 0`
  * `ProfileSearchRequest.extraData := ""`

and reads the response.


###### Step 3:

Then it sends *ProfileSearchRequest* to find profiles 4 and 5 by their type:

  * `Message.id := 3`
  * `ProfileSearchRequest.includeHostedOnly := false`
  * `ProfileSearchRequest.includeThumbnailImages := true`
  * `ProfileSearchRequest.maxResponseRecordCount := 100`
  * `ProfileSearchRequest.maxTotalRecordCount := 100`
  * `ProfileSearchRequest.type := "*Type B"`
  * `ProfileSearchRequest.name := ""`
  * `ProfileSearchRequest.latitude := NO_LOCATION`
  * `ProfileSearchRequest.longitude := NO_LOCATION`
  * `ProfileSearchRequest.radius := 0`
  * `ProfileSearchRequest.extraData := ""`

and reads the response.


###### Step 4:

Then it sends *ProfileSearchRequest* to find profiles 6 and 7 by their type:

  * `Message.id := 4`
  * `ProfileSearchRequest.includeHostedOnly := false`
  * `ProfileSearchRequest.includeThumbnailImages := true`
  * `ProfileSearchRequest.maxResponseRecordCount := 100`
  * `ProfileSearchRequest.maxTotalRecordCount := 100`
  * `ProfileSearchRequest.type := "Profile Type C"`
  * `ProfileSearchRequest.name := ""`
  * `ProfileSearchRequest.latitude := NO_LOCATION`
  * `ProfileSearchRequest.longitude := NO_LOCATION`
  * `ProfileSearchRequest.radius := 0`
  * `ProfileSearchRequest.extraData := ""`

and reads the response.

  
###### Step 5:

Then it sends *ProfileSearchRequest* to find profiles 2, 6 and 7 by their name:

  * `Message.id := 5`
  * `ProfileSearchRequest.includeHostedOnly := false`
  * `ProfileSearchRequest.includeThumbnailImages := true`
  * `ProfileSearchRequest.maxResponseRecordCount := 100`
  * `ProfileSearchRequest.maxTotalRecordCount := 100`
  * `ProfileSearchRequest.type := ""`
  * `ProfileSearchRequest.name := "Mumbai *"`
  * `ProfileSearchRequest.latitude := NO_LOCATION`
  * `ProfileSearchRequest.longitude := NO_LOCATION`
  * `ProfileSearchRequest.radius := 0`
  * `ProfileSearchRequest.extraData := ""`

and reads the response.

  
###### Step 6:

Then it sends *ProfileSearchRequest* to find profiles 1, 2, 4, 5, 6 and 7 by their name:

  * `Message.id := 6`
  * `ProfileSearchRequest.includeHostedOnly := false`
  * `ProfileSearchRequest.includeThumbnailImages := true`
  * `ProfileSearchRequest.maxResponseRecordCount := 100`
  * `ProfileSearchRequest.maxTotalRecordCount := 100`
  * `ProfileSearchRequest.type := ""`
  * `ProfileSearchRequest.name := "*ai*"`
  * `ProfileSearchRequest.latitude := NO_LOCATION`
  * `ProfileSearchRequest.longitude := NO_LOCATION`
  * `ProfileSearchRequest.radius := 0`
  * `ProfileSearchRequest.extraData := ""`

and reads the response.

  
###### Step 7:

Then it sends *ProfileSearchRequest* to find profiles 6 and 7 by their location:

  * `Message.id := 7`
  * `ProfileSearchRequest.includeHostedOnly := false`
  * `ProfileSearchRequest.includeThumbnailImages := true`
  * `ProfileSearchRequest.maxResponseRecordCount := 100`
  * `ProfileSearchRequest.maxTotalRecordCount := 100`
  * `ProfileSearchRequest.type := ""`
  * `ProfileSearchRequest.name := ""`
  * `ProfileSearchRequest.latitude := 18961000`
  * `ProfileSearchRequest.longitude := 72820000`
  * `ProfileSearchRequest.radius := 10`
  * `ProfileSearchRequest.extraData := ""`

and reads the response.

  
###### Step 8:

Then it sends *ProfileSearchRequest* to find profiles 2, 6 and 7 by their location:

  * `Message.id := 8`
  * `ProfileSearchRequest.includeHostedOnly := false`
  * `ProfileSearchRequest.includeThumbnailImages := true`
  * `ProfileSearchRequest.maxResponseRecordCount := 100`
  * `ProfileSearchRequest.maxTotalRecordCount := 100`
  * `ProfileSearchRequest.type := ""`
  * `ProfileSearchRequest.name := ""`
  * `ProfileSearchRequest.latitude := 18961000`
  * `ProfileSearchRequest.longitude := 72820000`
  * `ProfileSearchRequest.radius := 5000`
  * `ProfileSearchRequest.extraData := ""`

and reads the response.


###### Step 9:

Then it sends *ProfileSearchRequest* to find no profiles because of the location filter:

  * `Message.id := 9`
  * `ProfileSearchRequest.includeHostedOnly := false`
  * `ProfileSearchRequest.includeThumbnailImages := true`
  * `ProfileSearchRequest.maxResponseRecordCount := 100`
  * `ProfileSearchRequest.maxTotalRecordCount := 100`
  * `ProfileSearchRequest.type := ""`
  * `ProfileSearchRequest.name := ""`
  * `ProfileSearchRequest.latitude := -12345678`
  * `ProfileSearchRequest.longitude := 12345678`
  * `ProfileSearchRequest.radius := 5000`
  * `ProfileSearchRequest.extraData := ""`

and reads the response.


###### Step 10:

Then it sends *ProfileSearchRequest* to find no profiles because of the extra data filter:

  * `Message.id := 10`
  * `ProfileSearchRequest.includeHostedOnly := false`
  * `ProfileSearchRequest.includeThumbnailImages := true`
  * `ProfileSearchRequest.maxResponseRecordCount := 100`
  * `ProfileSearchRequest.maxTotalRecordCount := 100`
  * `ProfileSearchRequest.type := ""`
  * `ProfileSearchRequest.name := ""`
  * `ProfileSearchRequest.latitude := NO_LOCATION`
  * `ProfileSearchRequest.longitude := NO_LOCATION`
  * `ProfileSearchRequest.radius := 0`
  * `ProfileSearchRequest.extraData := "no profiles"`

and reads the response.


###### Step 11:

Then it sends *ProfileSearchRequest* to find profiles 2, 3 and 7 by their extraData information:

  * `Message.id := 11`
  * `ProfileSearchRequest.includeHostedOnly := false`
  * `ProfileSearchRequest.includeThumbnailImages := true`
  * `ProfileSearchRequest.maxResponseRecordCount := 100`
  * `ProfileSearchRequest.maxTotalRecordCount := 100`
  * `ProfileSearchRequest.type := ""`
  * `ProfileSearchRequest.name := ""`
  * `ProfileSearchRequest.latitude := NO_LOCATION`
  * `ProfileSearchRequest.longitude := NO_LOCATION`
  * `ProfileSearchRequest.radius := 0`
  * `ProfileSearchRequest.extraData := "(^|;)t=(|[^=]+,)running([;,]|$)"`

and reads the response.


###### Step 12:

Then it sends *ProfileSearchRequest* to find profiles 2, 3, 5, 6, 7, but only return first 2 records:

  * `Message.id := 12`
  * `ProfileSearchRequest.includeHostedOnly := false`
  * `ProfileSearchRequest.includeThumbnailImages := true`
  * `ProfileSearchRequest.maxResponseRecordCount := 2`
  * `ProfileSearchRequest.maxTotalRecordCount := 100`
  * `ProfileSearchRequest.type := ""`
  * `ProfileSearchRequest.name := ""`
  * `ProfileSearchRequest.latitude := NO_LOCATION`
  * `ProfileSearchRequest.longitude := NO_LOCATION`
  * `ProfileSearchRequest.radius := 0`
  * `ProfileSearchRequest.extraData := ".+"`

and reads the response. Then it sends *ProfileSearchPartRequest* to get the next 2 records:

  * `Message.id := 13`
  * `ProfileSearchPartRequest.recordIndex := 2`
  * `ProfileSearchPartRequest.recordCount := 2`

and reads the response. Then it sends *ProfileSearchPartRequest* to get the remaining record:

  * `Message.id := 14`
  * `ProfileSearchPartRequest.recordIndex := 4`
  * `ProfileSearchPartRequest.recordCount := 1`

and reads the response. Then it sends *ProfileSearchPartRequest* to get all records again:

  * `Message.id := 15`
  * `ProfileSearchPartRequest.recordIndex := 0`
  * `ProfileSearchPartRequest.recordCount := 5`

and reads the response.


###### Step 13:

Then it sends *ProfileSearchRequest* to find profiles 2, 3 and 7 by their extraData information, but only search for and get 2 records without images:

  * `Message.id := 16`
  * `ProfileSearchRequest.includeHostedOnly := false`
  * `ProfileSearchRequest.includeThumbnailImages := false`
  * `ProfileSearchRequest.maxResponseRecordCount := 2`
  * `ProfileSearchRequest.maxTotalRecordCount := 2`
  * `ProfileSearchRequest.type := ""`
  * `ProfileSearchRequest.name := ""`
  * `ProfileSearchRequest.latitude := NO_LOCATION`
  * `ProfileSearchRequest.longitude := NO_LOCATION`
  * `ProfileSearchRequest.radius := 0`
  * `ProfileSearchRequest.extraData := "(^|;)t=(|[^=]+,)running([;,]|$)"`

and reads the response.



###### Step 14:

Then it sends *ProfileSearchRequest* to find all profiles by their type:

  * `Message.id := 17`
  * `ProfileSearchRequest.includeHostedOnly := false`
  * `ProfileSearchRequest.includeThumbnailImages := true`
  * `ProfileSearchRequest.maxResponseRecordCount := 100`
  * `ProfileSearchRequest.maxTotalRecordCount := 100`
  * `ProfileSearchRequest.type := "profile*"`
  * `ProfileSearchRequest.name := ""`
  * `ProfileSearchRequest.latitude := NO_LOCATION`
  * `ProfileSearchRequest.longitude := NO_LOCATION`
  * `ProfileSearchRequest.radius := 0`
  * `ProfileSearchRequest.extraData := ""`

and reads the response.


  
###### Step 15:

Then it sends *ProfileSearchRequest* to find all profiles by their type:

  * `Message.id := 18`
  * `ProfileSearchRequest.includeHostedOnly := false`
  * `ProfileSearchRequest.includeThumbnailImages := true`
  * `ProfileSearchRequest.maxResponseRecordCount := 100`
  * `ProfileSearchRequest.maxTotalRecordCount := 100`
  * `ProfileSearchRequest.type := "*file*"`
  * `ProfileSearchRequest.name := ""`
  * `ProfileSearchRequest.latitude := NO_LOCATION`
  * `ProfileSearchRequest.longitude := NO_LOCATION`
  * `ProfileSearchRequest.radius := 0`
  * `ProfileSearchRequest.extraData := ""`

and reads the response.


  
###### Step 16:

Then it sends *ProfileSearchRequest* to find all profiles by their type:

  * `Message.id := 19`
  * `ProfileSearchRequest.includeHostedOnly := false`
  * `ProfileSearchRequest.includeThumbnailImages := true`
  * `ProfileSearchRequest.maxResponseRecordCount := 100`
  * `ProfileSearchRequest.maxTotalRecordCount := 100`
  * `ProfileSearchRequest.type := "**"`
  * `ProfileSearchRequest.name := ""`
  * `ProfileSearchRequest.latitude := NO_LOCATION`
  * `ProfileSearchRequest.longitude := NO_LOCATION`
  * `ProfileSearchRequest.radius := 0`
  * `ProfileSearchRequest.extraData := ""`

and reads the response.


  
###### Step 17:

Then it sends *ProfileSearchRequest* to find all profiles by their type:

  * `Message.id := 20`
  * `ProfileSearchRequest.includeHostedOnly := false`
  * `ProfileSearchRequest.includeThumbnailImages := true`
  * `ProfileSearchRequest.maxResponseRecordCount := 100`
  * `ProfileSearchRequest.maxTotalRecordCount := 100`
  * `ProfileSearchRequest.type := "*"`
  * `ProfileSearchRequest.name := ""`
  * `ProfileSearchRequest.latitude := NO_LOCATION`
  * `ProfileSearchRequest.longitude := NO_LOCATION`
  * `ProfileSearchRequest.radius := 0`
  * `ProfileSearchRequest.extraData := ""`

and reads the response.



###### Step 18:

Then it sends *ProfileSearchRequest* to find profiles 1 and 2 by their name:

  * `Message.id := 21`
  * `ProfileSearchRequest.includeHostedOnly := false`
  * `ProfileSearchRequest.includeThumbnailImages := true`
  * `ProfileSearchRequest.maxResponseRecordCount := 100`
  * `ProfileSearchRequest.maxTotalRecordCount := 100`
  * `ProfileSearchRequest.type := ""`
  * `ProfileSearchRequest.name := "*1"`
  * `ProfileSearchRequest.latitude := NO_LOCATION`
  * `ProfileSearchRequest.longitude := NO_LOCATION`
  * `ProfileSearchRequest.radius := 0`
  * `ProfileSearchRequest.extraData := ""`

and reads the response.


###### Step 19:

Then it sends *ProfileSearchRequest* to find profile 1 its name:

  * `Message.id := 22`
  * `ProfileSearchRequest.includeHostedOnly := false`
  * `ProfileSearchRequest.includeThumbnailImages := true`
  * `ProfileSearchRequest.maxResponseRecordCount := 100`
  * `ProfileSearchRequest.maxTotalRecordCount := 100`
  * `ProfileSearchRequest.type := ""`
  * `ProfileSearchRequest.name := "Shanghai 1"`
  * `ProfileSearchRequest.latitude := NO_LOCATION`
  * `ProfileSearchRequest.longitude := NO_LOCATION`
  * `ProfileSearchRequest.radius := 0`
  * `ProfileSearchRequest.extraData := ""`

and reads the response.



###### Step 20:

Then it sends *ProfileSearchRequest* to find all profiles by their name:

  * `Message.id := 23`
  * `ProfileSearchRequest.includeHostedOnly := false`
  * `ProfileSearchRequest.includeThumbnailImages := true`
  * `ProfileSearchRequest.maxResponseRecordCount := 100`
  * `ProfileSearchRequest.maxTotalRecordCount := 100`
  * `ProfileSearchRequest.type := ""`
  * `ProfileSearchRequest.name := "**"`
  * `ProfileSearchRequest.latitude := NO_LOCATION`
  * `ProfileSearchRequest.longitude := NO_LOCATION`
  * `ProfileSearchRequest.radius := 0`
  * `ProfileSearchRequest.extraData := ""`

and reads the response.



###### Step 21:

Then it sends *ProfileSearchRequest* to find all profiles by their name:

  * `Message.id := 24`
  * `ProfileSearchRequest.includeHostedOnly := false`
  * `ProfileSearchRequest.includeThumbnailImages := true`
  * `ProfileSearchRequest.maxResponseRecordCount := 100`
  * `ProfileSearchRequest.maxTotalRecordCount := 100`
  * `ProfileSearchRequest.type := ""`
  * `ProfileSearchRequest.name := "*"`
  * `ProfileSearchRequest.latitude := NO_LOCATION`
  * `ProfileSearchRequest.longitude := NO_LOCATION`
  * `ProfileSearchRequest.radius := 0`
  * `ProfileSearchRequest.extraData := ""`

and reads the response.


###### Step 22:

Then it sends *ProfileSearchRequest* to find profile 2 using multiple criteria:

  * `Message.id := 25`
  * `ProfileSearchRequest.includeHostedOnly := false`
  * `ProfileSearchRequest.includeThumbnailImages := true`
  * `ProfileSearchRequest.maxResponseRecordCount := 100`
  * `ProfileSearchRequest.maxTotalRecordCount := 100`
  * `ProfileSearchRequest.type := "*Type A"`
  * `ProfileSearchRequest.name := "*ai*"`
  * `ProfileSearchRequest.latitude := NO_LOCATION`
  * `ProfileSearchRequest.longitude := NO_LOCATION`
  * `ProfileSearchRequest.radius := 0`
  * `ProfileSearchRequest.extraData := "water"`

and reads the response.


###### Step 23:

Then it sends *ProfileSearchRequest* to find profiles 2, 3, 5, 6, 7, but only return first 2 records:

  * `Message.id := 26`
  * `ProfileSearchRequest.includeHostedOnly := false`
  * `ProfileSearchRequest.includeThumbnailImages := true`
  * `ProfileSearchRequest.maxResponseRecordCount := 2`
  * `ProfileSearchRequest.maxTotalRecordCount := 100`
  * `ProfileSearchRequest.type := ""`
  * `ProfileSearchRequest.name := ""`
  * `ProfileSearchRequest.latitude := NO_LOCATION`
  * `ProfileSearchRequest.longitude := NO_LOCATION`
  * `ProfileSearchRequest.radius := 0`
  * `ProfileSearchRequest.extraData := ".+"`

and reads the response. After 15 seconds wait, it sends *ProfileSearchPartRequest*:

  * `Message.id := 27`
  * `ProfileSearchPartRequest.recordIndex := 8`
  * `ProfileSearchPartRequest.recordCount := 2`

and reads the response. After 15 seconds wait, it sends *ProfileSearchPartRequest*:

  * `Message.id := 28`
  * `ProfileSearchPartRequest.recordIndex := 4`
  * `ProfileSearchPartRequest.recordCount := 5`

and reads the response. After 22 seconds wait, it sends *ProfileSearchPartRequest*:

  * `Message.id := 29`
  * `ProfileSearchPartRequest.recordIndex := 0`
  * `ProfileSearchPartRequest.recordCount := 500`

and reads the response. Then it sends *ProfileSearchPartRequest* to get all records:

  * `Message.id := 30`
  * `ProfileSearchPartRequest.recordIndex := 0`
  * `ProfileSearchPartRequest.recordCount := 5`

and reads the response.


  
##### Acceptance Criteria


###### Step 1:

The test successfully obtains list of ports on which the node provides its services. 
Then the test successfully establishes home node agreements for its test identities.
Then the test successfully initializes all test profiles. 


###### Step 2:

Node replies with *StartConversationResponse*:
  
  * `Message.id == 1`
  * `Response.status == STATUS_OK`
  * `ConversationResponse.signature` is a valid signature of $ClientChallenge
  * `StartConversationResponse.clientChallenge == $ClientChallenge`


Node sends *ProfileSearchResponse*:

  * `Message.id == 2`
  * `Response.status == STATUS_OK`
  * `ProfileSearchResponse.totalRecordCount == 7`
  * `ProfileSearchResponse.maxResponseRecordCount == 100`
  * `ProfileSearchResponse.profiles.Count == 7`
  * `ProfileSearchResponse.profiles == 
    (
      {isHosted == true, isOnline == false; type, name, latitude, longitude, extraData match $profileInfo1; image != empty},
      {isHosted == true, isOnline == false; type, name, latitude, longitude, extraData match $profileInfo2; image != empty},
      {isHosted == true, isOnline == false; type, name, latitude, longitude, extraData match $profileInfo3; image == empty},
      {isHosted == true, isOnline == false; type, name, latitude, longitude, extraData match $profileInfo4; image != empty},
      {isHosted == true, isOnline == false; type, name, latitude, longitude, extraData match $profileInfo5; image == empty},
      {isHosted == true, isOnline == false; type, name, latitude, longitude, extraData match $profileInfo6; image != empty},
      {isHosted == true, isOnline == false; type, name, latitude, longitude, extraData match $profileInfo7; image == empty},
    )`



###### Step 3:

Node sends *ProfileSearchResponse*:

  * `Message.id == 3`
  * `Response.status == STATUS_OK`
  * `ProfileSearchResponse.totalRecordCount == 2`
  * `ProfileSearchResponse.maxResponseRecordCount == 100`
  * `ProfileSearchResponse.profiles.Count == 2`
  * `ProfileSearchResponse.profiles == 
    (
      {isHosted == true, isOnline == false; type, name, latitude, longitude, extraData match $profileInfo4; image != empty},
      {isHosted == true, isOnline == false; type, name, latitude, longitude, extraData match $profileInfo5; image == empty},
    )`




###### Step 4:

Node sends *ProfileSearchResponse*:

  * `Message.id == 4`
  * `Response.status == STATUS_OK`
  * `ProfileSearchResponse.totalRecordCount == 2`
  * `ProfileSearchResponse.maxResponseRecordCount == 100`
  * `ProfileSearchResponse.profiles.Count == 2`
  * `ProfileSearchResponse.profiles == 
    (
      {isHosted == true, isOnline == false; type, name, latitude, longitude, extraData match $profileInfo6; image != empty},
      {isHosted == true, isOnline == false; type, name, latitude, longitude, extraData match $profileInfo7; image == empty},
    )`

  
###### Step 5:

Node sends *ProfileSearchResponse*:

  * `Message.id == 5`
  * `Response.status == STATUS_OK`
  * `ProfileSearchResponse.totalRecordCount == 3`
  * `ProfileSearchResponse.maxResponseRecordCount == 100`
  * `ProfileSearchResponse.profiles.Count == 3`
  * `ProfileSearchResponse.profiles == 
    (
      {isHosted == true, isOnline == false; type, name, latitude, longitude, extraData match $profileInfo2; image != empty},
      {isHosted == true, isOnline == false; type, name, latitude, longitude, extraData match $profileInfo6; image != empty},
      {isHosted == true, isOnline == false; type, name, latitude, longitude, extraData match $profileInfo7; image == empty},
    )`

  
###### Step 6:

Node sends *ProfileSearchResponse*:

  * `Message.id == 6`
  * `Response.status == STATUS_OK`
  * `ProfileSearchResponse.totalRecordCount == 6`
  * `ProfileSearchResponse.maxResponseRecordCount == 100`
  * `ProfileSearchResponse.profiles.Count == 6`
  * `ProfileSearchResponse.profiles == 
    (
      {isHosted == true, isOnline == false; type, name, latitude, longitude, extraData match $profileInfo1; image != empty},
      {isHosted == true, isOnline == false; type, name, latitude, longitude, extraData match $profileInfo2; image != empty},
      {isHosted == true, isOnline == false; type, name, latitude, longitude, extraData match $profileInfo4; image != empty},
      {isHosted == true, isOnline == false; type, name, latitude, longitude, extraData match $profileInfo5; image == empty},
      {isHosted == true, isOnline == false; type, name, latitude, longitude, extraData match $profileInfo6; image != empty},
      {isHosted == true, isOnline == false; type, name, latitude, longitude, extraData match $profileInfo7; image == empty},
    )`

  
###### Step 7:

Node sends *ProfileSearchResponse*:

  * `Message.id == 7`
  * `Response.status == STATUS_OK`
  * `ProfileSearchResponse.totalRecordCount == 2`
  * `ProfileSearchResponse.maxResponseRecordCount == 100`
  * `ProfileSearchResponse.profiles.Count == 2`
  * `ProfileSearchResponse.profiles == 
    (
      {isHosted == true, isOnline == false; type, name, latitude, longitude, extraData match $profileInfo6; image != empty},
      {isHosted == true, isOnline == false; type, name, latitude, longitude, extraData match $profileInfo7; image == empty},
    )`

  
###### Step 8:

Node sends *ProfileSearchResponse*:

  * `Message.id == 8`
  * `Response.status == STATUS_OK`
  * `ProfileSearchResponse.totalRecordCount == 3`
  * `ProfileSearchResponse.maxResponseRecordCount == 100`
  * `ProfileSearchResponse.profiles.Count == 3`
  * `ProfileSearchResponse.profiles == 
    (
      {isHosted == true, isOnline == false; type, name, latitude, longitude, extraData match $profileInfo2; image != empty},
      {isHosted == true, isOnline == false; type, name, latitude, longitude, extraData match $profileInfo6; image != empty},
      {isHosted == true, isOnline == false; type, name, latitude, longitude, extraData match $profileInfo7; image == empty},
    )`


###### Step 9:

Node sends *ProfileSearchResponse*:

  * `Message.id == 9`
  * `Response.status == STATUS_OK`
  * `ProfileSearchResponse.totalRecordCount == 0`
  * `ProfileSearchResponse.maxResponseRecordCount == 100`
  * `ProfileSearchResponse.profiles.Count == 0`


###### Step 10:

Node sends *ProfileSearchResponse*:

  * `Message.id == 10`
  * `Response.status == STATUS_OK`
  * `ProfileSearchResponse.totalRecordCount == 0`
  * `ProfileSearchResponse.maxResponseRecordCount == 100`
  * `ProfileSearchResponse.profiles.Count == 0`


###### Step 11:

Node sends *ProfileSearchResponse*:

  * `Message.id == 11`
  * `Response.status == STATUS_OK`
  * `ProfileSearchResponse.totalRecordCount == 3`
  * `ProfileSearchResponse.maxResponseRecordCount == 100`
  * `ProfileSearchResponse.profiles.Count == 3`
  * `ProfileSearchResponse.profiles == 
    (
      {isHosted == true, isOnline == false; type, name, latitude, longitude, extraData match $profileInfo2; image != empty},
      {isHosted == true, isOnline == false; type, name, latitude, longitude, extraData match $profileInfo3; image == empty},
      {isHosted == true, isOnline == false; type, name, latitude, longitude, extraData match $profileInfo7; image == empty},
    )`



###### Step 12:

Node sends *ProfileSearchResponse*:

  * `Message.id == 12`
  * `Response.status == STATUS_OK`
  * `ProfileSearchResponse.totalRecordCount == 5`
  * `ProfileSearchResponse.maxResponseRecordCount == 2`
  * `ProfileSearchResponse.profiles.Count == 2`
  * `$SetA := ProfileSearchResponse.profiles`


Node sends *ProfileSearchPartResponse*:

  * `Message.id == 13`
  * `Response.status == STATUS_OK`
  * `ProfileSearchPartResponse.recordIndex == 2`
  * `ProfileSearchPartResponse.recordCount == 2`
  * `ProfileSearchPartResponse.profiles.Count == 2`
  * `$SetB := ProfileSearchPartResponse.profiles`


Node sends *ProfileSearchPartResponse*:

  * `Message.id == 14`
  * `Response.status == STATUS_OK`
  * `ProfileSearchPartResponse.recordIndex == 4`
  * `ProfileSearchPartResponse.recordCount == 1`
  * `ProfileSearchPartResponse.profiles.Count == 1`
  * `$SetC := ProfileSearchPartResponse.profiles`


Node sends *ProfileSearchPartResponse*:

  * `Message.id == 15`
  * `Response.status == STATUS_OK`
  * `ProfileSearchPartResponse.recordIndex == 0`
  * `ProfileSearchPartResponse.recordCount == 5`
  * `ProfileSearchPartResponse.profiles.Count == 5`
  * `$SetAll := ProfileSearchPartResponse.profiles ==
    (
      {isHosted == true, isOnline == false; type, name, latitude, longitude, extraData match $profileInfo2; image != empty},
      {isHosted == true, isOnline == false; type, name, latitude, longitude, extraData match $profileInfo3; image == empty},
      {isHosted == true, isOnline == false; type, name, latitude, longitude, extraData match $profileInfo5; image == empty},
      {isHosted == true, isOnline == false; type, name, latitude, longitude, extraData match $profileInfo6; image != empty},
      {isHosted == true, isOnline == false; type, name, latitude, longitude, extraData match $profileInfo7; image == empty},
    )`

  * `$SetA + $SetB + $SetC == $SetAll`



###### Step 13:

Node sends *ProfileSearchResponse*:

  * `Message.id == 16`
  * `Response.status == STATUS_OK`
  * `ProfileSearchResponse.totalRecordCount == 2`
  * `ProfileSearchResponse.maxResponseRecordCount == 100`
  * `ProfileSearchResponse.profiles.Count == 2`
  * `ProfileSearchResponse.profiles == any two of 
    (
      {isHosted == true, isOnline == false; type, name, latitude, longitude, extraData match $profileInfo2; image == empty},
      {isHosted == true, isOnline == false; type, name, latitude, longitude, extraData match $profileInfo3; image == empty},
      {isHosted == true, isOnline == false; type, name, latitude, longitude, extraData match $profileInfo7; image == empty},
    )`



###### Step 14:

Node sends *ProfileSearchResponse*:

  * `Message.id == 17`
  * `Response.status == STATUS_OK`
  * `ProfileSearchResponse.totalRecordCount == 7`
  * `ProfileSearchResponse.maxResponseRecordCount == 100`
  * `ProfileSearchResponse.profiles.Count == 7`
  * `ProfileSearchResponse.profiles == 
    (
      {isHosted == true, isOnline == false; type, name, latitude, longitude, extraData match $profileInfo1; image != empty},
      {isHosted == true, isOnline == false; type, name, latitude, longitude, extraData match $profileInfo2; image != empty},
      {isHosted == true, isOnline == false; type, name, latitude, longitude, extraData match $profileInfo3; image == empty},
      {isHosted == true, isOnline == false; type, name, latitude, longitude, extraData match $profileInfo4; image != empty},
      {isHosted == true, isOnline == false; type, name, latitude, longitude, extraData match $profileInfo5; image == empty},
      {isHosted == true, isOnline == false; type, name, latitude, longitude, extraData match $profileInfo6; image != empty},
      {isHosted == true, isOnline == false; type, name, latitude, longitude, extraData match $profileInfo7; image == empty},
    )`


###### Step 15:

Node sends *ProfileSearchResponse*:

  * `Message.id == 18`
  * `Response.status == STATUS_OK`
  * `ProfileSearchResponse.totalRecordCount == 7`
  * `ProfileSearchResponse.maxResponseRecordCount == 100`
  * `ProfileSearchResponse.profiles.Count == 7`
  * `ProfileSearchResponse.profiles == 
    (
      {isHosted == true, isOnline == false; type, name, latitude, longitude, extraData match $profileInfo1; image != empty},
      {isHosted == true, isOnline == false; type, name, latitude, longitude, extraData match $profileInfo2; image != empty},
      {isHosted == true, isOnline == false; type, name, latitude, longitude, extraData match $profileInfo3; image == empty},
      {isHosted == true, isOnline == false; type, name, latitude, longitude, extraData match $profileInfo4; image != empty},
      {isHosted == true, isOnline == false; type, name, latitude, longitude, extraData match $profileInfo5; image == empty},
      {isHosted == true, isOnline == false; type, name, latitude, longitude, extraData match $profileInfo6; image != empty},
      {isHosted == true, isOnline == false; type, name, latitude, longitude, extraData match $profileInfo7; image == empty},
    )`


###### Step 16:

Node sends *ProfileSearchResponse*:

  * `Message.id == 19`
  * `Response.status == STATUS_OK`
  * `ProfileSearchResponse.totalRecordCount == 7`
  * `ProfileSearchResponse.maxResponseRecordCount == 100`
  * `ProfileSearchResponse.profiles.Count == 7`
  * `ProfileSearchResponse.profiles == 
    (
      {isHosted == true, isOnline == false; type, name, latitude, longitude, extraData match $profileInfo1; image != empty},
      {isHosted == true, isOnline == false; type, name, latitude, longitude, extraData match $profileInfo2; image != empty},
      {isHosted == true, isOnline == false; type, name, latitude, longitude, extraData match $profileInfo3; image == empty},
      {isHosted == true, isOnline == false; type, name, latitude, longitude, extraData match $profileInfo4; image != empty},
      {isHosted == true, isOnline == false; type, name, latitude, longitude, extraData match $profileInfo5; image == empty},
      {isHosted == true, isOnline == false; type, name, latitude, longitude, extraData match $profileInfo6; image != empty},
      {isHosted == true, isOnline == false; type, name, latitude, longitude, extraData match $profileInfo7; image == empty},
    )`


###### Step 17:

Node sends *ProfileSearchResponse*:

  * `Message.id == 20`
  * `Response.status == STATUS_OK`
  * `ProfileSearchResponse.totalRecordCount == 7`
  * `ProfileSearchResponse.maxResponseRecordCount == 100`
  * `ProfileSearchResponse.profiles.Count == 7`
  * `ProfileSearchResponse.profiles == 
    (
      {isHosted == true, isOnline == false; type, name, latitude, longitude, extraData match $profileInfo1; image != empty},
      {isHosted == true, isOnline == false; type, name, latitude, longitude, extraData match $profileInfo2; image != empty},
      {isHosted == true, isOnline == false; type, name, latitude, longitude, extraData match $profileInfo3; image == empty},
      {isHosted == true, isOnline == false; type, name, latitude, longitude, extraData match $profileInfo4; image != empty},
      {isHosted == true, isOnline == false; type, name, latitude, longitude, extraData match $profileInfo5; image == empty},
      {isHosted == true, isOnline == false; type, name, latitude, longitude, extraData match $profileInfo6; image != empty},
      {isHosted == true, isOnline == false; type, name, latitude, longitude, extraData match $profileInfo7; image == empty},
    )`


###### Step 18:

Node sends *ProfileSearchResponse*:

  * `Message.id == 21`
  * `Response.status == STATUS_OK`
  * `ProfileSearchResponse.totalRecordCount == 2`
  * `ProfileSearchResponse.maxResponseRecordCount == 100`
  * `ProfileSearchResponse.profiles.Count == 2`
  * `ProfileSearchResponse.profiles == 
    (
      {isHosted == true, isOnline == false; type, name, latitude, longitude, extraData match $profileInfo1; image != empty},
      {isHosted == true, isOnline == false; type, name, latitude, longitude, extraData match $profileInfo2; image != empty},
    )`


###### Step 19:

Node sends *ProfileSearchResponse*:

  * `Message.id == 22`
  * `Response.status == STATUS_OK`
  * `ProfileSearchResponse.totalRecordCount == 1`
  * `ProfileSearchResponse.maxResponseRecordCount == 100`
  * `ProfileSearchResponse.profiles.Count == 1`
  * `ProfileSearchResponse.profiles == 
    (
      {isHosted == true, isOnline == false; type, name, latitude, longitude, extraData match $profileInfo1; image != empty},
    )`


###### Step 20:

Node sends *ProfileSearchResponse*:

  * `Message.id == 23`
  * `Response.status == STATUS_OK`
  * `ProfileSearchResponse.totalRecordCount == 7`
  * `ProfileSearchResponse.maxResponseRecordCount == 100`
  * `ProfileSearchResponse.profiles.Count == 7`
  * `ProfileSearchResponse.profiles == 
    (
      {isHosted == true, isOnline == false; type, name, latitude, longitude, extraData match $profileInfo1; image != empty},
      {isHosted == true, isOnline == false; type, name, latitude, longitude, extraData match $profileInfo2; image != empty},
      {isHosted == true, isOnline == false; type, name, latitude, longitude, extraData match $profileInfo3; image == empty},
      {isHosted == true, isOnline == false; type, name, latitude, longitude, extraData match $profileInfo4; image != empty},
      {isHosted == true, isOnline == false; type, name, latitude, longitude, extraData match $profileInfo5; image == empty},
      {isHosted == true, isOnline == false; type, name, latitude, longitude, extraData match $profileInfo6; image != empty},
      {isHosted == true, isOnline == false; type, name, latitude, longitude, extraData match $profileInfo7; image == empty},
    )`


###### Step 21:

Node sends *ProfileSearchResponse*:

  * `Message.id == 24`
  * `Response.status == STATUS_OK`
  * `ProfileSearchResponse.totalRecordCount == 7`
  * `ProfileSearchResponse.maxResponseRecordCount == 100`
  * `ProfileSearchResponse.profiles.Count == 7`
  * `ProfileSearchResponse.profiles == 
    (
      {isHosted == true, isOnline == false; type, name, latitude, longitude, extraData match $profileInfo1; image != empty},
      {isHosted == true, isOnline == false; type, name, latitude, longitude, extraData match $profileInfo2; image != empty},
      {isHosted == true, isOnline == false; type, name, latitude, longitude, extraData match $profileInfo3; image == empty},
      {isHosted == true, isOnline == false; type, name, latitude, longitude, extraData match $profileInfo4; image != empty},
      {isHosted == true, isOnline == false; type, name, latitude, longitude, extraData match $profileInfo5; image == empty},
      {isHosted == true, isOnline == false; type, name, latitude, longitude, extraData match $profileInfo6; image != empty},
      {isHosted == true, isOnline == false; type, name, latitude, longitude, extraData match $profileInfo7; image == empty},
    )`



###### Step 22:

Node sends *ProfileSearchResponse*:

  * `Message.id == 25`
  * `Response.status == STATUS_OK`
  * `ProfileSearchResponse.totalRecordCount == 1`
  * `ProfileSearchResponse.maxResponseRecordCount == 100`
  * `ProfileSearchResponse.profiles.Count == 1`
  * `ProfileSearchResponse.profiles == 
    (
      {isHosted == true, isOnline == false; type, name, latitude, longitude, extraData match $profileInfo2; image != empty},
    )`



###### Step 23:

Node sends *ProfileSearchResponse*:

  * `Message.id == 26`
  * `Response.status == STATUS_OK`
  * `ProfileSearchResponse.totalRecordCount == 5`
  * `ProfileSearchResponse.maxResponseRecordCount == 2`
  * `ProfileSearchResponse.profiles.Count == 2`


Node sends *Response*:

  * `Message.id == 27`
  * `Response.status == ERROR_INVALID_VALUE`
  * `Response.details == "recordIndex"`


Node sends *Response*:

  * `Message.id == 28`
  * `Response.status == ERROR_INVALID_VALUE`
  * `Response.details == "recordCount"`


Node sends *Response*:

  * `Message.id == 29`
  * `Response.status == ERROR_INVALID_VALUE`
  * `Response.details == "recordCount"`


Node sends *ProfileSearchPartResponse*:

  * `Message.id == 30`
  * `Response.status == STATUS_OK`
  * `ProfileSearchPartResponse.recordIndex == 0`
  * `ProfileSearchPartResponse.recordCount == 5`
  * `ProfileSearchPartResponse.profiles.Count == 5`
  * `$SetAll := ProfileSearchPartResponse.profiles ==
    (
      {isHosted == true, isOnline == false; type, name, latitude, longitude, extraData match $profileInfo2; image != empty},
      {isHosted == true, isOnline == false; type, name, latitude, longitude, extraData match $profileInfo3; image == empty},
      {isHosted == true, isOnline == false; type, name, latitude, longitude, extraData match $profileInfo5; image == empty},
      {isHosted == true, isOnline == false; type, name, latitude, longitude, extraData match $profileInfo6; image != empty},
      {isHosted == true, isOnline == false; type, name, latitude, longitude, extraData match $profileInfo7; image == empty},
    )`






#### HN06002 - Profile Search - Empty Database

##### Prerequisites/Inputs

###### Prerequisites:
  * Node's database is empty.

###### Inputs:
  * Node's IP address
  * Node's primary port


##### Description 

The test performs a search query when the node has empty database.


###### Step 1:

The test creates a primary identity which it uses for getting list of ports and then it establishes 
a new TLS connection to the node's clNonCustomer port and sends *StartConversationRequest*:

  * `Message.id := 1`
  * `StartConversationRequest.supportedVersions := [[1,0,0]]`
  * `StartConversationRequest.publicKey` set to the test identity's 32 byte long public key
  * `StartConversationRequest.clientChallenge` set to 32 byte random challenge; `$ClientChallenge := StartConversationRequest.clientChallenge`
 
and reads the response. 

Then it sends *ProfileSearchRequest*:

  * `Message.id := 2`
  * `ProfileSearchRequest.includeHostedOnly := false`
  * `ProfileSearchRequest.includeThumbnailImages := true`
  * `ProfileSearchRequest.maxResponseRecordCount := 100`
  * `ProfileSearchRequest.maxTotalRecordCount := 1000`
  * `ProfileSearchRequest.type := ""`
  * `ProfileSearchRequest.name := ""`
  * `ProfileSearchRequest.latitude := NO_LOCATION`
  * `ProfileSearchRequest.longitude := NO_LOCATION`
  * `ProfileSearchRequest.radius := 0`
  * `ProfileSearchRequest.extraData := ""`

and reads the response.


  
##### Acceptance Criteria


###### Step 1:

The test successfully obtains list of ports on which the node provides its services. 

Node replies with *StartConversationResponse*:
  
  * `Message.id == 1`
  * `Response.status == STATUS_OK`
  * `ConversationResponse.signature` is a valid signature of $ClientChallenge
  * `StartConversationResponse.clientChallenge == $ClientChallenge`


Node sends *ProfileSearchResponse*:

  * `Message.id == 1`
  * `Response.status == STATUS_OK`
  * `ProfileSearchResponse.totalRecordCount == 0`
  * `ProfileSearchResponse.maxResponseRecordCount == 100`
  * `ProfileSearchResponse.profiles.Count == 0`








#### HN06003 - Profile Search - Mass Location Search

##### Prerequisites/Inputs

###### Prerequisites:
  * Node's database is empty.

###### Inputs:
  * Node's IP address
  * Node's primary port


##### Description 

The test creates a large number of identities, for which it establishes home node agreements with the node. 
Then it performs a number of search queries with a focus on GPS location of the created identities and verifies the results. 


###### Step 1:

The test creates a primary identity which it uses for getting list of ports and then that it will use for sending search queries. 

The test generates positive integers R1, R2, and R3:

  * `20,000 < R2 < 150,000`
  * `5,000 < R1 < 0.8 * R2`
  * `1.50 * R2 < R3 < 500,000`

The test generates 20 GPS locations, first 15 locations are generated as follows:

  * Location 1 is within R2 range of (0.0, 0.0),
  * location 2 is within R2 range of (89.9, 0.0),
  * location 3 is within R2 range of (-89.9, 0.0),
  * location 4 is within R2 range of (40.0, 0.0),
  * location 5 is within R2 range of (0.0, 179.9),
  * location 6 is within R2 range of (89.9, 179.9),
  * location 7 is within R2 range of (-89.9, 179.9),
  * location 8 is within R2 range of (40.0, 179.9),
  * location 9 is within R2 range of (0.0, -179.9),
  * location 10 is within R2 range of (89.9, -179.9),
  * location 11 is within R2 range of (-89.9, -179.9),
  * location 12 is within R2 range of (40.0, -179.9),
  * location 13 is within R2 range of (0.0, 50.0),
  * location 14 is within R2 range of (89.9, 50.0),
  * location 15 is within R2 range of (-89.9, 50.0).

the remaining 5 locations are random GPS locations.

For each of 20 locations, the test generates, establishes home nodes agreements, and initializes profiles of 10 identities 
that are all located randomly within R1 range of the location, 10 identities within R2 range and 10 identities within R3 range.


###### Step 2:

The test performs search queries using *ProfileSearchRequest*. For each of the 20 locations, it searches for profiles 
located within R1, R2 and R3 and a random number (new for each query) within the range of 1,000,000 to 10,000,000.
The tests verifies that the search results match the expected results.




  
##### Acceptance Criteria


###### Step 1:

The test successfully obtains list of ports on which the node provides its services. 
Then the test successfully establishes home node agreements for its test identities.
Then the test successfully initializes all test profiles. 


###### Step 2:

The node's results for each search query match locally computed expected results. 











#### HN06004 - Profile Search - Invalid Queries

###### Prerequisites:
  * Node's database is empty.

###### Inputs:
  * Node's IP address
  * Node's primary port

##### Description 

The test performs a set of profile search queries with invalid values.

###### Step 1:

The test creates obtains list of service ports and then the test establishes a new TLS connection to the node's clNonCustomer port and establishes a conversation.

Then it sends *ProfileSearchRequest*:

  * `Message.id := 2`
  * `ProfileSearchRequest.includeHostedOnly := false`
  * `ProfileSearchRequest.includeThumbnailImages := true`
  * `ProfileSearchRequest.maxResponseRecordCount := 0`
  * `ProfileSearchRequest.maxTotalRecordCount := 1000`
  * `ProfileSearchRequest.type := ""`
  * `ProfileSearchRequest.name := ""`
  * `ProfileSearchRequest.latitude := NO_LOCATION`
  * `ProfileSearchRequest.longitude := NO_LOCATION`
  * `ProfileSearchRequest.radius := 0`
  * `ProfileSearchRequest.extraData := ""`

and reads the response.

Then it sends *ProfileSearchRequest*:

  * `Message.id := 3`
  * `ProfileSearchRequest.includeHostedOnly := false`
  * `ProfileSearchRequest.includeThumbnailImages := true`
  * `ProfileSearchRequest.maxResponseRecordCount := 200`
  * `ProfileSearchRequest.maxTotalRecordCount := 1000`
  * `ProfileSearchRequest.type := ""`
  * `ProfileSearchRequest.name := ""`
  * `ProfileSearchRequest.latitude := NO_LOCATION`
  * `ProfileSearchRequest.longitude := NO_LOCATION`
  * `ProfileSearchRequest.radius := 0`
  * `ProfileSearchRequest.extraData := ""`

and reads the response.

Then it sends *ProfileSearchRequest*:

  * `Message.id := 4`
  * `ProfileSearchRequest.includeHostedOnly := false`
  * `ProfileSearchRequest.includeThumbnailImages := false`
  * `ProfileSearchRequest.maxResponseRecordCount := 1200`
  * `ProfileSearchRequest.maxTotalRecordCount := 2000`
  * `ProfileSearchRequest.type := ""`
  * `ProfileSearchRequest.name := ""`
  * `ProfileSearchRequest.latitude := NO_LOCATION`
  * `ProfileSearchRequest.longitude := NO_LOCATION`
  * `ProfileSearchRequest.radius := 0`
  * `ProfileSearchRequest.extraData := ""`

and reads the response.

Then it sends *ProfileSearchRequest*:

  * `Message.id := 5`
  * `ProfileSearchRequest.includeHostedOnly := false`
  * `ProfileSearchRequest.includeThumbnailImages := true`
  * `ProfileSearchRequest.maxResponseRecordCount := 50`
  * `ProfileSearchRequest.maxTotalRecordCount := 25`
  * `ProfileSearchRequest.type := ""`
  * `ProfileSearchRequest.name := ""`
  * `ProfileSearchRequest.latitude := NO_LOCATION`
  * `ProfileSearchRequest.longitude := NO_LOCATION`
  * `ProfileSearchRequest.radius := 0`
  * `ProfileSearchRequest.extraData := ""`

and reads the response.

Then it sends *ProfileSearchRequest*:

  * `Message.id := 6`
  * `ProfileSearchRequest.includeHostedOnly := false`
  * `ProfileSearchRequest.includeThumbnailImages := true`
  * `ProfileSearchRequest.maxResponseRecordCount := 50`
  * `ProfileSearchRequest.maxTotalRecordCount := 1001`
  * `ProfileSearchRequest.type := ""`
  * `ProfileSearchRequest.name := ""`
  * `ProfileSearchRequest.latitude := NO_LOCATION`
  * `ProfileSearchRequest.longitude := NO_LOCATION`
  * `ProfileSearchRequest.radius := 0`
  * `ProfileSearchRequest.extraData := ""`

and reads the response.

Then it sends *ProfileSearchRequest*:

  * `Message.id := 7`
  * `ProfileSearchRequest.includeHostedOnly := false`
  * `ProfileSearchRequest.includeThumbnailImages := false`
  * `ProfileSearchRequest.maxResponseRecordCount := 50`
  * `ProfileSearchRequest.maxTotalRecordCount := 10010`
  * `ProfileSearchRequest.type := ""`
  * `ProfileSearchRequest.name := ""`
  * `ProfileSearchRequest.latitude := NO_LOCATION`
  * `ProfileSearchRequest.longitude := NO_LOCATION`
  * `ProfileSearchRequest.radius := 0`
  * `ProfileSearchRequest.extraData := ""`

and reads the response.

Then it sends *ProfileSearchRequest*:

  * `Message.id := 8`
  * `ProfileSearchRequest.includeHostedOnly := false`
  * `ProfileSearchRequest.includeThumbnailImages := true`
  * `ProfileSearchRequest.maxResponseRecordCount := 100`
  * `ProfileSearchRequest.maxTotalRecordCount := 1000`
  * `ProfileSearchRequest.type` is set to string containing 70x 'a'
  * `ProfileSearchRequest.name := ""`
  * `ProfileSearchRequest.latitude := NO_LOCATION`
  * `ProfileSearchRequest.longitude := NO_LOCATION`
  * `ProfileSearchRequest.radius := 0`
  * `ProfileSearchRequest.extraData := ""`

and reads the response.

Then it sends *ProfileSearchRequest*:

  * `Message.id := 9`
  * `ProfileSearchRequest.includeHostedOnly := false`
  * `ProfileSearchRequest.includeThumbnailImages := true`
  * `ProfileSearchRequest.maxResponseRecordCount := 100`
  * `ProfileSearchRequest.maxTotalRecordCount := 1000`
  * `ProfileSearchRequest.type` is set to string containing 50x 'ɐ' (UTF8 code 0xc990), which consumes 2 bytes per character
  * `ProfileSearchRequest.name := ""`
  * `ProfileSearchRequest.latitude := NO_LOCATION`
  * `ProfileSearchRequest.longitude := NO_LOCATION`
  * `ProfileSearchRequest.radius := 0`
  * `ProfileSearchRequest.extraData := ""`

and reads the response.


Then it sends *ProfileSearchRequest*:

  * `Message.id := 10`
  * `ProfileSearchRequest.includeHostedOnly := false`
  * `ProfileSearchRequest.includeThumbnailImages := true`
  * `ProfileSearchRequest.maxResponseRecordCount := 100`
  * `ProfileSearchRequest.maxTotalRecordCount := 1000`
  * `ProfileSearchRequest.type := ""`
  * `ProfileSearchRequest.name` is set to string containing 70x 'a'
  * `ProfileSearchRequest.latitude := NO_LOCATION`
  * `ProfileSearchRequest.longitude := NO_LOCATION`
  * `ProfileSearchRequest.radius := 0`
  * `ProfileSearchRequest.extraData := ""`

and reads the response.

Then it sends *ProfileSearchRequest*:

  * `Message.id := 11`
  * `ProfileSearchRequest.includeHostedOnly := false`
  * `ProfileSearchRequest.includeThumbnailImages := true`
  * `ProfileSearchRequest.maxResponseRecordCount := 100`
  * `ProfileSearchRequest.maxTotalRecordCount := 1000`
  * `ProfileSearchRequest.type := ""`
  * `ProfileSearchRequest.name` is set to string containing 50x 'ɐ' (UTF8 code 0xc990), which consumes 2 bytes per character
  * `ProfileSearchRequest.latitude := NO_LOCATION`
  * `ProfileSearchRequest.longitude := NO_LOCATION`
  * `ProfileSearchRequest.radius := 0`
  * `ProfileSearchRequest.extraData := ""`

and reads the response.

Then it sends *ProfileSearchRequest*:

  * `Message.id := 12`
  * `ProfileSearchRequest.includeHostedOnly := false`
  * `ProfileSearchRequest.includeThumbnailImages := true`
  * `ProfileSearchRequest.maxResponseRecordCount := 100`
  * `ProfileSearchRequest.maxTotalRecordCount := 1000`
  * `ProfileSearchRequest.type := ""`
  * `ProfileSearchRequest.name := ""`
  * `ProfileSearchRequest.latitude := -90,000,001`
  * `ProfileSearchRequest.longitude := 1`
  * `ProfileSearchRequest.radius := 1`
  * `ProfileSearchRequest.extraData := ""`

and reads the response.

Then it sends *ProfileSearchRequest*:

  * `Message.id := 13`
  * `ProfileSearchRequest.includeHostedOnly := false`
  * `ProfileSearchRequest.includeThumbnailImages := true`
  * `ProfileSearchRequest.maxResponseRecordCount := 100`
  * `ProfileSearchRequest.maxTotalRecordCount := 1000`
  * `ProfileSearchRequest.type := ""`
  * `ProfileSearchRequest.name := ""`
  * `ProfileSearchRequest.latitude := 90,000,001`
  * `ProfileSearchRequest.longitude := 1`
  * `ProfileSearchRequest.radius := 1`
  * `ProfileSearchRequest.extraData := ""`

and reads the response.

Then it sends *ProfileSearchRequest*:

  * `Message.id := 14`
  * `ProfileSearchRequest.includeHostedOnly := false`
  * `ProfileSearchRequest.includeThumbnailImages := true`
  * `ProfileSearchRequest.maxResponseRecordCount := 100`
  * `ProfileSearchRequest.maxTotalRecordCount := 1000`
  * `ProfileSearchRequest.type := ""`
  * `ProfileSearchRequest.name := ""`
  * `ProfileSearchRequest.latitude := 1`
  * `ProfileSearchRequest.longitude := -180,000,000`
  * `ProfileSearchRequest.radius := 1`
  * `ProfileSearchRequest.extraData := ""`

and reads the response.

Then it sends *ProfileSearchRequest*:

  * `Message.id := 15`
  * `ProfileSearchRequest.includeHostedOnly := false`
  * `ProfileSearchRequest.includeThumbnailImages := true`
  * `ProfileSearchRequest.maxResponseRecordCount := 100`
  * `ProfileSearchRequest.maxTotalRecordCount := 1000`
  * `ProfileSearchRequest.type := ""`
  * `ProfileSearchRequest.name := ""`
  * `ProfileSearchRequest.latitude := 1`
  * `ProfileSearchRequest.longitude := 180,000,001`
  * `ProfileSearchRequest.radius := 1`
  * `ProfileSearchRequest.extraData := ""`

and reads the response.

Then it sends *ProfileSearchRequest*:

  * `Message.id := 16`
  * `ProfileSearchRequest.includeHostedOnly := false`
  * `ProfileSearchRequest.includeThumbnailImages := true`
  * `ProfileSearchRequest.maxResponseRecordCount := 100`
  * `ProfileSearchRequest.maxTotalRecordCount := 1000`
  * `ProfileSearchRequest.type := ""`
  * `ProfileSearchRequest.name := ""`
  * `ProfileSearchRequest.latitude := 1`
  * `ProfileSearchRequest.longitude := 1`
  * `ProfileSearchRequest.radius := 0`
  * `ProfileSearchRequest.extraData := ""`

and reads the response.

Then it sends *ProfileSearchRequest*:

  * `Message.id := 17`
  * `ProfileSearchRequest.includeHostedOnly := false`
  * `ProfileSearchRequest.includeThumbnailImages := true`
  * `ProfileSearchRequest.maxResponseRecordCount := 100`
  * `ProfileSearchRequest.maxTotalRecordCount := 1000`
  * `ProfileSearchRequest.type := ""`
  * `ProfileSearchRequest.name := ""`
  * `ProfileSearchRequest.latitude := NO_LOCATION`
  * `ProfileSearchRequest.longitude := NO_LOCATION`
  * `ProfileSearchRequest.radius := 0`
  * `ProfileSearchRequest.extraData` is set to string containing 300x 'a'

and reads the response.

Then it sends *ProfileSearchRequest*:

  * `Message.id := 18`
  * `ProfileSearchRequest.includeHostedOnly := false`
  * `ProfileSearchRequest.includeThumbnailImages := true`
  * `ProfileSearchRequest.maxResponseRecordCount := 100`
  * `ProfileSearchRequest.maxTotalRecordCount := 1000`
  * `ProfileSearchRequest.type := ""`
  * `ProfileSearchRequest.name := ""`
  * `ProfileSearchRequest.latitude := NO_LOCATION`
  * `ProfileSearchRequest.longitude := NO_LOCATION`
  * `ProfileSearchRequest.radius := 0`
  * `ProfileSearchRequest.extraData` is set to string containing 150x 'ɐ' (UTF8 code 0xc990), which consumes 2 bytes per character

and reads the response.

Then it sends *ProfileSearchRequest*:

  * `Message.id := 19`
  * `ProfileSearchRequest.includeHostedOnly := false`
  * `ProfileSearchRequest.includeThumbnailImages := true`
  * `ProfileSearchRequest.maxResponseRecordCount := 100`
  * `ProfileSearchRequest.maxTotalRecordCount := 1000`
  * `ProfileSearchRequest.type := ""`
  * `ProfileSearchRequest.name := ""`
  * `ProfileSearchRequest.latitude := NO_LOCATION`
  * `ProfileSearchRequest.longitude := NO_LOCATION`
  * `ProfileSearchRequest.radius := 0`
  * `ProfileSearchRequest.extraData := "(^|;)key=([^=]+;)?va(?'alpha')lue($|,|;)"`

and reads the response.

Then it sends *ProfileSearchRequest*:

  * `Message.id := 20`
  * `ProfileSearchRequest.includeHostedOnly := false`
  * `ProfileSearchRequest.includeThumbnailImages := true`
  * `ProfileSearchRequest.maxResponseRecordCount := 100`
  * `ProfileSearchRequest.maxTotalRecordCount := 1000`
  * `ProfileSearchRequest.type := ""`
  * `ProfileSearchRequest.name := ""`
  * `ProfileSearchRequest.latitude := NO_LOCATION`
  * `ProfileSearchRequest.longitude := NO_LOCATION`
  * `ProfileSearchRequest.radius := 0`
  * `ProfileSearchRequest.extraData := "iuawhefiuhawef\aaerwergj"`

and reads the response.

Then it sends *ProfileSearchRequest*:

  * `Message.id := 21`
  * `ProfileSearchRequest.includeHostedOnly := false`
  * `ProfileSearchRequest.includeThumbnailImages := true`
  * `ProfileSearchRequest.maxResponseRecordCount := 100`
  * `ProfileSearchRequest.maxTotalRecordCount := 1000`
  * `ProfileSearchRequest.type := ""`
  * `ProfileSearchRequest.name := ""`
  * `ProfileSearchRequest.latitude := NO_LOCATION`
  * `ProfileSearchRequest.longitude := NO_LOCATION`
  * `ProfileSearchRequest.radius := 0`
  * `ProfileSearchRequest.extraData := "aerghearg\beraarg"`

and reads the response.

Then it sends *ProfileSearchRequest*:

  * `Message.id := 22`
  * `ProfileSearchRequest.includeHostedOnly := false`
  * `ProfileSearchRequest.includeThumbnailImages := true`
  * `ProfileSearchRequest.maxResponseRecordCount := 100`
  * `ProfileSearchRequest.maxTotalRecordCount := 1000`
  * `ProfileSearchRequest.type := ""`
  * `ProfileSearchRequest.name := ""`
  * `ProfileSearchRequest.latitude := NO_LOCATION`
  * `ProfileSearchRequest.longitude := NO_LOCATION`
  * `ProfileSearchRequest.radius := 0`
  * `ProfileSearchRequest.extraData := "afewafawefwaef\"`

and reads the response.

Then it sends *ProfileSearchRequest*:

  * `Message.id := 23`
  * `ProfileSearchRequest.includeHostedOnly := false`
  * `ProfileSearchRequest.includeThumbnailImages := true`
  * `ProfileSearchRequest.maxResponseRecordCount := 100`
  * `ProfileSearchRequest.maxTotalRecordCount := 1000`
  * `ProfileSearchRequest.type := ""`
  * `ProfileSearchRequest.name := ""`
  * `ProfileSearchRequest.latitude := NO_LOCATION`
  * `ProfileSearchRequest.longitude := NO_LOCATION`
  * `ProfileSearchRequest.radius := 0`
  * `ProfileSearchRequest.extraData := "(^|;)key=([^=]+;)?(?<double>A)B<double>($|,|;)"`

and reads the response.

Then it sends *ProfileSearchRequest*:

  * `Message.id := 24`
  * `ProfileSearchRequest.includeHostedOnly := false`
  * `ProfileSearchRequest.includeThumbnailImages := true`
  * `ProfileSearchRequest.maxResponseRecordCount := 100`
  * `ProfileSearchRequest.maxTotalRecordCount := 1000`
  * `ProfileSearchRequest.type := ""`
  * `ProfileSearchRequest.name := ""`
  * `ProfileSearchRequest.latitude := NO_LOCATION`
  * `ProfileSearchRequest.longitude := NO_LOCATION`
  * `ProfileSearchRequest.radius := 0`
  * `ProfileSearchRequest.extraData := "(^|;)key=rai??n($|,|;)"`

and reads the response.


###### Step 2:

Then it sends *ProfileSearchPartRequest*:

  * `Message.id := 25`
  * `ProfileSearchPartRequest.recordIndex := 10`
  * `ProfileSearchPartRequest.recordCount := 20`



##### Acceptance Criteria

###### Step 1:

The test successfully obtains list of ports on which the node provides its services and establishes a conversation.

Node replies with *Response*:

  * `Message.id == 2`
  * `Response.status == ERROR_INVALID_VALUE`
  * `Response.details == "maxResponseRecordCount"`

Node replies with *Response*:

  * `Message.id == 3`
  * `Response.status == ERROR_INVALID_VALUE`
  * `Response.details == "maxResponseRecordCount"`

Node replies with *Response*:

  * `Message.id == 4`
  * `Response.status == ERROR_INVALID_VALUE`
  * `Response.details == "maxResponseRecordCount"`

Node replies with *Response*:

  * `Message.id == 5`
  * `Response.status == ERROR_INVALID_VALUE`
  * `Response.details == "maxResponseRecordCount"`

Node replies with *Response*:

  * `Message.id == 6`
  * `Response.status == ERROR_INVALID_VALUE`
  * `Response.details == "maxTotalRecordCount"`

Node replies with *Response*:

  * `Message.id == 7`
  * `Response.status == ERROR_INVALID_VALUE`
  * `Response.details == "maxTotalRecordCount"`

Node replies with *Response*:

  * `Message.id == 8`
  * `Response.status == ERROR_INVALID_VALUE`
  * `Response.details == "type"`

Node replies with *Response*:

  * `Message.id == 9`
  * `Response.status == ERROR_INVALID_VALUE`
  * `Response.details == "type"`

Node replies with *Response*:

  * `Message.id == 10`
  * `Response.status == ERROR_INVALID_VALUE`
  * `Response.details == "name"`

Node replies with *Response*:

  * `Message.id == 11`
  * `Response.status == ERROR_INVALID_VALUE`
  * `Response.details == "name"`

Node replies with *Response*:

  * `Message.id == 12`
  * `Response.status == ERROR_INVALID_VALUE`
  * `Response.details == "latitude"`

Node replies with *Response*:

  * `Message.id == 13`
  * `Response.status == ERROR_INVALID_VALUE`
  * `Response.details == "latitude"`

Node replies with *Response*:

  * `Message.id == 14`
  * `Response.status == ERROR_INVALID_VALUE`
  * `Response.details == "longitude"`

Node replies with *Response*:

  * `Message.id == 15`
  * `Response.status == ERROR_INVALID_VALUE`
  * `Response.details == "longitude"`

Node replies with *Response*:

  * `Message.id == 16`
  * `Response.status == ERROR_INVALID_VALUE`
  * `Response.details == "radius"`

Node replies with *Response*:

  * `Message.id == 17`
  * `Response.status == ERROR_INVALID_VALUE`
  * `Response.details == "extraData"`

Node replies with *Response*:

  * `Message.id == 18`
  * `Response.status == ERROR_INVALID_VALUE`
  * `Response.details == "extraData"`

Node replies with *Response*:

  * `Message.id == 19`
  * `Response.status == ERROR_INVALID_VALUE`
  * `Response.details == "extraData"`

Node replies with *Response*:

  * `Message.id == 20`
  * `Response.status == ERROR_INVALID_VALUE`
  * `Response.details == "extraData"`

Node replies with *Response*:

  * `Message.id == 21`
  * `Response.status == ERROR_INVALID_VALUE`
  * `Response.details == "extraData"`

Node replies with *Response*:

  * `Message.id == 22`
  * `Response.status == ERROR_INVALID_VALUE`
  * `Response.details == "extraData"`

Node replies with *Response*:

  * `Message.id == 23`
  * `Response.status == ERROR_INVALID_VALUE`
  * `Response.details == "extraData"`

Node replies with *Response*:

  * `Message.id == 24`
  * `Response.status == ERROR_INVALID_VALUE`
  * `Response.details == "extraData"`


###### Step 2:

Then it sends *ProfileSearchPartRequest*:

  * `Message.id := 25`
  * `Response.status == ERROR_NOT_AVAILABLE`










### HN07xxx - Related Identities Related Functionality Tests

#### HN07001 - Add/Remove/Get Related Identity

##### Prerequisites/Inputs

###### Prerequisites:
  * Node's database is empty.

###### Inputs:
  * Node's IP address
  * Node's primary port


##### Description 

The test adds, removes and queries related identities to its profile.


###### Step 1:

The tests obtains a list of service ports from the node's primary port.
The test creates a primary identity and a secondary, for which it establishes home node agreements and checks them in.
Then it creates 5 other identities (Identity1 to Identity5), which it uses for issuing relationship cards.


###### Step 2:

Using the primary checked-in identity, the test sends *AddRelatedIdentityRequest* with what we call $Card1:

  * `Message.id := 3`
  * `AddRelatedIdentityRequest.signedCard.card.type := "Card Type A"`
  * `AddRelatedIdentityRequest.signedCard.card.validFrom := 1479220556000`
  * `AddRelatedIdentityRequest.signedCard.card.validTo := 2479220556000`
  * `AddRelatedIdentityRequest.signedCard.card.issuerPublicKey` is a public key of Identity1
  * `AddRelatedIdentityRequest.signedCard.card.recipientPublicKey` is a public key of test's primary identity
  * `AddRelatedIdentityRequest.signedCard.card.cardId` is a valid hash of the relationship card as defined in the protocol
  * `AddRelatedIdentityRequest.signedCard.issuerSignature` is a valid signature of `AddRelatedIdentityRequest.signedCard.card.cardId` by Identity1
  * `AddRelatedIdentityRequest.cardApplication.cardId := AddRelatedIdentityRequest.signedCard.card.cardId`
  * `AddRelatedIdentityRequest.cardApplication.applicationId := [1]`
  * `ConversationResponse.signature` is a valid signature of `AddRelatedIdentityRequest.cardApplication`

and reads the response. Then it sends *AddRelatedIdentityRequest* ($Card2):

  * `Message.id := 4`
  * `AddRelatedIdentityRequest.signedCard.card.type := "Card Type A"`
  * `AddRelatedIdentityRequest.signedCard.card.validFrom := 1479220556000`
  * `AddRelatedIdentityRequest.signedCard.card.validTo := 1479220557000`
  * `AddRelatedIdentityRequest.signedCard.card.issuerPublicKey` is a public key of Identity1
  * `AddRelatedIdentityRequest.signedCard.card.recipientPublicKey` is a public key of test's primary identity
  * `AddRelatedIdentityRequest.signedCard.card.cardId` is a valid hash of the relationship card as defined in the protocol
  * `AddRelatedIdentityRequest.signedCard.issuerSignature` is a valid signature of `AddRelatedIdentityRequest.signedCard.card.cardId` by Identity1
  * `AddRelatedIdentityRequest.cardApplication.cardId := AddRelatedIdentityRequest.signedCard.card.cardId`
  * `AddRelatedIdentityRequest.cardApplication.applicationId := [2]`
  * `ConversationResponse.signature` is a valid signature of `AddRelatedIdentityRequest.cardApplication`

and reads the response. Then it sends *AddRelatedIdentityRequest* ($Card3):

  * `Message.id := 5`
  * `AddRelatedIdentityRequest.signedCard.card.type := "Card Type A"`
  * `AddRelatedIdentityRequest.signedCard.card.validFrom := 1479220556000`
  * `AddRelatedIdentityRequest.signedCard.card.validTo := 2479220556000`
  * `AddRelatedIdentityRequest.signedCard.card.issuerPublicKey` is a public key of Identity2
  * `AddRelatedIdentityRequest.signedCard.card.recipientPublicKey` is a public key of test's primary identity
  * `AddRelatedIdentityRequest.signedCard.card.cardId` is a valid hash of the relationship card as defined in the protocol
  * `AddRelatedIdentityRequest.signedCard.issuerSignature` is a valid signature of `AddRelatedIdentityRequest.signedCard.card.cardId` by Identity2
  * `AddRelatedIdentityRequest.cardApplication.cardId := AddRelatedIdentityRequest.signedCard.card.cardId`
  * `AddRelatedIdentityRequest.cardApplication.applicationId := [3]`
  * `ConversationResponse.signature` is a valid signature of `AddRelatedIdentityRequest.cardApplication`

and reads the response. Then it sends *AddRelatedIdentityRequest* ($Card4):

  * `Message.id := 6`
  * `AddRelatedIdentityRequest.signedCard.card.type := "Card Type A"`
  * `AddRelatedIdentityRequest.signedCard.card.validFrom := 2479220555000`
  * `AddRelatedIdentityRequest.signedCard.card.validTo := 2479220556000`
  * `AddRelatedIdentityRequest.signedCard.card.issuerPublicKey` is a public key of Identity2
  * `AddRelatedIdentityRequest.signedCard.card.recipientPublicKey` is a public key of test's primary identity
  * `AddRelatedIdentityRequest.signedCard.card.cardId` is a valid hash of the relationship card as defined in the protocol
  * `AddRelatedIdentityRequest.signedCard.issuerSignature` is a valid signature of `AddRelatedIdentityRequest.signedCard.card.cardId` by Identity2
  * `AddRelatedIdentityRequest.cardApplication.cardId := AddRelatedIdentityRequest.signedCard.card.cardId`
  * `AddRelatedIdentityRequest.cardApplication.applicationId := [4]`
  * `ConversationResponse.signature` is a valid signature of `AddRelatedIdentityRequest.cardApplication`

and reads the response. Then it sends *AddRelatedIdentityRequest* ($Card5):

  * `Message.id := 7`
  * `AddRelatedIdentityRequest.signedCard.card.type := "Card Type B"`
  * `AddRelatedIdentityRequest.signedCard.card.validFrom := 1479220556000`
  * `AddRelatedIdentityRequest.signedCard.card.validTo := 2479220556000`
  * `AddRelatedIdentityRequest.signedCard.card.issuerPublicKey` is a public key of Identity3
  * `AddRelatedIdentityRequest.signedCard.card.recipientPublicKey` is a public key of test's primary identity
  * `AddRelatedIdentityRequest.signedCard.card.cardId` is a valid hash of the relationship card as defined in the protocol
  * `AddRelatedIdentityRequest.signedCard.issuerSignature` is a valid signature of `AddRelatedIdentityRequest.signedCard.card.cardId` by Identity3
  * `AddRelatedIdentityRequest.cardApplication.cardId := AddRelatedIdentityRequest.signedCard.card.cardId`
  * `AddRelatedIdentityRequest.cardApplication.applicationId := [5]`
  * `ConversationResponse.signature` is a valid signature of `AddRelatedIdentityRequest.cardApplication`

and reads the response. Then it sends *AddRelatedIdentityRequest* ($Card6):

  * `Message.id := 8`
  * `AddRelatedIdentityRequest.signedCard.card.type := "Card Type B"`
  * `AddRelatedIdentityRequest.signedCard.card.validFrom := 1479220556000`
  * `AddRelatedIdentityRequest.signedCard.card.validTo := 2479220556000`
  * `AddRelatedIdentityRequest.signedCard.card.issuerPublicKey` is a public key of Identity4
  * `AddRelatedIdentityRequest.signedCard.card.recipientPublicKey` is a public key of test's primary identity
  * `AddRelatedIdentityRequest.signedCard.card.cardId` is a valid hash of the relationship card as defined in the protocol
  * `AddRelatedIdentityRequest.signedCard.issuerSignature` is a valid signature of `AddRelatedIdentityRequest.signedCard.card.cardId` by Identity4
  * `AddRelatedIdentityRequest.cardApplication.cardId := AddRelatedIdentityRequest.signedCard.card.cardId`
  * `AddRelatedIdentityRequest.cardApplication.applicationId := [6]`
  * `ConversationResponse.signature` is a valid signature of `AddRelatedIdentityRequest.cardApplication`

and reads the response. Then it sends *AddRelatedIdentityRequest* ($Card7):

  * `Message.id := 9`
  * `AddRelatedIdentityRequest.signedCard.card.type := "Card Type C"`
  * `AddRelatedIdentityRequest.signedCard.card.validFrom := 1479220556000`
  * `AddRelatedIdentityRequest.signedCard.card.validTo := 2479220556000`
  * `AddRelatedIdentityRequest.signedCard.card.issuerPublicKey` is a public key of Identity4
  * `AddRelatedIdentityRequest.signedCard.card.recipientPublicKey` is a public key of test's primary identity
  * `AddRelatedIdentityRequest.signedCard.card.cardId` is a valid hash of the relationship card as defined in the protocol
  * `AddRelatedIdentityRequest.signedCard.issuerSignature` is a valid signature of `AddRelatedIdentityRequest.signedCard.card.cardId` by Identity4
  * `AddRelatedIdentityRequest.cardApplication.cardId := AddRelatedIdentityRequest.signedCard.card.cardId`
  * `AddRelatedIdentityRequest.cardApplication.applicationId := [7]`
  * `ConversationResponse.signature` is a valid signature of `AddRelatedIdentityRequest.cardApplication`

and reads the response. Then it sends *AddRelatedIdentityRequest* ($Card8):

  * `Message.id := 10`
  * `AddRelatedIdentityRequest.signedCard.card.type := "Card Type C"`
  * `AddRelatedIdentityRequest.signedCard.card.validFrom := 1479220556000`
  * `AddRelatedIdentityRequest.signedCard.card.validTo := 2479220556000`
  * `AddRelatedIdentityRequest.signedCard.card.issuerPublicKey` is a public key of Identity4
  * `AddRelatedIdentityRequest.signedCard.card.recipientPublicKey` is a public key of test's primary identity
  * `AddRelatedIdentityRequest.signedCard.card.cardId` is a valid hash of the relationship card as defined in the protocol
  * `AddRelatedIdentityRequest.signedCard.issuerSignature` is a valid signature of `AddRelatedIdentityRequest.signedCard.card.cardId` by Identity4
  * `AddRelatedIdentityRequest.cardApplication.cardId := AddRelatedIdentityRequest.signedCard.card.cardId`
  * `AddRelatedIdentityRequest.cardApplication.applicationId := [8]`
  * `ConversationResponse.signature` is a valid signature of `AddRelatedIdentityRequest.cardApplication`

and reads the response. Then it sends *AddRelatedIdentityRequest* ($Card9):

  * `Message.id := 11`
  * `AddRelatedIdentityRequest.signedCard.card.type := "Other"`
  * `AddRelatedIdentityRequest.signedCard.card.validFrom := 1479220556000`
  * `AddRelatedIdentityRequest.signedCard.card.validTo := 2479220556000`
  * `AddRelatedIdentityRequest.signedCard.card.issuerPublicKey` is a public key of Identity5
  * `AddRelatedIdentityRequest.signedCard.card.recipientPublicKey` is a public key of test's primary identity
  * `AddRelatedIdentityRequest.signedCard.card.cardId` is a valid hash of the relationship card as defined in the protocol
  * `AddRelatedIdentityRequest.signedCard.issuerSignature` is a valid signature of `AddRelatedIdentityRequest.signedCard.card.cardId` by Identity5
  * `AddRelatedIdentityRequest.cardApplication.cardId := AddRelatedIdentityRequest.signedCard.card.cardId`
  * `AddRelatedIdentityRequest.cardApplication.applicationId := [9]`
  * `ConversationResponse.signature` is a valid signature of `AddRelatedIdentityRequest.cardApplication`

and reads the response. 

###### Step 3:

Using the secondary checked-in identity, the test sends *AddRelatedIdentityRequest* ($Card10):

  * `Message.id := 3`
  * `AddRelatedIdentityRequest.signedCard.card.type := "Card Type A"`
  * `AddRelatedIdentityRequest.signedCard.card.validFrom := 1479220556000`
  * `AddRelatedIdentityRequest.signedCard.card.validTo := 2479220556000`
  * `AddRelatedIdentityRequest.signedCard.card.issuerPublicKey` is a public key of Identity1
  * `AddRelatedIdentityRequest.signedCard.card.recipientPublicKey` is a public key of test's secondary identity
  * `AddRelatedIdentityRequest.signedCard.card.cardId` is a valid hash of the relationship card as defined in the protocol
  * `AddRelatedIdentityRequest.signedCard.issuerSignature` is a valid signature of `AddRelatedIdentityRequest.signedCard.card.cardId` by Identity1
  * `AddRelatedIdentityRequest.cardApplication.cardId := AddRelatedIdentityRequest.signedCard.card.cardId`
  * `AddRelatedIdentityRequest.cardApplication.applicationId := [1]`
  * `ConversationResponse.signature` is a valid signature of `AddRelatedIdentityRequest.cardApplication`

and reads the response.



###### Step 4:

Using the secondary identity, it sends *GetIdentityRelationshipsInformationRequest*:

  * `Message.id := 4`
  * `SingleRequest.version := [1,0,0]`
  * `GetIdentityRelationshipsInformationRequest.identityNetworkId` is set to the primary test's identity ID
  * `GetIdentityRelationshipsInformationRequest.includeInvalid := true`
  * `GetIdentityRelationshipsInformationRequest.type := ""`
  * `GetIdentityRelationshipsInformationRequest.specificIssuer := false`
  * `GetIdentityRelationshipsInformationRequest.issuerNetworkId` is uninitialized

and reads the response. Then it sends *GetIdentityRelationshipsInformationRequest*:

  * `Message.id := 5`
  * `SingleRequest.version := [1,0,0]`
  * `GetIdentityRelationshipsInformationRequest.identityNetworkId` is set to the primary test's identity ID
  * `GetIdentityRelationshipsInformationRequest.includeInvalid := false`
  * `GetIdentityRelationshipsInformationRequest.type := ""`
  * `GetIdentityRelationshipsInformationRequest.specificIssuer := false`
  * `GetIdentityRelationshipsInformationRequest.issuerNetworkId` is uninitialized

and reads the response. Then it sends *GetIdentityRelationshipsInformationRequest*:

  * `Message.id := 6`
  * `SingleRequest.version := [1,0,0]`
  * `GetIdentityRelationshipsInformationRequest.identityNetworkId` is set to the primary test's identity ID
  * `GetIdentityRelationshipsInformationRequest.includeInvalid := true`
  * `GetIdentityRelationshipsInformationRequest.type := "*"`
  * `GetIdentityRelationshipsInformationRequest.specificIssuer := false`
  * `GetIdentityRelationshipsInformationRequest.issuerNetworkId` is uninitialized

and reads the response. Then it sends *GetIdentityRelationshipsInformationRequest*:

  * `Message.id := 7`
  * `SingleRequest.version := [1,0,0]`
  * `GetIdentityRelationshipsInformationRequest.identityNetworkId` is set to the primary test's identity ID
  * `GetIdentityRelationshipsInformationRequest.includeInvalid := true`
  * `GetIdentityRelationshipsInformationRequest.type := "**"`
  * `GetIdentityRelationshipsInformationRequest.specificIssuer := false`
  * `GetIdentityRelationshipsInformationRequest.issuerNetworkId` is uninitialized

and reads the response. Then it sends *GetIdentityRelationshipsInformationRequest*:

  * `Message.id := 8`
  * `SingleRequest.version := [1,0,0]`
  * `GetIdentityRelationshipsInformationRequest.identityNetworkId` is set to the primary test's identity ID
  * `GetIdentityRelationshipsInformationRequest.includeInvalid := true`
  * `GetIdentityRelationshipsInformationRequest.type := "Card*"`
  * `GetIdentityRelationshipsInformationRequest.specificIssuer := false`
  * `GetIdentityRelationshipsInformationRequest.issuerNetworkId` is uninitialized

and reads the response. Then it sends *GetIdentityRelationshipsInformationRequest*:

  * `Message.id := 9`
  * `SingleRequest.version := [1,0,0]`
  * `GetIdentityRelationshipsInformationRequest.identityNetworkId` is set to the primary test's identity ID
  * `GetIdentityRelationshipsInformationRequest.includeInvalid := true`
  * `GetIdentityRelationshipsInformationRequest.type := "*Type A"`
  * `GetIdentityRelationshipsInformationRequest.specificIssuer := false`
  * `GetIdentityRelationshipsInformationRequest.issuerNetworkId` is uninitialized

and reads the response. Then it sends *GetIdentityRelationshipsInformationRequest*:

  * `Message.id := 10`
  * `SingleRequest.version := [1,0,0]`
  * `GetIdentityRelationshipsInformationRequest.identityNetworkId` is set to the primary test's identity ID
  * `GetIdentityRelationshipsInformationRequest.includeInvalid := true`
  * `GetIdentityRelationshipsInformationRequest.type := "*Type *"`
  * `GetIdentityRelationshipsInformationRequest.specificIssuer := false`
  * `GetIdentityRelationshipsInformationRequest.issuerNetworkId` is uninitialized

and reads the response. Then it sends *GetIdentityRelationshipsInformationRequest*:

  * `Message.id := 11`
  * `SingleRequest.version := [1,0,0]`
  * `GetIdentityRelationshipsInformationRequest.identityNetworkId` is set to the primary test's identity ID
  * `GetIdentityRelationshipsInformationRequest.includeInvalid := true`
  * `GetIdentityRelationshipsInformationRequest.type := ""`
  * `GetIdentityRelationshipsInformationRequest.specificIssuer := true`
  * `GetIdentityRelationshipsInformationRequest.issuerNetworkId` is Identity1 ID

and reads the response. Then it sends *GetIdentityRelationshipsInformationRequest*:

  * `Message.id := 12`
  * `SingleRequest.version := [1,0,0]`
  * `GetIdentityRelationshipsInformationRequest.identityNetworkId` is set to the primary test's identity ID
  * `GetIdentityRelationshipsInformationRequest.includeInvalid := true`
  * `GetIdentityRelationshipsInformationRequest.type := "*C"`
  * `GetIdentityRelationshipsInformationRequest.specificIssuer := true`
  * `GetIdentityRelationshipsInformationRequest.issuerNetworkId` is Identity4 ID

and reads the response.



###### Step 5:


Using the first identity, it sends *RemoveRelatedIdentityRequest*:

  * `Message.id := 12`
  * `RemoveRelatedIdentityRequest.applicationId := [2]`

and reads the response. Then it sends *RemoveRelatedIdentityRequest*:

  * `Message.id := 13`
  * `RemoveRelatedIdentityRequest.applicationId := [4]`

and reads the response. Then it sends *GetIdentityRelationshipsInformationRequest*:

  * `Message.id := 14`
  * `SingleRequest.version := [1,0,0]`
  * `GetIdentityRelationshipsInformationRequest.identityNetworkId` is set to the primary test's identity ID
  * `GetIdentityRelationshipsInformationRequest.includeInvalid := true`
  * `GetIdentityRelationshipsInformationRequest.type := "*Type a*"`
  * `GetIdentityRelationshipsInformationRequest.specificIssuer := false`
  * `GetIdentityRelationshipsInformationRequest.issuerNetworkId` is uninitialized

and reads the response. Then it sends *GetIdentityRelationshipsInformationRequest*:

  * `Message.id := 15`
  * `SingleRequest.version := [1,0,0]`
  * `GetIdentityRelationshipsInformationRequest.identityNetworkId` is set to first 10 bytes of the primary test's identity ID
  * `GetIdentityRelationshipsInformationRequest.includeInvalid := true`
  * `GetIdentityRelationshipsInformationRequest.type := "*Type a*"`
  * `GetIdentityRelationshipsInformationRequest.specificIssuer := false`
  * `GetIdentityRelationshipsInformationRequest.issuerNetworkId` is uninitialized

and reads the response.

  
##### Acceptance Criteria


###### Step 1:

The test successfully obtains list of ports on which the node provides its services. 
Then the test successfully establishes home node agreements for its primary and secondary identities.
Then the test successfully checks-in both identities.


###### Step 2:

Node replies with *AddRelatedIdentityResponse*:

  * `Message.id := 3`
  * `Response.status == STATUS_OK`


Node replies with *AddRelatedIdentityResponse*:

  * `Message.id := 4`
  * `Response.status == STATUS_OK`


Node replies with *AddRelatedIdentityResponse*:

  * `Message.id := 5`
  * `Response.status == STATUS_OK`


Node replies with *AddRelatedIdentityResponse*:

  * `Message.id := 6`
  * `Response.status == STATUS_OK`


Node replies with *AddRelatedIdentityResponse*:

  * `Message.id := 7`
  * `Response.status == STATUS_OK`


Node replies with *AddRelatedIdentityResponse*:

  * `Message.id := 8`
  * `Response.status == STATUS_OK`


Node replies with *AddRelatedIdentityResponse*:

  * `Message.id := 9`
  * `Response.status == STATUS_OK`


Node replies with *AddRelatedIdentityResponse*:

  * `Message.id := 10`
  * `Response.status == STATUS_OK`


Node replies with *AddRelatedIdentityResponse*:

  * `Message.id := 11`
  * `Response.status == STATUS_OK`



###### Step 3:

Node replies with *AddRelatedIdentityResponse*:

  * `Message.id := 3`
  * `Response.status == STATUS_OK`


###### Step 4:

Node replies with *GetIdentityRelationshipsInformationResponse*:

  * `Message.id := 4`
  * `Response.status == STATUS_OK`
  * `SingleResponse.version == [1,0,0]`
  * `GetIdentityRelationshipsInformationResponse.relationships == 
    (
      $Card1, $Card2, $Card3, $Card4, $Card5, $Card6, $Card7, $Card8, $Card9,
    )`

Node replies with *GetIdentityRelationshipsInformationResponse*:

  * `Message.id := 5`
  * `Response.status == STATUS_OK`
  * `SingleResponse.version == [1,0,0]`
  * `GetIdentityRelationshipsInformationResponse.relationships == 
    (
      $Card1, $Card3, $Card5, $Card6, $Card7, $Card8, $Card9,
    )`

Node replies with *GetIdentityRelationshipsInformationResponse*:

  * `Message.id := 6`
  * `Response.status == STATUS_OK`
  * `SingleResponse.version == [1,0,0]`
  * `GetIdentityRelationshipsInformationResponse.relationships == 
    (
      $Card1, $Card2, $Card3, $Card4, $Card5, $Card6, $Card7, $Card8, $Card9,
    )`

Node replies with *GetIdentityRelationshipsInformationResponse*:

  * `Message.id := 7`
  * `Response.status == STATUS_OK`
  * `SingleResponse.version == [1,0,0]`
  * `GetIdentityRelationshipsInformationResponse.relationships == 
    (
      $Card1, $Card2, $Card3, $Card4, $Card5, $Card6, $Card7, $Card8, $Card9,
    )`

Node replies with *GetIdentityRelationshipsInformationResponse*:

  * `Message.id := 8`
  * `Response.status == STATUS_OK`
  * `SingleResponse.version == [1,0,0]`
  * `GetIdentityRelationshipsInformationResponse.relationships == 
    (
      $Card1, $Card2, $Card3, $Card4, $Card5, $Card6, $Card7, $Card8,
    )`

Node replies with *GetIdentityRelationshipsInformationResponse*:

  * `Message.id := 9`
  * `Response.status == STATUS_OK`
  * `SingleResponse.version == [1,0,0]`
  * `GetIdentityRelationshipsInformationResponse.relationships == 
    (
      $Card1, $Card2, $Card3, $Card4,
    )`

Node replies with *GetIdentityRelationshipsInformationResponse*:

  * `Message.id := 10`
  * `Response.status == STATUS_OK`
  * `SingleResponse.version == [1,0,0]`
  * `GetIdentityRelationshipsInformationResponse.relationships == 
    (
      $Card1, $Card2, $Card3, $Card4, $Card5, $Card6, $Card7, $Card8,
    )`

Node replies with *GetIdentityRelationshipsInformationResponse*:

  * `Message.id := 11`
  * `Response.status == STATUS_OK`
  * `SingleResponse.version == [1,0,0]`
  * `GetIdentityRelationshipsInformationResponse.relationships == 
    (
      $Card1, $Card2,
    )`

Node replies with *GetIdentityRelationshipsInformationResponse*:

  * `Message.id := 12`
  * `Response.status == STATUS_OK`
  * `SingleResponse.version == [1,0,0]`
  * `GetIdentityRelationshipsInformationResponse.relationships == 
    (
      $Card7, $Card8,
    )`


###### Step 5:

Node replies with *RemoveRelatedIdentityResponse*:

  * `Message.id := 12`
  * `Response.status == STATUS_OK`

Node replies with *RemoveRelatedIdentityResponse*:

  * `Message.id := 13`
  * `Response.status == STATUS_OK`

Node replies with *GetIdentityRelationshipsInformationResponse*:

  * `Message.id := 14`
  * `Response.status == STATUS_OK`
  * `SingleResponse.version == [1,0,0]`
  * `GetIdentityRelationshipsInformationResponse.relationships == 
    (
      $Card1, $Card3,
    )`

Node replies with *GetIdentityRelationshipsInformationResponse*:

  * `Message.id := 15`
  * `Response.status == STATUS_OK`
  * `SingleResponse.version == [1,0,0]`
  * `GetIdentityRelationshipsInformationResponse.relationships == ()`











#### HN07002 - Add/Remove/Get Related Identity - Invalid Requests

##### Prerequisites/Inputs

###### Prerequisites:
  * Node's database is empty.

###### Inputs:
  * Node's IP address
  * Node's primary port


##### Description 

The test checks error handling for invalid requests to add, remove and query related identities.


###### Step 1:

The tests obtains a list of service ports from the node's primary port.
The test creates a primary identity, for which it establishes a home node agreement and checks it in.
Then it creates another identities (called Issuer), which it uses for issuing relationship cards.


###### Step 2:

The test sends *AddRelatedIdentityRequest*:

  * `Message.id := 3`
  * `AddRelatedIdentityRequest.signedCard.card.type := "Card Type A"`
  * `AddRelatedIdentityRequest.signedCard.card.validFrom := 1479220556000`
  * `AddRelatedIdentityRequest.signedCard.card.validTo := 2479220556000`
  * `AddRelatedIdentityRequest.signedCard.card.issuerPublicKey` is a public key of Issuer
  * `AddRelatedIdentityRequest.signedCard.card.recipientPublicKey` is a public key of test's primary identity
  * `AddRelatedIdentityRequest.signedCard.card.cardId` is a valid hash of the relationship card as defined in the protocol
  * `AddRelatedIdentityRequest.signedCard.issuerSignature` is a valid signature of `AddRelatedIdentityRequest.signedCard.card.cardId` by Issuer
  * `AddRelatedIdentityRequest.cardApplication.cardId := AddRelatedIdentityRequest.signedCard.card.cardId`
  * `AddRelatedIdentityRequest.cardApplication.applicationId := [1]`
  * `ConversationResponse.signature` is initialized with 16 bytes 0x40

and reads the response. Then it sends *AddRelatedIdentityRequest*

  * `Message.id := 4`
  * `AddRelatedIdentityRequest.signedCard.card.type := "Card Type A"`
  * `AddRelatedIdentityRequest.signedCard.card.validFrom := 1479220556000`
  * `AddRelatedIdentityRequest.signedCard.card.validTo := 2479220556000`
  * `AddRelatedIdentityRequest.signedCard.card.issuerPublicKey` is a public key of Issuer
  * `AddRelatedIdentityRequest.signedCard.card.recipientPublicKey` is a public key of test's primary identity
  * `AddRelatedIdentityRequest.signedCard.card.cardId` is a valid hash of the relationship card as defined in the protocol
  * `AddRelatedIdentityRequest.signedCard.issuerSignature` is a valid signature of `AddRelatedIdentityRequest.signedCard.card.cardId` by Issuer
  * `AddRelatedIdentityRequest.cardApplication.cardId := AddRelatedIdentityRequest.signedCard.card.cardId`
  * `AddRelatedIdentityRequest.cardApplication.applicationId := [2]`
  * `ConversationResponse.signature` is a signature of `AddRelatedIdentityRequest.cardApplication` with XORed first byte with 0x12

and reads the response. Then it sends *AddRelatedIdentityRequest*

  * `Message.id := 5`
  * `AddRelatedIdentityRequest.signedCard.card.type := "Card Type A"`
  * `AddRelatedIdentityRequest.signedCard.card.validFrom := 1479220556000`
  * `AddRelatedIdentityRequest.signedCard.card.validTo := 2479220556000`
  * `AddRelatedIdentityRequest.signedCard.card.issuerPublicKey` is a public key of Issuer
  * `AddRelatedIdentityRequest.signedCard.card.recipientPublicKey` is a public key of test's primary identity
  * `AddRelatedIdentityRequest.signedCard.card.cardId` is a valid hash of the relationship card as defined in the protocol
  * `AddRelatedIdentityRequest.signedCard.issuerSignature` is a valid signature of `AddRelatedIdentityRequest.signedCard.card.cardId` by Issuer
  * `AddRelatedIdentityRequest.cardApplication.cardId := AddRelatedIdentityRequest.signedCard.card.cardId`
  * `AddRelatedIdentityRequest.cardApplication.applicationId := [3]`
  * `ConversationResponse.signature` is a valid signature of `AddRelatedIdentityRequest.cardApplication` 

and reads the response. Then it sends *AddRelatedIdentityRequest*

  * `Message.id := 6`
  * `AddRelatedIdentityRequest.signedCard.card.type := "Card Type A"`
  * `AddRelatedIdentityRequest.signedCard.card.validFrom := 1479220556000`
  * `AddRelatedIdentityRequest.signedCard.card.validTo := 2479220556000`
  * `AddRelatedIdentityRequest.signedCard.card.issuerPublicKey` is a public key of Issuer
  * `AddRelatedIdentityRequest.signedCard.card.recipientPublicKey` is a public key of test's primary identity
  * `AddRelatedIdentityRequest.signedCard.card.cardId` is a valid hash of the relationship card as defined in the protocol
  * `AddRelatedIdentityRequest.signedCard.issuerSignature` is a valid signature of `AddRelatedIdentityRequest.signedCard.card.cardId` by Issuer
  * `AddRelatedIdentityRequest.cardApplication.cardId := AddRelatedIdentityRequest.signedCard.card.cardId`
  * `AddRelatedIdentityRequest.cardApplication.applicationId := [3]`
  * `ConversationResponse.signature` is a valid signature of `AddRelatedIdentityRequest.cardApplication` 

and reads the response. Then it sends *AddRelatedIdentityRequest*

  * `Message.id := 7`
  * `AddRelatedIdentityRequest.signedCard.card.type := "Card Type A"`
  * `AddRelatedIdentityRequest.signedCard.card.validFrom := 1479220556000`
  * `AddRelatedIdentityRequest.signedCard.card.validTo := 2479220556000`
  * `AddRelatedIdentityRequest.signedCard.card.issuerPublicKey` is a public key of Issuer
  * `AddRelatedIdentityRequest.signedCard.card.recipientPublicKey` is a public key of test's primary identity
  * `AddRelatedIdentityRequest.signedCard.card.cardId` is a valid hash of the relationship card as defined in the protocol
  * `AddRelatedIdentityRequest.signedCard.issuerSignature` is a valid signature of `AddRelatedIdentityRequest.signedCard.card.cardId` by Issuer
  * `AddRelatedIdentityRequest.cardApplication.cardId` is initialized with 16 bytes 0x40
  * `AddRelatedIdentityRequest.cardApplication.applicationId := [4]`
  * `ConversationResponse.signature` is a valid signature of `AddRelatedIdentityRequest.cardApplication` 

and reads the response. Then it sends *AddRelatedIdentityRequest*

  * `Message.id := 8`
  * `AddRelatedIdentityRequest.signedCard.card.type := "Card Type A"`
  * `AddRelatedIdentityRequest.signedCard.card.validFrom := 1479220556000`
  * `AddRelatedIdentityRequest.signedCard.card.validTo := 2479220556000`
  * `AddRelatedIdentityRequest.signedCard.card.issuerPublicKey` is a public key of Issuer
  * `AddRelatedIdentityRequest.signedCard.card.recipientPublicKey` is a public key of test's primary identity
  * `AddRelatedIdentityRequest.signedCard.card.cardId` is a valid hash of the relationship card as defined in the protocol
  * `AddRelatedIdentityRequest.signedCard.issuerSignature` is a valid signature of `AddRelatedIdentityRequest.signedCard.card.cardId` by Issuer
  * `AddRelatedIdentityRequest.cardApplication.cardId := AddRelatedIdentityRequest.signedCard.card.cardId` and XOR its first byte with 0x12
  * `AddRelatedIdentityRequest.cardApplication.applicationId := [5]`
  * `ConversationResponse.signature` is a valid signature of `AddRelatedIdentityRequest.cardApplication` 

and reads the response. Then it sends *AddRelatedIdentityRequest*

  * `Message.id := 9`
  * `AddRelatedIdentityRequest.signedCard.card.type := "Card Type A"`
  * `AddRelatedIdentityRequest.signedCard.card.validFrom := 1479220556000`
  * `AddRelatedIdentityRequest.signedCard.card.validTo := 2479220556000`
  * `AddRelatedIdentityRequest.signedCard.card.issuerPublicKey` is a public key of Issuer
  * `AddRelatedIdentityRequest.signedCard.card.recipientPublicKey` is a public key of test's primary identity
  * `AddRelatedIdentityRequest.signedCard.card.cardId` is a valid hash of the relationship card as defined in the protocol
  * `AddRelatedIdentityRequest.signedCard.issuerSignature` is a valid signature of `AddRelatedIdentityRequest.signedCard.card.cardId` by Issuer
  * `AddRelatedIdentityRequest.cardApplication.cardId := AddRelatedIdentityRequest.signedCard.card.cardId`
  * `AddRelatedIdentityRequest.cardApplication.applicationId := []`
  * `ConversationResponse.signature` is a valid signature of `AddRelatedIdentityRequest.cardApplication` 

and reads the response. Then it sends *AddRelatedIdentityRequest*

  * `Message.id := 10`
  * `AddRelatedIdentityRequest.signedCard.card.type := "Card Type A"`
  * `AddRelatedIdentityRequest.signedCard.card.validFrom := 1479220556000`
  * `AddRelatedIdentityRequest.signedCard.card.validTo := 2479220556000`
  * `AddRelatedIdentityRequest.signedCard.card.issuerPublicKey` is a public key of Issuer
  * `AddRelatedIdentityRequest.signedCard.card.recipientPublicKey` is a public key of test's primary identity
  * `AddRelatedIdentityRequest.signedCard.card.cardId` is a valid hash of the relationship card as defined in the protocol
  * `AddRelatedIdentityRequest.signedCard.issuerSignature` is a valid signature of `AddRelatedIdentityRequest.signedCard.card.cardId` by Issuer
  * `AddRelatedIdentityRequest.cardApplication.cardId := AddRelatedIdentityRequest.signedCard.card.cardId`
  * `AddRelatedIdentityRequest.cardApplication.applicationId` is initialized with 40 bytes 0x40
  * `ConversationResponse.signature` is a valid signature of `AddRelatedIdentityRequest.cardApplication` 

and reads the response. Then it sends *AddRelatedIdentityRequest*

  * `Message.id := 11`
  * `AddRelatedIdentityRequest.signedCard.card.type := "Card Type A"`
  * `AddRelatedIdentityRequest.signedCard.card.validFrom := 1479220556000`
  * `AddRelatedIdentityRequest.signedCard.card.validTo := 2479220556000`
  * `AddRelatedIdentityRequest.signedCard.card.issuerPublicKey` is first 10 bytes of a public key of Issuer
  * `AddRelatedIdentityRequest.signedCard.card.recipientPublicKey` is a public key of test's primary identity
  * `AddRelatedIdentityRequest.signedCard.card.cardId` is a valid hash of the relationship card as defined in the protocol
  * `AddRelatedIdentityRequest.signedCard.issuerSignature` is a valid signature of `AddRelatedIdentityRequest.signedCard.card.cardId` by Issuer
  * `AddRelatedIdentityRequest.cardApplication.cardId := AddRelatedIdentityRequest.signedCard.card.cardId`
  * `AddRelatedIdentityRequest.cardApplication.applicationId := [6]`
  * `ConversationResponse.signature` is a valid signature of `AddRelatedIdentityRequest.cardApplication` 

and reads the response. Then it sends *AddRelatedIdentityRequest*

  * `Message.id := 12`
  * `AddRelatedIdentityRequest.signedCard.card.type := "Card Type A"`
  * `AddRelatedIdentityRequest.signedCard.card.validFrom := 1479220556000`
  * `AddRelatedIdentityRequest.signedCard.card.validTo := 2479220556000`
  * `AddRelatedIdentityRequest.signedCard.card.issuerPublicKey` is a public key of Issuer with XORed first byte with 0x12
  * `AddRelatedIdentityRequest.signedCard.card.recipientPublicKey` is a public key of test's primary identity
  * `AddRelatedIdentityRequest.signedCard.card.cardId` is a valid hash of the relationship card as defined in the protocol
  * `AddRelatedIdentityRequest.signedCard.issuerSignature` is a valid signature of `AddRelatedIdentityRequest.signedCard.card.cardId` by Issuer
  * `AddRelatedIdentityRequest.cardApplication.cardId := AddRelatedIdentityRequest.signedCard.card.cardId`
  * `AddRelatedIdentityRequest.cardApplication.applicationId := [7]`
  * `ConversationResponse.signature` is a valid signature of `AddRelatedIdentityRequest.cardApplication` 

and reads the response. Then it sends *AddRelatedIdentityRequest*

  * `Message.id := 13`
  * `AddRelatedIdentityRequest.signedCard.card.type := "Card Type A"`
  * `AddRelatedIdentityRequest.signedCard.card.validFrom := 1479220556000`
  * `AddRelatedIdentityRequest.signedCard.card.validTo := 2479220556000`
  * `AddRelatedIdentityRequest.signedCard.card.issuerPublicKey` is a public key of Issuer
  * `AddRelatedIdentityRequest.signedCard.card.recipientPublicKey` is a public key of test's primary identity
  * `AddRelatedIdentityRequest.signedCard.card.cardId` is a valid hash of the relationship card as defined in the protocol
  * `AddRelatedIdentityRequest.signedCard.issuerSignature` is first 20 bytes of a valid signature of `AddRelatedIdentityRequest.signedCard.card.cardId` by Issuer
  * `AddRelatedIdentityRequest.cardApplication.cardId := AddRelatedIdentityRequest.signedCard.card.cardId`
  * `AddRelatedIdentityRequest.cardApplication.applicationId := [8]`
  * `ConversationResponse.signature` is a valid signature of `AddRelatedIdentityRequest.cardApplication` 

and reads the response. Then it sends *AddRelatedIdentityRequest*

  * `Message.id := 14`
  * `AddRelatedIdentityRequest.signedCard.card.type := "Card Type A"`
  * `AddRelatedIdentityRequest.signedCard.card.validFrom := 1479220556000`
  * `AddRelatedIdentityRequest.signedCard.card.validTo := 2479220556000`
  * `AddRelatedIdentityRequest.signedCard.card.issuerPublicKey` is a public key of Issuer
  * `AddRelatedIdentityRequest.signedCard.card.recipientPublicKey` is a public key of test's primary identity
  * `AddRelatedIdentityRequest.signedCard.card.cardId` is a valid hash of the relationship card as defined in the protocol
  * `AddRelatedIdentityRequest.signedCard.issuerSignature` is a signature of `AddRelatedIdentityRequest.signedCard.card.cardId` by Issuer with XORed first byte with 0x12
  * `AddRelatedIdentityRequest.cardApplication.cardId := AddRelatedIdentityRequest.signedCard.card.cardId`
  * `AddRelatedIdentityRequest.cardApplication.applicationId := [9]`
  * `ConversationResponse.signature` is a valid signature of `AddRelatedIdentityRequest.cardApplication` 


and reads the response. Then it sends *AddRelatedIdentityRequest*

  * `Message.id := 15`
  * `AddRelatedIdentityRequest.signedCard.card.type := "Card Type A"`
  * `AddRelatedIdentityRequest.signedCard.card.validFrom := 1479220556000`
  * `AddRelatedIdentityRequest.signedCard.card.validTo := 2479220556000`
  * `AddRelatedIdentityRequest.signedCard.card.issuerPublicKey` is a public key of Issuer
  * `AddRelatedIdentityRequest.signedCard.card.recipientPublicKey` is a public key of test's primary identity
  * `AddRelatedIdentityRequest.signedCard.card.cardId` is first 20 bytes of a valid hash of the relationship card as defined in the protocol
  * `AddRelatedIdentityRequest.signedCard.issuerSignature` is a valid signature of `AddRelatedIdentityRequest.signedCard.card.cardId` by Issuer
  * `AddRelatedIdentityRequest.cardApplication.cardId := AddRelatedIdentityRequest.signedCard.card.cardId`
  * `AddRelatedIdentityRequest.cardApplication.applicationId := [10]`
  * `ConversationResponse.signature` is a valid signature of `AddRelatedIdentityRequest.cardApplication` 

and reads the response. Then it sends *AddRelatedIdentityRequest*

  * `Message.id := 16`
  * `AddRelatedIdentityRequest.signedCard.card.type := "Card Type A"`
  * `AddRelatedIdentityRequest.signedCard.card.validFrom := 1479220556000`
  * `AddRelatedIdentityRequest.signedCard.card.validTo := 2479220556000`
  * `AddRelatedIdentityRequest.signedCard.card.issuerPublicKey` is a public key of Issuer
  * `AddRelatedIdentityRequest.signedCard.card.recipientPublicKey` is a public key of test's primary identity
  * `AddRelatedIdentityRequest.signedCard.card.cardId` is a hash of the relationship card as defined in the protocol with XORed first byte with 0x12
  * `AddRelatedIdentityRequest.signedCard.issuerSignature` is a valid signature of `AddRelatedIdentityRequest.signedCard.card.cardId` by Issuer
  * `AddRelatedIdentityRequest.cardApplication.cardId := AddRelatedIdentityRequest.signedCard.card.cardId`
  * `AddRelatedIdentityRequest.cardApplication.applicationId := [11]`
  * `ConversationResponse.signature` is a valid signature of `AddRelatedIdentityRequest.cardApplication` 

and reads the response. Then it sends *AddRelatedIdentityRequest*

  * `Message.id := 17`
  * `AddRelatedIdentityRequest.signedCard.card.type := "Card Type A"`
  * `AddRelatedIdentityRequest.signedCard.card.validFrom := 1479220556000`
  * `AddRelatedIdentityRequest.signedCard.card.validTo := 2479220556000`
  * `AddRelatedIdentityRequest.signedCard.card.issuerPublicKey` is a public key of Issuer
  * `AddRelatedIdentityRequest.signedCard.card.recipientPublicKey` is first 20 bytes of a public key of test's primary identity
  * `AddRelatedIdentityRequest.signedCard.card.cardId` is a valid hash of the relationship card as defined in the protocol
  * `AddRelatedIdentityRequest.signedCard.issuerSignature` is a valid signature of `AddRelatedIdentityRequest.signedCard.card.cardId` by Issuer
  * `AddRelatedIdentityRequest.cardApplication.cardId := AddRelatedIdentityRequest.signedCard.card.cardId`
  * `AddRelatedIdentityRequest.cardApplication.applicationId := [12]`
  * `ConversationResponse.signature` is a valid signature of `AddRelatedIdentityRequest.cardApplication` 

and reads the response. Then it sends *AddRelatedIdentityRequest*

  * `Message.id := 18`
  * `AddRelatedIdentityRequest.signedCard.card.type := "Card Type A"`
  * `AddRelatedIdentityRequest.signedCard.card.validFrom := 1479220556000`
  * `AddRelatedIdentityRequest.signedCard.card.validTo := 2479220556000`
  * `AddRelatedIdentityRequest.signedCard.card.issuerPublicKey` is a public key of Issuer
  * `AddRelatedIdentityRequest.signedCard.card.recipientPublicKey` is a public key of test's primary identity with XORed first byte with 0x12
  * `AddRelatedIdentityRequest.signedCard.card.cardId` is a valid hash of the relationship card as defined in the protocol
  * `AddRelatedIdentityRequest.signedCard.issuerSignature` is a valid signature of `AddRelatedIdentityRequest.signedCard.card.cardId` by Issuer
  * `AddRelatedIdentityRequest.cardApplication.cardId := AddRelatedIdentityRequest.signedCard.card.cardId`
  * `AddRelatedIdentityRequest.cardApplication.applicationId := [13]`
  * `ConversationResponse.signature` is a valid signature of `AddRelatedIdentityRequest.cardApplication` 

and reads the response. Then it sends *AddRelatedIdentityRequest*

  * `Message.id := 19`
  * `AddRelatedIdentityRequest.signedCard.card.type := "Card Type A"`
  * `AddRelatedIdentityRequest.signedCard.card.validFrom := 1479220556000`
  * `AddRelatedIdentityRequest.signedCard.card.validTo := 1479220555000`
  * `AddRelatedIdentityRequest.signedCard.card.issuerPublicKey` is a public key of Issuer
  * `AddRelatedIdentityRequest.signedCard.card.recipientPublicKey` is a public key of test's primary identity
  * `AddRelatedIdentityRequest.signedCard.card.cardId` is a valid hash of the relationship card as defined in the protocol
  * `AddRelatedIdentityRequest.signedCard.issuerSignature` is a valid signature of `AddRelatedIdentityRequest.signedCard.card.cardId` by Issuer
  * `AddRelatedIdentityRequest.cardApplication.cardId := AddRelatedIdentityRequest.signedCard.card.cardId`
  * `AddRelatedIdentityRequest.cardApplication.applicationId := [14]`
  * `ConversationResponse.signature` is a valid signature of `AddRelatedIdentityRequest.cardApplication` 

and reads the response. Then it sends *AddRelatedIdentityRequest*

  * `Message.id := 20`
  * `AddRelatedIdentityRequest.signedCard.card.type` is initialized with 70x 'a'
  * `AddRelatedIdentityRequest.signedCard.card.validFrom := 1479220556000`
  * `AddRelatedIdentityRequest.signedCard.card.validTo := 2479220556000`
  * `AddRelatedIdentityRequest.signedCard.card.issuerPublicKey` is a public key of Issuer
  * `AddRelatedIdentityRequest.signedCard.card.recipientPublicKey` is a public key of test's primary identity
  * `AddRelatedIdentityRequest.signedCard.card.cardId` is a valid hash of the relationship card as defined in the protocol
  * `AddRelatedIdentityRequest.signedCard.issuerSignature` is a valid signature of `AddRelatedIdentityRequest.signedCard.card.cardId` by Issuer
  * `AddRelatedIdentityRequest.cardApplication.cardId := AddRelatedIdentityRequest.signedCard.card.cardId`
  * `AddRelatedIdentityRequest.cardApplication.applicationId := [15]`
  * `ConversationResponse.signature` is a valid signature of `AddRelatedIdentityRequest.cardApplication` 

and reads the response. Then it sends *AddRelatedIdentityRequest*

  * `Message.id := 21`
  * `AddRelatedIdentityRequest.signedCard.card.type` is initialized with 35x 'ɐ' (UTF8 code 0xc990), which consumes 2 bytes per character
  * `AddRelatedIdentityRequest.signedCard.card.validFrom := 1479220556000`
  * `AddRelatedIdentityRequest.signedCard.card.validTo := 2479220556000`
  * `AddRelatedIdentityRequest.signedCard.card.issuerPublicKey` is a public key of Issuer
  * `AddRelatedIdentityRequest.signedCard.card.recipientPublicKey` is a public key of test's primary identity
  * `AddRelatedIdentityRequest.signedCard.card.cardId` is a valid hash of the relationship card as defined in the protocol
  * `AddRelatedIdentityRequest.signedCard.issuerSignature` is a valid signature of `AddRelatedIdentityRequest.signedCard.card.cardId` by Issuer
  * `AddRelatedIdentityRequest.cardApplication.cardId := AddRelatedIdentityRequest.signedCard.card.cardId`
  * `AddRelatedIdentityRequest.cardApplication.applicationId := [16]`
  * `ConversationResponse.signature` is a valid signature of `AddRelatedIdentityRequest.cardApplication` 




###### Step 3:


Then it sends *RemoveRelatedIdentityRequest*:

  * `Message.id := 22`
  * `RemoveRelatedIdentityRequest.applicationId := [17]`

and reads the response. Then it sends *GetIdentityRelationshipsInformationRequest*:

  * `Message.id := 23`
  * `SingleRequest.version := [1,0,0]`
  * `GetIdentityRelationshipsInformationRequest.identityNetworkId` is set to the primary test's identity ID
  * `GetIdentityRelationshipsInformationRequest.includeInvalid := true`
  * `GetIdentityRelationshipsInformationRequest.type` is initialized with 70x 'a'
  * `GetIdentityRelationshipsInformationRequest.specificIssuer := false`
  * `GetIdentityRelationshipsInformationRequest.issuerNetworkId` is uninitialized

and reads the response. Then it sends *GetIdentityRelationshipsInformationRequest*:

  * `Message.id := 24`
  * `SingleRequest.version := [1,0,0]`
  * `GetIdentityRelationshipsInformationRequest.identityNetworkId` is set to the primary test's identity ID
  * `GetIdentityRelationshipsInformationRequest.includeInvalid := true`
  * `GetIdentityRelationshipsInformationRequest.type` is initialized with 35x 'ɐ' (UTF8 code 0xc990), which consumes 2 bytes per character
  * `GetIdentityRelationshipsInformationRequest.specificIssuer := false`
  * `GetIdentityRelationshipsInformationRequest.issuerNetworkId` is uninitialized

and reads the response.

  
##### Acceptance Criteria


###### Step 1:

The test successfully obtains list of ports on which the node provides its services. 
Then the test successfully establishes home node agreements for its primary and secondary identities.
Then the test successfully checks-in both identities.


###### Step 2:

Node replies with *Response*:

  * `Message.id := 3`
  * `Response.status == ERROR_INVALID_SIGNATURE`


Node replies with *Response*:

  * `Message.id := 4`
  * `Response.status == ERROR_INVALID_SIGNATURE`


Node replies with *AddRelatedIdentityResponse*:

  * `Message.id := 5`
  * `Response.status == STATUS_OK`


Node replies with *Response*:

  * `Message.id := 6`
  * `Response.status == ERROR_ALREADY_EXISTS`


Node replies with *Response*:

  * `Message.id := 7`
  * `Response.status == ERROR_INVALID_VALUE`
  * `Response.details == "cardApplication.cardId"`


Node replies with *Response*:

  * `Message.id := 8`
  * `Response.status == ERROR_INVALID_VALUE`
  * `Response.details == "cardApplication.cardId"`


Node replies with *Response*:

  * `Message.id := 9`
  * `Response.status == ERROR_INVALID_VALUE`
  * `Response.details == "cardApplication.applicationId"`


Node replies with *Response*:

  * `Message.id := 10`
  * `Response.status == ERROR_INVALID_VALUE`
  * `Response.details == "cardApplication.applicationId"`


Node replies with *Response*:

  * `Message.id := 11`
  * `Response.status == ERROR_INVALID_VALUE`
  * `Response.details == "signedCard.issuerSignature"`

Node replies with *Response*:

  * `Message.id := 12`
  * `Response.status == ERROR_INVALID_VALUE`
  * `Response.details == "signedCard.issuerSignature"`

Node replies with *Response*:

  * `Message.id := 13`
  * `Response.status == ERROR_INVALID_VALUE`
  * `Response.details == "signedCard.issuerSignature"`

Node replies with *Response*:

  * `Message.id := 14`
  * `Response.status == ERROR_INVALID_VALUE`
  * `Response.details == "signedCard.issuerSignature"`

Node replies with *Response*:

  * `Message.id := 15`
  * `Response.status == ERROR_INVALID_VALUE`
  * `Response.details == "signedCard.card.cardId"`

Node replies with *Response*:

  * `Message.id := 16`
  * `Response.status == ERROR_INVALID_VALUE`
  * `Response.details == "signedCard.card.cardId"`

Node replies with *Response*:

  * `Message.id := 17`
  * `Response.status == ERROR_INVALID_VALUE`
  * `Response.details == "signedCard.card.recipientPublicKey"`

Node replies with *Response*:

  * `Message.id := 18`
  * `Response.status == ERROR_INVALID_VALUE`
  * `Response.details == "signedCard.card.recipientPublicKey"`

Node replies with *Response*:

  * `Message.id := 19`
  * `Response.status == ERROR_INVALID_VALUE`
  * `Response.details == "signedCard.card.validFrom"`

Node replies with *Response*:

  * `Message.id := 20`
  * `Response.status == ERROR_INVALID_VALUE`
  * `Response.details == "signedCard.card.type"`

Node replies with *Response*:

  * `Message.id := 21`
  * `Response.status == ERROR_INVALID_VALUE`
  * `Response.details == "signedCard.card.type"`



###### Step 3:

Node replies with *Response*:

  * `Message.id := 22`
  * `Response.status == ERROR_NOT_FOUND`

Node replies with *Response*:

  * `Message.id := 23`
  * `Response.status == ERROR_INVALID_VALUE`
  * `Response.details == "type"`

Node replies with *Response*:

  * `Message.id := 24`
  * `Response.status == ERROR_INVALID_VALUE`
  * `Response.details == "type"`






#### HN07003 - Add Related Identity - Quota Exceeded

##### Prerequisites/Inputs

###### Prerequisites:
  * Node's database is empty.
  * Node's maximum number of related identities is set to 100.

###### Inputs:
  * Node's IP address
  * Node's primary port


##### Description 

The test adds too many related identities.


###### Step 1:

The tests obtains a list of service ports from the node's primary port.
The test creates a primary identity, for which it establishes a home node agreement and checks it in.
Then it creates another identities (called Issuer), which it uses for issuing relationship cards.


###### Step 2:

The test then sends 101 *AddRelatedIdentityRequest* requests (for $i = 0 to 100):

  * `Message.id := $i + 1`
  * `AddRelatedIdentityRequest.signedCard.card.type := "Card Type A"`
  * `AddRelatedIdentityRequest.signedCard.card.validFrom := 1479220556000`
  * `AddRelatedIdentityRequest.signedCard.card.validTo := 2479220556000`
  * `AddRelatedIdentityRequest.signedCard.card.issuerPublicKey` is a public key of Issuer
  * `AddRelatedIdentityRequest.signedCard.card.recipientPublicKey` is a public key of test's primary identity
  * `AddRelatedIdentityRequest.signedCard.card.cardId` is a valid hash of the relationship card as defined in the protocol
  * `AddRelatedIdentityRequest.signedCard.issuerSignature` is a valid signature of `AddRelatedIdentityRequest.signedCard.card.cardId` by Issuer
  * `AddRelatedIdentityRequest.cardApplication.cardId := AddRelatedIdentityRequest.signedCard.card.cardId`
  * `AddRelatedIdentityRequest.cardApplication.applicationId := [$i]`
  * `ConversationResponse.signature` is a valid signature of `AddRelatedIdentityRequest.cardApplication`



##### Acceptance Criteria


###### Step 1:

The test successfully obtains list of ports on which the node provides its services. 
Then the test successfully establishes home node agreements for its primary and secondary identities.
Then the test successfully checks-in both identities.


###### Step 2:

For first 100 cards, node replies with *AddRelatedIdentityResponse*:

  * `Message.id := 3`
  * `Response.status == STATUS_OK`


For 101st card, node replies with *Response*:

  * `Message.id := 3`
  * `Response.status == ERROR_QUOTA_EXCEEDED`


