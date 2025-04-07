class ChatModel {
  late final DateTime? createdAt;
  String? senderId;
  String? reciverId;
  String? dateTime;
  String? text;
  String? profileImage;

  ChatModel({
    this.createdAt,
    this.senderId,
    this.reciverId,
    this.dateTime,
    this.text,
    this.profileImage
  });

  // The fromJson constructor now formats the time.
  ChatModel.fromJson(Map<String, dynamic> json) {
    senderId = json['senderId'];
    createdAt = json['createdAt'];


    dateTime = json['dateTime'];


    reciverId = json['reciverId'];
    text = json['text'];
    profileImage=json['profile_image'];
  }

  Map<String, dynamic> toMap() {
    return {
      'senderId': senderId,
      'createdAt': createdAt,
      'reciverId': reciverId,
      'dateTime': dateTime,  // Now contains formatted time
      'text': text,
      'profile_image':profileImage
    };
  }
}