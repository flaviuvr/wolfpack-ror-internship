function updateSlider() {
    let sliderValue = document.getElementById("slider").value;
    document.getElementById("upper-bound").innerHTML = sliderValue + "$";
    console.log(sliderValue);
}

let dishes = [
  {
    "imageSource": "./assets/pancakes.png",
    "title": "Pancakes",
    "category": "Breakfast",
    "price": "5.00$"
  },
  {
    "imageSource": "./assets/salad.png",
    "title": "Caesar Salad",
    "category": "Salads",
    "price": "10.00$"
  },
  {
    "imageSource": "./assets/lasagna.png",
    "title": "Lasagna",
    "category": "Main Course",
    "price": "18.00$",
  },
];

function updateFormRender() {
    const displayAdd = document.getElementById("add-display");
    const formAdd = document.getElementById("add-form");

    let shouldDisplayForm = formAdd.style.display == "none"
    displayAdd.style.display = shouldDisplayForm ? "flex" : "none";
    formAdd.style.display = shouldDisplayForm ? "none" : "flex";
}

function handleFormInput() {
    const newDish = {
        "imageSource": "./assets/" + document.getElementById("input-image-dish").value + ".png",
        "title": document.getElementById("input-title-dish").value,
        "category": document.getElementById("input-category-dish").value,
        "price": document.getElementById("input-price-dish").value + "$"
    }

    addDishToStorage(newDish);
    loadCardElements();

    const inputs = document.getElementsByClassName("dish-input");
    resetFormValues(inputs);
}

function resetFormValues(inputs){
    for (let i = 0; i < inputs.length; i++) {
        inputs[i].value = "";
    }
}

function addDishToStorage(dish) {
    let storedDishes = JSON.parse(localStorage.getItem("food-dishes")) || {};
    storedDishes.push(dish);
    localStorage.setItem("food-dishes", JSON.stringify(storedDishes));
}

function loadCardElements() {
    removeAllContent();
    const dishesGrid = document.getElementById("food-dishes");
    const dishesList = JSON.parse(localStorage.getItem("food-dishes")) || {};

    dishesList.forEach(dish => {
        dishesGrid.insertBefore(createDishCard(dish), dishesGrid.firstChild);
    })
}

function removeAllContent() {
    const gridItems = document.getElementById("food-dishes");

    while (gridItems.children.length != 1){
        gridItems.removeChild(gridItems.firstElementChild);
    }
}

function createDishCard(dish) {
    const card = document.createElement("div");
    card.className = "card";
    const info = createDishInfo(dish);

    info.forEach(info => {
        card.appendChild(info);
    })

    return card;
}

function createDishInfo(dish) {
    const image = document.createElement("img");
    image.src = dish.imageSource;

    const title = document.createElement("div");
    title.className = "title";
    title.innerHTML = dish.title;

    const category = document.createElement("div");
    category.className = "category";
    category.innerHTML = dish.category;

    const price = document.createElement("div");
    price.className = "price";
    price.innerHTML = dish.price;

    return [image, title, category, price];
}
