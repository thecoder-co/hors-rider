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
  static const String resendEmailOTP =
      baseURL + "/api/mobile/client/resend-email-otp";
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
  static const String updateClientphone =
      baseURL + '/api/mobile/client/change-client-phone-number';
  static const String verifyPhoneOtp =
      baseURL + '/api/mobile/client/verify-phone-otp';
  static const String verifyEmailOtp =
      baseURL + '/api/mobile/client/verify-email-otp';
  static const String cancelBooking =
      baseURL + '/api/mobile/client/cancel-booking';
  static const String confirmBooking =
      baseURL + '/api/mobile/client/confirm-delivery';
  static const String clientReport =
      baseURL + '/api/mobile/client/create-report';
  static const String getReportList =
      baseURL + '/api/mobile/client/reports-list/';
  static const String getBankList = baseURL + '/api/mobile/client/bank-lists';
  static const String savedBankAccounts =
      baseURL + '/api/mobile/client/saved-bank-accounts';
  static const String createWithdrawal =
      baseURL + '/api/mobile/client/create-withdrawal';
  static const String initiateWithdrawal =
      baseURL + '/api/mobile/client/initiate-withdrawal';
  static const String saveBankAccount =
      baseURL + '/api/mobile/client/save-bank-account';
  static const String removeBankAccount =
      baseURL + '/api/mobile/client/remove-bank-account';
  static const String depositDetails =
      baseURL + '/api/mobile/client/deposit-details';
  static const String latestOrderOnDelivery =
      baseURL + '/api/mobile/client/latest-order-on-delivery';
  static const String createReview =
      baseURL + '/api/mobile/client/create-review';
  static const String riderDetails =
      baseURL + '/api/mobile/client/view-rider-profile/';
}
