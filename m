Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A306C1B45B1
	for <lists+linux-hyperv@lfdr.de>; Wed, 22 Apr 2020 14:59:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727786AbgDVM7m (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 22 Apr 2020 08:59:42 -0400
Received: from mga07.intel.com ([134.134.136.100]:35916 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727782AbgDVM7m (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 22 Apr 2020 08:59:42 -0400
IronPort-SDR: irkY25Kw1sLHHGdeRXsI6GjkpRB1FlzZvTLGc4Sq4B0W/y2+dyZOMV24QyjAxUZU3adj3JcFuR
 KDOJPhr6M3Zg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2020 05:59:41 -0700
IronPort-SDR: jlfVlNmnULsQuyLfa7Ip2bm99B65CAsK/ZqY/5xZqQFBXyvAtwiPRj5cABKczPVqF1qRu2gN+5
 U103P1jYxDUQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,414,1580803200"; 
   d="scan'208";a="291934739"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga008.jf.intel.com with ESMTP; 22 Apr 2020 05:59:39 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id BB61E58F; Wed, 22 Apr 2020 15:59:38 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, linux-hyperv@vger.kernel.org
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1] hyper-v: Use UUID API for exporting the GUID
Date:   Wed, 22 Apr 2020 15:59:37 +0300
Message-Id: <20200422125937.38355-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.26.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

There is export_guid() function which exports guid_t to the u8 array.
Use it instead of open coding variant.

This allows to hide the uuid_t internals.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/hv/hv_trace.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/hv/hv_trace.h b/drivers/hv/hv_trace.h
index a43bc76c2d5d0..579d19bdc0981 100644
--- a/drivers/hv/hv_trace.h
+++ b/drivers/hv/hv_trace.h
@@ -286,8 +286,8 @@ TRACE_EVENT(vmbus_send_tl_connect_request,
 		    __field(int, ret)
 		    ),
 	    TP_fast_assign(
-		    memcpy(__entry->guest_id, &msg->guest_endpoint_id.b, 16);
-		    memcpy(__entry->host_id, &msg->host_service_id.b, 16);
+		    export_guid(__entry->guest_id, &msg->guest_endpoint_id);
+		    export_guid(__entry->host_id, &msg->host_service_id);
 		    __entry->ret = ret;
 		    ),
 	    TP_printk("sending guest_endpoint_id %pUl, host_service_id %pUl, "
-- 
2.26.1

