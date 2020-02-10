var StatisticalChart = function () {
    var colors = ['#5793f3', '#d14a61', '#675bba','#15c9d3'],
        color = new echarts.graphic.LinearGradient(0,0,0,1,[{offset:0,color:'#14c8d4'},{offset:1,color:'#43eec6'}]),maxData = 100,
        spirit = 'image://data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAABwAAAA2CAYAAADUOvnEAAAACXBIWXMAAAsTAAALEwEAmpwYAAAAGXRFWHRTb2Z0d2FyZQBBZG9iZSBJbWFnZVJlYWR5ccllPAAAA5tJREFUeNrcWE1oE0EUnp0kbWyUpCiNYEpCFSpIMdpLRTD15s2ePHixnj00N4/GoyfTg2fbiwdvvagHC1UQ66GQUIQKKgn1UAqSSFua38b3prPJZDs7s5ufKn0w7CaZ2W/fe9/73kyMRqNB3Nrj1zdn4RJ6du9T2u1a2iHYSxjP4d41oOHGQwAIwSUHIyh8/RA8XeiXh0kLGFoaXiTecw/hoTG4ZCSAaFkY0+BpsZceLtiAoV2FkepZSDk5EpppczBvpuuQCqx0YnkYcVVoqQYMyeCG+lFdaGkXeVOFNu4aEBalOBk6sbQrQF7gSdK5JXjuHXuYVIVyr0TZ0FjKDeCs6km7JYMUdrWAUVmZUBtmRnVPK+x6nIR2xomH06R35ggwJPeofWphr/W5UjPIxq8B2bKgE8C4HVHWvg+2gZjXj19PkdFztY7bk9TDCH/g6oafDPpaoMvZIRI5WyMB/0Hv++HkpTKE0kM+A+h20cPAfN4GuRyp9G+LMTW+z8rCLI8b46XO9zRcYZTde/j0AZm8WGb3Y2F9KLlE2nqYkjFLJAsDOl/lea0q55mqxXcL7YBc++bsCPMe8mUyU2ZIpnCoblca6TZA/ga2Co8PGg7UGUlEDd0ueptglbrRZLLE7poti6pCaWUo2pu1oaYI1CF9b9cCZPO3F8ikJQ/rPpQT5YETht26ss+uCIL2Y8vHwJGpA96GI5mjOlaKhowUy6BcNcgIhDviTGWCGFaqEuufWz4pgcbCh+w0gEOyOjTlTtYYlIWPYWKEsLDzOs+nhzaO1KEpd+MXpOoTUgKiNyhdy5aSMPNVqxtSsJFgza5EWA4zKtCJ2OGbLn0JSLu8+SL4G86p1Fpr7ABXdGFF/UTD4rfmFYFw4G9VAJ9SM3aF8l3yok4/J6IV9sDVb36ynmtJ2M5+CwxTYBdKNMBaocKGV2nYgkz6r+cHBP30MzAfi4Sy+BebSoPIOi8PW1PpCCvr/KOD4k9Zu0WSH0Y0+SxJ2awp/nlwKtcGyHOJ8vNHtRJzhPlsHr8MogtlVtwUU0tSM1x58upSKbfJnSKUR07GVMKkDNfXpzpv0RTHy3nZMVx5IOWdZIaPabGFvfpwpjnvfmJHXLaEvZUTseu/TeLc+xgAPhEAb/PbjO6PBaOTf6LQRh/dERde23zxLtOXbaKNhfq2L/1fAOPHDUhOpIf5485h7l+GNHHiSYPKE3Myz9sFxoJuAyazvwIMAItferha5LTqAAAAAElFTkSuQmCC';

    var option = {
        backgroundColor: '#0f375f',
        title: {
            text: '',
            subtext: '',
            padding:10,
            left:35,
            top:0
        },
        tooltip: {//提示框组件 鼠标hove 显示的框子
            show: true,
            trigger: 'item',
            axisPointer: {
                type: 'shadow'
            },
        },
        legend: {//图例组件 头部的小标签
            show: true,
            data: ['line', 'bar'],
            textStyle: {
                color: '#ccc'
            }
        },
        xAxis: {//直角坐标系 grid 中的 x 轴 横向
            max:null,
            show: true,
            data: [],
            axisLine: { //坐标 x 轴 分割线
                show: true,
                lineStyle: {
                    color: '#ccc'
                }
            },
        },
        yAxis: {//直角坐标系 grid 中的 y 轴 左侧列
            show: true,
            max:null,
            splitLine: {show: true},
            axisLine: { //坐标 y 轴 分割线
                show: true,
                lineStyle: {
                    fontSize: 16,
                    color: '#ccc'
                }
            },
            axisLabel: {
                margin: 10,
                textStyle: {
                    color: '#999',
                    fontSize: 16
                }
            }

        },
        /**
         * 系列列表。每个系列通过 type 决定自己的图表类型 更多类型请访问下面的URL
         * http://echarts.baidu.com/option.html#series
         */
        series: []
    };

    /**
     * 获取筛选框的值查询数据
     */
    var getDateRangePicker = function () {
        $(".m-page--fluid").on('click', '.ranges li', function () {
            var startDate = $("#daterangepicker").attr('start'),
                endDate = $("#daterangepicker").attr('end');
            if (typeof startDate !== 'undefined' && typeof endDate !== 'undefined') {
                createFinishedOut(startDate, endDate)
                createMachinTea(startDate, endDate);
                createHarvest(startDate, endDate)
            }
        })
    }
    /**
     * 成品出库统计
     */
    var createFinishedOut = function (startDate, endDate) {
        var beginTime = "", endTime = "";
        if (typeof startDate !== 'undefined' && typeof endDate !== 'undefined') {
            beginTime = startDate, endTime = endDate;
        } else {
            var myDate = new Date();
            endTime = myDate.getFullYear() + '-' + myDate.getMonth() + 1 + '-' + myDate.getDate();
            var n=new Date(myDate.getTime()-86400000*7);
            beginTime = n.getFullYear()+"-"+ (n.getMonth()+1)+"-"+ n.getDate();
        }
        if (beginTime != '' && endTime != '') {
            request(
                'getFinishedOut',
                'post',
                {'beginTime':beginTime,'endTime':endTime},
                function (result) {
                    if(result.message){
                        createCanvasImg(result,'line',"finishedOut",'件')
                    }
                }
            )
        }
    }
    /**
     * 鲜叶数量统计
     */
    var createHarvest = function (startDate, endDate) {
        var beginTime = "", endTime = "";
        if (typeof startDate !== 'undefined' && typeof endDate !== 'undefined') {
            beginTime = startDate, endTime = endDate;
        } else {
            var myDate = new Date();
            endTime = myDate.getFullYear() + '-' + myDate.getMonth() + 1 + '-' + myDate.getDate();
            var n=new Date(myDate.getTime()-86400000*7);
            beginTime = n.getFullYear()+"-"+ (n.getMonth()+1)+"-"+ n.getDate();
        }
        if (beginTime != '' && endTime != '') {
            request(
                'getHarvestQuality',
                'post',
                {'beginTime':beginTime,'endTime':endTime},
                function (result) {
                    if(result.message){
                        createCanvasImg(result,'bar',"Harvest",'斤')
                    }
                }
            )
        }
    }

    /**
     * 鲜叶加工统计
     */
    var createMachinTea = function (startDate, endDate) {
        var beginTime = "", endTime = "";
        if (typeof startDate !== 'undefined' && typeof endDate !== 'undefined') {
            beginTime = startDate, endTime = endDate;
        } else {
            var myDate = new Date();
            endTime = myDate.getFullYear() + '-' + myDate.getMonth() + 1 + '-' + myDate.getDate();
            var n=new Date(myDate.getTime()-86400000*7);
            beginTime = n.getFullYear()+"-"+ (n.getMonth()+1)+"-"+ n.getDate();
        }
        if (beginTime != '' && endTime != '') {
            request(
                'getHarvestMachin',
                'post',
                {'beginTime':beginTime,'endTime':endTime},
                function (result) {
                    if(result.message){
                        createCanvasImgAsRow(result,'pictorialBar',"machinTea",'比例')
                    }
                }
            )
        }
    }

    /**
     * 创建横向统计图
     */
    var createCanvasImgAsRow = function (data,chartType,elementById,subtext) {
        var dataArr = [],category = [];
        if (data != ''){
            $.each(data.data,function (i,n) {
                if($.inArray(n.pickBatchNo, category) == -1){
                    category.push(n.pickBatchNo);
                }
                if (typeof n.baseNum !== 'undefined' && typeof n.machinNum != 'undefined' && n.machinNum != '0'){
                    var bn = (Number(n.machinNum+n.quaNum)),
                        s = (Number(bn <= n.baseNum ? bn : n.baseNum) / n.baseNum * 100);
                    dataArr.push({name:n.teaTypeName +'-' +n.name,value:s.toFixed(2)});
                }else{
                    dataArr.push({name:'无',value:0});
                }
            })
        }
        var noption = {
            tooltip: {
            },
            xAxis: {
                max: maxData,
                splitLine: {show: false},
                offset: 10,
                axisLine: {
                    lineStyle: {
                        color: '#ccc'
                    }
                }
            },
            yAxis: {
                data: category,
                inverse: true,
                axisTick: {show: false},
                axisLine: {show: false},
                axisLabel: {
                    margin: 10,
                    textStyle: {
                        color: '#ccc',
                        fontSize: 16
                    }
                }
            },
            grid: {
                top: 20,
                height: 170,
                left: 120,
                right: 80
            }}
        noption.series = [{
            type: chartType,
            symbol: spirit,
            symbolRepeat: 'fixed',
            symbolMargin: '5%',
            symbolClip: true,
            symbolSize: 20,
            symbolBoundingData: maxData,
            data: dataArr,
            markLine: {
                symbol: 'none',
                label: {
                    normal: {
                        show:true,
                        position: 'start'
                    }
                }
            },
            z: 10
        }, {
            type: chartType,
            itemStyle: {
                normal: {
                    opacity: 0.2
                }
            },
            label: {
                normal: {
                    show: true,
                    formatter: function (params) {
                        return params.data.name+(params.value / maxData * 100).toFixed(2) + ' %';
                    },
                    position: 'outside',
                    offset: [10, 0],
                    textStyle: {
                        color: 'green',
                        fontSize: 12
                    }
                }
            },
            animationDuration: 0,
            symbolRepeat: 'fixed',
            symbolMargin: '5%',
            symbol: spirit,
            symbolSize: 20,
            symbolBoundingData: maxData,
            data:  dataArr,
            z: 5
        }];
        createCharts(elementById,noption);
    }
    /**
     * 合格率
     */
    var createQualityTea = function () {
        var colors = ['#5793f3', '#d14a61', '#675bba'];


        var app = {};
        app.title = '合格率(质检)';
        var category = [];
        var dottedBase = +new Date();
        var lineData = [];
        var barData = [];

        for (var i = 0; i < 20; i++) {
            var date = new Date(dottedBase += 3600 * 24 * 1000);
            category.push([
                date.getFullYear(),
                date.getMonth() + 1,
                date.getDate()
            ].join('-'));
            var b = Math.random() * 200;
            var d = Math.random() * 200;
            barData.push(b)
            lineData.push(d + b);
        }
        option.backgroundColor = '#ffffff';
        option.legend.data = ["合格", "不合格"];
        option.xAxis.data = category;
        option.series[0] = {
            name: 'dotted',
            type: 'line',
            show: true,
            itemStyle: {
                normal: {
                    color: '#5793f3'
                }
            },
            smooth: true,
            symbolMargin: 1,
            z: -10,
            data: lineData
        };
        // option.series[1].data = barData;
        // option.series[2].data = lineData;
        // option.series[3].data = lineData;
        // option.series[3].show = false;
        createCharts("qualityTea", option)
    }

    /**
     * 绘制 统计图
     * @param data
     * @param itemObj
     * @param color
     */
    var createCanvasImg = function (data,chartType,elementById,subtext) {
        var vars = {};
        var legendArr = [];
        var seriesArr = [];
        var category = [];
        if (data.data.length > 0){
            $.each(data.data,function (i,n) {
                if($.inArray(n.dateTime, category) == -1){
                    category.push(n.dateTime);
                }
                if (typeof n.account !== 'undefined'){
                    if($.inArray(n.name, legendArr) == -1){
                        legendArr.push(n.name);
                    }
                    var dataGroup = n.account;
                    if (vars[dataGroup]){
                       // console.log(n.outTea)
                        //vars[dataGroup].data.push(n.userOutForDay);
                        vars[dataGroup].data.push({name:n.outTea,value:n.userOutForDay});
                    }else{
                        vars[dataGroup] = {
                            name:n.name,
                            type:chartType,
                            show: true,
                            smooth:true,
                            showAllSymbol:true,
                            symbol:'emptyCircle',
                            symbolSize:15,
                            barWidth: 10,
                            itemStyle: {
                                normal: {
                                    barBorderRadius: 5,
                                    color: colors[i] ? colors[i] : colors
                                }
                            },
                            data: [n.userOutForDay],
                            label: {
                                normal: {
                                    //show: true,
                                    // formatter: function (params) {
                                    //      console.log(params)
                                    // },

                                }
                            },
                            tooltip:{
                                formatter: function (params) {
                                    if (typeof params.data.name !== 'undefined' && params.value !== 0){
                                        return params.seriesName +': 共'+params.value+subtext+'/'+ params.data.name;
                                    }else{
                                        return params.seriesName +': 共'+params.value+subtext;
                                    }
                                },
                            }
                        }
                    }
                }
            })
            for(var tmp in vars){
                if (typeof vars[tmp] !== 'undefined'){
                    seriesArr.push(vars[tmp])
                }
            }
            option.backgroundColor = '#ffffff';
            option.legend.data = legendArr;
            option.xAxis.data = category;
            option.series= seriesArr;
            option.title.subtext = "单位:"+subtext;
            createCharts(elementById, option)
        }else{
            ToastrMsg("未产生出货信息.","warning","topRight");
        }
    }
    /**
     * 创建echats 统计图
     * @param ElementById
     * @param option
     */
    var createCharts = function (elementById, option) {
        var dom = document.getElementById(elementById);
        var chartObject = echarts.init(dom);
        if (option && typeof option === "object") {
            chartObject.setOption(option, true);
        }
    }

    return {
        init: function () {
            createHarvest();
            createMachinTea();
            createQualityTea();
            createFinishedOut();
            getDateRangePicker();
        }
    };
}();

    jQuery(document).ready(function () {
        StatisticalChart.init();
        daterangepickerInit();
    });