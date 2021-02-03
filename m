Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 518A430DDA3
	for <lists+linux-hyperv@lfdr.de>; Wed,  3 Feb 2021 16:08:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234181AbhBCPHf (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 3 Feb 2021 10:07:35 -0500
Received: from mail-wm1-f47.google.com ([209.85.128.47]:50617 "EHLO
        mail-wm1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233963AbhBCPF1 (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 3 Feb 2021 10:05:27 -0500
Received: by mail-wm1-f47.google.com with SMTP id 190so5873794wmz.0;
        Wed, 03 Feb 2021 07:05:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8kWAe/AAJgE120Gfy7H8tp4OHgjkczeJ8rjLnUABL/s=;
        b=gmf2eLMsSgb/4rLFT1OkbxI1e8yxatjGpqIppdhdYMTIKV8LrK3dMu740tfF5XBwzg
         H04SsetqBB338BBjOreAeKmxRb+HC6VtNgCtDaxiIs72IR6xdzWJK+JdG5hxz+wiA5j4
         RldJEXYUC8cPzlMoqjSMWKUf5mX8S5nSSWBne3MK1RiS0+Sm2qeH4FVdj5lGZbv0TKrn
         ZWt1cr5qiqW9jfmyRoVZVMUWoSjCupUZyzwmmxY3plEcCtVF5GHZ2PDGFQVqMTz6v55Q
         k0wYsujmGIHzjnoGyaO8c4XSPDHJy6NWRlDyaQfDANyxM+uCT1NzRqwkiuNvJUdNIn9w
         T2lQ==
X-Gm-Message-State: AOAM531Pn1HYVuYFnuSZvW05e1suxMIkdjxvSKjfWjzhGPqLlPOglbCA
        7AjacAZUa3iKXldrExrFuY80biU9eIE=
X-Google-Smtp-Source: ABdhPJyMRBsPCHu+Zt8iglrg5GARaCWJxkAQv3nqlaGDyjWlXIpZTHYZWAeJhgrMtoRA/e8gkybzpA==
X-Received: by 2002:a7b:c8ca:: with SMTP id f10mr3195825wml.101.1612364685255;
        Wed, 03 Feb 2021 07:04:45 -0800 (PST)
Received: from liuwe-devbox-debian-v2.j3c5onc20sse1dnehy4noqpfcg.zx.internal.cloudapp.net ([51.145.34.42])
        by smtp.gmail.com with ESMTPSA id r17sm4051704wro.46.2021.02.03.07.04.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Feb 2021 07:04:44 -0800 (PST)
From:   Wei Liu <wei.liu@kernel.org>
To:     Linux on Hyper-V List <linux-hyperv@vger.kernel.org>
Cc:     virtualization@lists.linux-foundation.org,
        Linux Kernel List <linux-kernel@vger.kernel.org>,
        Michael Kelley <mikelley@microsoft.com>,
        Vineeth Pillai <viremana@linux.microsoft.com>,
        Sunil Muthuswamy <sunilmut@microsoft.com>,
        Nuno Das Neves <nunodasneves@linux.microsoft.com>,
        pasha.tatashin@soleen.com, Wei Liu <wei.liu@kernel.org>,
        Lillian Grassin-Drake <ligrassi@microsoft.com>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org (maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)),
        "H. Peter Anvin" <hpa@zytor.com>
Subject: [PATCH v6 07/16] x86/hyperv: handling hypercall page setup for root
Date:   Wed,  3 Feb 2021 15:04:26 +0000
Message-Id: <20210203150435.27941-8-wei.liu@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210203150435.27941-1-wei.liu@kernel.org>
References: <20210203150435.27941-1-wei.liu@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

When Linux is running as the root partition, the hypercall page will
have already been setup by Hyper-V. Copy the content over to the
allocated page.

Add checks to hv_suspend & co to bail early because they are not
supported in this setup yet.

Signed-off-by: Lillian Grassin-Drake <ligrassi@microsoft.com>
Signed-off-by: Sunil Muthuswamy <sunilmut@microsoft.com>
Signed-off-by: Nuno Das Neves <nunodasneves@linux.microsoft.com>
Co-Developed-by: Lillian Grassin-Drake <ligrassi@microsoft.com>
Co-Developed-by: Sunil Muthuswamy <sunilmut@microsoft.com>
Co-Developed-by: Nuno Das Neves <nunodasneves@linux.microsoft.com>
Signed-off-by: Wei Liu <wei.liu@kernel.org>
Reviewed-by: Michael Kelley <mikelley@microsoft.com>
---
v3:
1. Use HV_HYP_PAGE_SIZE.
2. Add checks to hv_suspend & co.
---
 arch/x86/hyperv/hv_init.c | 37 ++++++++++++++++++++++++++++++++++---
 1 file changed, 34 insertions(+), 3 deletions(-)

diff --git a/arch/x86/hyperv/hv_init.c b/arch/x86/hyperv/hv_init.c
index 5b90a7290177..11c5997691f4 100644
--- a/arch/x86/hyperv/hv_init.c
+++ b/arch/x86/hyperv/hv_init.c
@@ -25,6 +25,7 @@
 #include <linux/cpuhotplug.h>
 #include <linux/syscore_ops.h>
 #include <clocksource/hyperv_timer.h>
+#include <linux/highmem.h>
 
 u64 hv_current_partition_id = ~0ull;
 EXPORT_SYMBOL_GPL(hv_current_partition_id);
@@ -283,6 +284,9 @@ static int hv_suspend(void)
 	union hv_x64_msr_hypercall_contents hypercall_msr;
 	int ret;
 
+	if (hv_root_partition)
+		return -EPERM;
+
 	/*
 	 * Reset the hypercall page as it is going to be invalidated
 	 * accross hibernation. Setting hv_hypercall_pg to NULL ensures
@@ -432,8 +436,35 @@ void __init hyperv_init(void)
 
 	rdmsrl(HV_X64_MSR_HYPERCALL, hypercall_msr.as_uint64);
 	hypercall_msr.enable = 1;
-	hypercall_msr.guest_physical_address = vmalloc_to_pfn(hv_hypercall_pg);
-	wrmsrl(HV_X64_MSR_HYPERCALL, hypercall_msr.as_uint64);
+
+	if (hv_root_partition) {
+		struct page *pg;
+		void *src, *dst;
+
+		/*
+		 * For the root partition, the hypervisor will set up its
+		 * hypercall page. The hypervisor guarantees it will not show
+		 * up in the root's address space. The root can't change the
+		 * location of the hypercall page.
+		 *
+		 * Order is important here. We must enable the hypercall page
+		 * so it is populated with code, then copy the code to an
+		 * executable page.
+		 */
+		wrmsrl(HV_X64_MSR_HYPERCALL, hypercall_msr.as_uint64);
+
+		pg = vmalloc_to_page(hv_hypercall_pg);
+		dst = kmap(pg);
+		src = memremap(hypercall_msr.guest_physical_address << PAGE_SHIFT, PAGE_SIZE,
+				MEMREMAP_WB);
+		BUG_ON(!(src && dst));
+		memcpy(dst, src, HV_HYP_PAGE_SIZE);
+		memunmap(src);
+		kunmap(pg);
+	} else {
+		hypercall_msr.guest_physical_address = vmalloc_to_pfn(hv_hypercall_pg);
+		wrmsrl(HV_X64_MSR_HYPERCALL, hypercall_msr.as_uint64);
+	}
 
 	/*
 	 * Ignore any errors in setting up stimer clockevents
@@ -576,6 +607,6 @@ EXPORT_SYMBOL_GPL(hv_is_hyperv_initialized);
 
 bool hv_is_hibernation_supported(void)
 {
-	return acpi_sleep_state_supported(ACPI_STATE_S4);
+	return !hv_root_partition && acpi_sleep_state_supported(ACPI_STATE_S4);
 }
 EXPORT_SYMBOL_GPL(hv_is_hibernation_supported);
-- 
2.20.1

