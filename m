Return-Path: <linux-hyperv+bounces-11804-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id ULJsMNgpRmqIKwsAu9opvQ
	(envelope-from <linux-hyperv+bounces-11804-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Thu, 02 Jul 2026 11:05:28 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 38CF26F50DF
	for <lists+linux-hyperv@lfdr.de>; Thu, 02 Jul 2026 11:05:28 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=redhat.com header.s=mimecast20190719 header.b=D4hqxleJ;
	dkim=pass header.d=redhat.com header.s=google header.b=of0DEcOc;
	spf=pass (mail.lfdr.de: domain of "linux-hyperv+bounces-11804-lists+linux-hyperv=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="linux-hyperv+bounces-11804-lists+linux-hyperv=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=redhat.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id AAAB630D4C1A
	for <lists+linux-hyperv@lfdr.de>; Thu,  2 Jul 2026 08:57:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 036EA42B31F;
	Thu,  2 Jul 2026 08:56:50 +0000 (UTC)
X-Original-To: linux-hyperv@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FEFE420E83
	for <linux-hyperv@vger.kernel.org>; Thu,  2 Jul 2026 08:56:46 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782982609; cv=none; b=cC3/1ZYY3FCfdMZmEWqCtYRQgV7xfw/LfteLXh/XP/soH4i1IOBokQFB4R6/vmOJHzk65NUAtcsIzupODBbG7efAlf4dUl7uqYKIASSvvDbrZ/byf0kAZxLRHWJHZB3UTW1fhyXogPthtlhI7qV90kJigndc01UrxuM7jB0XH2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782982609; c=relaxed/simple;
	bh=A8kz+z/pn/2NvDfwSoTwoXovKS5Tz/eYbUJLArUxpKk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eUPw5gbA7ZfgjBQ6zr5ptG2fxH2ztE5/m9JzXvlbieVcHyDIXxCVmdK0UGBs7VLZQ/9OnWQWybu2o1GqdbjAZe8Di/IHD3a1aIifHyo5KT33v0Z/0m1RAq/jF+ZEHVUAcmFmGzJ9Fzew5aI17bKHNCvOPjTQL9sSpB941lGWju8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=D4hqxleJ; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=of0DEcOc; arc=none smtp.client-ip=170.10.129.124
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1782982606;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1BNV7d13XbfTlrXrCmDz2hviM6j+trGL8vCgv7cOUtY=;
	b=D4hqxleJkdZBfqj+z3G5439nGX4VVhektyqXOKQ1Eqdii5kT162K/bTkYjyMzFIVFDd6KW
	SyFD8k7WkDl44QQ5QxEf0EROG0oCG2+crvtd896ccmcJ12ZXBpwEqY6HK9Rd9Zt4ff95O4
	FOXniejmvSK/9+wAEzTAm1GG0FeGoO8=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-501-Vo0emLkkP3uCvW9nBYOowQ-1; Thu, 02 Jul 2026 04:56:44 -0400
X-MC-Unique: Vo0emLkkP3uCvW9nBYOowQ-1
X-Mimecast-MFC-AGG-ID: Vo0emLkkP3uCvW9nBYOowQ_1782982603
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-493ae2a6a72so12306525e9.0
        for <linux-hyperv@vger.kernel.org>; Thu, 02 Jul 2026 01:56:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1782982603; x=1783587403; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1BNV7d13XbfTlrXrCmDz2hviM6j+trGL8vCgv7cOUtY=;
        b=of0DEcOcwfgrXkgsIHW90sEV7PJgyLLzCILGPxXx1FAr21o3zC1XyRZnLEJ079OsJq
         +eZ5yZY1Pxp/7WrxmjF4hZQsT0WK9GVLa+DAxNjtY56qKYS2v+luJ8aPk8+NPwYkV2oP
         QwXPqaFlRvZtodQUWAnEC9kMxlvrgMrsjXJmhfRrski1ALfub4TA5jG+IbShwaK8Xt4f
         se17P1smnCDMeMB4NVGdlAcf4hcKVaHXIP7OHbEnZ4vjHV/OjwrZ0QitzavUE0USnqDS
         s3xX+q4pZdv4KGoJ2Tgg8IvBHp7FtkZhxhvbD01XG3FtEZaNnfMltXDecylGHSkoLuAE
         Y+4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782982603; x=1783587403;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1BNV7d13XbfTlrXrCmDz2hviM6j+trGL8vCgv7cOUtY=;
        b=cwWCdReCeh/587UvsH5aOHOZDPX4Tm1ptRheRXkgk+w/k7AfnGb9XQ3OJpqNzCEYw1
         GxzayZsTzSyvED53H4iqnp6mReoJCxOqz0YB+htmsWOTre9dcu79VAe24OEjtO6I+wFr
         Hq2B8ZZ1HmF43hFmWGDr2Wpxoo3IFByCNBT1sHJA5ykTOvgcUqcpeJZJ2KC95E0Ps7K1
         QdbuJ93m3CndcsJ3mTGKfGgu+f7c1hvUxQdp/SGM/dkip9/udYR6axotwiuNbzJwSCih
         T9yIC7mSRjSAQeC+WpGH8Q1X+30sZ+SgzBtNaGyVXzbl6jN52NRwJ8tqPVZcGhNB/Hr2
         6GDg==
X-Forwarded-Encrypted: i=1; AFNElJ/gAxansm9NLhvMxWY1itzFiOjV4jArBmCmwjbpkwAjkY0q6bikswSuzDvomB3Lc1ejLKNJ/U3X3KIwmXw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwJ9/0sDDVUdBje5FwFgSuZsVuAIcfueSXxCt6PyMNqhKdXDGID
	xEEVleEPjOixVabdTv3jK9TTsOffhafi3MSULN0kaN+ySGCsxTprcolzxHxXLukyF8n5dGsG2Yw
	Cye4cJN5/fSoXwAEuiD1+NCX/LthaaojWgC7J6UXRN8JJB70nzq0fmUfrFThERwu5tA==
X-Gm-Gg: AfdE7cm7cPmXXGVUICQHRlN/5WCQ6XIwMBT68Fb+1Kb4glByIdJDJia4qyJMLqr1Vap
	u6S5CyeaK7z00Extlar3a9h4JI1FqBR/tySZyRdeQEO2G3D+/lVkR97dbJC7O36dni5u5HDlElW
	xKbJb2trw6eXobn8kf2BN9rqqH1wWgyr2K7aB6xguXxmQPfkqmz+ocvFPmq3yDZWehiXmEMHXyg
	l0UCQI88N0PrNRpLthWIv7vQ+hiVUQaoGMazzf8m51neLUGhTfT568hUC0TO9wPA6LMaTZWdk48
	HIOb5XOnorxykz90o2HU2LHrt0YHoATW4RI/2wh/PEDUs/F1Wl66AZWZ80NlyepYd9Esn1xju1G
	TvN2iIGL/J3RTxouUEFI+gpl8BrgRgtmk1/SxKPl3CdO+q5buN4drQD5y3QgqX4/EvDpTu0Gt1m
	gPzdo4RGrlpQ==
X-Received: by 2002:a05:600d:8497:10b0:493:c3e0:99ab with SMTP id 5b1f17b1804b1-493c481e706mr33395595e9.25.1782982603483;
        Thu, 02 Jul 2026 01:56:43 -0700 (PDT)
X-Received: by 2002:a05:600d:8497:10b0:493:c3e0:99ab with SMTP id 5b1f17b1804b1-493c481e706mr33395145e9.25.1782982602991;
        Thu, 02 Jul 2026 01:56:42 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:5521:6b10:2eb7:f61a:75:4534? ([2a0d:3344:5521:6b10:2eb7:f61a:75:4534])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-493c63172fesm55898635e9.0.2026.07.02.01.56.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Jul 2026 01:56:42 -0700 (PDT)
Message-ID: <8906f758-27fe-4ea8-8558-6d15089372d1@redhat.com>
Date: Thu, 2 Jul 2026 10:56:40 +0200
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v4] net: mana: Add Interrupt Moderation support
To: Haiyang Zhang <haiyangz@linux.microsoft.com>,
 linux-hyperv@vger.kernel.org, netdev@vger.kernel.org,
 "K. Y. Srinivasan" <kys@microsoft.com>,
 Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>,
 Dexuan Cui <decui@microsoft.com>, Long Li <longli@microsoft.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>,
 Konstantin Taranov <kotaranov@microsoft.com>, Simon Horman
 <horms@kernel.org>, Erni Sri Satya Vennela <ernis@linux.microsoft.com>,
 Dipayaan Roy <dipayanroy@linux.microsoft.com>,
 Aditya Garg <gargaditya@linux.microsoft.com>,
 Breno Leitao <leitao@debian.org>, linux-kernel@vger.kernel.org,
 linux-rdma@vger.kernel.org
Cc: paulros@microsoft.com
References: <20260629213652.11682-1-haiyangz@linux.microsoft.com>
From: Paolo Abeni <pabeni@redhat.com>
Content-Language: en-US
In-Reply-To: <20260629213652.11682-1-haiyangz@linux.microsoft.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-11804-lists,linux-hyperv=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[pabeni@redhat.com,linux-hyperv@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[21];
	FORGED_RECIPIENTS(0.00)[m:haiyangz@linux.microsoft.com,m:linux-hyperv@vger.kernel.org,m:netdev@vger.kernel.org,m:kys@microsoft.com,m:haiyangz@microsoft.com,m:wei.liu@kernel.org,m:decui@microsoft.com,m:longli@microsoft.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:kotaranov@microsoft.com,m:horms@kernel.org,m:ernis@linux.microsoft.com,m:dipayanroy@linux.microsoft.com,m:gargaditya@linux.microsoft.com,m:leitao@debian.org,m:linux-kernel@vger.kernel.org,m:linux-rdma@vger.kernel.org,m:paulros@microsoft.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[redhat.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 38CF26F50DF

On 6/29/26 11:36 PM, Haiyang Zhang wrote:
> diff --git a/drivers/net/ethernet/microsoft/mana/mana_en.c b/drivers/net/ethernet/microsoft/mana/mana_en.c
> index 7438ea6b3f26..9391e9564605 100644
> --- a/drivers/net/ethernet/microsoft/mana/mana_en.c
> +++ b/drivers/net/ethernet/microsoft/mana/mana_en.c
> @@ -1591,6 +1591,9 @@ int mana_create_wq_obj(struct mana_port_context *apc,
>  
>  	mana_gd_init_req_hdr(&req.hdr, MANA_CREATE_WQ_OBJ,
>  			     sizeof(req), sizeof(resp));
> +
> +	req.hdr.req.msg_version = GDMA_MESSAGE_V3;
> +	req.hdr.resp.msg_version = GDMA_MESSAGE_V2;

Double checking the above is intentional; it feels strange to me that
request and reply use different versions. Possibly a comment for future
memory would make sense.

>  	req.vport = vport;
>  	req.wq_type = wq_type;
>  	req.wq_gdma_region = wq_spec->gdma_region;
> @@ -1599,6 +1602,9 @@ int mana_create_wq_obj(struct mana_port_context *apc,
>  	req.cq_size = cq_spec->queue_size;
>  	req.cq_moderation_ctx_id = cq_spec->modr_ctx_id;
>  	req.cq_parent_qid = cq_spec->attached_eq;
> +	req.req_cq_moderation = cq_spec->req_cq_moderation;
> +	req.cq_moderation_comp = cq_spec->cq_moderation_comp;
> +	req.cq_moderation_usec = cq_spec->cq_moderation_usec;
>  
>  	err = mana_send_request(apc->ac, &req, sizeof(req), &resp,
>  				sizeof(resp));
> @@ -1856,6 +1862,7 @@ static void mana_poll_tx_cq(struct mana_cq *cq)
>  	struct gdma_posted_wqe_info *wqe_info;
>  	unsigned int pkt_transmitted = 0;
>  	unsigned int wqe_unit_cnt = 0;
> +	unsigned int tx_bytes = 0;
>  	struct mana_txq *txq = cq->txq;
>  	struct mana_port_context *apc;
>  	struct netdev_queue *net_txq;
> @@ -1937,6 +1944,8 @@ static void mana_poll_tx_cq(struct mana_cq *cq)
>  
>  		mana_unmap_skb(skb, apc);
>  
> +		tx_bytes += skb->len;
> +
>  		napi_consume_skb(skb, cq->budget);
>  
>  		pkt_transmitted++;
> @@ -1967,6 +1976,10 @@ static void mana_poll_tx_cq(struct mana_cq *cq)
>  	if (atomic_sub_return(pkt_transmitted, &txq->pending_sends) < 0)
>  		WARN_ON_ONCE(1);
>  
> +	/* Feed DIM with the completion rate observed here, in NAPI context. */
> +	cq->tx_dim_pkts += pkt_transmitted;
> +	cq->tx_dim_bytes += tx_bytes;
> +
>  	cq->work_done = pkt_transmitted;
>  }
>  
> @@ -2318,6 +2331,119 @@ static void mana_poll_rx_cq(struct mana_cq *cq)
>  		xdp_do_flush();
>  }
>  
> +static void mana_rx_dim_work(struct work_struct *work)
> +{
> +	struct dim *dim = container_of(work, struct dim, work);
> +	struct dim_cq_moder cur_moder;
> +	struct mana_cq *cq;
> +
> +	cur_moder = net_dim_get_rx_moderation(dim->mode, dim->profile_ix);
> +	cq = container_of(dim, struct mana_cq, dim);
> +
> +	cur_moder.usec = min_t(u16, cur_moder.usec, MANA_INTR_MODR_USEC_MAX);
> +	cur_moder.pkts = min_t(u16, cur_moder.pkts, MANA_INTR_MODR_COMP_MAX);
> +
> +	mana_gd_ring_dim(cq->gdma_cq, cur_moder.usec, true,
> +			 cur_moder.pkts, true);
> +
> +	dim->state = DIM_START_MEASURE;
> +}
> +
> +static void mana_tx_dim_work(struct work_struct *work)
> +{
> +	struct dim *dim = container_of(work, struct dim, work);
> +	struct dim_cq_moder cur_moder;
> +	struct mana_cq *cq;
> +
> +	cur_moder = net_dim_get_tx_moderation(dim->mode, dim->profile_ix);
> +	cq = container_of(dim, struct mana_cq, dim);
> +
> +	cur_moder.usec = min_t(u16, cur_moder.usec, MANA_INTR_MODR_USEC_MAX);
> +	cur_moder.pkts = min_t(u16, cur_moder.pkts, MANA_INTR_MODR_COMP_MAX);
> +
> +	mana_gd_ring_dim(cq->gdma_cq, cur_moder.usec, true,
> +			 cur_moder.pkts, true);
> +
> +	dim->state = DIM_START_MEASURE;
> +}
> +
> +/* The caller must update apc->rx/tx_dim_enabled before disabling and
> + * after enabling. And synchronize_net() before draining the DIM work,
> + * so that NAPI cannot observe a stale flag.
> + */
> +int mana_dim_change(struct mana_cq *cq, bool enable)

This always return 0, and the return value is not checked by the
callers; return type should likelly changed to void

/P


