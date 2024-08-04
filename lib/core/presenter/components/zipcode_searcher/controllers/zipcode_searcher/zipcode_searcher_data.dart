class ZipcodeSearcherData {
  final bool loading;
  ZipcodeSearcherData({
    required this.loading,
  });

  ZipcodeSearcherData copyWith({
    bool? loading,
  }) {
    return ZipcodeSearcherData(
      loading: loading ?? this.loading,
    );
  }
}
