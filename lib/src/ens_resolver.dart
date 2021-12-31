// ignore_for_file: constant_identifier_names

import 'dart:typed_data';
import 'package:convert/convert.dart';

import 'package:web3dart/crypto.dart';
import 'package:web3dart/web3dart.dart';

import 'ens_dart.dart';

enum EnsTextKey {
  email,
  url,
  avatar,
  description,
  notice,
  keywords,
  com_discord,
  com_github,
  com_reddit,
  com_twitter,
  org_telegram,
  eth_ens_delegate
}

extension EnsResolve on Ens {
  /// Name hash for ENS name
  Uint8List get nodeHash => hexToBytes(ENSUtils.nameHash(ensName ?? ''));
  
  /// Reverse node hash for ENS name
  Uint8List get reverseNodeHash => hexToBytes(
      ENSUtils.reverseNameHash('${ensAddress!.hexNo0x}.addr.reverse'));

  /// Returns the owner/controller for the current ENS name.
  Future<EthereumAddress> getAddress() async {
    if (ensName == null) {
      throw 'ensName needs to be set first with .withName()';
    }

    final _resolvedAddress = await addr(nodeHash);
    withAddress(_resolvedAddress);
    return _resolvedAddress;
  }

  /// Returns the owner/controller for the current ENS name.
  Future<String> getCoinAddress(CoinType coinType) async {
    if (ensName == null) {
      throw 'ensName needs to be set first with .withName()';
    }

    final _resolvedAddress = await addr$2(nodeHash, coinType.coinTypeInt);
    return hex.encode(_resolvedAddress);
  }

  /// Returns the address for the current ENS name for the coinId provided.
  Future<String> setAddress(
    EthereumAddress address,
    BigInt coinType, {
    required Credentials credentials,
    Transaction? transaction,
  }) async {
    if (ensName == null) {
      throw 'ensName needs to be set first with .withName()';
    }

    final _resolvedAddress = await setAddr(
      nodeHash,
      coinType,
      address.addressBytes,
      credentials: credentials,
      transaction: transaction,
    );
    return _resolvedAddress;
  }

  /// Sets the address for the current ENS name for the coinId provided.
  Future<String> getContentHash() async {
    return hex.encode(await contenthash(nodeHash));
  }

  /// Returns the text record for a given key for the current ENS name.
  Future<EnsTextRecord> getTextRecord() async {
    var map = <String, dynamic>{};

    for (var item in EnsTextKey.values) {
      var _name = ENSUtils.describeEnum(item);
      final _raw = await text(
        nodeHash,
        _name.replaceAll('_', '.'),
      );

      map.putIfAbsent(_name, () => _raw);
    }

    final _record = EnsTextRecord.fromMap(map);
    setEnsTextRecord(_record);

    return _record;
  }

  /// Returns a Resolver Object, allowing you to query names from this specific resolver.
  /// Most useful when querying a different resolver that is different than is currently recorded on the registry.
  ///  E.g. migrating to a new resolver
  Future<EthereumAddress> getResolverAddress(Uint8List hash) async {
    final ensReg = EnsRegistryFallback(
      address: ENS_FALLBACK_REGISTRY,
      client: client,
    );
    return ensReg.resolver(hash);
  }

  ///Returns a name, that allows you to make record queries.
  Future<String> getName() async {
    if (ensAddress == null) {
      throw 'ensAddress needs to be set first with .withAddress()';
    }
    final resolver = await getResolverAddress(reverseNodeHash);
    final name = await reverseEns(resolver).name(reverseNodeHash);
    withName(name);
    return name;
  }

  /// Sets the name for the current Ethereum address
  Future<String> setEnsName(
    String name, {
    required Credentials credentials,
    Transaction? transaction,
  }) async {
    if (ensAddress == null) {
      throw 'ensAddress needs to be set first with .withAddress()';
    }
    final _resolvedAddress = await setName(
      reverseNodeHash,
      name,
      credentials: credentials,
      transaction: transaction,
    );
    return _resolvedAddress;
  }
}
