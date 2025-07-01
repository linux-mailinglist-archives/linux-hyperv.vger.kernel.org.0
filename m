Return-Path: <linux-hyperv+bounces-6062-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C123CAEF584
	for <lists+linux-hyperv@lfdr.de>; Tue,  1 Jul 2025 12:49:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E7DB21895AF2
	for <lists+linux-hyperv@lfdr.de>; Tue,  1 Jul 2025 10:49:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3E27271447;
	Tue,  1 Jul 2025 10:48:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="DVzJ/88P"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43A66270EC3;
	Tue,  1 Jul 2025 10:48:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751366931; cv=none; b=jhzDlMX1M7NQL9fLElgDZMRT8TJhehD1pPmSZkeZYVYzT0rBFB95RAzKZvtIXby7qRqTwHTvy7gFyoP+Qa1inR4g3FEolYvLz8IrAYIzPfOVox3ZxXsWMVw5ovg0XcoOwbActeC2cjiWRGt6oQnH+1Drsie4lR6VdoN7nLcnbrY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751366931; c=relaxed/simple;
	bh=xMRqV198FRBCLCeJk89yMS6Zfr6mkLw4sENEFReDij8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=AO1zr6iWnM6uWgK+4Bb8RsZZV3zriBCRYYAz9lADgUbj/Kkb0NnhEVLH57ef6tkY6TBUxlrz2XTvx8cnQPo/ijB3yBoMFJ6BY/FkVR+8ImD0Hqx0I04d15Zq8yJ2gsz5d0QLhsmrFFQSP1wZUENsyGrPXtKSIp3N8pTLdPpLV8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=DVzJ/88P; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from namjain-Virtual-Machine.mshome.net (unknown [4.213.232.43])
	by linux.microsoft.com (Postfix) with ESMTPSA id F1E2D206787D;
	Tue,  1 Jul 2025 03:48:46 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com F1E2D206787D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1751366929;
	bh=1mZwCYjK5KwlkUcBLP6Sb3wXHC217d46BhcC97NsTXs=;
	h=From:To:Cc:Subject:Date:From;
	b=DVzJ/88P/VW6hE+NTmuM8z2kHscNZ+/l9LHR4gkTzHa+E5A+QITUHII1wy/ZIayoV
	 ZNquvoN+t/0RedP53J0EBxHnxy1IaDsqqVZCu+t234pxAn+aKOTiGQcI2YK8+Z6RLZ
	 p+Iskj/7d1Z574Ql4Ei/vtmaNBdgjA8K92sEY6d8=
From: Naman Jain <namjain@linux.microsoft.com>
To: "K . Y . Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>,
	Dexuan Cui <decui@microsoft.com>,
	Long Li <longli@microsoft.com>,
	Michael Kelley <mhklinux@outlook.com>
Cc: linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Olaf Hering <olaf@aepfle.de>,
	Saurabh Sengar <ssengar@linux.microsoft.com>,
	Naman Jain <namjain@linux.microsoft.com>
Subject: [PATCH v2] tools/hv: fcopy: Fix irregularities with size of ring buffer
Date: Tue,  1 Jul 2025 16:18:37 +0530
Message-Id: <20250701104837.3006-1-namjain@linux.microsoft.com>
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
Changes since v1:
https://lore.kernel.org/all/20250620070618.3097-1-namjain@linux.microsoft.com/

* Removed unnecessary type casting in malloc for desc variable (Olaf)
* Added retry mechanisms to avoid potential race conditions (Michael)
* Moved the logic to fetch ring size to a later part in main (Michael)

So Michael, you suggested me to move the above logic after the
/dev/uio<N> entry is successfully opened. But there is some issue
with uio_hv_generic changing interrupt mask, resulting in fcopy daemon
to get stuck in pread forever. Since fcopy is broken as of now, I
thought it is better to take it separately, and let this change go.
Please let me know if you are fine with that.
---
 tools/hv/hv_fcopy_uio_daemon.c | 82 +++++++++++++++++++++++++++++++---
 1 file changed, 75 insertions(+), 7 deletions(-)

