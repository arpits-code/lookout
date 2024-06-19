import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';

void main() {
  runApp(file());
}

class file extends StatelessWidget {
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
  void _pickFile(FileType fileType) async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(type: fileType);

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
      appBar: AppBar(
        title: Text('Sidebar Example'),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Text(
                'Upload Options',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              leading: Icon(Icons.photo),
              title: Text('Upload Picture'),
              onTap: () {
                Navigator.pop(context);
                _pickFile(FileType.image);
              },
            ),
            ListTile(
              leading: Icon(Icons.insert_drive_file),
              title: Text('Upload Document'),
              onTap: () {
                Navigator.pop(context);
                _pickFile(FileType.any);
              },
            ),
          ],
        ),
      ),
      body: Center(
        child: Text('Select an option from the sidebar'),
      ),
    );
  }
}
