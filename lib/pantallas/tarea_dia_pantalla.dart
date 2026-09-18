import 'package:flutter/material.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;

class TareaDiaPantalla extends StatefulWidget {
  const TareaDiaPantalla({super.key});

  @override
  State<TareaDiaPantalla> createState() => _TareaPantallaState();

  }


class _TareaPantallaState extends State<TareaDiaPantalla> {

  bool _isListening = false;
  bool _isListeningtarde = false;
  bool _isListeningnoche = false;

  @override
  void initState() { 
    super.initState();
    _speech = stt.SpeechToText();
    
  }
  
  late stt.SpeechToText _speech;

  final TextEditingController textoTareaControlador = TextEditingController();
  final TextEditingController textoTareaControladortarde = TextEditingController();
  final TextEditingController textoTareaControladornoche = TextEditingController();

  List <String> tareas= [];
  List <String> tareastarde= [];
  List <String> tareasnochee= [];


 
  void agregarTarea(){
    setState(() {
      tareas.add(textoTareaControlador.text);
      textoTareaControlador.clear();
    });
  }

   void agregarTareatarde(){
    setState(() {
      tareastarde.add(textoTareaControladortarde.text);
      textoTareaControladortarde.clear();
    });
  }

  void agregarTareanoche(){
    setState(() {
      tareasnochee.add(textoTareaControladornoche.text);
      textoTareaControladornoche.clear();
    });
  }
  
  void borrarTarea(int index){
    setState(() {
      tareas.removeAt(index);
    });
  }
   void borrarTareatarde(int index){
    setState(() {
      tareastarde.removeAt(index);
    });
  }

   void borrarTareanoche(int index){
    setState(() {
      tareasnochee.removeAt(index);
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
  /////////////////////////////
   void _escucharVoztarde() async{
    if (!_isListeningtarde){
      bool diponible = await _speech.initialize(
        onStatus: (status) => print('Estado: $status'),
        onError: (error) => print('Error : $error'),
      );
      if (diponible){
        setState(() => _isListeningtarde = true);

        _speech.listen(
          onResult:(result) {
            setState(() {
              textoTareaControladortarde.text = result.recognizedWords;
            });
          },
        );
      }
    } else{
      setState(() => _isListeningtarde = false);
      _speech.stop();
    }
  }
////////////////////////////
   void _escucharVoznoche() async{
    if (!_isListeningnoche){
      bool diponible = await _speech.initialize(
        onStatus: (status) => print('Estado: $status'),
        onError: (error) => print('Error : $error'),
      );
      if (diponible){
        setState(() => _isListeningnoche = true);

        _speech.listen(
          onResult:(result) {
            setState(() {
              textoTareaControladornoche.text = result.recognizedWords;
            });
          },
        );
      }
    } else{
      setState(() => _isListeningnoche = false);
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

            Text('Tareas para hacer en el Día  ${tareas.length}'),

            
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


/////////////////////////////////////

Text('Tareas para hacer en la tarde  ${tareastarde.length}'),
TextField(
              decoration: InputDecoration(
                labelText: 'Ingresa una tarea',
                border: OutlineInputBorder(),
                suffixIcon: IconButton(
                  icon: Icon(
                    _isListeningtarde ? Icons.mic : Icons.mic_none,
                    color: _isListeningtarde ? Colors.red : Colors.grey,
                    ),
                    onPressed: _escucharVoztarde,
                    )
              ),
              controller: textoTareaControladortarde,
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
                  agregarTareatarde();
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
                    textoTareaControladortarde.text = '';
                  });
                }, 
                child: Icon(Icons.delete)),]),



              Expanded(
                child: ListView.builder(
                  itemCount: tareastarde.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(tareastarde[index]),
                      trailing: IconButton(
                        icon: const Icon(Icons.delete, color: Colors.red,),
                        onPressed: ()=> borrarTareatarde(index)
                      ),
                    );
                  },
                ),
              ),


/////////////////////////////////////
Text('Tareas para hacer en la noche:${tareasnochee.length} '),
TextField(
              decoration: InputDecoration(
                labelText: 'Ingresa una tarea',
                border: OutlineInputBorder(),
                suffixIcon: IconButton(
                  icon: Icon(
                    _isListeningnoche ? Icons.mic : Icons.mic_none,
                    color: _isListeningnoche ? Colors.red : Colors.grey,
                    ),
                    onPressed: _escucharVoznoche,
                    )
              ),
              controller: textoTareaControladornoche,
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
                  agregarTareanoche();
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
                    textoTareaControladornoche.text = '';
                  });
                }, 
                child: Icon(Icons.delete)),]),



              Expanded(
                child: ListView.builder(
                  itemCount: tareasnochee.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(tareasnochee[index]),
                      trailing: IconButton(
                        icon: const Icon(Icons.delete, color: Colors.red,),
                        onPressed: ()=> borrarTareanoche(index)
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