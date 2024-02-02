class SensorsListData {
  SensorsListData({
    this.imagePath = '',
    this.titleTxt = '',
    this.startColor = '',
    this.endColor = '',
    this.sensors,
    this.status = 'connected',
  });

  String imagePath;
  String titleTxt;
  String startColor;
  String endColor;
  List<String>? sensors;
  String status;

  static List<SensorsListData> tabIconsList = <SensorsListData>[
    SensorsListData(
      imagePath: 'assets/monitoring_app/proximity.png',
      titleTxt: 'E18-D80NK',
      status: 'connected',
      sensors: <String>['Proximity 1'],
      startColor: '#FA7D82',
      endColor: '#FFB295',
    ),
    SensorsListData(
      imagePath: 'assets/monitoring_app/proximity.png',
      titleTxt: 'E18-D80NK',
      status: 'connected',
      sensors: <String>['Proximity 2'],
      startColor: '#738AE6',
      endColor: '#5C5EDD',
    ),
    SensorsListData(
      imagePath: 'assets/monitoring_app/tachometer.png',
      titleTxt: 'Tachometer',
      status: 'disconnected',
      sensors: <String>['Speed Sensor'],
      startColor: '#FE95B6',
      endColor: '#FF5287',
    ),
    SensorsListData(
      imagePath: 'assets/monitoring_app/tachometer.png',
      titleTxt: 'Tachometer',
      status: 'connected',
      sensors: <String>['Speed Sensor'],
      startColor: '#6F72CA',
      endColor: '#1E1466',
    ),
     SensorsListData(
      imagePath: 'assets/monitoring_app/TCS3200.png',
      titleTxt: 'TCS3200',
      status: 'disconnected',
      sensors: <String>['Color Sensor'],
      startColor: '#FA7D82',
      endColor: '#FFB295',
    ),
  ];
}
