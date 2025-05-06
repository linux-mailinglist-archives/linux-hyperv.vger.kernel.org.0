Return-Path: <linux-hyperv+bounces-5382-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 94402AAC535
	for <lists+linux-hyperv@lfdr.de>; Tue,  6 May 2025 15:07:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 07D05170CF5
	for <lists+linux-hyperv@lfdr.de>; Tue,  6 May 2025 13:07:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDD79280038;
	Tue,  6 May 2025 13:07:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XBEBREdP"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D22127FB1C;
	Tue,  6 May 2025 13:07:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746536838; cv=none; b=fXGj7cUOD5KXWannDJ9v8BLkTYr9jnURJ/ikWndVObNX8mi0fjL6dzdFm7C5FaCFTh2ZpGi4GpCDVlqIBVIinmFxXFgYL1NN3lzZXM9Xi8g4DpVbYxI4GivbAgBQg9kT4z8TPJhd+Mtagop/Get0lNrEquVw51FVOtH/PWlnYTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746536838; c=relaxed/simple;
	bh=sZuDXCkL4t/OMPk8Stj1OTyFXveRtWL3RoduHVOxTdY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=DuuGuWeG4hMIBv2uNOMFOOWibsUAxebJyJJssP27Rqxz109z5OKoAMDpWd1PEucQlxB3o1kqhNf6FH1nuWoRnuH4rPV0xCn40wetCdWEJy+sa0YPlNzITN+gP6Pu68C5qjZwtcnTtSKnRFAkBzSwszs5b2Hf09B+FWWpP+1OyDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XBEBREdP; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-30a452d3b38so4793853a91.3;
        Tue, 06 May 2025 06:07:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746536837; x=1747141637; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ui7h4Bm1iSaD55Ked7lvX6BmHIBdmEjKS4TrsnxOauw=;
        b=XBEBREdPCUzbM1k9+HY6cdDi3RkRmR3OKOJqVZtoNvK15zHd1Gn3TEU+VCveGD+zQ1
         cGUI01cceAndHYqTa8DBIH2xn7ldqoPf0UDtf5WMWbI6MngHlxzHQDs9kvimz5P2BSXG
         fSQD75koD47shaGdoYBtgYLJ97wDL+BEttHfR1KMQEjGeNfI3SeQAihpS45vrFE4361f
         EtvtKgu03KtouBXc8gDdXBhPEdpGd5XFWOfVoVrJV/j/6j+PuJ96W5DBkU0tVJXDi3ty
         1qxejKN7aKSkqyQAyp8ELrsVGjyw4TYbSKiPEPikniCdjIhXR2eu8pA3HRDTxHcFTdc/
         OXsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746536837; x=1747141637;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ui7h4Bm1iSaD55Ked7lvX6BmHIBdmEjKS4TrsnxOauw=;
        b=Wd7oZeXw0kQapPbooVk9uTBCUMlin5RLZ3SseU9wUgSv2QSuyVXeSsW3e48FTCCahu
         wMxv59bSH9H5iIz4vJV7vMukJ9BiXM/yO+pnoMyYny1+C0L5rM+DOix4TLWi1ntc8wC9
         JWYpBrG148ZRtwQBYVyTBWUJLM9KcvyWIG0hlJVFC0rVK4UcChFCvosXiG7CGc+oWRuE
         UAA2rviQSmtBjlr5DSovSRkWXSgX1brGkShR9BDOVxI2YIOrJrhGxN+qumLCdTgkgU8O
         Z3cViAKmRyInRCsRoqRFoOwWOI9WfeIBbnHwBztw48wf0NK+r79FcMk1C6QXCmuCePKo
         x/ig==
X-Forwarded-Encrypted: i=1; AJvYcCXbAuGoJeuIJg2nYcZRAhYFV8aXdenpq9IeZ98BUs5Ae7T553vNJ1UdN63ZhKMDGH4GMqwij5nNX50t4PQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxAtPJlhnNJGjQtJguZVcvun2AaGIamgaJnaejFjMrX+C8TR6c6
	13o6uyzqFXl8bNhYHvP8A7AI19lf/erFEVJfCWb6MDgUqEqUWSkk
