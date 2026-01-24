import 'dart:io';

import 'package:flutter/foundation.dart';

class ApiEndpoints {
  ApiEndpoints._();

  static const bool isPhysicalDevice = false;

  static const String compIpAddress = "192.168.100.8";

  static const String portPath = "3000/api/v1";

  //Info: Base URL
  static String get baseUrl {
    if (isPhysicalDevice) {
      return "http://$compIpAddress:$portPath";
    }
    if (kIsWeb) {
      return "http://localhost:$portPath";
    } else if (Platform.isAndroid) {
      // info: for android
      return "http://10.0.2.2:$portPath";
    } else if (Platform.isIOS) {
      return "http://localhost:$portPath";
    } else {
      return "http://localhost:$portPath";
    }
  }

  // Note: For physical device use computer IP: "http:/102.168.x.x:5000/api/v1"

  static const Duration connectionTimeout = Duration(seconds: 30);
  static const Duration receiveTimeout = Duration(seconds: 30);

  // Hack: ========== Batch Endpoints ===========
  static const String batches = "/batches";
  static String batchById(String id) => '/batches/$id';

  // Hack: ========== Categories Endpoints ===========
  static const String categories = "/categories";
  static String categoriesById(String id) => '/categories/$id';

  // Hack: ========== Student Endpoints ===========
  static const String students = "/students";
  static const String studentLogin = "/students/login";
  static const String studentRegister = "/students/register";
  static String studentById(String id) => '/students/$id';
  static String studentPhoto(String id) => "/students/$id/photo";

  // Hack: ========== Item Endpoints ===========
  static const String items = "/items";
  static String itemsById(String id) => '/items/$id';
  static String itemsClaim(String id) => '/items/$id/claim';
  static String itemUploadPhoto = '/items/upload-photo';
  static String itemUploadVideo = '/items/upload-video';

  // Hack: ========== Comment Endpoints ===========
  static const String comments = "/comments";
  static String commentById(String id) => '/comments/$id';
  static String commentsByItems(String itemId) => "comments/item/$itemId";
  static String commentLike(String id) => '/items/$id/like';
}
