$(function(){
    $(".reportbug").fadeOut();
    $(".tablet").fadeOut();
    $("#e2").fadeOut();
    $("#admb").fadeOut();
    $("#admb2").fadeOut();
    $(".registeredraces").fadeOut();
    $(".banracer").fadeOut();
    $(".racecreator").fadeOut();
    $(".help").fadeOut();
    $(".raceinterface").fadeOut();
    $(".countage").fadeOut();
    $(".racename").fadeOut();
    $(".policewarning").fadeOut();
    window.addEventListener("message", function(event){
        if (event.data.tablet != undefined) {
            let status = event.data.tablet
            if (status) {
                if (status == 'banned') {
                    $(".tablet").fadeIn();
                    $("#run").fadeOut();
                    $("#admb").fadeOut()
                    $("#admb2").fadeOut()
                } else if (status == 'ok') {
                        init();
                        races();
                        earnings();
                        bestcar();
                        isAdmin();
                        timerecord();
                        timeowner();
                        $(".tablet").fadeIn()
                        $("#e2").fadeIn();
                        $("#run").fadeIn();
                    }
                } else {
                    $(".tablet").fadeOut()
                }
                if (status.hide){
                    sendData("fechar2","fechar2")
                }
            }
        if (event.data.racecreator != undefined) {
            let status = event.data.racecreator
            if (status) {
                saveRace();
                $(".racecreator").fadeIn()
            } else {
                $(".racecreator").fadeOut()
            }
            if (status.hide){
                sendData("fechar2","fechar2")
            }
        }
        if (event.data.helprace != undefined) {
            let status = event.data.helprace
            if (status) {
                $(".help").fadeIn()
            } else {
                $(".help").fadeOut()
            }
            if (status.hide){
                sendData("fechar2","fechar2")
            }
        }
        if (event.data.racing != undefined) {
            let status = event.data.racing;
            if (status) {
                $(".raceinterface").fadeIn();
                actualCheckPoint();
                racingcar();
                startTimer();
                topracer();
                yourtop();
            } else {
                $(".raceinterface").fadeOut();
                var getValue = document.getElementById('timer'); 
                var realValue = getValue.textContent; 
                sendTime(realValue);
                stopTimer(); 
                resetTimer(); 
            }
            if (status.hide) {
                sendData("fechar2","fechar2");
            }
        }        
        if (event.data.pwarning != undefined) {
            let status = event.data.pwarning
            if (status) {
                $(".policewarning").fadeIn()
            } else {
                $(".policewarning").fadeOut()
            }
            if (status.hide){
                sendData("fechar2","fechar2")
            }
        }
        if (event.data.countage != undefined) {
            let status = event.data.countage
            if (status) {
                $(".countage").fadeIn()
                let element = document.getElementById('realCountage');
                setTimeout(() => {
                    element.textContent = '2';
                    setTimeout(() => {
                        element.textContent = '1';
                        setTimeout(() => {
                            element.textContent = '0';
                        }, 1000);
                    }, 1000);
                }, 1000);
            } else {
                $(".countage").fadeOut()
                let element = document.getElementById('realCountage');
                element.textContent = '3';
            }
            if (status.hide){
                sendData("fechar2","fechar2")
            }
        }
    })  
})

function init() {
    $(".run,#admb,#admb2").each(function(i,obj){
 
        if ($(this).attr("data-action")){
            $(this).click(function(){
                var data = $(this).data("action"); 
                sendData("ButtonClick",data);
            })
        }
 
        if ($(this).attr("data-sub")){
            var menu = $(this).data("sub");
            var element = $("#"+menu);
 
            $(this).click(function(){
                element.show();
                $(".container").hide();
                $(this).parent().hide();
            })
 
            var fst = $('<button/>',{text:'Voltar'});
 
            fst.click(function(){
                element.hide();
                $("#"+element.data("parent")).show();
            });
 
            element.append(fst); 
        }
    });
}

function races() {
    function waitForNotification() {
        return new Promise((resolve) => {
            function messageHandler(e) {
                var n = e.data.races;
                if (n !== undefined) {

                    window.removeEventListener('message', messageHandler);

                    resolve(n);
                }
            }

            window.addEventListener('message', messageHandler);
        });
    }

    waitForNotification().then((n) => {
        document.getElementById('races').innerText = n;

        sendData('Races', 'Races');
    });

    setTimeout(() => {
        sendData('Races', 'Races');
    }, 100);
}

function racingcar() {
    function waitForNotification() {
        return new Promise((resolve) => {
            function messageHandler(e) {
                var n = e.data.racingcar;
                if (n !== undefined) {

                    window.removeEventListener('message', messageHandler);

                    resolve(n);
                }
            }

            window.addEventListener('message', messageHandler);
        });
    }

    waitForNotification().then((n) => {
        document.getElementById('racingcar').innerText = n;

        sendData('RacingCar', 'RacingCar');
    });

    setTimeout(() => {
        sendData('RacingCar', 'RacingCar');
    }, 100);
}

