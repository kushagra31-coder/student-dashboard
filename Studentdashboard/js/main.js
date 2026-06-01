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
        // Once animated, stop observing for performance
        animationObserver.unobserve(entry.target);
      }
    });
  }, observerOptions);

  // Observe all animation-trigger elements
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
          // Small delay so the animation is visible
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
    // Add "scrolled" class when page is scrolled
    const handleNavScroll = () => {
      if (window.scrollY > 50) {
        navbar.classList.add('scrolled');
      } else {
        navbar.classList.remove('scrolled');
      }
    };
    window.addEventListener('scroll', handleNavScroll, { passive: true });
    handleNavScroll(); // run on load

    // Active link highlighting
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
    // Remove existing feedback
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
      // Auto-remove after 6 seconds
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
        typeSpeed = 2000; // Pause at end
        isDeleting = true;
      } else if (isDeleting && charIndex === 0) {
        isDeleting = false;
        phraseIndex = (phraseIndex + 1) % phrases.length;
        typeSpeed = 500; // Pause before next phrase
      }

      setTimeout(typeLoop, typeSpeed);
    }

    // Start after a short delay
    setTimeout(typeLoop, 800);
  }

  /* ------------------------------------------
     7. EPIC SPACE BACKGROUND
     ------------------------------------------ */
  const canvas = document.getElementById('particle-canvas');
  if (canvas) {
    const ctx = canvas.getContext('2d');
    let width, height;
    
    // Elements
    let stars = [];
    let planets = [];
    let shootingStars = [];
    let angle = 0; // For rotation

    function resizeCanvas() {
      width = canvas.width = window.innerWidth;
      height = canvas.height = window.innerHeight;
    }

    class Star {
      constructor() {
        this.x = Math.random() * width;
        this.y = Math.random() * height;
        this.r = Math.random() * 1.5;
        this.alpha = Math.random();
        this.fade = (Math.random() * 0.02) + 0.005;
      }
      update() {
        this.alpha += this.fade;
        if (this.alpha >= 1 || this.alpha <= 0.1) this.fade *= -1;
      }
      draw() {
        ctx.beginPath();
        ctx.arc(this.x, this.y, this.r, 0, Math.PI * 2);
        ctx.fillStyle = `rgba(255, 255, 255, ${this.alpha})`;
        ctx.fill();
      }
    }

    class Planet {
      constructor(dist, radius, speed, color) {
        this.dist = dist;
        this.radius = radius;
        this.speed = speed;
        this.color = color;
        this.angle = Math.random() * Math.PI * 2;
      }
      update() {
        this.angle += this.speed;
      }
      draw(cx, cy) {
        const x = cx + Math.cos(this.angle) * this.dist;
        const y = cy + Math.sin(this.angle) * this.dist;
        ctx.beginPath();
        ctx.arc(x, y, this.radius, 0, Math.PI * 2);
        ctx.fillStyle = this.color;
        ctx.shadowBlur = 15;
        ctx.shadowColor = this.color;
        ctx.fill();
        ctx.shadowBlur = 0; // reset
      }
    }

    class ShootingStar {
      constructor() {
        this.reset();
      }
      reset() {
        this.x = Math.random() * width;
        this.y = -50;
        this.len = Math.random() * 80 + 30;
        this.speed = Math.random() * 10 + 5;
        this.active = false;
        this.wait = Math.random() * 500 + 100; // frames to wait
      }
      update() {
        if (!this.active) {
          this.wait--;
          if (this.wait <= 0) this.active = true;
          return;
        }
        this.x -= this.speed;
        this.y += this.speed;
        if (this.x < 0 || this.y > height) this.reset();
      }
      draw() {
        if (!this.active) return;
        ctx.beginPath();
        ctx.moveTo(this.x, this.y);
        ctx.lineTo(this.x + this.len, this.y - this.len);
        const grad = ctx.createLinearGradient(this.x, this.y, this.x + this.len, this.y - this.len);
        grad.addColorStop(0, 'rgba(255, 255, 255, 1)');
        grad.addColorStop(1, 'rgba(255, 255, 255, 0)');
        ctx.strokeStyle = grad;
        ctx.lineWidth = 2;
        ctx.stroke();
      }
    }

    function initSpace() {
      stars = Array.from({ length: 250 }, () => new Star());
      planets = [
        new Planet(80, 4, 0.01, '#00d4ff'),
        new Planet(140, 8, 0.005, '#fb923c'),
        new Planet(220, 12, 0.002, '#34d399'),
        new Planet(300, 6, 0.003, '#f472b6')
      ];
      shootingStars = Array.from({ length: 3 }, () => new ShootingStar());
    }

    function drawNebula() {
      // Pink/Purple Nebula
      const g1 = ctx.createRadialGradient(width * 0.8, height * 0.2, 0, width * 0.8, height * 0.2, 500);
      g1.addColorStop(0, 'rgba(124, 58, 237, 0.15)');
      g1.addColorStop(1, 'rgba(0, 0, 0, 0)');
      ctx.fillStyle = g1;
      ctx.fillRect(0, 0, width, height);

      // Blue Nebula
      const g2 = ctx.createRadialGradient(width * 0.2, height * 0.8, 0, width * 0.2, height * 0.8, 400);
      g2.addColorStop(0, 'rgba(0, 212, 255, 0.1)');
      g2.addColorStop(1, 'rgba(0, 0, 0, 0)');
      ctx.fillStyle = g2;
      ctx.fillRect(0, 0, width, height);
    }

    function drawBlackHole() {
      const bhX = width * 0.85;
      const bhY = height * 0.8;
      
      // Accretion disk
      ctx.save();
      ctx.translate(bhX, bhY);
      ctx.rotate(angle * 2);
      ctx.scale(1, 0.3); // squash to make it look 3D
      
      const grad = ctx.createRadialGradient(0, 0, 40, 0, 0, 150);
      grad.addColorStop(0, 'rgba(0, 0, 0, 1)');
      grad.addColorStop(0.3, 'rgba(124, 58, 237, 0.8)');
      grad.addColorStop(0.6, 'rgba(0, 212, 255, 0.4)');
      grad.addColorStop(1, 'rgba(0, 0, 0, 0)');
      
      ctx.beginPath();
      ctx.arc(0, 0, 150, 0, Math.PI * 2);
      ctx.fillStyle = grad;
      ctx.fill();
      ctx.restore();

      // The hole itself
      ctx.beginPath();
      ctx.arc(bhX, bhY, 35, 0, Math.PI * 2);
      ctx.fillStyle = '#000';
      ctx.shadowBlur = 30;
      ctx.shadowColor = '#7c3aed';
      ctx.fill();
      ctx.shadowBlur = 0;
    }

    function drawSolarSystem() {
      const sunX = width * 0.15;
      const sunY = height * 0.25;

      // Sun Glow
      const glow = ctx.createRadialGradient(sunX, sunY, 20, sunX, sunY, 150);
      glow.addColorStop(0, 'rgba(251, 146, 60, 1)');
      glow.addColorStop(0.2, 'rgba(251, 146, 60, 0.4)');
      glow.addColorStop(1, 'rgba(0, 0, 0, 0)');
      ctx.beginPath();
      ctx.arc(sunX, sunY, 150, 0, Math.PI * 2);
      ctx.fillStyle = glow;
      ctx.fill();

      // Sun core
      ctx.beginPath();
      ctx.arc(sunX, sunY, 25, 0, Math.PI * 2);
      ctx.fillStyle = '#fffbeb';
      ctx.shadowBlur = 40;
      ctx.shadowColor = '#fb923c';
      ctx.fill();
      ctx.shadowBlur = 0;

      // Planets
      planets.forEach(p => p.draw(sunX, sunY));
    }

    function animate() {
      // Clear with slight trailing effect if we wanted it, but let's clear full
      ctx.clearRect(0, 0, width, height);

      // Light mode uses a different base, so we check if dark mode
      const isLight = document.documentElement.getAttribute('data-theme') === 'light';
      if (!isLight) {
          drawNebula();
          stars.forEach(s => { s.update(); s.draw(); });
          drawBlackHole();
          drawSolarSystem();
          shootingStars.forEach(s => { s.update(); s.draw(); });
      } else {
          // Subtle day stars or clear sky
          ctx.fillStyle = 'rgba(240, 244, 248, 0.5)';
          ctx.fillRect(0, 0, width, height);
      }

      angle += 0.005;
      planets.forEach(p => p.update());

      requestAnimationFrame(animate);
    }

    resizeCanvas();
    initSpace();
    animate();

    window.addEventListener('resize', () => {
      resizeCanvas();
      initSpace();
    });
  }

  /* ------------------------------------------
     11. THEME TOGGLE (DARK/LIGHT)
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
      btn.innerHTML = theme === 'dark' ? '<i class="bi bi-sun-fill" style="color:#fb923c;"></i>' : '<i class="bi bi-moon-fill" style="color:#1a0a2e;"></i>';
  }

  /* ------------------------------------------
     12. PASSWORD VISIBILITY TOGGLE
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
     8. PROJECT FILTER (projects page)
     ------------------------------------------ */
  const filterBtns = document.querySelectorAll('.filter-btn');
  if (filterBtns.length > 0) {
    filterBtns.forEach(btn => {
      btn.addEventListener('click', () => {
        // Update active state
        filterBtns.forEach(b => b.classList.remove('active'));
        btn.classList.add('active');

        const filter = btn.getAttribute('data-filter');
        const cards = document.querySelectorAll('.project-filter-item');

        cards.forEach(card => {
          if (filter === 'all' || card.getAttribute('data-category') === filter) {
            card.style.display = '';
            // Re-trigger animation
            setTimeout(() => card.querySelector('.fade-in-up')?.classList.add('visible'), 50);
          } else {
            card.style.display = 'none';
          }
        });
      });
    });
  }

  /* ------------------------------------------
     9. BOOTSTRAP NAVBAR COLLAPSE — Auto-close on link click (mobile)
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
     10. COUNT-UP ANIMATION — Dashboard Stats
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
            const duration = 2000; // 2 seconds
            const stepTime = Math.max(10, Math.floor(duration / target));
            // Using max(10) so it doesn't go too fast for large numbers
            
            // To ensure it always hits exactly 'duration', adjust steps:
            // But simple increment is fine for small numbers like 5, 8, 12, 6.
            const timer = setInterval(() => {
              // Increase by a proportional amount if target is very large, but our targets are small
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
