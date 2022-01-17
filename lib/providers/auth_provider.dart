import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../helpers/server_calls.dart' as app_server_call;

class AuthProvider extends ChangeNotifier {
  Map _user = {};
  bool _isMember = false;
  bool _isAuth = false;
  String _errorMessage = "";
  String _phoneNumber = "";
  int _accountType = 0;
  bool _loader = false;

  Map get user {
    return _user;
  }

  bool get loader {
    return _loader;
  }

  bool? get isMember {
    return _isMember;
  }

  bool? get isAuth {
    return _isAuth;
  }

  String get errorMessage {
    return _errorMessage;
  }

  String get phoneNumber {
    return _phoneNumber;
  }

  int get accountType {
    return _accountType;
  }

  void setLoader(bool state) {
    _loader = state;
    notifyListeners();
  }

  void savePhoneNumber(String phoneNumber) {
    _phoneNumber = phoneNumber;
    notifyListeners();
  }

  void saveAccountType(accountType) {
    _accountType = accountType;

    notifyListeners();
  }

  Future<void>? checkUserStatus(phoneNumber) async {
    Map<String, dynamic> data = {'phone_number': phoneNumber.toString()};
    app_server_call.send(data, 'check-status')!.then((response) {
      if (response.statusCode == 200) {
        _isMember = true;
        notifyListeners();
      } else {
        _isMember = false;
        notifyListeners();
      }
    });
  }

  Future<dynamic> verifyMobileNumber(otp) async {
    Map<String, dynamic> data = {
      'phone_number': _phoneNumber.toString(),
      "otp": otp
    };
    final response = await app_server_call.send(data, 'verify-otp');

    if (response.statusCode == 200) {
      return true;
    } else {
      errorHandler(response);
      return false;
    }
  }

  Future<dynamic> sendOTP(phoneNumber) async {
    Map<String, dynamic> data = {'phone_number': phoneNumber.toString()};
    final response = await app_server_call.send(data, 'send-otp');

    if (response.statusCode == 200) {
      return true;
    } else {
      errorHandler(response);
    }
  }

  Future<dynamic> changeNumber(phoneNumber) async {
    Map<String, dynamic> data = {'phone_number': phoneNumber.toString()};
    final response = await app_server_call.send(data, 'change-number');

    if (response.statusCode == 200) {
      return true;
    } else {
      errorHandler(response);
    }
  }

  Future<dynamic> resendOTP(phoneNumber) async {
    Map<String, dynamic> data = {'phone_number': phoneNumber.toString()};
    final response = await app_server_call.send(data, 'resend-otp');

    if (response.statusCode == 200) {
      return true;
    } else {
      errorHandler(response);
    }
  }

  Future<void> logUserIn(phoneNumber, password) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _phoneNumber = phoneNumber;

    Map<String, dynamic> data = {
      'phone_number': phoneNumber.toString(),
      'password': password
    };

    final response = await app_server_call.send(data, 'login');
    if (response.statusCode == 200) {
      final userData = json.decode(response.body)['data'];
      final token = json.decode(response.body)['token'];
      final decodedUserData = json.encode(userData);
      final decodedToken = json.encode(token);

      prefs.setString('userData', decodedUserData);
      prefs.setString('token', decodedToken);
      print(userData);
      _user = userData;
      _isAuth = true;
      notifyListeners();
    } else {
      _isAuth = false;
      errorHandler(response);
    }
  }

  Future<dynamic> register(Map<String, dynamic> data) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final response = await app_server_call.send(data, 'register');

    if (response.statusCode == 200) {
      final userData = json.decode(response.body)['data'];
      final token = json.decode(response.body)['token'];
      final decodedUserData = json.encode(userData);
      final decodedToken = json.encode(token);

      prefs.setString('userData', decodedUserData);
      prefs.setString('token', decodedToken);
      print(userData);
      _user = userData;
      _isAuth = true;
      notifyListeners();
      return true;
    } else {
      errorHandler(response);
    }
  }

  Future<dynamic> logOut() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove("userData");
    prefs.remove("token");
    _user = {};
    _isAuth = false;
    return true;
  }

  void errorHandler(response) {
    final decodedResponse = json.decode(response.body);
    _errorMessage = decodedResponse['message'];
    notifyListeners();
  }
}
