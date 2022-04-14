class Job {
  // Decalaration
  Job({
    required this.jobno,
    required this.subcustomerid,
    required this.customerid,
    required this.driverid,
    required this.pickupaddr1,
    required this.pickupaddr2,
    required this.pickupaddrpostal,
    required this.altref,
    required this.deliveryaddr1,
    required this.deliveryaddr2,
    required this.deliveryaddrpostal,
    required this.weight,
    required this.activationdate,
    required this.predEta,
    this.actualEta,
    required this.remarks,
    required this.jobType,
    required this.quantity,
    required this.status,
    required this.predPickuptime,
    this.actualPickuptime,
    this.podid,
    required this.serviceid,
    required this.jobCategory,
    required this.pickupcontactname,
    required this.pickupcontactno,
    required this.deliverycontactname,
    required this.deliverycontactno,
    required this.ItemDesc,
    required this.DoNo,
    this.tempdel,
    required this.id,
  });
  late final dynamic jobno;
  late final dynamic subcustomerid;
  late final dynamic customerid;
  late final dynamic driverid;
  late final dynamic pickupaddr1;
  late final dynamic pickupaddr2;
  late final dynamic pickupaddrpostal;
  late final dynamic altref;
  late final dynamic deliveryaddr1;
  late final dynamic deliveryaddr2;
  late final dynamic deliveryaddrpostal;
  late final dynamic weight;
  late final dynamic activationdate;
  late final dynamic predEta;
  late final dynamic actualEta;
  late final dynamic remarks;
  late final dynamic jobType;
  late final dynamic quantity;
  late final dynamic status;
  late final dynamic predPickuptime;
  late final dynamic actualPickuptime;
  late final dynamic podid;
  late final dynamic serviceid;
  late final dynamic jobCategory;
  late final dynamic pickupcontactname;
  late final dynamic pickupcontactno;
  late final dynamic deliverycontactname;
  late final dynamic deliverycontactno;
  late final dynamic ItemDesc;
  late final dynamic DoNo;
  late final dynamic tempdel;
  late final dynamic  id;

  // Receive Data from Server
  Job.fromJson(Map<String, dynamic> json){
    jobno = json['jobno'];
    subcustomerid = json['subcustomerid'];
    customerid = json['customerid'];
    driverid = json['driverid'];
    pickupaddr1 = json['pickupaddr1'];
    pickupaddr2 = json['pickupaddr2'];
    pickupaddrpostal = json['pickupaddrpostal'];
    altref = json['altref'];
    deliveryaddr1 = json['deliveryaddr1'];
    deliveryaddr2 = json['deliveryaddr2'];
    deliveryaddrpostal = json['deliveryaddrpostal'];
    weight = json['weight'];
    activationdate = json['activationdate'];
    predEta = json['pred_eta'];
    actualEta = null;
    remarks = json['remarks'];
    jobType = json['job_type'];
    quantity = json['quantity'];
    status = json['status'];
    predPickuptime = json['pred_pickuptime'];
    actualPickuptime = null;
    podid = null;
    serviceid = json['serviceid'];
    jobCategory = json['job_category'];
    pickupcontactname = json['pickupcontactname'];
    pickupcontactno = json['pickupcontactno'];
    deliverycontactname = json['deliverycontactname'];
    deliverycontactno = json['deliverycontactno'];
    ItemDesc = json['ItemDesc'];
    DoNo = json['Do_no'];
    tempdel = null;
    id = json['id'];
  }

  // Send Data from Server
  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['jobno'] = jobno;
    _data['subcustomerid'] = subcustomerid;
    _data['customerid'] = customerid;
    _data['driverid'] = driverid;
    _data['pickupaddr1'] = pickupaddr1;
    _data['pickupaddr2'] = pickupaddr2;
    _data['pickupaddrpostal'] = pickupaddrpostal;
    _data['altref'] = altref;
    _data['deliveryaddr1'] = deliveryaddr1;
    _data['deliveryaddr2'] = deliveryaddr2;
    _data['deliveryaddrpostal'] = deliveryaddrpostal;
    _data['weight'] = weight;
    _data['activationdate'] = activationdate;
    _data['pred_eta'] = predEta;
    _data['actual_eta'] = actualEta;
    _data['remarks'] = remarks;
    _data['job_type'] = jobType;
    _data['quantity'] = quantity;
    _data['status'] = status;
    _data['pred_pickuptime'] = predPickuptime;
    _data['actual_pickuptime'] = actualPickuptime;
    _data['podid'] = podid;
    _data['serviceid'] = serviceid;
    _data['job_category'] = jobCategory;
    _data['pickupcontactname'] = pickupcontactname;
    _data['pickupcontactno'] = pickupcontactno;
    _data['deliverycontactname'] = deliverycontactname;
    _data['deliverycontactno'] = deliverycontactno;
    _data['ItemDesc'] = ItemDesc;
    _data['Do_no'] = DoNo;
    _data['tempdel'] = tempdel;
    _data['id'] = id;
    return _data;
  }
}