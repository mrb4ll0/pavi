import 'package:flutter/material.dart';
import 'package:pavi/core/general/generalMethods.dart';
import 'package:pavi/theme/generalTheme.dart';

class BuyDataPage extends StatefulWidget {
  const BuyDataPage({super.key});

  @override
  State<BuyDataPage> createState() => _BuyDataPageState();
}

class _BuyDataPageState extends State<BuyDataPage> {
  String? _selectedNetwork;
  String? _selectedDataPlan;
  String? _selectedPhoneNumber;
  final TextEditingController _customAmountController = TextEditingController();
  bool _isCustomAmount = false;
  bool _isLoading = false;

  // Sample data
  final List<Map<String, dynamic>> _networks = [
    {
      'name': 'MTN',
      'icon': '🌐',
      'color': 0xFFF7931E,
      'dataPlans': [
        {'size': '500MB', 'price': '₦100', 'validity': '1 day'},
        {'size': '1GB', 'price': '₦200', 'validity': '2 days'},
        {'size': '2GB', 'price': '₦500', 'validity': '7 days'},
        {'size': '5GB', 'price': '₦1,200', 'validity': '30 days'},
        {'size': '10GB', 'price': '₦2,000', 'validity': '30 days'},
        {'size': '15GB', 'price': '₦2,800', 'validity': '30 days'},
      ],
    },
    {
      'name': 'GLO',
      'icon': '🌍',
      'color': 0xFF00A651,
      'dataPlans': [
        {'size': '500MB', 'price': '₦90', 'validity': '1 day'},
        {'size': '1GB', 'price': '₦180', 'validity': '2 days'},
        {'size': '2GB', 'price': '₦450', 'validity': '7 days'},
        {'size': '4.5GB', 'price': '₦1,000', 'validity': '30 days'},
        {'size': '11GB', 'price': '₦2,000', 'validity': '30 days'},
        {'size': '22GB', 'price': '₦3,500', 'validity': '30 days'},
      ],
    },
    {
      'name': 'Airtel',
      'icon': '📶',
      'color': 0xFFE30613,
      'dataPlans': [
        {'size': '500MB', 'price': '₦100', 'validity': '1 day'},
        {'size': '1GB', 'price': '₦200', 'validity': '2 days'},
        {'size': '2GB', 'price': '₦500', 'validity': '7 days'},
        {'size': '4.5GB', 'price': '₦1,000', 'validity': '30 days'},
        {'size': '10GB', 'price': '₦1,800', 'validity': '30 days'},
        {'size': '20GB', 'price': '₦3,000', 'validity': '30 days'},
      ],
    },
    {
      'name': '9mobile',
      'icon': '📱',
      'color': 0xFF0054A6,
      'dataPlans': [
        {'size': '500MB', 'price': '₦100', 'validity': '1 day'},
        {'size': '1GB', 'price': '₦200', 'validity': '2 days'},
        {'size': '2GB', 'price': '₦500', 'validity': '7 days'},
        {'size': '5GB', 'price': '₦1,200', 'validity': '30 days'},
        {'size': '10GB', 'price': '₦2,000', 'validity': '30 days'},
        {'size': '15GB', 'price': '₦2,800', 'validity': '30 days'},
      ],
    },
  ];

  final List<Map<String, dynamic>> _savedNumbers = [
    {'number': '08012345678', 'label': 'My Line', 'network': 'MTN'},
    {'number': '08098765432', 'label': 'Work', 'network': 'GLO'},
    {'number': '08123456789', 'label': 'Family', 'network': 'Airtel'},
  ];

