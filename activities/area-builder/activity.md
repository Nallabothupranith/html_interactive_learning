---
order: 106
class: VII
subject: Mathematics
topic: Perimeter and Area
title: Area Builder
paths:
- label: Area Builder
  path: index.html
- label: Simulator
  path: https://pythonstudio.technikh.com/#preview=phone&code=%23%20Area%20Builder%0A%23%20Each%20grid%20square%20is%201%20%C3%97%201%20unit%0A%0A%0Alength%20%3D%20int(input(%22Enter%20the%20length%20of%20the%20rectangle%3A%20%22))%0Abreadth%20%3D%20int(input(%22Enter%20the%20breadth%20of%20the%20rectangle%3A%20%22))%0A%0A%23%20Calculate%20area%20and%20perimeter%0Aarea%20%3D%20length%20*%20breadth%0Aperimeter%20%3D%202%20*%20(length%20%2B%20breadth)%0A%0Aprint(%22%5Cn---%20Rectangle%20---%22)%0A%0A%23%20Display%20the%20grid%0Afor%20i%20in%20range(breadth)%3A%0A%20%20%20%20print(%22%E2%96%A0%20%22%20*%20length)%0A%0Aprint(%22%5CnArea%20%3D%22%2C%20area%2C%20%22square%20units%22)%0Aprint(%22Perimeter%20%3D%22%2C%20perimeter%2C%20%22units%22)%0A%0A%23%20Compare%0Aprint(%22%5Cn---%20Comparison%20---%22)%0A%0Aif%20area%20%3E%20perimeter%3A%0A%20%20%20%20print(%22Area%20is%20greater%20than%20perimeter.%22)%0Aelif%20area%20%3C%20perimeter%3A%0A%20%20%20%20print(%22Perimeter%20is%20greater%20than%20area.%22)%0Aelse%3A%0A%20%20%20%20print(%22Area%20and%20perimeter%20have%20the%20same%20numerical%20value.%22)%0A%0A%23%20Verification%0Asquares%20%3D%20length%20*%20breadth%0A%0Aprint(%22%5Cn---%20Verification%20---%22)%0Aprint(%22Number%20of%20small%20squares%20inside%20%3D%22%2C%20squares)%0Aprint(%22Area%20using%20multiplication%20%3D%22%2C%20length%2C%20%22%C3%97%22%2C%20breadth%2C%20%22%3D%22%2C%20area)%0A%0Aif%20squares%20%3D%3D%20area%3A%0A%20%20%20%20print(%22%E2%9C%93%20Area%20verified!%22)
---

Change the length and breadth of a rectangle, count grid squares, and calculate area and perimeter.
