Return-Path: <linux-hyperv+bounces-5899-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A9D3AAD8A01
	for <lists+linux-hyperv@lfdr.de>; Fri, 13 Jun 2025 13:09:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5609C175146
	for <lists+linux-hyperv@lfdr.de>; Fri, 13 Jun 2025 11:09:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF9242D663C;
	Fri, 13 Jun 2025 11:08:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l3f4vYV7"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B3CA2D5C74;
	Fri, 13 Jun 2025 11:08:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749812936; cv=none; b=T/9RUzEyXO2pTxrPjIiO+mPvSWIW6mgYI/hTdbKJ6c5RbQWTFCf8GwOmSBFU0jPVmjMgH4fK5xSxS+qehg/AzgZ1nTOEm/t0CALUzP1XnIgdYcfRb5x+rukbJ0tRhtl43srJwoYbczMwzwEAB9Q1DYQ5kMqmtzt42wpcQhjALPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749812936; c=relaxed/simple;
	bh=CNmd6urAXg1EgW5psBuvU8xc9KsgS2G1jqP0soM6iLQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=kBPi1cUFuzL/cs9Y/eSIywPAMAcJlaz3TKbwFLukLig3nEzRwDmR2Myfqghd5TrgL4ONlnO7sn0HDyGXP/SLVHxeldgH0pShmqveTHHHZFtJvVIcOp8Kuac+/+/jS2m5U+UXe0dJ0a1Ye39ZDGoFbz+PlFDO0JyEenoGFb3SQ0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l3f4vYV7; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2350b1b9129so14558255ad.0;
        Fri, 13 Jun 2025 04:08:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749812935; x=1750417735; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2g0dseHTgpHyCMwi7PKFADRDOq5By6XKJMQ8Le1MqRg=;
        b=l3f4vYV7HVEl/Z/2sI4j7R2Zg7lASH8FAHiyeuFRl2T8GJFQOMb4ihtcS+O0THXuYe
         obggECCiV4pFL2B0Xx2mJq1nbpnfpLqkUAzbW0aGaUx529oeCoUWNkgZt1jMJeCZC6UC
         EtyiCvQTQc01NsChdUP1nfxUjGeSLVFGR6aE/UIacei5s4Akf/30WOo4blccbXN+TBxH
         5IQp4CgmvS7ymvvUQ6DZloOQujSKTa5Jjk7EbbCOpuM+4GQ+KqS5ZvO3rxPK0aR+0lEf
         d1an/HcwwPga+2QhPtaktiO0cC8kDTKIZyDSc+Rf48wj2EvFAKR1M36k8eDrsk+PxlLG
         /67Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749812935; x=1750417735;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2g0dseHTgpHyCMwi7PKFADRDOq5By6XKJMQ8Le1MqRg=;
        b=mEtSHccXjTEQGj/DrnXb1SZ475DsrR3KJirT7h5zZP3LbdDxhI3LGFs/WWmnkNpY7D
         tZ7ohqXZe73OhovGqZeoU01QOu/RHlp5KuZ7xjhUYpum5VJMBQRhREi2CmH1WVWxMTis
         It+U25tA9pbxOeusYcRWsKdmcM1PJ4aoBIP8ETEPS0zil6eFkQHftFSOWLsxlOAiZ74y
         sNH1uR/9aJ7EVhKOURtv2lAKz4NSNnHPh7+/L/Ig7Da+Spq8SNG7rBEOAxlVon6VBRNJ
         gDwuHkQc1JIpSxGe+cXL5tF1Depyh4i3pVCrvZ1HmG1ZVIYfcMLi9tYcA7uhCT/tIS47
         o9BQ==
