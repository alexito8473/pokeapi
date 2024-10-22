part of 'connectivity_cubit.dart';

@immutable
sealed class ConnectivityState {
  final bool haveWifi;
  const ConnectivityState({required this.haveWifi});
}

final class ConnectivityInitial extends ConnectivityState {
  const ConnectivityInitial({super.haveWifi = false});
}

final class ConnectivityWifiOn extends ConnectivityState {
  const ConnectivityWifiOn({super.haveWifi = true});
}

final class ConnectivityWifiOff extends ConnectivityState {
  const ConnectivityWifiOff({super.haveWifi = false});
}
