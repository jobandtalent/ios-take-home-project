
Make sure to do all the work in a private repository and, once finished, invite the following people:

https://github.com/broomburgo
https://github.com/dani-mendez
https://github.com/andrearori
https://github.com/rico-crescenzio
https://github.com/lucaangeletti-jobandtalent

```bash
git clone git@github.com:jobandtalent/ios-take-home-project.git
cd ios-take-home-project
git remote set-url origin git@github.com:<your-private-repo>.git
git push
```

_In case of questions, feel free to contact mobile-ios@jobandtalent.com_.

---

The _MiniJobandtalent_ app consists of a simple list of jobs that you can apply to. The project code quality is far from ideal, and it’s your responsibility to fix it. __Each step must be accomplished via a single commit__, whose message must provide further explanations about the changes: we will review the project commit-by-commit, and will use the commit message as a guide to the code, so we expect that each commit message contains __the number of the task__ and a description of the code that was added, removed or modified.

It's recommended that you read all the steps before starting. We really value, for reviewing purposes, that __you stick to what it's asked for in each task__: there is __room for you to show off__ in the two final steps, where you'll be able to apply a particular architecture to the project, if you want.

_Before executing the app, you must run the underlying server providing the static JSON data._

```bash
npm install -g json-server
json-server minijobandtalent.json --port 8000
```

1. The app crashes on startup. Figure out why and fix it.
2. Fix the layout bug happening when applying to the first job.
3. Can you discover the retain cycle hidden inside `JobListViewController`? Could you fix it?
4. Include any feedback inside `JobListViewController` while the information is retrieved.
5. `JobCell` notifies via `NotificationCenter` when applying to a job. What problems can you see with this solution? Implement a better one to propagate state changes using the current reference semantics.
6. `JobListViewController` relies on lifecycle methods like `viewWillAppear` to reflect the changes made in the detail view when coming back to the list. Come up with a different solution, so the list is refreshed instantly and reactively whenever a job is applied.
7. Change `Job` to be a value type without modifying the current app behavior. What are the main advantages and disadvantages of using value semantics for this case?
8. We want to show the number of _applicants_ for each job. Due to backend under-the-hood caching issues, the applicants’ information is provided in a different API call from the [following URL](http://localhost:8000/applicants). Modify the app, so `JobCell` shows the correct number of applicants coming from the JSON.
9. Make the aforementioned _applicants_ change when applying for a job.
10. `URLSessionDataTask` API provides the following completion handler: `(Data?, URLResponse?, Error?) -> Void)`. Can you see any problems with that handler input? Can you extend URLSession to provide a more typed-correct version?
11. Having types wrapping functions (like completion handlers) has great advantages, like allowing to provide some high-level constructions like `map` or `flatMap`. Create a new container type `AsyncResult<T, E: Error>` that wraps a function like `((Result<T, E>) -> Void) -> Void` and notifies you in case of success or failure. Implement `map` and `flatMap`.

The main functions on `AsyncResult<T, E: Error>` should have these signatures:
```swift
// within the definition of `AsyncResult<T, E: Error>`

init(_ run: ((Result<T, E>) -> Void) -> Void) {}

func map<U>(_ transform: (T) -> U) -> AsyncResult<U, E> {}

func flatMap<U>(_ transform: (T) -> AsyncResult<U, E>) -> AsyncResult<U, E> {}
```
Feel free to add `@escaping` where required.

12. Extend `URLSession` API to return `AsyncResult` instead of providing completion handlers.
13. Implement a function like the following:
```swift
func chooseSomeName<T1, T2, E: Error>(_ first: AsyncResult<T1, E>, _ second: AsyncResult<T2, E>) -> AsyncResult<(T1, T2), E>
```
Use it to compute the information needed for the list screen to be rendered (the list of jobs and the number of applicants). __How would you name this function?__

14. By using the previous `AsyncResult` type, change the _apply_ action to be an asynchronous operation that takes one second to complete and can never fail.
15. `JobListViewController` is currently pushing `JobDetailViewController` on top of the navigation stack. What are the disadvantages of that approach? Provide a better API and future-proof solution to handle navigation more robustly.
16. Apply further cleanup so that you feel the code is production-ready. Move things around and apply the architecture you feel more comfortable with.
17. Add enough testing to be confident applying changes to your code.
