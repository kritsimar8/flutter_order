import 'package:burger_delivery/components/my_button.dart';
import 'package:burger_delivery/pages/deliver_progress_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_credit_card/flutter_credit_card.dart';

class PaymentPage extends StatefulWidget{
  const PaymentPage({super.key});

  @override 
  State<PaymentPage> createState()=> _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage>{
  GlobalKey<FormState> formKey=GlobalKey<FormState>();
  String cardNumber='';
  String expiryDate='';
  String cardHolderName='';
  String cvvCode='';
  bool isCvvFocused=false;

  void userTappedPay(){
    if(formKey.currentState!.validate()){
      showDialog(
        context: context,
         builder: (context)=>AlertDialog(
          title:const Text("confirm payment"),
          content:SingleChildScrollView(
            child:ListBody(
              children:[
                Text("Card Number: $cardNumber"),
                Text("Expiry Date: $expiryDate"),
                Text("Card Holder name: $cardHolderName"),
                Text("CVV: $cvvCode"),
              ]
            )

          ),
          actions:[
            TextButton(
              onPressed:()=> Navigator.pop(context),
              child:const Text("Cancel"),
            ),
             TextButton(
              onPressed:()=> {
                Navigator.pop(context),
                Navigator.push(
                context,
                MaterialPageRoute(
                  builder:(context)=>DeliveryProgressPage(),
                )
              ),
              },
              child:const Text("Yes"),

            )
           

          ]
         ),
         );
    }
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
     appBar:AppBar(
      backgroundColor:Colors.transparent,
      title:const Text("Checkout")
     ),
     body:Column(
      children: [
        CreditCardWidget(cardNumber: cardNumber,
         expiryDate: expiryDate,
          cardHolderName: cardHolderName,
           cvvCode: cvvCode, 
           showBackView: isCvvFocused,
            onCreditCardWidgetChange: (p0){}),

        CreditCardForm(cardNumber: cardNumber,
         expiryDate: expiryDate,
          cardHolderName: cardHolderName,
           cvvCode: cvvCode,
            onCreditCardModelChange: (data){
              setState((){
                cardNumber=data.cardNumber;
                expiryDate=data.expiryDate;
                cardHolderName= data.cardHolderName;
                cvvCode= data.cvvCode;
              });
            }, 
            formKey: formKey
            ),

            const Spacer(),

            MyButton(
              onTap:userTappedPay,
              text:"Pay Now"
            ),

          const SizedBox(height:20)

      ],)

    );

  }
}