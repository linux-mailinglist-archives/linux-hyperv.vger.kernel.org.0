Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D8A472A842C
	for <lists+linux-hyperv@lfdr.de>; Thu,  5 Nov 2020 17:59:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731752AbgKEQ63 (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 5 Nov 2020 11:58:29 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:35711 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731731AbgKEQ63 (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 5 Nov 2020 11:58:29 -0500
Received: by mail-wm1-f65.google.com with SMTP id h22so2307272wmb.0;
        Thu, 05 Nov 2020 08:58:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=GTg33ob3RC5GG3GrqyKRBWlnUnaKM5TQaX6HZwdZJ84=;
        b=Tle7/5a4147gTlR/elLPSCEPZBU17KMUy+yEGBRKKiaKasY2HAoR5jJ5FxJ6bETjn/
         4rz6UVRHkSg9p1Vo7zWW8KBqScAnGrss6vVKPScyifK0aWRVtUHOXjGsoOdY2C/Bymyq
         4BY0dp+WoXMJZYSEosPH9PxEbtXItsF9kAyBYXM5nqvTqXYFQUGDurBDHpKekQDncsWE
         wphMxWrvy/SF5dh/e3+AfVhC4ypOJxDVBnxoFg8gNZEU/L+/oYBwtwG6eByTwDVU2RHU
         rjMJBe3N5jF8wrcxouJWKj4RT6D2rS0Ngs1ZzAJzGot2vmMV429d6L3+irp9+Fvw2WSs
         hRxg==
X-Gm-Message-State: AOAM532T7Ec8LFeBn6NhaKKcqiFnGNU1zpBVQ/E0EU+eP7EuODdmkKTP
        iA8SqqWnMfRqXpjWyESFIyts2ljQTkY=
X-Google-Smtp-Source: ABdhPJyYuEm1P/3mkSUy828svRJFE6/ybqHZhZRlYdrWwniLj4v6ue3zV/6XjoeZg/A4U0YAbKlWEQ==
X-Received: by 2002:a1c:4054:: with SMTP id n81mr3810185wma.48.1604595505193;
        Thu, 05 Nov 2020 08:58:25 -0800 (PST)
Received: from liuwe-devbox-debian-v2.j3c5onc20sse1dnehy4noqpfcg.zx.internal.cloudapp.net ([51.145.34.42])
        by smtp.gmail.com with ESMTPSA id z5sm3350729wrw.87.2020.11.05.08.58.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2020 08:58:24 -0800 (PST)
From:   Wei Liu <wei.liu@kernel.org>
To:     Linux on Hyper-V List <linux-hyperv@vger.kernel.org>
Cc:     virtualization@lists.linux-foundation.org,
        Linux Kernel List <linux-kernel@vger.kernel.org>,
        Michael Kelley <mikelley@microsoft.com>,
        Vineeth Pillai <viremana@linux.microsoft.com>,
        Sunil Muthuswamy <sunilmut@microsoft.com>,
        Nuno Das Neves <nunodasneves@linux.microsoft.com>,
        Wei Liu <wei.liu@kernel.org>,
        Lillian Grassin-Drake <ligrassi@microsoft.com>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org (maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)),
        "H. Peter Anvin" <hpa@zytor.com>
Subject: [PATCH v2 08/17] x86/hyperv: handling hypercall page setup for root
Date:   Thu,  5 Nov 2020 16:58:05 +0000
Message-Id: <20201105165814.29233-9-wei.liu@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201105165814.29233-1-wei.liu@kernel.org>
References: <20201105165814.29233-1-wei.liu@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

When Linux is running as the root partition, the hypercall page will
have already been setup by Hyper-V. Copy the content over to the
allocated page.

The suspend, resume and cleanup paths remain untouched because they are
not supported in this setup yet.

Signed-off-by: Lillian Grassin-Drake <ligrassi@microsoft.com>
Signed-off-by: Sunil Muthuswamy <sunilmut@microsoft.com>
Signed-off-by: Nuno Das Neves <nunodasneves@linux.microsoft.com>
Co-Developed-by: Lillian Grassin-Drake <ligrassi@microsoft.com>
Co-Developed-by: Sunil Muthuswamy <sunilmut@microsoft.com>
Co-Developed-by: Nuno Das Neves <nunodasneves@linux.microsoft.com>
Signed-off-by: Wei Liu <wei.liu@kernel.org>
---
 arch/x86/hyperv/hv_init.c | 32 ++++++++++++++++++++++++++++++--
 1 file changed, 30 insertions(+), 2 deletions(-)

diff --git a/arch/x86/hyperv/hv_init.c b/arch/x86/hyperv/hv_init.c
index 73b0fb851f76..9fcaf741be99 100644
--- a/arch/x86/hyperv/hv_init.c
+++ b/arch/x86/hyperv/hv_init.c
@@ -25,6 +25,7 @@
 #include <linux/cpuhotplug.h>
 #include <linux/syscore_ops.h>
 #include <clocksource/hyperv_timer.h>
+#include <linux/highmem.h>
 
 /* Is Linux running as the root partition? */
 bool hv_root_partition;
@@ -438,8 +439,35 @@ void __init hyperv_init(void)
 
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
+		memcpy(dst, src, PAGE_SIZE);
+		memunmap(src);
+		kunmap(pg);
+	} else {
+		hypercall_msr.guest_physical_address = vmalloc_to_pfn(hv_hypercall_pg);
+		wrmsrl(HV_X64_MSR_HYPERCALL, hypercall_msr.as_uint64);
+	}
 
 	/*
 	 * Ignore any errors in setting up stimer clockevents
-- 
2.20.1

