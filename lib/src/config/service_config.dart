import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart';
import 'package:io_extended_2023_gdg_la_paz/src/config/form_controller.dart';
import 'package:io_extended_2023_gdg_la_paz/src/config/middleware.dart';
import 'package:io_extended_2023_gdg_la_paz/src/plugins/auth/auth.dart';
import 'package:io_extended_2023_gdg_la_paz/src/plugins/firebase/firestore_service.dart';

class ResponseApi {
  late StatusNetwork status;
  late Map<String, dynamic> data;
  late dynamic log;
  late String message;

  ResponseApi(this.status, this.data, this.message, {this.log});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['status'] = status;
    data['response'] = data;
    data['message'] = message;
    return data;
  }

  static ResponseApi disconnected = ResponseApi(
      StatusNetwork.noInternet,
      {'message': 'No existe conexión a internet'},
      'No existe conexión a internet');

  static ResponseApi timeOut = ResponseApi(StatusNetwork.timeout,
      {'message': 'Tiempo de espera excedido'}, 'Tiempo de espera excedido');
}

class ServiceConfig with FormController, Middleware, Firestore {
  String urlBase;
  ServiceConfig(this.urlBase);

  Future<Map<String, String>> getHeaders(
      {bool withAuthorization = true}) async {
    Map<String, String> headers = {};
    // headers['Content-Type'] = 'application/json';
    headers['Accept'] = 'application/json';
    if (withAuthorization) {
      final token = await Auth().tokenApi;
      final auth = ('Bearer $token').replaceAll('"', "");
      headers['Authorization'] = auth;
    }
    return headers;
  }

  (String collection, String? document) decodeUrl(String url) {
    final parseUrl = url.split('/');
    return (parseUrl[0], parseUrl[1].isEmpty ? null : parseUrl[1]);
  }

  Future<ResponseApi> firestoreFetch(String recipe,
      {FirebaseProtocol? protocol = FirebaseProtocol.read,
      Map<String, dynamic>? rules}) async {
    if (!await internetConnected()) {
      return ResponseApi.disconnected;
    }

    StatusNetwork status = StatusNetwork.connected;
    final ResponseFirestore response;
    dynamic data;
    try {
      final (String collection, String? document) =
          decodeUrl('$urlBase$recipe');
      switch (protocol) {
        case FirebaseProtocol.read:
          response = await getSnapshot(collection, document: document);
          data = decodeResponse(response);
          break;
        default:
          response = await getSnapshot(collection, document: document);
          data = decodeResponse(response);
          break;
      }
      return ResponseApi(status, data, 'Tarea realizada correctamente',
          log: response);
    } catch (e) {
      log('ocurrio una exception>>> ${e.toString()}');
      return ResponseApi(
          StatusNetwork.exception,
          {'message': 'Ocurrió un error inesperado', 'log': e.toString()},
          'Ocurrió un error inesperado');
    }
  }

  Future<ResponseApi> fetch(String urlRecipe,
      {HttpProtocol? type = HttpProtocol.get,
      Map<String, dynamic>? body,
      bool withAuthorization = true}) async {
    if (!await internetConnected()) {
      return ResponseApi.disconnected;
    }

    StatusNetwork status = StatusNetwork.noContent;
    final Response response;
    final String url = '$urlBase$urlRecipe';

    log('Ejecutando>>>> $url, body: $body');

    try {
      final headers = await getHeaders(withAuthorization: withAuthorization);
      switch (type) {
        case HttpProtocol.get:
          response = await get(Uri.parse(url), headers: headers)
              .timeout(const Duration(seconds: 10));
          break;
        case HttpProtocol.post:
          response = await post(Uri.parse(url), headers: headers, body: body)
              .timeout(const Duration(seconds: 10));
          break;
        case HttpProtocol.patch:
          response = await patch(Uri.parse(url), headers: headers, body: body)
              .timeout(const Duration(seconds: 10));
          break;
        case HttpProtocol.put:
          response = await put(Uri.parse(url), headers: headers, body: body)
              .timeout(const Duration(seconds: 10));
          break;
        case HttpProtocol.delete:
          response = await delete(Uri.parse(url), headers: headers, body: body)
              .timeout(const Duration(seconds: 10));
          break;
        default:
          response = await get(Uri.parse(url), headers: headers)
              .timeout(const Duration(seconds: 10));
          break;
      }
      final decode = utf8.decode(response.bodyBytes);
      final json = jsonDecode(decode);
      status = decodeStatus(response.statusCode);
      validateResponse(status);
      final responseParsed = parseResponse(json);
      return ResponseApi(responseParsed['status'], responseParsed['data'],
          responseParsed['message'],
          log: json);
    } on TimeoutException catch (_) {
      return ResponseApi.timeOut;
    } catch (e) {
      return ResponseApi(
          StatusNetwork.exception,
          {'message': 'Ocurrió un error inesperado', 'log': e.toString()},
          'Ocurrió un error inesperado');
    }
  }
}

enum HttpProtocol { get, post, patch, put, delete }

enum FirebaseProtocol { read, create, update, delete }
