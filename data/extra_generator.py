from faker import Faker

faker = Faker()
Faker.seed(1222)

def id_generate():
    return str(faker.uuid4()).replace("-", "")[0:10]

# def prod_id_generate():
#     return str(faker.uuid4()).replace("-", "")[0:10]