Return-Path: <linux-hyperv+bounces-7715-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BC2FC745C3
	for <lists+linux-hyperv@lfdr.de>; Thu, 20 Nov 2025 14:52:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 9F1874FA122
	for <lists+linux-hyperv@lfdr.de>; Thu, 20 Nov 2025 13:41:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FA24342145;
	Thu, 20 Nov 2025 13:41:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PqO2NbVQ"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D9DA34105C
	for <linux-hyperv@vger.kernel.org>; Thu, 20 Nov 2025 13:41:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763646079; cv=none; b=X9zc1brbmXOkDoW/MGpIfe+IZbBFKE1SIY1y30fJ1pm7qWucMzobrek1dpTRYqO4xS8kJ4zl6xhm4bGrRKHExHkFcyvZiRVz7zb7IJeYrVBSUEfepuyKoLWJA0rgISwbigAxFdjprcknl49wdMDyGRz9D7x82VKuh14uz1fhCoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763646079; c=relaxed/simple;
	bh=mqhaF5Gz0sKTdxXQIjFAIm8YhwlO/Tnjk6bafLmiRVU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Mbs90TMucSFOFDCdfC1fq8j63h7RglAmfLuTaF7jQe7/sopJGp0M+wfNSGTnSRBOz5GrjnOAMd0UEMhWXgHahjajUpMbHUFSBcq2y/gD9ABWUnr7VUw4iZsWYQKKY04E1gd5KosuVwpgWtpedlEiq0OWd0hkkVAfPZ6u8sf7/H4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PqO2NbVQ; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-b7291af7190so134985666b.3
        for <linux-hyperv@vger.kernel.org>; Thu, 20 Nov 2025 05:41:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763646075; x=1764250875; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NpYFDzUQAIL7AtCSG/QKPMFyk7ggRbL0aM/xfsBLsPo=;
        b=PqO2NbVQh3bo0Gkwt8fVINd/3sPbCyN0t3I/ekjyY1RJlMBG5BapBbOhJ0U/xI49ZI
         eEz7tpX5a6hUBvmLrZ0wO/3Zleid4/IJPheUmVawpBy550Yliw13GxeZ/cCh3uFcU+sT
         H1pvBtBVkruKtS01wo9tDSqeLuJ0yjbeho6bvTM/dk6n7bswqvm7MVfXXGqKUC4XJyAm
         vwu1kQua8GRqzpoKPVfikGr6Sm64EAMh3JMAnFb26a0t4DEnpuUtD2mRHmviTfo1cCWo
         PlzJpgeGwGQi3CrUGr9fsuDMOTZJpXqTwYROobfvWn5z9j7daA84O3oQrdZ4+r/9lIvL
         AZCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763646075; x=1764250875;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=NpYFDzUQAIL7AtCSG/QKPMFyk7ggRbL0aM/xfsBLsPo=;
        b=uIfOtXM9VIXwKFbMdlP00bDyP4Bv9nralqef/v1TVIELFmLItHka39FIYlOukEYKAn
         ehZ3RnJBIodT0IvTb+nn8m8Q4xckPmc0doM9bu+idbtfMF4b09S/HRh7hPG4/vUt1v93
         c7Hf/I8C/TaFt/UQ9eykWxc5f/XYq/0uQWrqEuECrnAblVJAv23ZUAbhP2BN0eQhUDCi
         7MzsWxJRPGXWwzQmeQeYFZ7TN2Q771F/GKcG7a2tBRnGdAmAkvPwCWbphqty7VMErDQI
         JidjmjETk4sr+q597UHA1oYWHl1zCasX6P/xdYKY64oHyuufXx7bbxCUvckfrbimz0sB
         5YSA==
X-Gm-Message-State: AOJu0Yxjhd27YrxdHBB5PotDswEBcysAVvnrAghcux81A4Cd56LYpOsR
	hcNGhGyy9e3uy2bRpsJ98ZjgNdmna8TF55QglVRRWvLe7eYZ+/fpLB5VQIRLNQ8u
