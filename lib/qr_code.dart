class QrCode {
  final String id;

  QrCode(this.id);

  QrCode.fromJson(Map<String, dynamic> json)
    : id = json['o']['eI'];

  Map<String, dynamic> toJson() =>
      {
        'o': { 'eI': id }
      };
}