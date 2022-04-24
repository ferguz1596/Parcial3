class Fotos {
  int albumId = 0;
  int id = 0;
  String title = "";
  String url = "";
  String thumbnailUrl = "";

  Fotos(albumId, id, title, url, thumbnailUrl) {
    this.albumId = albumId;
    this.id = id;
    this.title = title;
    this.url = url;
    this.thumbnailUrl = thumbnailUrl;
  }
}
