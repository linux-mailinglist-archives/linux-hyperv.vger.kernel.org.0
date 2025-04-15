Return-Path: <linux-hyperv+bounces-4914-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D15FDA89C45
	for <lists+linux-hyperv@lfdr.de>; Tue, 15 Apr 2025 13:27:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2C3B13BCCD2
	for <lists+linux-hyperv@lfdr.de>; Tue, 15 Apr 2025 11:26:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DB29296D09;
	Tue, 15 Apr 2025 11:19:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="gu4568tB"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53E531E0E0C;
	Tue, 15 Apr 2025 11:19:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744715986; cv=none; b=MKADfIOgMSbDYNhGIr02KPiEVnI0ETFCe3FrHMBP6LqX+9oCCo9gVys+pu3J7fpug8AFlkDj+iZq952Yu4IC6pneGaRjck9/OvOTvd8OZwrfgsymivLppvdCR7Yy4IsDhLieBMEsXTu5YS4RbE/MF5XZkMpTkf7JSh4rzacOqHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744715986; c=relaxed/simple;
	bh=fm8nBPd0osnUG6dqX12oQsoVPD0PFBn5UOMP1jMH0mM=;
	h=From:To:Cc:Subject:Date:Message-Id; b=I8bXc/mBn0OJHPdBisG0CLxqqFoSXjMJNYdS3SGGtDILXhxmsaUqy+RUFl97iUlILvunB8AAMVmNYsD4Qcji+nWzXZl4bFa81qd4m1zMtM+62UaynnlfsrMc70AIdAXiZz0JYLl2C0Sw0PryZvvD74DofCiaVwPO6D8VuMPpHiM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=gu4568tB; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1134)
	id 3609620BCAD2; Tue, 15 Apr 2025 04:19:39 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 3609620BCAD2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1744715979;
	bh=z0JDToXaxOj4YM1xG5O0anHRB/LqnT8FbQltl3n3bNE=;
	h=From:To:Cc:Subject:Date:From;
	b=gu4568tBswLAGhTi89YoOKz5ULZDWS2wkjK0n4L2pObpW1lczkOEUOLKP2xpaqGHE
	 9Mx/MXOPMRYU+RqiQGkx4PuJNxnOe98N0em6hRtbinxatYNk5ih9sZLZ8YNuDAR0Hv
	 d3x0QB13Z+Z2wLj2F+0IdWPmlB2/SZS+UK0E/8G8=
From: Shradha Gupta <shradhagupta@linux.microsoft.com>
To: "K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>,
	Dexuan Cui <decui@microsoft.com>,
	Naman Jain <namjain@linux.microsoft.com>,
	linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Shradha Gupta <shradhagupta@linux.microsoft.com>,
	Shradha Gupta <shradhagupta@microsoft.com>
Subject: [PATCH v4] hv/hv_kvp_daemon: Enable debug logs for hv_kvp_daemon
Date: Tue, 15 Apr 2025 04:19:38 -0700
Message-Id: <1744715978-8185-1-git-send-email-shradhagupta@linux.microsoft.com>
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
Reviewed-by: Naman Jain <namjain@linux.microsoft.com>
Reviewed-by: Dexuan Cui <decui@microsoft.com>
---
 Changes in v4:
 * renamed the debug option from "debug_enabled" to "debug"
 * shorten a debug message by removing unnecessary strings
---
 Changes in v3:
 * remove timestamp from raw message
 * use i+1 instead of i while printing record array
 * add debug logs in delete operation
---
 Changes in v2:
 * log the debug logs in syslog(debug) instead of a seperate file that
   we will have to maintain.
 * fix the commit message to indicate the same.
---
 tools/hv/hv_kvp_daemon.c | 65 ++++++++++++++++++++++++++++++++++++----
 1 file changed, 60 insertions(+), 5 deletions(-)

diff --git a/tools/hv/hv_kvp_daemon.c b/tools/hv/hv_kvp_daemon.c
index 04ba035d67e9..37ebe1cf0641 100644
--- a/tools/hv/hv_kvp_daemon.c
+++ b/tools/hv/hv_kvp_daemon.c
@@ -83,6 +83,7 @@ enum {
 };
 
 static int in_hand_shake;
+static int debug;
 
 static char *os_name = "";
 static char *os_major = "";
@@ -183,6 +184,20 @@ static void kvp_update_file(int pool)
 	kvp_release_lock(pool);
 }
 
+static void kvp_dump_initial_pools(int pool)
+{
+	int i;
+
+	syslog(LOG_DEBUG, "===Start dumping the contents of pool %d ===\n",
+	       pool);
+
+	for (i = 0; i < kvp_file_info[pool].num_records; i++)
+		syslog(LOG_DEBUG, "pool: %d, %d/%d key=%s val=%s\n",
+		       pool, i + 1, kvp_file_info[pool].num_records,
+		       kvp_file_info[pool].records[i].key,
+		       kvp_file_info[pool].records[i].value);
+}
+
 static void kvp_update_mem_state(int pool)
 {
 	FILE *filep;
@@ -270,6 +285,8 @@ static int kvp_file_init(void)
 			return 1;
 		kvp_file_info[i].num_records = 0;
 		kvp_update_mem_state(i);
+		if (debug)
+			kvp_dump_initial_pools(i);
 	}
 
 	return 0;
