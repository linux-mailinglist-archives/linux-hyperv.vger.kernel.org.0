Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A195F2CFCA6
	for <lists+linux-hyperv@lfdr.de>; Sat,  5 Dec 2020 19:51:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726312AbgLESTT (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Sat, 5 Dec 2020 13:19:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727653AbgLERqn (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Sat, 5 Dec 2020 12:46:43 -0500
Received: from faui03.informatik.uni-erlangen.de (faui03.informatik.uni-erlangen.de [IPv6:2001:638:a000:4130:131:188:30:103])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A52A2C02B8FB;
        Sat,  5 Dec 2020 09:32:54 -0800 (PST)
Received: from cip4d0.informatik.uni-erlangen.de (cip4d0.cip.cs.fau.de [IPv6:2001:638:a000:4160:131:188:60:59])
        by faui03.informatik.uni-erlangen.de (Postfix) with ESMTP id EBC38240131;
        Sat,  5 Dec 2020 18:30:08 +0100 (CET)
Received: by cip4d0.informatik.uni-erlangen.de (Postfix, from userid 68457)
        id E6354D8049E; Sat,  5 Dec 2020 18:30:08 +0100 (CET)
From:   Stefan Eschenbacher <stefan.eschenbacher@fau.de>
To:     "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>
Cc:     Stefan Eschenbacher <stefan.eschenbacher@fau.de>,
        linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kernel@i4.cs.fau.de, Max Stolze <max.stolze@fau.de>
Subject: [PATCH 1/3] drivers/hv: make max_num_channels_supported configurable
Date:   Sat,  5 Dec 2020 18:30:02 +0100
Message-Id: <20201205173002.2529-1-stefan.eschenbacher@fau.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201205172650.2290-1-stefan.eschenbacher@fau.de>
References: <20201205172650.2290-1-stefan.eschenbacher@fau.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

To make the number of supported channels configurable, this patch
introduces uint max_num_channels_supported as module parameter.
Also macro MAX_NUM_CHANNELS_SUPPORTED_DEFAULT is introduced with
value 256, which is the currently used macro value.
MAX_NUM_CHANNELS_SUPPORTED was found and replaced in two locations.

During module initialization sanity checks are applied which will result
in EINVAL or ERANGE if the given value is no multiple of 32 or larger than
MAX_NUM_CHANNELS.

Signed-off-by: Stefan Eschenbacher <stefan.eschenbacher@fau.de>
Co-developed-by: Max Stolze <max.stolze@fau.de>
Signed-off-by: Max Stolze <max.stolze@fau.de>
---
 drivers/hv/hyperv_vmbus.h |  6 +++---
 drivers/hv/vmbus_drv.c    | 20 +++++++++++++++++++-
 2 files changed, 22 insertions(+), 4 deletions(-)

diff --git a/drivers/hv/hyperv_vmbus.h b/drivers/hv/hyperv_vmbus.h
index 02f3e8988836..edeee1c0497d 100644
--- a/drivers/hv/hyperv_vmbus.h
+++ b/drivers/hv/hyperv_vmbus.h
@@ -194,11 +194,11 @@ int hv_ringbuffer_read(struct vmbus_channel *channel,
 #define MAX_NUM_CHANNELS	((HV_HYP_PAGE_SIZE >> 1) << 3)
 
 /* The value here must be in multiple of 32 */
-/* TODO: Need to make this configurable */
-#define MAX_NUM_CHANNELS_SUPPORTED	256
+#define MAX_NUM_CHANNELS_SUPPORTED_DEFAULT	256
+extern uint max_num_channels_supported;
 
 #define MAX_CHANNEL_RELIDS					\
-	max(MAX_NUM_CHANNELS_SUPPORTED, HV_EVENT_FLAGS_COUNT)
+	max((ulong) max_num_channels_supported, (ulong) HV_EVENT_FLAGS_COUNT)
 
 enum vmbus_connect_state {
 	DISCONNECTED,
diff --git a/drivers/hv/vmbus_drv.c b/drivers/hv/vmbus_drv.c
index 502f8cd95f6d..8f1c8a606b4a 100644
--- a/drivers/hv/vmbus_drv.c
+++ b/drivers/hv/vmbus_drv.c
@@ -48,6 +48,11 @@ static int hyperv_cpuhp_online;
 
 static void *hv_panic_page;
 
+uint max_num_channels_supported = MAX_NUM_CHANNELS_SUPPORTED_DEFAULT;
+module_param(max_num_channels_supported, uint, 0);
+MODULE_PARM_DESC(max_num_channels_supported,
+	"Number of supported vmbus channels. Must be a multiple of 32 and equal to or less than 16348");
+
 /* Values parsed from ACPI DSDT */
 static int vmbus_irq;
 int vmbus_interrupt;
@@ -1220,7 +1225,7 @@ static void vmbus_chan_sched(struct hv_per_cpu_context *hv_cpu)
 	u32 maxbits, relid;
 
 	if (vmbus_proto_version < VERSION_WIN8) {
-		maxbits = MAX_NUM_CHANNELS_SUPPORTED;
+		maxbits = max_num_channels_supported;
 		recv_int_page = vmbus_connection.recv_int_page;
 	} else {
 		/*
@@ -2620,6 +2625,17 @@ static int __init hv_acpi_init(void)
 	if (!hv_is_hyperv_initialized())
 		return -ENODEV;
 
+	// Check if max_num_channels_supported is a multiple of 32 and smaller MAX_NUM_CHANNELS
+	if (max_num_channels_supported % 32 != 0) {
+		pr_err("max_num_channels_supported is %u, but must be a multiple of 32\n",
+			max_num_channels_supported);
+		return -EINVAL;
+	} else if (max_num_channels_supported > MAX_NUM_CHANNELS) {
+		pr_err("max_num_channels_supported is %u which exceeds maximum of %lu\n",
+			max_num_channels_supported, MAX_NUM_CHANNELS);
+		return -ERANGE;
+	}
+
 	init_completion(&probe_event);
 
 	/*
@@ -2641,6 +2657,8 @@ static int __init hv_acpi_init(void)
 	if (ret)
 		goto cleanup;
 
+	pr_info("Supporting up to %u channels\n", max_num_channels_supported);
+
 	hv_setup_kexec_handler(hv_kexec_handler);
 	hv_setup_crash_handler(hv_crash_handler);
 
-- 
2.20.1

