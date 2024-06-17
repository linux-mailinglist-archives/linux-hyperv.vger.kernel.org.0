Return-Path: <linux-hyperv+bounces-2442-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id ADAC790B539
	for <lists+linux-hyperv@lfdr.de>; Mon, 17 Jun 2024 17:51:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 645241F23F18
	for <lists+linux-hyperv@lfdr.de>; Mon, 17 Jun 2024 15:51:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6749D14AAD;
	Mon, 17 Jun 2024 15:28:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="b6PfhvWe"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from out30-110.freemail.mail.aliyun.com (out30-110.freemail.mail.aliyun.com [115.124.30.110])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6D24134DE;
	Mon, 17 Jun 2024 15:28:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.110
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718638102; cv=none; b=WnPDjgpKAJRa9tZXAN7Jz+Jh0xB7979wMMjAnOugFjZbXO7EKE7G+YqugTRCgCs+0kw/Wzvwi904HjSzTR+33kpF2Hqmgnvy18Aa/FqGb3Jw0iwsrZEMie+GhBxWtDWpkVT488m23IkPPjjEQuZxC4QUjBTH29MXHpgmx2mD34w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718638102; c=relaxed/simple;
	bh=1dDye3xMz9kCshlVTroWnygLjhXc9vMSQN03NQdnELM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=URTc+fSo65ZjIWElw2kifNh6Db2eII44go/8rWVe3RQuQEar/jRilNCsHIV0n7Yy4aSl4LuprJ7YgOLXWLadnsJ1XoptQbIPG+dZ7Y3+3jQ+XccgpTpiPg2YzRTCF3EGckVL+IdaHtNXoTMtL3IpB51TKAWDTwB4wKK1hKB66jk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=b6PfhvWe; arc=none smtp.client-ip=115.124.30.110
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1718638096; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=l+12FevlX3fdnfHXW0LMF9KRFfVUfjKWXSd2yQeA1ZQ=;
	b=b6PfhvWejcbXIWb0eUa8M/7QGPtM8N+KrmHU5QCUWBZP7UzfV+3aagQ/4LygyR5pWIcB401HcNlDV+EYRgxr4TOWcDIdvjmmV5b0DoaDQi7qA02h2fRX4tAZRAyKrjiWjn6j2EM2GF75gtt+9Q45FVymrVdpHXzdD/2T0a6wmw4=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R201e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033045075189;MF=hengqi@linux.alibaba.com;NM=1;PH=DS;RN=17;SR=0;TI=SMTPD_---0W8gs1NW_1718638094;
Received: from 30.15.205.40(mailfrom:hengqi@linux.alibaba.com fp:SMTPD_---0W8gs1NW_1718638094)
          by smtp.aliyun-inc.com;
          Mon, 17 Jun 2024 23:28:15 +0800
Message-ID: <2f77825b-c6db-491a-867d-1d7d357ea2a3@linux.alibaba.com>
Date: Mon, 17 Jun 2024 23:28:14 +0800
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] net: mana: Use mana_cleanup_port_context() for
 rxq cleanup
To: Shradha Gupta <shradhagupta@linux.microsoft.com>
Cc: Souradeep Chakrabarti <schakrabarti@linux.microsoft.com>,
 Erick Archer <erick.archer@outlook.com>,
 Konstantin Taranov <kotaranov@microsoft.com>, Simon Horman
 <horms@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Jakub Kicinski <kuba@kernel.org>, Eric Dumazet <edumazet@google.com>,
 "David S. Miller" <davem@davemloft.net>, Dexuan Cui <decui@microsoft.com>,
 Wei Liu <wei.liu@kernel.org>, Haiyang Zhang <haiyangz@microsoft.com>,
 "K. Y. Srinivasan" <kys@microsoft.com>,
 Shradha Gupta <shradhagupta@microsoft.com>,
 open list <linux-kernel@vger.kernel.org>,
 "open list:NETWORKING DRIVERS" <netdev@vger.kernel.org>,
 linux-hyperv@vger.kernel.org
References: <1718349548-28697-1-git-send-email-shradhagupta@linux.microsoft.com>
From: Heng Qi <hengqi@linux.alibaba.com>
In-Reply-To: <1718349548-28697-1-git-send-email-shradhagupta@linux.microsoft.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


在 2024/6/14 下午3:19, Shradha Gupta 写道:
> To cleanup rxqs in port context structures, instead of duplicating the
> code, use existing function mana_cleanup_port_context() which does
> the exact cleanup that's needed.
>
> Signed-off-by: Shradha Gupta <shradhagupta@linux.microsoft.com>
> ---
>   drivers/net/ethernet/microsoft/mana/mana_en.c | 6 ++----
>   1 file changed, 2 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/net/ethernet/microsoft/mana/mana_en.c b/drivers/net/ethernet/microsoft/mana/mana_en.c
> index b89ad4afd66e..93e526e5dd16 100644
> --- a/drivers/net/ethernet/microsoft/mana/mana_en.c
> +++ b/drivers/net/ethernet/microsoft/mana/mana_en.c
> @@ -2529,8 +2529,7 @@ static int mana_init_port(struct net_device *ndev)
>   	return 0;
>   
>   reset_apc:
> -	kfree(apc->rxqs);
> -	apc->rxqs = NULL;
> +	mana_cleanup_port_context(apc);
>   	return err;
>   }
>   
> @@ -2787,8 +2786,7 @@ static int mana_probe_port(struct mana_context *ac, int port_idx,
>   free_indir:
>   	mana_cleanup_indir_table(apc);
>   reset_apc:
> -	kfree(apc->rxqs);
> -	apc->rxqs = NULL;
> +	mana_cleanup_port_context(apc);
>   free_net:
>   	*ndev_storage = NULL;
>   	netdev_err(ndev, "Failed to probe vPort %d: %d\n", port_idx, err);

Reviewed-by: Heng Qi <hengqi@linux.alibaba.com>

Thanks!

