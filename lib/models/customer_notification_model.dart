class CustomerNotification {
  final String id;
  final String cari;
  final String content;
  final String url;

  const CustomerNotification({
    required this.id,
    required this.cari,
    required this.content,
    required this.url,
  });

  factory CustomerNotification.fromJson(Map<String, dynamic> json) {
    return CustomerNotification(
      id: json['id'],
      cari: json['cari'],
      content: json['metin'],
      url: json['url'],
    );
  }
}
