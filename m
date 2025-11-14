Return-Path: <linux-hyperv+bounces-7590-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 524AFC5DE83
	for <lists+linux-hyperv@lfdr.de>; Fri, 14 Nov 2025 16:36:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sin.lore.kernel.org (Postfix) with ESMTPS id DFCB92345E
	for <lists+linux-hyperv@lfdr.de>; Fri, 14 Nov 2025 15:36:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8872F331217;
	Fri, 14 Nov 2025 15:22:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="R62pJoTG"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08A2632ED4A
	for <linux-hyperv@vger.kernel.org>; Fri, 14 Nov 2025 15:22:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763133765; cv=none; b=R0W/mjmxY797VNgVjHPCa/a/E1puvCmqbqlKVyR+ELhfb3r4UazGe+nlYhaM7GPHD8je6UojicbKHqPYZoHTo5BuDHT7AvnGWRIrpncLGLIAd+x1wYI0uvELgkrNwHUwU5MYVAyPxQnU4DZWk3HXK8pqQRBy1p1nZCvaIF7tZfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763133765; c=relaxed/simple;
	bh=DpbKWxIyQ9KxrGiVD7t8GJpBnIreph23Cp44p8dMSM8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=aQvHntZVBQQccirWw70xUgMTFUO1rcliDwZSV/8wO63HEh1I7Snad6v5ONVBb1pluwi7r5rYfKg0Qia9ZqPFqKFWQvuLOLs8ynXoxjeAuAylKCJcR4EKK1y0SUTt73pQXkRKoBwN1zIumbUgFaL0tNu8gbAUcEA1fpkqHgtPGSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=R62pJoTG; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-341616a6fb7so2723820a91.0
        for <linux-hyperv@vger.kernel.org>; Fri, 14 Nov 2025 07:22:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1763133763; x=1763738563; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=eKSpfoYNgcderQopBxLm/p146foAdZqVSD0ikjtaERA=;
        b=R62pJoTGeQuuLr0U2gT9vGARADabcJgf+cHzzeqgDUNHmDFLyEDMNoXZKNutEUJ4XV
         zDjsgxgXOryctn6yBIg4JvUr97aVuvRCPzYUAnPcjL6LMqz5pyoJCGIMUFcRj59ewbDG
         meODFMnifggCzuCI4r9bUL1DCtCMoKu0usimemmAMLLdY0FzYmtGw58i6b3XbJK9jZXX
         ofIGMayQtXWSubbERwlGmbnFo8a0PxgXgRgmcej0Z50g9WNXujkujM6vAjfL8zCnY5Fh
         Y/9ZNYYXl7dbCphfu4vwyFMpPgd31ZncasPpk3EV6qnknX0s7bW9XJZ+UJTYoqrXj6ID
         6EWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763133763; x=1763738563;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eKSpfoYNgcderQopBxLm/p146foAdZqVSD0ikjtaERA=;
        b=YyWZVJMrpW2LU3tEzfBr502ZaUY5tCZrFneRv6mK+jxcS/mZRHHO3DbkmhRDBWD//I
         xC0nh2DYr4doCc1uMsD2JQ200NBAUFkm+nKlUsPrq4iwdZ7coWldI4VLUdmhQhPow7nK
         7Mwrg3q7Nb0F8wHnsILZvtWuShYqJNFZJJuLW3zq3uCtysS22KBlpD3aFuaCDrbgdKPN
         x4a91YMV0PZoDyJqwqBCsZEG0pVtr0m0SqqcgMkfCygGWBrffWXUqt3SzsZvBqtNItEI
         55ExwFLOLc63LeEFAqv2EAwHL5B1rNTKJNl/7n+PopaeeKcM7C4VrgtNAgyVyt1ihj4L
         StHA==
X-Forwarded-Encrypted: i=1; AJvYcCU3Xxo8EZlGdRMrhztbYKbqPzEd7vHdc6OyUT5W9IzXDGlOAIH6OCvGwBWvzet3brAUg9nD5u9IcqCG5F0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxPu/PUj6nOUzokKvMSPECH8tJWoVLR8oKVHkKGxYG9xOgP4nCL
	3yosMUASy7MgEg2rNIRxyMv6Mt/XPFMPYercJFogXummZ461ku6hq3aROCGA4Kmi10lQcC7JnJq
	6ueoV5g==
