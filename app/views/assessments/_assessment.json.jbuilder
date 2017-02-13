json.extract! assessment, :id, :name, :description, :created_at, :updated_at
json.url assessment_url(assessment, format: :json)