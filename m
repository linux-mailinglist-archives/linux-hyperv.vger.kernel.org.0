Return-Path: <linux-hyperv+bounces-9856-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MIbJINqUy2nMJAYAu9opvQ
	(envelope-from <linux-hyperv+bounces-9856-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Tue, 31 Mar 2026 11:33:14 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E89A367209
	for <lists+linux-hyperv@lfdr.de>; Tue, 31 Mar 2026 11:33:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 5618F301E98C
	for <lists+linux-hyperv@lfdr.de>; Tue, 31 Mar 2026 09:33:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66A803EC2E7;
	Tue, 31 Mar 2026 09:33:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Eq4rtvjw";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="sLy73V32"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 073513CF034
	for <linux-hyperv@vger.kernel.org>; Tue, 31 Mar 2026 09:33:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774949592; cv=none; b=dzv/0cuNYA2YDwmj5JwSHDRp9LeMKdboEwwMtpOP2lycN+LjmffwD+oKT+VhzO0OzJ6iB1L8L4OLRn/afc5fSxM9gZVkHmVJsPizFT64fuu09T2tAxJlI3FswB1MQonqmw7/ECCIMI2GSNteaxyXBb8Qz45oa/jdPATsxr90Wmo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774949592; c=relaxed/simple;
	bh=UXqsQ0BBG7/4O3Wp7zNRvbriuKMnrUyPn6h4dz9TOok=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=DJ/KMEAmnXo8cdSfskAFuoIvXYGd3Kh3eDZaYo0egpTJXUL0vg0uLszlhf03QP0XTH7bCt5WuhWEY+TmmmAlDbD3I/RtIohskvb8JA8mN4PP0MkgXTdKqdJgzPpobKePUpBMNk5p6+xzhY7hHlmZjFIaJezEU/6sF3jfqSZxlpE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Eq4rtvjw; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=sLy73V32; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1774949590;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vp9JL+N08mDhUd7pdtaI366A6NgeulMET6+HShC94Iw=;
	b=Eq4rtvjwsIbMgmUjPdBUabeP3FuYuQFEusALEhTw9thRwHWrPXrXpHORNh5hS2wYre6Hi1
	wHuUaqX8IENoMPVdUR9PTE9bAhc+UcH1Hj901zkrgzMblygcwqXNkBAvoM2hTtnOHx7CrH
	ipKnQYzPxwwpaiID2JV0cubXdjRjJFI=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-232-iPNwlj3SNnKdxWHI7v2B6g-1; Tue, 31 Mar 2026 05:33:08 -0400
X-MC-Unique: iPNwlj3SNnKdxWHI7v2B6g-1
X-Mimecast-MFC-AGG-ID: iPNwlj3SNnKdxWHI7v2B6g_1774949587
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-48542d5aa9eso48735665e9.0
        for <linux-hyperv@vger.kernel.org>; Tue, 31 Mar 2026 02:33:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1774949587; x=1775554387; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=vp9JL+N08mDhUd7pdtaI366A6NgeulMET6+HShC94Iw=;
        b=sLy73V32vZB27HWug4g9fBQvdSoTej8qtkeyQEJYT9UVudnWnsu8hX7LMDICrJ/YbA
         efkFxQ1UWB+T4LS5ovHR6rMgRjRqL+RYhD29Q1JJ1zqljkqAUTDgnLFYpF7okP6ymfxW
         dSo8xbf7CDqYwYH9hmGyJS7Ig4zL4hVx4eYv2ZZhkD+J/3W1wEHZrgyugEahzjVPQKDX
         hiCb3VhKdFRkglb5ypAj8XSjxIjixJqNOx3QOu+Txt7d3Yl52CuU/EldLhgJwR6cw7kg
         tQXMI9pNeUeOtJfjveQd4whNKbxi2L18OiYCPtM0WTp9jShiLlpWEOREjkvjhuXgHd1L
         smzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774949587; x=1775554387;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vp9JL+N08mDhUd7pdtaI366A6NgeulMET6+HShC94Iw=;
        b=UerjCNXcuDP15x9ciD+s6Rv7TixHcTQfn/pw0aawdu0WSlgzsGyTC25o0UikU+LDy1
         Axe4gttnwUyCJJ/PvxM97a98adOTa/8Y8eNrORMwH6tj+r85CAlKEY6xlVF8ki9AhYBF
         tjIjfVrJjGDlnzim+gTYJX46e5nl9y+gK+hE2laPiF0Wo644TzowZ4FNe66Q8iH4eYWi
         NRdS9x5lq4QEa0LLdVmFRhE0LIK3BM/iY2pSpLZYjooaFXwlbkuSzTQN2LyMLnw4Lsxg
         5YrxXGu5hzlNMWQG2Ew1BNgkeCzAzMt7OASZCjHJ/UOydQEBVLn8X5IqmCtgdr5rfn5S
         jlUA==
X-Forwarded-Encrypted: i=1; AJvYcCU8eqq8hhSHC/CPf+8uoRBOXRREwMekyMWyJCIhOdfQwN8jHDaOHer2RbR4wkD6b9cdqUGvDmMROJRLMaI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyd/d4GVGneRiUauXszUKuDwTG1hBw7n7ZNK28qB+km+AD78uPM
	8f1HpkB5DmRjF06Py5F84s8Am4cBqcYAzx9zl7+KjwDq7hdqJKj+mK/0JTTDvFfd/DOTbYVVO9B
	HgMqiXvrYQxVYF0ZIedBeTUOpFy0NDT7uo20L9hkNo+C1V9z3p/+T4S+13f85jOH6rg==
X-Gm-Gg: ATEYQzyKqv7YVCfl4L7Mm8pUj3J+VU2Gu6gBxvxKWzNTebP8RZo6JH3o+rT5xSos3jI
	+e5c58iURgW3NpKBkasOdBz5OFmxlTgs9hHuCHT3TMSLaZlRFk8ZZHcWa08j4+vjzaEbaoga4Pp
	6vKQ9OWj25GG/ZiddiK+7IuyNJgnaXlUFZrnY9XXiS9SDiU84+8A5yTgkRHOfOe9DOU1QOaZvaB
	UpSTYH8d9Vd85G+JsNy5t0tx9FEy3FO97RDeyhnfsZ7pSXwFRGsHFTsDb67e7quYCqLm52kFsfp
	4UL4QUvpxAbxKxkYFnjPIxZ2/zf82bOmnOhu0cFfGexjhzhugqODoEuWTZZvlK8I88qf2xeYvVv
	J/AEtMogrxHJg8DcmwYKk4eS8I8gcazlnZ+6A9ZxZKAWPlUD79q6T7e/b
X-Received: by 2002:a05:600c:8489:b0:486:fbdb:b718 with SMTP id 5b1f17b1804b1-4872807483cmr267366065e9.25.1774949587055;
        Tue, 31 Mar 2026 02:33:07 -0700 (PDT)
X-Received: by 2002:a05:600c:8489:b0:486:fbdb:b718 with SMTP id 5b1f17b1804b1-4872807483cmr267365375e9.25.1774949586546;
        Tue, 31 Mar 2026 02:33:06 -0700 (PDT)
Received: from [192.168.88.32] ([212.105.155.58])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4887e83682fsm23911365e9.7.2026.03.31.02.33.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 31 Mar 2026 02:33:05 -0700 (PDT)
Message-ID: <f0bc585f-b1d2-46e6-b0eb-801881862692@redhat.com>
Date: Tue, 31 Mar 2026 11:33:04 +0200
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] net: mana: hardening: Reject zero max_num_queues
 from MANA_QUERY_VPORT_CONFIG
