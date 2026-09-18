import 'package:flutter/material.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;

class TareaPantalla extends StatefulWidget {
  const TareaPantalla({super.key});

  @override
  State<TareaPantalla> createState() => _TareaPantallaState();

  }


class _TareaPantallaState extends State<TareaPantalla> {

  bool _isListening = false;

  @override
  void initState() { 
    super.initState();
    _speech = stt.SpeechToText();
    
  }
  
  late stt.SpeechToText _speech;

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

  void _escucharVoz() async{
    if (!_isListening){
      bool diponible = await _speech.initialize(
        onStatus: (status) => print('Estado: $status'),
        onError: (error) => print('Error : $error'),
      );
      if (diponible){
        setState(() => _isListening = true);

        _speech.listen(
          onResult:(result) {
            setState(() {
              textoTareaControlador.text = result.recognizedWords;
            });
          },
        );
      }
    } else{
      setState(() => _isListening = false);
      _speech.stop();
    }
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
                border: OutlineInputBorder(),
                suffixIcon: IconButton(
                  icon: Icon(
                    _isListening ? Icons.mic : Icons.mic_none,
                    color: _isListening ? Colors.red : Colors.grey,
                    ),
                    onPressed: _escucharVoz,
                    )
              ),
              controller: textoTareaControlador,
            ),

            SizedBox(height: 20,),

            
          Row(
           mainAxisAlignment: .center,
            children: [
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.black,
                foregroundColor: Colors.white
              ),
              onPressed: (){
                setState(() {
                  agregarTarea();
                });
                
              }, child: Icon(Icons.add_circle)),

              SizedBox(width: 50,),

              ElevatedButton(
                style: ElevatedButton.styleFrom(
                backgroundColor: Colors.black,
                foregroundColor: Colors.white
                ),
                onPressed: (){
                  setState(() {
                    textoTareaControlador.text = '';
                  });
                }, 
                child: Icon(Icons.delete)),]),



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
              ),
          ],
        ),
      ),
    );
  }
}