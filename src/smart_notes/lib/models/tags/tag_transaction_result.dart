import 'package:smart_notes/models/notes/tag_item_model.dart';
import 'package:smart_notes/models/tags/tag_transaction_result_type.dart';

class TagTransactionResult {
  TagTransactionResult(this.transactionType, this.tag);

  final TagTransactionResultType transactionType;
  final TagItemModel tag;
}
