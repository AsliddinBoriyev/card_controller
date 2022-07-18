import 'package:card_controller/models/card_model.dart';
import 'package:card_controller/services/hive_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_credit_card/flutter_credit_card.dart';

class CardPage extends StatefulWidget {
  const CardPage({Key? key}) : super(key: key);
  static const String id = "card_page";

  @override
  State<CardPage> createState() => _CardPageState();
}

class _CardPageState extends State<CardPage> {
  List <Color> bgColor =[
    Colors.purpleAccent,
    Colors.red,
    Colors.blue,
    Colors.grey,
    Colors.black,
    Colors.yellow,
    Colors.cyan,
    Colors.green,
    Colors.pink,
    Colors.orange,
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getAllData();
  }

  bool isLoading = false;

  List<CardModel> items = [];
  void deleteUser(CardModel card) async{
    isLoading = true;
    setState(() {});

    items.remove(card);


    await HiveService.setCards(items);
    /// 1, 2, 3
    /// 1, 2
    ///
    /// db: 1, 2
    isLoading = false;
    setState(() {});
  }

  void getAllData() async {
    isLoading = true;
    setState(() {});

    items = HiveService.readCards();
    //allUsers = items;

    isLoading = false;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 100,
        backgroundColor: Colors.white,
        centerTitle: false,
        elevation: 0,
        title: Stack(
          children: [
            Row(
              children: [
                // #Good Morning,
                const Padding(
                  padding: EdgeInsets.only(left: 10, bottom: 40),
                  child: Text(
                    "Good Morning,",
                    style: TextStyle(
                      color: Color.fromRGBO(45, 44, 45, 1),
                      fontSize: 25,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                // #Avatar
                Padding(
                  padding: const EdgeInsets.only(left: 130, bottom:10,),
                  child: Container(
                    height: 50,
                    width: 50,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(60),
                      image: const DecorationImage(
                        fit: BoxFit.cover,
                        image: AssetImage("assets/images/img.png",),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            // #Eugene
            const Padding(
              padding: EdgeInsets.only(top: 30, left: 10),
              child: Text(
                "Eugene",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),const SizedBox(height: 30,),
          ],
        ),
      ),

      body: ListView.builder(
          itemCount: items.length,
          itemBuilder: (context, index){
            return GestureDetector(
              onDoubleTap: (){
                deleteUser(items[index]);
              },
              child: CreditCardWidget(
                cardType: CardType.mastercard,
                cardNumber: items[index].cardNumder,
                expiryDate: items[index].date,
                cardHolderName: items[index].name,
                cvvCode: items[index].cvc,
                showBackView: false,
                obscureCardNumber: true,
                obscureCardCvv: true,
                isHolderNameVisible: true,
                cardBgColor: bgColor[index % 10], onCreditCardWidgetChange: (CreditCardBrand ) {  },
              ),
            );
          }
          ),

      bottomNavigationBar: BottomAppBar(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            IconButton(onPressed: (){},
              icon: const Icon(Icons.home_sharp,color: Colors.blue,),),
            IconButton(onPressed: (){},
                icon: const Icon(Icons.messenger,color: Colors.blue,),),
            IconButton(onPressed: (){},
              icon: const Icon(Icons.menu_outlined,color: Colors.blue,),),
            IconButton(onPressed: (){},
                icon: const Icon(Icons.swap_vert,color: Colors.blue,),),
            IconButton(onPressed: (){},
              icon: const Icon(Icons.person,color: Colors.blue,),),
          ],
        ),
      ),
    );
  }
}