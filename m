Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 23F1625545F
	for <lists+linux-hyperv@lfdr.de>; Fri, 28 Aug 2020 08:13:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726791AbgH1GNB (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 28 Aug 2020 02:13:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:35568 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726733AbgH1GNA (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 28 Aug 2020 02:13:00 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 12A5620791;
        Fri, 28 Aug 2020 06:12:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598595179;
        bh=LBzk3oAAqHfohZe8S681TVYnX6X9sRlHhrjkcFYQ0DE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=AInTcH93bPhdmVAkwLFdnaN2i6U1IofBalPyTYS+GVrVYHEuU0S2m5vUG3YJxHT4k
         /Q3tXvqCkJl/q0VyxzVRE09XGkCtZb/YnT6p6Lut/vfmhTcMGMQCzdD5fHj8/AzNCz
         zio1VJropXRY3WMmZXISTGpk1v9NZ5AuMIRAV/Tk=
Date:   Fri, 28 Aug 2020 08:12:57 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Iouri Tarassov <iourit@linux.microsoft.com>
Cc:     Sasha Levin <sashal@kernel.org>, kys@microsoft.com,
        haiyangz@microsoft.com, sthemmin@microsoft.com, wei.liu@kernel.org,
        iourit@microsoft.com, linux-kernel@vger.kernel.org,
        linux-hyperv@vger.kernel.org
Subject: Re: [PATCH 1/4] drivers: hv: dxgkrnl: core code
Message-ID: <20200828061257.GB56396@kroah.com>
References: <20200814123856.3880009-1-sashal@kernel.org>
 <20200814123856.3880009-2-sashal@kernel.org>
 <20200814130406.GC56456@kroah.com>
 <cfb9eb69-24f9-2a0c-1f1b-9204c6666aa8@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cfb9eb69-24f9-2a0c-1f1b-9204c6666aa8@linux.microsoft.com>
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Thu, Aug 27, 2020 at 05:05:44PM -0700, Iouri Tarassov wrote:
> 
> On 8/14/2020 6:04 AM, Greg KH wrote:
> > On Fri, Aug 14, 2020 at 08:38:53AM -0400, Sasha Levin wrote:
> > > Add support for a Hyper-V based vGPU implementation that exposes the
> > > DirectX API to Linux userspace.
> > > > Signed-off-by: Sasha Levin <sashal@kernel.org>
> > > ---
> > >  drivers/hv/dxgkrnl/Kconfig      |   10 +
> > >  drivers/hv/dxgkrnl/Makefile     |   12 +
> > >  drivers/hv/dxgkrnl/d3dkmthk.h   | 1636 ++++++++++
> > >  drivers/hv/dxgkrnl/dxgadapter.c | 1406 ++++++++
> > >  drivers/hv/dxgkrnl/dxgkrnl.h    |  927 ++++++
> > >  drivers/hv/dxgkrnl/dxgmodule.c  |  656 ++++
> > >  drivers/hv/dxgkrnl/dxgprocess.c |  357 ++
> > >  drivers/hv/dxgkrnl/dxgvmbus.c   | 3084 ++++++++++++++++++
> > >  drivers/hv/dxgkrnl/dxgvmbus.h   |  873 +++++
> > >  drivers/hv/dxgkrnl/hmgr.c       |  604 ++++
> > >  drivers/hv/dxgkrnl/hmgr.h       |  112 +
> > >  drivers/hv/dxgkrnl/ioctl.c      | 5413 +++++++++++++++++++++++++++++++
> > >  drivers/hv/dxgkrnl/misc.c       |  279 ++
> > >  drivers/hv/dxgkrnl/misc.h       |  309 ++
> > >  14 files changed, 15678 insertions(+)
> > 
> > It's almost impossible to review 15k lines at once, please break this up
> > into reviewable chunks next time.
> 
> Sorry about this, but we had to replace a lot of typedefs, which are not
> allowed by the coding style.

Ok, nice work, but that has nothing to do with how you submit a patch to
us for review.

> We expect one more big patch, which cannot be split in my opinion.

I disagree with that opinion, and so do thousands of other Linux kernel
developers who have done this successfully in the past :)

Remember, it is your job to make this as simple and as easy as possible
for me to review your code, such that it is trivial for me to understand
and accept it.  That takes more work on your side to do this, as we have
thousands of developers, but very few reviewers.  We know we waste
engineering time on this type of thing, but the end result makes for
better reviews and consequentially, better reviews.

So don't ignore this advice, remember, you are wanting me to do
something for you, for free.  Make it easy for me to do so.

> The VM
> vbus message format was changed to include additional header. As the result,
> every function in dxgvmbus.c needs to be changed to handle the new header. I
> do not see how this can be split to multiple patches so each patch produces
> a working driver.

It doesn't have to "work" fully, see many many examples of how to do
this every week submitted to us.  It's not an impossible task at all.

> > > +++ b/drivers/hv/dxgkrnl/Kconfig
> > > @@ -0,0 +1,10 @@
> > > +#
> > > +# dxgkrnl configuration
> > > +#
> > > +
> > > +config DXGKRNL
> > > +	tristate "Microsoft virtual GPU support"
> > > +	depends on HYPERV
> > > +	help
> > > +	  This driver supports Microsoft virtual GPU.
> > > +
> > 
> > You need more text here, this isn't a staging driver submission :)
> Is the the proposed description good enough?

What proposed description?

> "This driver handles paravirtualized GPU devices exposed by Microsoft
> Hyper-V when Linux is running inside of a virtual machine hosted
> by Windows."

That's better, but really, when a tiny serial port driver has more text
than this huge thing, you might want to consider expanding on exactly
what you want people to understand...

> > > +struct d3dkmt_closeadapter {
> > > +	struct d3dkmthandle		adapter_handle;
> > > +};
> > 
> > A "handle"?  And that has to be one of the most difficult structure
> > names ever :)
> > 
> > Why not just use the "handle" for the structure as obviously that's all
> > that is needed here.
> The structure definition matches the Windows D3DKMT interface. Some input
> structures to the interface functions have only one member. But there is
> possibility that new member could be added in the future. We prefer to have
> matching names between Windows and Linux to avoid confusion.

