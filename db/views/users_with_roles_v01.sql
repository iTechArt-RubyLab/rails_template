SELECT users.name,
       users.email,
       users.provider,
       roles.name AS role
FROM users_roles
         INNER JOIN users ON users.id = users_roles.user_id
         INNER JOIN roles ON roles.id = users_roles.role_id
ORDER BY users.name,
         users.email,
         roles.name;
