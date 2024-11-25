import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'insert.dart';

class BookListPage extends StatefulWidget {
  const BookListPage({super.key});

  @override
  State<BookListPage> createState() => _BookListPageState();
}

class _BookListPageState extends State<BookListPage> {
  List<Map<String, dynamic>> buku = [];

  @override
  void initState() {
    super.initState();
    fetchBooks();
  }

  Future<void> fetchBooks() async {
    final response = await Supabase.instance.client.from('buku').select();

    setState(() {
      buku = List<Map<String, dynamic>>.from(response);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        shadowColor: Colors.black,
        elevation: 8,
        backgroundColor: Colors.blue,
        title: Stack(
          children: [
            Text(
              "DAFTAR BUKU",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontFamily: 'think',
                fontSize: 40,
                foreground: Paint()
                  ..style = PaintingStyle.stroke
                  ..strokeWidth = 10
                  ..color = Colors.white,
              ),
            ),
            const Text(
              "DAFTAR BUKU",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontFamily: 'think',
                  fontSize: 40,
                  color: Colors.black),
            )
          ],
        ),
        actions: [
          IconButton(
            onPressed: fetchBooks,
            icon: const Icon(Icons.refresh),
            tooltip: "Refresh daftar",
          ),
          
        ],
      ),
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.blue, Colors.purple], // Warna gradient
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: buku.isEmpty
                ? const Center(child: CircularProgressIndicator())
                : ListView.builder(
                    padding: const EdgeInsets.all(10),
                    itemCount: buku.length,
                    itemBuilder: (context, index) {
                      final book = buku[index];
                      return Card(
                        shadowColor: Colors.grey,
                        elevation: 15.0,
                        margin: const EdgeInsets.symmetric(vertical: 8),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                          side: const BorderSide(
                            color: Colors.black,
                            width: 2.0,
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                book['judul'] ?? 'No Judul',
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 25,
                                    fontFamily: 'shine'),
                              ),
                              const SizedBox(height: 8),
                              Row(
                                children: [
                                  const Text(
                                    "Penulis : ",
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    book['penulis'] ?? 'No Penulis',
                                    style: const TextStyle(
                                      fontSize: 14,
                                      fontStyle: FontStyle.italic,
                                      color: Colors.black54,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 4),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Padding(
                                    padding: EdgeInsets.only(bottom: 22.0),
                                    child: Text(
                                      "Deskripsi : ",
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 8), // Memberikan jarak antara label dan deskripsi
                                  Expanded(
                                    child: Text(
                                      book['deskripsi'] ?? 'No Deskripsi',
                                      style: const TextStyle(
                                        fontSize: 12,
                                        color: Colors.black87,
                                      ),
                                      overflow: TextOverflow.ellipsis, // Menghindari teks terlalu panjang
                                      maxLines: 3, // Membatasi jumlah baris
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 16),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  IconButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    icon: const Icon(Icons.edit),
                                    color: Colors.blue,
                                    tooltip: "Edit buku",
                                  ),
                                  IconButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    icon: const Icon(Icons.delete),
                                    color: Colors.red,
                                    tooltip: "Hapus buku",
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final result = await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const AddBookPage()),
          );
          if (result == true) {
            fetchBooks(); // Refresh daftar buku setelah menambahkan data
          }
        },
        tooltip: "Tambah Buku",
        child: const Icon(Icons.add),
      ),
    );
  }
}
