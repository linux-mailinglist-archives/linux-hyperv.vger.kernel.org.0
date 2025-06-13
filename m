Return-Path: <linux-hyperv+bounces-5898-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E0ACAD8A00
	for <lists+linux-hyperv@lfdr.de>; Fri, 13 Jun 2025 13:09:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1734B3B257C
	for <lists+linux-hyperv@lfdr.de>; Fri, 13 Jun 2025 11:08:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA40F2D5C84;
	Fri, 13 Jun 2025 11:08:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ang6Lx2d"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 792D12D4B7C;
	Fri, 13 Jun 2025 11:08:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749812935; cv=none; b=Ko5LvBje0j8P95q/vm/1H0Azol9tkQFXhgtgwS9RdSS17R7vQwimIMQjNqaGdsNuYBcASEBT5/19W91hedJ0zj+n75XwXbXzklFMlyKscGtBJG8xHuYONwhjrk87K2ssxqxcbh2PXvJlIaDBAvgzl7+2EFnXO+XCp/2FArgLXVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749812935; c=relaxed/simple;
	bh=1pSQeJeAHzidykyiOCvT6vrjM6oyl/rmud3hNMYlEIM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=UzB1yA1YQN+w6FL6g5r8Ri6kXd2kpk+Y0C7H6up5hGDvhMahyiILVb1r9ZYTz77HVm+V1ZHEF8GdPIrwHM9SqehJVaxtNJapSiMABa6IQglqz/9d941tM2SmNkF3RM99gK/gXH9biOlBA3wbyjr/D3BLccWkROEHckxxI2DFAz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ang6Lx2d; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-313154270bbso2176977a91.2;
        Fri, 13 Jun 2025 04:08:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749812934; x=1750417734; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ttcsV2r/DbwKksmAX5EcenHls78sO7cykoW6Haqvciw=;
        b=ang6Lx2dwtROjBQXORHkwayL4O+4poaK+3O5f+bt7rYFS5pUBIXElCJ18dLEqk79p5
         ecd9DHkHcfn+6krT1skKgHdnV4i7P2KM+BAhFqvAklz84gZxiYVy9csrUzFZtrR0onkc
         0gHdlN9esZZnm+aKvN8Xk95qyLiA3bdnjvxHPQBEeROS7PRzCKvPEyVwnFiV8NfSaqnF
         x5J1ur4XkDv9nD4UM6FmNtAwsEn6SXqeam9ZSqRO1Mx58kd40qV83I8R7JS+am/1yzZN
         yEGkQ5GW8JUYoLt1XftqAIwjjYe3q/a6elxrf2KPFsNSznWZx31uIGpBu7l6AM+xn8LX
         Q8rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749812934; x=1750417734;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ttcsV2r/DbwKksmAX5EcenHls78sO7cykoW6Haqvciw=;
        b=e9UwngrREMOIvt5tTcy0YrgdHB7mEYE9FCHM9smbIIxvaTsi+uTDtUsEB4z86oDGwq
         O9IXmhW2WRq9EP+Zta9BNjEhoRuZYTT3XvJpdUej2WaoeEj210kHNUiuBEup4GbDaH3f
         bJkzMoel7pV+FPtPw8Y+KfxXxw5pLQQQFNDXDUsnv69Ida1YQzVarV2bHqh8UKdAX1DO
         iBUHo2nfuJ33upjZFmOvEW7czO6TXV0jf41Qhrwkr3u8QcPS2XXlpvuP/i85UqEjWfKj
         GF7j1/tD9alMUdBSZXew3Gt0qj/2Llv92JFJN/u10ZdTw0NUkaOqrcLZw2PQY4GbNDqU
         xqBQ==
