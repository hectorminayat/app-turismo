import 'package:discoverrd/app/config/theme_config.dart';
import 'package:discoverrd/app/controllers/tour_controller.dart';
import 'package:discoverrd/app/widgets/back_button_widget.dart';
import 'package:discoverrd/app/widgets/input_flat_widget.dart';
import 'package:discoverrd/app/widgets/multi_upload_photo.dart';
import 'package:discoverrd/app/widgets/rounded_button_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jiffy/jiffy.dart';

class FormTourPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    Widget _buildChip(String label) {
      return Chip(
        backgroundColor: primaryColor,
        labelPadding: EdgeInsets.all(2.0),
        label: Text(
          label,
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        elevation: 0.0,
        padding: EdgeInsets.all(8.0),
      );
    }

    Widget _chipList(TourController controller, int categoryId, String title) {
      final list = controller.includeItems
          .where((element) =>
              element.includeCategoryId == categoryId &&
              controller.includes.contains(element.id))
          .toList();
      if (list.length == 0) return Container();
      return Container(
        decoration: BoxDecoration(
            color: secundaryColors1, borderRadius: BorderRadius.circular(20)),
        width: width,
        padding: EdgeInsets.all(10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title,
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
            Wrap(
              spacing: 6.0,
              runSpacing: 6.0,
              children: <Widget>[
                for (var i = 0; i < list.length; i++) _buildChip(list[i].name!)
              ],
            ),
            SizedBox(
              height: 20,
            ),
          ],
        ),
      );
    }

    return GetBuilder<TourController>(
        builder: (_) => Obx(() => _.loadingData.value
            ? Container(
                color: Colors.white,
                child: Center(child: CircularProgressIndicator()),
              )
            : WillPopScope(
                onWillPop: () async {
                  _.backPage();
                  return false;
                },
                child: Scaffold(
                    body: GestureDetector(
                  onTap: () => FocusScope.of(context).unfocus(),
                  child: SafeArea(
                    child: Container(
                        height: height,
                        width: width,
                        padding: EdgeInsets.only(top: 10, bottom: 0),
                        child: SingleChildScrollView(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 10, right: 10),
                                child: Container(
                                    child: Row(
                                  children: [
                                    BackButtonWidget(onPressed: _.backPage),
                                    Expanded(
                                        child: Padding(
                                      padding: const EdgeInsets.only(right: 64),
                                      child: Obx(
                                        () => Text(
                                          _.pageTile.value,
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                    ))
                                  ],
                                )),
                              ),
                              Obx(() => MultiUploadPhoto(
                                  initialImages: _.initialImages,
                                  padding: EdgeInsets.only(bottom: 6, top: 15),
                                  max: 10,
                                  onChanged: _.onChangeImages,
                                  errorText: _.validations['images'])),
                              Obx(() => Padding(
                                    padding: const EdgeInsets.only(left: 20),
                                    child: Text(
                                      "Fotos ${_.imagesLength.value}/10 • Primero elige la foto principal de la excursión.",
                                      style: TextStyle(fontSize: 13),
                                    ),
                                  )),
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 15, top: 15, right: 15),
                                child: Column(
                                  children: [
                                    //Title
                                    Obx(() => InputFlatWidget(
                                        text: 'Titulo',
                                        hintText:
                                            'Escribe un titulo descriptivo a tu excursión',
                                        controller: _.titleCtrl,
                                        errorText: _.validations['title'],
                                        hintTitle: false)),

                                    //Description
                                    Obx(() => InputFlatWidget(
                                        text: 'Descripción',
                                        hintText:
                                            'Describe la visión general de tu excursión',
                                        controller: _.descriptionCtrl,
                                        hintTitle: false,
                                        errorText: _.validations['description'],
                                        keyboardType: TextInputType.multiline)),
                                    Divider(),
                                    InkWell(
                                      onTap: _.setLocation,
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          SizedBox(height: 8),
                                          Text('Ubicación',
                                              style: TextStyle(fontSize: 18)),
                                          SizedBox(height: 10),
                                          Row(
                                            children: [
                                              Icon(
                                                Icons.place,
                                                size: 26.0,
                                                color: _.location.value != ''
                                                    ? Colors.black
                                                    : secundaryColors2,
                                              ),
                                              Obx(() => Container(
                                                    width: width * 0.85,
                                                    child: Text(
                                                        _.location.value != ''
                                                            ? _.location.value
                                                            : 'Seleccione la ubicación de tu excursión',
                                                        style: TextStyle(
                                                            fontSize: 16,
                                                            fontWeight: _
                                                                        .location
                                                                        .value !=
                                                                    ''
                                                                ? FontWeight
                                                                    .w500
                                                                : FontWeight
                                                                    .normal,
                                                            color: _.location
                                                                        .value !=
                                                                    ''
                                                                ? Colors.black
                                                                : secundaryColors2)),
                                                  ))
                                            ],
                                          ),
                                          SizedBox(height: 8),
                                        ],
                                      ),
                                    ),
                                    Divider(),

                                    InkWell(
                                      onTap: _.setMeetingPlace,
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          SizedBox(height: 8),
                                          Text('Punto de encuentro',
                                              style: TextStyle(fontSize: 18)),
                                          SizedBox(height: 10),
                                          Obx(() => _.tourMeetingPlace.value
                                                          .address !=
                                                      null ||
                                                  _.tourMeetingPlace.value
                                                          .hour !=
                                                      null
                                              ? Column(
                                                  children: [
                                                    Row(
                                                      children: [
                                                        Icon(Icons.place,
                                                            size: 26.0,
                                                            color: _.location
                                                                        .value !=
                                                                    ''
                                                                ? Colors.black
                                                                : secundaryColors2),
                                                        SizedBox(width: 4),
                                                        Obx(() => Container(
                                                              width:
                                                                  width * 0.7,
                                                              child: Text(
                                                                  _.tourMeetingPlace.value
                                                                          .address ??
                                                                      '',
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          16,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w500,
                                                                      color: Colors
                                                                          .black)),
                                                            ))
                                                      ],
                                                    ),
                                                    SizedBox(height: 15),
                                                    Row(
                                                      children: [
                                                        Icon(Icons.schedule,
                                                            size: 26.0,
                                                            color: _.location
                                                                        .value !=
                                                                    ''
                                                                ? Colors.black
                                                                : secundaryColors2),
                                                        SizedBox(width: 4),
                                                        Container(
                                                          width: width * 0.7,
                                                          child: Obx(() => Text(
                                                              _.tourMeetingPlace
                                                                      .value.hour ??
                                                                  '00:00 AM',
                                                              style: TextStyle(
                                                                  fontSize: 16,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500,
                                                                  color: Colors
                                                                      .black))),
                                                        )
                                                      ],
                                                    ),
                                                  ],
                                                )
                                              : Container(
                                                  child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .start,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Icon(
                                                          Icons
                                                              .person_pin_circle,
                                                          size: 34,
                                                          color:
                                                              secundaryColors2,
                                                        ),
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .only(
                                                                  left: 8),
                                                          child: Container(
                                                            width: width * 0.72,
                                                            child: Column(
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                              children: [
                                                                Text(
                                                                    "¿Dónde te reunirás con los participantes?",
                                                                    style: TextStyle(
                                                                        fontWeight:
                                                                            FontWeight
                                                                                .bold,
                                                                        color:
                                                                            secundaryColors2)),
                                                                Text(
                                                                    "Asegurate de que sea un lugar facil de encontrar y llegar.",
                                                                    style: TextStyle(
                                                                        color: secundaryColors2
                                                                            .withOpacity(0.8)))
                                                              ],
                                                            ),
                                                          ),
                                                        )
                                                      ]),
                                                )),
                                          SizedBox(height: 8),
                                        ],
                                      ),
                                    ),
                                    Divider(),
                                    InkWell(
                                      onTap: _.setParticipantsRequirements,
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          SizedBox(height: 8),
                                          Text(
                                              'Requisitos para los participantes',
                                              style: TextStyle(fontSize: 18)),
                                          SizedBox(height: 10),
                                          Obx(
                                              () =>
                                                  _.tourParticipantsRequirements
                                                              .value.minAge !=
                                                          null
                                                      ? Column(
                                                          children: [
                                                            Row(
                                                              children: [
                                                                Icon(
                                                                    Icons
                                                                        .calendar_today,
                                                                    size: 26.0,
                                                                    color: Colors
                                                                        .black),
                                                                SizedBox(
                                                                    width: 4),
                                                                Obx(() =>
                                                                    Container(
                                                                      width:
                                                                          width *
                                                                              0.7,
                                                                      child:
                                                                          Column(
                                                                        mainAxisAlignment:
                                                                            MainAxisAlignment.start,
                                                                        crossAxisAlignment:
                                                                            CrossAxisAlignment.start,
                                                                        children: [
                                                                          Text(
                                                                              'Edad minima: ${_.tourParticipantsRequirements.value.minAge.toString()}',
                                                                              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: Colors.black)),
                                                                          _.showKidAge.value
                                                                              ? Text('Niños hasta: ${_.tourParticipantsRequirements.value.kidAge.toString()}', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: Colors.black))
                                                                              : Container()
                                                                        ],
                                                                      ),
                                                                    ))
                                                              ],
                                                            ),
                                                          ],
                                                        )
                                                      : Container(
                                                          child: Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .start,
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                              children: [
                                                                Icon(
                                                                  Icons
                                                                      .how_to_reg,
                                                                  size: 34,
                                                                  color:
                                                                      secundaryColors2,
                                                                ),
                                                                Padding(
                                                                  padding: const EdgeInsets
                                                                          .only(
                                                                      left: 8),
                                                                  child:
                                                                      Container(
                                                                    width:
                                                                        width *
                                                                            0.72,
                                                                    child:
                                                                        Column(
                                                                      crossAxisAlignment:
                                                                          CrossAxisAlignment
                                                                              .start,
                                                                      children: [
                                                                        Text(
                                                                            "¿Quién puede participar en tu excursión?",
                                                                            style:
                                                                                TextStyle(fontWeight: FontWeight.bold, color: secundaryColors2)),
                                                                        Text(
                                                                            "Los participantes que reserven tu excursión pueden reservar cupos para mas personas, si existen requisitos especifícalos aquí.",
                                                                            style:
                                                                                TextStyle(color: secundaryColors2.withOpacity(0.8)))
                                                                      ],
                                                                    ),
                                                                  ),
                                                                )
                                                              ]),
                                                        )),
                                          SizedBox(height: 8),
                                        ],
                                      ),
                                    ),
                                    Divider(),
                                    InkWell(
                                      onTap: _.setInclude,
                                      child: Container(
                                        padding:
                                            EdgeInsets.symmetric(vertical: 8),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text('Incluye',
                                                style: TextStyle(fontSize: 18)),
                                            SizedBox(height: 10),
                                            Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Icon(
                                                    Icons.check_circle_outline,
                                                    size: 34,
                                                    color: secundaryColors2,
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 8),
                                                    child: Container(
                                                      width: width * 0.72,
                                                      child: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Text(
                                                              "¿Qué incluye la excursión?",
                                                              style: TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  color:
                                                                      secundaryColors2)),
                                                          Text(
                                                              "Agrega informacion sobre lo que puedes ofrecer.",
                                                              style: TextStyle(
                                                                  color: secundaryColors2
                                                                      .withOpacity(
                                                                          0.8))),
                                                        ],
                                                      ),
                                                    ),
                                                  )
                                                ]),
                                            Obx(() => _.includes.length > 0
                                                ? Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                        SizedBox(
                                                          height: 20,
                                                        ),
                                                        _chipList(
                                                            _, 1, "Comida"),
                                                        _chipList(
                                                            _, 2, "Bebidas"),
                                                        _chipList(
                                                            _, 3, "Equipo"),
                                                        _chipList(
                                                            _, 4, "Entradas"),
                                                      ])
                                                : Container())
                                          ],
                                        ),
                                      ),
                                    ),
                                    Divider(),
                                    InkWell(
                                      onTap: _.setDuration,
                                      child: Container(
                                        padding:
                                            EdgeInsets.symmetric(vertical: 8),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text('Duración',
                                                style: TextStyle(fontSize: 18)),
                                            SizedBox(height: 10),
                                            Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Icon(
                                                    Icons.schedule,
                                                    size: 34,
                                                    color: secundaryColors2,
                                                  ),
                                                  Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              left: 8),
                                                      child:
                                                          Obx(() => Container(
                                                                width: width *
                                                                    0.72,
                                                                child: Column(
                                                                  crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .start,
                                                                  children: [
                                                                    Text(
                                                                        "Duración de la excursión",
                                                                        style: TextStyle(
                                                                            fontWeight:
                                                                                FontWeight.bold,
                                                                            color: secundaryColors2)),
                                                                    (_.tour.value.duration ??
                                                                                0) ==
                                                                            0
                                                                        ? Text(
                                                                            "¿Cuánto dura tu excursión?",
                                                                            style: TextStyle(
                                                                                color: secundaryColors2.withOpacity(
                                                                                    0.8)))
                                                                        : Text(
                                                                            ' ${_.tour.value.duration ?? 0} ${(_.tour.value.durationType ?? 0) == 0 ? 'Horas' : 'Dias'}',
                                                                            style: TextStyle(
                                                                                fontSize: 16,
                                                                                fontWeight: FontWeight.w500,
                                                                                color: Colors.black))
                                                                  ],
                                                                ),
                                                              )))
                                                ]),
                                          ],
                                        ),
                                      ),
                                    ),
                                    Divider(),
                                    InkWell(
                                      onTap: _.setDates,
                                      child: Container(
                                        padding:
                                            EdgeInsets.symmetric(vertical: 8),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text('Fechas',
                                                style: TextStyle(fontSize: 18)),
                                            SizedBox(height: 10),
                                            Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Icon(Icons.date_range,
                                                      size: 34,
                                                      color: secundaryColors2),
                                                  Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              left: 8),
                                                      child:
                                                          Obx(() => Container(
                                                                width:
                                                                    width * 0.8,
                                                                child: Column(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .start,
                                                                  crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .start,
                                                                  children: [
                                                                    Text(
                                                                        "Fechas de la excursión",
                                                                        style: TextStyle(
                                                                            fontWeight:
                                                                                FontWeight.bold,
                                                                            color: secundaryColors2)),
                                                                    (_.tourDates.length > 0 && _.durationTypeToggle.value == 0) ||
                                                                            (_.tourDatesRange.length > 0 &&
                                                                                _.durationTypeToggle.value == 1)
                                                                        ? _.durationTypeToggle.value == 0
                                                                            ? Container(
                                                                                width: width,
                                                                                padding: EdgeInsets.all(14),
                                                                                decoration: BoxDecoration(color: secundaryColors1, borderRadius: BorderRadius.circular(10)),
                                                                                child: Column(mainAxisAlignment: MainAxisAlignment.start, crossAxisAlignment: CrossAxisAlignment.start, children: [
                                                                                  for (var i = 0; i < _.tourDates.length; i++)
                                                                                    Padding(
                                                                                      padding: const EdgeInsets.only(top: 2.0),
                                                                                      child: Text(Jiffy(_.tourDates[i].date).yMMMMd),
                                                                                    )
                                                                                ]))
                                                                            : Container(
                                                                                width: width,
                                                                                padding: EdgeInsets.all(14),
                                                                                decoration: BoxDecoration(color: secundaryColors1, borderRadius: BorderRadius.circular(10)),
                                                                                child: Column(mainAxisAlignment: MainAxisAlignment.start, crossAxisAlignment: CrossAxisAlignment.start, children: [
                                                                                  for (var i = 0; i < _.tourDatesRange.length; i++)
                                                                                    Padding(
                                                                                      padding: const EdgeInsets.only(top: 2.0),
                                                                                      child: Column(
                                                                                        mainAxisAlignment: MainAxisAlignment.start,
                                                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                                                                        children: [
                                                                                          Text('Incio: ${Jiffy(_.tourDatesRange[i].startDate).yMMMMd}'),
                                                                                          Text('Fin: ${Jiffy(_.tourDatesRange[i].endDate).yMMMMd}'),
                                                                                          SizedBox(height: 8),
                                                                                        ],
                                                                                      ),
                                                                                    )
                                                                                ]))
                                                                        : Text("Configura el calendario para tu excursión.", style: TextStyle(color: secundaryColors2.withOpacity(0.8))),
                                                                  ],
                                                                ),
                                                              )))
                                                ]),
                                          ],
                                        ),
                                      ),
                                    ),
                                    Divider(),
                                    InkWell(
                                      onTap: _.setPrice,
                                      child: Container(
                                        padding:
                                            EdgeInsets.symmetric(vertical: 8),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text('Precios',
                                                style: TextStyle(fontSize: 18)),
                                            SizedBox(height: 10),
                                            Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Icon(
                                                    Icons.money,
                                                    size: 34,
                                                    color: secundaryColors2,
                                                  ),
                                                  Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              left: 8),
                                                      child:
                                                          Obx(() => Container(
                                                                width: width *
                                                                    0.72,
                                                                child: Column(
                                                                  crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .start,
                                                                  children: [
                                                                    Text(
                                                                        "Precios de la excursión",
                                                                        style: TextStyle(
                                                                            fontWeight:
                                                                                FontWeight.bold,
                                                                            color: secundaryColors2)),
                                                                    _.tourPrice.value.adultPrice >
                                                                            0
                                                                        ? Container(
                                                                            child:
                                                                                Column(crossAxisAlignment: CrossAxisAlignment.start, mainAxisAlignment: MainAxisAlignment.start, children: [
                                                                              _.showKidAge.value
                                                                                  ? Container()
                                                                                  : SizedBox(
                                                                                      height: 6,
                                                                                    ),
                                                                              Text('${_.showKidAge.value ? 'Precio por adulto' : 'Precio por persona'} RD\$  ${_.tourPrice.value.adultPrice.toStringAsFixed(2)}', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: Colors.black)),
                                                                              _.showKidAge.value ? Text('Precio por niño: RD\$ ${_.tourPrice.value.kidPrice.toStringAsFixed(2)}', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: Colors.black)) : Container()
                                                                            ]),
                                                                          )
                                                                        : Text(
                                                                            "Configura los precios de la excursión.",
                                                                            style:
                                                                                TextStyle(color: secundaryColors2.withOpacity(0.8))),
                                                                  ],
                                                                ),
                                                              )))
                                                ]),
                                          ],
                                        ),
                                      ),
                                    ),
                                    Divider(),
                                    Container(
                                      padding:
                                          EdgeInsets.symmetric(vertical: 8),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text('Publicar',
                                              style: TextStyle(fontSize: 18)),
                                          SizedBox(height: 10),
                                          Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                Obx(() => Transform.scale(
                                                      scale: 1.5,
                                                      child: Switch(
                                                        value: (_.tour.value
                                                                        .tourStatusId ??
                                                                    0) ==
                                                                1
                                                            ? true
                                                            : false,
                                                        onChanged: (value) {
                                                          _.setPublish(value);
                                                        },
                                                        activeColor:
                                                            primaryColor,
                                                      ),
                                                    )),
                                                Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 8),
                                                    child: Container(
                                                        width: width * 0.7,
                                                        child: Text(
                                                            "Si no activa la publicacion, las personas no pueder reservar esta excursión ni encontrarlo en los resultados de búsqueda. La excursión estara oculta.")))
                                              ]),
                                        ],
                                      ),
                                    ),

                                    Divider(),
                                    RoundedButton(
                                        title: 'Guardar',
                                        padding: EdgeInsets.only(
                                            top: 20, bottom: 20),
                                        onPressed: _.submit),
                                  ],
                                ),
                              )
                            ],
                          ),
                        )),
                  ),
                )),
              )));
  }
}
