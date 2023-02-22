<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page import="java.sql.SQLException"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@page import="test.db.DBConnection"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<!-- 미디어쿼리 선언부 -->

<%
request.setCharacterEncoding("utf-8");
String id = request.getParameter("pname");
//System.out.println(pname);
%>

<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
<title>4here user main</title>



</head>
<body>
	<%-- grid(그리드) : 페이지 레이아웃 --%>

	<%-- bootstrap의 container class 활용 --%>
	<nav class="navbar navbar-light bg-info">
		<div class="row">
			<div class="col-sm-4"></div>
			<div class="col-sm-4">
				<div style="text-align: center">
					<div style="color: ivory">
						<h1>4here</h1>
						<br>
					</div>
				</div>
			</div>
			<div class="col-sm-4"></div>
		</div>
	</nav>


	<nav class="navbar navbar-light bg-success">
		<div class="row">
			<%-- col-sm --%>
			<div class="col-sm-4"></div>
			<div class="col-sm-4">
				<div style="text-align: center">
					<br>
					<%-- 텍스트 필드에 자신이 배달을 원하는 주소를 입력한다--%>
					<h3>"어디로 배달해 드릴까요?"</h3>
					<br>
					<form class="d-flex">
						<div id="locationField">
							<input id="autocomplete" placeholder="주소를 입력하세요" type="text" />
						</div>
					</form>
					<br>
				</div>
			</div>
			<div class="col-sm-4"></div>
		</div>
	</nav>


	<style type="text/css">
/* 항상 지도 높이를 명시적으로 설정하여 div의 크기를 정의합니다.
* 맵을 포함하는 요소. */
#map {
	height: 100%;
}

/* 선택 사항: 샘플 페이지가 창을 채우도록 합니다. */
html, body {
	height: 100%;
	margin: 0;
	padding: 0;
}

body {
	padding: 0 !important;
}

table {
	font-size: 12px;
}

.hospital-search {
	-webkit-box-align: center;
	-ms-flex-align: center;
	align-items: center;
	background: #fff;
	display: -webkit-box;
	display: -ms-flexbox;
	display: flex;
	left: 0;
	position: absolute;
	top: 0;
	width: 880px;
	z-index: 1;
}

#map {
	margin-top: 40px;
	width: 880px;
}

#listing {
	position: absolute;
	width: 200px;
	height: 490px;
	overflow: auto;
	left: 630px;
	top: 0px;
	cursor: pointer;
	overflow-x: hidden;
}

#findhospitals {
	font-size: 14px;
}

#locationField {
	-webkit-box-flex: 1 1 190px;
	-ms-flex: 1 1 190px;
	flex: 1 1 190px;
	margin: 0 8px;
}

#controls {
	-webkit-box-flex: 1 1 140px;
	-ms-flex: 1 1 140px;
	flex: 1 1 140px;
}

#autocomplete {
	width: 100%;
}

#country {
	width: 100%;
}

.placeIcon {
	width: 20px;
	height: 34px;
	margin: 4px;
}

.hospitalIcon {
	width: 24px;
	height: 24px;
}

#resultsTable {
	border-collapse: collapse;
	width: 240px;
}

#rating {
	font-size: 13px;
	font-family: Arial Unicode MS;
}

.iw_table_row {
	height: 18px;
}

.iw_attribute_name {
	font-weight: bold;
	text-align: right;
}

