import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/scheduler.dart';
import 'package:loan_app/core/abstractions/abstractions.dart';

import 'package:loan_app/core/domain/value_objects/dynamic_link_data.dart';

class FirebaseDynamicLinksIntegration implements DynamicLinking {
  final FirebaseDynamicLinks _dynamicLinks = FirebaseDynamicLinks.instance;

  @override
  Future<void> init(
    ValueChanged<DynamicLinkData> onLink,
  ) async {
    final pendingDynamicLinkData = await _dynamicLinks.getInitialLink();

    if (pendingDynamicLinkData != null) {
      final initialLinkData = pendingDynamicLinkData.toDynamicLinkData();
      SchedulerBinding.instance?.addPostFrameCallback(
        (_) {
          onLink(initialLinkData);
        },
      );
    }

    _dynamicLinks.onLink.listen((linkData) {
      onLink(linkData.toDynamicLinkData());
    });
  }
}

extension _DynamicLinkDataMapper on PendingDynamicLinkData {
  DynamicLinkData toDynamicLinkData() {
    return DynamicLinkData(
      android: DynamicLinkDataAndroid(
        clickTimestamp: android?.clickTimestamp,
        minimumVersion: android?.minimumVersion,
      ),
      ios: DynamicLinkDataIos(
        matchType: ios?.matchType?.toIosMatchType(),
        minimumVersion: ios?.minimumVersion,
      ),
      link: link,
    );
  }
}

extension _MatchTypeMapper on MatchType {
  IosMatchType toIosMatchType() {
    switch (this) {
      case MatchType.none:
        return IosMatchType.none;
      case MatchType.weak:
        return IosMatchType.weak;
      case MatchType.high:
        return IosMatchType.high;
      case MatchType.unique:
        return IosMatchType.unique;
    }
  }
}