diff --git a/tools/hv/hv_fcopy_uio_daemon.c b/tools/hv/hv_fcopy_uio_daemon.c
index 0198321d14a2..f2e4976ebf28 100644
--- a/tools/hv/hv_fcopy_uio_daemon.c
+++ b/tools/hv/hv_fcopy_uio_daemon.c
@@ -36,6 +36,7 @@
 #define WIN8_SRV_VERSION	(WIN8_SRV_MAJOR << 16 | WIN8_SRV_MINOR)
 
 #define FCOPY_UIO		"/sys/bus/vmbus/devices/eb765408-105f-49b6-b4aa-c123b64d17d4/uio"
+#define FCOPY_CHANNELS_PATH	"/sys/bus/vmbus/devices/eb765408-105f-49b6-b4aa-c123b64d17d4/channels"
 
 #define FCOPY_VER_COUNT		1
 static const int fcopy_versions[] = {
@@ -47,9 +48,67 @@ static const int fw_versions[] = {
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
+	int retry_count = 0;
+
+	/* Find the channel directory */
+	dir = opendir(FCOPY_CHANNELS_PATH);
+	if (!dir) {
+		usleep(100 * 1000); /* Avoid race with kernel, wait 100ms and retry once */
+		dir = opendir(FCOPY_CHANNELS_PATH);
+		if (!dir) {
+			syslog(LOG_ERR, "Failed to open channels directory: %s", strerror(errno));
+			return HV_RING_SIZE_DEFAULT;
+		}
+	}
+
+retry_once:
+	while ((entry = readdir(dir)) != NULL) {
+		if (entry->d_type == DT_DIR && strcmp(entry->d_name, ".") != 0 &&
+		    strcmp(entry->d_name, "..") != 0) {
+			snprintf(ring_path, sizeof(ring_path), "%s/%s/ring",
+				 FCOPY_CHANNELS_PATH, entry->d_name);
+
+			if (stat(ring_path, &st) == 0) {
+				/*
+				 * stat returns size of Tx, Rx rings combined,
+				 * so take half of it for individual ring size.
+				 */
+				ring_size = (uint32_t)st.st_size / 2;
+				syslog(LOG_INFO, "Ring buffer size from %s: %u bytes",
+				       ring_path, ring_size);
+				break;
+			}
+		}
+	}
+
+	if (!ring_size && retry_count == 0) {
+		retry_count = 1;
+		rewinddir(dir);
+		usleep(100 * 1000); /* Wait 100ms and retry once */
+		goto retry_once;
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
@@ -406,7 +465,7 @@ int main(int argc, char *argv[])
 	int daemonize = 1, long_index = 0, opt, ret = -EINVAL;
 	struct vmbus_br txbr, rxbr;
 	void *ring;
-	uint32_t len = HV_RING_SIZE;
+	uint32_t ring_size, len;
 	char uio_name[NAME_MAX] = {0};
 	char uio_dev_path[PATH_MAX] = {0};
 
@@ -437,6 +496,15 @@ int main(int argc, char *argv[])
 	openlog("HV_UIO_FCOPY", 0, LOG_USER);
 	syslog(LOG_INFO, "starting; pid is:%d", getpid());
 
+	ring_size = get_ring_buffer_size();
+	len = ring_size;
+	desc = malloc(ring_size * sizeof(unsigned char));
+	if (!desc) {
+		syslog(LOG_ERR, "malloc failed for desc buffer");
+		ret = -ENOMEM;
+		goto exit;
+	}
+
 	fcopy_get_first_folder(FCOPY_UIO, uio_name);
 	snprintf(uio_dev_path, sizeof(uio_dev_path), "/dev/%s", uio_name);
 	fcopy_fd = open(uio_dev_path, O_RDWR);
@@ -448,14 +516,14 @@ int main(int argc, char *argv[])
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
 
@@ -472,7 +540,7 @@ int main(int argc, char *argv[])
 			goto close;
 		}
 
-		len = HV_RING_SIZE;
+		len = ring_size;
 		ret = rte_vmbus_chan_recv_raw(&rxbr, desc, &len);
 		if (unlikely(ret <= 0)) {
 			/* This indicates a failure to communicate (or worse) */

base-commit: 1343433ed38923a21425c602e92120a1f1db5f7a
-- 
2.34.1


