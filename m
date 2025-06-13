Return-Path: <linux-hyperv+bounces-5897-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 64A2DAD89FE
	for <lists+linux-hyperv@lfdr.de>; Fri, 13 Jun 2025 13:09:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A98AC3B1724
	for <lists+linux-hyperv@lfdr.de>; Fri, 13 Jun 2025 11:08:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BF712D5C64;
	Fri, 13 Jun 2025 11:08:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZFbDf1dz"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 817202D320C;
	Fri, 13 Jun 2025 11:08:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749812934; cv=none; b=h/AdMN6rtzK9qKNdOtCTRTgKFzAD7QPdwZdlVNd60rRewGaeae0w2cxLAu1VhNUNZNlsDFOBA1KqfLxnMtZfvocJ+7D91E9SDwuh2c3EMSfEoJN/rgIKM+ttsXQXROJZ/q7PcgOGqVd/KY/43fRNIq3E3KCBYVsTWKj4irim6uo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749812934; c=relaxed/simple;
	bh=NpUgUKlbyta3HoUzbthZJe9nbJi2yA/hVsL5jpI1Qgc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=D3E48ikmB1uFOyY/gaA08ltAGELHpcbCDJesiR8JrHHKf9pyWefV6MAyTKoWU0M0b9ckXIXSN8AsB8yrHF3fBhUveuNQvgSBRb/j5TGxCO55LEJsFb89NwRsa5D7gUTVpEdUx5y1Jhy1stXELPZTB7gryifagBcSQBaCIuEcrGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZFbDf1dz; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-235f9ea8d08so19795675ad.1;
        Fri, 13 Jun 2025 04:08:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749812933; x=1750417733; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OUGyln3YUNvAev0vt+DFy1ByCk18D3Xp07H0Oxb4O+I=;
        b=ZFbDf1dzZhDNPLRurp6DwxQaT2YalbUOTHnU4oIaq54eFn5jmJdksCKKShgtnzBoZh
         AQxlnH2Z05imWwbhfE/8gMD/ciGMwXM6W9RiWh91RP8kp55x890xZC26Eu0Uk3OBFpVJ
         iY+cZmnnkoV3xR2coAULIvPFnlkB1UXsV+A6EJNOn/x0CySBmS0poot+Pzb2ywFPzaYc
         9YTzqjeY5Q+KDr8/YRszERNdYgDBOUZQsJ2nOTqTdW8UeRiGKdeZhr86Lea06LHTrPli
         3wE0mMoVfTdO/9QnOcpshAWKAShMRqfwkn2QRlvrk4BGpH6Cdjf44cvc5WB4l119DHMS
         yw/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749812933; x=1750417733;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OUGyln3YUNvAev0vt+DFy1ByCk18D3Xp07H0Oxb4O+I=;
        b=s4C2yoSLxft8TbvGQD0zKRfuCAqK+ikBMhNlR0XjMeSh0y6/NlIhzuvH1xhEp71qwU
         TIhxtopVDdhwKEQxnhB4FW+vbVXUN1ZM4lm9vtNM9GrwPOdpnNZRJ3zzUCMcNSpZXb2Q
         LrBGbOfMccfxVR2Aajm1cu4gYddsto1RVL0qIEynceKmCZK1AJsgRlKpUxOLJzjMrEyA
         QuppLeavVafWozyOIdCBbCzRue9Yf6AAmsHWkJDrxEdUcHNwcwH5r3pYrG3ajCSRSLEv
         z/PTr6BfozmCBKdCBUmb33zjjkecwMJebt6TCQRnm0fwQMHO3p0dShFKrssj5SsPK6yd
         CJyg==
X-Forwarded-Encrypted: i=1; AJvYcCUSLInt7iHXzDl2PVDln3LW2qTf9NaUg3QDs5XnoEoGPJoyKxAHw60Ce/9Xr1EJttgS1COxDJ9Cwug8NGMl@vger.kernel.org, AJvYcCV0lw1BOYIklqt9u5ts0/faB7vktQaNZdMmV/ZwmGp8QMmq75t5vpXRoJX3+x2tpTilGg+eTBMJYE8AuwE=@vger.kernel.org
X-Gm-Message-State: AOJu0YypxrGOu3gaUNtQXT8sK+NGrgSdHpLYN1mIwFCsKuwhpCK25GE4
	0FvAwze/OwzRikTsh1G/9HmZzEcip8MZAbXL0rjSQFaFh4Jk3rlvrbbL
X-Gm-Gg: ASbGncsOIe9M0rmzTQwDWNaEjLoHYDjr3yRA8X1k/4PFiUxZLluCvjH8xDLm/XW7GXr
	XZXq7vQpe2Qt6zQyIk1C8nKmSXuHimDDNhGkPJ0EBcrJve7METwzhciacNEeTNwXLXt0uwUq6u7
	cpEHhvV9S0dwpoptUxNQALLFp61eYFr3AWUn0eiRInuA8kngVYpiKZNVKxnmdtjsLvSSAW1N/QL
	lxbzkJS/tuoyPG19tcqH/jAuZLYCylQ5xfmYCrEaDAqzPhG/Auv+QN0gzyr0WQajt5LoBe9lVH3
	IT4vUe2XD9pl3j6f3jPqe4K3ap4KI4nIiZyXhJC9TGN2+PoWEeI2YrZp8Zsg76gy4P186TekEM7
	oPjpueOFWyL/Px4/Y20Xz6dZ/
X-Google-Smtp-Source: AGHT+IHyIV/kRLXpm5mIItyYKYnr4wy6j3ptaHdQJ+y/BLYRSsU3/i1+UkAf1y16V4bx/f1krXag2w==
X-Received: by 2002:a17:902:db10:b0:234:d292:be7f with SMTP id d9443c01a7336-2365db04c8bmr35708575ad.31.1749812932776;
        Fri, 13 Jun 2025 04:08:52 -0700 (PDT)
Received: from ubuntu-Virtual-Machine.corp.microsoft.com ([2001:4898:80e8:b:d53a:6918:4c22:f91])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2365d8a19e3sm11894235ad.82.2025.06.13.04.08.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Jun 2025 04:08:52 -0700 (PDT)
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
Subject: [RFC Patch v2 1/4] x86/Hyper-V: Not use hv apic driver when Secure AVIC is available
Date: Fri, 13 Jun 2025 07:08:26 -0400
Message-Id: <20250613110829.122371-2-ltykernel@gmail.com>
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

When Secure AVIC is available, AMD x2apic Secure
AVIC driver should be selected and return directly
in the hv_apic_init().

Signed-off-by: Tianyu Lan <tiala@microsoft.com>
---
 arch/x86/hyperv/hv_apic.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/x86/hyperv/hv_apic.c b/arch/x86/hyperv/hv_apic.c
index bfde0a3498b9..1c48396e5389 100644
--- a/arch/x86/hyperv/hv_apic.c
+++ b/arch/x86/hyperv/hv_apic.c
@@ -293,6 +293,9 @@ static void hv_send_ipi_self(int vector)
 
 void __init hv_apic_init(void)
 {
+       if (cc_platform_has(CC_ATTR_SNP_SECURE_AVIC))
+               return;
+
 	if (ms_hyperv.hints & HV_X64_CLUSTER_IPI_RECOMMENDED) {
 		pr_info("Hyper-V: Using IPI hypercalls\n");
 		/*
-- 
2.25.1


