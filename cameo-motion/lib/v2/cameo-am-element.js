// cameo-am-element.js
import { fetch_dic, fetch_transpose } from "/cameo-motion/lib/v2/cameo-clean.js";
class CameoAmElement extends HTMLElement {
  connectedCallback() {
    this.str_random_id = "id_" + Math.random().toString(36).substr(2, 9);
    this.innerHTML = `<div class="cameo-am-element" id="${this.str_random_id}"
                      style="width: 100%; height: 600px;"></div>`;
    this.chart_render();
  }
  set_height(int_height) {
    document.getElementById(this.str_random_id).setAttribute("style", `width: 100%; height:${int_height}px;`);
  }
  async fetch_data_meta() {
    let [ary_data, dic_meta] = await Promise.all([
      fetch_transpose(this.getAttribute("data")),
      fetch_dic(this.getAttribute("meta"))
    ]);
    ary_data = ary_data.map((ary) => ary.slice(1));
    return [ary_data, dic_meta];
  }
  set_theme_height_menu_watermark_title(chart, dic_meta) {
    am4core.useTheme(am4themes_animated);
    this.set_height(dic_meta[`圖表高度`]);
    set_chart_exporting_menu(chart, dic_meta["圖表下載檔名"]);
    set_watermark(chart, dic_meta["資料來源"]);
    set_title(chart, dic_meta["圖表標題"]);
  }
}
function set_watermark(chart, str_filename) {
  var watermark = chart.createChild(am4core.Label);
  watermark.text = str_filename;
  watermark.fontSize = 10;
  watermark.align = "right";
  watermark.valign = "bottom";
  watermark.fillOpacity = 0.5;
}
function set_title(chart, str_filename) {
  var title = chart.titles.push(new am4core.Label());
  title.text = str_filename;
  title.fontSize = 25;
  title.marginBottom = 15;
}
function set_chart_exporting_menu(chart, str_filename) {
  chart.exporting.menu = new am4core.ExportMenu();
  chart.exporting.filePrefix = str_filename;
  chart.exporting.useWebFonts = false;
  chart.exporting.menu.items = [
    {
      label: "...",
      menu: [
        {
          label: "Image",
          menu: [
            { type: "png", label: "PNG" },
            { type: "jpg", label: "JPG" },
            { type: "svg", label: "SVG" },
            { type: "pdf", label: "PDF" }
          ]
        },
        {
          label: "Print",
          type: "print"
        }
      ]
    }
  ];
}
function set_license() {
  // Add amCharts 4 license
  am4core.addLicense("CH251292242");
  // Add Maps license
  am4core.addLicense("MP251292242");
  // Add TimeLine license
  am4core.addLicense("TL251292242");
}
function define(str_tag, cameo_am_element) {
  set_license();
  customElements.define(str_tag, cameo_am_element);
}
export { CameoAmElement, set_chart_exporting_menu, set_license, set_watermark, set_title, define };
