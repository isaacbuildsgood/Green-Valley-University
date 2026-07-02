@'
$departments = @(
    @{slug='biology'; title='Biology'; overview='Biology explores living systems from molecules to ecosystems, combining laboratory work with field studies and research opportunities.'; degrees=@('ba','ma','phd')},
    @{slug='chemistry'; title='Chemistry'; overview='Chemistry provides strong fundamentals in analytical, organic, and physical chemistry with practical lab experience and research.'; degrees=@('ba','ma','phd')},
    @{slug='physics'; title='Physics'; overview='Physics emphasizes theoretical foundations and experimental techniques across classical and modern physics.'; degrees=@('ba','ma','phd')},
    @{slug='mathematics'; title='Mathematics'; overview='Mathematics covers pure and applied topics, fostering analytical reasoning and problem-solving abilities.'; degrees=@('ba','ma','phd')},
    @{slug='engineering'; title='Engineering'; overview='Engineering covers multiple disciplines including civil, mechanical, electrical and chemical engineering.'; degrees=@('ba','ma','phd')},
    @{slug='civil-engineering'; title='Civil Engineering'; overview='Civil Engineering focuses on infrastructure, structural design, transportation, and environmental engineering.'; degrees=@('ba','ma','phd')},
    @{slug='mechanical-engineering'; title='Mechanical Engineering'; overview='Mechanical Engineering covers dynamics, thermodynamics, and design of mechanical systems.'; degrees=@('ba','ma','phd')},
    @{slug='electrical-engineering'; title='Electrical Engineering'; overview='Electrical Engineering explores circuits, communications, and power systems.'; degrees=@('ba','ma','phd')},
    @{slug='chemical-engineering'; title='Chemical Engineering'; overview='Chemical Engineering integrates chemistry and engineering to design processes and materials.'; degrees=@('ba','ma','phd')},
    @{slug='medicine'; title='Medicine'; overview='Medicine prepares students for clinical practice and medical research with extensive practical training.'; degrees=@('md')},
    @{slug='nursing'; title='Nursing'; overview='Nursing combines clinical practice, theoretical knowledge, and patient care to prepare healthcare professionals.'; degrees=@('ba','ma','phd')},
    @{slug='pharmacy'; title='Pharmacy'; overview='Pharmacy trains students in pharmaceutical sciences, medicinal chemistry, and clinical pharmacy practice.'; degrees=@('ba','ma','phd')},
    @{slug='dentistry'; title='Dentistry'; overview='Dentistry prepares students for oral health practice with comprehensive clinical and theoretical training.'; degrees=@('ba','ma','phd')},
    @{slug='public-health'; title='Public Health'; overview='Public Health addresses community health challenges through epidemiology, policy, and health promotion.'; degrees=@('ba','ma','phd')},
    @{slug='law'; title='Law'; overview='Law offers doctrinal training, practical clinics, and opportunities in legal research and advocacy.'; degrees=@('ba','ma','phd')},
    @{slug='legal-studies'; title='Legal Studies'; overview='Legal Studies provides comprehensive training in legal theory, practice, and professional skills.'; degrees=@('ba','ma','phd')},
    @{slug='accounting'; title='Accounting'; overview='Accounting educates students in financial reporting, auditing, and accounting analytics.'; degrees=@('ba','ma','phd')},
    @{slug='business-administration'; title='Business Administration'; overview='Business Administration covers management, finance, marketing and entrepreneurship with practical projects.'; degrees=@('ba','ma','phd')},
    @{slug='marketing'; title='Marketing'; overview='Marketing focuses on consumer behaviour, analytics, and strategic brand management.'; degrees=@('ba','ma','phd')},
    @{slug='finance'; title='Finance'; overview='Finance covers corporate finance, investments, and financial markets with quantitative training.'; degrees=@('ba','ma','phd')},
    @{slug='history'; title='History'; overview='History examines societies, cultures, and events to build critical perspectives on the past and present.'; degrees=@('ba','ma','phd')},
    @{slug='philosophy'; title='Philosophy'; overview='Philosophy develops skills in critical thinking, ethics, and logic applicable across disciplines.'; degrees=@('ba','ma','phd')},
    @{slug='sociology'; title='Sociology'; overview='Sociology investigates social systems, inequality, and cultural practices through research and fieldwork.'; degrees=@('ba','ma','phd')},
    @{slug='environmental-science'; title='Environmental Science'; overview='Environmental Science blends fieldwork and lab research to address environmental challenges.'; degrees=@('ba','ma','phd')},
    @{slug='criminal-justice'; title='Criminal Justice'; overview='Criminal Justice prepares students to understand the legal system, enforcement, and corrections.'; degrees=@('ba','ma','phd')},
    @{slug='human-rights'; title='Human Rights'; overview='Human Rights examines international law, advocacy, and social justice through an interdisciplinary lens.'; degrees=@('ba','ma','phd')},
    @{slug='international-business'; title='International Business'; overview='International Business covers global markets, trade, and cross-cultural management.'; degrees=@('ba','ma','phd')},
    @{slug='international-law'; title='International Law'; overview='International Law addresses treaties, diplomacy, and cross-border legal frameworks.'; degrees=@('ba','ma','phd')},
    @{slug='english-literature'; title='English Literature'; overview='The Department of English Literature offers interdisciplinary study in literary history, criticism, and creative writing, preparing students for careers in education, research, and the creative industries.'; degrees=@('ba','ma','phd')}
)

$degreeInfo = @{
    'ba' = @{title='Bachelor of Arts'; level='Undergraduate'; duration='4 Years'}
    'md' = @{title='MD'; level='Medical'; duration='5-6 Years'}
    'ma' = @{title='Master of Arts'; level='Graduate'; duration='2 Years'}
    'phd' = @{title='PhD'; level='Doctoral'; duration='3-6 Years'}
}

foreach ($dept in $departments) {
    $slug = $dept.slug
    $title = $dept.title
    $overview = $dept.overview
    $filename = "$slug-courses.html"
    
    if (Test-Path $filename) {
        Write-Host "Skipping $filename (already exists)"
        continue
    }
    
    $cards = ""
    foreach ($deg in $dept.degrees) {
        $degTitle = $degreeInfo[$deg].title
        $degLevel = $degreeInfo[$deg].level
        $degDuration = $degreeInfo[$deg].duration
        
        if ($deg -eq 'md') {
            $link = "$slug.html"
        } else {
            $link = "$deg-$slug.html"
        }
        
        $cards += @"
          <div class="course-card" data-level="$deg">
            <h3>$degTitle in $title</h3>
            <p class="degree">$degLevel</p>
            <p class="duration">$degDuration</p>
            <p>$overview</p>
            <a href="$link" class="btn">View Course</a>
          </div>

"@
    }
    
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
    
    Set-Content -Path $filename -Value $html -Encoding UTF8
    Write-Host " Created $filename"
}

Write-Host "Done!"
'@ | Set-Content -Path create_courses.ps1 -Encoding UTF8
powershell -NoProfile -ExecutionPolicy Bypass -File create_courses.ps1