X-Google-Smtp-Source: AGHT+IHguiFlQ0z5dlRYfgNcEgqZOl8+CF7sD5lgZUJiizDuYK4N6jAChUXIGNOe8U4ks8AdguhO7M/4KMw=
X-Received: from pjtz18.prod.google.com ([2002:a17:90a:cb12:b0:340:b1b5:eb5e])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90a:e18c:b0:336:b60f:3936
 with SMTP id 98e67ed59e1d1-343f9e9f23bmr4797401a91.12.1763133763161; Fri, 14
 Nov 2025 07:22:43 -0800 (PST)
Date: Fri, 14 Nov 2025 07:22:41 -0800
In-Reply-To: <SN6PR02MB4157AF057CC8539AD47F6D66D4CAA@SN6PR02MB4157.namprd02.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251113225621.1688428-1-seanjc@google.com> <20251113225621.1688428-8-seanjc@google.com>
 <SN6PR02MB4157AF057CC8539AD47F6D66D4CAA@SN6PR02MB4157.namprd02.prod.outlook.com>
Message-ID: <aRdJQQ7_j6RcHwjJ@google.com>
Subject: Re: [PATCH 7/9] KVM: SVM: Treat exit_code as an unsigned 64-bit value
 through all of KVM
From: Sean Christopherson <seanjc@google.com>
To: Michael Kelley <mhklinux@outlook.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Vitaly Kuznetsov <vkuznets@redhat.com>, 
	"K. Y. Srinivasan" <kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, 
	Dexuan Cui <decui@microsoft.com>, Nuno Das Neves <nunodasneves@linux.microsoft.com>, 
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>, 
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Jim Mattson <jmattson@google.com>, 
	Yosry Ahmed <yosry.ahmed@linux.dev>
Content-Type: text/plain; charset="us-ascii"

On Fri, Nov 14, 2025, Michael Kelley wrote:
> From: Sean Christopherson <seanjc@google.com> Sent: Thursday, November 13, 2025 2:56 PM
> > 
> 
> Adding Microsoft's Nuno Das Neves to the "To:" line since he
> originated the work to keep the Linux headers such as hvgdk.h in
> sync with the Windows counterparts from which they originate.

...

> >  /* Exit code reserved for hypervisor/software use */
> > -#define SVM_EXIT_SW				0xf0000000
> > +#define SVM_EXIT_SW				0xf0000000ull
> > 
> > -#define SVM_EXIT_ERR           -1
> > +#define SVM_EXIT_ERR           -1ull
> > 
> 
> [snip]
> 
> > diff --git a/include/hyperv/hvgdk.h b/include/hyperv/hvgdk.h
> > index dd6d4939ea29..56b695873a72 100644
> > --- a/include/hyperv/hvgdk.h
> > +++ b/include/hyperv/hvgdk.h
> > @@ -281,7 +281,7 @@ struct hv_vmcb_enlightenments {
> >  #define HV_VMCB_NESTED_ENLIGHTENMENTS		31
> > 
> >  /* Synthetic VM-Exit */
> > -#define HV_SVM_EXITCODE_ENL			0xf0000000
> > +#define HV_SVM_EXITCODE_ENL			0xf0000000u
> 
> Is there a reason for making this Hyper-V code just "u", while
> making the SVM_VMGEXIT_* values "ull"? I don't think
> "u" vs. "ull" shouldn't make any difference when assigning to a
> u64, but the inconsistency piqued my interest ....

I hedged and went for a more "minimal" change because it isn't KVM code, and at
the time because I thought the value isn't defined by the APM.  Though looking
again at the APM, it does reserve that value for software

  F000_000h    Unused    Reserved for Host.

and I can't find anything in the TLFS.  Ah, my PDF copy is just stale, it's indeed
defined as a synthetic exit.

  https://learn.microsoft.com/en-us/virtualization/hyper-v-on-windows/tlfs/nested-virtualization#synthetic-vm-exit

Anyways, I'm in favor of making HV_SVM_EXITCODE_ENL an ull, though part of me
wonders if we should do:

  #define HV_SVM_EXITCODE_ENL	SVM_EXIT_SW

