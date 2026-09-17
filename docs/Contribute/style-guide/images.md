# Images


## Image guidelines 

Images play a crucial role in our documentation. They visually guide users through FusionReactor's features, illustrate complex concepts, and enhance the overall user experience. This guide outlines best practices for creating and maintaining images in FusionReactor's documentation.



### Image Types

We primarily use four categories of images in our documentation:

1. Screenshots
2. Diagrams
3. Charts and graphs
4. Icons and logos

#### Screenshots

Screenshots are essential for our users. They consistently request more high-quality screenshots in our documentation surveys.

```
We use two types of screenshots in FusionReactor documentation:

1. Full screenshots: These show the entire FusionReactor UI, helping users orient themselves within the application.
2. Cropped screenshots: These focus on specific UI elements or features when the full UI might be distracting.

Guidelines for FusionReactor screenshots:

* Use FusionReactor's dark mode for consistency.
* Always mask or crop sensitive information.
* Follow our image annotation guidelines and use annotations sparingly.
* Add captions when necessary (see caption guidelines below).
* Crop out non-UI elements like mouse pointers or browser tabs.
* If blurring is required, use Gaussian blur for a professional appearance.
```

### Captions in Material for MkDocs

To add captions to images in our Material for MkDocs setup, use the following format:

```markdown
![Image alt text](path/to/image.png)
{ .image-caption }
Caption text goes here.
```

Example:

```markdown
![FusionReactor Dashboard](images/fr-dashboard.png)
{ .image-caption }
FusionReactor's main dashboard provides an overview of your application's performance metrics.
```

### Diagrams

Use diagrams to illustrate complex processes, architectures, or concepts. Ensure diagrams are clear, properly labeled, and consistent with FusionReactor's visual style.

### Charts and Graphs

When presenting data or trends, use charts and graphs. Ensure they are easy to read, properly labeled, and use FusionReactor's color palette.

### Icons and Logos

Use official FusionReactor icons and logos consistently throughout the documentation. Refer to our separate brand guidelines for proper usage of these assets.

Remember, high-quality images enhance the user experience and understanding of FusionReactor. Always consider the user's perspective when creating and including images in our documentation.

### Deleting an image

If you're replacing an existing image, you should give the image file the same name. Delete the file you want to replace and add the new file. Doing this means you won't need to change any references to that image file.