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
      body: Column(
        children: [
          // Number Display
          if (!_isSearching) ...[
            Container(
              padding: EdgeInsets.all(context.spacingXL),
              child: Column(
                children: [
                  Text(
                    'Enter Number',
                    style: context.bodySmall?.copyWith(
                      color: context.mediumGray,
                    ),
                  ),
                  SizedBox(height: context.spacingSM),
                  Text(
                    _dialedNumber.isEmpty ? '---' : _dialedNumber,
                    style: context.displaySmall?.copyWith(
                      fontSize: 32,
                      letterSpacing: 2,
                      color: context.deepNavy,
                    ),
                  ),
                ],
              ),
            ),
          ],

          // Search Results or Call Type Tabs
          if (_isSearching)
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
            )
          else ...[
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
            SizedBox(height: context.spacingMD),

            // Call Type Details
            Padding(
              padding: EdgeInsets.symmetric(horizontal: context.spacingLG),
              child: Row(
                children: [
                  Icon(
                    _selectedCallType == CallType.appToApp
                        ? Icons.check_circle
                        : Icons.radio_button_unchecked,
                    size: 16,
                    color: _selectedCallType == CallType.appToApp
                        ? context.primaryGreen
                        : context.mediumGray,
                  ),
                  SizedBox(width: context.spacingXS),
                  Expanded(
                    child: Text(
                      'Free call to other app users',
                      style: context.bodySmall?.copyWith(
                        color: _selectedCallType == CallType.appToApp
                            ? context.primaryGreen
                            : context.mediumGray,
                      ),
                    ),
                  ),
                  Text(
                    'Free',
                    style: context.bodySmall?.copyWith(
                      color: context.success,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
            if (_selectedCallType == CallType.appToPhone) ...[
              SizedBox(height: context.spacingSM),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: context.spacingLG),
                child: Row(
                  children: [
                    Icon(
                      Icons.info_outline,
                      size: 16,
                      color: context.actionAmber,
                    ),
                    SizedBox(width: context.spacingXS),
                    Expanded(
                      child: Text(
                        'Rate: ₦25/min to Nigerian numbers',
                        style: context.bodySmall?.copyWith(
                          color: context.actionAmber,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],

            // T9 Keypad
            Expanded(
              child: Container(
                margin: EdgeInsets.all(context.spacingLG),
                padding: EdgeInsets.all(context.spacingMD),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(context.radiusXL),
                  boxShadow: context.shadowMD,
                ),
                child: Column(
                  children: [
                    Expanded(
                      child: GridView.count(
                        crossAxisCount: 3,
                        childAspectRatio: 1.2,
                        physics: const NeverScrollableScrollPhysics(),
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
                      ),
                    ),

                    // Bottom Row with Call and Delete
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        // Call Type Selector (simplified for UI)
                        GestureDetector(
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
                          child: Container(
                            width: 60,
                            height: 60,
                            decoration: BoxDecoration(
                              color: context.lightGray.withOpacity(0.3),
                              shape: BoxShape.circle,
                            ),
                            child: Icon(
                              _selectedCallType == CallType.appToApp
                                  ? Icons.wifi
                                  : Icons.phone,
                              color: _selectedCallType == CallType.appToApp
                                  ? context.primaryGreen
                                  : context.actionAmber,
                              size: 24,
                            ),
                          ),
                        ),

                        // Call Button
                        GestureDetector(
                          onTap: _startCall,
                          child: Container(
                            width: 70,
                            height: 70,
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
                              size: 30,
                            ),
                          ),
                        ),

                        // Delete Button
                        GestureDetector(
                          onTap: _onDeletePressed,
                          child: Container(
                            width: 60,
                            height: 60,
                            decoration: BoxDecoration(
                              color: context.lightGray.withOpacity(0.3),
                              shape: BoxShape.circle,
                            ),
                            child: Icon(
                              Icons.backspace_outlined,
                              color: context.darkGray,
                              size: 24,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: context.spacingSM),
                  ],
                ),
              ),
            ),
          ],
        ],
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
          margin: EdgeInsets.all(context.spacingXS),
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
                    fontSize: 28,
                    fontWeight: FontWeight.w500,
                    color: context.deepNavy,
                  ),
                ),
                if (sub.isNotEmpty)
                  Text(
                    sub,
                    style: context.labelSmall?.copyWith(
                      color: context.mediumGray,
                      fontSize: 10,
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