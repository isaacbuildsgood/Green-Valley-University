// JavaScript for interactivity

// Hamburger menu toggle
document.addEventListener('DOMContentLoaded', function() {
  const hamburger = document.querySelector('.hamburger');
  const navMenu = document.querySelector('.nav-menu');

  if (hamburger && navMenu) {
    hamburger.addEventListener('click', function() {
      navMenu.classList.toggle('active');
    });
  }

  // Close menu when clicking a link (for mobile)
  const navLinks = document.querySelectorAll('.nav-menu a');
  navLinks.forEach(link => {
    link.addEventListener('click', function() {
      navMenu.classList.remove('active');
    });
  });
});

// Simple accordion for FAQs or expandable sections
function toggleAccordion(element) {
  const content = element.nextElementSibling;
  if (content.style.display === 'block') {
    content.style.display = 'none';
  } else {
    content.style.display = 'block';
  }
}

// Modal functionality (for contact or details)
function openModal(modalId) {
  const modal = document.getElementById(modalId);
  if (modal) {
    modal.style.display = 'block';
  }
}

function closeModal(modalId) {
  const modal = document.getElementById(modalId);
  if (modal) {
    modal.style.display = 'none';
  }
}

// Close modal when clicking outside
window.onclick = function(event) {
  const modals = document.querySelectorAll('.modal');
  modals.forEach(modal => {
    if (event.target === modal) {
      modal.style.display = 'none';
    }
  });
};

// Carousel functionality
document.addEventListener('DOMContentLoaded', function() {
  const slides = document.querySelectorAll('.slide');
  const dots = document.querySelectorAll('.dot');
  let currentSlide = 0;
  const totalSlides = slides.length;

  // Function to show a specific slide
  function showSlide(index) {
    // Remove active class from all slides and dots
    slides.forEach(slide => slide.classList.remove('active'));
    dots.forEach(dot => dot.classList.remove('active'));
    
    // Add active class to current slide and dot
    slides[index].classList.add('active');
    dots[index].classList.add('active');
    
    currentSlide = index;
  }

  // Function to go to next slide
  function nextSlide() {
    currentSlide = (currentSlide + 1) % totalSlides;
    showSlide(currentSlide);
  }

  // Auto transition every 5 seconds
  setInterval(nextSlide, 5000);

  // Dot navigation
  dots.forEach(dot => {
    dot.addEventListener('click', function() {
      const slideIndex = parseInt(this.getAttribute('data-slide'));
      showSlide(slideIndex);
    });
  });
});

// Gallery Carousel functionality
document.addEventListener('DOMContentLoaded', function() {
  const gallerySlides = document.querySelectorAll('.gallery-slide');
  const galleryDots = document.querySelectorAll('.gallery-dot');
  let currentGallerySlide = 0;
  const totalGallerySlides = gallerySlides.length;

  // Function to show a specific gallery slide
  function showGallerySlide(index) {
    // Remove active class from all slides and dots
    gallerySlides.forEach(slide => slide.classList.remove('active'));
    galleryDots.forEach(dot => dot.classList.remove('active'));
    
    // Add active class to current slide and dot
    gallerySlides[index].classList.add('active');
    galleryDots[index].classList.add('active');
    
    currentGallerySlide = index;
  }

  // Function to go to next gallery slide
  function nextGallerySlide() {
    currentGallerySlide = (currentGallerySlide + 1) % totalGallerySlides;
    showGallerySlide(currentGallerySlide);
  }

  // Auto transition every 4 seconds
  setInterval(nextGallerySlide, 4000);

  // Dot navigation for gallery
  galleryDots.forEach(dot => {
    dot.addEventListener('click', function() {
      const slideIndex = parseInt(this.getAttribute('data-slide'));
      showGallerySlide(slideIndex);
    });
  });
});

/* Courses filter and contact form handling */

document.addEventListener('DOMContentLoaded', function() {
  // Courses filter (pages with .filter-btn and .course-card[data-level])
  const filterBtns = document.querySelectorAll('.filter-btn');
  const courseCards = document.querySelectorAll('.course-card');

  if (filterBtns.length && courseCards.length) {
    // Initialize aria-pressed states and apply initial filter based on .active (or default to first)
    let initialBtn = document.querySelector('.filter-btn.active') || filterBtns[0];
    filterBtns.forEach(b => {
      b.setAttribute('aria-pressed', b === initialBtn ? 'true' : 'false');
    });

    const initFilter = initialBtn.getAttribute('data-filter');
    courseCards.forEach(card => {
      const level = card.getAttribute('data-level');
      if (initFilter === 'all' || level === initFilter) {
        card.style.display = '';
      } else {
        card.style.display = 'none';
      }
    });

    filterBtns.forEach(btn => {
      btn.addEventListener('click', function() {
        // active state & aria
        filterBtns.forEach(b => { b.classList.remove('active'); b.setAttribute('aria-pressed', 'false'); });
        this.classList.add('active');
        this.setAttribute('aria-pressed', 'true');

        const filter = this.getAttribute('data-filter');
        courseCards.forEach(card => {
          const level = card.getAttribute('data-level');
          if (filter === 'all' || level === filter) {
            card.style.display = '';
          } else {
            card.style.display = 'none';
          }
        });
      });
    });
  }

  // Contact form (department contact page)
  const contactForm = document.getElementById('department-contact-form');
  if (contactForm) {
    contactForm.addEventListener('submit', function(e) {
      e.preventDefault();
      const name = document.getElementById('name').value.trim();
      const email = document.getElementById('email').value.trim();
      const message = document.getElementById('message').value.trim();
      const result = document.getElementById('contact-result');

      if (!name || !email || !message) {
        result.style.display = 'block';
        result.style.color = 'red';
        result.textContent = 'Please fill in name, email and message.';
        return;
      }

      // Simulate successful submission
      result.style.display = 'block';
      result.style.color = 'green';
      result.textContent = 'Thanks — your message has been sent. We will respond within 2-3 business days.';
      contactForm.reset();
    });
  }

  /* Program Structure: Collapsible ps-card behavior (reusable component) */
  const psHeaders = document.querySelectorAll('.ps-card-header');
  psHeaders.forEach(header => {
    const body = header.nextElementSibling;

    // enable keyboard interaction
    header.addEventListener('keydown', function(e) {
      if (e.key === 'Enter' || e.key === ' ') {
        e.preventDefault();
        header.click();
      }
    });

    header.addEventListener('click', function() {
      const expanded = header.getAttribute('aria-expanded') === 'true';
      header.setAttribute('aria-expanded', String(!expanded));
      if (body) {
        if (expanded) {
          body.classList.add('collapsed');
        } else {
          body.classList.remove('collapsed');
        }
      }
    });
  });

});