# Pandoraverse

Pandoraverse is a new parallel universe designed to explore restaurants through Augmented Reality. With this app, we won the Most Innovative and the Best Presentation award at Delivery Hero Hackathon 2021.

Demo video: https://youtu.be/n8FEU-vJO0U

Features:
- See the nearby restaurants & navigate to a specific restaurant
    - The main idea is to show nearby restaurants information as AR contents where user can click it and see the details
    - This part is built based on https://github.com/DanijelHuis/HDAugmentedReality
- See Foodpanda related marketing contents (such as vouchers, banners) placed in the real world through the Augmented Reality technology
    - To build this part, we use the sample app from this [tutorial]( https://developer.apple.com/documentation/arkit/environmental_analysis/placing_objects_and_handling_3d_interaction#overview) and only made some changes to the 3D object texture image

Initially, we planned to use [Location Anchor from ARKit 4](https://developer.apple.com/videos/play/wwdc2020/10611) and place geo-referenced AR contents (restaurant information, marketing or loyalty contents, etc) in each restaurant coordinate. But unfortunately, this feature is only available in US at the moment.
