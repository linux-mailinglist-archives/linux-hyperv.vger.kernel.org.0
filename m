Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2EE8514995F
	for <lists+linux-hyperv@lfdr.de>; Sun, 26 Jan 2020 06:50:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726654AbgAZFu3 (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Sun, 26 Jan 2020 00:50:29 -0500
Received: from mail-mw2nam10on2112.outbound.protection.outlook.com ([40.107.94.112]:58464
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726098AbgAZFu2 (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Sun, 26 Jan 2020 00:50:28 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fiRqmAvWlcJe3w2hC+sXG02QI/91DZgduIMpRaBmZ5zOGzMHKOINB9CCCOCeqQOa7uL6ZNyKxOMXHiBS7aUrybf1qMGnezAvj3ekIwShJj/1eYYCV4oZQZcMDWIqapnkIQIiKlSaKfpQf3AD4j56FFVipDhsw2wCcuicz+J02zLpfemf0ikAQdvNzSRp3c8hiWHlryaTPv1g8no2WX//6OKP1g96C/11rS51N3IvlK44TXD5vAww7wv1uDbYmS6Pl9Sofj5YVv0ZcyYU737sB+qNg6th82080vKMeWXU7525iMZxfIgnhn+ZH2PsZThhR9MnpXtctQtRx8pU9GTzkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bwcKRR0HH2pHxSeblWtrrOgYLGIa4Z8/Nbi16fj0eqY=;
 b=NquZPhx/9ejvX5TtpmCU+4cXKc8/aZIKrahWFgktPhiNtrD2VvyDXeSYXOqWvGMNsOs+Oz6EFxLTx8L9EVz3sevF9vn+hxgOlHZSHLSarXbiNFQGKy9rzPljOtj4andUkXgS8HQIOeGHaVFsHaOOp3XA/kumhAjNPetp24HkFJzUoPCsHfXWDKy2b3S8VNfEqMeQ1lnJyLY9dvs0VE8Qk1wfC6c7xcQo0+q1/tgacTd7YNZ/IWHjQaszOt64vTXoeEl/eIgz9XpKKwz8v3xNhEQQwutq6OBKxc0hTHiT8WkLuGbWTwrzpQJAY3+lgrQBUd0e/XugEpwlVsY+KeHppQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bwcKRR0HH2pHxSeblWtrrOgYLGIa4Z8/Nbi16fj0eqY=;
 b=KxwJi4hvVlA0ABgsSaRF27wAfIUyCLMK+V0SoTlGyuASRR+opg7ZRq8jYLWprAlobC2zW9AhkkFDWWX3aMDCtd6q6pJ1CiybtkPv6qkX50ntXnXshoPDVsZGZj/Vt/3BEiFylbywxdfg1NSYp7fvcjDO+typyB+1Xpm5Be4YMpk=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=decui@microsoft.com; 
Received: from BN8PR21MB1139.namprd21.prod.outlook.com (20.179.72.138) by
 BN8PR21MB1203.namprd21.prod.outlook.com (20.179.73.143) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2686.6; Sun, 26 Jan 2020 05:50:24 +0000
Received: from BN8PR21MB1139.namprd21.prod.outlook.com
 ([fe80::b4cb:911c:ec4a:950e]) by BN8PR21MB1139.namprd21.prod.outlook.com
 ([fe80::b4cb:911c:ec4a:950e%7]) with mapi id 15.20.2686.019; Sun, 26 Jan 2020
 05:50:24 +0000
From:   Dexuan Cui <decui@microsoft.com>
To:     kys@microsoft.com, haiyangz@microsoft.com, sthemmin@microsoft.com,
        sashal@kernel.org, linux-hyperv@vger.kernel.org,
        linux-kernel@vger.kernel.org, mikelley@microsoft.com,
        vkuznets@redhat.com
Cc:     Dexuan Cui <decui@microsoft.com>
Subject: [PATCH v4 1/4] Tools: hv: Reopen the devices if read() or write() returns errors
Date:   Sat, 25 Jan 2020 21:49:41 -0800
Message-Id: <1580017784-103557-2-git-send-email-decui@microsoft.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1580017784-103557-1-git-send-email-decui@microsoft.com>
References: <1580017784-103557-1-git-send-email-decui@microsoft.com>
Reply-To: decui@microsoft.com
Content-Type: text/plain
X-ClientProxiedBy: MWHPR14CA0028.namprd14.prod.outlook.com
 (2603:10b6:300:12b::14) To BN8PR21MB1139.namprd21.prod.outlook.com
 (2603:10b6:408:72::10)
MIME-Version: 1.0
Received: from linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net (13.77.154.182) by MWHPR14CA0028.namprd14.prod.outlook.com (2603:10b6:300:12b::14) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2665.23 via Frontend Transport; Sun, 26 Jan 2020 05:50:23 +0000
X-Mailer: git-send-email 1.8.3.1
X-Originating-IP: [13.77.154.182]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: d4adfdf2-bc45-4d3f-7c3b-08d7a223a366
X-MS-TrafficTypeDiagnostic: BN8PR21MB1203:|BN8PR21MB1203:|BN8PR21MB1203:
X-MS-Exchange-Transport-Forked: True
X-LD-Processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
X-Microsoft-Antispam-PRVS: <BN8PR21MB12038A195DEF7C8DCA6CFC30BF080@BN8PR21MB1203.namprd21.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-Forefront-PRVS: 02945962BD
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(4636009)(346002)(136003)(376002)(39860400002)(366004)(396003)(199004)(189003)(316002)(2906002)(66556008)(6512007)(66946007)(66476007)(86362001)(107886003)(3450700001)(6486002)(36756003)(8936002)(26005)(5660300002)(4326008)(2616005)(956004)(478600001)(186003)(52116002)(6506007)(6666004)(16526019)(81166006)(81156014)(8676002)(10290500003);DIR:OUT;SFP:1102;SCL:1;SRVR:BN8PR21MB1203;H:BN8PR21MB1139.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xgdSlTUNNxCjCYbP1ETDRFUHmx+rvBI0kl/GrppxHE2qlqArbqLRtqWsmqvdVLx7MbQk0mOYNIwsTRu0G8WeC7EUjTxzPZ07jaOQALufjQ4M18ggZuio0cytMS37vvPqHETRCRamV66YOBpCb6cjw6YexzoeFBkbMRJzh3GjrByNXH6YWNjM+yDCLGC6xGrxrdLeImUjilpyiqvyREnLNCBCITUaqcpPj9cJd83gb4J13W+67u3b6vr2jG+xUgqYiEsKlgAa9vclx1WKZpfzAGFbglOP7ZLWSgXw/XgNKPUUMfJfRud4pcCvQP1QH0WHLBDQHME+A09b49ip9nLP2cxm7QUjYXREkTNb/4GeV/B1RJx+giHhrJLkq/jmkAg0mmiyl1LvQnwWUa0nr8qb1o9bLwWyLPcLHbdhHYw0z+OiyEzcjqnZ1XFr3NGY7x3W
X-MS-Exchange-AntiSpam-MessageData: 93/P+p77qOkeYBKZzC76aSI0YA7l3+idg68yXQqSf1NXt8lR9uHVWMaqNtgaF8baG0ckoPaCufkIBjoOLL96GkdCAcb10h4mrH6cWe8ncrjLWAaDXY3grnEIiu9aN7n6HdkCm56+CuI785QbtMMPFg==
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d4adfdf2-bc45-4d3f-7c3b-08d7a223a366
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jan 2020 05:50:24.7920
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: r/4UBv0x1NOhBpWvDbmBGseyvFnUP26WPvyNrWM2Ii34GfQUKf12WQwdutbtg9mDJYHCwFP7cIRLKdplvKHarA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR21MB1203
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

The state machine in the hv_utils driver can run out of order in some
corner cases, e.g. if the kvp daemon doesn't call write() fast enough
due to some reason, kvp_timeout_func() can run first and move the state
to HVUTIL_READY; next, when kvp_on_msg() is called it returns -EINVAL
since kvp_transaction.state is smaller than HVUTIL_USERSPACE_REQ; later,
the daemon's write() gets an error -EINVAL, and the daemon will exit().

We can reproduce the issue by sending a SIGSTOP signal to the daemon, wait
for 1 minute, and send a SIGCONT signal to the daemon: the daemon will
exit() quickly.

We can fix the issue by forcing a reset of the device (which means the
daemon can close() and open() the device again) and doing extra necessary
clean-up.

Signed-off-by: Dexuan Cui <decui@microsoft.com>

---
Changes in v2:
    This is actually a new patch that makes the daemons more robust.

Changes in v3 (I addressed Michael's comments):
    Don't reset target_fd, since that's unnecessary.
    Reset target_fname by: target_fname[0] = '\0';
    Added the missing "fs_frozen = true;" in vss_operate().
    Just after reopen_vss_fd: if vss_operate(VSS_OP_THAW) can not clear
        fs_frozen due to an error, we just exit().
    Added comments.

Changes in v4 (Thanks to Michael!):
    Added the omitted "int fcopy_fd = -1" and
    "
     if (fcopy_fd != -1)
               close(fcopy_fd);
    "

 tools/hv/hv_fcopy_daemon.c | 37 ++++++++++++++++++++++++----
 tools/hv/hv_kvp_daemon.c   | 36 ++++++++++++++++------------
 tools/hv/hv_vss_daemon.c   | 49 +++++++++++++++++++++++++++++---------
 3 files changed, 91 insertions(+), 31 deletions(-)

diff --git a/tools/hv/hv_fcopy_daemon.c b/tools/hv/hv_fcopy_daemon.c
index aea2d91ab364..16d629b22c25 100644
--- a/tools/hv/hv_fcopy_daemon.c
+++ b/tools/hv/hv_fcopy_daemon.c
@@ -80,6 +80,8 @@ static int hv_start_fcopy(struct hv_start_fcopy *smsg)
 
 	error = 0;
 done:
+	if (error)
+		target_fname[0] = '\0';
 	return error;
 }
 
@@ -108,15 +110,29 @@ static int hv_copy_data(struct hv_do_fcopy *cpmsg)
 	return ret;
 }
 
+/*
+ * Reset target_fname to "" in the two below functions for hibernation: if
+ * the fcopy operation is aborted by hibernation, the daemon should remove the
+ * partially-copied file; to achieve this, the hv_utils driver always fakes a
+ * CANCEL_FCOPY message upon suspend, and later when the VM resumes back,
+ * the daemon calls hv_copy_cancel() to remove the file; if a file is copied
+ * successfully before suspend, hv_copy_finished() must reset target_fname to
+ * avoid that the file can be incorrectly removed upon resume, since the faked
+ * CANCEL_FCOPY message is spurious in this case.
+ */
 static int hv_copy_finished(void)
 {
 	close(target_fd);
+	target_fname[0] = '\0';
 	return 0;
 }
 static int hv_copy_cancel(void)
 {
 	close(target_fd);
-	unlink(target_fname);
+	if (strlen(target_fname) > 0) {
+		unlink(target_fname);
+		target_fname[0] = '\0';
+	}
 	return 0;
 
 }
@@ -131,7 +147,7 @@ void print_usage(char *argv[])
 
 int main(int argc, char *argv[])
 {
-	int fcopy_fd;
+	int fcopy_fd = -1;
 	int error;
 	int daemonize = 1, long_index = 0, opt;
 	int version = FCOPY_CURRENT_VERSION;
@@ -141,7 +157,7 @@ int main(int argc, char *argv[])
 		struct hv_do_fcopy copy;
 		__u32 kernel_modver;
 	} buffer = { };
-	int in_handshake = 1;
+	int in_handshake;
 
 	static struct option long_options[] = {
 		{"help",	no_argument,	   0,  'h' },
@@ -170,6 +186,12 @@ int main(int argc, char *argv[])
 	openlog("HV_FCOPY", 0, LOG_USER);
 	syslog(LOG_INFO, "starting; pid is:%d", getpid());
 
+reopen_fcopy_fd:
+	if (fcopy_fd != -1)
+		close(fcopy_fd);
+	/* Remove any possible partially-copied file on error */
+	hv_copy_cancel();
+	in_handshake = 1;
 	fcopy_fd = open("/dev/vmbus/hv_fcopy", O_RDWR);
 
 	if (fcopy_fd < 0) {
@@ -196,7 +218,7 @@ int main(int argc, char *argv[])
 		len = pread(fcopy_fd, &buffer, sizeof(buffer), 0);
 		if (len < 0) {
 			syslog(LOG_ERR, "pread failed: %s", strerror(errno));
-			exit(EXIT_FAILURE);
+			goto reopen_fcopy_fd;
 		}
 
 		if (in_handshake) {
@@ -231,9 +253,14 @@ int main(int argc, char *argv[])
 
 		}
 
+		/*
+		 * pwrite() may return an error due to the faked CANCEL_FCOPY
+		 * message upon hibernation. Ignore the error by resetting the
+		 * dev file, i.e. closing and re-opening it.
+		 */
 		if (pwrite(fcopy_fd, &error, sizeof(int), 0) != sizeof(int)) {
 			syslog(LOG_ERR, "pwrite failed: %s", strerror(errno));
-			exit(EXIT_FAILURE);
+			goto reopen_fcopy_fd;
 		}
 	}
 }
diff --git a/tools/hv/hv_kvp_daemon.c b/tools/hv/hv_kvp_daemon.c
index e9ef4ca6a655..ee9c1bb2293e 100644
--- a/tools/hv/hv_kvp_daemon.c
+++ b/tools/hv/hv_kvp_daemon.c
@@ -76,7 +76,7 @@ enum {
 	DNS
 };
 
-static int in_hand_shake = 1;
+static int in_hand_shake;
 
 static char *os_name = "";
 static char *os_major = "";
@@ -1360,7 +1360,7 @@ void print_usage(char *argv[])
 
 int main(int argc, char *argv[])
 {
-	int kvp_fd, len;
+	int kvp_fd = -1, len;
 	int error;
 	struct pollfd pfd;
 	char    *p;
@@ -1400,14 +1400,6 @@ int main(int argc, char *argv[])
 	openlog("KVP", 0, LOG_USER);
 	syslog(LOG_INFO, "KVP starting; pid is:%d", getpid());
 
-	kvp_fd = open("/dev/vmbus/hv_kvp", O_RDWR | O_CLOEXEC);
-
-	if (kvp_fd < 0) {
-		syslog(LOG_ERR, "open /dev/vmbus/hv_kvp failed; error: %d %s",
-			errno, strerror(errno));
-		exit(EXIT_FAILURE);
-	}
-
 	/*
 	 * Retrieve OS release information.
 	 */
@@ -1423,6 +1415,18 @@ int main(int argc, char *argv[])
 		exit(EXIT_FAILURE);
 	}
 
+reopen_kvp_fd:
+	if (kvp_fd != -1)
+		close(kvp_fd);
+	in_hand_shake = 1;
+	kvp_fd = open("/dev/vmbus/hv_kvp", O_RDWR | O_CLOEXEC);
+
+	if (kvp_fd < 0) {
+		syslog(LOG_ERR, "open /dev/vmbus/hv_kvp failed; error: %d %s",
+		       errno, strerror(errno));
+		exit(EXIT_FAILURE);
+	}
+
 	/*
 	 * Register ourselves with the kernel.
 	 */
@@ -1456,9 +1460,7 @@ int main(int argc, char *argv[])
 		if (len != sizeof(struct hv_kvp_msg)) {
 			syslog(LOG_ERR, "read failed; error:%d %s",
 			       errno, strerror(errno));
-
-			close(kvp_fd);
-			return EXIT_FAILURE;
+			goto reopen_kvp_fd;
 		}
 
 		/*
@@ -1617,13 +1619,17 @@ int main(int argc, char *argv[])
 			break;
 		}
 
-		/* Send the value back to the kernel. */
+		/*
+		 * Send the value back to the kernel. Note: the write() may
+		 * return an error due to hibernation; we can ignore the error
+		 * by resetting the dev file, i.e. closing and re-opening it.
+		 */
 kvp_done:
 		len = write(kvp_fd, hv_msg, sizeof(struct hv_kvp_msg));
 		if (len != sizeof(struct hv_kvp_msg)) {
 			syslog(LOG_ERR, "write failed; error: %d %s", errno,
 			       strerror(errno));
-			exit(EXIT_FAILURE);
+			goto reopen_kvp_fd;
 		}
 	}
 
diff --git a/tools/hv/hv_vss_daemon.c b/tools/hv/hv_vss_daemon.c
index 92902a88f671..dd111870beee 100644
--- a/tools/hv/hv_vss_daemon.c
+++ b/tools/hv/hv_vss_daemon.c
@@ -28,6 +28,8 @@
 #include <stdbool.h>
 #include <dirent.h>
 
+static bool fs_frozen;
+
 /* Don't use syslog() in the function since that can cause write to disk */
 static int vss_do_freeze(char *dir, unsigned int cmd)
 {
@@ -155,18 +157,27 @@ static int vss_operate(int operation)
 			continue;
 		}
 		error |= vss_do_freeze(ent->mnt_dir, cmd);
-		if (error && operation == VSS_OP_FREEZE)
-			goto err;
+		if (operation == VSS_OP_FREEZE) {
+			if (error)
+				goto err;
+			fs_frozen = true;
+		}
 	}
 
 	endmntent(mounts);
 
 	if (root_seen) {
 		error |= vss_do_freeze("/", cmd);
-		if (error && operation == VSS_OP_FREEZE)
-			goto err;
+		if (operation == VSS_OP_FREEZE) {
+			if (error)
+				goto err;
+			fs_frozen = true;
+		}
 	}
 
