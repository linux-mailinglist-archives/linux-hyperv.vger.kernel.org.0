Return-Path: <linux-hyperv+bounces-5383-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CB2AAAC54A
	for <lists+linux-hyperv@lfdr.de>; Tue,  6 May 2025 15:10:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2E7F63A9C74
	for <lists+linux-hyperv@lfdr.de>; Tue,  6 May 2025 13:07:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDDC828031E;
	Tue,  6 May 2025 13:07:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y1f7DWyR"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BD3228001A;
	Tue,  6 May 2025 13:07:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746536839; cv=none; b=icMnkgv0LqdIn6sreNLiVrkK6snEGErQhX1J/nTGJ9xcBloICiCof3vCAcZCSsMxqhpwqdehU0qPb+mdCjzj4xkdgS7xq8N+fL818w5V2lBpNUyfAConOyupE5NndRTJqZY5yGfkgrytG4/q3tErk7uqAkyKNU5jhRskMVV5Kz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746536839; c=relaxed/simple;
	bh=JmKdiZloNM3VMGsPht1pQ8yVN8oREN46C1IFpNnEQwk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=OjMW8hmYa3wG1EKWo+8q/1UIVu6UraSht53rV7O2Lvf4r4t2cz733Jmxr95ow1hfG/Ir1l9m3y9reoEW9UvQSlw8xlkA0nXz3s1qm2a5+so7RzVoKR2ktcx2RkQIZzOzypRTkK+lk+VjaDjr1yRECjzlGoq1jsmSKQugsMZY7AM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y1f7DWyR; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-22e45088d6eso8805245ad.0;
        Tue, 06 May 2025 06:07:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746536837; x=1747141637; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iijiH93GlGmb7Z/5hAIdem5+cBrqEfbp0KIWjv4SCvA=;
        b=Y1f7DWyRc8tLCBPlQfzBLwWiaoYm2RcWZOi1spjA1kHe412NgPDYlEt75ijSRnKaus
         a3xl31A2geEDyFdBCb3vYiLyi9NSin0Y+JBU5CIjBzX9SdEWM3CUxWXltXHw9cmuPVRZ
         zgsMYTz4I0PkB48RqPMj7UFoBvRKWDLpAKxIG1r/k1GgdpuWW90bfyVdAaJTn3eeDtac
         2OO6AfLOJml8a4RNt0jpHnVaxfpYziI/FQlMegfEoDlQ8Lk1G0ns51QUS7Gap+My7jiW
         c+RJ2VrWrneTYwKL8cuyc8TLZWTM6UzDAV4igAyDHjJr0Z9avs5QbiIc6Tt7q07dyyjh
         VhfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746536837; x=1747141637;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iijiH93GlGmb7Z/5hAIdem5+cBrqEfbp0KIWjv4SCvA=;
        b=w3QP1Os/u4MQ7UETSWI6HsPkjmiim7ZAEIfcEi7L3uPll4Vwwg31oIbWWgK5w3Mrbt
         C++cgFPoCD3H3Y12P/QGZOGlBy4PpUTwLcQsRRinFynDVV4bft/YIJYzKJIi+ZdK3Q4u
         jMuYW//6mJUfjXhQlVmA87Ts3xZtH966UXn7ca7lQoiwHoBX3+NwLq48Vvi5il88M9TY
         4SgiKnz4zrCGwXPoEzDHVJd3lrGrUMZO9hXI2iZX4mCiju7ET9zu3YEj8QjJPwTxEKvB
         tXggzzCK8z8d6zY6ozJtvue7p328yH8uqNZn1byP7AOkLw73UZ9YUtxKsNFft6GI+S90
         OvPg==
X-Forwarded-Encrypted: i=1; AJvYcCU5HWA033dNtsu5xZUUwT+h0nMO1WGTv31oQMSqx4EpcWNx6v7Ows0Jqzoh6GGSOjSCoic/EHI28LTUT+Q=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5RROOJx1kZIdIPQaU2xJy20nBOnc6XCtvx2mcDGskFKakrns+
	LN8qfmcuZ5SQgbbBAxDd3/KVRoJfDMCdN/6yfk1V+0wuWaAVEce0
X-Gm-Gg: ASbGncu6XXXzGN0HcemuSDW97wfhnkoTYeDIi4Zw6PeLdN5egO407jDMHU4fU3dGKDz
	LVvgnMHDpSfok2cij2M9lSla/XZZgc4PIZqaZVSnLlAEvf74vyNhq3ItgeWkaFkLqdWB7AkjYoS
	LTK76gNIoFAO4DYOzRetB5ZlK20maCqCAly3nx5XI9GjIIkrThAG2IS5BITjusEIycCeqswpWkm
	kRYr2zr3GP6XYrvP8i4icxGQp3/PT0vjtQBMx4eLtO3yHAMq8vo6i0C+uHuJQDkF27vo/J/94Qf
	LTgbJgO9kjF1+ekR0hMDTlU/fm/kvWJjAjLxZ6kHRIaR0sz00H7tSm9kAW0rmZ9Qoo/lM4y3gtq
	uuv9Yvg==
X-Google-Smtp-Source: AGHT+IGfc15e/a8GUYqzEhAbY4hb7bU8HXZMCh2jovqQ67PlJD8oWTrolWl+/lmXp+hOUAStzH8p8g==
X-Received: by 2002:a17:902:ecc1:b0:224:c76:5e57 with SMTP id d9443c01a7336-22e3637e732mr34585685ad.39.1746536837461;
        Tue, 06 May 2025 06:07:17 -0700 (PDT)
Received: from ubuntu-Virtual-Machine.corp.microsoft.com ([2001:4898:80e8:72:2835:d413:5ee2:7e6a])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22e15229384sm72628275ad.206.2025.05.06.06.07.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 May 2025 06:07:17 -0700 (PDT)
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
Subject: [RFC PATCH 3/6] drivers/hv: Allow vmbus message synic interrupt injected from Hyper-V
Date: Tue,  6 May 2025 09:07:08 -0400
Message-Id: <20250506130712.156583-4-ltykernel@gmail.com>
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

When Secure AVIC is enabled, Vmbus driver should
call x2apic Secure AVIC interface to allow Hyper-V
to inject Vmbus message interrupt.

Signed-off-by: Tianyu Lan <tiala@microsoft.com>
---
 drivers/hv/hv.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/hv/hv.c b/drivers/hv/hv.c
index 308c8f279df8..f77c1dc0e8d4 100644
--- a/drivers/hv/hv.c
+++ b/drivers/hv/hv.c
@@ -20,6 +20,11 @@
 #include <linux/interrupt.h>
 #include <clocksource/hyperv_timer.h>
 #include <asm/mshyperv.h>
+
+#if IS_ENABLED(CONFIG_AMD_SECURE_AVIC)
+#include <asm/apic.h>
+#endif
+
 #include <linux/set_memory.h>
 #include "hyperv_vmbus.h"
 
@@ -311,6 +316,10 @@ void hv_synic_enable_regs(unsigned int cpu)
 		enable_percpu_irq(vmbus_irq, 0);
 	shared_sint.as_uint64 = hv_get_msr(HV_MSR_SINT0 + VMBUS_MESSAGE_SINT);
 
+#if IS_ENABLED(CONFIG_AMD_SECURE_AVIC)
+	x2apic_savic_update_vector(smp_processor_id(), vmbus_interrupt, true);
+#endif
+	
 	shared_sint.vector = vmbus_interrupt;
 	shared_sint.masked = false;
 	shared_sint.auto_eoi = hv_recommend_using_aeoi();
-- 
2.25.1


