document.addEventListener('DOMContentLoaded', function() {
    const params = new URLSearchParams(window.location.search);
    const selectedId = params.get('smallCategoryId');

    console.log('selectedId:', selectedId);  

    if (selectedId) {
        const selectedItem = document.querySelector(`#item-${selectedId} img`);
        if (selectedItem) {
            selectedItem.style.border = '1px solid black';
            selectedItem.style.padding = '3px';
            selectedItem.style.backgroundColor = 'white';
        }
    }
});
