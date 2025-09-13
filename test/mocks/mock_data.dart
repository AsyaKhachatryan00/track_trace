import 'package:track_trace/models/animal.dart';

/// Mock data for testing
class MockData {
  static List<Animal> get mockAnimals => [
    Animal(
      image: 'assets/img/tiger.png',
      name: 'Tiger',
      category: Category.mammal,
      footType: FootType.paws,
    ),
    Animal(
      image: 'assets/img/elephant.png',
      name: 'Elephant',
      category: Category.mammal,
      footType: FootType.hooves,
    ),
    Animal(
      image: 'assets/img/duck.png',
      name: 'Duck',
      category: Category.bird,
      footType: FootType.webbed,
    ),
    Animal(
      image: 'assets/img/crocodile.png',
      name: 'Crocodile',
      category: Category.reptile,
      footType: FootType.paws,
    ),
  ];

  static List<String> get mockAnimalNames => [
    'Tiger',
    'Elephant',
    'Duck',
    'Crocodile',
    'Lion',
    'Bear',
    'Wolf',
    'Fox',
  ];

  static List<String> get mockAssetPaths => [
    'assets/img/tiger.png',
    'assets/img/elephant.png',
    'assets/img/duck.png',
    'assets/img/crocodile.png',
  ];
}
