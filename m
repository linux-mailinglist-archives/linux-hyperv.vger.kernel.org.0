Return-Path: <linux-hyperv+bounces-463-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 23C507B77A5
	for <lists+linux-hyperv@lfdr.de>; Wed,  4 Oct 2023 08:11:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 9CF43281317
	for <lists+linux-hyperv@lfdr.de>; Wed,  4 Oct 2023 06:11:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 620375677;
	Wed,  4 Oct 2023 06:11:15 +0000 (UTC)
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EE2723C8;
	Wed,  4 Oct 2023 06:11:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27838C433C8;
	Wed,  4 Oct 2023 06:11:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1696399874;
	bh=rALAYhGQmJyIirMMRNk2TTp+3BBfkrtdrx8C7W4qdw4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=i51R0wVzA2sf7Y9M68lYyzEygs8eHLfNW/lGCwRQOXvbqtgvE6UV4HzPymji571NQ
	 A80ODPwQoC7tzhbnnusmSVhXXp/ahpzHKA7xnYgbWz1UUq0co4bO5sBxku3T6kdyIy
	 jULjlCqgyhIGfmofQJyKGmOAxkQ6VplOzgS/DSSE=
Date: Wed, 4 Oct 2023 08:11:13 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Wei Liu <wei.liu@kernel.org>
Cc: Nuno Das Neves <nunodasneves@linux.microsoft.com>,
	linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
	x86@kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-arch@vger.kernel.org, patches@lists.linux.dev,
	mikelley@microsoft.com, kys@microsoft.com, haiyangz@microsoft.com,
	decui@microsoft.com, apais@linux.microsoft.com,
	Tianyu.Lan@microsoft.com, ssengar@linux.microsoft.com,
	mukeshrathor@microsoft.com, stanislav.kinsburskiy@gmail.com,
	jinankjain@linux.microsoft.com, vkuznets@redhat.com,
	tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
	dave.hansen@linux.intel.com, hpa@zytor.com, will@kernel.org,
	catalin.marinas@arm.com
Subject: Re: [PATCH v4 13/15] uapi: hyperv: Add mshv driver headers defining
 hypervisor ABIs
Message-ID: <2023100458-confusing-carton-3302@gregkh>
References: <1696010501-24584-1-git-send-email-nunodasneves@linux.microsoft.com>
 <1696010501-24584-14-git-send-email-nunodasneves@linux.microsoft.com>
 <2023093057-eggplant-reshoot-8513@gregkh>
 <ZRia1uyFfEkSqmXw@liuwe-devbox-debian-v2>
 <2023100154-ferret-rift-acef@gregkh>
 <ZRyj5kJJYaBu22O3@liuwe-devbox-debian-v2>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZRyj5kJJYaBu22O3@liuwe-devbox-debian-v2>

On Tue, Oct 03, 2023 at 11:29:42PM +0000, Wei Liu wrote:
> > > > > diff --git a/include/uapi/hyperv/hvgdk.h b/include/uapi/hyperv/hvgdk.h
> > > > > new file mode 100644
> > > > > index 000000000000..9bcbb7d902b2
> > > > > --- /dev/null
> > > > > +++ b/include/uapi/hyperv/hvgdk.h
> > > > > @@ -0,0 +1,41 @@
> > > > > +/* SPDX-License-Identifier: MIT */
> > > > 
> > > > That's usually not a good license for a new uapi .h file, why did you
> > > > choose this one?
> > > > 
> > > 
> > > This is chosen so that other Microsoft developers who don't normally
> > > work on Linux can review this code.
> > 
> > Sorry, but that's not how kernel development is done.  Please fix your
> > internal review processes and use the correct uapi header file license.
> > 
> > If your lawyers insist on this license, that's fine, but please have
> > them provide a signed-off-by on the patch that adds it and have it
> > documented why it is this license in the changelog AND in a comment in
> > the file so we can understand what is going on with it.
> > 
> 
> We went through an internal review with our legal counsel regarding the
> MIT license. We have an approval from them.
> 
> Let me ask if using something like "GPL-2.0 WITH Linux-syscall-note OR
> MIT" is possible.

That marking makes no sense from a legal point of view, please work with
your lawyers as it seems they do not understand license descriptions
very well :(

thanks,

greg k-h

