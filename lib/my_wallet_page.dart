import 'package:flutter/material.dart';

class MyWalletPage extends StatefulWidget {
  const MyWalletPage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyWalletPage> createState() => _MyWalletPageState();
}

class _MyWalletPageState extends State<MyWalletPage> {
  int _amountBtc = 0;
  int _amountEuro = 0;
  int _calculatedAmount = 0;
  final int _rate = 2;

  final myAmountController = TextEditingController();

  void _incrementBTCWallet() {
    setState(() {
      _amountBtc++;
    });
  }

  _incrementEuroWallet() {
    setState(() {
      if ((int.parse(myAmountController.text)) <= _amountBtc) {
        _amountBtc -= (int.parse(myAmountController.text));
        _amountEuro += _calculatedAmount;
        clearText();
      } else {
        //
      }
    });
  }
  
  void _calculateEuroAmount(String text) {
    setState(() {
      _calculatedAmount = (int.parse(myAmountController.text)) * _rate;
    });
  }

  void clearText() {
    myAmountController.clear();
  }

  @override
  void dispose() {
    myAmountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 16.0),
        child: ListView(
          // mainAxisSize: MainAxisSize.max,
          // mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Center(
              child: buildMarketPlaceButton(),
            ),
            const SizedBox(height: 40),
            buildWalletBtcContainer(),
            const SizedBox(height: 40),
            TextField(
              controller: myAmountController,
              onChanged: (text) {
                _calculateEuroAmount(text);
              },
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
              border: OutlineInputBorder(),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.tealAccent,
                ),
              ),
              labelText: "Spécifier un montant à revendre",
            )),
            const SizedBox(height: 40),
            Center(
              child: MaterialButton(
                onPressed: () {
                  _incrementEuroWallet();
                  print(_amountEuro);
                },
                shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(35))),
                textColor: Colors.deepPurpleAccent,
                color: Colors.white,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                  child: Text(
                    'REVENDRE POUR  $_calculatedAmount €',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      letterSpacing: 1.25,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 40),
            Container(
              width: double.maxFinite,
              decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/images/background-white.png'),
                    fit: BoxFit.cover,
                  ),
                  borderRadius: BorderRadius.all(Radius.circular(9))),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                    vertical: 20.0, horizontal: 20.0),
                child: Column(
                  children: [
                    const SizedBox(
                      width: double.infinity,
                      child: Text("MON WALLET EN EUROS",
                          style: TextStyle(
                            fontWeight: FontWeight.w900,
                            fontSize: 18,
                            letterSpacing: 1.25,
                            color: Colors.black,
                          ),
                          textAlign: TextAlign.start),
                    ),
                    const SizedBox(height: 40),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          '$_amountEuro',
                          style: TextStyle(
                              fontWeight: FontWeight.w900,
                              fontSize: 42,
                              letterSpacing: 1.25,
                              color: Colors.black),
                        ),
                        Icon(
                          Icons.euro,
                          color: Colors.black,
                          size: 32,
                        )
                      ],
                    ),
                    const SizedBox(height: 40),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      drawer: buildDrawer(
          context), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  Container buildWalletBtcContainer() {
    return Container(
      width: double.maxFinite,
      decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/background-pink.png'),
            fit: BoxFit.cover,
          ),
          borderRadius: BorderRadius.all(Radius.circular(9))),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 20.0),
        child: Column(
          children: [
            const SizedBox(
              width: double.infinity,
              child: Text("MON WALLET BTC",
                  style: TextStyle(
                    fontWeight: FontWeight.w900,
                    fontSize: 18,
                    letterSpacing: 1.25,
                    color: Colors.white,
                  ),
                  textAlign: TextAlign.start),
            ),
            const SizedBox(height: 40),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  '$_amountBtc',
                  style: const TextStyle(
                      fontWeight: FontWeight.w900,
                      fontSize: 42,
                      letterSpacing: 1.25,
                      color: Colors.white),
                ),
                const Icon(
                  Icons.currency_bitcoin,
                  color: Colors.white,
                  size: 32,
                )
              ],
            ),
            const SizedBox(height: 30),
            MaterialButton(
              onPressed: () => {
                _incrementBTCWallet(),
              },
              shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(35))),
              textColor: Colors.white,
              color: Colors.tealAccent[400],
              height: 36,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                child: Text(
                  'GAGNER 1 BTC',
                  style: const TextStyle(
                    fontWeight: FontWeight.w900,
                    fontSize: 18,
                    letterSpacing: 1.25,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  MaterialButton buildMarketPlaceButton() {
    return MaterialButton(
      onPressed: () {
        debugPrint('Received click');
      },
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(35))),
      textColor: Colors.deepPurpleAccent,
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: const [
            Text(
              'PLACE DU MARCHE NFT',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
                letterSpacing: 1.25,
              ),
            ),
            Icon(Icons.storefront_outlined),
          ],
        ),
      ),
    );
  }

  Drawer buildDrawer(BuildContext context) {
    return Drawer(
      child: ListView(
        // Important: Remove any padding from the ListView.
        padding: EdgeInsets.zero,
        children: [
          const DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.deepPurple,
            ),
            child: Text('Argent Facile NFT',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold)),
          ),
          ListTile(
            title: const Text('Item 1'),
            onTap: () {
              // Update the state of the app
              // ...
              // Then close the drawer
              Navigator.pop(context);
            },
          ),
          ListTile(
            title: const Text('Item 2'),
            onTap: () {
              // Update the state of the app
              // ...
              // Then close the drawer
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }
}
