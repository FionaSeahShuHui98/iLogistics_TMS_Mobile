class ServiceTier {
  ServiceTier({
    required this.serviceid,
    required this.servicename,
    required this.servicepricing,
  });
  late final int serviceid;
  late final String servicename;
  late final int servicepricing;

  ServiceTier.fromJson(Map<String, dynamic> json) {
    serviceid = json['serviceid'];
    servicename = json['servicename'];
    servicepricing = json['servicepricing'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['serviceid'] = serviceid;
    _data['servicename'] = servicename;
    _data['servicepricing'] = servicepricing;
    return _data;
  }
}