X-Forwarded-Encrypted: i=1; AJvYcCWG/XDfyq/KJjsjs9sablJ2Wb+T0UAY8kxkHfv0SMpzCCCE41qRUExtE+ZMeBGmHgv5ZxE9HjP46UlHlWo=@vger.kernel.org, AJvYcCXfI5SMArcQ4W6US/ISwSeP1xH5DJrKRAWhXyYX86vb8OXhTcavWRYy1A1JBCvdLyYaiOcO2Ad4RKsZm2yP@vger.kernel.org
X-Gm-Message-State: AOJu0YwZGR7EMwOWCF+GtxsYulQHYbNOe7AE6qrXpbI5h+afCRiygfrz
	GwrsPe8YsyEUNNTLUyjEsnf8Sbg4Pfq1U5MhwQZ28vWTpHU4A34vi2gT
X-Gm-Gg: ASbGncvWlm0cAmczOYP1Ka9+2UNGfEMq5Sa7UJcuI5hxS0koiGpsaAY53PSMNNqQ+jM
	6TEV1h0/x2xkNI2MeNKPx2RcW321kQEeBFsAp27Jz26hQ4B4wcOIiE/LCnBAY9Q44UotW6saObU
	4/qYULKIy9f+OlSxro2wQc5yrypmCbf/FGPJVGLXmH0GH3Jdt0V9ta0D0+A7XR15bAjpOPptyVb
	VPDJcw4fZ4nDVmt8Ga9aBTeRikCNFMIYMYvM5cecKpzLNaTi3brggDxsi88NwANKb0VKqzB8bKP
	Zt4mEI+ITu6ChOBvQql7Z6mJ8Dw/uaSgDqPr4kd7cgyYamesyuLTr3nfkCQcac3P8gZGADjj3Vi
	uTMEKPsJJOhILZBUqcIwgF5vjOYNHuH5YTvA=
X-Google-Smtp-Source: AGHT+IGWnm6Dr3mStmJ9gtdzytIdOCSfspu+oWoJLNDTIybo8PSn2We1wxkZvKz4QAE8j7zCOxwbnQ==
X-Received: by 2002:a17:90b:1e07:b0:311:d28a:73ef with SMTP id 98e67ed59e1d1-313d9c35581mr4095368a91.10.1749812933633;
        Fri, 13 Jun 2025 04:08:53 -0700 (PDT)
Received: from ubuntu-Virtual-Machine.corp.microsoft.com ([2001:4898:80e8:b:d53a:6918:4c22:f91])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2365d8a19e3sm11894235ad.82.2025.06.13.04.08.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Jun 2025 04:08:53 -0700 (PDT)
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
Subject: [RFC Patch v2 2/4] drivers/hv: Allow vmbus message synic interrupt injected from Hyper-V
Date: Fri, 13 Jun 2025 07:08:27 -0400
Message-Id: <20250613110829.122371-3-ltykernel@gmail.com>
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

When Secure AVIC is enabled, Vmbus driver should
call x2apic Secure AVIC interface to allow Hyper-V
to inject Vmbus message interrupt.

Signed-off-by: Tianyu Lan <tiala@microsoft.com>
---
 drivers/hv/hv.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/hv/hv.c b/drivers/hv/hv.c
index 308c8f279df8..f78b46c51d69 100644
--- a/drivers/hv/hv.c
+++ b/drivers/hv/hv.c
@@ -20,6 +20,7 @@
 #include <linux/interrupt.h>
 #include <clocksource/hyperv_timer.h>
 #include <asm/mshyperv.h>
+#include <asm/apic.h>
 #include <linux/set_memory.h>
 #include "hyperv_vmbus.h"
 
@@ -310,6 +311,7 @@ void hv_synic_enable_regs(unsigned int cpu)
 	if (vmbus_irq != -1)
 		enable_percpu_irq(vmbus_irq, 0);
 	shared_sint.as_uint64 = hv_get_msr(HV_MSR_SINT0 + VMBUS_MESSAGE_SINT);
+	apic_update_vector(smp_processor_id(), vmbus_interrupt, true);
 
 	shared_sint.vector = vmbus_interrupt;
 	shared_sint.masked = false;
-- 
2.25.1