@@ -297,6 +314,9 @@ static int kvp_key_delete(int pool, const __u8 *key, int key_size)
 		 * Found a match; just move the remaining
 		 * entries up.
 		 */
+		if (debug)
+			syslog(LOG_DEBUG, "%s: deleting the KVP: pool=%d key=%s val=%s",
+			       __func__, pool, record[i].key, record[i].value);
 		if (i == (num_records - 1)) {
 			kvp_file_info[pool].num_records--;
 			kvp_update_file(pool);
@@ -315,20 +335,36 @@ static int kvp_key_delete(int pool, const __u8 *key, int key_size)
 		kvp_update_file(pool);
 		return 0;
 	}
+
+	if (debug)
+		syslog(LOG_DEBUG, "%s: could not delete KVP: pool=%d key=%s. Record not found",
+		       __func__, pool, key);
+
 	return 1;
 }
 
 static int kvp_key_add_or_modify(int pool, const __u8 *key, int key_size,
 				 const __u8 *value, int value_size)
 {
-	int i;
-	int num_records;
 	struct kvp_record *record;
+	int num_records;
 	int num_blocks;
+	int i;
+
+	if (debug)
+		syslog(LOG_DEBUG, "%s: got a KVP: pool=%d key=%s val=%s",
+		       __func__, pool, key, value);
 
 	if ((key_size > HV_KVP_EXCHANGE_MAX_KEY_SIZE) ||
-		(value_size > HV_KVP_EXCHANGE_MAX_VALUE_SIZE))
+		(value_size > HV_KVP_EXCHANGE_MAX_VALUE_SIZE)) {
+		syslog(LOG_ERR, "%s: Too long key or value: key=%s, val=%s",
+		       __func__, key, value);
+
+		if (debug)
+			syslog(LOG_DEBUG, "%s: Too long key or value: pool=%d, key=%s, val=%s",
+			       __func__, pool, key, value);
 		return 1;
+	}
 
 	/*
 	 * First update the in-memory state.
@@ -348,6 +384,9 @@ static int kvp_key_add_or_modify(int pool, const __u8 *key, int key_size,
 		 */
 		memcpy(record[i].value, value, value_size);
 		kvp_update_file(pool);
+		if (debug)
+			syslog(LOG_DEBUG, "%s: updated: pool=%d key=%s val=%s",
+			       __func__, pool, key, value);
 		return 0;
 	}
 
@@ -359,8 +398,10 @@ static int kvp_key_add_or_modify(int pool, const __u8 *key, int key_size,
 		record = realloc(record, sizeof(struct kvp_record) *
 			 ENTRIES_PER_BLOCK * (num_blocks + 1));
 
-		if (record == NULL)
+		if (!record) {
+			syslog(LOG_ERR, "%s: Memory alloc failure", __func__);
 			return 1;
+		}
 		kvp_file_info[pool].num_blocks++;
 
 	}
@@ -368,6 +409,11 @@ static int kvp_key_add_or_modify(int pool, const __u8 *key, int key_size,
 	memcpy(record[i].key, key, key_size);
 	kvp_file_info[pool].records = record;
 	kvp_file_info[pool].num_records++;
+
+	if (debug)
+		syslog(LOG_DEBUG, "%s: added: pool=%d key=%s val=%s",
+		       __func__, pool, key, value);
+
 	kvp_update_file(pool);
 	return 0;
 }
@@ -1662,6 +1708,7 @@ void print_usage(char *argv[])
 	fprintf(stderr, "Usage: %s [options]\n"
 		"Options are:\n"
 		"  -n, --no-daemon        stay in foreground, don't daemonize\n"
+		"  -d, --debug            Enable debug logs(syslog debug by default)\n"
 		"  -h, --help             print this help\n", argv[0]);
 }
 
@@ -1683,10 +1730,11 @@ int main(int argc, char *argv[])
 	static struct option long_options[] = {
 		{"help",	no_argument,	   0,  'h' },
 		{"no-daemon",	no_argument,	   0,  'n' },
+		{"debug",	no_argument,	   0,  'd' },
 		{0,		0,		   0,  0   }
 	};
 
-	while ((opt = getopt_long(argc, argv, "hn", long_options,
+	while ((opt = getopt_long(argc, argv, "hnd", long_options,
 				  &long_index)) != -1) {
 		switch (opt) {
 		case 'n':
@@ -1695,6 +1743,9 @@ int main(int argc, char *argv[])
 		case 'h':
 			print_usage(argv);
 			exit(0);
+		case 'd':
+			debug = 1;
+			break;
 		default:
 			print_usage(argv);
 			exit(EXIT_FAILURE);
@@ -1717,6 +1768,9 @@ int main(int argc, char *argv[])
 	 */
 	kvp_get_domain_name(full_domain_name, sizeof(full_domain_name));
 
+	if (debug)
+		syslog(LOG_INFO, "Logging debug info in syslog(debug)");
+
 	if (kvp_file_init()) {
 		syslog(LOG_ERR, "Failed to initialize the pools");
 		exit(EXIT_FAILURE);
-- 
2.34.1


