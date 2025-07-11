<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Movie Schedule</title>
    <script src="https://js.tosspayments.com/v2/standard"></script>
    <link rel="stylesheet" href="/resources/css/schedule.css">
</head>
<body>
<!-- Include common header -->
<jsp:include page="/WEB-INF/views/header.jsp" />

<div class="container">
    <!-- Booking Steps -->
    <div class="booking-steps">
        <div class="steps">
            <div class="step" id="step1">
                <div class="step-number">1</div>
                <span>Showtime</span>
            </div>
            <div class="step inactive" id="step2">
                <div class="step-number">2</div>
                <span>Seats</span>
            </div>
            <div class="step inactive" id="step3">
                <div class="step-number">3</div>
                <span>Payment</span>
            </div>
            <div class="step inactive" id="step4">
                <div class="step-number">4</div>
                <span>Complete</span>
            </div>
        </div>
    </div>

    <!-- Error Message -->
    <c:if test="${not empty error}">
        <div class="error-message"
             style="background-color: #ffebee; color: #c62828; padding: 10px; margin: 10px 0; border-radius: 4px;">
                ${error}
        </div>
    </c:if>

    <!-- Current Theater -->
    <div class="section">
        <div class="section-header">Phoenix Jonggak Branch</div>
        <div class="section-content">
            <p style="color: #666; font-size: 14px;">15 Jongno 12-gil, Jongno-gu, Seoul</p>
        </div>
    </div>

    <!-- Movie Schedule Section -->
    <div class="section" id="scheduleSection">
        <div class="section-header">Date and Showtime Selection</div>
        <div class="section-content">
            <!-- Date Selection -->
            <div class="date-selection">
                <c:forEach var="date" items="${dates}" varStatus="status">
                    <div class="date-item ${status.index == 0 ? 'active' : ''}"
                         data-date="${date.dateString}"
                         onclick="selectDate('${date.dateString}', this)">
                        <div class="date-day">${date.dayName}</div>
                        <div class="date-number">${date.dayNumber}</div>
                    </div>
                </c:forEach>
            </div>

            <!-- Movie Selection -->
            <div class="movie-grid" id="movieGrid">
                <c:choose>
                    <c:when test="${not empty movieRuntimes}">
                        <c:forEach var="movieEntry" items="${movieRuntimes}">
                            <c:set var="movieTitle" value="${movieEntry.key}"/>
                            <c:set var="runtimes" value="${movieEntry.value}"/>
                            <c:set var="firstRuntime" value="${runtimes[0]}"/>

                            <div class="movie-card">
                                <div class="movie-poster">
                                    <c:choose>
                                        <c:when test="${not empty firstRuntime.poster_url}">
                                            <img src="${firstRuntime.poster_url}" alt="${movieTitle}"
                                                 style="width: 100%; height: 100%; object-fit: cover;"/>
                                        </c:when>
                                        <c:otherwise>
                                            <div style="display: flex; align-items: center; justify-content: center; height: 100%; background: #f0f0f0; color: #666;">
                                                    ${movieTitle}
                                            </div>
                                        </c:otherwise>
                                    </c:choose>
                                </div>
                                <div class="movie-info">
                                    <div class="movie-title">${movieTitle}</div>
                                    <div class="movie-genre">${firstRuntime.movie_genre}</div>
                                    <div class="movie-rating">${firstRuntime.movie_rating}</div>
                                    <div class="showtimes-grid">
                                        <c:forEach var="runtime" items="${runtimes}">
                                            <c:set var="isSoldOut" value="${soldOutStatus[runtime.runtime_id]}"/>
                                            <div class="showtime-btn ${isSoldOut ? 'full' : ''}"
                                                 data-runtime-id="${runtime.runtime_id}"
                                                 data-movie-title="${movieTitle}"
                                                 data-start-time="${runtime.start_time}"
                                                 data-room-name="${runtime.room_name}"
                                                 data-available-seats="${runtime.available_seats}"
                                                 onclick="${isSoldOut ? '' : 'selectShowtime(this)'}">
                                                    ${runtime.start_time}
                                                <br><small>${runtime.room_name}</small>
                                                <br><small>${runtime.available_seats} seats</small>
                                            </div>
                                        </c:forEach>
                                    </div>
                                </div>
                            </div>
                        </c:forEach>
                    </c:when>
                    <c:otherwise>
                        <div style="text-align: center; padding: 40px; color: #666;">
                            No movies available for the selected date.
                        </div>
                    </c:otherwise>
                </c:choose>
            </div>

            <!-- Selected showtime information -->
            <div id="selectedShowtimeInfo"
                 style="display: none; background: #f8f9fa; padding: 15px; margin-top: 20px; border-radius: 8px;">
                <h4>Selected Showtime</h4>
                <p id="selectedDetails"></p>
                <button type="button" class="btn-primary" onclick="loadSeatSelection()">Select Seats</button>
            </div>
        </div>
    </div>

    <!-- Seat Selection Section -->
    <div class="section seat-selection" id="seatSelection">
        <div class="section-header">Seat Selection</div>
        <div class="section-content">
            <!-- Runtime Info -->
            <div class="seat-info">
                <div id="seatRuntimeInfo"></div>
            </div>

            <!-- Seat Legend -->
            <div class="seat-legend">
                <div class="legend-item">
                    <div class="legend-seat legend-available"></div>
                    <span>Available</span>
                </div>
                <div class="legend-item">
                    <div class="legend-seat legend-selected"></div>
                    <span>Selected</span>
                </div>
                <div class="legend-item">
                    <div class="legend-seat legend-reserved"></div>
                    <span>Reserved</span>
                </div>
            </div>

            <!-- Cinema Screen -->
            <div class="cinema-screen">SCREEN</div>

            <!-- Seat Map -->
            <div class="seat-map" id="seatMap">
                <!-- Seat layout is dynamically generated via JavaScript -->
            </div>

            <!-- Selected Seats Info -->
            <div class="selected-seats" id="selectedSeatsInfo">
                <h4>Selected Seats</h4>
                <div id="selectedSeatsList"></div>
                <div id="totalPrice"></div>
            </div>

            <!-- Seat Buttons -->
            <div class="seat-buttons">
                <button type="button" class="btn-secondary" onclick="cancelSeatSelection()">Previous Step</button>
                <button type="button" class="btn-primary" id="confirmSeatsBtn" onclick="confirmSeats()" disabled>Next Step
                </button>
            </div>
        </div>
    </div>

    <!-- ▼ Payment Section Start ▼ -->
    <div class="section payment-section" id="paymentSection" style="display:none;">
        <!-- Header -->
        <div class="section-header">Payment</div>
        <!-- Content -->
        <div class="section-content">
            <!-- Payment Summary -->
            <div id="paymentSummary" style="margin-bottom: 30px;"></div>

            <!-- Discount Coupon -->
            <div>
                <input type="checkbox" id="coupon-box" />
                <label for="coupon-box"> Apply $5 Coupon </label>
            </div>
            <!-- Payment UI -->
            <div id="payment-method"></div>
            <!-- Terms and Conditions UI -->
            <div id="agreement"></div>

            <!-- Pay Button -->
            <button type="button" id="payment-button" class="btn-primary" disabled>
                Pay Now
            </button>
        </div>
    </div>
    <!-- ▲ Payment Section End ▲ -->

    <!-- Complete Section -->
    <div id="completeSection" style="display:none;">
        <div id="completeMessage"></div>
        <button class="payButton" onclick="location.href='/reservation/list'">View Reservations</button>
    </div>
