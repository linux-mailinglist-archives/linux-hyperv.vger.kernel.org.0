Return-Path: <linux-hyperv+bounces-7897-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 245CBC9102E
	for <lists+linux-hyperv@lfdr.de>; Fri, 28 Nov 2025 08:15:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id C6D2E34C015
	for <lists+linux-hyperv@lfdr.de>; Fri, 28 Nov 2025 07:15:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A353E26B2B0;
	Fri, 28 Nov 2025 07:15:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lWNk2Z+5"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A05622759C;
	Fri, 28 Nov 2025 07:15:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764314126; cv=none; b=uRdbFnuDwb/H5IoVLot5f9VvQvMjqRj33s+0vB1d7xOEj78jOhl8+OXVjbkUqfA9PERf8EMuYsq1uVgYxmPvKZWi179AzHAmw9gbLjthrnL3qWOolWKUDQuYOryh+DYxjmQnRtW0md8hVYYqlv+WNZlqXjSuxoAA1dphUziROSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764314126; c=relaxed/simple;
	bh=cGVtwKeQw/dP0JxRxt5FH8OM3MDSs/kL4Kxdbi2hANM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Xl4qSxWFVXdYIol+Buzl7E7hpg7UlE9ImzthFUiVM2ewkZUU5MiCIsucaDpR0dnCfbJ7eunzxiFlwaY/3ykNXGdd+AZFeL8YWXFFrHylhq6yqnm750Pzxfb6w4REIozM2MtlPG/I1WLUgQg+MeKVpZ05N1ezDJx6FSVaf9Z6PIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lWNk2Z+5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3CA2C4CEF1;
	Fri, 28 Nov 2025 07:15:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764314126;
	bh=cGVtwKeQw/dP0JxRxt5FH8OM3MDSs/kL4Kxdbi2hANM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lWNk2Z+55Qv1sw7wUtNyV4Av39W9Yv3w3XXtpRH2dij+W2rbzAjunBjHIUwUa3y8a
	 WOa3Lpfc4XRLigdJegNaZjGzmHXo6pOmUErbfNpo1vL1I5mjdm2yWH90sbnT8Dn8Wf
	 AryOeNTSBYbLdfZkk7phJhtIDKT76jdF6LGxJptXt4oqEXxyZFKXLdQsoocQCdehdh
	 bU66lgxDB9lhcJOKbd94qeUyc1Dpdr/VIbB0y947KwqMq2RWMzadCKIOph2QN33pqo
	 VYsp7oQ6j0eSfcVSFnBKzqcCXDu66XI5SedcAlTz+55drYQJSRbiweOrW9zOg7yJtu
	 a7Wn7alRoT61A==
Date: Fri, 28 Nov 2025 07:15:24 +0000
From: Wei Liu <wei.liu@kernel.org>
To: Gongwei Li <13875017792@163.com>
Cc: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
	decui@microsoft.com, linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org, Gongwei Li <ligongwei@kylinos.cn>
Subject: Re: [PATCH 1/1] Drivers: hv: use kmalloc_array() instead of kmalloc()
Message-ID: <20251128071524.GA69390@liuwe-devbox-debian-v2.local>
References: <20251121031041.56619-1-13875017792@163.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251121031041.56619-1-13875017792@163.com>

On Fri, Nov 21, 2025 at 11:10:41AM +0800, Gongwei Li wrote:
> From: Gongwei Li <ligongwei@kylinos.cn>
> 
> Replace kmalloc() with kmalloc_array() to prevent potential
> overflow, as recommended in Documentation/process/deprecated.rst.
> 
> Signed-off-by: Gongwei Li <ligongwei@kylinos.cn>

Applied to hyperv-next. Thanks.

> ---
>  drivers/hv/hv_util.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/hv/hv_util.c b/drivers/hv/hv_util.c
> index 36ee89c0358b..7e9c8e169c66 100644
> --- a/drivers/hv/hv_util.c
> +++ b/drivers/hv/hv_util.c
> @@ -586,7 +586,7 @@ static int util_probe(struct hv_device *dev,
>  		(struct hv_util_service *)dev_id->driver_data;
>  	int ret;
>  
> -	srv->recv_buffer = kmalloc(HV_HYP_PAGE_SIZE * 4, GFP_KERNEL);
> +	srv->recv_buffer = kmalloc_array(4, HV_HYP_PAGE_SIZE, GFP_KERNEL);
>  	if (!srv->recv_buffer)
>  		return -ENOMEM;
>  	srv->channel = dev->channel;
> -- 
> 2.25.1
> 

