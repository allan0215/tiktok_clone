class VideoModel {
  final String title, description, fileURL, thumbnailURL, creatorUid, creator;
  final int likes, comments, createdAt;

  VideoModel({
    required this.description,
    required this.fileURL,
    required this.thumbnailURL,
    required this.creatorUid,
    required this.creator,
    required this.likes,
    required this.comments,
    required this.createdAt,
    required this.title,
  });

  VideoModel.onlyTitle({required this.title})
      : description = "",
        fileURL = "",
        thumbnailURL = "",
        creatorUid = "",
        creator = "",
        likes = 0,
        comments = 0,
        createdAt = 0;

  VideoModel.fromJson(Map<String, dynamic> json)
      : title = json["title"],
        description = json["description"],
        fileURL = json["fileURL"],
        thumbnailURL = json["thumbnailURL"],
        creatorUid = json["creatorUid"],
        creator = json["creator"],
        likes = json["likes"],
        comments = json["comments"],
        createdAt = json["createdAt"];

  Map<String, dynamic> toJson() {
    return {
      "title": title,
      "description": description,
      "fileURL": fileURL,
      "thumbnailURL": thumbnailURL,
      "creatorUid": creatorUid,
      "creator": creator,
      "likes": likes,
      "comments": comments,
      "createdAt": createdAt,
    };
  }
}
