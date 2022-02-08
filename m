Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 495D14AE0B0
	for <lists+linux-hyperv@lfdr.de>; Tue,  8 Feb 2022 19:24:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1384781AbiBHSYb (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 8 Feb 2022 13:24:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1384827AbiBHSY3 (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 8 Feb 2022 13:24:29 -0500
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0797BC061576;
        Tue,  8 Feb 2022 10:24:27 -0800 (PST)
Received: from [192.168.1.17] (unknown [192.182.151.181])
        by linux.microsoft.com (Postfix) with ESMTPSA id 7F43B20B90CC;
        Tue,  8 Feb 2022 10:24:26 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 7F43B20B90CC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1644344666;
        bh=QMYPts7c7dD+rlJaWW7pjZHqR53IRrbmcgY9kyd0KSE=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=WkXj8oQ+bsG5VrIynKlh0LQUSCIhJuYfTkw+ZzaLwGaUGdlx9PQ6ITKwakNa2L8ga
         tGGebby3r6b56nlMeoRPjoesYxuPlQ54B8zvqENkMllOzeXB/a4eQ2QWQuerhTflFx
         vfvjHfiGD2ADOcgRAKtFOa00ijb0GQpGtbcBzc88=
Message-ID: <5493bb21-7c85-9a8a-07f6-983d1d5c425b@linux.microsoft.com>
Date:   Tue, 8 Feb 2022 10:24:26 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: [PATCH v2 01/24] drivers: hv: dxgkrnl: Driver initialization and
 creation of dxgadapter
Content-Language: en-US
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     kys@microsoft.com, haiyangz@microsoft.com, sthemmin@microsoft.com,
        wei.liu@kernel.org, linux-hyperv@vger.kernel.org,
        linux-kernel@vger.kernel.org, spronovo@microsoft.com
References: <cover.1644025661.git.iourit@linux.microsoft.com>
 <98fe53740526526c4df85a3a3d2e13e88c95f229.1644025661.git.iourit@linux.microsoft.com>
 <Yf40f9MBfPPfyNuS@kroah.com>
 <a10cc7b6-98bc-e123-edfa-2cd4eba6c5c3@linux.microsoft.com>
 <YgIZzKWCSCaEWPF7@kroah.com>
From:   Iouri Tarassov <iourit@linux.microsoft.com>
In-Reply-To: <YgIZzKWCSCaEWPF7@kroah.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-19.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Hi Greg,

On 2/7/2022 11:20 PM, Greg KH wrote:
> On Mon, Feb 07, 2022 at 10:59:25AM -0800, Iouri Tarassov wrote:
> > 
> > On 2/5/2022 12:25 AM, Greg KH wrote:
> > > On Fri, Feb 04, 2022 at 06:33:59PM -0800, Iouri Tarassov wrote:
> > > > This is the first commit for adding support for a Hyper-V based
> > > > vGPU implementation that exposes the DirectX API to Linux userspace.
> > > >
> > > 
> > > Only add the interfaces for the changes that you need in this commit.
> > > Do not add them all and then use them later, that makes it impossible to
> > > review.
> > > 
> > > > ---
> > > >  MAINTAINERS                     |    7 +
> > > >  drivers/hv/Kconfig              |    2 +
> > > >  drivers/hv/Makefile             |    1 +
> > > >  drivers/hv/dxgkrnl/Kconfig      |   26 +
> > > >  drivers/hv/dxgkrnl/Makefile     |    5 +
> > > >  drivers/hv/dxgkrnl/dxgadapter.c |  172 +++
> > > >  drivers/hv/dxgkrnl/dxgkrnl.h    |  223 ++++
> > > >  drivers/hv/dxgkrnl/dxgmodule.c  |  736 ++++++++++++
> > > >  drivers/hv/dxgkrnl/dxgprocess.c |   17 +
> > > >  drivers/hv/dxgkrnl/dxgvmbus.c   |  578 +++++++++
> > > >  drivers/hv/dxgkrnl/dxgvmbus.h   |  855 ++++++++++++++
> > > >  drivers/hv/dxgkrnl/hmgr.c       |   23 +
> > > >  drivers/hv/dxgkrnl/hmgr.h       |   75 ++
> > > >  drivers/hv/dxgkrnl/ioctl.c      |   24 +
> > > >  drivers/hv/dxgkrnl/misc.c       |   37 +
> > > >  drivers/hv/dxgkrnl/misc.h       |   89 ++
> > > >  include/linux/hyperv.h          |   16 +
> > > >  include/uapi/misc/d3dkmthk.h    | 1945 +++++++++++++++++++++++++++++++
> > > >  18 files changed, 4831 insertions(+)
> > > 
> > > Would you want to review a 4800 line patch all at once?
> > > 
> > > greg k-h
> > 
> > Hi Greg,
> > 
> > Thank you for reviewing. I appreciate your time.
> > 
> > 1. d3dkmthk.h defines the user mode interface structures. This is ported
> > from
> >  the windows header at once. Is it acceptable to add it at it is?
>
> No, again, would you want to be presented with code that is not used at
> all?  How would you want this to look if you had to review this?

Could you recommend a similar in size driver to look how it was first 
submitted?

I looked at the Habanalabs driver submission, which was signed off by you.

The commit 1ea2a20e91a4d0543a933b4df706c2585db7e3ae adds 94 header 
files, without using the definitions.

     habanalabs: add Goya registers header files
     This patch just adds a lot of header files that contain description of
     Goya's registers.
     Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

How did you review this? I do not see much difference between defining 
an interface to a virtual device and
defining an interface to a hardware device.

d3dkmthk.h defines a binary interface to the compute driver. It cannot 
be changed, because it must
be binary compatible with the Windows display graphics model.
In my opinion the only thing to review here is the usage of the correct 
Linux types and coding style.
I can submit the file in a dedicated patch.

> > 2. dxgvmbus.h defines the VM bus interface between the linux guest and the
> > host.
> > It was ported from the windows version at once. Is it acceptable to add it
> > as it is?
>
> Again, no.

The same here.
dxgvmbus.h defines the binary VM bus interface between the host and guest.
It must be compatible with the existing interface.It cannot be changed.
In my opinion the only thing to review here is the usage of the correct 
Linux types and coding style.
I can submit the file in a dedicated patch.

What are you looking to review in these interface? I am trying to avoid 
unnecessary work, but will do it
if it really helps during review.

Thanks a lot,
Iouri


