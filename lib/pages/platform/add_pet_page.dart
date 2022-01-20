import 'package:demo/model/index.dart';
import 'package:demo/platform/index.dart';
import 'package:flutter/material.dart';

class AddPetPage extends StatefulWidget {
  static const String rName = "AddPet";

  const AddPetPage({Key? key}) : super(key: key);
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
        title: const Text('Add pet details'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
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
            const SizedBox(
              height: 8,
            ),
            TextField(
              controller: breedTextController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                filled: true,
                hintText: 'Breed of pet',
                labelText: 'Breed',
              ),
            ),
            const SizedBox(height: 8,),
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
