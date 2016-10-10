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
  * `StartConversationRequest.publicKey` set to test's 32 byte long public key
 
and reads the response. Then it sends *HomeNodeRequestRequest*:

  * `Message.id := 2`
  * `HomeNodeRequestRequest.contract` is uninitialized

and reads the response.


##### Acceptance Criteria

###### Step 1:

Node replies with *StartConversationResponse*:
  
  * `Message.id == 1`
  * `Response.status == STATUS_OK`

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
  * `StartConversationRequest.publicKey` set to test's 32 byte long public key
 
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
  * `StartConversationRequest.publicKey` set to test's 32 byte long public key
 
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
  * `GetIdentityInformationRequest.identityNetworkId` is set to SHA1 of test's identity public key
  * `GetIdentityInformationRequest.includeProfileImage := false`
  * `GetIdentityInformationRequest.includeThumbnailImage := false`
  * `GetIdentityInformationRequest.includeApplicationServices := false`
 
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
  * `StartConversationRequest.publicKey` set to test's 32 byte long public key

and reads the response
  
##### Acceptance Criteria

###### Step 1:
Node replies with *StartConversationResponse*:
  
  * `Message.id == 1`
  * `Response.status == STATUS_OK`
  * `StartConversationResponse.version == [1,0,0]`
  * `StartConversationResponse.publicKey.Length == 32`
  * `StartConversationResponse.challenge.Length == 32`












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
  * `StartConversationRequest.publicKey` set to test's 32 byte long public key
  
and reads the response.
  
##### Acceptance Criteria

###### Step 1:
Node replies with *Response*:
  
  * `Message.id == 1`
  * `Response.status == ERROR_UNSUPPORTED`







#### HN02005 - Home Node Request

##### Prerequisites/Inputs

###### Prerequisites
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
  * `StartConversationRequest.publicKey` set to test's 32 byte long public key
  
and reads the response. Then it sends *HomeNodeRequestRequest*:

  * `Message.id := 2`
  * `HomeNodeRequestRequest.contract` is uninitialized

and reads the response.

  
##### Acceptance Criteria

###### Step 1:
Node replies with *StartConversationResponse*:
  
  * `Message.id == 1`
  * `Response.status == STATUS_OK`
  * `StartConversationResponse.version == [1,0,0]`
  * `StartConversationResponse.publicKey.Length == 32`
  * `StartConversationResponse.challenge.Length == 32`

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

###### Prerequisites
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
  
and reads the response. Then it sends *HomeNodeRequestRequest*:

  * `Message.id := 2`
  * `HomeNodeRequestRequest.contract` is uninitialized
  
and reads the response.
  
###### Step 2:
The test then closes the connection and creates a new TLS connection to the clNonCustomer port and sends *StartConversationRequest*:

  * `Message.id := 1`
  * `StartConversationRequest.supportedVersions := [[1,0,0]]`
  * `StartConversationRequest.publicKey` set to the test's identity #2 32 byte long public key

and reads the response. Then it sends *HomeNodeRequestRequest*:

  * `Message.id := 2`
  * `HomeNodeRequestRequest.contract` is uninitialized

and reads the response.
  
##### Acceptance Criteria


###### Step 1:
Node replies with *StartConversationResponse*:

  * `Message.id == 1`
  * `Response.status == STATUS_OK`
  * `$NodeKey := StartConversationResponse.publicKey`

Node replies with *HomeNodeRequestResponse*:

  * `Message.id == 2`
  * `Response.status == STATUS_OK`


###### Step 2:
Node replies with *StartConversationResponse*:

  * `Message.id == 1`
  * `Response.status == STATUS_OK`
  * `StartConversationResponse.publicKey == $NodeKey`

Node replies with *Response*:

  * `Message.id == 2`
  * `Response.status == ERROR_QUOTA_EXCEEDED`












#### HN02008 - Home Node Request - Already Exists

##### Prerequisites/Inputs

###### Prerequisites
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
  
and reads the response. Then it sends *HomeNodeRequestRequest*:

  * `Message.id := 2`
  * `HomeNodeRequestRequest.contract` is uninitialized

and reads the response.
 
###### Step 2:
The test then closes the connection and creates a new TLS connection to the clNonCustomer port and sends *StartConversationRequest*:

  * `Message.id := 1`
  * `StartConversationRequest.supportedVersions := [[1,0,0]]`
  * `StartConversationRequest.publicKey` set to the test's identity 32 byte long public key

and reads the response. Then it sends *HomeNodeRequestRequest*:

  * `Message.id := 2`
  * `HomeNodeRequestRequest.contract` is uninitialized

and reads the response.

##### Acceptance Criteria


###### Step 1:
Node replies with *StartConversationResponse*:

  * `Message.id == 1`
  * `Response.status == STATUS_OK`

Node replies with *HomeNodeRequestResponse*:

  * `Message.id == 2`
  * `Response.status == STATUS_OK`


###### Step 2:
Node replies with *StartConversationResponse*:

  * `Message.id == 1`
  * `Response.status == STATUS_OK`

Node replies with *Response*:

  * `Message.id == 2`
  * `Response.status == ERROR_ALREADY_EXISTS`








