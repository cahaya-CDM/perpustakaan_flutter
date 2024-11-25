import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AddBookPage extends StatefulWidget {
  const AddBookPage({super.key});

  @override
  State<AddBookPage> createState() => _AddBookPageState();
}

class _AddBookPageState extends State<AddBookPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _judulController = TextEditingController();
  final TextEditingController _penulisController = TextEditingController();
  final TextEditingController _deskripsiController = TextEditingController();

  bool _isLoading = false;

  Future<void> tambahBuku() async {
    if (!_formKey.currentState!.validate()) return;

    // Menutup keyboard
    FocusScope.of(context).unfocus();

    setState(() {
      _isLoading = true;
    });

    try {
      final response = await Supabase.instance.client.from('buku').insert({
        'judul': _judulController.text.trim(),
        'penulis': _penulisController.text.trim(),
        'deskripsi': _deskripsiController.text.trim(),
      });

      if (response.error == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Buku berhasil ditambahkan!")),
        );
        Navigator.pop(context, true); // Mengembalikan hasil ke halaman sebelumnya
      } else {
        throw Exception(response.error?.message ?? 'Terjadi kesalahan');
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Gagal menambahkan buku: $e")),
      );
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  void dispose() {
    _judulController.dispose();
    _penulisController.dispose();
    _deskripsiController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Tambah Buku"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                controller: _judulController,
                decoration: const InputDecoration(labelText: "Judul Buku"),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return "Judul tidak boleh kosong";
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _penulisController,
                decoration: const InputDecoration(labelText: "Penulis"),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return "Penulis tidak boleh kosong";
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _deskripsiController,
                decoration: const InputDecoration(labelText: "Deskripsi"),
                maxLines: 3,
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return "Deskripsi tidak boleh kosong";
                  }
                  return null;
                },
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _isLoading ? null : tambahBuku,
                  child: _isLoading
                      ? const SizedBox(
                          height: 20,
                          width: 20,
                          child: CircularProgressIndicator(
                            color: Colors.white,
                            strokeWidth: 2,
                          ),
                        )
                      : const Text("Simpan"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
