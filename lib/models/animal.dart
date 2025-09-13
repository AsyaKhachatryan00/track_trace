class Animal {
  final String image;
  final String name;
  final Category category;
  final FootType footType;
    bool isFavorite;

  Animal({
    required this.image,
    required this.name,
    required this.category,
    required this.footType,
    this.isFavorite = false,
  });

  static List<Animal> buildFromAssetPaths(List<String> assetPaths) {
    return assetPaths.map((path) {
      final String fileName = path.split('/').last;
      final String rawName = fileName.split('.').first;
      final String normalized = rawName.toLowerCase().replaceAll('_', ' ');
      final String displayName = normalized
          .split(' ')
          .map(
            (word) =>
                word.isEmpty ? word : word[0].toUpperCase() + word.substring(1),
          )
          .join(' ');

      final Category category = _inferCategory(normalized);
      final FootType footType = _inferFootType(normalized);

      return Animal(
        image: path,
        name: displayName,
        category: category,
        footType: footType,
      );
    }).toList();
  }

  static Category _inferCategory(String lowerName) {
    const Set<String> birds = {
      'duck',
      'dove',
      'goose',
      'hen',
      'ostrich',
      'turkey',
      'rooster',
    };
    if (birds.contains(lowerName)) return Category.bird;
    if (lowerName == 'crocodile') return Category.reptile;
    return Category.mammal;
  }

  static FootType _inferFootType(String lowerName) {
    const Set<String> webbed = {'duck', 'goose'};
    const Set<String> hooved = {
      'pig',
      'llama',
      'rhino',
      'sheep',
      'moose',
      'giraffe',
      'tapir',
      'okapi',
      'goat',
      'horse',
      'impala',
      'zebra',
      'duiker',
      'mink',
      'deer',
      'hippo',
      'cow',
    };

    if (webbed.contains(lowerName)) return FootType.webbed;
    if (hooved.contains(lowerName)) return FootType.hooves;
    return FootType.paws;
  }
}

enum Category { bird, mammal, reptile }

enum FootType { paws, hooves, webbed }
