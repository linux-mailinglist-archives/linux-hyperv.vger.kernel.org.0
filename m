Return-Path: <linux-hyperv+bounces-9113-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aJbgAgrTpmnHWgAAu9opvQ
	(envelope-from <linux-hyperv+bounces-9113-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Tue, 03 Mar 2026 13:24:42 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E2331EF585
	for <lists+linux-hyperv@lfdr.de>; Tue, 03 Mar 2026 13:24:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BCE7231AD15D
	for <lists+linux-hyperv@lfdr.de>; Tue,  3 Mar 2026 11:56:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AF2633EB1A;
	Tue,  3 Mar 2026 11:56:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cBBlG38o";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="NX+11DLJ"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB0CF336ECC
	for <linux-hyperv@vger.kernel.org>; Tue,  3 Mar 2026 11:56:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772539004; cv=none; b=Y4r6o46c0bNTrV1pjALTGNNlnux3mGGKYnsqK5u6ri1l7C05YUgMKsKBDiaBuLw7ZvroSE9iFN20E6bgrQxCRvD2i3zZWXaLhWR2/I9rCX4ff7Map9ye2muDtgEr9bXqTdOYtNAqDBfubNnK+mGCPJhRQ4CT+fXQVfD3bcSXJn8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772539004; c=relaxed/simple;
	bh=A/NEFi/PBYeAOmB2KG5gxaOCCxGsrdsftJAmATm2mHg=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Yii2tvYSM712wO4qz1Wphqgkb4u+ZyN9gt1zy/+/i2L28QPyTce5Fw5oLUuIFOma8lTalLHSVoIAFBa0gKp8/CYI6LsOFyWEToKs2t3kq+UmhuTtTLSWUbzC/YjRY2RwNyFpkoD35tDhWg29Vpi269YU4+UpX/5rTasJaWlP+No=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cBBlG38o; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=NX+11DLJ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1772539000;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LLxBnAuISZ3YGJZFcr1hGO+eIaLFeSdfs24D7Pk3tSk=;
	b=cBBlG38o24gwvlx6FBrfP/2pPslXkBaLoKYCfYnkG6QnIQ+9Gly8aXLDH/+I6Dz4VzVjjC
	3Y3QQBH73uGWHtbttkRVFvkapHCbagjpw3MKHoefSj9igl+sT1FLnW8L+UdadlXF1KXP2Z
	bCulrS+pQ7xHGUPtgQO3154YMLk7lNU=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-359-vP2y5h8VOC2v9g2X_i-ENg-1; Tue, 03 Mar 2026 06:56:39 -0500
X-MC-Unique: vP2y5h8VOC2v9g2X_i-ENg-1
X-Mimecast-MFC-AGG-ID: vP2y5h8VOC2v9g2X_i-ENg_1772538998
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-43996fb9cf9so5072207f8f.1
        for <linux-hyperv@vger.kernel.org>; Tue, 03 Mar 2026 03:56:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1772538998; x=1773143798; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=LLxBnAuISZ3YGJZFcr1hGO+eIaLFeSdfs24D7Pk3tSk=;
        b=NX+11DLJrrxZJlcGoCC31j0K7UYI6qxhyb0/8P/ZPKYy9mwE8FDh5Xsfg9+MhfWwnl
         m9XLi/QIoQxuhoxKJ8k0x1HVhVEkGH0/kvRu0kc7fPEAiH1kdyyKCmbwasLD72BjuuZj
         nwj5jyeEtuG5ckCJGi3DtF1ozhgsKPVBsMi2Dlrfxogj5g++MY2NqI4KDlQMIMVn5bKE
         1wGF8treA0g0m8Pf9KugVOmo0uJlyoa4OFQ+chxoY5JDiGjG7jUz7imEFrY+raTCXlxR
         vwdi+nPqX3o4PnLS0PVHADK5LzmTOUCCBD8RApDOb5KvqVaRn5bBlgmicpsZjuMsaiV6
         u+Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772538998; x=1773143798;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LLxBnAuISZ3YGJZFcr1hGO+eIaLFeSdfs24D7Pk3tSk=;
        b=oxyU1fGUWh0L5yiSk+o9rRljNgJcr+xq/BFiMor+qdmgEjAQpTiebOExWsI/lHEUni
         WMm3FedgSm0JTFxxgW6PzhZ0GALB3uWHH38KSt9drcexK8qDVbWRgo8LECT/A9c2fW4P
         fnuSgzAA5LiW8Nk4RhwBiumyLRGZs2qJTr8y8a5/TWFD7x/ZWmGBk1lDjMVStrJPYsZ7
         6zSxzCmQUj4s6dnN7DyluaMgVZv3ZonQtOL2HKmjw4bCIECA3gHlcisPoT0q4F+CL6F+
         wZAVWjNuFy9tpnPiH9dcZzBl+9BqYK/TnO6OoDhOPDGAIvNaKk7eQ0M0l5QLEgJW1ESV
         +rfw==
X-Forwarded-Encrypted: i=1; AJvYcCWh4MuTwxdfQLIjBUwUsEwPK8bcI12RkzBj7lKDrMIEQSJ8LfQXWPS0WkmKwgUvKvaI15URGnlQaXum9PM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxkUEWoSjsiPDTas/qpYKfPsxryphgKfu0bzzVuuA4iu/GYFIcb
	QLSCO9n+oPexsPTGB/gJh5IcK1OSg4xUfo1JxiIWtINAa7WkuRYUnx3DlnahgiUvVMGBSwwfqZ8
	G+39eWFDWfsXvKHlK3pKpM2oA/b6NdIi8qrhNmp9q0Dk64WBNT8I5v9MxWFrT6mxasg==
X-Gm-Gg: ATEYQzzWRnNsKGpYZcaqkOrhj82kLcgupl9LoSnvn1JNQGDlJkbUdDAE+1OmpCorsDJ
	gRC3e0CeOvb7Vd+XAPI4mQ4ViP8o4i5EXyWVdo6GGdIgDntfgmR3rXPXwWoarlZhWv3V2+ZTYvt
	lQd2d0VVM4AKq6mi6WEiL/TrmF1ADq9HF4UcXLIIRzHMmDn63cwXOla4kC70m6fKC1Xi97TUgSs
	HB1g6vXwDqjA3UFpxjYFMab/iEbOu4KnCsvKCeuUbGgTvMGUMHrrdDDD7oxCXlkQol23v6HceNm
	SFF7em77pzw/ElN9gMJ7liO/ozAJAcsP6E5ueikVwBrDquGwDvVUHDem6b6ltJ1307/f5r5vHCA
	9z3/wV0Og/TJQVcCgGKA8BLAM
X-Received: by 2002:a05:6000:24ca:b0:439:b564:7a6c with SMTP id ffacd0b85a97d-439b5647fa6mr13229274f8f.4.1772538998382;
        Tue, 03 Mar 2026 03:56:38 -0800 (PST)
X-Received: by 2002:a05:6000:24ca:b0:439:b564:7a6c with SMTP id ffacd0b85a97d-439b5647fa6mr13229226f8f.4.1772538997874;
        Tue, 03 Mar 2026 03:56:37 -0800 (PST)
Received: from [192.168.88.32] ([212.105.155.73])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-439ae3f31dbsm21348530f8f.1.2026.03.03.03.56.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Mar 2026 03:56:37 -0800 (PST)
Message-ID: <03ac38dc-69c5-4641-98ea-5679465c0b7f@redhat.com>
Date: Tue, 3 Mar 2026 12:56:35 +0100
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] net: mana: Force full-page RX buffers for 4K
 page size on specific systems.
