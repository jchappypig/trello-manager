$(function () {
    $('#container').highcharts({
        chart: {
            type: 'column'
        },

        title: {
            text: 'Digital Team Velocity Chart'
        },

        xAxis: {
            categories: ['Mid APR', 'Early MAY', 'Mid MAY', 'Early JUN', 'Mid JUN']
        },

        yAxis: {
            allowDecimals: false,
            min: 0,
            title: {
                text: 'Points'
            }
        },

        tooltip: {
            formatter: function () {
                return '<b>' + this.x + '</b><br/>' +
                    this.series.name + ': ' + this.y + '<br/>' +
                    'Total: ' + this.point.stackTotal;
            }
        },

        plotOptions: {
            column: {
                stacking: 'normal'
            }
        },

        series: [{
            name: 'Milli',
            data: [20, 21, 24, 36, 40],
            stack: 'actual'
        }, {
            name: 'LM Marketing',
            data: [5, 2, 4, 4, 10],
            stack: 'actual'
        }, {
            name: 'LM Lead',
            data: [0, 0, 4, 1, 0],
            stack: 'actual'
        }, {
            name: 'Home Now',
            data: [11, 22, 9, 14, 18],
            stack: 'actual'
        }, {
            name: 'Newly Added',
            data: [0, 0, 0, 24, 30],
            stack: 'planed'
        }, {
            name: 'Expected',
            data: [0, 0, 0, 60, 38],
            stack: 'planed'
        }]
    });
});
