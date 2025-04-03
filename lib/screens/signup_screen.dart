import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'dart:async';
import 'dart:convert';
import 'message_screen.dart';
import 'signin_screen.dart';

class CreateAccountScreen extends StatefulWidget {
  const CreateAccountScreen({super.key});

  @override
  _CreateAccountScreenState createState() => _CreateAccountScreenState();
}

class _CreateAccountScreenState extends State<CreateAccountScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController otpController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final GlobalKey<FormState> _otpFormKey = GlobalKey<FormState>();
  Uint8List? _webImage;
  final List<TextEditingController> _otpControllers =
      List.generate(6, (index) => TextEditingController());
  final List<FocusNode> _otpFocusNodes =
      List.generate(6, (index) => FocusNode());

  bool _showResendButton = false;
  int _secondsRemaining = 30;
  Timer? _timer;
  String? _imageFileName;
  bool _isEmailValid = false;
  bool _isPasswordValid = false;
  bool _isPasswordHidden = true;
  String email = "";
  String phoneNumber = "";
  bool isEmailSelected = true; // Toggle between email & phone
  String emailOrPhone = ""; // Stores either email or phone
  bool isEmail = true;
  Future<void> _sendCode() async {
    emailOrPhone = emailController.text.trim();
    isEmail = RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(emailOrPhone);

    try {
      final response = await http.post(
        Uri.parse("https://your-api.com/send-otp"),
        body: jsonEncode({isEmail ? "email" : "phone": emailOrPhone}),
        headers: {"Content-Type": "application/json"},
      );

      if (response.statusCode == 200) {
        print("OTP Sent Successfully");
        _showOTPDialog(isEmail, emailOrPhone);
      } else {
        print("Failed to send OTP");
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Failed to send OTP. Please try again.")),
        );
      }
    } catch (e) {
      print("Error sending OTP: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("An error occurred. Please try again.")),
      );
    }
  }

  void startTimer() {
    _secondsRemaining = 30;
    _showResendButton = false;

    _timer?.cancel(); // Cancel any previous timer
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (_secondsRemaining > 0) {
        setState(() {
          _secondsRemaining--;
        });
      } else {
        setState(() {
          _showResendButton = true;
          timer.cancel(); // Stop the timer when it reaches 0
        });
      }
    });
  }

