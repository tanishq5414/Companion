class MessageModel {
  String? message;
  String? messageid;
  String? senderid;
  String? sendername;
  String? senderPhotoUrl;
  String? timestamp;

  MessageModel(
      {this.message,
      this.messageid,
      this.senderid,
      this.sendername,
      this.senderPhotoUrl,
      this.timestamp});

  MessageModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    messageid = json['messageid'];
    senderid = json['senderid'];
    sendername = json['sendername'];
    senderPhotoUrl = json['senderPhotoUrl'];
    timestamp = json['timestamp'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    data['messageid'] = this.messageid;
    data['senderid'] = this.senderid;
    data['sendername'] = this.sendername;
    data['senderPhotoUrl'] = this.senderPhotoUrl;
    data['timestamp'] = this.timestamp;
    return data;
  }
}
