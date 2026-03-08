import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pavi/theme/generalTheme.dart';
import '../../model/messageModel.dart';
import 'call_screen.dart';

class DialerScreen extends StatefulWidget {
  const DialerScreen({super.key});

  @override
  State<DialerScreen> createState() => _DialerScreenState();
}

class _DialerScreenState extends State<DialerScreen> with SingleTickerProviderStateMixin {
  final TextEditingController _numberController = TextEditingController();
  final FocusNode _searchFocusNode = FocusNode();
  late TabController _tabController;
  // Add these variables to your state class
  Timer? _deleteTimer;
  bool _isLongPressing = false;

  bool _isSearching = false;
  String _dialedNumber = '';
  CallType _selectedCallType = CallType.appToApp;

  // Sample contacts for search
  final List<Contact> _contacts = [
    Contact(name: 'Mum', number: '+234 802 345 6789', type: 'Mobile'),
    Contact(name: 'Dad', number: '+234 803 456 7890', type: 'Mobile'),
    Contact(name: 'John Smith', number: '+234 805 678 9012', type: 'Mobile'),
    Contact(name: 'Sarah Johnson', number: '+234 806 789 0123', type: 'Mobile'),
    Contact(name: 'Business Client', number: '+234 807 890 1234', type: 'Work'),
    Contact(name: 'Dr. Ahmed', number: '+234 808 901 2345', type: 'Mobile'),
  ];

