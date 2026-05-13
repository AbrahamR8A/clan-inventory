let loadMoreBtn = document.querySelector('#load-more');
let currentItem = 4;

loadMoreBtn.onclick=() => {

    let boxes = [...document.querySelectorAll('.box-container .box')];
    for(var i = currentItem; i<currentItem + 4; i++){
        boxes[i].style.display = 'inline-block';

    }
    currentItem += 4;
    if(currentItem >= boxes.length){
        loadMoreBtn.style.display = 'none';
    }
}

//Funcion de la Cajita

const cajita = document.getElementById('cajita');
const elementos1 = document.getElementById('lista-1');
const lista = document.querySelector('#lista-cajita tbody');
const vaciarCajitaBtn = document.getElementById('vaciar-cajita')

cargarEventListeners();

function cargarEventListeners(){
    elementos1.addEventListener('click', comprarElemento);
    cajita.addEventListener('click', eliminarElemento);
    vaciarCajitaBtn.addEventListener('click', vaciarCajita);
}

function comprarElemento(e){
    e.preventDefault();

    if (e.target.classList.contains('agregar-cajita')) {
        const elemento = e.target.parentElement.parentElement;
        leerDatosElemento(elemento);
    }
}

function leerDatosElemento(elemento) {
    const infoElemento = {
        imagen: elemento.querySelector('img').src,
        titulo: elemento.querySelector('h3').textContent,
        categoria: elemento.querySelector('.categoria').textContent,
        id: elemento.querySelector('a').getAttribute('data-id')
    }

    insertarCajita(infoElemento)
}

function insertarCajita(elemento) {
    const row = document.createElement('tr');
    
    // Aquí ajustamos la imagen y los textos usando clases de Bootstrap y CSS inline
    row.innerHTML = `
        <td class="align-middle text-center py-2">
            <img src="${elemento.imagen}" style="width: 50px; height: 50px; object-fit: cover; border-radius: 8px; border: 2px solid white;" />
        </td>
        <td class="align-middle text-dark font-weight-bold">
            ${elemento.titulo}
        </td>
        <td class="align-middle text-dark">
            <small>${elemento.categoria}</small>
        </td>
        <td class="align-middle text-center">
            <a href="#" class="borrar text-white" data-id="${elemento.id}">X</a>
        </td>
    `;
    lista.appendChild(row);
}

function eliminarElemento(e){
    e.preventDefault();
    let elemento,
        elementosId;

    if(e.target.classList.contains('borrar')) {
        e.target.parentElement.parentElement.remove();
        elemento = e.target.parentElement.parentElement;
        elementosId = elemento.querySelector('a').getAttribute('data-id');
    }
}

function vaciarCajita() {
    while(lista.firstChild) {
        lista.removeChild(lista.firstChild);
    }
    return false;
}