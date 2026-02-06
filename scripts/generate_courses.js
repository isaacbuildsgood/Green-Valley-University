const fs = require('fs');
const path = require('path');

const templatePath = path.join(__dirname, '..', 'templates', 'course-template.html');
const dataPath = path.join(__dirname, '..', 'data', 'courses.json');

const outDir = path.join(__dirname, '..');

function safeFileName(slug){
  return slug + '.html';
}

function makeDegreeCards(course){
  const degrees = [];
  const durations = course.durations || {};
  // Standard degrees to output if present
  const map = [
    { key: 'ba', title: 'Bachelor of Arts', label: 'Undergraduate' },
    { key: 'md', title: 'MD', label: 'Medical' },
    { key: 'ma', title: 'Master of Arts', label: 'Graduate' },
    { key: 'phd', title: 'PhD', label: 'Doctoral' }
  ];

  map.forEach(d => {
    if(durations[d.key]){
      const slugPrefix = (d.key === 'ba' || d.key === 'ma' || d.key === 'phd') ? `${d.key}-${course.slug}` : `${course.slug}`;
      const file = (d.key === 'md') ? `${course.slug}.html` : `${d.key}-${course.slug}.html`;
      degrees.push(`          <div class="course-card">\n            <h3>${d.title} in ${course.title}</h3>\n            <p class="degree">${d.label}</p>\n            <p class="duration">${durations[d.key]}</p>\n            <p>${course.overview}</p>\n            <a href="${file}" class="btn">View Course</a>\n          </div>`);
    }
  });

  // Always include links to degree pages (if not present above) as fallback
  if(!durations.ba){
    degrees.push(`          <div class="course-card">\n            <h3>Bachelor Program in ${course.title}</h3>\n            <p class="degree">Undergraduate</p>\n            <p class="duration">4 Years</p>\n            <p>Comprehensive undergraduate program.</p>\n            <a href="ba-${course.slug}.html" class="btn">View Course</a>\n          </div>`);
  }
  if(!durations.ma){
    degrees.push(`          <div class="course-card">\n            <h3>Master Program in ${course.title}</h3>\n            <p class="degree">Graduate</p>\n            <p class="duration">2 Years</p>\n            <p>Advanced study and specialization.</p>\n            <a href="ma-${course.slug}.html" class="btn">View Course</a>\n          </div>`);
  }
  if(!durations.phd){
    degrees.push(`          <div class="course-card">\n            <h3>PhD in ${course.title}</h3>\n            <p class="degree">Doctoral</p>\n            <p class="duration">3-6 Years</p>\n            <p>Research-focused doctoral program.</p>\n            <a href="phd-${course.slug}.html" class="btn">View Course</a>\n          </div>`);
  }

  return degrees.join('\n');
}

function generateSingle(template, course){
  let out = template;
  out = out.replace(/{{COURSE_TITLE}}/g, course.title);
  out = out.replace(/{{OVERVIEW}}/g, course.overview || 'Program overview coming soon.');
  out = out.replace(/{{HOD_NAME}}/g, course.hod || 'TBD');
  out = out.replace(/{{HOD_TITLE}}/g, course.hod_title || 'PhD');
  out = out.replace(/{{HOD_IMAGE}}/g, course.hod_image || 'images/hod.jpg');
  out = out.replace(/{{HOD_VISION}}/g, course.hod_vision || 'Our mission is to support student success.');
  out = out.replace(/{{DEGREE_CARDS}}/g, makeDegreeCards(course));
  return out;
}

function main(){
  if(!fs.existsSync(templatePath)){
    console.error('Template not found:', templatePath);
    process.exit(1);
  }
  if(!fs.existsSync(dataPath)){
    console.error('Data file not found:', dataPath);
    process.exit(1);
  }

  const template = fs.readFileSync(templatePath, 'utf8');
  const courses = JSON.parse(fs.readFileSync(dataPath, 'utf8'));

  courses.forEach(course => {
    const html = generateSingle(template, course);
    const mainFile = path.join(outDir, `${course.slug}.html`);
    fs.writeFileSync(mainFile, html, 'utf8');

    // Generate degree-specific pages if durations provided or as standard pages
    const degrees = ['ba','ma','phd'];
    degrees.forEach(d => {
      const degFile = path.join(outDir, `${d}-${course.slug}.html`);
      // create a simplified degree page based on template with degree-specific heading
      const degCourse = Object.assign({}, course);
      const degTitles = { ba: 'Bachelor of Arts', ma: 'Master of Arts', phd: 'PhD' };
      degCourse.title = `${degTitles[d] || d} in ${course.title}`;
      degCourse.overview = course.overview + ` This is the ${degTitles[d] || d} program.`;
      const degHtml = generateSingle(template, degCourse);
      fs.writeFileSync(degFile, degHtml, 'utf8');
    });

  });

  console.log('Generation complete. Files written for', courses.length, 'courses.');
}

main();
