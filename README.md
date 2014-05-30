# DPlugin

### Author: Thibaut CHARLES (CromFr)

Precompiled plugin system written in D


# Features

Loads .so files at runtime and provides utilities to:
- Call functions
- Bind with an interface and:
	- Check if all methods are instanciated
	- Directly call methods on plugin via opDispatch


# Limitations
### Plugin

- Call to polymorph functions
- Default function arguments are not handled, and must be filled

### InterfacePlugin

- Direct call to non void methods
- Access to the members of the iface