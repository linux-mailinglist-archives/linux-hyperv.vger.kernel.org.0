Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2CFA71497A3
	for <lists+linux-hyperv@lfdr.de>; Sat, 25 Jan 2020 20:55:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729134AbgAYTzF (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Sat, 25 Jan 2020 14:55:05 -0500
Received: from mail-dm6nam11on2132.outbound.protection.outlook.com ([40.107.223.132]:55905
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729112AbgAYTzF (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Sat, 25 Jan 2020 14:55:05 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SjJbvBT6L3+dAlq+N2dObiPAArTHbFWZBJG76L+ToifDG/SlT9NkUueRptYqL4CCCm+SdWvpxpKIHz8zUo2YFeUTP0mMCc1k9d68OP4HMrW4j3lK5GVQ09EpqN+HI4GslHYvxEFhbFBtIY25U3M3B7AQJ9xGjiz2+aqcbZz+ITc9vAoW7IO+y6+Sva6V1p0KT+s1tHY8G1PLfh9aE3MP6WXk/WVniqDaKx2rEpZoYNmkQShpOYhCKH72RIxNgxvZ8OhITZyUiMmFbCrqljUndbgp3DFXiYdfsKTTiGJkMAlw3m07Qx1fYWSir/1HsbhnY8TfTILfh4v+45a8UAR+1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dwGi4DV6YrT/tBgzeHVkWT9nanGC2FM3oGSANUPIUUs=;
 b=lFvyhg6PrCaI1L8KnSknmGGr3kKC7Lq4iJ68ZkNWjhSdzfH1cZ3oEhSGrng8Bv2EeLaaJOji1XV6YogAuEh/yN9/JpoBN40SSR3orD5uWuP+jA1W6Xy3kHu78fKzoM0thQ4nHQk1UcEOK42nxUDDk8pcnuyLKiams0E2Dr1m2ERHBO0zHM3E89eJD3oMM9UdrN2OV6e9dUttEGGmycisHjhOmBYSB1Bvb9gOapjOM0Mp1vGunmMMwkfrISay2fXWNMObdU3L4Uq+TRkn94RFPgzN1IiNcnhtWtZv8Iioi68vPXxGm2puo5Kb+LmPV2xsghNuSatGw0OMOpWSm643UA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dwGi4DV6YrT/tBgzeHVkWT9nanGC2FM3oGSANUPIUUs=;
 b=Z5/yM+i6c+n0pGhHJqoCEt+SlXcA2Bl/MELEpZXbFWfdQ57qQkIy26e+KLEuD2Sn/G7s3CZ112J68kuewYxk9estDGs1oiExCWR00PdJSnxwQibzz1huYoLFyJylowADXs4vbFkQ0COOF+1J1bVka/ynMVkjshTP13NLH15bvSM=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=decui@microsoft.com; 
Received: from BN8PR21MB1139.namprd21.prod.outlook.com (20.179.72.138) by
 BN8PR21MB1202.namprd21.prod.outlook.com (20.179.73.142) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2686.7; Sat, 25 Jan 2020 19:55:02 +0000
Received: from BN8PR21MB1139.namprd21.prod.outlook.com
 ([fe80::b4cb:911c:ec4a:950e]) by BN8PR21MB1139.namprd21.prod.outlook.com
 ([fe80::b4cb:911c:ec4a:950e%7]) with mapi id 15.20.2686.007; Sat, 25 Jan 2020
 19:55:02 +0000
From:   Dexuan Cui <decui@microsoft.com>
To:     kys@microsoft.com, haiyangz@microsoft.com, sthemmin@microsoft.com,
        sashal@kernel.org, linux-hyperv@vger.kernel.org,
        linux-kernel@vger.kernel.org, mikelley@microsoft.com,
        vkuznets@redhat.com
Cc:     Dexuan Cui <decui@microsoft.com>
Subject: [PATCH v3 1/4] Tools: hv: Reopen the devices if read() or write() returns errors
Date:   Sat, 25 Jan 2020 11:53:53 -0800
Message-Id: <1579982036-121722-2-git-send-email-decui@microsoft.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1579982036-121722-1-git-send-email-decui@microsoft.com>
References: <1579982036-121722-1-git-send-email-decui@microsoft.com>
Reply-To: decui@microsoft.com
Content-Type: text/plain
X-ClientProxiedBy: MWHPR10CA0005.namprd10.prod.outlook.com (2603:10b6:301::15)
 To BN8PR21MB1139.namprd21.prod.outlook.com (2603:10b6:408:72::10)
MIME-Version: 1.0
Received: from linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net (13.77.154.182) by MWHPR10CA0005.namprd10.prod.outlook.com (2603:10b6:301::15) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2665.20 via Frontend Transport; Sat, 25 Jan 2020 19:55:01 +0000
X-Mailer: git-send-email 1.8.3.1
X-Originating-IP: [13.77.154.182]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: aee05e34-7810-4a6d-ed25-08d7a1d0771f
X-MS-TrafficTypeDiagnostic: BN8PR21MB1202:|BN8PR21MB1202:|BN8PR21MB1202:
X-MS-Exchange-Transport-Forked: True
X-LD-Processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
X-Microsoft-Antispam-PRVS: <BN8PR21MB1202571E0D25762531B5ED08BF090@BN8PR21MB1202.namprd21.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5236;
X-Forefront-PRVS: 0293D40691
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(4636009)(366004)(376002)(39860400002)(346002)(136003)(396003)(199004)(189003)(81156014)(81166006)(8936002)(478600001)(2906002)(8676002)(86362001)(6486002)(186003)(4326008)(26005)(6506007)(36756003)(5660300002)(10290500003)(16526019)(3450700001)(52116002)(66476007)(6512007)(956004)(66946007)(2616005)(316002)(66556008)(107886003)(6666004);DIR:OUT;SFP:1102;SCL:1;SRVR:BN8PR21MB1202;H:BN8PR21MB1139.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sTh2zarj2jWWQw8pwmaaS3klbM+V66m0LnLz8PjnpxAnjVxmKam5+4uz9VOdfX4juLZJHnFA0SXVEskqXJbuQWEw05aExuh/K8xik16C2jEGg+i6mWFIg/Mjb7rG1471tTgVIGkDOTZKoNNNK9ry9kaj/cLvUeHICnjkMpbYzLsDBnj13fRY13oLNKvCwS8htKbnZa1K1xnx0+ooAt7wvRqPoW3WZYanocMrSu81m2FNg87yDzuW9n0U8DzgjvZArtjXBhipyflYRl7BQGmLfzUeA6VWeg+50ZMnv7PmuKawcQk7BY/Od2OfNMjEtP39b7mz0+VtpAE+ig5mNZaJswhsA3Lx1eDDb+jCv2pNliKJwM6Yo2fBRs1TlSui/xleA3uSIH0T3UyWCNQf5bkGWoAKFJNIdljd7d41bgra3X4mzOuadCmb9mcS1BaOrDS0
X-MS-Exchange-AntiSpam-MessageData: CKh5EZNy/WK8h31+uE26+KeYMo5dM5P0yX9fzSI0h1JXauwhbYOi7kjaodyk6qqW2UD7cNZRSYF3xB8Ijfb9czSIpQGS1UmTCaJ5DY+y3rH598IMjheyY6FUi0aasegD/QraR+qSx79e8zlFb7CZkQ==
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aee05e34-7810-4a6d-ed25-08d7a1d0771f
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jan 2020 19:55:02.6711
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6oJ6g5zRl/w3WKoNmcyK9WDIwViee+p95fi2CgtgaEuXUnzq8HF1tvFBclxjlVGIWWlmL3GP0diiB3uD0BoOeQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR21MB1202
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
    After reopen_vss_fd: if vss_operate(VSS_OP_THAW) can not clear
        fs_frozen due to an error, we just exit().
    Added comments.

 tools/hv/hv_fcopy_daemon.c | 33 +++++++++++++++++++++----
 tools/hv/hv_kvp_daemon.c   | 36 ++++++++++++++++------------
 tools/hv/hv_vss_daemon.c   | 49 +++++++++++++++++++++++++++++---------
 3 files changed, 88 insertions(+), 30 deletions(-)

diff --git a/tools/hv/hv_fcopy_daemon.c b/tools/hv/hv_fcopy_daemon.c
index aea2d91ab364..48cfa032432c 100644
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
@@ -141,7 +157,7 @@ int main(int argc, char *argv[])
 		struct hv_do_fcopy copy;
 		__u32 kernel_modver;
 	} buffer = { };
-	int in_handshake = 1;
+	int in_handshake;
 
 	static struct option long_options[] = {
 		{"help",	no_argument,	   0,  'h' },
@@ -170,6 +186,10 @@ int main(int argc, char *argv[])
 	openlog("HV_FCOPY", 0, LOG_USER);
 	syslog(LOG_INFO, "starting; pid is:%d", getpid());
 
+reopen_fcopy_fd:
+	/* Remove any possible partially-copied file on error */
+	hv_copy_cancel();
+	in_handshake = 1;
 	fcopy_fd = open("/dev/vmbus/hv_fcopy", O_RDWR);
 
 	if (fcopy_fd < 0) {
@@ -196,7 +216,7 @@ int main(int argc, char *argv[])
 		len = pread(fcopy_fd, &buffer, sizeof(buffer), 0);
 		if (len < 0) {
 			syslog(LOG_ERR, "pread failed: %s", strerror(errno));
-			exit(EXIT_FAILURE);
+			goto reopen_fcopy_fd;
 		}
 
 		if (in_handshake) {
@@ -231,9 +251,14 @@ int main(int argc, char *argv[])
 
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

