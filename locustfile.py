from locust import HttpUser, task, between
import random

class OnlineBoutiqueUser(HttpUser):
    wait_time = between(1, 3)
    
    @task(5)
    def view_homepage(self):
        self.client.get("/")
    
    @task(3)
    def view_product(self):
        products = ["0PUK6V6EV0", "1YMWWN1N4O", "2ZYFJ3GM2N", "66VCHSJNUP", "6E92ZMYYFZ"]
        self.client.get(f"/product/{random.choice(products)}")
    
    @task(2)
    def view_cart(self):
        self.client.get("/cart")
    
    @task(1)
    def add_to_cart(self):
        products = ["0PUK6V6EV0", "1YMWWN1N4O", "2ZYFJ3GM2N"]
        self.client.post("/cart", data={
            "product_id": random.choice(products),
            "quantity": str(random.randint(1, 3))
        })