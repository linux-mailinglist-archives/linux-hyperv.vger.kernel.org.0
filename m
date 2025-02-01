Return-Path: <linux-hyperv+bounces-3816-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F41E1A246A7
	for <lists+linux-hyperv@lfdr.de>; Sat,  1 Feb 2025 03:20:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6062618860E8
	for <lists+linux-hyperv@lfdr.de>; Sat,  1 Feb 2025 02:20:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4297419D067;
	Sat,  1 Feb 2025 02:17:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fjs4n93V"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9430E189B8F
	for <linux-hyperv@vger.kernel.org>; Sat,  1 Feb 2025 02:17:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738376265; cv=none; b=K3Xy7+sqKZI+lXbMLz69kTcfz/Za6//3sH59sHNNlDpdjpk6IHJBWNcvdcP6+MQOIK5nATL6P5rUjA3uUmrC+Lb45qCaKjDOS7uOiR7hwn35nknJWwp6AbpRfTfgmy7iYa1VoG/1VSq89SPA7gD0eduvI04f2QLblJXiGGCR+44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738376265; c=relaxed/simple;
	bh=SMb+ptqn3Y2lAemdJfa8mzgfJB25QAWQ7cmu+kYKQzc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=fj7x9atIOyCmGgM/ghe9Edn2KbtZW8qREh93SXjv9cfnWv1R9HlZ4/f7LpJyFsP8a1nEySlFvCCzFNnxBuibuiglndLUvHekke20f9dciNu/W/VXFEOJm+p4Nb47BUzHMQg06NSuIHlO3bXqF8dVEWwZ+hchZZSOgvGNQdIYBtM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fjs4n93V; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-2ef9864e006so7283049a91.2
        for <linux-hyperv@vger.kernel.org>; Fri, 31 Jan 2025 18:17:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1738376263; x=1738981063; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=T4DEhCWG0SuSvz0a+mPR7euxpU0fSN+tQ/CkCS9MqCY=;
        b=fjs4n93VSxxTFtsT1CdCYXluuJhttoGgBXKCZxmAtD44Oii4XE++21RCHxMhwV5DVe
         /IUDAyyan5YgKx9IdDMnyPS70Zdwr1PYcaXE0T8os/NPnwHAGOEExT4VF0Rv4sON2BhD
         oXUggauFBGR85HieWhZ7xikuKMnZM3I71vUcSFNGE/jY0EMNGWb/5OH0E9rnTx3eogyd
         Yw9Y9R7Op1WuZVqqrPjIDBuGt2ZzT8l7XUtE6y8X1ChJcl0kRhrkJoOEeDreFeFKm5rl
         1FH0VtCmvvUPVjFlvjKSaQ/j7tvhmQdjdCLKVtYjHcfM82wtfp7NPqJJHcTCssoYIg+G
         4fcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738376263; x=1738981063;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=T4DEhCWG0SuSvz0a+mPR7euxpU0fSN+tQ/CkCS9MqCY=;
        b=chc4wRgpL7Y/tY6iIOmJ34C0N/f9VqFXr3DSPL9Y7hjD3ZnSGy/Ue9EqHzlht7xNsv
         iyO/ZLvHfZL0pkOCpxXe03gG77vyPM+oPH9DdyzyjuiSAo4v0MMWzo9Cx5lJACYLuLbu
         3lg2LhhQ3BZWNiQJwoPbppmaM6xmevm/PhdQ62jP/wFjguye71VhTXxMN11aRXODeuO2
         aYSdwCWtiGZrO4bLdB/fDuAqXlNR++pqeMt6Ln+X5bJ361YqtflNHRORxgal95c7x+9v
         HE0jY0HEmqABUO9UC9uUB6xRrwG0SO6u3SY7yYu9FFTr+fm7YP2TvSNqkBLCV1iep1te
         T3ag==
