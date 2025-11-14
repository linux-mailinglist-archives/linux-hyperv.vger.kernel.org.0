Return-Path: <linux-hyperv+bounces-7595-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 07EC0C5EEB2
	for <lists+linux-hyperv@lfdr.de>; Fri, 14 Nov 2025 19:49:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E26904E3541
	for <lists+linux-hyperv@lfdr.de>; Fri, 14 Nov 2025 18:40:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 997B22DC333;
	Fri, 14 Nov 2025 18:40:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QOaqpxR2"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A83B1548C;
	Fri, 14 Nov 2025 18:40:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763145624; cv=none; b=F4JZ8o/e8h1iHtcwokWyyar+UJ+3N1S4dCiMsjQJ7lAbE5MuLGf3a7S4FXgUkJRXPkyFjdqEkDHbMxbHBEvmytUrisjLzFti791CQ+asXFw5IDG9HsqmgdmDBla/pn52Xp2X9fIMr9c9vpkk7NZitXpeF/tFVWmv0NJutc36JkU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763145624; c=relaxed/simple;
	bh=3X7ylcKMDC1cXrej3rX2Ktd4GwNPtz/CwW1hNWzOZUQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sfDneXxn0HbztfNr1OACicwlaY6koDCa/ZqOLABmAQMPaIGB30k7Ocm8Z83ZdGNKmSiLBKJiioDh11+LNy4CaProP+CswE8AWHAwtxkp7L2zrb3pmCmsFUT58WFaCQaGXUJovu2CCGrRJ0EodFDhfD9/Q+mcVT3DfJZLoqx4KR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QOaqpxR2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE88CC4AF0B;
	Fri, 14 Nov 2025 18:40:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763145624;
	bh=3X7ylcKMDC1cXrej3rX2Ktd4GwNPtz/CwW1hNWzOZUQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QOaqpxR208txp7buoIwRfqkjX8uRR70VK4gWJs9/ULOv+IaTxjygN4qax0+k6OJWP
	 6cheqNKhndzN3r5RsHymuzraMHhJDFg7kMzlKewr8kJ+2ZQTQFpgA4dqZUL2fsqpia
	 04nNpO6rfMUTw/nSF04dwJ51OdNjCf6i2zeTvix71U9BQ5lDitOrcl9fro9fIEcC3A
	 9MmXQ0NP/5VTZ5ENQE4SNiksNY045xWPMBABA9fDLLFrNWy/MHp2vMFOS0tdnUvyGD
	 jerUw0y24m+tUkqJSI1a5fodS25NjjTCOeKLrRzFFuhJXJfgQpsf4wgQGqh24tfMOw
	 mfGSVYbU3qGqw==
Date: Fri, 14 Nov 2025 18:40:22 +0000
From: Wei Liu <wei.liu@kernel.org>
To: Sean Christopherson <seanjc@google.com>
Cc: Wei Liu <wei.liu@kernel.org>, Michael Kelley <mhklinux@outlook.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Vitaly Kuznetsov <vkuznets@redhat.com>,
	"K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Dexuan Cui <decui@microsoft.com>,
	Nuno Das Neves <nunodasneves@linux.microsoft.com>,
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>,
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Jim Mattson <jmattson@google.com>,
	Yosry Ahmed <yosry.ahmed@linux.dev>
Subject: Re: [PATCH 7/9] KVM: SVM: Treat exit_code as an unsigned 64-bit
 value through all of KVM
Message-ID: <20251114184022.GC1725668@liuwe-devbox-debian-v2.local>
References: <20251113225621.1688428-1-seanjc@google.com>
 <20251113225621.1688428-8-seanjc@google.com>
 <SN6PR02MB4157AF057CC8539AD47F6D66D4CAA@SN6PR02MB4157.namprd02.prod.outlook.com>
 <aRdJQQ7_j6RcHwjJ@google.com>
 <20251114182921.GB1725668@liuwe-devbox-debian-v2.local>
 <aRd2famvq_3frSEq@google.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aRd2famvq_3frSEq@google.com>

On Fri, Nov 14, 2025 at 10:35:41AM -0800, Sean Christopherson wrote:
> On Fri, Nov 14, 2025, Wei Liu wrote:
> > On Fri, Nov 14, 2025 at 07:22:41AM -0800, Sean Christopherson wrote:
> > > Ah, my PDF copy is just stale, it's indeed
> > > defined as a synthetic exit.
> > > 
> > >   https://learn.microsoft.com/en-us/virtualization/hyper-v-on-windows/tlfs/nested-virtualization#synthetic-vm-exit
> > > 
> > > Anyways, I'm in favor of making HV_SVM_EXITCODE_ENL an ull, though part of me
> > > wonders if we should do:
> > > 
> > >   #define HV_SVM_EXITCODE_ENL	SVM_EXIT_SW
> > 
> > I know this is very tempting, but these headers are supposed to mirror
> > Microsoft's internal headers, so we would like to keep them
> > self-contained for ease of tracking.
> 
> Ya, no argument from me.  Aha!  Even better, what I can do is have KVM assert
> that HV_SVM_EXITCODE_ENL == SVM_EXIT_SW in the KVM Hyper-V code, because what I
> really want to do is connect the dots for KVM folks.

This sounds like a good plan.

Wei

