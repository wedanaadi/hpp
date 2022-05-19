<!DOCTYPE html>
<html lang="en">

<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>HPP</title>

  {{--
  <link rel="preconnect" href="https://fonts.gstatic.com"> --}}
  <link href="https://fonts.googleapis.com/css2?family=Nunito:wght@300;400;600;700;800&display=swap" rel="stylesheet">
  <link rel="stylesheet" href="{{ asset('css/app.css') }}">
  {{--
  <link rel="shortcut icon" href="assets/images/favicon.svg" type="image/x-icon"> --}}
</head>

<body>
  <div id="app">
    <div id="sidebar" class="active">
      <div class="sidebar-wrapper active">
        <div class="sidebar-header">
          <div class="d-flex justify-content-between">
            <div class="logo">
              <a href="index.html"><img src="{{ asset('images/vila.png') }}" alt="Logo" srcset=""></a>
            </div>
            <div class="toggler">
              <a href="#" class="sidebar-hide d-xl-none d-block"><i class="bi bi-x bi-middle"></i></a>
            </div>
          </div>
        </div>
        <div class="login-header">
          <div class="d-flex">
            <div>
              <a href="index.html"><img src="{{ asset('images/login.png') }}" alt="Logo"></a>
            </div>
            <div class="ps-2 d-flex flex-column">
              <span>Selamat Datang!</span>
              <span>FOOD & BEVERAGE</span>
              <a href="" class="logout">Logout <i class="bi bi-power"></i></a>
            </div>
          </div>
        </div>
        <div class="sidebar-menu">
          <ul class="menu">
            <li class="sidebar-title">Menu</li>

            <li class="sidebar-item  active">
              <a href="index.html" class='sidebar-link'>
                <i class="bi bi-house-door-fill"></i>
                <span>Beranda</span>
              </a>
            </li>

            <li class="sidebar-item  has-sub">
              <a href="#" class='sidebar-link'>
                <i class="bi bi-stack"></i>
                <span>Components</span>
              </a>
              <ul class="submenu ">
                <li class="submenu-item ">
                  <a href="component-alert.html">Alert</a>
                </li>
              </ul>
            </li>
          </ul>
        </div>
        <button class="sidebar-toggler btn x"><i data-feather="x"></i></button>
      </div>
    </div>
    <div id="main">
      <header class="mb-3">
        <a href="#" class="burger-btn d-block d-xl-none">
          <i class="bi bi-justify fs-3"></i>
        </a>
      </header>

      <div class="page-heading">
        <div class="page-title">
          <div class="row mb-2">
            <div class="col-12 col-md-6 order-md-1 order-last">
              {{-- <h3>Layout Default</h3> --}}
              {{-- <p class="text-subtitle text-muted">&nbsp; </p> --}}
            </div>
            <div class="col-12 col-md-6 order-md-2 order-first">
              <nav aria-label="breadcrumb" class="breadcrumb-header float-start float-lg-end">
                <ol class="breadcrumb">
                  <li class="breadcrumb-item active"><a href="index.html">Dashboard</a></li>
                  {{-- <li class="breadcrumb-item active" aria-current="page">Layout Default</li> --}}
                </ol>
              </nav>
            </div>
          </div>
        </div>
        <section class="section">
          <div class="card">
            <div class="card-header">
              <h4 class="card-title">Default Layout</h4>
            </div>
            <div class="card-body">
              Lorem ipsum dolor sit amet consectetur adipisicing elit. Magnam, commodi? Ullam quaerat similique iusto
              temporibus, vero aliquam praesentium, odit deserunt eaque nihil saepe hic deleniti? Placeat delectus
              quibusdam ratione ullam!
              <router-view></router-view>
            </div>
          </div>
        </section>
      </div>

      <footer>
        <div class="footer clearfix mb-0 text-muted">
          <div class="float-start">
            <p>2021 &copy; Diah Pramesti</p>
          </div>
          {{-- <div class="float-end">
            <p>Crafted with <span class="text-danger"><i class="bi bi-heart"></i></span> by <a
                href="http://ahmadsaugi.com">A. Saugi</a></p>
          </div> --}}
        </div>
      </footer>
    </div>
  </div>
  <script src="{{ asset('mazer/assets/vendors/perfect-scrollbar/perfect-scrollbar.min.js') }}"></script>
  <script src="{{ asset('js/app.js') }}"></script>
  <script src="{{ asset('mazer/assets/js/mazer.js') }}"></script>

</body>

</html>