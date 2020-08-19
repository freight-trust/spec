# Freight Trust Network

- [Freight Trust Network](#freight-trust-network)
- [Abstract](#abstract)
  * [Network Overview](#network-overview)
  * [EDI Messages](#edi-messages)
  * [Nodes](#nodes)
    + [Network Nodes](#network-nodes)
    + [Concensus Nodes](#concensus-nodes)
  * [Protocol](#protocol)
    + [Genesis State](#genesis-state)
  * [Businessess](#businessess)
    + [Exposed Instrument Interfaces](#exposed-instrument-interfaces)
- [Burgess](#burgess)
  * [Abstract](#abstract-1)
    + [Unit Concepts](#unit-concepts)
  * [Blocks as `units of agreement`](#blocks-as--units-of-agreement-)
    + [Facts](#facts)
    + [Rules](#rules)
  * [Primitives](#primitives)
    + [ExecutionPrimitive](#executionprimitive)
    + [ContractFormationPrimitive](#contractformationprimitive)
    + [AllocationPrimitive](#allocationprimitive)
    + [Primitive Example](#primitive-example)
    + [ExercisePrimitive](#exerciseprimitive)
    + [Inception Primitive](#inception-primitive)
    + [Obervation Primitive](#obervation-primitive)
    + [Quantity Change Primitive](#quantity-change-primitive)
    + [Reset  Primitive](#reset--primitive)
    + [Terms Change Primitive](#terms-change-primitive)
    + [Transfer Primitive](#transfer-primitive)
  * [Workflow for Contractual Product (e.g. Forward Contracts)](#workflow-for-contractual-product--eg-forward-contracts-)
  * [Solidity Contract Specification](#solidity-contract-specification)
  * [Rulebook](#rulebook)
  * [Further Documentation](#further-documentation)
  * [License](#license)


# Abstract

Business A and Business B have a `transaction`, in this example the transaction
is a shippment of freight. This diagram shows at a high level how we facilitate
these business `transactions` in a distributed, fault tolerant network utilziing
hyperledger besu. Censorship resistance and high availability are some of the
more important aspects of utilizing a blockchain network, in addition to
providing for a provably electronically unique piece of data (i.e. this is why
cryptocurrencies work in the first place).

![](images/high-level.png)

## Network Overview

![](images/ft-network-besu.png)

## EDI Messages

> Note EDI Messages are NOT $EDI Tokens. $EDI Tokens represent the unit of
> account for Units of Agreement and Units of Execution (i.e. think of it just
> as you would think of gwei for ethereum, a fixed unit of cost per byte for
> transacting on the network.)

Charging on a `per byte` basis has been and continutes to be the basis of all
transactional cost models especially EDI and XML messages which provide an
incentive for users not to spam the network with unnecessarily large messages.

![](images/EDI_Components.png)

## Nodes

There are 5 different classes of nodes, with 2 groups.

- Network Nodes
- Concensus Nodes

### Network Nodes

![](images/besu-redis-componets.png)

Besu-tx: Handling of local transaction pool.

Besu-sync: Handling of blockchain synchronisation through Ethereum P2P network.

Besu-query: Handling of database queries.

![](images/network-component-besu.png)

### Concensus Nodes

Sealer

In general concept terms, a Sealer adds its testimony (assertion of
authentication assessment) and proof of custody to the chain of custody.

Validator

In general concept terms, a Validator inspects the chain of custody to determine
the content and validity of individual evidence supplied by custodians.

## Protocol

> Protocol Interface

![](images/protocol.png)




### Genesis State 

Calculations for determining the optimal configuration were done as follows:

| **key**                                    | **value**    |
|--------------------------------------------|--------------|
| block                                      | 1            |
| seconds                                    | 10           |
| seconds/day                                | 86400        |
| blocks/day                                 | 8640         |
| days/year                                  | 365\.2425    |
| seconds/year                               | 31556952     |
| blocks/year                                | 3155695\.2   |
| GxdataZero                                 | 4            |
| GxdataNonZero                              | 68           |
| GxminTransaction                           | 21000        |
| gas limit per block \(decimal\)            | 10485760     |
| block gas limit                            | 0xa00000     |
| EDI X12 4010 Transaction Size \(in bytes\) | 1,136        |
| EDI X12 4010 Transaction Cost \(in gwei\)  | 4544         |
| Network Size per Year, bytes               | 0            |
| Network Size per Year, gigabytes           | 486\.615625  |
| Gwei/Gas limit per block \(decimal\)       | 10485760     |
| EDI X12 4010 Transaction Sets, throughput  | 135\.7415079 |
| EDI X12 Transactions Per Block             | 135\.7415079 |
| Total Upper Floating Supply                | 428358824\.8 |

## Businessess

> List of Trading Partners & Orginizations recognized on the Platform

```json
[
	"SELLER",
	"BUYER",
	"EXPORTER",
	"IMPORTER",
	"CONSIGNOR",
	"CONSIGNEE",
	"TRANSPORT_SERVICE_BUYER",
	"ORIGIN_3PL",
	"DESTINATION_3PL",
	"EXPORT_CUSTOMS_BROKER",
	"IMPORT_CUSTOMS_BROKER",
	"BUYERS_BANK",
	"SELLERS_BANK",
	"INSURANCE_PROVIDER",
	"OCEAN_CARRIER",
	"TRANSPORT_SERVICE_INTERMEDIARY",
	"RAIL_OPERATOR",
	"TRUCK_OPERATOR",
	"BARGE_OPERATOR",
	"FEEDER",
	"ORIGIN_MARINE_TERMINAL",
	"DESTINATION_MARINE_TERMINAL",
	"TRANSSHIPMENT_TERMINAL",
	"INLAND_TERMINAL",
	"DATA_AGGREGATOR",
	"EXPORT_AUTHORITY",
	"IMPORT_AUTHORITY"
]
```
### Exposed Instrument Interfaces

EDI Messages that are used to create `smart contracts` are done so by our [protocol specification](https://github.com/freight-trust/protocol/commit/d912a26bc18141db166c4559d98204c3303f6aac)

The ASC X12 4010 856 Transaction set is provided here as a reference UML image for perspective of potential data elements that it defines

![](https://www.dropbox.com/s/5rokohmvaighcvl/X12_UML.png)

[dropbox link for 856 X12 UML image](https://www.dropbox.com/s/5rokohmvaighcvl/X12_UML.png)

We have identified basic primitives that are constituent 

For Example, as a Financial Institution that would want to `verify` a `bill of lading`a High Level API is offered along with a low level application binary interface (ABI). 

<img src="https://raw.githubusercontent.com/freight-trust/protocol/master/ROOT/x12.png" width=700>

```json
{
  "type": "object",
  "properties": {
    "PRO": {
      "type": "string",
      "minimum": 0,
      "maximum": 30,
      "pattern": "gs1_spec"
    },
    "SCAC": {
      "type": "string",
      "maximum": null,
      "maxLength": 5
    },
    "AgreementTerms": {
      "format": "uri",
      "type": "string",
      "description": "pki",
      "enum": ["notify", "notifyAll", "getClass", "finalize"]
    },
    "GoverningLaw": {
      "enum": ["MASTER_AGREEMENT", "USCA", "USDE", "USIL", "USNY", "OTHER"],
      "type": "string"
    },
    "Cosignee": {
      "uniqueItems": null,
      "type": "string",
      "title": "Freight_Charges_Bill_To"
    },
    "CheckSum": {
      "properties": null,
      "type": "string",
      "format": "uri",
      "pattern": "BL-nnnnn-s"
    },
    "3rdParty": {
      "type": "string",
      "items": {
        "enum": null,
        "description": "Insurance"
      },
      "description": "insurance"
    },
    "BillOfLading": {
      "type": "number",
      "minimum": 16,
      "additionalProperties": {
        "format": null,
        "type": "object",
        "required": ["checksum_digit"]
      }
    }
  }
}
```



# Burgess


## Abstract
We introduce a new specification for smart contract integration that requires only a certificate to enable transactions with a certificate issued by an authorized operator. We provide a list of primitives so that smart contract mechanics can be formalized (to an extent) in relations to legal mechanics in order to replicate a "de facto" contracting system (i.e. jursidictional regimes) within the context of blockchain based smart contracts. 


We want to make smart contracts legal in the sense that the replicate all the exact workings of existing legal contracts (i.e. paper based legal contracts). We call these "primitives". 

You can read this article here detailing the concept
[Applications of traditional contract principles to Smart Contracts](https://medium.com/freighttrust/application-of-traditional-contract-principles-to-smart-contracts-64cad84091bf)

We then enable existing EDI transactions the ability to interact (i.e. create, move, delegate, transfer, etc) with these smart contracts, removing the issues of "legality and legal bindingness" of using a smart contract protocol versus traditional paper based documents, removing the need for "hash stored" protocol implematation [see protocolv1](https://github.com/freight-chain/protocol)

### Unit Concepts

- Units of Execution
- Units of Agreement
- Units of Afferent
- Units of Efferent
- Units of Lexigram

* Controlled Natural Language = Jurisdictional Grammar (see
  [Burgess](https://github.com/freight-trust/burgess) )
* Afferent = Towards
* Efferent = Away

## Blocks as `units of agreement`

A couple of specific block linkages are stated as facts. Two general principles
of block chaining based on such linkages are stated as "conclusion if condition"
rules.

> (The diagrams' color coding is extended to the symbolic form by using green
> for facts and their rule-condition counterparts while using red for rule
> conclusions and the recursive rule-condition counterpart.)

### Facts

- "Block1 links to Block2."
- "Block2 links to Block3."

### Rules

- "x chains to y if x links to y."
- "x chains to z if x links to y and y chains to z."

Facts are _primitives_ (i.e. not containing variables) that apply a `predicate`
to `arguments`

to Block1 followed by Block2 and to Block2 followed by Block3

Rules are of the form `conclusion :- condition` (i.e. containing variables),
with the Prolog-like (symbol) infix `":-"` corresponding to the above "if".

This constitutes the extent of which RuleML is applied to the `TradeDocs`
system, a basic primitive set for `rule-conditions`



## Primitives

Defined ordered list 

`PrimitiveEvent`
`ExercisePrimitive`
`AllocationPrimitive`
`ContractFormationPrimitive`
`ExecutionPrimitive`
`InceptionPrimitive`
`ObservationPrimitive`
`QuantityChangePrimitive`
`ResetPrimitive`
`TermsChangePrimitive`
`TransferPrimitive`


### ExecutionPrimitive

Specification of the primitive event for an execution, with 'after' state being an ExecutionState and the 'before' state being Null.

The 'before' ExecutionState (0..0) The 0 cardinality reflects the fact that there is no execution in the before state of an execution primitive. Think of this as the "genesis" point.

after `ExecutionState`

The after state corresponds to the execution between the parties. In the case of an execution on a contractual product, some additional characteristics may need to be specified to get a fully-formed contract, for instance when the executing party acts as an agent, as is the case in an allocation scenario. This is the purpose of the `ContractFormation` primitive event.


### ContractFormationPrimitive

> **@dev** this design pattern is differnet in that it does not bundle together execution of the contract and formation of the contract, similar to the way a `proxy` contract works. The design pattern for this is to better provide for atomic primitites. Our pruposes do not need such atomiticy, as they are contractual products.


`ExecutionPrimitive` + `ContractFormationPrimitive` = atomic financial primitive

`InceptionPrimitive` = contractual product primitive [see jEDI contract below]


Specification of the primitive event for the formation of a contract, with 'before' state being an 'ExecutionState' and 'after' state being a 'PostInceptionState'.


### AllocationPrimitive
The primitive event to represent a split/allocation of a trade. As part of this primitive event the type of trade, either an execution or a contract, does not get altered. In the case of an execution, the further transformation of each split execution into a contract will be the purpose of the ContractFormation primitive.

### Primitive Example

```markdown
if AllocationPrimitive exists and before -> execution exists
	then after -> originalTrade -> execution exists
	and after -> allocatedTrade -> execution exists
	and after -> allocatedTrade -> contract is absent
	
condition ContractType: 
if AllocationPrimitive exists and before -> contract exists
	then after -> originalTrade -> contract exists
	and after -> allocatedTrade -> contract exists
	and after -> allocatedTrade -> execution is absent
```

### ExercisePrimitive

`exerciseTiming` which is deemed as associated to a request for exercise that is meant to take place, as opposed to the actual exercise event. Similar to how in FpML an OptionExercise is constructed. [FpML 5.5](https://www.fpml.org/spec/fpml-5-6-5-rec-1/html/confirmation/fpml-5-6-intro-8.html)


### Inception Primitive
The primitive event for the inception of a new contract between parties. 

### Obervation Primitive 
A class to specify the primitive object to specify market observation events, which is applicable across all asset classes.

### Quantity Change Primitive 
The primitive event to represent a change in quantity or notional.

### Reset  Primitive
The primitive event to represent a reset.

### Terms Change Primitive
The primitive event to represent change(s) to the contractual terms and the clearing submission and acceptance process.

### Transfer Primitive 
A class to specify the transfer of assets between parties, those assets being either cash, securities or physical assets (such as freight or an asset held by a bailee relationship such as warehouse receipts). This class combines components that are cross-assets (settlement date, settlement type, status, ...) and some other which are specialized by asset class (e.g. the payer/receiver amount and cashflow type for a cash transfer, the transferor/transferee, security indication, quantity, and asset transfer type qualification for the case of a security).


## Workflow for Contractual Product (e.g. Forward Contracts)

```javascript
if WorkflowStep -> businessEvent -> primitives -> inception -> after -> contract only exists
	then WorkflowStep -> businessEvent -> primitives -> inception -> after -> contract

else if WorkflowStep -> businessEvent -> primitives -> quantityChange -> after -> contract  exists
		
	then WorkflowStep -> businessEvent -> primitives -> quantityChange -> after -> contract
	else WorkflowStep -> businessEvent -> primitives -> inception -> after -> contract
 	as "Contract"
```


## Solidity Contract Specification
[version 1.4, 2020.05.01](https://github.com/freight-trust/jedi)


> This has not gone through auditing but is working

> Instruments generally are capable with ERC, but not exactly
> Primitves resemble partitioned semi-fungible token implementations 

```javascript=

/// @title EDI based Transactions using Solidity
/// @license this is BSD-3 Clause
/// @author FreightTrust and Clearing Corporation All Rights Reserved
// @version 1.4.0
/// @dev jEDI stands for "jointed" edi transactions, through our parser we are able to do this, code is for public ref. 

interface jEDI { 


function getEDI(bytes32 _name) external view returns (string, bytes32, uint256);

function setEDI(bytes32 _name, string _uri, bytes32 _EDIHash) external;

function amendEDI(bytes32 _name) external;

function getAllEDITransactions() view returns (bytes32[]);

/// emit events based upon EDI transactions 

event EDITransaction(bytes32 indexed _name, string _uri, bytes32 _ediHash);
event EDIUpdated(bytes32 indexed _name, string _uri, bytes32 _ediHash);
event EDIAmended(bytes32 indexed _name, string _uri, bytes32 _ediHash);

/// control contracts using EDI spec. 

function transferWithEDI(address _to, uint256 _value, bytes _data) external;
function transferFromWithEDI(address _from, address _to, uint256 _value, bytes _data) external;


/// EDI Events

event EDITransaction(bytes32 indexed _name, string _uri, bytes32 _ediHash);
event EDIUpdated(bytes32 indexed _name, string _uri, bytes32 _ediHash);
event EDIAmended(bytes32 indexed _name, string _uri, bytes32 _ediHash);

function transferWithEDI(address _to, uint256 _value, bytes _data) external;
function transferFromWithEDI(address _from, address _to, uint256 _value, bytes _data) external;

/// Instrument for the most part is interchangeable with ERC-20 fungability in concept
/// function transferByInstrument(bytes32 _instrument, address _to, uint256 _value, bytes _data) external returns (bytes32);

function transferWithEDI(address _to, uint256 _value, bytes _data) external;
function transferFromWithEDI(address _from, address _to, uint256 _value, bytes _data) external;

}
```



## Rulebook

[see full omnibus](https://ft-docs.netlify.app)

## Further Documentation

[see full omnibus](https://ft-docs.netlify.app)

## License

Mozilla Public License 2.0
