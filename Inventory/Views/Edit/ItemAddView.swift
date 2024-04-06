
import SwiftUI
import PhotosUI

struct ItemEditView: View {
    
    // MARK: - Properties
    
    @StateObject private var itemDetailViewModel = ItemDetailViewModel()
    
    @Environment(\.dismiss) private var dismiss
    
    @State private var itemPick: PhotosPickerItem?
    @State private var itemImage: Image?

    
    
    // MARK: - Body
    
    var body: some View {
        NavigationStack {
            Form {
                Section("Name des Gegenstandes") {
                    TextField("Name", text: $itemDetailViewModel.name)
                }
                Section("Gebe hier die Anzahl ein") {
                    TextField("Anzahl", value: $itemDetailViewModel.count, formatter: NumberFormatter())
                        .keyboardType(.numberPad)
                }
                
                Section("Füge optional ein Bild hinzu") {
                    PhotosPicker("Bild hinzufügen", selection: $itemPick, matching: .images)
                    itemImage?
                        .resizable()
                        .scaledToFit()
                        .frame(width: 300, height: 300)
                }
                .onChange(of: itemPick) {
                    Task {
                        guard let data = try? await itemPick?.loadTransferable(type: Data.self) else {
                            print("Failed to load image data")
                            return
                        }

                        // Convert the data to UIImage for display
                        if let uiImage = UIImage(data: data) {
                            DispatchQueue.main.async {
                                // Update the SwiftUI Image for display in the UI
                                itemImage = Image(uiImage: uiImage)
                                // Also set the UIImage in the view model for any UI handling
                                itemDetailViewModel.image = uiImage
                            }
                        } else {
                            print("Failed to create UIImage from data")
                        }
                    }
                }

                Button(action: save) {
                    Text("Speichern")
                }
                .disabled(itemDetailViewModel.disableSaving)
            }
            .navigationTitle("Neuer Gegenstand")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                Button(action: dismissView) {
                    Image(systemName: "xmark.circle.fill")
                }
            }
        }
    }
    
    
    
    // MARK: - Functions
    
    private func save() {
        itemDetailViewModel.save()
        dismissView()
    }
    
    private func dismissView() {
        dismiss()
    }
    
}

struct ItemEditView_Previews: PreviewProvider {
    static var previews: some View {
        ItemEditView()
    }
}
