Return-Path: <linux-hyperv+bounces-5977-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B181AE1485
	for <lists+linux-hyperv@lfdr.de>; Fri, 20 Jun 2025 09:06:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B35E64A0DA1
	for <lists+linux-hyperv@lfdr.de>; Fri, 20 Jun 2025 07:06:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D924E2253E0;
	Fri, 20 Jun 2025 07:06:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="HfbPMewg"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 492C7A923;
	Fri, 20 Jun 2025 07:06:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750403211; cv=none; b=DfrkVUzq0BDXB0Sz6bsHVUaOzuwwCR+pFWc2lk6Lq2DkBJ4d0QPNTx6xEpY5xfLoRSGLqh6cPbE3gs3xpVWtKhdyTy8KJkQrqz38GvpBVrcu1q500+6/pae3uwUO3JY8IWPnwSD8vzaEd3Fp6d2s26wPM+T+4CCxsBTnGxXoH/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750403211; c=relaxed/simple;
	bh=SmlS60NEZr5Ej2L3lqp8/4Woh0GdyTocO/ohWGtU/wE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=oFKmljl0JKpKbS1aWfmSS4+aAZ5R/QjFMfb9IVzWRNHTlgH1MU3edWCbbul3MMmfDuhbLAUa1Vi13fT0mXPKav2GOXZl8yA4h/jDCjsAv3sUbASXMV+3JKFp7wK3LMmGFEeR9jf4w6mcfRGROKfFimxwHQrjTYNTYtEKSfxaRWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=HfbPMewg; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from namjain-Virtual-Machine.mshome.net (unknown [167.220.238.139])
	by linux.microsoft.com (Postfix) with ESMTPSA id E11FC20277C1;
	Fri, 20 Jun 2025 00:06:46 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com E11FC20277C1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1750403209;
	bh=BYw4HgDjdqu8ShsUkQvASB2T/It7pcAPBrXZBA0uP9g=;
	h=From:To:Cc:Subject:Date:From;
	b=HfbPMewgwqH5KJNI5vwxsdw0myCJ0sif8gqxXSuR2Cgq4vg7L+OII6X3VoZWFn/nM
	 zmf15hUM4/agFreUv3xTu7pOB4V3nydSO97OB8zlKIZCJ9yAp7sDooJ8lbskeZCCsJ
	 L/tGFjUVGpxPfUvEktcmkjQx6AOEelJYVJXhz3dM=
From: Naman Jain <namjain@linux.microsoft.com>
To: "K . Y . Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>,
	Dexuan Cui <decui@microsoft.com>,
	Long Li <longli@microsoft.com>,
	Michael Kelley <mhklinux@outlook.com>,
	Saurabh Sengar <ssengar@linux.microsoft.com>
Cc: linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	namjain@linux.microsoft.com,
	stable@vger.kernel.org
Subject: [PATCH] tools/hv: fcopy: Fix irregularities with size of ring buffer
Date: Fri, 20 Jun 2025 12:36:18 +0530
Message-Id: <20250620070618.3097-1-namjain@linux.microsoft.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Size of ring buffer, as defined in uio_hv_generic driver, is no longer
fixed to 16 KB. This creates a problem in fcopy, since this size was
hardcoded. With the change in place to make ring sysfs node actually
reflect the size of underlying ring buffer, it is safe to get the size
of ring sysfs file and use it for ring buffer size in fcopy daemon.
Fix the issue of disparity in ring buffer size, by making it dynamic
in fcopy uio daemon.

Cc: stable@vger.kernel.org
Fixes: 0315fef2aff9 ("uio_hv_generic: Align ring size to system page")
Signed-off-by: Naman Jain <namjain@linux.microsoft.com>
---
 tools/hv/hv_fcopy_uio_daemon.c | 65 ++++++++++++++++++++++++++++++----
 1 file changed, 58 insertions(+), 7 deletions(-)

diff --git a/tools/hv/hv_fcopy_uio_daemon.c b/tools/hv/hv_fcopy_uio_daemon.c
index 0198321d14a2..da2b27d6af0e 100644
--- a/tools/hv/hv_fcopy_uio_daemon.c
+++ b/tools/hv/hv_fcopy_uio_daemon.c
@@ -36,6 +36,7 @@
 #define WIN8_SRV_VERSION	(WIN8_SRV_MAJOR << 16 | WIN8_SRV_MINOR)
 
 #define FCOPY_UIO		"/sys/bus/vmbus/devices/eb765408-105f-49b6-b4aa-c123b64d17d4/uio"
