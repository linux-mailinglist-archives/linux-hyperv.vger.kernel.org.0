Return-Path: <linux-hyperv+bounces-9855-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cMu4BiGVy2nMJAYAu9opvQ
	(envelope-from <linux-hyperv+bounces-9855-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Tue, 31 Mar 2026 11:34:25 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F09F36723C
	for <lists+linux-hyperv@lfdr.de>; Tue, 31 Mar 2026 11:34:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1F6FE30C3331
	for <lists+linux-hyperv@lfdr.de>; Tue, 31 Mar 2026 09:28:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7A163ECBD6;
	Tue, 31 Mar 2026 09:28:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="P9UpGq27";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="N5eC38D3"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C7463ED132
	for <linux-hyperv@vger.kernel.org>; Tue, 31 Mar 2026 09:28:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774949318; cv=none; b=FArsfrb6DVbA92W7A4iwGF3YQy8jb8tNIowS8BnN80ImYOooefcPnvxg2Snc5kJVaLO4L1PrOTCbywIVLIbimBg1d1vtqaDJJ3fOxinhVZGKxQLhtQT8yYu+zjvHFuTDpVC47Ebth65McnNZzi5IvhIsRrMzk0fGUVUoeVa/Ogc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774949318; c=relaxed/simple;
	bh=NBrawPDPzTZMShXyjuHEmK45v2SuMkUgHKMBfO43mGw=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=cIOI8xte5oYGvgB0VbKSchHwpZbCMe4QXBoWRetXAx/VKwRF+L1CSEJ/KAbfFntbvGciDLZwY+2WOICd50BhIzB1aU3lLeBIjO0xUEVcrJEGJ5JpBRW7A8IpQbMJR7DffmqGk5a94hagyI0YGas1quOX7rIHudY07DGXaXQEYng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=P9UpGq27; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=N5eC38D3; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1774949316;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hE/wELyunyzB08vE4KhsobAhK0D+1FSIRk8/BrdctfY=;
	b=P9UpGq27sLAOkpuirsTz1DhtmtatbDACNlGk/cQ0fNQozgDdFNnxkaqOrTndqHXaVVnrG/
	RBNXm1jwuNYw4jXGB+WytsVU2acX1dX21laZmSERJGZPzAbmBIXGFeY0YXmjVsW9N0auik
	UXvBYgA0PG+tOAxJikNJOm8w4VIkscE=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-456-ZDZNaMlgM2eBwpTh2rh5aQ-1; Tue, 31 Mar 2026 05:28:34 -0400
X-MC-Unique: ZDZNaMlgM2eBwpTh2rh5aQ-1
X-Mimecast-MFC-AGG-ID: ZDZNaMlgM2eBwpTh2rh5aQ_1774949313
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-4887e4b338bso3383175e9.1
        for <linux-hyperv@vger.kernel.org>; Tue, 31 Mar 2026 02:28:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1774949313; x=1775554113; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=hE/wELyunyzB08vE4KhsobAhK0D+1FSIRk8/BrdctfY=;
        b=N5eC38D3VSqiSaDDKcypzkI+9lJii27dNI57bI5KAGArrw8CfL+atLf7RYe1BG5KWm
         5q6s3/F3uyHG02aTHrUefzk7aIFub07IJjTZFoR+TgxWrFynfkWGRsS0X5W2lkeqWjFE
         Gx31ycNIZ+N+BCLCvJK/7IzsjuUqjeB6mqAgKleYVViGdyEVpsKrsPrdI2vgNZjyRCMW
         xry8664sQwvFTy/q66ZIRYfhxmgv6Vv9aPIy7O52+2bNso80UoU6VUub3c+KOontEXik
         kp0yV0z4St18a18S/JRFK8ZW9qdtx3LtLQl1FBXbbYeuDkDQt9RgxewqV9RThNZb0Tjw
         9Bjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774949313; x=1775554113;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hE/wELyunyzB08vE4KhsobAhK0D+1FSIRk8/BrdctfY=;
        b=qIs7nAspmWs6ana5HL5494NI39YUvdAGaeXpEmWtf1WLMCO8DvEo+t3qxQpss1yFU/
         UMn3u24m9YX0Jk2EIe7AzFVXpJRltHtZGKTJ1NTd6xAaFZyf/XiuOPnJ0mRRxSrPljoc
         FDhhoOIRRNco4u/iZHmGLHUVGqSq2SkcK8dJY3dgSna6m7xeqd3INTwIPqV/s0zDS0xa
         nfFbsirQjf5uU/iHNuBdzIZZuTWtO64Iw5kQhXa7q+MSRVdkZVFOEfpbn53TNOWnmkMD
         pmGr+8s9lu8712YchRnloHLuBRkf1FPvNTiSW8Mrc9304nPyTNAaaxOuzEZKndKK6ngl
         OrCQ==
X-Forwarded-Encrypted: i=1; AJvYcCUw+VLkLhSefBMGnjBHFG1JeiK1GmoVZa/1UO2tXT6Yv3czYhBabZEnNTdfJCTxYTVGR1mJ8Y02Tvn8wbE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz3KDHBlacEiDPbr3hG+2xAcHMSb1OMDaXBuHa6ZodAtdJGWQdA
	SXcGyYHz8utl55awMMTsasO72egkSqm3azyRFxOtsDEYry5ciDab17RmSAZ0gu5FNvnl0s0GebQ
	UOqt5OG646+jjtjaj5Y19/eJ7sNLlD/pEkEvLhwjcLUqX7CSFTGoRY/gtA8wUTH8TgQ==
X-Gm-Gg: ATEYQzxomSEJ1X6kDmBSJppG+PogIgxzqNoQhiGcdh2yDg1ayIVGkSaHoBQ+TRcSlMJ
	H6lH1OITKIow+wgTWNoPVcvkxNARWJUyeZh4PlsssCWGHtfTzrlbtSBy3oMgHpshFXYz23S4r0L
	UgdqcYtc3o/Ri9C9pm1U6o5Tv1j2lfLVFp60xT80qCnQlbq3oAw7TJ3p+qRQM6qQqJ4A5b/mD0W
	/ubCQdm20KbIYw70wm+r76RtC1+wxCt78jasNKEiApcaqiBpgdFsDfisQR/T6kMUMbSmi5tXb+n
	m3zCi3BiNF7jf7vdoAIjSwCwSnOW34sj4iuV0d7mJQvgJvOZ62hgqsf07liRNxnjYU8O5NstrAY
	dkjft0EIpcxuYosLrRkJc1UwF8rrDAjWTGVArBlY80XjUcDUGKpV790/I
X-Received: by 2002:a05:600c:1986:b0:486:faa8:9e4 with SMTP id 5b1f17b1804b1-488783a6913mr42729845e9.12.1774949313115;
        Tue, 31 Mar 2026 02:28:33 -0700 (PDT)
X-Received: by 2002:a05:600c:1986:b0:486:faa8:9e4 with SMTP id 5b1f17b1804b1-488783a6913mr42729325e9.12.1774949312589;
        Tue, 31 Mar 2026 02:28:32 -0700 (PDT)
Received: from [192.168.88.32] ([212.105.155.58])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4887c77df84sm17291665e9.4.2026.03.31.02.28.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 31 Mar 2026 02:28:32 -0700 (PDT)
Message-ID: <4ceecee2-ea5a-4026-ad38-66c0a7d263cd@redhat.com>
Date: Tue, 31 Mar 2026 11:28:30 +0200
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] net: mana: hardening: Validate adapter_mtu from
 MANA_QUERY_DEV_CONFIG
