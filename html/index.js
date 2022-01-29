$(function () {
    function display(bool) {
        if (bool) {
            $("#container").show();
        } else {
            $("#container").hide();
        }
    }

    display(false)

    window.addEventListener('message', function(event) {
        var item = event.data;
        if (item.type === "ui") {
            if (item.status == true) {
                display(true)
            } else {
                display(false)
            }
        }
    })
    // if the person uses the escape key, it will exit the resource
    document.onkeyup = function (data) {
        if (data.which == 27) {
            $.post('https://yxupy-darktablet/close', JSON.stringify({}));
            return
        }
    };
    $("#close").click(function () {
        $.post('https://yxupy-darktablet/close', JSON.stringify({}));
        return
    })

    $("#hijack").click(function () {
        $.post('https://yxupy-darktablet/CreateVehicle', JSON.stringify({}));
        return
    })

        // if there are no errors from above, we can send the data back to the original callback and hanndle it from there
        $.post('https://yxupy-darktablet/:main', JSON.stringify({

        }));
        return;
    })


let $wrap = document.querySelector('.wrap'),
$opts = document.querySelectorAll('.bar a');

Array.prototype.forEach.call($opts, (el, i) => {
el.addEventListener('click', function (event) {
    $wrap.setAttribute('data-pos', i);			  
});
});

let count = 0,
$btns = document.querySelectorAll('.btn'),
$cart = document.querySelector('.cart');

Array.prototype.forEach.call($btns, (el, i) => {
el.addEventListener('click', function (event) {
    $cart.classList.add('add');
    $cart.querySelector('span').innerText = ++count;
    setTimeout(() => {
        $cart.classList.remove('add');
    }, 1500);			  
});
});
