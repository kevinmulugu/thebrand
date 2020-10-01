class BrandTheme {
  final String id;
  final String catalogid;
  final String title;
  final String picture;
  final String poster;

  BrandTheme({this.id, this.catalogid, this.title, this.picture, this.poster});

  factory BrandTheme.fromJson(Map<String, dynamic> json) {
    return BrandTheme(
      id: json['id'],
      catalogid: json['catalogid'],
      title: json['title'],
      picture: 'https://itsthebrand.com/taswira.php?width=500&height=500&quality=100&cropratio=1:1&image=/v/uploads/gallery/${json['picture']}',
      poster: 'https://itsthebrand.com/taswira.php?width=500&height=500&quality=100&cropratio=1:1&image=/v/uploads/gallery/${json['poster']}'
    );
  }
}
