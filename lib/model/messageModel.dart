enum MessageType { text, voice, file }
enum MessageStatus { sent, delivered, read }
enum CallType { appToApp, appToPhone }

class ChatPreview {
  final String id;
  final String name;
  final String avatar;
  final String lastMessage;
  final String time;
  final int unreadCount;
  final bool isOnline;
  final MessageType messageType;
  final bool isGroup;
  final String? groupAvatar;
  bool isRoom;

  ChatPreview({
    required this.id,
    required this.name,
    required this.avatar,
    required this.lastMessage,
    required this.time,
    required this.unreadCount,
    required this.isOnline,
    required this.messageType,
    this.isGroup = false,
    this.groupAvatar,
     this.isRoom = false,
  });
}

class Message {
  final String id;
  final String text;
  final bool isMe;
  final DateTime timestamp;
  final bool isVoice;
  final bool isFile;
  final String? voiceDuration;
  final String? fileSize;
  final String? fileName;
  final MessageStatus status;
  final String? senderId;
  final String? senderName;

  Message({
    required this.id,
    required this.text,
    required this.isMe,
    required this.timestamp,
    this.isVoice = false,
    this.isFile = false,
    this.voiceDuration,
    this.fileSize,
    this.fileName,
    required this.status,
    this.senderId,
    this.senderName,
  });

  String get formattedTime {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final messageDate = DateTime(timestamp.year, timestamp.month, timestamp.day);

    if (messageDate == today) {
      return '${timestamp.hour.toString().padLeft(2, '0')}:${timestamp.minute.toString().padLeft(2, '0')}';
    } else if (messageDate == today.subtract(const Duration(days: 1))) {
      return 'Yesterday';
    } else {
      return '${timestamp.day}/${timestamp.month}/${timestamp.year}';
    }
  }
}

class VoiceMessage extends Message {
  final String audioUrl;
  final double duration;

  VoiceMessage({
    required super.id,
    required super.text,
    required super.isMe,
    required super.timestamp,
    required this.audioUrl,
    required this.duration,
    required super.status,
    super.senderId,
    super.senderName,
  }) : super(
    isVoice: true,
    voiceDuration: _formatDuration(duration),
  );

  static String _formatDuration(double seconds) {
    final minutes = seconds ~/ 60;
    final remainingSeconds = seconds % 60;
    return '${minutes.toString()}:${remainingSeconds.toString().padLeft(2, '0')}';
  }
}

class FileMessage extends Message {
  final String fileUrl;
  final String fileType;

  FileMessage({
    required super.id,
    required super.text,
    required super.isMe,
    required super.timestamp,
    required this.fileUrl,
    required this.fileType,
    required String fileSize,
    required super.status,
    super.senderId,
    super.senderName,
  }) : super(
    isFile: true,
    fileSize: fileSize,
    fileName: text,
  );
}