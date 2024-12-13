import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:test_ai/routes.dart';
import 'package:test_ai/services/file_service.dart';

class GeminiPage extends StatelessWidget {
  const GeminiPage({
    super.key,
    required this.fileService,
  });

  final FileService fileService;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ElevatedButton(
            onPressed: () => context.go('/gemini/chat'),
            child: const Text('Chat voi Gemini'),
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () => context.go('/gemini/create-document'),
            child: const Text('Tạo văn bản'),
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () async {
              final files = await fileService.pickImage(withData: true);
              if (files.isEmpty) {
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                  content: Text('Hãy chọn file ảnh'),
                ));

                return;
              } else {
                print('selected ${files.length} images');
              }

              final response = await aiService.getImageDescription(files.map((file) => file.path!).toList());
              showDialog(
                  context: context,
                  builder: (_) => AlertDialog(
                        content: SingleChildScrollView(
                          child: Text(response ?? 'Không phân tích được'),
                        ),
                      ));
            },
            child: const Text('Phân tích nội dung ảnh'),
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () async {
              final files = await fileService.pickImage(withData: true);
              if (files.isEmpty) {
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                  content: Text('Hãy chọn file thiết kế màn hình'),
                ));

                return;
              } else {
                print('selected ${files.length} images');
              }

              final response = await aiService.generateFlutterCode(files[0].path!);
              showDialog(
                  context: context,
                  builder: (_) => AlertDialog(
                        content: SingleChildScrollView(
                          child: Text(response ?? 'Không phân tích được'),
                        ),
                      ));
            },
            child: const Text('Tạo Flutter UI'),
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () async {
              final items = [
                'sáng đi làm mua cốc cafe 20 nghìn',
                'mua điện thoại iphone 16 xs max giá hơn hai chục triệu',
                'ăn trưa quên mang tiền nợ chủ quán 30k',
                'đi uống bia hết 500k',
              ];

              final String? selected = await showModalBottomSheet<String>(
                context: context,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
                ),
                builder: (BuildContext context) {
                  return ListView.separated(
                    padding: const EdgeInsets.all(16.0),
                    itemCount: items.length,
                    separatorBuilder: (context, index) => const Divider(),
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Text(items[index]),
                        onTap: () {
                          Navigator.pop(context, items[index]); // Return selected item
                        },
                      );
                    },
                  );
                },
              );

              if(selected == null) {
                return;
              }

              final response =
                  await aiService.prompt('Câu văn sau có những loại chi phí nào, trả về dữ liệu json: $selected.');
              showDialog(
                context: context,
                builder: (_) => AlertDialog(
                  content: SingleChildScrollView(
                    child:
                        Text(response != null ? (selected! + '\r\n------\r\n\r\n' + response) : 'Không phân tích được'),
                  ),
                ),
              );
            },
            child: const Text('Tìm các chi phí trong văn bản'),
          ),
        ],
      ),
    );
  }
}
