class PreviousCatch {
  final int id;
  final String Location;
  final String Date;
  final String Time;
  final String Species;
  final double Weight;
  final String Length;
  final String Bait;

  PreviousCatch(
      {required this.id,
      required this.Location,
      required this.Date,
      required this.Time,
      required this.Species,
      required this.Weight,
      required this.Length,
      required this.Bait});

  factory PreviousCatch.fromJson(Map<dynamic, dynamic> json) {
    return PreviousCatch(
      id: json["id"],
      Location: json["Location"],
      Date: json["Date"],
      Time: json["Time"],
      Species: json["Species"],
      Weight: json["Weight"],
      Length: json["Length"],
      Bait: json["Bait"],
    );
  }
}
