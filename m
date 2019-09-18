Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4CC09B6D2A
	for <lists+linux-hyperv@lfdr.de>; Wed, 18 Sep 2019 22:01:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389417AbfIRUBA (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 18 Sep 2019 16:01:00 -0400
Received: from mout.kundenserver.de ([212.227.126.135]:51893 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388697AbfIRUA7 (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 18 Sep 2019 16:00:59 -0400
Received: from threadripper.lan ([149.172.19.189]) by mrelayeu.kundenserver.de
 (mreue012 [212.227.15.129]) with ESMTPA (Nemesis) id
 1N4NHS-1i2OLD1Ppm-011TTy; Wed, 18 Sep 2019 22:00:53 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Sasha Levin <sashal@kernel.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, Dexuan Cui <decui@microsoft.com>,
        Michael Kelley <mikelley@microsoft.com>,
        linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] hv: vmbus: mark PM functions as __maybe_unused
Date:   Wed, 18 Sep 2019 22:00:42 +0200
Message-Id: <20190918200052.2261769-1-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:0Q0q64LtlR0+ruBCAru32aom+kL/oEc0mD+WK5wwvwLiINIQ/Hb
 4yD2T0bPSqtcvBxfkjR8Tb3sdvfzteqK1QKv9AIB/OcYn3mrizomStRga9sX0kh7iY8h3gK
 KZml/eNUssHKlDxbXOE/3cnUnYiuzyXou3N+npMdg8EQ5saKWpHXoD6Yu68f8T90ZrIxlvI
 +IoDD48TO7nhcpLP/VBAw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:gWTUSYGfCaI=:m8zc4EEontUFE1Dblk5uBL
 +domcl714lVeJRd1bkyRNumeoiifdx/ly5LlbN+G+QyNr8udkEXX8ioKB1Kv5PzEJQEb9XOWi
 yq1Y5QOiASc6KCC1D7aPPBsXdBHWcQWn03K7/dFnBCc+LnaSTcLephYCA/pXAkrddY42tx7Ih
 XiiX7QcaIvEj2j1cYHkfy2i93C9zEkfXQIcIpJar8/GAxY3MpwPWj2sd1HrI3Y3hXeSdfO1/O
 9khatrk3MI7usOcQksCF04FJ6EzOq/mjvll7p9CKI+rBtEcAoPamcLxLkjJoDBqyEipgZljgL
 uv3PgWa6KDk870g4nQPNM8I3cxq0+Lb/yz88wZnR2ub37lG2p7mo5yBkw/Cxd3Biv9LIOr8Da
 8+1HIJNfF14Ozh+QszzVpfw8dJ/NCaCMG4GRz0Vps1jDVpbkKGZz7b7K/7xJq6jHRZbBGZdh/
 w666CLz0vWrbY4k8v5Mu5uTRCS7NnodrewVL4REMtvXoeA2mkFQ89Zsj1E8aClwbWN+ZwhQFL
 rs8jBKlZ0TKRJm39ziFNVYR6ggUmjQdBNSHJm8WzHfcG/Z1z4KQp95JdWoKISYU4usdo5Xhwj
 9u5nhDPEoUypazgaSBkHZVbRBy0ByTqWwYb9hw9UkGh3chc/qAqG2XWhXRGQqmTlXBqknq3W+
 FPnRwjk0+7ulmoG7/blgRfQF5LwfcO0/aIiNtQChDEvcuOi9AwmNV9Z6YeuCdieP6r1WZT0o0
 LVUDGPYtQIOd6Y7t8VQWZ0RVChEjLLbpEdERI8/byFffcnoswEm9M6PbiXiIcn72e6cW1sJEA
 9bZIC2nSa/dQbjVtQXLJjb2e+w25UGG6Zd6jiK5oI0NuvVizF2vrddfujaiZimLnvLoYsV3Jk
 thj/Oku432vgLNCWrltg==
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

When CONFIG_PM is disabled, we get a couple of harmless warnings:

drivers/hv/vmbus_drv.c:918:12: error: unused function 'vmbus_suspend' [-Werror,-Wunused-function]
drivers/hv/vmbus_drv.c:937:12: error: unused function 'vmbus_resume' [-Werror,-Wunused-function]
drivers/hv/vmbus_drv.c:2128:12: error: unused function 'vmbus_bus_suspend' [-Werror,-Wunused-function]
drivers/hv/vmbus_drv.c:2208:12: error: unused function 'vmbus_bus_resume' [-Werror,-Wunused-function]

Mark these functions __maybe_unused to let gcc drop them silently.

Fixes: f53335e3289f ("Drivers: hv: vmbus: Suspend/resume the vmbus itself for hibernation")
Fixes: 271b2224d42f ("Drivers: hv: vmbus: Implement suspend/resume for VSC drivers for hibernation")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/hv/vmbus_drv.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/hv/vmbus_drv.c b/drivers/hv/vmbus_drv.c
index 391f0b225c9a..2542eb1f872b 100644
--- a/drivers/hv/vmbus_drv.c
+++ b/drivers/hv/vmbus_drv.c
@@ -915,7 +915,7 @@ static void vmbus_shutdown(struct device *child_device)
 /*
  * vmbus_suspend - Suspend a vmbus device
  */
-static int vmbus_suspend(struct device *child_device)
+static int __maybe_unused vmbus_suspend(struct device *child_device)
 {
 	struct hv_driver *drv;
 	struct hv_device *dev = device_to_hv_device(child_device);
@@ -934,7 +934,7 @@ static int vmbus_suspend(struct device *child_device)
 /*
  * vmbus_resume - Resume a vmbus device
  */
-static int vmbus_resume(struct device *child_device)
+static int __maybe_unused vmbus_resume(struct device *child_device)
 {
 	struct hv_driver *drv;
 	struct hv_device *dev = device_to_hv_device(child_device);
@@ -2125,7 +2125,7 @@ static int vmbus_acpi_add(struct acpi_device *device)
 	return ret_val;
 }
 
-static int vmbus_bus_suspend(struct device *dev)
+static int __maybe_unused vmbus_bus_suspend(struct device *dev)
 {
 	struct vmbus_channel *channel, *sc;
 	unsigned long flags;
@@ -2205,7 +2205,7 @@ static int vmbus_bus_suspend(struct device *dev)
 	return 0;
 }
 
-static int vmbus_bus_resume(struct device *dev)
+static int __maybe_unused vmbus_bus_resume(struct device *dev)
 {
 	struct vmbus_channel_msginfo *msginfo;
 	size_t msgsize;
-- 
2.20.0