// Ensure timer is disposed when leaving the screen
  @override
  void dispose() {
    for (var controller in _otpControllers) {
      controller.dispose();
    }
    for (var focusNode in _otpFocusNodes) {
      focusNode.dispose();
    }
    _timer?.cancel();
    super.dispose();
    _timer?.cancel();
    super.dispose();
  }

  void _showOTPDialog(bool isEmail, String recipient) {
    startTimer(); // Start the resend OTP countdown

    showDialog(
      context: context,
      barrierDismissible: false, // Prevent accidental dismiss
      builder: (context) {
        return AlertDialog(
          content: StatefulBuilder(
            builder: (context, setDialogState) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Icon (Email/SMS)
                  Image.asset(
                    isEmail
                        ? 'assets/images/email-icon.png'
                        : 'assets/images/sms-icon.png',
                    width: 60,
                    height: 60,
                  ),
                  SizedBox(height: 10),

                  // Title
                  Text(
                    "OTP Verification",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 10),

                  // Info Text
                  Text(
                    "An OTP has been sent via ${isEmail ? 'Email' : 'SMS'} to",
                    textAlign: TextAlign.center,
                  ),
                  Text(
                    recipient,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 10),

                  // OTP Input Fields
                  Form(
                    key: _otpFormKey,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(
                        6,
                        (index) => Container(
                          width: 40,
                          height: 50,
                          margin: EdgeInsets.symmetric(horizontal: 5),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey),
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: TextFormField(
                            controller: _otpControllers[index],
                            focusNode: _otpFocusNodes[index],
                            textAlign: TextAlign.center,
                            keyboardType: TextInputType.number,
                            maxLength: 1,
                            decoration: InputDecoration(
                              counterText: "",
                              border: InputBorder.none,
                            ),
                            onChanged: (value) {
                              if (value.isNotEmpty && index < 5) {
                                FocusScope.of(context)
                                    .requestFocus(_otpFocusNodes[index + 1]);
                              } else if (value.isEmpty && index > 0) {
                                FocusScope.of(context)
                                    .requestFocus(_otpFocusNodes[index - 1]);
                              }
                            },
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return '';
                              }
                              return null;
                            },
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 10),

                  // Resend OTP
                  Text(
                    _showResendButton
                        ? "Click to Resend OTP"
                        : "Resend OTP in 00:${_secondsRemaining.toString().padLeft(2, '0')}",
                    style: TextStyle(color: Colors.grey),
                  ),

                  if (_showResendButton)
                    TextButton(
                      onPressed: () {
                        setDialogState(() {
                          _secondsRemaining = 30;
                          _showResendButton = false;
                        });
                        _sendCode(); // Resend OTP API call
                      },
                      child: Text("Resend OTP"),
                    ),
                  SizedBox(height: 15),

                  // Verify OTP Button
                  ElevatedButton(
                    onPressed: () {
                      if (_otpFormKey.currentState!.validate()) {
                        Navigator.pop(context);
                        _verifyOTP(); // Verify OTP API call
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.brown,
                      padding:
                          EdgeInsets.symmetric(horizontal: 80, vertical: 15),
                    ),
                    child: Text("Verify OTP",
                        style: TextStyle(color: Colors.white)),
                  ),
                ],
              );
            },
          ),
        );
      },
    );
  }

  Future<void> _verifyOTP() async {
    String otpCode =
        _otpControllers.map((c) => c.text).join(); // Combine all OTP fields

    final response = await http.post(
      Uri.parse("https://your-api.com/verify-otp"),
      body: jsonEncode({"phone": phoneNumber}),
      headers: {"Content-Type": "application/json"},
    );

    if (response.statusCode == 200) {
      print("OTP Verified Successfully");
      // Navigate to next screen
    } else {
      print("Invalid OTP");
    }
  }

  Future<void> _pickImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? pickedFile =
        await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      if (kIsWeb) {
        final bytes = await pickedFile.readAsBytes();
        setState(() {
          _webImage = bytes;
          _imageFileName = pickedFile.name;
        });
      }
    }
  }

  void _removeImage() {
    setState(() {
      _webImage = null;
      _imageFileName = null;
    });
  }

  Future<void> _signUp() async {
    if (!_formKey.currentState!.validate()) return;

    final url = Uri.parse('http://localhost:5000/api/auth/signup');
    var request = http.MultipartRequest("POST", url);

    request.fields["email"] = emailController.text;
    request.fields["otp"] = otpController.text;
    request.fields["password"] = passwordController.text;

    if (_webImage != null) {
      request.files.add(
        http.MultipartFile.fromBytes(
          'trade_license',
          _webImage!,
          filename: _imageFileName ?? 'trade_license.jpg',
          contentType: MediaType('image', 'jpeg'),
        ),
      );
    }

    try {
      var streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);

      if (response.statusCode == 200) {
        print("Signup successful: \${response.body}");

        // Navigate to the Message Screen after successful signup
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => MessageScreen()),
        );
      } else {
        print("Signup failed: \${response.body}");
        // Show error message (optional)
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Signup failed. Please try again.")),
        );
      }
    } catch (e) {
      print("Error: \$e");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("An error occurred. Please try again.")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 60),
                Center(
                  child: Text("Create  Account",
                      style:
                          TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                ),
                SizedBox(height: 10),
                Center(
                  child: Text("Fill in your information below",
                      style: TextStyle(fontSize: 16, color: Colors.grey)),
                ),
                SizedBox(height: 20),
                Text("Email/Phone Number:"),
                SizedBox(height: 5),
                TextFormField(
                  controller: emailController,
                  onChanged: (value) {
                    setState(() {
                      _isEmailValid = value.isNotEmpty;
                    });
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your email or phone number';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    hintText: "Enter your email/phone",
                    filled: true,
                    fillColor: Colors.brown[100],
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide.none,
                    ),
                    suffixIcon: Container(
                      margin: EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        color: Colors.brown,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Icon(Icons.email, color: Colors.white),
                    ),
                  ),
                ),

                SizedBox(height: 15),

                // Password Field
                Text("Password:"),
                SizedBox(height: 5),
                TextFormField(
                  controller: passwordController,
                  obscureText: _isPasswordHidden, // Hide/show password
                  onChanged: (value) {
                    setState(() {
                      _isPasswordValid = value.isNotEmpty;
                    });
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your password';
                    } else if (value.length < 6) {
                      return 'Password must be at least 6 characters long';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    hintText: "Enter your password",
                    filled: true,
                    fillColor: Colors.brown[100],
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide.none,
                    ),
                    suffixIcon: GestureDetector(
                      onTap: () {
                        setState(() {
                          _isPasswordHidden = !_isPasswordHidden;
                        });
                      },
                      child: Container(
                        margin: EdgeInsets.all(5),
                        decoration: BoxDecoration(
                          color: Colors.brown,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Icon(
                          _isPasswordHidden
                              ? Icons.visibility_off
                              : Icons.visibility,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 15),
                Text("Trade License:",
                    style:
                        TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                SizedBox(height: 10),
                GestureDetector(
                  onTap: _pickImage,
                  child: Container(
                    height: 150,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: _webImage != null
                        ? Stack(
                            children: [
                              Center(
                                  child: Text(_imageFileName ?? "Upload Image",
                                      textAlign: TextAlign.center)),
                              Positioned(
                                top: 10,
                                right: 10,
                                child: GestureDetector(
                                  onTap: _removeImage,
                                  child: Icon(Icons.cancel, color: Colors.red),
                                ),
                              ),
                            ],
                          )
                        : Center(
                            child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset('assets/images/upload-icon.png',
                                  width: 50, height: 50),
                              SizedBox(height: 5),
                              Text("Upload Image"),
                            ],
                          )),
                  ),
                ),
                SizedBox(height: 20),
                Center(
                  child: ElevatedButton(
                    onPressed: _sendCode,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.brown,
                      padding:
                          EdgeInsets.symmetric(horizontal: 80, vertical: 15),
                    ),
                    child:
                        Text("Sign Up", style: TextStyle(color: Colors.white)),
                  ),
                ),
                SizedBox(height: 10),
                Center(
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => SignInScreen()),
                      );
                    },
                    child: Text(
                      "Already have an account? Sign in",
                      style: TextStyle(
                          color: Colors.brown, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
