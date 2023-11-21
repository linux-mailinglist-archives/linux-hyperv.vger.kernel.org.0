Return-Path: <linux-hyperv+bounces-1013-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 27AAD7F3829
	for <lists+linux-hyperv@lfdr.de>; Tue, 21 Nov 2023 22:20:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 58C0B1C20E9C
	for <lists+linux-hyperv@lfdr.de>; Tue, 21 Nov 2023 21:20:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF39E584C4;
	Tue, 21 Nov 2023 21:20:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G4t36tCH"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9752CD50;
	Tue, 21 Nov 2023 13:20:42 -0800 (PST)
Received: by mail-pl1-x636.google.com with SMTP id d9443c01a7336-1cc5fa0e4d5so51073425ad.0;
        Tue, 21 Nov 2023 13:20:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700601642; x=1701206442; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SKZ1/19bZDjXmVD1CEbmEpv81ZSrP5Qqz0tPf+dknk4=;
        b=G4t36tCHg0fwkGnEShyrhGWezWsXVxN2qVmH10CL3JfF2Q7uESiu9nvcM9EMkRYYIM
         g94Mz4SwhQligb30bqks2ddGGNw5+QOtQrS9zOb8ssvy00WkU7vrh8UUK57qcBSJQTUn
         TmAT3O5n7Ig2LH7Q9OdHoUzifBgqIm3I4bR9Gm1b5P5Kfukql6TGt6fZbs55aAf8gBtx
         Fp4T5uYbSndgbh+3ueIcvUfypwPZVB4Dt2z7j3wZpKSof3JwUcXdis0LaF5SA+XaUl6u
         GVcVqYbeQEDcpaymbwJR92CP492vBTim00yrpL/2Fvbyg35VrU88YOOM5rp53cvNYuAs
         35zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700601642; x=1701206442;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=SKZ1/19bZDjXmVD1CEbmEpv81ZSrP5Qqz0tPf+dknk4=;
        b=o1CywgdMEeafBO4z/mUJaVTntSseBDuDd+3V+wcK2+W2ZpbxaMYmN5WPVgTK9BMFqj
         RLviAI1hVgpSFcKvQaPa40qnqCo5E4Aec0Hm8J3jbSbvT6+Q0t0qBHCTUZSYx/M6RTa5
         iA6lsQPyYtSiZzXlP5o6v9iD1GmewyzJHKXSzAm9NPSks28FCEqD+9ArgV8LL29hrWbV
         AChDYUlP6ECndSfQBLsbRUEJCwMO3pGmflaf/xTWXR2XDSTT445IPEOy82EChH97z0Mw
         NOCUInXGWsaFN43sEB8Z4887FiWAchsYtHtnosUK/ps6v9E5+QO1TcUCijA1ugo/niLd
         llQw==
X-Gm-Message-State: AOJu0Yx81zTC7iuCvZqeLgjJlgrVkc0EEMTQG5X1A7PbAHBYjE4pJw3F
	yO+zLvYiCjt7haCc4choGh4=
X-Google-Smtp-Source: AGHT+IGz0GBc2L6fKdHOp277El3AvOBOL/M7tgvndLmzeYqXyjHTZ5visODxoyvzOD8ddZlnIN7psg==
X-Received: by 2002:a17:903:2281:b0:1cf:6315:8698 with SMTP id b1-20020a170903228100b001cf63158698mr401033plh.42.1700601641967;
        Tue, 21 Nov 2023 13:20:41 -0800 (PST)
Received: from localhost.localdomain (c-73-254-87-52.hsd1.wa.comcast.net. [73.254.87.52])
        by smtp.gmail.com with ESMTPSA id j2-20020a170902758200b001bf52834696sm8281924pll.207.2023.11.21.13.20.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Nov 2023 13:20:41 -0800 (PST)
From: mhkelley58@gmail.com
X-Google-Original-From: mhklinux@outlook.com
To: tglx@linutronix.de,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	x86@kernel.org,
	hpa@zytor.com,
	kirill.shutemov@linux.intel.com,
	kys@microsoft.com,
	haiyangz@microsoft.com,
	wei.liu@kernel.org,
	decui@microsoft.com,
	luto@kernel.org,
	peterz@infradead.org,
	akpm@linux-foundation.org,
	urezki@gmail.com,
	hch@infradead.org,
	lstoakes@gmail.com,
	thomas.lendacky@amd.com,
	ardb@kernel.org,
	jroedel@suse.de,
	seanjc@google.com,
	rick.p.edgecombe@intel.com,
	sathyanarayanan.kuppuswamy@linux.intel.com,
	linux-kernel@vger.kernel.org,
	linux-coco@lists.linux.dev,
	linux-hyperv@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH v2 7/8] x86/mm: Remove unnecessary call layer for __set_memory_enc_pgtable()
Date: Tue, 21 Nov 2023 13:20:15 -0800
Message-Id: <20231121212016.1154303-8-mhklinux@outlook.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231121212016.1154303-1-mhklinux@outlook.com>
References: <20231121212016.1154303-1-mhklinux@outlook.com>
Reply-To: mhklinux@outlook.com
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Michael Kelley <mhklinux@outlook.com>

__set_memory_enc_pgtable() is only called from __set_memory_enc_dec()
after doing a simple validation check. Prior to commit 812b0597fb40,
__set_memory_enc_dec() did more complex checking, but now the code
can be simplified by collapsing the two functions.

No functional change.

Signed-off-by: Michael Kelley <mhklinux@outlook.com>
---
 arch/x86/mm/pat/set_memory.c | 15 +++++----------
 1 file changed, 5 insertions(+), 10 deletions(-)

diff --git a/arch/x86/mm/pat/set_memory.c b/arch/x86/mm/pat/set_memory.c
index c13178f37b13..7365c86a7ff0 100644
--- a/arch/x86/mm/pat/set_memory.c
+++ b/arch/x86/mm/pat/set_memory.c
@@ -2131,15 +2131,18 @@ int set_memory_global(unsigned long addr, int numpages)
 }
 
 /*
- * __set_memory_enc_pgtable() is used for the hypervisors that get
+ * __set_memory_enc_dec() is used for the hypervisors that get
  * informed about "encryption" status via page tables.
  */
-static int __set_memory_enc_pgtable(unsigned long addr, int numpages, bool enc)
+static int __set_memory_enc_dec(unsigned long addr, int numpages, bool enc)
 {
 	pgprot_t empty = __pgprot(0);
 	struct cpa_data cpa;
 	int ret;
 
+	if (!cc_platform_has(CC_ATTR_MEM_ENCRYPT))
+		return 0;
+
 	/* Should not be working on unaligned addresses */
 	if (WARN_ONCE(addr & ~PAGE_MASK, "misaligned address: %#lx\n", addr))
 		addr &= PAGE_MASK;
@@ -2200,14 +2203,6 @@ static int __set_memory_enc_pgtable(unsigned long addr, int numpages, bool enc)
 	return set_memory_p(&addr, numpages);
 }
 
-static int __set_memory_enc_dec(unsigned long addr, int numpages, bool enc)
-{
-	if (cc_platform_has(CC_ATTR_MEM_ENCRYPT))
-		return __set_memory_enc_pgtable(addr, numpages, enc);
-
-	return 0;
-}
-
 int set_memory_encrypted(unsigned long addr, int numpages)
 {
 	return __set_memory_enc_dec(addr, numpages, true);
-- 
2.25.1


