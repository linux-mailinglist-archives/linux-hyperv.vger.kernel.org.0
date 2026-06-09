Return-Path: <linux-hyperv+bounces-11556-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id IUVuJVQbKGpE+AIAu9opvQ
	(envelope-from <linux-hyperv+bounces-11556-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Tue, 09 Jun 2026 15:55:32 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E82DA660C61
	for <lists+linux-hyperv@lfdr.de>; Tue, 09 Jun 2026 15:55:31 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=redhat.com header.s=mimecast20190719 header.b=GaePByQ2;
	dkim=pass header.d=redhat.com header.s=google header.b=jK9aVJGT;
	spf=pass (mail.lfdr.de: domain of "linux-hyperv+bounces-11556-lists+linux-hyperv=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-hyperv+bounces-11556-lists+linux-hyperv=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=redhat.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6A0DF3035B45
	for <lists+linux-hyperv@lfdr.de>; Tue,  9 Jun 2026 13:49:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A9CD426D19;
	Tue,  9 Jun 2026 13:49:35 +0000 (UTC)
X-Original-To: linux-hyperv@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78857423A68
	for <linux-hyperv@vger.kernel.org>; Tue,  9 Jun 2026 13:49:32 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781012975; cv=none; b=AsKfs64ol52ccpbH3ymQm+5XJOsRdMXz0qWZ3HtUf3pOYGKipfh2kDirr52wkGEaD5d9STV4RMBRUEtxhMGBzIZGicgzwnqsEsg+9qJeZtrzNNMZx/yx08QyWWB7TcH/vkFfd66Ypg9fEsXxHeaMkz3i4IJrd+wwQuevJl+ZFHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781012975; c=relaxed/simple;
	bh=52hnpEEgmB0qWOhFXmQimr5kmQmV0hK1rKA90td2mpE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ItLdzxkRhJf1md/SqH+dLrz7CRhXWHwC7aVdOC4DImejhaaDLYG8xcw6EXt4j0m6f6uZT2q4XwDodKHnqZ3olsMf0iO3oNurWK8DXgyR9208rA1hVp6eFmzzSEHd5Q2REg3G5PVUhn5fKWQaDBJ4dozhymMfzdoU1MR11Ep3bDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GaePByQ2; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=jK9aVJGT; arc=none smtp.client-ip=170.10.129.124
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1781012971;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=s6ZyLSFW2ZGo0KhUw8PJ3xCFPCwEjsrRdGcTeemtK0Q=;
	b=GaePByQ2vg2sG8WhPP2DNlvjf0+G0scmuaIf/0VGDxLxvfUXcMjthGV8aXN9fF08gTqDul
	UVAkGzSMo6X4apAM4A4lj7ZUYdvGXJKKpJppqRYgtS2UvMWr7QXyUDuNI5ruVSOuQYKzfu
	lqDVCksW0DYHnub9kKdDmPiXZciWEQA=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-351-O6-KV3uYP7mCPrWTUFWxUg-1; Tue, 09 Jun 2026 09:49:30 -0400
X-MC-Unique: O6-KV3uYP7mCPrWTUFWxUg-1
X-Mimecast-MFC-AGG-ID: O6-KV3uYP7mCPrWTUFWxUg_1781012969
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-490b37e1f47so49268045e9.0
        for <linux-hyperv@vger.kernel.org>; Tue, 09 Jun 2026 06:49:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1781012969; x=1781617769; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=s6ZyLSFW2ZGo0KhUw8PJ3xCFPCwEjsrRdGcTeemtK0Q=;
        b=jK9aVJGTxv8be1+tKzicU7/AOu5CStC3IF11kDiUoOs5TCuXNHt70oGKCJ/NXnuWnq
         Qrp0SI4A9Q1W/D0+Y/KagkERSITlruDORdL/XEBHrCeg9HyhO+QK2X3MLgPjbQj8neef
         m5520zjbb7S8hL7CgC3V8K8UgsZF57KOPiD6ysud22c2m7BgoR7nhPfTh4RV43a7DLfL
         o004DPFsvYEnrgUY6xylZUuulPdq8fffA9QEExifr/5GemmYWurs5vb3WXvtC21jdOJ7
         9wxDHoLMLYfNCuIqrXPLClxM3AeJHcZQ2NoUMp2I8YtnweyQtcdCdyciOa2/sJ/6R+NR
         X3uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781012969; x=1781617769;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=s6ZyLSFW2ZGo0KhUw8PJ3xCFPCwEjsrRdGcTeemtK0Q=;
        b=iTYw2ht4mqotn6rX5nMNJjW2kPOSsYlxfInimNb9uTklJZlsNhRrAHnDKWQCNhJEa3
         Pf6mW3dED4zSWuSwtOoS+a3QGbnqXh8tyeRg1ieHU+f0Q5jcnufeTKyYn5hMCtNTeMks
         fXUYNiFAMDVUG99cs2cApzqitcbvGo5dJkl+BmR7y2J+vH8fQ0Zr/v/mJhsx4UTDSKzY
         Q0Bsg3HXGoI5RL/s42iBhPplsGzupxTsrJmqH1OsZoN3AZguPKCUTeN/JT90JnNPxJr/
         pv2bAsLxIaT6XND5sxOu8Mp0PjGYkZoVugIm+uOvA0QrC99QveE7gDYIECKLlnUZ6yH/
         lbEg==
X-Forwarded-Encrypted: i=1; AFNElJ+FV1XTMJUBhUtUdpYmC5NH77GFXMBGZwej9rtxpu7feIKBOIVXN45VYwLRKAm9CNgRrkcbx0lN5sd0C9E=@vger.kernel.org
X-Gm-Message-State: AOJu0YwtVdYKIvKxLaC9iTDSekSxwEHk/ugz1VM/LYJaYVvlwuTga9MF
	j9lzUnl7Vik6KnrU6al/Qiy53TQeUNFNvCyv1FG/OfcHxPuKswvujf4QjiyjPTayUZ+8I5Is/o6
	Tc7H68EGja5OpaUa6JQUO9+WRYu5o322gBI0jC4iQ+i4h1se7dWD32+WWzu3+JR/pww==
X-Gm-Gg: Acq92OE0GvW60+XQpwCHNto8yiXz59CsRrS43RKOHcQXh9jVVoKVH6y1Fst1LBI2eZR
	Pu2j0SwEXi3OD8JhO+gVpB/6J/kNc+A9BIHI1CHydBRJJkjJ6VrYn4Ld08HNPgdzi8/m6dNHPcg
	ZmnhQkNdYy9BaPlxE0lyl7/rTjcnfQHyi/jNyKlA+nOqW+7UcXzDTyDB0uJX3mSFLOQQKKORf81
	VDun/AWzKezubjQZfKav57hTqZa0g/8RsMSa8VqkUiDzjlnnnAC5aWbrHUB/7iM2XP6Mh6+Jc+0
	MmIU2ukl3eB7GFk1BL5FeTuRpqsVbLEa6SUf0soXFadGPJNaLW4KAx4G2lyi2aIT5TaU5r/zqwt
	je6Ok30O46wihaSik3xrk9DJZrJtbp44F7mYQXB7hj13x34sA4dTIuoHXOJ1pJM2bew==
X-Received: by 2002:a05:600c:198d:b0:490:9d1b:f086 with SMTP id 5b1f17b1804b1-490c25baa0bmr347625705e9.14.1781012969037;
        Tue, 09 Jun 2026 06:49:29 -0700 (PDT)
X-Received: by 2002:a05:600c:198d:b0:490:9d1b:f086 with SMTP id 5b1f17b1804b1-490c25baa0bmr347625035e9.14.1781012968602;
        Tue, 09 Jun 2026 06:49:28 -0700 (PDT)
Received: from [192.168.88.32] ([150.228.93.44])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490bc23394asm480555685e9.0.2026.06.09.06.49.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Jun 2026 06:49:28 -0700 (PDT)
Message-ID: <dcd35c42-3aae-4ba2-bd84-4af08467b2fc@redhat.com>
Date: Tue, 9 Jun 2026 15:49:25 +0200
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2] net: mana: Add Interrupt Moderation support
To: Haiyang Zhang <haiyangz@linux.microsoft.com>,
 linux-hyperv@vger.kernel.org, netdev@vger.kernel.org,
 "K. Y. Srinivasan" <kys@microsoft.com>,
 Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>,
 Dexuan Cui <decui@microsoft.com>, Long Li <longli@microsoft.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>,
 Konstantin Taranov <kotaranov@microsoft.com>, Simon Horman
 <horms@kernel.org>, Shradha Gupta <shradhagupta@linux.microsoft.com>,
 Erni Sri Satya Vennela <ernis@linux.microsoft.com>,
 Dipayaan Roy <dipayanroy@linux.microsoft.com>,
 Aditya Garg <gargaditya@linux.microsoft.com>, Kees Cook <kees@kernel.org>,
 Breno Leitao <leitao@debian.org>, linux-kernel@vger.kernel.org,
 linux-rdma@vger.kernel.org
Cc: paulros@microsoft.com
References: <20260604234211.2056341-1-haiyangz@linux.microsoft.com>
From: Paolo Abeni <pabeni@redhat.com>
Content-Language: en-US
In-Reply-To: <20260604234211.2056341-1-haiyangz@linux.microsoft.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-11556-lists,linux-hyperv=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[pabeni@redhat.com,linux-hyperv@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[23];
	FORGED_RECIPIENTS(0.00)[m:haiyangz@linux.microsoft.com,m:linux-hyperv@vger.kernel.org,m:netdev@vger.kernel.org,m:kys@microsoft.com,m:haiyangz@microsoft.com,m:wei.liu@kernel.org,m:decui@microsoft.com,m:longli@microsoft.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:kotaranov@microsoft.com,m:horms@kernel.org,m:shradhagupta@linux.microsoft.com,m:ernis@linux.microsoft.com,m:dipayanroy@linux.microsoft.com,m:gargaditya@linux.microsoft.com,m:kees@kernel.org,m:leitao@debian.org,m:linux-kernel@vger.kernel.org,m:linux-rdma@vger.kernel.org,m:paulros@microsoft.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[redhat.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pabeni@redhat.com,linux-hyperv@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-hyperv,netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sashiko.dev:url,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: E82DA660C61

On 6/5/26 1:41 AM, Haiyang Zhang wrote:
> diff --git a/drivers/net/ethernet/microsoft/mana/mana_en.c b/drivers/net/ethernet/microsoft/mana/mana_en.c
> index db14357d3732..b1e0c444f414 100644
> --- a/drivers/net/ethernet/microsoft/mana/mana_en.c
> +++ b/drivers/net/ethernet/microsoft/mana/mana_en.c
> @@ -1551,6 +1551,9 @@ int mana_create_wq_obj(struct mana_port_context *apc,
>  
>  	mana_gd_init_req_hdr(&req.hdr, MANA_CREATE_WQ_OBJ,
>  			     sizeof(req), sizeof(resp));
> +
> +	req.hdr.req.msg_version = GDMA_MESSAGE_V3;
> +	req.hdr.resp.msg_version = GDMA_MESSAGE_V2;

Sashiko noted the above cold break initialization on older firmware:

https://sashiko.dev/#/patchset/20260604234211.2056341-1-haiyangz%40linux.microsoft.com

[...]
> +static void mana_update_rx_dim(struct mana_cq *cq)
> +{
> +	struct mana_port_context *apc = netdev_priv(cq->rxq->ndev);
> +	struct mana_rxq *rxq = cq->rxq;
> +	struct dim_sample dim_sample = {};

Minor nit: please fix the variable declaration order above. Other
occurrences below.

[...]
> @@ -440,17 +474,94 @@ static int mana_set_coalesce(struct net_device *ndev,
>  		return -EINVAL;
>  	}
>  
> -	saved_cqe_coalescing_enable = apc->cqe_coalescing_enable;
> +	if (ec->rx_coalesce_usecs > MANA_INTR_MODR_USEC_MAX ||
> +	    ec->tx_coalesce_usecs > MANA_INTR_MODR_USEC_MAX) {
> +		NL_SET_ERR_MSG_FMT(extack,
> +				   "coalesce usecs must be <= %lu",
> +				   MANA_INTR_MODR_USEC_MAX);
> +		return -EINVAL;
> +	}
> +
> +	if (ec->rx_max_coalesced_frames > MANA_INTR_MODR_COMP_MAX ||
> +	    ec->tx_max_coalesced_frames > MANA_INTR_MODR_COMP_MAX) {
> +		NL_SET_ERR_MSG_FMT(extack,
> +				   "coalesce frames must be <= %lu",
> +				   MANA_INTR_MODR_COMP_MAX);
> +		return -EINVAL;
> +	}
> +
> +	if (ec->rx_coalesce_usecs != apc->intr_modr_rx_usec ||
> +	    ec->rx_max_coalesced_frames != apc->intr_modr_rx_comp ||
> +	    ec->tx_coalesce_usecs != apc->intr_modr_tx_usec ||
> +	    ec->tx_max_coalesced_frames != apc->intr_modr_tx_comp)
> +		modr_changed = true;
> +
> +	saved.intr_modr_rx_usec = apc->intr_modr_rx_usec;
> +	saved.intr_modr_rx_comp = apc->intr_modr_rx_comp;
> +	saved.intr_modr_tx_usec = apc->intr_modr_tx_usec;
> +	saved.intr_modr_tx_comp = apc->intr_modr_tx_comp;
> +
> +	apc->intr_modr_rx_usec = ec->rx_coalesce_usecs;
> +	apc->intr_modr_rx_comp = ec->rx_max_coalesced_frames;
> +	apc->intr_modr_tx_usec = ec->tx_coalesce_usecs;
> +	apc->intr_modr_tx_comp = ec->tx_max_coalesced_frames;
> +
> +	if (!!ec->use_adaptive_rx_coalesce != apc->rx_dim_enabled ||
> +	    !!ec->use_adaptive_tx_coalesce != apc->tx_dim_enabled)
> +		dim_changed = true;
> +
> +	saved.rx_dim_enabled = apc->rx_dim_enabled;
> +	saved.tx_dim_enabled = apc->tx_dim_enabled;
> +	apc->rx_dim_enabled = !!ec->use_adaptive_rx_coalesce;
> +	apc->tx_dim_enabled = !!ec->use_adaptive_tx_coalesce;
> +
> +	saved.cqe_coalescing_enable = apc->cqe_coalescing_enable;
>  	apc->cqe_coalescing_enable =
>  		kernel_coal->rx_cqe_frames == MANA_RXCOMP_OOB_NUM_PPI;
>  
>  	if (!apc->port_is_up)
>  		return 0;
>  
> -	err = mana_config_rss(apc, TRI_STATE_TRUE, false, false);
> -	if (err)
> -		apc->cqe_coalescing_enable = saved_cqe_coalescing_enable;
> +	if (apc->cqe_coalescing_enable != saved.cqe_coalescing_enable &&
> +	    !modr_changed && !dim_changed) {
> +		/* If only CQE coalescing setting is changed, we can just update
> +		 * RSS configuration.
> +		 */
> +		err = mana_config_rss(apc, TRI_STATE_TRUE, false, false);
> +		if (err) {
> +			netdev_err(ndev, "Change CQE coalescing failed: %d\n",
> +				   err);
> +			apc->cqe_coalescing_enable =
> +				saved.cqe_coalescing_enable;
> +			return err;
> +		}
> +		return 0;
> +	}
> +
> +	if (modr_changed || dim_changed) {
> +		err = mana_detach(ndev, false);
> +		if (err) {
> +			netdev_err(ndev, "mana_detach failed: %d\n", err);
> +			goto restore_modr;
> +		}
> +
> +		err = mana_attach(ndev);
> +		if (err) {
> +			netdev_err(ndev, "mana_attach failed: %d\n", err);
> +			goto restore_modr;
> +		}

You should try hard to avoid this sequence: if mana_attach fails,
mana_set_coalesce() will leave the NIC unexpectedly down.

/P


