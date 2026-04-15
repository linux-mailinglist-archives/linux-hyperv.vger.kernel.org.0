Return-Path: <linux-hyperv+bounces-10180-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kOILE7Bq32niSgAAu9opvQ
	(envelope-from <linux-hyperv+bounces-10180-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Wed, 15 Apr 2026 12:38:40 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A9CB540354C
	for <lists+linux-hyperv@lfdr.de>; Wed, 15 Apr 2026 12:38:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A36AD301E230
	for <lists+linux-hyperv@lfdr.de>; Wed, 15 Apr 2026 10:38:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC129347536;
	Wed, 15 Apr 2026 10:38:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AJrnX99Y";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="U0NcrzVV"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BE58330D2A
	for <linux-hyperv@vger.kernel.org>; Wed, 15 Apr 2026 10:38:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776249497; cv=none; b=t4qnyTpjRnEBJYEBPvPSMrhGsUDz+Ry0Wt6G17fs7J0gWrHJrdeDg3Boy5HwGaYOsptnV4EEBBUaT1sUvBLP1wH+WMfE1VvZU0MZm6U7DFUch7WZqvj5h0rkIPI6Zggp2vztF1w7WJQCMLwuuS/Qi/8XWQYMLU1EmrZs3DphbtI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776249497; c=relaxed/simple;
	bh=MTvLj66Y77ArXLSp+TSw8ghHRCXJwgL40oURLnpQzt4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DPm8XQzOdl4Yst+k0qaAWFXvgCCVoVtZB+NKXGoo/BjluzgvgXxJ/gXLUhEoT3RlCTjmZBWx8HaTqZ6M5ZahfDreVZrQLCFwV9A5gOwmama87jm+SqjkjSUSjAupa8L1nMkhDcGWc4wCACahb1JZNRXrNq6odkri5Sgc/3iNQ88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AJrnX99Y; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=U0NcrzVV; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1776249495;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=hHOnfYuW3tC+yUaHMZSnrjEvT22LJH6fSZwyXCPhnqE=;
	b=AJrnX99YSbM91yM5IEAYd1hTzUSta3A2/doH1UdZxvvcWgNRzuWtnuLBqnZuWYPNpvpMix
	nTaLHeNOubZesjyizOtecxt+f6ZecKrstn2W0satE1VkrVcA2bc0HGsoJlR3x4bBMcLUm2
	kZEl1U+6AuQzLIkGvZ80b4t3lgY15dM=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-231-qklBHSTaNdKjiBTtxV615A-1; Wed, 15 Apr 2026 06:38:14 -0400
X-MC-Unique: qklBHSTaNdKjiBTtxV615A-1
X-Mimecast-MFC-AGG-ID: qklBHSTaNdKjiBTtxV615A_1776249493
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-488d9e1e61aso35070985e9.0
        for <linux-hyperv@vger.kernel.org>; Wed, 15 Apr 2026 03:38:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1776249493; x=1776854293; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=hHOnfYuW3tC+yUaHMZSnrjEvT22LJH6fSZwyXCPhnqE=;
        b=U0NcrzVVjY6gjX5DffGCbMccj7Whri+rEWRWeYaofTN2IrFM4sp0h81cRl7C91bkwG
         aggg36rkrlKfEesRAWLDrmBYIaO/FQwjqqZXOkmT4lnqB1PxiGE5MAYZOq2fSnIAVNl0
         AxVH0qemkkFKqsRQOEBRLrwOame+g5w7Wnne84LzAtkovuIzGyMSJd9TeAF1eKIzRIGi
         rQPDIwW1s/Nh53AURiwjbWHipsTO/+QDckmt1/V9KgN5bNiw6ycmeWggQx8NcxA8iC0S
         v+cdw0lJxeJW39MLJRmBIc/y/9KyfoQGWOfGVYVdM6OXIpO5rqjd0lN1FzOxV6tqVpa2
         hJRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776249493; x=1776854293;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hHOnfYuW3tC+yUaHMZSnrjEvT22LJH6fSZwyXCPhnqE=;
        b=VMuwD4MSlkzUtsxIlWXu+6fGTpVLYTjvn859pacB4jPZm/tilyirop94oyV5VFwrQ7
         YcvQ7/qesjbX4wCmXdRwUVenn5n0fgQni4XHeYaFZSZ4DRlBCOV2e8xkA/nEIsjH1uur
         X4H/DssZ+o0+TXaP5ViAzlnti8StNj5skPOOXZVZwm1xm8rP7U+chms2JJOZRb4vVoL2
         pSufPK+HpCHCdDszdDPEU74+V3MHSGVsD8uKX3aybUsKPIQA1AO5vEkg0QRaLSML1xuX
         d+U03zZH4tgtbtgPAeg36pcqMeRlVQQy58zEghzaTAR4MVa2zqYSLhRBl8zBewTshUji
         yO/w==
X-Forwarded-Encrypted: i=1; AFNElJ+K4iBLsJjF0r9GU+s+alripLdJtnoUEFmL4gLH0DDkkGqkMVn6vnGn9Kl1G9IgMw2ipuxgjno7hhVT+nw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz2McQcG5KhX+1ErSV1VAMbtt+ysiIxiLzaV5b9UhnzwdujkRui
	nSRWxVpU9tVfcETbZmVJM16dkNllPWiupi3gt3UBvY9m37m6O0UA15wiHlay8jm4x/1A2hYgSRi
	kgomD9+S9eQaqDj8j/O0tuvEjL7S+QvnEQAwfCtQPf5nALBZ25UWDmS+SSPmFx28VRw==
X-Gm-Gg: AeBDies4Wu3Sw7vYZeMZnrxwrjoCzqC7UXqFxxI34LTiw/aoimwxw+EU11UA1314gME
	8Dg0IT0d7FCdKLj+qvU+UuJXBMfGfKFGUm0BIQKjzfvq2FvLgsMcpE1cy6Fc0m/+uIJSG9Q0OnW
	StjjGYXA+JyHenelNZjg8o3T6WiY1MEen6y7x0KSyVAn2mgBZZEwnDsdjL/wvCJwdo2ca4VtQn/
	sefayRSB1kwWYtTW7FWICu1b9BYpS55pKKaDcOeeuqdjHsAKib6VihhbDe3rRDtzI1AVHtXslBY
	KAsmOI4zKS1P5eOJ2YTaCZjDEEdZ9MkimwOmEJ0jnctQXH7TNZpn69WRClUyiW4QI4HP/6UlQlV
	2OUG98R5scgq4F9sTajLyQDgFHNVXmkHYaroQAAaDgNsxtfHPiKpwkW98p2ms3J39RqYaoZZjcm
	Eh/NxxLA==
X-Received: by 2002:a05:600c:890e:b0:488:bd79:94d8 with SMTP id 5b1f17b1804b1-488d684331emr195084355e9.18.1776249492704;
        Wed, 15 Apr 2026 03:38:12 -0700 (PDT)
X-Received: by 2002:a05:600c:890e:b0:488:bd79:94d8 with SMTP id 5b1f17b1804b1-488d684331emr195083925e9.18.1776249492197;
        Wed, 15 Apr 2026 03:38:12 -0700 (PDT)
Received: from sgarzare-redhat (host-87-16-204-83.retail.telecomitalia.it. [87.16.204.83])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488f0ec6cc6sm17072045e9.29.2026.04.15.03.38.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Apr 2026 03:38:11 -0700 (PDT)
Date: Wed, 15 Apr 2026 12:38:04 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Dexuan Cui <decui@microsoft.com>
Cc: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org, 
	longli@microsoft.com, davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, horms@kernel.org, niuxuewei.nxw@antgroup.com, 
	linux-hyperv@vger.kernel.org, virtualization@lists.linux.dev, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org, Ben Hillis <Ben.Hillis@microsoft.com>, 
	Mitchell Levy <levymitchell0@gmail.com>
Subject: Re: [PATCH net] hv_sock: Report EOF instead of -EIO for FIN
Message-ID: <ad9pPrji1uYSgNir@sgarzare-redhat>
References: <20260414234316.711578-1-decui@microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20260414234316.711578-1-decui@microsoft.com>
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-10180-lists,linux-hyperv=lfdr.de];
	FREEMAIL_CC(0.00)[microsoft.com,kernel.org,davemloft.net,google.com,redhat.com,antgroup.com,vger.kernel.org,lists.linux.dev,gmail.com];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	DKIM_TRACE(0.00)[redhat.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sgarzare@redhat.com,linux-hyperv@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-hyperv];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: A9CB540354C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Apr 14, 2026 at 04:43:16PM -0700, Dexuan Cui wrote:
