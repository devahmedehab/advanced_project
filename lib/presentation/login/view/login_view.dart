import 'package:app1/app/d_i.dart';
import 'package:app1/presentation/login/viewmodel/login_view_model.dart';
import 'package:app1/presentation/resources/assets_manager.dart';
import 'package:app1/presentation/resources/color_manager.dart';
import 'package:app1/presentation/resources/component.dart';
import 'package:app1/presentation/resources/font_manager.dart';
import 'package:app1/presentation/resources/routs_manager.dart';
import 'package:app1/presentation/resources/strings_manager.dart';
import 'package:app1/presentation/resources/values_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class LoginView extends StatefulWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final LoginViewModel _viewModel = instance<LoginViewModel>();
  final TextEditingController _userNameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool passwordVisible=true;
  bool isClickable=true;

  Color ?suffixColor ;
  Color ? prefixColor ;


  _bind() {
    _viewModel.start(); //tell viewModel start job
    _userNameController
        .addListener(() => _viewModel.setUserName(_userNameController.text));
    _passwordController
        .addListener(() => _viewModel.setPassword(_passwordController.text));
  }

  @override
  void initState() {
    _bind();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return _getContentWidget();
  }

  Widget _getContentWidget() {
    return Scaffold(
      backgroundColor: ColorManager.white,
      body: Container(
        padding:  EdgeInsets.only(top: mediaQueryHeight(context)*0.15),
        color: ColorManager.white,
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                const Center(
                    child: Image(
                      image: AssetImage(ImageAssets.splashLogo),
                    )),
                SizedBox(
                  height: mediaQueryHeight(context)*.04,
                ),
                Padding(

                  padding:  EdgeInsets.only(
                    left: mediaQueryHeight(context)*0.03,
                    right: mediaQueryHeight(context)*0.03,
                  ),
                  child: StreamBuilder<bool>(
                    stream: _viewModel.outIsUserNameValid,
                    builder: (context, snapshot) {
                      return TextFormField(
                          cursorColor: ColorManager.primary,
                          autofillHints: const [AutofillHints.email],
                          controller: _userNameController,
                          keyboardType: TextInputType.emailAddress,
                          decoration: InputDecoration(
                            prefixIcon:   const Icon(Icons.email_outlined,),
                            hintText: AppStrings.username,
                            labelText: AppStrings.username,
                            errorText: (snapshot.data ?? true)
                                ? null
                                : AppStrings.usernameError,

                          )
                      );
                    },
                  ),
                ),
                SizedBox(
                  height: mediaQueryHeight(context)*.04,
                ),
                Padding(

                  padding: EdgeInsets.only(
                    left: mediaQueryHeight(context)*0.03,
                    right: mediaQueryHeight(context)*0.03,
                  ),
                  child: StreamBuilder<bool>(
                    stream: _viewModel.outIsPasswordValid,
                    builder: (context, snapshot) {
                      return TextFormField(
                          cursorColor: ColorManager.primary,
                          obscureText: passwordVisible,
                          controller: _passwordController,
                          keyboardType: TextInputType.visiblePassword,
                          decoration: InputDecoration(
                            prefixIcon:  const Icon(Icons.key_outlined,),
                            suffixIcon:IconButton(
                              color: ColorManager.lightGrey,
                              icon:  Icon(suffix, color: suffixColor,),

                              onPressed: (){
                                setState(() {
                                  suffixColor= passwordVisible ?
                                  ColorManager.primary
                                      :  ColorManager.lightGrey ;
                                  passwordVisible = !passwordVisible;
                                  suffix = passwordVisible ?
                                  Icons.visibility_outlined
                                      : Icons.visibility_off_outlined;
                                });
                              },
                            ) ,
                            hintText: AppStrings.password,
                            labelText: AppStrings.password,
                            errorText: (snapshot.data ?? true)
                                ? null
                                : AppStrings.passwordError,

                          )
                      );
                    },
                  )),
                 SizedBox(
                  height: mediaQueryHeight(context)*.04,
                ),
                Padding(
                  padding: EdgeInsets.only(
                    left: mediaQueryHeight(context)*0.03,
                    right: mediaQueryHeight(context)*0.03,
                  ),
                  child: StreamBuilder<bool>(
                    stream: _viewModel.outAreAllInputsValid,
                    builder: (context, snapshot) {
                      return SizedBox(
                        height: mediaQueryHeight(context)*0.06,
                        width: mediaQueryWidth(context)*0.9,
                        child: MaterialButton(

                          disabledColor: ColorManager.disabledButton,

                          color:ColorManager.primary ,
                          onPressed: (snapshot.data ?? false)
                              ? () {
                            _viewModel.login();
                          }
                              : null,
                          child: const Text(AppStrings.login)),


                      );
                    },
                  ),
                ),
                SizedBox(
                  height: mediaQueryHeight(context)*.01,
                ),
                Padding(
                  padding: EdgeInsets.only(
                    left: mediaQueryHeight(context)*0.03,
                    right: mediaQueryHeight(context)*0.03,
                  ),
                  child: StreamBuilder<bool>(
                    stream: _viewModel.outAreAllInputsValid,
                    builder: (context, snapshot) {
                      return Row(
                        children: [
                          TextButton(
                              onPressed:(){
                                Navigator.pushNamed(
                                    context, Routes.forgetPasswordRoute);
                              } ,
                              child: const Text(AppStrings.forgetPassword,
                                style: TextStyle(

                                    fontSize: FontSize.s14
                                ),
                              )
                          ),
                          const Spacer(),
                           Text(
                             AppStrings.doNotHaveAccount,
                          style: TextStyle(
                            color: ColorManager.grey,
                            fontSize: FontSize.s12
                          ),
                          ),
                          TextButton(
                              onPressed:(){
                                Navigator.pushNamed(
                                    context, Routes.registerRoute);
                              } ,
                              child: const Text(AppStrings.signUp,
                                style: TextStyle(

                                    fontSize: FontSize.s14
                                ),
                              )
                          ),

                        ],
                      );
                    },
                  ),
                ),



              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _viewModel.dispose();
    super.dispose();
  }


}
