# Testing IoP Message Protocol

In order to create a software that is compatible with IoP Message Protocol specification, we define the set of tests that the software must pass. 
If a software passes the given set of tests, it might be compatible with the protocol. If it does not pass all the tests, it is not compatible.

## Notation

  * `[X,Y,Z]` is an ordered array of three elements X, Y, and Z. Thus `[X,Y,Z] != [Y,Z,X]`.
  * `(X,Y,Z)` is a set of of three elements X, Y, and Z. Thus `(X,Y,Z) == (Y,Z,X)`.


## Profile Server Tests

The tests in this section are intended for testing of IoP Profile Server software. 

  * [PS00xxx - General Protocol Tests](./tests/PS00.md)
  * [PS01xxx - Primary Port Functionality Tests](./tests/PS01.md)
  * [PS02xxx - Client Non-Customer Port Functionality Tests](./tests/PS02.md)
  * [PS03xxx - Client Customer Port Functionality Tests](./tests/PS03.md)
  * [PS04xxx - Combined Client Customer and Non-Customer Port Functionality Tests](./tests/PS04.md)
  * [PS05xxx - Application Service Calls Related Functionality Tests](./tests/PS05.md)
  * [PS06xxx - Profile Search Related Functionality Tests](./tests/PS06.md)
  * [PS07xxx - Related Identities Related Functionality Tests](./tests/PS07.md)
  * [PS08xxx - Neighborhood Related Functionality Tests](./tests/PS08.md)

