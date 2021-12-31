import 'package:convert/convert.dart';
import 'package:sha3/sha3.dart';

class ENSUtils {
  static String nameHash(String? inputName) {
    var node = '';
    for (var i = 0; i < 32; i++) {
      node += '00';
    }
    if (inputName != null) {
      if (!inputName.contains('.eth')) {
        inputName = '$inputName.eth';
      }

      var labels = inputName.split('.');

      for (var i = labels.length - 1; i >= 0; i--) {
        String labelSha;
        if (isEncodedLabelhash(labels[i])) {
          labelSha = decodeLabelhash(labels[i]);
        } else {
          var normalisedLabel = labels[i];
          labelSha = sha3(normalisedLabel);
        }

        node = sha3(String.fromCharCodes(hex.decode('$node$labelSha')));
      }
    }

    return '0x' + node;
  }

  static String reverseNameHash(inputName) {
    // Reject empty names:
    var node = '';
    for (var i = 0; i < 32; i++) {
      node += '00';
    }

    var name = normalize(inputName);

    var labels = name.split('.');

    for (var i = labels.length - 1; i >= 0; i--) {
      var labelSha = sha3(labels[i]);
      node = sha3(String.fromCharCodes(hex.decode('$node$labelSha')));
    }

    return '0x' + node;
  }

  String encodeLabelhash(hash) {
    if (!hash.startsWith('0x')) {
      throw 'Expected label hash to start with 0x';
    }

    if (hash.length != 66) {
      throw 'Expected label hash to have a length of 66';
    }

    return '[${hash.slice(2)}]';
  }

  static String decodeLabelhash(String hash) {
    if (!(hash.startsWith('[') && hash.endsWith(']'))) {
      throw 'Expected encoded labelhash to start and end with square brackets';
    }

    if (hash.length != 66) {
      throw 'Expected encoded labelhash to have a length of 66';
    }

    return hash.slice(1, -1);
  }

  static bool isEncodedLabelhash(hash) {
    return hash.startsWith('[') && hash.endsWith(']') && hash.length == 66;
  }

  static bool isDecrypted(String name) {
    final nameArray = name.split('.');
    final decrypted = nameArray.skip(1).fold(true, ((acc, label) {
      if (acc == false) return false;
      return isEncodedLabelhash(label) ? false : true;
    }));
    return decrypted;
  }

  static String labelhash(unnormalisedLabelOrLabelhash) {
    return isEncodedLabelhash(unnormalisedLabelOrLabelhash)
        ? '0x' + decodeLabelhash(unnormalisedLabelOrLabelhash)
        : '0x' + sha3(normalize(unnormalisedLabelOrLabelhash));
  }

  static String sha3(String string) {
    var hash =
        SHA3(256, KECCAK_PADDING, 256).update(string.runes.toList()).digest();

    return hex.encode(hash);
  }

  static String normalize(String name) {
    return (name);
  }

  static String describeEnum(Object enumEntry) {
    final String description = enumEntry.toString();
    final int indexOfDot = description.indexOf('.');
    assert(
      indexOfDot != -1 && indexOfDot < description.length - 1,
      'The provided object "$enumEntry" is not an enum.',
    );
    return description.substring(indexOfDot + 1);
  }
}

extension Slice on String {
  String slice(int start, [int? end]) {
    if (end != null && end.isNegative) {
      return substring(start, length - end.abs());
    }
    return substring(start, end);
  }
}