#### HN02009 - Verify Identity

##### Prerequisites/Inputs

###### Prerequisites
  * Node's database is empty.
  
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

Node replies with *VerifyIdentityResponse*:

  * `Message.id == 2`
  * `Response.status == STATUS_OK`






#### HN02010 - Verify Identity - Invalid Signature

##### Prerequisites/Inputs

###### Prerequisites
  * Node's database is empty.
  
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


Node replies with *Response*:

  * `Message.id == 2`
  * `Response.status == ERROR_INVALID_SIGNATURE`




#### HN02011 - Verify Identity - Invalid Challenge

##### Prerequisites/Inputs

###### Prerequisites
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
###### Prerequisites:
  * Test's identity is hosted by the node

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

Node replies with *VerifyIdentityResponse*:

  * `Message.id == 2`
  * `Response.status == STATUS_OK`


###### Step 2:
Node replies with *StartConversationResponse*:

  * `Message.id == 1`
  * `Response.status == STATUS_OK`

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
  * `StartConversationRequest.publicKey` set to test's 32 byte long public key
 
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

Node replies with *Response*:
  
  * `Message.id == 2`
  * `Response.status == ERROR_BAD_ROLE`








#### HN02015 - Get Identity Information - Uninitialized

##### Prerequisites/Inputs

###### Prerequisites
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
  
and reads the response from the node in form of *StartConversationResponse*:

  * `$Challenge := StartConversationResponse.challenge`

Then it sends *HomeNodeRequestRequest*:

  * `Message.id := 2`
  * `HomeNodeRequestRequest.contract` is uninitialized
  
and reads the response. The test it sends *GetIdentityInformationRequest*:

  * `Message.id := 3`
  * `SingleRequest.version := [1,0,0]`
  * `GetIdentityInformationRequest.identityNetworkId` is set to SHA1 of test's identity public key
  * `GetIdentityInformationRequest.includeProfileImage := false`
  * `GetIdentityInformationRequest.includeThumbnailImage := false`
  * `GetIdentityInformationRequest.includeApplicationServices := false`
  
and reads the response.

  
##### Acceptance Criteria


###### Step 1:
Node replies with *StartConversationResponse*:

  * `Message.id == 1`
  * `Response.status == STATUS_OK`

Node replies with *HomeNodeRequestResponse*:

  * `Message.id == 2`
  * `Response.status == STATUS_OK`

Node replies with *Response*:

  * `Message.id == 3`
  * `Response.status == ERROR_UNINITIALIZED`







#### HN02016 - Get Identity Information - Unknown Identity

##### Prerequisites/Inputs

###### Prerequisites
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
  * `GetIdentityInformationRequest.identityNetworkId := SHA1("test")`
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
  * Test's identity is hosted by the node
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
  * `UpdateProfileRequest.location := 0x12345678`
  * `UpdateProfileRequest.extraData` is unintialized

and reads the response.


##### Acceptance Criteria


###### Step 1:
Node replies with *StartConversationResponse*:

  * `Message.id == 1`
  * `Response.status == STATUS_OK`

Node replies with *VerifyIdentityResponse*:

  * `Message.id == 2`
  * `Response.status == STATUS_OK`

Node replies with *Response*:

  * `Message.id == 3`
  * `Response.status == ERROR_BAD_ROLE`


















### HN03xxx - Node Client Customer Port Functionality Tests

#### HN03001 - Check-In - Not Hosted Identity

##### Prerequisites/Inputs

###### Prerequisites
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
  * `StartConversationRequest.publicKey` set to test's 32 byte long public key
 
and reads the response. Then it sends *HomeNodeRequestRequest*:

  * `Message.id := 2`
  * `HomeNodeRequestRequest.contract` is uninitialized

and reads the response.


##### Acceptance Criteria

###### Step 1:

Node replies with *StartConversationResponse*:
  
  * `Message.id == 1`
  * `Response.status == STATUS_OK`

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
  * `StartConversationRequest.publicKey` set to test's 32 byte long public key
 
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
  * `CheckInRequest.challenge` is uninitialized
  
and reads the response.
  
##### Acceptance Criteria

###### Step 1:
Node replies with *Response*:
  
  * `Message.id == 1`
  * `Response.status == ERROR_BAD_CONVERSATION_STATUS`






#### HN03005 - Cancel Home Node Agreement - Redirection

##### Prerequisites/Inputs
###### Prerequisites:
  * Test's identity is hosted by the node

###### Inputs:
  * Node's IP address
  * Node's clCustomer port

##### Description 

The test cancels home node agreement for its hosted identity and sets up a redirect to a new home node. It then verifies that this redirect has been installed.

###### Step 1:
The test establishes a TLS connection to the clCustomer port of the node and sends *StartConversationRequest*:

  * `Message.id := 1`
  * `StartConversationRequest.supportedVersions := [[1,0,0]]`
  * `StartConversationRequest.publicKey` set to the test's identity 32 byte long public key

and reads the response from the node in form of *StartConversationResponse*:

  * `$Challenge := StartConversationResponse.challenge`