To: Erni Sri Satya Vennela <ernis@linux.microsoft.com>, kys@microsoft.com,
 haiyangz@microsoft.com, wei.liu@kernel.org, decui@microsoft.com,
 longli@microsoft.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, ssengar@linux.microsoft.com,
 dipayanroy@linux.microsoft.com, gargaditya@linux.microsoft.com,
 shirazsaleem@microsoft.com, kees@kernel.org, linux-hyperv@vger.kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260326174815.2012137-1-ernis@linux.microsoft.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20260326174815.2012137-1-ernis@linux.microsoft.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[redhat.com:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9856-lists,linux-hyperv=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pabeni@redhat.com,linux-hyperv@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-hyperv,netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 1E89A367209
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 3/26/26 6:48 PM, Erni Sri Satya Vennela wrote:
> As a part of MANA hardening for CVM, validate that max_num_sq and
> max_num_rq returned by MANA_QUERY_VPORT_CONFIG are not zero. These
> values flow into apc->num_queues, which is used as an allocation count
> and loop bound. A zero value would result in zero-size allocations and
> incorrect driver behavior.
> 
> Return -EPROTO if either value is zero.
> 
> Signed-off-by: Erni Sri Satya Vennela <ernis@linux.microsoft.com>
> ---
>  drivers/net/ethernet/microsoft/mana/mana_en.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/net/ethernet/microsoft/mana/mana_en.c b/drivers/net/ethernet/microsoft/mana/mana_en.c
> index b39e8b920791..a4197b4b0597 100644
> --- a/drivers/net/ethernet/microsoft/mana/mana_en.c
> +++ b/drivers/net/ethernet/microsoft/mana/mana_en.c
> @@ -1249,6 +1249,12 @@ static int mana_query_vport_cfg(struct mana_port_context *apc, u32 vport_index,
>  
>  	*max_sq = resp.max_num_sq;
>  	*max_rq = resp.max_num_rq;
> +
> +	if (*max_sq == 0 || *max_rq == 0) {
> +		netdev_err(apc->ndev, "Invalid max queues from vPort config\n");
> +		return -EPROTO;

AI review says:

Will returning -EPROTO here expose a pre-existing resource leak in the
driver's teardown path?
If mana_query_vport_cfg() returns an error, mana_init_port() fails and
mana_probe_port() frees the ndev, leaving ac->ports[i] as NULL. In
mana_probe(), the port initialization loop breaks upon this error, but
the err variable is then overwritten:

mana_probe() {
    ...
    for (i = 0; i < ac->num_ports; i++) {
        err = mana_probe_port(ac, i, &ac->ports[i]);
        if (err) {
            dev_err(dev, "Probe Failed for port %d\n", i);
            break;
        }
    }

    err = add_adev(gd, "eth");
    ...
}

If add_adev() succeeds, mana_probe() completes successfully instead of
failing, masking the earlier error while leaving ac->ports[0] as NULL.
Later, when the driver is unloaded or if add_adev() fails and triggers
immediate cleanup, mana_remove() is called. It iterates over ac->ports
and, upon encountering the NULL device, immediately executes goto out:

mana_remove() {
    ...
    for (i = 0; i < ac->num_ports; i++) {
        ndev = ac->ports[i];
        if (!ndev) {
            if (i == 0)
                ...
            goto out;
        }
        ...
    }

    mana_destroy_eq(ac);
out:
    ...
}

Because the out label in mana_remove() is located after the
mana_destroy_eq(ac) call, jumping there completely skips destroying the
event queues allocated earlier by mana_create_eq(ac).
In a Confidential Virtual Machine context, could an untrusted hypervisor
repeatedly return invalid configs to continuously leak guest memory and
hardware queues?


