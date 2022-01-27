import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:viettel_app/models/weather/weather_model.dart';
import 'package:viettel_app/services/graphql/crud_repo.dart';
import 'package:viettel_app/shared/widget/widget_image_network.dart';
import 'package:viettel_app/src/home/controllers/weather_controller.dart';

import '../../../export.dart';
import 'widget_icon_text.dart';

class HomeWeather extends StatelessWidget {

  final WeatherController? weatherController;
  HomeWeather({Key? key,this.weatherController}) : super(key: key);

  String address = "N/A";
  String temperature = "N/A";
  String humidity = "N/A";
  String clouds = "N/A";
  String? iconWeather;

  String? typeWeather;



  @override
  Widget build(BuildContext context) {
    if(weatherController==null) return SizedBox();
    return GetBuilder<WeatherController>(
      init: weatherController,
      builder: (controller) {
        if (controller.loadMoreItems.value.length > 0) {
          address = controller.loadMoreItems.value.first.name ?? "N/A";
          temperature = controller.loadMoreItems.value.first.current?.temp
                  ?.toStringAsFixed(0) ??
              "N/A";
          humidity = controller.loadMoreItems.value.first.current?.humidity
                  ?.toStringAsFixed(0) ??
              "N/A";
          clouds = controller.loadMoreItems.value.first.current?.clouds
                  ?.toStringAsFixed(0) ??
              "N/A";
          iconWeather = controller
              .loadMoreItems.value.first.current?.weather?.first.iconUrl;
          typeWeather = controller
              .loadMoreItems.value.first.current?.weather?.first.description;
        }
        return Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    address,
                    style: StyleConst.regularStyle( height: 1.3),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Text(
                        "$temperature°C",
                        style: StyleConst.boldStyle(fontSize: 28),
                      ),
                      SizedBox(
                        width: 14,
                      ),
                      Expanded(
                        child: WidgetIconText(
                          text: "$clouds%",
                          iconAsset: AssetsConst.iconWeather1,
                          style: StyleConst.boldStyle(fontSize: 15),
                        ),
                      ),
                      Expanded(
                        child: WidgetIconText(
                          text: "$humidity%",
                          iconAsset: AssetsConst.iconWeather2,
                          style: StyleConst.boldStyle(fontSize: 15),
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
            SizedBox(
              width: 10,
            ),
            iconWeather != null
                ? Column(
                    children: [
                      WidgetImageNetWork(
                        url: iconWeather ?? "",
                        width: 93,
                        height: 68,
                        fit: BoxFit.cover,
                      ),

                      Text(
                        "$typeWeather",
                        style: StyleConst.regularStyle(
                            fontStyle: FontStyle.italic),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      )
                    ],
                  )
                : Image.asset(
                    AssetsConst.imageWeather,
                    width: 93,
                    height: 68,
                  )
          ],
        );
      },
    );
  }
}