Don't write code because "it might change in the future".  Write code
for what you have today.  If it does change in the future, wonderful, go
and change the code.  You have the full ability to do so then, no need
to hurt all of us today for that potential.

As for "matching names", why does that matter?  Who sees both names at
the same time?

> > > +
> > > +struct d3dkmt_openadapterfromluid {
> > > +	struct winluid			adapter_luid;
> > > +	struct d3dkmthandle		adapter_handle;
> > > +};
> > > +
> > > +struct d3dddi_allocationlist {
> > > +	struct d3dkmthandle		allocation;
> > > +	union {
> > > +		struct {
> > > +			uint		write_operation		:1;
> > > +			uint		do_not_retire_instance	:1;
> > > +			uint		offer_priority		:3;
> > > +			uint		reserved		:27;
> > 
> > endian issues?
> > 
> > If not, why are these bit fields?
> This matches the definition on the Windows side. Windows only works on
> little endian platforms.

But Linux works on both, so you need to properly document/handle this somehow.

> > 
> > > +struct d3dkmt_destroydevice {
> > > +	struct d3dkmthandle		device;
> > > +};
> > 
> > Again, single entity structures?
> > 
> > Are you trying to pass around "handles" and cast them backwards?
> > 
> > If so, great, but then use the real kernel structures for that like
> > 'struct device' if these are actually devices.
> > 
> Again. The structure matches the definition on the Windows side to avoid
> confusion.

Who is confused here?  We accept naming conventions that do not match
the normal Linux style when they are referring to external sources of
the data.  Examples of this are USB device field names, and other
hardware specifications that are public.  You aren't sharing code with a
Windows system, so please follow the Linux coding style rules, as you
want Linux developers to be helping you maintain this code, not
developers who have ever read code from other operating systems.

So please follow the rule of, "unless these fields and structures are
publically defined somewhere, use Linux naming rules", like all of the
rest of us do.

> > > +	ret = dxgglobal_getiospace(dxgglobal);
> > > +	if (ret) {
> > > +		pr_err("getiospace failed: %d\n", ret);
> > > +		goto error;
> > > +	}
> > > +
> > > +	ret = dxgvmb_send_set_iospace_region(dxgglobal->mmiospace_base,
> > > +					     dxgglobal->mmiospace_size, 0);
> > > +	if (ISERROR(ret)) {
> > > +		pr_err("send_set_iospace_region failed");
> > > +		goto error;
> > 
> > You forgot to unwind from the things you initialized above :(
> The caller of dxgglobal_init_global_channel() checks the return value and
> calls dxgglobal_destroy_global_channel() in case of an error, which does the
> cleanup. If preferred the call to destroy the channel could be moved to the
> end of this function.

It is generally a good idea for a function to clean up after itself if
things go wrong as it is almost impossible for a reader of the code, or
automated tools, to determine that these resources are freed up by an
external call later on in the code path.

So yes, please fix this up.

> > > +static void dxgglobal_destroy_global_channel(void)
> > > +{
> > > +	dxglockorder_acquire(DXGLOCK_GLOBAL_CHANNEL);
> > > +	down_write(&dxgglobal->channel_lock);
> > > +
> > > +	TRACE_DEBUG(1, "%s", __func__);
> > 
> > ftrace is your friend :)
> I mentioned in other mail that these macros will be removed when we pick to
> final tracing technology for the driver.

Please pick now, no need to wait :)

thanks,

greg k-h
