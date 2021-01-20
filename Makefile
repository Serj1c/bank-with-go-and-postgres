postgres:
	docker run --name postgre -d -p 5432:5432 -e POSTGRES_USER=root -e POSTGRES_PASSWORD=secret postgres:13.1-alpine

createdb:
	docker exec -it postgre createdb --username=root --owner=root bank

dropdb:
	docker exec -it postgre dropdb bank

migrateup:
	migrate -path db/migration -database "postgresql://root:secret@localhost:5432/bank?sslmode=disable" -verbose up

migratedown:
	migrate -path db/migration -database "postgresql://root:secret@localhost:5432/bank?sslmode=disable" -verbose down

sqlc:
	sqlc generate

test:
	go test -v -cover ./...

.PHONY: createdb postgre dtopdb migrateup migratedown sqlc