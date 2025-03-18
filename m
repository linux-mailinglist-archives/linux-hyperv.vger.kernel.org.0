Return-Path: <linux-hyperv+bounces-4595-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 518EEA67F19
	for <lists+linux-hyperv@lfdr.de>; Tue, 18 Mar 2025 22:49:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6DA8A168639
	for <lists+linux-hyperv@lfdr.de>; Tue, 18 Mar 2025 21:49:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A2EC1F873E;
	Tue, 18 Mar 2025 21:49:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cE3UKyX+"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0783E1DEFDA;
	Tue, 18 Mar 2025 21:49:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742334571; cv=none; b=avOOSG3limcp5j9UHlShaAgc54+UYUKHD/Gv2FzIyAgKmXH6PP1UHM40UPx8wnaTBnxZaKG4EPcu8UbkQ9WUXCafj103zB2lREfpwqfom0MA2ciqKu9hp6/qDpGrmedfBbft/0y5bK2nx03xyLIPvJ5OZD/u8a73KVWg7mOrobA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742334571; c=relaxed/simple;
	bh=2HkJ1PLBhckuzMKVjGMsI63fnslGi1fgDibj3H7qz8k=;
	h=From:To:Subject:Date:Message-Id:MIME-Version; b=mO59ymuyTQoBYKZ5+a1ORokQzKpH4CUyH5eKUWxVfz5tzm9xpZ/bQXbIB0xd1C/DFXbSs+YfqDhwCcu8ubqPZ7ljfeKinoj1os2unYh2fILmaVDAir3Z/vjBiZihx/9OH+EukYu2PA8e9Ueu3Y4zEHJkeutypXdUkqvyajBEzq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cE3UKyX+; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-225d66a4839so1159845ad.1;
        Tue, 18 Mar 2025 14:49:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742334569; x=1742939369; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:reply-to:message-id:date
         :subject:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=apFSN+iYdUjJ/ySgc4tYDPoBJZPQHCUTufgccs2slIM=;
        b=cE3UKyX+fdGfmiCrls+2/PCkqdkWgxVs2lgnD6JtFxAw754EnYUS0iPMhKlNH/1MtA
         ZXhA9cDWrjUKsTk41H5QB53TVvmPreShNyY0K0r6zitst3g4tLjGNWk34tijgZMYdq9R
         7fOiDB4OfP6Y0aD23kpWHeeYg99qrXKujGmsJ6S4oc2g0e+ecKXNc8aknruYp9V0yfkm
         9ah4jLpHRV3qXt4/U5Ct9YaLeLKGP1JoRUEdDWjX2FzGIV9RH5i8SZahkvBsSqz2TFp4
         9QKXqM0QCBKuD3RMqV8TewrFFdZKWwM0zomG62GMtKZ7C63xH1oqKJ+PknLNf8+xlVIv
         PlFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742334569; x=1742939369;
        h=content-transfer-encoding:mime-version:reply-to:message-id:date
         :subject:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=apFSN+iYdUjJ/ySgc4tYDPoBJZPQHCUTufgccs2slIM=;
        b=caWdTQYjGNBNmkGSZPBeoHKd0yLE9vmS+XZMLTKUXLaKR7n4r/tw38ipU8HcOg4NaI
         Rp8JVI81GdK8G5mCQrVzu/VuGUSqhJd2ZyYPTS5shPyoW8JW7BNGue9BIJYArswYyH+o
         99gqmn0A/h+pXgh1FAln3bPyIBXpQIpaF6KDU0BD6kIjgj/wRAP/cH3YneIQyz9RQN8b
         AEkHBAQdTtIp/nomSdK9XUTvK2DrTDq92UsKlxyuRGvXYy0OtAzjqTkAL0pg1fKoZYM/
         m9h8kwusBYWNUcoQB+TelRa1AuejklNGllvm2MhpEvvusH+4PYnRD2C1aE8EwA8U8oz7
         yEOA==
X-Forwarded-Encrypted: i=1; AJvYcCVuRfYu/jQ6FnK5D2u4HI2Ji5DGCCTfGvhIM2MgdQIqFXr+athbKwjWJ92tfpLkwiZWBmpHarAZpV431aI=@vger.kernel.org, AJvYcCWjl1dcEOMxen84qR+Qv038QvlvT+PvSfQRbQJnMJ7DKPtTiR07fmUPFXT5KTbBh788vV6+3sUheIdoFZiO@vger.kernel.org
X-Gm-Message-State: AOJu0Yyu+QB6ccezzIW8LDOKrn3thdIDSVLcOA5xHEBQPFdtTxpq31g4
	OccBmRVCIIK/2tcf84rGSyZxwOCNOHuGG2Y+9eIXEs0RBDYQSL9R
X-Gm-Gg: ASbGncvS+ePVkHtkmdFsMOAeOB+2DwnDhmULWNPThVloc/L9bN5cKczG7EwKBNt5uAY
	pvKlSdtXROdU6MTLk/AJD+ZaC8BLytoi7sgFIIjQpStA86z2qkG9zncHcTn+91Wwdwh5gSI+XP/
	WUXG0ZHWH/5YqxkKLi7H9SuKL0IzNsoGZ58ErwWBaa5SAwtGd+Lowts5e20ISMWfBZWZkGE9imJ
	9UZw2eBL1ULuY3cUTR9ZvJXBCseBUPte2XGbAuTIxrR6NENoJAtOyM/JfzARch1NfK1pJcRnAMj
	UK4HPIkJ3jl3RVQo4oJVgFIbPZYfJc+orzFW096twWPzUyG38wI7VsSHkrqWCjCA4h+0eyvwOGL
	0a+a7U+90d99lS83N9/iizVk=
