Return-Path: <linux-hyperv+bounces-651-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 89E447DC29F
	for <lists+linux-hyperv@lfdr.de>; Mon, 30 Oct 2023 23:50:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AD0C31C209C5
	for <lists+linux-hyperv@lfdr.de>; Mon, 30 Oct 2023 22:50:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AE156AB1;
	Mon, 30 Oct 2023 22:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JuetohCp"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 587C64C84
	for <linux-hyperv@vger.kernel.org>; Mon, 30 Oct 2023 22:50:27 +0000 (UTC)
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E99548E;
	Mon, 30 Oct 2023 15:50:25 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id d9443c01a7336-1cc55bcd51eso2345545ad.0;
        Mon, 30 Oct 2023 15:50:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698706225; x=1699311025; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Ol71Wy23MLqAWlJq8ZIGhp6OorJwOj5RE9vie1iTxBI=;
        b=JuetohCpSC/VS6nclBxAf7zvP+xioCQH4kw/XmEZEfe/orDYLVI1ELSmwUDS6M+yxk
         hiXd9RraKr7+U3BCF8+aT4tpka+88nINtUOq5q2q2zFXu0/vTCDO7cOByHY8y1YrQuWz
         P7g92BhDd8OEZsH1pUnLdmAK/Bv77S/WWOWKek2xW2glh+SUKZ9foMrsxegKlVLH065s
         2Ma96EBhjbhaRVp5GnxLlKYZzp3cL/vdULQZa5mEkvbPBsrsvKlbGUrxdSfzqUQLYKiV
         lB1x7FBRUcZZOyjH1LIXJcFnUUGVZUIjAtX6znBBZ4NgNB7oqp+rdFmfLpx0KnXp6s34
         p+3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698706225; x=1699311025;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ol71Wy23MLqAWlJq8ZIGhp6OorJwOj5RE9vie1iTxBI=;
        b=RVGHvTO8k51KZES3pg0M9fNgh5bczkOeWuJa7ncz9J7LunL2fVtpA6Q7+YuhTLHyfR
         PAbQqa2razDdQ9mANaFbC9Osf4XqQFEomQkQrAklXo6JEdtscaF6T8d3GiNGN0Nu+u+8
         C6Io+8Bi2rDFkf5CyufsF3T4o2TVezzrDKl5kDZymjw1JzS6DZcalaeAqjh8VCYDi7Q6
         OejcaieCqvR3aBuf1uSzk2joh3GadCZp0kv180rbMh9sfLCQ+CCNsY6ijm2y8ZiVA+B3
         +ycGe3jc5cD3drDe+g19K0bx6s2JQmOLTJHhtwNECll6QGlH/0oSxecG8Nm0Jah7+ieb
         GRqQ==
X-Gm-Message-State: AOJu0YxayFr+SY7ZBrBcW4IYlWRxXERLYdcPcWzkN28oXaE+9X1lSQHs
	rxdOSXoIsrj14ev988RPmdfnwmUGVA5Cb+tM
X-Google-Smtp-Source: AGHT+IFOrFgKAQD3TszBSjrQcXQS15Tf/X3a/FzJ2mdzcpcahVuvRrcDI3fFHhxMc0r+2KGuykC+4w==
X-Received: by 2002:a17:902:e906:b0:1c0:bf60:ba82 with SMTP id k6-20020a170902e90600b001c0bf60ba82mr12045288pld.5.1698706224955;
        Mon, 30 Oct 2023 15:50:24 -0700 (PDT)
Received: from abhinav.. ([103.75.161.210])
        by smtp.gmail.com with ESMTPSA id y6-20020a170902ed4600b001c898328289sm34350plb.158.2023.10.30.15.50.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Oct 2023 15:50:24 -0700 (PDT)
From: Abhinav Singh <singhabhinav9051571833@gmail.com>
To: linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: hpa@zytor.com,
	x86@kernel.org,
	dave.hansen@linux.intel.com,
	bp@alien8.de,
	mingo@redhat.com,
	tglx@linutronix.de,
	decui@microsoft.com,
	wei.liu@kernel.org,
	haiyangz@microsoft.com,
	kys@microsoft.com,
	niyelchu@linux.microsoft.com,
	Abhinav Singh <singhabhinav9051571833@gmail.com>
Subject: [PATCH v2] x86/hyperv : Fixing removal of __iomem address space warning
Date: Tue, 31 Oct 2023 04:20:03 +0530
Message-Id: <20231030225003.374717-1-singhabhinav9051571833@gmail.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch fixes two sparse warnings

1. sparse complaining about the removal of __iomem address
space when casting the return value of this ioremap_cache(...)
from `void __ioremap*` to `void*`.
Fixed this by replacing the ioremap_cache(...)
by memremap(...) and using MEMREMAP_DEC and MEMREMAP_WB flag for making
sure the memory is always decrypted and it will support full write back
cache.

2. sparse complaining `expected void volatile [noderef] __iomem *addr`
when calling iounmap with a non __iomem pointer.
Fixed this by replacing iounmap(...) with memumap(...).

Signed-off-by: Abhinav Singh <singhabhinav9051571833@gmail.com>
---

v1:
https://lore.kernel.org/all/19cec6f0-e176-4bcc-95a0-9d6eb0261ed1@gmail.com/T/

v1 to v2:
1. Fixed the comment which was earlier describing ioremap_cache(...).
2. Replaced iounmap(...) with memremap(...) inside function hv_cpu_die(...).

 arch/x86/hyperv/hv_init.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/arch/x86/hyperv/hv_init.c b/arch/x86/hyperv/hv_init.c
index 21556ad87f4b..2a14928b8a36 100644
--- a/arch/x86/hyperv/hv_init.c
+++ b/arch/x86/hyperv/hv_init.c
@@ -68,9 +68,11 @@ static int hyperv_init_ghcb(void)
 	 */
 	rdmsrl(MSR_AMD64_SEV_ES_GHCB, ghcb_gpa);

-	/* Mask out vTOM bit. ioremap_cache() maps decrypted */
+	/* Mask out vTOM bit.
+	MEMREMAP_WB full write back cache
+	MEMREMAP_DEC maps decrypted memory */
 	ghcb_gpa &= ~ms_hyperv.shared_gpa_boundary;
-	ghcb_va = (void *)ioremap_cache(ghcb_gpa, HV_HYP_PAGE_SIZE);
+	ghcb_va = memremap(ghcb_gpa, HV_HYP_PAGE_SIZE, MEMREMAP_WB | MEMREMAP_DEC);
 	if (!ghcb_va)
 		return -ENOMEM;

@@ -238,7 +240,7 @@ static int hv_cpu_die(unsigned int cpu)
 	if (hv_ghcb_pg) {
 		ghcb_va = (void **)this_cpu_ptr(hv_ghcb_pg);
 		if (*ghcb_va)
-			iounmap(*ghcb_va);
+			memunmap(*ghcb_va);
 		*ghcb_va = NULL;
 	}

--
2.39.2


