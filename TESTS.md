# Testing IoP Message Protocol

In order to create a software that is compatible with IoP Message Protocol specification, we define the set of tests that the software must pass. If a software passes the given set of tests, it might be compatible with the protocol. If it does not pass all the tests, it is not compatible.


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


##### Acceptance Criteria

###### Step 1:

Node disconnects the test and the attempt to send *PingRequest* fails.



#### HN00004 - Disconnection of Inactive TCP Client from Primary Port - Incomplete Header

##### Prerequisites/Inputs

Inputs:
  * Node's IP address
  * Node's primary port

##### Description 

The test sends incomplete message header to the node and waits. This should be detected as an inactive connection by the node after a while. 

###### Step 1:

The test connects to the primary port of the node and creates the following *PingRequest*:

  * `Message.id := 1`
  * `SingleRequest.version := [1,0,0]`
  * `PingRequest.payload = "test"`

but it only sends first 4 bytes of this message to the node and then it waits 500 seconds. Then it attempts to send the rest of the message.


##### Acceptance Criteria

###### Step 1:

Node disconnects the test and this prevents the test to send the second part of the message.




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

but it only sends first 6 bytes of this message to the node and then it waits 500 seconds. Then it attempts to send the rest of the message.


##### Acceptance Criteria

###### Step 1:

Node disconnects the test and this prevents the test to send the second part of the message.



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



##### Acceptance Criteria

###### Step 1:

Node disconnects the test before it sends the message and the test will thus not be able to send the message.



#### HN00007 - Disconnection of Inactive TCP Client from Non-Customer Port - Incomplete Header

##### Prerequisites/Inputs

Inputs:
  * Node's IP address
  * Node's clNonCustomer port

##### Description 

The test sends incomplete message header to the node and waits. This should be detected as an inactive connection by the node after a while.

###### Step 1:
The test creates a TLS connection to the clNonCustomer port of the node and creates the following *PingRequest*:

  * `Message.id := 1`
  * `SingleRequest.version := [1,0,0]`
  * `PingRequest.payload = "test"`

but it only sends first 4 bytes of this message to the node and then it waits 180 seconds. Then it attempts to send the rest of the message.


##### Acceptance Criteria

###### Step 1:

Node disconnects the test and this prevents the test to send the second part of the message.




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

but it only sends first 6 bytes of this message to the node and then it waits 180 seconds. Then it attempts to send the rest of the message.

##### Acceptance Criteria

###### Step 1:

Node disconnects the test and this prevents the test to send the second part of the message.






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

and reads the response.


##### Acceptance Criteria

###### Step 1:

Node replies with *Response*:
  
  * `Response.status == ERROR_PROTOCOL_VIOLATION`

and then the node closes the connection.







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

and reads the response.

##### Acceptance Criteria

###### Step 1:
Node replies with *Response*:
  
  * `Message.id == 1`
  * `Response.status == ERROR_PROTOCOL_VIOLATION`

and then the node closes the connection.



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

and reads the response.


##### Acceptance Criteria

###### Step 1:
Node replies with *Response*:
  
  * `Message.id == 1`
  * `Response.status == ERROR_PROTOCOL_VIOLATION`

and then the node closes the connection.


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
  * `StartConversationResponse.challenge == [1,0,0]`



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
  * `StartConversationResponse.publicKey` is 32 byte long
  * `StartConversationResponse.challenge` is 32 byte long

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




#### HN02013 - Check-In - Bad Role

##### Prerequisites/Inputs

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










#### HN03006 - Parallel Check-Ins

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

Using the first connection the test attempts to send *PingRequest*.




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

Node replies with *CheckInResponse*:

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










