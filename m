Return-Path: <linux-hyperv+bounces-6145-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E9C46AFC4FA
	for <lists+linux-hyperv@lfdr.de>; Tue,  8 Jul 2025 10:03:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 790F6481550
	for <lists+linux-hyperv@lfdr.de>; Tue,  8 Jul 2025 08:03:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAE95226D17;
	Tue,  8 Jul 2025 08:03:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="UmQ7uucA"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76F3A220F38;
	Tue,  8 Jul 2025 08:03:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751961811; cv=none; b=nazEFTJjnabVu4Qqp0CGvcnfjge4ZLccm4jyXK7luwDzSQH5wHeZnW4akqVb1xNJPDt/vYFg6B3whTi/AmgsKY2gztl70ry/N2TTykh69Ec4CztVn4VCcwFm71XgB5V2vjDsyE+W9X2BvILdVZDRA1xv4LjmOxAIF8qqqMBgkt0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751961811; c=relaxed/simple;
	bh=Ugt1KAcJj9St1EzAIVpU4633/qb9DD+377dB4nWwLH4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=iccRBZNzuiNYNAl2TFanFvnN+Al++ySkpfuLGY5kpSbrGybnVGRRl5mfijhfjmw9Wbna0Te2vPPuIfgg+bWgC+PtW2IzklO8QYk0ditKNmhgO70IyNHh+w2T/CLtaD5Fqb1RU1g3MmemARqDiL8mPzTlhxUVY48vuhA8cu6R2C0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=UmQ7uucA; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from namjain-Virtual-Machine.mshome.net (unknown [4.213.232.40])
	by linux.microsoft.com (Postfix) with ESMTPSA id 2D560201B1DC;
	Tue,  8 Jul 2025 01:03:25 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 2D560201B1DC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1751961809;
	bh=eUSR5JQvM8D1+fXJepbw/p8MvJa4Z8PwmpIrOJ8XICY=;
	h=From:To:Cc:Subject:Date:From;
	b=UmQ7uucAZSgENnh+1UMUIYB0+bC6qt6NublHIolwjkOKkzBDXp+esumzMA/mP0QRW
	 qwtF7bLKONeGMXM7Yux+Cgtx2Tzry20Qkt1XIg1JXjJ9BR+6qFJGTV0IQEGtt9djWw
	 OtE6SG+SrQ6uQ9F9EVxquR23AKI7DrLrxOf4crXE=
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
Subject: [PATCH v3] tools/hv: fcopy: Fix irregularities with size of ring buffer
Date: Tue,  8 Jul 2025 13:33:19 +0530
Message-Id: <20250708080319.3904-1-namjain@linux.microsoft.com>
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
 tools/hv/hv_fcopy_uio_daemon.c | 82 +++++++++++++++++++++++++++++++---
 1 file changed, 75 insertions(+), 7 deletions(-)

diff --git a/tools/hv/hv_fcopy_uio_daemon.c b/tools/hv/hv_fcopy_uio_daemon.c
index 0198321d14a2..5388ee1ebf4d 100644
--- a/tools/hv/hv_fcopy_uio_daemon.c
+++ b/tools/hv/hv_fcopy_uio_daemon.c
@@ -36,6 +36,7 @@
 #define WIN8_SRV_VERSION	(WIN8_SRV_MAJOR << 16 | WIN8_SRV_MINOR)
 
 #define FCOPY_UIO		"/sys/bus/vmbus/devices/eb765408-105f-49b6-b4aa-c123b64d17d4/uio"
+#define FCOPY_CHANNELS_PATH	"/sys/bus/vmbus/devices/eb765408-105f-49b6-b4aa-c123b64d17d4/channels"
 
 #define FCOPY_VER_COUNT		1
 static const int fcopy_versions[] = {
@@ -47,9 +48,62 @@ static const int fw_versions[] = {
 	UTIL_FW_VERSION
 };
 
-#define HV_RING_SIZE		0x4000 /* 16KB ring buffer size */
+static uint32_t get_ring_buffer_size(void)
+{
+	char ring_path[PATH_MAX];
+	DIR *dir;
+	struct dirent *entry;
+	struct stat st;
+	uint32_t ring_size = 0;
+	int retry_count = 0;
 
-static unsigned char desc[HV_RING_SIZE];
+	/* Find the channel directory */
+	dir = opendir(FCOPY_CHANNELS_PATH);
+	if (!dir) {
+		usleep(100 * 1000); /* Avoid race with kernel, wait 100ms and retry once */
+		dir = opendir(FCOPY_CHANNELS_PATH);
+		if (!dir) {
+			syslog(LOG_ERR, "Failed to open channels directory: %s", strerror(errno));
+			return 0;
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
+	if (!ring_size)
+		syslog(LOG_ERR, "Could not determine ring size");
+
+	return ring_size;
+}
+
+static unsigned char *desc;
 
 static int target_fd;
 static char target_fname[PATH_MAX];
@@ -406,7 +460,7 @@ int main(int argc, char *argv[])
 	int daemonize = 1, long_index = 0, opt, ret = -EINVAL;
 	struct vmbus_br txbr, rxbr;
 	void *ring;
-	uint32_t len = HV_RING_SIZE;
+	uint32_t ring_size, len;
 	char uio_name[NAME_MAX] = {0};
 	char uio_dev_path[PATH_MAX] = {0};
 
@@ -437,6 +491,20 @@ int main(int argc, char *argv[])
 	openlog("HV_UIO_FCOPY", 0, LOG_USER);
 	syslog(LOG_INFO, "starting; pid is:%d", getpid());
 
+	ring_size = get_ring_buffer_size();
+	if (!ring_size) {
+		ret = -ENODEV;
+		goto exit;
+	}
+
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

base-commit: 26ffb3d6f02cd0935fb9fa3db897767beee1cb2a
-- 
2.34.1


