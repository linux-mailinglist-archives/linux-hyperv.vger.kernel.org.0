Return-Path: <linux-hyperv+bounces-1245-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A99E805F02
	for <lists+linux-hyperv@lfdr.de>; Tue,  5 Dec 2023 21:04:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B7DD1281FC8
	for <lists+linux-hyperv@lfdr.de>; Tue,  5 Dec 2023 20:04:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF7B46929F;
	Tue,  5 Dec 2023 20:04:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cVhlsFqL"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8187918C
	for <linux-hyperv@vger.kernel.org>; Tue,  5 Dec 2023 12:04:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1701806650;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+s/bFE6xgyjWjg9l0eDus09xn9qMoGdQv3xi9sP30Mo=;
	b=cVhlsFqL0JrqqRbXmga4VASg4gw9US7Bo1spFnliCEG1urZIb4nwjOQykamiAvUUorufow
	z4FMWNzbgEO9cKQ/vtcXyLSa+JlA84YVrzLaBXIku0R/RqJPPlpvXJcch3sfxR9+A1UC6f
	42mV8Zr/K86enWkT90x0eM7WPu7rvrI=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-537-mIMTSTmFOJ6pUx03gAiXqQ-1; Tue, 05 Dec 2023 15:04:08 -0500
X-MC-Unique: mIMTSTmFOJ6pUx03gAiXqQ-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-40b40234b64so47074575e9.0
        for <linux-hyperv@vger.kernel.org>; Tue, 05 Dec 2023 12:04:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701806647; x=1702411447;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+s/bFE6xgyjWjg9l0eDus09xn9qMoGdQv3xi9sP30Mo=;
        b=EP45Ohw+F9PJahoC+KBdTMd6mFvaXBE4IUg9YDo4HEq+0Uchc3NFAtyryENwvAwjMU
         2vQjl2oyb8sC8iveJCbXw9TGJo5f9199CrVezWwNZWpBofgUC8mE2LTS8M9c/tDHiq59
         D9Ck1KHDFswjmswN3sAM8Lccam6duqgst3BbGpw29mvL5MiTJ/wr5Kh8XICAMpThtYWp
         ImdcdBJLg0TBiGzfEPGZVA8Ufvo+Lnm9txeflUvR/dhx8Va5dc+18ezOsNO6DqzypqXj
         kmB/SWyzs6CuT3J88GyeMRBvJiRa6HfuBuBVz87B8Mo26QkAoSUvn/iEmwK1VXaKDE/W
         tJJQ==
X-Gm-Message-State: AOJu0YzCDLZJfnN3yteoHcoiVk4eCv+WaepA02oQgd1lbep8IQBEJKhx
	AI777peVwq4pLiljbHddtS0QVj3e2A0PBSyeqBE+CD6aycO1ED4YW2u4lO4omyX2/waypUHZjAZ
	3sj4fl7r8ma61zQRkxxtX2IaU
X-Received: by 2002:a05:600c:4f49:b0:40b:5e21:cc19 with SMTP id m9-20020a05600c4f4900b0040b5e21cc19mr960067wmq.68.1701806647275;
        Tue, 05 Dec 2023 12:04:07 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH+xDNPOikcr570KVQC6im6G/7epzJv3koIVlHQmahfi/k9ra/UMfu2LkaDap8die5Q9RRPsQ==
X-Received: by 2002:a05:600c:4f49:b0:40b:5e21:cc19 with SMTP id m9-20020a05600c4f4900b0040b5e21cc19mr960051wmq.68.1701806646958;
        Tue, 05 Dec 2023 12:04:06 -0800 (PST)
Received: from starship ([89.237.98.20])
        by smtp.gmail.com with ESMTPSA id d4-20020a05600c3ac400b0040b538047b4sm23151845wms.3.2023.12.05.12.04.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Dec 2023 12:04:06 -0800 (PST)
Message-ID: <fc09fec34a89ba7655f344a31174d078a8248182.camel@redhat.com>
Subject: Re: [RFC 05/33] KVM: x86: hyper-v: Introduce VTL call/return
 prologues in hypercall page
From: Maxim Levitsky <mlevitsk@redhat.com>
To: Sean Christopherson <seanjc@google.com>, Nicolas Saenz Julienne
	 <nsaenz@amazon.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-hyperv@vger.kernel.org, pbonzini@redhat.com, vkuznets@redhat.com, 
 anelkz@amazon.com, graf@amazon.com, dwmw@amazon.co.uk, jgowans@amazon.com, 
 kys@microsoft.com, haiyangz@microsoft.com, decui@microsoft.com,
 x86@kernel.org,  linux-doc@vger.kernel.org
