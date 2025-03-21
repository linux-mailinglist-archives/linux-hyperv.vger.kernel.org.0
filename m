Return-Path: <linux-hyperv+bounces-4666-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 896ABA6C253
	for <lists+linux-hyperv@lfdr.de>; Fri, 21 Mar 2025 19:26:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4AD943BBA43
	for <lists+linux-hyperv@lfdr.de>; Fri, 21 Mar 2025 18:24:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A4F222FDE7;
	Fri, 21 Mar 2025 18:25:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tggeLW+o"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 480C022B8BD;
	Fri, 21 Mar 2025 18:24:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742581500; cv=none; b=QvYnvj8K8KvdwJcK+3dZXSKnPVDwXjDAkgP6l2UWQcUrerhPU9bJXGRVMelxsIq4ZwEzIBtWihpAjzZfQHOCD+ydF7TwPrt9ohKIbxutGHzLQHBsASJzwKTXThWLnMYupXvh5ulES2DOWQ7DqlpEOX5qbyBZvTT2dxjooABqw3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742581500; c=relaxed/simple;
	bh=tuPORlnJJGXXGYoBoU7VqjD4PIV9k+XGJ3BUeOaEKM0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bcCPw5U42UqYhc6x/VKTDvOglkj+gcG0Runz3qPOs1B6G2zl9i21pCSmRv0EqDQdscaj+QJV1p+7YSwBk2GUPu0xhNqNz7vCVslNklgdr8dSkmbsHGChKl8JUP/U0i6x+GOuxB1LhcA8vxQZP7Mb4uNDf6sHInX49swq8IGgjyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tggeLW+o; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 732D3C4CEE3;
	Fri, 21 Mar 2025 18:24:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742581499;
	bh=tuPORlnJJGXXGYoBoU7VqjD4PIV9k+XGJ3BUeOaEKM0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tggeLW+o91EZTace/qoK//L/NIrtdgTkAihRQ3IXmS2e0uw9GBPPkfLmWFYZGmWaQ
	 d1B0GPoJKftHzFMe8TAr4J/BA7qFKw8yZRNT72pLNlucCIDcMqCL37cJsaAoLBGvfr
	 ciw579TF+/zD+mXRcVhIMLqkjxVNX2wMNMNkN5eSECl2ttXcO8JMzTeZKWSxJ/9Toi
	 dROW4O3gPZMABAhWTctDH57jkobAdINnCCuWbRh1v5kalK3FjbzbxvSZeGEZwHBmN7
	 Ug5/Ir84f56zwvrXxcVdAVo/QviYeczxNWTZW2wxIW3VqrYwwB3DonO9oaQxEZD5cg
	 USI6swkDhuEyg==
Date: Fri, 21 Mar 2025 18:24:58 +0000
From: Wei Liu <wei.liu@kernel.org>
To: Nuno Das Neves <nunodasneves@linux.microsoft.com>
Cc: Dan Carpenter <dan.carpenter@linaro.org>,
	"wei.liu@kernel.org" <wei.liu@kernel.org>,
	"K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Dexuan Cui <decui@microsoft.com>,
	Anirudh Rayabharam <anrayabh@linux.microsoft.com>,
	Praveen K Paladugu <prapal@linux.microsoft.com>,
	Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>,
	linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Subject: Re: [PATCH next] Drivers: hv: mshv: Prevent potential NULL
 dereference
Message-ID: <Z92u-g59fWeMgwoJ@liuwe-devbox-ubuntu-v2.lamzopl0uupeniq2etz1fddiyg.xx.internal.cloudapp.net>
References: <9fee7658-1981-48b1-b909-fb2b78894077@stanley.mountain>
 <38525f8a-823c-4a79-ac55-68a2ef569a85@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <38525f8a-823c-4a79-ac55-68a2ef569a85@linux.microsoft.com>

On Fri, Mar 21, 2025 at 09:53:45AM -0700, Nuno Das Neves wrote:
> On 3/21/2025 7:35 AM, Dan Carpenter wrote:
> > Move the NULL check on "partition" before the dereference.
> > 
> > Fixes: f5288d14069b ("Drivers: hv: Introduce mshv_root module to expose /dev/mshv to VMMs")
> > Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
> > ---
> >  drivers/hv/mshv_synic.c | 3 +--
> >  1 file changed, 1 insertion(+), 2 deletions(-)
> > 
> > diff --git a/drivers/hv/mshv_synic.c b/drivers/hv/mshv_synic.c
> > index a3daedd680ff..88949beb5e37 100644
> > --- a/drivers/hv/mshv_synic.c
> > +++ b/drivers/hv/mshv_synic.c
> > @@ -151,13 +151,12 @@ static bool mshv_async_call_completion_isr(struct hv_message *msg)
> >  	rcu_read_lock();
> >  
> >  	partition = mshv_partition_find(partition_id);
> > -	partition->async_hypercall_status = async_msg->status;
> > -
> >  	if (unlikely(!partition)) {
> >  		pr_debug("failed to find partition %llu\n", partition_id);
> >  		goto unlock_out;
> >  	}
> >  
> > +	partition->async_hypercall_status = async_msg->status;
> >  	complete(&partition->async_hypercall);
> >  
> >  	handled = true;
> 
> Thanks for catching this one!
> Wei could you please apply or squash this into the driver patch?

Thank you Dan. I squashed this fix to the original patch.

