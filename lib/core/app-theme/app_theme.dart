import 'package:flutter/material.dart';

class AppTheme {
  // General Text
  static const String welcomeText = 'Welcome to the Bible Trivia Game!';
  static const String knowledgeText = 'Test your knowledge about the Bible with this fun quiz!';
  static const String appBarTitleText = "Bible Trivia App";
  static const String startQuizText = "Start Quiz";
  static const String startGameText = "Start Game";
  static const String exitQuizText = "End Quiz";
  static const String exitText = "Exit";
  static const String cancelText = "Cancel";
  static const String confirmationExitQuiz = "Are you sure you want to exit the Quiz?";
  static const String quizMenuText = 'Quiz Menu';
  static const String homeText = "Home";
  static const String gameLevelsText = "Game Levels";
  static const String confirmSelectionText = "Confirm Selection";
  static const String nextQuestionText = "Next Question";
  static const String endQuizText = "End Quiz";
  static const String completedQuizText = "Quiz Completed!";
  static const String yourScoreText = "Your Score is";
  static const String noMoreQuestionsText = "No more questions available!";
  static const String retryText = "Would you like to try again?";
  static const String exitQuizTitle = "Exit Quiz";
  static const String exitQuizMessage =
      "Are you sure you want to exit the quiz? Your progress will not be saved.";
  static const String quizCompletedText = "Quiz Completed! Well done!";
  static const String userScoreText = "Your final score is:";

  // Login Page
  static const String loginTitle = 'Login';
  static const String emailLabel = 'Email';
  static const String passwordLabel = 'Password';
  static const String confirmPasswordLabel = "Confirm Password";
  static const String loginWithEmailButton = 'Login with Email';
  static const String orText = 'OR';
  static const String googleSignInButtonText = 'Sign in with Google';
  static const String facebookSignInButtonText = 'Sign in with Facebook';
  static const String signUpTitle = 'Sign Up';
  static const String dontHaveAccountText = "Don't have an account?";
  static const String noAccountText = "No account?";
  static const String createAccountText = "Create an account";
  static const String signUpButtonText = 'Sign Up';
  static const String alreadyHaveAccountText = "Already have an account?";
  static const String signInText = "Sign In";
  static const String loginText = "Login";
  static const String okButtonText = 'OK';
  static const String loadingText = 'Loading...';
  static const String forgotPasswordText = "Forgot Password?";
  static const String passwordMismatchMessage = "Passwords do not match. Please try again.";
  static const String loginFailedMessage = 'Login failed. Please try again.';
  static const String accountCreationSuccessMessage = 'Account created successfully.';
  static const String invalidEmailMessage = 'Please enter a valid email address.';
  static const String emptyFieldMessage = 'This field cannot be empty.';

  // Registration
  static const String nameLabel = 'Name';
  static const String usernameLabel = 'Username';
  static const String mobileNumberLabel = 'Mobile Number';
  static const String registerButtonText = 'Register';
  static const String allFieldsRequiredMessage = 'All fields are required';
  static const String registrationFailedMessage = 'Registration failed. Please try again.';
  static const String errorDialogTitle = 'Error';
  static const String passwordLengthMessage = "Password must be at least 6 characters long.";
  static const String signUpRedirectText = 'Don\'t have an account? Sign Up';
  static const String googleSignInFailedMessage = 'Google sign-in failed.';
  static const String facebookSignInFailedMessage = "Facebook sign-in failed. Please try again.";
  static const String userAlreadyExistsMessage = 'This email is already in use.';

  // Dialogs
  static const String successDialogTitle = "Success";
  static const String successDialogMessage = "Your request has been successfully processed.";
  static const String closeButtonText = "Close"; // For dialog close button text

  // Forgot Password Page
  static const String emptyEmailError = "Please enter your email address.";
  static const String passwordResetEmailSent = "Password reset email sent successfully.";
  static const String passwordResetEmailFailed = "Failed to send password reset email.";
  static const String forgotPasswordPageTitle = "Forgot Password";
  static const String forgotPasswordInstructions = "Enter your email to reset your password.";
  static const String sendResetLinkButtonText = "Send Reset Link";

  //Profile