>Commit f0c5827d07cb unluckily causes a regression for the FIN packet,
>and the final read syscall gets an error rather than 0.
>
>Ideally, we would want to fix hvs_channel_readable_payload() so that it
>could return 0 in the FIN scenario, but it's not good for the hv_sock
>driver to use the VMBus ringbuffer's cached priv_read_index, which is
>internal data in the VMBus driver.
>
>Fix the regression in hv_sock by returning 0 rather than -EIO.
>
>Fixes: f0c5827d07cb ("hv_sock: Return the readable bytes in hvs_stream_has_data()")
>Cc: stable@vger.kernel.org
>Reported-by: Ben Hillis <Ben.Hillis@microsoft.com>
>Reported-by: Mitchell Levy <levymitchell0@gmail.com>
>Signed-off-by: Dexuan Cui <decui@microsoft.com>
>---
> net/vmw_vsock/hyperv_transport.c | 18 ++++++++++++++++--
> 1 file changed, 16 insertions(+), 2 deletions(-)
>
>diff --git a/net/vmw_vsock/hyperv_transport.c b/net/vmw_vsock/hyperv_transport.c
>index 069386a74557..63d3549125be 100644
>--- a/net/vmw_vsock/hyperv_transport.c
>+++ b/net/vmw_vsock/hyperv_transport.c
>@@ -703,8 +703,22 @@ static s64 hvs_stream_has_data(struct vsock_sock *vsk)
> 	switch (hvs_channel_readable_payload(hvs->chan)) {
> 	case 1:
> 		need_refill = !hvs->recv_desc;
>-		if (!need_refill)
>-			return -EIO;
>+		if (!need_refill) {

Can we drop `need_refill` entirly and just check `hvs->recv_desc` here?

Mainly because now the comment we are adding is confusing me about what 
`need_refill` means.

The rest LGTM.

Thanks,
Stefano

>+			/* Here hvs->recv_data_len is 0, so hvs->recv_desc must
>+			 * be NULL unless it points to the 0-byte-payload FIN
>+			 * packet: see hvs_update_recv_data().
>+			 *
>+			 * Here all the payload has been dequeued, but
>+			 * hvs_channel_readable_payload() still returns 1,
>+			 * because the VMBus ringbuffer's read_index is not
>+			 * updated for the FIN packet: hvs_stream_dequeue() ->
>+			 * hv_pkt_iter_next() updates the cached priv_read_index
>+			 * but has no opportunity to update the read_index in
>+			 * hv_pkt_iter_close() as hvs_stream_has_data() returns
>+			 * 0 for the FIN packet, so it won't get dequeued.
>+			 */
>+			return 0;
>+		}
>
> 		hvs->recv_desc = hv_pkt_iter_first(hvs->chan);
> 		if (!hvs->recv_desc)
>-- 
>2.49.0
>
>


