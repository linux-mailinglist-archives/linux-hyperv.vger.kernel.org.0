Return-Path: <linux-hyperv+bounces-3455-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 68EF89EB963
	for <lists+linux-hyperv@lfdr.de>; Tue, 10 Dec 2024 19:34:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E72B9161044
	for <lists+linux-hyperv@lfdr.de>; Tue, 10 Dec 2024 18:34:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B02C155757;
	Tue, 10 Dec 2024 18:34:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a8d0nqoB"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 465198634A
	for <linux-hyperv@vger.kernel.org>; Tue, 10 Dec 2024 18:34:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733855670; cv=none; b=Xtg6xlXXhKoQ5PZwQrXdJJBirJDbP/Cq7yb5a13x3HH3WR7ilw4R/8sCVeDhIS/DfZG1OivgmIzF9KYdOjjHTlEIjvXz5QCY5VKR4Jeo4g1oHqsb/SBq8CZd7yEKMynhWcidRBz+KXeGLDwPLc4BI/Z7GxS2TXLzZxdHsfq8ZoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733855670; c=relaxed/simple;
	bh=iM6n3n15xvAfMAostk2rQffta9gbg7SsBi2o6dvIIYA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GaJ11CyZMC6Wu0IW0HTzWMJcm1dk22UsjUF0qpnQpd7xeB3C8d2oAkneBmJ0gz4l7e8PqzBBErdeZ54KhvfwlYUNF1oAj+5wyL0FYgOfsUaGxfcFi/l7AuqF2VAGAjmeoYKNJLCTZleR3o27L3oachE4Wl8jxfWFdsD/MCXLOUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a8d0nqoB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9AAD3C4CED6;
	Tue, 10 Dec 2024 18:34:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733855669;
	bh=iM6n3n15xvAfMAostk2rQffta9gbg7SsBi2o6dvIIYA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=a8d0nqoBNdZgwuIW3jVmIDGv7/NtRUCn2UNclBwzAWm1WznykyBQ4xuKuArOz6hFy
	 k1P7o25FzQtNcIPA9SNHUuuOk1Eg1q8brEvC9jF+pMB24MZjW2JNHkU0xhDkZmbPKv
	 O4sA+xSu2JN2hgtRJYgnWVgQG77AMo8ORv9pkBKkqecMN25VVKFX3BQb7jf5cm77V9
	 f30Vs0oz4TSg4QFNpV2uyDPoK3tc3lZc/SV+atRsmPXs5eoSGozmzxECQSmYYO0KC4
	 LEy/8FVB5gc+n5Hrskb8UghRK6AzI9X8nJyPyua7pxM6wMu5YNHoq1JKQat2zjSehj
	 jpKLLDXmIE6+g==
Date: Tue, 10 Dec 2024 18:34:28 +0000
From: Wei Liu <wei.liu@kernel.org>
To: Saurabh Singh Sengar <ssengar@linux.microsoft.com>
Cc: Wei Liu <wei.liu@kernel.org>,
	Adrian Vladu <avladu@cloudbasesolutions.com>,
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	Alessandro Pilotti <apilotti@cloudbasesolutions.com>,
	Mathieu Tortuyaux <mtortuyaux@microsoft.com>
Subject: Re: kernel: fix hv tools build for arm64 when cross-built
Message-ID: <Z1iJtM3q59PsoKzh@liuwe-devbox-debian-v2>
References: <PR3PR09MB54119DB2FD76977C62D8DD6AB04D2@PR3PR09MB5411.eurprd09.prod.outlook.com>
 <Z1Y9ZkAt9GPjQsGi@liuwe-devbox-debian-v2>
 <20241209083035.GA25242@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
 <Z1c7Er37YET8rXzo@liuwe-devbox-debian-v2>
 <20241210033910.GA14466@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241210033910.GA14466@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>

