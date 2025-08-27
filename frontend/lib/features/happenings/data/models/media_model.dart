class Media {
  final String uri;

  Media({required this.uri});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{"uri": uri};
  }
}
