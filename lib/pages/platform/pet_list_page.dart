import 'dart:convert';

import 'package:demo/model/index.dart';
import 'package:demo/model/pet_list_model.dart';
import 'package:demo/pages/index.dart';
import 'package:demo/platform/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class PetListPage extends StatefulWidget {
  static const String rName = "PetList";

  const PetListPage({Key? key}) : super(key: key);

  @override
  _PetListPageState createState() => _PetListPageState();
}

class _PetListPageState extends State<PetListPage> {
  PetListModel? petListModel;
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    const BasicMessageChannel('flutter_demo/string_message_channel', StringCodec())
        .setMessageHandler((message) async {
      if (message == null) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("An error occurred while adding pet details")));
      } else {
        setState(() {
          final jsonData = json.decode(message) as Map<String, dynamic>;
          petListModel = PetListModel.fromJson(jsonData);
        });
      }
      return Future.value('');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        title: const Text('Pet List'),
      ),
      body: petListModel?.petList.isEmpty ?? true
          ? const Center(
              child: Text("Enter Pet Details"),
            )
          : BuildPetList(petListModel!.petList),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          Navigator.pushNamed(context, AddPetPage.rName);
        },
      ),
    );
  }
}

class BuildPetList extends StatelessWidget {
  final List<PetDetails> petList;

  const BuildPetList(this.petList, {Key? key}): super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.all(8),
      itemCount: petList.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text('Pet breed: ${petList[index].breed}'),
          subtitle: Text('Pet type: ${petList[index].petType}'),
          trailing: IconButton(
            icon: const Icon(Icons.delete),
            onPressed: () async {
              try {
                await PetListMessageChannel.removePet(index);
                showSnackBar('Removed successfully', context);
              } catch (e) {
                showSnackBar(e.toString(), context);
              }
            },
          ),
        );
      },
    );
  }

  void showSnackBar(String message, BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
  }
}
