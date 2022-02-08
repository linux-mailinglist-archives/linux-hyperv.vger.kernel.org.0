Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53C0F4AD218
	for <lists+linux-hyperv@lfdr.de>; Tue,  8 Feb 2022 08:21:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245502AbiBHHUx (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 8 Feb 2022 02:20:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237283AbiBHHUw (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 8 Feb 2022 02:20:52 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42422C0401EF;
        Mon,  7 Feb 2022 23:20:50 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B426AB817D3;
        Tue,  8 Feb 2022 07:20:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8C6EC004E1;
        Tue,  8 Feb 2022 07:20:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1644304848;
        bh=WMxbne3dqYu6oWo2knWZ3QdtB7OF/7OyKubW4l9Wi6w=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Vm2GB/TVOsqx2edVv1wKFOjRrOIqqT6LLOxc/SheDTOWjDKr8N5mS6bBtRzWq3iBP
         2XFJDiBuFOL11+b+J/MmO3MYhO6CJqcEvDbHOCwIxCjUDCrP+9CjT3xf8qEJ85q1Nv
         zG7VDSGqrR0zrGVRpuINKHPK0Y/mG3gUy86ldRvo=
Date:   Tue, 8 Feb 2022 08:20:44 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Iouri Tarassov <iourit@linux.microsoft.com>
Cc:     kys@microsoft.com, haiyangz@microsoft.com, sthemmin@microsoft.com,
        wei.liu@kernel.org, linux-hyperv@vger.kernel.org,
        linux-kernel@vger.kernel.org, spronovo@microsoft.com
Subject: Re: [PATCH v2 01/24] drivers: hv: dxgkrnl: Driver initialization and
 creation of dxgadapter
Message-ID: <YgIZzKWCSCaEWPF7@kroah.com>
References: <cover.1644025661.git.iourit@linux.microsoft.com>
 <98fe53740526526c4df85a3a3d2e13e88c95f229.1644025661.git.iourit@linux.microsoft.com>
 <Yf40f9MBfPPfyNuS@kroah.com>
 <a10cc7b6-98bc-e123-edfa-2cd4eba6c5c3@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a10cc7b6-98bc-e123-edfa-2cd4eba6c5c3@linux.microsoft.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Mon, Feb 07, 2022 at 10:59:25AM -0800, Iouri Tarassov wrote:
> 
> On 2/5/2022 12:25 AM, Greg KH wrote:
> > On Fri, Feb 04, 2022 at 06:33:59PM -0800, Iouri Tarassov wrote:
> > > This is the first commit for adding support for a Hyper-V based
> > > vGPU implementation that exposes the DirectX API to Linux userspace.
> > >
> > 
> > Only add the interfaces for the changes that you need in this commit.
> > Do not add them all and then use them later, that makes it impossible to
> > review.
> > 
> > > ---
> > >  MAINTAINERS                     |    7 +
> > >  drivers/hv/Kconfig              |    2 +
> > >  drivers/hv/Makefile             |    1 +
> > >  drivers/hv/dxgkrnl/Kconfig      |   26 +
> > >  drivers/hv/dxgkrnl/Makefile     |    5 +
> > >  drivers/hv/dxgkrnl/dxgadapter.c |  172 +++
> > >  drivers/hv/dxgkrnl/dxgkrnl.h    |  223 ++++
> > >  drivers/hv/dxgkrnl/dxgmodule.c  |  736 ++++++++++++
> > >  drivers/hv/dxgkrnl/dxgprocess.c |   17 +
> > >  drivers/hv/dxgkrnl/dxgvmbus.c   |  578 +++++++++
> > >  drivers/hv/dxgkrnl/dxgvmbus.h   |  855 ++++++++++++++
> > >  drivers/hv/dxgkrnl/hmgr.c       |   23 +
> > >  drivers/hv/dxgkrnl/hmgr.h       |   75 ++
> > >  drivers/hv/dxgkrnl/ioctl.c      |   24 +
> > >  drivers/hv/dxgkrnl/misc.c       |   37 +
> > >  drivers/hv/dxgkrnl/misc.h       |   89 ++
> > >  include/linux/hyperv.h          |   16 +
> > >  include/uapi/misc/d3dkmthk.h    | 1945 +++++++++++++++++++++++++++++++
> > >  18 files changed, 4831 insertions(+)
> > 
> > Would you want to review a 4800 line patch all at once?
> > 
> > greg k-h
> 
> Hi Greg,
> 
> Thank you for reviewing. I appreciate your time.
> 
> I am trying to find compromise between the number of patches and making
> review easy. There are about 70 IOCTLs in the driver interface, so having a
> patch
> for every IOCTL seems excessive.
> 
> I tried to add only definitions for the internal objects, which are used in
> the patch.
> 
> 1. d3dkmthk.h defines the user mode interface structures. This is ported
> from
>  the windows header at once. Is it acceptable to add it at it is?

No, again, would you want to be presented with code that is not used at
all?  How would you want this to look if you had to review this?

> 2. dxgvmbus.h defines the VM bus interface between the linux guest and the
> host.
> It was ported from the windows version at once. Is it acceptable to add it
> as it is?

Again, no.

> 3. Is it acceptable to combine logically connected IOCTLs to a single patch?
> For example, IOCTLs for creation/destruction sync object and submission of
> wait/signal operations.

Yes, that makes sense.

Again, what would you want here if you had to review all of this?

I suggest stopping and taking some time and start reviewing code on the
mailing lists first.  Look at how others are doing this for large new
features, and offer up your review to those changes.  That will give you
the experience for how to do it yourself.  To expect to do this all
correct the first time without ever being on the other side of the
process very difficult.

thanks,

greg k-h
