import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class CardConstAnak extends StatefulWidget {
  final DocumentSnapshot documentSnapshot;
  const CardConstAnak({super.key, required this.documentSnapshot});

  @override
  State<CardConstAnak> createState() => _CardConstAnakState();
}

class _CardConstAnakState extends State<CardConstAnak> {
  final userid = FirebaseAuth.instance.currentUser!.uid;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 5.0),
      child: ListTile(
        title: Text(widget.documentSnapshot['nama']),
        subtitle: Text(widget.documentSnapshot['sekolah']),
      ),
    );
  }
}