On Mon, Dec 09, 2024 at 07:39:10PM -0800, Saurabh Singh Sengar wrote:
> On Mon, Dec 09, 2024 at 06:46:42PM +0000, Wei Liu wrote:
> > On Mon, Dec 09, 2024 at 12:30:35AM -0800, Saurabh Singh Sengar wrote:
> > > On Mon, Dec 09, 2024 at 12:44:22AM +0000, Wei Liu wrote:
> > > > On Wed, Oct 23, 2024 at 02:01:12PM +0000, Adrian Vladu wrote:
> > > > > Hello,
> > > > > 
> > > > > While trying to build the LIS daemons for Flatcar Container Linux for
> > > > > ARM64 (https://www.flatcar.org/), as we are doing Gentoo based
> > > > > cross-building from X64 boxes, there was an error while building those
> > > > > daemons, because the cross-compile scenario was not working, as ` ARCH
> > > > > := $(shell uname -m 2>/dev/null)` always returns `x86_64`.
> > > > > 
> > > > > I have a working patch for the Linux kernel here that was already
> > > > > applied in the Flatcar context and it works:
> > > > > https://github.com/flatcar/scripts/blob/94b1df1b19449eb5aa967fd48ba4c1f4a6d5f415/sdk_container/src/third_party/coreos-overlay/sys-kernel/coreos-sources/files/6.10/z0008-tools-hv-fix-cross-compilation-for-ARM64.patch
> > > > > 
> > > > > Raw patch link here:
> > > > > https://raw.githubusercontent.com/flatcar/scripts/94b1df1b19449eb5aa967fd48ba4c1f4a6d5f415/sdk_container/src/third_party/coreos-overlay/sys-kernel/coreos-sources/files/6.10/z0008-tools-hv-fix-cross-compilation-for-ARM64.patch
> > > > > 
> > > > > Sorry for the delivery method via github link, but I cannot send
> > > > > proper patches from my work email address currently, as the email
> > > > > server does not support it.
> > > > > 
> > > > > Please let me know if I need to send the patch via the recommended way
> > > > > or if the patch can be used directly.
> > > > > 
> > > > > Also, maybe there is a better way to address the cross-compilation
> > > > > issue, I just wanted to report the bug and also provide a possible
> > > > > fix.
> > > > 
> > > > Saurabh added the ARCH variable. He's CCed.
> > > > 
> > > > BTW I think your patch can be simplified by using
> > > >   ARCH ?= $(shell uname -m 2>/dev/null)
> > > > instead of the ifeq test in your patch.
> > > 
> > > Agree, this is better way to handle it.
> > > 
> > > > 
> > > > I don't think that's correct. ARCH will be set to the correct value by
> > > > Kbuild. 
> > > 
> > > If we build locally on ARM64, there is a chance that ARCH may not be set,
> > > leading to build failures for arm64. IMO we should provide a fallback
> > > option for local builds when ARCH is not set.
> > 
> > How do you build locally? Even if you build those tools in tools/hv, it
> > still uses the Kbuild system, which sets ARCH to the correct value,
> > right?
> > 
> 
> I have tested your patch in ARM64 VM, can see the build failure. Here's the
> exact details how I tested:
> 
> 
> azureuser@ARM64-ubunutu24:/work/linux-next$ cd tools/hv/
> azureuser@ARM64-ubunutu24:/work/linux-next/tools/hv$ make
> make[1]: Entering directory '/work/linux-next/tools/hv'
>   CC      hv_kvp_daemon.o
>   LD      hv_kvp_daemon-in.o
> make[1]: Leaving directory '/work/linux-next/tools/hv'
>   LINK    hv_kvp_daemon
> make[1]: Entering directory '/work/linux-next/tools/hv'
>   CC      hv_vss_daemon.o
>   LD      hv_vss_daemon-in.o
> make[1]: Leaving directory '/work/linux-next/tools/hv'
>   LINK    hv_vss_daemon
> make[1]: Entering directory '/work/linux-next/tools/hv'
>   CC      hv_fcopy_uio_daemon.o
>   CC      vmbus_bufring.o
> vmbus_bufring.c:11:10: fatal error: emmintrin.h: No such file or directory
>    11 | #include <emmintrin.h>
>       |          ^~~~~~~~~~~~~

I see. I create an arm64 VM and reproduce the issue. The ARCH variable
is not set.

That said, the build breaks because emmintrin.h is not available on
arm64. It is only needed for _mm_pause().  There is maybe an
architecture specific header file we can use to make it build.

Thanks,
Wei.

> compilation terminated.
> make[1]: *** [/work/linux-next/tools/build/Makefile.build:106: vmbus_bufring.o] Error 1
> make[1]: Leaving directory '/work/linux-next/tools/hv'
> make: *** [Makefile:48: hv_fcopy_uio_daemon-in.o] Error 2
> azureuser@ARM64-ubunutu24:/work/linux-next/tools/hv$ uname -a
> Linux ARM64-ubunutu24 6.12.0-next-20241128+ #12 SMP Fri Nov 29 14:53:06 UTC 2024 aarch64 aarch64 aarch64 GNU/Linux
> 
> - Saurabh

