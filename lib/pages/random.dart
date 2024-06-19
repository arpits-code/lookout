import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lookout/pages/singup.dart';

void main() {
  runApp(random());
}

class random extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: TouristFacilitiesPage(),
    );
  }
}

class TouristFacilitiesPage extends StatelessWidget {
  final List<Map<String, dynamic>> facilities = [
    {
      'title': 'Hotel Booking',
      'icon': Icons.hotel,
      'color': Colors.blueAccent,
      'page': HotelListPage()
    },
    {
      'title': 'Transportation',
      'icon': Icons.directions_car,
      'color': Colors.greenAccent,
      'page': TransportationPage()
    },
    {
      'title': 'Tour Guides',
      'icon': Icons.person,
      'color': Colors.orangeAccent,
      'page': TourGuidesPage()
    },
    {
      'title': 'Restaurant Reservations',
      'icon': Icons.restaurant,
      'color': Colors.purpleAccent,
      'page': RestaurantReservationsPage()
    },
    {
      'title': 'Local Attractions',
      'icon': Icons.local_activity,
      'color': Colors.redAccent,
      'page': LocalAttractionsPage()
    },
    {
      'title': 'Emergency Services',
      'icon': Icons.local_hospital,
      'color': Colors.tealAccent,
      'page': EmergencyServicesPage()
    },
    {
      'title': 'Shopping',
      'icon': Icons.shopping_cart,
      'color': Colors.yellowAccent,
      'page': ShoppingPage()
    },
    {
      'title': 'Currency Exchange',
      'icon': Icons.attach_money,
      'color': Colors.pinkAccent,
      'page': CurrencyExchangePage()
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tourist Facilities'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
          ),
          itemCount: facilities.length,
          itemBuilder: (context, index) {
            return FacilityCard(
              title: facilities[index]['title'],
              icon: facilities[index]['icon'],
              color: facilities[index]['color'],
              page: facilities[index]['page'],
            );
          },
        ),
      ),
    );
  }
}

class FacilityCard extends StatelessWidget {
  final String title;
  final IconData icon;
  final Color color;
  final Widget page;

  const FacilityCard(
      {required this.title,
      required this.icon,
      required this.color,
      required this.page});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: color,
      elevation: 5,
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => page),
          );
        },
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon, size: 50, color: Colors.white),
              SizedBox(height: 10),
              Text(
                title,
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16, color: Colors.white),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class HotelListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Hotel List'),
      ),
      body: Center(
        child: Text('List of Hotels'),
      ),
    );
  }
}

class TourGuidesPage extends StatelessWidget {
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ChatPage(),
    );
  }
}

class ChatPage extends StatefulWidget {
  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final TextEditingController _controller = TextEditingController();
  final List<Map<String, String>> _messages = [];
  bool _alternateMessage = true;

  void _sendMessage(String text) {
    if (text.isNotEmpty) {
      setState(() {
        _messages.add({"type": "user", "message": text});
        String reply = _alternateMessage ? "Hello" : "Hi";
        _messages.add({"type": "bot", "message": reply});
        _alternateMessage = !_alternateMessage;
      });
      _controller.clear();
    }
  }

  Future<void> _sendPicture() async {
    final picker = ImagePicker();
    final pickedFile = await picker.getImage(source: ImageSource.camera);

    if (pickedFile != null) {
      File imageFile = File(pickedFile.path);
      setState(() {
        _messages.add({
          "type": "user",
          "message": "Picture sent",
          "imagePath": imageFile.path
        });
        _messages.add({
          "type": "bot",
          "message": "Nice pic. This is a beautiful photo taken by you."
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Search Anything you see'),
        backgroundColor: Colors.blueAccent,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => random()));
          },
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                var message = _messages[index];
                return ListTile(
                  title: message["imagePath"] == null
                      ? Text(message["message"] ?? '')
                      : Column(
                          children: [
                            Image.file(File(message["imagePath"]!)),
                            Text(message["message"] ?? '')
                          ],
                        ),
                  tileColor: message["type"] == "user"
                      ? Colors.lightBlue[50]
                      : Colors.grey[200],
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: InputDecoration(
                      hintText: 'Type a message...',
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: BorderSide.none,
                      ),
                    ),
                    onSubmitted: _sendMessage,
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.camera_alt),
                  onPressed: _sendPicture,
                ),
                IconButton(
                  icon: Icon(Icons.send),
                  onPressed: () => _sendMessage(_controller.text),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class RestaurantReservationsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Restaurant Reservations'),
      ),
      body: Center(
        child: Text('Restaurant Reservations'),
      ),
    );
  }
}

class LocalAttractionsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Local Attractions'),
      ),
      body: Center(
        child: Text('Local Attractions'),
      ),
    );
  }
}

class EmergencyServicesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Emergency Services'),
      ),
      body: Center(
        child: Text('Emergency Services'),
      ),
    );
  }
}

class ShoppingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Shopping'),
      ),
      body: Center(
        child: Text('Shopping Options'),
      ),
    );
  }
}

class CurrencyExchangePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Currency Exchange'),
      ),
      body: Center(
        child: Text('Currency Exchange Locations'),
      ),
    );
  }
}

class TransportationPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Emergency Services'),
      ),
      body: Center(
        child: Text('Emergency Services'),
      ),
    );
  }
}
