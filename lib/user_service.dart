import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class UserService {
  static const String _key = 'user_storage_key';

  static Future<SharedPreferences> _getPrefs() async => await SharedPreferences.getInstance();

  static Future<List<Map<String, dynamic>>> getUsers() async {
    final prefs = await _getPrefs();
    final String? data = prefs.getString(_key);
    if (data == null) return [];
    final List decoded = jsonDecode(data);
    return decoded.map((e) => Map<String, dynamic>.from(e)).toList();
  }

  static Future<void> insup({
    String? id,
    required String ndepan,
    required String nbelakang,
    required String mail,
    required String usr,
    required String pwd,
    String? photoPath,
  }) async {
    final prefs = await _getPrefs();
    List<Map<String, dynamic>> users = await getUsers();

    if (id != null) {
      int index = users.indexWhere((e) => e['id'] == id);
      if (index != -1) {
        users[index] = {
          'id': id,
          'nama_depan': ndepan,
          'nama_belakang': nbelakang,
          'email': mail,
          'username': usr,
          'photo': photoPath ?? users[index]['photo'],
        };
      }
    } else {
      users.add({
        'id': DateTime.now().millisecondsSinceEpoch.toString(),
        'nama_depan': ndepan,
        'nama_belakang': nbelakang,
        'email': mail,
        'username': usr,
        'photo': photoPath ?? '',
      });
    }
    await prefs.setString(_key, jsonEncode(users));
  }

  static Future<void> deleteUser(String id) async {
    final prefs = await _getPrefs();
    List<Map<String, dynamic>> users = await getUsers();
    users.removeWhere((e) => e['id'] == id);
    await prefs.setString(_key, jsonEncode(users));
  }
}