Then it sends *CheckInRequest*:

  * `Message.id := 2`
  * `CheckInRequest.challenge := $Challenge`
  * `ConversationRequest.signature` is set to a signature of `CheckInRequest` part of the message using the test's identity private key
  
and reads the response. Then it sends *CancelHomeNodeAgreementRequest*:

  * `Message.id := 3`
  * `CancelHomeNodeAgreementRequest.redirectToNewHomeNode := true`
  * `CancelHomeNodeAgreementRequest.newHomeNodeNetworkId` is set to SHA1("test")

and reads the response. Then it sends *GetIdentityInformationRequest*:

  * `Message.id := 4`
  * `SingleRequest.version := [1,0,0]`
  * `GetIdentityInformationRequest.identityNetworkId` is set to SHA1 of test's identity public key
  * `GetIdentityInformationRequest.includeProfileImage = false`
  * `GetIdentityInformationRequest.includeThumbnailImage = false`
  * `GetIdentityInformationRequest.includeApplicationServices = false`


##### Acceptance Criteria


###### Step 1:
Node replies with *StartConversationResponse*:

  * `Message.id == 1`
  * `Response.status == STATUS_OK`

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
  * `GetIdentityInformationResponse.targetHomeNodeNetworkId == SHA1("test")`






#### HN03006 - Cancel Home Node Agreement - Invalid New Home Node Id

##### Prerequisites/Inputs
###### Prerequisites:
  * Test's identity is hosted by the node

###### Inputs:
  * Node's IP address
  * Node's clCustomer port

##### Description 

The test cancels home node agreement for its hosted identity and sets up a redirect to a new home node, but provides invalid new home node network identifier.

###### Step 1:
The test establishes a TLS connection to the clCustomer port of the node and sends *StartConversationRequest*:

  * `Message.id := 1`
  * `StartConversationRequest.supportedVersions := [[1,0,0]]`
  * `StartConversationRequest.publicKey` set to the test's identity 32 byte long public key

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
Node replies with *StartConversationResponse*:

  * `Message.id == 1`
  * `Response.status == STATUS_OK`

Node replies with *CheckInResponse*:

  * `Message.id == 2`
  * `Response.status == STATUS_OK`

Node replies with *Response*:

  * `Message.id == 3`
  * `Response.status == ERROR_INVALID_VALUE`
  * `Response.details == newHomeNodeNetworkId`








#### HN03007 - Parallel Check-Ins

##### Prerequisites/Inputs
###### Prerequisites:
  * Test's identity is hosted by the node

###### Inputs:
  * Node's IP address
  * Node's clCustomer port

##### Description 

The test checks-in its identity and then it checks it in again in a second parallel connection. This should disconnect the first connection.

###### Step 1:
The test establishes a TLS connection to the clCustomer port of the node and sends *StartConversationRequest*:

  * `Message.id := 1`
  * `StartConversationRequest.supportedVersions := [[1,0,0]]`
  * `StartConversationRequest.publicKey` set to the test's identity 32 byte long public key

and reads the response from the node in form of *StartConversationResponse*:

  * `$Challenge := StartConversationResponse.challenge`

Then it sends *CheckInRequest*:

  * `Message.id := 2`
  * `CheckInRequest.challenge := $Challenge`
  * `ConversationRequest.signature` is set to a signature of `CheckInRequest` part of the message using the test's identity private key
  
and reads the response. 

###### Step 2:
With the first connection left open, the test establishes a new TLS connection to the clCustomer port of the node and sends *StartConversationRequest*:

  * `Message.id := 1`
  * `StartConversationRequest.supportedVersions := [[1,0,0]]`
  * `StartConversationRequest.publicKey` set to the test's identity 32 byte long public key

and reads the response from the node in form of *StartConversationResponse*:

  * `$Challenge := StartConversationResponse.challenge`

Then it sends *CheckInRequest*:

  * `Message.id := 2`
  * `CheckInRequest.challenge := $Challenge`
  * `ConversationRequest.signature` is set to a signature of `CheckInRequest` part of the message using the test's identity private key
  
and reads the response. 

###### Step 3:

Using the first connection the test attempts to send *PingRequest*:

  * `Message.id := 1`
  * `SingleRequest.version := [1,0,0]`
  * `PingRequest.payload = "test"`




##### Acceptance Criteria


###### Step 1:
Node replies with *StartConversationResponse*:

  * `Message.id == 1`
  * `Response.status == STATUS_OK`

Node replies with *CheckInResponse*:

  * `Message.id == 2`
  * `Response.status == STATUS_OK`


###### Step 2:
Node replies with *StartConversationResponse*:

  * `Message.id == 1`
  * `Response.status == STATUS_OK`

Node replies with *CheckInResponse*:

  * `Message.id == 2`
  * `Response.status == STATUS_OK`

###### Step 3:

The first connection should be disconnected and it should not be possible to send the request.













#### HN03008 - Update Profile - Unauthorized

##### Prerequisites/Inputs

###### Prerequisites
  * Test's identity is hosted by the node

###### Inputs:
  * Node's IP address
  * Node's clCustomer port

##### Description 

The test asks to update its profile without performing a check-in process first. 

