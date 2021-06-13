import {CameoAmElement, define} from "/cameo-motion/lib/v2/cameo-am-element.js";

class CameoBubble extends CameoAmElement {
    parse_ary_color(dic_meta) {
        let ary_color = [];
        for (let str_key in dic_meta) {
            if (str_key.includes("泡泡顏色_")) {
                ary_color.push(dic_meta[str_key]);
            }
        }
        return ary_color;
    }

    parse_ary_chart_data(ary_data, ary_color) {
        let ary_chart_data = [];
        for (let i = 0; i < ary_data[0].length; i++) {
            let dic_data = {};
            dic_data["title"] = ary_data[0][i];
            dic_data["id"] = ary_data[1][i];
            dic_data["x"] = parseFloat(ary_data[2][i]);
            dic_data["y"] = parseFloat(ary_data[3][i]);
            dic_data["value"] = parseFloat(ary_data[4][i]);
            dic_data["category"] = ary_data[5][i];
            dic_data["color"] = ary_color[i];
            ary_chart_data.push(dic_data);
        }
        return ary_chart_data;
    }

    async chart_render() {
        var chart = am4core.create(this.str_random_id, am4charts.XYChart);
        let [ary_data, dic_meta] = await this.fetch_data_meta();
        this.set_theme_height_menu_watermark_title(chart, dic_meta);

        const ary_color = this.parse_ary_color(dic_meta);
        const ary_chart_data = this.parse_ary_chart_data(ary_data, ary_color);

        var valueAxisX = chart.xAxes.push(new am4charts.ValueAxis());
        valueAxisX.min = parseFloat(dic_meta["X軸最小值"]);
        valueAxisX.max = parseFloat(dic_meta["X軸最大值"]);
        valueAxisX.renderer.ticks.template.disabled = true;
        valueAxisX.renderer.axisFills.template.disabled = true;

        var valueAxisY = chart.yAxes.push(new am4charts.ValueAxis());
        valueAxisY.min = parseFloat(dic_meta["Y軸最小值"]);
        valueAxisY.max = parseFloat(dic_meta["Y軸最大值"]);
        valueAxisY.renderer.ticks.template.disabled = true;
        valueAxisY.renderer.axisFills.template.disabled = true;

        var series = chart.series.push(new am4charts.LineSeries());
        series.dataFields.valueX = "x";
        series.dataFields.valueY = "y";
        series.dataFields.value = "value";
        series.strokeOpacity = 0;
        series.sequencedInterpolation = true;
        series.tooltip.pointerOrientation = "vertical";

        var bullet = series.bullets.push(new am4core.Circle());
        bullet.fill = am4core.color("#ff0000");
        bullet.propertyFields.fill = "color";
        bullet.strokeOpacity = 0;
        bullet.strokeWidth = 2;
        bullet.fillOpacity = 0.5;
        bullet.stroke = am4core.color("#ffffff");
        bullet.hiddenState.properties.opacity = 0;
        bullet.tooltipText = "[bold]{title}[/]\n"+ dic_meta["泡泡大小標籤文字"] +
            "{value.value}\n" + dic_meta["X軸標籤文字"] +
            "{valueX.value}\n" + dic_meta["Y軸標籤文字"] + "{valueY.value}";

        var outline = chart.plotContainer.createChild(am4core.Circle);
        outline.fillOpacity = 0;
        outline.strokeOpacity = 0.8;
        outline.stroke = am4core.color("#ff0000");
        outline.strokeWidth = 2;
        outline.hide(0);

        var blurFilter = new am4core.BlurFilter();
        outline.filters.push(blurFilter);

        bullet.events.on("over", function (event) {
            var target = event.target;
            outline.radius = target.pixelRadius + 2;
            outline.x = target.pixelX;
            outline.y = target.pixelY;
            outline.show();
        });

        bullet.events.on("out", function (event) {
            outline.hide();
        });

        var hoverState = bullet.states.create("hover");
        hoverState.properties.fillOpacity = 1;
        hoverState.properties.strokeOpacity = 1;

        series.heatRules.push({target: bullet, min: parseFloat(dic_meta["泡泡半徑最小值"]), max: parseFloat(dic_meta["泡泡半徑最大值"]), property: "radius"});

        bullet.adapter.add("tooltipY", function (tooltipY, target) {
            return -target.radius;
        });

        chart.cursor = new am4charts.XYCursor();
        chart.cursor.behavior = "zoomXY";
        chart.cursor.snapToSeries = series;

        chart.scrollbarX = new am4core.Scrollbar();
        chart.scrollbarY = new am4core.Scrollbar();

        chart.data = ary_chart_data;
    }
}

define("cameo-bubble", CameoBubble);
