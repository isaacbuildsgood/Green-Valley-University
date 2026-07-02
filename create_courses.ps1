$departments = @(
    @{slug='chemistry'; title='Chemistry'},
    @{slug='physics'; title='Physics'},
    @{slug='mathematics'; title='Mathematics'},
    @{slug='engineering'; title='Engineering'},
    @{slug='civil-engineering'; title='Civil Engineering'},
    @{slug='mechanical-engineering'; title='Mechanical Engineering'},
    @{slug='electrical-engineering'; title='Electrical Engineering'},
    @{slug='chemical-engineering'; title='Chemical Engineering'},
    @{slug='medicine'; title='Medicine'},
    @{slug='nursing'; title='Nursing'},
    @{slug='pharmacy'; title='Pharmacy'},
    @{slug='dentistry'; title='Dentistry'},
    @{slug='public-health'; title='Public Health'},
    @{slug='law'; title='Law'},
    @{slug='legal-studies'; title='Legal Studies'},
    @{slug='accounting'; title='Accounting'},
    @{slug='business-administration'; title='Business Administration'},
    @{slug='marketing'; title='Marketing'},
    @{slug='finance'; title='Finance'},
    @{slug='history'; title='History'},
    @{slug='philosophy'; title='Philosophy'},
    @{slug='sociology'; title='Sociology'},
    @{slug='environmental-science'; title='Environmental Science'},
    @{slug='criminal-justice'; title='Criminal Justice'},
    @{slug='human-rights'; title='Human Rights'},
    @{slug='international-business'; title='International Business'},
    @{slug='international-law'; title='International Law'},
    @{slug='english-literature'; title='English Literature'}
)

$template = @'
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Green Valley University - {TITLE} Courses</title>
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
        <h1>All Courses - Department of {TITLE}</h1>
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
{CARDS}        </div>
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
'@

$baseDegrees = @{
    'ba' = @{title='Bachelor of Arts'; level='Undergraduate'; duration='4 Years'}
    'md' = @{title='MD'; level='Medical'; duration='5-6 Years'}
    'ma' = @{title='Master of Arts'; level='Graduate'; duration='2 Years'}
    'phd' = @{title='PhD'; level='Doctoral'; duration='3-6 Years'}
}

$count = 0
foreach ($dept in $departments) {
    $filename = "$($dept.slug)-courses.html"
    if (Test-Path $filename) { continue }
    
    # Determine which degrees exist
    $cards = ""
    foreach ($deg in ('ba', 'md', 'ma', 'phd')) {
        $baseFile = if ($deg -eq 'md') { "$($dept.slug).html" } else { "$deg-$($dept.slug).html" }
        if (-not (Test-Path $baseFile)) { continue }
        
        $degInfo = $baseDegrees[$deg]
        $link = $baseFile
        
        $cards += @"
          <div class="course-card" data-level="$deg">
            <h3>$($degInfo.title) in $($dept.title)</h3>
            <p class="degree">$($degInfo.level)</p>
            <p class="duration">$($degInfo.duration)</p>
            <p>Department of $($dept.title) academic programs.</p>
            <a href="$link" class="btn">View Course</a>
          </div>

"@
    }
    
    if ($cards.Length -eq 0) { continue }
    
    $html = $template.Replace('{TITLE}', $dept.title).Replace('{CARDS}', $cards)
    Set-Content -Path $filename -Value $html
    $count++
}

Write-Host "Created $count course pages"
