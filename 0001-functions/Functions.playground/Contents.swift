
func incr(_ x: Int) -> Int {
  return x + 1
}

incr(2)

func square(_ x: Int) -> Int {
  return x * x
}

square(incr(2))

extension Int {
  func incr() -> Int {
    return self + 1
  }

  func square() -> Int {
    return self * self
  }
}

2.incr()
2.incr().square()

precedencegroup ForwardApplication {
  associativity: left
}

infix operator |>: ForwardApplication

func |> <A, B>(x: A, f: (A) -> B) -> B {
  return f(x)
}

2 |> incr |> square

extension Int {
  func incrAndSquare() -> Int {
    return self.incr().square()
  }
}

precedencegroup ForwardComposition {
  higherThan: ForwardApplication
  associativity: right
}
infix operator >>>: ForwardComposition

/* this is original
func >>> <A, B, C>(_ f: @escaping (A) -> B, _ g: @escaping (B) -> C) -> ((A) -> C) {
    return { a in g(f(a)) }
}
*/

// ss this also works since we aren't chaning types
func >>> <A>(_ f: @escaping (A) -> A, _ g: @escaping (A) -> A) -> ((A) -> A) {
  return { a in g(f(a)) }
}


2 |> incr >>> square

let z = 2 |> incr >>> square // this does not return a function but an Int

// 2 |> z // proves that an Int was returned not a function

[1, 2, 3]
  .map(square)
  .map(incr)

[1, 2, 3]
  .map(square >>> incr)