  static const String profileText = "Profile";
  static const String logoutText = "Log Out";
  static const String logoutConfirmationTitle = "Log Out";
  static const String logoutConfirmationMessage = "Are you sure you want to log out?";

  // Quiz Results
  static const String quizCompletedMessage = 'Quiz Completed. Well done!';
  static const String scoreText = 'Score';
  static const String retryQuizText = 'Retry Quiz';
  static const String quizSummaryText = 'Here is a summary of your quiz results';
  static const String performanceFeedbackText = 'Your performance was outstanding!';

  // Colors
  static const Color primaryColor = Color(0xFF6200EA); // Deep Purple
  static const Color accentColor = Color(0xFFBB86FC); // Light Purple
  static const Color backgroundColor = Color(0xFF1C1C1E); // Darker Gray for better contrast
  static const Color buttonBackgroundColor = Color(0xFF6A1B9A); // Dark Purple for buttons
  static const Color buttonTextColor = Colors.white; // White text for buttons
  static const Color buttonBorderColor = Colors.purpleAccent; // Accent for button borders
  static const Color buttonGradientStart = Color(0xFF8E24AA); // Gradient start color
  static const Color buttonGradientEnd = Color(0xFFAB47BC); // Gradient end color
  static const Color drawerHeaderBackgroundColor =
      Color(0xFF4A148C); // Dark Purple for drawer header
  static const Color drawerBackgroundColor = Color(0xFF212121); // Dark Gray for drawer background
  static const Color iconColor = Colors.white; // White for icons
  static const Color optionCardColor =
      Color(0xFF424242); // Slightly lighter dark gray for option cards
  static const Color dialogTitleColor = Colors.white; // White for dialog titles
  static const Color dialogContentColor = Colors.white; // White for dialog content
  static const Color textColor = Colors.white; // White for general text
  static const Color errorColor = Colors.red;
  static const Color labelColor = Colors.black54;
  // Sizes
  static const double buttonPaddingVertical = 15.0;
  static const double buttonPaddingHorizontal = 30.0;
  static const double buttonBorderRadius = 10.0;
  static const double buttonElevation = 4;
  static const double buttonMinWidth = 75.0;
  static const double buttonMinHeight = 50.0;
  static const double imagePadding = 8.0;
  static const double imageSize = 40.0;
  static const double iconPadding = 8.0;
  static const double buttonTextSize = 18.0;

  // Spacing
  static const double spaceSizeExtremeSmall = 8.0;
  static const double spaceSizeSmall = 16.0;
  static const double spaceSizeMedium = 24.0;
  static const double spaceSizeLarge = 32.0;
  static const double spaceSizeExtremeLarge = 40.0;

  // Font Sizes
  static const double fontSizeSmall = 12.0;
  static const double fontSizeRegular = 16.0;
  static const double fontSizeNormal = 20.0;
  static const double fontSizeSubTitle = 24.0;
  static const double fontSizeTitle = 36.0;
  static const double fontSizeLargeTitle = 40.0;
  static const double fontSizeExtremeLargeTitle = 56.0;

  // Additional Theme Constants
  static const double drawerElevation = 4.0; // Elevation for drawer
  static const double headerCornerRadius = 20.0; // Corner radius for drawer header
  static const double headerSpacing = 10.0; // Spacing below header title
  static const double itemPaddingVertical = 10.0; // Vertical padding for drawer items
  static const double itemPaddingHorizontal = 20.0; // Horizontal padding for drawer items
  static const double itemBorderRadius = 10.0; // Border radius for drawer items
  static const double itemSpacing = 12.0; // Spacing between icon and text in drawer items
  static const double dialogActionSpacing =
      16.0; // Spacing between dialog content and action buttons
  static const double dialogContentSpacing = 12.0; // Spacing between title and content
  static const double dialogBorderRadius = 12.0; // Border radius for dialogs
  static const double dialogPadding = 20.0; // Padding inside the dialog container
  static const double listTilePadding = 16.0; // Padding for list tile
  static const double listTileBorderRadius = 8.0; // Border radius for list tile background
  static const double listTileIconSize = 24.0; // Size for the icon
  static const double defaultLetterSpacing = 0.5; // Default letter spacing
  static const double defaultWordSpacing = 0.5; // Default word spacing
  static const double defaultLineHeight = 1.5; // Default line height
}
