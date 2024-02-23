/*
See the LICENSE.txt file for this sample’s licensing information.

Abstract:
A detail view that presents information about different module types.
*/

import SwiftUI

/// A detail view that presents information about different module types.
struct ModuleDetail: View {
    @Environment(ViewModel.self) private var model

    var module: Module

    var body: some View {
        @Bindable var model = model

        GeometryReader { proxy in
            let textWidth = min(max(proxy.size.width * 0.4, 300), 500)
            let imageWidth = min(max(proxy.size.width - textWidth, 300), 700)
            ZStack {
                HStack(spacing: 60) {
                    VStack(alignment: .leading, spacing: 0) {
                        Text(module.heading)
                            .font(.system(size: 50, weight: .bold))
                            .padding(.bottom, 15)

                        Text(module.overview)
                            .padding(.bottom, 30)

                        switch module {
                        case .globe:
                            GlobeToggle()
                        case .orbit:
                            OrbitToggle()
                        case .solar:
                            SolarSystemToggle()
                        }
                    }
                    .frame(width: textWidth, alignment: .leading)

                    module.detailView
                        .frame(width: imageWidth, alignment: .center)
                }
                .offset(y: -30)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
        .padding(70)
        .background {
            if module == .solar {
                Image("SolarBackground")
                    .resizable()
                    .scaledToFill()
            }
        }

        // A settings button in an ornament,
        // visible only when `showDebugSettings` is true.
        .settingsButton(module: module)
   }
}

extension Module {
    @ViewBuilder
    fileprivate var detailView: some View {
        switch self {
        case .globe: GlobeModule()
        case .orbit: OrbitModule()
        case .solar: SolarSystemModule()
        }
    }
}

#Preview("Globe") {
    NavigationStack {
        ModuleDetail(module: .globe)
            .environment(ViewModel())
    }
}

#Preview("Orbit") {
    NavigationStack {
        ModuleDetail(module: .orbit)
            .environment(ViewModel())
    }
}

#Preview("Solar System") {
    NavigationStack {
        ModuleDetail(module: .solar)
            .environment(ViewModel())
    }
}
