class Cast {
  List<Actor> items = new List();
  Cast();
  Cast.fromJsonList(List<dynamic> jsonList) {
    if (jsonList == null) return;

    for (var item in jsonList) {
      final actor = Actor.fromJsonMap(item);
      items.add(actor);
    }
  }
}

class Actor {
  int castId;
  String character;
  String creditId;
  int gender;
  int id;
  String name;
  int order;
  String profilePath;

  Actor({
    this.castId,
    this.character,
    this.creditId,
    this.gender,
    this.id,
    this.name,
    this.order,
    this.profilePath,
  });

  Actor.fromJsonMap(Map<String, dynamic> json) {
    castId = json['cast_id'];
    character = json['character'];
    creditId = json['credit_id'];
    gender = json['gender'];
    id = json['id'];
    name = json['name'];
    order = json['order'];
    profilePath = json['profile_path'];
  }
  String getPosterImg() {
    if (profilePath == null) {
      return 'https://edrl.berkeley.edu/wp-content/uploads/2019/06/no-image-available.jpg';
    }
    return 'https://image.tmdb.org/t/p/w500/$profilePath';
  }

  String getAssetImage() {
    return 'assets/img/loading.gif';
  }
}
