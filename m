Return-Path: <linux-hyperv+bounces-2943-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 58C4096C70A
	for <lists+linux-hyperv@lfdr.de>; Wed,  4 Sep 2024 21:05:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 89C031C249F3
	for <lists+linux-hyperv@lfdr.de>; Wed,  4 Sep 2024 19:05:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D887B140378;
	Wed,  4 Sep 2024 19:05:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=engleder-embedded.com header.i=@engleder-embedded.com header.b="G7TwooNM"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mx08lb.world4you.com (mx08lb.world4you.com [81.19.149.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C97D313E409;
	Wed,  4 Sep 2024 19:05:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=81.19.149.118
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725476735; cv=none; b=QP3NJSFX6kixpIrBvdQEuwIaiGe0tpWhL+rY6nQMpjbFCAbDmdeZCo2Y67KlRZA6kEASy9QikZFyGDCwAtgOdDrBon2roOCf12swPx2499zlISzpT7bDfyUUwqGk363Ew+XyEOD0D+Y4ufg+whApQ364Wi0LoN04RoYE+IuFvDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725476735; c=relaxed/simple;
	bh=udAqtoaRC/SZRiVlHYjDz69dZCVfDadiSZvuLLCKLt4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tSk957pFCiswFXn5+XOjnMal0KZpn57o3xDLWH608vqPgFupjSJLfWjtLM9BO6i/Pbzd6E2odOInSXjX/ALYZWOzKC3H9TgBEL2l96FSEjJOghWvB3xJatPPxqBiX3RczbGDo4qnQRkxoXTp4UZBBefTO+s5dhSGy6ZUSML+mFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=engleder-embedded.com; spf=pass smtp.mailfrom=engleder-embedded.com; dkim=pass (1024-bit key) header.d=engleder-embedded.com header.i=@engleder-embedded.com header.b=G7TwooNM; arc=none smtp.client-ip=81.19.149.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=engleder-embedded.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=engleder-embedded.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=engleder-embedded.com; s=dkim11; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=AxYohhgnAu4PLvnfed/ve57jItrbBbytOljsqVlPTm4=; b=G7TwooNMRe5YbP3u+Am0TZsMz+
	ZCiWlKD+st6VQa/hKSSohSjtzDf5VOdm3xmwm0OF0yvtyXWuvt//VmDpdeT86X0s3xPuco/VTXMVz
	9OboDqQG3a+spkUUlKrZmrLTrb4u+BnlD+y+zR6b5zy9lylBImVmY5zkRsVer7llw5sQ=;
Received: from [88.117.52.244] (helo=[10.0.0.160])
	by mx08lb.world4you.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <gerhard@engleder-embedded.com>)
	id 1slvJj-0003Rb-1n;
	Wed, 04 Sep 2024 21:05:23 +0200
Message-ID: <beffd557-7e58-4841-a930-03c271d243a2@engleder-embedded.com>
Date: Wed, 4 Sep 2024 21:05:21 +0200
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2] net: mana: Improve mana_set_channels() in low
 mem conditions
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
References: <1725248734-21760-1-git-send-email-shradhagupta@linux.microsoft.com>
Content-Language: en-US
From: Gerhard Engleder <gerhard@engleder-embedded.com>
In-Reply-To: <1725248734-21760-1-git-send-email-shradhagupta@linux.microsoft.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-AV-Do-Run: Yes

On 02.09.24 05:45, Shradha Gupta wrote:
> The mana_set_channels() function requires detaching the mana
> driver and reattaching it with changed channel values.
> During this operation if the system is low on memory, the reattach
> might fail, causing the network device being down.
> To avoid this we pre-allocate buffers at the beginning of set operation,
> to prevent complete network loss
> 
> Signed-off-by: Shradha Gupta <shradhagupta@linux.microsoft.com>
> ---
>   Changes in v2
>   * Pass num_queues as argument in mana_pre_alloc_rxbufs()
> ---
>   drivers/net/ethernet/microsoft/mana/mana_en.c |  6 ++--
>   .../ethernet/microsoft/mana/mana_ethtool.c    | 28 ++++++++++---------
>   include/net/mana/mana.h                       |  2 +-
>   3 files changed, 19 insertions(+), 17 deletions(-)

Looks better now with the argument for the queue number.

Reviewed-by: Gerhard Engleder <gerhard@engleder-embedded.com>

