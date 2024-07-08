


import 'package:burger_delivery/models/cart_item.dart';
import 'package:burger_delivery/models/food.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';

class Restaurant extends ChangeNotifier{
  final List<Food> _menu=[
    Food(
      name:"Classic Cheeseburger",
      description:"A Juicy chicken patty with melted cheddar,lettuce,tomato with a hint of onion and pickle",
      imagePath:"lib/images/burgers/burger1.png",
      price:0.99,
      category: FoodCategory.burgers,
      availableAddons: [
        Addon(name:"Extra cheese",price:0.99),
        Addon(name:"Bacon",price:1.99),
        Addon(name:"Avocado",price:2.99),
      ]
    ),

    Food(
      name:"Caesar Salad",
      description:"Crisp romaine lettuce,parmesan cheese,croutons and Caesar dressing.",
      imagePath:"lib/images/salads/salad.png",
      price: 7.99,
      category:FoodCategory.salads,
      availableAddons:[
        Addon(name:"Grilled chicken", price:0.99),
        Addon(name:"Anchovies",price:1.49),
        Addon(name:"Extra Parmesan",price:1.99),
      ],
    ),
    Food(
      name:"Garlic Bread",
      description:"Warm and tasty garlic bread,topped with melted butter and parsley",
      imagePath:"lib/images/sides/sides.png",
      price:4.49,
      category:FoodCategory.sides,
      availableAddons:[
        Addon(name:"Extra Garlic", price:0.99),
        Addon(name:"Mozzerella cheese", price:1.49),
        Addon(name:"Marinara Dip", price:1.99),
      ]
    ),
    Food(
      name:"Choclate Brownie",
      description:"Rich and fudgy choclate brownie with chunks of choclate.",
      imagePath:"lib/images/deserts/cake.png",
      price:5.99,
      category:FoodCategory.deserts,
      availableAddons:[
        Addon(name:"Vanilla Ice cream",price:0.99),
        Addon(name:"Hot Fudge", price:1.49),
        Addon(name:"Whipped Cream",price:1.99),
      ],
    ),
    Food(
      name:"Smoothie",
      description:"A blend of fresh fruits and yogurt, perfect for a healthy boost",
      imagePath:"lib/images/drinks/strawberryshake.png",
      price:4.49,
      category:FoodCategory.drinks,
      availableAddons:[
        Addon(name:"Protien Powder",price:0.99),
        Addon(name:"Almond Milk",price:1.49),
        Addon(name:"chia Seeds",price:1.99),
      ]
    ),


  ];

  List<Food> get menu=> _menu;
  List<CartItem> get cart=> _cart;



  final List<CartItem> _cart=[];

  void addToCart(Food food,List<Addon>selectedAddons ){
    CartItem? cartItem=_cart.firstWhereOrNull((item){
      bool isSameFood=item.food==food;

      bool isSameAddons= ListEquality().equals(item.selectedAddons,selectedAddons);

      return isSameFood && isSameAddons;
    });
    if(cartItem!=null){
      cartItem.quantity++;
    }

    else{
      _cart.add(
        CartItem(
          food:food,
          selectedAddons:selectedAddons,
        ),
      );
    }
    notifyListeners();
  }


  void removeFromCart(CartItem cartItem){
    int cartIndex=_cart.indexOf(cartItem);

    if(cartIndex!=-1){
      if(_cart[cartIndex].quantity>1){
        _cart[cartIndex].quantity--;
      }else{
        _cart.removeAt(cartIndex);
      }
    }
  }


  double getTotalPrice(){
    double total=0.0;

    for(CartItem cartItem in _cart){
      double itemTotal = cartItem.food.price;

      for(Addon addon in cartItem.selectedAddons){
        itemTotal += addon.price;
      }
      total+= itemTotal* cartItem.quantity;
    }
    return total;
  }


  int getTotalItemCount(){
    int totalItemCount=0;

    for(CartItem cartItem in _cart){
      totalItemCount += cartItem.quantity;
    }
    return totalItemCount;
  }


  void clearCart(){
    _cart.clear();
    notifyListeners();
  }






}