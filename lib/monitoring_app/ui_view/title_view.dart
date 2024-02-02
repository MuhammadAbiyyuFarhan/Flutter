//import 'package:best_flutter_ui_templates/monitoring_app/info/sensor_info_screen.dart';
import 'package:best_flutter_ui_templates/monitoring_app/monitoring_app_theme.dart';
import 'package:best_flutter_ui_templates/monitoring_app/my_screen/history.dart';
import 'package:best_flutter_ui_templates/monitoring_app/my_screen/product_detail.dart';
import 'package:best_flutter_ui_templates/monitoring_app/my_screen/sensors_detail.dart';
import 'package:flutter/material.dart';

class TitleView extends StatelessWidget {
  final String titleTxt;
  final String subTxt;
  final AnimationController? animationController;
  final Animation<double>? animation;

  const TitleView(
      {Key? key,
      this.titleTxt = "",
      this.subTxt = "",
      this.animationController,
      this.animation})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animationController!,
      builder: (BuildContext context, Widget? child) {
        return FadeTransition(
          opacity: animation!,
          child: new Transform(
            transform: new Matrix4.translationValues(
                0.0, 30 * (1.0 - animation!.value), 0.0),
            child: Container(
              child: Padding(
                padding: const EdgeInsets.only(left: 24, right: 24),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: Text(
                        titleTxt,
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          fontFamily: MonitoringAppTheme.fontName,
                          fontWeight: FontWeight.w500,
                          fontSize: 18,
                          letterSpacing: 0.5,
                          color: MonitoringAppTheme.lightText,
                        ),
                      ),
                    ),
                    InkWell(
                      highlightColor: Colors.transparent,
                      borderRadius: BorderRadius.all(Radius.circular(4.0)),
                      onTap: () {
    // Menentukan aksi berdasarkan nilai subTxt
                        switch (subTxt) {
                          case 'Details':
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => SensorDetailScreen(),
                              ),
                            ); // Panggil fungsi untuk menampilkan notifikasi details
                            break;
                            case 'About':
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => SensorDetailScreen(),
                              ),
                            ); // Panggil fungsi untuk menampilkan notifikasi details
                            break;
                          case 'More':
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => HistoryScreen(),
                              ),
                            );
                            break;
                          case 'Today':
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ProductDetailScreen(),
                              ),
                            );
                            break;
                          default:
                            // Aksi default jika subTxt tidak cocok dengan kasus di atas
                        }
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(left: 8),
                        child: Row(
                          children: <Widget>[
                            Text(
                              subTxt,
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                fontFamily: MonitoringAppTheme.fontName,
                                fontWeight: FontWeight.normal,
                                fontSize: 16,
                                letterSpacing: 0.5,
                                color: MonitoringAppTheme.nearlyDarkBlue,
                              ),
                            ),
                            SizedBox(
                              height: 38,
                              width: 26,
                              child: Icon(
                                Icons.arrow_forward,
                                color: MonitoringAppTheme.darkText,
                                size: 18,
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
