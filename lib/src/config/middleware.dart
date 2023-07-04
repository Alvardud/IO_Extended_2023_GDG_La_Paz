import 'dart:developer';
import 'dart:io';

mixin Middleware {
  Future<bool> internetConnected() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        return true;
      }
      return false;
    } catch (e) {
      return false;
    }
  }

  returnLogin() {
    // navigatorKey.currentState
    //     ?.pushNamedAndRemoveUntil(LoginPage.route, (route) => false);
    // loginPage.currentState?.showSnackBar(const SnackBar(
    //     content: Text('Las credenciales expiraron, inicia sesión nuevamente')));
  }

  validateResponse(StatusNetwork status) {
    switch (status) {
      case StatusNetwork.unauthorized:
        returnLogin();
        return;
      case StatusNetwork.noContent:
        returnLogin();
        return;
      default:
        return;
    }
  }

  Map<String, dynamic> parseResponse(Map<String, dynamic> json) {
    try {
      final Map<String, dynamic> data = {};
      if (json.containsKey('status')) {
        if (json['status']) {
          data['status'] = StatusNetwork.connected;
        } else {
          data['status'] = StatusNetwork.exception;
        }
      } else {
        data['status'] = StatusNetwork.exception;
      }

      if (json.containsKey('message')) {
        data['message'] = json['message'] ?? '';
      } else {
        data['message'] = 'Se realizó la tarea correctamente';
      }

      if (json.containsKey('data')) {
        data['data'] = json['data'] ?? {};
      } else {
        data['data'] = json;
      }
      return data;
    } catch (e) {
      log('exception ${e.toString()}');
      return {
        'status': StatusNetwork.exception,
        'mensaje': 'ocurrio un error inesperado',
        'data': e.toString()
      };
    }
  }

  StatusNetwork decodeStatus(int status) {
    switch (status) {
      case 200:
        return StatusNetwork.connected;
      case 202:
        return StatusNetwork.connected;
      case 400:
        return StatusNetwork.unauthorized;
      case 403:
        return StatusNetwork.unauthorized;
      case 404:
        return StatusNetwork.noContent;
      case 500:
        return StatusNetwork.exception;
      default:
        return StatusNetwork.noValidate;
    }
  }
}

enum StatusNetwork {
  connected,
  noInternet,
  exception,
  noValidate,
  unauthorized,
  timeout,
  noContent
}
