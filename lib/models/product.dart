class Product {
  final List<String> barcode;
  final String description;
  final String description_ES;
  final List<String> materials;
  final String name;
  final String name_ES;
  final String picture;
  final List<String> properties;


  Product(this.barcode, this.description, this.description_ES, this.materials,
      this.name, this.name_ES, this.picture, this.properties);

  Map<String, dynamic> toJson() => {
    'barcode':barcode,
    'description':description,
    'description_ES':description_ES,
    'materials':materials,
    'name':name,
    'name_ES':name_ES,
    'picture':picture,
    'properties':properties

  };
}
