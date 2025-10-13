Return-Path: <linux-hyperv+bounces-7203-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id EC1C2BD5DF9
	for <lists+linux-hyperv@lfdr.de>; Mon, 13 Oct 2025 21:05:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B6E6F4E54A3
	for <lists+linux-hyperv@lfdr.de>; Mon, 13 Oct 2025 19:05:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A42AA2C0F87;
	Mon, 13 Oct 2025 19:05:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o31SYh5I"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C5481CA84;
	Mon, 13 Oct 2025 19:05:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760382348; cv=none; b=mnxpGkoBvqm2QludRZ7j86XcpIqNvcDl94+wxy0mrxRlUTPuhFVXSxz6TP9egq/bXmyAzfeewi6puI8GzNlEEYH49myr2EosA1cHtAUE+dmETp56u27Yt+v92IMxkFMPwCZQydfiR7O9S/8hrXDccOdzSie0rei6/2fc2moz1QE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760382348; c=relaxed/simple;
	bh=LIs+eH1h3tvAOe8qwrw54zyMOhRIOtOkXny411d9yII=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jOCPWNYUvuaEs9cyt7eoh0fXSTdnmhCuc3kSElIav1s5N+NijJoKnWXxDH2JKXspC1l3yV8PG7Wb6tDtiZZMrYf+0rWpDST8md/9Z0+MJ4DfO3npuPfen47pB/ABlnoNJGUaCVIochdV1JZnyJT0ab2aSceexI40IQV9AF4Ul/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o31SYh5I; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D35BEC4CEE7;
	Mon, 13 Oct 2025 19:05:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760382348;
	bh=LIs+eH1h3tvAOe8qwrw54zyMOhRIOtOkXny411d9yII=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=o31SYh5II/apx1pwAHROObEENAt0uVL2R+d/igjrbRC1l6fyB0WgL5TQpciG8UHKO
	 W/3vXh/DPUBZrLvSQRmVx+OU19Na/rVpbUcVYY6bvW4Pxe1Wgql15mFZ9ru9i8e4I0
	 Z0cVLxWUohEkynDJPnvdEWLCXu4nABVJTnROMaFBJVv2pUFQzOkSbR9cKriVGHGkdL
	 t3IZHuVZ8cBnITFGsMtIjL7J52CWN36CCq+TxLolWWJZwv3QZSHV/YWJopIM9G93qR
	 x5pSrK0j9IFJSq5wuINxA7SjmUuSraRoT2rUiIOTf5TRMqX/efUhn8tw+RPiOckhEu
	 MG++8dSP3puGQ==
Date: Mon, 13 Oct 2025 19:05:46 +0000
From: Wei Liu <wei.liu@kernel.org>
To: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
Cc: Praveen K Paladugu <prapal@linux.microsoft.com>, kys@microsoft.com,
	haiyangz@microsoft.com, wei.liu@kernel.org, decui@microsoft.com,
	tglx@linutronix.de, mingo@redhat.com, linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org, bp@alien8.de,
	dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
	arnd@arndb.de, anbelski@linux.microsoft.com
Subject: Re: [PATCH 0/2] Add support for clean shutdown with MSHV
Message-ID: <20251013190546.GC3862989@liuwe-devbox-debian-v2.local>
References: <20251009160501.6356-1-prapal@linux.microsoft.com>
 <aOg2hiWM4PZ8D1S5@skinsburskii.localdomain>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aOg2hiWM4PZ8D1S5@skinsburskii.localdomain>

On Thu, Oct 09, 2025 at 03:26:14PM -0700, Stanislav Kinsburskii wrote:
> On Thu, Oct 09, 2025 at 10:58:49AM -0500, Praveen K Paladugu wrote:
> > Add support for clean shutdown of the root partition when running on MSHV
> > hypervisor.
> > 
> > Praveen K Paladugu (2):
> >   hyperv: Add definitions for MSHV sleep state configuration
> >   hyperv: Enable clean shutdown for root partition with MSHV
> > 
> 
> There is no need to split this logic to two patches: the first one
> doesn't make sense without the second one, so it would be better to
> squash them.
> 

I would rather keep them separate. It is a bit easier to pick out only
the header changes that way.

Wei

> Thanks,
> Stanislav
> 
> >  arch/x86/hyperv/hv_init.c      |   7 ++
> >  drivers/hv/hv_common.c         | 118 +++++++++++++++++++++++++++++++++
> >  include/asm-generic/mshyperv.h |   1 +
> >  include/hyperv/hvgdk_mini.h    |   4 +-
> >  include/hyperv/hvhdk_mini.h    |  33 +++++++++
> >  5 files changed, 162 insertions(+), 1 deletion(-)
> > 
> > -- 
> > 2.51.0
> > 

