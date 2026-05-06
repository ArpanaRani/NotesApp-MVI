import Foundation
import LocalAuthentication

enum BiometricAuthError: Error {
    case notAvailable
    case failed
}

struct BiometricAuthService {
    enum Biometry {
        case none
        case faceID
        case touchID
    }

    func availableBiometry() -> Biometry {
        let context = LAContext()
        var error: NSError?
        guard context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) else {
            return .none
        }

        switch context.biometryType {
        case .faceID: return .faceID
        case .touchID: return .touchID
        default: return .none
        }
    }

    func authenticate(reason: String) async throws {
        let context = LAContext()
        context.localizedCancelTitle = "Cancel"

        var error: NSError?
        guard context.canEvaluatePolicy(.deviceOwnerAuthentication, error: &error) else {
            throw BiometricAuthError.notAvailable
        }

        let success: Bool = try await withCheckedThrowingContinuation { continuation in
            context.evaluatePolicy(.deviceOwnerAuthentication, localizedReason: reason) { ok, evalError in
                if let evalError {
                    continuation.resume(throwing: evalError)
                } else {
                    continuation.resume(returning: ok)
                }
            }
        }

        if !success {
            throw BiometricAuthError.failed
        }
    }
}