###### Step 1:
The test then closes the connection and establishes a TLS connection to the clCustomer port of the node and sends *StartConversationRequest*:

  * `Message.id := 1`
  * `StartConversationRequest.supportedVersions := [[1,0,0]]`
  * `StartConversationRequest.publicKey := $PublicKey`

and reads the response from the node in form of *StartConversationResponse*:

  * `$Challenge := StartConversationResponse.challenge`

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
  * `UpdateProfileRequest.location := 0x12345678`
  * `UpdateProfileRequest.extraData` is unintialized

and reads the response. 

  
##### Acceptance Criteria


###### Step 1:
Node replies with *StartConversationResponse*:

  * `Message.id == 1`
  * `Response.status == STATUS_OK`

Node replies with *Response*:

  * `Message.id == 2`
  * `Response.status == ERROR_UNAUTHORIZED`












#### HN03009 - Application Service Add

##### Prerequisites/Inputs
###### Prerequisites:
  * Test's identity is hosted by the node

###### Inputs:
  * Node's IP address
  * Node's clCustomer port

##### Description 

The test checks-in its identity and then it adds/deletes/queries its application services. Some of the requests are valid and some are invalid.


###### Step 1:
The test establishes a TLS connection to the clCustomer port of the node and sends *StartConversationRequest*:

  * `Message.id := 1`
  * `StartConversationRequest.supportedVersions := [[1,0,0]]`
  * `StartConversationRequest.publicKey` set to the test's identity 32 byte long public key; `$PublicKey := StartConversationRequest.publicKey`

and reads the response from the node in form of *StartConversationResponse*:

  * `$Challenge := StartConversationResponse.challenge`

Then it sends *CheckInRequest*:

  * `Message.id := 2`
  * `CheckInRequest.challenge := $Challenge`
  * `ConversationRequest.signature` is set to a signature of `CheckInRequest` part of the message using the test's identity private key
  
and reads the response. Then it sends *ApplicationServiceAddRequest*:

  * `Message.id := 3`
  * `ApplicationServiceAddRequest.serviceNames := ["a","b","c","d","a"]`

and reads the response. Then it sends *GetIdentityInformationRequest*:

  * `Message.id := 4`
  * `SingleRequest.version := [1,0,0]`
  * `GetIdentityInformationRequest.identityNetworkId:= SHA1($PublicKey)`
  * `GetIdentityInformationRequest.includeProfileImage := false`
  * `GetIdentityInformationRequest.includeThumbnailImage := false`
  * `GetIdentityInformationRequest.includeApplicationServices := true`

and reads the response. Then it sends *ApplicationServiceAddRequest*:

  * `Message.id := 5`
  * `ApplicationServiceAddRequest.serviceNames := ["c","d","a","e"]`

and reads the response. Then it sends *GetIdentityInformationRequest*:

  * `Message.id := 6`
  * `SingleRequest.version := [1,0,0]`
  * `GetIdentityInformationRequest.identityNetworkId:= SHA1($PublicKey)`
  * `GetIdentityInformationRequest.includeProfileImage := false`
  * `GetIdentityInformationRequest.includeThumbnailImage := false`
  * `GetIdentityInformationRequest.includeApplicationServices := true`

and reads the response. Then it sends *ApplicationServiceRemoveRequest*:

  * `Message.id := 7`
  * `ApplicationServiceRemoveRequest.serviceName := "a"`

and reads the response. Then it sends *GetIdentityInformationRequest*:

  * `Message.id := 8`
  * `SingleRequest.version := [1,0,0]`
  * `GetIdentityInformationRequest.identityNetworkId:= SHA1($PublicKey)`
  * `GetIdentityInformationRequest.includeProfileImage := false`
  * `GetIdentityInformationRequest.includeThumbnailImage := false`
  * `GetIdentityInformationRequest.includeApplicationServices := true`

and reads the response. Then it sends *ApplicationServiceRemoveRequest*:

  * `Message.id := 9`
  * `ApplicationServiceRemoveRequest.serviceName := "a"`

and reads the response. Then it sends *GetIdentityInformationRequest*:

  * `Message.id := 10`
  * `SingleRequest.version := [1,0,0]`
  * `GetIdentityInformationRequest.identityNetworkId:= SHA1($PublicKey)`
  * `GetIdentityInformationRequest.includeProfileImage := false`
  * `GetIdentityInformationRequest.includeThumbnailImage := false`
  * `GetIdentityInformationRequest.includeApplicationServices := true`

and reads the response. Then it sends *ApplicationServiceAddRequest*:

  * `Message.id := 11`
  * `ApplicationServiceAddRequest.serviceNames := ["d","1234567890-1234567890-1234567890-1234567890","a","e"]`

and reads the response. Then it sends *GetIdentityInformationRequest*:

  * `Message.id := 12`
  * `SingleRequest.version := [1,0,0]`
  * `GetIdentityInformationRequest.identityNetworkId:= SHA1($PublicKey)`
  * `GetIdentityInformationRequest.includeProfileImage := false`
  * `GetIdentityInformationRequest.includeThumbnailImage := false`
  * `GetIdentityInformationRequest.includeApplicationServices := true`

