User.create(email: 'admin@example.com', password: 'adminadmin')
Role.create(name: 'admin')
User.where(email: 'admin@example.com').first.roles << Role.where(name: 'admin').first