</div>

<script>
    let selectedShowtime = null;
    let selectedSeats = [];
    let allSeats = [];
    let seatPrice = 12000; // Default price

    // Date selection function
    function selectDate(dateString, element) {
        document.querySelectorAll('.date-item').forEach(item => {
            item.classList.remove('active');
        });
        element.classList.add('active');

        fetch('/schedule/date/' + dateString)
            .then(response => response.json())
            .then(data => {
                if (data.success) {
                    updateMovieGrid(data.movieRuntimes, data.soldOutStatus);
                    hideAllSections();
                } else {
                    alert(data.message || 'Unable to load data.');
                }
            })
            .catch(error => {
                console.error('Error:', error);
                alert('An error occurred. Please try again.');
            });
    }

    // Showtime selection (DOM element method)
    function selectShowtime(element) {
        console.log('🎬 Starting showtime selection');

        // Remove previous selection
        document.querySelectorAll('.showtime-btn').forEach(btn => {
            btn.classList.remove('selected');
        });

        // Mark current selection
        element.classList.add('selected');

        // Extract and validate data
        const runtimeId = element.dataset.runtimeId;
        const movieTitle = element.dataset.movieTitle;
        const startTime = element.dataset.startTime;
        const roomName = element.dataset.roomName;
        const availableSeats = element.dataset.availableSeats;

        console.log('📋 Extracted data:', {
            runtimeId: runtimeId,
            movieTitle: movieTitle,
            startTime: startTime,
            roomName: roomName,
            availableSeats: availableSeats
        });

        // Validate Runtime ID
        if (!runtimeId || runtimeId === 'undefined' || runtimeId === 'null') {
            console.error('❌ Invalid Runtime ID:', runtimeId);
            alert('There is an error in the showtime information. Please refresh the page.');
            return;
        }

        // Create selectedShowtime object
        selectedShowtime = {
            runtimeId: parseInt(runtimeId), // Convert to integer
            movieTitle: movieTitle,
            startTime: startTime,
            roomName: roomName,
            availableSeats: parseInt(availableSeats) // Convert to integer
        };

        console.log('✅ selectedShowtime setup complete:', selectedShowtime);

        // Display selected showtime information
        showSelectedInfo();
    }

    // Display selected showtime information
    function showSelectedInfo() {
        if (selectedShowtime) {
            const infoDiv = document.getElementById('selectedShowtimeInfo');
            const detailsP = document.getElementById('selectedDetails');

            if (infoDiv && detailsP) {
                detailsP.innerHTML = '<strong>' + selectedShowtime.movieTitle + '</strong><br>' +
                    selectedShowtime.startTime + ' | ' + selectedShowtime.roomName + ' | Available seats: ' + selectedShowtime.availableSeats + ' seats';

                infoDiv.style.display = 'block';
                console.log('✅ Selected showtime information display complete');
            }
        }
    }

    // Replace this loadSeatSelection function in the JSP file
    function loadSeatSelection() {
        if (!selectedShowtime) {
            alert('Please select a showtime first.');
            return;
        }

        // Update step display
        updateSteps(2);

        // Convert runtimeId to integer
        const runtimeId = parseInt(selectedShowtime.runtimeId);

        // Debug log
        console.log('🔍 Loading seat selection screen - Runtime ID:', runtimeId);
        console.log('📋 selectedShowtime:', selectedShowtime);

        // ✅ Use correct endpoint
        fetch(`/seat/\${runtimeId}/seats`)
            .then(response => {
                console.log('📡 Response status:', response.status);
                return response.json();
            })
            .then(data => {
                console.log('📦 Received data:', data);

                if (data.success) {
                    allSeats = data.seats;
                    seatPrice = data.runtime.price || 12000;

                    // Display seat selection screen
                    showSeatSelection(data.runtime, data.seats);
                    console.log('✅ Seat information loaded successfully:', data.seats.length + ' seats');
                } else {
                    alert(data.message || 'Unable to load seat information.');
                }
            })
            .catch(error => {
                console.error('❌ Seat information loading error:', error);
                alert('An error occurred while loading seat information: ' + error.message);
            });
    }

    // Display seat selection screen
    function showSeatSelection(runtime, seats) {
        // Display showtime information
        document.getElementById('seatRuntimeInfo').innerHTML =
            '<strong>' + runtime.movie_title + '</strong> | ' +
            runtime.start_time + ' | ' +
            runtime.room_name + ' | ' +
            runtime.price.toLocaleString() + ' won';

        // Create seat map
        createSeatMap(seats);

        // Switch screen
        document.getElementById('scheduleSection').style.display = 'none';
        document.getElementById('seatSelection').classList.add('active');
    }

    // Create seat map
    function createSeatMap(seats) {
        const seatMap = document.getElementById('seatMap');
        seatMap.innerHTML = '';

        // Group seats by row
        const seatsByRow = {};
        seats.forEach(seat => {
            if (!seatsByRow[seat.seat_row]) {
                seatsByRow[seat.seat_row] = [];
            }
            seatsByRow[seat.seat_row].push(seat);
        });

        // Create seats for each row
        Object.keys(seatsByRow).sort().forEach(row => {
            const rowDiv = document.createElement('div');
            rowDiv.className = 'seat-row';

            // Row label
            const rowLabel = document.createElement('div');
            rowLabel.className = 'seat-row-label';
            rowLabel.textContent = row;
            rowDiv.appendChild(rowLabel);

            // Seats
            seatsByRow[row].sort((a, b) => a.seat_number - b.seat_number).forEach(seat => {
                const seatDiv = document.createElement('div');
                seatDiv.className = 'seat';
                seatDiv.dataset.seatId = seat.seat_id;
                seatDiv.dataset.seatRow = seat.seat_row;
                seatDiv.dataset.seatNumber = seat.seat_number;
                seatDiv.textContent = seat.seat_number;

                if (seat.status === 'Reserved') {
                    seatDiv.classList.add('reserved');
                } else {
                    seatDiv.classList.add('available');
                    seatDiv.onclick = () => toggleSeat(seatDiv, seat);
                }

                rowDiv.appendChild(seatDiv);
            });

            seatMap.appendChild(rowDiv);
        });
    }

    // Select/deselect seat
    function toggleSeat(seatDiv, seat) {
        const seatId = parseInt(seatDiv.dataset.seatId);

        if (seatDiv.classList.contains('selected')) {
            // Deselect
            seatDiv.classList.remove('selected');
            seatDiv.classList.add('available');
            selectedSeats = selectedSeats.filter(s => parseInt(s.seat_id) !== seatId);
        } else {
            // Select
            seatDiv.classList.remove('available');
            seatDiv.classList.add('selected');
            // Convert seat object's seat_id to integer and store
            seat.seat_id = parseInt(seat.seat_id);
            selectedSeats.push(seat);
        }

        updateSelectedSeatsInfo();
    }

    // Update selected seats information
    function updateSelectedSeatsInfo() {
        const selectedSeatsInfo = document.getElementById('selectedSeatsInfo');
        const selectedSeatsList = document.getElementById('selectedSeatsList');
        const totalPrice = document.getElementById('totalPrice');
        const confirmBtn = document.getElementById('confirmSeatsBtn');

        if (selectedSeats.length > 0) {
            selectedSeatsInfo.classList.add('active');

            const seatLabels = selectedSeats.map(seat =>
                seat.seat_row + seat.seat_number
            ).join(', ');

            selectedSeatsList.innerHTML =
                '<strong>Selected Seats:</strong> ' + seatLabels + '<br>' +
                '<strong>Number of Seats:</strong> ' + selectedSeats.length + ' seats';

            totalPrice.innerHTML =
                '<strong>Total Amount:</strong> ' + (selectedSeats.length * seatPrice).toLocaleString() + ' won';

            confirmBtn.disabled = false;
        } else {
            selectedSeatsInfo.classList.remove('active');
            confirmBtn.disabled = true;
        }
    }

    // Cancel seat selection
    function cancelSeatSelection() {
        selectedSeats = [];
        updateSteps(1);
        document.getElementById('seatSelection').classList.remove('active');
        document.getElementById('scheduleSection').style.display = 'block';
    }

    // Confirm seat selection - Create actual reservation
    /**
     * Function to move to payment step after completing seat selection
     */
    function confirmSeats() {
        if (selectedSeats.length === 0) {
            alert('Please select seats.');
            return;
        }

        // Prepare to move to payment step
        const totalAmount = selectedSeats.length * seatPrice;
        const seatLabels = selectedSeats.map(seat => seat.seat_row + seat.seat_number).join(', ');

        // Call function to display payment section
        showPaymentSection(totalAmount, seatLabels);

        console.log('[confirmSeats] selectedShowtime', selectedShowtime);
    }

    /**
     * Function to set up and display payment section on screen
     */
    function showPaymentSection(amount, seatLabels) {
        // 1. Fill payment summary information
        document.getElementById('paymentSummary').innerHTML = `
            <div class="payment-summary-box">
               <h3>Final Booking Confirmation</h3>
            <p><strong>Movie:</strong> \${selectedShowtime.movieTitle}</p>
            <p><strong>Showtime:</strong> \${selectedShowtime.startTime}</p>
            <p><strong>Theater:</strong> \${selectedShowtime.roomName}</p>
            <p><strong>Seats:</strong> \${seatLabels}</p>
            <p><strong>Final Payment Amount:</strong> \${amount.toLocaleString()} won</p>
            </div>
        `;

        // 2. Update progress step to step 3 'Payment'
        updateSteps(3);

        // 3. Hide previous section and show payment section
        document.getElementById('seatSelection').classList.remove('active');
        document.getElementById('paymentSection').style.display = 'block';

        // 4. Enable 'Pay Now' button and connect click event
        const paymentButton = document.getElementById('payment-button');
        paymentButton.disabled = false; // Enable button
        paymentButton.onclick = processPaymentAndReserve; // Connect actual reservation processing function
    }

    /**
     * Function to process final reservation when 'Pay Now' button is clicked
     */
    function processPaymentAndReserve() {
        // Disable button to prevent duplicate clicks
        document.getElementById('payment-button').disabled = true;

        const runtimeId = parseInt(selectedShowtime.runtimeId);
        const selectedSeatIds = selectedSeats.map(seat => parseInt(seat.seat_id));

        // Request reservation creation to server (logic from existing confirmSeats)
        fetch('/seat/reserve', {
            method: 'POST',
            headers: {'Content-Type': 'application/json'},
            body: JSON.stringify({
                runtimeId: runtimeId,
                selectedSeatIds: selectedSeatIds
            })
        })
            .then(response => response.json())
            .then(data => {
                if (data.success) {
                    // Show completion screen on successful reservation
                    updateSteps(4);
                    document.getElementById('paymentSection').style.display = 'none'; // Hide payment section
                    showReservationComplete(data.reservation);
                } else {
                    // On reservation failure
                    alert(data.message || 'An error occurred during reservation.');
                    document.getElementById('payment-button').disabled = false; // Enable button for retry
                }
            })
            .catch(error => {
                console.error('Error:', error);
                alert('An error occurred during reservation processing.');
                document.getElementById('payment-button').disabled = false; // Enable button
            });
    }

    // Display reservation completion screen
    function showReservationComplete(reservation) {
        const completeSection = document.getElementById('completeSection');
        const completeMessage = document.getElementById('completeMessage');

        completeMessage.innerHTML = `
            <h2>Reservation Completed!</h2>
            <p><strong>Reservation Number:</strong> \${reservation.reservation_id}</p>
            <p><strong>Movie:</strong> \${reservation.movie_title}</p>
            <p><strong>Showtime:</strong> \${reservation.start_time}</p>
            <p><strong>Theater:</strong> \${reservation.room_name}</p>
            <p><strong>Seats:</strong> \${reservation.selected_seats}</p>
            <p><strong>Total Amount:</strong> \${reservation.total_amount.toLocaleString()} won</p>
        `;

        completeSection.style.display = 'block';
    }

    // Update steps
    function updateSteps(activeStep) {
        document.querySelectorAll('.step').forEach((step, index) => {
            if (index + 1 <= activeStep) {
                step.classList.remove('inactive');
            } else {
                step.classList.add('inactive');
            }
        });
    }

    // Hide all sections
    function hideAllSections() {
        document.getElementById('selectedShowtimeInfo').style.display = 'none';
        document.getElementById('seatSelection').classList.remove('active');
        document.getElementById('scheduleSection').style.display = 'block';
        selectedShowtime = null;
        selectedSeats = [];
        updateSteps(1);
    }

    // Update movie grid (existing function)
    function updateMovieGrid(movieRuntimes, soldOutStatus) {
        const movieGrid = document.getElementById('movieGrid');

        if (!movieRuntimes || Object.keys(movieRuntimes).length === 0) {
            movieGrid.innerHTML = '<div style="text-align: center; padding: 40px; color: #666;">No movies available for the selected date.</div>';
            return;
        }

        let html = '';
        for (const [movieTitle, runtimes] of Object.entries(movieRuntimes)) {
            const firstRuntime = runtimes[0];
            html += '<div class="movie-card">';
            html += '<div class="movie-poster">';

            if (firstRuntime.poster_url) {
                html += '<img src="' + firstRuntime.poster_url + '" alt="' + movieTitle + '" style="width: 100%; height: 100%; object-fit: cover;" />';
            } else {
                html += '<div style="display: flex; align-items: center; justify-content: center; height: 100%; background: #f0f0f0; color: #666;">' + movieTitle + '</div>';
            }

            html += '</div>';
            html += '<div class="movie-info">';
            html += '<div class="movie-title">' + movieTitle + '</div>';
            html += '<div class="movie-genre">' + firstRuntime.movie_genre + '</div>';
            html += '<div class="movie-rating">' + firstRuntime.movie_rating + '</div>';
            html += '<div class="showtimes-grid">';

            runtimes.forEach(runtime => {
                const isSoldOut = soldOutStatus[runtime.runtime_id];
                html += '<div class="showtime-btn ' + (isSoldOut ? 'full' : '') + '"';
                html += ' data-runtime-id="' + runtime.runtime_id + '"';
                html += ' data-movie-title="' + movieTitle + '"';
                html += ' data-start-time="' + runtime.start_time + '"';
                html += ' data-room-name="' + runtime.room_name + '"';
                html += ' data-available-seats="' + runtime.available_seats + '"';
                if (!isSoldOut) {
                    html += ' onclick="selectShowtime(this)"';
                }
                html += '>';
                html += runtime.start_time;
                html += '<br><small>' + runtime.room_name + '</small>';
                html += '<br><small>' + runtime.available_seats + ' seats</small>';
                html += '</div>';
            });

            html += '</div>';
            html += '</div>';
            html += '</div>';
        }

        movieGrid.innerHTML = html;
    }

    // TossPay
    main();

    async function main() {
        const button = document.getElementById("payment-button");
        const coupon = document.getElementById("coupon-box");
        // ------  Initialize payment widget ------
        const clientKey = "test_gck_docs_Ovk5rk1EwkEbP0W43n07xlzm";
        const tossPayments = TossPayments(clientKey);
        // Member payment
        const customerKey = "qMATQmTPqT9RMvmO0EpQQ";
        const widgets = tossPayments.widgets({
            customerKey,
        });
        // Non-member payment
        // const widgets = tossPayments.widgets({ customerKey: TossPayments.ANONYMOUS });

        // ------ Set payment amount for order ------
        await widgets.setAmount({
            currency: "KRW",
            value: 50000,
        });

        await Promise.all([
            // ------  Render payment UI ------
            widgets.renderPaymentMethods({
                selector: "#payment-method",
                variantKey: "DEFAULT",
            }),
            // ------  Render terms and conditions UI ------
            widgets.renderAgreement({ selector: "#agreement", variantKey: "AGREEMENT" }),
        ]);

        // ------  Update payment amount when order payment amount changes ------
        coupon.addEventListener("change", async function () {
            if (coupon.checked) {
                await widgets.setAmount({
                    currency: "KRW",
                    value: 50000 - 5000,
                });

                return;
            }

            await widgets.setAmount({
                currency: "KRW",
                value: 50000,
            });
        });

        // ------ Show payment window when 'Pay Now' button is pressed ------
        // button.addEventListener("click", async function () {
        //     await widgets.requestPayment({
        //         orderId: "ualqx-0Mvh-wmo9smOcnr",
        //         orderName: "Toss T-shirt and 2 other items",
        //         successUrl: window.location.origin + "/success.html",
        //         failUrl: window.location.origin + "/fail.html",
        //         customerEmail: "customer123@gmail.com",
        //         customerName: "Kim Toss",
        //         customerMobilePhone: "01012341234",
        //     });
        // });
    }
</script>
</body>
<script src="/resources/js/schedule.js"></script>
</html>