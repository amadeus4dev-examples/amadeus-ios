## Development and Testing

The project depends on Swift. You can follow the [Getting Started](https://swift.org/getting-started/) guide to get it installed.

To develop and debug the project locally, clone the repository, and then create a Xcode project:

```sh
git clone https://github.com/amadeus4dev/amadeus-ios.git
cd amadeus-ios
swift package generate-xcodeproj
```

The command will create a new `Amadeus.xcodeproj` folder. You can open the project to develop and debug from Xcode IDE

```sh
open Amadeus.xcodeproj
```
### Running tests

Some tests depend on your Amadeus for Developers API credentials. Make sure your credentials are exported as environment varibles before opening Xcode:

```sh
export AMADEUS_CLIENT_ID="amadeusclientid"
export AMADEUS_CLIENT_SECRET="amadeusclientsecret"

open Amadeus.xcodeproj
```

# Asking Questions

We don't use GitHub as a support forum. If you have issues with the APIs or SDKs, please use [Stack Overflow](https://stackoverflow.com/questions/tagged/amadeus).

#### **Did you find a bug?**

* **Ensure the bug was not already reported** by searching on GitHub under [Issues](https://github.com/amadeus4dev/amadeus-ios/issues).

* If you're unable to find an open issue addressing the problem, [open a new one](https://github.com/amadeus4dev/amadeus-ios/issues/new). Be sure to include a **title and clear description**, as much relevant information as possible, and a **code sample** or an **executable test case** demonstrating the expected behavior that is not occurring.

#### **Did you write a patch that fixes a bug?**

* Open a new GitHub pull request with the patch.

* Ensure the PR description clearly describes the problem and solution. Include the relevant issue number if applicable.

#### **Do you intend to add a new feature or change an existing one?**

* Suggest your change [in a new issue](https://github.com/amadeus4dev/amadeus-python/ios/new) and start writing code.

* Make sure your new code does not break any tests and include new tests.

* With good code comes good documentation. Try to copy the existing documentation and adapt it to your needs.

* Close the issue or mark it as inactive if you decide to discontinue working on the code.

#### **Do you have questions about the source code?**

* Ask any question about how to use the library by [raising a new issue](https://github.com/amadeus4dev/amadeus-ios/issues/new).
