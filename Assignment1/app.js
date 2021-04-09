function updateSlider() {
    let sliderValue = document.getElementById("slider").value;
    document.getElementById("upper-bound").innerHTML = sliderValue + "$";
    console.log(sliderValue);
}

function sort() {
    var cards = document.getElementsByClassName("main-courses");
    console.log(cards);

}