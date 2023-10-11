Return-Path: <linux-hyperv+bounces-515-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DABB7C4AD3
	for <lists+linux-hyperv@lfdr.de>; Wed, 11 Oct 2023 08:42:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7F4A91C20C59
	for <lists+linux-hyperv@lfdr.de>; Wed, 11 Oct 2023 06:42:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EC91389;
	Wed, 11 Oct 2023 06:42:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="inEi2Gj7"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0194F2106;
	Wed, 11 Oct 2023 06:42:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B954CC433C9;
	Wed, 11 Oct 2023 06:42:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1697006552;
	bh=J3Ab/wO6tzZP1kYPblZYB8C+PJ1b07cj73IxokkQfKc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=inEi2Gj7rCcYaJdPbpHTGY90rKNKVWJ8xnp8nWp1VRk/z0JSOI9K9gt09ZG/aq1lY
	 fYvqiymOZtWuFNzXUz/+fnuUdKpi6t4/MQ6Fw/4Tj+MXTqBouekHY1akyqSFZRga74
	 JjV7VDb8JnCbviOR4UUVIrsYv1g55cixcjQaVS5A=
Date: Wed, 11 Oct 2023 08:42:28 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Nuno Das Neves <nunodasneves@linux.microsoft.com>
Cc: Wei Liu <wei.liu@kernel.org>, linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org, x86@kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-arch@vger.kernel.org,
	patches@lists.linux.dev, mikelley@microsoft.com, kys@microsoft.com,
	haiyangz@microsoft.com, decui@microsoft.com,
	apais@linux.microsoft.com, Tianyu.Lan@microsoft.com,
	ssengar@linux.microsoft.com, mukeshrathor@microsoft.com,
	stanislav.kinsburskiy@gmail.com, jinankjain@linux.microsoft.com,
	vkuznets@redhat.com, tglx@linutronix.de, mingo@redhat.com,
	bp@alien8.de, dave.hansen@linux.intel.com, hpa@zytor.com,
	will@kernel.org, catalin.marinas@arm.com
Subject: Re: [PATCH v2 13/15] uapi: hyperv: Add mshv driver headers hvhdk.h,
 hvhdk_mini.h, hvgdk.h, hvgdk_mini.h
Message-ID: <2023101133-blade-diary-11e4@gregkh>
References: <1692309711-5573-1-git-send-email-nunodasneves@linux.microsoft.com>
 <1692309711-5573-14-git-send-email-nunodasneves@linux.microsoft.com>
 <ZN6m2gVmtVStuEfA@liuwe-devbox-debian-v2>
 <2023081923-crown-cake-79f7@gregkh>
 <c4482a6a-aed0-4750-aa1b-421f0e541cfa@linux.microsoft.com>
 <50f1721f-64fb-49ff-9740-0dac7cf832c8@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <50f1721f-64fb-49ff-9740-0dac7cf832c8@linux.microsoft.com>

On Tue, Oct 10, 2023 at 03:49:48PM -0700, Nuno Das Neves wrote:
> On 8/25/2023 11:24 AM, Nuno Das Neves wrote:
> > On 8/19/2023 3:26 AM, Greg KH wrote:
> > > 
> > > My "strong" opinion is the one kernel development rule that we have,
> > > "you can not break userspace".  So, if you change these
> > > values/structures/whatever in the future, and userspace tools break,
> > > that's not ok and the changes have to be reverted.
> > > 
> > > If you can control both sides of the API here (with open tools that you
> > > can guarantee everyone will always update to), then yes, you can change
> > > the api in the future.
> > > 
> > 
> > This is true for us - we contribute and maintain support for this driver
> > in Cloud Hypervisor[1], an open source VMM.
> > 
> 
> Hi Greg,
> 
> Bringing up this discussion again so we can clear up any confusion on the
> uapi headers in this patch set.
> 
> The headers consist of the ioctls in mshv.h, and the hypervisor ABIs in
> the *hdk.h files. The ioctls depend on the hypervisor ABIs.
> 
> We will add (to the next version), an ioctl like KVM_GET_API_VERSION [1].
> This will return a version number for the ioctl interface that increments
> any time there is a breaking change. Userspace would be required to check
> this before calling any other ioctl, and it can exit gracefully if there
> is a mismatch.
> 
> That's how KVM evolved its userspace ABI. We want to use the same approach.

That's one way to do interfaces, but there are better ways as you know.
What do you expect to change that is going to require such heavy-handed
treatment of structures and ioctls?

And how are you going to handle backwards compatiblity?

Versioning things is almost always a pain, and should only be done as a
last resort as a sign of an api that is not well understood at creation
time.  Surely you have studied how other hypervisor interfaces work and
know what you need to do for yours by now, right?  This isn't the first
hypervisor api in Linux like KVM was when it was introduced a few
decades ago.  Why not learn from past mistakes and design patterns
instead of just blindly imitating old apis that perhaps should not be
imitated at all?

> I also wanted to reiterate that we are the only maintainers and users of
> the userspace code for this driver via Cloud Hypervisor [2].

For today, maybe, but you can never guarantee that in the future as you
well know.

> We generate rust bindings from these headers using bindgen [3].

What does rust have to do with anything here?  You can use m4 to parse
the headers for all we care :)

> Taking this into account, is the above a viable path for this patch set?

I have no idea, sorry, I don't see any patches here to review as the
original set is long-gone from my queue.

Just submit your fixed up patch series based on the previous review
comments and it will be reviewed again, just like all kernel patches
are.  Why is this set somehow more special than anything else?

Perhaps you all should take the time to do some kernel patch reviews of
other stuff sent to the mailing lists to get an idea of how this whole
process works, and to get better integrated into the kernel development
community, before dumping a huge patchset on us with lots of process
questions like this?  Why are you asking the community to do a lot of
work and hand-holding when you aren't helping others out as well?

good luck!

greg k-h