X-Gm-Gg: ASbGncsN1wsIoPXUmfvDfwHo1YSW1z8tSoZoRFzwPlj0Yeq9/u9yGIY/6ugEPwYXJyY
	QDEJy/RT+EsBR5m6LiaTzqFzsESeix+nKYM/DZBUQQKs7A91LFQzSJWlnUha7bwYpLIBmFeescx
	YF5QEOXnDHhX8o9MI+slpAV38GBx0enO1PLQR24YpIPhHSEQOYfRpiJqF58gXIfqPG7gKxMsm7R
	So11G9ayRwF+gllGtXE9ONBE5OTcuQlgqUCa2KM+6btDZFEkQYllHX44IveJeqRcldDUwjoHMVv
	XF0phuxWL62fA/MShFHoPl14ZcyZKfppBhAjvdq/zQvEvCrbyLqpGON/aLwLLVB7hG3nRqRpeHu
	LRby/xa8kfUuPBAzH
X-Google-Smtp-Source: AGHT+IGjmHp8eo0xgBGdC8IT2z5KqSTmz8mPQCvWDPGKSKpLuQZgF+mBDWs7kGPv0IE9dFQtNyFmAw==
X-Received: by 2002:a17:90b:520f:b0:2fe:9e6c:add9 with SMTP id 98e67ed59e1d1-30a4e5c5d2dmr27122612a91.18.1746536836507;
        Tue, 06 May 2025 06:07:16 -0700 (PDT)
Received: from ubuntu-Virtual-Machine.corp.microsoft.com ([2001:4898:80e8:72:2835:d413:5ee2:7e6a])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22e15229384sm72628275ad.206.2025.05.06.06.07.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 May 2025 06:07:16 -0700 (PDT)
From: Tianyu Lan <ltykernel@gmail.com>
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
	Neeraj.Upadhyay@amd.com,
	yuehaibing@huawei.com,
	kvijayab@amd.com,
	jacob.jun.pan@linux.intel.com,
	jpoimboe@kernel.org,
	tiala@microsoft.com
Cc: linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [RFC PATCH 2/6] x86/x2apic-savic: Expose x2apic_savic_update_vector()
Date: Tue,  6 May 2025 09:07:07 -0400
Message-Id: <20250506130712.156583-3-ltykernel@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250506130712.156583-1-ltykernel@gmail.com>
References: <20250506130712.156583-1-ltykernel@gmail.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Tianyu Lan <tiala@microsoft.com>

Expose x2apic_savic_update_vector() and device driver
arch code may update AVIC backing page to allow Hyper-V
inject associated vector.

Signed-off-by: Tianyu Lan <tiala@microsoft.com>
---
 arch/x86/include/asm/apic.h         | 9 +++++++++
 arch/x86/kernel/apic/x2apic_savic.c | 8 ++++++++
 2 files changed, 17 insertions(+)

diff --git a/arch/x86/include/asm/apic.h b/arch/x86/include/asm/apic.h
index 6aa4b8ff08a9..949389e05dd7 100644
--- a/arch/x86/include/asm/apic.h
+++ b/arch/x86/include/asm/apic.h
@@ -241,6 +241,15 @@ static inline u64 native_x2apic_icr_read(void)
 	return val;
 }
 
+#if defined(CONFIG_AMD_SECURE_AVIC)
+extern void x2apic_savic_update_vector(unsigned int cpu,
+				unsigned int vector,
+				bool set);
+#else
+static inline void x2apic_savic_update_vector(unsigned int cpu,
+					      unsigned int vector,								      bool set) { }
+#endif
+
 extern int x2apic_mode;
 extern int x2apic_phys;
 extern void __init x2apic_set_max_apicid(u32 apicid);
diff --git a/arch/x86/kernel/apic/x2apic_savic.c b/arch/x86/kernel/apic/x2apic_savic.c
index 6284d1f8dac9..0dd7e39931b0 100644
--- a/arch/x86/kernel/apic/x2apic_savic.c
+++ b/arch/x86/kernel/apic/x2apic_savic.c
@@ -321,6 +321,14 @@ static void savic_update_vector(unsigned int cpu, unsigned int vector, bool set)
 	update_vector(cpu, SAVIC_ALLOWED_IRR, vector, set);
 }
 
+void x2apic_savic_update_vector(unsigned int cpu, unsigned int vector, bool set)
+{
+	if (!cc_platform_has(CC_ATTR_SNP_SECURE_AVIC))
+		return;
+
+	savic_update_vector(cpu, vector, set);
+}
+
 static void init_apic_page(void)
 {
 	u32 apic_id;
-- 
2.25.1


