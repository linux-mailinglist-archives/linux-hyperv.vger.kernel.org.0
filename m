Return-Path: <linux-hyperv+bounces-11839-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 8TYkDHTtS2pbdAEAu9opvQ
	(envelope-from <linux-hyperv+bounces-11839-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Mon, 06 Jul 2026 20:01:24 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id A227971437E
	for <lists+linux-hyperv@lfdr.de>; Mon, 06 Jul 2026 20:01:23 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=google.com header.s=20251104 header.b=aXRGKFRY;
	dmarc=pass (policy=reject) header.from=google.com;
	spf=pass (mail.lfdr.de: domain of "linux-hyperv+bounces-11839-lists+linux-hyperv=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="linux-hyperv+bounces-11839-lists+linux-hyperv=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 599F83030D6C
	for <lists+linux-hyperv@lfdr.de>; Mon,  6 Jul 2026 18:00:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3E5342A148;
	Mon,  6 Jul 2026 18:00:26 +0000 (UTC)
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F4DA42377E
	for <linux-hyperv@vger.kernel.org>; Mon,  6 Jul 2026 18:00:25 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783360826; cv=none; b=Uf8plO5Ysfdxrbw3AZ/oQbL3LQ7tdexLAuTgk5TbxfhoEfI1c3PP3bW8YLF+ObVbvh6Om3OEY/XNsuTJSkPjryEAZRc/abET8d0A7dgvv60ucloF61+vplyXhRhdS0yIXsj2cnMkoALtCAJjYBvbqyY+9pkJXNQH8FI2wJiKvPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783360826; c=relaxed/simple;
	bh=6HvxXL/hPWnIS2ERxITvaZCHswmXyfcfLFJrYY619nA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=gNhVT7yNOWaf8f6HyyvmNOIJdwUlak+vfV7a+MX27zrcY6rCC4V51x8Ig2GHVy1VY8oQC/p5+tzzp2ma5N5DzCZmVOfLfJzbaqHWJU+qV0m+t4jwjknWLhPaAvrTa6a6qQrY2K6GIOqDbA2RlrvZYzaNTQJZDSKK7sIlUYrHO/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=aXRGKFRY; arc=none smtp.client-ip=209.85.210.201
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-846f50381a6so2645878b3a.0
        for <linux-hyperv@vger.kernel.org>; Mon, 06 Jul 2026 11:00:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1783360825; x=1783965625; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=eYcfhMi5NCPMduPSvGqKtbO87FaKSq3RfhmI47bcB1U=;
        b=aXRGKFRYenZRjZGIwSdAJNreLpqh7yKNczUlKghcYwHUg7DkLUY88aYFDcEWam3BTV
         D0PqKMLZPWjM13nu6q4Ei0eHobHbiyrfJK+iSQWD8Mi8j2AU/T5a2owkWVdIeRZdkjSH
         NkH9OWVFZrQotIy0W6Vn1juvFI1jWaGVRePRwcH94yRXPLnERxdwpUy93lnN4cBzY3jp
         vy0ho9+fFAMUv61eu1jqYN7O7N5Y2qZDgZO0GP2eW9sp33Xv8f+9J+8ijifOwwLIy0vW
         JOM8w0NuKqtUhnOdqszYTSaFuN1y/okEPe9i19RloDZLELXWfdozCSP5nX6RBWdiadfI
         LhIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783360825; x=1783965625;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=eYcfhMi5NCPMduPSvGqKtbO87FaKSq3RfhmI47bcB1U=;
        b=bXD0AHA7adugOWk3lGWPTftf2ALZnLuhlVL8wTo2w3tl/EpEfQ7UYqfOtYZyzcM/k7
         o6/OJOOo9/bnUrYcrwZ7F8V3g/wUwBWIOmHMDe7bdZhrvOFGwU8c7yNprNJCDdIQySv6
         kYWS0PvrzE7JSppaTOXXpS8pFxVZXmdvIIOc2yFCXr7WkR4rtBSvdj2D3AoWnPdwYScn
         tBvj2yjCBX93U1TuzyKUTZQzdKvCxds2fmP6Qyk7HEKUPtzXk5XxIfYDSXyB2hxgxfE0
         Eix88BXGBq/wO9mgspxj5EWo/W5TEAenwBzV+urc+nQslbeQUNL/RYKAX+tDWfdeoqXQ
         0VMA==
X-Forwarded-Encrypted: i=1; AHgh+RrOTdYY8vaTMiiSUjYTLQINR5mOVWsple++Qy4SZj+Hfl15qcgLg8nfm4PdhsQenAVCUCclw+11Oz376Co=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5TutLM/YWeMMAgtdUvs7C4U+nuCJdzIFQu2QPapftN/dSJ1Ko
	6uZux5jIU+9OG9z1tUXjDZLt+4e2yrkw/sm8srZiAEJEo3f9O00GkU9MQXOZCRZUgz39CL0BV/Q
	3CY729w==
X-Received: from pgam14.prod.google.com ([2002:a05:6a02:2b4e:b0:c92:460e:4f73])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:4307:b0:847:8c6d:2f24
 with SMTP id d2e1a72fcca58-84826ec2591mr1691676b3a.56.1783360823962; Mon, 06
 Jul 2026 11:00:23 -0700 (PDT)
Date: Mon, 6 Jul 2026 11:00:23 -0700
In-Reply-To: <SN6PR02MB41578D3C34AB283B892C27A4D4F52@SN6PR02MB4157.namprd02.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260701193212.749551-1-seanjc@google.com> <20260701193212.749551-2-seanjc@google.com>
 <SN6PR02MB41578D3C34AB283B892C27A4D4F52@SN6PR02MB4157.namprd02.prod.outlook.com>
Message-ID: <akvtN7aIjZ7gOq4o@google.com>
Subject: Re: [PATCH v5 01/51] x86/apic: Provide helpers to set local APIC
 timer period in hz and khz
From: Sean Christopherson <seanjc@google.com>
To: Michael Kelley <mhklinux@outlook.com>
Cc: Jonathan Corbet <corbet@lwn.net>, Paolo Bonzini <pbonzini@redhat.com>, 
	Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, "x86@kernel.org" <x86@kernel.org>, 
	Kiryl Shutsemau <kas@kernel.org>, Rick Edgecombe <rick.p.edgecombe@intel.com>, 
	"K. Y. Srinivasan" <kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, 
	Dexuan Cui <decui@microsoft.com>, Long Li <longli@microsoft.com>, 
	Ajay Kaher <ajay.kaher@broadcom.com>, Alexey Makhalov <alexey.makhalov@broadcom.com>, 
	Jan Kiszka <jan.kiszka@siemens.com>, Andy Lutomirski <luto@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Juergen Gross <jgross@suse.com>, 
	Daniel Lezcano <daniel.lezcano@kernel.org>, John Stultz <jstultz@google.com>, 
	Shuah Khan <skhan@linuxfoundation.org>, "H. Peter Anvin" <hpa@zytor.com>, 
	Vitaly Kuznetsov <vkuznets@redhat.com>, 
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, 
	Boris Ostrovsky <boris.ostrovsky@oracle.com>, Stephen Boyd <sboyd@kernel.org>, 
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"linux-coco@lists.linux.dev" <linux-coco@lists.linux.dev>, 
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>, 
	"virtualization@lists.linux.dev" <virtualization@lists.linux.dev>, 
	"xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>, Tom Lendacky <thomas.lendacky@amd.com>, 
	Nikunj A Dadhania <nikunj@amd.com>, David Woodhouse <dwmw@amazon.co.uk>, 
	David Woodhouse <dwmw2@infradead.org>, Thomas Gleixner <tglx@linutronix.de>
Content-Type: text/plain; charset="us-ascii"
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	MV_CASE(0.50)[];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[41];
	FORGED_RECIPIENTS(0.00)[m:mhklinux@outlook.com,m:corbet@lwn.net,m:pbonzini@redhat.com,m:tglx@kernel.org,m:mingo@redhat.com,m:bp@alien8.de,m:dave.hansen@linux.intel.com,m:x86@kernel.org,m:kas@kernel.org,m:rick.p.edgecombe@intel.com,m:kys@microsoft.com,m:haiyangz@microsoft.com,m:wei.liu@kernel.org,m:decui@microsoft.com,m:longli@microsoft.com,m:ajay.kaher@broadcom.com,m:alexey.makhalov@broadcom.com,m:jan.kiszka@siemens.com,m:luto@kernel.org,m:peterz@infradead.org,m:jgross@suse.com,m:daniel.lezcano@kernel.org,m:jstultz@google.com,m:skhan@linuxfoundation.org,m:hpa@zytor.com,m:vkuznets@redhat.com,m:bcm-kernel-feedback-list@broadcom.com,m:boris.ostrovsky@oracle.com,m:sboyd@kernel.org,m:linux-doc@vger.kernel.org,m:kvm@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-coco@lists.linux.dev,m:linux-hyperv@vger.kernel.org,m:virtualization@lists.linux.dev,m:xen-devel@lists.xenproject.org,m:thomas.lendacky@amd.com,m:nikunj@amd.com,m:dwmw@amazon.co.uk,m:dwmw2@infradead.org,m:tglx@linutronix.d
 e,s:lists@lfdr.de];
	FREEMAIL_TO(0.00)[outlook.com];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[seanjc@google.com,linux-hyperv@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-11839-lists,linux-hyperv=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[seanjc@google.com,linux-hyperv@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[google.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[linux-hyperv];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: A227971437E

On Thu, Jul 02, 2026, Michael Kelley wrote:
> > @@ -796,6 +796,16 @@ bool __init apic_needs_pit(void)
> >  	return lapic_timer_period == 0;
> >  }
> > 
> > +void apic_set_timer_period_khz(u64 period_khz, const char *source)
> > +{
> > +	lapic_timer_period = mul_u64_u32_div(period_khz, 1000, HZ);
> > +}
> > +
> > +void apic_set_timer_period_hz(u64 period_hz, const char *source)
> > +{
> > +	lapic_timer_period = div_u64(period_hz, HZ);
> > +}
> 
> A string "source" argument is passed in, but not used. Is there an
> envisioned future use? Also, this function doesn't output a pr_info()
> message like the existing Hyper-V and VMware code does. 

It was a complete goof on my part (Sashiko also pointed out the oddity[*]).  I
fully intended to log a message and provide equivalent Hyper-V/VMware behavior,
and totally spaced it.

[*] https://lore.kernel.org/all/20260701194621.4BD691F000E9@smtp.kernel.org

> I don't know that the message is all that useful, though I do remember one
> case where I was debugging some clock/timer issue when I looked at it. 


