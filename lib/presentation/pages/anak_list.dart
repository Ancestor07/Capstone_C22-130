// ignore_for_file: use_build_context_synchronously

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:ngawasi/presentation/widgets/card_anak.dart';
import 'package:ngawasi/presentation/widgets/show_message.dart';

class AnakList extends StatefulWidget {
  const AnakList({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _AnakListState createState() => _AnakListState();
}

final CollectionReference _anak = FirebaseFirestore.instance.collection('anak');
final userid = FirebaseAuth.instance.currentUser!.uid;
final TextEditingController _namaController = TextEditingController();
final TextEditingController _sekolahController = TextEditingController();
final TextEditingController _tglController = TextEditingController();

class _AnakListState extends State<AnakList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: StreamBuilder(
          stream: _anak.snapshots(),
          builder: (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
            if (streamSnapshot.hasData) {
              return ListView.builder(
                  itemCount: streamSnapshot.data!.docs.length,
                  itemBuilder: (context, index) {
                    final DocumentSnapshot documentSnapshot =
                        streamSnapshot.data!.docs[index];
                    return CardAnak(documentSnapshot: documentSnapshot);
                  });
            }
            return const Center(
                //child: CircularProgressIndicator(),
                );
          },
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () => _create(),
          child: const Icon(Icons.add),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat);
  }

  Future<void> _create([DocumentSnapshot? documentSnapshot]) async {
    if (documentSnapshot != null) {
      _namaController.text = documentSnapshot["nama"];
      _sekolahController.text = documentSnapshot["sekolah"];
      _tglController.text = documentSnapshot["lahir"];
    }
    await showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (BuildContext ctx) {
          return Padding(
            padding: EdgeInsets.only(
                top: 20,
                left: 20,
                right: 20,
                bottom: MediaQuery.of(context).viewInsets.bottom + 20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextField(
                  controller: _namaController,
                  decoration: const InputDecoration(hintText: 'Nama'),
                ),
                TextField(
                  controller: _sekolahController,
                  decoration: const InputDecoration(hintText: 'Sekolah'),
                ),
                TextField(
                  controller: _tglController,
                  decoration: InputDecoration(
                    hintText: 'Tanggal Lahir',
                    suffixIcon: IconButton(
                      onPressed: () async {
                        DateTime pickDate = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(2000),
                          lastDate: DateTime(2222),
                        ) as DateTime;
                        String formattedDate =
                            DateFormat.yMd().format(pickDate);
                        _tglController.text = formattedDate;
                      },
                      icon: const Icon(Icons.calendar_month),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                    onPressed: () async {
                      final String nama = _namaController.text;
                      final String sekolah = _sekolahController.text;
                      final String lahir = _tglController.text;

                      if (nama.isEmpty || sekolah.isEmpty || lahir.isEmpty) {
                        const ShowMessage(message: "Lengkapi seluruh data");
                      } else {
                        await _anak.add({
                          "nama": nama,
                          "sekolah": sekolah,
                          "lahir": lahir,
                          "parentId": userid
                        });
                        _namaController.text = "";
                        _sekolahController.text = "";
                        _tglController.text = "";
                        Navigator.of(context).pop();
                      }
                    },
                    child: const Text('Add'))
              ],
            ),
          );
        });
  }
}
