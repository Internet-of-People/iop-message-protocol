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

The test connects to the primary port of the node ands sends binary data:

`46 84 21 46 87`


##### Acceptance Criteria

Node replies with *Response*:

  * `Response.status == ERROR_PROTOCOL_VIOLATION`
  
  
#### HN00002 - Invalid Message Body

##### Prerequisites/Inputs

###### Inputs:

  * Node's IP address
  * Node's primary port

##### Description 

The test connects to the primary port of the node and sends binary data:

`0D 04 00 00 00 FF FF FF FF`


##### Acceptance Criteria

Node replies with *Response*:

  * `Response.status == ERROR_PROTOCOL_VIOLATION`  


  
#### HN00003 - Disconnection of Inactive TCP Client from Primary Port - No Message

##### Prerequisites/Inputs

###### Inputs:

  * Node's IP address
  * Node's primary port

##### Description 

The test connects to the primary port of the node and waits 500 seconds. This should be detected as an inactive connection by the node.


##### Acceptance Criteria

Node disconnects the test before the wait finishes.



#### HN00004 - Disconnection of Inactive TCP Client from Primary Port - Incomplete Header

##### Prerequisites/Inputs

Inputs:
  * Node's IP address
  * Node's primary port

##### Description 

The test connects to the primary port and sends binary data:

`0D 04 00 00` 

then it waits 500 seconds. This should be detected as an inactive connection by the node as the client did not sent a whole message header.


##### Acceptance Criteria

Node disconnects the test before the wait finishes. 




#### HN00005 - Disconnection of Inactive TCP Client from Primary Port - Incomplete Message

##### Prerequisites/Inputs

###### Inputs:
  * Node's IP address
  * Node's primary port

##### Description 

The test connects to the primary port and sends binary data:

`0D 04 00 00 00 FF` 

then it waits 500 seconds. This should be detected as an inactive connection by the node as the client did not sent a whole message body.


##### Acceptance Criteria

Node disconnects the test before the wait finishes. 



#### HN00006 - Disconnection of Inactive TCP Client from Non-Customer Port - No Message

##### Prerequisites/Inputs

###### Inputs:

  * Node's IP address
  * Node's clNonCustomer port

##### Description 

The test creates a TLS connection to the clNonCustomer port of the node and waits 180 seconds. This should be detected as an inactive connection by the node.


##### Acceptance Criteria

Node disconnects the test before the wait finishes.



#### HN00007 - Disconnection of Inactive TCP Client from Non-Customer Port - Incomplete Header

##### Prerequisites/Inputs

Inputs:
  * Node's IP address
  * Node's clNonCustomer port

##### Description 

The test creates a TLS connection to the clNonCustomer port of the node and sends binary data:

`0D 04 00 00` 

then it waits 180 seconds. This should be detected as an inactive connection by the node as the client did not sent a whole message header.


##### Acceptance Criteria

Node disconnects the test before the wait finishes. 




#### HN00008 - Disconnection of Inactive TCP Client from Non-Customer Port - Incomplete Message

##### Prerequisites/Inputs

###### Inputs:
  * Node's IP address
  * Node's clNonCustomer port

##### Description 

The test creates a TLS connection to the clNonCustomer port of the node and sends binary data:

`0D 04 00 00 00 FF` 

then it waits 180 seconds. This should be detected as an inactive connection by the node as the client did not sent a whole message body.

##### Acceptance Criteria

Node disconnects the test before the wait finishes. 






#### HN00009 - Disconnection of Inactive TCP Client from Non-Customer Port - No TLS Handshake

##### Prerequisites/Inputs

###### Inputs:
  * Node's IP address
  * Node's clNonCustomer port

##### Description 

The test creates a TCP connection to the clNonCustomer port and does not initiate TLS handshake. Then it waits 180 seconds. This should be detected as an inactive connection by the node as the client did not sent a whole message body.

##### Acceptance Criteria

Node disconnects the test before the wait finishes. 





#### HN00010 - Message Too Large

##### Prerequisites/Inputs

###### Inputs:
  * Node's IP address
  * Node's primary port

