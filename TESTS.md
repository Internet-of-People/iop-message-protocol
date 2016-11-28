# Testing IoP Message Protocol

In order to create a software that is compatible with IoP Message Protocol specification, we define the set of tests that the software must pass. If a software passes the given set of tests, it might be compatible with the protocol. If it does not pass all the tests, it is not compatible.

## Notation

  * `[X,Y,Z]` is an ordered array of three elements X, Y, and Z. Thus `[X,Y,Z] != [Y,Z,X]`.
  * `(X,Y,Z)` is a set of of three elements X, Y, and Z. Thus `(X,Y,Z) == (Y,Z,X)`.


## HomeNet Profile Server Tests

The tests in this section are intended for testing of IoP HomeNet Profile Server software. 

  * [HN00xxx - General Protocol Tests](./tests/HN00.md)
  * [HN01xxx - Node Primary Port Functionality Tests](./tests/HN01.md)
  * [HN02xxx - Node Client Non-Customer Port Functionality Tests](./tests/HN02.md)
  * [HN03xxx - Node Client Customer Port Functionality Tests](./tests/HN03.md)
  * [HN04xxx - Node Combined Client Customer and Non-Customer Port Functionality Tests](./tests/HN04.md)
  * [HN05xxx - Application Service Calls Related Functionality Tests](./tests/HN05.md)
  * [HN06xxx - Profile Search Related Functionality Tests](./tests/HN06.md)
  * [HN07xxx - Related Identities Related Functionality Tests](./tests/HN07.md)

