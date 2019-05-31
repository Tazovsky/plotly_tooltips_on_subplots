renderTooltipsOnSubplots = function(id) {
  document.getElementById(id).on('plotly_hover', function (eventdata){
        if(eventdata.xvals)
        {
          console.log(eventdata.xvals);
            Plotly.Fx.hover(document.getElementById(id),
              [
                { curveNumber: 0, pointNumber:eventdata.points[0].pointNumber },
                { curveNumber: 1, pointNumber:eventdata.points[0].pointNumber },
              ],
                ['xy', 'x2y2']
            );
        }
    });
};