import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class Weapon {
  String name;
  String description;
  double price;
  int quantity;
  String? image;
  String note;

  Weapon({
    required this.name,
    required this.description,
    required this.price,
    this.image,
    this.quantity = 1,
    this.note = '',
  });
}

class _MyAppState extends State<MyApp> {
  int _currentIndex = 0;
  List<Weapon> _cart = [];

  final List<Weapon> _weapons = [
    Weapon(
      name: 'Slaught-O-Matic',
      description: 'Single-use pistol, available at vending machines.',
      price: 100.0,
      image: 'images/Slaught.png',
    ),
    Weapon(
      name: 'Carnage',
      description:
          'A cheap, 4 gauge pump action shotgun, capable of holding 5 shells.',
      price: 214650.0,
      image: 'images/Carnage.png',
    ),
    Weapon(
      name: 'Guillotine',
      description:
          'Fully automatic and made out of cheap plastics, the Guillotine is the ultimate budget submachine gun in Night City.',
      price: 164755.0,
      image: 'images/Guillotine.png',
    ),
  ];

  void _addToCart(Weapon weapon) {
    setState(() {
      bool found = false;

      for (var item in _cart) {
        if (item.name == weapon.name) {
          item.quantity++;
          found = true;
          break;
        }
      }

      if (!found) {
        _cart.add(Weapon(
          name: weapon.name,
          description: weapon.description,
          price: weapon.price,
          image: weapon.image,
          quantity: 1,
          note: weapon.note,
        ));
      }
    });
  }

  void _updateCart(Weapon weapon, int quantity) {
    setState(() {
      weapon.quantity = quantity;
      if (weapon.quantity <= 0) {
        _cart.remove(weapon);
      }
    });
  }

  void _updateNote(Weapon weapon, String note) {
    setState(() {
      weapon.note = note;
    });
  }

  void _deleteFromCart(Weapon weapon) {
    setState(() {
      _cart.remove(weapon);
    });
  }

