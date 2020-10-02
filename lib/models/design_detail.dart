///
/// The Class for the brand API theme
///
///
class DesignDetail {
  final String id;
  final String catalogid;
  final String title;
  final String alias;
  final String picture;
  final String poster;
  final String description;
  final String category;
  final String public;
  final String adddate;
  final String viewnum;

  DesignDetail({this.id, this.catalogid, this.title, this.alias, this.picture, this.poster, this.description, this.category, this.public, this.adddate, this.viewnum, });

  factory DesignDetail.fromJson(Map<String, dynamic> json) {
    return DesignDetail(
      id: json['id'],
      catalogid: json['catalogid'],
      title: json['title'],
      alias: json['alias'],
      picture: 'https://itsthebrand.com/taswira.php?width=500&height=500&quality=100&cropratio=1:1&image=/v/uploads/gallery/${json['picture']}',
      poster: 'https://itsthebrand.com/taswira.php?width=500&height=500&quality=100&cropratio=1:1&image=/v/uploads/gallery/${json['poster']}',
      description: json['description'],
      category: json['category'],
      public: json['public'],
      adddate: json['adddate'],
      viewnum: json['viewnum'],
    );
  }
}
