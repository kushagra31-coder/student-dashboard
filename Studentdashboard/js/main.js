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
     7. PARTICLE / FLOATING ORB BACKGROUND
     ------------------------------------------ */
  const canvas = document.getElementById('particle-canvas');
  if (canvas) {
    const ctx = canvas.getContext('2d');
    let width, height, orbs;

    function resizeCanvas() {
      width = canvas.width = window.innerWidth;
      height = canvas.height = window.innerHeight;
    }

    class Orb {
      constructor() {
        this.reset();
      }

      reset() {
        this.x = Math.random() * width;
        this.y = Math.random() * height;
        this.radius = Math.random() * 2.5 + 0.5;
        this.vx = (Math.random() - 0.5) * 0.3;
        this.vy = (Math.random() - 0.5) * 0.3;
        this.opacity = Math.random() * 0.4 + 0.1;
        this.opacityDir = (Math.random() - 0.5) * 0.005;

        // Choose a random accent color
        const colors = [
          [0, 212, 255],    // blue
          [124, 58, 237],   // purple
          [244, 114, 182],  // pink
        ];
        this.color = colors[Math.floor(Math.random() * colors.length)];
      }

      update() {
        this.x += this.vx;
        this.y += this.vy;

        // Oscillate opacity
        this.opacity += this.opacityDir;
        if (this.opacity > 0.5 || this.opacity < 0.05) {
          this.opacityDir *= -1;
        }

        // Wrap around edges
        if (this.x < -10) this.x = width + 10;
        if (this.x > width + 10) this.x = -10;
        if (this.y < -10) this.y = height + 10;
        if (this.y > height + 10) this.y = -10;
      }

      draw() {
        const [r, g, b] = this.color;
        ctx.beginPath();
        ctx.arc(this.x, this.y, this.radius, 0, Math.PI * 2);
        ctx.fillStyle = `rgba(${r}, ${g}, ${b}, ${this.opacity})`;
        ctx.fill();

        // Subtle glow
        if (this.radius > 1.5) {
          ctx.beginPath();
          ctx.arc(this.x, this.y, this.radius * 3, 0, Math.PI * 2);
          ctx.fillStyle = `rgba(${r}, ${g}, ${b}, ${this.opacity * 0.15})`;
          ctx.fill();
        }
      }
    }

    function initOrbs() {
      const count = Math.min(80, Math.floor((width * height) / 15000));
      orbs = Array.from({ length: count }, () => new Orb());
    }

    function animate() {
      ctx.clearRect(0, 0, width, height);

      orbs.forEach(orb => {
        orb.update();
        orb.draw();
      });

      // Draw subtle connection lines between nearby orbs
      for (let i = 0; i < orbs.length; i++) {
        for (let j = i + 1; j < orbs.length; j++) {
          const dx = orbs[i].x - orbs[j].x;
          const dy = orbs[i].y - orbs[j].y;
          const dist = Math.sqrt(dx * dx + dy * dy);
          if (dist < 120) {
            const alpha = (1 - dist / 120) * 0.08;
            ctx.beginPath();
            ctx.moveTo(orbs[i].x, orbs[i].y);
            ctx.lineTo(orbs[j].x, orbs[j].y);
            ctx.strokeStyle = `rgba(124, 58, 237, ${alpha})`;
            ctx.lineWidth = 0.5;
            ctx.stroke();
          }
        }
      }

      requestAnimationFrame(animate);
    }

    resizeCanvas();
    initOrbs();
    animate();

    let resizeTimeout;
    window.addEventListener('resize', () => {
      clearTimeout(resizeTimeout);
      resizeTimeout = setTimeout(() => {
        resizeCanvas();
        initOrbs();
      }, 250);
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