function timerecord() {
    function waitForNotification() {
        return new Promise((resolve) => {
            function messageHandler(e) {
                var n = e.data.timerecord;
                if (n !== undefined) {

                    window.removeEventListener('message', messageHandler);

                    resolve(n);
                }
            }

            window.addEventListener('message', messageHandler);
        });
    }

    waitForNotification().then((n) => {
        document.getElementById('timerecord').innerText = n;

        sendData('TimeRecord', 'TimeRecord');
    });

    setTimeout(() => {
        sendData('TimeRecord', 'TimeRecord');
    }, 100);
}

function timeowner() {
    function waitForNotification() {
        return new Promise((resolve) => {
            function messageHandler(e) {
                var n = e.data.timeowner;
                if (n !== undefined) {

                    window.removeEventListener('message', messageHandler);

                    resolve(n);
                }
            }

            window.addEventListener('message', messageHandler);
        });
    }

    waitForNotification().then((n) => {
        document.getElementById('timeowner').innerText = n;

        sendData('TimeOwner', 'TimeOwner');
    });

    setTimeout(() => {
        sendData('TimeOwner', 'TimeOwner');
    }, 100);
}

function topracer() {
    function waitForNotification() {
        return new Promise((resolve) => {
            function messageHandler(e) {
                var n = e.data.topracer;
                if (n !== undefined) {

                    window.removeEventListener('message', messageHandler);

                    resolve(n);
                }
            }

            window.addEventListener('message', messageHandler);
        });
    }

    waitForNotification().then((n) => {
        document.getElementById('topracer').innerText = n;

        sendData('TopRacer', 'TopRacer');
    });

    setTimeout(() => {
        sendData('TopRacer', 'TopRacer');
    }, 100);
}

function yourtop() {
    function waitForNotification() {
        return new Promise((resolve) => {
            function messageHandler(e) {
                var n = e.data.yourtop;
                if (n !== undefined) {

                    window.removeEventListener('message', messageHandler);

                    resolve(n);
                }
            }

            window.addEventListener('message', messageHandler);
        });
    }

    waitForNotification().then((n) => {
        document.getElementById('yourtop').innerText = n;

        sendData('YourTop', 'YourTop');
    });

    setTimeout(() => {
        sendData('YourTop', 'YourTop');
    }, 100);
}

function actualCheckPoint() {
    function waitForNotification() {
        return new Promise((resolve) => {
            function messageHandler(e) {
                var n = e.data.actualCheckPoint;
                if (n !== undefined) {

                    window.removeEventListener('message', messageHandler);

                    resolve(n);
                }
            }

            window.addEventListener('message', messageHandler);
        });
    }

    waitForNotification().then((n) => {
        document.getElementById('actualCheckPoint').innerText = n;

        sendData('ActualCheckPoint', 'ActualCheckPoint');
    });

    setTimeout(() => {
        sendData('ActualCheckPoint', 'ActualCheckPoint');
    }, 100);
}

function isAdmin() {
    function waitForNotification() {
        return new Promise((resolve) => {
            function messageHandler(e) {
                var n = e.data.isAdmin;
                if (n !== undefined) {

                    window.removeEventListener('message', messageHandler);

                    resolve(n);
                }
            }

            window.addEventListener('message', messageHandler);
        });
    }

    waitForNotification().then((n) => {
        sendData('isAdmin', 'isAdmin');
        if (n == true) {
            $("#admb").fadeIn();
            $("#admb2").fadeIn();
            $(".registeredraces").fadeIn();
            let tablet = document.getElementById('tablet')
            let newHeight = '55vh'
            tablet.style.height = newHeight
            document.getElementById('e2').style.marginTop = '-7vh'
            document.getElementById('registeredraces').style.marginTop = '25vw'
            document.getElementById('tablet').style.marginTop = '20vh'
        }
    });

    setTimeout(() => {
        sendData('isAdmin', 'isAdmin');
    }, 100);
}

function saveRace() {
    function waitForNotification() {
        return new Promise((resolve) => {
            function messageHandler(e) {
                var n = e.data.saverace;
                if (n !== undefined) {

                    window.removeEventListener('message', messageHandler);

                    resolve(n);
                }
            }

            window.addEventListener('message', messageHandler);
        });
    }

    waitForNotification().then((n) => {
        sendData('SaveRace', 'SaveRace');
        if (n == true) {
            $(".racename").fadeIn();
        }
    });

    setTimeout(() => {
        sendData('SaveRace', 'SaveRace');
    }, 100);
}

