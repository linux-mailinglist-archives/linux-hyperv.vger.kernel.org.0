Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C5925B28FA
	for <lists+linux-hyperv@lfdr.de>; Fri,  9 Sep 2022 00:06:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229572AbiIHWGK (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 8 Sep 2022 18:06:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229549AbiIHWGJ (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 8 Sep 2022 18:06:09 -0400
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E0C4EB81F6;
        Thu,  8 Sep 2022 15:06:05 -0700 (PDT)
Received: from linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net (linux.microsoft.com [13.77.154.182])
        by linux.microsoft.com (Postfix) with ESMTPSA id 8FC45204A5AD;
        Thu,  8 Sep 2022 15:06:05 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 8FC45204A5AD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1662674765;
        bh=0IklZrohBoUgnAuhKbvOAkhT6zLzbap5UEa4RgA+F/w=;
        h=From:To:Subject:Date:From;
        b=MZWIlwSc+8A14CQFzY+ccAFtsiT73bXIW528iVOQbMQ89q914u/kIk/6QXeH3kHPX
         y30zze+rLi2jUJHKM6+eoOw7fcg/GEQ0AEp+97X6yoRv2w4A3LSaB9Ote6J5YiT5AY
         AIpqtH+woiR2fqO6ch0uDQ19ODjlm7tWPRxn3roY=
From:   eahariha@linux.microsoft.com
To:     "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
        linux-hyperv@vger.kernel.org (open list:Hyper-V/Azure CORE AND DRIVERS),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 1/3] hv: Use PCI_VENDOR_ID_MICROSOFT for better discoverability
Date:   Thu,  8 Sep 2022 15:05:55 -0700
Message-Id: <1662674757-31945-1-git-send-email-eahariha@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
X-Spam-Status: No, score=-19.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

From: Easwar Hariharan <easwar.hariharan@microsoft.com>

Signed-off-by: Easwar Hariharan <easwar.hariharan@microsoft.com>
---
 drivers/hv/vmbus_drv.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/hv/vmbus_drv.c b/drivers/hv/vmbus_drv.c
index 23c680d..8d90855 100644
--- a/drivers/hv/vmbus_drv.c
+++ b/drivers/hv/vmbus_drv.c
@@ -38,6 +38,8 @@
 #include <clocksource/hyperv_timer.h>
 #include "hyperv_vmbus.h"
 
+#define PCI_VENDOR_ID_MICROSOFT 0x1414
+
 struct vmbus_dynid {
 	struct list_head node;
 	struct hv_vmbus_device_id id;
@@ -2051,7 +2053,7 @@ struct hv_device *vmbus_device_create(const guid_t *type,
 	child_device_obj->channel = channel;
 	guid_copy(&child_device_obj->dev_type, type);
 	guid_copy(&child_device_obj->dev_instance, instance);
-	child_device_obj->vendor_id = 0x1414; /* MSFT vendor ID */
+	child_device_obj->vendor_id = PCI_VENDOR_ID_MICROSOFT;
 
 	return child_device_obj;
 }
-- 
1.8.3.1

