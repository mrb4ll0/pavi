import 'package:flutter/material.dart';
import 'package:pavi/theme/generalTheme.dart';

enum TransactionType {
  credit,
  debit,
  recharge,
  callDeduction,
  dataPurchase
}

enum TransactionStatus {
  pending,
  completed,
  failed,
  refunded
}

enum PaymentMethod {
  paystack,
  card,
  bankTransfer,
  ussd
}

extension PaymentMethodExtension on PaymentMethod {
  String get displayName {
    switch (this) {
      case PaymentMethod.paystack:
        return 'Paystack';
      case PaymentMethod.card:
        return 'Card Payment';
      case PaymentMethod.bankTransfer:
        return 'Bank Transfer';
      case PaymentMethod.ussd:
        return 'USSD Code';
    }
  }

  String get description {
    switch (this) {
      case PaymentMethod.paystack:
        return 'Pay with card, bank transfer or USSD';
      case PaymentMethod.card:
        return 'Direct card payment';
      case PaymentMethod.bankTransfer:
        return 'Transfer from your bank account';
      case PaymentMethod.ussd:
        return 'Dial *123# to pay';
    }
  }

  IconData get icon {
    switch (this) {
      case PaymentMethod.paystack:
        return Icons.payment;
      case PaymentMethod.card:
        return Icons.credit_card;
      case PaymentMethod.bankTransfer:
        return Icons.account_balance;
      case PaymentMethod.ussd:
        return Icons.phone_android;
    }
  }

  Color getColor(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    switch (this) {
      case PaymentMethod.paystack:
        return const Color(0xFF0BA4E0); // Paystack blue
      case PaymentMethod.card:
        return isDark ? context.accentPurple : context.primaryColor;
      case PaymentMethod.bankTransfer:
        return context.warning;
      case PaymentMethod.ussd:
        return context.info;
    }
  }
}

class WalletBalance {
  final double nairaBalance;
  final int minutesBalance;
  final int dataBalance; // in MB
  final DateTime lastUpdated;

  WalletBalance({
    required this.nairaBalance,
    required this.minutesBalance,
    required this.dataBalance,
    required this.lastUpdated,
  });

  factory WalletBalance.initial() {
    return WalletBalance(
      nairaBalance: 2500.00,
      minutesBalance: 150,
      dataBalance: 2560, // 2.5 GB
      lastUpdated: DateTime.now(),
    );
  }

  WalletBalance copyWith({
    double? nairaBalance,
    int? minutesBalance,
    int? dataBalance,
    DateTime? lastUpdated,
  }) {
    return WalletBalance(
      nairaBalance: nairaBalance ?? this.nairaBalance,
      minutesBalance: minutesBalance ?? this.minutesBalance,
      dataBalance: dataBalance ?? this.dataBalance,
      lastUpdated: lastUpdated ?? this.lastUpdated,
    );
  }
}

class Transaction {
  final String id;
  final String title;
  final String description;
  final double amount;
  final DateTime date;
  final TransactionType type;
  final TransactionStatus status;
  final String? reference;
  final PaymentMethod? paymentMethod;
  final Map<String, dynamic>? metadata;

  Transaction({
    required this.id,
    required this.title,
    required this.description,
    required this.amount,
    required this.date,
    required this.type,
    required this.status,
    this.reference,
    this.paymentMethod,
    this.metadata,
  });

  String get formattedDate {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final transactionDate = DateTime(date.year, date.month, date.day);

    if (transactionDate == today) {
      return 'Today, ${date.hour.toString().padLeft(2, '0')}:${date.minute.toString().padLeft(2, '0')}';
    } else if (transactionDate == today.subtract(const Duration(days: 1))) {
      return 'Yesterday, ${date.hour.toString().padLeft(2, '0')}:${date.minute.toString().padLeft(2, '0')}';
    } else {
      return '${date.day}/${date.month}/${date.year}';
    }
  }

  Color getStatusColor(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    switch (status) {
      case TransactionStatus.completed:
        return context.success;
      case TransactionStatus.pending:
        return context.warning;
      case TransactionStatus.failed:
        return context.error;
      case TransactionStatus.refunded:
        return context.info;
    }
  }

