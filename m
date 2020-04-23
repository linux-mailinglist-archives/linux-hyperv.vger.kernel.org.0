Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E3C1D1B5CCF
	for <lists+linux-hyperv@lfdr.de>; Thu, 23 Apr 2020 15:45:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728133AbgDWNpJ (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 23 Apr 2020 09:45:09 -0400
Received: from mga14.intel.com ([192.55.52.115]:36004 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728622AbgDWNpJ (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 23 Apr 2020 09:45:09 -0400
IronPort-SDR: joA4rzifArrbkbRow2NHW8D9FgMQHRmevTaSbXw5BeQnY/GquSi4JkAcOglIRzytyhe545ynQb
 dONgwzVfTXSQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Apr 2020 06:45:08 -0700
IronPort-SDR: axVryDJT3i7AsNPUwS0ncQ1qG14j2M/wuWcN2FdQyXzULgn+Phbg4X/ht0/SQ/QlXN4SRe07Tt
 xGdAsnyXPPZg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,307,1583222400"; 
   d="scan'208";a="291183380"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga002.fm.intel.com with ESMTP; 23 Apr 2020 06:45:07 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 3A7F06D8; Thu, 23 Apr 2020 16:45:06 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, linux-hyperv@vger.kernel.org
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 4/4] hyper-v: Switch to use UUID types directly
Date:   Thu, 23 Apr 2020 16:45:05 +0300
Message-Id: <20200423134505.78221-4-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.26.1
In-Reply-To: <20200423134505.78221-1-andriy.shevchenko@linux.intel.com>
References: <20200423134505.78221-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

uuid_le is an alias for guid_t and is going to be removed in the future.
Replace it with original type.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 include/linux/mod_devicetable.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/mod_devicetable.h b/include/linux/mod_devicetable.h
index 4b3d0a4945dfc6..c97195fe865852 100644
--- a/include/linux/mod_devicetable.h
+++ b/include/linux/mod_devicetable.h
@@ -434,7 +434,7 @@ struct virtio_device_id {
  * For Hyper-V devices we use the device guid as the id.
  */
 struct hv_vmbus_device_id {
-	uuid_le guid;
+	guid_t guid;
 	kernel_ulong_t driver_data;	/* Data private to the driver */
 };
 
-- 
2.26.1

