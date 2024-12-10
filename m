Return-Path: <linux-hyperv+bounces-3456-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D35E9EB9D5
	for <lists+linux-hyperv@lfdr.de>; Tue, 10 Dec 2024 20:07:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4ED1F16758D
	for <lists+linux-hyperv@lfdr.de>; Tue, 10 Dec 2024 19:07:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 942192046AE;
	Tue, 10 Dec 2024 19:07:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ppUqnn2f"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F210194080
	for <linux-hyperv@vger.kernel.org>; Tue, 10 Dec 2024 19:07:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733857659; cv=none; b=ZtxUDEf/roGnZkkPSQBZdBdmR+GNRfvRPvfevca9CL5RGjbRc/ml9lieI3+TruFikG+6Mw3tniYLCo0B2ov6/D95QJgs+2/8PcV1fznOgAL6FlPdUX0hSVP3EdVzu6ETJARdWrDX82BEn9yBn6nCYcBL1deUz3FHqbAZu09Pvl0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733857659; c=relaxed/simple;
	bh=V4uHHDJQdjcLREtssNGGJYufbkyZVqT5028TP7dr4Vg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W7fZr2rnFItYMJatJ6ldUaEkdYnzVqxH45iwzpFKci+kIHJk+JaxIdJCmGTZL67hZd9U//OopnApqLuVA3DcQ2My6gQjKjT/qHFeL5K73reHDeSVw44rLc65tPp90km9uxXTy44a6jK0r3yJSb++QHVOj41e0xm9iuyyTzmf+Bo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ppUqnn2f; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9A23C4CED6;
	Tue, 10 Dec 2024 19:07:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733857659;
	bh=V4uHHDJQdjcLREtssNGGJYufbkyZVqT5028TP7dr4Vg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ppUqnn2fNKt/JDN5uUZXFrAf9KfPP2gi9KjIic5OgwtmsRPx96LxBjNPvauFLAQ+l
	 fa95aWIXHyd9q6XGjEKfMv2LkSek4pX9UZhTz2g1k3jEH+K7jXxhQQmnEP4PhtJo1Q
	 MRb0wLEbUZn9ZhlEzzODE9f4UU4QJXGm7BtU/Pxzc4hrYk+6QPuuIQgADxgzk4OFPg
	 huBTMgW5JrkOUmPYpFNXSBoK+VCToNhFGbpnt3uZanAUoAhV2BU6HtfvhFaeMv/xyh
	 7cDsz3AA8GRsd1/8ncyR3RGGIzGwL3zKqtdFd03ggM17RpyxkIFZIcLOeeJEZItdmu
	 Jybf09DxsZu1A==
Date: Tue, 10 Dec 2024 19:07:37 +0000
From: Wei Liu <wei.liu@kernel.org>
To: Saurabh Singh Sengar <ssengar@linux.microsoft.com>
Cc: Wei Liu <wei.liu@kernel.org>,
	Adrian Vladu <avladu@cloudbasesolutions.com>,
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	Alessandro Pilotti <apilotti@cloudbasesolutions.com>,
	Mathieu Tortuyaux <mtortuyaux@microsoft.com>
Subject: Re: kernel: fix hv tools build for arm64 when cross-built
Message-ID: <Z1iRedv6XoVJ56lh@liuwe-devbox-debian-v2>
References: <PR3PR09MB54119DB2FD76977C62D8DD6AB04D2@PR3PR09MB5411.eurprd09.prod.outlook.com>
 <Z1Y9ZkAt9GPjQsGi@liuwe-devbox-debian-v2>
 <20241209083035.GA25242@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
 <Z1c7Er37YET8rXzo@liuwe-devbox-debian-v2>
 <20241210033910.GA14466@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
 <Z1iJtM3q59PsoKzh@liuwe-devbox-debian-v2>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z1iJtM3q59PsoKzh@liuwe-devbox-debian-v2>

