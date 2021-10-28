import 'package:flutter/material.dart';

class BuyProduct extends StatefulWidget {
  const BuyProduct({Key? key}) : super(key: key);

  @override
  _BuyProductState createState() => _BuyProductState();
}

class _BuyProductState extends State<BuyProduct> {
  late int count = 0;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Icon(
        Icons.shopping_bag,
        color: Colors.blue,
      ),
      onTap: () {
        setState(() {
          count = 1;
        });
        showDialog(
            context: context,
            builder: (BuildContext context) =>
                StatefulBuilder(builder: (context, setState) {
                  return AlertDialog(
                    title: const Text('Choose the number of products'),
                    content: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        SizedBox(width: 20),
                        IconButton(
                            onPressed: () {
                              setState(() {
                                if (count > 0) {
                                  count--;
                                }
                              });
                            },
                            icon: Icon(Icons.minimize)),
                        Text("$count"),
                        IconButton(
                            onPressed: () {
                              setState(() {
                                count++;
                              });
                            },
                            icon: Icon(Icons.add)),
                        SizedBox(width: 20)
                      ],
                    ),
                    actions: <Widget>[
                      TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: const Text('Cancel'),
                      ),
                      TextButton(
                        onPressed: () => _showToast(context),
                        child: const Text('Buy'),
                      ),
                    ],
                  );
                }));
      },
    );
  }

  void _showToast(BuildContext context) {
    final scaffold = ScaffoldMessenger.of(context);
    scaffold.showSnackBar(
      SnackBar(
        content: const Text('Thanks for your shopping!!!'),
      ),
    );
    Navigator.pop(context);
  }
}
