import 'package:faker/faker.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_rodrigo_manguinho/data/http/http.dart';
import 'package:flutter_rodrigo_manguinho/data/usecases/remote_authentication.dart';
import 'package:flutter_rodrigo_manguinho/domain/usecases/authentication.dart';
import 'package:mocktail/mocktail.dart';

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

  test(
    'Should call HttpClient with correct URL',
    () async {
      //Arrange
      final params = AuthenticationParams(
          email: faker.internet.email(), password: faker.internet.password());

      //Act
      await remoteAuthentication.auth(params);
      //Assert
      verify(
        () => httpClient.request(
          url: url,
          method: 'post',
          body: {
            'email': params.email,
            'password': params.password,
          },
        ),
      );
    },
  );
}
