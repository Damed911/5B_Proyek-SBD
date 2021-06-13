const express = require('express');
const app = express();
const fileUpload = require('express-fileupload');
const { Client } = require('pg');
const { response } = require('express');
const fs = require('fs');

const client = new Client({
    user: 'postgres',
    host: 'localhost',
    database: 'mysun_shines',
    password: '',
    port: 5432,
    multipleStatements:true
});

client.connect((err) =>{
    if (err) {
        console.error(err);
        return;
    }
    console.log('Database Connected');
});
// set the view engine to ejs
app.set('view engine', 'ejs');

// use stylesheet and js in public directory for ejs views 
app.use(express.static(__dirname + '/public'));
app.use(express.urlencoded({ extended: false })); 
app.use(fileUpload());

// index page
app.get('/', function(req, res) {
    const query = `SELECT * FROM produk`;
    client.query(query , [], (err, results) => {
        if (err) {
            console.error(err);
            return;
        }
        res.render('pages/index', {
            model: results.rows
          });
    });    
});


app.get('/admin', function(req, res) {
    const query = `SELECT * FROM produk`;
    client.query(query , [], (err, results) => {
        if (err) {
            console.error(err);
            return;
        }
        res.render('pages/admin', {
            model: results.rows
          });
    })  
});

app.get('/produk/:id', async (req, res) => {

    const id = req.params.id;
    const query = `SELECT * FROM produk WHERE id_p = $1 `;
    client.query(query, [id], (err, results) => {
        if (err) {
            console.error(err);
            return;
        }
        res.render('pages/details', {
            model: results.rows[0]
          });
    });
})
app.post("/produk/:id", (req, res) => {

    const id = [req.body.nama_acc, req.body.jumlah, req.body.metode_transaksi, req.params.id];
    const query1 = `INSERT INTO transaksi(id_p, nama_acc, nama_prod, nama_cust, jumlah, harga_prod, metode_transaksi) VALUES($4, $1, (SELECT nama_prod FROM produk WHERE id_p=$4), (SELECT nama_cust FROM akun_p WHERE nama_acc = $1), $2, (SELECT harga FROM produk WHERE id_p = $4), $3)`;
    client.query(query1, id, (err, result) => {
    if (err) {
        console.error(err);
    return;
    }
    });

    const data = [req.body.jumlah,req.params.id];
    const query2 = `UPDATE produk SET jumlah_stok = (SELECT jumlah_stok FROM produk WHERE id_p = $2) - $1 WHERE id_p = $2`;
    client.query(query2, data, (err, result) => {
    if (err) {
        console.error(err);
    return;
    }
    });
    
    res.redirect("/");
});


//GET and POST for add product
app.get("/create", (req, res) => {
    res.render("pages/create");
});
app.post("/create", (req, res) => {
    if (!req.files || Object.keys(req.files).length === 0) {
        return res.status(400).send('No files were uploaded.');
    }
    let uploadedFile = req.files.gambar;
    let image_name = uploadedFile.name;
    //upload image file to directory public/images/
    uploadedFile.mv(`public/images/${image_name}`, (err ) => {
        if (err) {
            return res.status(500).send(err);
        }
    });

    const query = `INSERT INTO produk(nama_prod, jumlah_stok, harga, deskripsi,gambar) VALUES ($1, $2, $3, $4,$5)`;
    const produk = [req.body.Nama, req.body.Jumlah, req.body.Harga, req.body.Deskripsi,req.files.gambar.name];
    client.query(query, produk, (err, result) => {
    if (err) {
        console.error(err);
    return;
    }
    });
    
    res.redirect("/admin");
});

//register
app.get("/register", (req, res) => {
    res.render("pages/register");
});

app.post("/register", (req, res) => {

    const query = `INSERT INTO akun_p(nama_acc, nama_cust, email, nomor_telfon, alamat_rumah) VALUES ($1, $2, $3, $4,$5)`;
    const produk = [req.body.nama_acc, req.body.nama_cust, req.body.email, req.body.nomor_telfon, req.body.alamat_rumah];
    client.query(query, produk, (err, result) => {
    if (err) {
        console.error(err);
    return;
    }
    });
    
    res.redirect("/");
});

//GET and POST for edit product
app.get("/edit/:id", (req, res) => {
    const id = req.params.id;
    const query = `SELECT * FROM produk WHERE id_p = $1`;
    client.query(query , [id], (err, results) => {
        if (err) {
            console.error(err);
            return;
        }
        res.render('pages/edit', {
            model: results.rows[0]
        });
    });  
});

app.post("/edit/:id", (req, res) => {

    if (!req.files || Object.keys(req.files).length === 0) {
        return res.status(400).send('No files were uploaded.');
    }
    let uploadedFile = req.files.gambar;
    let image_name = uploadedFile.name;
    //upload image file to directory public/images/
    uploadedFile.mv(`public/images/${image_name}`, (err ) => {
        if (err) {
            return res.status(500).send(err);
        }
    });

    const id = req.params.id;
    const query = `UPDATE produk SET nama_prod = $1, jumlah_stok = $2, harga = $3, deskripsi = $4,gambar=$5 WHERE id_p = $6`;
    const produk = [req.body.Nama, req.body.Jumlah, req.body.Harga, req.body.Deskripsi,req.files.gambar.name, id];
    client.query(query , produk, (err, results) => {
        if (err) {
            console.error(err);
            return;
        }
    }); 
    res.redirect("/admin");
});

//GET and POST for delete product

app.post("/delete/:id", (req, res) => {
    const id = req.params.id;
    const query = `DELETE FROM produk WHERE id_p = $1`;
    client.query(query , [id], (err, results) => {
        if (err) {
            console.error(err);
            return;
        }
    }); 
    res.redirect("/admin");
});

app.listen(5000, () => {
    console.log('Program berjalan pada port 5000');
});