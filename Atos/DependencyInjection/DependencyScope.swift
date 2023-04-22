import Foundation

// We can keep dependencies with different scopes
//
// .shared - we create one instance that we keep in the memory
//           and the same instance is resolved everytime
//
// .transient - we create new instance everytime something
//              resolves this dependency
enum DependencyScope {
    case shared
    case transient
}
