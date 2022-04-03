import 'dart:convert';

import 'package:githubit/config/global_config.dart';
import 'package:http/http.dart' as http;

Future<Map<String, dynamic>> paymentRequest(
    int idShop,
    int orderId,
    int paymentId,
    String email,
    String cardNumber,
    String cardExpired,
    String cardHolder,
    String cardCvv) async {
  String url = "$GLOBAL_URL/payment-system/payment";

  Map<String, String> headers = {
    "Content-Type": "application/json",
    "Accept": "application/json"
  };

  final client = new http.Client();

  Map<String, String> body = {
    "shop_id": idShop.toString(),
    "id": orderId.toString(),
    "type": "order",
    "payment_id": paymentId.toString()
  };

  if (paymentId == 4) {
    body['card_number'] = cardNumber;
    body['card_expired'] = cardExpired;
    body['card_holder'] = cardHolder;
    body['card_cvv'] = cardCvv;
  } else if (paymentId == 3) {
    body['email'] = email;
  }

  final response = await client.post(Uri.parse(url),
      headers: headers, body: json.encode(body));

  Map<String, dynamic> responseJson = {};

  try {
    if (response.statusCode == 200)
      responseJson = json.decode(response.body) as Map<String, dynamic>;
  } on FormatException catch (e) {
    print(e);
  }

  return responseJson;
}
