//
//  ColorPickerView.swift
//  DailyActivities
//
//  Created by Theo Sementa on 16/06/2025.
//

import SwiftUI
import TheoKit

struct ColorPickerView: View {
    
    // MARK: Dependencies
    @Binding var selectedColor: Color?
    var colorWidth: CGFloat
    
    // MARK: States
    @State private var customColor: Color = .red
    @State private var isCustomColorsAlreadySelected: Bool = false
    @State private var isColorPickerPresented: Bool = false
    
    // MARK: Constants
    let defaultColors: [Color] = [
        Color(hex: "007AFF"),
        Color(hex: "FF3B30"),
        Color(hex: "34C759"),
        Color(hex: "AF52DE"),
        Color(hex: "FF2F90"),
    ]
    
    // MARK: - View
    var body: some View {
        ScrollView(.horizontal) {
            HStack(spacing: TKDesignSystem.Spacing.small) {
                Button { isColorPickerPresented.toggle() } label: {
                    ZStack {
                        RoundedRectangle(cornerRadius: TKDesignSystem.Radius.medium, style: .continuous)
                            .fill(isCustomColorsAlreadySelected ? customColor : TKDesignSystem.Colors.Background.Theme.bg100)
                            .strokeBorder(selectedColor == customColor ? Color.white : Color.clear, lineWidth: 3)
                        
                        if !isCustomColorsAlreadySelected {
                            IconSVGView(icon: .iconDiamondPlus, value: .large)
                                .foregroundStyle(Color.white)
                        }
                    }
                    .frame(width: colorWidth, height: colorWidth)
                }

                ForEach(defaultColors, id: \.self) { color in
                    Button { selectedColor = color } label: {
                        RoundedRectangle(cornerRadius: TKDesignSystem.Radius.medium, style: .continuous)
                            .fill(color)
                            .strokeBorder(selectedColor == color ? Color.white : Color.clear, lineWidth: 3)
                            .frame(width: colorWidth, height: colorWidth)
                    }
                
                }
                .animation(.smooth, value: selectedColor)
            }
        }
        .scrollIndicators(.hidden)
        .onAppear {
            self.selectedColor = defaultColors.first
        }
        .onChange(of: customColor) {
            self.selectedColor = customColor
            isCustomColorsAlreadySelected = true
        }
        .sheet(isPresented: $isColorPickerPresented) {
            ColorPickerUIKITView(
                selectedColor: customColor,
                didSelectColor: { color in
                    self.customColor = color
                }
            )
            .padding(.top, 8)
            .background(TKDesignSystem.Colors.Background.Theme.bg50)
            .presentationDetents([.height(640)])
        }
    }
}

// MARK: - Preview
#Preview {
    @Previewable @State var selectedColor: Color? = nil
    ColorPickerView(selectedColor: $selectedColor, colorWidth: 50)
        .preferredColorScheme(.dark)
}





class ColorPickerDelegate: NSObject, UIColorPickerViewControllerDelegate {
    var didSelectColor: ((Color) -> Void)

    init(_ didSelectColor: @escaping ((Color) -> Void)) {
        self.didSelectColor = didSelectColor
    }

    func colorPickerViewController(
        _ viewController: UIColorPickerViewController,
        didSelect color: UIColor,
        continuously: Bool
    ) {
        let selectedUIColor = viewController.selectedColor
        didSelectColor(Color(uiColor: selectedUIColor))
    }

    func colorPickerViewControllerDidFinish(_ viewController: UIColorPickerViewController) {
        print("dismiss colorPicker")
    }

}

struct ColorPickerUIKITView: UIViewControllerRepresentable {
    private let delegate: ColorPickerDelegate
    private let selectedColor: UIColor

    init(selectedColor: Color, didSelectColor: @escaping ((Color) -> Void)) {
        self.selectedColor = UIColor(selectedColor)
        self.delegate = ColorPickerDelegate(didSelectColor)
    }

    func makeUIViewController(context: Context) -> UIColorPickerViewController {
        let colorPickerController = UIColorPickerViewController()
        colorPickerController.delegate = delegate
        colorPickerController.title = "create_cat_choose_color".localized
        colorPickerController.selectedColor = selectedColor
        return colorPickerController
    }

    func updateUIViewController(_ uiViewController: UIColorPickerViewController, context: Context) {}
}