and reads the response. Then it sends *ApplicationServiceAddRequest*:

  * `Message.id := 13`
  * `ApplicationServiceAddRequest.serviceNames := ["a1","a2","a3","a4,"a5","a6","a7","a8","a9","a10"]`

and reads the response. Then it sends *ApplicationServiceAddRequest*:

  * `Message.id := 14`
  * `ApplicationServiceAddRequest.serviceNames := ["b1","b2","b3","b4,"b5","b6","b7","b8","b9","b10"]`

and reads the response. Then it sends *GetIdentityInformationRequest*:

  * `Message.id := 15`
  * `SingleRequest.version := [1,0,0]`
  * `GetIdentityInformationRequest.identityNetworkId:= SHA1($PublicKey)`
  * `GetIdentityInformationRequest.includeProfileImage := false`
  * `GetIdentityInformationRequest.includeThumbnailImage := false`
  * `GetIdentityInformationRequest.includeApplicationServices := true`

and reads the response. Then it sends *ApplicationServiceAddRequest*:

  * `Message.id := 16`
  * `ApplicationServiceAddRequest.serviceNames := ["c1","c2","c3","c4,"c5","c6","c7","c8","c9","c10","d1","d2","d3","d4,"d5","d6","d7","d8","d9","d10","e1","e2","e3","e4,"e5","e6","e7","e8","e9","e10"]`

and reads the response. Then it sends *GetIdentityInformationRequest*:

  * `Message.id := 17`
  * `SingleRequest.version := [1,0,0]`
  * `GetIdentityInformationRequest.identityNetworkId:= SHA1($PublicKey)`
  * `GetIdentityInformationRequest.includeProfileImage := false`
  * `GetIdentityInformationRequest.includeThumbnailImage := false`
  * `GetIdentityInformationRequest.includeApplicationServices := true`

and reads the response.


                                      

##### Acceptance Criteria


###### Step 1:
Node replies with *StartConversationResponse*:

  * `Message.id == 1`
  * `Response.status == STATUS_OK`

Node replies with *CheckInResponse*:

  * `Message.id == 2`
  * `Response.status == STATUS_OK`

Node replies with *ApplicationServiceAddResponse*:

  * `Message.id == 3`
  * `Response.status == STATUS_OK`

Node replies with *GetIdentityInformationResponse*:

  * `Message.id == 4`
  * `Response.status == STATUS_OK`
  * `GetIdentityInformationResponse.isHosted == true`
  * `GetIdentityInformationResponse.isOnline == true`
  * `GetIdentityInformationResponse.identityPublicKey == $PublicKey`
  * `GetIdentityInformationResponse.applicationServices == ("a","b","c","d")`

Node replies with *ApplicationServiceAddResponse*:

  * `Message.id == 5`
  * `Response.status == STATUS_OK`

Node replies with *GetIdentityInformationResponse*:

  * `Message.id == 6`
  * `Response.status == STATUS_OK`
  * `GetIdentityInformationResponse.isHosted == true`
  * `GetIdentityInformationResponse.isOnline == true`
  * `GetIdentityInformationResponse.identityPublicKey == $PublicKey`
  * `GetIdentityInformationResponse.applicationServices == ("a","b","c","d","e")`

Node replies with *ApplicationServiceRemoveResponse*:

  * `Message.id == 7`
  * `Response.status == STATUS_OK`

Node replies with *GetIdentityInformationResponse*:

  * `Message.id == 8`
  * `Response.status == STATUS_OK`
  * `GetIdentityInformationResponse.isHosted == true`
  * `GetIdentityInformationResponse.isOnline == true`
  * `GetIdentityInformationResponse.identityPublicKey == $PublicKey`
  * `GetIdentityInformationResponse.applicationServices == ("b","c","d","e")`

Node replies with *Response*:

  * `Message.id == 9`
  * `Response.status == ERROR_NOT_FOUND`

Node replies with *GetIdentityInformationResponse*:

  * `Message.id == 10`
  * `Response.status == STATUS_OK`
  * `GetIdentityInformationResponse.isHosted == true`
  * `GetIdentityInformationResponse.isOnline == true`
  * `GetIdentityInformationResponse.identityPublicKey == $PublicKey`
  * `GetIdentityInformationResponse.applicationServices == ("b","c","d","e")`

Node replies with *Response*:

  * `Message.id == 11`
  * `Response.status == ERROR_INVALID_VALUE`
  * `Response.details == "serviceNames[1]"`

Node replies with *GetIdentityInformationResponse*:

  * `Message.id == 12`
  * `Response.status == STATUS_OK`
  * `GetIdentityInformationResponse.isHosted == true`
  * `GetIdentityInformationResponse.isOnline == true`
  * `GetIdentityInformationResponse.identityPublicKey == $PublicKey`
  * `GetIdentityInformationResponse.applicationServices == ("b","c","d","e")`

Node replies with *ApplicationServiceAddResponse*:

  * `Message.id == 13`
  * `Response.status == STATUS_OK`

Node replies with *ApplicationServiceAddResponse*:

  * `Message.id == 14`
  * `Response.status == STATUS_OK`

