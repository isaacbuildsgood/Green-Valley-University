import json
from pathlib import Path

template_path = Path(__file__).resolve().parents[1] / 'templates' / 'course-template.html'
data_path = Path(__file__).resolve().parents[1] / 'data' / 'courses.json'
out_dir = Path(__file__).resolve().parents[1]

def make_degree_cards(course):
    degrees = []
    durations = course.get('durations', {})
    map_items = [
        ('ba', 'Bachelor of Arts', 'Undergraduate'),
        ('md', 'MD', 'Medical'),
        ('ma', 'Master of Arts', 'Graduate'),
        ('phd', 'PhD', 'Doctoral')
    ]
    for key, title, label in map_items:
        if key in durations:
            if key == 'md':
                file = f"{course['slug']}.html"
            else:
                file = f"{key}-{course['slug']}.html"
            degrees.append(f"          <div class=\"course-card\">\n            <h3>{title} in {course['title']}</h3>\n            <p class=\"degree\">{label}</p>\n            <p class=\"duration\">{durations[key]}</p>\n            <p>{course['overview']}</p>\n            <a href=\"{file}\" class=\"btn\">View Course</a>\n          </div>")
    # Fallbacks
    if 'ba' not in durations:
        degrees.append(f"          <div class=\"course-card\">\n            <h3>Bachelor Program in {course['title']}</h3>\n            <p class=\"degree\">Undergraduate</p>\n            <p class=\"duration\">4 Years</p>\n            <p>Comprehensive undergraduate program.</p>\n            <a href=\"ba-{course['slug']}.html\" class=\"btn\">View Course</a>\n          </div>")
    if 'ma' not in durations:
        degrees.append(f"          <div class=\"course-card\">\n            <h3>Master Program in {course['title']}</h3>\n            <p class=\"degree\">Graduate</p>\n            <p class=\"duration\">2 Years</p>\n            <p>Advanced study and specialization.</p>\n            <a href=\"ma-{course['slug']}.html\" class=\"btn\">View Course</a>\n          </div>")
    if 'phd' not in durations:
        degrees.append(f"          <div class=\"course-card\">\n            <h3>PhD in {course['title']}</h3>\n            <p class=\"degree\">Doctoral</p>\n            <p class=\"duration\">3-6 Years</p>\n            <p>Research-focused doctoral program.</p>\n            <a href=\"phd-{course['slug']}.html\" class=\"btn\">View Course</a>\n          </div>")
    return '\n'.join(degrees)


def generate_single(template, course):
    out = template
    out = out.replace('{{COURSE_TITLE}}', course.get('title', 'Course'))
    out = out.replace('{{OVERVIEW}}', course.get('overview', 'Program overview coming soon.'))
    out = out.replace('{{HOD_NAME}}', course.get('hod', 'TBD'))
    out = out.replace('{{HOD_TITLE}}', course.get('hod_title', 'PhD'))
    out = out.replace('{{HOD_IMAGE}}', course.get('hod_image', 'images/hod.jpg'))
    out = out.replace('{{HOD_VISION}}', course.get('hod_vision', 'Our mission is to support student success.'))
    out = out.replace('{{DEGREE_CARDS}}', make_degree_cards(course))
    return out


def main():
    if not template_path.exists():
        print('Template not found:', template_path)
        return
    if not data_path.exists():
        print('Data file not found:', data_path)
        return
    template = template_path.read_text(encoding='utf8')
    courses = json.loads(data_path.read_text(encoding='utf8'))

    for course in courses:
        html = generate_single(template, course)
        main_file = out_dir / f"{course['slug']}.html"
        main_file.write_text(html, encoding='utf8')

        # generate degree pages
        for d in ['ba','ma','phd']:
            deg_file = out_dir / f"{d}-{course['slug']}.html"
            deg_course = dict(course)
            deg_titles = {'ba': 'Bachelor of Arts', 'ma': 'Master of Arts', 'phd': 'PhD'}
            deg_course['title'] = f"{deg_titles[d]} in {course['title']}"
            deg_course['overview'] = course.get('overview','') + f" This is the {deg_titles[d]} program."
            deg_html = generate_single(template, deg_course)
            deg_file.write_text(deg_html, encoding='utf8')

    print(f"Generation complete. Files written for {len(courses)} courses.")

if __name__ == '__main__':
    main()
