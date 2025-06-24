class Urls {
  static String baseUrls = 'http://35.73.30.144:2008/api/v1';
  static String createProduct = '$baseUrls/CreateProduct';
  static String readProduct = '$baseUrls/ReadProduct';
  static String updateProduct(String id) => '$baseUrls/UpdateProduct/$id';
  static String readProductById(String id) => '$baseUrls/ReadProductById/$id';
  static String deleteProduct(String id) => '$baseUrls/DeleteProduct/$id';
}