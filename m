Return-Path: <linux-hyperv+bounces-4730-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9ABB0A75EC4
	for <lists+linux-hyperv@lfdr.de>; Mon, 31 Mar 2025 08:14:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3C15F167805
	for <lists+linux-hyperv@lfdr.de>; Mon, 31 Mar 2025 06:14:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6D1881AC8;
	Mon, 31 Mar 2025 06:14:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="p6SEC91M"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BF3D273F9;
	Mon, 31 Mar 2025 06:14:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743401691; cv=none; b=FoL4qHy/hSWKAZ1HHF+kOPs8Veyguwlg5c5Zn4Ada1oWzOnkc+OzrSQ11quuR2Xeo7h2Re3Y/WyJKgZzncGzCDyv+jpS395NRjVIG6NozCt2UuNYS1Vpa0apNQEn8WaAh0ejXwV5YO7lBPo8v75eaVlv/VbsWBHYJoSxMPhu2D8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743401691; c=relaxed/simple;
	bh=OwwpOitkg48CtLBrxIGOwMiIEwZRNT8nD4QL9XiRclk=;
	h=From:To:Cc:Subject:Date:Message-Id; b=RT78ou/RZ3PqqpBHB5b+6RD7h8MZV0XatGL05dvMKAHxvDq6AHCibD2HlINKxYG3ebInQfVCYwxsiYQMPU3wf8wezx190mS0cIs6pkbcbRQ6hknZQf6UQVbBIMQNFTRApwg7sFTzc5hmTyoYkVUBIpO3hCHZAvW9/PB6ZdEyTsk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=p6SEC91M; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1134)
	id D3184211251D; Sun, 30 Mar 2025 23:14:49 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com D3184211251D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1743401689;
	bh=bGKOKa9F8eNWrGg8tv+FBjjf0mVGzQFU1uMT7463nBI=;
	h=From:To:Cc:Subject:Date:From;
	b=p6SEC91M3coGJJg3bR6nVytVawOqy12NKihmtpKK6wSr5/SqnMWM6A3RXqu30mNnW
	 zjGIhdKQFIyqXJF9pGOcp4hCTD3q/8kEZ1cvHlkNMTPqxkTbqWrUt8CrYVweK/XFFJ
	 Gt83dm8ViklIsxR67udRtBV7zpgmqtKcgFNYdXe4=
From: Shradha Gupta <shradhagupta@linux.microsoft.com>
To: "K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>,
	Dexuan Cui <decui@microsoft.com>,
	linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Shradha Gupta <shradhagupta@linux.microsoft.com>,
	Shradha Gupta <shradhagupta@microsoft.com>
Subject: [PATCH v2] hv/hv_kvp_daemon: Enable debug logs for hv_kvp_daemon
Date: Sun, 30 Mar 2025 23:14:48 -0700
Message-Id: <1743401688-1573-1-git-send-email-shradhagupta@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>

Allow the KVP daemon to log the KVP updates triggered in the VM
with a new debug flag(-d).
When the daemon is started with this flag, it logs updates and debug
information in syslog with loglevel LOG_DEBUG. This information comes
in handy for debugging issues where the key-value pairs for certain
pools show mismatch/incorrect values.
The distro-vendors can further consume these changes and modify the
respective service files to redirect the logs to specific files as
needed.

Signed-off-by: Shradha Gupta <shradhagupta@linux.microsoft.com>
---
 Changes in v2:
 * log the debug logs in syslog(debug) instead of a seperate file that
   we will have to maintain.
 * fix the commit message to indicate the same.
---
 tools/hv/hv_kvp_daemon.c | 80 ++++++++++++++++++++++++++++++++++++----
 1 file changed, 72 insertions(+), 8 deletions(-)

diff --git a/tools/hv/hv_kvp_daemon.c b/tools/hv/hv_kvp_daemon.c
index 04ba035d67e9..2ff34c2f6a8d 100644
--- a/tools/hv/hv_kvp_daemon.c
+++ b/tools/hv/hv_kvp_daemon.c
@@ -41,6 +41,7 @@
 #include <net/if.h>
 #include <limits.h>
 #include <getopt.h>
