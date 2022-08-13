document.addEventListener('DOMContentLoaded', function(){ //これを定義することにより、今からquerySelectorを使うよーみたいな感じで宣言してあげてる感じらしい！これがないと読み込まれない

  var swiper = new Swiper(".mySwiper", {
    
    navigation: {
      nextEl: ".swiper-button-next",
      prevEl: ".swiper-button-prev",
    },
    pagination: {
    el: ".swiper-pagination"
    },
  });

  const container = document.querySelector('.mySwiper');
  const prev_button =  document.querySelector('.mySwiper .swiper-button-prev');
  const next_button =  document.querySelector('.mySwiper .swiper-button-next');
  
  container.addEventListener('mouseenter', () => {
    // hover クラスを追加
    prev_button.classList.add('hover');
    next_button.classList.add('hover');
  });
  //マウスアウトイベント
  container.addEventListener('mouseleave', () => {
    // hover クラスを削除
    prev_button.classList.remove('hover');
    next_button.classList.remove('hover');
  });
  
  });