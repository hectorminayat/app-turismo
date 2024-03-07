import 'package:discoverrd/app/config/theme_config.dart';
import 'package:discoverrd/app/controllers/home_controller.dart';
import 'package:discoverrd/app/pages/agency/agency_tour_list_page.dart';
import 'package:discoverrd/app/pages/home/pages/discover_page.dart';
import 'package:discoverrd/app/pages/home/pages/favorite_page.dart';
import 'package:discoverrd/app/pages/home/pages/profile_page.dart';
import 'package:discoverrd/app/pages/home/pages/trips_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomePage extends StatelessWidget {
  HomePage();

  BottomNavigationBarItem _buildBottomItem(IconData icon, String label) {
    return BottomNavigationBarItem(icon: Icon(icon), label: label);
  }

  List<BottomNavigationBarItem> _bottomCustomerItems() {
    return [
      _buildBottomItem(Icons.explore, 'Explorar'),
      _buildBottomItem(Icons.favorite, 'Favoritos'),
      _buildBottomItem(Icons.shopping_bag, 'Mis viajes'),
      _buildBottomItem(Icons.person, 'Mi cuenta')
    ];
  }

  List<BottomNavigationBarItem> _bottomAgencyItems() {
    return [
      _buildBottomItem(Icons.list_alt, 'Mis actividades'),
      _buildBottomItem(Icons.add_circle, 'Nueva actividad'),
      _buildBottomItem(Icons.inbox, 'Inbox'),
      _buildBottomItem(Icons.person, 'Mi cuenta')
    ];
  }

  void _onItemTapped(int index, HomeController controller) {
    controller.setCurrentPage(index);
  }

  Widget _bottomNavigationBar(BuildContext context, HomeController controller) {
    double _iconSize = 32;
    return Container(
      color: Colors.transparent,
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: ClipRRect(
          borderRadius: BorderRadius.all(Radius.circular(32)),
          child: BottomNavigationBar(
              currentIndex: controller.currentPage.value,
              onTap: (index) => _onItemTapped(index, controller),
              backgroundColor: Colors.white,
              type: BottomNavigationBarType.fixed,
              iconSize: _iconSize,
              showSelectedLabels: false,
              showUnselectedLabels: false,
              selectedIconTheme: IconThemeData(
                  color: Theme.of(context).accentColor, size: _iconSize),
              unselectedIconTheme:
                  IconThemeData(color: secundaryColors3, size: _iconSize),
              selectedItemColor: Theme.of(context).accentColor,
              unselectedItemColor: secundaryColors3,
              items: controller.isAgency.value
                  ? _bottomAgencyItems()
                  : _bottomCustomerItems()),
        ),
      ),
    );
  }

  List<Widget> _pagesCustomer(HomeController controller) {
    return [
      DiscoverPage(controller: controller),
      FavoritePage(controller: controller),
      TripsPage(controller: controller),
      ProfilePage(
        controller: controller,
        type: "1",
      )
    ];
  }

  List<Widget> _pagesAgency(HomeController controller) {
    return [
      AgencyTourListPage(),
      Container(),
      Container(),
      ProfilePage(
        controller: controller,
        type: "2",
      )
    ];
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
        builder: (_) => Scaffold(
              backgroundColor: Color(0xFFf2f3f7),
              body: Obx(() => IndexedStack(
                    index: _.currentPage.value,
                    children:
                        _.isAgency.value ? _pagesAgency(_) : _pagesCustomer(_),
                  )),
              bottomNavigationBar: Obx(() => _bottomNavigationBar(context, _)),
            ));
  }
}