+#include <time.h>
 
 /*
  * KVP protocol: The user mode component first registers with the
@@ -83,6 +84,7 @@ enum {
 };
 
 static int in_hand_shake;
+static int debug_enabled;
 
 static char *os_name = "";
 static char *os_major = "";
@@ -153,6 +155,16 @@ static void kvp_release_lock(int pool)
 	}
 }
 
+static void convert_tm_to_string(char *tm_str, size_t tm_str_size)
+{
+	struct tm tm;
+	time_t t;
+
+	time(&t);
+	gmtime_r(&t, &tm);
+	strftime(tm_str, tm_str_size, "%Y-%m-%dT%H:%M:%S", &tm);
+}
+
 static void kvp_update_file(int pool)
 {
 	FILE *filep;
@@ -183,6 +195,23 @@ static void kvp_update_file(int pool)
 	kvp_release_lock(pool);
 }
 
+static void kvp_dump_initial_pools(int pool)
+{
+	char tm_str[50];
+	int i;
+
+	convert_tm_to_string(tm_str, sizeof(tm_str));
+
+	syslog(LOG_DEBUG, "===Start dumping the contents of pool %d ===\n",
+	       pool);
+
+	for (i = 0; i < kvp_file_info[pool].num_records; i++)
+		syslog(LOG_DEBUG, "[%s]: pool: %d, %d/%d key=%s val=%s\n",
+		       tm_str, pool, i, kvp_file_info[pool].num_records,
+		       kvp_file_info[pool].records[i].key,
+		       kvp_file_info[pool].records[i].value);
+}
+
 static void kvp_update_mem_state(int pool)
 {
 	FILE *filep;
@@ -270,6 +299,8 @@ static int kvp_file_init(void)
 			return 1;
 		kvp_file_info[i].num_records = 0;
 		kvp_update_mem_state(i);
+		if (debug_enabled)
+			kvp_dump_initial_pools(i);
 	}
 
 	return 0;
@@ -321,14 +352,28 @@ static int kvp_key_delete(int pool, const __u8 *key, int key_size)
 static int kvp_key_add_or_modify(int pool, const __u8 *key, int key_size,
 				 const __u8 *value, int value_size)
 {
-	int i;
-	int num_records;
 	struct kvp_record *record;
+	int num_records;
+	char tm_str[50];
 	int num_blocks;
+	int i;
+
+	if (debug_enabled) {
+		convert_tm_to_string(tm_str, sizeof(tm_str));
+		syslog(LOG_DEBUG, "[%s]:%s: got a KVP: pool=%d key=%s val=%s",
+		       tm_str, __func__, pool, key, value);
+	}
 
 	if ((key_size > HV_KVP_EXCHANGE_MAX_KEY_SIZE) ||
-		(value_size > HV_KVP_EXCHANGE_MAX_VALUE_SIZE))
+		(value_size > HV_KVP_EXCHANGE_MAX_VALUE_SIZE)) {
+		syslog(LOG_ERR, "Got a too long key or value: key=%s, val=%s",
+		       key, value);
+
+		if (debug_enabled)
+			syslog(LOG_DEBUG, "[%s]:[%s]: Got a too long key or value: pool=%d, key=%s, val=%s",
+			       tm_str, __func__, pool, key, value);
 		return 1;
+	}
 
 	/*
 	 * First update the in-memory state.
@@ -348,6 +393,9 @@ static int kvp_key_add_or_modify(int pool, const __u8 *key, int key_size,
 		 */
 		memcpy(record[i].value, value, value_size);
 		kvp_update_file(pool);
+		if (debug_enabled)
+			syslog(LOG_DEBUG, "[%s]:%s: updated: pool=%d key=%s val=%s",
+			       tm_str, __func__, pool, key, value);
 		return 0;
 	}
 
@@ -359,8 +407,10 @@ static int kvp_key_add_or_modify(int pool, const __u8 *key, int key_size,
 		record = realloc(record, sizeof(struct kvp_record) *
 			 ENTRIES_PER_BLOCK * (num_blocks + 1));
 
-		if (record == NULL)
+		if (!record) {
+			syslog(LOG_ERR, "%s: Memory alloc failure", __func__);
 			return 1;
+		}
 		kvp_file_info[pool].num_blocks++;
 
 	}
@@ -368,6 +418,11 @@ static int kvp_key_add_or_modify(int pool, const __u8 *key, int key_size,
 	memcpy(record[i].key, key, key_size);
 	kvp_file_info[pool].records = record;
 	kvp_file_info[pool].num_records++;
+
+	if (debug_enabled)
+		syslog(LOG_DEBUG, "[%s]:%s: added: pool=%d key=%s val=%s",
+		       tm_str, __func__, pool, key, value);
+
 	kvp_update_file(pool);
 	return 0;
 }
@@ -1662,6 +1717,7 @@ void print_usage(char *argv[])
 	fprintf(stderr, "Usage: %s [options]\n"
 		"Options are:\n"
 		"  -n, --no-daemon        stay in foreground, don't daemonize\n"
+		"  -d, --debug-enabled    Enable debug logs(syslog debug by default)\n"
 		"  -h, --help             print this help\n", argv[0]);
 }
 
@@ -1681,12 +1737,13 @@ int main(int argc, char *argv[])
 	int daemonize = 1, long_index = 0, opt;
 
 	static struct option long_options[] = {
-		{"help",	no_argument,	   0,  'h' },
-		{"no-daemon",	no_argument,	   0,  'n' },
-		{0,		0,		   0,  0   }
+		{"help",		no_argument,	   0,  'h' },
+		{"no-daemon",		no_argument,	   0,  'n' },
+		{"debug-enabled",	no_argument,	   0,  'd' },
+		{0,			0,		   0,  0   }
 	};
 
-	while ((opt = getopt_long(argc, argv, "hn", long_options,
+	while ((opt = getopt_long(argc, argv, "hnd", long_options,
 				  &long_index)) != -1) {
 		switch (opt) {
 		case 'n':
@@ -1695,6 +1752,9 @@ int main(int argc, char *argv[])
 		case 'h':
 			print_usage(argv);
 			exit(0);
+		case 'd':
+			debug_enabled = 1;
+			break;
 		default:
 			print_usage(argv);
 			exit(EXIT_FAILURE);
@@ -1717,6 +1777,9 @@ int main(int argc, char *argv[])
 	 */
 	kvp_get_domain_name(full_domain_name, sizeof(full_domain_name));
 
+	if (debug_enabled)
+		syslog(LOG_INFO, "Logging debug info in syslog(debug)");
+
 	if (kvp_file_init()) {
 		syslog(LOG_ERR, "Failed to initialize the pools");
 		exit(EXIT_FAILURE);
-- 
2.34.1


