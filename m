Return-Path: <linux-hyperv+bounces-4120-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AC78A472DD
	for <lists+linux-hyperv@lfdr.de>; Thu, 27 Feb 2025 03:32:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C6290169F94
	for <lists+linux-hyperv@lfdr.de>; Thu, 27 Feb 2025 02:30:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09AFA23C8A9;
	Thu, 27 Feb 2025 02:20:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="yEKooXjh"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 373EE23ED53
	for <linux-hyperv@vger.kernel.org>; Thu, 27 Feb 2025 02:20:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740622805; cv=none; b=SFyhDEtbykslvhSMQikbf8dc3xCRHBwM6S00nclrnOL6UFwtP7iRaJ8ETkKjIjVMCOL/gAESk2tMH2ZQbHNQl164odL0UIpFc9ROzJfPVkgFzmrdHvYd5twIg9DLhq3OyDel4st636xFKRtaK7YDZ+hoYkxs/M/mfziC5yRJWHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740622805; c=relaxed/simple;
	bh=dSybtMuoZF9XQBwPnBkfo1UPLtlynUI+WZpyVl8WUu8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=TwF2blUth7IZNQ1nB83JTniyJ9yWW+QZcnZRfeQyDWcDi/1CIrLCEMCW7oirg2Mri2NcxkCPVpSPFyIjatYkgVkkJkBh5TQdqDBGR7ty+KSJpvhoeKy20FkDFMkcDt57g7RJBDOnby2lHWzXUSv7M5uY3T5gm07FaOIOp2TNlSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=yEKooXjh; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-2fc3e239675so1567629a91.0
        for <linux-hyperv@vger.kernel.org>; Wed, 26 Feb 2025 18:20:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740622804; x=1741227604; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=tqdKNUZqbb8d2CJvLoLFEQfT4OY26dkczDpR+rA3UIo=;
        b=yEKooXjhGutr0yoGJ9BYE8yYcdI1q/WwEB6uNmCnqyCCh1Ji3Yy7I1uCsFlMyj0iYr
         0apXVa/6iHPLT1FwbgsWr3UTdCKOTD/fsK1AgTGNv09yQWAdM+/xlXhRSOrFJPBfzcQd
         KsggSannwx1q0Zp32G5uOTze8iItLZH2c2dncTTJVQXa9gTAeEmCKu23I0dU8uk3NaiN
         0oLmwr6pKhoCw244suT0Yfn/hB8ujyqpW/kgRocDUqIKfrlcuMydOZyraUffXRh9gAV0
         Brnr7nMVbq+xFNiCf29SLBBQviWQLaHewFSk8HdAdpb05XNhn37SEY6Z56xCv/q0iQ0q
         0uVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740622804; x=1741227604;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tqdKNUZqbb8d2CJvLoLFEQfT4OY26dkczDpR+rA3UIo=;
        b=I+HBjubxcHFQyJbn4a1VIyvGQag5NS2Dcp+xVmUsrHKlpFkprA/7OuS+fJmatGA5qQ
         HfFIBH/Y8MmhB9pdW/J695bYAXbb+crsj6LkUvlVlgEZkbfLrxZVXECVLGPcYA4CCVmA
         vY/EKrlehnJMlOWaA1kdPlDN212DxWta8S8Le2YJ81MtCD4ZsbSS66Hc2+NtoPC2SS4J
         mdZy4YGECYbg0aKQrgQG/kRNK+IX6qm6oHV7UdgKYm/iOPSBOIguy2Kp+CWddpercKNF
         zDjTYqt5Lv2JCMjZdAVg+lGWXkpsr3brLJyqmtSstRruVixx4wBsol3SorYoXVTnZL8k
         kLVg==
X-Forwarded-Encrypted: i=1; AJvYcCWprMU2iu+XPoqPRHgC9c15clHomTPBx448uof5UGdcfUtcckNeGFFTZWSwX7UjBwww87jBm/oxZV89Q7Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YwNN6S4nMXfRA5C7XR+GAsoLsP8y0xKmPY27N16I7Gijlr3Dsdo
	UUjOk3m7sxKnyOyC72gQ0TK/IvwDNOGPDkq84/2iAANNXuKk8YVumQhlzrpccyjJkc6O8wJfQZS
	kzQ==
X-Google-Smtp-Source: AGHT+IGMz3bH4S0o1xgsITZANeNn+Z/tGuVwcYyVyvqnl2NMWrRx99tESpyiBKte9PgB4aGO5q0vwXh4uHk=
X-Received: from pjuj3.prod.google.com ([2002:a17:90a:d003:b0:2fc:b544:749e])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:3c84:b0:2fc:c262:ef4b
 with SMTP id 98e67ed59e1d1-2fce86cf0e0mr42953377a91.18.1740622803772; Wed, 26
 Feb 2025 18:20:03 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Wed, 26 Feb 2025 18:18:51 -0800
In-Reply-To: <20250227021855.3257188-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250227021855.3257188-1-seanjc@google.com>
X-Mailer: git-send-email 2.48.1.711.g2feabab25a-goog
Message-ID: <20250227021855.3257188-36-seanjc@google.com>
Subject: [PATCH v2 35/38] x86/kvmclock: Get TSC frequency from CPUID when its available
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

When kvmclock and CPUID.0x15 are both present, use the TSC frequency from
CPUID.0x15 instead of kvmclock's frequency.  Barring a misconfigured
setup, both sources should provide the same frequency, CPUID.0x15 is
arguably a better source when using the TSC over kvmclock, and most
importantly, using CPUID.0x15 will allow stuffing the local APIC timer
frequency based on the core crystal frequency, i.e. will allow skipping
APIC timer calibration.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kernel/kvmclock.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/arch/x86/kernel/kvmclock.c b/arch/x86/kernel/kvmclock.c
index c45b321533e5..3efb837c7406 100644
--- a/arch/x86/kernel/kvmclock.c
+++ b/arch/x86/kernel/kvmclock.c
@@ -188,6 +188,16 @@ void kvmclock_cpu_action(enum kvm_guest_cpu_action action)
 	}
 }
 
+static unsigned long kvm_get_tsc_khz(void)
+{
+	struct cpuid_tsc_info info;
+
+	if (!cpuid_get_tsc_freq(&info))
+		return info.tsc_khz;
+
+	return pvclock_tsc_khz(this_cpu_pvti());
+}
+
 static unsigned long kvm_get_cpu_khz(void)
 {
 	unsigned int cpu_khz;
@@ -211,11 +221,6 @@ static unsigned long kvm_get_cpu_khz(void)
  * poll of guests can be running and trouble each other. So we preset
  * lpj here
  */
-static unsigned long kvm_get_tsc_khz(void)
-{
-	return pvclock_tsc_khz(this_cpu_pvti());
-}
-
 static void __init kvm_get_preset_lpj(void)
 {
 	unsigned long khz;
-- 
2.48.1.711.g2feabab25a-goog


