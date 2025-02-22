import 'package:flutter/material.dart';

class CalculadoraFonte extends StatefulWidget {
  @override
  _CalculadoraFonteState createState() => _CalculadoraFonteState();
}

class _CalculadoraFonteState extends State<CalculadoraFonte> {
  double potenciaAltoFalante = 0; // Potência de cada alto-falante
  int quantidadeAltoFalantes = 0; // Quantidade de alto-falantes
  double amperagemBateria = 0; // Amperagem de cada bateria
  int quantidadeBaterias = 0; // Quantidade de baterias
  double potenciaRmsTotal = 0;
  double consumoCorrente = 0;
  double capacidadeBateria = 0;
  int fonteRecomendada = 0;

  void calcular() {
    setState(() {
      // Calcula a potência RMS total com base na potência de cada alto-falante e na quantidade
      potenciaRmsTotal = potenciaAltoFalante * quantidadeAltoFalantes;

      // Considerando uma eficiência de 75% para o amplificador
      double potenciaReal = potenciaRmsTotal / 0.75;

      // Consumo de corrente = Potência Real / Tensão do sistema (12V)
      consumoCorrente = potenciaReal / 12;

      // Capacidade da bateria = Quantidade de baterias * Amperagem de cada bateria
      capacidadeBateria = quantidadeBaterias * amperagemBateria;

      // Fonte recomendada com margem de segurança de 20%
      fonteRecomendada = (consumoCorrente * 1.2).ceil();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.amber, // Fundo amarelo
      appBar: AppBar(
        title: Text('Calculadora de Fonte'),
        backgroundColor: Colors.black, // AppBar preta
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Card(
              color: Colors.black, // Fundo do cartão preto
              elevation: 5,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    // Potência de cada alto-falante
                    _buildTextField(
                      label: 'Potência de cada alto-falante (W)',
                      onChanged: (value) {
                        setState(() {
                          potenciaAltoFalante = double.tryParse(value) ?? 0;
                        });
                      },
                    ),
                    SizedBox(height: 10),
                    // Quantidade de alto-falantes
                    _buildTextField(
                      label: 'Quantidade de alto-falantes',
                      onChanged: (value) {
                        setState(() {
                          quantidadeAltoFalantes = int.tryParse(value) ?? 0;
                        });
                      },
                    ),
                    SizedBox(height: 10),
                    // Amperagem de cada bateria
                    _buildTextField(
                      label: 'Amperagem de cada bateria (Ah)',
                      onChanged: (value) {
                        setState(() {
                          amperagemBateria = double.tryParse(value) ?? 0;
                        });
                      },
                    ),
                    SizedBox(height: 10),
                    // Quantidade de baterias
                    _buildTextField(
                      label: 'Quantidade de baterias',
                      onChanged: (value) {
                        setState(() {
                          quantidadeBaterias = int.tryParse(value) ?? 0;
                        });
                      },
                    ),
                    SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: calcular,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        foregroundColor: Colors.black,
                      ),
                      child: Text('Calcular'),
                    ),
                  ],
                ),
              ),
            ),
            if (fonteRecomendada > 0)
              Card(
                color: Colors.black,
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
                      _buildResultText(
                        label: 'Potência RMS Total:',
                        value: '${potenciaRmsTotal.toStringAsFixed(2)} W',
                      ),
                      _buildResultText(
                        label: 'Consumo de Corrente:',
                        value: '${consumoCorrente.toStringAsFixed(2)} A',
                      ),
                      _buildResultText(
                        label: 'Capacidade da Bateria:',
                        value: '${capacidadeBateria.toStringAsFixed(2)} Ah',
                      ),
                      _buildResultText(
                        label: 'Fonte Recomendada:',
                        value: '$fonteRecomendada A',
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

  Widget _buildTextField({
    required String label,
    required Function(String) onChanged,
  }) {
    return TextField(
      keyboardType: TextInputType.number,
      style: TextStyle(color: Colors.white),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(color: Colors.white),
        contentPadding: EdgeInsets.symmetric(
            vertical: 16.0, horizontal: 12.0), // Padding maior
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.white),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.yellowAccent),
        ),
      ),
      onChanged: onChanged,
    );
  }

  Widget _buildResultText({required String label, required String value}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Text('$label $value', style: TextStyle(color: Colors.white)),
    );
  }
}
