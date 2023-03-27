import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Animaciones en Flutter'),
        ),
        body: const Center(
          child: AnimacionesDemo(),
        ),
      ),
    );
  }
}

class AnimacionesDemo extends StatefulWidget {
  /*
    esta línea de código define un constructor constante para la clase AnimacionesDemo,
     que acepta un parámetro opcional key y pasa ese parámetro al constructor de su
     superclase. Esto es común en los widgets personalizados de Flutter
     y permite el uso de claves en la creación de instancias de estos widgets.
     Las claves en Flutter se utilizan para controlar la identidad de los widgets
     y ayudar en el proceso de reconstrucción y actualización del árbol de widgets.
  */
  const AnimacionesDemo({Key? key}) : super(key: key);

  @override
  _AnimacionesDemoState createState() => _AnimacionesDemoState();
}

/*
Un TickerProvider es una interfaz utilizada para crear instancias de objetos Ticker.
 Algunos widgets, como AnimationController, requieren un TickerProvider
 para funcionar correctamente.

TickerProviderStateMixin es un mixin que implementa la interfaz TickerProvider
y proporciona una implementación básica para crear instancias de objetos Ticker.
Esta clase mixin se utiliza comúnmente en los State objetos de los StatefulWidget
que requieren animaciones.
 */
class _AnimacionesDemoState extends State<AnimacionesDemo> with TickerProviderStateMixin {
  /*
  late es una palabra clave en Dart que se utiliza para indicar que una variable
  de instancia no se inicializará en su declaración, sino que se asignará
  más adelante antes de que se utilice. Es útil cuando no puedes
  proporcionar un valor inicial para una variable durante su declaración
  o en el constructor, pero aún quieres garantizar que la variable se inicializará
  antes de su primer uso.
  */
  late final AnimationController _scaleController;
  late final AnimationController _rotationController;
  late final AnimationController _opacityController;
  late final AnimationController _slideController;

  late final Animation<double> _scaleAnimation;
  late final Animation<double> _rotationAnimation;
  late final Animation<double> _opacityAnimation;
  late final Animation<Offset> _slideAnimation;

  /* recordad que las variables final no pueden cambiar de valor una vez
  que se les ha declarado
   */

  @override
  void initState() {
    /*
    super.initState(); es una llamada al método initState() de la clase base
    (superclase) en Flutter. Esta línea de código se utiliza típicamente en el
     método initState() de un objeto State cuando se extiende un StatefulWidget.

   Cuando se crea un StatefulWidget en Flutter,
   el framework crea un objeto State correspondiente.
   El método initState() se llama automáticamente una vez cuando se crea
   ese objeto State, antes de que se construya el widget.
   Este método es el lugar ideal para realizar inicializaciones
   específicas del estado, como cargar datos, iniciar animaciones
    o suscribirse a eventos.

    Sin embargo, cuando se sobrescribe el método initState() en una subclase de State,
    es crucial llamar al método initState() de la superclase utilizando super.initState();
   para garantizar que el objeto State se inicialice correctamente
   según las implementaciones de la superclase. La llamada a super.initState();
   debe ser la primera línea en el método initState() sobrescrito.
     */
    super.initState();

    _scaleController = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );
    _rotationController = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );
    _opacityController = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );
    _slideController = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );

    _scaleAnimation = Tween<double>(begin: 1, end: 2).animate(_scaleController);
    _rotationAnimation = Tween<double>(begin: 0, end: 2 * 3.1415926535).animate(_rotationController);
    _opacityAnimation = Tween<double>(begin: 1, end: 0).animate(_opacityController);
    _slideAnimation = Tween<Offset>(begin: Offset.zero, end: const Offset(2, 0)).animate(_slideController);

    _scaleController.repeat(reverse: true);
    _rotationController.repeat(reverse: true);
    _opacityController.repeat(reverse: true);
    _slideController.repeat(reverse: true);
  }

  @override
  void dispose() {
    _scaleController.dispose();
    _rotationController.dispose();
    _opacityController.dispose();
    _slideController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        ScaleTransition(
          scale: _scaleAnimation,
          child: const FlutterLogo(size: 50),
        ),
        RotationTransition(
          turns: _rotationAnimation,
          child: const FlutterLogo(size: 50),
        ),
        FadeTransition(
          opacity: _opacityAnimation,
          child: const FlutterLogo(size: 50),
        ),
        SlideTransition(
          position: _slideAnimation,
          child: const FlutterLogo(size: 50),
        ),
      ],
    );
  }
}