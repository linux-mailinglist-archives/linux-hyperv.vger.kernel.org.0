Return-Path: <linux-hyperv+bounces-4100-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 674B0A47267
	for <lists+linux-hyperv@lfdr.de>; Thu, 27 Feb 2025 03:25:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 09FAC165FA0
	for <lists+linux-hyperv@lfdr.de>; Thu, 27 Feb 2025 02:23:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE1891EFFB9;
	Thu, 27 Feb 2025 02:19:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YyyjItTo"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E27F11EB5EB
	for <linux-hyperv@vger.kernel.org>; Thu, 27 Feb 2025 02:19:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740622771; cv=none; b=TP4WHH673LHN/jh18SMAPTP4/tCNQk73NdQVAhjGkXpXEtimQ7LlusZ10o3lOdchLoD2vhsC13gGEpHmxjDhdRVSwN2LQRWzOwPGz1bCqappaMLEYjsyHS3Ml5tPywZZPt0VHCjw6ut7SaQIqJgpuUjmfJpnBL6jfAhy2NsSwE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740622771; c=relaxed/simple;
	bh=qrmPmOcptAmLgQCle3N1kl8WrTK3PJ1AWETKMFIpJ6A=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=KUm5J6hR/GyyDyqhD1TM0GxKKS5eGsRCHGkwyxMiZXNA+QH4S8ugjATWO1LSEUWRWChB/5bgzZR0flB5H8uIKt2pF2BAl84K+12vGgFl6J8femOmPk3GmvyQXrys6YXyubaqLUoDLqTC9EZ6Yi12j4WVn6CWSYN7Gv5s3Hdiq5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=YyyjItTo; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-2fc1a4c14d4so1063819a91.0
        for <linux-hyperv@vger.kernel.org>; Wed, 26 Feb 2025 18:19:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740622769; x=1741227569; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=4/yyaam3CnBmuwJ2ykq85CXFFo+ZsEjkVRvpD/uHncQ=;
        b=YyyjItToezQre9Sp01FKz3/7BsTNQhUdFKJMw2FCdGitER6cRnXEiuR7eMqIFgv4zC
         PLy6jO7yEgX0/h7b4T4480H5nNOVyoMeImsS77tMwMKZrrjMNqQIQfPKp0Iv7FumPaQK
         bWD/p7tGewBNhN/NL3DiD6yQcpmzqEIqrJvJE57/KdS0d2Msc1qMh2xcpYB7Gb+H22iV
         DUMuS3CztnCUtLtwLuv77Dpel0sFQDymf6jrKezXH3NftvLI46FWf3eLzgvzIpQMyhHU
         0/HPDoqeCT1joGoj4juYfoSnNmkbGynN6PXOHEJPfg8feaXrpAMyeWDgvmmYxwEYLTrK
         VvoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740622769; x=1741227569;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4/yyaam3CnBmuwJ2ykq85CXFFo+ZsEjkVRvpD/uHncQ=;
        b=ScrVyQlmTgcf8yhVc+GG4JVG1/221rbZsL87YSLkSerSzSupBWx1N36rej9dt9TXq8
         S8W55grrB0/jO2Xeno3zGernmsO6+SINJ429Jc+pGnq9cCQBVq1MyoCAnXSGs/WNkFCQ
         d5MvQlBluE1Xpt1GS+Tqvn6symFMn2ZWB8DFWXeP0eWOYyDh8KaHCq/uHXJ8UUmufmbP
         2QKFxXVojCSuRuVEp7NBwajqpoh2ueCWQjRrGpzqm7FYCDh+22iK/afiQe8tNv9aHzXi
         wWOIHoD5ztGJ7IXukXRHBIE6vFtsME1w5VYXYc7NnNjt1rrt0hIVUS+nfwZmBfY+5l6y
         NwnQ==
X-Forwarded-Encrypted: i=1; AJvYcCUHoJMsQjHjDdUJJa4itp7ytzZw21Ov8LSyZqe6I6Ft+rn/gPgQ7ENsFW63JK6GBpiF/XESRyMAgh8C/EM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxbEGGnVjsiSPan0wvADCQyGMHysj3xeJ7CKfGX1U1zOovDiUG5
	ruNxFsQFXiphp1ohMMCt6Zv9aAcDOFTB5a77EPnKUlehqgippFmmuxTQz8ZwCLTpi5CZXzLyuPm
	3Wg==
X-Google-Smtp-Source: AGHT+IHB6t2yNhuRRLSjnQcCsiQss9r1P7c1nIVM64h4xrkl38FU8N4jisiF+hTwqGE4B/+REyTZDinhF2Y=
X-Received: from pjbqb10.prod.google.com ([2002:a17:90b:280a:b0:2e0:915d:d594])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:280c:b0:2ee:5bc9:75c7
 with SMTP id 98e67ed59e1d1-2fe68ac9330mr14041142a91.5.1740622769336; Wed, 26
 Feb 2025 18:19:29 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Wed, 26 Feb 2025 18:18:31 -0800
In-Reply-To: <20250227021855.3257188-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250227021855.3257188-1-seanjc@google.com>
X-Mailer: git-send-email 2.48.1.711.g2feabab25a-goog
Message-ID: <20250227021855.3257188-16-seanjc@google.com>
Subject: [PATCH v2 15/38] x86/xen/time: Nullify x86_platform's sched_clock
 save/restore hooks
From: Sean Christopherson <seanjc@google.com>
To: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Sean Christopherson <seanjc@google.com>, Juergen Gross <jgross@suse.com>, 
	"K. Y. Srinivasan" <kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, 
	Dexuan Cui <decui@microsoft.com>, Ajay Kaher <ajay.kaher@broadcom.com>, 
	Jan Kiszka <jan.kiszka@siemens.com>, Andy Lutomirski <luto@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, 
	John Stultz <jstultz@google.com>
Cc: linux-kernel@vger.kernel.org, linux-coco@lists.linux.dev, 
	kvm@vger.kernel.org, virtualization@lists.linux.dev, 
	linux-hyperv@vger.kernel.org, xen-devel@lists.xenproject.org, 
	Tom Lendacky <thomas.lendacky@amd.com>, Nikunj A Dadhania <nikunj@amd.com>
Content-Type: text/plain; charset="UTF-8"

Nullify the x86_platform sched_clock save/restore hooks when setting up
Xen's PV clock to make it somewhat obvious the hooks aren't used when
running as a Xen guest (Xen uses a paravirtualized suspend/resume flow).

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/xen/time.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/x86/xen/time.c b/arch/x86/xen/time.c
index 9e2e900dc0c7..51eba986cd18 100644
--- a/arch/x86/xen/time.c
+++ b/arch/x86/xen/time.c
@@ -565,6 +565,12 @@ static void __init xen_init_time_common(void)
 	xen_sched_clock_offset = xen_clocksource_read();
 	static_call_update(pv_steal_clock, xen_steal_clock);
 	paravirt_set_sched_clock(xen_sched_clock);
+	/*
+	 * Xen has paravirtualized suspend/resume and so doesn't use the common
+	 * x86 sched_clock save/restore hooks.
+	 */
+	x86_platform.save_sched_clock_state = NULL;
+	x86_platform.restore_sched_clock_state = NULL;
 
 	tsc_register_calibration_routines(xen_tsc_khz, NULL);
 	x86_platform.get_wallclock = xen_get_wallclock;
-- 
2.48.1.711.g2feabab25a-goog