+#define FCOPY_CHANNELS_PATH	"/sys/bus/vmbus/devices/eb765408-105f-49b6-b4aa-c123b64d17d4/channels"
 
 #define FCOPY_VER_COUNT		1
 static const int fcopy_versions[] = {
@@ -47,9 +48,51 @@ static const int fw_versions[] = {
 	UTIL_FW_VERSION
 };
 
-#define HV_RING_SIZE		0x4000 /* 16KB ring buffer size */
+#define HV_RING_SIZE_DEFAULT	0x4000 /* 16KB ring buffer size default */
 
-static unsigned char desc[HV_RING_SIZE];
+static uint32_t get_ring_buffer_size(void)
+{
+	char ring_path[PATH_MAX];
+	DIR *dir;
+	struct dirent *entry;
+	struct stat st;
+	uint32_t ring_size = 0;
+
+	/* Find the channel directory */
+	dir = opendir(FCOPY_CHANNELS_PATH);
+	if (!dir) {
+		syslog(LOG_ERR, "Failed to open channels directory, using default ring size");
+		return HV_RING_SIZE_DEFAULT;
+	}
+
+	while ((entry = readdir(dir)) != NULL) {
+		if (entry->d_type == DT_DIR && strcmp(entry->d_name, ".") != 0 &&
+		    strcmp(entry->d_name, "..") != 0) {
+			snprintf(ring_path, sizeof(ring_path), "%s/%s/ring",
+				 FCOPY_CHANNELS_PATH, entry->d_name);
+
+			if (stat(ring_path, &st) == 0) {
+				/* stat returns size of Tx, Rx rings combined, so take half of it */
+				ring_size = (uint32_t)st.st_size / 2;
+				syslog(LOG_INFO, "Ring buffer size from %s: %u bytes",
+				       ring_path, ring_size);
+				break;
+			}
+		}
+	}
+
+	closedir(dir);
+
+	if (!ring_size) {
+		ring_size = HV_RING_SIZE_DEFAULT;
+		syslog(LOG_ERR, "Could not determine ring size, using default: %u bytes",
+		       HV_RING_SIZE_DEFAULT);
+	}
+
+	return ring_size;
+}
+
+static unsigned char *desc;
 
 static int target_fd;
 static char target_fname[PATH_MAX];
@@ -406,7 +449,8 @@ int main(int argc, char *argv[])
 	int daemonize = 1, long_index = 0, opt, ret = -EINVAL;
 	struct vmbus_br txbr, rxbr;
 	void *ring;
-	uint32_t len = HV_RING_SIZE;
+	uint32_t ring_size = get_ring_buffer_size();
+	uint32_t len = ring_size;
 	char uio_name[NAME_MAX] = {0};
 	char uio_dev_path[PATH_MAX] = {0};
 
@@ -416,6 +460,13 @@ int main(int argc, char *argv[])
 		{0,		0,		   0,  0   }
 	};
 
+	desc = (unsigned char *)malloc(ring_size * sizeof(unsigned char));
+	if (!desc) {
+		syslog(LOG_ERR, "malloc failed for desc buffer");
+		ret = -ENOMEM;
+		goto exit;
+	}
+
 	while ((opt = getopt_long(argc, argv, "hn", long_options,
 				  &long_index)) != -1) {
 		switch (opt) {
@@ -448,14 +499,14 @@ int main(int argc, char *argv[])
 		goto exit;
 	}
 
-	ring = vmbus_uio_map(&fcopy_fd, HV_RING_SIZE);
+	ring = vmbus_uio_map(&fcopy_fd, ring_size);
 	if (!ring) {
 		ret = errno;
 		syslog(LOG_ERR, "mmap ringbuffer failed; error: %d %s", ret, strerror(ret));
 		goto close;
 	}
-	vmbus_br_setup(&txbr, ring, HV_RING_SIZE);
-	vmbus_br_setup(&rxbr, (char *)ring + HV_RING_SIZE, HV_RING_SIZE);
+	vmbus_br_setup(&txbr, ring, ring_size);
+	vmbus_br_setup(&rxbr, (char *)ring + ring_size, ring_size);
 
 	rxbr.vbr->imask = 0;
 
@@ -472,7 +523,7 @@ int main(int argc, char *argv[])
 			goto close;
 		}
 
-		len = HV_RING_SIZE;
+		len = ring_size;
 		ret = rte_vmbus_chan_recv_raw(&rxbr, desc, &len);
 		if (unlikely(ret <= 0)) {
 			/* This indicates a failure to communicate (or worse) */

base-commit: bc6e0ba6c9bafa6241b05524b9829808056ac4ad
-- 
2.34.1


