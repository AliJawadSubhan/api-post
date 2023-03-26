import 'package:apicrud/model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as https;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Future<Data?> postApi(String name, String job) async {
    var response = await https.post(Uri.https('reqres.in', 'api/users'), body: {
      'name': name,
      'job': job,
    });
    var data = response.body;
    print(data);

    if (response.statusCode == 201) {
      return dataFromJson(response.body);
    } else {
      return null;
    }
  }

  String title = 'Api';
  TextEditingController nameController = TextEditingController();

  TextEditingController jobController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            TextField(
              controller: nameController,
              decoration: const InputDecoration(
                hintText: 'Name',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(
              height: 12,
            ),
            TextField(
              controller: jobController,
              decoration: const InputDecoration(
                hintText: 'Job',
                border: OutlineInputBorder(),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                String name = nameController.text;
                String job = jobController.text;
                postApi(name, job);
              },
              child: const Text('Submit'),
            ),
          ],
        ),
      ),
    );
  }
}
