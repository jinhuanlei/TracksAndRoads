<!DOCTYPE html>
<html>

<head>
    <meta charset="UTF-8">
    <title>assignment4</title>
    <style type="text/css">
        /*.circle {
            width: 1000px;
            float: none;
            display: block;
            margin-left: auto;
            margin-right: auto;
        }
        */

        .anim {
            position: absolute;
            left: 0px;
            width: 150px;
            height: 150px;
            background: blue;
            font-size: larger;
            color: white;
            border-radius: 10px;
            padding: 1em;
        }

        #canvas1 {}
    </style>
    <!-- Latest compiled and minified CSS -->
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" ;; integrity="sha384-BVYiiSIFeK1dGmJRAkycuHAHRg32OmUcww7on3RYdg4Va+PmSTsz/K68vbdEjh4u" crossorigin="anonymous">

</head>

<body>
<div class="container">
    <div class="row">

        <div class="col-md-1">
            <button type="button" id ="runLeft"class="btn btn-success" style="margin-top: 30px; ">RunLeft</button>
            <button type="button" id ="runRight"class="btn btn-success" style="margin-top: 30px; ">RunRight</button>
            <button type="button" id ="runBoth"class="btn btn-success" style="margin-top: 30px;  ">RunBothSide</button>
            <button type="button" id ="run"class="btn btn-success" style="margin-top: 30px; ">Run</button>
            <button type="button" id="stop" class="btn btn-warning" style="margin-top: 30px;">Stop</button>
        </div>
        <div class="col-md-10">

            <canvas id="canvas1" width="1000" height="600"></canvas>
            <img src="images/train.jpg" id="train" hidden="hidden" />
            <img src="images/trainL.png" id="trainL" hidden="hidden" />
            <img src="images/trainR.png" id="trainR" hidden="hidden" />
        </div>

    </div>
</div>
<script type="text/javascript">
    var n = 100;
    var elem = document.getElementById("anim");

    // requestAnimationFrame的兼容性写法
    window.requestAnimFrame = (function() {
        return window.requestAnimationFrame ||
            window.webkitRequestAnimationFrame ||
            window.mozRequestAnimationFrame ||
            window.oRequestAnimationFrame ||
            window.msRequestAnimationFrame ||
            function( /* function FrameRequestCallback */ callback, /* DOMElement Element */ element) {
                window.setTimeout(callback, 1000 / 60);
            };
    })();

    window.cancelAnimationFrame = (function() {
        return window.cancelAnimationFrame ||
            window.webkitCancelAnimationFrame ||
            window.mozCancelAnimationFrame ||
            window.oCancelAnimationFrame ||
            function(timer) {
                window.clearTimeout(timer);
            };
    })();

    var canvas1 = document.getElementById("canvas1");
    var ctx = canvas1.getContext("2d");
    var startTime = Date.now();
    var x = 0;
    var stopMarkL=0;
    var stopMarkR=0;
    var lPos = 0;
     var rPos =1000;
     var rate=0;
    DrawSline(ctx);
    DrawDline(ctx);
    DrawShape(ctx);
    ctx.stroke();

    function drawL() {

        stopMark=requestAnimFrame(drawL);

        drawStatic(ctx,0);

    }
    function drawR() {

        stopMark=requestAnimFrame(drawR);

        drawStatic(ctx,1);

    }


    document.getElementById("run").addEventListener("click", function() {
        rate++;
        draw();

    }, false);

    document.getElementById("runLeft").addEventListener("click", function() {
        rate++;
        drawL();

    }, false);
    document.getElementById("runRight").addEventListener("click", function() {
        rate++;
        drawR();

    }, false);

    document.getElementById("stop").addEventListener("click", function() {
        console.log(rate);
        if( stopMark) {
//            for (var x = 0; x < rate; x++) {

            window.cancelAnimationFrame(stopMark);
//            }
            stopMark = null;
        }
          rate=0;

    }, false);

    function drawStatic(ctx, num) {

      //  var time = Date.now();
if(num==0)
{
    ctx.clearRect(lPos, 270, 140, 60);
    var train = document.getElementById("trainL");
    // x = (time - startTime) / 10 % 1000;
    lPos=(lPos+1)%1000;
    ctx.drawImage(train,lPos, 270);
}
       else{
    ctx.clearRect(rPos, 270, 140, 60);
    var train = document.getElementById("trainR");
    // x = (time - startTime) / 10 % 1000;
    rPos=(rPos-1)%1000;
    ctx.drawImage(train,rPos, 270);
}

        //				elem.style.left = ((time - startTime) / 10 % 500) + "px";
    }

    function DrawShape(ctx) {

        ctx.fillStyle = "blue";
        ctx.fillRect(410, 255, 180, 10);

        ctx.fillRect(410, 335, 180, 10);
    }

    function DrawDline(ctx) {

        drawDashLine(ctx, 50, 50, 50, 550, 5);
        drawDashLine(ctx, 950, 50, 950, 550, 5);

        drawDashLine(ctx, 200, 50, 200, 550, 5);
        drawDashLine(ctx, 800, 50, 800, 550, 5);

        drawDashLine(ctx, 350, 50, 350, 550, 5);
        drawDashLine(ctx, 650, 50, 650, 550, 5);
    }

    function DrawSline(ctx) {
        //设置线宽
        ctx.lineWidth = 10;
        //设置线的颜色
        ctx.strokeStyle = "dodgerblue";

        ctx.moveTo(0, 0);
        ctx.strokeRect(0, 0, 1000, 600);

        ctx.lineWidth = 2;
        //
        ctx.moveTo(0, 270);

        ctx.lineTo(1000, 270);
        //vertical line
        ctx.moveTo(420, 250);

        ctx.lineTo(420, 100);

        ctx.moveTo(580, 250);

        ctx.lineTo(580, 100);
        //
        ctx.moveTo(0, 330);

        ctx.lineTo(1000, 330);
        //vertical line
        ctx.moveTo(420, 350);

        ctx.lineTo(420, 500);

        ctx.moveTo(580, 350);

        ctx.lineTo(580, 500);

    }

    function drawDashLine(ctx, x1, y1, x2, y2, dashLength) {
        var dashLen = dashLength === undefined ? 5 : dashLength,
            xpos = x2 - x1, //得到横向的宽度;
            ypos = y2 - y1, //得到纵向的高度;
            numDashes = Math.floor(Math.sqrt(xpos * xpos + ypos * ypos) / dashLen);
        //利用正切获取斜边的长度除以虚线长度，得到要分为多少段;
        for(var i = 0; i < numDashes; i++) {
            if(i % 2 === 0) {
                ctx.moveTo(x1 + (xpos / numDashes) * i, y1 + (ypos / numDashes) * i);
                //有了横向宽度和多少段，得出每一段是多长，起点 + 每段长度 * i = 要绘制的起点；
            } else {
                ctx.lineTo(x1 + (xpos / numDashes) * i, y1 + (ypos / numDashes) * i);
            }
        }
        ctx.stroke();
    }
</script>
<script src="https://code.jquery.com/jquery-3.2.1.min.js" ;></script>;
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js" ;; integrity="sha384-Tc5IQib027qvyjSMfHjOMaLkfuWVxZxUPnCJA7l2mCWNIpG9mGCD8wGNIcPD7Txa" crossorigin="anonymous"></script>
</body>

</html>