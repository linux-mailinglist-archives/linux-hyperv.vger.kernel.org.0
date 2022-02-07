Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE2374AC913
	for <lists+linux-hyperv@lfdr.de>; Mon,  7 Feb 2022 20:03:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231253AbiBGTCm (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 7 Feb 2022 14:02:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235087AbiBGS71 (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 7 Feb 2022 13:59:27 -0500
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id DBF72C0401E0;
        Mon,  7 Feb 2022 10:59:26 -0800 (PST)
Received: from [192.168.1.17] (unknown [192.182.151.181])
        by linux.microsoft.com (Postfix) with ESMTPSA id 6081420B87DC;
        Mon,  7 Feb 2022 10:59:26 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 6081420B87DC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1644260366;
        bh=qnPRMfr3c5IgREOlj6BVGD2d9Eo+Ll7t5iBZeIolVII=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=H9jrmewIVXQceTZmVhtfMmDt/HEPmjHbNqhVBCHmn1RFlQSclLlxOVNYcpqJ6C4gs
         naUgCvS2ZPTgbW/iSs6a8R4O9993OxXAJmMhMwfjSoefnf6Sz/SDcJNb1oBGdYuqK0
         L0uNVMzVer432HvZeELG+z+3W6OuQc9XLeOCEVSo=
Message-ID: <a10cc7b6-98bc-e123-edfa-2cd4eba6c5c3@linux.microsoft.com>
Date:   Mon, 7 Feb 2022 10:59:25 -0800
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
From:   Iouri Tarassov <iourit@linux.microsoft.com>
In-Reply-To: <Yf40f9MBfPPfyNuS@kroah.com>
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


On 2/5/2022 12:25 AM, Greg KH wrote:
> On Fri, Feb 04, 2022 at 06:33:59PM -0800, Iouri Tarassov wrote:
> > This is the first commit for adding support for a Hyper-V based
> > vGPU implementation that exposes the DirectX API to Linux userspace.
> > 
>
> Only add the interfaces for the changes that you need in this commit.
> Do not add them all and then use them later, that makes it impossible to
> review.
>
> > ---
> >  MAINTAINERS                     |    7 +
> >  drivers/hv/Kconfig              |    2 +
> >  drivers/hv/Makefile             |    1 +
> >  drivers/hv/dxgkrnl/Kconfig      |   26 +
> >  drivers/hv/dxgkrnl/Makefile     |    5 +
> >  drivers/hv/dxgkrnl/dxgadapter.c |  172 +++
> >  drivers/hv/dxgkrnl/dxgkrnl.h    |  223 ++++
> >  drivers/hv/dxgkrnl/dxgmodule.c  |  736 ++++++++++++
> >  drivers/hv/dxgkrnl/dxgprocess.c |   17 +
> >  drivers/hv/dxgkrnl/dxgvmbus.c   |  578 +++++++++
> >  drivers/hv/dxgkrnl/dxgvmbus.h   |  855 ++++++++++++++
> >  drivers/hv/dxgkrnl/hmgr.c       |   23 +
> >  drivers/hv/dxgkrnl/hmgr.h       |   75 ++
> >  drivers/hv/dxgkrnl/ioctl.c      |   24 +
> >  drivers/hv/dxgkrnl/misc.c       |   37 +
> >  drivers/hv/dxgkrnl/misc.h       |   89 ++
> >  include/linux/hyperv.h          |   16 +
> >  include/uapi/misc/d3dkmthk.h    | 1945 +++++++++++++++++++++++++++++++
> >  18 files changed, 4831 insertions(+)
>
> Would you want to review a 4800 line patch all at once?
>
> greg k-h

Hi Greg,

Thank you for reviewing. I appreciate your time.

I am trying to find compromise between the number of patches and making
review easy. There are about 70 IOCTLs in the driver interface, so 
having a patch
for every IOCTL seems excessive.

I tried to add only definitions for the internal objects, which are used 
in the patch.

1. d3dkmthk.h defines the user mode interface structures. This is ported 
from
  the windows header at once. Is it acceptable to add it at it is?

2. dxgvmbus.h defines the VM bus interface between the linux guest and 
the host.
It was ported from the windows version at once. Is it acceptable to add 
it as it is?

3. Is it acceptable to combine logically connected IOCTLs to a single patch?
For example, IOCTLs for creation/destruction sync object and submission 
of wait/signal operations.

Thanks
Iouri

