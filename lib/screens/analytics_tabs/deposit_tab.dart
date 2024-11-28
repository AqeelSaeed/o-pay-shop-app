import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:zamapay_shop_app/l10n/locale_keys.g.dart';
import 'package:zamapay_shop_app/models/dashboard/transaction_history_model.dart';
import 'package:zamapay_shop_app/screens/dashboard/widgets/transaction_widget.dart';
import 'package:zamapay_shop_app/styles/styles.dart';
import 'package:zamapay_shop_app/utils/assets_constants.dart';
import 'package:zamapay_shop_app/utils/colors.dart';
import 'package:zamapay_shop_app/utils/lable_keys.dart';
import 'package:zamapay_shop_app/utils/utils.dart';

class DepositTab extends StatefulWidget {
  const DepositTab({super.key});

  @override
  State<DepositTab> createState() => _DepositTabState();
}

class _DepositTabState extends State<DepositTab> {
  late List<ChartData> data;
  late TooltipBehavior _tooltip;
  bool isBalanceHidden = true;
  String selected = 'Week';

  List<TransactionHistoryModel> modelList = [
    TransactionHistoryModel(
        Assets.userOne, 'Emma Watson', '(+221)7748577558', 24200, depositKey),
    TransactionHistoryModel(
        Assets.userTwo, 'Ellie Golden', '(+221)7748577558', 25000, withdrawKey),
    TransactionHistoryModel(
        Assets.userThree, 'Vin Deisel', '(+221)7748577558', 64000, transferKey),
    TransactionHistoryModel(
        Assets.userFour, 'Gallgadet', '(+221)7748577558', 56000, depositKey),
    TransactionHistoryModel(
        Assets.userOne, 'Jenifer', '(+221)7748577558', 32500, withdrawKey),
  ];

  String? selectedGender;

