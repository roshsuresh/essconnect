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
    d = json['d'] != null ? new BusDataList.fromJson(json['d']) : null;
    metaD = json['meta_d'] != null ? new MetaD.fromJson(json['meta_d']) : null;
    serialNo = json['serial_no'];
    imeiNo = json['imei_no'];
    createdDate = json['created_date'];
    createdBy = json['created_by'];
    sourceDate = json['source_date'];
    receivedDate = json['received_date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    if (this.d != null) {
      data['d'] = this.d!.toJson();
    }
    if (this.metaD != null) {
      data['meta_d'] = this.metaD!.toJson();
    }
    data['serial_no'] = this.serialNo;
    data['imei_no'] = this.imeiNo;
    data['created_date'] = this.createdDate;
    data['created_by'] = this.createdBy;
    data['source_date'] = this.sourceDate;
    data['received_date'] = this.receivedDate;
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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['server'] = this.server;
    data['data'] = this.data;
    data['latitude'] = this.latitude;
    data['hst'] = this.hst;
    data['main_power'] = this.mainPower;
    data['alt'] = this.alt;
    data['nw_operator'] = this.nwOperator;
    data['speed'] = this.speed;
    data['satellite_count'] = this.satelliteCount;
    data['imei_no'] = this.imeiNo;
    data['vehicle_mode'] = this.vehicleMode;
    data['gsm_signal_strength'] = this.gsmSignalStrength;
    data['gnss_fix'] = this.gnssFix;
    data['ignition'] = this.ignition;
    data['serial_no'] = this.serialNo;
    data['packet_type'] = this.packetType;
    data['valid_status'] = this.validStatus;
    data['longitude'] = this.longitude;
    data['source_date'] = this.sourceDate;
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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['fleet'] = this.fleet;
    data['vehicle_registration'] = this.vehicleRegistration;
    data['vendor'] = this.vendor;
    data['dealer'] = this.dealer;
    data['distributor'] = this.distributor;
    return data;
  }
}
