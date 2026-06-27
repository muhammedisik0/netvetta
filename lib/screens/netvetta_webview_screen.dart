import 'dart:async';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../constants/color_constants.dart';
import '../constants/enum_constants.dart';
import '../constants/netvetta_api_constants.dart';
import '../constants/netvetta_web_constants.dart';
import '../constants/route_constants.dart';
import '../models/user_model.dart';
import '../services/storage_service.dart';
import '../utils/url_extensions.dart';
import '../utils/webview_utils.dart';
import '../widgets/account_navigation_bar_item_group.dart';
import '../widgets/custom_bottom_navigation_bar_item.dart';
import '../widgets/internet_connectivity_widget.dart';
import '../widgets/loading_widget.dart';

class NetvettaWebViewScreen extends StatefulWidget {
  final Uri initialUrl;
  final User user;

  const NetvettaWebViewScreen(
      {super.key, required this.initialUrl, required this.user});

  @override
  State<NetvettaWebViewScreen> createState() => _NetvettaWebViewScreenState();
}

class _NetvettaWebViewScreenState extends State<NetvettaWebViewScreen> {
  late final WebViewController _webviewController;
  late User _user;

  WebViewNavigationTab _currentNavigationTab = WebViewNavigationTab.home;
  bool _showAccountNavigationBarItemGroup = false;
  bool _hasInternetConnection = true;
  bool _isLoading = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: InternetConnectivityWidget(
          onChanged: (value) {
            _hasInternetConnection = value;
            _checkRequest(_currentNavigationTab);
          },
          child: _isLoading
              ? Center(child: const LoadingWidget())
              : WebViewWidget(controller: _webviewController),
        ),
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.symmetric(vertical: 10),
        decoration: const BoxDecoration(
          color: ColorConstants.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
          boxShadow: [
            BoxShadow(
              color: Colors.grey,
              blurRadius: 10,
              offset: Offset(0, -2),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            CustomBottomNavigationBarItem(
              onTap: () => _onNavigationBarTap(WebViewNavigationTab.home),
              icon: FontAwesomeIcons.house,
              text: 'Ana Sayfa',
              isSelected: _currentNavigationTab == WebViewNavigationTab.home,
            ),
            CustomBottomNavigationBarItem(
              onTap: () => _onNavigationBarTap(WebViewNavigationTab.basket),
              icon: FontAwesomeIcons.basketShopping,
              text: 'Sepet',
              isSelected: _currentNavigationTab == WebViewNavigationTab.basket,
            ),
            Visibility(
              visible: !_showAccountNavigationBarItemGroup,
              replacement: AccountNavigationBarItemGroup(
                onPersonalPressed: () =>
                    _onNavigationBarTap(WebViewNavigationTab.account),
                onLogoutPressed: _onLogOutPressed,
                isSelected:
                    _currentNavigationTab == WebViewNavigationTab.account,
              ),
              child: CustomBottomNavigationBarItem(
                onTap: () =>
                    setState(() => _showAccountNavigationBarItemGroup = true),
                icon: FontAwesomeIcons.solidCircleUser,
                text: 'Hesap',
                isSelected:
                    _currentNavigationTab == WebViewNavigationTab.account,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _user = widget.user;

    _webviewController = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(Colors.black)
      ..setNavigationDelegate(NavigationDelegate(
        onNavigationRequest: _onNavigationRequest,
        onPageStarted: _onPageStarted,
        onPageFinished: _onPageFinished,
      ))
      ..loadRequest(widget.initialUrl);
  }

  void _checkRequest(WebViewNavigationTab tab) {
    switch (tab) {
      case WebViewNavigationTab.home:
        _webviewController.loadRequest(NetvettaWebConstants.home.uri);
        break;
      case WebViewNavigationTab.basket:
        _webviewController.loadRequest(_user.basketUrl.uri);
        break;
      case WebViewNavigationTab.account:
        _webviewController.loadRequest(_user.accountUrl.uri);
        break;
    }
  }

  Future<void> _onLogOutPressed() async {
    if (_hasInternetConnection) {
      _webviewController.loadRequest(NetvettaApiConstants.logoutUrl.uri);
      StorageService.user = null;
      Navigator.pushReplacementNamed(context, RouteConstants.login);
    } else {
      _onNavigationBarTap(WebViewNavigationTab.account);
    }
  }

  void _onNavigationBarTap(WebViewNavigationTab tab) {
    _showAccountNavigationBarItemGroup = false;
    setState(() => _currentNavigationTab = tab);
    _checkRequest(_currentNavigationTab);
    if (_isLoading) setState(() => _isLoading = false);
  }

  FutureOr<NavigationDecision> _onNavigationRequest(
      NavigationRequest request) async {
    if (request.url == NetvettaWebConstants.home) {
      setState(() => _currentNavigationTab = WebViewNavigationTab.home);
    } else if (request.url == _user.basketUrl) {
      setState(() => _currentNavigationTab = WebViewNavigationTab.basket);
    } else if (request.url == _user.accountUrl) {
      setState(() => _currentNavigationTab = WebViewNavigationTab.account);
    }

    return NavigationDecision.navigate;
  }

  void _onPageFinished(String url) async {
    if (url == NetvettaWebConstants.login) {
      final javascript = buildLoginJavaScript(_user);
      _webviewController.runJavaScript(javascript);
    }

    if (url.contains(NetvettaWebConstants.home)) {
      if (_isLoading) {
        await Future.delayed(Durations.extralong4);
        setState(() => _isLoading = false);
      }
    }
  }

  void _onPageStarted(String url) {
    if (_user.id == -1 && url.contains(NetvettaWebConstants.home)) {
      final userId = extractUserIdFromUrl(url);
      _user = _user.copyWith(id: userId);
      StorageService.user = _user;
    }
  }
}
