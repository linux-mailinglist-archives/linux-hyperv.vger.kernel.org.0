Return-Path: <linux-hyperv+bounces-6189-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AB30B01351
	for <lists+linux-hyperv@lfdr.de>; Fri, 11 Jul 2025 08:09:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 76FCD171A98
	for <lists+linux-hyperv@lfdr.de>; Fri, 11 Jul 2025 06:09:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F0291C5F2C;
	Fri, 11 Jul 2025 06:08:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="meY0HnVD"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03CCF944F;
	Fri, 11 Jul 2025 06:08:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752214137; cv=none; b=A9+uV/kmasqS4h0EcEsIAKyOFrc5i0rZraFwDaWZib10d4/yuBFqO3wjU0k6mMjWYCVyj3+VqI3LWuTLBSePVg0lpY+x6eD6yT+qwTLLZFwoabx4wVMcvQX98elQgp12T99co+4szQp/ernpo0YSIMj4nnHxGXwhHokUsI5LIrM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752214137; c=relaxed/simple;
	bh=QjF5BzSgzj78DANOKaT+lShHyk0cn1rnyxGWfTHM9hM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=CBbjvrZXxcQfbu18hmBMcu4i1pYObXkKDEkcegN3G8r+PiyuRY9DbH4EXeKDWIm8OWkD+cPoLmGNU+sQSjzNLyCGwyksSJ35Pg/uFVZX6w+WsHRGgnDlkhEggMK9muHUapQCkib0i7cVDNqJW7YNYRTDsGnngdrRllOVB6uGHHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=meY0HnVD; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from namjain-Virtual-Machine.mshome.net (unknown [4.213.232.44])
	by linux.microsoft.com (Postfix) with ESMTPSA id CA450201A4AC;
	Thu, 10 Jul 2025 23:08:52 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com CA450201A4AC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1752214135;
	bh=/Q7idzf4FKj6hEbdYzmxDNSg5CWgPUcvcwaIQhXEWpU=;
	h=From:To:Cc:Subject:Date:From;
	b=meY0HnVDxv6oAeuT1E0Wh5y+TOqdFtuf9Oc39rSZGROliVT6YhRlRG2OK5mxbEsiO
	 lfaRWTs1qxlOb+lUFqne+AKQOTSWkRXpt6PchFpCVbiiCjn8eDhyc3ODgwasfa/7RI
	 bhvbbLnt7ybb0OkJgUPSWBzsOSrYVVmgEFTKnThE=
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
Subject: [PATCH v4] tools/hv: fcopy: Fix irregularities with size of ring buffer
Date: Fri, 11 Jul 2025 11:38:46 +0530
Message-Id: <20250711060846.9168-1-namjain@linux.microsoft.com>
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
Reviewed-by: Saurabh Sengar <ssengar@linux.microsoft.com>
---
 tools/hv/hv_fcopy_uio_daemon.c | 91 ++++++++++++++++++++++++++++++----
 1 file changed, 81 insertions(+), 10 deletions(-)

diff --git a/tools/hv/hv_fcopy_uio_daemon.c b/tools/hv/hv_fcopy_uio_daemon.c
index 0198321d14a2..7d9bcb066d3f 100644
--- a/tools/hv/hv_fcopy_uio_daemon.c
+++ b/tools/hv/hv_fcopy_uio_daemon.c
@@ -35,7 +35,10 @@
 #define WIN8_SRV_MINOR		1
 #define WIN8_SRV_VERSION	(WIN8_SRV_MAJOR << 16 | WIN8_SRV_MINOR)
 
-#define FCOPY_UIO		"/sys/bus/vmbus/devices/eb765408-105f-49b6-b4aa-c123b64d17d4/uio"
+#define FCOPY_DEVICE_PATH(subdir) \
+	"/sys/bus/vmbus/devices/eb765408-105f-49b6-b4aa-c123b64d17d4/" #subdir
+#define FCOPY_UIO_PATH          FCOPY_DEVICE_PATH(uio)
+#define FCOPY_CHANNELS_PATH     FCOPY_DEVICE_PATH(channels)
 
 #define FCOPY_VER_COUNT		1
 static const int fcopy_versions[] = {
@@ -47,9 +50,62 @@ static const int fw_versions[] = {
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
+
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
 
-static unsigned char desc[HV_RING_SIZE];
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
@@ -406,7 +462,7 @@ int main(int argc, char *argv[])
 	int daemonize = 1, long_index = 0, opt, ret = -EINVAL;
 	struct vmbus_br txbr, rxbr;
 	void *ring;
-	uint32_t len = HV_RING_SIZE;
+	uint32_t ring_size, len;
 	char uio_name[NAME_MAX] = {0};
 	char uio_dev_path[PATH_MAX] = {0};
 
@@ -437,7 +493,20 @@ int main(int argc, char *argv[])
 	openlog("HV_UIO_FCOPY", 0, LOG_USER);
 	syslog(LOG_INFO, "starting; pid is:%d", getpid());
 
-	fcopy_get_first_folder(FCOPY_UIO, uio_name);
+	ring_size = get_ring_buffer_size();
+	if (!ring_size) {
+		ret = -ENODEV;
+		goto exit;
+	}
+
+	desc = malloc(ring_size * sizeof(unsigned char));
+	if (!desc) {
+		syslog(LOG_ERR, "malloc failed for desc buffer");
+		ret = -ENOMEM;
+		goto exit;
+	}
+
+	fcopy_get_first_folder(FCOPY_UIO_PATH, uio_name);
 	snprintf(uio_dev_path, sizeof(uio_dev_path), "/dev/%s", uio_name);
 	fcopy_fd = open(uio_dev_path, O_RDWR);
 
@@ -445,17 +514,17 @@ int main(int argc, char *argv[])
 		syslog(LOG_ERR, "open %s failed; error: %d %s",
 		       uio_dev_path, errno, strerror(errno));
 		ret = fcopy_fd;
-		goto exit;
+		goto free_desc;
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
 
@@ -472,7 +541,7 @@ int main(int argc, char *argv[])
 			goto close;
 		}
 
-		len = HV_RING_SIZE;
+		len = ring_size;
 		ret = rte_vmbus_chan_recv_raw(&rxbr, desc, &len);
 		if (unlikely(ret <= 0)) {
 			/* This indicates a failure to communicate (or worse) */
@@ -492,6 +561,8 @@ int main(int argc, char *argv[])
 	}
 close:
 	close(fcopy_fd);
+free_desc:
+	free(desc);
 exit:
 	return ret;
 }

base-commit: b551c4e2a98a177a06148cf16505643cd2108386
-- 
2.34.1


