Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 41CDE1B5CD0
	for <lists+linux-hyperv@lfdr.de>; Thu, 23 Apr 2020 15:45:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728622AbgDWNpK (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 23 Apr 2020 09:45:10 -0400
Received: from mga12.intel.com ([192.55.52.136]:40803 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728632AbgDWNpJ (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 23 Apr 2020 09:45:09 -0400
IronPort-SDR: q97AO57bf3sMLhypgtYtuCUfeFP5ThF1YubR5itwVUxnIWuB4XATkylQYbbgZk+qsKuyt3NemZ
 +FbPwlb5VWuQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Apr 2020 06:45:08 -0700
IronPort-SDR: bQqltvjo5uEHHkgON1vgqt9WAY65z8G8Cf/DL49tVBvi5sKEdbfQlRNDkhHEGOHFeR8lVfUb6/
 3SEbZdVFgKtg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,307,1583222400"; 
   d="scan'208";a="255989300"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga003.jf.intel.com with ESMTP; 23 Apr 2020 06:45:07 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 161EA402; Thu, 23 Apr 2020 16:45:05 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, linux-hyperv@vger.kernel.org
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 1/4] hyper-v: Use UUID API for exporting the GUID (part 2)
Date:   Thu, 23 Apr 2020 16:45:02 +0300
Message-Id: <20200423134505.78221-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.26.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

This is a follow up to the commit 1d3c9c075462
  ("hyper-v: Use UUID API for exporting the GUID")
which starts the conversion.

There is export_guid() function which exports guid_t to the u8 array.
Use it instead of open coding variant.

This allows to hide the uuid_t internals.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/hv/hv_trace.h | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/hv/hv_trace.h b/drivers/hv/hv_trace.h
index 579d19bdc0981b..6063bb21bb1371 100644
--- a/drivers/hv/hv_trace.h
+++ b/drivers/hv/hv_trace.h
@@ -44,10 +44,8 @@ TRACE_EVENT(vmbus_onoffer,
 			   __entry->monitorid = offer->monitorid;
 			   __entry->is_ddc_int = offer->is_dedicated_interrupt;
 			   __entry->connection_id = offer->connection_id;
-			   memcpy(__entry->if_type,
-				  &offer->offer.if_type.b, 16);
-			   memcpy(__entry->if_instance,
-				  &offer->offer.if_instance.b, 16);
+			   export_guid(__entry->if_type, &offer->offer.if_type);
+			   export_guid(__entry->if_instance, &offer->offer.if_instance);
 			   __entry->chn_flags = offer->offer.chn_flags;
 			   __entry->mmio_mb = offer->offer.mmio_megabytes;
 			   __entry->sub_idx = offer->offer.sub_channel_index;
-- 
2.26.1

