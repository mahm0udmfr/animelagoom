import 'package:animelagoom/models/app_user_model.dart';

import '../core/api/api_manager.dart';

class UserService {
  final KitsuApiManager _api;

  UserService(this._api);

  Future<AppUser> getUserById(String userId) async {
    final json = await _api.get('/users/$userId');
    return AppUser.fromJson(json['data']);
  }

  Future<List<AppUser>> searchUsers(String query) async {
    final json = await _api.get('/users', queryParams: {
      'filter[name]': query,
    });
    return (json['data'] as List)
        .map((e) => AppUser.fromJson(e))
        .toList();
  }
}
