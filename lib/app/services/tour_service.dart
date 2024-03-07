import 'package:discoverrd/app/models/dtos/tour_dto.dart';
import 'package:discoverrd/app/models/dtos/tour_search_dto.dart';
import 'package:discoverrd/app/models/tour_rating.dart';
import 'package:discoverrd/app/models/tour_reserve_view.dart';
import 'package:discoverrd/app/models/tour_view.dart';
import 'package:discoverrd/app/services/base/api_service.dart';
import 'package:get/get.dart';
import 'package:dio/dio.dart' as dio;

class TourService {
  final ApiService _apiService = Get.find<ApiService>();

  register(TourDto tour) async {
    try {
      var formData = dio.FormData.fromMap(tour.toJson());
      await _apiService.post('/tour', formData);
    } catch (e) {
      throw (e);
    }
  }

  edit(TourDto tour) async {
    try {
      var formData = dio.FormData.fromMap(tour.toJson());
      await _apiService.put('/tour', formData);
    } catch (e) {
      throw (e);
    }
  }

  Future<List<TourView>> getAllAgency() async {
    try {
      var result = await _apiService.getAll('/tour/all/agency');

      var list = result.map((data) => TourView.fromJson(data)).toList();
      return List<TourView>.from(list);
    } catch (e) {
      throw (e);
    }
  }

  Future<List<TourView>> popular() async {
    try {
      var result = await _apiService.getAll('/tour/popular');

      var list = result.map((data) => TourView.fromJson(data)).toList();
      return List<TourView>.from(list);
    } catch (e) {
      throw (e);
    }
  }

  Future<List<TourView>> likes() async {
    try {
      var result = await _apiService.getAll('/tour/likes');

      var list = result.map((data) => TourView.fromJson(data)).toList();
      return List<TourView>.from(list);
    } catch (e) {
      throw (e);
    }
  }

  Future<List<TourReserveView>> reserves() async {
    try {
      var result = await _apiService.getAll('/tour/reserves');

      var list = result.map((data) => TourReserveView.fromJson(data)).toList();
      return List<TourReserveView>.from(list);
    } catch (e) {
      throw (e);
    }
  }

  Future<List<TourView>> search(TourSeachDto data) async {
    try {
      var result = await _apiService.post('/tour/search', data.toJson());
      var list = result.map((data) => TourView.fromJson(data)).toList();
      return List<TourView>.from(list);
    } catch (e) {
      throw (e);
    }
  }

  Future<TourView> getByid(id) async {
    try {
      var result = await _apiService.getAll('/tour/id/$id');
      return TourView.fromJson(result);
    } catch (e) {
      throw (e);
    }
  }

  Future<TourReserveView> getReserveByid(id) async {
    try {
      var result = await _apiService.getAll('/tour/reserve/id/$id');
      return TourReserveView.fromJson(result);
    } catch (e) {
      throw (e);
    }
  }

  Future<void> delete(id) async {
    try {
      await _apiService.delete('/tour', id);
    } catch (e) {
      throw (e);
    }
  }

  Future<void> like(int id) async {
    try {
      await _apiService.post('/tour/like/$id', null);
    } catch (e) {
      throw (e);
    }
  }

  Future<void> rating(TourRating data) async {
    try {
      await _apiService.post('/tour/rate/', data.toJson());
    } catch (e) {
      throw (e);
    }
  }

  Future<bool> checkRating(int id) async {
    try {
      final res = await _apiService.post('/tour/CheckRate/$id', null);
      return res;
    } catch (e) {
      throw (e);
    }
  }

  Future<void> dislike(int id) async {
    try {
      await _apiService.post('/tour/dislike/$id', null);
    } catch (e) {
      throw (e);
    }
  }
}
