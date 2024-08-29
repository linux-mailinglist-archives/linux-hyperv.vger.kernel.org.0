Return-Path: <linux-hyperv+bounces-2918-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 36A3196515B
	for <lists+linux-hyperv@lfdr.de>; Thu, 29 Aug 2024 23:05:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E3B09283860
	for <lists+linux-hyperv@lfdr.de>; Thu, 29 Aug 2024 21:05:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13A5218A933;
	Thu, 29 Aug 2024 21:05:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=engleder-embedded.com header.i=@engleder-embedded.com header.b="nET9SDcH"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mx08lb.world4you.com (mx08lb.world4you.com [81.19.149.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 350521662F1;
	Thu, 29 Aug 2024 21:05:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=81.19.149.118
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724965552; cv=none; b=T5ysPaLL6qjcg+Y9U/RfVUKedcOHl+vhVvfNmXK9Tfalg4ylBwlQ/7HiV+IDe0nb4ky7jRfvkhjGs5LR5sN/9h1ZP1ErP+5ZkZMBMHTXqhd0p97i5aO0+jDxgUeBVjVARYskoC3a+nvgw+4adkYc5g8kDF1N8MYebb/5feEu/8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724965552; c=relaxed/simple;
	bh=696BIpkw6qSh37ys61ph+L8lAJ+SLZxIyuKa5FXpAKY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lr/59mjO5+A9ZPgXQvGbntKhtrEsqi8ZRSBvA9mgmeW/n1nrVTo0tJe6pYXQ9firyouh7mtGVWyaTLfCWQu9YdqOgjscU2jzSzBvyzBAy5LqnB2mCjeN8aKt7zfwa2VImk0VHOEq3vyW6mDpJKUYHG8VQrHAwwTmmf35ZeyV7Dw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=engleder-embedded.com; spf=pass smtp.mailfrom=engleder-embedded.com; dkim=pass (1024-bit key) header.d=engleder-embedded.com header.i=@engleder-embedded.com header.b=nET9SDcH; arc=none smtp.client-ip=81.19.149.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=engleder-embedded.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=engleder-embedded.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=engleder-embedded.com; s=dkim11; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=lyDPgUZOhSh56bBL5knVf1Gg5mPzltrEGUQa4C517M4=; b=nET9SDcHx8bVspaLr9Dm7IuY4I
	erPimdqwAz47xqqD8ZJj7A/D7Qeb9dTvvdhuDbVE0cKmf85TEdgFf2JmMG7o5mzkIANzM8dtbiZHN
	tZIf1N+r9PXMmB62XyU38Yq0j1N5tiOKTEiT0mJ4Mh/3eSMvhwyZoq8SL89DBN1PhKFE=;
Received: from [88.117.52.244] (helo=[10.0.0.160])
	by mx08lb.world4you.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <gerhard@engleder-embedded.com>)
	id 1sjlDu-0008SF-0A;
	Thu, 29 Aug 2024 21:54:26 +0200
Message-ID: <d73d45af-e76e-4e87-8df1-0ed71e823abc@engleder-embedded.com>
Date: Thu, 29 Aug 2024 21:54:18 +0200
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] net: mana: Improve mana_set_channels() for low
 mem conditions
Content-Language: en-US
To: Shradha Gupta <shradhagupta@linux.microsoft.com>,
 linux-hyperv@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org
Cc: "K. Y. Srinivasan" <kys@microsoft.com>,
 Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>,
 Dexuan Cui <decui@microsoft.com>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Long Li <longli@microsoft.com>,
 Simon Horman <horms@kernel.org>, Konstantin Taranov
 <kotaranov@microsoft.com>,
 Souradeep Chakrabarti <schakrabarti@linux.microsoft.com>,
 Erick Archer <erick.archer@outlook.com>,
 Pavan Chebbi <pavan.chebbi@broadcom.com>, Ahmed Zaki <ahmed.zaki@intel.com>,
 Colin Ian King <colin.i.king@gmail.com>,
 Shradha Gupta <shradhagupta@microsoft.com>
References: <1724941006-2500-1-git-send-email-shradhagupta@linux.microsoft.com>
From: Gerhard Engleder <gerhard@engleder-embedded.com>
In-Reply-To: <1724941006-2500-1-git-send-email-shradhagupta@linux.microsoft.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-AV-Do-Run: Yes

On 29.08.24 16:16, Shradha Gupta wrote:
> The mana_set_channels() function requires detaching the mana
> driver and reattaching it with changed channel values.
> During this operation if the system is low on memory, the reattach
> might fail, causing the network device being down.
> To avoid this we pre-allocate buffers at the beginning of set operation,
> to prevent complete network loss
> 
> Signed-off-by: Shradha Gupta <shradhagupta@linux.microsoft.com>
> ---
>   .../ethernet/microsoft/mana/mana_ethtool.c    | 28 +++++++++++--------
>   1 file changed, 16 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/net/ethernet/microsoft/mana/mana_ethtool.c b/drivers/net/ethernet/microsoft/mana/mana_ethtool.c
> index d6a35fbda447..5077493fdfde 100644
> --- a/drivers/net/ethernet/microsoft/mana/mana_ethtool.c
> +++ b/drivers/net/ethernet/microsoft/mana/mana_ethtool.c
> @@ -345,27 +345,31 @@ static int mana_set_channels(struct net_device *ndev,
>   	struct mana_port_context *apc = netdev_priv(ndev);
>   	unsigned int new_count = channels->combined_count;
>   	unsigned int old_count = apc->num_queues;
> -	int err, err2;
> +	int err;
> +
> +	apc->num_queues = new_count;
> +	err = mana_pre_alloc_rxbufs(apc, ndev->mtu);
> +	apc->num_queues = old_count;

Are you sure that temporary changing num_queues has no side effects on
other num_queues users like mana_chn_setxdp()?

Gerhard

