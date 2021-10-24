class SplashState {
  bool credoScraped;
  bool onboardingSeen;
  SplashState({
    this.credoScraped = false,
    this.onboardingSeen = false,
  });

  SplashState copyWith({
    bool? credoScraped,
    bool? onboardingSeen,
  }) {
    return SplashState(
      credoScraped: credoScraped ?? this.credoScraped,
      onboardingSeen: onboardingSeen ?? this.onboardingSeen,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is SplashState &&
      other.credoScraped == credoScraped &&
      other.onboardingSeen == onboardingSeen;
  }

  @override
  int get hashCode => credoScraped.hashCode ^ onboardingSeen.hashCode;
}