function earnings() {
    function waitForNotification() {
        return new Promise((resolve) => {
            function messageHandler(e) {
                var n = e.data.earnings;
                if (n !== undefined) {

                    window.removeEventListener('message', messageHandler);

                    resolve(n);
                }
            }

            window.addEventListener('message', messageHandler);
        });
    }

    waitForNotification().then((n) => {
        document.getElementById('earnings').innerText = n;

        sendData('Earnings', 'Earnings');
    });

    setTimeout(() => {
        sendData('Earnings', 'Earnings');
    }, 100);
}

function bestcar() {
    function waitForNotification() {
        return new Promise((resolve) => {
            function messageHandler(e) {
                var n = e.data.bestcar;
                if (n !== undefined) {

                    window.removeEventListener('message', messageHandler);

                    resolve(n);
                }
            }

            window.addEventListener('message', messageHandler);
        });
    }

    waitForNotification().then((n) => {
        document.getElementById('bestcar').innerText = n;

        sendData('Bestcar', 'Bestcar');
    });

    setTimeout(() => {
        sendData('Bestcar', 'Bestcar');
    }, 100);
}

$(function(){
    $(function(){
        let valor = $(".tablet")
        $(".fechar").each(()=>{
            $(".fechar").click(function(){
                valor.fadeOut()
            })
        })
        let valor2 = $(".reportbug")
        $(".fechar").each(()=>{
            $(".fechar").click(function(){
                valor2.fadeOut()
            })
        })
    })

    document.onkeyup = function(data){
        if (data.which == 27){
            if ($(".tablet").fadeIn()){
                $(".tablet").hide()
                sendData("fechar2","fechar2")
            }
            if ($(".reportbug").fadeIn()){
                $(".reportbug").hide()
                sendData("fechar2","fechar2")
            }
        }
    }
})

document.getElementById('report').addEventListener('click', function(){
    $(".reportbug").fadeIn();
})

document.getElementById('rrace').addEventListener('click', function(){
    var textD = document.getElementById('deleterace')
    var valueTextd = textD.value
    if (valueTextd !== '' || valueTextd !== null) {
        sendData('DeleteRace', valueTextd);
    }
})

document.getElementById('denuncia').addEventListener('click', function(){
    var text = document.getElementById('denunciatext')
    var textCtnt = text.value
    if (textCtnt !== '' || textCtnt !== null) {
        sendData('DenunciaBug', textCtnt);
    }
})

document.getElementById('sub').addEventListener('click', function(){
    var name = document.getElementById('racename')
    var racename = name.value
    if (racename !== '' || racename !== null) {
        sendData('Create', racename)
    }
})

document.getElementById('admb2').addEventListener('click', function(){
    $("#e2").fadeOut();
    $(".banracer").fadeIn();
})

document.getElementById('bann').addEventListener('click', function(){
    var ban = document.getElementById('ban')
    var banValue = ban.value
    if (banValue !== '' || banValue !== null) {
        sendData('BanRacer', banValue)
    }
})

var startTime = 0; 
var timerInterval; 

function startTimer() {
    startTime = Date.now(); 

    function formatTime(milliseconds) {
        let minutes = Math.floor(milliseconds / 60000);
        let seconds = Math.floor((milliseconds % 60000) / 1000);
        let millis = milliseconds % 1000;

        return `${minutes}.${seconds.toString().padStart(2, '0')}.${millis.toString().padStart(3, '0')}`;
    }

    function update() {
        let elapsedTime = Date.now() - startTime;
        let formattedTime = formatTime(elapsedTime);
        document.getElementById('timer').innerHTML = formattedTime;

        timerInterval = setTimeout(update, 80);
    }

    update();
}

function stopTimer() {
    clearTimeout(timerInterval); // Para o intervalo do timer
}

function resetTimer() {
    document.getElementById('timer').innerHTML = '0.00.000'; // Redefine o conteúdo do timer para '0.00.000'
    startTime = 0; // Reinicia o tempo inicial
}

function sendTime(time){
    function waitForNotification() {
        return new Promise((resolve) => {
            function messageHandler(e) {
                var n = e.data.racefinish;
                if (n !== undefined) {

                    window.removeEventListener('message', messageHandler);

                    resolve(n);
                }
            }

            window.addEventListener('message', messageHandler);
        });
    }

    waitForNotification().then((n) => {
        if (n) {
            sendData('finish:race', time)
        }

        sendData('FinishedRace', 'FinishedRace');
    });

    setTimeout(() => {
        sendData('FinishedRace', 'FinishedRace');
    }, 100);
}

function sendData(name, data) {
    $.post("https://RafaRacing/" + name, JSON.stringify(data), function (datab) {
    });
}