X-Google-Smtp-Source: AGHT+IHYwbXImWFFem7kEVrNNUP4SJh431CKrSr061fj5qip32ZxLac/LmwZYzmQ2+HLmwvUs1JSlA==
X-Received: by 2002:a05:6a20:9f8f:b0:1f3:1e5c:c655 with SMTP id adf61e73a8af0-1fbe0519cbamr578249637.6.1742334569224;
        Tue, 18 Mar 2025 14:49:29 -0700 (PDT)
Received: from localhost.localdomain (c-67-160-120-253.hsd1.wa.comcast.net. [67.160.120.253])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-af56ea7bd0csm9558743a12.47.2025.03.18.14.49.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Mar 2025 14:49:28 -0700 (PDT)
From: mhkelley58@gmail.com
X-Google-Original-From: mhklinux@outlook.com
To: kys@microsoft.com,
	haiyangz@microsoft.com,
	wei.liu@kernel.org,
	decui@microsoft.com,
	tglx@linutronix.de,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	x86@kernel.org,
	hpa@zytor.com,
	linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/1] x86/hyperv: Add comments about hv_vpset and var size hypercall input args
Date: Tue, 18 Mar 2025 14:49:19 -0700
Message-Id: <20250318214919.958953-1-mhklinux@outlook.com>
X-Mailer: git-send-email 2.25.1
Reply-To: mhklinux@outlook.com
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Michael Kelley <mhklinux@outlook.com>

Current code varies in how the size of the variable size input header
for hypercalls is calculated when the input contains struct hv_vpset.
Surprisingly, this variation is correct, as different hypercalls make
different choices for what portion of struct hv_vpset is treated as part
of the variable size input header. The Hyper-V TLFS is silent on these
details, but the behavior has been confirmed with Hyper-V developers.

To avoid future confusion about these differences, add comments to
struct hv_vpset, and to hypercall call sites with input that contains
a struct hv_vpset. The comments describe the overall situation and
the calculation that should be used at each particular call site.

No functional change as only comments are updated.

Signed-off-by: Michael Kelley <mhklinux@outlook.com>
---
 arch/x86/hyperv/hv_apic.c   | 5 +++++
 arch/x86/hyperv/mmu.c       | 4 ++++
 include/hyperv/hvgdk_mini.h | 9 ++++++++-
 3 files changed, 17 insertions(+), 1 deletion(-)

diff --git a/arch/x86/hyperv/hv_apic.c b/arch/x86/hyperv/hv_apic.c
index f022d5f64fb6..6d91ac5f9836 100644
--- a/arch/x86/hyperv/hv_apic.c
+++ b/arch/x86/hyperv/hv_apic.c
@@ -145,6 +145,11 @@ static bool __send_ipi_mask_ex(const struct cpumask *mask, int vector,
 		ipi_arg->vp_set.format = HV_GENERIC_SET_ALL;
 	}
 
+	/*
+	 * For this hypercall, Hyper-V treats the valid_bank_mask field
+	 * of ipi_arg->vp_set as part of the fixed size input header.
+	 * So the variable input header size is equal to nr_bank.
+	 */
 	status = hv_do_rep_hypercall(HVCALL_SEND_IPI_EX, 0, nr_bank,
 				     ipi_arg, NULL);
 
diff --git a/arch/x86/hyperv/mmu.c b/arch/x86/hyperv/mmu.c
index 1f7c3082a36d..cfcb60468b01 100644
--- a/arch/x86/hyperv/mmu.c
+++ b/arch/x86/hyperv/mmu.c
@@ -205,6 +205,10 @@ static u64 hyperv_flush_tlb_others_ex(const struct cpumask *cpus,
 	/*
 	 * We can flush not more than max_gvas with one hypercall. Flush the
 	 * whole address space if we were asked to do more.
+	 *
+	 * For these hypercalls, Hyper-V treats the valid_bank_mask field
+	 * of flush->hv_vp_set as part of the fixed size input header.
+	 * So the variable input header size is equal to nr_bank.
 	 */
 	max_gvas =
 		(PAGE_SIZE - sizeof(*flush) - nr_bank *
diff --git a/include/hyperv/hvgdk_mini.h b/include/hyperv/hvgdk_mini.h
index 735329859f21..abf0bd76e370 100644
--- a/include/hyperv/hvgdk_mini.h
+++ b/include/hyperv/hvgdk_mini.h
@@ -205,7 +205,14 @@ union hv_reference_tsc_msr {
 /* The number of vCPUs in one sparse bank */
 #define HV_VCPUS_PER_SPARSE_BANK (64)
 
-/* Some of Hyper-V structs do not use hv_vpset where linux uses them */
+/*
+ * Some of Hyper-V structs do not use hv_vpset where linux uses them.
+ *
+ * struct hv_vpset is usually used as part of hypercall input. The portion
+ * that counts as "fixed size input header" vs. "variable size input header"
+ * varies per hypercall. See comments at relevant hypercall call sites as to
+ * how the "valid_bank_mask" field should be accounted.
+ */
 struct hv_vpset {	 /* HV_VP_SET */
 	u64 format;
 	u64 valid_bank_mask;
-- 
2.25.1


