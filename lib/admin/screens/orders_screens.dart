import 'package:amazon_clone/admin/screens/services/admin_services.dart';
import 'package:amazon_clone/common/widgets/loader.dart';
import 'package:amazon_clone/features/auth/screens/widgets/single_product.dart';
import 'package:amazon_clone/features/order_details/screen/order_details.dart';
import 'package:amazon_clone/models/order.dart';
import 'package:flutter/material.dart';

class OrdersScreen extends StatefulWidget {
  const OrdersScreen({super.key});

  @override
  State<OrdersScreen> createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  List<Order>? orders;
  final AdminServices adminServices = AdminServices();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchOrders();
  }

  void fetchOrders() async {
    orders = await adminServices.fetchAllOrders(context);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return orders == null
        ? const Loader()
        : GridView.builder(
            itemCount: orders!.length,
            gridDelegate:
                SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
            itemBuilder: (context, index) {
              final orderData = orders![index];
              return GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, OrderDetailScreen.routeName, arguments: orderData );
                },
                child: SizedBox(
                  height: 140,
                  child: SingleProduct(image: orderData.products[0].images[0]),
                ),
              );
            });
  }
}
