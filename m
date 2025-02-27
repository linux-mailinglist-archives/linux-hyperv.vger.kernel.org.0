Return-Path: <linux-hyperv+bounces-4092-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EFF21A4723A
	for <lists+linux-hyperv@lfdr.de>; Thu, 27 Feb 2025 03:22:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2C7403B2A8C
	for <lists+linux-hyperv@lfdr.de>; Thu, 27 Feb 2025 02:21:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB4D01D7995;
	Thu, 27 Feb 2025 02:19:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fef7FjLd"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 229D51BD9D0
	for <linux-hyperv@vger.kernel.org>; Thu, 27 Feb 2025 02:19:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740622757; cv=none; b=JtdkObTdWn5J1KwKwvSsXesyLmIMQkuUZcbV/SFM3FsLlE6lzWTznJIZPSWBcL6qzBH4+HD3Z7lzpuBla4PczEzw33MfIpVWPGbRsvC5q8itpTkgu36+uUgiMdaYGr9nfnLmP+BZfjCkF0akcLA/eqAsDDTGA+bi6lRfTFH06gM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740622757; c=relaxed/simple;
	bh=X5UL+eTktXYoDPfW4LhmVxWuD5wQW055Sxbi/QZyZe8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=pj+a6FDK8XCidRGNwhaYhhkM1pu3IzMBVq/cy3qQjND08gcaRqraSiSXFNeDPQMvFepc95KwabBdsMwdPLg3HW8+bkn59H8jNxobXputB3QXYoU9EPU+mU0zfYaJtdS7yC3ivL9z3U4uHMcIGZTonPj7hPQUZbs+xBkH+HQA/7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fef7FjLd; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-2fc1cb0c2cbso1525772a91.1
        for <linux-hyperv@vger.kernel.org>; Wed, 26 Feb 2025 18:19:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740622755; x=1741227555; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=YtBqucRQyVVjFtgUlGbh/U8C9xbSv2L/3t5kwpG/0fs=;
        b=fef7FjLdAGAJFHAV25KQWsC9t24sfQtyoidwN5PhExU2XZXQEHcBpReguAaITHeA2q
         euVkzCaUxnh9LnEd/DeVHueiSFgC48U8XOFiALyEo16At6ambnX0VOJMkcDU15wV4hF3
         zk8x9Mv5sfkkIB69g9s0MCeaXB9p2k9Fa1M+dFW1pasT5Dy0RIciAUEmWfkcpicm/oY6
         F3OJI5txJcOBanKjOnda7GPAL+1dGGB+UxbFzdFJ8pI9PhJ+2zZfIsCmEdqWbr3IPyQ/
         zPMgJfwb6fabO18/j/NRfzi/j3VtftBgDU9aJ7Sds2DYxf9xs5dUqTcKuGe1gJOPiBEY
         XuYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740622755; x=1741227555;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YtBqucRQyVVjFtgUlGbh/U8C9xbSv2L/3t5kwpG/0fs=;
        b=La1DMWf5lzpjVfuGUq90hFASuwSbk4d2kDbunHsjYcEooTlKQV6bceABw9xrFP7OJr
         d96Zn5yf2whPHKyUoUQ93pdUMqzfflAraxlEkC0Kq8ADv5uvuBc4IMJZgZF39MT8yIdw
         T+OqJ05/9WQMGFUR3zxXC8zBKnJ22HerBa34tvskA0uGDjWmyo7roqvCT43VfcUT3brK
         CcpgEQ+JNH3024rPOg2mzVJUlDE/HKLtCdg+jmSohDOr7A3qnbwl11IsoNSyYdwWhABp
         ZE6RyLZLm1fji22YsMWQDG1wqiAzJEZlB56Ju98BArVL3unzcdeHtTgrtEZjs6H2WXOS
         co4Q==
X-Forwarded-Encrypted: i=1; AJvYcCW7avb7IJ28JkTvVWnnVboVB+axp5U4A8FzSs9Bg70pZ8AI7SUc2aZtyJLDdsFSPcuhJXe2bMw4+Sf9CaM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwGMY7gpSy+2bDWFACuuZYugUhqVYjEkMk4beMorf8Ppy8qYB2V
	huBPJsAbfA4mZztHdfhtkdJxWtpA7f+xf3UidoaARBsB5QFkyDXcyq0qu8c8FWqI74QD0/F+hFm
	jXQ==
X-Google-Smtp-Source: AGHT+IH9Y0SwBcAS02xHNq+a4IakpnWSLKqVw4P68iCQM2m6waYT1AwLAOPZPnrjzYdSpJiao+kBYkSTr34=
X-Received: from pjb4.prod.google.com ([2002:a17:90b:2f04:b0:2ef:78ff:bc3b])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:2dc8:b0:2fa:ba3:5457
 with SMTP id 98e67ed59e1d1-2fe68ae6c4fmr17520974a91.17.1740622755379; Wed, 26
 Feb 2025 18:19:15 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Wed, 26 Feb 2025 18:18:23 -0800
In-Reply-To: <20250227021855.3257188-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250227021855.3257188-1-seanjc@google.com>
X-Mailer: git-send-email 2.48.1.711.g2feabab25a-goog
Message-ID: <20250227021855.3257188-8-seanjc@google.com>
Subject: [PATCH v2 07/38] x86/acrn: Mark TSC frequency as known when using
 ACRN for calibration
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

Mark the TSC frequency as known when using ACRN's PV CPUID information.
Per commit 81a71f51b89e ("x86/acrn: Set up timekeeping") and common sense,
the TSC freq is explicitly provided by the hypervisor.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kernel/cpu/acrn.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/kernel/cpu/acrn.c b/arch/x86/kernel/cpu/acrn.c
index c1506cb87d8c..2da3de4d470e 100644
--- a/arch/x86/kernel/cpu/acrn.c
+++ b/arch/x86/kernel/cpu/acrn.c
@@ -29,6 +29,7 @@ static void __init acrn_init_platform(void)
 	/* Install system interrupt handler for ACRN hypervisor callback */
 	sysvec_install(HYPERVISOR_CALLBACK_VECTOR, sysvec_acrn_hv_callback);
 
+	setup_force_cpu_cap(X86_FEATURE_TSC_KNOWN_FREQ);
 	tsc_register_calibration_routines(acrn_get_tsc_khz,
 					  acrn_get_tsc_khz);
 }
-- 
2.48.1.711.g2feabab25a-goog


