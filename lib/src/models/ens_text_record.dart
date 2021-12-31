import 'dart:convert';

class EnsTextRecord {
  final String email;
  final String url;
  final String avatar;
  final String description;
  final String notice;
  final String keywords;
  final String discord;
  final String github;
  final String reddit;
  final String twitter;
  final String telegram;
  final String ensDelegate;
  EnsTextRecord({
    required this.email,
    required this.url,
    required this.avatar,
    required this.description,
    required this.notice,
    required this.keywords,
    required this.discord,
    required this.github,
    required this.reddit,
    required this.twitter,
    required this.telegram,
    required this.ensDelegate,
  });

  EnsTextRecord copyWith({
    String? email,
    String? url,
    String? avatar,
    String? description,
    String? notice,
    String? keywords,
    String? discord,
    String? github,
    String? reddit,
    String? twitter,
    String? telegram,
    String? ensDelegate,
  }) {
    return EnsTextRecord(
      email: email ?? this.email,
      url: url ?? this.url,
      avatar: avatar ?? this.avatar,
      description: description ?? this.description,
      notice: notice ?? this.notice,
      keywords: keywords ?? this.keywords,
      discord: discord ?? this.discord,
      github: github ?? this.github,
      reddit: reddit ?? this.reddit,
      twitter: twitter ?? this.twitter,
      telegram: telegram ?? this.telegram,
      ensDelegate: ensDelegate ?? this.ensDelegate,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'email': email,
      'url': url,
      'avatar': avatar,
      'description': description,
      'notice': notice,
      'keywords': keywords,
      'com_discord': discord,
      'com_github': github,
      'com_reddit': reddit,
      'com_twitter': twitter,
      'org_telegram': telegram,
      'eth_ens_delegate': ensDelegate,
    };
  }

  factory EnsTextRecord.fromMap(Map<String, dynamic> map) {
    return EnsTextRecord(
      email: map['email'] ?? '',
      url: map['url'] ?? '',
      avatar: map['avatar'] ?? '',
      description: map['description'] ?? '',
      notice: map['notice'] ?? '',
      keywords: map['keywords'] ?? '',
      discord: map['com_discord'] ?? '',
      github: map['com_github'] ?? '',
      reddit: map['com_reddit'] ?? '',
      twitter: map['com_twitter'] ?? '',
      telegram: map['org_telegram'] ?? '',
      ensDelegate: map['eth_ens_delegate'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory EnsTextRecord.fromJson(String source) =>
      EnsTextRecord.fromMap(json.decode(source));

  @override
  String toString() {
    return '''
    EnsTextRecord {
      email: $email,
      url: $url, 
      avatar: $avatar, 
      description: $description, 
      notice: $notice, 
      keywords: $keywords, 
      com.discord: $discord, 
      com.github: $github, 
      com.reddit: $reddit, 
      com.twitter: $twitter, 
      org.telegram: $telegram, 
      eth.ens.delegate: $ensDelegate
    }''';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is EnsTextRecord &&
        other.email == email &&
        other.url == url &&
        other.avatar == avatar &&
        other.description == description &&
        other.notice == notice &&
        other.keywords == keywords &&
        other.discord == discord &&
        other.github == github &&
        other.reddit == reddit &&
        other.twitter == twitter &&
        other.telegram == telegram &&
        other.ensDelegate == ensDelegate;
  }

  @override
  int get hashCode {
    return email.hashCode ^
        url.hashCode ^
        avatar.hashCode ^
        description.hashCode ^
        notice.hashCode ^
        keywords.hashCode ^
        discord.hashCode ^
        github.hashCode ^
        reddit.hashCode ^
        twitter.hashCode ^
        telegram.hashCode ^
        ensDelegate.hashCode;
  }
}