.iw_table_icon {
	text-align: right;
}
</style>
	<script>
	// Google Places API의 자동 완성 기능을 사용합니다.
	// 사용자가 주어진 장소, 주어진 장소 내에서 모든 약국을 찾을 수 있도록 한다.
	// 시골의 그런 다음 반환된 모든 약국의 마커를 표시합니다.
	// 각 약국에 대한 자세한 내용을 클릭해서 확인할 수 있습니다.
	// 이 예에는 장소 라이브러리가 필요합니다. 라이브러리=플레이스 포함
	// 매개 변수는 API를 처음 API를 로드할 때 예:
	// <script src="https://maps.googleapis.com/maps/api/js?"키=YOUR_API_KEY&libraries=places">
      let map;
      let places;
      let infoWindow;
      let markers = [];
      let autocomplete;
      const countryRestrict = { country: "kr" };
      const MARKER_PATH =
        "https://developers.google.com/maps/documentation/javascript/images/marker_green";
      const hostnameRegexp = new RegExp("^https?://.+?/");
      const countries = {
        au: {
          center: { lat: -25.3, lng: 133.8 },
          zoom: 4,
        },
        br: {
          center: { lat: -14.2, lng: -51.9 },
          zoom: 3,
        },
        ca: {
          center: { lat: 62, lng: -110.0 },
          zoom: 3,
        },
        fr: {
          center: { lat: 46.2, lng: 2.2 },
          zoom: 5,
        },
        de: {
          center: { lat: 51.2, lng: 10.4 },
          zoom: 5,
        },
        mx: {
          center: { lat: 23.6, lng: -102.5 },
          zoom: 4,
        },
        nz: {
          center: { lat: -40.9, lng: 174.9 },
          zoom: 5,
        },
        it: {
          center: { lat: 41.9, lng: 12.6 },
          zoom: 5,
        },
        za: {
          center: { lat: -30.6, lng: 22.9 },
          zoom: 5,
        },
        es: {
          center: { lat: 40.5, lng: -3.7 },
          zoom: 5,
        },
        pt: {
          center: { lat: 39.4, lng: -8.2 },
          zoom: 6,
        },
        us: {
          center: { lat: 37.1, lng: -95.7 },
          zoom: 3,
        },
        uk: {
          center: { lat: 54.8, lng: -4.6 },
          zoom: 5,
        },
        
        kr: {
          center : { lat: 37.5642135 ,lng: 127.0016985 },
          zoom: 16,
        },
        
      };

      function initMap() {
        map = new google.maps.Map(document.getElementById("map"), {
          zoom: countries["kr"].zoom,
          center: countries["kr"].center,
          mapTypeControl: true,
          panControl: true,
          zoomControl: true,
          streetViewControl: true,
        });
        infoWindow = new google.maps.InfoWindow({
          content: document.getElementById("info-content"),
        });
        // 자동 완성 개체를 만들고 이를 UI 입력 컨트롤과 연결합니다.
     	// 검색을 기본 국가로 제한하고 도시로 검색하기 원할 경우, types에 "cities"를 배치한다.
     	// 정확한 주소를 입력받기 위해 types를 따로 지정하지 않았음
        autocomplete = new google.maps.places.Autocomplete(
          document.getElementById("autocomplete"),
          {
            //types: ["(cities)"], 
            componentRestrictions: countryRestrict,
          }
        );
        places = new google.maps.places.PlacesService(map);
        autocomplete.addListener("place_changed", onPlaceChanged);
     	// 사용자가 국가를 선택할 때 응답할 DOM 이벤트 수신기를 추가합니다.
        document
          .getElementById("country")
          .addEventListener("change", setAutocompleteCountry);
      }

   	// 사용자가 주소를 선택할 때 주소의 장소 세부 정보를 가져오고
   	// 지도를 확대해서 그 주소를 비춘다.
      function onPlaceChanged() {
        const place = autocomplete.getPlace();

        if (place.geometry && place.geometry.location) {
          map.panTo(place.geometry.location);
          map.setZoom(15);
          search();
        } else {
          document.getElementById("autocomplete").placeholder = "Enter a city";
        }
      }

   	  // 지도의 뷰포트 내에서 선택한 주소의 약국을 검색합니다.
      function search() {
        const search = {
          bounds: map.getBounds(),
          types: ["pharmacy"],
        };
        places.nearbySearch(search, (results, status, pagination) => {
          if (status === google.maps.places.PlacesServiceStatus.OK && results) {
            clearResults();
            clearMarkers();

         	// 발견된 각 약국에 대해 마커를 만들고
         	// 각 마커 아이콘에 알파벳 문자를 할당합니다.
            for (let i = 0; i < results.length; i++) {
              const markerLetter = String.fromCharCode(
                "A".charCodeAt(0) + (i % 26)
              );
              const markerIcon = MARKER_PATH + markerLetter + ".png";
           	  // 마커 애니메이션을 사용하여 아이콘을 지도에 점진적으로 놓습니다.
              markers[i] = new google.maps.Marker({
                position: results[i].geometry.location,
                animation: google.maps.Animation.DROP,
                icon: markerIcon,
              });
          	  // 사용자가 약국 마커를 클릭하면 해당 약국의 세부 정보를 표시합니다.
              // 인포메이션 창에서
              markers[i].placeResult = results[i];
              google.maps.event.addListener(
                markers[i],
                "click",
                showInfoWindow
              );
              setTimeout(dropMarker(i), i * 100);
              addResult(results[i], i);
            }
          }
        });
      }

      function clearMarkers() {
        for (let i = 0; i < markers.length; i++) {
          if (markers[i]) {
            markers[i].setMap(null);
          }
        }
        markers = [];
      }

   	  // 사용자 입력에 따라 국가 제한을 설정합니다.
   	  // 또한 맵을 지정된 국가의 중심에 놓고 확대/축소합니다.
      function setAutocompleteCountry() {
        const country = document.getElementById("country").value;

        if (country == "all") {
          autocomplete.setComponentRestrictions({ country: [] });
          map.setCenter({ lat: 15, lng: 0 });
          map.setZoom(2);
        } else {
          autocomplete.setComponentRestrictions({ country: country });
          map.setCenter(countries[country].center);
          map.setZoom(countries[country].zoom);
        }
        clearResults();
        clearMarkers();
      }

      function dropMarker(i) {
        return function () {
          markers[i].setMap(map);
        };
      }

      function addResult(result, i) {
        const results = document.getElementById("results");
        const markerLetter = String.fromCharCode("A".charCodeAt(0) + (i % 26));
        const markerIcon = MARKER_PATH + markerLetter + ".png";
        const tr = document.createElement("tr");
        tr.style.backgroundColor = i % 2 === 0 ? "#F0F0F0" : "#FFFFFF";

        tr.onclick = function () {
          google.maps.event.trigger(markers[i], "click");
        };
        const iconTd = document.createElement("td");
        const nameTd = document.createElement("td");
        const icon = document.createElement("img");
        icon.src = markerIcon;
        icon.setAttribute("class", "placeIcon");
        icon.setAttribute("className", "placeIcon");
        const name = document.createTextNode(result.name);
        iconTd.appendChild(icon);
        nameTd.appendChild(name);
        tr.appendChild(iconTd);
        tr.appendChild(nameTd);
        results.appendChild(tr);
      }

      function clearResults() {
        const results = document.getElementById("results");

        while (results.childNodes[0]) {
          results.removeChild(results.childNodes[0]);
        }
      }

   // 야국의 장소 세부 정보를 가져옵니다. 정보 창에 정보를 표시합니다.
   // 사용자가 선택한 약국의 마커에 고정됩니다.
      function showInfoWindow() {
        const marker = this;
        places.getDetails(
          { placeId: marker.placeResult.place_id },
          (place, status) => {
            if (status !== google.maps.places.PlacesServiceStatus.OK) {
              return;
            }
            infoWindow.open(map, marker);
            buildIWContent(place);
          }
        );
      }
      
   	  // 정보 창에서 사용하는 HTML 요소에 장소 정보를 로드합니다.
      function buildIWContent(place) {
       document.getElementById("iw-icon").innerHTML =
          '<img class="hospitalIcon" ' + 'src="' + place.icon + '"/>';
       document.getElementById("iw-url").innerHTML =
        	'<b><a href="' + place.url + '">' + place.name + "</a></b>";
       document.getElementById("abc").innerHTML =
            '<b><a >' + place.name + "</a></b>";    
       document.getElementById("abc").value=place.name;      	
       document.getElementById("iw-address").textContent = place.vicinity;
        if (place.formatted_phone_number) {
          document.getElementById("iw-phone-row").style.display = "";
          document.getElementById("iw-phone").textContent =
            place.formatted_phone_number;
        } else {
          document.getElementById("iw-phone-row").style.display = "none";
        }

     // 검은 별('&#10029;')을 사용하여 병원에 별 다섯 개 등급을 할당합니다.
     // 평가 점수를 획득하지 못한 경우. 병원이 획득한 등급과 흰색 별('&#10025;')을 나타냅니다.
        if (place.rating) {
          let ratingHtml = "";

          for (let i = 0; i < 5; i++) {
            if (place.rating < i + 0.5) {
              ratingHtml += "&#10025;";
            } else {
              ratingHtml += "&#10029;";
            }
            document.getElementById("iw-rating-row").style.display = "";
            document.getElementById("iw-rating").innerHTML = ratingHtml;
          }
        } else {
          document.getElementById("iw-rating-row").style.display = "none";
        }

     	// regexp는 URL의 첫 번째 부분(도메인과 하위 도메인)을 분리합니다.
     	// 정보 창에 표시하기 위한 짧은 URL을 제공합니다.
        if (place.website) {
          let fullUrl = place.website;
          let website = String(hostnameRegexp.exec(place.website));

          if (!website) {
            website = "http://" + place.website + "/";
            fullUrl = website;
          }
          document.getElementById("iw-website-row").style.display = "";
          document.getElementById("iw-website").textContent = website;
        } else {
          document.getElementById("iw-website-row").style.display = "none";
        }
      }
      
      
    </script>
