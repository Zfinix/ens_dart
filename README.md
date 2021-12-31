# ⚡️ ENS Dart

A dart library that wraps the Ethereum Name Service.

The Ethereum Name Service is analogous to the Domain Name Service. It enables users and developers to use human-friendly names in place of error-prone hexadecimal addresses, content hashes, and more.

- Interop with `web3dart` package
- Get ENS name from ETH address
- Get address from ENS name
- Get contentHash
- Get textRecord
- Call functions on ENS smart contracts and listen for contract events

## Usage

### Get ENS name and address

ENS Dart provides an interface to look up an address from a name, the reverse, and more.

```dart
Future<void> main() async {
  env.load('../.env');
  final infuraKey = env.env['INFURA_KEY'];

  final rpcUrl = 'https://mainnet.infura.io/v3/$infuraKey';
  final wsUrl = 'wss://mainnet.infura.io/ws/v3/$infuraKey';

  final client = Web3Client(rpcUrl, Client(), socketConnector: () {
    return IOWebSocketChannel.connect(wsUrl).cast<String>();
  });

  /// ENS client
  final ens = Ens(client: client);

  /// Get name from address
  final name = await ens
      .withAddress('0x1a5cdcFBA600e0c669795e0B65c344D5A37a4d5A')
      .getName();

  /// Get address from name
  final addr = await ens.withName('brantly.eth').getAddress();

  /// Get text record
  final textRecord = await ens.getTextRecord();

  print('name: $name'); // addr: 0x324f9307b6d26881822c7c8692eeac39791a9756
  print('addr: $addr'); // name: sea.eth
  print(
      'textRecord: $textRecord');  /* EnsTextRecord {
      email: me@brantly.xyz,
      url: http://brantly.xyz/,
      avatar: eip155:1/erc721:0xb7F7F6C52F2e2fdb1963Eab30438024864c313F6/2430,
      description: "If anyone would come after me, let him deny himself and take up his cross daily and follow me. For whoever would save his life will lose it, but whoever loses his life for my sake will save it. For what does it profit a man if he gains the whole world and loses or forfeits himself?" - Jesus, Luke 9.23-25,
      notice: Not for sale,
      keywords: ,
      com.discord: brantly.eth#9803,
      com.github: brantlymillegan,
      com.reddit: brantlymillegan,
      com.twitter: brantlymillegan,
      org.telegram: brantlymillegan,
      eth.ens.delegate: https://discuss.ens.domains/t/ens-dao-delegate-applications/815/697?u=brantlymillegan
    } 
}

```
