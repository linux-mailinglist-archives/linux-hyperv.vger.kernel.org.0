Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E139446D628
	for <lists+linux-hyperv@lfdr.de>; Wed,  8 Dec 2021 15:52:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233491AbhLHO4F (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 8 Dec 2021 09:56:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231951AbhLHO4E (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 8 Dec 2021 09:56:04 -0500
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1A8FC061746;
        Wed,  8 Dec 2021 06:52:32 -0800 (PST)
Received: by mail-pj1-x102e.google.com with SMTP id gf14-20020a17090ac7ce00b001a7a2a0b5c3so4492248pjb.5;
        Wed, 08 Dec 2021 06:52:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=QzKcx5yPUcuops4Q+JZ93iOnQti2rPR+TjoSjnXXm9A=;
        b=UMng7B3YW1PY/k4q0KBZkM7wtKPbKKAPUrZ31Hhr4l+5og1PggHxE/4ypeOQju2Isi
         ddUx0FKBJeWtsiW1d88WJpsU0lTXQ0HXAPbH0PhEEnW65mFqOR86I6QzD3tdChAKLhqT
         cSA5R2dRE+yuiuE8XvAot0dpiTVwZXQZLNVfIcQ8bSb8wMmZXTvPPxtwpdbtMj3n/qBe
         6hw1XP5sTy+3y23o3DT+dIi0stcfydpk4W6NHn5BPriYHfLEQChiiaY2r+qL2ILdq1p4
         iY/Bdd8cKk+AvWhF60zg224x5xyb+QOnuTery92NAIcBAH96SglyyudltDKP3uL5rMqs
         Gmng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QzKcx5yPUcuops4Q+JZ93iOnQti2rPR+TjoSjnXXm9A=;
        b=dUbAo9s+69uquEjxc5EfR+pAVpgYaG6g3bIKV/1tQPlHH4sdpJcZ+v0CxOmfmDi6KV
         2qS8sqJtHAxONnlN5E+5e3c3TZZSou9j0ZVKakCqEtmd2yNt5rzYcIfDRGQkYgltdwJe
         ce1VIoUdxPr6/g2+XipvD6ht+wk+Oh1TYgLIvHlOnzQ9kLQ8uuMr4JndHovV4wc1j16y
         lXHoT1nvqO9UeovkmC/puQmjRTcqtgGt5ZNmK8MeFxa1b2C1DegDtansYuV7AO5wx7nC
         qFXVMpwiL0T8xNnMuuzGYiZK881v8oYsCd7rxFsa7eFbO6LVx8kXGrSOY4Q8DgXS6xKu
         HUag==
X-Gm-Message-State: AOAM531YgT80aU7ByKVwTgciJft5ljxc0NanQMrEv/jEpTcFZx69G9dV
        DkDOl7s00V07D2O6Pd9BhWg=
X-Google-Smtp-Source: ABdhPJzYa+4js8K70gVBG7XUrUChCAHiqE9sZ9ISJ0oj8XxR8ZPal8nMUGzVAVJVm1aWQB2YLSFlgg==
X-Received: by 2002:a17:903:300d:b0:142:744f:c74d with SMTP id o13-20020a170903300d00b00142744fc74dmr61115251pla.26.1638975152436;
        Wed, 08 Dec 2021 06:52:32 -0800 (PST)
Received: from ubuntu-Virtual-Machine.corp.microsoft.com ([2001:4898:80e8:3:1571:13c3:b90a:380])
        by smtp.gmail.com with ESMTPSA id oa17sm3182861pjb.37.2021.12.08.06.52.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Dec 2021 06:52:31 -0800 (PST)
From:   Tianyu Lan <ltykernel@gmail.com>
To:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
        thomas.lendacky@amd.com, Tianyu.Lan@microsoft.com,
        michael.h.kelley@microsoft.com, kys@microsoft.com
Cc:     linux-kernel@vger.kernel.org, vkuznets@redhat.com,
        brijesh.singh@amd.com, konrad.wilk@oracle.com, hch@lst.de,
        wei.liu@kernel.org, robin.murphy@arm.com, joro@8bytes.org,
        parri.andrea@gmail.com, dave.hansen@intel.com,
        linux-hyperv@vger.kernel.org
Subject: [PATCH V6.1] x86/hyper-v: Add hyperv Isolation VM check in the cc_platform_has()
Date:   Wed,  8 Dec 2021 09:52:28 -0500
Message-Id: <20211208145228.42048-1-ltykernel@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211207075602.2452-3-ltykernel@gmail.com>
References: <20211207075602.2452-3-ltykernel@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

From: Tianyu Lan <Tianyu.Lan@microsoft.com>

Hyper-V provides Isolation VM which encrypt guest memory. In
isolation VM, swiotlb bounce buffer size needs to adjust
according to memory size in the sev_setup_arch(). Add GUEST_MEM_
ENCRYPT check in the Isolation VM.

Signed-off-by: Tianyu Lan <Tianyu.Lan@microsoft.com>
---
Change since v6:
	* Change the order in the cc_platform_has() and check sev first.

Change since v3:
	* Change code style of checking GUEST_MEM attribute in the
	  hyperv_cc_platform_has().
---
 arch/x86/kernel/cc_platform.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/x86/kernel/cc_platform.c b/arch/x86/kernel/cc_platform.c
index 03bb2f343ddb..6cb3a675e686 100644
--- a/arch/x86/kernel/cc_platform.c
+++ b/arch/x86/kernel/cc_platform.c
@@ -11,6 +11,7 @@
 #include <linux/cc_platform.h>
 #include <linux/mem_encrypt.h>
 
+#include <asm/mshyperv.h>
 #include <asm/processor.h>
 
 static bool __maybe_unused intel_cc_platform_has(enum cc_attr attr)
@@ -58,12 +59,19 @@ static bool amd_cc_platform_has(enum cc_attr attr)
 #endif
 }
 
+static bool hyperv_cc_platform_has(enum cc_attr attr)
+{
+	return attr == CC_ATTR_GUEST_MEM_ENCRYPT;
+}
 
 bool cc_platform_has(enum cc_attr attr)
 {
 	if (sme_me_mask)
 		return amd_cc_platform_has(attr);
 
+	if (hv_is_isolation_supported())
+		return hyperv_cc_platform_has(attr);
+
 	return false;
 }
 EXPORT_SYMBOL_GPL(cc_platform_has);
-- 
2.25.1

