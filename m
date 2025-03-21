Return-Path: <linux-hyperv+bounces-4663-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 12C63A6C087
	for <lists+linux-hyperv@lfdr.de>; Fri, 21 Mar 2025 17:50:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 35E447A46AD
	for <lists+linux-hyperv@lfdr.de>; Fri, 21 Mar 2025 16:49:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3060622D78D;
	Fri, 21 Mar 2025 16:50:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="MGYKSNg8"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D290022D786;
	Fri, 21 Mar 2025 16:49:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742575801; cv=none; b=R4kQxHNOnaERDVKLxcUF3uh6ZGCIx1NWxn6nC9DHFuFRl3yeVCIL9DFNuVAeThSAHbZulfLnJwmuRDOZzPBX1FEYMP3EZjolYDqO/q5ttLJemWTlmL44WocSx2kDbb4Xdbc0FCOnWS7NbmvoZPBgV3ovrdOQ7wss2esvtCNH9Hw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742575801; c=relaxed/simple;
	bh=7ZLBSwgjoEIfSznRwPheH9oHUGqDXbicJ1KRp4+oGXM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ES4dQXjSQLscG7JId+dPlIXd6BomDRnUKQoc1VwKEqOHD4I0S+KQPZKkD2kapFygzUV8ygxEfdu2DvY287St9QhmfEwzRfF3hyCqywqRTeAq918KG+QJRTOwe8AlVSvfa/lFsAX3ccwj+SOMWWQIH0Zhl/gqHqhwz3DYXnz5HE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=MGYKSNg8; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [10.0.0.114] (c-67-182-156-199.hsd1.wa.comcast.net [67.182.156.199])
	by linux.microsoft.com (Postfix) with ESMTPSA id 49AC1202538A;
	Fri, 21 Mar 2025 09:49:59 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 49AC1202538A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1742575799;
	bh=dfc7HGYSq09N0vV5A9Bi6bT9CfzsYt4jHAqPhyqP6+8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=MGYKSNg8NaasKcH0VjudKU/KMa00ld42lzKijtCy+EmKQTzsIkUQZGRVNiOYLbdEk
	 QAHLDRMUH8khBW0cuinVXxWlQjSGMzGUvZS98xRS1JhxrrNnhzstIoy9K0Vn0LrRvJ
	 E0Kp2ZBKb8ki/y4P1BEDkZrqsAiw11CcJYdNgtCA=
Message-ID: <b1fe0df0-efee-4940-9865-8bcabcd5809e@linux.microsoft.com>
Date: Fri, 21 Mar 2025 09:49:53 -0700
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH next] Drivers: hv: mshv: Fix uninitialize variable in
 mshv_ioctl_passthru_hvcall()
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: "K. Y. Srinivasan" <kys@microsoft.com>,
 Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>,
 Dexuan Cui <decui@microsoft.com>,
 Praveen K Paladugu <prapal@linux.microsoft.com>,
 Roman Kisel <romank@linux.microsoft.com>,
 Jinank Jain <jinankjain@microsoft.com>,
 Mukesh Rathor <mrathor@linux.microsoft.com>, linux-hyperv@vger.kernel.org,
 linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
References: <97036225-597d-4a2d-8f51-7310757b9929@stanley.mountain>
Content-Language: en-US
From: Nuno Das Neves <nunodasneves@linux.microsoft.com>
In-Reply-To: <97036225-597d-4a2d-8f51-7310757b9929@stanley.mountain>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/21/2025 7:35 AM, Dan Carpenter wrote:
> The "ret" variable could be uninitialized on the success path depending
> on if "is_async" is true of false.  Initialized it to zero.
> 
> Fixes: f5288d14069b ("Drivers: hv: Introduce mshv_root module to expose /dev/mshv to VMMs")
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
> ---
>  drivers/hv/mshv_root_main.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/hv/mshv_root_main.c b/drivers/hv/mshv_root_main.c
> index 29fa6d5a3994..b94d8fe0f691 100644
> --- a/drivers/hv/mshv_root_main.c
> +++ b/drivers/hv/mshv_root_main.c
> @@ -151,13 +151,14 @@ static int mshv_ioctl_passthru_hvcall(struct mshv_partition *partition,
>  				      void __user *user_args)
>  {
>  	u64 status;
> -	int ret, i;
>  	bool is_async;
>  	struct mshv_root_hvcall args;
>  	struct page *page;
>  	unsigned int pages_order;
>  	void *input_pg = NULL;
>  	void *output_pg = NULL;
> +	int ret = 0;
> +	int i;
>  
>  	if (copy_from_user(&args, user_args, sizeof(args)))
>  		return -EFAULT;

Thanks Dan, I already sent a fixup for this:
https://lore.kernel.org/linux-hyperv/1742492693-21960-1-git-send-email-nunodasneves@linux.microsoft.com/

