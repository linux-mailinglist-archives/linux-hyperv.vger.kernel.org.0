Return-Path: <linux-hyperv+bounces-370-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B74927B4591
	for <lists+linux-hyperv@lfdr.de>; Sun,  1 Oct 2023 08:19:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sy.mirrors.kernel.org (Postfix) with ESMTP id 00D87B20B8C
	for <lists+linux-hyperv@lfdr.de>; Sun,  1 Oct 2023 06:19:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 379D69477;
	Sun,  1 Oct 2023 06:19:31 +0000 (UTC)
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C1C5138D;
	Sun,  1 Oct 2023 06:19:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1221C433C7;
	Sun,  1 Oct 2023 06:19:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1696141170;
	bh=HCPDJuB+VMwSxIKjZO86qo5UoEDCRGeYi9qs9U712Rk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=V1tJ4TJboCGp7/y9JWb9M49g9jcwUtV8cgBkmuBful5NJDpuM2utscf1o1NzLll4a
	 Hgr9J811M/9jsP2eJoReuyfljPha7iYKEMnhZLMiVfB7O9Q3MG3DdYR6A1Ru0dod/P
	 UGRNmRrHHacfULccI+eASPQOUtOWXFBTL6Ef259A=
Date: Sun, 1 Oct 2023 08:19:27 +0200
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
Message-ID: <2023100154-ferret-rift-acef@gregkh>
References: <1696010501-24584-1-git-send-email-nunodasneves@linux.microsoft.com>
 <1696010501-24584-14-git-send-email-nunodasneves@linux.microsoft.com>
 <2023093057-eggplant-reshoot-8513@gregkh>
 <ZRia1uyFfEkSqmXw@liuwe-devbox-debian-v2>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZRia1uyFfEkSqmXw@liuwe-devbox-debian-v2>

On Sat, Sep 30, 2023 at 10:01:58PM +0000, Wei Liu wrote:
> On Sat, Sep 30, 2023 at 08:09:19AM +0200, Greg KH wrote:
> > On Fri, Sep 29, 2023 at 11:01:39AM -0700, Nuno Das Neves wrote:
> > > These must be in uapi because they will be used in the mshv ioctl API.
> > > 
> > > Version numbers for each file:
> > > hvhdk.h		25212
> > > hvhdk_mini.h	25294
> > > hvgdk.h		25125
> > > hvgdk_mini.h	25294
> > 
> > what are version numbers?
> 
> These are internal version numbers for the hypervisor headers. We keep
> track of them so that we can detect if there are any breakages in the
> ABI, and thus either ask them to be fixed or we come up with ways to
> maintain compatibility. People outside of Microsoft don't need to worry
> about this. If you don't think this information belongs in the commit
> message, we can drop it.

Internal numbers to a single company that have no relevance to anyone
else do not belong in a changelog comment.  Would you want to see this
in any other kernel changelog message for any other portion of the
kernel?

> > > diff --git a/include/uapi/hyperv/hvgdk.h b/include/uapi/hyperv/hvgdk.h
> > > new file mode 100644
> > > index 000000000000..9bcbb7d902b2
> > > --- /dev/null
> > > +++ b/include/uapi/hyperv/hvgdk.h
> > > @@ -0,0 +1,41 @@
> > > +/* SPDX-License-Identifier: MIT */
> > 
> > That's usually not a good license for a new uapi .h file, why did you
> > choose this one?
> > 
> 
> This is chosen so that other Microsoft developers who don't normally
> work on Linux can review this code.

Sorry, but that's not how kernel development is done.  Please fix your
internal review processes and use the correct uapi header file license.

If your lawyers insist on this license, that's fine, but please have
them provide a signed-off-by on the patch that adds it and have it
documented why it is this license in the changelog AND in a comment in
the file so we can understand what is going on with it.

> > > +/* Define connection identifier type. */
> > > +union hv_connection_id {
> > > +	__u32 asu32;
> > > +	struct {
> > > +		__u32 id:24;
> > > +		__u32 reserved:8;
> > > +	} __packed u;
> > 
> > bitfields will not work properly in uapi .h files, please never do that.
> 
> Can you clarify a bit more why it wouldn't work? Endianess? Alignment?

Yes to both.

Did you all read the documentation for how to write a kernel api?  If
not, please do so.  I think it mentions bitfields, but it not, it really
should as of course, this will not work properly with different endian
systems or many compilers.

thanks,

greg k-h

