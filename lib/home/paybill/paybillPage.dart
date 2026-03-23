import 'package:flutter/material.dart';
import 'package:pavi/core/general/generalMethods.dart';
import 'package:pavi/theme/generalTheme.dart';

class PayBillPage extends StatefulWidget {
  const PayBillPage({super.key});

  @override
  State<PayBillPage> createState() => _PayBillPageState();
}

class _PayBillPageState extends State<PayBillPage> with SingleTickerProviderStateMixin {
  String? _selectedService;
  String? _selectedProvider;
  String? _selectedMeterType;
  final TextEditingController _meterNumberController = TextEditingController();
  final TextEditingController _amountController = TextEditingController();
  final TextEditingController _customerNameController = TextEditingController();
  bool _isLoading = false;
  bool _isValidating = false;

  late TabController _tabController;

  final List<Map<String, dynamic>> _services = [
    {'name': 'Electricity', 'icon': Icons.electric_bolt, 'color': 0xFFFF9800},
    {'name': 'TV Subscription', 'icon': Icons.tv, 'color': 0xFF2196F3},
    {'name': 'Internet', 'icon': Icons.wifi, 'color': 0xFF4CAF50},
    {'name': 'Water Bill', 'icon': Icons.water_drop, 'color': 0xFF00BCD4},
    {'name': 'Education', 'icon': Icons.school, 'color': 0xFF9C27B0},
    {'name': 'Loan Repayment', 'icon': Icons.credit_card, 'color': 0xFFF44336},
  ];

  final Map<String, List<Map<String, dynamic>>> _providers = {
    'Electricity': [
      {'name': 'Ikeja Electric', 'code': 'IE', 'icon': '⚡'},
      {'name': 'Eko Electric', 'code': 'EE', 'icon': '💡'},
      {'name': 'Abuja Electric', 'code': 'AEDC', 'icon': '🔌'},
      {'name': 'Enugu Electric', 'code': 'EEDC', 'icon': '⚡'},
      {'name': 'Jos Electric', 'code': 'JED', 'icon': '💡'},
      {'name': 'Kano Electric', 'code': 'KEDCO', 'icon': '🔌'},
    ],
    'TV Subscription': [
      {'name': 'DSTV', 'code': 'DSTV', 'icon': '📺'},
      {'name': 'GOTV', 'code': 'GOTV', 'icon': '📡'},
      {'name': 'Startimes', 'code': 'STARTIMES', 'icon': '📺'},
      {'name': 'Showmax', 'code': 'SHOWMAX', 'icon': '🎬'},
    ],
    'Internet': [
      {'name': 'Spectranet', 'code': 'SPECTRA', 'icon': '🌐'},
      {'name': 'Smile', 'code': 'SMILE', 'icon': '📶'},
      {'name': 'FibreOne', 'code': 'FIBRE', 'icon': '🔌'},
      {'name': 'Swift', 'code': 'SWIFT', 'icon': '⚡'},
    ],
    'Water Bill': [
      {'name': 'Lagos Water', 'code': 'LWC', 'icon': '💧'},
      {'name': 'Abuja Water', 'code': 'AWC', 'icon': '💧'},
      {'name': 'Port Harcourt Water', 'code': 'PHWC', 'icon': '💧'},
    ],
    'Education': [
      {'name': 'School Fees', 'code': 'SCHOOL', 'icon': '🎓'},
      {'name': 'Exam Fees', 'code': 'EXAM', 'icon': '📝'},
      {'name': 'Accommodation', 'code': 'HOSTEL', 'icon': '🏠'},
    ],
    'Loan Repayment': [
      {'name': 'Bank Loan', 'code': 'BANK', 'icon': '🏦'},
      {'name': 'Microfinance', 'code': 'MICRO', 'icon': '💰'},
      {'name': 'Personal Loan', 'code': 'PERSONAL', 'icon': '👤'},
    ],
  };

