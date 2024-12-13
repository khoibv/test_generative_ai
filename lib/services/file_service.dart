import 'package:file_picker/file_picker.dart';

class PickedImage {}

class FileService {
  Future<List<PlatformFile>> pickImage({
    filter = const ['jpg', 'jpeg', 'png'],
    bool withData = false,
  }) async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      withData: withData,
      type: FileType.custom,
      allowedExtensions: filter,
    );

    return result?.files ?? [];
  }
}