  @override
  void initState() {
    data = [
      ChartData('Mon', 12),
      ChartData('Tue', 15),
      ChartData('Wed', 30),
      ChartData('Thu', 6.4),
      ChartData('Fri', 4),
      ChartData('Sat', 5),
      ChartData('Sun', 2),
    ];
    _tooltip = TooltipBehavior(enable: false);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            height: 240,
            width: double.infinity,
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 25),
            decoration: BoxDecoration(
                color: Theme.of(context).brightness == Brightness.dark
                    ? const Color(0xff342B26)
                    : primaryLightColor,
                borderRadius: BorderRadius.circular(20)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                    padding: const EdgeInsets.only(
                        top: 18.0, left: 16.0, bottom: 20.0, right: 16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          flex: 2,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                Utils.getTranslatedLabel(
                                    context, totalAssetValueKey),
                                style: Styles.regularText.copyWith(
                                    fontSize: 12,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w400),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Flexible(
                                    child: FittedBox(
                                      fit: BoxFit.scaleDown,
                                      child: Text(
                                        isBalanceHidden
                                            ? '●●●●●●●●'
                                            : '348722230.22',
                                        style: Styles.regularText.copyWith(
                                            color: Colors.white,
                                            fontSize: isBalanceHidden ? 15 : 28,
                                            fontWeight: FontWeight.w700),
                                        overflow: TextOverflow
                                            .ellipsis, // Handle overflow
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 10),
                                  InkWell(
                                    onTap: () => setState(() =>
                                        isBalanceHidden = !isBalanceHidden),
                                    child: Icon(
                                      isBalanceHidden
                                          ? Icons.visibility
                                          : Icons.visibility_off,
                                      color: Colors.white,
                                      size: 25,
                                    ),
                                  ),
                                  const SizedBox(width: 10),
                                ],
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          flex: 1,
                          child: Container(
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(5),
                            ),
                            width: 90,
                            height: 36,
                            child: DropdownButton<String>(
                              isDense: false,
                              value: selected,
                              dropdownColor: Colors.white,
                              icon: const Icon(
                                Icons.keyboard_arrow_down,
                                color: primaryColor,
                              ),
                              underline:
                                  const SizedBox.shrink(), // Removes underline
                              items: [
                                DropdownMenuItem(
                                  value: LocaleKeys.week.tr(),
                                  child: Text(
                                    LocaleKeys.week.tr(),
                                    style: Styles.regularText
                                        .copyWith(color: primaryColor),
                                  ),
                                ),
                                DropdownMenuItem(
                                  value: LocaleKeys.month.tr(),
                                  child: Text(
                                    LocaleKeys.month.tr(),
                                    style: Styles.regularText
                                        .copyWith(color: primaryColor),
                                  ),
                                ),
                              ],
                              onChanged: (value) {
                                setState(() {
                                  selected = value ?? '';
                                });
                              },
                            ),
                          ),
                        ),
                      ],
                    )),
                SizedBox(
                  height: 140,
                  width: double.infinity,
                  child: SfCartesianChart(
                      primaryXAxis: CategoryAxis(
                        axisLine: const AxisLine(width: 0),
                        majorTickLines: const MajorTickLines(size: 0),
                        majorGridLines: const MajorGridLines(
                          width: 0,
                        ),
                        axisLabelFormatter: (AxisLabelRenderDetails details) {
                          String label = details.text;
                          List<String> words = label.split(' ');
                          String firstLetters = words
                              .map((word) => word.isNotEmpty ? word[0] : '')
                              .join();
                          return ChartAxisLabel(
                              firstLetters,
                              Styles.regularText.copyWith(
                                fontSize: 15,
                                fontWeight: FontWeight.w500,
                                color: Colors.white,
                              ));
                        },
                      ),
                      primaryYAxis: const NumericAxis(
                        isVisible: true,
                        labelsExtent: 0,
                        majorTickLines: MajorTickLines(size: 0),
                        axisLine: AxisLine(width: 0),
                        majorGridLines: MajorGridLines(
                          width: 0.6, // Line thickness
                          dashArray: [
                            6,
                            6
                          ], // Creates dashed lines: [5, 5] means 5 pixels line, 5 pixels space
                          color: Colors.grey, // Color of the dashed lines
                        ),
                      ),
                      enableSideBySideSeriesPlacement: true,
                      plotAreaBorderWidth: 0,
                      tooltipBehavior: _tooltip,
                      zoomPanBehavior: ZoomPanBehavior(
                        enablePanning: true, // Enables horizontal scrolling
                        zoomMode: ZoomMode.x, // Only scroll horizontally
                        maximumZoomLevel: 0.5, // Adjust as needed
                      ),
                      series: <CartesianSeries<ChartData, String>>[
                        ColumnSeries<ChartData, String>(
                            dataSource: data,
                            xValueMapper: (ChartData data, _) => data.x,
                            yValueMapper: (ChartData data, _) => data.y,
                            name: 'Gold',
                            spacing: 0.3,
                            color: primaryLightColor),
                        ColumnSeries<ChartData, String>(
                            dataSource: data,
                            spacing: 0.3,
                            xValueMapper: (ChartData data, _) => data.x,
                            yValueMapper: (ChartData data, _) => data.y,
                            name: 'Gold',
                            color: Colors.white),
                      ]),
                ),
              ],
            ),
          ),
          Padding(
            padding:
                const EdgeInsets.only(left: 16.0, right: 16.0, bottom: 25.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  Utils.getTranslatedLabel(context, transactionsKey),
                  style: Styles.regularMediumBlackStyle(context).copyWith(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  Utils.getTranslatedLabel(context, seeAllKey),
                  style: Styles.regularTextTheme(context).copyWith(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: modelList.length,
                itemBuilder: (context, index) {
                  var model = modelList[index];
                  return TransactionWidget(
                    model: model,
                  );
                }),
          ),
        ],
      ),
    );
  }
}

class ChartData {
  ChartData(this.x, this.y);

  final String x;
  final double y;
}
