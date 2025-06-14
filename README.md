# Pet Tracking API

This is a Ruby on Rails API-only application for tracking pets (dogs and cats) and calculating how many pets are outside the power saving zone. It supports multiple tracker types per pet type and includes a small composition pattern for cat-specific attributes.

---

## Features

- Receive pet tracking data via REST API
- Store pet data with validations
- Query pets currently outside the power saving zone grouped by pet type and tracker type
- Easily replaceable storage layer (currently using SQLite)
- Fully tested with Minitest

---

### Prerequisites

- Ruby 3.x  
- Rails 8.x  
- SQLite3  
- Bundler

### Setup

1. Clone the repository:
  ```bash
  git clone <repository-url>
  cd pet-tracking-api
2. Install dependencies:
  bundle install
3. Setup Database
	rails db:create db:migrate
4.Run the Rails server
	rails server
5. Running tests
	rails test
### Api Endpoints
	- Base URL: http://localhost:3000/api/v1
	- Create a pet
		curl -X POST http://localhost:3000/api/v1/pets \
		-H "Content-Type: application/json" \
		-d '{
			"pet": {
				"pet_type": "cat",
				"tracker_type": "small",
				"owner_id": 1,
				"in_zone": false,
				"cat_profile_attributes": {
					"lost_tracker": false
				}
			}
		}'
	-Get report of Pets Outside Zone
		curl http://localhost:3000/api/v1/pets/report