  List<Contact> _searchResults = [];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _searchResults = _contacts;
  }

  @override
  void dispose() {
    _numberController.dispose();
    _searchFocusNode.dispose();
    _tabController.dispose();
    super.dispose();
  }

  void _onKeyPressed(String value) {
    setState(() {
      _dialedNumber += value;
      _numberController.text = _dialedNumber;
      _numberController.selection = TextSelection.fromPosition(
        TextPosition(offset: _dialedNumber.length),
      );
    });
  }

  void _startContinuousDelete() {
    _isLongPressing = true;

    // Immediate first deletion
    _onDeletePressed();

    // Then continue deleting every 100ms while holding
    _deleteTimer = Timer.periodic(const Duration(milliseconds: 100), (timer) {
      if (_isLongPressing && mounted) {
        _onDeletePressed();
      } else {
        timer.cancel();
      }
    });
  }

  void _stopContinuousDelete() {
    _isLongPressing = false;
    _deleteTimer?.cancel();
    _deleteTimer = null;
  }

  void _onDeletePressed() {
    if (_dialedNumber.isNotEmpty) {
      setState(() {
        _dialedNumber = _dialedNumber.substring(0, _dialedNumber.length - 1);
        _numberController.text = _dialedNumber;
        _numberController.selection = TextSelection.fromPosition(
          TextPosition(offset: _dialedNumber.length),
        );
      });
    }
  }

  void _onSearchChanged(String query) {
    setState(() {
      if (query.isEmpty) {
        _searchResults = _contacts;
      } else {
        _searchResults = _contacts.where((contact) {
          return contact.name.toLowerCase().contains(query.toLowerCase()) ||
              contact.number.contains(query);
        }).toList();
      }
    });
  }

  void _startCall() {
    if (_dialedNumber.isNotEmpty) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => CallScreen(
            contactName: _dialedNumber,
            phoneNumber: _dialedNumber,
            callType: _selectedCallType,
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.offWhite,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        elevation: 0,
        title: _isSearching
            ? TextField(
          controller: _numberController,
          focusNode: _searchFocusNode,
          autofocus: true,
          style: context.bodyLarge,
          decoration: InputDecoration(
            hintText: 'Search contacts or enter number',
            hintStyle: context.bodyMedium?.copyWith(
              color: context.mediumGray,
            ),
            border: InputBorder.none,
          ),
          onChanged: _onSearchChanged,
        )
            : Text(
          'Dialer',
          style: context.titleLarge?.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(
              _isSearching ? Icons.close : Icons.search,
              color: context.deepNavy,
            ),
            onPressed: () {
              setState(() {
                _isSearching = !_isSearching;
                if (!_isSearching) {
                  _numberController.clear();
                  _dialedNumber = '';
                  _searchResults = _contacts;
                  FocusScope.of(context).unfocus();
                } else {
                  _searchFocusNode.requestFocus();
                }
              });
            },
          ),
        ],
      ),
      body: _isSearching ? _buildSearchView() : _buildDialerView(),
    );
  }

  Widget _buildSearchView() {
    return Column(
      children: [
        Expanded(
          child: ListView.builder(
            padding: EdgeInsets.all(context.spacingMD),
            itemCount: _searchResults.length,
            itemBuilder: (context, index) {
              final contact = _searchResults[index];
              return ListTile(
                leading: Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    gradient: context.primaryGradient,
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: Text(
                      contact.name[0],
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
                title: Text(
                  contact.name,
                  style: context.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                subtitle: Text(
                  contact.number,
                  style: context.bodySmall?.copyWith(
                    color: context.mediumGray,
                  ),
                ),
                trailing: Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: context.spacingSM,
                    vertical: context.spacingXXS,
                  ),
                  decoration: BoxDecoration(
                    color: context.primaryGreen.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(context.radiusSM),
                  ),
                  child: Text(
                    contact.type,
                    style: context.labelSmall?.copyWith(
                      color: context.primaryGreen,
                    ),
                  ),
                ),
                onTap: () {
                  setState(() {
                    _dialedNumber = contact.number.replaceAll(' ', '');
                    _numberController.text = _dialedNumber;
                    _isSearching = false;
                  });
                },
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildDialerView() {
    return Column(
      children: [
        // Number Display - Single line with horizontal scrolling
        Container(
          padding: EdgeInsets.symmetric(
            horizontal: context.spacingXL,
            vertical: context.spacingMD,
          ),
          child: Column(
            children: [
              Text(
                'Enter Number',
                style: context.bodySmall?.copyWith(
                  color: context.mediumGray,
                ),
              ),
              SizedBox(height: context.spacingXS),
              // Single line with horizontal scrolling
              Container(
                height: 50,
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  reverse: true, // Start from the right (newest digits)
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: _dialedNumber.isEmpty
                        ? [
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 8),
                        child: Text(
                          '---',
                          style: context.displaySmall?.copyWith(
                            fontSize: 32,
                            letterSpacing: 2,
                            color: context.deepNavy,
                          ),
                        ),
                      ),
                    ]
                        : _dialedNumber.split('').map((digit) {
                      return Container(
                        padding: EdgeInsets.symmetric(horizontal: 2),
                        child: Text(
                          digit,
                          style: context.displaySmall?.copyWith(
                            fontSize: 32,
                            letterSpacing: 2,
                            color: context.deepNavy,
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ),
            ],
          ),
        ),

        // Call Type Tabs
        Container(
          margin: EdgeInsets.symmetric(horizontal: context.spacingLG),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(context.radiusLG),
            boxShadow: context.shadowSM,
          ),
          child: TabBar(
            controller: _tabController,
            indicator: BoxDecoration(
              borderRadius: BorderRadius.circular(context.radiusLG),
              color: context.primaryGreen.withOpacity(0.1),
            ),
            labelColor: context.primaryGreen,
            unselectedLabelColor: context.mediumGray,
            tabs: const [
              Tab(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.wifi, size: 18),
                    SizedBox(width: 4),
                    Text('App-to-App'),
                  ],
                ),
              ),
              Tab(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.phone, size: 18),
                    SizedBox(width: 4),
                    Text('App-to-Phone'),
                  ],
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: context.spacingSM),

        // Call Type Details - More compact
        Padding(
          padding: EdgeInsets.symmetric(horizontal: context.spacingLG),
          child: Row(
            children: [
              Icon(
                _selectedCallType == CallType.appToApp
                    ? Icons.check_circle
                    : Icons.radio_button_unchecked,
                size: 14,
                color: _selectedCallType == CallType.appToApp
                    ? context.primaryGreen
                    : context.mediumGray,
              ),
              SizedBox(width: context.spacingXS),
              Expanded(
                child: Text(
                  'Free call to other app users',
                  style: context.bodySmall?.copyWith(
                    fontSize: 12,
                    color: _selectedCallType == CallType.appToApp
                        ? context.primaryGreen
                        : context.mediumGray,
                  ),
                ),
              ),
              Text(
                'Free',
                style: context.bodySmall?.copyWith(
                  fontSize: 12,
                  color: context.success,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
        if (_selectedCallType == CallType.appToPhone) ...[
          SizedBox(height: context.spacingXS),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: context.spacingLG),
            child: Row(
              children: [
                Icon(
                  Icons.info_outline,
                  size: 14,
                  color: context.actionAmber,
                ),
                SizedBox(width: context.spacingXS),
                Expanded(
                  child: Text(
                    'Rate: ₦25/min',
                    style: context.bodySmall?.copyWith(
                      fontSize: 12,
                      color: context.actionAmber,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],

        // T9 Keypad - Takes remaining space with adjusted aspect ratio
        Expanded(
          child: Container(
            margin: EdgeInsets.fromLTRB(
              context.spacingLG,
              context.spacingSM,
              context.spacingLG,
              context.spacingLG,
            ),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(context.radiusXL),
              boxShadow: context.shadowMD,
            ),
            child: Column(
              children: [
                // Grid takes most of the space - adjusted aspect ratio
                Expanded(
                  child: LayoutBuilder(
                    builder: (context, constraints) {
                      // Calculate aspect ratio to ensure all buttons fit
                      // 4 rows of buttons, each with some spacing
                      double availableHeight = constraints.maxHeight;
                      double buttonHeight = availableHeight / 4.2; // Slightly less than 1/4 for spacing
                      double aspectRatio = constraints.maxWidth / 3 / buttonHeight;

                      return GridView.count(
                        crossAxisCount: 3,
                        childAspectRatio: aspectRatio * 0.9, // Slightly reduce to ensure fit
                        physics: const NeverScrollableScrollPhysics(),
                        padding: EdgeInsets.zero,
                        children: [
                          _buildKeyButton('1', ''),
                          _buildKeyButton('2', 'ABC'),
                          _buildKeyButton('3', 'DEF'),
                          _buildKeyButton('4', 'GHI'),
                          _buildKeyButton('5', 'JKL'),
                          _buildKeyButton('6', 'MNO'),
                          _buildKeyButton('7', 'PQRS'),
                          _buildKeyButton('8', 'TUV'),
                          _buildKeyButton('9', 'WXYZ'),
                          _buildKeyButton('*', ''),
                          _buildKeyButton('0', '+'),
                          _buildKeyButton('#', ''),
                        ],
                      );
                    },
                  ),
                ),

                // Bottom Action Row
                Container(
                  height: 70,
                  padding: EdgeInsets.symmetric(vertical: context.spacingSM),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _buildBottomActionButton(
                        icon: _selectedCallType == CallType.appToApp
                            ? Icons.wifi : Icons.phone,
                        color: _selectedCallType == CallType.appToApp
                            ? context.primaryGreen : context.actionAmber,
                        onTap: () {
                          setState(() {
                            _selectedCallType = _selectedCallType == CallType.appToApp
                                ? CallType.appToPhone
                                : CallType.appToApp;
                            _tabController.animateTo(
                              _selectedCallType == CallType.appToApp ? 0 : 1,
                            );
                          });
                        },
                      ),
                      _buildCallButton(),
                      _buildBottomActionButton(
                        icon: Icons.backspace_outlined,
                        color: context.darkGray,
                        onTap: _onDeletePressed,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildBottomActionButton({
    required IconData icon,
    required Color color,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      onLongPress: _startContinuousDelete, // Start continuous delete
      onLongPressUp: _stopContinuousDelete, // Stop when released
      onLongPressCancel: _stopContinuousDelete,
      child: Container(
        width: 50,
        height: 50,
        decoration: BoxDecoration(
          color: context.lightGray.withOpacity(0.3),
          shape: BoxShape.circle,
        ),
        child: Icon(
          icon,
          color: color,
          size: 22,
        ),
      ),
    );
  }

  Widget _buildCallButton() {
    return GestureDetector(
      onTap: _startCall,
      child: Container(
        width: 60,
        height: 60,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              context.primaryGreen,
              context.primaryGreenDark,
            ],
          ),
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: context.primaryGreen.withOpacity(0.3),
              blurRadius: 8,
              spreadRadius: 2,
            ),
          ],
        ),
        child: const Icon(
          Icons.phone,
          color: Colors.white,
          size: 26,
        ),
      ),
    );
  }

  Widget _buildKeyButton(String main, String sub) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () => _onKeyPressed(main),
        borderRadius: BorderRadius.circular(context.radiusCircular),
        child: Container(
          margin: EdgeInsets.all(2),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
          ),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  main,
                  style: context.titleLarge?.copyWith(
                    fontSize: 20, // Smaller font to ensure fit
                    fontWeight: FontWeight.w500,
                    color: context.deepNavy,
                  ),
                ),
                if (sub.isNotEmpty)
                  Text(
                    sub,
                    style: context.labelSmall?.copyWith(
                      color: context.mediumGray,
                      fontSize: 8, // Smaller font
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

class Contact {
  final String name;
  final String number;
  final String type;

  Contact({
    required this.name,
    required this.number,
    required this.type,
  });
}