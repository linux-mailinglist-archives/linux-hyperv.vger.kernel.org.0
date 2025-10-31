Return-Path: <linux-hyperv+bounces-7392-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E456C2694B
	for <lists+linux-hyperv@lfdr.de>; Fri, 31 Oct 2025 19:33:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 110174F6C76
	for <lists+linux-hyperv@lfdr.de>; Fri, 31 Oct 2025 18:32:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 186EB1D7E31;
	Fri, 31 Oct 2025 18:32:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ujP33nn9"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4F46405F7;
	Fri, 31 Oct 2025 18:32:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761935526; cv=none; b=iycnpC06vO3tElLwI1eZJiDi5TxjnzMhbJ1XyaO0LF5SnYhd74cmTERiKBvYOLV7Irz/hZ7TSf1UMOCVav/kKQZIM+bz9oVPfSuL4qEH4Vc+kt2Z7FLPtqXK2HJPY67ciwJp4ItlLVkwlEZKKqK9PuC/2ZAr9gaZa3QTAfYj0bw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761935526; c=relaxed/simple;
	bh=iOhbO4RNyVZThupm0wb+eZKrenQeZqXijyy1/H+MvUU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=prLi7S2iI6Zr20S3/Q8VQq0nyEfKzWbc/cEsz782ATHFYFN1t8PJnElfwhjpFcJEliIoXtn84NU+bU9KcayiWtSntnmToIDurG20vOsPfbLiV2N630PY4GTHLKOo0pAmcLaBRJ/ED7ErtJNtji6FVECR1oOb0/DFZd06X+Ei/1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ujP33nn9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A619C4CEF1;
	Fri, 31 Oct 2025 18:32:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761935525;
	bh=iOhbO4RNyVZThupm0wb+eZKrenQeZqXijyy1/H+MvUU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ujP33nn9EgoAJ1KwZYdTn1mTg/dEeRIAz3gO4H1uwN7KMl6xWiQEu6wEjF4bE+NDy
	 3t5x0qmdjxIiGcuJnPgSX3kGPZ7f0Vz8vKpDth/h3xDkjze5xNvRp4BJpBwLdRKQM9
	 FlIogTv8Rk9Gv99KZIHtwxLUiEKa2Ch7VGYdLe1mvRaMvmGeZyPFL7tV4rq+RGRdZ8
	 XKONB79Xy2MnzOfQ1VeX2vzRKpgP+4Ch2HJlLogVvdd00dJcOV4efT3Y9GeSz+gypZ
	 8HeI5GOjb6yvxeVf1DcsH9fdR8n4JSnBulyQkMDkXJHAShp1VMvrmvwfgfoxJKHpLL
	 wNjggCjv1Y/IQ==
Date: Fri, 31 Oct 2025 18:32:03 +0000
From: Wei Liu <wei.liu@kernel.org>
To: Nuno Das Neves <nunodasneves@linux.microsoft.com>
Cc: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>,
	kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
	decui@microsoft.com, linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] Drivers: hv: Resolve ambiguity in hypervisor version
 log
Message-ID: <20251031183203.GD2612078@liuwe-devbox-debian-v2.local>
References: <175996340003.108050.17652201410306711595.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
 <fa14e8f8-fe92-4636-9565-a6174edcea71@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fa14e8f8-fe92-4636-9565-a6174edcea71@linux.microsoft.com>

On Fri, Oct 10, 2025 at 03:49:17PM -0700, Nuno Das Neves wrote:
> On 10/8/2025 3:43 PM, Stanislav Kinsburskii wrote:
> > Update the log message in hv_common_init to explicitly state that the
> > reported version is for the Microsoft Hypervisor, not the host OS.
> > 
> > Previously, this message was accurate for guests running on Windows
> > hosts, where the host and hypervisor versions matched. With support for
> > Linux hosts running the Hyper-V hypervisor, the host OS and hypervisor
> > versions may differ.
> > 
> > This change avoids confusion by making it clear that the version refers to
> > the Microsoft Hypervisor regardless of the host operating system.
> > 
> > Signed-off-by: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
> > ---
> >  drivers/hv/hv_common.c |    4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/hv/hv_common.c b/drivers/hv/hv_common.c
> > index e109a620c83fc..0289ee4ed5ebf 100644
> > --- a/drivers/hv/hv_common.c
> > +++ b/drivers/hv/hv_common.c
> > @@ -315,9 +315,9 @@ int __init hv_common_init(void)
> >  	int i;
> >  	union hv_hypervisor_version_info version;
> >  
> > -	/* Get information about the Hyper-V host version */
> > +	/* Get information about the Microsoft Hypervisor version */
> >  	if (!hv_get_hypervisor_version(&version))
> > -		pr_info("Hyper-V: Host Build %d.%d.%d.%d-%d-%d\n",
> > +		pr_info("Hyper-V: Hypervisor Build %d.%d.%d.%d-%d-%d\n",
> >  			version.major_version, version.minor_version,
> >  			version.build_number, version.service_number,
> >  			version.service_pack, version.service_branch);
> > 
> > 
> 
> Looks like a good idea.
> 
> Reviewed-by: Nuno Das Neves <nunodasneves@linux.microsoft.com>

Applied to hyperv-next.

