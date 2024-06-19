import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';

void main() {
  runApp(chatsearch());
}

class chatsearch extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TextEditingController _controller = TextEditingController();

  void _pickFile(FileType fileType) async {
    FilePickerResult? result =
        await FilePicker.platform.pickFiles(type: fileType);

    if (result != null) {
      PlatformFile file = result.files.first;

      print('File name: ${file.name}');
      print('File path: ${file.path}');
      // Perform upload or other actions with the selected file
    } else {
      // User canceled the picker
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.blueGrey, Colors.black12],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _controller,
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.search),
                        hintText: "Enter text here",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25.0),
                        ),
                        contentPadding: EdgeInsets.symmetric(horizontal: 20.0),
                      ),
                    ),
                  ),
                  PopupMenuButton<String>(
                    icon: Icon(Icons.attach_file),
                    onSelected: (value) {
                      if (value == 'Take a Picture') {
                        _pickFile(FileType.image);
                      } else if (value == 'Upload Document') {
                        _pickFile(FileType.any);
                      }
                    },
                    itemBuilder: (BuildContext context) {
                      return {'Take a Picture', 'Upload Document'}
                          .map((String choice) {
                        return PopupMenuItem<String>(
                          value: choice,
                          child: Text(choice),
                        );
                      }).toList();
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
