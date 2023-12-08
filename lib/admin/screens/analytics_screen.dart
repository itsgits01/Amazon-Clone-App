import 'package:amazon_clone/admin/models/sales.dart';
import 'package:amazon_clone/admin/screens/services/admin_services.dart';
import 'package:amazon_clone/common/widgets/loader.dart';
import 'package:flutter/material.dart';

class AnalyticsScreen extends StatefulWidget {
  const AnalyticsScreen({super.key});

  @override
  State<AnalyticsScreen> createState() => _AnalyticsScreenState();
}

class _AnalyticsScreenState extends State<AnalyticsScreen> {
  final AdminServices adminServices = AdminServices();
  int? totalsales;
  List<Sales>? earnings;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getEarnings();
  }

  getEarnings() async {
    var earningData = await adminServices.getEarnings(context);
    totalsales = earningData['totalEarnings'];
    earnings = earningData['sales'];
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return earnings == null || totalsales == null
        ? Loader()
        : Column(
            children: [
              Text(
                'Rs.${totalsales}',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),

              
            ],
          );
  }
}
