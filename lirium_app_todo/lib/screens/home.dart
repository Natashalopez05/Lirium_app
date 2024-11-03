import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}


class _HomeState extends State<Home> {
  final List<String> _notes = []; // Lista de notas
  final List<bool> _checked = []; // Lista de verificación
  final TextEditingController _noteController = TextEditingController(); // Controlador de texto

  // Método para agregar una nota
  void _addNote() {
    setState(() {
      _notes.insert(0, _noteController.text);
      _checked.insert(0, false);
      _noteController.clear();
    });
  }

  // Método para eliminar una nota
  void _deleteNote(int index) {
    setState(() {
      _notes.removeAt(index);
      _checked.removeAt(index);
    });
  }

  // Método para mostrar el modal
  void _showMenuModal() {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Menú',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              ListTile(
                leading: const Icon(Icons.delete),
                title: const Text('Eliminados'),
                onTap: () {
                  // Acción para Configuración
                  Navigator.pop(context);
                },
              ),
             
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.menu, color: Colors.black), // Icono de menú
          onPressed: _showMenuModal, // Mostrar el modal al presionar el botón de menú
        ),
        title: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Lirium',
              style: TextStyle(
                color: Colors.black,
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 16.0), // Espaciado a la derecha
            child: CircleAvatar(
              radius: 20, // Tamaño del círculo
              backgroundImage: AssetImage('assets/images/lirio-profile.png'), // Ruta de la imagen
            ),
          ),
        ],
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color(0xFFE57373), // Rojo Rubor
                Color(0xFFFFF1E6), // Beige Claro
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
      ),
      body: Stack(
        children: [
          Align(
            alignment: Alignment.topCenter,
            child: Padding(
              padding: const EdgeInsets.only(left: 20.0, right: 20.0), // Espaciado a los lados
              child: Scrollbar(
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width * 0.90, // Ancho del cuadro de título
                        decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 255, 255, 255), // Beige Claro
                          borderRadius: BorderRadius.circular(20.0),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.2),
                              blurRadius: 6,
                              offset: const Offset(0, 3),
                            ),
                          ],
                        ),
                        margin: const EdgeInsets.only(top: 50, bottom: 20),
                        padding: const EdgeInsets.all(20.0), // Espaciado interno
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'All ToDos',
                              style: TextStyle(
                                color: Color.fromRGBO(0, 0, 0, 1), // Color del texto
                                fontSize: 25, // Tamaño de la fuente
                                fontWeight: FontWeight.bold, // Peso de la fuente
                              ),
                            ),
                            const SizedBox(height: 10), // Espaciado entre el texto y el campo de búsqueda
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 16.0),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(20.0),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.2),
                                    blurRadius: 6,
                                    offset: const Offset(0, 3),
                                  ),
                                ],
                              ),
                              child: const TextField(
                                decoration: InputDecoration(
                                  hintText: 'Search...',
                                  border: InputBorder.none,
                                  suffixIcon: Icon(Icons.search, color: Color.fromARGB(255, 97, 1, 1), size: 30),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width * 0.90, // Ancho del cuadro de notas
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20.0),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.2),
                              blurRadius: 6,
                              offset: const Offset(0, 3),
                            ),
                          ],
                        ),
                        padding: const EdgeInsets.all(10.0), // Espaciado interno
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Notas',
                              style: TextStyle(
                                color: Color.fromRGBO(0, 0, 0, 1), // Color del texto
                                fontSize: 20, // Tamaño de la fuente
                                fontWeight: FontWeight.bold, // Peso de la fuente
                              ),
                            ),
                            const SizedBox(height: 10), // Espaciado entre el título y las notas
                            // Mostrar notas
                            for (int i = 0; i < _notes.length; i++)
                              Row(
                                children: [
                                  Checkbox(
                                    value: _checked[i],
                                    onChanged: (bool? value) {
                                      setState(() {
                                        _checked[i] = value!;
                                      });
                                    },
                                  ),
                                  Expanded(
                                    child: Text(
                                      _notes[i],
                                      style: TextStyle(
                                        color: _checked[i] ? Colors.grey : Colors.black,
                                        fontSize: 16,
                                        decoration: _checked[i] ? TextDecoration.lineThrough : null,
                                      ),
                                    ),
                                  ),
                                  IconButton(
                                    icon: const Icon(Icons.delete, color: Color.fromARGB(255, 97, 1, 1), size: 30),
                                    onPressed: () => _deleteNote(i),
                                  ),
                                ],
                              ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: 110, // Altura del degradado inferior
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Color(0xFFFFF1E6), // Beige Claro
                    Color(0xFFE57373), // Rojo Rubor
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 20.0), // Espaciado inferior para ajustar la posición
              child: Container(
                width: MediaQuery.of(context).size.width * 0.90, // Ancho del cuadro de entrada
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20.0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      blurRadius: 6,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _noteController,
                        decoration: const InputDecoration(
                          hintText: 'Add a new todo...',
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.add, color: Color.fromARGB(255, 97, 1, 1), size: 40),
                      onPressed: _addNote,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}