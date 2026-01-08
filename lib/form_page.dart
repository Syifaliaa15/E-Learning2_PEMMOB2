import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'user_service.dart';

class FormPage extends StatefulWidget {
  final Map<String, dynamic>? user;
  const FormPage({super.key, this.user});
  @override
  State<FormPage> createState() => _FormPageState();
}

class _FormPageState extends State<FormPage> {
  final keyForm = GlobalKey<FormState>();
  late TextEditingController ndepan, nbelakang, mail, usr, pwd;
  File? pickedPhoto;
  bool loading = false;

  @override
  void initState() {
    super.initState();
    ndepan = TextEditingController(text: widget.user?['nama_depan'] ?? '');
    nbelakang = TextEditingController(text: widget.user?['nama_belakang'] ?? '');
    mail = TextEditingController(text: widget.user?['email'] ?? '');
    usr = TextEditingController(text: widget.user?['username'] ?? '');
    pwd = TextEditingController();
    if (widget.user?['photo'] != null && widget.user?['photo'] != '') {
      pickedPhoto = File(widget.user!['photo']);
    }
  }

  Future<void> _pickPhoto() async {
    final x = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (x != null) setState(() => pickedPhoto = File(x.path));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.user != null ? "Edit ✨" : "Baru ✨")),
      body: Form(
        key: keyForm,
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            Center(
              child: GestureDetector(
                onTap: _pickPhoto,
                child: CircleAvatar(
                  radius: 50,
                  backgroundImage: pickedPhoto != null ? FileImage(pickedPhoto!) : null,
                  child: pickedPhoto == null ? const Icon(Icons.add_a_photo) : null,
                ),
              ),
            ),
            const SizedBox(height: 20),
            _input(ndepan, "Nama Depan"),
            _input(nbelakang, "Nama Belakang"),
            _input(mail, "Email"),
            _input(usr, "Username"),
            _input(pwd, "Password", isPass: true),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: loading ? null : _submit,
              style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFFFF69B4)),
              child: Text(loading ? "..." : "Simpan ✨", style: const TextStyle(color: Colors.white)),
            ),
          ],
        ),
      ),
    );
  }

  Widget _input(TextEditingController c, String l, {bool isPass = false}) {
    return TextFormField(
      controller: c,
      obscureText: isPass,
      decoration: InputDecoration(labelText: l),
      validator: (v) => v!.isEmpty ? "Wajib isi" : null,
    );
  }

  Future<void> _submit() async {
    if (!keyForm.currentState!.validate()) return;
    setState(() => loading = true);
    await UserService.insup(
      id: widget.user?['id'],
      ndepan: ndepan.text,
      nbelakang: nbelakang.text,
      mail: mail.text,
      usr: usr.text,
      pwd: pwd.text,
      photoPath: pickedPhoto?.path,
    );
    if (mounted) Navigator.pop(context, true);
  }
}