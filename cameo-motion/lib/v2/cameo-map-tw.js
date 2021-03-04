// cameo-map-tw.js
import {CameoAmElement, define} from "/cameo-motion/lib/v2/cameo-am-element.js";

class CameoMapTw extends CameoAmElement {
    parse_ary_chart_data(ary_data) {
        let i = 0;
        let ary_chart_data = [];
        for (; i < ary_data[0].length; i++) {
            let dic_data = {};
            dic_data["category"] = ary_data[0][i];
            dic_data["latitude"] = parseFloat(ary_data[1][i]);
            dic_data["longitude"] = parseFloat(ary_data[2][i]);
            dic_data["description1"] = ary_data[3][i];
            dic_data["description2"] = ary_data[4][i];
            dic_data["value"] = parseFloat(ary_data[5][i]);
            dic_data["count"] = parseInt(ary_data[6][i]);
            dic_data["city"] = ary_data[7][i];
            ary_chart_data.push(dic_data);
        }
        return ary_chart_data;
    }

    async chart_render() {
        let [ary_data, dic_meta] = await this.fetch_data_meta();

        //針對產業描述斷行
        var length = ary_data[0].length;
        for (var i = 0; i < length; i++) {
            var t = "";
            var j = 0;
            while (j < ary_data[4][i].length) {
                t = t + ary_data[4][i].substr(j, 15) + "\n";
                j = j + 15;
            }
            ary_data[4][i] = t;
        }

        //針對描述斷行
        var des_length = ary_data[0].length;
        for (var i = 0; i < des_length; i++) {
            t = "";
            j = 0;
            while (j < ary_data[3][i].length) {
                t = t + ary_data[3][i].substr(j, 15) + "\n";
                j = j + 15;
            }
            ary_data[3][i] = t;
        }
        const ary_chart_data = this.parse_ary_chart_data(ary_data);
        var chart = am4core.create(this.str_random_id, am4maps.MapChart);
        this.set_theme_height_menu_watermark_title(chart, dic_meta);

        // Set map definition
        chart.geodata = am4geodata_worldHigh;
        // Set projection
        chart.projection = new am4maps.projections.Miller();
        chart.homeGeoPoint = {
            latitude: -25,
            longitude: -60
        };
        chart.legend = new am4maps.Legend();
        chart.legend.position = "left";
        chart.legend.align = "left";
        chart.legend.background.fill = am4core.color("#e3f6f5");
        //chart.legend.background.fillOpacity = 0.85;
        chart.legend.width = 180;
        chart.legend.fontSize = "12px";

        chart.legend.useDefaultMarker = true;
        var marker = chart.legend.markers.template.children.getIndex(0);
        marker.cornerRadius(14, 14, 14, 14);
        marker.width = 14;
        marker.height = 14;

        const str_taiwan_json = "/cameo-motion/lib/v2/taiwan.json";

        // 台灣地圖
        var seriestw = chart.series.push(new am4maps.MapPolygonSeries());
        seriestw.name = "臺灣地圖";
        seriestw.geodataSource.url = str_taiwan_json;
        seriestw.fill = am4core.color("#000");
        seriestw.fillOpacity = 0.1;
        seriestw.include = [
            "TW-KEE",
            "TW-NWT",
            "TW-ILA",
            "TW-TPE",
            "TW-TYC",
            "TW-HSQ",
            "TW-HSZ",
            "TW-MIA",
            "TW-TXG",
            "TW-CHA",
            "TW-NAN",
            "TW-YUN",
            "TW-CYQ",
            "TW-CYI",
            "TW-TNN",
            "TW-KHH",
            "TW-PIF",
            "TW-PEN",
            "TW-KIN",
            "TW-LIE",
            "TW-HUA",
            "TW-TTT"
        ];
        seriestw.mapPolygons.template.fill = am4core.color("#000");
        seriestw.mapPolygons.template.fillOpacity = 0.1;

        let len2 = ary_data[7].length;
        for (let i = 0; i < len2; i++) {
            let series = chart.series.push(new am4maps.MapPolygonSeries());
            series.geodataSource.url = str_taiwan_json;
            series.name = ary_data[0][i];
            console.log(ary_data);
            let lst_cities = replace_chinese_cities_to_symbol(ary_data[7][i]);
            series.include = lst_cities;
            series.fill = am4core.color(dic_meta[`地圖區域${i + 1}顏色`]);
            series.mapPolygons.template.tooltipText = "{name}"; //:{number}家數
            series.mapPolygons.template.fill = am4core.color(dic_meta[`地圖區域${i + 1}顏色`]);
            series.tooltip.fontSize = "12px";

        }

        // 產業聚落 Pins
        var imageSeries = chart.series.push(new am4maps.MapImageSeries());
        imageSeries.name = "聚落介紹";
        var imageTemplate = imageSeries.mapImages.template;
        imageTemplate.propertyFields.longitude = "longitude";
        imageTemplate.propertyFields.latitude = "latitude";
        imageTemplate.nonScaling = true;
        imageTemplate.tooltipText = dic_meta["介紹標題1"] + "\n{description1}\n" + dic_meta["介紹標題2"] + "\n{description2}";

        imageSeries.tooltip.animationDuration = 0;
        imageSeries.tooltip.showInViewport = false;
        imageSeries.tooltip.background.fillOpacity = 0.2;
        imageSeries.tooltip.getStrokeFromObject = true;
        imageSeries.tooltip.getFillFromObject = false;
        imageSeries.tooltip.background.fillOpacity = 0.65;
        imageSeries.tooltip.background.fill = am4core.color("#000000");
        imageSeries.tooltip.fontSize = "13px";

        // Creating a pin bullet
        var pin = imageTemplate.createChild(am4plugins_bullets.PinBullet);

        // Colors
        var color1 = am4core.color("#0a3336");

        // Configuring pin appearance
        pin.background.fill = color1;
        pin.background.pointerBaseWidth = 1;
        pin.background.pointerLength = 20;
        pin.background.propertyFields.pointerLength = 10;
        pin.circle.fill = pin.background.fill;

        var text =
            "[bold " +
            dic_meta["標籤1文字顏色"] +
            "]{category}[/]\n[font-size:12px " +
            dic_meta["標籤2文字顏色"] +
            "]{count}" +
            dic_meta["標籤2單位"] +
            "\n[font-size:12px " +
            dic_meta["標籤3文字顏色"] +
            "]({value}" +
            dic_meta["標籤3單位"] +
            ")[/]";

        var label = pin.createChild(am4core.Label);
        label.fontSize = "13px";
        label.text = text;
        label.align = "right";
        label.valign = "right";
        label.isMeasured = false;
        label.x = -72;
        label.y = -55;
        label.fill = am4core.color("#242323");

        imageSeries.heatRules.push({
            target: pin.background,
            property: "radius",
            min: 5,
            max: 10
            // dataField: dic_meta["產業聚落泡泡大小(資料來源)"]
        });
        imageSeries.data = ary_chart_data;
    }
}

