class Hotline {
  // Declaration
  Hotline({
    required this.hotlineid,
    required this.hotlineName,
    required this.hotlineNo,
    required this.userid,
  });
  late final int hotlineid;
  late final String hotlineName;
  late final int hotlineNo;
  late final int userid;

  // Receive Data from Server
  Hotline.fromJson(Map<String, dynamic> json){
    hotlineid = json['hotlineid'];
    hotlineName = json['hotlineName'];
    hotlineNo = json['hotlineNo'];
    userid = json['userid'];
  }

  // Send Data from Server
  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['hotlineid'] = hotlineid;
    _data['hotlineName'] = hotlineName;
    _data['hotlineNo'] = hotlineNo;
    _data['userid'] = userid;
    return _data;
  }
}