</head>

<body>
	<section class="contact-section">
		<div class="container">
			<div class="d-none d-sm-block mb-5 pb-4">
				<div id="MapID"
					style="height: 480px; position: relative; overflow: hidden;">

					<div id="map"
						style="height: 480px; position: relative; overflow: hidden;"></div>

					<div id="listing">
						<table id="resultsTable">
							<tbody id="results"></tbody>
						</table>
					</div>

					<div style="display: none">
						<div id="info-content">
							<table>
								<tr id="iw-url-row" class="iw_table_row">
									<td id="iw-icon" class="iw_table_icon"></td>
									<td id="iw-url"></td>
								</tr>
								<tr id="iw-address-row" class="iw_table_row">
									<td class="iw_attribute_name">Address:</td>
									<td id="iw-address"></td>
								</tr>
								<tr id="iw-phone-row" class="iw_table_row">
									<td class="iw_attribute_name">Telephone:</td>
									<td id="iw-phone"></td>
								</tr>
								<tr id="iw-rating-row" class="iw_table_row">
									<td class="iw_attribute_name">Rating:</td>
									<td id="iw-rating"></td>
								</tr>
								<tr id="iw-website-row" class="iw_table_row">
									<td class="iw_attribute_name">Website:</td>
									<td id="iw-website"></td>
								</tr>
							</table>

						</div>
					</div>
				</div>
			</div>
			
			<!-- 웹 페이지에서의 입력 양식을 작성해서 약국 검색 처리 페이지인 user_pharmacyAction.jsp로 보낸다. -->	
			<form accept-charset="utf-8" action="user_pharmacyAction.jsp">
				<!-- 사용자에게는 보이지 않는 숨겨진 입력 필드를 정의합니다.-->
				<!-- 주문페이지에 선택한 약국이름을 전달하기위해서 value에 지도에서 선택한 약국이름을 대입한다.-->
				<input type="hidden" name="abc" id="abc" value="{{form.abc.value}}"> 
				<!--버튼을 누르면 백엔드 서버에 양식이 전달되어 정보를 처리한다.-->	
				<button type="submit" class="btn btn-primary mb-3">선 택</button>
			</form>


			<script src="https://polyfill.io/v3/polyfill.min.js?features=default"></script>
			
			<!-- 처음 API를 로드할 때, 키에 구글맵 플랫폼에서 할당받은 키를 대입한다.  -->	
			<script
				src="https://maps.googleapis.com/maps/api/js?key=AIzaSyDFKvTLgQr0Q-WmJrhGz2HiblksTW9M5Fk&callback=initMap&libraries=places&v=weekly&radius=5000"></script>
</body>
</html>