To: Erni Sri Satya Vennela <ernis@linux.microsoft.com>, kys@microsoft.com,
 haiyangz@microsoft.com, wei.liu@kernel.org, decui@microsoft.com,
 longli@microsoft.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, ssengar@linux.microsoft.com,
 dipayanroy@linux.microsoft.com, gargaditya@linux.microsoft.com,
 shirazsaleem@microsoft.com, kees@kernel.org, linux-hyperv@vger.kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260326173101.2010514-1-ernis@linux.microsoft.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20260326173101.2010514-1-ernis@linux.microsoft.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[redhat.com:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9855-lists,linux-hyperv=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pabeni@redhat.com,linux-hyperv@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-hyperv,netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 6F09F36723C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



On 3/26/26 6:30 PM, Erni Sri Satya Vennela wrote:
> As a part of MANA hardening for CVM, validate the adapter_mtu value
> returned from the MANA_QUERY_DEV_CONFIG HWC command.
> 
> The adapter_mtu value is used to compute ndev->max_mtu via:
> gc->adapter_mtu - ETH_HLEN. If hardware returns a bogus adapter_mtu
> smaller than ETH_HLEN (e.g. 0), the unsigned subtraction wraps to a
> huge value, silently allowing oversized MTU settings.
> 
> Add a validation check to reject adapter_mtu values below
> ETH_MIN_MTU + ETH_HLEN, returning -EPROTO to fail the device
> configuration early with a clear error message.
> 
> Signed-off-by: Erni Sri Satya Vennela <ernis@linux.microsoft.com>
> ---
>  drivers/net/ethernet/microsoft/mana/mana_en.c | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/ethernet/microsoft/mana/mana_en.c b/drivers/net/ethernet/microsoft/mana/mana_en.c
> index b39e8b920791..bd07d17a6017 100644
> --- a/drivers/net/ethernet/microsoft/mana/mana_en.c
> +++ b/drivers/net/ethernet/microsoft/mana/mana_en.c
> @@ -1207,10 +1207,16 @@ static int mana_query_device_cfg(struct mana_context *ac, u32 proto_major_ver,
>  
>  	*max_num_vports = resp.max_num_vports;
>  
> -	if (resp.hdr.response.msg_version >= GDMA_MESSAGE_V2)
> +	if (resp.hdr.response.msg_version >= GDMA_MESSAGE_V2) {
> +		if (resp.adapter_mtu < ETH_MIN_MTU + ETH_HLEN) {
> +			dev_err(dev, "Adapter MTU too small: %u\n",
> +				resp.adapter_mtu);
> +			return -EPROTO;

AI review says:

If this returns -EPROTO, does the caller mana_probe() jump to an error
label and call mana_remove()?
If so, mana_remove() unconditionally calls
disable_work_sync(&ac->link_change_work) and
cancel_delayed_work_sync(&ac->gf_stats_work).
Since mana_query_device_cfg() is called before INIT_WORK() and
INIT_DELAYED_WORK() in the probe sequence, wouldn't this result in
calling sync cancellation functions on uninitialized, zeroed work
structures?
This can lead to a WARN_ON(!work->func) in __flush_work(), or debug
object warnings if CONFIG_DEBUG_OBJECTS_WORK is enabled.
While this initialization issue appears to already exist for other early
error paths, this new error path can also trigger it.


