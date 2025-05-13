Return-Path: <linux-hyperv+bounces-5485-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 245A1AB4AA6
	for <lists+linux-hyperv@lfdr.de>; Tue, 13 May 2025 06:49:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AEBD346142E
	for <lists+linux-hyperv@lfdr.de>; Tue, 13 May 2025 04:49:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F8B11B4145;
	Tue, 13 May 2025 04:49:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SY6Ew3Fj"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45EF52AD0B;
	Tue, 13 May 2025 04:49:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747111792; cv=none; b=W4aRpshTozHNGcA7c1lR5YuvXO/hSfmiNUNkVMHwiuVoP36AdPxGw9I6yaJk+/7eohgmzki9SPsIAwwuLka/DTPjePVI/SoVuFeZBDABUvs+YXVYGNe/RDipNpkoRgt9MTX1Qo/zxfNNsFyW3n3r/WMFc5AtfUnbeS+K1csVqbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747111792; c=relaxed/simple;
	bh=sD2VHXBjtRZcO79CM7jeujQ+aK1oW43+d3Axb1NVKAY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q0U2yc+6xpGRWu7s1hnWIZVtvoPf+TwKw6gjFR8g5Qi/cOA6ijyhmtnI+G+OtuvRwlCCrztaHXhHma2ensGWJkCudFCIO9GKTWCtfV7p2ApB+7Uvyjug5gDcy8eLfq1/LsEBImTflnax9PGDLdUDLusPZXEglaePahMrs4+lrmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SY6Ew3Fj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C6C9C4CEE4;
	Tue, 13 May 2025 04:49:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747111791;
	bh=sD2VHXBjtRZcO79CM7jeujQ+aK1oW43+d3Axb1NVKAY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SY6Ew3FjjtfHR+AdOcprddixxpTYsY5OIh4OA7mzbY2zA6dFx8XVcKOJ3y+zGKr8L
	 y+uxBlvUrdOjIKsX4igqXgTu8HKbTvV3vrHomTziZgIgMhZ++wS8EZ0lIoIg3L86hJ
	 +IDr1DVOWcllpWJBtuMwJrlKv3LJYnuhQ8f4r9eO7O9KgOlcwyLIubwRKV8hgr5FQu
	 hZP143LA3zDlIIOJY2G8AZzkfMIKTCJrkyjX8yLpq97vfpGVdcI3T4giANEeyUBKDa
	 KfwBg3WYLbH1kk8h5XivuQp+oDpvMfavjMPsYT9nzM2TkabTl9LBxu3+CXirP6u0jI
	 EBYkn5FMKlhtA==
Date: Tue, 13 May 2025 04:49:50 +0000
From: Wei Liu <wei.liu@kernel.org>
To: longli@linuxonhyperv.com
Cc: "K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
	Long Li <longli@microsoft.com>
Subject: Re: [Patch v3 0/5] Fix uio_hv_generic on systems with >4k page sizes
Message-ID: <aCLPbob_vVopoMt9@liuwe-devbox-ubuntu-v2.tail21d00.ts.net>
References: <1746492997-4599-1-git-send-email-longli@linuxonhyperv.com>
 <aBz8fBWQKfH04g2u@liuwe-devbox-ubuntu-v2.tail21d00.ts.net>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aBz8fBWQKfH04g2u@liuwe-devbox-ubuntu-v2.tail21d00.ts.net>

On Thu, May 08, 2025 at 06:48:28PM +0000, Wei Liu wrote:
> On Mon, May 05, 2025 at 05:56:32PM -0700, longli@linuxonhyperv.com wrote:
> > From: Long Li <longli@microsoft.com>
> > 
> > UIO framework requires the device memory aligned to page boundary.
> > Hyper-V may allocate some memory that is Hyper-V page aligned (4k)
> > but not system page aligned.
> > 
> > Fix this by having Hyper-V always allocate those pages on system page
> > boundary and expose them to user-mode.
> > 
> > Change in v2:
> > Added two more patches to the series:
> > "uio_hv_generic: Adjust ring size according to system page alignment"
> > "Drivers: hv: Remove hv_free/alloc_* helpers"
> > 
> > Added more details in the commit message of
> > "uio_hv_generic: Use correct size for interrupt and monitor pages"
> > 
> > Change in v3:
> > Rearranged the patch on removing hv_alloc/free* helpers
> > Added "Drivers: hv: Use kzalloc for panic page allocation"
> > Fixed typos.
> > 
> > Long Li (5):
> >   Drivers: hv: Allocate interrupt and monitor pages aligned to system
> >     page boundary
> >   uio_hv_generic: Use correct size for interrupt and monitor pages
> >   uio_hv_generic: Align ring size to system page
> 
> These patches to UIO look like small bug fixes to me.
> 
> Greg, let me know if you care enough to review them.
> 
> Given the patches surround these bug fixes, I propose to let me take
> them via the Hyper-V tree.

Series applied to hyperv-next-staging. Thanks.

