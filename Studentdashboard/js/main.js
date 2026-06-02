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
     7. VAPORWAVE RETRO PERSPECTIVE GRID CANVAS
     ------------------------------------------ */
  const canvas = document.getElementById('particle-canvas');
  if (canvas) {
    const ctx = canvas.getContext('2d');
    let width, height;
    let gridOffset = 0;
    const speed = 0.035; // scrolling velocity

    function resizeCanvas() {
      width = canvas.width = window.innerWidth;
      height = canvas.height = window.innerHeight;
    }

    function drawSun(cx, cy, r, isLight) {
      ctx.save();
      // Draw Radial Sun Glow
      const glow = ctx.createRadialGradient(cx, cy, r * 0.1, cx, cy, r * 2.0);
      if (!isLight) {
        glow.addColorStop(0, 'rgba(255, 0, 127, 0.45)');
        glow.addColorStop(0.3, 'rgba(157, 78, 221, 0.2)');
        glow.addColorStop(1, 'rgba(0, 0, 0, 0)');
      } else {
        glow.addColorStop(0, 'rgba(255, 124, 0, 0.25)');
        glow.addColorStop(0.4, 'rgba(255, 77, 128, 0.08)');
        glow.addColorStop(1, 'rgba(0, 0, 0, 0)');
      }
      ctx.beginPath();
      ctx.arc(cx, cy, r * 2.0, 0, Math.PI * 2);
      ctx.fillStyle = glow;
      ctx.fill();

      // Sun Gradient (Sunset blend)
      const sunGrad = ctx.createLinearGradient(cx, cy - r, cx, cy + r);
      if (!isLight) {
        sunGrad.addColorStop(0, '#ffbd00');   // Sunset Yellow
        sunGrad.addColorStop(0.4, '#ff007f'); // Hot pink
        sunGrad.addColorStop(1, '#12052c');   // Merge into background deep purple
      } else {
        sunGrad.addColorStop(0, '#ff9e00');   // Neon Orange
        sunGrad.addColorStop(0.6, '#ff4d80'); // Coral Pink
        sunGrad.addColorStop(1, '#ffe6f2');   // Light background pink
      }

      ctx.beginPath();
      ctx.arc(cx, cy, r, 0, Math.PI * 2);
      ctx.fillStyle = sunGrad;
      ctx.fill();

      // Sun horizontal grid slices/stripes
      ctx.fillStyle = isLight ? '#ffe6f2' : '#09021a'; // Match background top-layer colors
      
      const numStripes = 7;
      for (let i = 0; i < numStripes; i++) {
        // Stripe vertical positions get thicker towards the bottom of the sun
        const stripeHeight = 2.5 + (i * 2.5);
        const stripeY = cy + (r * 0.15) + (i * (r * 0.11));
        
        if (stripeY < cy + r) {
          ctx.fillRect(cx - r - 10, stripeY, r * 2 + 20, stripeHeight);
        }
      }
      ctx.restore();
    }

    function drawGrid(horizon, isLight) {
      ctx.save();
      
      const gridColor = isLight ? 'rgba(0, 143, 149, 0.25)' : 'rgba(255, 0, 127, 0.35)';
      const horizonGlow = isLight ? 'rgba(0, 143, 149, 0.05)' : 'rgba(0, 242, 254, 0.12)';
      
      ctx.strokeStyle = gridColor;
      ctx.lineWidth = 1.5;

      const vanishingX = width / 2;
      const numRadials = 26;

      // 1. Perspective Radial Grid lines
      for (let i = -numRadials / 2; i <= numRadials / 2; i++) {
        const endX = vanishingX + (i * (width / 11));
        ctx.beginPath();
        ctx.moveTo(vanishingX, horizon);
        ctx.lineTo(endX, height);
        ctx.stroke();
      }

      // 2. Transverse scroll lines (depth-scaled using exponential curves)
      const numHorizontals = 11;
      for (let i = 0; i < numHorizontals; i++) {
        const ratio = (i + gridOffset) / numHorizontals;
        const lineY = horizon + Math.pow(ratio, 2.5) * (height - horizon);
        
        ctx.beginPath();
        ctx.moveTo(0, lineY);
        ctx.lineTo(width, lineY);
        ctx.stroke();
      }

      // 3. Horizon separator line
      ctx.strokeStyle = isLight ? 'rgba(0, 143, 149, 0.5)' : 'rgba(0, 242, 254, 0.6)';
      ctx.lineWidth = 2.5;
      ctx.beginPath();
      ctx.moveTo(0, horizon);
      ctx.lineTo(width, horizon);
      ctx.stroke();

      // Horizon Glow
      const horizonGrad = ctx.createLinearGradient(0, horizon, 0, height);
      horizonGrad.addColorStop(0, horizonGlow);
      horizonGrad.addColorStop(0.35, 'rgba(0,0,0,0)');
      ctx.fillStyle = horizonGrad;
      ctx.fillRect(0, horizon, width, height);

      ctx.restore();
    }

    function animate() {
      ctx.clearRect(0, 0, width, height);

      const isLight = document.documentElement.getAttribute('data-theme') === 'light';
      const horizon = height * 0.55;
      
      const sunR = Math.min(width, height) * 0.18;
      const sunX = width / 2;
      const sunY = horizon - 20;
      
      // Draw Sunset
      drawSun(sunX, sunY, sunR, isLight);
      
      // Draw grid perspective
      drawGrid(horizon, isLight);

      // Increment scroll animation
      gridOffset += speed;
      if (gridOffset >= 1) {
        gridOffset = 0;
      }

      requestAnimationFrame(animate);
    }

    resizeCanvas();
    animate();

    window.addEventListener('resize', () => {
      resizeCanvas();
    });
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
      const iconStr = theme === 'dark' ? '<i class="bi bi-sun-fill" style="color:#ff9e00; margin-right: 8px;"></i>' : '<i class="bi bi-moon-fill" style="color:#7a00ff; margin-right: 8px;"></i>';
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
