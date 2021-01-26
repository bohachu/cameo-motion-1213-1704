// cameo-rank.js
import { CameoAmElement, define } from "/cameo-motion/lib/v2/cameo-am-element.js";
class CameoRank extends CameoAmElement {
  parse_ary_icon_file(dic_meta) {
    let ary_icon_file = [];
    for (let str_key in dic_meta) {
      if (str_key.includes("圖示_")) {
        ary_icon_file.push(dic_meta[str_key]);
      }
    }
    return ary_icon_file;
  }
  parse_ary_chart_data(ary_data, ary_icon_file) {
    let i = 0;
    let ary_chart_data = [];
    for (; i < ary_data[0].length; i++) {
      let dic_data = {};
      dic_data["name"] = ary_data[0][i] + " " + ary_data[1][i];
      // arry 0 和 1 合併在 name
      dic_data["steps"] = ary_data[2][i];
      dic_data["file"] = ary_icon_file[i];
      ary_chart_data.push(dic_data);
    }
    return ary_chart_data;
  }
  parse_ary_chart_data_2col(ary_data, ary_icon_file) {
    let i = 0;
    let ary_chart_data = [];
    for (; i < ary_data[0].length; i++) {
      let dic_data = {};
      dic_data["name"] = ary_data[0][i];
      dic_data["steps"] = ary_data[1][i];
      dic_data["file"] = ary_icon_file[i];
      ary_chart_data.push(dic_data);
    }
    return ary_chart_data;
  }
  async chart_render() {
    var chart = am4core.create(this.str_random_id, am4charts.XYChart);
    let [ary_data, dic_meta] = await this.fetch_data_meta();
    this.set_theme_height_menu_watermark_title(chart, dic_meta);

    const ary_icon_file = this.parse_ary_icon_file(dic_meta);
    let ary_chart_data;
    if (ary_data.length === 2) {
      ary_chart_data = this.parse_ary_chart_data_2col(ary_data, ary_icon_file);
    }
    if (ary_data.length === 3) {
      ary_chart_data = this.parse_ary_chart_data(ary_data, ary_icon_file);
    }
    chart.hiddenState.properties.opacity = 0;
    chart.paddingRight = 70;
    chart.data = ary_chart_data;
    var categoryAxis = chart.yAxes.push(new am4charts.CategoryAxis());
    categoryAxis.dataFields.category = "name";
    categoryAxis.renderer.grid.template.strokeOpacity = 0;
    categoryAxis.renderer.minGridDistance = 10;
    categoryAxis.renderer.labels.template.dx = -30;
    categoryAxis.renderer.minWidth = 130;
    categoryAxis.renderer.tooltip.dx = -30;
    categoryAxis.fontSize = "12px";

    var valueAxis = chart.xAxes.push(new am4charts.ValueAxis());
    valueAxis.renderer.inside = true;
    // valueAxis.renderer.labels.template.fillOpacity = 1;
    // valueAxis.renderer.grid.template.strokeOpacity = 0;
    valueAxis.min = 0;
    valueAxis.cursorTooltipEnabled = false;
    valueAxis.renderer.baseGrid.strokeOpacity = 0;
    valueAxis.renderer.labels.template.dy = 30;
    valueAxis.title.text = dic_meta["X軸標題文字"];
    valueAxis.title.align = "center";
    valueAxis.title.paddingTop = 30;
    valueAxis.fontSize = "12px";

    var series = chart.series.push(new am4charts.ColumnSeries());
    series.dataFields.valueX = "steps";
    series.dataFields.categoryY = "name";
    series.fill = "color";
    series.tooltipText = "{valueX.value}";
    series.tooltip.pointerOrientation = "vertical";
    series.tooltip.dy = -30;
    series.columnsContainer.zIndex = 100;

    var columnTemplate = series.columns.template;
    columnTemplate.height = am4core.percent(50);
    columnTemplate.maxHeight = 35;
    columnTemplate.column.cornerRadius(60, 10, 60, 10);
    columnTemplate.strokeOpacity = 0;

    chart.scrollbarX = new am4core.Scrollbar();
    chart.scrollbarX.align = "center";

    series.heatRules.push({
      target: columnTemplate,
      property: "fill",
      dataField: "valueX",
      max: am4core.color(dic_meta["圖表漸層最深色"]),
      min: am4core.color(dic_meta["圖表漸層最淺色"])
    });
    series.mainContainer.mask = undefined;

    var cursor = new am4charts.XYCursor();
    chart.cursor = cursor;
    cursor.lineX.disabled = true;
    cursor.lineY.disabled = true;
    cursor.behavior = "none";

    var bullet = columnTemplate.createChild(am4charts.CircleBullet);
    bullet.circle.radius = 13;
    bullet.valign = "middle";
    bullet.align = "left";
    bullet.isMeasured = true;
    bullet.interactionsEnabled = false;
    bullet.horizontalCenter = "right";
    bullet.interactionsEnabled = false;

    var hoverState = bullet.states.create("hover");
    var outlineCircle = bullet.createChild(am4core.Circle);
    outlineCircle.adapter.add("radius", function (radius, target) {
      var circleBullet = target.parent;
      return circleBullet.circle.pixelRadius + 3;
    });

    var image = bullet.createChild(am4core.Image);
    image.width = 23;
    image.height = 23;
    image.horizontalCenter = "middle";
    image.verticalCenter = "middle";
    image.propertyFields.href = "file";
    image.adapter.add("mask", function (mask, target) {
      var circleBullet = target.parent;
      return circleBullet.circle;
    });

    var previousBullet;
    chart.cursor.events.on("cursorpositionchanged", function (event) {
      var dataItem = series.tooltipDataItem;

      if (dataItem.column) {
        var bullet = dataItem.column.children.getIndex(1);

        if (previousBullet && previousBullet != bullet) {
          previousBullet.isHover = false;
        }

        if (previousBullet != bullet) {
          var hs = bullet.states.getKey("hover");
          hs.properties.dx = dataItem.column.pixelWidth;
          bullet.isHover = true;

          previousBullet = bullet;
        }
      }
    });
  }
}
define("cameo-rank", CameoRank);
