// DO NOT EDIT. This is code generated via package:easy_localization/generate.dart

// ignore_for_file: prefer_single_quotes, avoid_renaming_method_parameters

import 'dart:ui';

import 'package:easy_localization/easy_localization.dart' show AssetLoader;

class CodegenLoader extends AssetLoader {
  const CodegenLoader();

  @override
  Future<Map<String, dynamic>?> load(String path, Locale locale) {
    return Future.value(mapLocales[locale.toString()]);
  }

  static const Map<String, dynamic> en_US = {
    "actions": {
      "apply": "Apply",
      "cancel": "Cancel",
      "clear": "Clear",
      "close": "Close",
      "confirm": "Confirm"
    },
    "encryption": {
      "enterEncryptionKey": "Enter encryption key",
      "enterMasterKey": "Enter master key",
      "enterYourMasterKey": "Enter your master key",
      "masterKey": "Master key",
      "note":
          "This key will only be used for the current session. You can change or clear it in Settings"
    },
    "errors": {
      "decryptPasswordFailed": "Failed to decrypt password",
      "encryptPasswordFailed": "Failed to encrypt password",
      "failedDeletePassword": "Failed to delete password",
      "failedGeneratePassword": "Failed to generate password",
      "failedGetSavedPassword": "Failed to get saved password",
      "failedLoadEncryptedPassword": "Failed to load encrypted password",
      "failedSavePassword": "Failed to save password",
      "failedUpdatePassword": "Failed to update password",
      "invalidInput": "Invalid input",
      "invalidKey": "Invalid key",
      "noInternet": "No internet connection",
      "passwordNotFound": "Password not found",
      "requiredField": "This field is required",
      "serverError": "Server error",
      "timeout": "Request timeout"
    },
    "filter": {
      "sections": {"apps": "Apps", "cards": "Cards", "social": "Social"}
    },
    "messages": {
      "processing": "Processing...",
      "saved": "Saved",
      "someThingWentWrong": "Something went wrong"
    },
    "password": {"label": "Password"},
    "search": {
      "filter": {
        "accountTypes": "Account types",
        "sections": "Sections",
        "title": "Filter"
      },
      "noResults": "No passwords found",
      "title": "Search passwords..."
    },
    "success": {
      "passwordDeleted": "Password deleted successfully",
      "passwordSaved": "Password saved successfully",
      "passwordUpdated": "Password updated successfully"
    },
    "warnings": {
      "keyRequired": "Key is required",
      "nameRequired": "Name is required",
      "passwordAndKeyRequired": "Password and key are required",
      "passwordAndNameRequired": "Password and name are required",
      "passwordNameRequired": "Name of password is required",
      "passwordRequired": "Password is required",
      "selectAtLeastOne": "Select at least one option"
    }
  };
  static const Map<String, dynamic> vi_VN = {
    "actions": {
      "apply": "Áp dụng",
      "cancel": "Hủy",
      "clear": "Xóa",
      "close": "Đóng",
      "confirm": "Xác nhận"
    },
    "encryption": {
      "enterEncryptionKey": "Nhập khóa mã hóa",
      "enterMasterKey": "Nhập khóa chính",
      "enterYourMasterKey": "Nhập khóa chính của bạn",
      "masterKey": "Khóa chính",
      "note":
          "Khóa này chỉ được sử dụng cho phiên hiện tại. Bạn có thể thay đổi hoặc xóa nó trong Cài đặt"
    },
    "errors": {
      "decryptPasswordFailed": "Không thể giải mã mật khẩu",
      "encryptPasswordFailed": "Mã hóa mật khẩu thất bại",
      "failedDeletePassword": "Xóa mật khẩu thất bại",
      "failedGeneratePassword": "Không thể tạo mật khẩu",
      "failedGetSavedPassword": "Không thể lấy mật khẩu đã lưu",
      "failedLoadEncryptedPassword": "Không thể tải mật khẩu đã mã hóa",
      "failedSavePassword": "Không thể lưu mật khẩu",
      "failedUpdatePassword": "Cập nhật mật khẩu không thành công",
      "invalidInput": "Đầu vào không hợp lệ",
      "invalidKey": "Khóa không hợp lệ",
      "noInternet": "Không có kết nối internet",
      "passwordNotFound": "Không tìm thấy mật khẩu",
      "requiredField": "Trường này là bắt buộc",
      "serverError": "Lỗi máy chủ",
      "timeout": "Yêu cầu hết thời gian"
    },
    "filter": {
      "sections": {"apps": "Ứng dụng", "cards": "Thẻ", "social": "Xã hội"}
    },
    "messages": {
      "processing": "Đang xử lý...",
      "saved": "Đã lưu",
      "someThingWentWrong": "Đã xảy ra lỗi"
    },
    "password": {"label": "Mật khẩu"},
    "search": {
      "filter": {
        "accountTypes": "Các loại tài khoản",
        "sections": "Các mục",
        "title": "Bộ lọc"
      },
      "noResults": "Không tìm thấy mật khẩu nào",
      "title": "Tìm kiếm mật khẩu..."
    },
    "success": {
      "passwordDeleted": "Đã xóa mật khẩu thành công",
      "passwordSaved": "Đã lưu mật khẩu thành công",
      "passwordUpdated": "Cập nhật mật khẩu thành công"
    },
    "warnings": {
      "keyRequired": "Yêu cầu khóa",
      "nameRequired": "Tên là bắt buộc",
      "passwordAndKeyRequired": "Yêu cầu mật khẩu và khóa",
      "passwordAndNameRequired": "Mật khẩu và tên là bắt buộc",
      "passwordNameRequired": "Tên của mật khẩu là bắt buộc",
      "passwordRequired": "Mật khẩu là bắt buộc",
      "selectAtLeastOne": "Chọn ít nhất một tùy chọn"
    }
  };
  static const Map<String, Map<String, dynamic>> mapLocales = {
    "en_US": en_US,
    "vi_VN": vi_VN
  };
}
