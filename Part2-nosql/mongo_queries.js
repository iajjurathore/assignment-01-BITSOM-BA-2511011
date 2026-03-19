// OP1: insertMany() — insert all 3 documents from sample_documents.json
db.products.insertMany([
  {
    _id: "prod_E001",
    category: "Electronics",
    name: "Samsung 55-inch 4K Smart TV",
    brand: "Samsung",
    price: 45000,
    in_stock: true,
    specs: {
      voltage: "220V",
      warranty_years: 2,
      screen_size_inches: 55,
      resolution: "4K UHD",
      smart_tv: true,
      hdmi_ports: 3
    },
    tags: ["television", "4K", "smart", "Samsung"],
    ratings: { average: 4.5, total_reviews: 1284 },
    added_on: "2024-01-15"
  },
  {
    _id: "prod_C001",
    category: "Clothing",
    name: "Men's Premium Cotton Formal Shirt",
    brand: "Raymond",
    price: 1299,
    in_stock: true,
    specs: {
      fabric: "100% Cotton",
      fit: "Regular",
      gender: "Men",
      sizes_available: ["S", "M", "L", "XL", "XXL"],
      color_options: ["White", "Light Blue", "Black", "Grey"],
      care_instructions: "Machine wash cold"
    },
    tags: ["formal", "cotton", "office-wear", "men"],
    ratings: { average: 4.2, total_reviews: 376 },
    added_on: "2024-02-10"
  },
  {
    _id: "prod_G001",
    category: "Groceries",
    name: "Organic Rolled Oats 1kg",
    brand: "Quaker",
    price: 280,
    in_stock: true,
    specs: {
      weight_grams: 1000,
      organic: true,
      vegan: true,
      expiry_date: "2025-06-30",
      storage: "Store in cool dry place"
    },
    nutrition_per_100g: {
      calories: 389, protein_g: 17,
      carbohydrates_g: 66, fat_g: 7, fiber_g: 10
    },
    tags: ["oats", "organic", "breakfast", "healthy"],
    ratings: { average: 4.7, total_reviews: 892 },
    added_on: "2024-01-20"
  }
]);

{
  acknowledged: true,
  insertedIds ;{
    '0'= 'prod_E001',
    '1'= 'prod_C001',
    '2'= 'prod_G001'
  }
}
 
// OP2: find() — retrieve all Electronics products with price > 20000
db.products.find(
  {
    category: "Electronics",
    price: { $gt: 20000 }
  },
  {
    name: 1,
    price: 1,
    brand: 1,
    _id: 0
  }
);
{
  name: 'Samsung 55-inch 4K Smart TV',
  brand = 'Samsung',
  price= 45000
}
 
 
// OP3: find() — retrieve all Groceries expiring before 2025-01-01
db.products.find(
  {
    category: "Groceries",
    "specs.expiry_date": { $lt: "2025-01-01" }
  },
  {
    name: 1,
    "specs.expiry_date": 1,
    price: 1,
    _id: 0
  }
);
 
 

// OP4: updateOne() — add a "discount_percent" field to a specific product
db.products.updateOne(
  { _id: "prod_E001" },
  {
    $set: {
      discount_percent: 10,
      discounted_price: 40500
    }
  }
);
{
  acknowledged: true,
  insertedId= null,
  matchedCount= 1,
  modifiedCount=1,
  upsertedCount= 0
}
 
// Verify update
db.products.findOne({ _id: "prod_E001" }, { name: 1, price: 1, discount_percent: 1 });
 
{
  _id: 'prod_E001',
  name= 'Samsung 55-inch 4K Smart TV',
  price= 45000,
  discount_percent= 10
}
 
 
// OP5: createIndex() — create an index on category field and explain why
db.products.createIndex(
  { category: 1 },
  { name: "idx_category" }
);
idx_category
 
db.products.getIndexes();
[
  { v: 2, key: { _id: 1 }, name: '_id_' },
  { v: 2, key: { category: 1 }, name: 'idx_category' }
]