To: Dipayaan Roy <dipayanroy@linux.microsoft.com>, kys@microsoft.com,
 haiyangz@microsoft.com, wei.liu@kernel.org, decui@microsoft.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, leon@kernel.org, longli@microsoft.com,
 kotaranov@microsoft.com, horms@kernel.org, shradhagupta@linux.microsoft.com,
 ssengar@linux.microsoft.com, ernis@linux.microsoft.com,
 shirazsaleem@microsoft.com, linux-hyperv@vger.kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-rdma@vger.kernel.org, dipayanroy@microsoft.com
References: <aaFusIxdbVkUqIpd@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <aaFusIxdbVkUqIpd@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 5E2331EF585
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[22];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9113-lists,linux-hyperv=lfdr.de];
	DKIM_TRACE(0.00)[redhat.com:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pabeni@redhat.com,linux-hyperv@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-hyperv,netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

On 2/27/26 11:15 AM, Dipayaan Roy wrote:
> diff --git a/drivers/net/ethernet/microsoft/mana/mana_en.c b/drivers/net/ethernet/microsoft/mana/mana_en.c
> index 91c418097284..a53a8921050b 100644
> --- a/drivers/net/ethernet/microsoft/mana/mana_en.c
> +++ b/drivers/net/ethernet/microsoft/mana/mana_en.c
> @@ -748,6 +748,26 @@ static void *mana_get_rxbuf_pre(struct mana_rxq *rxq, dma_addr_t *da)
>  	return va;
>  }
>  
> +static inline bool
> +mana_use_single_rxbuf_per_page(struct mana_port_context *apc, u32 mtu)
> +{

I almost forgot: please avoid the 'inline' keyword in .c files. This is
function used only once, should be inlined by the compiler anyway.

> +	struct gdma_context *gc = apc->ac->gdma_dev->gdma_context;
> +
> +	/* On some systems with 4K PAGE_SIZE, page_pool RX fragments can
> +	 * trigger a throughput regression. Hence forces one RX buffer per page
> +	 * to avoid the fragment allocation/refcounting overhead in the RX
> +	 * refill path for those processors only.
> +	 */
> +	if (gc->force_full_page_rx_buffer)
> +		return true;

Side note: since you could keep the above flag up2date according to the
current mtu and xdp configuration and just test it in the data path.

/P


