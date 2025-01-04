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