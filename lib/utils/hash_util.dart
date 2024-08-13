import 'package:crypto/crypto.dart';
import 'dart:convert';

class HashUtil {
  // SHA256 해시화 메서드
  static String hashPassword(String password) {
    // 비밀번호를 바이트로 변환
    final bytes = utf8.encode(password);
    // SHA256 해시를 계산
    final digest = sha256.convert(bytes);
    // 해시를 16진수 문자열로 변환
    return digest.toString();
  }
}
