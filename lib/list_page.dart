import 'dart:io';
import 'package:flutter/material.dart';
import 'user_service.dart';

class ListPage extends StatefulWidget {
  const ListPage({super.key});
  @override
  State<ListPage> createState() => _ListPageState();
}

class _ListPageState extends State<ListPage> {
  late Future<List<Map<String, dynamic>>> future;

  @override
  void initState() {
    super.initState();
    future = UserService.getUsers();
  }

  void reload() {
    final updatedData = UserService.getUsers();
    setState(() {
      future = updatedData;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFF5F7),
      appBar: AppBar(
        title: const Text("E-Leaning 2 (23552011013)"),
        actions: [IconButton(onPressed: reload, icon: const Icon(Icons.refresh))],
      ),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: future,
        builder: (context, snap) {
          if (snap.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          final data = snap.data ?? [];
          if (data.isEmpty) return const Center(child: Text("Kosong nih... 💕"));

          return ListView.builder(
            padding: const EdgeInsets.all(10),
            itemCount: data.length,
            itemBuilder: (context, i) {
              final u = data[i];
              return Card(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                child: ListTile(
                  leading: CircleAvatar(
                    backgroundImage: u['photo'] != '' ? FileImage(File(u['photo'])) : null,
                    child: u['photo'] == '' ? const Icon(Icons.face, color: Colors.pink) : null,
                  ),
                  title: Text("${u['nama_depan']} ${u['nama_belakang']}"),
                  subtitle: Text("@${u['username']}"),
                  onTap: () async {
                    final res = await Navigator.pushNamed(context, '/form', arguments: u);
                    if (res == true) reload();
                  },
                  trailing: IconButton(
                    icon: const Icon(Icons.delete_outline, color: Colors.redAccent),
                    onPressed: () async {
                      await UserService.deleteUser(u['id']);
                      reload();
                    },
                  ),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final res = await Navigator.pushNamed(context, '/form');
          if (res == true) reload();
        },
        backgroundColor: const Color(0xFFFF69B4),
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}