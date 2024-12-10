Return-Path: <linux-hyperv+bounces-3446-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B1BE9EA6C1
	for <lists+linux-hyperv@lfdr.de>; Tue, 10 Dec 2024 04:39:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CDF53287B15
	for <lists+linux-hyperv@lfdr.de>; Tue, 10 Dec 2024 03:39:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 808861D4609;
	Tue, 10 Dec 2024 03:39:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="BpS+DTnJ"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E96911C242C
	for <linux-hyperv@vger.kernel.org>; Tue, 10 Dec 2024 03:39:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733801952; cv=none; b=PRJBnxmEiW5ThJCrGtqab2HBI9ba8Idob5yCILKO+HDquyNHMQHvR7cO6R9GUJp/xCUzqFnYLH585Q6GvLOYyktpj9zhmUUVKnZRbZ4kazfuHvU8+c7s+PQmxCY703okHIn5L39nM4xLelk3gEEt6RE83VL8qGd2ZH2eznyakhE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733801952; c=relaxed/simple;
	bh=5/RwsBEZRJ/YukDB6f9f8gQfSUNmL4bun+iDDe+GBvE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FUFvhE0k/ijc3J4pIenRXawpnJMOK7oLK4AWsdxAx+EYaiLw2Bb9xnXEQii+h9gB2Tg5Opep8ZXQ0AV6eMcWoyhTRmVDl8O03jBuIy5wCjM83+oRfzADsd7Iv3Wr9Uw2xy6ocsFjttYEzfB7uiJKAMaM/NFbaOF/szUElxJXD1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=BpS+DTnJ; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1127)
	id 4E17D2047203; Mon,  9 Dec 2024 19:39:10 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 4E17D2047203
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1733801950;
	bh=AogAhxwRCRQIvDNAGvKVW1i0rjBtIOlYiVMdz5WnafI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BpS+DTnJVMaWVCAi+v/NKwitKBqcZi7wNltB8OdDxa8d+j/MXmHskcOxpoiymsWIf
	 HRmfiBfj1IONZTl6vyc3rlrqQpQlbpurG9EnWtOKH/hGk06r7EFMlNj68PUyNXQtOP
	 DTuSPUI28kCXEUnlBNTyqXqce5S+7EN0fFpkiai8=
Date: Mon, 9 Dec 2024 19:39:10 -0800
From: Saurabh Singh Sengar <ssengar@linux.microsoft.com>
To: Wei Liu <wei.liu@kernel.org>
Cc: Adrian Vladu <avladu@cloudbasesolutions.com>,
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	Alessandro Pilotti <apilotti@cloudbasesolutions.com>,
	Mathieu Tortuyaux <mtortuyaux@microsoft.com>
Subject: Re: kernel: fix hv tools build for arm64 when cross-built
Message-ID: <20241210033910.GA14466@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <PR3PR09MB54119DB2FD76977C62D8DD6AB04D2@PR3PR09MB5411.eurprd09.prod.outlook.com>
 <Z1Y9ZkAt9GPjQsGi@liuwe-devbox-debian-v2>
 <20241209083035.GA25242@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
 <Z1c7Er37YET8rXzo@liuwe-devbox-debian-v2>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z1c7Er37YET8rXzo@liuwe-devbox-debian-v2>
User-Agent: Mutt/1.5.21 (2010-09-15)

