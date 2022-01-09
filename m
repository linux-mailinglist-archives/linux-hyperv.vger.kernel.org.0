Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B5776488898
	for <lists+linux-hyperv@lfdr.de>; Sun,  9 Jan 2022 10:55:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229523AbiAIJz2 (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Sun, 9 Jan 2022 04:55:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229473AbiAIJz1 (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Sun, 9 Jan 2022 04:55:27 -0500
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73FE2C06173F
        for <linux-hyperv@vger.kernel.org>; Sun,  9 Jan 2022 01:55:27 -0800 (PST)
Received: by mail-pj1-x102e.google.com with SMTP id 59-20020a17090a09c100b001b34a13745eso11649696pjo.5
        for <linux-hyperv@vger.kernel.org>; Sun, 09 Jan 2022 01:55:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=6lx4WtuK/iCNQPOX7wOlMk8ruAPUmNxQ7XRdTkMm7FQ=;
        b=jXmX1wUImiiiH+xOi01i4MUGozwazW36BPAMy8C2fBdsifUmHdEcH1ftwkR1F3lyfj
         UFhjUCBtDPGh/jHkA8vnrA2dgu/ketM1E+ehU2A4RFy31XlaD8HEwT31Va1KuWjjs1Ii
         zWleGG2Jff6dE7xluY9LXh8I/RwIk2WnVW/QgmG2v+ahLfkVMjGHghOY2hxKEpIkqVOf
         3vPxUhZZsc18kaWCyEGEbmlFkJqyFLdE26eAlwURWpDgnQj2PdYNPGiW9Xnz61hd5/ZI
         16jOsaQAEA2E9g0GS128MaVKVEjiiWM3T1VOAeeBJDrxW3NT0DgM5NgOTNF6ELlxG9Rg
         CuEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=6lx4WtuK/iCNQPOX7wOlMk8ruAPUmNxQ7XRdTkMm7FQ=;
        b=lxOLAfJNGgKxF0j2cBLxx3xZ2S74Eq+zBwPNQoaoBSJ+jxdIoJREi2kzplR01I/9u7
         awo4Nsj8wqidR26R0Kvgtg3bRw89QfhmI6fKwkJ+CDQypl0mS+AFjLCgNHYnch/pTw1m
         P8l+7OUbWZAdZqcHes6d3/NzGhRzXEpGDvbF/Z9E5m837CRscl3M8IB4+L8NPHDsw42H
         KhOqGDfNlt21YUKoEmLJvoBkaEyk/pwHRVm8YKHfVSDLAofosQljMz4TjBnPub3hxwJS
         juey05mnhVOx3CvQQW60MvaY7uoXuWq+0g/sf5g+UKEZ55YTIU2tZvRrRtZObldgl10Y
         9+NA==
X-Gm-Message-State: AOAM532SMLzzRkpMu0CVL6tKb0dZ9mLeQBm50dUUOyPkve4l61YdoHy3
        G2cTGIbmNZCziGfzlg8UDj5bnHVwjzGBd1bc
X-Google-Smtp-Source: ABdhPJxiOrnIX3TP1hnKbrOu64EvTehYADFkdY5jz+CgoBtBzLE2UP1ybrRWNFhcpErDSjICcYpiaQ==
X-Received: by 2002:a17:902:9695:b0:149:208f:d9f9 with SMTP id n21-20020a170902969500b00149208fd9f9mr70829488plp.139.1641722126501;
        Sun, 09 Jan 2022 01:55:26 -0800 (PST)
Received: from megumi-s.h.riat.re ([103.72.4.142])
        by smtp.gmail.com with ESMTPSA id s5sm3111667pfe.117.2022.01.09.01.55.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Jan 2022 01:55:26 -0800 (PST)
From:   Yanming Liu <yanminglr@gmail.com>
To:     linux-hyperv@vger.kernel.org
Cc:     "Andrea Parri (Microsoft)" <parri.andrea@gmail.com>,
        Wei Liu <wei.liu@kernel.org>, Yanming Liu <yanminglr@gmail.com>
Subject: [PATCH v2] hv: account for packet descriptor in maximum packet size
Date:   Sun,  9 Jan 2022 17:55:16 +0800
Message-Id: <20220109095516.3250392-1-yanminglr@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Commit adae1e931acd ("Drivers: hv: vmbus: Copy packets sent by Hyper-V
out of the ring buffer") introduced a notion of maximum packet size in
vmbus channel and used that size to initialize a buffer holding all
incoming packet along with their vmbus packet header. Currently, some
vmbus drivers set max_pkt_size to the size of their receive buffer
passed to vmbus_recvpacket, however vmbus_open expects this size to also
include vmbus packet header. This leads to corruption of the ring buffer
state when receiving a maximum sized packet.

Specifically, in hv_balloon I have observed of a dm_unballoon_request
message of 4096 bytes being truncated to 4080 bytes. When the driver
tries to read next packet it starts from a wrong read_index, receives
garbage and prints a lot of "Unhandled message: type: <garbage>" in
dmesg.

The same mismatch also happens in hv_fcopy, hv_kvp, hv_snapshot,
hv_util, hyperv_drm and hyperv_fb, though bad cases are not observed
yet.

Allocate the buffer with HV_HYP_PAGE_SIZE more bytes to make room for
the descriptor, assuming the vmbus packet header will never be larger
than HV_HYP_PAGE_SIZE. This is essentially free compared to just adding
'sizeof(struct vmpacket_descriptor)' because these buffers are all more
than HV_HYP_PAGE_SIZE bytes so kmalloc rounds them up anyway.

Fixes: adae1e931acd ("Drivers: hv: vmbus: Copy packets sent by Hyper-V out of the ring buffer")
Suggested-by: Andrea Parri (Microsoft) <parri.andrea@gmail.com>
Signed-off-by: Yanming Liu <yanminglr@gmail.com>
---
v2: Changed to modify max_pkt_size in individual drivers instead of in
vmbus code as suggested by Andrea Parri.

 drivers/gpu/drm/hyperv/hyperv_drm_proto.c |  2 ++
 drivers/hv/hv_balloon.c                   |  7 +++++++
 drivers/hv/hv_fcopy.c                     |  2 +-
 drivers/hv/hv_kvp.c                       |  2 +-
 drivers/hv/hv_snapshot.c                  |  2 +-
 drivers/hv/hv_util.c                      | 17 +++++++++++++++++
 drivers/video/fbdev/hyperv_fb.c           |  2 ++
 7 files changed, 31 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/hyperv/hyperv_drm_proto.c b/drivers/gpu/drm/hyperv/hyperv_drm_proto.c
index c0155c6271bf..bf1548054276 100644
--- a/drivers/gpu/drm/hyperv/hyperv_drm_proto.c
+++ b/drivers/gpu/drm/hyperv/hyperv_drm_proto.c
@@ -478,6 +478,8 @@ int hyperv_connect_vsp(struct hv_device *hdev)
 	struct drm_device *dev = &hv->dev;
 	int ret;
 
+	hdev->channel->max_pkt_size = HV_HYP_PAGE_SIZE + VMBUS_MAX_PACKET_SIZE;
+
 	ret = vmbus_open(hdev->channel, VMBUS_RING_BUFSIZE, VMBUS_RING_BUFSIZE,
 			 NULL, 0, hyperv_receive, hdev);
 	if (ret) {
diff --git a/drivers/hv/hv_balloon.c b/drivers/hv/hv_balloon.c
index ca873a3b98db..ee2527c3d3b8 100644
--- a/drivers/hv/hv_balloon.c
+++ b/drivers/hv/hv_balloon.c
@@ -1660,6 +1660,13 @@ static int balloon_connect_vsp(struct hv_device *dev)
 	unsigned long t;
 	int ret;
 
+	/*
+	 * max_pkt_size should be large enough for one vmbus packet header plus
+	 * our receive buffer size. We assume vmbus packet header is smaller
+	 * than HV_HYP_PAGE_SIZE.
+	 */
+	dev->channel->max_pkt_size = HV_HYP_PAGE_SIZE * 2;
+
 	ret = vmbus_open(dev->channel, dm_ring_size, dm_ring_size, NULL, 0,
 			 balloon_onchannelcallback, dev);
 	if (ret)
diff --git a/drivers/hv/hv_fcopy.c b/drivers/hv/hv_fcopy.c
index 660036da7449..07a508ce65db 100644
--- a/drivers/hv/hv_fcopy.c
+++ b/drivers/hv/hv_fcopy.c
@@ -349,7 +349,7 @@ int hv_fcopy_init(struct hv_util_service *srv)
 {
 	recv_buffer = srv->recv_buffer;
 	fcopy_transaction.recv_channel = srv->channel;
-	fcopy_transaction.recv_channel->max_pkt_size = HV_HYP_PAGE_SIZE * 2;
+	fcopy_transaction.recv_channel->max_pkt_size = HV_HYP_PAGE_SIZE * 3;
 
 	/*
 	 * When this driver loads, the user level daemon that
diff --git a/drivers/hv/hv_kvp.c b/drivers/hv/hv_kvp.c
index c698592b83e4..b85d725ae5b1 100644
--- a/drivers/hv/hv_kvp.c
+++ b/drivers/hv/hv_kvp.c
@@ -757,7 +757,7 @@ hv_kvp_init(struct hv_util_service *srv)
 {
 	recv_buffer = srv->recv_buffer;
 	kvp_transaction.recv_channel = srv->channel;
-	kvp_transaction.recv_channel->max_pkt_size = HV_HYP_PAGE_SIZE * 4;
+	kvp_transaction.recv_channel->max_pkt_size = HV_HYP_PAGE_SIZE * 5;
 
 	/*
 	 * When this driver loads, the user level daemon that
diff --git a/drivers/hv/hv_snapshot.c b/drivers/hv/hv_snapshot.c
index 6018b9d1b1fb..dba6baacbf17 100644
--- a/drivers/hv/hv_snapshot.c
+++ b/drivers/hv/hv_snapshot.c
@@ -375,7 +375,7 @@ hv_vss_init(struct hv_util_service *srv)
 	}
 	recv_buffer = srv->recv_buffer;
 	vss_transaction.recv_channel = srv->channel;
-	vss_transaction.recv_channel->max_pkt_size = HV_HYP_PAGE_SIZE * 2;
+	vss_transaction.recv_channel->max_pkt_size = HV_HYP_PAGE_SIZE * 3;
 
 	/*
 	 * When this driver loads, the user level daemon that
diff --git a/drivers/hv/hv_util.c b/drivers/hv/hv_util.c
index 835e6039c186..a7b88c067c07 100644
--- a/drivers/hv/hv_util.c
+++ b/drivers/hv/hv_util.c
@@ -112,6 +112,8 @@ static int hv_shutdown_init(struct hv_util_service *srv)
 
 	hibernation_supported = hv_is_hibernation_supported();
 
+	channel->max_pkt_size = HV_HYP_PAGE_SIZE * 2;
+
 	return 0;
 }
 
@@ -133,9 +135,11 @@ static struct hv_util_service util_timesynch = {
 	.util_deinit = hv_timesync_deinit,
 };
 
+static int heartbeat_init(struct hv_util_service *src);
 static void heartbeat_onchannelcallback(void *context);
 static struct hv_util_service util_heartbeat = {
 	.util_cb = heartbeat_onchannelcallback,
+	.util_init = heartbeat_init,
 };
 
 static struct hv_util_service util_kvp = {
@@ -553,6 +557,15 @@ static void heartbeat_onchannelcallback(void *context)
 	}
 }
 
+static int heartbeat_init(struct hv_util_service *srv)
+{
+	struct vmbus_channel *channel = srv->channel;
+
+	channel->max_pkt_size = HV_HYP_PAGE_SIZE * 2;
+
+	return 0;
+}
+
 #define HV_UTIL_RING_SEND_SIZE VMBUS_RING_SIZE(3 * HV_HYP_PAGE_SIZE)
 #define HV_UTIL_RING_RECV_SIZE VMBUS_RING_SIZE(3 * HV_HYP_PAGE_SIZE)
 
@@ -734,6 +747,8 @@ static struct ptp_clock *hv_ptp_clock;
 
 static int hv_timesync_init(struct hv_util_service *srv)
 {
+	struct vmbus_channel *channel = srv->channel;
+
 	spin_lock_init(&host_ts.lock);
 
 	INIT_WORK(&adj_time_work, hv_set_host_time);
@@ -750,6 +765,8 @@ static int hv_timesync_init(struct hv_util_service *srv)
 		hv_ptp_clock = NULL;
 	}
 
+	channel->max_pkt_size = HV_HYP_PAGE_SIZE * 2;
+
 	return 0;
 }
 
diff --git a/drivers/video/fbdev/hyperv_fb.c b/drivers/video/fbdev/hyperv_fb.c
index 23999df52739..ae4240777f7d 100644
--- a/drivers/video/fbdev/hyperv_fb.c
+++ b/drivers/video/fbdev/hyperv_fb.c
@@ -636,6 +636,8 @@ static int synthvid_connect_vsp(struct hv_device *hdev)
 	struct hvfb_par *par = info->par;
 	int ret;
 
+	hdev->channel->max_pkt_size = HV_HYP_PAGE_SIZE + MAX_VMBUS_PKT_SIZE;
+
 	ret = vmbus_open(hdev->channel, RING_BUFSIZE, RING_BUFSIZE,
 			 NULL, 0, synthvid_receive, hdev);
 	if (ret) {
-- 
2.34.1