  void _buyItems() {
    setState(() {
      _cart.clear();
    });
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Thank You For Your Purchase'),
          content: Text('Click anywhere to close this window.'),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: const Color.fromARGB(255, 24, 24, 24),
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Image.asset(
            'images/BudgetArms.png',
            width: 120,
            height: 120,
          ),
        ),
        body: _getBody(_currentIndex),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: (index) {
            setState(() {
              _currentIndex = index;
            });
          },
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.search),
              label: 'Buy Weapons',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.shopping_cart),
              label: 'Cart',
            ),
          ],
        ),
      ),
    );
  }

  Widget _getBody(int index) {
    switch (index) {
      case 0:
        return SingleChildScrollView(
          child: Center(
            child: Column(
              children: [
                SizedBox(height: 20.0),
                Container(
                  padding: EdgeInsets.all(2.0),
                  color: Color.fromARGB(255, 255, 238, 0),
                  child: Image.asset(
                    'images/BudgetArms.png',
                  ),
                ),
                SizedBox(height: 20.0),
                Container(
                  padding: EdgeInsets.all(0.0),
                  child: Text(
                    '2nd Amendment is',
                    style: TextStyle(
                      fontSize: 30.0,
                      color: Color.fromARGB(255, 255, 242, 66),
                      fontWeight: FontWeight.w300,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(0.0),
                  child: Text(
                    'NOT',
                    style: TextStyle(
                      fontSize: 30.0,
                      color: Color.fromARGB(255, 236, 64, 64),
                      fontWeight: FontWeight.w900,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                SizedBox(height: 0.0),
                Container(
                  padding: EdgeInsets.all(0.0),
                  child: Text(
                    'For the Rich',
                    style: TextStyle(
                      fontSize: 30.0,
                      color: Color.fromARGB(255, 255, 242, 66),
                      fontWeight: FontWeight.w300,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                SizedBox(height: 90.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 200,
                      height: 300,
                      child: Column(
                        children: [
                          Container(
                            child: Text(
                              'Slaught-O-Matic',
                              style: TextStyle(
                                fontSize: 24.0,
                                color: Color.fromARGB(255, 255, 217, 0),
                                fontWeight: FontWeight.w900,
                                fontStyle: FontStyle.italic,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          Container(
                            child: Text(
                              'The Slaught-O-Matic! Priced as low as a can of NiCola and available at vending machines, this single-use pistol is your go-to for protection on a budget. With its no-frills design and easy accessibility. Grab yours today and experience peace of mind knowing you are prepared for whatever comes your way.',
                              style: TextStyle(
                                fontSize: 14.0,
                                color: Color.fromARGB(255, 255, 217, 0),
                                fontWeight: FontWeight.w300,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          Container(
                            child: Text(
                              'NO QUESTION ASKED.',
                              style: TextStyle(
                                fontSize: 15.0,
                                color: Color.fromARGB(255, 236, 64, 64),
                                fontWeight: FontWeight.w900,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(width: 8.0), // Adjust spacing between widgets
                    Container(
                      width: 200,
                      height: 200,
                      decoration: BoxDecoration(
                        border: Border.all(
                          width: 2.0,
                          color: const Color.fromARGB(255, 255, 242, 66),
                        ),
                      ),
                      child: Center(
                        child: Image.asset(
                          'images/Slaught.png',
                          width: 300,
                          height: 300,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20.0),
                Row(
                  children: [
                    Container(
                      child: Text(
                        'You Can \n Get This At',
                        style: TextStyle(
                          fontSize: 14.0,
                          color: Color.fromARGB(255, 255, 217, 0),
                          fontWeight: FontWeight.w600,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    SizedBox(width: 8.0), // Adjust spacing between widgets
                    Container(
                      child: Image.asset(
                        'images/VendingMachine.png',
                        width: 320,
                        height: 300,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      case 1:
        return SingleChildScrollView(
          child: Column(
            children: _weapons.map((weapon) {
              return Card(
                margin: EdgeInsets.all(10),
                child: ListTile(
                  contentPadding: EdgeInsets.all(10),
                  leading: weapon.image != null
                      ? Image.asset(
                          weapon.image!,
                          width: 50,
                          height: 50,
                        )
                      : null,
                  title: Text(weapon.name),
                  subtitle: Text(weapon.description),
                  trailing: Text('\€\$${weapon.price.toStringAsFixed(0)}'),
                  onTap: () => _addToCart(weapon),
                ),
              );
            }).toList(),
          ),
        );
      case 2:
        return Column(
          children: [
            Expanded(
              child: _cart.isEmpty
                  ? Center(
                      child: Text(
                        'Your cart is empty',
                        style: TextStyle(
                          fontSize: 24.0,
                          color: Color.fromARGB(255, 255, 217, 0),
                        ),
                      ),
                    )
                  : ListView.builder(
                      itemCount: _cart.length,
                      itemBuilder: (context, index) {
                        final weapon = _cart[index];
                        final TextEditingController _controller =
                            TextEditingController(text: weapon.note);

                        _controller.selection = TextSelection.fromPosition(
                            TextPosition(offset: _controller.text.length));

                        return Card(
                          margin: EdgeInsets.all(10),
                          child: ListTile(
                            leading: weapon.image != null
                                ? Image.asset(
                                    weapon.image!,
                                    width: 50,
                                    height: 50,
                                  )
                                : null,
                            title: Text(weapon.name),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(weapon.description),
                                SizedBox(height: 10),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Flexible(
                                      // Added Flexible widget
                                      child: Text(
                                        'Price: \$${weapon.price.toStringAsFixed(2)}',
                                        overflow: TextOverflow
                                            .ellipsis, // Truncate if overflow
                                      ),
                                    ),
                                    Row(
                                      children: [
                                        IconButton(
                                          icon: Icon(Icons.remove),
                                          onPressed: () {
                                            if (weapon.quantity > 1) {
                                              _updateCart(
                                                  weapon, weapon.quantity - 1);
                                            } else {
                                              _deleteFromCart(weapon);
                                            }
                                          },
                                        ),
                                        Text('${weapon.quantity}'),
                                        IconButton(
                                          icon: Icon(Icons.add),
                                          onPressed: () {
                                            _updateCart(
                                                weapon, weapon.quantity + 1);
                                          },
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                TextField(
                                  decoration: InputDecoration(
                                    labelText: 'Note',
                                  ),
                                  onChanged: (value) {
                                    _updateNote(weapon, value);
                                  },
                                  controller: _controller,
                                ),
                              ],
                            ),
                            trailing: IconButton(
                              icon: Icon(Icons.delete),
                              onPressed: () => _deleteFromCart(weapon),
                            ),
                          ),
                        );
                      },
                    ),
            ),
            Container(
              padding: EdgeInsets.all(10),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color.fromARGB(255, 255, 217, 0),
                  padding: EdgeInsets.symmetric(vertical: 15, horizontal: 50),
                ),
                onPressed: _buyItems,
                child: Text(
                  'BUY!!!',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    fontStyle: FontStyle.italic,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
          ],
        );
      default:
        return SizedBox.shrink();
    }
  }
}
