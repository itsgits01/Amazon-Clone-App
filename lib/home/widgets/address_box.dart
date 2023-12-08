import 'package:amazon_clone/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddressBox extends StatefulWidget {
  const AddressBox({Key? key}) : super(key: key);

  @override
  _AddressBoxState createState() => _AddressBoxState();
}

class _AddressBoxState extends State<AddressBox> {
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context).user;

    return GestureDetector(
      onTap: () {
        setState(() {
          isExpanded = !isExpanded;
        });
      },
      child: Container(
        height: isExpanded ? null : 40, // Adjust the initial height
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color.fromARGB(255, 114, 226, 221),
              Color.fromARGB(255, 162, 236, 233),
            ],
            stops: [0.5, 1.0],
          ),
        ),
        padding: const EdgeInsets.only(
          left: 10,
        ),
        child: Row(
          children: [
            const Icon(
              Icons.location_on_outlined,
              size: 20,
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(left: 5),
                child: Text(
                  'Delivery to ${user.name} - ${user.address}',
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                  ),
                  overflow: isExpanded ? null : TextOverflow.ellipsis,
                  maxLines: isExpanded ? null : 1,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 5, top: 2),
              child: Icon(
                isExpanded
                    ? Icons.arrow_drop_up_outlined
                    : Icons.arrow_drop_down_outlined,
                size: 20,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
