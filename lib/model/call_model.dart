class CallModel {
  // Declaration
  String? hotlineNo;
  String? userid;
  String? hotlineName;

  // Linking Declaration to Codes
  CallModel({this.hotlineNo, this.hotlineName, this.userid});

  // Receive Data from Server
  factory CallModel.fromMap(map) {
    return CallModel(
      hotlineNo: map['hotlineNo'],
      hotlineName: map['hotlineName'],
      userid: map['userid']
    );
  }

  // Send Data from Server
  Map<String, dynamic> toMap(){
    return {
      'userid': userid,
      'hotlineName': hotlineName,
      'hotlineNo':hotlineNo,
    };
  }

}