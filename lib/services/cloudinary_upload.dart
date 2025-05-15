import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

Future<String?> uploadImageToCloudinary(File imageFile) async {
  const cloudName = 'dgipszkn7';       
  const uploadPreset = 'unsigned_preset';

  final url = Uri.parse('https://api.cloudinary.com/v1_1/$cloudName/image/upload');

  final request = http.MultipartRequest('POST', url)
    ..fields['upload_preset'] = uploadPreset
    ..files.add(await http.MultipartFile.fromPath('file', imageFile.path));

  final response = await request.send();

  if (response.statusCode == 200) {
    final res = await response.stream.bytesToString();
    final data = json.decode(res);
    return data['secure_url'];
  } else {
    print(' Upload failed: ${response.statusCode}');
    return null;
  }
}
