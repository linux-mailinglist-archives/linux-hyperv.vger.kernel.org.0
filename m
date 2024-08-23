Return-Path: <linux-hyperv+bounces-2832-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 14EF695D93B
	for <lists+linux-hyperv@lfdr.de>; Sat, 24 Aug 2024 00:26:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 93A0FB218DA
	for <lists+linux-hyperv@lfdr.de>; Fri, 23 Aug 2024 22:26:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74AE31C8FA0;
	Fri, 23 Aug 2024 22:26:13 +0000 (UTC)
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19786191F6B;
	Fri, 23 Aug 2024 22:26:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724451973; cv=none; b=c/43JJ0/dT1cHLr1r1wlooE/OZOo2WqJQyyOI80MJzjO3hqfBQ1ruBu2zylpVUxWcRRlxcW256JKoPMU/OC/gIGwrNHb1tUeDAixGGsinSSsnuu2xlq69tp2zE/Pe5CXOSxPdM5PfN4HfmRjfB1J9qGZeAdo14GGC1hiDWyvRBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724451973; c=relaxed/simple;
	bh=eLCmEV3ljwLRxFocwTohCv1knJB6UKK5vBItWzRmJxY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZrR0u6+5ltt1SCN67tBfkf1xRRkyRiyuwKIASOGlPflkaX+84CK7YS8WvT9EzKIonjzBy588gpjG19s95UyYLubnAwO1xWAHBAJPZJWN/by/zsxyruz+/rEHlrWYN/bQzC5JiTI8j6HbFRMu+I46dm81zCPULhQNG+kXrnYah80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-7141b04e7a3so2044856b3a.3;
        Fri, 23 Aug 2024 15:26:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724451971; x=1725056771;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FdNQRWy4m/f1LqMofqJHKv4N0JPmy7Ex46RigXKn8ow=;
        b=sXPHWUJ4/iBLIQ85zWjRcS8i8TG4unMBOfXLUqzVxXAm7Wgs0hxkLiztweOy1w3VVw
         bZr9nelOHzGNQleBi807wOGGyslIAcbY94atvqAyJrFz7SmmZ+v+iGqxQ2sBdPHutf88
         AdUrJddM18tptOrQuI11qc3e+8DPyaWjPQDLZbJEAlIfJmv7Yt1AUkkrW1a/iY4wbZg7
         Y7qXzNVvZA9jTlr2wLVjDNhj/buBDlWXIxg4zHcNYKybpy3Ah4t66jbKy37dd1ozL99C
         PDXG9pagM2gNTkmBxmupo9P7cYTleH5xX+PlvZBzFIfeAFdIHcxJVRZuciplDwJqhZWh
         94Tg==
X-Forwarded-Encrypted: i=1; AJvYcCUqGqhB6hN5eI5qLjMyA7MGI3ARgYITGTEs64n+tTIayKSYoIfzaom6CW+/QDehm3FGZoj5ROlluGpPqAn4@vger.kernel.org, AJvYcCWP3opiNunMo1UwdxCTW8rgPAXzDB1JAKNpOvpZaXSjO9EYKLxehKVDeOPJX700yP96LWmWZJ6tP+mYhmU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxb0kUoXRH1euaytZyOxbEVANJXfRhasK3RZNdvdNnZO1gNGpC0
	hcRhvKoqBmJmQVr2VdtKG3TG5RqjktiACGmwV4rIDzIgBR5C8mEo
X-Google-Smtp-Source: AGHT+IHTY/45MOums/RrhmNxfIyjTZwPcT5SCZcRi5tBmMVFKliYHXyvHq9qcDI0G+8KI7zWdBwFTg==
X-Received: by 2002:a05:6a21:1191:b0:1c0:f5fa:cbe6 with SMTP id adf61e73a8af0-1cc89d7dca6mr3857291637.22.1724451971112;
        Fri, 23 Aug 2024 15:26:11 -0700 (PDT)
Received: from liuwe-devbox-debian-v2 ([20.69.120.36])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7cd9aca1193sm3222434a12.6.2024.08.23.15.26.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Aug 2024 15:26:10 -0700 (PDT)
Date: Fri, 23 Aug 2024 22:26:01 +0000
From: Wei Liu <wei.liu@kernel.org>
To: Yosry Ahmed <yosryahmed@google.com>
Cc: "K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>, linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] x86/hyperv: use helpers to read control registers in
 hv_snp_boot_ap()
Message-ID: <ZskMeWQfjQ00BTVm@liuwe-devbox-debian-v2>
References: <20240805201247.427982-1-yosryahmed@google.com>
 <CAJD7tkZTFNm3k3OM9G1qtd8-FyjKDvj5C-CPKvuS3AipKb7x8Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJD7tkZTFNm3k3OM9G1qtd8-FyjKDvj5C-CPKvuS3AipKb7x8Q@mail.gmail.com>

On Wed, Aug 14, 2024 at 04:54:32PM -0700, Yosry Ahmed wrote:
> On Mon, Aug 5, 2024 at 1:12 PM Yosry Ahmed <yosryahmed@google.com> wrote:
> >
> > Use native_read_cr*() helpers to read control registers into vmsa->cr*
> > instead of open-coded assembly.
> >
> > No functional change intended, unless there was a purpose to specifying
> > rax.
> >
> > Signed-off-by: Yosry Ahmed <yosryahmed@google.com>
> > ---
> >
> > v1 -> v2:
> > - Fixed a silly bug that overwrote vmsa->cr3 instead of reading
> >   vmsa->cr0.
> >
> > ---
> 
> Friendly ping on this, any thoughts?

Applied to hyperv-next. Thanks.

> 
> >  arch/x86/hyperv/ivm.c | 6 +++---
> >  1 file changed, 3 insertions(+), 3 deletions(-)
> >
> > diff --git a/arch/x86/hyperv/ivm.c b/arch/x86/hyperv/ivm.c
> > index b4a851d27c7cb..60fc3ed728304 100644
> > --- a/arch/x86/hyperv/ivm.c
> > +++ b/arch/x86/hyperv/ivm.c
> > @@ -321,9 +321,9 @@ int hv_snp_boot_ap(u32 cpu, unsigned long start_ip)
> >
> >         vmsa->efer = native_read_msr(MSR_EFER);
> >
> > -       asm volatile("movq %%cr4, %%rax;" : "=a" (vmsa->cr4));
> > -       asm volatile("movq %%cr3, %%rax;" : "=a" (vmsa->cr3));
> > -       asm volatile("movq %%cr0, %%rax;" : "=a" (vmsa->cr0));
> > +       vmsa->cr4 = native_read_cr4();
> > +       vmsa->cr3 = __native_read_cr3();
> > +       vmsa->cr0 = native_read_cr0();
> >
> >         vmsa->xcr0 = 1;
> >         vmsa->g_pat = HV_AP_INIT_GPAT_DEFAULT;
> > --
> > 2.46.0.rc2.264.g509ed76dc8-goog
> >

