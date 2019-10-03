
String getTimeStamp(int milliseconds) {
  int seconds = (milliseconds / 1000).truncate();
  int minutes = (seconds / 60).truncate();

  String minutesStr = (minutes % 60).toString().padLeft(2, '0');
  String secondsStr = (seconds % 60).toString().padLeft(2, '0');

  return "$minutesStr:$secondsStr";
}

String getTimeStamps(double duration) {
  int seconds = int.parse(((duration).truncate()).toString());
  int minutes = (seconds / 60).truncate();

  String minutesStr = (minutes % 60).toString().padLeft(2, '0');
  String secondsStr = (seconds % 60).toString().padLeft(2, '0');

  return "$minutesStr:$secondsStr";
}

int stamp2int(final String stamp) {
  // 00:00
  final int indexOfColon = stamp.indexOf(":");
  final int minute = int.parse(stamp.substring(0, indexOfColon));
  final int second = int.parse(stamp.substring(indexOfColon + 1, stamp.length));
  return (((minute * 60) + second));
}