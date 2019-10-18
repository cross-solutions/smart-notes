import 'package:http/http.dart';
import 'package:http/io_client.dart';

class DriveHttpClient extends IOClient {
  @override
  Future<StreamedResponse> send(BaseRequest request) => super.send(request..headers.addAll(null));
}
