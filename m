Return-Path: <linux-hyperv+bounces-1104-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 479647FBF3D
	for <lists+linux-hyperv@lfdr.de>; Tue, 28 Nov 2023 17:34:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 01499282934
	for <lists+linux-hyperv@lfdr.de>; Tue, 28 Nov 2023 16:34:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1B695E0A1;
	Tue, 28 Nov 2023 16:33:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NaNNIfLg"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F2FB10E6
	for <linux-hyperv@vger.kernel.org>; Tue, 28 Nov 2023 08:33:54 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-db3ef4c7094so6788686276.1
        for <linux-hyperv@vger.kernel.org>; Tue, 28 Nov 2023 08:33:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701189233; x=1701794033; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=vo/95/Uj9Fg4uJeKo+eJAx6dpBh0gdcUuvBHqXATckU=;
        b=NaNNIfLgB93VcUkI9OpjV5L9tEcnng14sJr3vjy0Q0Z1j8TSQS7jFTvfS6Qk+vhNH9
         IftTXZYyVs24Tm/f9sEZeWtq2MdPFTNlZmHeWvfzjQlkGq3zyUztRufC+Ae/f+HK/9pQ
         tDW25YoSaXzX0dUundpAGiO7c2s2UjOdiP4rOK/CgTFEGg+KKcLpiI68c7v4QjYTmKO9
         xIgCqxej0Yv4rg2ceCMe2b9DP+/uBcijwB+Car0nsTvaFB+R9MgJNOUSOnXbjqq17z7/
         srTEWRmqK+1/pxlBb/oJMm5/e3L8+PxUJXDG4if1Mqx3mm8CRfClJqrzku7EmUWx9PIi
         xjdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701189233; x=1701794033;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vo/95/Uj9Fg4uJeKo+eJAx6dpBh0gdcUuvBHqXATckU=;
        b=CpbSE92qucj4LfVHdqMtd5cAe//8WhrgaKiJJdxOQUHeYTyKhNEuzPZZDaAvqJgBEZ
         d02uoD1yjQvD5ehQTjd+RyITu42tu43+n1577u6yCv/nio8/lsw3FnHuBrGKiURE7Lzs
         YO35QvjPiXcmMbjUzab7jWBJNiaj5pA/ygVyT7ivYy3PVFSbUviEYqUAY4ahmlgsCPiv
         /aivRUxOwrtUVaxTMUPVScb8D/QtyrVb6JYjH+1L7XmWDgjB/UWDjaj+rh8rd/dU+m2B
         rQNqqzDQBpgnQbqXKgWNGRKJpPBNcFABTASU9P4VRAWiltpDEzZprEpnRkYDihHfBL8o
         4FvQ==
X-Gm-Message-State: AOJu0YxX6m9cO2QDfiuOlldWJkAFZn8bkX9Knjvs8N/Cif+HSlOFeol+
	5svu6P0nbT0W7bVtP8sHFfjeQQPTR0o=
X-Google-Smtp-Source: AGHT+IEo0YpirGMFLOQPu1+JPSR0DG5FDk303PQza9eOuDyOragnS042ndzE8Pd0ow1j/PtRzL0iHYgXDSU=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a25:d081:0:b0:d9a:fd29:4fe6 with SMTP id
 h123-20020a25d081000000b00d9afd294fe6mr562511ybg.3.1701189233386; Tue, 28 Nov
 2023 08:33:53 -0800 (PST)
Date: Tue, 28 Nov 2023 08:33:51 -0800
In-Reply-To: <f4495d1f697cf9a7ddfb786eaeeac90f554fc6db.camel@redhat.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20231108111806.92604-1-nsaenz@amazon.com> <20231108111806.92604-6-nsaenz@amazon.com>
 <f4495d1f697cf9a7ddfb786eaeeac90f554fc6db.camel@redhat.com>
Message-ID: <ZWYWb3OQG3CaS7-f@google.com>
Subject: Re: [RFC 05/33] KVM: x86: hyper-v: Introduce VTL call/return
 prologues in hypercall page
From: Sean Christopherson <seanjc@google.com>
To: Maxim Levitsky <mlevitsk@redhat.com>
Cc: Nicolas Saenz Julienne <nsaenz@amazon.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-hyperv@vger.kernel.org, pbonzini@redhat.com, vkuznets@redhat.com, 
	anelkz@amazon.com, graf@amazon.com, dwmw@amazon.co.uk, jgowans@amazon.com, 
	corbert@lwn.net, kys@microsoft.com, haiyangz@microsoft.com, 
	decui@microsoft.com, x86@kernel.org, linux-doc@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Tue, Nov 28, 2023, Maxim Levitsky wrote:
> On Wed, 2023-11-08 at 11:17 +0000, Nicolas Saenz Julienne wrote:
> > diff --git a/arch/x86/kvm/hyperv.c b/arch/x86/kvm/hyperv.c
> > index 78d053042667..d4b1b53ea63d 100644
> > --- a/arch/x86/kvm/hyperv.c
> > +++ b/arch/x86/kvm/hyperv.c
> > @@ -259,7 +259,8 @@ static void synic_exit(struct kvm_vcpu_hv_synic *synic, u32 msr)
> >  static int patch_hypercall_page(struct kvm_vcpu *vcpu, u64 data)
> >  {
> >  	struct kvm *kvm = vcpu->kvm;
> > -	u8 instructions[9];
> > +	struct kvm_hv *hv = to_kvm_hv(kvm);
> > +	u8 instructions[0x30];
> >  	int i = 0;
> >  	u64 addr;
> >  
> > @@ -285,6 +286,81 @@ static int patch_hypercall_page(struct kvm_vcpu *vcpu, u64 data)
> >  	/* ret */
> >  	((unsigned char *)instructions)[i++] = 0xc3;
> >  
> > +	/* VTL call/return entries */
> > +	if (!kvm_xen_hypercall_enabled(kvm) && kvm_hv_vsm_enabled(kvm)) {
> > +#ifdef CONFIG_X86_64
> > +		if (is_64_bit_mode(vcpu)) {
> > +			/*
> > +			 * VTL call 64-bit entry prologue:
> > +			 * 	mov %rcx, %rax
> > +			 * 	mov $0x11, %ecx
> > +			 * 	jmp 0:
> 
> This isn't really 'jmp 0' as I first wondered but actually backward jump 32
> bytes back (if I did the calculation correctly).  This is very dangerous
> because code that was before can change and in fact I don't think that this
> offset is even correct now, and on top of that it depends on support for xen
> hypercalls as well.
> 
> This can be fixed by calculating the offset in runtime, however I am
> thinking:
> 
> 
> Since userspace will have to be aware of the offsets in this page, and since
> pretty much everything else is done in userspace, it might make sense to
> create the hypercall page in the userspace.
> 
> In fact, the fact that KVM currently overwrites the guest page, is a
> violation of the HV spec.
> 
> It's more correct regardless of VTL to do userspace vm exit and let the
> userspace put a memslot ("overlay") over the address, and put whatever
> userspace wants there, including the above code.
> 
> Then we won't need the new ioctl as well.
> 
> To support this I think that we can add a userspace msr filter on the
> HV_X64_MSR_HYPERCALL, although I am not 100% sure if a userspace msr filter
> overrides the in-kernel msr handling.

Yep, userspace MSR filters override in-kernel handling.

