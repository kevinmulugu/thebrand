///
/// The Class for the design layer
///
///
class DesignLayer {
  final String text;
  final String type;
  final String alt;
  final String version;

  DesignLayer({this.text, this.type, this.alt, this.version});

  factory DesignLayer.fromJson(Map<String, dynamic> json) {
    return DesignLayer(
      text: json['text'],
      type: json['type'],
      alt: json['alt'],
      version: json['version'],
    );
  }
}
