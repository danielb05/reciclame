class MaterialService {
  static final MaterialService instance = MaterialService._internal();

  MaterialService._internal();

  factory MaterialService() => instance;

  getByReference(documentRef) async {
    var snapshot = await documentRef.get();
    return snapshot.data();
  }
}
