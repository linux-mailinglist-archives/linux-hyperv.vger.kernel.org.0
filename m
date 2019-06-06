Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D702636E06
	for <lists+linux-hyperv@lfdr.de>; Thu,  6 Jun 2019 10:03:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726223AbfFFIDK (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 6 Jun 2019 04:03:10 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:40144 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726157AbfFFIDK (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 6 Jun 2019 04:03:10 -0400
Received: by mail-pf1-f194.google.com with SMTP id u17so1009155pfn.7;
        Thu, 06 Jun 2019 01:03:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=X+5omg05moGUnjvkNUDj9Btx23ZMSVNZ5vRwilYMMMk=;
        b=urtLIIiM4dS/SYQwVI9wQ9V4pSgfsvjnoe6/bX4wDa2norsn1R2D4hpDPqZrg5HxIJ
         ErcVeSXJWr6LzbDzeshcwkHWkmR750fVFeTfk789u/uJ6k7C9anP0ZRAGJSo+4/k1Yen
         UyckRxNAReyjVqVHbaV0nJw/NSVvE36305SKjCY06mFhMYqYtXIzTX81dR4sJSp2eS1/
         x/WfIKg9H0MNcjXYlmgCoUZIlakfXhYNKMTqGYfIzlB6y0lSyKbhUMu7mRAulBmXhpw3
         z9rhQu2KQdXj/AWzEgAYz3q/0X/At7fXhljFuuMR8DqncmmuNlTrwfHCQIKl6gCYS/5k
         cnjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=X+5omg05moGUnjvkNUDj9Btx23ZMSVNZ5vRwilYMMMk=;
        b=DlK4y2eQgEjQ/MN4/xfKfotcS21R6GSHYEWYw0eSnkWKTmzSmZk5C3wnEg6i0PTYkB
         Ld2iXmPzMH1mccxYRhhKn68VtQw9xkt7G1tMZWWBqf+RDRkpeUPUwchl8OXMipGcNgZL
         CwD/kcoUQNyvhNH9FMt8W/H2DBItpcfTazFp0KmKD90F1aKWVwt4oDx53Ln3xz7eeI90
         iJ+WiEPit9hi53sAcwbhrlhMEFgs8hxCg1qr6T9hFp+ubZRad+xq9w06XgCY+PgtlpIj
         Z9rQ9K0rruXKvVONGCuSfKQazMbqnKGiQXcbfkpvLtXguoGwIlsh9LbOsHlXiQ/jxHsT
         dmBw==
X-Gm-Message-State: APjAAAWPcDJiTMfvh5WBVKwqUJxsDpQovNLhtzEN/eV+oKsDxbqB++dZ
        /pjsA1cmdcYny2fAYlZfSXTlpk8rQgA=
X-Google-Smtp-Source: APXvYqxziP1v2PbMyUtQ+mBSMis1QKL3RVW3cJVbZhDUi+1NO/xQ/XpXiv1dTvGTg9haWKI/sgUsVQ==
X-Received: by 2002:a17:90a:cb12:: with SMTP id z18mr20415578pjt.82.1559808189181;
        Thu, 06 Jun 2019 01:03:09 -0700 (PDT)
Received: from maya190131 ([13.66.160.195])
        by smtp.gmail.com with ESMTPSA id n66sm1349991pfn.52.2019.06.06.01.03.09
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 06 Jun 2019 01:03:09 -0700 (PDT)
Date:   Thu, 6 Jun 2019 08:03:08 +0000
From:   Maya Nakamura <m.maya.nakamura@gmail.com>
To:     mikelley@microsoft.com, kys@microsoft.com, haiyangz@microsoft.com,
        sthemmin@microsoft.com, sashal@kernel.org
Cc:     x86@kernel.org, linux-hyperv@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/5] x86: hv: hyperv-tlfs.h: Create and use Hyper-V page
 definitions
Message-ID: <67be3e283c0f28326f9c31a64f399fe659ad5690.1559807514.git.m.maya.nakamura@gmail.com>
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

Define HV_HYP_PAGE_SHIFT, HV_HYP_PAGE_SIZE, and HV_HYP_PAGE_MASK because
the Linux guest page size and hypervisor page size concepts are
different, even though they happen to be the same value on x86.

Also, replace PAGE_SIZE with HV_HYP_PAGE_SIZE.

Signed-off-by: Maya Nakamura <m.maya.nakamura@gmail.com>
---
 arch/x86/include/asm/hyperv-tlfs.h | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/hyperv-tlfs.h b/arch/x86/include/asm/hyperv-tlfs.h
index cdf44aa9a501..44bd68aefd00 100644
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
+#define HV_HYP_PAGE_SHIFT	12
+#define HV_HYP_PAGE_SIZE	BIT(HV_HYP_PAGE_SHIFT)
+#define HV_HYP_PAGE_MASK	(~(HV_HYP_PAGE_SIZE - 1))
+
 /*
  * The below CPUID leaves are present if VersionAndFeatures.HypervisorPresent
  * is set by CPUID(HvCpuIdFunctionVersionAndFeatures).
@@ -841,7 +851,7 @@ union hv_gpa_page_range {
  * count is equal with how many entries of union hv_gpa_page_range can
  * be populated into the input parameter page.
  */
-#define HV_MAX_FLUSH_REP_COUNT ((PAGE_SIZE - 2 * sizeof(u64)) /	\
+#define HV_MAX_FLUSH_REP_COUNT ((HV_HYP_PAGE_SIZE - 2 * sizeof(u64)) /	\
 				sizeof(union hv_gpa_page_range))
 
 struct hv_guest_mapping_flush_list {
-- 
2.17.1

