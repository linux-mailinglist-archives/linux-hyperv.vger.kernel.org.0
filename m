Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7939136E1D
	for <lists+linux-hyperv@lfdr.de>; Thu,  6 Jun 2019 10:07:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726605AbfFFIG6 (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 6 Jun 2019 04:06:58 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:43802 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726140AbfFFIG6 (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 6 Jun 2019 04:06:58 -0400
Received: by mail-pl1-f193.google.com with SMTP id cl9so598027plb.10;
        Thu, 06 Jun 2019 01:06:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=B7PI3lRvcRn5YsjKZaM8VAfEA9LM5Mb34wcf1QlCT9E=;
        b=a1mUz4yagvLdR6fk3zHnxeQ82AYyd7LEyimBOtJBFKZhzwuQ4gGCI+hx1ThK/qvBcz
         HiRhWQkwAGKFW0BuVJGuaBr78/DmvEmg2kwByCh+T5xDU5I0uq+P8dvbjVggUsLjgF7+
         61p+kFIcG7Xr3s0Ty/+VdpIXyTaV8V5k+tURvtW4qqjtui3GnWWBgfFIKaJ9JCA7Scyi
         00NhOdqkriK4Yf2G6O2nYiPagoGkxVvzUNlEGiD4XTW9ImYNL9rknP5cTjd3nhnI8ZDZ
         3SN1ssBC/q7dNTxGD9vDmQlo0z84Vpqug/ABbD/hZ6XnAqaiAVGoxG48I06OL1rCj2oN
         aRww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=B7PI3lRvcRn5YsjKZaM8VAfEA9LM5Mb34wcf1QlCT9E=;
        b=JkDDahf0p7eOHoAwm9iDPHvwl+jUHXwXtAMbJUf51rJhN9IOLLyztf5utk2GIL9oLE
         ROo0dhBKO0MaNUnh/DEj2wivTIMHK6c4pOXLYNKdKVsPBIcOf2bxkdIfxaRL66sMhVNy
         2xeNi6BRe8sbs0ZbqdTRpCyQbsu4ZRQnVXtWxpbxdIb0urnHjod0Ed5aovy3N0RFqvYY
         jSXX4VzXWiyJapqxh6wausOtZeuLFIvRtDjgnfwbWD90vKC/3uX6R4o6p3C0ZG76tqTw
         6RYWJfkcLOeghDUCiBr2nEcfNedsnj4Y7WAsdLWUWYKENGYWJCVNqauwKUdFhCa2HMQM
         kbsw==
X-Gm-Message-State: APjAAAW9U19dMGeu6LaKJjiq24Y2/0gz6JVYJsQqnKJeiYo5r4X5opmY
        5cTmtYNn7PdiHOrC0M8RaLEnmd+3jbo=
X-Google-Smtp-Source: APXvYqwfsilz/VH+eooS8YRH2YGQydhBg/MSHihk39URW/f21Zb3zXkXFfFzqewMBfL0KcpP+Pltlg==
X-Received: by 2002:a17:902:b093:: with SMTP id p19mr13696085plr.174.1559808417954;
        Thu, 06 Jun 2019 01:06:57 -0700 (PDT)
Received: from maya190131 ([13.66.160.195])
        by smtp.gmail.com with ESMTPSA id 128sm1164580pff.16.2019.06.06.01.06.57
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 06 Jun 2019 01:06:57 -0700 (PDT)
Date:   Thu, 6 Jun 2019 08:06:57 +0000
From:   Maya Nakamura <m.maya.nakamura@gmail.com>
To:     mikelley@microsoft.com, kys@microsoft.com, haiyangz@microsoft.com,
        sthemmin@microsoft.com, sashal@kernel.org
Cc:     x86@kernel.org, linux-hyperv@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/5] hv: vmbus: Replace page definition with Hyper-V
 specific one
Message-ID: <210c56ddb1dafc20ba289e6be9165efe8a5e818c.1559807514.git.m.maya.nakamura@gmail.com>
References: <cover.1559807514.git.m.maya.nakamura@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1559807514.git.m.maya.nakamura@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Replace PAGE_SIZE with HV_HYP_PAGE_SIZE because the guest page size may
not be 4096 on all architectures and Hyper-V always runs with a page
size of 4096.

Signed-off-by: Maya Nakamura <m.maya.nakamura@gmail.com>
---
 drivers/hv/hyperv_vmbus.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/hv/hyperv_vmbus.h b/drivers/hv/hyperv_vmbus.h
index e5467b821f41..5489b061d261 100644
--- a/drivers/hv/hyperv_vmbus.h
+++ b/drivers/hv/hyperv_vmbus.h
@@ -208,11 +208,11 @@ int hv_ringbuffer_read(struct vmbus_channel *channel,
 		       u64 *requestid, bool raw);
 
 /*
- * Maximum channels is determined by the size of the interrupt page
- * which is PAGE_SIZE. 1/2 of PAGE_SIZE is for send endpoint interrupt
- * and the other is receive endpoint interrupt
+ * Maximum channels, 16348, is determined by the size of the interrupt page,
+ * which is HV_HYP_PAGE_SIZE. 1/2 of HV_HYP_PAGE_SIZE is to send endpoint
+ * interrupt, and the other is to receive endpoint interrupt.
  */
-#define MAX_NUM_CHANNELS	((PAGE_SIZE >> 1) << 3)	/* 16348 channels */
+#define MAX_NUM_CHANNELS	((HV_HYP_PAGE_SIZE >> 1) << 3)
 
 /* The value here must be in multiple of 32 */
 /* TODO: Need to make this configurable */
-- 
2.17.1