  @override
  void dispose() {
    _customAmountController.dispose();
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
          'Buy Data',
          style: context.titleMedium?.copyWith(
            fontWeight: FontWeight.w700,
            color: context.textPrimary,
          ),
        ),
        centerTitle: false,
        actions: [
          IconButton(
            onPressed: () {
              // Navigate to transaction history
            },
            icon: Icon(
              Icons.history,
              color: context.textPrimary,
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
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

            // Network Selection
            Padding(
              padding: EdgeInsets.symmetric(horizontal: context.spacingLG),
              child: Text(
                'Select Network',
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
                itemCount: _networks.length,
                itemBuilder: (context, index) {
                  final network = _networks[index];
                  final isSelected = _selectedNetwork == network['name'];
                  final color = Color(network['color'] as int);

                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        _selectedNetwork = network['name'] as String;
                        _selectedDataPlan = null;
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
                          Text(
                            network['icon'] as String,
                            style: const TextStyle(fontSize: 32),
                          ),
                          SizedBox(height: context.spacingXS),
                          Text(
                            network['name'] as String,
                            style: context.bodyMedium?.copyWith(
                              fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
                              color: isSelected ? color : context.textPrimary,
                            ),
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

            // Phone Number Selection
            if (_selectedNetwork != null) ...[
              Padding(
                padding: EdgeInsets.symmetric(horizontal: context.spacingLG),
                child: Text(
                  'Phone Number',
                  style: context.titleMedium?.copyWith(
                    fontWeight: FontWeight.w700,
                    color: context.textPrimary,
                  ),
                ),
              ),
              SizedBox(height: context.spacingMD),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: context.spacingLG),
                child: Container(
                  decoration: BoxDecoration(
                    color: isDark ? context.darkCard : context.white,
                    borderRadius: BorderRadius.circular(context.radiusLG),
                    border: Border.all(
                      color: isDark ? context.darkTextHint.withOpacity(0.2) : context.lightGray,
                    ),
                  ),
                  child: Column(
                    children: [
                      // Saved numbers
                      if (_savedNumbers.isNotEmpty)
                        Column(
                          children: [
                            Padding(
                              padding: EdgeInsets.all(context.spacingMD),
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.save,
                                    size: 20,
                                    color: context.textHint,
                                  ),
                                  SizedBox(width: context.spacingSM),
                                  Text(
                                    'Saved Numbers',
                                    style: context.bodySmall?.copyWith(
                                      color: context.textHint,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            ..._savedNumbers
                                .where((number) => number['network'] == _selectedNetwork)
                                .map((number) => _buildSavedNumberTile(context, number)),
                            if (_savedNumbers.where((n) => n['network'] == _selectedNetwork).isEmpty)
                              Padding(
                                padding: EdgeInsets.all(context.spacingMD),
                                child: Text(
                                  'No saved numbers for ${_selectedNetwork}',
                                  style: context.bodySmall?.copyWith(
                                    color: context.textHint,
                                  ),
                                ),
                              ),
                          ],
                        ),
                      Divider(
                        height: 1,
                        color: isDark ? context.darkTextHint.withOpacity(0.2) : context.lightGray,
                      ),
                      // Manual entry
                      ListTile(
                        onTap: () {
                          _showPhoneNumberDialog(context);
                        },
                        leading: Icon(
                          Icons.add_circle_outline,
                          color: context.accentPurple,
                        ),
                        title: Text(
                          'Enter New Number',
                          style: context.bodyMedium?.copyWith(
                            color: context.accentPurple,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        trailing: Icon(
                          Icons.chevron_right,
                          color: context.textHint,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: context.spacingXL),
            ],

            // Data Plan Selection
            if (_selectedNetwork != null && _selectedPhoneNumber != null) ...[
              Padding(
                padding: EdgeInsets.symmetric(horizontal: context.spacingLG),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Select Data Plan',
                      style: context.titleMedium?.copyWith(
                        fontWeight: FontWeight.w700,
                        color: context.textPrimary,
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        setState(() {
                          _isCustomAmount = !_isCustomAmount;
                          _selectedDataPlan = null;
                        });
                      },
                      child: Text(
                        _isCustomAmount ? 'View Plans' : 'Custom Amount',
                        style: context.labelSmall?.copyWith(
                          color: context.accentPurple,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: context.spacingMD),
              if (!_isCustomAmount)
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: context.spacingLG),
                  child: GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: context.spacingMD,
                      mainAxisSpacing: context.spacingMD,
                      childAspectRatio: 1.5,
                    ),
                    itemCount: _getCurrentNetworkDataPlans().length,
                    itemBuilder: (context, index) {
                      final plan = _getCurrentNetworkDataPlans()[index];
                      final isSelected = _selectedDataPlan == plan['size'];
                      final networkColor = Color(_networks.firstWhere(
                            (n) => n['name'] == _selectedNetwork,
                      )['color'] as int);

                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            _selectedDataPlan = plan['size'] as String;
                          });
                        },
                        child: Container(
                          padding: EdgeInsets.all(context.spacingMD),
                          decoration: BoxDecoration(
                            gradient: isSelected
                                ? LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              colors: [
                                networkColor.withOpacity(0.2),
                                networkColor.withOpacity(0.1),
                              ],
                            )
                                : null,
                            color: isSelected
                                ? null
                                : (isDark ? context.darkCard : context.white),
                            borderRadius: BorderRadius.circular(context.radiusLG),
                            border: Border.all(
                              color: isSelected
                                  ? networkColor
                                  : (isDark ? context.darkTextHint.withOpacity(0.2) : context.lightGray),
                              width: isSelected ? 2 : 1,
                            ),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                plan['size'] as String,
                                style: context.titleMedium?.copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: isSelected ? networkColor : context.textPrimary,
                                ),
                              ),
                              SizedBox(height: context.spacingXS),
                              Text(
                                plan['price'] as String,
                                style: context.bodyMedium?.copyWith(
                                  fontWeight: FontWeight.w600,
                                  color: isSelected ? networkColor : context.textSecondary,
                                ),
                              ),
                              SizedBox(height: context.spacingXXS),
                              Text(
                                plan['validity'] as String,
                                style: context.labelSmall?.copyWith(
                                  color: context.textHint,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              if (_isCustomAmount)
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: context.spacingLG),
                  child: Container(
                    padding: EdgeInsets.all(context.spacingMD),
                    decoration: BoxDecoration(
                      color: isDark ? context.darkCard : context.white,
                      borderRadius: BorderRadius.circular(context.radiusLG),
                      border: Border.all(
                        color: isDark ? context.darkTextHint.withOpacity(0.2) : context.lightGray,
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Enter Amount (₦)',
                          style: context.bodySmall?.copyWith(
                            color: context.textHint,
                          ),
                        ),
                        SizedBox(height: context.spacingSM),
                        TextField(
                          controller: _customAmountController,
                          keyboardType: TextInputType.number,
                          style: context.titleLarge?.copyWith(
                            color: context.textPrimary,
                          ),
                          decoration: InputDecoration(
                            hintText: 'e.g., 500',
                            hintStyle: context.bodyMedium?.copyWith(
                              color: context.textHint,
                            ),
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
                        SizedBox(height: context.spacingSM),
                        Text(
                          'Minimum amount: ₦100',
                          style: context.labelSmall?.copyWith(
                            color: context.textHint,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              SizedBox(height: context.spacingXL),
            ],

            // Purchase Button
            if (_selectedNetwork != null &&
                _selectedPhoneNumber != null &&
                (_selectedDataPlan != null || (_isCustomAmount && _customAmountController.text.isNotEmpty))) ...[
              Padding(
                padding: EdgeInsets.symmetric(horizontal: context.spacingLG),
                child: Column(
                  children: [
                    // Order Summary
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
                            label: 'Network',
                            value: _selectedNetwork!,
                          ),
                          _buildSummaryRow(
                            context,
                            label: 'Phone Number',
                            value: _selectedPhoneNumber!,
                          ),
                          _buildSummaryRow(
                            context,
                            label: 'Data Plan',
                            value: _isCustomAmount
                                ? 'Custom - ₦${_customAmountController.text}'
                                : '${_selectedDataPlan} - ${_getSelectedPlanPrice()}',
                          ),
                          Divider(
                            height: context.spacingMD,
                            color: isDark ? context.darkTextHint.withOpacity(0.2) : context.lightGray,
                          ),
                          _buildSummaryRow(
                            context,
                            label: 'Total',
                            value: _isCustomAmount
                                ? '₦${_customAmountController.text}'
                                : _getSelectedPlanPrice(),
                            isTotal: true,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: context.spacingLG),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: _isLoading ? null : _processPurchase,
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
                          'Buy Data',
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
      ),
    );
  }

  Widget _buildSavedNumberTile(BuildContext context, Map<String, dynamic> number) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final isSelected = _selectedPhoneNumber == number['number'];

    return ListTile(
      onTap: () {
        setState(() {
          _selectedPhoneNumber = number['number'] as String;
        });
      },
      leading: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          color: isSelected
              ? context.accentPurple.withOpacity(0.1)
              : (isDark ? context.darkSurface : context.lightGray.withOpacity(0.3)),
          shape: BoxShape.circle,
        ),
        child: Icon(
          Icons.phone_android,
          size: 20,
          color: isSelected ? context.accentPurple : context.textHint,
        ),
      ),
      title: Text(
        number['label'] as String,
        style: context.bodyMedium?.copyWith(
          fontWeight: FontWeight.w600,
          color: context.textPrimary,
        ),
      ),
      subtitle: Text(
        number['number'] as String,
        style: context.bodySmall?.copyWith(
          color: context.textHint,
        ),
      ),
      trailing: isSelected
          ? Container(
        width: 24,
        height: 24,
        decoration: BoxDecoration(
          color: context.accentPurple,
          shape: BoxShape.circle,
        ),
        child: Icon(
          Icons.check,
          size: 14,
          color: Colors.white,
        ),
      )
          : null,
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

  List<Map<String, String>> _getCurrentNetworkDataPlans() {
    final network = _networks.firstWhere(
          (n) => n['name'] == _selectedNetwork,
      orElse: () => _networks[0],
    );
    return (network['dataPlans'] as List<Map<String, dynamic>>).map((plan) {
      return {
        'size': plan['size'] as String,
        'price': plan['price'] as String,
        'validity': plan['validity'] as String,
      };
    }).toList();
  }

  String _getSelectedPlanPrice() {
    final plans = _getCurrentNetworkDataPlans();
    final selectedPlan = plans.firstWhere(
          (plan) => plan['size'] == _selectedDataPlan,
      orElse: () => plans[0],
    );
    return selectedPlan['price'] ?? '₦0';
  }

  void _showPhoneNumberDialog(BuildContext context) {
    final TextEditingController controller = TextEditingController();
    final isDark = Theme.of(context).brightness == Brightness.dark;

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: context.surfaceColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(context.radiusLG),
        ),
        title: Text(
          'Enter Phone Number',
          style: context.titleMedium?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        content: TextField(
          controller: controller,
          keyboardType: TextInputType.phone,
          style: context.bodyMedium,
          decoration: InputDecoration(
            hintText: 'e.g., 08012345678',
            hintStyle: context.bodySmall?.copyWith(
              color: context.textHint,
            ),
            prefixIcon: Icon(
              Icons.phone,
              color: context.accentPurple,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(context.radiusMD),
              borderSide: BorderSide(
                color: isDark ? context.darkTextHint.withOpacity(0.2) : context.lightGray,
              ),
            ),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              'Cancel',
              style: TextStyle(
                color: context.textHint,
              ),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              if (controller.text.isNotEmpty) {
                setState(() {
                  _selectedPhoneNumber = controller.text;
                });
                Navigator.pop(context);
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: context.accentPurple,
              foregroundColor: Colors.white,
            ),
            child: const Text('Add'),
          ),
        ],
      ),
    );
  }

  void _processPurchase() async {
    setState(() {
      _isLoading = true;
    });

    final isDark = Theme.of(context).brightness == Brightness.dark;
    // Simulate API call
    await Future.delayed(const Duration(seconds: 2));

    setState(() {
      _isLoading = false;
    });

    // Show success dialog
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
              'Purchase Successful!',
              style: context.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
                color: context.textPrimary,
              ),
            ),
            SizedBox(height: context.spacingSM),
            Text(
              'You have successfully purchased data for $_selectedPhoneNumber',
              textAlign: TextAlign.center,
              style: context.bodyMedium?.copyWith(
                color: context.textSecondary,
              ),
            ),
            SizedBox(height: context.spacingMD),
            Container(
              padding: EdgeInsets.all(context.spacingMD),
              decoration: BoxDecoration(
                color: isDark ? context.darkCard : context.lightGray.withOpacity(0.3),
                borderRadius: BorderRadius.circular(context.radiusMD),
              ),
              child: Column(
                children: [
                  Text(
                    _isCustomAmount
                        ? '₦${_customAmountController.text}'
                        : _getSelectedPlanPrice(),
                    style: context.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: context.accentPurple,
                    ),
                  ),
                  Text(
                    _isCustomAmount
                        ? 'Custom Data'
                        : '${_selectedDataPlan} Data Plan',
                    style: context.bodySmall?.copyWith(
                      color: context.textHint,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        actions: [
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                Navigator.pop(context); // Close dialog
                Navigator.pop(context); // Go back to home
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