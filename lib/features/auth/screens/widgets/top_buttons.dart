import 'package:amazon_clone/features/auth/screens/account/services/account_servies.dart';
import 'package:amazon_clone/features/auth/screens/widgets/account_button.dart';
import 'package:flutter/material.dart';

class TopButtons extends StatelessWidget {
  const TopButtons({super.key});

  
  
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            AccountButton(text: 'Your Orders', onTap: () {}),
            AccountButton(text: 'Turn Seller', onTap: () {}),
          ],
        ),
        SizedBox(
          height: 10,
        ),
        Row(
          children: [
            AccountButton(text: 'Logout', onTap: () => AccountServices().logout(context)),
            AccountButton(text: 'Your Wishlist', onTap: () {}),
          ],
        ),
      ],
    );
  }
}