Date: Tue, 05 Dec 2023 22:04:04 +0200
In-Reply-To: <ZW94T8Fx2eJpwKQS@google.com>
References: <20231108111806.92604-1-nsaenz@amazon.com>
	 <20231108111806.92604-6-nsaenz@amazon.com>
	 <f4495d1f697cf9a7ddfb786eaeeac90f554fc6db.camel@redhat.com>
	 <CXD4TVV5QWUK.3SH495QSBTTUF@amazon.com> <ZWoKlJUKJGGhRRgM@google.com>
	 <CXD5HJ5LQMTE.11XP9UB9IL8LY@amazon.com> <ZWocI-2ajwudA-S5@google.com>
	 <CXD7AW5T9R7G.2REFR2IRSVRVZ@amazon.com> <ZW94T8Fx2eJpwKQS@google.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5 (3.36.5-2.fc32) 
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

On Tue, 2023-12-05 at 11:21 -0800, Sean Christopherson wrote:
> On Fri, Dec 01, 2023, Nicolas Saenz Julienne wrote:
> > On Fri Dec 1, 2023 at 5:47 PM UTC, Sean Christopherson wrote:
> > > On Fri, Dec 01, 2023, Nicolas Saenz Julienne wrote:
> > > > On Fri Dec 1, 2023 at 4:32 PM UTC, Sean Christopherson wrote:
> > > > > On Fri, Dec 01, 2023, Nicolas Saenz Julienne wrote:
> > > > > > > To support this I think that we can add a userspace msr filter on the HV_X64_MSR_HYPERCALL,
> > > > > > > although I am not 100% sure if a userspace msr filter overrides the in-kernel msr handling.
> > > > > > 
> > > > > > I thought about it at the time. It's not that simple though, we should
> > > > > > still let KVM set the hypercall bytecode, and other quirks like the Xen
> > > > > > one.
> > > > > 
> > > > > Yeah, that Xen quirk is quite the killer.
> > > > > 
> > > > > Can you provide pseudo-assembly for what the final page is supposed to look like?
> > > > > I'm struggling mightily to understand what this is actually trying to do.
> > > > 
> > > > I'll make it as simple as possible (diregard 32bit support and that xen
> > > > exists):
> > > > 
> > > > vmcall             <-  Offset 0, regular Hyper-V hypercalls enter here
> > > > ret
> > > > mov rax,rcx  <-  VTL call hypercall enters here
> > > 
> > > I'm missing who/what defines "here" though.  What generates the CALL that points
> > > at this exact offset?  If the exact offset is dictated in the TLFS, then aren't
> > > we screwed with the whole Xen quirk, which inserts 5 bytes before that first VMCALL?
> > 
> > Yes, sorry, I should've included some more context.
> > 
> > Here's a rundown (from memory) of how the first VTL call happens:
> >  - CPU0 start running at VTL0.
> >  - Hyper-V enables VTL1 on the partition.
> >  - Hyper-V enabled VTL1 on CPU0, but doesn't yet switch to it. It passes
> >    the initial VTL1 CPU state alongside the enablement hypercall
> >    arguments.
> >  - Hyper-V sets the Hypercall page overlay address through
> >    HV_X64_MSR_HYPERCALL. KVM fills it.
> >  - Hyper-V gets the VTL-call and VTL-return offset into the hypercall
> >    page using the VP Register HvRegisterVsmCodePageOffsets (VP register
> >    handling is in user-space).
> 
> Ah, so the guest sets the offsets by "writing" HvRegisterVsmCodePageOffsets via
> a HvSetVpRegisters() hypercall.

No, you didn't understand this correctly. 

The guest writes the HV_X64_MSR_HYPERCALL, and in the response hyperv fills the hypercall page,
including the VSM thunks.

Then the guest can _read_ the offsets, hyperv chose there by issuing another hypercall. 

In the current implementation,
the offsets that the kernel choose are first exposed to the userspace via new ioctl, and then the userspace
exposes these offsets to the guest via that 'another hypercall' 
(reading a pseudo partition register 'HvRegisterVsmCodePageOffsets')

I personally don't know for sure anymore if the userspace or kernel based hypercall page is better
here, it's ugly regardless :(


Best regards,
	Maxim Levitsky

> 
> I don't see a sane way to handle this in KVM if userspace handles HvSetVpRegisters().
> E.g. if the guest requests offsets that don't leave enough room for KVM to shove
> in its data, then presumably userspace needs to reject HvSetVpRegisters().  But
> that requires userspace to know exactly how many bytes KVM is going to write at
> each offsets.
> 
> My vote is to have userspace do all the patching.  IIUC, all of this is going to
> be mutually exclusive with kvm_xen_hypercall_enabled(), i.e. userspace doesn't
> need to worry about setting RAX[31].  At that point, it's just VMCALL versus
> VMMCALL, and userspace is more than capable of identifying whether its running
> on Intel or AMD.
> 
> >  - Hyper-V performs the first VTL-call, and has all it needs to move
> >    between VTL0/1.
> > 
> > Nicolas



