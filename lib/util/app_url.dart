class AppUrl {
  static const String liveBaseURL = "https://app.johors.com";
  static const String localURL = "https://app.johors.com";
  static const String baseURL = liveBaseURL;
  static const String login = baseURL + "/api/mobile/login";
  static const String register = baseURL + "/api/mobile/client/register";
  static const String profileDetails = baseURL + "/api/mobile/profile-details";
  static const String walletBalance =
      baseURL + "/api/mobile/client/wallet-balance";
  static const String fundWallet = baseURL + "/api/mobile/client/fund-wallet";
  static const String getClientBookings =
      baseURL + "/api/mobile/client/bookings-list";
  static const String depositHistory =
      baseURL + "/api/mobile/client/deposit-history";
  static const String withdrawalHistory =
      baseURL + "/api/mobile/client/withdrawals";
  static const String addProfilePhoto =
      baseURL + "/api/mobile/change-profile-photo";
  static const String updateProfile =
      baseURL + "/api/mobile/client/update-client-profile";
  static const String verificationStatus =
      baseURL + "/api/mobile/account-status";
  static const String resendOTP =
      baseURL + "/api/mobile/client/resend-phone-otp";
  static const String getBookingDetails =
      baseURL + '/api/mobile/client/booking-details/';
  static const String forgotPassword = baseURL + "/api/mobile/forget-password";
  static const String verifyOtpForPasswordReset =
      baseURL + "/api/mobile/verify-otp-for-forget-pass";

  static const String resetPassword = baseURL + "/api/mobile/reset-password";
  static const String processBooking =
      baseURL + "/api/mobile/client/proccess-booking";
  static const String finishBooking =
      baseURL + "/api/mobile/client/finish-booking";
}
