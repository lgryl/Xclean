import XcleanCore

let xclean = Xclean()

do {
    try xclean.run()
} catch {
    print("Whoops! An error occurred: \(error)")
}