On Mon, Dec 09, 2024 at 06:46:42PM +0000, Wei Liu wrote:
> On Mon, Dec 09, 2024 at 12:30:35AM -0800, Saurabh Singh Sengar wrote:
> > On Mon, Dec 09, 2024 at 12:44:22AM +0000, Wei Liu wrote:
> > > On Wed, Oct 23, 2024 at 02:01:12PM +0000, Adrian Vladu wrote:
> > > > Hello,
> > > > 
> > > > While trying to build the LIS daemons for Flatcar Container Linux for
> > > > ARM64 (https://www.flatcar.org/), as we are doing Gentoo based
> > > > cross-building from X64 boxes, there was an error while building those
> > > > daemons, because the cross-compile scenario was not working, as ` ARCH
> > > > := $(shell uname -m 2>/dev/null)` always returns `x86_64`.
> > > > 
> > > > I have a working patch for the Linux kernel here that was already
> > > > applied in the Flatcar context and it works:
> > > > https://github.com/flatcar/scripts/blob/94b1df1b19449eb5aa967fd48ba4c1f4a6d5f415/sdk_container/src/third_party/coreos-overlay/sys-kernel/coreos-sources/files/6.10/z0008-tools-hv-fix-cross-compilation-for-ARM64.patch
> > > > 
> > > > Raw patch link here:
> > > > https://raw.githubusercontent.com/flatcar/scripts/94b1df1b19449eb5aa967fd48ba4c1f4a6d5f415/sdk_container/src/third_party/coreos-overlay/sys-kernel/coreos-sources/files/6.10/z0008-tools-hv-fix-cross-compilation-for-ARM64.patch
> > > > 
> > > > Sorry for the delivery method via github link, but I cannot send
> > > > proper patches from my work email address currently, as the email
> > > > server does not support it.
> > > > 
> > > > Please let me know if I need to send the patch via the recommended way
> > > > or if the patch can be used directly.
> > > > 
> > > > Also, maybe there is a better way to address the cross-compilation
> > > > issue, I just wanted to report the bug and also provide a possible
> > > > fix.
> > > 
> > > Saurabh added the ARCH variable. He's CCed.
> > > 
> > > BTW I think your patch can be simplified by using
> > >   ARCH ?= $(shell uname -m 2>/dev/null)
> > > instead of the ifeq test in your patch.
> > 
> > Agree, this is better way to handle it.
> > 
> > > 
> > > I don't think that's correct. ARCH will be set to the correct value by
> > > Kbuild. 
> > 
> > If we build locally on ARM64, there is a chance that ARCH may not be set,
> > leading to build failures for arm64. IMO we should provide a fallback
> > option for local builds when ARCH is not set.
> 
> How do you build locally? Even if you build those tools in tools/hv, it
> still uses the Kbuild system, which sets ARCH to the correct value,
> right?
> 

I have tested your patch in ARM64 VM, can see the build failure. Here's the
exact details how I tested:


azureuser@ARM64-ubunutu24:/work/linux-next$ cd tools/hv/
azureuser@ARM64-ubunutu24:/work/linux-next/tools/hv$ make
make[1]: Entering directory '/work/linux-next/tools/hv'
  CC      hv_kvp_daemon.o
  LD      hv_kvp_daemon-in.o
make[1]: Leaving directory '/work/linux-next/tools/hv'
  LINK    hv_kvp_daemon
make[1]: Entering directory '/work/linux-next/tools/hv'
  CC      hv_vss_daemon.o
  LD      hv_vss_daemon-in.o
make[1]: Leaving directory '/work/linux-next/tools/hv'
  LINK    hv_vss_daemon
make[1]: Entering directory '/work/linux-next/tools/hv'
  CC      hv_fcopy_uio_daemon.o
  CC      vmbus_bufring.o
vmbus_bufring.c:11:10: fatal error: emmintrin.h: No such file or directory
   11 | #include <emmintrin.h>
      |          ^~~~~~~~~~~~~
compilation terminated.
make[1]: *** [/work/linux-next/tools/build/Makefile.build:106: vmbus_bufring.o] Error 1
make[1]: Leaving directory '/work/linux-next/tools/hv'
make: *** [Makefile:48: hv_fcopy_uio_daemon-in.o] Error 2
azureuser@ARM64-ubunutu24:/work/linux-next/tools/hv$ uname -a
Linux ARM64-ubunutu24 6.12.0-next-20241128+ #12 SMP Fri Nov 29 14:53:06 UTC 2024 aarch64 aarch64 aarch64 GNU/Linux

- Saurabh

