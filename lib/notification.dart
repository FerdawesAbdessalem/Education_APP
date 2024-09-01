import 'package:flutter/material.dart';

class NotificationPage extends StatefulWidget {
  @override
  _NotificationPageState createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  List<Map<String, dynamic>> notifications = [
    {
      'type': 'review',
      'message': 'برنامج مراجعة جديد متاح.',
      'time': '2024-08-24 10:30',
    },
    {
      'type': 'exam',
      'message': 'تم تحديث برنامج الامتحان.',
      'time': '2024-08-23 09:00',
    },
    {
      'type': 'save',
      'message': 'تم حفظ بياناتك بنجاح.',
      'time': '2024-08-22 14:15',
    },
    // أضف إشعارات أخرى هنا
  ];

  void _removeNotification(int index) {
    setState(() {
      notifications.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Ajout des cercles décoratifs
          Positioned(
            top: 0,
            left: -80,
            child: Container(
              width: 190,
              height: 190,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Color(0xFF499DA2).withOpacity(0.5),
              ),
            ),
          ),
          Positioned(
            top: -70,
            left: 20,
            child: Container(
              width: 180,
              height: 180,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Color(0xFF499DA2).withOpacity(0.5),
              ),
            ),
          ),
          // Utiliser un Padding pour déplacer les notifications vers le bas
          Padding(
            padding: const EdgeInsets.only(
                top: 170), // Adjustez la valeur ici pour contrôler la distance
            child: ListView.builder(
              itemCount: notifications.length,
              itemBuilder: (context, index) {
                final notification = notifications[index];
                return Card(
                  margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  child: ListTile(
                    leading: Icon(
                      _getIconForNotification(notification['type']),
                      color: _getColorForNotification(notification['type']),
                    ),
                    title: Text(
                      notification['message'],
                      style: TextStyle(fontSize: 18),
                      textDirection: TextDirection
                          .rtl, // لضبط اتجاه النص من اليمين إلى اليسار
                    ),
                    subtitle: Text(
                      notification['time'],
                      style: TextStyle(color: Colors.grey),
                      textDirection: TextDirection
                          .rtl, // لضبط اتجاه النص من اليمين إلى اليسار
                    ),
                    trailing: IconButton(
                      icon: Icon(Icons.delete),
                      onPressed: () {
                        _removeNotification(
                            index); // حذف الإشعار عند الضغط على زر الحذف
                      },
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  IconData _getIconForNotification(String type) {
    switch (type) {
      case 'review':
        return Icons.book;
      case 'exam':
        return Icons.edit;
      case 'save':
        return Icons.save;
      default:
        return Icons.notifications;
    }
  }

  Color _getColorForNotification(String type) {
    switch (type) {
      case 'review':
        return Colors.blue;
      case 'exam':
        return Colors.red;
      case 'save':
        return Colors.green;
      default:
        return Colors.grey;
    }
  }
}
