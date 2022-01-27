/// id : "611e267ff4880e3c4c79567f"
/// name : "Thành phố Hồ Chí Minh"
/// current : {"temp":307.12,"humidity":49,"weather":[{"description":"mây rải rác","iconUrl":"https://openweathermap.org/img/wn/03d@2x.png"}]}

class WeatherModel {
  String? id;
  String? name;
  Current? current;

  WeatherModel({
    this.id,
    this.name,
    this.current});

  WeatherModel.fromJson(dynamic json) {
    id = json['id'];
    name = json['name'];
    current = json['current'] != null ? Current.fromJson(json['current']) : null;
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map['id'] = id;
    map['name'] = name;
    if (current != null) {
      map['current'] = current?.toJson();
    }
    return map;
  }

}

/// temp : 307.12
/// humidity : 49
/// weather : [{"description":"mây rải rác","iconUrl":"https://openweathermap.org/img/wn/03d@2x.png"}]

class Current {
  double? temp;
  num? humidity;
  num? clouds;
  List<Weather>? weather;

  Current({
    this.temp,
    this.humidity,
    this.clouds,
    this.weather});

  Current.fromJson(dynamic json) {
    temp = json['temp'];
    humidity = json['humidity'];
    clouds = json['clouds'];
    if (json['weather'] != null) {
      weather = [];
      json['weather'].forEach((v) {
        weather?.add(Weather.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map['temp'] = temp;
    map['humidity'] = humidity;
    map['clouds'] = clouds;
    if (weather != null) {
      map['weather'] = weather?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// description : "mây rải rác"
/// iconUrl : "https://openweathermap.org/img/wn/03d@2x.png"

class Weather {
  String? description;
  String? iconUrl;

  Weather({
    this.description,
    this.iconUrl});

  Weather.fromJson(dynamic json) {
    description = json['description'];
    iconUrl = json['iconUrl'];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map['description'] = description;
    map['iconUrl'] = iconUrl;
    return map;
  }

}