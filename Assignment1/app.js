function updateSlider() {
    let sliderValue = document.getElementById("slider").value;
    document.getElementById("upper-bound").innerHTML = sliderValue + "$";
    console.log(sliderValue);
}
