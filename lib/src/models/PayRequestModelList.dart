class PayRequestModelList {
  int invoiceId;
  int clientId;
  String name;
  String email;
  String description;
  double requestedAmount;
  String requestedCurrency;
  String status;
  DateTime createDate;
  String ip;
  String trackid;
  String productName;
  int invoiceType;
  String returnUrl;

  PayRequestModelList({
    required this.invoiceId,
    required this.clientId,
    required this.name,
    required this.email,
    required this.description,
    required this.requestedAmount,
    required this.requestedCurrency,
    required this.status,
    required this.createDate,
    required this.ip,
    required this.trackid,
    required this.productName,
    required this.invoiceType,
    required this.returnUrl,
  });

  factory PayRequestModelList.fromJson(Map<String, dynamic> json) {
    return PayRequestModelList(
      invoiceId: json['Invoice_id'] as int,
      clientId: json['client_id'] as int,
      name: json['name'] as String,
      email: json['email'] as String,
      description: json['description'] as String,
      requestedAmount: (json['requestedamount'] as num).toDouble(),
      requestedCurrency: json['requestedcurrency'] as String,
      status: json['status'] as String,
      createDate: DateTime.parse(json['createdate'] as String),
      ip: json['ip'] as String,
      trackid: json['trackid'] as String,
      productName: json['product_name'] as String,
      invoiceType: json['invoice_type'] as int,
      returnUrl: json['return_url'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'Invoice_id': invoiceId,
      'client_id': clientId,
      'name': name,
      'email': email,
      'description': description,
      'requestedamount': requestedAmount,
      'requestedcurrency': requestedCurrency,
      'status': status,
      'createdate': createDate.toIso8601String(),
      'ip': ip,
      'trackid': trackid,
      'product_name': productName,
      'invoice_type': invoiceType,
      'return_url': returnUrl,
    };
  }
}