X-Forwarded-Encrypted: i=1; AJvYcCVO5TX2JHE6VTeX/Xov98ESCw4pI9D0Ljb1U9tdBTK02yT/rq+Nvq8qiKod1DfCuu2STQVpfRa4RyU+B+k=@vger.kernel.org
X-Gm-Message-State: AOJu0YyfmoYf8RsnzB2D27qJUdoUxMTHmRpPTcrFStiT8h8egKlZoaby
	ZmAZd0eHwaoiJo1nB2sNUkXs4fCx+aG3T1+8WRLkZrzwVwKRss1szJtcxN3CBJE1nGhGlDtnGoL
	3ww==
X-Google-Smtp-Source: AGHT+IHof1w34LjQ30XVM2gwsfD2n69eJy7Rgvm5USApfq7itvhXgigdwO4D30qo87G/8bS8xHYNlWrIUTM=
X-Received: from pjd6.prod.google.com ([2002:a17:90b:54c6:b0:2e2:9f67:1ca3])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:51c1:b0:2ea:7cd5:4ad6
 with SMTP id 98e67ed59e1d1-2f83ac86a44mr17727640a91.32.1738376263046; Fri, 31
 Jan 2025 18:17:43 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri, 31 Jan 2025 18:17:11 -0800
In-Reply-To: <20250201021718.699411-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250201021718.699411-1-seanjc@google.com>
X-Mailer: git-send-email 2.48.1.362.g079036d154-goog
Message-ID: <20250201021718.699411-10-seanjc@google.com>
Subject: [PATCH 09/16] x86/tsc: Rejects attempts to override TSC calibration
 with lesser routine
From: Sean Christopherson <seanjc@google.com>
To: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, Juergen Gross <jgross@suse.com>, 
	"K. Y. Srinivasan" <kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, 
	Dexuan Cui <decui@microsoft.com>, Ajay Kaher <ajay.kaher@broadcom.com>, 
	Alexey Makhalov <alexey.amakhalov@broadcom.com>, Jan Kiszka <jan.kiszka@siemens.com>, 
	Paolo Bonzini <pbonzini@redhat.com>, Andy Lutomirski <luto@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>
Cc: linux-kernel@vger.kernel.org, linux-coco@lists.linux.dev, 
	virtualization@lists.linux.dev, linux-hyperv@vger.kernel.org, 
	jailhouse-dev@googlegroups.com, kvm@vger.kernel.org, 
	xen-devel@lists.xenproject.org, Sean Christopherson <seanjc@google.com>, 
	Nikunj A Dadhania <nikunj@amd.com>, Tom Lendacky <thomas.lendacky@amd.com>
Content-Type: text/plain; charset="UTF-8"

When registering a TSC frequency calibration routine, sanity check that
the incoming routine is as robust as the outgoing routine, and reject the
incoming routine if the sanity check fails.

Because native calibration routines only mark the TSC frequency as known
and reliable when they actually run, the effective progression of
capabilities is: None (native) => Known and maybe Reliable (PV) =>
Known and Reliable (CoCo).  Violating that progression for a PV override
is relatively benign, but messing up the progression when CoCo is
involved is more problematic, as it likely means a trusted source of
information (hardware/firmware) is being discarded in favor of a less
trusted source (hypervisor).

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kernel/tsc.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/x86/kernel/tsc.c b/arch/x86/kernel/tsc.c
index 47776f450720..d7096323c2c4 100644
--- a/arch/x86/kernel/tsc.c
+++ b/arch/x86/kernel/tsc.c
@@ -1260,8 +1260,13 @@ void tsc_register_calibration_routines(unsigned long (*calibrate_tsc)(void),
 
 	if (properties & TSC_FREQUENCY_KNOWN)
 		setup_force_cpu_cap(X86_FEATURE_TSC_KNOWN_FREQ);
+	else if (WARN_ON(boot_cpu_has(X86_FEATURE_TSC_KNOWN_FREQ)))
+		return;
+
 	if (properties & TSC_RELIABLE)
 		setup_force_cpu_cap(X86_FEATURE_TSC_RELIABLE);
+	else if (WARN_ON(boot_cpu_has(X86_FEATURE_TSC_RELIABLE)))
+		return;
 
 	x86_platform.calibrate_tsc = calibrate_tsc;
 	if (calibrate_cpu)
-- 
2.48.1.362.g079036d154-goog


