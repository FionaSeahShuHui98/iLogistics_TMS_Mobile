class User {
  User({
    required this.userid,
    required this.userpw,
    required this.email,
    required this.phone,
    this.employmentid,
    required this.role,
    required this.address,
    this.EName,
    this.EContactNo,
    this.EHomeAddr,
    required this.DOB,
    required this.vehicleLicense,
    required this.VehicleType,
    required this.name,
    this.delbool,
    required this.salt,
  });
  late final int userid;
  late final String userpw;
  late final String email;
  late final int phone;
  late final Null employmentid;
  late final String role;
  late final String address;
  late final Null EName;
  late final Null EContactNo;
  late final Null EHomeAddr;
  late final String DOB;
  late final String vehicleLicense;
  late final String VehicleType;
  late final String name;
  late final Null delbool;
  late final String salt;

  User.fromJson(Map<String, dynamic> json) {
    userid = json['userid'];
    userpw = json['userpw'];
    email = json['email'];
    phone = json['phone'];
    employmentid = null;
    role = json['role'];
    address = json['address'];
    EName = null;
    EContactNo = null;
    EHomeAddr = null;
    DOB = json['DOB'];
    vehicleLicense = json['vehicle_license'];
    VehicleType = json['VehicleType'];
    name = json['name'];
    delbool = null;
    salt = json['salt'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['userid'] = userid;
    _data['userpw'] = userpw;
    _data['email'] = email;
    _data['phone'] = phone;
    _data['employmentid'] = employmentid;
    _data['role'] = role;
    _data['address'] = address;
    _data['EName'] = EName;
    _data['EContactNo'] = EContactNo;
    _data['EHomeAddr'] = EHomeAddr;
    _data['DOB'] = DOB;
    _data['vehicle_license'] = vehicleLicense;
    _data['VehicleType'] = VehicleType;
    _data['name'] = name;
    _data['delbool'] = delbool;
    _data['salt'] = salt;
    return _data;
  }
}
