import 'package:flutter/material.dart';

class CalculadoraInversor extends StatefulWidget {
  @override
  _CalculadoraInversorState createState() => _CalculadoraInversorState();
}

class _CalculadoraInversorState extends State<CalculadoraInversor> {
  List<Aparelho> aparelhos = [];
  int capacidadeBateria = 0;
  double potenciaTotalAparelhos = 0;
  double consumoTotalDiario = 0;
  double autonomiaBateria = 0;
  int potenciaInversorRecomendada = 0;

  void adicionarAparelho() {
    setState(() {
      aparelhos.add(Aparelho());
    });
  }

  void calcular() {
    potenciaTotalAparelhos = 0;
    consumoTotalDiario = 0;

    for (var aparelho in aparelhos) {
      consumoTotalDiario += aparelho.potencia * aparelho.tempoUso;
      potenciaTotalAparelhos += aparelho.potencia;
    }

    if (potenciaTotalAparelhos > 0) {
      autonomiaBateria = (capacidadeBateria * 12) / potenciaTotalAparelhos;
    } else {
      autonomiaBateria = 0;
    }

    potenciaInversorRecomendada = (potenciaTotalAparelhos * 1.25).ceil();

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.amber,
      appBar: AppBar(
        title: Text('Calculadora de Inversor'),
        backgroundColor: Colors.black,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Card(
              color: Colors.black,
              elevation: 5,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    _buildTextField(
                      label: 'Capacidade da bateria (Ah)',
                      onChanged: (value) {
                        setState(() {
                          capacidadeBateria = int.tryParse(value) ?? 0;
                        });
                      },
                    ),
                    SizedBox(height: 10),
                    Text(
                      'Aparelhos:',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 10),
                    Column(
                      children: aparelhos
                          .map((aparelho) => AparelhoWidget(aparelho: aparelho))
                          .toList(),
                    ),
                    SizedBox(height: 10),
                    ElevatedButton.icon(
                      onPressed: adicionarAparelho,
                      icon: Icon(Icons.add),
                      label: Text('Adicionar Aparelho'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        foregroundColor: Colors.black,
                      ),
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
            if (potenciaInversorRecomendada > 0)
              Card(
                color: Colors.black,
                elevation: 5,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
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
                        label: 'Potência Total dos Aparelhos:',
                        value: '${potenciaTotalAparelhos.toStringAsFixed(2)} W',
                      ),
                      _buildResultText(
                        label: 'Consumo Total Diário:',
                        value: '${consumoTotalDiario.toStringAsFixed(2)} Wh',
                      ),
                      _buildResultText(
                        label: 'Autonomia da Bateria:',
                        value: '${autonomiaBateria.toStringAsFixed(2)} horas',
                      ),
                      _buildResultText(
                        label: 'Potência do Inversor Recomendada:',
                        value: '$potenciaInversorRecomendada W',
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
        floatingLabelBehavior:
            FloatingLabelBehavior.auto, // Garante que o label flutue
        contentPadding: EdgeInsets.symmetric(
            vertical: 16.0, horizontal: 12.0), // Padding maior
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.white),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.yellowAccent),
        ),
        border: OutlineInputBorder(), // Adiciona uma borda padrão
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

class Aparelho {
  String nome = '';
  double potencia = 0;
  double tempoUso = 0;
  bool usoContinuo = false;
}

class AparelhoWidget extends StatefulWidget {
  final Aparelho aparelho;

  const AparelhoWidget({Key? key, required this.aparelho}) : super(key: key);

  @override
  _AparelhoWidgetState createState() => _AparelhoWidgetState();
}

class _AparelhoWidgetState extends State<AparelhoWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildTextField(
          label: 'Nome do Aparelho',
          onChanged: (value) {
            widget.aparelho.nome = value;
          },
        ),
        SizedBox(height: 10), // Espaço entre os campos
        _buildTextField(
          label: 'Potência (W)',
          onChanged: (value) {
            widget.aparelho.potencia = double.tryParse(value) ?? 0;
          },
        ),
        SizedBox(height: 10), // Espaço entre os campos
        _buildTextField(
          label: 'Tempo de Uso (horas)',
          onChanged: (value) {
            widget.aparelho.tempoUso = double.tryParse(value) ?? 0;
          },
        ),
        SizedBox(height: 10), // Espaço entre os campos
        Row(
          children: [
            Text('Uso Contínuo', style: TextStyle(color: Colors.white)),
            Checkbox(
              value: widget.aparelho.usoContinuo,
              onChanged: (value) {
                setState(() {
                  widget.aparelho.usoContinuo = value!;
                });
              },
            ),
          ],
        ),
        SizedBox(height: 10), // Espaço entre os campos
      ],
    );
  }

  Widget _buildTextField(
      {required String label, required Function(String) onChanged}) {
    return TextField(
      keyboardType: TextInputType.number,
      style: TextStyle(color: Colors.white),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(color: Colors.white),
        floatingLabelBehavior:
            FloatingLabelBehavior.auto, // Garante que o label flutue
        contentPadding: EdgeInsets.symmetric(
            vertical: 16.0, horizontal: 12.0), // Padding maior
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.white),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.yellowAccent),
        ),
        border: OutlineInputBorder(), // Adiciona uma borda padrão
      ),
      onChanged: onChanged,
    );
  }
}