Node replies with *GetIdentityInformationResponse*:

  * `Message.id == 15`
  * `Response.status == STATUS_OK`
  * `GetIdentityInformationResponse.isHosted == true`
  * `GetIdentityInformationResponse.isOnline == true`
  * `GetIdentityInformationResponse.identityPublicKey == $PublicKey`
  * `GetIdentityInformationResponse.applicationServices == ("b","c","d","e","a1","a2","a3","a4,"a5","a6","a7","a8","a9","a10","b1","b2","b3","b4,"b5","b6","b7","b8","b9","b10")`

Node replies with *Response*:

  * `Message.id == 16`
  * `Response.status == ERROR_QUOTA_EXCEEDED`

Node replies with *GetIdentityInformationResponse*:

  * `Message.id == 17`
  * `Response.status == STATUS_OK`
  * `GetIdentityInformationResponse.isHosted == true`
  * `GetIdentityInformationResponse.isOnline == true`
  * `GetIdentityInformationResponse.identityPublicKey == $PublicKey`
  * `GetIdentityInformationResponse.applicationServices == ("b","c","d","e","a1","a2","a3","a4,"a5","a6","a7","a8","a9","a10","b1","b2","b3","b4,"b5","b6","b7","b8","b9","b10")`
















### HN04xxx - Node Combined Client Customer and Non-Customer Port Functionality Tests

#### HN04001 - Check-In - Different Customer and Non-Customer Ports

##### Prerequisites/Inputs

###### Prerequisites
  * Node's database is empty.
  * Node's clNonCustomer port != Node's clCustomer port

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
  
and reads the response. Then it sends *HomeNodeRequestRequest*:

  * `Message.id := 2`
  * `HomeNodeRequestRequest.contract` is uninitialized
  
and reads the response.
  
###### Step 2:
The test then closes the connection and establishes a TLS connection to the clCustomer port of the node and sends *StartConversationRequest*:

  * `Message.id := 1`
  * `StartConversationRequest.supportedVersions := [[1,0,0]]`
  * `StartConversationRequest.publicKey` set to the test's identity 32 byte long public key

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

Node replies with *HomeNodeRequestResponse*:

  * `Message.id == 2`
  * `Response.status == STATUS_OK`


###### Step 2:
Node replies with *StartConversationResponse*:

  * `Message.id == 1`
  * `Response.status == STATUS_OK`

Node replies with *CheckInResponse*:

  * `Message.id == 2`
  * `Response.status == STATUS_OK`





#### HN04002 - Check-In - Same Customer and Non-Customer Ports

##### Prerequisites/Inputs

###### Prerequisites
  * Node's database is empty.
  * Node's clNonCustomer port == Node's clCustomer port

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

Node replies with *HomeNodeRequestResponse*:

  * `Message.id == 2`
  * `Response.status == STATUS_OK`

Node replies with *CheckInResponse*:

  * `Message.id == 3`
  * `Response.status == STATUS_OK`








#### HN04003 - Check-In - Invalid Signature

##### Prerequisites/Inputs

###### Prerequisites
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
  
and reads the response. Then it sends *HomeNodeRequestRequest*:

  * `Message.id := 2`
  * `HomeNodeRequestRequest.contract` is uninitialized
  
and reads the response.
  
###### Step 2:
The test then closes the connection and establishes a TLS connection to the clCustomer port of the node and sends *StartConversationRequest*:

  * `Message.id := 1`
  * `StartConversationRequest.supportedVersions := [[1,0,0]]`
  * `StartConversationRequest.publicKey` set to the test's identity 32 byte long public key

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

Node replies with *HomeNodeRequestResponse*:

  * `Message.id == 2`
  * `Response.status == STATUS_OK`


###### Step 2:
Node replies with *StartConversationResponse*:

  * `Message.id == 1`
  * `Response.status == STATUS_OK`

Node replies with *Response*:

  * `Message.id == 2`
  * `Response.status == ERROR_INVALID_SIGNATURE`




#### HN04004 - Check-In - Invalid Challenge

##### Prerequisites/Inputs

###### Prerequisites
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
  
and reads the response. Then it sends *HomeNodeRequestRequest*:

  * `Message.id := 2`
  * `HomeNodeRequestRequest.contract` is uninitialized
  
and reads the response.
  
###### Step 2:
The test then closes the connection and establishes a TLS connection to the clCustomer port of the node and sends *StartConversationRequest*:

  * `Message.id := 1`
  * `StartConversationRequest.supportedVersions := [[1,0,0]]`
  * `StartConversationRequest.publicKey` set to the test's identity 32 byte long public key

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

Node replies with *HomeNodeRequestResponse*:

  * `Message.id == 2`
  * `Response.status == STATUS_OK`


###### Step 2:
Node replies with *StartConversationResponse*:

  * `Message.id == 1`
  * `Response.status == STATUS_OK`

Node replies with *Response*:

  * `Message.id == 2`
  * `Response.status == ERROR_INVALID_VALUE`
  * `Response.details == "challenge"`












#### HN04005 - Cancel Home Node Agreement, Register Again and Checks-In

##### Prerequisites/Inputs
###### Prerequisites:
  * Test's identity is hosted by the node

