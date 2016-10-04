# Testing IoP Message Protocol

In order to create a software that is compatible with IoP Message Protocol specification, we define the set of tests that the software must pass. If a software passes the given set of tests, it might be compatible with the protocol. If it does not pass all the tests, it is not compatible.

## HomeNet Node Tests

The tests in this section are intended for testing of IoP HomeNet Node software. 

### HN00001 - Primary Port Ping Test

#### Description 

The test connects to the primary port of the node and sends *PingRequest*:

  * `SingleRequest.version := [1,0,0]`
  * `PingRequest.payload := "Hello"`

#### Acceptance Criteria

Node replies with *PingResponse*:
  
  * `Response.status == STATUS_OK`
  * `PingResponse.payload == "Hello"`
  * `PingResponse.clock` does not differ more than 10 minutes from the test's machine clock.
