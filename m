Return-Path: <linux-hyperv+bounces-9821-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cKX4LYn2xmkGQwUAu9opvQ
	(envelope-from <linux-hyperv+bounces-9821-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Fri, 27 Mar 2026 22:28:41 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C9D534BB4E
	for <lists+linux-hyperv@lfdr.de>; Fri, 27 Mar 2026 22:28:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BA340304971A
	for <lists+linux-hyperv@lfdr.de>; Fri, 27 Mar 2026 21:27:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95A623947B3;
	Fri, 27 Mar 2026 21:27:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="Ms6teX8r"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E2DA392C5A;
	Fri, 27 Mar 2026 21:27:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774646846; cv=none; b=eK3EgWxbXQwHiWMyera1AjW139Sn6m3QNOs2szvG1la0eSqsWBOE2LWqua80dqvRFh9jKCAbVRe7Kg4iqzBqXujuXv+T+YYJC9xFgJGgr997Nt2mY6rsHNB7V2+rVvZ0B8TT2kZb6io7ctf+oMVyDTEuiD182m6altpSV+gVW0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774646846; c=relaxed/simple;
	bh=5KA0kZt4s0Pa0hT1hYmZ5xCmj7e+CT/d+UoZc79RQ2E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bRWhfg6KUU3zo5NoUg7B35bcJ9vyYy4ffNGkpKVxyEl8vp5kB78mSBImBXzyPmj2j4Fnm5H7oUKFi0Bb3L6JLmI1M3W9oKfE34XBkk1d2q+nJ1xA20Wc8OQrOhstUSPiYDD7eGGMoqYL3JDR7GjKI4KZpPGvSkUexrTMMzUfHy0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=Ms6teX8r; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [10.17.149.12] (unknown [131.107.8.12])
	by linux.microsoft.com (Postfix) with ESMTPSA id A8F6D20B6F01;
	Fri, 27 Mar 2026 14:27:24 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com A8F6D20B6F01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1774646844;
	bh=rOEiR+xqNwP7mi5DMkwFjv/YmDpf5sOAdwYcP1lPfCU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Ms6teX8rQ/QhSM0TRb/L+6L0QiQ1pSwDvM/YDAqecVmDuw3BOFfkuov2LsbZyBpRa
	 zdY4g72PXsKja/NAwe9pX3kENSZzlghkhg7pUync6wAEli9VU0uR1IdD0HVPCo8DXY
	 S5PSilxlirLRpo6x/eJ+IuZJpRbHUTOxtjtZjiKk=
Message-ID: <eb567b6f-2822-4802-97d2-d78fe63a7342@linux.microsoft.com>
Date: Fri, 27 Mar 2026 14:27:23 -0700
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net: mana: fix use-after-free in add_adev() error path
To: Guangshuo Li <lgs201920130244@gmail.com>,
 "K. Y. Srinivasan" <kys@microsoft.com>,
 Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>,
 Dexuan Cui <decui@microsoft.com>, Long Li <longli@microsoft.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Saurabh Sengar <ssengar@linux.microsoft.com>,
 Erni Sri Satya Vennela <ernis@linux.microsoft.com>,
 Shradha Gupta <shradhagupta@linux.microsoft.com>,
 Dipayaan Roy <dipayanroy@linux.microsoft.com>,
 Aditya Garg <gargaditya@linux.microsoft.com>,
 Shiraz Saleem <shirazsaleem@microsoft.com>, Leon Romanovsky
 <leon@kernel.org>, linux-hyperv@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
References: <20260318154041.638747-1-lgs201920130244@gmail.com>
Content-Language: en-US
From: Hardik Garg <hargar@linux.microsoft.com>
In-Reply-To: <20260318154041.638747-1-lgs201920130244@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.microsoft.com,none];
	R_DKIM_ALLOW(-0.20)[linux.microsoft.com:s=default];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9821-lists,linux-hyperv=lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com,microsoft.com,kernel.org,lunn.ch,davemloft.net,google.com,redhat.com,linux.microsoft.com,vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[22];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hargar@linux.microsoft.com,linux-hyperv@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.microsoft.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-hyperv,netdev];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linux.microsoft.com:dkim,linux.microsoft.com:mid]
X-Rspamd-Queue-Id: 1C9D534BB4E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



On 3/18/2026 8:40 AM, Guangshuo Li wrote:
> If auxiliary_device_add() fails, add_adev() calls
> auxiliary_device_uninit(adev), whose release callback adev_release()
> frees the containing struct mana_adev.
> 
> The current error path then falls through to init_fail and accesses
> adev->id. Since adev is embedded in struct mana_adev, this may lead
> to a use-after-free.
> 
> Fix it by storing the allocated auxiliary device id in a local
> variable and using that saved id in the cleanup path after
> auxiliary_device_uninit().
> 
> Fixes: a69839d4327d ("net: mana: Add support for auxiliary device")
> Cc: stable@vger.kernel.org
> Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
> ---
>  drivers/net/ethernet/microsoft/mana/mana_en.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/ethernet/microsoft/mana/mana_en.c b/drivers/net/ethernet/microsoft/mana/mana_en.c
> index 1ad154f9db1a..70d71594c599 100644
> --- a/drivers/net/ethernet/microsoft/mana/mana_en.c
> +++ b/drivers/net/ethernet/microsoft/mana/mana_en.c
> @@ -3362,6 +3362,7 @@ static int add_adev(struct gdma_dev *gd, const char *name)
>  {
>  	struct auxiliary_device *adev;
>  	struct mana_adev *madev;
> +	int id;
>  	int ret;
>  
>  	madev = kzalloc(sizeof(*madev), GFP_KERNEL);
> @@ -3372,7 +3373,8 @@ static int add_adev(struct gdma_dev *gd, const char *name)
>  	ret = mana_adev_idx_alloc();
>  	if (ret < 0)
>  		goto idx_fail;
> -	adev->id = ret;
> +	id = ret;
> +	adev->id = id;
>  
>  	adev->name = name;
>  	adev->dev.parent = gd->gdma_context->dev;
> @@ -3398,7 +3400,7 @@ static int add_adev(struct gdma_dev *gd, const char *name)
>  	auxiliary_device_uninit(adev);
>  
>  init_fail:
> -	mana_adev_idx_free(adev->id);
> +	mana_adev_idx_free(id);
>  
>  idx_fail:
>  	kfree(madev);

Reviewed-by: Hardik Garg <hargar@linux.microsoft.com>


Thanks,
Hardik

