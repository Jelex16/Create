import 'package:googleapis_auth/auth_io.dart';

class AccessTokenFirebase {
  static String firebaseMessagingScope =
      "https://www.googleapis.com/auth/firebase.messaging";
  static String firebaseCloudMessagingScope =
      "https://www.googleapis.com/auth/firebase.messaging";

  Future<String> getAccessToken() async {
    final client = await clientViaServiceAccount(
      ServiceAccountCredentials.fromJson({
        "type": "service_account",
        "project_id": "match-home-741c2",
        "private_key_id": "7bb6fcb65d9992b0a9c2da7837e941bbb661dee6",
        "private_key":
            "-----BEGIN PRIVATE KEY-----\nMIIEvgIBADANBgkqhkiG9w0BAQEFAASCBKgwggSkAgEAAoIBAQDjluBK2yzAXhKS\nwnA/enQhddgABQ2Ix03bGj/xCI2OKzlnyAbi7JTcjVpt0gCrpHX+JckIJa/fLgVd\n20ml9/rNxwR7mCkN4dPw1lUEx1ytJe06K80GvEVTrQNFyZtDcXeWuq8G1oP/rQV8\nchyx3w+A/990XPW0HEArISFG97EL6CdepPPMkwh7dOHqvNA8uzybOJpOueMSgDTz\nJr6XtJzojZ68rx5AgRcKvllGEKvqpQXQXMnFUEaZv2eGxDd5EW/NZycbOSbYNnE3\nHGf4QWN+Pw9UVhOQKL+cW48U4YGDPMEWGxvQY/Y5PnRpNHL+HqjgN8/z4yDOPS6G\nnImVeha5AgMBAAECggEAabcplFvem7SW2Ajtbu8IhopgvRGbyc8aQQ4eaW3ZoxI8\n5hIp8LqIIzKdsKl9mj0Yeec/TEOFQBv2bjRwL2HS5EbvtCFn4ITnl9VXRJL+X4dg\nfEbgQ6KsaUPSY1ZUgq1wKVmp93kpc1gBVl8DKTQ91WQFfd24W+NLgz0uYfKoEKjz\nchf/dm+yY1fi9ZQPgAX5zqc06R902Ealp5b3+EN0uTr5HWnDisXG2PoGmKrK1qUQ\nn6JrPP+uc9i+iUBun2vqpyoNYlc35OtwAKg5JIA/ZJ9/Fx1oNqzXc3D56KLXqTAk\nmhPd6zH3aVgKYPt0uWBy1u4ofi3e86QlNl5YvxM0CQKBgQDyLmo7HtU7AU/iRR0c\nN9a12z/NGLCvw73HkyfHMWejeullQy0TdXny8y47vA8Eg0Jmi6UCAhgUTOVrNDOU\nl0YxLvytBHXcJxhppueug7bWglhrHt5IU1M4Fc0kC6ApNtpoqnC/+bUifYbtf7iJ\n1jD9aV140bmUrqYn53K6EO+ARwKBgQDwk1BjSR8GjTb+BSEuvuWe+wf+Ime9U1an\nC34jOB7zGT85a8JzTQ9vlepvsYTlTVEaYG03BjfZEDFOVNPP1w8XXw2mIlzhM+gM\nz1vhZNq12LVZBfvttzMGQN9FmcG0OuTpe0CrQ+OIRdaLF2JU7J1+DvzswFLpihyG\n4MtUZEQw/wKBgFqklqwUCTjxb8W/mnqiR6F/Myz/bboLaC+XW08JpcGhUlPNRcS/\ntmoBLK+83l4RBrw8zgCnaf3HHiL2wct+pw3niTj0r2w70b5Rcut1buxwksldH1Mw\npLgcKNCx7TsfxbVg/ZxMyMfk9ahUomwsl99xHUQIMw58I8JRtTYA+rMnAoGBAOeC\nLBrPc/7fCCudDhio9dlu43so6sHjoACya5lC2W3BPvln/MDuSEtubiM8JpJvO/vx\nDUilQDsvfPNPaGGbKFeqTj0w1kaVp9oj9dxKLLpQJ/vaaVySLpT2+qVE2IYzIrSY\nulvVwfESm+pP/32QEeMMU1MVpPQ+x0L4slKtBn5LAoGBANvNwU9iiz5QzIolGLKQ\n4og0i24TJD4AvX3P/9WAIfBiZjzhYsJZp+yQnKKM/s//CxS2HKhQUtI678EuBAs7\nVOITMg+LpK0kS2BpT+rBH/lFbVwjAc2iitnq6rJngUnjZ7Y2+oV1ic6zAmwx9qvH\nfjYPhxZ99VRwGxWuowm25YSc\n-----END PRIVATE KEY-----\n",
        "client_email":
            "firebase-adminsdk-m8cuj@match-home-741c2.iam.gserviceaccount.com",
        "client_id": "112420675627551074495",
        "auth_uri": "https://accounts.google.com/o/oauth2/auth",
        "token_uri": "https://oauth2.googleapis.com/token",
        "auth_provider_x509_cert_url":
            "https://www.googleapis.com/oauth2/v1/certs",
        "client_x509_cert_url":
            "https://www.googleapis.com/robot/v1/metadata/x509/firebase-adminsdk-m8cuj%40match-home-741c2.iam.gserviceaccount.com",
        "universe_domain": "googleapis.com"
      }),
      [firebaseMessagingScope],
    );

    final accessToken = client.credentials.accessToken.data;

    return accessToken;
  }
}
