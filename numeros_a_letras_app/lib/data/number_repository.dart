import 'dart:convert';
import 'dart:io';
import 'package:async/async.dart';
import 'package:http/http.dart' as http;
import 'package:numeros_a_letras_app/models/number.dart';

class NumberRepository {
  CancelableOperation cancellableOperation;
  Future<dynamic> fromCancelable(Future<dynamic> future) async {
    cancellableOperation?.cancel();
    cancellableOperation = CancelableOperation.fromFuture(future, onCancel: () {
      print('Operation Cancelled');
    });
    return cancellableOperation.value;
  }

  Future<Number> getNumber(double number) async {
    try {
      var queryParameters = {
        'num': number.toString(),
      };

      var uri = Uri.https("nal.azurewebsites.net", "/api/NAL", queryParameters);
      var response = await http.get(uri, headers: {
        HttpHeaders.contentTypeHeader: 'application/json',
      });

      if (response.statusCode == 200) {
        // If server returns an OK response, parse the JSON.
        print('Api Called');
        return Number.fromJson(json.decode(response.body));
      } else {
        // If that response was not OK, throw an error.
        return Number.nullResponse();
      }
    } catch (ex) {
      return Number.nullResponse();
    }
  }
}