X-Forwarded-Encrypted: i=1; AJvYcCU8XXibQs1ekSEZIo/kVhd676Doe6e72i1//Q04U9oTWtYU+hAAAjeBRNJHNhl0Iwr3J9xXsQ4GV7C8GoSJ@vger.kernel.org, AJvYcCWrh4HimBIpAm6tVYaKVsLXfzazKsr817k2GiVXUaGWnidWJPMyzL7twbL9gIfU0j5Yf4PVm2nafZArE6I=@vger.kernel.org
X-Gm-Message-State: AOJu0YxMuN7JPnoGCCUroI2c20n5XYqymBlWYOZzjtIQ0gg4FekS5Ibb
	RaC87Clzq/1onAbYXLX/6lMoEK4tCSE0yRjThOHRBMXcL7TOmcyDsX6m
X-Gm-Gg: ASbGncsqG8ba5zkF6GW/NVYhWs0+Y9MyVfS0ke2WFnaOi5SsjTXf8B2tSYnOAZTH/3k
	CEINpRoRnviX2Pbp6Jqctm1ARhpHMaa0Ba82urYbGtS4EPrpQ6oIIh7cIkX4t4YEkb63Go0hcyI
	uqBx03XzXrUXzAoi/2RAATOzKXgnbWPDXtR6aw97LI7EQvN8Y6kog+JsXdcHL4J9cBDqyzWM4Tz
	JmforRdfi8EqHr7QY4zDO/awTlRDW+whs3XHsfeysVsFxVbP4K+wUnCDuOFwUk9qyXSoQXJLkJ3
	mHfXtBEQ6hbc7vW/8ZaVOh04oj4cXAKHhWxAdm7NIRHConilDPIOLNev9xNxyH1kZCRkG67WkZ2
	Sn0+OQp5BJGkm1RyP48ZkIael
X-Google-Smtp-Source: AGHT+IFPCnbJttgRDAmG0YhafGXvhV8ZUCEXuK/Xi1GICwveShvDvY6y2MU0jR8MeCgfIS3knZzE5w==
X-Received: by 2002:a17:902:e88f:b0:235:225d:3083 with SMTP id d9443c01a7336-2365d88bf9cmr30820455ad.6.1749812934676;
        Fri, 13 Jun 2025 04:08:54 -0700 (PDT)
Received: from ubuntu-Virtual-Machine.corp.microsoft.com ([2001:4898:80e8:b:d53a:6918:4c22:f91])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2365d8a19e3sm11894235ad.82.2025.06.13.04.08.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Jun 2025 04:08:54 -0700 (PDT)
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
	kvijayab@amd.com,
	Neeraj.Upadhyay@amd.com
Cc: Tianyu Lan <tiala@microsoft.com>,
	linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [RFC Patch v2 3/4] x86/Hyper-V: Not use auto-eoi when Secure AVIC is available
Date: Fri, 13 Jun 2025 07:08:28 -0400
Message-Id: <20250613110829.122371-4-ltykernel@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250613110829.122371-1-ltykernel@gmail.com>
References: <20250613110829.122371-1-ltykernel@gmail.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Tianyu Lan <tiala@microsoft.com>

Hyper-V doesn't support auto-eoi with Secure AVIC.
So Enable HV_DEPRECATING_AEOI_RECOMMENDED flag
to force to write eoi register after handling
interrupt.

Signed-off-by: Tianyu Lan <tiala@microsoft.com>
---
 arch/x86/kernel/cpu/mshyperv.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/x86/kernel/cpu/mshyperv.c b/arch/x86/kernel/cpu/mshyperv.c
index c78f860419d6..8f029650f16c 100644
--- a/arch/x86/kernel/cpu/mshyperv.c
+++ b/arch/x86/kernel/cpu/mshyperv.c
@@ -463,6 +463,8 @@ static void __init ms_hyperv_init_platform(void)
 		 ms_hyperv.max_vp_index, ms_hyperv.max_lp_index);
 
 	hv_identify_partition_type();
+	if (cc_platform_has(CC_ATTR_SNP_SECURE_AVIC))
+		ms_hyperv.hints |= HV_DEPRECATING_AEOI_RECOMMENDED;
 
 	if (ms_hyperv.hints & HV_X64_HYPERV_NESTED) {
 		hv_nested = true;
-- 
2.25.1