###### Inputs:
  * Node's IP address
  * Node's clNonCustomer port
  * Node's clCustomer port

##### Description 

The test cancels home node agreement for its hosted identity. It then attempts to check-in the identity, which should fail because it is no longer hosted on the node. It then establishes a new home node agreement and then it checks-in.

###### Step 1:
The test establishes a TLS connection to the clCustomer port of the node and sends *StartConversationRequest*:

  * `Message.id := 1`
  * `StartConversationRequest.supportedVersions := [[1,0,0]]`
  * `StartConversationRequest.publicKey` set to the test's identity 32 byte long public key

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


###### Step 2:
The test closes the connection and establishes a new TLS connection to the clCustomer port and sends *StartConversationRequest*:

  * `Message.id := 1`
  * `StartConversationRequest.supportedVersions := [[1,0,0]]`
  * `StartConversationRequest.publicKey` set to the test's identity 32 byte long public key

and reads the response from the node in form of *StartConversationResponse*:

  * `$Challenge := StartConversationResponse.challenge`

Then it sends *CheckInRequest*:

  * `Message.id := 2`
  * `CheckInRequest.challenge := $Challenge`
  * `ConversationRequest.signature` is set to a signature of `CheckInRequest` part of the message using the test's identity private key
  
and reads the response. 

###### Step 3:

The test establishes a TLS connection to the clNonCustomer port of the node and sends *StartConversationRequest*:

  * `Message.id := 1`
  * `StartConversationRequest.supportedVersions := [[1,0,0]]`
  * `StartConversationRequest.publicKey` set to test's 32 byte long public key
  
and reads the response. Then it sends *HomeNodeRequestRequest*:

  * `Message.id := 2`
  * `HomeNodeRequestRequest.contract` is uninitialized

and reads the response.



###### Step 4:
The test closes the connection and establishes a new TLS connection to the clCustomer port and sends *StartConversationRequest*:

  * `Message.id := 1`
  * `StartConversationRequest.supportedVersions := [[1,0,0]]`
  * `StartConversationRequest.publicKey` set to the test's identity 32 byte long public key

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

Node replies with *CheckInResponse*:

  * `Message.id == 2`
  * `Response.status == STATUS_OK`

Node replies with *CancelHomeNodeAgreementResponse*:

  * `Message.id == 3`
  * `Response.status == STATUS_OK`
  
  
###### Step 2:
Node replies with *StartConversationResponse*:

  * `Message.id == 1`
  * `Response.status == STATUS_OK`

Node replies with *Response*:

  * `Message.id == 2`
  * `Response.status == ERROR_NOT_FOUND`

###### Step 3:
Node replies with *StartConversationResponse*:

  * `Message.id == 1`
  * `Response.status == STATUS_OK`

Node replies with *HomeNodeRequestResponse*:

  * `Message.id == 2`
  * `Response.status == STATUS_OK`
  
###### Step 4:
Node replies with *StartConversationResponse*:

  * `Message.id == 1`
  * `Response.status == STATUS_OK`

Node replies with *CheckInRequest*:

  * `Message.id == 2`
  * `Response.status == STATUS_OK`









#### HN04006 - Home Node Agreement, Update Profile, Get Identity Information 

##### Prerequisites/Inputs

###### Prerequisites
  * Node's database is empty.

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
  
and reads the response. Then it sends *HomeNodeRequestRequest*:

  * `Message.id := 2`
  * `HomeNodeRequestRequest.contract` is uninitialized
  
and reads the response.
  
###### Step 2:
The test then closes the connection and establishes a TLS connection to the clCustomer port of the node and sends *StartConversationRequest*:

  * `Message.id := 1`
  * `StartConversationRequest.supportedVersions := [[1,0,0]]`
  * `StartConversationRequest.publicKey := $PublicKey`

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
  * `UpdateProfileRequest.location := 0x12345678`
  * `UpdateProfileRequest.extraData` is unintialized

and reads the response. Then it sends *GetIdentityInformationRequest*:

  * `Message.id := 4`
  * `SingleRequest.version := [1,0,0]`
  * `GetIdentityInformationRequest.identityNetworkId` is set to SHA1 of test's identity public key
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
  * `UpdateProfileRequest.image` is initialized with data loaded from HN04006.jpg file. `$ImageData := UpdateProfileRequest.image`
  * `UpdateProfileRequest.location` is unintialized
  * `UpdateProfileRequest.extraData := "a=b"` 

and reads the response. Then it sends *GetIdentityInformationRequest*:

  * `Message.id := 6`
  * `SingleRequest.version := [1,0,0]`
  * `GetIdentityInformationRequest.identityNetworkId` is set to SHA1 of test's identity public key
  * `GetIdentityInformationRequest.includeProfileImage := true`
  * `GetIdentityInformationRequest.includeThumbnailImage := true`
  * `GetIdentityInformationRequest.includeApplicationServices := false`


  
##### Acceptance Criteria


###### Step 1:
Node replies with *StartConversationResponse*:

  * `Message.id == 1`
  * `Response.status == STATUS_OK`

Node replies with *HomeNodeRequestResponse*:

  * `Message.id == 2`
  * `Response.status == STATUS_OK`


