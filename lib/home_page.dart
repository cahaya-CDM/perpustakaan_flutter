import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class BookListPage extends StatefulWidget {
  const BookListPage({super.key});

  @override
  State<BookListPage> createState() => _BookListPageState();
}

class _BookListPageState extends State<BookListPage>{
  List<Map<String, dynamic>> buku = [];

  @override
  void initState(){
    super.initState();
    fetchBooks();
  }

  Future<void> fetchBooks() async{
    final response = await Supabase.instance.client
    .from('buku')
    .select();

    setState(() {
      buku = List<Map<String, dynamic>>.from(response);
    });
  }

  Widget build(BuildContext context){
      return Scaffold(
        appBar: AppBar(
          title: const Text("daftar Buku"),
          actions: [
            IconButton(onPressed: fetchBooks, icon: const Icon(Icons.refresh))
          ],
        ),
        body: buku.isEmpty ? const Center(child: CircularProgressIndicator()) :  ListView.builder(
          itemCount: buku.length,
          itemBuilder: (context, index){
            final book = buku[index];
            return ListTile(
              title: Text(book['judul'] ?? 'No judul', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(book['penulis'] ?? 'No Penulis', style: const TextStyle(fontSize: 14, fontStyle: FontStyle.italic),),
                  Text(book['deskripsi'] ?? 'No deskripsi', style: const TextStyle(fontSize: 12),)
                ],
              ),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(onPressed: (){
                    Navigator.pop(context);
                  }, icon: const Icon(Icons.edit, color: Colors.blue,)),
                  IconButton(onPressed: (){
                    Navigator.pop(context);
                  }, icon: const Icon(Icons.delete, color: Colors.red,)),
                ],
              ),
            );
          }
        ),
      );
    }
}