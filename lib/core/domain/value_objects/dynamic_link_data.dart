class DynamicLinkData {
  DynamicLinkData({
    required this.link,
    this.android,
    this.ios,
  });

  final Uri link;
  final DynamicLinkDataAndroid? android;
  final DynamicLinkDataIos? ios;
}

class DynamicLinkDataAndroid {
  DynamicLinkDataAndroid({
    this.clickTimestamp,
    this.minimumVersion,
  });

  final int? clickTimestamp;
  final int? minimumVersion;
}

class DynamicLinkDataIos {
  DynamicLinkDataIos({
    this.minimumVersion,
    this.matchType,
  });

  final String? minimumVersion;
  final IosMatchType? matchType;
}

/// The match type of the Dynamic Link.
/// https://firebase.google.com/docs/reference/ios/firebasedynamiclinks/api/reference/Enums/FIRDLMatchType.html
enum IosMatchType {
  ///  The match has not been achieved.
  none,

  /// The match between the Dynamic Link and this device may not be perfect, 
  /// hence you should
  /// not reveal any personal information related to the Dynamic Link.
  weak,

  /// The match between the Dynamic Link and this device has high confidence 
  /// but small possibility
  /// of error still exist.
  high,

  /// The match between the Dynamic Link and this device is exact, 
  /// hence you may reveal personal
  /// information related to the Dynamic Link.
  unique,
}
