class UserModel {
  final String userId;
  final String username;
  final String name;
  final String email;
  final String password; // Sensitive information, handle securely
  final String? mobileNumber;
  final DateTime createdAt;
  late final int currentLevel;
  late final int totalScore;
  final List<String> rewards;
  late final int lives;
  late final DateTime lastRechargeTime;
  final String customizableAvatar;
  final int userLevel; // Represents the user's XP level
  final Map<String, dynamic> scores; // Stores level scores
  final List<String> donations;
  late final double totalDonationAmount;

  UserModel({
    required this.userId,
    required this.username,
    required this.name,
    required this.email,
    required this.password,
    this.mobileNumber,
    required this.createdAt,
    this.currentLevel = 0,
    this.totalScore = 0,
    this.rewards = const [],
    this.lives = 5,
    required this.lastRechargeTime,
    this.customizableAvatar = '',
    this.userLevel = 1,
    this.scores = const {},
    this.donations = const [],
    this.totalDonationAmount = 0.0,
  });

  // Converts UserModel to a Map for Firestore storage
  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'displayName': name,
      'username': username,
      'email': email,
      'password': password, // Handle this securely
      'mobileNumber': mobileNumber,
      'createdAt': createdAt.toIso8601String(),
      'currentLevel': currentLevel,
      'totalScore': totalScore,
      'rewards': rewards,
      'lives': lives,
      'lastRechargeTime': lastRechargeTime.toIso8601String(),
      'customizableAvatar': customizableAvatar,
      'userLevel': userLevel,
      'scores': scores,
      'donations': donations,
      'totalDonationAmount': totalDonationAmount,
    };
  }

  // Converts a Firestore document into a UserModel instance
  static UserModel fromMap(Map<String, dynamic> map) {
    return UserModel(
      userId: map['userId'],
      name: map['displayName'],
      username: map['username'],
      email: map['email'],
      password: map['password'], // Handle securely
      mobileNumber: map['mobileNumber'],
      createdAt: DateTime.parse(map['createdAt']),
      currentLevel: map['currentLevel'] ?? 0,
      totalScore: map['totalScore'] ?? 0,
      rewards: List<String>.from(map['rewards'] ?? []),
      lives: map['lives'] ?? 5,
      lastRechargeTime: DateTime.parse(map['lastRechargeTime']),
      customizableAvatar: map['customizableAvatar'] ?? '',
      userLevel: map['userLevel'] ?? 1,
      scores: Map<String, dynamic>.from(map['scores'] ?? {}),
      donations: List<String>.from(map['donations'] ?? []),
      totalDonationAmount: map['totalDonationAmount']?.toDouble() ?? 0.0,
    );
  }

  // Updates the user's total score
  void updateTotalScore(int newScore) {
    totalScore += newScore;
  }

  // Updates the user's level progress
  void updateLevelProgress(int newLevel, int newScore) {
    currentLevel = newLevel;
    totalScore += newScore;
  }

  // Adds a reward to the user's rewards list
  void addReward(String reward) {
    rewards.add(reward);
  }

  // Deducts a life when the user makes a mistake
  void loseLife() {
    if (lives > 0) {
      lives -= 1;
    }
  }

  // Resets lives to full when recharge time is reached
  void rechargeLives() {
    lives = 5;
    lastRechargeTime = DateTime.now();
  }

  // Adds a donation to the user's profile
  void addDonation(String donationId, double amount) {
    donations.add(donationId);
    totalDonationAmount += amount;
  }
}