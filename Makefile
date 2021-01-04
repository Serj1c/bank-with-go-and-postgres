postgres:
	docker run --name postgres -d -p 5432:5432 -e POSTGRES_USER=root -e POSTGRES_PASSWORD=secret postgres:13.1-alpine

createdb:
	docker exec -it postgres createdb --username=root --owner=root bank

dropdb:
	docker exec -it postgres dropdb bank

migrateup:
	migrate -path db/migration -database "postgresql://root:secret@localhost:5432/bank?sslmode=disable" -verbose up

migratedown:
	migrate -path db/migration -database "postgresql://root:secret@localhost:5432/bank?sslmode=disable" -verbose down

sqlc:
	sqlc generate

test:
	go test -v -cover ./...

.PHONY: createdb postgres dtopdb migrateup migratedown sqlc