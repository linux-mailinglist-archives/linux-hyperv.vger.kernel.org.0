Return-Path: <linux-hyperv+bounces-561-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6862D7CFFE4
	for <lists+linux-hyperv@lfdr.de>; Thu, 19 Oct 2023 18:46:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EF4B2282163
	for <lists+linux-hyperv@lfdr.de>; Thu, 19 Oct 2023 16:46:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E05A225C8;
	Thu, 19 Oct 2023 16:46:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="oRdsyrrT"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA1CE225B0
	for <linux-hyperv@vger.kernel.org>; Thu, 19 Oct 2023 16:46:46 +0000 (UTC)
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77F8B138
	for <linux-hyperv@vger.kernel.org>; Thu, 19 Oct 2023 09:46:45 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-59b5a586da6so8280077b3.1
        for <linux-hyperv@vger.kernel.org>; Thu, 19 Oct 2023 09:46:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1697734004; x=1698338804; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=TpEPzMpbmRE7S67/u7J3M2Dti06L1rP8ZIHmBIwQBxQ=;
        b=oRdsyrrTg/a/sxyEmhjry+QyhUC2XFHXJt8eVHcq8zN+egLarC6Ra3fjwGdpaCY/0j
         CUulr1Iow+3ani9thHw6DryW2JeMSSA58xEMNU1XSYuq0HOPRQkqeriOE06GUL4G+d+V
         406W0OFbCZ16oc93zH1DgRgdowLa28o/6Uhxot/k/H4eGBIL2l0BKPW0hwYuLRcRm8sN
         JNV0kZGDDHYMYwX9d94C0w9Z2PhoWFK6yNCWtD8nT07BzO6qwtPHd45pw/ikUvqc+KXT
         cWKLAyvWK2O/r7OLUVezLXO1yPrl1OcTloqhEziIw9k89tIsjrHCN0Sz+VVyFn0hEjVQ
         NlBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697734004; x=1698338804;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TpEPzMpbmRE7S67/u7J3M2Dti06L1rP8ZIHmBIwQBxQ=;
        b=GQ2SMUeQcavRoO0GhmYct8CSm+VnviAGnwGeKc04/DEl4HrA3fOoZY0AH3vJZnawI/
         8GC+1MFgWzx/DlcnX13kDuyrlyeTsSU0UeYTxPkaKs1u1FBunkaPLJaSB9AVZAMnJGAB
         3l+NrtKvbRN20p8S3Hn84u+92xEVxESL85G9bhj6odNwblme0txrnzDXv3aLmOOosEDw
         qIpHLtEB37bCqpei02i/4BaJ005s2QZ/qwLpOOjO+zC/s+QspdY6hEHYbGI2Pyp+GeGq
         IcVMjzDbA1U5DRkyNGlPTAxc2hALAq+oMmtpQwuXOwtSzTT+k1r9WYSFqATIesN1Gi/8
         +DKg==
X-Gm-Message-State: AOJu0Yzp9r1cODRchkeE4KZ4menFIspaS9AJ6o+iCQBlX+1PRPbzmWWW
	VuaHULq8F+hPjs6wPNHBv69oJnigFhs=
X-Google-Smtp-Source: AGHT+IEY4l1tLFRd4OKDMZ5BEmKfsOkdl3pCTB2Bb27l0R7GZ2kCcrsoaryqlPd22mnjSHSD4UHcORKmX0Q=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a81:4fcb:0:b0:5a7:b4d5:5f27 with SMTP id
 d194-20020a814fcb000000b005a7b4d55f27mr63990ywb.5.1697734004668; Thu, 19 Oct
 2023 09:46:44 -0700 (PDT)
Date: Thu, 19 Oct 2023 09:46:43 -0700
In-Reply-To: <2f1459d7c3e3e81cdca931e104c3ade71dfcfee5.camel@infradead.org>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20231018221123.136403-1-dongli.zhang@oracle.com>
 <87ttqm6d3f.fsf@redhat.com> <ZTFOCqMCuSiH8VEt@google.com> <2f1459d7c3e3e81cdca931e104c3ade71dfcfee5.camel@infradead.org>
Message-ID: <ZTFdczzpORPBNpbx@google.com>
Subject: Re: [PATCH RFC 1/1] x86/paravirt: introduce param to disable pv sched_clock
From: Sean Christopherson <seanjc@google.com>
To: David Woodhouse <dwmw2@infradead.org>
Cc: Vitaly Kuznetsov <vkuznets@redhat.com>, Dongli Zhang <dongli.zhang@oracle.com>, x86@kernel.org, 
	virtualization@lists.linux-foundation.org, kvm@vger.kernel.org, 
	pv-drivers@vmware.com, xen-devel@lists.xenproject.org, 
	linux-hyperv@vger.kernel.org, jgross@suse.com, akaher@vmware.com, 
	amakhalov@vmware.com, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, 
	dave.hansen@linux.intel.com, hpa@zytor.com, pbonzini@redhat.com, 
	wanpengli@tencent.com, peterz@infradead.org, joe.jin@oracle.com, 
	boris.ostrovsky@oracle.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Thu, Oct 19, 2023, David Woodhouse wrote:
> On Thu, 2023-10-19 at 08:40 -0700, Sean Christopherson wrote:
> > > If for some 'historical reasons' we can't revoke features we can always
> > > introduce a new PV feature bit saying that TSC is preferred.
> 
> Don't we already have one? It's the PVCLOCK_TSC_STABLE_BIT. Why would a
> guest ever use kvmclock if the PVCLOCK_TSC_STABLE_BIT is set?
>
> The *point* in the kvmclock is that the hypervisor can mess with the
> epoch/scaling to try to compensate for TSC brokenness as the host
> scales/sleeps/etc.
> 
> And the *problem* with the kvmclock is that it does just that, even
> when the host TSC hasn't done anything wrong and the kvmclock shouldn't
> have changed at all.
> 
> If the PVCLOCK_TSC_STABLE_BIT is set, a guest should just use the guest
> TSC directly without looking to the kvmclock for adjusting it.
> 
> No?

No :-)

PVCLOCK_TSC_STABLE_BIT doesn't provide the guarantees that are needed to use the
raw TSC directly.  It's close, but there is at least one situation where using TSC
directly even when the TSC is stable is bad idea: when hardware doesn't support TSC
scaling and the guest virtual TSC is running at a higher frequency than the hardware
TSC.  The guest doesn't have to worry about the TSC going backwards, but using the
TSC directly would cause the guest's time calculations to be inaccurate.

And PVCLOCK_TSC_STABLE_BIT is also much more dynamic as it's tied to a given
generation/sequence.  E.g. if KVM stops using its masterclock for whatever reason,
then kvm_guest_time_update() will effectively clear PVCLOCK_TSC_STABLE_BIT and the
guest-side __pvclock_clocksource_read() will be forced to do a bit of extra work
to ensure the clock is monotonically increasing.

