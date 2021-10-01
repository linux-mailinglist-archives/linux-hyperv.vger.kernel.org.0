Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4419041EEF4
	for <lists+linux-hyperv@lfdr.de>; Fri,  1 Oct 2021 15:56:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231699AbhJAN6K (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 1 Oct 2021 09:58:10 -0400
Received: from mga14.intel.com ([192.55.52.115]:57024 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231513AbhJAN6K (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 1 Oct 2021 09:58:10 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10123"; a="225096542"
X-IronPort-AV: E=Sophos;i="5.85,339,1624345200"; 
   d="scan'208";a="225096542"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Oct 2021 06:56:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,339,1624345200"; 
   d="scan'208";a="556318993"
Received: from black.fi.intel.com ([10.237.72.28])
  by FMSMGA003.fm.intel.com with ESMTP; 01 Oct 2021 06:56:00 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 869121AD; Fri,  1 Oct 2021 16:56:06 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH v1 1/1] hyper-v: Replace uuid.h with types.h
Date:   Fri,  1 Oct 2021 16:55:44 +0300
Message-Id: <20211001135544.1823-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

There is no user of anything in uuid.h in the hyperv.h. Replace it with
more appropriate types.h.

Fixes: f081bbb3fd03 ("hyper-v: Remove internal types from UAPI header")
Reported-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 include/uapi/linux/hyperv.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/uapi/linux/hyperv.h b/include/uapi/linux/hyperv.h
index 6135d92e0d47..daf82a230c0e 100644
--- a/include/uapi/linux/hyperv.h
+++ b/include/uapi/linux/hyperv.h
@@ -26,7 +26,7 @@
 #ifndef _UAPI_HYPERV_H
 #define _UAPI_HYPERV_H
 
-#include <linux/uuid.h>
+#include <linux/types.h>
 
 /*
  * Framework version for util services.
-- 
2.33.0

