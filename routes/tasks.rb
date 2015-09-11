get '/api/tasks' do
  Task.all.to_json
end

get '/api/tasks/:id' do
  t = Task.get(params[:id])
  halt 404 if t.nil?
  t.to_json
end

post '/api/tasks' do
  body = JSON.parse request.body.read
  t = Task.create(title: body['title'], 
                 description: body['description'],
                 completed: false)
  status 201
  t.to_json
end

put '/api/tasks/:id' do
  body = JSON.parse request.body.read
  t = Task.get(params[:id])
  halt 404 if t.nil?
  halt 500 unless Task.update(
    title: body['title'], 
    description: body['description'])

  t.to_json
end

delete '/api/tasks/:id' do
  t = Task.get params[:id]
  halt 404 if t.nil?
  halt 500 unless t.destroy
  t.to_json
end
