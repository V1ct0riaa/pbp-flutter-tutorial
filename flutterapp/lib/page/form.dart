import 'main.dart';
import 'package:flutter/material.dart';

class MyFormPage extends StatefulWidget {
    const MyFormPage({super.key});

    @override
    State<MyFormPage> createState() => _MyFormPageState();
}

class _MyFormPageState extends State<MyFormPage> {
    final _formKey = GlobalKey<FormState>();
    String _namaLengkap = "";
    bool jenjangDiploma = false;
    bool jenjangSarjana = false;
    bool jenjangMagister = false;
    bool jenjangDoktor = false;

    double umur = 0;

    String kelasPBP = 'A';
    List<String> listKelasPBP = ['A', 'B', 'C', 'D', 'E', 'F', 'KI'];

    bool _nilaiSwitch = false;


    @override
    Widget build(BuildContext context) {
        return Scaffold(
            appBar: AppBar(
                title: Text('Form'),
            ),

            drawer: Drawer(
              child: Column(
                children: [
                  // Adds clickable menu
                  ListTile(
                    title: const Text('Counter'),
                    onTap: () {
                      // Routes menu to main page
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => const MyHomePage()),
                      );
                    },
                  ),

                  ListTile(
                    title: const Text('Form'),
                    onTap: () {
                      // Routes menu to form page
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => const MyFormPage()),
                      );
                    },
                  ),
                ],
              ),
            ),

            // body: Center(
            //     child: Column(
            //         mainAxisAlignment: MainAxisAlignment.center,
            //         children: <Widget>[
            //             Text('Hello World!'),
            //         ],
            //     ),
            // ),

            body: Form(
              key: _formKey,
              child: SingleChildScrollView(
                child: Container(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    children: [
                      Padding(
                        // 8 pixels padding
                        padding: const EdgeInsets.all(8.0),
                        child: TextFormField(
                          decoration: InputDecoration(
                            hintText: "Contoh: Pak Dengklek",
                            labelText: "Nama Lengkap",

                            // Adds icon
                            icon: const Icon(Icons.people),

                            // Adds circular border
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5.0),
                            ),
                          ),

                          // Adds behaviour when input is typed
                          onChanged: (String? val) {
                            setState(() {
                              _namaLengkap = val!;
                            });
                          },

                          // Form validator
                          validator: (String? val) {
                            if (val == null || val.isEmpty) {
                              return 'Nama lengkap tidak boleh kosong!';
                            }
                            return null;
                          },
                        ),
                      ),

                      Container(
                        margin: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey),
                          borderRadius: BorderRadius.circular(5.0),
                        ),

                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const ListTile(
                              leading: Icon(Icons.school),
                              title: Text('Jenjang'),
                            ),

                            CheckboxListTile(
                              title: const Text('Sarjana'),
                              value: jenjangSarjana,
                              onChanged: (bool? val) {
                                setState(() {
                                  jenjangSarjana = val!;
                                  if (val) {
                                    jenjangMagister = jenjangDiploma = jenjangDoktor = false;
                                  }
                                });
                              },
                            ),

                            CheckboxListTile(
                              title: const Text('Diploma'),
                              value: jenjangDiploma,
                              onChanged: (bool? val) {
                                setState(() {
                                  jenjangDiploma = val!;

                                  if (val) {
                                    jenjangMagister = jenjangSarjana = jenjangDoktor = false;
                                  }
                                });
                              },
                            ),

                            CheckboxListTile(
                              title: const Text('Magister'),
                              value: jenjangMagister,
                              onChanged: (bool? val) {
                                setState(() {
                                  jenjangMagister = val!;

                                  if (val) {
                                    jenjangDiploma = jenjangDoktor = jenjangSarjana = false;
                                  }
                                });
                              },
                            ),

                            CheckboxListTile(
                              title: const Text('Doktor'),
                              value: jenjangDoktor,
                              onChanged: (bool? val) {
                                setState(() {
                                  jenjangDoktor = val!;

                                  if (val) {
                                    jenjangDiploma = jenjangMagister = jenjangSarjana = false;
                                  }
                                });
                              },
                            ),
                          ],
                        ),
                      ),

                      ListTile(
                        leading: const Icon(Icons.co_present),
                        title: Row(
                          children: [
                            Text('Umur: ${umur.round()}'),
                          ],
                        ),
                        subtitle: Slider(
                          value: umur,
                          max: 100,
                          divisions: 100,
                          label: umur.round().toString(),
                          onChanged: (double val) {
                            setState(() {
                              umur = val;
                            });
                          },
                        ),
                      ),

                      ListTile(
                        leading: const Icon(Icons.class_),
                        title: const Text('Kelas PBP',),
                        trailing: DropdownButton(
                          value: kelasPBP,
                          icon: const Icon(Icons.keyboard_arrow_down),
                          items: listKelasPBP.map((String items) {
                            return DropdownMenuItem(
                              value: items,
                              child: Text(items),
                            );
                          }).toList(),

                          onChanged: (String? newVal) {
                            setState(() {
                              kelasPBP = newVal!;
                            });
                          },
                        ),
                      ),

                      SwitchListTile(
                        title: const Text("Practice Mode"),
                        value: _nilaiSwitch,
                        onChanged: (bool val) {
                          setState(() {
                            _nilaiSwitch = val;
                          });
                        },
                        secondary: const Icon(Icons.run_circle_outlined),
                      ),

                      TextButton(
                        child: const Text(
                          "Simpan",
                          style: TextStyle(color: Colors.white),
                        ),
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(Colors.blue),
                        ),
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            showDialog(
                              context: context,
                              builder: (context) {
                                return Dialog(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),

                                  elevation: 15,

                                  child: Container(
                                    child: ListView(
                                      padding: const EdgeInsets.only(top: 20, bottom: 20),
                                      shrinkWrap: true,
                                      children: <Widget>[
                                        Center(child: const Text('Informasi Data'),),
                                        SizedBox(height: 20,),

                                        // TODO: Show informations from form
                                        Text('Judul: $_namaLengkap'),
                                        TextButton(
                                          onPressed: () {
                                            Navigator.pop(context);
                                          },
                                          child: Text('Kembali'),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            );
                          }
                        },
                      ),

                    ],
                  ),
                ),
              ),
            ),
        );
    }
}