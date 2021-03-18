import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Calcular Imc',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Calculo Imc"),
        centerTitle: true,
        backgroundColor: Colors.red,
      ),
      body: Calcular(),
    );
  }
}

class Calcular extends StatefulWidget {
  @override
  _CalcularState createState() => _CalcularState();
}

class _CalcularState extends State<Calcular> {

  TextEditingController _ctrlPeso = TextEditingController();
  TextEditingController _ctrlAltura = TextEditingController();
  var resultado = "Imc";

  void calculo(){
    double _peso = double.tryParse(_ctrlPeso.text);
    double _altura = double.tryParse(_ctrlAltura.text);
    
    if(_peso == null || _altura == null){
      setState(() {
        resultado = "Um ou mais campos devem ser preenchidos !";        
      });
    } else{


      var calcula = _peso / (_altura * _altura);
      

      setState(() {

        var imc = calcula.toStringAsFixed(2);
        var grau = "";

        if(calcula < 16){
          grau = "Magreza Grau 3";
          resultado = "Seu imc é: $imc \n Grau: $grau \n Risco: Nenhum";
          SystemChannels.textInput.invokeMethod('TextInput.hide'); 
        }
        else if(calcula == 16 || calcula < 16.9 ) {
          grau = "Magreza Grau 2";
          resultado = "Seu imc é: $imc \n Grau: $grau \n Risco: Nenhum";
          SystemChannels.textInput.invokeMethod('TextInput.hide'); 
        }
        else if(calcula == 17 || calcula < 18.4 ) {
          grau = "Magreza Grau 1";
          resultado = "Seu imc é: $imc \n Grau: $grau \n Risco: Nenhum";
          SystemChannels.textInput.invokeMethod('TextInput.hide'); 
        }
        else if(calcula == 18.5 || calcula < 24.9 ) {
          grau = "Eutrofia";
          resultado = "Seu imc é: $imc \n Grau: $grau \n Risco: Nenhum";
          SystemChannels.textInput.invokeMethod('TextInput.hide'); 
        }
        else if(calcula == 25 || calcula < 29.9 ) {
          grau = "Sobrepeso";
          resultado = "Seu imc é: $imc \n Grau: $grau \n Risco: Aumentado";
          SystemChannels.textInput.invokeMethod('TextInput.hide'); 
        }
        else if(calcula == 30 || calcula < 34.9 ) {
          grau = "Obesidade Grau 1";
          resultado = "Seu imc é: $imc \n Grau: $grau \n Risco: Moderado";
          SystemChannels.textInput.invokeMethod('TextInput.hide'); 
        }
        else if(calcula == 35 || calcula < 40 ) {
          grau = "Obesidade Grau 2";
          resultado = "Seu imc é: $imc \n Grau: $grau \n Risco: Grave";
          SystemChannels.textInput.invokeMethod('TextInput.hide'); 
        }
        else if(calcula > 40 ) {
          grau = "Obesidade Grau 3";
          resultado = "Seu imc é: $imc \n Grau: $grau \n Risco: Muito grave";
          SystemChannels.textInput.invokeMethod('TextInput.hide'); 
        }      
      });
    }
  }

  void limpar(){
    _ctrlPeso.text = " ";
    _ctrlAltura.text = " ";
    resultado = "Imc";
  }



  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.stretch,

        children: [
          Text(
            resultado,
            style: new TextStyle(
              fontSize: 20.0,
              color: Colors.blue
            ),
            textAlign: TextAlign.center,
          ),
          TextField(
            controller: _ctrlPeso,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(labelText: "Digite seu peso Ex: 71.60"),
            style: TextStyle(
              fontSize: 20.0,
              color: Colors.blue,
              fontWeight: FontWeight.w400,
            ),
          ),


          TextField(
            controller: _ctrlAltura,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(labelText: "Digite sua altura Ex: 1.80"),
            style: TextStyle(
              fontSize: 20.0,
              color: Colors.blue,
              fontWeight: FontWeight.w400,
            ),
          ),

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                margin: const EdgeInsets.all(10.0),
                child: ElevatedButton(
                  onPressed: () {
                    calculo();
                  },
                  child: new Text(
                    "Calcular",
                    style: new TextStyle(
                      fontSize: 20.0,
                      color: Colors.white,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.all(10.0),
                child: ElevatedButton(
                  onPressed: () {
                    limpar();
                  },
                  child: new Text(
                    "Limpar",
                    style: new TextStyle(
                      fontSize: 20.0,
                      color: Colors.white,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}