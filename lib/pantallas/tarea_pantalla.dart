import 'package:flutter/material.dart';

class TareaPantalla extends StatefulWidget {
  const TareaPantalla({super.key});

  @override
  State<TareaPantalla> createState() => _TareaPantallaState();

  }


class _TareaPantallaState extends State<TareaPantalla> {
  final TextEditingController textoTareaControlador = TextEditingController();
  List <String> tareas= [];
 
  void agregarTarea(){
    setState(() {
      tareas.add(textoTareaControlador.text);
      textoTareaControlador.clear();
    });
  }
  
  void borrarTarea(int index){
    setState(() {
      tareas.removeAt(index);
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
        title: Text('Lista de Tareas'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
         
          children: [
            
            TextField(
              decoration: InputDecoration(
                labelText: 'Ingresa una tarea',
                border: OutlineInputBorder()
              ),
              controller: textoTareaControlador,
            ),

            SizedBox(height: 20,),
        
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.black,
                foregroundColor: Colors.white
              ),
              onPressed: (){
                setState(() {
                  agregarTarea();
                });
                
              }, child: Text('Agregar')),



              Expanded(
                child: ListView.builder(
                  itemCount: tareas.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(tareas[index]),
                      trailing: IconButton(
                        icon: const Icon(Icons.delete, color: Colors.red,),
                        onPressed: ()=> borrarTarea(index)
                      ),
                    );
                  },
                ),
              )
          ],
        ),
      ),
    );
  }
}