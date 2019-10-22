import 'package:http/http.dart';
import 'package:http/io_client.dart';

class DriveHttpClient extends IOClient {
  DriveHttpClient(this.headers);

  final Map<String, dynamic> headers;

  @override
  Future<StreamedResponse> send(BaseRequest request) =>
      super.send(request..headers.addAll(headers as Map<String, String>));
}
