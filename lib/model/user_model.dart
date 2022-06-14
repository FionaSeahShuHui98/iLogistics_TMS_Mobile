class UserModel {
String? userid;
  String? email;
  String? name;
    String? vehicleType;
      String? vehicle_license;
      String? phone;
 String? employmentid;
  String? role;
 String? address;
  String? EName;
 String? EContactNo;
  String? EHomeAddr;
 String? DOB;


 Null? delbool;
String? salt;
String? userpw;
  

  UserModel({this.userid,
   this.email,
    this.name, 
    this.vehicle_license,
    this.vehicleType,
    this.phone,
    this.employmentid,
    this.role,
    this.address,
    this.EName,
    this.EContactNo,
    this.EHomeAddr,
    this.DOB,
    this.delbool,
    this.salt,
    this.userpw
    });

  // receiving data from server
  factory UserModel.fromMap(map) {
    return UserModel(
      userid: map['userid'],
      email: map['email'],
      name: map['name'],
      vehicle_license:map['vehicle_license'],
       vehicleType:map['vehicleType'],
       phone: map['phone'],
       employmentid: map['employmentid'],
       role: map['role'],
       address: map['address'],
       EName: map['EName'],
       EContactNo: map['EContactNo'],
       EHomeAddr: map['EhomeAddr'],
       DOB: map['DOB'],
       delbool: map['delbool'],
       salt: map['salt'],
       userpw: map['userpw']
    );
  }

  // sending data to our server
  Map<String, dynamic> toMap() {
    return {
      'uid': userid,
      'email': email,
    'userpw' : userpw,
    'phone' : phone,
    'employmentid' : employmentid,
    'role' : role,
    'address' : address,
    'EName' : EName,
    'EContactNo' : EContactNo,
    'EHomeAddr' : EHomeAddr,
    'DOB' : DOB,
    'vehicle_license' : vehicle_license,
    'VehicleType' : vehicleType,
    'name' : name,
    'delbool' : delbool,
    'salt' : salt
  
    
    };
  }
}
