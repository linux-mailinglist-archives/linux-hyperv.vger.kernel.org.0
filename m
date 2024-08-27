Return-Path: <linux-hyperv+bounces-2885-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8244D96187B
	for <lists+linux-hyperv@lfdr.de>; Tue, 27 Aug 2024 22:26:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3EE5F284BD4
	for <lists+linux-hyperv@lfdr.de>; Tue, 27 Aug 2024 20:26:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38F901D2F61;
	Tue, 27 Aug 2024 20:26:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HZhAde7O"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08E1C186A;
	Tue, 27 Aug 2024 20:26:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724790400; cv=none; b=Z97fAyoyHZs2rHEbh5N59HklHa3G/5N/ccMzIrlmPvoH+CkzQe8fymGgxKhSaRsGME/oINrO9NvgEOQjYC/xroLNgiRUPYuWS2XZVp8wGI/GA4PB0rZ1AeDNYwgLDeCs5GrovZdqHC9553SfW47Z1jHmRmuVU5/tleOYipC8blg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724790400; c=relaxed/simple;
	bh=F3ADu+qXXA3CnXy8TRWnBbqi7MbomgkybY5qFvZN868=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pVU5alHhd93CNWZitPG8c6UKwV5iEXpaLiEWSXkTk0yzJiuNOlIveaON8PebPEUd2ntVPsBCDCnHo4dgTkW7A2RTVf7CFKLMO6F86j3x6GGM68LeleADtmvc5oIwO7Jb8+8NAzK9udHxp3bMQPC6yYmhTafitz0OcfO/Gsw/8Bg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HZhAde7O; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CEB8EC32786;
	Tue, 27 Aug 2024 20:26:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724790399;
	bh=F3ADu+qXXA3CnXy8TRWnBbqi7MbomgkybY5qFvZN868=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=HZhAde7O/ad8dQKhylWpwl3qnkIS9bFPGI3jQl0APyMkJUKu2H2tmLwVuYuFN/oVv
	 oM40BFlMtm6KkTmBZE2qGhkdDMCsdWmP3hYyw6Bva+hvWiX2+VI9TukWxDkylE7sL+
	 MIQ3ayU44ffY00ylRp84oRoCnqAc55/SZiYo6K7Zch8QOKXf4yYiRuoNkiVQrK+/h9
	 kfmseX7iDZOoQfwRc+wWVKqNcThOfVT8Spn+fsSdaFia+K9HnmnEsAaNxQcq44KyyD
	 GamDGFWhKaJdUzcj1APXzPW4fps3COFuXeWkLDZZ95oFEY2mOkkqZ3Ck+7VouIhpbr
	 gf64kSPx+aXXQ==
Date: Tue, 27 Aug 2024 13:26:37 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Souradeep Chakrabarti <schakrabarti@linux.microsoft.com>
Cc: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
 decui@microsoft.com, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, longli@microsoft.com, yury.norov@gmail.com,
 leon@kernel.org, cai.huoqing@linux.dev, ssengar@linux.microsoft.com,
 vkuznets@redhat.com, tglx@linutronix.de, linux-hyperv@vger.kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-rdma@vger.kernel.org, schakrabarti@microsoft.com
Subject: Re: [PATCH V2 net] net: mana: Fix error handling in
 mana_create_txq/rxq's NAPI cleanup
Message-ID: <20240827132637.31b7eb36@kernel.org>
In-Reply-To: <1724406269-10868-1-git-send-email-schakrabarti@linux.microsoft.com>
References: <1724406269-10868-1-git-send-email-schakrabarti@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 23 Aug 2024 02:44:29 -0700 Souradeep Chakrabarti wrote:
> @@ -2023,14 +2024,17 @@ static void mana_destroy_rxq(struct mana_port_context *apc,
>  
>  	napi = &rxq->rx_cq.napi;
>  
> -	if (validate_state)
> -		napi_synchronize(napi);
> +	if (napi->dev == apc->ndev) {
>  
> -	napi_disable(napi);
> +		if (validate_state)
> +			napi_synchronize(napi);
>  
> -	xdp_rxq_info_unreg(&rxq->xdp_rxq);
> +		napi_disable(napi);
>  
> -	netif_napi_del(napi);
> +		netif_napi_del(napi);
> +	}
> +
> +	xdp_rxq_info_unreg(&rxq->xdp_rxq);

Please don't use internal core state as a crutch for your cleanup.

IDK what "validate_state" stands for, but it gives you all the info you
need on Rx. On Rx NAPI registration happens as the last stage of rxq
activation, once nothing can fail. And the "cleanup" path calls destroy
with validate_state=false. The only other caller passes true.

So you can rewrite this as:

	if (validate_state) { /* rename it maybe? */
		napi_disable(napi);
		...
	}
	xdp_rxq_info_unreg(&rxq->xdp_rxq);

You can take similar approach with Tx. Pass a bool which tells the
destroy function whether NAPI has been registered.
-- 
pw-bot: cr

