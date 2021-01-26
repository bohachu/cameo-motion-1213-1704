// cameo-line.js
import { CameoAmElement, define } from "/cameo-motion/lib/v2/cameo-am-element.js";
import { csv_to_transpose, csv_to_json, fetch_dic, one_col_ary, fetch_text } from "/cameo-motion/lib/v2/cameo-clean.js";
class CameoLine extends CameoAmElement {
  async chart_render() {
    var chart = am4core.create(this.str_random_id, am4charts.XYChart);
    let [str_data, dic_meta, str_color_line_csv] = await Promise.all([
      fetch_text(this.getAttribute("data")),
      fetch_dic(this.getAttribute("meta")),
      fetch_text(this.getAttribute("color"))
    ]);
    const ary_transpose = csv_to_transpose(str_data);
    const ary_data = csv_to_json(str_data);
    const ary_color = one_col_ary(str_color_line_csv);
    this.set_theme_height_menu_watermark_title(chart, dic_meta);

    chart.data = ary_data;
    var categoryAxis = chart.xAxes.push(new am4charts.CategoryAxis());
    categoryAxis.dataFields.category = ary_transpose[0][0];
    categoryAxis.fontSize = "12px";
    var valueAxis = chart.yAxes.push(new am4charts.ValueAxis());
    valueAxis.renderer.inversed = false;
    valueAxis.title.text = dic_meta["左側 Y 軸標題"];
    valueAxis.renderer.minLabelPosition = 0.01;
    valueAxis.fontSize = "12px";
    var tooltipText = "{name}";

    let ary_series = [];
    let str_x軸名字 = ary_transpose[0][0]; //Years
    chart.cursor = new am4charts.XYCursor();
    chart.cursor.behavior = "zoomY";
    for (let i = 0; i < ary_transpose.length; i++) {
      let str_y軸名字 = ary_transpose[i][0];
      ary_series.push(chart.series.push(new am4charts.LineSeries()));
      ary_series[i].dataFields.valueY = str_y軸名字;
      ary_series[i].dataFields.categoryX = str_x軸名字;
      ary_series[i].name = str_y軸名字;
      ary_series[i].bullets.push(new am4charts.CircleBullet());
      ary_series[i].tooltipText = "{name}";
      ary_series[i].tooltip.fontSize = "10px";
      ary_series[i].legendSettings.valueText = "{valueY}";
      ary_series[i].visible = false;
      ary_series[i].fill = am4core.color(ary_color[i]);
      ary_series[i].stroke = am4core.color(ary_color[i]);
      let hs1 = ary_series[i].segments.template.states.create("hover");
      hs1.properties.strokeWidth = 1;
      ary_series[i].segments.template.strokeWidth = 1;
    }
    chart.series.shift();
    ary_series.shift();
    chart.legend = new am4charts.Legend();
    chart.legend.itemContainers.template.events.on("over", function (event) {
      var segments = event.target.dataItem.dataContext.segments;
      segments.each(function (segment) {
        segment.isHover = true;
      });
    });
    chart.legend.position = "right";
    chart.legend.fontSize = "12px";
    chart.scrollbarX = new am4core.Scrollbar();
    chart.scrollbarX.align = "center";
    chart.legend.itemContainers.template.events.on("out", function (event) {
      var segments = event.target.dataItem.dataContext.segments;
      segments.each(function (segment) {
        segment.isHover = false;
      });
    });
  }
}
define("cameo-line", CameoLine);
