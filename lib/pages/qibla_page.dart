import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_qiblah/flutter_qiblah.dart';
import '../blocs/qibla/qibla_bloc.dart';
import '../blocs/qibla/qibla_event.dart';
import '../blocs/qibla/qibla_state.dart';

class QiblahScreen extends StatelessWidget {
  const QiblahScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => QiblaBloc()..add(LoadQiblaDirection()),
      child: Scaffold(
        appBar: AppBar(
          title: Text('القبلة',
              style: GoogleFonts.cairo(fontWeight: FontWeight.bold)),
          backgroundColor: Colors.deepPurple,
        ),
        body: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Colors.deepPurple.shade100, Colors.white],
            ),
          ),
          child: const Column(
            children: [Expanded(child: QiblahCompass())],
          ),
        ),
      ),
    );
  }
}

class QiblahCompass extends StatelessWidget {
  const QiblahCompass({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<QiblaBloc, QiblaState>(
      builder: (context, state) {
        if (state is QiblaLoading) {
          return const LoadingIndicator();
        } else if (state is QiblaLoaded) {
          final model = state.model;
          if (model.locationStatus.status == LocationPermission.always ||
              model.locationStatus.status == LocationPermission.whileInUse) {
            return QiblahCompassWidget(direction: model.direction, offset: model.offset);
          } else {
            return LocationErrorWidget(
              error: "Location permission not granted",
              callback: () => context.read<QiblaBloc>().add(LoadQiblaDirection()),
            );
          }
        } else if (state is QiblaError) {
          return Center(child: Text(state.message));
        }
        return const SizedBox();
      },
    );
  }
}

class QiblahCompassWidget extends StatelessWidget {
  final double direction;
  final double offset;
  final SvgPicture _compassSvg = SvgPicture.asset('assets/compass.svg');
  final SvgPicture _needleSvg = SvgPicture.asset(
    'assets/needle.svg',
    fit: BoxFit.contain,
    height: 300,
    alignment: Alignment.center,
  );

  QiblahCompassWidget({Key? key, required this.direction, required this.offset}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: <Widget>[
        Transform.rotate(
          angle: (direction * (pi / 180) * -1),
          child: _compassSvg,
        ),
        Transform.rotate(
          angle: ((direction + offset) * (pi / 180) * -1),
          alignment: Alignment.center,
          child: _needleSvg,
        ),
        Positioned(
          bottom: 8,
          child: Text("${offset.toStringAsFixed(3)}°"),
        )
      ],
    );
  }
}
class LocationErrorWidget extends StatelessWidget {
  final String error;
  final Function callback;

  const LocationErrorWidget({Key? key, required this.error, required this.callback})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    const box = SizedBox(height: 32);
    const errorColor = Color(0xffb00020);

    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          const Icon(
            Icons.location_off,
            size: 150,
            color: errorColor,
          ),
          box,
          Text(
            error,
            style: const TextStyle(color: errorColor, fontWeight: FontWeight.bold),
          ),
          box,
          ElevatedButton(
            child: const Text("Retry"),
            onPressed: () => callback(),
          )
        ],
      ),
    );
  }
}

class LoadingIndicator extends StatelessWidget {
  const LoadingIndicator({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => const Center(
    child: CircularProgressIndicator.adaptive(),
  );
}