##### Description 

The test connects to the primary port and sends *PingRequest*:

  * `Message.id := 1234`
  * `SingleRequest.version := [1,0,0]`
  * `PingRequest.payload` is set to a sequence of 1,048,576 times 'a'

Size of this message is greater than the protocol's maximal message size limit of 1 MB.

##### Acceptance Criteria

Node replies with *Response*:
  
  * `Message.id == 1`
  * `Response.status == ERROR_PROTOCOL_VIOLATION`



### HN01xxx - Node Primary Port Functionality Tests

#### HN01001 - Primary Port Ping

##### Prerequisites/Inputs

###### Inputs:
  * Node's IP address
  * Node's primary port

##### Description 

The test connects to the primary port of the node and sends *PingRequest*:

  * `Message.id := 1234`
  * `SingleRequest.version := [1,0,0]`
  * `PingRequest.payload := "Hello"`

##### Acceptance Criteria

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

The test connects to the primary port of the node and sends *PingRequest*:

  * `Message.id := 1`
  * `SingleRequest.version := [1,0]`
  * `PingRequest.payload := "Hello"`

The version must be 3 bytes long, but the client sends 2 bytes only.

##### Acceptance Criteria

Node replies with *Response*:
  
  * `Message.id == 1`
  * `Response.status == ERROR_PROTOCOL_VIOLATION`



#### HN01003 - Primary Port Ping - Invalid Version Value

##### Prerequisites/Inputs

###### Inputs:
  * Node's IP address
  * Node's primary port

##### Description 

The test connects to the primary port of the node and sends *PingRequest*:

  * `Message.id := 1`
  * `SingleRequest.version := [0,0,0]`
  * `PingRequest.payload := "Hello"`

Version 0.0.0 is not a valid version.


##### Acceptance Criteria

Node replies with *Response*:
  
  * `Message.id == 1`
  * `Response.status == ERROR_PROTOCOL_VIOLATION`



#### HN01004 - List Roles

##### Prerequisites/Inputs

###### Inputs:
  * Node's IP address
  * Node's primary port

##### Description 

The test connects to the primary port of the node and sends *ListRolesRequest*:

  * `Message.id := 1`
  * `SingleRequest.version := [1,0,0]`  

##### Acceptance Criteria

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



### HN02xxx - Node Client Non-Customer Port Functionality Tests

#### HN02001 - Client Non-Customer Port Ping

##### Prerequisites/Inputs

###### Inputs:
  * Node's IP address
  * Node's clNonCustomer port

##### Description 

The test establishes a TLS connection to the clNonCustomer port of the node and sends *PingRequest*:

  * `Message.id := 1`
  * `SingleRequest.version := [1,0,0]`
  * `PingRequest.payload := "Hello"`

##### Acceptance Criteria

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

The test establishes a TLS connection to the clNonCustomer port of the node and sends *ListRolesRequest*:

  * `Message.id := 1`
  * `SingleRequest.version := [1,0,0]`  
  
List Roles request requires primary port to be used.

##### Acceptance Criteria

Node replies with *Response*:
  
  * `Message.id == 1`
  * `Response.status == ERROR_BAD_ROLE`



#### HN02003 - Start Conversation 

##### Prerequisites/Inputs

###### Inputs:
  * Node's IP address
  * Node's clNonCustomer port

##### Description 

The test establishes a TLS connection to the clNonCustomer port of the node and sends *StartConversationRequest*:

  * `Message.id := 1`
  * `StartConversationRequest.supportedVersions := [[1,0,0]]`
  * `StartConversationRequest.publicKey` set to test's 32 byte long public key
  
##### Acceptance Criteria

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

The test establishes a TLS connection to the clNonCustomer port of the node and sends *StartConversationRequest*:

  * `Message.id := 1`
  * `StartConversationRequest.supportedVersions := [[255,255,255], [255,255,254]]`
  * `StartConversationRequest.publicKey` set to test's 32 byte long public key
  
##### Acceptance Criteria

Node replies with *Response*:
  
  * `Message.id == 1`
  * `Response.status == ERROR_UNSUPPORTED`
