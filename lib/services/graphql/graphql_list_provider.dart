import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:viettel_app/src/login/controllers/auth_controller.dart';
import 'crud_repo.dart';

abstract class GraphqlListProvider<T> extends GetxController {
  final CrudRepository<T> service;
  Rx<List<T>> items = Rx<List<T>>([]);
  int total = 0;
  Rx<Pagination> pagination = Rx(Pagination(
    limit: 10,
    offset: 0,
    page: 1,
    total: 0,
  ));
  QueryInput query = QueryInput(limit: 10, page: 1);
  late String fragment;

  GraphqlListProvider(
      {required this.service,
      QueryInput? query,
      required String fragment}) {
    this.fragment = fragment;
    if(service.isLoginRequired == true && Get.find<AuthController>().isLogged() == false)
      return;
    this.loadAll(query: query);
  }

  Future<List<T>> loadAll({QueryInput? query}) {
    this.query = query == null
        ? this.query
        // : QueryInput.fromJson({...this.query.toJson(), ...query.toJson()});
        : QueryInput.fromJson(mapData(this.query.toJson(), query.toJson()));

    if(this.service.isPaging == false){
      this.query = QueryInput.fromJson(transQueryToWithoutPaging(this.query.toJson()));
    }
    print("json query loadAll: ${this.query.toJson()}");

    return service
        .getAll(query: this.query, fragment: this.fragment)
        .then((res) {
      items.value = res.data;
      pagination.value = res.pagination;
      total = res.total;
      // pagination.notifyListeners();
      update();
      return res.data;
    });
  }

  Future<T> create(dynamic data) {
    return service.create(data: data, fragment: fragment).then((res) {
      this.loadAll();
      return res;
    });
  }

  Future<T> updateData(String id, dynamic data) {
    return service.update(id: id, data: data, fragment: fragment).then((res) {
      this.loadAll();
      return res;
    });
  }

  Future<T> delete(String id) {
    return service.delete(id: id, fragment: fragment).then((res) {
      this.loadAll();
      return res;
    });
  }

  mapData(Map<String, dynamic> map1, Map<String, dynamic> map2) {
    Map<String, dynamic> object = map1;
    if (map1.keys.length > map2.keys.length) {
      object = {...map2, ...map1};
    } else {
      if (map1.keys.length < map2.keys.length) {
        object = {...map1, ...map2};
      }
    }
    map1.keys.forEach((element) {
      if (map2[element] != null) map1[element] = map2[element];
    });
    object = map1;
    // print("mapData----- $object");
    return object;
  }

  transQueryToWithoutPaging(Map<String, dynamic> map){
    map["limit"] = null;
    map["offset"] = null;

    return map;
  }
}
