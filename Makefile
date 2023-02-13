postgres:
	docker run --name postgres_con -p 5432:5432 -e POSTGRES_USER=ghost -e POSTGRES_PASSWORD=ghost -d postgres
createdb:
	docker exec -it postgres_con createdb --username=ghost --owner=ghost test
dropdb:
	docker exec -it postgres_con dropdb test
migrateup:
	migrate -path db/migration -database "postgresql://ghost:ghost@localhost:5432/test?sslmode=disable" -verbose up
migratedown:
	migrate -path db/migration -database "postgresql://ghost:ghost@localhost:5432/test?sslmode=disable" -verbose down
sqlc:
	sqlc generate
test:
	go test -v -cover ./..
.PHONY: postgres createdb dropdb migrateup migratedown sqlc test