  IconData getTypeIcon() {
    switch (type) {
      case TransactionType.credit:
      case TransactionType.recharge:
        return Icons.arrow_downward;
      case TransactionType.debit:
      case TransactionType.callDeduction:
      case TransactionType.dataPurchase:
        return Icons.arrow_upward;
    }
  }

  String getTypeDisplayName() {
    switch (type) {
      case TransactionType.credit:
        return 'Credit';
      case TransactionType.debit:
        return 'Debit';
      case TransactionType.recharge:
        return 'Recharge';
      case TransactionType.callDeduction:
        return 'Call Deduction';
      case TransactionType.dataPurchase:
        return 'Data Purchase';
    }
  }
}

class RechargeRequest {
  final double amount;
  final String? email;
  final String? phoneNumber;
  final PaymentMethod paymentMethod;

  RechargeRequest({
    required this.amount,
    this.email,
    this.phoneNumber,
    required this.paymentMethod,
  });

  bool get isValid {
    return amount > 0 && amount <= 100000; // Max ₦100,000 per transaction
  }

  Map<String, dynamic> toJson() {
    return {
      'amount': amount,
      'email': email,
      'phoneNumber': phoneNumber,
      'paymentMethod': paymentMethod.toString(),
    };
  }
}

class PaymentResponse {
  final String reference;
  final double amount;
  final PaymentMethod paymentMethod;
  final DateTime timestamp;
  final PaymentStatus status;
  final String? message;

  PaymentResponse({
    required this.reference,
    required this.amount,
    required this.paymentMethod,
    required this.timestamp,
    required this.status,
    this.message,
  });

  factory PaymentResponse.success({
    required String reference,
    required double amount,
    required PaymentMethod paymentMethod,
  }) {
    return PaymentResponse(
      reference: reference,
      amount: amount,
      paymentMethod: paymentMethod,
      timestamp: DateTime.now(),
      status: PaymentStatus.success,
    );
  }

  factory PaymentResponse.failed({
    required String reference,
    required double amount,
    required PaymentMethod paymentMethod,
    String? message,
  }) {
    return PaymentResponse(
      reference: reference,
      amount: amount,
      paymentMethod: paymentMethod,
      timestamp: DateTime.now(),
      status: PaymentStatus.failed,
      message: message,
    );
  }
}

enum PaymentStatus {
  success,
  failed,
  pending
}

extension PaymentStatusExtension on PaymentStatus {
  String get displayName {
    switch (this) {
      case PaymentStatus.success:
        return 'Successful';
      case PaymentStatus.failed:
        return 'Failed';
      case PaymentStatus.pending:
        return 'Pending';
    }
  }

  Color getColor(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    switch (this) {
      case PaymentStatus.success:
        return context.success;
      case PaymentStatus.failed:
        return context.error;
      case PaymentStatus.pending:
        return context.warning;
    }
  }

  IconData get icon {
    switch (this) {
      case PaymentStatus.success:
        return Icons.check_circle;
      case PaymentStatus.failed:
        return Icons.error;
      case PaymentStatus.pending:
        return Icons.hourglass_empty;
    }
  }
}

class PaymentMethodOption {
  final PaymentMethod method;
  final bool isAvailable;
  final String? unavailableReason;
  final double? processingFee;
  final int? processingTime; // in minutes

  PaymentMethodOption({
    required this.method,
    this.isAvailable = true,
    this.unavailableReason,
    this.processingFee,
    this.processingTime,
  });

  String get processingTimeText {
    if (processingTime == null) return 'Instant';
    if (processingTime == 0) return 'Instant';
    return '${processingTime} min';
  }

  String get feeText {
    if (processingFee == null) return 'No fees';
    if (processingFee == 0) return 'No fees';
    return '₦${processingFee!.toStringAsFixed(2)} fee';
  }
}

// Mock data for available payment methods
List<PaymentMethodOption> getAvailablePaymentMethods() {
  return [
    PaymentMethodOption(
      method: PaymentMethod.paystack,
      processingTime: 0,
      processingFee: 0,
    ),
    PaymentMethodOption(
      method: PaymentMethod.card,
      processingTime: 0,
      processingFee: 50, // ₦50 processing fee
    ),
    PaymentMethodOption(
      method: PaymentMethod.bankTransfer,
      processingTime: 5,
      processingFee: 0,
    ),
    PaymentMethodOption(
      method: PaymentMethod.ussd,
      processingTime: 1,
      processingFee: 20,
    ),
  ];
}