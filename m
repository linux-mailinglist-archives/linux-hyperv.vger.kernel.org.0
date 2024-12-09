Return-Path: <linux-hyperv+bounces-3442-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 70B0C9E9E48
	for <lists+linux-hyperv@lfdr.de>; Mon,  9 Dec 2024 19:46:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9FC5D1881EC9
	for <lists+linux-hyperv@lfdr.de>; Mon,  9 Dec 2024 18:46:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 219AF154BE2;
	Mon,  9 Dec 2024 18:46:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QnPxtFV+"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F150213B59A
	for <linux-hyperv@vger.kernel.org>; Mon,  9 Dec 2024 18:46:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733770004; cv=none; b=DLcO6/I6vSNv+xvxxF8mI6NY3DynttXbJed0lNnY8elGyfr9QAytIcE40cMOf7aQI+wCPEq/mAmfu7znuTxn9JHXr3g9JsURRrBunIS4crbb0TZF8WISuK0VdHz+lkVqT/65rqyx3+YWOMZODWhUz49kJpqlQuwAzAcMbsIXn0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733770004; c=relaxed/simple;
	bh=zan1QbSpSD1tnt1u1x41I+WnjS7tQGknMZz28q6N3Gg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ffEKgY24violBUxElpDQYVJxzMsOAB9yj8nLtOtc2d1hRv0tZ3NdlIDdokSvk3lz8a9wirhGxP8MeGIIqaHWbR4+096JCvQ0dXhZLS0f1YupeLAK6MevCqFr4vSI36GPODlqzvmp1ZDxeK733AQwSUtYii9x8rSKNjPcnUY119U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QnPxtFV+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65EA3C4CED1;
	Mon,  9 Dec 2024 18:46:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733770003;
	bh=zan1QbSpSD1tnt1u1x41I+WnjS7tQGknMZz28q6N3Gg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QnPxtFV+QUr4aFqVBQOlo1dI7cn/1R5C6ZnL2e4/Ruh7Jkf6cdggtexCPF4plPCiK
	 92cpGgDc+eeRl32THaK1x/fmLDtC8pV7Dtj1589iRd9LWDKHgcGIHSWJ04BJ1EkIwC
	 oH0Bh0xffa63edDcmpkaAkG5T79hbK3oMU/s0JFSymi8VWlYaeJiJoz49wRRmCwWfo
	 igOwDzz7xsyPbZMd9uBO3xGKmeuKBzO/nVbKz2LB08TCqABcsQQ0jIS/n9ak08JEwx
	 X7ZtqCdM3fStmxcL9Go/kL5Pw276tl0PVpCxJ422F9fdOzyu+PNJ715W1SkRA26iMv
	 Fw+O4pfykTkPA==
Date: Mon, 9 Dec 2024 18:46:42 +0000
From: Wei Liu <wei.liu@kernel.org>
To: Saurabh Singh Sengar <ssengar@linux.microsoft.com>
Cc: Wei Liu <wei.liu@kernel.org>,
	Adrian Vladu <avladu@cloudbasesolutions.com>,
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	Alessandro Pilotti <apilotti@cloudbasesolutions.com>,
	Mathieu Tortuyaux <mtortuyaux@microsoft.com>
Subject: Re: kernel: fix hv tools build for arm64 when cross-built
Message-ID: <Z1c7Er37YET8rXzo@liuwe-devbox-debian-v2>
References: <PR3PR09MB54119DB2FD76977C62D8DD6AB04D2@PR3PR09MB5411.eurprd09.prod.outlook.com>
 <Z1Y9ZkAt9GPjQsGi@liuwe-devbox-debian-v2>
 <20241209083035.GA25242@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241209083035.GA25242@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>

On Mon, Dec 09, 2024 at 12:30:35AM -0800, Saurabh Singh Sengar wrote:
> On Mon, Dec 09, 2024 at 12:44:22AM +0000, Wei Liu wrote:
> > On Wed, Oct 23, 2024 at 02:01:12PM +0000, Adrian Vladu wrote:
> > > Hello,
> > > 
> > > While trying to build the LIS daemons for Flatcar Container Linux for
> > > ARM64 (https://www.flatcar.org/), as we are doing Gentoo based
> > > cross-building from X64 boxes, there was an error while building those
> > > daemons, because the cross-compile scenario was not working, as ` ARCH
> > > := $(shell uname -m 2>/dev/null)` always returns `x86_64`.
> > > 
> > > I have a working patch for the Linux kernel here that was already
> > > applied in the Flatcar context and it works:
> > > https://github.com/flatcar/scripts/blob/94b1df1b19449eb5aa967fd48ba4c1f4a6d5f415/sdk_container/src/third_party/coreos-overlay/sys-kernel/coreos-sources/files/6.10/z0008-tools-hv-fix-cross-compilation-for-ARM64.patch
> > > 
> > > Raw patch link here:
> > > https://raw.githubusercontent.com/flatcar/scripts/94b1df1b19449eb5aa967fd48ba4c1f4a6d5f415/sdk_container/src/third_party/coreos-overlay/sys-kernel/coreos-sources/files/6.10/z0008-tools-hv-fix-cross-compilation-for-ARM64.patch
> > > 
> > > Sorry for the delivery method via github link, but I cannot send
> > > proper patches from my work email address currently, as the email
> > > server does not support it.
> > > 
> > > Please let me know if I need to send the patch via the recommended way
> > > or if the patch can be used directly.
> > > 
> > > Also, maybe there is a better way to address the cross-compilation
> > > issue, I just wanted to report the bug and also provide a possible
> > > fix.
> > 
> > Saurabh added the ARCH variable. He's CCed.
> > 
> > BTW I think your patch can be simplified by using
> >   ARCH ?= $(shell uname -m 2>/dev/null)
> > instead of the ifeq test in your patch.
> 
> Agree, this is better way to handle it.
> 
> > 
> > I don't think that's correct. ARCH will be set to the correct value by
> > Kbuild. 
> 
> If we build locally on ARM64, there is a chance that ARCH may not be set,
> leading to build failures for arm64. IMO we should provide a fallback
> option for local builds when ARCH is not set.

How do you build locally? Even if you build those tools in tools/hv, it
still uses the Kbuild system, which sets ARCH to the correct value,
right?

Thanks,
Wei.