function replace_chinese_cities_to_symbol(str_chinese_cities) {
    let str_symbols = str_chinese_cities.replaceAll("、", ",");
    const dic = {
        "臺北市": "\"TW-TPE\"",
        "台北市": "\"TW-TPE\"",
        "新北市": "\"TW-NWT\"",
        "臺中市": "\"TW-TXG\"",
        "台中市": "\"TW-TXG\"",
        "宜蘭縣": "\"TW-ILA\"",
        "南投縣": "\"TW-NAN\"",
        "雲林縣": "\"TW-YUN\"",
        "屏東縣": "\"TW-PIF\"",
        "新竹市": "\"TW-HSZ\"",
        "臺南市": "\"TW-TNN\"",
        "台南市": "\"TW-TNN\"",
        "桃園市": "\"TW-TYC\"",
        "苗栗縣": "\"TW-MIA\"",
        "彰化縣": "\"TW-CHA\"",
        "基隆市": "\"TW-KEE\"",
        "新竹縣": "\"TW-HSQ\"",
        "嘉義市": "\"TW-CYI\"",
        "嘉義縣": "\"TW-CYQ\"",
        "高雄市": "\"TW-KHH\"",
        "花蓮縣": "\"TW-HUA\"",
        "臺東縣": "\"TW-TTT\"",
        "台東縣": "\"TW-TTT\"",
        "金門縣": "\"TW-KIN\"",
        "澎湖縣": "\"TW-PEN\"",
        "連江縣": "\"TW-LIE\"",
    };
    let lst_keys = Object.keys(dic);
    for (let i = 0; i < lst_keys.length; i++) {
        let str_key = lst_keys[i];
        let str_value = dic[str_key];
        str_symbols = str_symbols.replaceAll(str_key, str_value);
    }
    return JSON.parse("["+str_symbols+"]");

}

define("cameo-map-tw", CameoMapTw);
