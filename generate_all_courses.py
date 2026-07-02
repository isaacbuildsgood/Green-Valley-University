#!/usr/bin/env python3
"""Generate course listing pages for all departments."""
import json
from pathlib import Path

# Load departments data
with open('data/courses.json', 'r', encoding='utf-8') as f:
    departments = json.load(f)

def make_course_cards(dept):
    """Generate HTML for course cards."""
    slug = dept['slug']
    title = dept['title']
    overview = dept.get('overview', 'Program overview')
    durations = dept.get('durations', {})
    
    cards_html = ""
    
    # Degree mapping: (key, display_title, level, order)
    degree_types = [
        ('ba', 'Bachelor of Arts', 'Undergraduate'),
        ('md', 'MD', 'Medical'),
        ('ma', 'Master of Arts', 'Graduate'),
        ('phd', 'PhD', 'Doctoral'),
    ]
    
    for deg_key, deg_title, deg_level in degree_types:
        if deg_key not in durations:
            continue
            
        # Determine link
        if deg_key == 'md':
            link = f'{slug}.html'
        else:
            link = f'{deg_key}-{slug}.html'
        
        duration = durations[deg_key]
        
        cards_html += f'''          <div class="course-card" data-level="{deg_key}">
            <h3>{deg_title} in {title}</h3>
            <p class="degree">{deg_level}</p>
            <p class="duration">{duration}</p>
            <p>{overview}</p>
            <a href="{link}" class="btn">View Course</a>
          </div>

'''
    
    return cards_html

def generate_course_page(dept):
    """Generate complete course listing page HTML."""
    slug = dept['slug']
    title = dept['title']
    cards = make_course_cards(dept)
    
    html = f'''<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Green Valley University - {title} Courses</title>
  <link rel="stylesheet" href="css/styles.css">
</head>
<body>
  <header class="navbar">
    <div class="nav-container">
      <div class="logo">Green Valley University</div>
      <ul class="nav-menu">
        <li><a href="index.html">Home</a></li>
        <li><a href="about.html">About</a></li>
        <li><a href="faculties.html">Faculties</a></li>
        <li><a href="admissions.html">Admissions</a></li>
        <li><a href="news.html">News & Events</a></li>
        <li><a href="contact.html">Contact</a></li>
      </ul>
      <div class="hamburger">
        <span class="bar"></span>
        <span class="bar"></span>
        <span class="bar"></span>
      </div>
    </div>
  </header>

  <main>
    <section class="hero">
      <div class="hero-content">
        <h1>All Courses - Department of {title}</h1>
        <p>Filter by degree level to find the right program.</p>
      </div>
    </section>

    <section class="section">
      <div class="container">
        <div class="filters" role="toolbar" aria-label="Course filters">
          <button type="button" class="filter-btn active" data-filter="all" aria-pressed="true">All</button>
          <button type="button" class="filter-btn" data-filter="undergraduate" aria-pressed="false">Undergraduate</button>
          <button type="button" class="filter-btn" data-filter="postgraduate" aria-pressed="false">Postgraduate</button>
          <button type="button" class="filter-btn" data-filter="phd" aria-pressed="false">PhD</button>
        </div>

        <div class="courses-grid course-list" style="margin-top:24px;">
{cards}        </div>
      </div>
    </section>
  </main>

  <footer class="footer">
    <div class="footer-content">
      <div class="footer-section">
        <h3>Contact Us</h3>
        <p>123 University Drive<br>Green Valley, GV 12345</p>
        <p>Phone: (123) 456-7890</p>
        <p>Email: info@gvuniversity.edu</p>
      </div>
    </div>
    <p>&copy; 2026 Green Valley University. All rights reserved.</p>
  </footer>

  <script src="js/script.js"></script>
</body>
</html>
'''
    return html

# Generate course pages for all departments
created_count = 0
for dept in departments:
    slug = dept['slug']
    filename = f"{slug}-courses.html"
    
    # Skip if already exists (like psychology-courses.html)
    if Path(filename).exists():
        continue
    
    html_content = generate_course_page(dept)
    with open(filename, 'w', encoding='utf-8') as f:
        f.write(html_content)
    
    created_count += 1

print(f"Created {created_count} course pages")

# List all course pages
import glob
files = glob.glob("*-courses.html")
print(f"Total course pages now: {len(files)}")
if files:
    for f in sorted(files)[:5]:
        print(f"  - {f}")
    if len(files) > 5:
        print(f"  ... and {len(files) - 5} more")
