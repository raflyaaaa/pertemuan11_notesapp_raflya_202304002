import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import '../providers/auth_provider.dart';
import '../models/note_model.dart';
import 'login_view.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  int refreshKey = 0;

  Future<List<Note>> fetchNotes(String token) async {
    final url = Uri.parse(
      'https://coercible-ranee-militantly.ngrok-free.dev/api/notes',
    );

    final response = await http.get(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    final decoded = jsonDecode(response.body);
    final List list = decoded is Map ? decoded['data'] : decoded;

    return list.map((e) => Note.fromJson(e)).toList();
  }

  Future<void> createNote(String token, String title, String content) async {
    final url = Uri.parse(
      'https://coercible-ranee-militantly.ngrok-free.dev/api/notes',
    );

    await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode({
        'title': title,
        'content': content,
      }),
    );
  }

  Future<void> updateNote(String token, int id, String title, String content) async {
    final url = Uri.parse(
      'https://coercible-ranee-militantly.ngrok-free.dev/api/notes/$id',
    );

    await http.put(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode({
        'title': title,
        'content': content,
      }),
    );
  }

  Future<void> deleteNote(String token, int id) async {
    final url = Uri.parse(
      'https://coercible-ranee-militantly.ngrok-free.dev/api/notes/$id',
    );

    await http.delete(
      url,
      headers: {
        'Authorization': 'Bearer $token',
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Catatan Pribadi'),
        actions: [
          // ➕ CREATE NOTE
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              final titleController = TextEditingController();
              final contentController = TextEditingController();

              showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: const Text("Tambah Catatan"),
                    content: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        TextField(
                          controller: titleController,
                          decoration: const InputDecoration(labelText: "Judul"),
                        ),
                        TextField(
                          controller: contentController,
                          decoration: const InputDecoration(labelText: "Isi"),
                        ),
                      ],
                    ),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: const Text("Batal"),
                      ),
                      ElevatedButton(
                        onPressed: () async {
                          await createNote(
                            authProvider.token!,
                            titleController.text,
                            contentController.text,
                          );

                          Navigator.pop(context);
                          setState(() => refreshKey++);
                        },
                        child: const Text("Simpan"),
                      ),
                    ],
                  );
                },
              );
            },
          ),

          // LOGOUT
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () async {
              await authProvider.logout();
              if (context.mounted) {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const LoginView()),
                );
              }
            },
          )
        ],
      ),

      body: FutureBuilder<List<Note>>(
        key: ValueKey(refreshKey),
        future: fetchNotes(authProvider.token ?? ''),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('Belum ada catatan.'));
          }

          final notes = snapshot.data!;

          return ListView.builder(
            itemCount: notes.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(notes[index].title),
                subtitle: Text(notes[index].content),

                // ✏️ + 🗑 ACTION
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // EDIT
                    IconButton(
                      icon: const Icon(Icons.edit),
                      onPressed: () {
                        final titleController =
                            TextEditingController(text: notes[index].title);
                        final contentController =
                            TextEditingController(text: notes[index].content);

                        showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: const Text("Edit Catatan"),
                              content: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  TextField(controller: titleController),
                                  TextField(controller: contentController),
                                ],
                              ),
                              actions: [
                                TextButton(
                                  onPressed: () => Navigator.pop(context),
                                  child: const Text("Batal"),
                                ),
                                ElevatedButton(
                                  onPressed: () async {
                                    await updateNote(
                                      authProvider.token!,
                                      notes[index].id!,
                                      titleController.text,
                                      contentController.text,
                                    );

                                    Navigator.pop(context);
                                    setState(() => refreshKey++);
                                  },
                                  child: const Text("Update"),
                                ),
                              ],
                            );
                          },
                        );
                      },
                    ),

                    // DELETE
                    IconButton(
                      icon: const Icon(Icons.delete),
                      onPressed: () async {
                        await deleteNote(
                          authProvider.token!,
                          notes[index].id!,
                        );

                        setState(() => refreshKey++);
                      },
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}