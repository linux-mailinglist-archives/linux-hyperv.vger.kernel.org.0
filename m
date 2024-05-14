Return-Path: <linux-hyperv+bounces-2109-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 994F88C55FC
	for <lists+linux-hyperv@lfdr.de>; Tue, 14 May 2024 14:24:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 37AC9281189
	for <lists+linux-hyperv@lfdr.de>; Tue, 14 May 2024 12:24:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 932C755C36;
	Tue, 14 May 2024 12:23:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="HUYIhJQS"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp-1908.mail.infomaniak.ch (smtp-1908.mail.infomaniak.ch [185.125.25.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A607050278
	for <linux-hyperv@vger.kernel.org>; Tue, 14 May 2024 12:23:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.25.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715689437; cv=none; b=UlH1KCHZaQb/AoWCANBvpmLIXaKQgENdKTVQxNJobNn9TlxxT3ilPIJue5xvQJsqAj8yq/P3IGZTPFBoY8J3yqTqVzoELV3PAf8H6KfH5GAPrltUI/kTIuckKvnPOWznTamOITMsIXX4sQSftX0uc9TVZwGf3NxL9viYyxt3O6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715689437; c=relaxed/simple;
	bh=bRkarWPZPXCcGNKnN/GFmEsDu3L8Us8oWBdG536diIA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t52wKnLwA+JHNPfsnjboFPqqUOm6Pk7lWou+FosP+4rAhCGZM/kA27VwYeMlqcbHE2iV2JUUL58hTCTvM16QeBJBSG9qGKBCFfrL5uMmXa/YaxUAgLcNRmc6y8BVNAlpnG+IjhNxXNFmoQEBnfAAYGyHGGaL7uaCh5xLMTkyzoQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=HUYIhJQS; arc=none smtp.client-ip=185.125.25.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Received: from smtp-4-0001.mail.infomaniak.ch (smtp-4-0001.mail.infomaniak.ch [10.7.10.108])
	by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4VdwWP64pbzTXk;
	Tue, 14 May 2024 14:23:45 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1715689425;
	bh=I0eZWdP4Q+KPu4Hx3s3mpwHuoQ0UvkeO9/nafOAr82w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HUYIhJQSGxJF3jwUizanlmonUX7sygOvcV8noUaAFzN0V3a3iKwuGB8/GEum6Clxq
	 EcKo1qBH3Un5VS8jWoGkoTi3TiKlCjIcaIL1kB+8poVzqExKvp5IQ2ywDDPeKqlugY
	 OVZlyAPCKt5gtA5k6143lcqKUer3NgtqPGvwYp+A=
Received: from unknown by smtp-4-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4VdwWN5tzlzF2L;
	Tue, 14 May 2024 14:23:44 +0200 (CEST)
Date: Tue, 14 May 2024 14:23:42 +0200
From: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To: Nicolas Saenz Julienne <nsaenz@amazon.com>
Cc: Sean Christopherson <seanjc@google.com>, 
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, 
	"H . Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>, 
	Kees Cook <keescook@chromium.org>, Paolo Bonzini <pbonzini@redhat.com>, 
	Thomas Gleixner <tglx@linutronix.de>, Vitaly Kuznetsov <vkuznets@redhat.com>, 
	Wanpeng Li <wanpengli@tencent.com>, Rick P Edgecombe <rick.p.edgecombe@intel.com>, 
	Alexander Graf <graf@amazon.com>, Angelina Vu <angelinavu@linux.microsoft.com>, 
	Anna Trikalinou <atrikalinou@microsoft.com>, Chao Peng <chao.p.peng@linux.intel.com>, 
	Forrest Yuan Yu <yuanyu@google.com>, James Gowans <jgowans@amazon.com>, 
	James Morris <jamorris@linux.microsoft.com>, John Andersen <john.s.andersen@intel.com>, 
	"Madhavan T . Venkataraman" <madvenka@linux.microsoft.com>, Marian Rotariu <marian.c.rotariu@gmail.com>, 
	Mihai =?utf-8?B?RG9uyJt1?= <mdontu@bitdefender.com>, =?utf-8?B?TmljdciZb3IgQ8OuyJt1?= <nicu.citu@icloud.com>, 
	Thara Gopinath <tgopinath@microsoft.com>, Trilok Soni <quic_tsoni@quicinc.com>, 
	Wei Liu <wei.liu@kernel.org>, Will Deacon <will@kernel.org>, 
	Yu Zhang <yu.c.zhang@linux.intel.com>, =?utf-8?Q?=C8=98tefan_=C8=98icleru?= <ssicleru@bitdefender.com>, 
	dev@lists.cloudhypervisor.org, kvm@vger.kernel.org, linux-hardening@vger.kernel.org, 
	linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-security-module@vger.kernel.org, qemu-devel@nongnu.org, virtualization@lists.linux-foundation.org, 
	x86@kernel.org, xen-devel@lists.xenproject.org
Subject: Re: [RFC PATCH v3 3/5] KVM: x86: Add notifications for Heki policy
 configuration and violation
Message-ID: <20240514.mai3Ahdoo2qu@digikod.net>
References: <20240503131910.307630-1-mic@digikod.net>
 <20240503131910.307630-4-mic@digikod.net>
 <ZjTuqV-AxQQRWwUW@google.com>
 <20240506.ohwe7eewu0oB@digikod.net>
 <ZjmFPZd5q_hEBdBz@google.com>
 <20240507.ieghomae0UoC@digikod.net>
 <ZjpTxt-Bxia3bRwB@google.com>
 <D15VQ97L5M8J.1TDNQE6KLW6JO@amazon.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <D15VQ97L5M8J.1TDNQE6KLW6JO@amazon.com>
X-Infomaniak-Routing: alpha

On Fri, May 10, 2024 at 10:07:00AM +0000, Nicolas Saenz Julienne wrote:
> On Tue May 7, 2024 at 4:16 PM UTC, Sean Christopherson wrote:
> > > If yes, that would indeed require a *lot* of work for something we're not
> > > sure will be accepted later on.
> >
> > Yes and no.  The AWS folks are pursuing VSM support in KVM+QEMU, and SVSM support
> > is trending toward the paired VM+vCPU model.  IMO, it's entirely feasible to
> > design KVM support such that much of the development load can be shared between
> > the projects.  And having 2+ use cases for a feature (set) makes it _much_ more
> > likely that the feature(s) will be accepted.
> 
> Since Sean mentioned our VSM efforts, a small update. We were able to
> validate the concept of one KVM VM per VTL as discussed in LPC. Right
> now only for single CPU guests, but are in the late stages of bringing
> up MP support. The resulting KVM code is small, and most will be
> uncontroversial (I hope). If other obligations allow it, we plan on
> having something suitable for review in the coming months.

Looks good!

> 
> Our implementation aims to implement all the VSM spec necessary to run
> with Microsoft Credential Guard. But note that some aspects necessary
> for HVCI are not covered, especially the ones that depend on MBEC
> support, or some categories of secure intercepts.

We already implemented support for MBEC, so that should not be an issue.
We just need to find the best interface to configure it.

> 
> Development happens
> https://github.com/vianpl/{linux,qemu,kvm-unit-tests} and the vsm-next
> branch, but I'd advice against looking into it until we add some order
> to the rework. Regardless, feel free to get in touch.

Thanks for the update.

Could we schedule a PUCK meeting to synchronize and help each other?
What about June 12?

