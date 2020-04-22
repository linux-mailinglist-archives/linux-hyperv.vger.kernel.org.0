Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 33A1F1B461C
	for <lists+linux-hyperv@lfdr.de>; Wed, 22 Apr 2020 15:18:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725810AbgDVNSV (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 22 Apr 2020 09:18:21 -0400
Received: from mga09.intel.com ([134.134.136.24]:24951 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726030AbgDVNSV (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 22 Apr 2020 09:18:21 -0400
IronPort-SDR: /pT+oIyP7P6yzVTypgobrjNlIckpma6XuFx8XMiOJ5pgTk97oq0e0UDdeI5im37RygBsf3L7/a
 /ICxmc9lw+LA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2020 06:18:21 -0700
IronPort-SDR: n+RUR7eSXAHV66t+lNVDa7M/e20jDbkohOoEhd7vc1tVLLcUo01D9R+rHc1yMw5NbTnaBggCMM
 7Vzbh9HLnS9g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,414,1580803200"; 
   d="scan'208";a="429908486"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga005.jf.intel.com with ESMTP; 22 Apr 2020 06:18:19 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 96C4D58F; Wed, 22 Apr 2020 16:18:18 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, linux-hyperv@vger.kernel.org
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1] hyper-v: Remove internal types from UAPI header
Date:   Wed, 22 Apr 2020 16:18:18 +0300
Message-Id: <20200422131818.23088-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.26.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

The uuid_le mistakenly comes to be an UAPI type. Since it's luckily not used by
Hyper-V APIs, we may replace with POD types, i.e. __u8 array.

Note, previously shared uuid_be had been removed from UAPI few releases ago.
This is a continuation of that process towards removing uuid_le one.

Note, there is no ABI change!

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 include/uapi/linux/hyperv.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/uapi/linux/hyperv.h b/include/uapi/linux/hyperv.h
index 991b2b7ada7a3..8f24404ad04f1 100644
--- a/include/uapi/linux/hyperv.h
+++ b/include/uapi/linux/hyperv.h
@@ -119,8 +119,8 @@ enum hv_fcopy_op {
 
 struct hv_fcopy_hdr {
 	__u32 operation;
-	uuid_le service_id0; /* currently unused */
-	uuid_le service_id1; /* currently unused */
+	__u8 service_id0[16]; /* currently unused */
+	__u8 service_id1[16]; /* currently unused */
 } __attribute__((packed));
 
 #define OVER_WRITE	0x1
-- 
2.26.1

