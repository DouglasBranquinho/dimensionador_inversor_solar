import 'package:flutter/material.dart';

void main() {
  runApp(DimensionadorApp());
}

class DimensionadorApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Dimensionador de Inversor Solar',
      theme: ThemeData(
        primarySwatch: Colors.amber, // Define a paleta de cores base
      ),
      home: SplashScreen(),
    );
  }
}

// Tela inicial com o botão "Vamos Começar?"
class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.amber, // Fundo amarelo
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('img/usina.png', width: 200), // Logo da empresa
            SizedBox(height: 20),
            Text(
              'Usina, a marca que você confia!',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 30),
            ElevatedButton(
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => HomePage()),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.black, // Cor do botão
                padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
              ),
              child: Text(
                'Vamos Começar?',
                style: TextStyle(fontSize: 18, color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Tela principal com fundo amarelo e texto preto
class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController powerController = TextEditingController();
  final TextEditingController hoursController = TextEditingController();
  double dailyEnergy = 0.0;
  double batteryCapacity = 0.0;
  double continuousPower = 0.0;
  double peakPower = 0.0;
  bool isResultVisible = false;

  void calculate() {
    final power = double.tryParse(powerController.text) ?? 0.0;
    final hours = double.tryParse(hoursController.text) ?? 0.0;

    dailyEnergy = power * hours;
    final systemVoltage = 12.0;
    batteryCapacity = dailyEnergy / systemVoltage;
    continuousPower = power;
    peakPower = continuousPower * 2;

    setState(() {
      isResultVisible = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.amber, // Fundo amarelo
      appBar: AppBar(
        title: Text('Inversor Senoidal Solar'),
        backgroundColor: Colors.black, // Barra superior preta
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Card(
              color: Colors.black, // Fundo do card preto
              margin: EdgeInsets.only(bottom: 20),
              elevation: 5,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    TextField(
                      controller: nameController,
                      style: TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        labelText: 'Nome do Aparelho',
                        labelStyle: TextStyle(color: Colors.white),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                        ),
                      ),
                    ),
                    SizedBox(height: 10),
                    TextField(
                      controller: powerController,
                      keyboardType: TextInputType.number,
                      style: TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        labelText: 'Potência (W)',
                        labelStyle: TextStyle(color: Colors.white),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                        ),
                      ),
                    ),
                    SizedBox(height: 10),
                    TextField(
                      controller: hoursController,
                      keyboardType: TextInputType.number,
                      style: TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        labelText: 'Horas de Uso Diário',
                        labelStyle: TextStyle(color: Colors.white),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: calculate,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        foregroundColor: Colors.black,
                        padding: EdgeInsets.symmetric(
                          horizontal: 30,
                          vertical: 15,
                        ),
                      ),
                      child: Text('Calcular'),
                    ),
                  ],
                ),
              ),
            ),

            if (isResultVisible)
              Card(
                color: Colors.black, // Fundo preto para o card de resultado
                elevation: 5,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      Text(
                        'Resultado:',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(height: 10),
                      Text(
                        'Total de Energia Diária: ${dailyEnergy.toStringAsFixed(2)} Wh',
                        style: TextStyle(color: Colors.white),
                      ),
                      Text(
                        'Capacidade da Bateria: ${batteryCapacity.toStringAsFixed(2)} Ah',
                        style: TextStyle(color: Colors.white),
                      ),
                      Text(
                        'Potência Contínua do Inversor: ${continuousPower.toStringAsFixed(2)} W',
                        style: TextStyle(color: Colors.white),
                      ),
                      Text(
                        'Potência de Pico do Inversor: ${peakPower.toStringAsFixed(2)} W',
                        style: TextStyle(color: Colors.white),
                      ),
                    ],
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