+	if (operation == VSS_OP_THAW && !error)
+		fs_frozen = false;
+
 	goto out;
 err:
 	save_errno = errno;
@@ -175,6 +186,7 @@ static int vss_operate(int operation)
 		endmntent(mounts);
 	}
 	vss_operate(VSS_OP_THAW);
+	fs_frozen = false;
 	/* Call syslog after we thaw all filesystems */
 	if (ent)
 		syslog(LOG_ERR, "FREEZE of %s failed; error:%d %s",
@@ -196,13 +208,13 @@ void print_usage(char *argv[])
 
 int main(int argc, char *argv[])
 {
-	int vss_fd, len;
+	int vss_fd = -1, len;
 	int error;
 	struct pollfd pfd;
 	int	op;
 	struct hv_vss_msg vss_msg[1];
 	int daemonize = 1, long_index = 0, opt;
-	int in_handshake = 1;
+	int in_handshake;
 	__u32 kernel_modver;
 
 	static struct option long_options[] = {
@@ -232,6 +244,18 @@ int main(int argc, char *argv[])
 	openlog("Hyper-V VSS", 0, LOG_USER);
 	syslog(LOG_INFO, "VSS starting; pid is:%d", getpid());
 
+reopen_vss_fd:
+	if (vss_fd != -1)
+		close(vss_fd);
+	if (fs_frozen) {
+		if (vss_operate(VSS_OP_THAW) || fs_frozen) {
+			syslog(LOG_ERR, "failed to thaw file system: err=%d",
+			       errno);
+			exit(EXIT_FAILURE);
+		}
+	}
+
+	in_handshake = 1;
 	vss_fd = open("/dev/vmbus/hv_vss", O_RDWR);
 	if (vss_fd < 0) {
 		syslog(LOG_ERR, "open /dev/vmbus/hv_vss failed; error: %d %s",
@@ -284,8 +308,7 @@ int main(int argc, char *argv[])
 		if (len != sizeof(struct hv_vss_msg)) {
 			syslog(LOG_ERR, "read failed; error:%d %s",
 			       errno, strerror(errno));
-			close(vss_fd);
-			return EXIT_FAILURE;
+			goto reopen_vss_fd;
 		}
 
 		op = vss_msg->vss_hdr.operation;
@@ -312,14 +335,18 @@ int main(int argc, char *argv[])
 		default:
 			syslog(LOG_ERR, "Illegal op:%d\n", op);
 		}
+
+		/*
+		 * The write() may return an error due to the faked VSS_OP_THAW
+		 * message upon hibernation. Ignore the error by resetting the
+		 * dev file, i.e. closing and re-opening it.
+		 */
 		vss_msg->error = error;
 		len = write(vss_fd, vss_msg, sizeof(struct hv_vss_msg));
 		if (len != sizeof(struct hv_vss_msg)) {
 			syslog(LOG_ERR, "write failed; error: %d %s", errno,
 			       strerror(errno));
-
-			if (op == VSS_OP_FREEZE)
-				vss_operate(VSS_OP_THAW);
+			goto reopen_vss_fd;
 		}
 	}
 
-- 
2.19.1

