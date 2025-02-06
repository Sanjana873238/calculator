<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">
    <title>Simple Calculator</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f0f0f0;
        }
        .calculator {
            width: 300px;
            margin: 50px auto;
            padding: 20px;
            background-color: #fff;
            border: 1px solid #ddd;
            border-radius: 10px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        }
        .display {
            width: 100%;
            height: 40px;
            margin-bottom: 20px;
            padding: 10px;
            font-size: 24px;
            font-weight: bold;
            text-align: right;
            border: none;
            border-radius: 10px;
            box-shadow: inset 0 0 10px rgba(0, 0, 0, 0.1);
        }
        .buttons {
            display: grid;
            grid-template-columns: repeat(4, 1fr);
            grid-gap: 10px;
        }
        .button {
            padding: 10px;
            font-size: 18px;
            font-weight: bold;
            text-align: center;
            border: none;
            border-radius: 10px;
            background-color: #fff;
            cursor: pointer;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        }
        .button:hover {
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.3);
        }
        .button:active {
            transform: scale(0.9);
        }
        .error {
            font-size: 18px;
            font-weight: bold;
            margin-bottom: 20px;
        }
        .modal-content {
            background-color: #fff;
            border: 1px solid #ddd;
            border-radius: 10px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        }
        .modal-body {
            padding: 20px;
            font-size: 18px;
            font-weight: bold;
        }
    </style>
</head>
<body>
    <div class="calculator">
        <input type="text" id="display" class="display" disabled>
        <div class="error" id="error"></div>
        <div class="buttons">
            <button class="button" onclick="clearDisplay()">C</button>
            <button class="button" onclick="backspace()">DEL</button>
            <button class="button" onclick="calculate('%')">%</button>
            <button class="button" onclick="calculate('/')">/</button>
            <button class="button" onclick="appendNumber(7)">7</button>
            <button class="button" onclick="appendNumber(8)">8</button>
            <button class="button" onclick="appendNumber(9)">9</button>
            <button class="button" onclick="calculate('*')">*</button>
            <button class="button" onclick="appendNumber(4)">4</button>
            <button class="button" onclick="appendNumber(5)">5</button>
            <button class="button" onclick="appendNumber(6)">6</button>
            <button class="button" onclick="calculate('-')">-</button>
            <button class="button" onclick="appendNumber(1)">1</button>
            <button class="button" onclick="appendNumber(2)">2</button>
            <button class="button" onclick="appendNumber(3)">3</button>
            <button class="button" onclick="calculate('+')">+</button>
            <button class="button" onclick="appendNumber(0)">0</button>
            <button class="button" onclick="appendNumber('.')">.</button>
            <button class="button" onclick="calculate('=')">=</button>
            <button class="button" data-bs-toggle="modal" data-bs-target="#historyModal">History</button>
        </div>
    </div>

    <div class="modal fade" id="historyModal" tabindex="-1" aria-labelledby="historyModalLabel" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="historyModalLabel">Calculation History</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body" id="history"></div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                </div>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p" crossorigin="anonymous"></script>
    <script>
        let display = document.getElementById('display');
        let error = document.getElementById('error');
        let historyModal = document.getElementById('history');
        let currentNumber = '';
        let previousNumber = '';
        let operation = '';
        let calculations = [];

        function appendNumber(number) {
            currentNumber += number.toString();
            display.value = currentNumber;
        }

        function calculate(op) {
            if (op === '=') {
                if (operation === '') {
                    error.textContent = 'No operation selected';
                    return;
                }
                try {
                    let result = eval(previousNumber + operation + currentNumber);
                    display.value = result;
                    calculations.push(previousNumber + operation + currentNumber + '=' + result);
                    updateHistory();
                    currentNumber = result.toString();
                    previousNumber = '';
                    operation = '';
                } catch (e) {
                    error.textContent = 'Error: ' + e.message;
                }
            } else {
                previousNumber = currentNumber;
                operation = op;
                currentNumber = '';
                display.value = '';
            }
        }

        function clearDisplay() {
            currentNumber = '';
            previousNumber = '';
            operation = '';
            display.value = '';
            error.textContent = '';
        }

        function backspace() {
            currentNumber = currentNumber.slice(0, -1);
            display.value = currentNumber;
        }

        function updateHistory() {
            historyModal.textContent = '';
            calculations.forEach(calculation => {
                let paragraph = document.createElement('p');
                paragraph.textContent = calculation;
                historyModal.appendChild(paragraph);
            });
        }

        document.addEventListener('keydown', function(event) {
            if (event.key === '0') {
                appendNumber(0);
            } else if (event.key === '1') {
                appendNumber(1);
            } else if (event.key === '2') {
                appendNumber(2);
            } else if (event.key === '3') {
                appendNumber(3);
            } else if (event.key === '4') {
                appendNumber(4);
            } else if (event.key === '5') {
                appendNumber(5);
            } else if (event.key === '6') {
                appendNumber(6);
            } else if (event.key === '7') {
                appendNumber(7);
            } else if (event.key === '8') {
                appendNumber(8);
            } else if (event.key === '9') {
                appendNumber(9);
            } else if (event.key === '.') {
                appendNumber('.');
            } else if (event.key === '+') {
                calculate('+');
            } else if (event.key === '-') {
                calculate('-');
            } else if (event.key === '*') {
                calculate('*');
            } else if (event.key === '/') {
                calculate('/');
            } else if (event.key === '%') {
                calculate('%');
            } else if (event.key === 'Enter') {
                calculate('=');
            } else if (event.key === 'Backspace') {
                backspace();
            } else if (event.key === 'c' || event.key === 'C') {
                clearDisplay();
            }
        });
    </script>
</body>
</html>