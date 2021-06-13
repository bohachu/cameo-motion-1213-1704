import {CameoAmElement, define} from "/cameo-motion/lib/v2/cameo-am-element.js";

class CameoTreemap extends CameoAmElement {
    parse_ary_children_data(ary_data) {
        let ary_children_data = [];
        for (let i = 0; i < ary_data[0].length; i++) {
            let dic_children_data = {};
            dic_children_data["name"] = ary_data[1][i];
            dic_children_data["showname"] = ary_data[2][i];
            dic_children_data["value"] = parseFloat(ary_data[3][i]);
            ary_children_data.push(dic_children_data);
        }
        console.log(ary_children_data);
        return ary_children_data;
    }

    parse_ary_chart_data(ary_data,ary_children_data) {
        let ary_chart_data = [];
        for (let i = 0; i < ary_data[0].length; i++) {
            let dic_data = {};
            dic_data["name"] = ary_data[0][i];
            dic_data["children"] = [ary_children_data[i]];
            ary_chart_data.push(dic_data);
        }
        console.log("ary_chart_data");
        console.log(ary_chart_data);
        return ary_chart_data;
    }

    async chart_render() {
        var chart = am4core.create(this.str_random_id, am4charts.TreeMap);
        let [ary_data,dic_meta] = await this.fetch_data_meta();
        this.set_theme_height_menu_watermark_title(chart, dic_meta);

        const ary_children_data = this.parse_ary_children_data(ary_data);
        const ary_chart_data = this.parse_ary_chart_data(ary_data,ary_children_data);

        chart.data = ary_chart_data;
        //     [{
        //     name: "1999",
        //     children: [
        //         {
        //             name: "願境網訊股份有限公司 \n KKBOX Taiwan Co., Ltd.",
        //             showname: "KKBOX",
        //             value: 2950
        //         }
        //     ]
        // },
        //     {
        //         name: "2007",
        //         children: [
        //             {
        //                 name: "威朋大數據股份有限公司 \n VPON TAIWAN INC.",
        //                 showname: "VPON",
        //                 value: 1627
        //             }
        //         ]
        //     },
        //     {
        //         name: "2008",
        //         children: [
        //             {
        //                 name: "優必達科技有限公司 \n UBITUS TECHNOLOGY LIMITED",
        //                 showname: "UBITUS",
        //                 value: 482
        //             }
        //         ]
        //     },
        //     {
        //         name: "2010",
        //         children: [
        //             {
        //                 name: "沛星互動科技股份有限公司 \n Appier Inc.",
        //                 showname: "Appier",
        //                 value: 4622
        //             },
        //             {
        //                 name: "歐簿客科技股份有限公司 \n OBOOK INC.",
        //                 showname: "OBOOK",
        //                 value: 470
        //             }
        //         ]
        //     },
        //     {
        //         name: "2011",
        //         children: [
        //             {
        //                 name: "睿能創意股份有限公司 \n Gogoro Taiwan Limited",
        //                 showname: "Gogoro",
        //                 value: 14400
        //             },
        //             {
        //                 name: "愛卡拉互動媒體股份有限公司 \n iKala Interactive Media Inc.",
        //                 showname: "iKala",
        //                 value: 909
        //             }
        //         ]
        //     },
        //     {
        //         name: "2013",
        //         children: [
        //             {
        //                 name: "九易宇軒股份有限公司 \n 91APP(TAIWAN), INC.",
        //                 showname: "91APP",
        //                 value: 570
        //             },
        //             {
        //                 name: "創意引晴股份有限公司 \n VisualSearch Technology Co.",
        //                 showname: "VisualSearch",
        //                 value: 428
        //             },
        //             {
        //                 name: "關鍵評論網股份有限公司 \n The News Lens Co., Ltd.",
        //                 showname: "The News Lens",
        //                 value: 369
        //             }
        //         ]
        //     },
        //     {
        //         name: "2014",
        //         children: [
        //             {
        //                 name: "酷遊天股份有限公司 \n KKDAY.COM INTERNATIONAL COMPANY LIMITED (TAIWAN)",
        //                 showname: "KKDAY",
        //                 value: 3053
        //             },
        //             {
        //                 name: "稜研科技股份有限公司 \n TMY TECHNOLOGY INC.",
        //                 showname: "TMY",
        //                 value: 371
        //             }
        //         ]
        //     },
        //     {
        //         name: "2015",
        //         children: [
        //             {
        //                 name: "耐能智慧股份有限公司 \n Kneron (Taiwan) Co., Ltd.",
        //                 showname: "Kneron",
        //                 value: 2080
        //             },
        //             {
        //                 name: "知之有限公司 \n Snapask Inc.",
        //                 showname: "Snapask",
        //                 value: 1620
        //             },
        //             {
        //                 name: "藝啟股份有限公司 \n 17LIVE Inc.",
        //                 showname: "17LIVE",
        //                 value: 1459
        //             }
        //         ]
        //     },
        //     {
        //         name: "2016",
        //         children: [
        //             {
        //                 name: "炳碩生醫股份有限公司 \n POINT ROBOTICS MEDTECH INC.",
        //                 showname: "POINT ROBOTICS",
        //                 value: 540
        //             }
        //         ]
        //     },
        //     {
        //         name: "2017",
        //         children: [
        //             {
        //                 name: "萬里雲互聯股份有限公司 \n Cloud Mile Inc.",
        //                 showname: "Cloud Mile",
        //                 value: 570
        //             },
        //             {
        //                 name: "巧克科技新媒體股份有限公司 \n CHOCO MEDIA CO., LIMITED",
        //                 showname: "CHOCO MEDIA",
        //                 value: 510
        //             }
        //         ]
        //     },
        //     {
        //         name: "2018",
        //         children: [
        //             {
        //                 name: "元創電子股份有限公司 \n Origin Wireless Taiwan Corporation",
        //                 showname: "Origin",
        //                 value: 799
        //             }
        //         ]
        //     }, {
        //         name: "2019",
        //         children: [
        //             {
        //                 name: "易達通科技股份有限公司 \n Infinity Communication Tech. Inc.",
        //                 showname: "Infinity",
        //                 value: 514
        //             }
        //         ]
        //     }];


        /* Set color step */
        chart.colors.step = 2;

        /* Define data fields */
        chart.dataFields.value = "value";
        chart.dataFields.name = "name";
        chart.dataFields.children = "children";
        chart.homeText = dic_meta["第一階層標籤文字"];

        /* Create top-level series */
        var level1 = chart.seriesTemplates.create("0");
        var level1_column = level1.columns.template;
        level1_column.fillOpacity = 0;
        level1_column.strokeOpacity = 0;

        var level1_bullet = level1.bullets.push(new am4charts.LabelBullet());
        level1_bullet.locationY = 0.5;
        level1_bullet.locationX = 0.5;
        level1_bullet.label.text = "{showname}";
        level1_bullet.label.fill = am4core.color("#fff");

        /* Create second-level series */
        var level2 = chart.seriesTemplates.create("1");
        var level2_column = level2.columns.template;
        level2_column.column.cornerRadius(10, 10, 10, 10);
        level2_column.fillOpacity = 0.8;
        level2_column.stroke = am4core.color("#fff");
        level2_column.strokeWidth = 5;
        level2_column.strokeOpacity = 1;
        level2_column.tooltipText = "{name}\n"+dic_meta["文字標籤"]+"{value}"+dic_meta["文字標籤單位"];

        var level2_bullet = level2.bullets.push(new am4charts.LabelBullet());
        level2_bullet.locationY = 0.5;
        level2_bullet.locationX = 0.5;
        level2_bullet.label.text = "{showname}";
        level2_bullet.label.fill = am4core.color("#fff");

        chart.legend = new am4charts.Legend();

        /* Add a navigation bar */
        chart.navigationBar = new am4charts.NavigationBar();

    }
}

define("cameo-treemap", CameoTreemap);
