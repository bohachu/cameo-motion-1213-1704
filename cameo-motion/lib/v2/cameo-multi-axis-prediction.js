// cameo-multi-axis-prediction.js
import { CameoAmElement, define } from "/cameo-motion/lib/v2/cameo-am-element.js";
class CameoMultiAxisPrediction extends CameoAmElement {
  parse_ary_chart_data(ary_data) {
    let i = 0;
    let ary_chart_data = [];
    let 開關_是否第一個預測值的年增率已經設定過了 = false;
    for (; i < ary_data[0].length; i++) {
      let dic_data = {};
      let str_value = ary_data[3][i];
      dic_data["季度"] = ary_data[0][i];
      dic_data["產值"] = 0;
      dic_data["預測產值"] = 0;
      dic_data["年增率"] = 0;
      dic_data["預測年增率"] = 0;
      dic_data["是否為預測"] = str_value;
      if (str_value === "N") {
        dic_data["產值"] = parseFloat(ary_data[1][i]);
        dic_data["年增率"] = parseFloat(ary_data[2][i]);
        delete dic_data["預測年增率"];
      }
      if (str_value === "Y") {
        dic_data["預測產值"] = parseFloat(ary_data[1][i]);
        dic_data["預測年增率"] = parseFloat(ary_data[2][i]);
        delete dic_data["年增率"];
        if (開關_是否第一個預測值的年增率已經設定過了 == false) {
          開關_是否第一個預測值的年增率已經設定過了 = true;
          dic_data["年增率"] = parseFloat(ary_data[2][i]);
        }
      }
      delete dic_data["是否為預測"];
      ary_chart_data.push(dic_data);
    }
    return ary_chart_data;
  }

  async chart_render() {
    var chart = am4core.create(this.str_random_id, am4charts.XYChart);
    let [ary_data, dic_meta] = await this.fetch_data_meta();
    this.set_theme_height_menu_watermark_title(chart, dic_meta);

    const ary_chart_data = this.parse_ary_chart_data(ary_data);
    chart.paddingRight = 65;
    chart.data = ary_chart_data;
    /* Create axes */
    var categoryAxis = chart.xAxes.push(new am4charts.CategoryAxis());
    categoryAxis.dataFields.category = "季度";
    // categoryAxis.renderer.minGridDistance = 30;
    categoryAxis.fontSize = "12px";

    /* Create value axis */
    var yAxis = chart.yAxes.push(new am4charts.ValueAxis());
    yAxis.min = 0;
    yAxis.title.text = dic_meta["左側 Y 軸標題"];
    // yAxis.title.fontWeight = "bold";
    yAxis.title.fontSize = 12;
    yAxis.renderer.labels.template.fontSize = 12;

    var y2Axis = chart.yAxes.push(new am4charts.ValueAxis());
    y2Axis.title.text = dic_meta["右側 Y 軸標題"];
    y2Axis.title.fontSize = 12;
    // Add percent sign to all numbers
    // y2Axis.numberFormatter.numberFormat = "#.#'%'";
    y2Axis.renderer.labels.template.fontSize = 12;
    //x2Axis.renderer.grid.template.disabled = true;
    y2Axis.renderer.opposite = true;
    y2Axis.syncWithAxis = yAxis;

    /* Create series */
    var columnSeries = chart.series.push(new am4charts.ColumnSeries());
    columnSeries.name = dic_meta["實心軸資料標記"];
    columnSeries.dataFields.valueY = "產值";
    columnSeries.dataFields.categoryX = "季度";
    columnSeries.clustered = false;
    columnSeries.columns.template.tooltipText =
      "[font-size: 12px]" + dic_meta["實心軸資料標記"] + "[/] [font-size: 12px]{valueY}[/]";
    columnSeries.columns.template.stroke = "stroke";
    columnSeries.columns.template.strokeWidth = 1.3;
    columnSeries.columns.template.stroke = am4core.color(dic_meta["軸圖顏色"]);
    columnSeries.tooltip.label.textAlign = "middle";
    columnSeries.fill = am4core.color(dic_meta["軸圖顏色"]);

    var column2Series = chart.series.push(new am4charts.ColumnSeries());
    column2Series.name = dic_meta["虛線軸資料標記"];
    column2Series.dataFields.valueY = "預測產值";
    column2Series.dataFields.categoryX = "季度";
    column2Series.clustered = false;
    column2Series.columns.template.width = am4core.percent(80);
    column2Series.columns.template.tooltipText =
      "[font-size: 12px]" + dic_meta["虛線軸資料標記"] + "[/] [font-size: 12px]{valueY}[/]";
    column2Series.columns.template.fillOpacity = 0.4;
    column2Series.columns.template.stroke = "stroke";
    column2Series.columns.template.strokeWidth = 1.3;
    column2Series.columns.template.stroke = am4core.color(dic_meta["軸圖顏色"]);
    column2Series.columns.template.strokeDasharray = 5.5;
    column2Series.tooltip.label.textAlign = "middle";
    column2Series.fill = am4core.color(dic_meta["軸圖顏色"]).lighten(0.7);

    var lineSeries = chart.series.push(new am4charts.LineSeries());
    lineSeries.name = dic_meta["實線資料標記"];
    lineSeries.dataFields.valueY = "年增率";
    lineSeries.dataFields.categoryX = "季度";
    lineSeries.yAxis = y2Axis;
    lineSeries.stroke = am4core.color(dic_meta["線圖顏色"]);
    lineSeries.strokeWidth = 2.5;
    lineSeries.tooltip.label.textAlign = "middle";

    var line2Series = chart.series.push(new am4charts.LineSeries());
    line2Series.name = dic_meta["虛線資料標記"];
    line2Series.dataFields.valueY = "預測年增率";
    line2Series.dataFields.categoryX = "季度";
    line2Series.yAxis = y2Axis;
    line2Series.stroke = am4core.color(dic_meta["線圖顏色"]);
    line2Series.strokeWidth = 2.5;
    line2Series.strokeDasharray = 5.5;
    line2Series.tooltip.label.textAlign = "middle";

    chart.legend = new am4charts.Legend();
    chart.legend.position = "buttom";
    chart.legend.fontSize = "12px";

    var bullet = lineSeries.bullets.push(new am4charts.Bullet());
    bullet.fill = am4core.color(dic_meta["線圖顏色"]);
    bullet.tooltipText = "[font-size: 12px]" + dic_meta["實線資料標記"] + "[/] [font-size: 12px]{valueY}%[/]";
    var circle = bullet.createChild(am4core.Circle);
    circle.radius = 4;
    circle.fill = am4core.color(dic_meta["線圖顏色"]);
    circle.strokeWidth = 2;

    var bullet2 = line2Series.bullets.push(new am4charts.Bullet());
    bullet2.fill = am4core.color(dic_meta["線圖顏色"]).lighten(0.5);
    bullet2.tooltipText = "[font-size: 12px]" + dic_meta["虛線資料標記"] + "[/] [font-size: 12px]{valueY}%[/]";
    var circle2 = bullet2.createChild(am4core.Circle);
    circle2.radius = 4;
    circle2.fill = am4core.color("#ffffff");
    circle2.strokeWidth = 2;
  }
}
define("cameo-multi-axis-prediction", CameoMultiAxisPrediction);
