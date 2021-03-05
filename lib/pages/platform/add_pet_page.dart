import 'package:demo/platform/index.dart';
import 'package:flutter/material.dart';

class AddPetPage extends StatefulWidget {
  static const String rName = "AddPet";
  @override
  _AddPetPageState createState() => _AddPetPageState();
}

class _AddPetPageState extends State<AddPetPage> {
  final breedTextController = TextEditingController();
  String petType = 'Dog';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add pet details'),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              PetListMessageChannel.addPetDetails(PetDetails(
                petType: petType,
                breed: breedTextController.text,
              ));
              Navigator.pop(context);
            },
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            SizedBox(
              height: 8,
            ),
            TextField(
              controller: breedTextController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                filled: true,
                hintText: 'Breed of pet',
                labelText: 'Breed',
              ),
            ),
            SizedBox(height: 8,),
            RadioListTile<String>(
              title: const Text("Dog"),
              value: 'Dog',
              groupValue: petType,
              onChanged: (value) {
                setState(() {
                  petType = value!;
                });
              },
            ),
            RadioListTile<String>(
              title: const Text("Cat"),
              value: 'Cat',
              groupValue: petType,
              onChanged: (value) {
                setState(() {
                  petType = value!;
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}
