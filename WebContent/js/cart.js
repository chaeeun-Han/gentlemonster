   calculateTotal();
    let initialCartState = {};
       
    //수정 요청
    window.updateCart = function update() {
       const updatedItems = [];
       
       document.querySelectorAll('.item').forEach(item => {
          const cartId = item.dataset.cartid;
          const currentQuantity = parseInt(item.querySelector('.quantity').textContent, 10);
          
          if (initialCartState[cartId] !== currentQuantity) {
                updatedItems.push({
                    cartId: cartId,
                    quantity: currentQuantity
                });
            }
        });
        
        if (updatedItems.length > 0) {
           fetch('/shop/cart?action=UPDATE', {
              method: 'POST',
              headers: {
                 'Content-Type': 'application/json'
                },
                body: JSON.stringify({
                   updatedItems: updatedItems
                })
            })
            .then(response => {
                if (!response.ok) {
                    console.warn('Cart update may have failed.');
                }
            })
            .catch(error => {
                console.error('Error updating cart:', error);
            });
        } else {
            console.log('No changes detected.');
        }
    }
    
    // 초기 장바구니 상태 저장
    document.querySelectorAll('.item').forEach(item => {
        const cartId = item.dataset.cartid;
        const quantity = parseInt(item.querySelector('.quantity').textContent, 10);
        initialCartState[cartId] = quantity;
    });
    
    // 수량 감소
   function decreaseEvent() {
       let decreaseButtons = document.querySelectorAll('.decrease');
       let quantityDisplays = document.querySelectorAll('.quantity');
   
       decreaseButtons.forEach((button, index) => {
           button.onclick = function() {
               let currentQuantity = parseInt(quantityDisplays[index].innerText);
               if (currentQuantity > 1) {
                   quantityDisplays[index].innerText = currentQuantity - 1;
                   calculateTotal();
               }
           }
       });
   }
   
   // 수량 증가
   function increaseEvent() {
       let increaseButtons = document.querySelectorAll('.increase');
       let quantityDisplays = document.querySelectorAll('.quantity');
   
       increaseButtons.forEach((button, index) => {
           button.onclick = function() {
               let currentQuantity = parseInt(quantityDisplays[index].innerText);
               quantityDisplays[index].innerText = currentQuantity + 1;
               calculateTotal();
           }
       });   
   }
    
    //가격 합계 계산
    function calculateTotal() {
       let total = 0;
       const items = document.querySelectorAll('.item');
   
       items.forEach(item => {
           const priceText = item.querySelector('.item-price').textContent.replace(/,/g, '');
           const price = parseInt(priceText, 10) || 0;
           const quantity = parseInt(item.querySelector('.quantity').textContent, 10) || 0;
           total += price * quantity;
       });
   
       // 합계 업데이트
       const totalAmountElement = document.getElementById('totalAmount');
       if (totalAmountElement) {
           totalAmountElement.textContent = formatNumber(total);
       }
   }
   
   function formatNumber(number) {
       return number.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
   }
   
// 구매하기 버튼을 눌렀을 때 발생할 때
function handlePurchase() {
    	console.log("나는 버튼을 눌렀다!!");

    const form = document.querySelector("form");
    form.action = "/shop/purchase"; // 명시적으로 설정    
    const items = document.querySelectorAll(".item");

    // 모든 hidden input 초기화
    form.querySelectorAll('input[type="hidden"]').forEach((input) => input.remove());

    let hasCheckedItems = false;

    // 각 아이템의 데이터를 hidden input으로 추가
    items.forEach((item) => {
        const checkbox = item.querySelector(".checkbox");
        if (checkbox.checked) {
            hasCheckedItems = true;

            const productId = item.dataset.cartid;
            const productName = item.querySelector(".item-name").textContent.trim();
            const productCount = parseInt(item.querySelector(".quantity").textContent, 10);
            const price = parseInt(item.querySelector(".item-price").textContent.replace(/,/g, ""), 10);
            const imgUrl = item.querySelector(".item-image").src;

            // hidden input 추가
            form.innerHTML += `
                <input type="hidden" name="productId" value="${productId}">
                <input type="hidden" name="productName" value="${productName}">
                <input type="hidden" name="productCount" value="${productCount}">
                <input type="hidden" name="price" value="${price}">
                <input type="hidden" name="imgUrl" value="${imgUrl}">
            `;
        }
    });

    // 체크된 아이템이 없을 경우 처리
    if (!hasCheckedItems) {
        alert("구매할 상품을 선택해주세요.");
        return;
    }

    // 폼 제출
    form.submit();
}