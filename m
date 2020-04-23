Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C43F1B5CCE
	for <lists+linux-hyperv@lfdr.de>; Thu, 23 Apr 2020 15:45:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728633AbgDWNpJ (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 23 Apr 2020 09:45:09 -0400
Received: from mga05.intel.com ([192.55.52.43]:16342 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728133AbgDWNpJ (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 23 Apr 2020 09:45:09 -0400
IronPort-SDR: 2tNA66LRAGI7Mi1Y0UnwHWDcZ1nOA3pkD9W34S4bnqRMp9/rZJ2qmxUeDkW4e19Fv4xsu4G+KI
 sJVx765fvvZw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Apr 2020 06:45:08 -0700
IronPort-SDR: OQUOLBeweipwjMgX3aMuMzv9xQ5uuwezHSHVijuHYjae2uzeDTGoVEodujrkaWvEVlWfeTaqY1
 yjIimyfT2MvQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,307,1583222400"; 
   d="scan'208";a="259425469"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga006.jf.intel.com with ESMTP; 23 Apr 2020 06:45:07 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 21C1711D; Thu, 23 Apr 2020 16:45:06 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, linux-hyperv@vger.kernel.org
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 2/4] hyper-v: Supply GUID pointer to printf() like functions
Date:   Thu, 23 Apr 2020 16:45:03 +0300
Message-Id: <20200423134505.78221-2-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.26.1
In-Reply-To: <20200423134505.78221-1-andriy.shevchenko@linux.intel.com>
References: <20200423134505.78221-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Drop dereference when printing the GUID with printf() like functions.
This allows to hide the uuid_t internals.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/hv/vmbus_drv.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/hv/vmbus_drv.c b/drivers/hv/vmbus_drv.c
index 84c9985d83918c..3d03a26216b7b8 100644
--- a/drivers/hv/vmbus_drv.c
+++ b/drivers/hv/vmbus_drv.c
@@ -201,7 +201,7 @@ static ssize_t class_id_show(struct device *dev,
 	if (!hv_dev->channel)
 		return -ENODEV;
 	return sprintf(buf, "{%pUl}\n",
-		       hv_dev->channel->offermsg.offer.if_type.b);
+		       &hv_dev->channel->offermsg.offer.if_type);
 }
 static DEVICE_ATTR_RO(class_id);
 
@@ -213,7 +213,7 @@ static ssize_t device_id_show(struct device *dev,
 	if (!hv_dev->channel)
 		return -ENODEV;
 	return sprintf(buf, "{%pUl}\n",
-		       hv_dev->channel->offermsg.offer.if_instance.b);
+		       &hv_dev->channel->offermsg.offer.if_instance);
 }
 static DEVICE_ATTR_RO(device_id);
 
@@ -2005,7 +2005,7 @@ int vmbus_device_register(struct hv_device *child_device_obj)
 	int ret;
 
 	dev_set_name(&child_device_obj->device, "%pUl",
-		     child_device_obj->channel->offermsg.offer.if_instance.b);
+		     &child_device_obj->channel->offermsg.offer.if_instance);
 
 	child_device_obj->device.bus = &hv_bus;
 	child_device_obj->device.parent = &hv_acpi_dev->dev;
-- 
2.26.1

