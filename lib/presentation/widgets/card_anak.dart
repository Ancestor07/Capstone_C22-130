// ignore_for_file: unnecessary_null_comparison, use_build_context_synchronously, empty_catches

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:ngawasi/presentation/widgets/show_message.dart';

class CardAnak extends StatefulWidget {
  final DocumentSnapshot documentSnapshot;
  const CardAnak({super.key, required this.documentSnapshot});

  @override
  State<CardAnak> createState() => _CardAnakState();
}

class _CardAnakState extends State<CardAnak> {
  final _anak = FirebaseFirestore.instance.collection('anak');
  final userid = FirebaseAuth.instance.currentUser!.uid;

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Card(
        margin: const EdgeInsets.all(10),
        child: ListTile(
            title: Text(widget.documentSnapshot['nama']),
            subtitle: Text(widget.documentSnapshot['sekolah']),
            trailing: SizedBox(
              width: 100,
              child: Row(
                children: [
                  IconButton(
                    onPressed: () async {
                      try {
                        await _update(widget.documentSnapshot);
                      } catch (e) {}
                    },
                    icon: const Icon(Icons.edit),
                  ),
                  IconButton(
                    onPressed: () async {
                      try {
                        await _delete(widget.documentSnapshot.id);
                      } catch (e) {
                        ShowMessage(
                          message: e.toString(),
                        );
                      }
                    },
                    icon: const Icon(Icons.delete),
                  ),
                ],
              ),
            )),
      ),
    );
  }

  final TextEditingController _namaController = TextEditingController();

  final TextEditingController _sekolahController = TextEditingController();

  final TextEditingController _tglController = TextEditingController();

  Future<void> _update([DocumentSnapshot? documentSnapshot]) async {
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
                        await _anak.doc(documentSnapshot!.id).update({
                          "nama": nama,
                          "sekolah": sekolah,
                          "lahir": lahir,
                          "parentId": userid
                        });
                      }
                    },
                    child: const Text('Update'))
              ],
            ),
          );
        });
  }

  Future<void> _delete(String id) async {
    await _anak.doc(id).delete();

    // ignore: use_build_context_synchronously
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('You have successfully deleted a product')));
  }
}