X-Gm-Gg: ASbGncsDsrK1i9bf4PFf7v7xe8fs55WAO0ePOulqxt5cyChIhnJidwsCozdcJVdbbP2
	CcP6RgJC2/ScpImcipe0bSfcNpWqTwitKK+C1crsJaVA2gk/U16S3JV8qLzJ9KuhD58ztLLZWgM
	CxG29iXbDX9mqE+MpQRqPxz2CnO3a0RMzhAM30XQrNkD05ZAtTmMRVP6pZzBroNv/Kpt0rZtLxX
	MehNwVnmV6+3uN6HE5Nl9I3Voqc1v+BTwaIGEEFc+AEXvo2KyBUW6pI406OJJsF52GUBuDvvIAR
	IQIWK1docO0XqP+DIPiqo0DQtLVGxc48aAjwNZZAf/8g5PU/Yt8NqBugM0Njf7P7YoqZ9N13Rxe
	6ZQpeCFMAjWJHiBeCEVoPaB8k867Yby2YE2dEVLaC2bhmuoGLFCbbp3cokOctEGYAi05ml4WNIh
	4/FFhzgaDGgjs=
X-Google-Smtp-Source: AGHT+IGtXZ6u4Ii3WDCWKYmQfHi3aiJVMSybQSxzVjind8B6R3+wUxpgT3Vqmcr3s3TSfED+0MFx5g==
X-Received: by 2002:a17:906:6a22:b0:b76:3bfd:8afe with SMTP id a640c23a62f3a-b7658693527mr222487266b.5.1763646075211;
        Thu, 20 Nov 2025 05:41:15 -0800 (PST)
Received: from fedora ([193.77.86.199])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b7654cdd62bsm215930866b.5.2025.11.20.05.41.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Nov 2025 05:41:14 -0800 (PST)
From: Uros Bizjak <ubizjak@gmail.com>
To: linux-hyperv@vger.kernel.org,
	x86@kernel.org,
	linux-kernel@vger.kernel.org
Cc: Uros Bizjak <ubizjak@gmail.com>,
	"K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>,
	Dexuan Cui <decui@microsoft.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>
Subject: [PATCH 2/3] x86/hyperv: Use savesegment() instead of inline asm() to save segment registers
Date: Thu, 20 Nov 2025 14:40:23 +0100
Message-ID: <20251120134105.189753-2-ubizjak@gmail.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251120134105.189753-1-ubizjak@gmail.com>
References: <20251120134105.189753-1-ubizjak@gmail.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use standard savesegment() utility macro to save segment registers.

Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
Cc: "K. Y. Srinivasan" <kys@microsoft.com>
Cc: Haiyang Zhang <haiyangz@microsoft.com>
Cc: Wei Liu <wei.liu@kernel.org>
Cc: Dexuan Cui <decui@microsoft.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
---
 arch/x86/hyperv/ivm.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/arch/x86/hyperv/ivm.c b/arch/x86/hyperv/ivm.c
index 651771534cae..7365d8f43181 100644
--- a/arch/x86/hyperv/ivm.c
+++ b/arch/x86/hyperv/ivm.c
@@ -25,6 +25,7 @@
 #include <asm/e820/api.h>
 #include <asm/desc.h>
 #include <asm/msr.h>
+#include <asm/segment.h>
 #include <uapi/asm/vmx.h>
 
 #ifdef CONFIG_AMD_MEM_ENCRYPT
@@ -315,16 +316,16 @@ int hv_snp_boot_ap(u32 apic_id, unsigned long start_ip, unsigned int cpu)
 	vmsa->gdtr.base = gdtr.address;
 	vmsa->gdtr.limit = gdtr.size;
 
-	asm volatile("movl %%es, %%eax;" : "=a" (vmsa->es.selector));
+	savesegment(es, vmsa->es.selector);
 	hv_populate_vmcb_seg(vmsa->es, vmsa->gdtr.base);
 
-	asm volatile("movl %%cs, %%eax;" : "=a" (vmsa->cs.selector));
+	savesegment(cs, vmsa->cs.selector);
 	hv_populate_vmcb_seg(vmsa->cs, vmsa->gdtr.base);
 
-	asm volatile("movl %%ss, %%eax;" : "=a" (vmsa->ss.selector));
+	savesegment(ss, vmsa->ss.selector);
 	hv_populate_vmcb_seg(vmsa->ss, vmsa->gdtr.base);
 
-	asm volatile("movl %%ds, %%eax;" : "=a" (vmsa->ds.selector));
+	savesegment(ds, vmsa->ds.selector);
 	hv_populate_vmcb_seg(vmsa->ds, vmsa->gdtr.base);
 
 	vmsa->efer = native_read_msr(MSR_EFER);
-- 
2.51.1


