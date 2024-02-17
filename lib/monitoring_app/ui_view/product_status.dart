import 'package:flutter/material.dart';
import 'package:monitoring_app/monitoring_app/monitoring_app_theme.dart';
import 'package:intl/intl.dart';
import 'package:firebase_database/firebase_database.dart';

String _formatDateTime(DateTime dateTime) {
  return DateFormat('h:mm a').format(dateTime);
}

class ProductStatusView extends StatefulWidget {
  final AnimationController? animationController;
  final Animation<double>? animation;

  const ProductStatusView({
    super.key,
    this.animationController,
    this.animation,
  });

  @override
  _ProductStatusViewState createState() => _ProductStatusViewState();
}

class _ProductStatusViewState extends State<ProductStatusView> {
  late DatabaseReference _databaseReference;
  String detectionCounter = 'Loading...'; // Initial value

  @override
  void initState() {
    super.initState();
    // Initialize the database reference
    _databaseReference = FirebaseDatabase.instance.reference();

    // Register a listener to listen for changes in the database
    _databaseReference.onValue.listen((DatabaseEvent event) {
      if (event.snapshot.value != null) {
        setState(() {
          // Use null-aware operators to safely access the values
          detectionCounter =
              (event.snapshot.value as Map<String, dynamic>?)?['detectionCounter']?.toString() ?? 'Error';
        });
      } else {
        // Handle the case when sensor values cannot be obtained
        setState(() {
          detectionCounter = 'Error';
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: widget.animationController!,
      builder: (BuildContext context, Widget? child) {
        return FadeTransition(
          opacity: widget.animation!,
          child: Transform(
            transform: Matrix4.translationValues(
              0.0,
              30 * (1.0 - widget.animation!.value),
              0.0,
            ),
            child: Padding(
              padding: const EdgeInsets.only(
                left: 24,
                right: 24,
                top: 16,
                bottom: 18,
              ),
              child: Container(
                decoration: BoxDecoration(
                  color: MonitoringAppTheme.white,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(8.0),
                    bottomLeft: Radius.circular(8.0),
                    bottomRight: Radius.circular(8.0),
                    topRight: Radius.circular(68.0),
                  ),
                  boxShadow: <BoxShadow>[
                    BoxShadow(
                      color: MonitoringAppTheme.grey.withOpacity(0.2),
                      offset: const Offset(1.1, 1.1),
                      blurRadius: 10.0,
                    ),
                  ],
                ),
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(
                        top: 16,
                        left: 16,
                        right: 24,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          const Padding(
                            padding: EdgeInsets.only(
                              left: 4,
                              bottom: 8,
                              top: 16,
                            ),
                            child: Text(
                              'Bottles in total',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontFamily: MonitoringAppTheme.fontName,
                                fontWeight: FontWeight.w500,
                                fontSize: 16,
                                letterSpacing: -0.1,
                                color: MonitoringAppTheme.darkText,
                              ),
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.only(
                                      left: 4,
                                      bottom: 3,
                                    ),
                                    child: Text(
                                      detectionCounter,
                                      textAlign: TextAlign.center,
                                      style: const TextStyle(
                                        fontFamily: MonitoringAppTheme.fontName,
                                        fontWeight: FontWeight.w600,
                                        fontSize: 32,
                                        color: MonitoringAppTheme.nearlyDarkBlue,
                                      ),
                                    ),
                                  ),
                                  const Padding(
                                    padding: EdgeInsets.only(
                                      left: 8,
                                      bottom: 8,
                                    ),
                                    child: Text(
                                      'pcs',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontFamily: MonitoringAppTheme.fontName,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 18,
                                        letterSpacing: -0.2,
                                        color: MonitoringAppTheme.nearlyDarkBlue,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: <Widget>[
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Icon(
                                        Icons.access_time,
                                        color: MonitoringAppTheme.grey
                                            .withOpacity(0.5),
                                        size: 16,
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                          left: 4.0,
                                        ),
                                        child: Text(
                                          _formatDateTime(DateTime.now()),
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            fontFamily:
                                                MonitoringAppTheme.fontName,
                                            fontWeight: FontWeight.w500,
                                            fontSize: 14,
                                            letterSpacing: 0.0,
                                            color: MonitoringAppTheme.grey
                                                .withOpacity(0.5),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  const Padding(
                                    padding: EdgeInsets.only(
                                      top: 4,
                                      bottom: 14,
                                    ),
                                    child: Text(
                                      'Real-Time Data',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontFamily: MonitoringAppTheme.fontName,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 12,
                                        letterSpacing: 0.0,
                                        color:
                                            MonitoringAppTheme.nearlyDarkBlue,
                                      ),
                                    ),
                                  ),
                                ],
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        left: 24,
                        right: 24,
                        top: 8,
                        bottom: 8,
                      ),
                      child: Container(
                        height: 2,
                        decoration: const BoxDecoration(
                          color: MonitoringAppTheme.background,
                          borderRadius: BorderRadius.all(
                            Radius.circular(4.0),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        left: 24,
                        right: 24,
                        top: 8,
                        bottom: 16,
                      ),
                      child: Row(
                        children: <Widget>[
                          Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                const Text(
                                  '35 pcs',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontFamily: MonitoringAppTheme.fontName,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 16,
                                    letterSpacing: -0.2,
                                    color: MonitoringAppTheme.darkText,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 6),
                                  child: Text(
                                    'Bottle 1',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontFamily: MonitoringAppTheme.fontName,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 12,
                                      color: MonitoringAppTheme.grey
                                          .withOpacity(0.5),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: <Widget>[
                                    const Text(
                                      '32 pcs',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontFamily: MonitoringAppTheme.fontName,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 16,
                                        letterSpacing: -0.2,
                                        color: MonitoringAppTheme.darkText,
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 6),
                                      child: Text(
                                        'Bottle 2',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontFamily:
                                              MonitoringAppTheme.fontName,
                                          fontWeight: FontWeight.w600,
                                          fontSize: 12,
                                          color: MonitoringAppTheme.grey
                                              .withOpacity(0.5),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: <Widget>[
                                    const Text(
                                      '3%',
                                      style: TextStyle(
                                        fontFamily: MonitoringAppTheme.fontName,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 16,
                                        letterSpacing: -0.2,
                                        color: MonitoringAppTheme.darkText,
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 6),
                                      child: Text(
                                        'Difference',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontFamily:
                                              MonitoringAppTheme.fontName,
                                          fontWeight: FontWeight.w600,
                                          fontSize: 12,
                                          color: MonitoringAppTheme.grey
                                              .withOpacity(0.5),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          )
                        ],
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
