// ignore_for_file: deprecated_member_use

import 'package:amazon_clone/common/widgets/custom_button.dart';
import 'package:amazon_clone/common/widgets/custom_textfield.dart';
import 'package:amazon_clone/constants/global_variable.dart';
import 'package:amazon_clone/constants/utils.dart';
import 'package:amazon_clone/features/address/services/address_services.dart';
import 'package:amazon_clone/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:pay/pay.dart';
import 'package:provider/provider.dart';

class AddressScreen extends StatefulWidget {
  static const String routeName = '/address';
  final String totalAmount;
  const AddressScreen({super.key, required this.totalAmount});

  @override
  State<AddressScreen> createState() => _AddressScreenState();
}

class _AddressScreenState extends State<AddressScreen> {
  final TextEditingController flatBuildingController = TextEditingController();
  final TextEditingController areaController = TextEditingController();
  final TextEditingController pincodeController = TextEditingController();
  final TextEditingController cityController = TextEditingController();

  final Future<PaymentConfiguration> _googlePayConfigFuture =
      PaymentConfiguration.fromAsset('gpay.json');

  final _addressFormKey = GlobalKey<FormState>();
  String addressToBeUsed = "";
  List<PaymentItem> paymentItems = [];

  final AddressServices addressServices = AddressServices();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    paymentItems.add(
      PaymentItem(
          amount: widget.totalAmount,
          label: 'Total Amount',
          status: PaymentItemStatus.final_price),
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    flatBuildingController.dispose();
    areaController.dispose();
    pincodeController.dispose();
    cityController.dispose();
  }

  void onGooglePayResult(res) {
    if (Provider.of<UserProvider>(context, listen: false)
        .user
        .address
        .isEmpty) {
      addressServices.saveUserAddress(
          context: context, address: addressToBeUsed);
    }

    addressServices.placeOrder(
        context: context,
        address: addressToBeUsed,
        totalSum: double.parse(widget.totalAmount));
  }

  void payPressed(String addresFromProvider) {
    addressToBeUsed = "";

    bool isForm = flatBuildingController.text.isNotEmpty ||
        areaController.text.isNotEmpty ||
        pincodeController.text.isNotEmpty ||
        cityController.text.isNotEmpty;

    if (isForm) {
      if (_addressFormKey.currentState!.validate()) {
        addressToBeUsed =
            '${flatBuildingController.text}, ${areaController.text}, ${cityController.text}- ${pincodeController.text}';
      } else {
        throw Exception('Please enter the complete address!');
      }
    } else if (addresFromProvider.isNotEmpty) {
      addressToBeUsed = addresFromProvider;
    } else {
      showSnackBar(context, 'ERROR');
    }
    print(addressToBeUsed);
  }

  @override
  Widget build(BuildContext context) {
    var address = context.watch<UserProvider>().user.address;

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: AppBar(
          automaticallyImplyLeading: false,
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              gradient: GlobalVariables.appBarGradient,
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              if (address.isNotEmpty)
                Column(
                  children: [
                    Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.black12,
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          address,
                          style: TextStyle(fontSize: 18),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      'OR',
                      style: TextStyle(fontSize: 22),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                  ],
                ),
              Form(
                key: _addressFormKey,
                child: Column(
                  children: [
                    CustomTextField(
                      controller: flatBuildingController,
                      text: "Flat, House no, Building",
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    CustomTextField(
                      controller: areaController,
                      text: "Area, Street",
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    CustomTextField(
                      controller: pincodeController,
                      text: "Pincode",
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    CustomTextField(
                      controller: cityController,
                      text: "Town, City",
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                  ],
                ),
              ),

              GooglePayButton(
                paymentConfigurationAsset: 'gpay.json',
                onPressed: ()=> payPressed(address),
                onPaymentResult: onGooglePayResult,
                paymentItems: paymentItems,
                type: GooglePayButtonType.checkout,
                height: 50,
                margin: EdgeInsets.only(top: 15),
                loadingIndicator: Center(
                  child: CircularProgressIndicator(),
                ),
              ),
              // FutureBuilder<PaymentConfiguration>(
              //     future: _googlePayConfigFuture,
              //     builder: (context, snapshot) => snapshot.hasData
              //         ? GooglePayButton(
              //             onPressed: () => payPressed(address),
              //             paymentConfiguration: snapshot.data!,
              //             paymentItems: paymentItems,
              //             type: GooglePayButtonType.checkout,
              //             height: 50,
              //             width: double.infinity,
              //             margin: const EdgeInsets.only(top: 15.0),
              //             onPaymentResult: onGooglePayResult,
              //             loadingIndicator: const Center(
              //               child: CircularProgressIndicator(),
              //             ),
              //           )
              //         : const SizedBox.shrink()),
            ],
          ),
        ),
      ),
    );
  }
}
