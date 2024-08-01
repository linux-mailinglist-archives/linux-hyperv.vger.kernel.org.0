Return-Path: <linux-hyperv+bounces-2651-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E8E799452F0
	for <lists+linux-hyperv@lfdr.de>; Thu,  1 Aug 2024 20:40:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A2D28283452
	for <lists+linux-hyperv@lfdr.de>; Thu,  1 Aug 2024 18:40:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C4771494A4;
	Thu,  1 Aug 2024 18:40:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KbV9Ee+M"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCF5C13D889
	for <linux-hyperv@vger.kernel.org>; Thu,  1 Aug 2024 18:40:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722537603; cv=none; b=UkDvTAVkn1+E9U0bE+9wOTEpbSAOvcEewr3sTkqtbD3uRC2q1B+DnPsyYslEV11TmgzO3DIgXalvfwVvXF8pQGVUFpEvbYWs0Shq2MJIMV8atw8LzuqRvYF5Hp8JE8K4DH0GqcxQ7qMzJGjroQIAqyHK8DvBQvujCbBrrzJMHxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722537603; c=relaxed/simple;
	bh=v3ngMtvWawUbNngrsCnmsU9HoWKp4/snJm8LhI4ZsL0=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=j3Plzg/5oyKZSYviCRVB54cK+w9I0RCQR60jfF2BbGPw86LyJWyjo41UA/DWoeJ02gr6XS4mSJpzRULweVgQhaosZXF834CSfmONlTbqwenI6DztKnkYdvoQnJI/ema/IyAgNm3VQVB2X3vLGSe7nlzCoy3fnz/7j4SXX/QnSuw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--yosryahmed.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=KbV9Ee+M; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--yosryahmed.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-666010fb35cso40386007b3.0
        for <linux-hyperv@vger.kernel.org>; Thu, 01 Aug 2024 11:40:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1722537601; x=1723142401; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=T6yPRhC8+VoSP5QSl7WqotG6f6x/q7DmyfyOAFIfGXQ=;
        b=KbV9Ee+MtjGJK1M4YAjAMLV3ULX7QteAlLM+xkVtQ+G87phsLuSszTOxbVLq1SZrN7
         ZhOsRgsCVXgzb8+G+EW11lHLfn8xKdESGbnDBTK4N4YlI+cFx2vg2BntPcHssnVfnTCG
         fMel8f7pcPTnxZq1xthPjlpI9OdEEiKrOXWC8MOzn8Ns/pp3Diz/CZLbJmu5BfUgiAfh
         DS3rhJ1z8rA0Z67GeIxEhCNG0KYrXPV/GSExTH+D9dgRz25Fb67PNhXRymZXz3rjEAJK
         MHO3Wqz3wYYcqMNhRe0VVv9ZCkfANUdEo2WxSAqKkGdPdjHS+KUlIgwQ6t8GObJsSVb/
         q4mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722537601; x=1723142401;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=T6yPRhC8+VoSP5QSl7WqotG6f6x/q7DmyfyOAFIfGXQ=;
        b=PW1LFQPxw+OyO9f6xGB52RU5br8NTKoV7tySHJMHdhIwwFpJej9lQLPa3h233RK9lv
         QFFfN+sZVtqfuy+eqsRXvsmAOM6sM8RPW4G9W6qUWRcnH+yCuqzPhn3yItztlqeV3V2o
         rUDNQqv+yIfoezi9E4pe+b29ihkd8B4WkGFGOKfXfG2rJ5g9uLENA0SOyog0g0ak5tKm
         hKzzNJ+cHVcb2zL/JPBGh2Ew3tZLOSqQJ26Ne5NtLKCNqY15CYd/pxUV3NpwPOZ9+sJ0
         aoTtUR0zfmV09ntqxQUmUqhOpJjZ9189sIPiFjLE8YLbyug/Jhk7pV2LYMTeQRKMK1yl
         W2IA==
X-Forwarded-Encrypted: i=1; AJvYcCU2armxUeudeSwTfhiwU98BpIi1ijlB2Jhu3QDtw5xXHtZV7thIOHkS2ZwP9HcMWA23QrRPzGfUp+clWFRO9i//DkS/YH7Pz16GNYq0
X-Gm-Message-State: AOJu0YwcYbfRskUMIFNATfr56ihsk0ydNrQc7phXRcvDqMD1Ei3FIsXU
	7zoYp/IBbB0oTk89MDj+g4ldn5ysebIzywKLN76Rdoggh34ix4vq+kl/RH22LGcNp5DkO/ri3We
	mOMqzJfqmws1NM2uDaA==
X-Google-Smtp-Source: AGHT+IHYOqsisgtCA4aJn8iiJrhlOqWcWkXhmH+zVo7bk8yf1CWdZe9U3mUn5G8dyhc0nxA756eyNP+k6DuS+1MQ
X-Received: from yosry.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:29b4])
 (user=yosryahmed job=sendgmr) by 2002:a05:690c:dc7:b0:64b:2608:a6b9 with SMTP
 id 00721157ae682-689643921c3mr457477b3.3.1722537600846; Thu, 01 Aug 2024
 11:40:00 -0700 (PDT)
Date: Thu,  1 Aug 2024 18:39:58 +0000
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.46.0.rc2.264.g509ed76dc8-goog
Message-ID: <20240801183958.2030252-1-yosryahmed@google.com>
Subject: [PATCH] x86/hyperv: use helpers to read control registers in hv_snp_boot_ap()
From: Yosry Ahmed <yosryahmed@google.com>
To: "K. Y. Srinivasan" <kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>, 
	Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Yosry Ahmed <yosryahmed@google.com>
Content-Type: text/plain; charset="UTF-8"

Use native_read_cr*() helpers to read control registers into vmsa->cr*
instead of open-coded assembly.

No functional change intended, unless there was a purpose to specifying
rax.

Signed-off-by: Yosry Ahmed <yosryahmed@google.com>
---
 arch/x86/hyperv/ivm.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/x86/hyperv/ivm.c b/arch/x86/hyperv/ivm.c
index b4a851d27c7cb..434507dd135c5 100644
--- a/arch/x86/hyperv/ivm.c
+++ b/arch/x86/hyperv/ivm.c
@@ -321,9 +321,9 @@ int hv_snp_boot_ap(u32 cpu, unsigned long start_ip)
 
 	vmsa->efer = native_read_msr(MSR_EFER);
 
-	asm volatile("movq %%cr4, %%rax;" : "=a" (vmsa->cr4));
-	asm volatile("movq %%cr3, %%rax;" : "=a" (vmsa->cr3));
-	asm volatile("movq %%cr0, %%rax;" : "=a" (vmsa->cr0));
+	vmsa->cr4 = native_read_cr4();
+	vmsa->cr3 = __native_read_cr3();
+	vmsa->cr3 = native_read_cr0();
 
 	vmsa->xcr0 = 1;
 	vmsa->g_pat = HV_AP_INIT_GPAT_DEFAULT;
-- 
2.46.0.rc2.264.g509ed76dc8-goog


