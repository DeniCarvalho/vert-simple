import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../../../../core/core.dart';
import '../../../../../internationalization/internationalization.dart';
import '../../../domain/domain.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late bool isLoading = false;

  /// Data atual (ano e mês)
  late DateTime dateCurrent;

  /// Lista de eventos vinda da base
  late List<EventEntity> events = [];

  /// Lista de eventos por mês
  late List<EventEntity> eventsForMonth;

  /// Lista de eventos específica para o componente TableCalander
  late Map<DateTime, List<EventEntity>> eventsForDay = {};

  @override
  void initState() {
    dateCurrent = DateTime.now();
    isLoading = true;
    _getEvents();
    super.initState();
  }

  _getEvents() async {
    try {
      events = [];
      eventsForMonth = [];
      eventsForDay = {};
      var response = await Dio()
          .get('https://623b384646a692bd8450858b.mockapi.io/api/v1/events');
      for (Map map in response.data) {
        EventEntity s = EventEntity.fromJson(map as Map<String, dynamic>);
        events.add(s);
      }
      eventsForMonth = _filterForMonth();
      for (var e in events) {
        if (eventsForDay[e.date] != null) {
          eventsForDay[e.date]!.add(e);
        } else {
          eventsForDay[e.date] = [e];
        }
      }
      setState(() {
        isLoading = false;
      });
    } catch (e) {
      events.clear();
      eventsForMonth.clear();
      eventsForDay = {};
      setState(() {
        isLoading = false;
      });
    }
  }

  List<EventEntity> _getEventsForDay(DateTime date) {
    DateTime transformDate = DateTime(date.year, date.month, date.day);
    return eventsForDay[transformDate] ?? [];
  }

  List<EventEntity> _filterForMonth() {
    return events.where((e) => e.date.month == dateCurrent.month).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColorSystem,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(0),
        child: Container(
          color: AppColors.light,
        ),
      ),
      body: Stack(
        children: [
          if (isLoading)
            _loading()
          else
            SingleChildScrollView(
              padding: const EdgeInsets.only(top: 100, bottom: 50),
              child: ListView(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                children: _filterForMonth()
                    .map((e) => _itemList(
                          title: e.name,
                          description: e.speaker,
                          date: e.date,
                        ))
                    .toList(),
              ),
            ),
          _header(),
          _footer(),
        ],
      ),
    );
  }

  Widget _loading() {
    return const Center(
        child: CircularProgressIndicator(
      color: AppColors.primary,
    ));
  }

  Widget _header() {
    return Align(
      alignment: Alignment.topCenter,
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.light,
          boxShadow: [
            BoxShadow(
              color: AppColors.system.withOpacity(0.2),
              offset: const Offset(0, 5),
              blurRadius: 2,
              spreadRadius: -3,
            ),
          ],
        ),
        child: Theme(
          data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
          child: ExpansionTile(
            backgroundColor: AppColors.light,
            title: Container(
              decoration: const BoxDecoration(color: AppColors.light),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    DateFormat('MMMM').format(dateCurrent).toTitleCase(),
                    style: const TextStyle(
                      color: AppColors.secundary,
                      fontWeight: FontWeight.bold,
                      fontSize: 30,
                    ),
                  ),
                  SizedBox(
                    height: 5.responsiveHeight,
                  ),
                  Text(
                    DateFormat.y().format(dateCurrent),
                    style: TextStyle(
                      color: AppColors.system,
                      fontSize: 15.fontSize,
                    ),
                  ),
                ],
              ),
            ),
            children: <Widget>[
              TableCalendar(
                onPageChanged: (focusDate) {
                  setState(() {
                    dateCurrent = focusDate;
                  });
                },
                eventLoader: _getEventsForDay,
                firstDay: DateTime.utc(2000, 1, 1),
                lastDay: DateTime.utc(2090, 1, 1),
                focusedDay: dateCurrent,
                daysOfWeekVisible: true,
                locale: Localizations.localeOf(context).languageCode,
                headerVisible: true,
                calendarFormat: CalendarFormat.month,
                availableCalendarFormats: const {CalendarFormat.month: 'Mês'},
                selectedDayPredicate: (DateTime date) {
                  return isSameDay(dateCurrent, date) &&
                      !(dateCurrent.day == DateTime.now().day &&
                          dateCurrent.month == DateTime.now().month &&
                          dateCurrent.year == DateTime.now().year);
                },
                onDaySelected: (DateTime _selectedDay, DateTime _focusDay) {
                  setState(() {});
                },
                onFormatChanged: (CalendarFormat format) {},
                headerStyle: const HeaderStyle(
                  titleCentered: true,
                ),
                calendarStyle: CalendarStyle(
                  outsideDaysVisible: false,
                  isTodayHighlighted: true,
                  todayDecoration: const BoxDecoration(
                    color: AppColors.secundary,
                    shape: BoxShape.circle,
                  ),
                  selectedDecoration: BoxDecoration(
                    color: Colors.transparent,
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: AppColors.primary,
                      width: 2.0,
                    ),
                  ),
                  selectedTextStyle: const TextStyle(color: Colors.black),
                  markersMaxCount: 1,
                  defaultDecoration: const BoxDecoration(
                    shape: BoxShape.circle,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _footer() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 30),
      child: Align(
        alignment: Alignment.bottomCenter,
        child: ElevatedButton.icon(
          onPressed: () {},
          icon: const Icon(Icons.add),
          label: Text('newEvent'.i18n(context)),
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(AppColors.primary),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30.0),
                side: const BorderSide(
                  color: Colors.transparent,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _itemList(
      {required String title,
      required String description,
      required DateTime date}) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
      decoration: BoxDecoration(
        color: AppColors.light,
        border: const Border(
          left: BorderSide(
            color: Colors.blueGrey,
            width: 5,
          ),
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.system.withOpacity(0.2),
            offset: const Offset(0, 5),
            blurRadius: 2,
            spreadRadius: -3,
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Column(
                children: [
                  Text(
                    date.day.toZeroLeft(2),
                    style: const TextStyle(
                      fontSize: 22,
                      color: AppColors.systemText,
                    ),
                  ),
                  Text(
                    DateFormat('EEE').format(date).toTitleCase(),
                    style: const TextStyle(
                      color: AppColors.systemText,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              width: 1,
              height: 40,
              color: AppColors.system.withOpacity(0.5),
              margin: const EdgeInsets.symmetric(horizontal: 20),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    color: AppColors.systemText,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                Text(
                  description,
                  style: const TextStyle(
                    color: AppColors.system,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
