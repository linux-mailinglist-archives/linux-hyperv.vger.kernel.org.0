Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E7C206684F
	for <lists+linux-hyperv@lfdr.de>; Fri, 12 Jul 2019 10:14:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726074AbfGLIOt (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 12 Jul 2019 04:14:49 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:46384 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725877AbfGLIOt (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 12 Jul 2019 04:14:49 -0400
Received: by mail-pg1-f194.google.com with SMTP id i8so4176228pgm.13;
        Fri, 12 Jul 2019 01:14:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Clmkg1JPx1ezaTOs0dmOCyHheHWNM2GCNT/4o6eeDVA=;
        b=iPCnHNicT1zvtKwp+ySM1G7H+Sr20rnFvGgoQQxCJNutapxHyQLP/jspNhr0lv28Em
         ebTVVcgfuQRAt2SZtnrWMJ8AAqhKtw9cbqYGhYz5ngJjFxbA1IksBTJPtJx43Tv9KEPG
         KiqYBaF8nsDz+0HjmPOuZ2ZXrT0qcW30Q4rrwQvRYYvKCMdT6Ij6zc2so91+m53rYMWe
         Q7aUygF3ykxOxAtocOGDv3loILlT/G8ZROs4yBObAIF+IXiLwbYngBcyh6COUQ7F4Y/y
         btph2+T7C1ZiCVObo9fSjKR26cq3qpuUR7Oxt1zsNXfnzEbhYX3ihXRHaG7jMgheOzAY
         oj0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Clmkg1JPx1ezaTOs0dmOCyHheHWNM2GCNT/4o6eeDVA=;
        b=tsSxcFZv0tXBZBrsLCuzfW0KtYwzpAaNwf1dfCx7ytzen7JFBRzMJxe05NSZc7/dpH
         ea6l9W47k6J5CpYVH3Yeadm11Va2WoqNzWD5QekaKXG/IRPot8ZjO8u2/guW4jrM2deR
         ht8rtDKcAqG+9TBgu7bQe+PN7wiWsrf/5rke+7mTRXeBl/n0gdIHiC20uxNKYGdcHepP
         tR1vrNjG/V4qyVcpcdZFQI0zXHixWGL1ZDdVcLNZfpwm9swP/uKssP969tFRb2liOpBH
         htQWEyOzU3f5qc1UPh8P93YhUNeYXIMG+ACTRqDaDO4j75XxiOln4rsVYjZujpjniG7j
         E+VA==
X-Gm-Message-State: APjAAAVdGql2EfKVIkFYvOHIBI40hxIpsSlrxqMRLkCke9taPPnpxbni
        QuA837DxszGYHDAQPKA8k0ql1lqB/tpS/g==
X-Google-Smtp-Source: APXvYqz1oy271vQvAzwgaFZDg63g3q/1hTl6QD2Pf/WhzyXu6MoJv+dExcVrtQWw39hRVZEmB4z/Pg==
X-Received: by 2002:a63:c70d:: with SMTP id n13mr9181046pgg.171.1562919288295;
        Fri, 12 Jul 2019 01:14:48 -0700 (PDT)
Received: from maya190711 ([52.250.118.122])
        by smtp.gmail.com with ESMTPSA id u6sm7020841pjx.23.2019.07.12.01.14.48
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 12 Jul 2019 01:14:48 -0700 (PDT)
Date:   Fri, 12 Jul 2019 08:14:47 +0000
From:   Maya Nakamura <m.maya.nakamura@gmail.com>
To:     mikelley@microsoft.com, kys@microsoft.com, haiyangz@microsoft.com,
        sthemmin@microsoft.com, sashal@kernel.org
Cc:     x86@kernel.org, linux-hyperv@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 1/5] x86: hv: hyperv-tlfs.h: Create and use Hyper-V page
 definitions
Message-ID: <e95111629abf65d016e983f72494cbf110ce605f.1562916939.git.m.maya.nakamura@gmail.com>
References: <cover.1562916939.git.m.maya.nakamura@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1562916939.git.m.maya.nakamura@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Define HV_HYP_PAGE_SHIFT, HV_HYP_PAGE_SIZE, and HV_HYP_PAGE_MASK because
the Linux guest page size and hypervisor page size concepts are
different, even though they happen to be the same value on x86.

Also, replace PAGE_SIZE with HV_HYP_PAGE_SIZE.

Signed-off-by: Maya Nakamura <m.maya.nakamura@gmail.com>
Reviewed-by: Michael Kelley <mikelley@microsoft.com>
Reviewed-by: Vitaly Kuznetsov <vkuznets@redhat.com>
---
 arch/x86/include/asm/hyperv-tlfs.h | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/hyperv-tlfs.h b/arch/x86/include/asm/hyperv-tlfs.h
index af78cd72b8f3..7a2705694f5b 100644
--- a/arch/x86/include/asm/hyperv-tlfs.h
+++ b/arch/x86/include/asm/hyperv-tlfs.h
@@ -12,6 +12,16 @@
 #include <linux/types.h>
 #include <asm/page.h>
 
+/*
+ * While not explicitly listed in the TLFS, Hyper-V always runs with a page size
+ * of 4096. These definitions are used when communicating with Hyper-V using
+ * guest physical pages and guest physical page addresses, since the guest page
+ * size may not be 4096 on all architectures.
+ */
+#define HV_HYP_PAGE_SHIFT      12
+#define HV_HYP_PAGE_SIZE       BIT(HV_HYP_PAGE_SHIFT)
+#define HV_HYP_PAGE_MASK       (~(HV_HYP_PAGE_SIZE - 1))
+
 /*
  * The below CPUID leaves are present if VersionAndFeatures.HypervisorPresent
  * is set by CPUID(HvCpuIdFunctionVersionAndFeatures).
@@ -847,7 +857,7 @@ union hv_gpa_page_range {
  * count is equal with how many entries of union hv_gpa_page_range can
  * be populated into the input parameter page.
  */
-#define HV_MAX_FLUSH_REP_COUNT ((PAGE_SIZE - 2 * sizeof(u64)) /	\
+#define HV_MAX_FLUSH_REP_COUNT ((HV_HYP_PAGE_SIZE - 2 * sizeof(u64)) /	\
 				sizeof(union hv_gpa_page_range))
 
 struct hv_guest_mapping_flush_list {
-- 
2.17.1

