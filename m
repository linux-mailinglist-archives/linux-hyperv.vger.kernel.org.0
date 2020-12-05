Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A284D2CFC94
	for <lists+linux-hyperv@lfdr.de>; Sat,  5 Dec 2020 19:29:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728717AbgLES3P (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Sat, 5 Dec 2020 13:29:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727199AbgLES3O (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Sat, 5 Dec 2020 13:29:14 -0500
Received: from faui03.informatik.uni-erlangen.de (faui03.informatik.uni-erlangen.de [IPv6:2001:638:a000:4130:131:188:30:103])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A193AC02B8F7;
        Sat,  5 Dec 2020 09:30:36 -0800 (PST)
Received: from cip4d0.informatik.uni-erlangen.de (cip4d0.cip.cs.fau.de [IPv6:2001:638:a000:4160:131:188:60:59])
        by faui03.informatik.uni-erlangen.de (Postfix) with ESMTP id 4784E241063;
        Sat,  5 Dec 2020 18:30:35 +0100 (CET)
Received: by cip4d0.informatik.uni-erlangen.de (Postfix, from userid 68457)
        id 44CE8D8049E; Sat,  5 Dec 2020 18:30:35 +0100 (CET)
From:   Stefan Eschenbacher <stefan.eschenbacher@fau.de>
To:     "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>
Cc:     Stefan Eschenbacher <stefan.eschenbacher@fau.de>,
        linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kernel@i4.cs.fau.de, Max Stolze <max.stolze@fau.de>
Subject: [PATCH 3/3] drivers/hv: add default number of vmbus channels to Kconfig
Date:   Sat,  5 Dec 2020 18:30:34 +0100
Message-Id: <20201205173034.2695-1-stefan.eschenbacher@fau.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201205172650.2290-1-stefan.eschenbacher@fau.de>
References: <20201205172650.2290-1-stefan.eschenbacher@fau.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

The default number of vmbus channels (macro
MAX_NUM_CHANNELS_SUPPORTED_DEFAULT) is made configurable through the new
Kconfig option HYPERV_VMBUS_DEFAULT_CHANNELS.

Signed-off-by: Stefan Eschenbacher <stefan.eschenbacher@fau.de>
Co-developed-by: Max Stolze <max.stolze@fau.de>
Signed-off-by: Max Stolze <max.stolze@fau.de>
---
 drivers/hv/Kconfig        | 13 +++++++++++++
 drivers/hv/hyperv_vmbus.h |  2 +-
 2 files changed, 14 insertions(+), 1 deletion(-)

diff --git a/drivers/hv/Kconfig b/drivers/hv/Kconfig
index 79e5356a737a..40bee5b05ccd 100644
--- a/drivers/hv/Kconfig
+++ b/drivers/hv/Kconfig
@@ -26,4 +26,17 @@ config HYPERV_BALLOON
 	help
 	  Select this option to enable Hyper-V Balloon driver.
 
+config HYPERV_VMBUS_DEFAULT_CHANNELS
+	int "Default number of VMBus channels (as multiple of 32)"
+	range 0 512
+	default 8
+	depends on HYPERV
+	help
+	  Specify the default number of VMBus channels here as nth multiple of
+	  32. The value must be equal to or less than 512.
+	  The default is 8 meaning the number of channels is 8 * 32 = 256.
+	  A different value can be set when loading the hv_vmbus module by
+	  setting the parameter max_num_channels_supported directly to the
+	  number of channels and not as a multiple of 32.
+
 endmenu
diff --git a/drivers/hv/hyperv_vmbus.h b/drivers/hv/hyperv_vmbus.h
index 52dcfa1c17ef..47af2c76ce57 100644
--- a/drivers/hv/hyperv_vmbus.h
+++ b/drivers/hv/hyperv_vmbus.h
@@ -194,7 +194,7 @@ int hv_ringbuffer_read(struct vmbus_channel *channel,
 #define MAX_NUM_CHANNELS	((HV_HYP_PAGE_SIZE >> 1) << 3)
 
 /* The value here must be in multiple of 32 */
-#define MAX_NUM_CHANNELS_SUPPORTED_DEFAULT	256
+#define MAX_NUM_CHANNELS_SUPPORTED_DEFAULT	(CONFIG_HYPERV_VMBUS_DEFAULT_CHANNELS * 32)
 extern uint max_num_channels_supported;
 
 #define MAX_CHANNEL_RELIDS					\
-- 
2.20.1

