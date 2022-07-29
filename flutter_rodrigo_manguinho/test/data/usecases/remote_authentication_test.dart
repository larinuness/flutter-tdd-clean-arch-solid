import 'package:faker/faker.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class RemoteAuthentication {
  final HttpClient httpClient;
  final String url;
  RemoteAuthentication({
    required this.httpClient,
    required this.url,
  });

  Future<void> auth() async {
    await httpClient.request(url: url, method: 'post');
  }
}

abstract class HttpClient {
  request({
    required String url,
    required String method,
  }) async {}
}

class MockHttpClient extends Mock implements HttpClient {}

void main() {
  late String url;
  late RemoteAuthentication remoteAuthentication;
  late MockHttpClient httpClient;

  setUp(() {
    httpClient = MockHttpClient();
    url = faker.internet.httpUrl();
    remoteAuthentication =
        RemoteAuthentication(httpClient: httpClient, url: url);
  });

  test('Should call HttpClient with correct URL', () async {
    //Arrange

    //Act
    await remoteAuthentication.auth();
    //Assert
    verify(() => httpClient.request(url: url, method: 'post'));
  });
}