On Tue, Dec 10, 2024 at 06:34:28PM +0000, Wei Liu wrote:
> On Mon, Dec 09, 2024 at 07:39:10PM -0800, Saurabh Singh Sengar wrote:
> > On Mon, Dec 09, 2024 at 06:46:42PM +0000, Wei Liu wrote:
> > > On Mon, Dec 09, 2024 at 12:30:35AM -0800, Saurabh Singh Sengar wrote:
> > > > On Mon, Dec 09, 2024 at 12:44:22AM +0000, Wei Liu wrote:
> > > > > On Wed, Oct 23, 2024 at 02:01:12PM +0000, Adrian Vladu wrote:
> > > > > > Hello,
> > > > > > 
> > > > > > While trying to build the LIS daemons for Flatcar Container Linux for
> > > > > > ARM64 (https://www.flatcar.org/), as we are doing Gentoo based
> > > > > > cross-building from X64 boxes, there was an error while building those
> > > > > > daemons, because the cross-compile scenario was not working, as ` ARCH
> > > > > > := $(shell uname -m 2>/dev/null)` always returns `x86_64`.
> > > > > > 
> > > > > > I have a working patch for the Linux kernel here that was already
> > > > > > applied in the Flatcar context and it works:
> > > > > > https://github.com/flatcar/scripts/blob/94b1df1b19449eb5aa967fd48ba4c1f4a6d5f415/sdk_container/src/third_party/coreos-overlay/sys-kernel/coreos-sources/files/6.10/z0008-tools-hv-fix-cross-compilation-for-ARM64.patch
> > > > > > 
> > > > > > Raw patch link here:
> > > > > > https://raw.githubusercontent.com/flatcar/scripts/94b1df1b19449eb5aa967fd48ba4c1f4a6d5f415/sdk_container/src/third_party/coreos-overlay/sys-kernel/coreos-sources/files/6.10/z0008-tools-hv-fix-cross-compilation-for-ARM64.patch
> > > > > > 
> > > > > > Sorry for the delivery method via github link, but I cannot send
> > > > > > proper patches from my work email address currently, as the email
> > > > > > server does not support it.
> > > > > > 
> > > > > > Please let me know if I need to send the patch via the recommended way
> > > > > > or if the patch can be used directly.
> > > > > > 
> > > > > > Also, maybe there is a better way to address the cross-compilation
> > > > > > issue, I just wanted to report the bug and also provide a possible
> > > > > > fix.
> > > > > 
> > > > > Saurabh added the ARCH variable. He's CCed.
> > > > > 
> > > > > BTW I think your patch can be simplified by using
> > > > >   ARCH ?= $(shell uname -m 2>/dev/null)
> > > > > instead of the ifeq test in your patch.
> > > > 
> > > > Agree, this is better way to handle it.
> > > > 
> > > > > 
> > > > > I don't think that's correct. ARCH will be set to the correct value by
> > > > > Kbuild. 
> > > > 
> > > > If we build locally on ARM64, there is a chance that ARCH may not be set,
> > > > leading to build failures for arm64. IMO we should provide a fallback
> > > > option for local builds when ARCH is not set.
> > > 
> > > How do you build locally? Even if you build those tools in tools/hv, it
> > > still uses the Kbuild system, which sets ARCH to the correct value,
> > > right?
> > > 
> > 
> > I have tested your patch in ARM64 VM, can see the build failure. Here's the
> > exact details how I tested:
> > 
> > 
> > azureuser@ARM64-ubunutu24:/work/linux-next$ cd tools/hv/
> > azureuser@ARM64-ubunutu24:/work/linux-next/tools/hv$ make
> > make[1]: Entering directory '/work/linux-next/tools/hv'
> >   CC      hv_kvp_daemon.o
> >   LD      hv_kvp_daemon-in.o
> > make[1]: Leaving directory '/work/linux-next/tools/hv'
> >   LINK    hv_kvp_daemon
> > make[1]: Entering directory '/work/linux-next/tools/hv'
> >   CC      hv_vss_daemon.o
> >   LD      hv_vss_daemon-in.o
> > make[1]: Leaving directory '/work/linux-next/tools/hv'
> >   LINK    hv_vss_daemon
> > make[1]: Entering directory '/work/linux-next/tools/hv'
> >   CC      hv_fcopy_uio_daemon.o
> >   CC      vmbus_bufring.o
> > vmbus_bufring.c:11:10: fatal error: emmintrin.h: No such file or directory
> >    11 | #include <emmintrin.h>
> >       |          ^~~~~~~~~~~~~
> 
> I see. I create an arm64 VM and reproduce the issue. The ARCH variable
> is not set.
> 
> That said, the build breaks because emmintrin.h is not available on
> arm64. It is only needed for _mm_pause().  There is maybe an
> architecture specific header file we can use to make it build.

Never mind. There are also open coded x86 assembly code in
vmbus_bufring.c. Let's fix the cross-compilation issue first.

Thanks,
Wei.

