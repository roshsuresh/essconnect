class Data {
  String? id;
  BusDataList? d;
  MetaD? metaD;
  String? serialNo;
  String? imeiNo;
  int? createdDate;
  String? createdBy;
  int? sourceDate;
  int? receivedDate;

  Data(
      {this.id,
      this.d,
      this.metaD,
      this.serialNo,
      this.imeiNo,
      this.createdDate,
      this.createdBy,
      this.sourceDate,
      this.receivedDate});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    d = json['d'] != null ? BusDataList.fromJson(json['d']) : null;
    metaD = json['meta_d'] != null ? MetaD.fromJson(json['meta_d']) : null;
    serialNo = json['serial_no'];
    imeiNo = json['imei_no'];
    createdDate = json['created_date'];
    createdBy = json['created_by'];
    sourceDate = json['source_date'];
    receivedDate = json['received_date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    if (d != null) {
      data['d'] = d!.toJson();
    }
    if (metaD != null) {
      data['meta_d'] = metaD!.toJson();
    }
    data['serial_no'] = serialNo;
    data['imei_no'] = imeiNo;
    data['created_date'] = createdDate;
    data['created_by'] = createdBy;
    data['source_date'] = sourceDate;
    data['received_date'] = receivedDate;
    return data;
  }
}

class BusDataList {
  String? server;
  String? data;
  String? latitude;
  bool? hst;
  String? mainPower;
  double? alt;
  String? nwOperator;
  double? speed;
  int? satelliteCount;
  String? imeiNo;
  String? vehicleMode;
  int? gsmSignalStrength;
  int? gnssFix;
  String? ignition;
  String? serialNo;
  String? packetType;
  bool? validStatus;
  String? longitude;
  int? sourceDate;

  BusDataList(
      {this.server,
      this.data,
      this.latitude,
      this.hst,
      this.mainPower,
      this.alt,
      this.nwOperator,
      this.speed,
      this.satelliteCount,
      this.imeiNo,
      this.vehicleMode,
      this.gsmSignalStrength,
      this.gnssFix,
      this.ignition,
      this.serialNo,
      this.packetType,
      this.validStatus,
      this.longitude,
      this.sourceDate});

  BusDataList.fromJson(Map<String, dynamic> json) {
    server = json['server'];
    data = json['data'];
    latitude = json['latitude'];
    hst = json['hst'];
    mainPower = json['main_power'];
    alt = json['alt'];
    nwOperator = json['nw_operator'];
    speed = json['speed'];
    satelliteCount = json['satellite_count'];
    imeiNo = json['imei_no'];
    vehicleMode = json['vehicle_mode'];
    gsmSignalStrength = json['gsm_signal_strength'];
    gnssFix = json['gnss_fix'];
    ignition = json['ignition'];
    serialNo = json['serial_no'];
    packetType = json['packet_type'];
    validStatus = json['valid_status'];
    longitude = json['longitude'];
    sourceDate = json['source_date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['server'] = server;
    data['data'] = this.data;
    data['latitude'] = latitude;
    data['hst'] = hst;
    data['main_power'] = mainPower;
    data['alt'] = alt;
    data['nw_operator'] = nwOperator;
    data['speed'] = speed;
    data['satellite_count'] = satelliteCount;
    data['imei_no'] = imeiNo;
    data['vehicle_mode'] = vehicleMode;
    data['gsm_signal_strength'] = gsmSignalStrength;
    data['gnss_fix'] = gnssFix;
    data['ignition'] = ignition;
    data['serial_no'] = serialNo;
    data['packet_type'] = packetType;
    data['valid_status'] = validStatus;
    data['longitude'] = longitude;
    data['source_date'] = sourceDate;
    return data;
  }
}

class MetaD {
  String? fleet;
  String? vehicleRegistration;
  String? vendor;
  String? dealer;
  String? distributor;

  MetaD(
      {this.fleet,
      this.vehicleRegistration,
      this.vendor,
      this.dealer,
      this.distributor});

  MetaD.fromJson(Map<String, dynamic> json) {
    fleet = json['fleet'];
    vehicleRegistration = json['vehicle_registration'];
    vendor = json['vendor'];
    dealer = json['dealer'];
    distributor = json['distributor'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['fleet'] = fleet;
    data['vehicle_registration'] = vehicleRegistration;
    data['vendor'] = vendor;
    data['dealer'] = dealer;
    data['distributor'] = distributor;
    return data;
  }
}
