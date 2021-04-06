import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:ezparking/Controller/Validation.dart' as validation;
import 'package:ezparking/Controller/Auth.dart' as auth;
import 'package:firebase_auth_platform_interface/firebase_auth_platform_interface.dart';

import 'mock.dart';

import 'package:mockito/mockito.dart';


///Method: White-box testing
///
/// main() runs the test
///
///

class MockFirebaseAuth extends Mock implements FirebaseAuth{}
class MockFirebaseCore extends Mock implements FirebaseApp{}
class MockFirebaseUserCred extends Mock implements UserCredential{}
class MockAuth extends Mock implements auth.Auth{}
class MockUser extends Mock implements User{}
class MockFirebase extends Mock implements Firebase{}




void main() async {
  TestWidgetsFlutterBinding.ensureInitialized();
  setupFirebaseAuthMocks();

  MockFirebase firebase = MockFirebase();
  MockFirebaseAuth _auth = MockFirebaseAuth();
  //final MockAuthBase authBase;


  const String kMockEmail = 'test@example.com';
  const String kMockPassword = 'testPW';

  MockFirebaseAuth firebaseAuthMock = MockFirebaseAuth();

  /*setUp(()async{
    FirebaseAuthPlatform.instance = firebaseAuthMock = MockFirebase();
    final app = await Firebase.initializeApp(
      name: 'Test Firebase',
      options: const FirebaseOptions(
        apiKey: '',
        appId: '',
        messagingSenderId: '',
        projectId: '',
      ),
    );
    authA = firebase.FirebaseAuth.instanceFor(app:app);
    when(firebaseAuthMock.createUserWithEmailAndPassword(any, any))
        .thenAnswer((_) async => firebaseAuthMock);
  }); */

  /*group('createUserWithEmailAndPassword()', () {
    test('should call delegate method', () async {

      await authA.createUserWithEmailAndPassword(
        email: kMockEmail,
        password: kMockPassword,
      );

      verify(firebaseAuthMock.createUserWithEmailAndPassword(
        kMockEmail,
        kMockPassword,
      ));
    });
  });*/


  

  final _fireB = MockFirebase();

  final mockAuth = MockAuth();


  //await Firebase.initializeApp();
  final valid = validation.Validation();


  test('Sign Up',() {
    expect(valid.validateUserName('abc'),'username < 4 digits');
    expect(valid.validateUserName(''),'username can not be empty');
    expect(valid.validateUserName('abc@gmail.com'),null);

    expect(valid.validatePassWord('abc'),'password < 4 digits');
    expect(valid.validatePassWord(''),'password can not be none');
    expect(valid.validatePassWord('abcdd'),null);

  });

  test('Sign In',() async {
    MockFirebaseUserCred userCred;
    userCred = await firebaseAuthMock.createUserWithEmailAndPassword(email: 'abc@gmail.com', password: 'password');
    print(userCred);

    when(firebaseAuthMock.createUserWithEmailAndPassword(email: 'abc@gmail.com', password: 'password')).thenAnswer((_) => Future<MockFirebaseUserCred>.value(userCred));
    print(userCred.user);
    expect(await firebaseAuthMock.createUserWithEmailAndPassword(email: 'abc@gmail.com', password: 'password'),MockFirebaseUserCred);


    await mockAuth.signInWithEmailAndPassword('abc@gmail.com', 'password');
    verify(mockAuth.signInWithEmailAndPassword('abc@gmail.com', 'password'));
    expect(mockAuth.signInWithEmailAndPassword('', 'password'), null);

  });

}
