import 'package:faker/faker.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:flutter_rodrigo_manguinho/domain/usecases/authentication.dart';

class RemoteAuthentication {
  final HttpClient httpClient;
  final String url;
  RemoteAuthentication({
    required this.httpClient,
    required this.url,
  });

  Future<void> auth(AuthenticationParams params) async {
    final body = {
      'email': params.email,
      'password': params.secret,
    };
    await httpClient.request(
      url: url,
      method: 'post',
      body: body,
    );
  }
}

abstract class HttpClient {
  request({required String url, required String method, Map? body}) async {}
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
    final params = AuthenticationParams(
        email: faker.internet.email(), secret: faker.internet.password());

    //Act
    await remoteAuthentication.auth(params);
    //Assert
    verify(
      () => httpClient.request(
        url: url,
        method: 'post',
        body: {
          'email': params.email,
          'password': params.secret,
        },
      ),
    );
  });
}
