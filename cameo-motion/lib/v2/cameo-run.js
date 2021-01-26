// cameo-run.js
import { CameoAmElement, define } from "/cameo-motion/lib/v2/cameo-am-element.js";
class CameoRun extends CameoAmElement {
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
    let ary_chart_data = [];
    for (let i = 0; i < ary_data[0].length; i++) {
      let dic_data = {};
      dic_data["name"] = ary_data[0][i];
      dic_data["file"] = ary_icon_file[i];
      dic_data["track"] = i;
      dic_data["value"] = parseFloat(ary_data[1][i]);
      ary_chart_data.push(dic_data);
    }
    return ary_chart_data;
  }
  async chart_render() {
    var chart = am4core.create(this.str_random_id, am4plugins_timeline.CurveChart);
    let [ary_data, dic_meta] = await this.fetch_data_meta();
    this.set_theme_height_menu_watermark_title(chart, dic_meta);

    const ary_icon_file = this.parse_ary_icon_file(dic_meta);
    const ary_chart_data = this.parse_ary_chart_data(ary_data, ary_icon_file);

    var insterfaceColors = new am4core.InterfaceColorSet();
    var lineColor = insterfaceColors.getFor("background");
    chart.curveContainer.padding(50, 50, 50, 50);
    chart.data = ary_chart_data;
    draw_on_browser();

    function draw_on_browser() {
      var categoryAxis = chart.yAxes.push(new am4charts.CategoryAxis());
      categoryAxis.dataFields.category = "name";
      categoryAxis.renderer.minGridDistance = 10;
      categoryAxis.renderer.innerRadius = 10;
      categoryAxis.renderer.radius = 145;
      categoryAxis.renderer.line.stroke = lineColor;
      categoryAxis.renderer.line.strokeWidth = 5;
      categoryAxis.renderer.line.strokeOpacity = 1;

      var labelTemplate = categoryAxis.renderer.labels.template;
      labelTemplate.fill = lineColor;
      labelTemplate.fontWeight = 400;
      labelTemplate.fontSize = 11;

      var gridTemplate = categoryAxis.renderer.grid.template;
      gridTemplate.strokeWidth = 1;
      gridTemplate.strokeOpacity = 1;
      gridTemplate.stroke = lineColor;
      gridTemplate.location = 0;
      gridTemplate.above = true;

      var fillTemplate = categoryAxis.renderer.axisFills.template;
      fillTemplate.disabled = false;
      fillTemplate.fill = am4core.color(dic_meta["操場跑道顏色"]);
      fillTemplate.fillOpacity = 1;

      categoryAxis.fillRule = function (dataItem) {
        dataItem.axisFill.__disabled = false;
        dataItem.axisFill.opacity = 1;
      };

      var valueAxis = chart.xAxes.push(new am4charts.ValueAxis());
      valueAxis.min = parseFloat(dic_meta["操場跑道最小值"]);
      valueAxis.max = parseFloat(dic_meta["操場跑道最大值"]);
      valueAxis.renderer.points = [
        { x: 0, y: -100 },
        { x: 200, y: -100 },
        { x: 200, y: 100 },
        { x: 0, y: 100 },
        {
          x: -200,
          y: 100
        },
        { x: -200, y: -100 },
        { x: 0, y: -100 }
      ];
      valueAxis.renderer.polyspline.tensionX = 0.4;
      valueAxis.renderer.line.strokeOpacity = 0.1;
      valueAxis.renderer.line.strokeWidth = 10;
      valueAxis.renderer.maxLabelPosition = 0.98;
      valueAxis.renderer.minLabelPosition = 0.02;

      // Flag bullet
      var flagRange = valueAxis.axisRanges.create();
      flagRange.value = 0;
      var flagBullet = new am4plugins_bullets.FlagBullet();
      flagBullet.label.text = dic_meta["旗子文字"];
      flagRange.bullet = flagBullet;
      //flagBullet.dy = -145;
      flagBullet.adapter.add("dy", function (dy, target) {
        return -categoryAxis.renderer.radius;
      });

      var valueLabelTemplate = valueAxis.renderer.labels.template;
      valueLabelTemplate.fill = lineColor;
      valueLabelTemplate.fontSize = 10;
      valueLabelTemplate.fontWeight = 400;
      valueLabelTemplate.fillOpacity = 1;
      valueLabelTemplate.horizontalCenter = "right";
      valueLabelTemplate.verticalCenter = "bottom";
      // 跑道上數字的位置
      valueLabelTemplate.padding(0, 15, 0, 0);
      valueLabelTemplate.adapter.add("rotation", function (rotation, target) {
        var value = target.dataItem.value;
        var position = valueAxis.valueToPosition(value);

        var angle = valueAxis.renderer.positionToAngle(position);
        return angle;
      });

      var valueGridTemplate = valueAxis.renderer.grid.template;
      valueGridTemplate.strokeOpacity = 0.3;
      valueGridTemplate.stroke = lineColor;

      // SERIES
      var series = chart.series.push(new am4plugins_timeline.CurveColumnSeries());
      series.dataFields.categoryY = "name";
      series.stroke = lineColor;
      series.fill = lineColor;
      series.dataFields.valueX = "value";
      series.defaultState.transitionDuration = 4000;

      var columnTemplate = series.columns.template;
      columnTemplate.fill = lineColor;
      columnTemplate.strokeOpacity = 0;
      columnTemplate.fillOpacity = 0.3;
      columnTemplate.height = am4core.percent(100);

      var hoverState = columnTemplate.states.create("hover");
      hoverState.properties.fillOpacity = 0.9;

      var bullet = series.bullets.push(new am4charts.CircleBullet());
      bullet.fill = lineColor;

      // LEGEND
      chart.legend = new am4charts.Legend();
      chart.legend.data = chart.data;
      chart.legend.parent = chart.curveContainer;
      chart.legend.width = 350;
      chart.legend.horizontalCenter = "middle";
      chart.legend.verticalCenter = "middle";
      chart.legend.fontSize = 10;

      var markerTemplate = chart.legend.markers.template;
      markerTemplate.width = 20;
      markerTemplate.height = 20;

      chart.legend.itemContainers.template.events.on("over", function (event) {
        series.dataItems.each(function (dataItem) {
          if (dataItem.dataContext == event.target.dataItem.dataContext) {
            dataItem.column.isHover = true;
          } else {
            dataItem.column.isHover = false;
          }
        });
      });

      chart.legend.itemContainers.template.events.on("hit", function (event) {
        series.dataItems.each(function (dataItem) {
          if (dataItem.dataContext == event.target.dataItem.dataContext) {
            if (dataItem.visible) {
              dataItem.hide(1000, 0, 0, ["valueX"]);
            } else {
              dataItem.show(1000, 0, ["valueX"]);
            }
          }
        });
      });

      var rect = markerTemplate.children.getIndex(0);
      rect.cornerRadius(20, 20, 20, 20);

      var as = markerTemplate.states.create("active");
      as.properties.opacity = 0.5;

      var image = markerTemplate.createChild(am4core.Image);
      image.propertyFields.href = "file";
      image.width = 20;
      image.height = 20;
      image.filters.push(new am4core.DesaturateFilter());

      image.events.on("inited", function (event) {
        var image = event.target;
        var parent = image.parent;
        image.mask = parent.children.getIndex(0);
      });
    }
  }
}
define("cameo-run", CameoRun);
