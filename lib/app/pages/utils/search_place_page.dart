import 'package:discoverrd/app/config/app_config.dart';
import 'package:discoverrd/app/config/theme_config.dart';
import 'package:discoverrd/app/widgets/back_button_widget.dart';
import 'package:discoverrd/app/widgets/input_flat_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_place/google_place.dart';

class SearchPlacePage<T extends GetxController> extends StatefulWidget {

  SearchPlacePage({this.pageTitle, this.types, this.input, this.initialValue});
  final String? pageTitle;
  final String? types;
  final String? input;
  final String? initialValue;


  @override
  _SearchPlacePageState<T> createState() => _SearchPlacePageState<T>();
}

class _SearchPlacePageState<T extends GetxController> extends State<SearchPlacePage<T>> {
  late GooglePlace googlePlace;
  List<AutocompletePrediction> predictions = [];

  @override
  void initState() {
    googlePlace = GooglePlace(AppConfig.GOOGLE_API_KEY);
    super.initState();
  }

    void autoCompleteSearch(String value) async {

      var result = await googlePlace.autocomplete.get(value, language: 'es', types: widget.types, components: [Component('country', 'do')] );
      if (result != null && result.predictions != null && mounted) {
        setState(() {
          if(result.predictions != null && result.predictions!.length > 0){
            predictions = result.predictions!;
            print(predictions[0]);
          }
        
        });
      }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child: Container(
        child: Column(
          mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 10, right: 10, top: 8),
                child: Row(
                  children: [
                    BackButtonWidget(),
                    Expanded(child: Padding(
                      padding: const EdgeInsets.only(right: 64),
                      child: Text(widget.pageTitle ?? '', 
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
                    ))
                  ],
                ),
              ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 15),
              child: InputFlatWidget(text: 'Buscar...', 
              initialValue: widget.initialValue,
                onChanged: (value) {
                  if (value.isNotEmpty) {
                    autoCompleteSearch(value);
                  } else {
                    if (predictions.length > 0 && mounted) {
                      setState(() {
                        predictions = [];
                      });
                    }
                  }
                },
              ),
            ),
            Expanded(
              child: ListView.separated(
                itemCount: predictions.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    leading: Icon(
                      Icons.place,
                      color: primaryColor,
                      size: 32,
                    ),
                    title: Text(predictions[index].description!, style: TextStyle(color: Colors.black.withOpacity(0.8))),
                    onTap: () {
                     Get.back(result: predictions[index]);
                    },
                  );
                }, separatorBuilder: (BuildContext context, int index) {  return Divider(); },
              ),
            )
          ]),
      )),
    );

  }
}
