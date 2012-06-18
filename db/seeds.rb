# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

Hospital.destroy_all
hospitals = Hospital.create([
  { name: 'Chicago Hospital', address: '1234 Michigan Ave', city: 'Chicago', state: 'IL', zip: '60657', service_area_id: ServiceArea.first.count  },
  { name: 'Detroit Hospital', address: '1234 Woodward', city: 'Detroit', state: 'MI', zip: '48207', service_area_id: 1 },
  { name: 'New York Hospital', address: '1234 Broadway', city: 'New York', state: 'NY', zip: '39280', service_area_id: 3  },
  { name: 'Chicago2 Hospital', address: '1234 LaSalle', city: 'Chicago', state: 'IL', zip: '60657', service_area_id: 1 },
  { name: 'Managua Hospital', address: 'Calle Trece', city: 'Managua', state: 'Nica', zip: "we don't do zips", service_area_id: 4 }
])

ServiceArea.destroy_all
service_areas = ServiceArea.create([
  { name: "Chicago" },
  { name: "Detroit" },
  { name: "New York" },
  { name: "International" }
])

Category.destroy_all
categories = Category.create([
  { name: "Jobs and Careers" },
  { name: "General Health/Medicine" },
  { name: "Cardiology Services" },
  { name: "Oncology Services" }
])

ContentFile.destroy_all
content = ContentFile.create([
  { title: "Example 1", description: "Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum." },
  { title: "Example 2", description: "Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do" },
  { title: "Another file!", description: "Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.", service_area_id: 2 },
  { title: "Example 3", description: "Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor", service_area_id: 2 },
  { title: "Example 4", description: "Lorem ipsum dolor sit amet, consectetur adipisicing elit", service_area_id: 1 }
])

Tag.destroy_all
tags = Tag.create([
  { content_file_id: 1, category_id: 1 },
  { content_file_id: 2, category_id: 3 },
  { content_file_id: 2, category_id: 4 },
  { content_file_id: 3, category_id: 2 },
  { content_file_id: 3, category_id: 1 },
  { content_file_id: 3, category_id: 4 }
])


