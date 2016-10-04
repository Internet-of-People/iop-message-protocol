# Testing IoP Message Protocol

In order to create a software that is compatible with IoP Message Protocol specification, we define the set of tests that the software must pass. If a software passes the given set of tests, it might be compatible with the protocol. If it does not pass all the tests, it is not compatible.

## HomeNet Node Tests

The tests in this section are intended for testing of IoP HomeNet Node software. 

### HN00001 - Invalid Message Header 

#### Prerequisites/Inputs

Inputs:
  * Node's IP address
  * Node's primary port

#### Description 

The test connects to the primary port of the node ands sends binary data:

`46 84 21 46 87`


#### Acceptance Criteria

Node replies with *Response*:

  * `Response.status == ERROR_PROTOCOL_VIOLATION`
  
  
### HN00002 - Invalid Message Body

#### Prerequisites/Inputs

Inputs:
  * Node's IP address
  * Node's primary port

#### Description 

The test connects to the primary port of the node and sends binary data:

`0D 04 00 00 00 FF FF FF FF`


#### Acceptance Criteria

Node replies with *Response*:

  * `Response.status == ERROR_PROTOCOL_VIOLATION`  




  
### HN00003 - Disconnection of Inactive TCP Client from Primary Port 1

#### Prerequisites/Inputs

Inputs:
  * Node's IP address
  * Node's primary port

#### Description 

The test connects to the primary port of the node and waits 500 seconds. This should be detected as an inactive connection by the node.


#### Acceptance Criteria

Node disconnects the test before the wait finishes.



### HN00004 - Disconnection of Inactive TCP Client from Primary Port 2

#### Prerequisites/Inputs

Inputs:
  * Node's IP address
  * Node's primary port

#### Description 

The test connects to the primary port and sends binary data:

`0D 04 00 00` 

then it waits 500 seconds. This should be detected as an inactive connection by the node as the client did not sent a whole message header.


#### Acceptance Criteria

Node disconnects the test before the wait finishes. 




### HN00005 - Disconnection of Inactive TCP Client from Primary Port 3

#### Prerequisites/Inputs

Inputs:
  * Node's IP address
  * Node's primary port

#### Description 

The test connects to the primary port and sends binary data:

`0D 04 00 00 00 FF` 

then it waits 500 seconds. This should be detected as an inactive connection by the node as the client did not sent a whole message body.


#### Acceptance Criteria

Node disconnects the test before the wait finishes. 



### HN00101 - Primary Port Ping

#### Prerequisites/Inputs

Inputs:
  * Node's IP address
  * Node's primary port

#### Description 

The test connects to the primary port of the node and sends *PingRequest*:

  * `SingleRequest.version := 1,0,0`
  * `PingRequest.payload := "Hello"`

#### Acceptance Criteria

Node replies with *PingResponse*:
  
  * `Response.status == STATUS_OK`
  * `PingResponse.payload == "Hello"`
  * `PingResponse.clock` does not differ more than 10 minutes from the test's machine clock.
