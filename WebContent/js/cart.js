
    calculateTotal();
    let initialCartState = {};
    
	function deleteItem(cartId) {
    	if (!cartId) {
    		console.warn('cartId is null');
    		return;
    	}
    	fetch(`/shop/cart?action=DELETE&cartid=${cartId}`, {
    		method: 'POST',
    		headers: {
    			'Content-Type': 'application/json'
            }
        })
        .then(response => {
            if (!response.ok) {
                console.warn('Item delete may have failed.');
            } else {
            	//cartId를 갖고 있는 아이템 화면에서 삭제
            	const itemElement = document.querySelector(`.item[data-cartid="${cartId}"]`);
            	if (itemElement) {
            		itemElement.remove();
            	}
            }
        })
        .catch(error => {
            console.error('Error deleting cart:', error);
        });
    }
    
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

    // 수량 관련 버튼 및 수량 표시를 각 아이템에 대해 다르게 처리
    const decreaseButtons = document.querySelectorAll('.decrease');
    const increaseButtons = document.querySelectorAll('.increase');
    const quantityDisplays = document.querySelectorAll('.quantity');

    // 각 버튼에 클릭 이벤트를 추가
    decreaseButtons.forEach((button, index) => {
        button.onclick = function() {
            let currentQuantity = parseInt(quantityDisplays[index].innerText);
            if (currentQuantity > 1) {
                quantityDisplays[index].innerText = currentQuantity - 1;
                calculateTotal();
            }
        }
    });

    increaseButtons.forEach((button, index) => {
        button.onclick = function() {
            let currentQuantity = parseInt(quantityDisplays[index].innerText);
            quantityDisplays[index].innerText = currentQuantity + 1;
            calculateTotal();
        }
    });
    
    //가격 합계 계산
    function calculateTotal() {
	    let total = 0;
	    const items = document.querySelectorAll('.item');
	
	    items.forEach(item => {
	        const price = parseInt(item.querySelector('.item-price').textContent, 10) || 0;
	        const quantity = parseInt(item.querySelector('.quantity').textContent, 10) || 0;
	        total += price * quantity;
	    });
	
	    // 합계 업데이트
	    const totalAmountElement = document.getElementById('totalAmount');
	    if (totalAmountElement) {
	        totalAmountElement.textContent = total;
	    }
	}