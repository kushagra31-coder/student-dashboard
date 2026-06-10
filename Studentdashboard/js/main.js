/* ============================================
   STUDENT PORTFOLIO DASHBOARD — Main JavaScript
   ============================================ */

document.addEventListener('DOMContentLoaded', () => {

  /* ------------------------------------------
     1. INTERSECTION OBSERVER — Scroll Animations
     ------------------------------------------ */
  const observerOptions = {
    root: null,
    rootMargin: '0px 0px -60px 0px',
    threshold: 0.1
  };

  const animationObserver = new IntersectionObserver((entries) => {
    entries.forEach(entry => {
      if (entry.isIntersecting) {
        entry.target.classList.add('visible');
        animationObserver.unobserve(entry.target);
      }
    });
  }, observerOptions);

  document.querySelectorAll('.fade-in-up, .fade-in-left, .fade-in-right, .reveal').forEach(el => {
    animationObserver.observe(el);
  });

  /* ------------------------------------------
     2. ANIMATED SKILL BARS — Fill on Scroll
     ------------------------------------------ */
  const skillObserver = new IntersectionObserver((entries) => {
    entries.forEach(entry => {
      if (entry.isIntersecting) {
        const fill = entry.target.querySelector('.skill-bar-fill');
        if (fill) {
          const target = fill.getAttribute('data-width') || '0';
          setTimeout(() => {
            fill.style.width = target + '%';
            fill.classList.add('filled');
          }, 200);
        }
        skillObserver.unobserve(entry.target);
      }
    });
  }, { threshold: 0.3 });

  document.querySelectorAll('.skill-item').forEach(el => {
    skillObserver.observe(el);
  });

  /* ------------------------------------------
     3. NAVBAR — Scroll Effect & Active Link
     ------------------------------------------ */
  const navbar = document.querySelector('.nav-glass');

  if (navbar) {
    const handleNavScroll = () => {
      if (window.scrollY > 50) {
        navbar.classList.add('scrolled');
      } else {
        navbar.classList.remove('scrolled');
      }
    };
    window.addEventListener('scroll', handleNavScroll, { passive: true });
    handleNavScroll();

    const currentPath = window.location.pathname;
    navbar.querySelectorAll('.nav-link').forEach(link => {
      const href = link.getAttribute('href');
      if (href && currentPath.endsWith(href.replace(/.*\//, '/'))) {
        link.classList.add('active');
      }
    });
  }

  /* ------------------------------------------
     4. SMOOTH SCROLL — Anchor Links
     ------------------------------------------ */
  document.querySelectorAll('a[href^="#"]').forEach(anchor => {
    anchor.addEventListener('click', (e) => {
      const targetId = anchor.getAttribute('href');
      if (targetId === '#') return;
      const targetEl = document.querySelector(targetId);
      if (targetEl) {
        e.preventDefault();
        const navHeight = parseInt(getComputedStyle(document.documentElement).getPropertyValue('--nav-height')) || 72;
        const top = targetEl.getBoundingClientRect().top + window.pageYOffset - navHeight - 20;
        window.scrollTo({ top, behavior: 'smooth' });
      }
    });
  });

  /* ------------------------------------------
     5. CONTACT FORM — AJAX Submission
     ------------------------------------------ */
  const contactForm = document.getElementById('contactForm');
  if (contactForm) {
    contactForm.addEventListener('submit', (e) => {
      e.preventDefault();

      const submitBtn = contactForm.querySelector('button[type="submit"]');
      const originalText = submitBtn.innerHTML;
      submitBtn.innerHTML = '<span class="spinner-border spinner-border-sm me-2"></span>Sending...';
      submitBtn.disabled = true;

      const formData = new FormData(contactForm);

      fetch(contactForm.action, {
        method: 'POST',
        body: formData,
        headers: {
          'X-Requested-With': 'XMLHttpRequest'
        }
      })
      .then(response => {
        if (response.ok) {
          return response.text();
        }
        throw new Error('Network response was not ok');
      })
      .then(() => {
        showFeedback('success', 'Message sent successfully! We\'ll get back to you soon.');
        contactForm.reset();
      })
      .catch(() => {
        showFeedback('error', 'Something went wrong. Please try again later.');
      })
      .finally(() => {
        submitBtn.innerHTML = originalText;
        submitBtn.disabled = false;
      });
    });
  }

  function showFeedback(type, message) {
    const existing = document.querySelector('.ajax-feedback');
    if (existing) existing.remove();

    const alertClass = type === 'success' ? 'alert-glass-success' : 'alert-glass-error';
    const icon = type === 'success' ? 'bi-check-circle-fill' : 'bi-exclamation-triangle-fill';

    const div = document.createElement('div');
    div.className = `alert-glass ${alertClass} ajax-feedback fade-in-up visible mb-4`;
    div.innerHTML = `<i class="bi ${icon} me-2"></i>${message}`;

    const form = document.getElementById('contactForm');
    if (form) {
      form.parentNode.insertBefore(div, form);
      setTimeout(() => {
        div.style.opacity = '0';
        div.style.transform = 'translateY(-10px)';
        setTimeout(() => div.remove(), 400);
      }, 6000);
    }
  }

  /* ------------------------------------------
     6. TYPING ANIMATION — Hero Subtitle
     ------------------------------------------ */
  const typingEl = document.querySelector('.typing-text');
  if (typingEl) {
    const phrases = JSON.parse(typingEl.getAttribute('data-phrases') || '[]');
    if (phrases.length === 0) {
      phrases.push(
        'Showcasing Student Excellence',
        'Building Tomorrow\'s Innovators',
        'Code \u00B7 Create \u00B7 Collaborate'
      );
    }

    let phraseIndex = 0;
    let charIndex = 0;
    let isDeleting = false;
    let typeSpeed = 60;

    function typeLoop() {
      const current = phrases[phraseIndex];

      if (isDeleting) {
        typingEl.textContent = current.substring(0, charIndex - 1);
        charIndex--;
        typeSpeed = 30;
      } else {
        typingEl.textContent = current.substring(0, charIndex + 1);
        charIndex++;
        typeSpeed = 70;
      }

      if (!isDeleting && charIndex === current.length) {
        typeSpeed = 2000;
        isDeleting = true;
      } else if (isDeleting && charIndex === 0) {
        isDeleting = false;
        phraseIndex = (phraseIndex + 1) % phrases.length;
        typeSpeed = 500;
      }

      setTimeout(typeLoop, typeSpeed);
    }

    setTimeout(typeLoop, 800);
  }


  /* ------------------------------------------
     8. THEME TOGGLE (DARK/LIGHT)
     ------------------------------------------ */
  const themeToggle = document.getElementById('theme-toggle');
  if (themeToggle) {
      const savedTheme = localStorage.getItem('theme') || 'dark';
      document.documentElement.setAttribute('data-theme', savedTheme);
      updateToggleIcon(savedTheme);
      
      themeToggle.addEventListener('click', () => {
          const current = document.documentElement.getAttribute('data-theme') || 'dark';
          const next = current === 'dark' ? 'light' : 'dark';
          document.documentElement.setAttribute('data-theme', next);
          localStorage.setItem('theme', next);
          updateToggleIcon(next);
      });
  }

  function updateToggleIcon(theme) {
      const btn = document.getElementById('theme-toggle');
      if (!btn) return;
      const iconStr = theme === 'dark' ? '<i class="bi bi-sun-fill" style="color:#ff9e00;"></i>' : '<i class="bi bi-moon-fill" style="color:#7a00ff;"></i>';
      const textStr = theme === 'dark' ? 'Light Mode' : 'Dark Mode';
      
      const textSpan = document.getElementById('theme-text');
      if (textSpan) {
          btn.innerHTML = iconStr + '<span id="theme-text">' + textStr + '</span>';
      } else {
          btn.innerHTML = iconStr;
      }
  }

  /* ------------------------------------------
     9. PASSWORD VISIBILITY TOGGLE
     ------------------------------------------ */
  const pwdToggle = document.getElementById('pwd-toggle');
  const pwdInput = document.querySelector('input[name="password"]');
  if (pwdToggle && pwdInput) {
      pwdToggle.addEventListener('click', () => {
          const isPassword = pwdInput.type === 'password';
          pwdInput.type = isPassword ? 'text' : 'password';
          pwdToggle.innerHTML = isPassword ? '<i class="bi bi-eye-slash-fill"></i>' : '<i class="bi bi-eye-fill"></i>';
      });
  }

  /* ------------------------------------------
     10. PROJECT FILTER (projects page)
     ------------------------------------------ */
  const filterBtns = document.querySelectorAll('.filter-btn');
  if (filterBtns.length > 0) {
    filterBtns.forEach(btn => {
      btn.addEventListener('click', () => {
        filterBtns.forEach(b => b.classList.remove('active'));
        btn.classList.add('active');

        const filter = btn.getAttribute('data-filter');
        const cards = document.querySelectorAll('.project-filter-item');

        cards.forEach(card => {
          if (filter === 'all' || card.getAttribute('data-category') === filter) {
            card.style.display = '';
            setTimeout(() => card.querySelector('.fade-in-up')?.classList.add('visible'), 50);
          } else {
            card.style.display = 'none';
          }
        });
      });
    });
  }

  /* ------------------------------------------
     11. BOOTSTRAP NAVBAR COLLAPSE — Auto-close on link click (mobile)
     ------------------------------------------ */
  const navCollapse = document.querySelector('.navbar-collapse');
  if (navCollapse) {
    document.querySelectorAll('.navbar-nav .nav-link').forEach(link => {
      link.addEventListener('click', () => {
        if (window.innerWidth < 992) {
          const bsCollapse = bootstrap.Collapse.getInstance(navCollapse);
          if (bsCollapse) bsCollapse.hide();
        }
      });
    });
  }

  /* ------------------------------------------
     12. COUNT-UP ANIMATION — Dashboard Stats
     ------------------------------------------ */
  const statNumbers = document.querySelectorAll('.stat-number');
  if (statNumbers.length > 0) {
    const statObserver = new IntersectionObserver((entries) => {
      entries.forEach(entry => {
        if (entry.isIntersecting) {
          const el = entry.target;
          const target = parseInt(el.getAttribute('data-target'), 10) || 0;
          let current = 0;
          
          if (target > 0) {
            const duration = 2000;
            const stepTime = Math.max(10, Math.floor(duration / target));
            
            const timer = setInterval(() => {
              let increment = Math.ceil(target / (duration / stepTime));
              current += increment;
              if (current >= target) {
                current = target;
                clearInterval(timer);
              }
              el.innerText = current;
            }, stepTime);
          } else {
            el.innerText = target;
          }
          statObserver.unobserve(el);
        }
      });
    }, { threshold: 0.1 });
    
    statNumbers.forEach(stat => statObserver.observe(stat));
  }

});
