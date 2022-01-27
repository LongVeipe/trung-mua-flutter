import 'package:viettel_app/models/weather/weather_model.dart';
import 'package:viettel_app/services/graphql/crud_repo.dart';
import 'package:viettel_app/services/graphql/graphql_list_load_more_provider.dart';

class WeatherController extends GraphqlListLoadMoreProvider<WeatherModel> {

  static WeatherProvider weatherProvider=WeatherProvider();

  WeatherController({query})
      : super(service: weatherProvider, query: query, fragment: """
      id
      name
      current{
        temp
        humidity
        clouds
        weather{
          description
          iconUrl
        }
      }
  """);

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
  }

}

class WeatherProvider extends CrudRepository<WeatherModel> {
  WeatherProvider() : super(apiName: "Weather");

  @override
  WeatherModel fromJson(Map<String, dynamic> json) {
    // TODO: implement fromJson
    return WeatherModel.fromJson(json);
  }
}
