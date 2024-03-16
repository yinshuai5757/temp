-- create DB
CREATE DATABASE IF NOT EXISTS `ai`;

-- use DB
USE `ai`;

-- create simple table
-- CREATE TABLE IF NOT EXISTS `users` (
--    `id` INT AUTO_INCREMENT PRIMARY KEY,
--    `username` VARCHAR(50) NOT NULL,
--    `email` VARCHAR(100),
--    `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP
-- );

-- create document_texts table
CREATE TABLE IF NOT EXISTS `document_texts` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT COMMENT 'id',
  `document_id` bigint unsigned NOT NULL COMMENT 'documents.id',
  `status_id` bigint unsigned NOT NULL COMMENT 'statuses.id',
  `ai_type_id` bigint unsigned NOT NULL COMMENT 'ai_types.id',
  `sample_case_memo` text COLLATE utf8mb4_unicode_ci COMMENT 'サンプルケースメモ',
  `sample_format` text COLLATE utf8mb4_unicode_ci COMMENT 'サンプルフォーマット',
  `sample_generated_text` text COLLATE utf8mb4_unicode_ci COMMENT 'サンプル生成分',
  `user_case_memo` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci COMMENT 'ケースメモ（ヒアリング内容）',
  `user_format` text COLLATE utf8mb4_unicode_ci COMMENT 'フォーマット',
  `user_generated_text` text COLLATE utf8mb4_unicode_ci COMMENT 'AIによる生成結果',
  `ai_generate_start_datetime` datetime DEFAULT NULL COMMENT 'AI生成開始日時',
  `ai_generate_end_datetime` datetime DEFAULT NULL COMMENT 'AI生成終了日時',
  `created_datetime` datetime DEFAULT NULL COMMENT 'レコード作成日時',
  `updated_datetime` datetime DEFAULT NULL COMMENT 'レコード更新日時',
  PRIMARY KEY (`id`)
);

-- -- insert data
-- INSERT INTO `users` (`username`, `email`) VALUES ('user1', 'user1@example.com');
-- INSERT INTO `users` (`username`, `email`) VALUES ('user2', 'user2@example.com');

-- -- insert data
INSERT INTO `document_texts` (`id`, `document_id`, `status_id`, `ai_type_id`, `sample_case_memo`, `sample_format`, `sample_generated_text`, `user_case_memo`, `user_format`, `user_generated_text`, `ai_generate_start_datetime`, `ai_generate_end_datetime`, `created_datetime`, `updated_datetime`) VALUES ('11', '10001', '0', '2', 'X経歴=平成２８年に宅建に合格', '原告には{X経歴}という経歴がある。', '原告には平成２８年に宅建に合格という経歴がある。', 'X経歴=平成２９年に司法書士に合格', '原告には{X経歴}という経歴がある。',  NULL, '2024-03-13 09:57:07', '2013-03-13 03:33:33', '2024-03-12 09:57:07', '2013-03-13 03:33:33');
INSERT INTO `document_texts` (`id`, `document_id`, `status_id`, `ai_type_id`, `sample_case_memo`, `sample_format`, `sample_generated_text`, `user_case_memo`, `user_format`, `user_generated_text`, `ai_generate_start_datetime`, `ai_generate_end_datetime`, `created_datetime`, `updated_datetime`) VALUES ('22', '10002', '0', '2', 'X経歴=平成２８年に宅建に合格', '原告には{X経歴}という経歴がある。', '原告には平成２８年に宅建に合格という経歴がある。', 'X経歴=平成２９年に司法書士に合格', '原告には{X経歴}という経歴がある。',  NULL, '2024-03-15 09:57:07', '2013-03-13 03:33:33', '2024-03-13 09:57:07', '2013-03-13 03:33:33');
INSERT INTO `document_texts` (`id`, `document_id`, `status_id`, `ai_type_id`, `sample_case_memo`, `sample_format`, `sample_generated_text`, `user_case_memo`, `user_format`, `user_generated_text`, `ai_generate_start_datetime`, `ai_generate_end_datetime`, `created_datetime`, `updated_datetime`) VALUES ('333', '10003', '0', '1', 'X経歴=平成２８年に宅建に合格', '原告には{X経歴}という経歴がある。', '原告には平成２８年に宅建に合格という経歴がある。', 'X経歴=平成２９年に司法書士に合格', '原告には{X経歴}という経歴がある。',  NULL, '2024-03-13 10:57:07', '2013-03-13 03:33:33', '2024-03-01 09:57:07', '2013-03-13 03:33:33');
INSERT INTO `document_texts` (`id`, `document_id`, `status_id`, `ai_type_id`, `sample_case_memo`, `sample_format`, `sample_generated_text`, `user_case_memo`, `user_format`, `user_generated_text`, `ai_generate_start_datetime`, `ai_generate_end_datetime`, `created_datetime`, `updated_datetime`) VALUES ('4', '10004', '0', '2', 'X経歴=平成２８年に宅建に合格', '原告には{X経歴}という経歴がある。', '原告には平成２８年に宅建に合格という経歴がある。', 'X経歴=平成２９年に司法書士に合格', '原告には{X経歴}という経歴がある。',  NULL, '2024-03-13 02:57:07', '2013-03-13 03:33:33', '2024-03-07 09:57:07', '2013-03-13 03:33:33');
INSERT INTO `document_texts` (`id`, `document_id`, `status_id`, `ai_type_id`, `sample_case_memo`, `sample_format`, `sample_generated_text`, `user_case_memo`, `user_format`, `user_generated_text`, `ai_generate_start_datetime`, `ai_generate_end_datetime`, `created_datetime`, `updated_datetime`) VALUES ('5', '10005', '0', '2', 'X経歴=平成２８年に宅建に合格', '原告には{X経歴}という経歴がある。', '原告には平成２８年に宅建に合格という経歴がある。', 'X経歴=平成２９年に司法書士に合格', '原告には{X経歴}という経歴がある。',  NULL, '2024-03-13 08:57:07', '2013-03-13 03:33:33', '2024-03-03 09:57:07', '2013-03-13 03:33:33');
INSERT INTO `document_texts` (`id`, `document_id`, `status_id`, `ai_type_id`, `sample_case_memo`, `sample_format`, `sample_generated_text`, `user_case_memo`, `user_format`, `user_generated_text`, `ai_generate_start_datetime`, `ai_generate_end_datetime`, `created_datetime`, `updated_datetime`) VALUES ('6', '10005', '0', '2', 'X経歴=平成２８年に宅建に合格', '原告には{X経歴}という経歴がある。', '原告には平成２８年に宅建に合格という経歴がある。', 'X経歴=平成２９年に司法書士に合格', '原告には{X経歴}という経歴がある。',  NULL, '2024-03-14 08:57:07', '2013-03-13 03:33:33', '2024-03-04 09:57:44', '2013-03-13 03:33:33');
INSERT INTO `document_texts` (`id`, `document_id`, `status_id`, `ai_type_id`, `sample_case_memo`, `sample_format`, `sample_generated_text`, `user_case_memo`, `user_format`, `user_generated_text`, `ai_generate_start_datetime`, `ai_generate_end_datetime`, `created_datetime`, `updated_datetime`) VALUES ('111', '10001', '0', '2', 'X経歴=平成２８年に宅建に合格', '原告には{X経歴}という経歴がある。', '原告には平成２８年に宅建に合格という経歴がある。', 'X経歴=平成２９年に司法書士に合格', '原告には{X経歴}という経歴がある。',  NULL, '2024-03-13 09:57:07', '2013-03-13 03:33:33', '2024-03-12 09:57:54', '2013-03-13 03:33:33');
INSERT INTO `document_texts` (`id`, `document_id`, `status_id`, `ai_type_id`, `sample_case_memo`, `sample_format`, `sample_generated_text`, `user_case_memo`, `user_format`, `user_generated_text`, `ai_generate_start_datetime`, `ai_generate_end_datetime`, `created_datetime`, `updated_datetime`) VALUES ('222', '10002', '0', '2', 'X経歴=平成２８年に宅建に合格', '原告には{X経歴}という経歴がある。', '原告には平成２８年に宅建に合格という経歴がある。', 'X経歴=平成２９年に司法書士に合格', '原告には{X経歴}という経歴がある。',  NULL, '2024-03-15 09:57:07', '2013-03-13 03:33:33', '2024-03-13 09:57:02', '2013-03-13 03:33:33');
INSERT INTO `document_texts` (`id`, `document_id`, `status_id`, `ai_type_id`, `sample_case_memo`, `sample_format`, `sample_generated_text`, `user_case_memo`, `user_format`, `user_generated_text`, `ai_generate_start_datetime`, `ai_generate_end_datetime`, `created_datetime`, `updated_datetime`) VALUES ('3333', '10003', '0', '1', 'X経歴=平成２８年に宅建に合格', '原告には{X経歴}という経歴がある。', '原告には平成２８年に宅建に合格という経歴がある。', 'X経歴=平成２９年に司法書士に合格', '原告には{X経歴}という経歴がある。',  NULL, '2024-03-13 10:57:07', '2013-03-13 03:33:33', '2024-03-01 09:57:23', '2013-03-13 03:33:33');
INSERT INTO `document_texts` (`id`, `document_id`, `status_id`, `ai_type_id`, `sample_case_memo`, `sample_format`, `sample_generated_text`, `user_case_memo`, `user_format`, `user_generated_text`, `ai_generate_start_datetime`, `ai_generate_end_datetime`, `created_datetime`, `updated_datetime`) VALUES ('44', '10004', '0', '2', 'X経歴=平成２８年に宅建に合格', '原告には{X経歴}という経歴がある。', '原告には平成２８年に宅建に合格という経歴がある。', 'X経歴=平成２９年に司法書士に合格', '原告には{X経歴}という経歴がある。',  NULL, '2024-03-13 02:57:07', '2013-03-13 03:33:33', '2024-03-07 09:57:25', '2013-03-13 03:33:33');
INSERT INTO `document_texts` (`id`, `document_id`, `status_id`, `ai_type_id`, `sample_case_memo`, `sample_format`, `sample_generated_text`, `user_case_memo`, `user_format`, `user_generated_text`, `ai_generate_start_datetime`, `ai_generate_end_datetime`, `created_datetime`, `updated_datetime`) VALUES ('55', '10005', '0', '2', 'X経歴=平成２８年に宅建に合格', '原告には{X経歴}という経歴がある。', '原告には平成２８年に宅建に合格という経歴がある。', 'X経歴=平成２９年に司法書士に合格', '原告には{X経歴}という経歴がある。',  NULL, '2024-03-13 08:57:07', '2013-03-13 03:33:33', '2024-03-03 09:57:05', '2013-03-13 03:33:33');
INSERT INTO `document_texts` (`id`, `document_id`, `status_id`, `ai_type_id`, `sample_case_memo`, `sample_format`, `sample_generated_text`, `user_case_memo`, `user_format`, `user_generated_text`, `ai_generate_start_datetime`, `ai_generate_end_datetime`, `created_datetime`, `updated_datetime`) VALUES ('66', '10005', '0', '2', 'X経歴=平成２８年に宅建に合格', '原告には{X経歴}という経歴がある。', '原告には平成２８年に宅建に合格という経歴がある。', 'X経歴=平成２９年に司法書士に合格', '原告には{X経歴}という経歴がある。',  NULL, '2024-03-14 08:57:07', '2013-03-13 03:33:33', '2024-03-04 19:57:07', '2013-03-13 03:33:33');