  final List<Map<String, dynamic>> _recentPayments = [
    {'service': 'Electricity', 'provider': 'Ikeja Electric', 'amount': '₦5,000', 'date': '2 days ago', 'meter': '1234567890'},
    {'service': 'TV Subscription', 'provider': 'DSTV', 'amount': '₦3,500', 'date': '1 week ago', 'smartcard': '1234567890'},
    {'service': 'Internet', 'provider': 'Spectranet', 'amount': '₦10,000', 'date': '2 weeks ago', 'account': '1234567890'},
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    _meterNumberController.dispose();
    _amountController.dispose();
    _customerNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: context.backgroundColor,
      appBar: AppBar(
        backgroundColor: context.surfaceColor,
        elevation: 0,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Icon(
            Icons.arrow_back,
            color: context.textPrimary,
          ),
        ),
        title: Text(
          'Pay Bill',
          style: context.titleMedium?.copyWith(
            fontWeight: FontWeight.w700,
            color: context.textPrimary,
          ),
        ),
        centerTitle: false,
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(48),
          child: Container(
            decoration: BoxDecoration(
              color: isDark ? context.darkCard : context.lightGray.withOpacity(0.3),
            ),
            child: TabBar(
              controller: _tabController,
              indicator: BoxDecoration(
                color: context.accentPurple,
                borderRadius: BorderRadius.circular(context.radiusLG),
              ),
              labelColor: Colors.white,
              unselectedLabelColor: context.textHint,
              tabs: const [
                Tab(text: 'Pay Bill'),
                Tab(text: 'History'),
              ],
            ),
          ),
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildPayBillTab(context),
          _buildHistoryTab(context),
        ],
      ),
    );
  }

  Widget _buildPayBillTab(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Balance Card
          Container(
            margin: EdgeInsets.all(context.spacingLG),
            padding: EdgeInsets.all(context.spacingLG),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  context.accentPurple,
                  context.accentPurpleDark,
                  isDark ? context.darkCard : const Color(0xFF1E293B),
                ],
              ),
              borderRadius: BorderRadius.circular(context.radiusLG),
              boxShadow: [
                BoxShadow(
                  color: context.accentPurple.withOpacity(0.3),
                  blurRadius: 20,
                  offset: const Offset(0, 8),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      padding: EdgeInsets.all(context.spacingSM),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.2),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.account_balance_wallet,
                        color: Colors.white,
                        size: 20,
                      ),
                    ),
                    SizedBox(width: context.spacingSM),
                    Text(
                      'Available Balance',
                      style: context.bodyMedium?.copyWith(
                        color: Colors.white70,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: context.spacingMD),
                Text(
                  '₦12,250',
                  style: context.displaySmall?.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 32,
                  ),
                ),
                SizedBox(height: context.spacingXS),
                Text(
                  '≈ 2,450 Pocket Coins',
                  style: context.bodySmall?.copyWith(
                    color: Colors.white70,
                  ),
                ),
              ],
            ),
          ),

          // Service Selection
          Padding(
            padding: EdgeInsets.symmetric(horizontal: context.spacingLG),
            child: Text(
              'Select Service',
              style: context.titleMedium?.copyWith(
                fontWeight: FontWeight.w700,
                color: context.textPrimary,
              ),
            ),
          ),
          SizedBox(height: context.spacingMD),
          SizedBox(
            height: 100,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: EdgeInsets.symmetric(horizontal: context.spacingLG),
              itemCount: _services.length,
              itemBuilder: (context, index) {
                final service = _services[index];
                final isSelected = _selectedService == service['name'];
                final color = Color(service['color'] as int);

                return GestureDetector(
                  onTap: () {
                    setState(() {
                      _selectedService = service['name'] as String;
                      _selectedProvider = null;
                      _meterNumberController.clear();
                      _customerNameController.clear();
                      _amountController.clear();
                    });
                  },
                  child: Container(
                    width: 100,
                    margin: EdgeInsets.only(right: context.spacingMD),
                    decoration: BoxDecoration(
                      gradient: isSelected
                          ? LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          color.withOpacity(0.2),
                          color.withOpacity(0.1),
                        ],
                      )
                          : null,
                      color: isSelected
                          ? null
                          : (isDark ? context.darkCard : context.white),
                      borderRadius: BorderRadius.circular(context.radiusLG),
                      border: Border.all(
                        color: isSelected ? color : (isDark ? context.darkTextHint.withOpacity(0.2) : context.lightGray),
                        width: isSelected ? 2 : 1,
                      ),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          service['icon'] as IconData,
                          size: 28,
                          color: isSelected ? color : context.textPrimary,
                        ),
                        SizedBox(height: context.spacingXS),
                        Text(
                          service['name'] as String,
                          style: context.labelSmall?.copyWith(
                            fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
                            color: isSelected ? color : context.textPrimary,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        if (isSelected)
                          Container(
                            margin: EdgeInsets.only(top: 4),
                            width: 20,
                            height: 2,
                            color: color,
                          ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),

          SizedBox(height: context.spacingXL),

          // Provider Selection
          if (_selectedService != null) ...[
            Padding(
              padding: EdgeInsets.symmetric(horizontal: context.spacingLG),
              child: Text(
                'Select Provider',
                style: context.titleMedium?.copyWith(
                  fontWeight: FontWeight.w700,
                  color: context.textPrimary,
                ),
              ),
            ),
            SizedBox(height: context.spacingMD),
            SizedBox(
              height: 80,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                padding: EdgeInsets.symmetric(horizontal: context.spacingLG),
                itemCount: _providers[_selectedService]?.length ?? 0,
                itemBuilder: (context, index) {
                  final provider = _providers[_selectedService]![index];
                  final isSelected = _selectedProvider == provider['name'];
                  final serviceColor = Color(_services.firstWhere(
                        (s) => s['name'] == _selectedService,
                  )['color'] as int);

                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        _selectedProvider = provider['name'] as String;
                      });
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: context.spacingMD,
                        vertical: context.spacingSM,
                      ),
                      margin: EdgeInsets.only(right: context.spacingMD),
                      decoration: BoxDecoration(
                        gradient: isSelected
                            ? LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [
                            serviceColor.withOpacity(0.2),
                            serviceColor.withOpacity(0.1),
                          ],
                        )
                            : null,
                        color: isSelected
                            ? null
                            : (isDark ? context.darkCard : context.white),
                        borderRadius: BorderRadius.circular(context.radiusMD),
                        border: Border.all(
                          color: isSelected ? serviceColor : (isDark ? context.darkTextHint.withOpacity(0.2) : context.lightGray),
                          width: isSelected ? 2 : 1,
                        ),
                      ),
                      child: Row(
                        children: [
                          Text(
                            provider['icon'] as String,
                            style: const TextStyle(fontSize: 20),
                          ),
                          SizedBox(width: context.spacingSM),
                          Text(
                            provider['name'] as String,
                            style: context.bodyMedium?.copyWith(
                              fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
                              color: isSelected ? serviceColor : context.textPrimary,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            SizedBox(height: context.spacingXL),
          ],

          // Bill Details Form
          if (_selectedProvider != null) ...[
            Padding(
              padding: EdgeInsets.symmetric(horizontal: context.spacingLG),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Bill Details',
                    style: context.titleMedium?.copyWith(
                      fontWeight: FontWeight.w700,
                      color: context.textPrimary,
                    ),
                  ),
                  SizedBox(height: context.spacingMD),
                  Container(
                    padding: EdgeInsets.all(context.spacingMD),
                    decoration: BoxDecoration(
                      color: isDark ? context.darkCard : context.white,
                      borderRadius: BorderRadius.circular(context.radiusLG),
                      border: Border.all(
                        color: isDark ? context.darkTextHint.withOpacity(0.2) : context.lightGray,
                      ),
                    ),
                    child: Column(
                      children: [
                        // Meter/Account Number Field
                        TextField(
                          controller: _meterNumberController,
                          keyboardType: TextInputType.number,
                          style: context.bodyMedium,
                          decoration: InputDecoration(
                            labelText: _selectedService == 'Electricity' ? 'Meter Number' : 'Account/Smartcard Number',
                            labelStyle: context.bodySmall?.copyWith(
                              color: context.textHint,
                            ),
                            hintText: 'Enter number',
                            prefixIcon: Icon(
                              _selectedService == 'Electricity' ? Icons.electric_meter : Icons.numbers,
                              color: context.accentPurple,
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(context.radiusMD),
                              borderSide: BorderSide(
                                color: isDark ? context.darkTextHint.withOpacity(0.2) : context.lightGray,
                              ),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(context.radiusMD),
                              borderSide: BorderSide(
                                color: isDark ? context.darkTextHint.withOpacity(0.2) : context.lightGray,
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(context.radiusMD),
                              borderSide: BorderSide(
                                color: context.accentPurple,
                                width: 2,
                              ),
                            ),
                          ),
                          onChanged: (value) {
                            if (value.length >= 10 && !_isValidating) {
                              _validateMeterNumber(context, value);
                            }
                          },
                        ),
                        SizedBox(height: context.spacingMD),

                        // Customer Name (if validated)
                        if (_customerNameController.text.isNotEmpty)
                          Container(
                            padding: EdgeInsets.all(context.spacingMD),
                            decoration: BoxDecoration(
                              color: context.success.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(context.radiusMD),
                            ),
                            child: Row(
                              children: [
                                Icon(
                                  Icons.person,
                                  color: context.success,
                                  size: 20,
                                ),
                                SizedBox(width: context.spacingSM),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Customer Name',
                                        style: context.labelSmall?.copyWith(
                                          color: context.textHint,
                                        ),
                                      ),
                                      Text(
                                        _customerNameController.text,
                                        style: context.bodyMedium?.copyWith(
                                          fontWeight: FontWeight.w600,
                                          color: context.textPrimary,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Icon(
                                  Icons.check_circle,
                                  color: context.success,
                                  size: 20,
                                ),
                              ],
                            ),
                          ),

                        if (_customerNameController.text.isNotEmpty)
                          SizedBox(height: context.spacingMD),

                        // Amount Field
                        TextField(
                          controller: _amountController,
                          keyboardType: TextInputType.number,
                          style: context.bodyMedium,
                          decoration: InputDecoration(
                            labelText: 'Amount (₦)',
                            labelStyle: context.bodySmall?.copyWith(
                              color: context.textHint,
                            ),
                            hintText: 'Enter amount',
                            prefixIcon: Icon(
                              Icons.currency_exchange,
                              color: context.accentPurple,
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(context.radiusMD),
                              borderSide: BorderSide(
                                color: isDark ? context.darkTextHint.withOpacity(0.2) : context.lightGray,
                              ),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(context.radiusMD),
                              borderSide: BorderSide(
                                color: isDark ? context.darkTextHint.withOpacity(0.2) : context.lightGray,
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(context.radiusMD),
                              borderSide: BorderSide(
                                color: context.accentPurple,
                                width: 2,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: context.spacingXL),
          ],

          // Pay Button
          if (_customerNameController.text.isNotEmpty && _amountController.text.isNotEmpty) ...[
            Padding(
              padding: EdgeInsets.symmetric(horizontal: context.spacingLG),
              child: Column(
                children: [
                  // Summary
                  Container(
                    padding: EdgeInsets.all(context.spacingMD),
                    decoration: BoxDecoration(
                      color: isDark ? context.darkCard : context.white,
                      borderRadius: BorderRadius.circular(context.radiusLG),
                      border: Border.all(
                        color: isDark ? context.darkTextHint.withOpacity(0.2) : context.lightGray,
                      ),
                    ),
                    child: Column(
                      children: [
                        _buildSummaryRow(
                          context,
                          label: 'Service',
                          value: _selectedService!,
                        ),
                        _buildSummaryRow(
                          context,
                          label: 'Provider',
                          value: _selectedProvider!,
                        ),
                        _buildSummaryRow(
                          context,
                          label: _selectedService == 'Electricity' ? 'Meter Number' : 'Account Number',
                          value: _meterNumberController.text,
                        ),
                        _buildSummaryRow(
                          context,
                          label: 'Customer',
                          value: _customerNameController.text,
                        ),
                        Divider(
                          height: context.spacingMD,
                          color: isDark ? context.darkTextHint.withOpacity(0.2) : context.lightGray,
                        ),
                        _buildSummaryRow(
                          context,
                          label: 'Amount',
                          value: '₦${_amountController.text}',
                          isTotal: true,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: context.spacingLG),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: _isLoading ? null : _processPayment,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: context.accentPurple,
                        foregroundColor: Colors.white,
                        padding: EdgeInsets.symmetric(vertical: context.spacingMD),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(context.radiusMD),
                        ),
                      ),
                      child: _isLoading
                          ? SizedBox(
                        height: 20,
                        width: 20,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                        ),
                      )
                          : Text(
                        'Pay Bill',
                        style: context.bodyMedium?.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: context.spacing3XL),
          ],
        ],
      ),
    );
  }

  Widget _buildHistoryTab(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return ListView.builder(
      padding: EdgeInsets.all(context.spacingLG),
      itemCount: _recentPayments.length,
      itemBuilder: (context, index) {
        final payment = _recentPayments[index];
        final serviceColor = Color(_services.firstWhere(
              (s) => s['name'] == payment['service'],
          orElse: () => _services[0],
        )['color'] as int);

        return Container(
          margin: EdgeInsets.only(bottom: context.spacingMD),
          padding: EdgeInsets.all(context.spacingMD),
          decoration: BoxDecoration(
            color: isDark ? context.darkCard : context.white,
            borderRadius: BorderRadius.circular(context.radiusLG),
            border: Border.all(
              color: isDark ? context.darkTextHint.withOpacity(0.2) : context.lightGray,
            ),
          ),
          child: Row(
            children: [
              Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  color: serviceColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(context.radiusMD),
                ),
                child: Icon(
                  _services.firstWhere((s) => s['name'] == payment['service'])['icon'] as IconData,
                  color: serviceColor,
                  size: 24,
                ),
              ),
              SizedBox(width: context.spacingMD),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      payment['service'] as String,
                      style: context.bodyMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                        color: context.textPrimary,
                      ),
                    ),
                    Text(
                      payment['provider'] as String,
                      style: context.labelSmall?.copyWith(
                        color: context.textHint,
                      ),
                    ),
                    Text(
                      payment['date'] as String,
                      style: context.labelSmall?.copyWith(
                        color: context.textHint,
                        fontSize: 10,
                      ),
                    ),
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    payment['amount'] as String,
                    style: context.titleSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: context.error,
                    ),
                  ),
                  SizedBox(height: 4),
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: context.spacingSM,
                      vertical: context.spacingXXS,
                    ),
                    decoration: BoxDecoration(
                      color: context.success.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(context.radiusSM),
                    ),
                    child: Text(
                      'Completed',
                      style: context.labelSmall?.copyWith(
                        color: context.success,
                        fontSize: 10,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildSummaryRow(
      BuildContext context, {
        required String label,
        required String value,
        bool isTotal = false,
      }) {
    return Padding(
      padding: EdgeInsets.only(bottom: context.spacingSM),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: context.bodySmall?.copyWith(
              color: context.textHint,
              fontWeight: isTotal ? FontWeight.w600 : FontWeight.normal,
            ),
          ),
          Text(
            value,
            style: context.bodyMedium?.copyWith(
              fontWeight: isTotal ? FontWeight.bold : FontWeight.w500,
              color: isTotal ? context.accentPurple : context.textPrimary,
              fontSize: isTotal ? 16 : 14,
            ),
          ),
        ],
      ),
    );
  }

  void _validateMeterNumber(BuildContext context, String number) async {
    setState(() {
      _isValidating = true;
    });

    // Simulate API validation
    await Future.delayed(const Duration(seconds: 1));

    setState(() {
      _customerNameController.text = 'John Doe'; // Mock customer name
      _isValidating = false;
    });
  }

  void _processPayment() async {
    setState(() {
      _isLoading = true;
    });

    await Future.delayed(const Duration(seconds: 2));

    setState(() {
      _isLoading = false;
    });

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        backgroundColor: context.surfaceColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(context.radiusLG),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: EdgeInsets.all(context.spacingLG),
              decoration: BoxDecoration(
                color: context.success.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.check_circle,
                color: context.success,
                size: 64,
              ),
            ),
            SizedBox(height: context.spacingLG),
            Text(
              'Payment Successful!',
              style: context.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
                color: context.textPrimary,
              ),
            ),
            SizedBox(height: context.spacingSM),
            Text(
              'Your bill payment of ₦${_amountController.text} was successful',
              textAlign: TextAlign.center,
              style: context.bodyMedium?.copyWith(
                color: context.textSecondary,
              ),
            ),
          ],
        ),
        actions: [
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
                Navigator.pop(context);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: context.accentPurple,
                foregroundColor: Colors.white,
                padding: EdgeInsets.symmetric(vertical: context.spacingMD),
              ),
              child: const Text('Done'),
            ),
          ),
        ],
      ),
    );
  }
}