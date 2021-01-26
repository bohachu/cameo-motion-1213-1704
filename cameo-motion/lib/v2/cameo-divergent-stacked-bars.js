// cameo-divergent-stacked-bars.js
import { CameoAmElement, define } from "/cameo-motion/lib/v2/cameo-am-element.js";
class CameoDivergentStackedBars extends CameoAmElement {
  parse_ary_chart_data(ary_data, flo_cutoff) {
    let ary_chart_data = [];
    for (let i = 0; i < ary_data[0].length; i++) {
      let dic_data = {};
      let flo_value = parseFloat(ary_data[1][i]);
      dic_data["category"] = ary_data[0][i];
      dic_data["negative1"] = 0;
      dic_data["negative2"] = 0;
      dic_data["positive1"] = 0;
      dic_data["positive2"] = 0;
      if (flo_value < -flo_cutoff) {
        dic_data["negative1"] = flo_value;
      }
      if (flo_value >= -flo_cutoff && flo_value < 0) {
        dic_data["negative2"] = flo_value;
      }
      if (flo_value > 0 && flo_value <= flo_cutoff) {
        dic_data["positive1"] = flo_value;
      }
      if (flo_value > flo_cutoff) {
        dic_data["positive2"] = flo_value;
      }
      ary_chart_data.push(dic_data);
    }
    return ary_chart_data;
  }
  async chart_render() {
    var chart = am4core.create(this.str_random_id, am4charts.XYChart);
    let [ary_data, dic_meta] = await this.fetch_data_meta();
    this.set_theme_height_menu_watermark_title(chart, dic_meta);

    const ary_chart_data = this.parse_ary_chart_data(ary_data, dic_meta["分界數值"]);
    chart.paddingRight = 65;
    chart.data = ary_chart_data;
    // Create axes
    var categoryAxis = chart.yAxes.push(new am4charts.CategoryAxis());
    categoryAxis.dataFields.category = "category";
    categoryAxis.renderer.grid.template.location = 0;
    categoryAxis.renderer.inversed = true;
    categoryAxis.renderer.minGridDistance = 20;
    categoryAxis.renderer.axisFills.template.disabled = false;
    categoryAxis.renderer.axisFills.template.fillOpacity = 0.05;
    categoryAxis.renderer.labels.template.fontSize = 12;

    var valueAxis = chart.xAxes.push(new am4charts.ValueAxis());
    valueAxis.min = parseFloat(dic_meta["X軸顯示最小值"]);
    valueAxis.max = parseFloat(dic_meta["X軸顯示最大值"]);
    valueAxis.renderer.minGridDistance = 50;
    valueAxis.renderer.ticks.template.length = 5;
    valueAxis.renderer.ticks.template.disabled = false;
    valueAxis.renderer.ticks.template.strokeOpacity = 0.4;
    valueAxis.renderer.labels.template.adapter.add("text", function (text) {
      return text + "%";
    });
    valueAxis.renderer.labels.template.fontSize = 12;

    // Legend
    chart.legend = new am4charts.Legend();
    chart.legend.position = "bottom";
    chart.legend.fontSize = "12px";
    chart.legend.useDefaultMarker = true;
    var marker = chart.legend.markers.template.children.getIndex(0);
    // marker.cornerRadius(14, 14, 14, 14);
    marker.width = 18;
    marker.height = 18;

    // Use only absolute numbers
    chart.numberFormatter.numberFormat = "#.#s";

    // Create series
    function createSeries(field, name, color) {
      var series = chart.series.push(new am4charts.ColumnSeries());
      series.dataFields.valueX = field;
      series.dataFields.categoryY = "category";
      series.stacked = true;
      series.name = name;
      series.stroke = color;
      series.fill = color;
      var label = series.bullets.push(new am4charts.LabelBullet());
      label.label.text = "{valueX}%";
      label.label.fill = am4core.color("#fff");
      label.label.strokeWidth = 0;
      label.label.truncate = false;
      label.label.hideOversized = true;
      label.locationX = 0.5;
      return series;
    }
    var positiveColor = am4core.color(dic_meta["強烈正值顏色"]);
    var negativeColor = am4core.color(dic_meta["強烈負值顏色"]);
    createSeries("positive2", dic_meta["強烈正值名稱"], positiveColor);
    createSeries("positive1", dic_meta["正值名稱"], positiveColor.lighten(0.5));
    createSeries("negative2", dic_meta["負值名稱"], negativeColor.lighten(0.5));
    createSeries("negative1", dic_meta["強烈負值名稱"], negativeColor);
  }
}
define("cameo-divergent-stacked-bars", CameoDivergentStackedBars);
