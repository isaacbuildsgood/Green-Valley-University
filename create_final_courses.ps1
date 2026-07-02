create-page -slug medicine -title Medicine
create-page -slug nursing -title Nursing
create-page -slug pharmacy -title Pharmacy  
create-page -slug dentistry -title Dentistry
create-page -slug public-health -title "Public Health"
create-page -slug law -title Law
create-page -slug legal-studies -title "Legal Studies"
create-page -slug accounting -title Accounting
create-page -slug business-administration -title "Business Administration"
create-page -slug marketing -title Marketing
create-page -slug finance -title Finance
create-page -slug history -title History
create-page -slug philosophy -title Philosophy
create-page -slug sociology -title Sociology
create-page -slug environmental-science -title "Environmental Science"
create-page -slug criminal-justice -title "Criminal Justice"
create-page -slug human-rights -title "Human Rights"
create-page -slug international-business -title "International Business"
create-page -slug international-law -title "International Law"
create-page -slug english-literature -title "English Literature"

function create-page {
    param($slug, $title)
    $filename = "$slug-courses.html"
    if (Test-Path $filename) { return }
    
    $cards = ''
    foreach ($deg in ('ba', 'md', 'ma', 'phd')) {
        $link = if ($deg -eq 'md') { "$slug.html" } else { "$deg-$slug.html" }
        if (-not (Test-Path $link)) { continue }
        
        $degTitle = @{'ba'='Bachelor of Arts'; 'md'='MD'; 'ma'='Master of Arts'; 'phd'='PhD'}[$deg]
        $degLevel = @{'ba'='Undergraduate'; 'md'='Medical'; 'ma'='Graduate'; 'phd'='Doctoral'}[$deg]
        $duration = @{'ba'='4 Years'; 'md'='5-6 Years'; 'ma'='2 Years'; 'phd'='3-6 Years'}[$deg]
        
        $cards += @"
          <div class="course-card" data-level="$deg">
            <h3>$degTitle in $title</h3>
            <p class="degree">$degLevel</p>
            <p class="duration">$duration</p>
            <p>Department of $title academic programs.</p>
            <a href="$link" class="btn">View Course</a>
          </div>

"@
    }
    
    if ($cards -eq '') { return }
    
    $html = @"
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Green Valley University - $title Courses</title>
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
        <h1>All Courses - Department of $title</h1>
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
$cards        </div>
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
"@
    
    Set-Content -Path $filename -Value $html
    Write-Host "Created $filename"
}
