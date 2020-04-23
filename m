Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 622C41B5CD1
	for <lists+linux-hyperv@lfdr.de>; Thu, 23 Apr 2020 15:45:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728013AbgDWNpK (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 23 Apr 2020 09:45:10 -0400
Received: from mga12.intel.com ([192.55.52.136]:40803 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728536AbgDWNpK (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 23 Apr 2020 09:45:10 -0400
IronPort-SDR: l/p66awttP3X0A/pGPXBPhovkT64yCxnVKPcdi0KRaQPQSNDoxibM5VXBr3eJ8E7fzSALUdiT2
 EotqTWV35vqQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Apr 2020 06:45:09 -0700
IronPort-SDR: mxc9vp667t9NUiWSagUjNijinRyupYyi+EImcmRPYxoY2noqEBd5CbvCYBagQ+SvdKTQOq9+tY
 4Gsi3iX3nHoQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,307,1583222400"; 
   d="scan'208";a="430324471"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga005.jf.intel.com with ESMTP; 23 Apr 2020 06:45:07 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 2B840578; Thu, 23 Apr 2020 16:45:06 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, linux-hyperv@vger.kernel.org
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 3/4] hyper-v: Replace open-coded variant of %*phN specifier
Date:   Thu, 23 Apr 2020 16:45:04 +0300
Message-Id: <20200423134505.78221-3-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.26.1
In-Reply-To: <20200423134505.78221-1-andriy.shevchenko@linux.intel.com>
References: <20200423134505.78221-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

printf() like functions in the kernel have extensions, such as
%*phN to dump small pieces of memory as hex values.

Replace print_alias_name() with the direct use of %*phN.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/hv/vmbus_drv.c | 19 +++----------------
 1 file changed, 3 insertions(+), 16 deletions(-)

diff --git a/drivers/hv/vmbus_drv.c b/drivers/hv/vmbus_drv.c
index 3d03a26216b7b8..8651c58e892230 100644
--- a/drivers/hv/vmbus_drv.c
+++ b/drivers/hv/vmbus_drv.c
@@ -117,14 +117,6 @@ static int vmbus_exists(void)
 	return 0;
 }
 
-#define VMBUS_ALIAS_LEN ((sizeof((struct hv_vmbus_device_id *)0)->guid) * 2)
-static void print_alias_name(struct hv_device *hv_dev, char *alias_name)
-{
-	int i;
-	for (i = 0; i < VMBUS_ALIAS_LEN; i += 2)
-		sprintf(&alias_name[i], "%02x", hv_dev->dev_type.b[i/2]);
-}
-
 static u8 channel_monitor_group(const struct vmbus_channel *channel)
 {
 	return (u8)channel->offermsg.monitorid / 32;
@@ -221,10 +213,8 @@ static ssize_t modalias_show(struct device *dev,
 			     struct device_attribute *dev_attr, char *buf)
 {
 	struct hv_device *hv_dev = device_to_hv_device(dev);
-	char alias_name[VMBUS_ALIAS_LEN + 1];
 
-	print_alias_name(hv_dev, alias_name);
-	return sprintf(buf, "vmbus:%s\n", alias_name);
+	return sprintf(buf, "vmbus:%*phN\n", UUID_SIZE, &hv_dev->dev_type);
 }
 static DEVICE_ATTR_RO(modalias);
 
@@ -693,12 +683,9 @@ __ATTRIBUTE_GROUPS(vmbus_dev);
 static int vmbus_uevent(struct device *device, struct kobj_uevent_env *env)
 {
 	struct hv_device *dev = device_to_hv_device(device);
-	int ret;
-	char alias_name[VMBUS_ALIAS_LEN + 1];
+	const char *format = "MODALIAS=vmbus:%*phN";
 
-	print_alias_name(dev, alias_name);
-	ret = add_uevent_var(env, "MODALIAS=vmbus:%s", alias_name);
-	return ret;
+	return add_uevent_var(env, format, UUID_SIZE, &dev->dev_type);
 }
 
 static const struct hv_vmbus_device_id *
-- 
2.26.1

