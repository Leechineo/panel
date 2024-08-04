import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:leechineo_panel/core/domain/errors/app_error.dart';
import 'package:leechineo_panel/core/presenter/utils/show_alert_dialog.dart';
import 'package:leechineo_panel/core/presenter/widgets/app_builder.dart';

abstract class AppControllerData {
  copyWith();
}

abstract class AppController<AppControllerData, Methods> {
  final _dataStreamController = StreamController<AppControllerData>.broadcast();
  final _eventStreamController =
      StreamController<AppControllerEvent>.broadcast();

  late AppControllerData data;
  late AppControllerEvent event;
  late Methods methods;
  final List<AppControllerEvent> events;

  AppControllerData defineData();
  Methods defineMethods();
  void updateData(AppControllerData data) {
    this.data = data;
    if (!_dataStreamController.isClosed) {
      _dataStreamController.add(data);
    }
  }

  void dispatchEvent(AppControllerEvent event) {
    this.event = event;
    onEventDispatched(event);
    if (event.streamController != null) {
      event.streamController!.add(event);
    }
    _eventStreamController.add(event);
  }

  void catchError(dynamic error) {
    if (error is AppError) {
      dispatchEvent(
        AppControllerEvent<AppError>(
          id: 'catch_error',
          data: error,
        ),
      );
    }
  }

  AppBuilder<AppControllerData, AppControllerEvent> builder({
    required Widget Function(BuildContext context, AppControllerData data)
        builder,
    void Function(BuildContext context, AppControllerEvent event,
            AppControllerData data)?
        eventListener,
    bool allowAlertDialog = false,
  }) {
    return AppBuilder(
      streams: [
        _dataStreamController.stream,
        _eventStreamController.stream,
      ],
      initialData: data,
      listener: (context, data) {
        if (this.event.id == 'catch_error' && allowAlertDialog) {
          if (this.event.data is AppError) {
            showAlertDialog(
              context,
              // titleText: 'Erro',
              message: this.event.data.message,
              onClosed: () {
                dispatchEvent(
                  AppControllerEvent(
                    id: 'errorDone',
                    data: data,
                  ),
                );
              },
            );
          }
        }
        return eventListener?.call(context, this.event, this.data);
      },
      builder: (context, data) {
        return builder(context, this.data);
      },
    );
  }

  List<StreamSubscription> subscriptions = [];

  AppController({this.events = const []}) {
    data = defineData();
    methods = defineMethods();
    event = AppControllerEvent(id: 'initialEvent', data: data);

    for (final event in events) {
      if (event.streamController != null) {
        subscriptions.add(event.streamController!.stream.listen((e) {
          onEventDispatched(e);
        }));
      }
    }
  }

  void onEventDispatched(AppControllerEvent event) {}

  void dispose() {
    _dataStreamController.close();
    _eventStreamController.close();
    for (final sub in subscriptions) {
      sub.cancel();
    }
  }
}

class AppControllerEvent<D> {
  String id;
  D data;
  StreamController? streamController;

  AppControllerEvent({this.id = '', required this.data});

  AppControllerEvent<D> copyWith({
    String? id,
    D? data,
  }) {
    return AppControllerEvent<D>(
      id: id ?? this.id,
      data: data ?? this.data,
    );
  }

  void listen() {
    streamController ??= StreamController<D>();
  }

  void dispose() {
    if (streamController != null) {
      streamController!.close();
    }
  }
}
