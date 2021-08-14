import 'package:flutter/material.dart';

class SignIn extends StatefulWidget {
  const SignIn({ Key? key }) : super(key: key);

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {

  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: NetworkImage("https://img.rawpixel.com/s3fs-private/rawpixel_images/website_content/rm222-mind-20_1_1.jpg?w=1300&dpr=1&fit=default&crop=default&q=80&vib=3&con=3&usm=15&bg=F4F4F3&ixlib=js-2.2.1&s=4aaa54936fc9bff26222697d03307f18"),
            fit: BoxFit.cover
          )
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height / 1.4,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                )
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 40, horizontal: 32),
                    child: Text(
                      'Get Started',
                      style: TextStyle(
                        fontSize: 32,
                        color: Colors.purple,
                        fontWeight: FontWeight.bold
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 32),
                    child: TextField(
                      controller: name,
                      decoration: InputDecoration(
                        hintText: 'Name'
                      ),
                    ),
                  ),
                  SizedBox(height: 8,),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 32),
                    child: TextField(
                      controller: email,
                      decoration: InputDecoration(
                        hintText: 'Email'
                      ),
                    ),
                  ),
                  SizedBox(height: 8,),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 32),
                    child: TextField(
                      controller: password,
                      decoration: InputDecoration(
                        hintText: 'Password'
                      ),
                    ),
                  ),
                  SizedBox(height: 30,),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 32),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [                        
                        MaterialButton(
                          onPressed: () {
                            print('Sign up');
                            // signUp();
                          },
                          color: Colors.purple,
                          child: Text('Sign Up', style: TextStyle(color: Colors.white),),
                        ),
                        Container(
                          height: 80,
                          width: 80,
                          decoration: BoxDecoration(
                            color: Colors.purple,
                            borderRadius: BorderRadius.circular(100)
                          ),
                          child: Center(
                            child: Icon(Icons.arrow_forward_outlined, color: Colors.white,),
                          ),
                        )
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 32),
                    child: TextButton(
                      onPressed: () => print('Go to sign in'),
                      // onPressed: () => Navigator.pushReplacement(
                      //   context, MaterialPageRoute(
                      //     builder: (context) => SignInPage()
                      //   )
                      // ),
                      child: Text('Sign In'),              
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}