###### Step 2:
Node replies with *StartConversationResponse*:

  * `Message.id == 1`
  * `Response.status == STATUS_OK`

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
  * `GetIdentityInformationResponse.profileImage == $ImageData`
  * `GetIdentityInformationResponse.thumbnailImage` is non empty
















#### HN04007 - Update Profile - Invalid Initialization and Invalid Values

##### Prerequisites/Inputs

###### Prerequisites
  * Node's database is empty.

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
  
and reads the response. Then it sends *HomeNodeRequestRequest*:

  * `Message.id := 2`
  * `HomeNodeRequestRequest.contract` is uninitialized
  
and reads the response.
  
###### Step 2:
The test then closes the connection and establishes a TLS connection to the clCustomer port of the node and sends *StartConversationRequest*:

  * `Message.id := 1`
  * `StartConversationRequest.supportedVersions := [[1,0,0]]`
  * `StartConversationRequest.publicKey := $PublicKey`

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
  * `UpdateProfileRequest.location := 0x12345678`
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
  * `UpdateProfileRequest.location := 0x12345678`
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
  * `UpdateProfileRequest.location` is unintialized
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
  * `UpdateProfileRequest.location := 0x12345678`
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
  * `UpdateProfileRequest.location := 0x12345678`
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
  * `UpdateProfileRequest.location := 0x12345678`
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
  * `UpdateProfileRequest.location := 0x12345678`
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
  * `UpdateProfileRequest.location := 0x12345678`
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
  * `UpdateProfileRequest.image` is initialized with image data loaded from HN04007-too-big.jpg file
  * `UpdateProfileRequest.location := 0x12345678`
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
  * `UpdateProfileRequest.image` is initialized with image data loaded from HN04007-not-image.jpg file
  * `UpdateProfileRequest.location := 0x12345678`
  * `UpdateProfileRequest.extraData` is unintialized

and reads the response. Then it sends *UpdateProfileRequest*:

  * `Message.id := 13`
  * `UpdateProfileRequest.setVersion := true`
  * `UpdateProfileRequest.setName := true`
  * `UpdateProfileRequest.setImage := false`
  * `UpdateProfileRequest.setLocation := true`
  * `UpdateProfileRequest.setExtraData := false`
  * `UpdateProfileRequest.version := [1,0,0]`
  * `UpdateProfileRequest.name := "Test Identity"`
  * `UpdateProfileRequest.image` is uninitialized
  * `UpdateProfileRequest.location := 0x12345678`
  * `UpdateProfileRequest.extraData` is set to string containing 300x 'a'

and reads the response. Then it sends *UpdateProfileRequest*:

  * `Message.id := 14`
  * `UpdateProfileRequest.setVersion := true`
  * `UpdateProfileRequest.setName := true`
  * `UpdateProfileRequest.setImage := false`
  * `UpdateProfileRequest.setLocation := true`
  * `UpdateProfileRequest.setExtraData := false`
  * `UpdateProfileRequest.version := [1,0,0]`
  * `UpdateProfileRequest.name := "Test Identity"`
  * `UpdateProfileRequest.image` is uninitialized
  * `UpdateProfileRequest.location := 0x12345678`
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
  * `UpdateProfileRequest.location := 0x12345678`
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
  * `UpdateProfileRequest.location` is uninitialized
  * `UpdateProfileRequest.extraData` is uninitialized

and reads the response.

  
##### Acceptance Criteria


###### Step 1:
Node replies with *StartConversationResponse*:

  * `Message.id == 1`
  * `Response.status == STATUS_OK`

Node replies with *HomeNodeRequestResponse*:

  * `Message.id == 2`
  * `Response.status == STATUS_OK`


###### Step 2:
Node replies with *StartConversationResponse*:

  * `Message.id == 1`
  * `Response.status == STATUS_OK`

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









#### HN04008 - Verify Identity, Update Profile - Unauthorized

##### Prerequisites/Inputs
###### Prerequisites:
  * Test's identity is hosted by the node
  * Node's clNonCustomer port == clCustomer port

###### Inputs:
  * Node's IP address
  * Node's clNonCustomer/clCustomer port

##### Description 

The test verifies its identity on clNonCustomer/clCustomer port. Then it attempts to update its profile, which requires Authenticated status.


###### Step 1:
The test establishes a TLS connection to the clNonCustomer port of the node and sends *StartConversationRequest*:

  * `Message.id := 1`
  * `StartConversationRequest.supportedVersions := [[1,0,0]]`
  * `StartConversationRequest.publicKey` set to the test's identity 32 byte long public key

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
  * `UpdateProfileRequest.location := 0x12345678`
  * `UpdateProfileRequest.extraData` is unintialized

and reads the response.


##### Acceptance Criteria


###### Step 1:
Node replies with *StartConversationResponse*:

  * `Message.id == 1`
  * `Response.status == STATUS_OK`

Node replies with *VerifyIdentityResponse*:

  * `Message.id == 2`
  * `Response.status == STATUS_OK`

Node replies with *Response*:

  * `Message.id == 3`
  * `Response.status == ERROR_UNAUTHORIZED`




