# SMButton
SMButton - Inspired by Foodpanda


# Usage
SMButton creation

        // Create an instance of SMButton
        let customButton = SMButton(frame: CGRect(x: 0, y: 0, width: 300, height: 40), title: "Checkout")
        // Add it to view's subview
        view.addSubview(customButton)
        // Position it as you would do for anyother button
        customButton.center = view.center
       
Control SMButton's activity status

        // Update SMButton's activity status by updating its 'updateStatus' property
        @IBAction func start(_ sender: Any) {
            customButton.updateStatus = .start
        }
    
        @IBAction func succeed(_ sender: Any) {
            customButton.updateStatus = .success
        }
    
        @IBAction func fail(_ sender: Any) {
            customButton.updateStatus = .failed
        }
