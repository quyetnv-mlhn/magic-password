// DO NOT EDIT. This is code generated via package:easy_localization/generate.dart

// ignore_for_file: prefer_single_quotes, avoid_renaming_method_parameters

import 'dart:ui';

import 'package:easy_localization/easy_localization.dart' show AssetLoader;

class CodegenLoader extends AssetLoader{
  const CodegenLoader();

  @override
  Future<Map<String, dynamic>?> load(String path, Locale locale) {
    return Future.value(mapLocales[locale.toString()]);
  }

  static const Map<String,dynamic> en_US = {
  "error": {
    "decryptPasswordFailed": "Failed to decrypt password",
    "encryptPasswordFailed": "Failed to encrypt password",
    "failedGetSavedPassword": "Failed to get saved password",
    "failedLoadEncryptedPassword": "Failed to load encrypted password",
    "failedSavePassword": "Failed to save password",
    "invalidInput": "Invalid input",
    "invalidKey": "Invalid key",
    "noInternet": "No internet connection",
    "passwordNotFound": "Password not found",
    "requiredField": "This field is required",
    "serverError": "Server error",
    "timeout": "Request timeout"
  },
  "password": "Password",
  "saved": "Saved",
  "someThingWentWrong": "Something went wrong",
  "success": {
    "passwordDeleted": "Password deleted successfully",
    "passwordSaved": "Password saved successfully",
    "passwordUpdated": "Password updated successfully"
  },
  "warning": {
    "keyRequired": "Key is required",
    "nameRequired": "Name is required",
    "passwordAndKeyRequired": "Password and key are required",
    "passwordAndNameRequired": "Password and name are required",
    "passwordNameRequired": "Name of password are required",
    "passwordRequired": "Password is required"
  }
};
static const Map<String,dynamic> vi_VN = {
  "error": {
    "decryptPasswordFailed": "Không thể giải mã mật khẩu",
    "encryptPasswordFailed": "Mã hóa mật khẩu thất bại",
    "failedGetSavedPassword": "Không thể lấy mật khẩu đã lưu",
    "failedLoadEncryptedPassword": "Không tải được mật khẩu đã mã hóa",
    "failedSavePassword": "Không lưu được mật khẩu",
    "invalidInput": "Đầu vào không hợp lệ",
    "invalidKey": "Khóa không hợp lệ",
    "noInternet": "Không có kết nối internet",
    "passwordNotFound": "Không tìm thấy mật khẩu",
    "requiredField": "Trường này là bắt buộc",
    "serverError": "Lỗi máy chủ",
    "timeout": "Yêu cầu hết thời gian"
  },
  "password": "Mật khẩu",
  "saved": "Đã lưu",
  "someThingWentWrong": "Đã xảy ra lỗi",
  "success": {
    "passwordDeleted": "Đã xóa mật khẩu thành công",
    "passwordSaved": "Mật khẩu đã được lưu thành công",
    "passwordUpdated": "Đã cập nhật mật khẩu thành công"
  },
  "warning": {
    "keyRequired": "Khóa là bắt buộc",
    "nameRequired": "Tên là bắt buộc",
    "passwordAndKeyRequired": "Yêu cầu mật khẩu và khóa",
    "passwordAndNameRequired": "Yêu cầu mật khẩu và tên",
    "passwordNameRequired": "Tên của mật khẩu là bắt buộc",
    "passwordRequired": "Yêu cầu mật khẩu"
  }
};
static const Map<String, Map<String,dynamic>> mapLocales = {"en_US": en_US, "vi_VN": vi_VN};
}
