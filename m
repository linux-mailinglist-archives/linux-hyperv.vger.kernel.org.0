Return-Path: <linux-hyperv+bounces-7713-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id A6B4BC73A5D
	for <lists+linux-hyperv@lfdr.de>; Thu, 20 Nov 2025 12:12:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id E8E6D348AD4
	for <lists+linux-hyperv@lfdr.de>; Thu, 20 Nov 2025 11:11:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 900F932FA01;
	Thu, 20 Nov 2025 11:11:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="g1P4utE2";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="CScb18ra"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56D9D32FA09
	for <linux-hyperv@vger.kernel.org>; Thu, 20 Nov 2025 11:11:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763637090; cv=none; b=B1+zA446ZK36z5EgbRIfnoZORM/pbwCi8iYclGRismf1YKQ8DLn6Sl+ukFb8/9mMAbFgY7nQ5Dk8Dz97RKzh6oFwuJM6UDtlC9VUYr3a4zd7Z16qE19+U8EKdTkInjo5+1noyj+/Acy8v8YMFQeE+BWPg8nllfvAlGIjyWzw7tg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763637090; c=relaxed/simple;
	bh=4w94fCVl14EEV0Zihb71NNS/ooZ/eDdAuYJP2GMD/70=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HOaUMuSa15dlHK29g+DWP65I0/oT4zmd7ILjaDJyaNxY4+x4obkxvCA7gnOadsT6hZJ1oViOr/RbM72DkZM/GY9amdLDz3n+1jORpcOuhgUA+dzLUFIZAaqGZRxuRYjHrtuiiGbvlSe0AwsA1/a1QHmifJxqozUKyFeQR5io7a8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=g1P4utE2; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=CScb18ra; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1763637087;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VMS34UwrZ8S2nle8FVRzl8w579va+uy0VBnhRljJShQ=;
	b=g1P4utE2Rf4IQKEV5SF5hNdWAKgNWyzhPnzE4VXdIM6aBq+mfZp+S7CFGBGJwIJG29EhfV
	GpaHq/QaO6yHGyLOqScXcUymNCbreKijl+09MiFBUm4WakSrXkLq1tGTN/3djwxbNlCHlc
	h66V0MVO1fODIASU9jM1ju6vraogEm4=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-36-tL0d5hUoNSe098qO7-zKJQ-1; Thu, 20 Nov 2025 06:11:25 -0500
X-MC-Unique: tL0d5hUoNSe098qO7-zKJQ-1
X-Mimecast-MFC-AGG-ID: tL0d5hUoNSe098qO7-zKJQ_1763637085
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-4775e00b16fso5140455e9.2
        for <linux-hyperv@vger.kernel.org>; Thu, 20 Nov 2025 03:11:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1763637084; x=1764241884; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VMS34UwrZ8S2nle8FVRzl8w579va+uy0VBnhRljJShQ=;
        b=CScb18raWHf2CQJLRDUi+l8B51BmVrX63VFmtLeUAtYlhRak/R/TCDgO+VJp69KXqo
         Y+itwfjb52IW8k7ojUeCy0Aj8yU0lSf7S7RVZ/joHObbAWxw1HRG/5tLAzOzVH1Uf5UD
         484OCGFvuf8vrABUtbgzrk0y7DLCNZX+oRgsukkc3N2OW2TfrbvRYJcnym7ycGwTOcgr
         W5SPH8Q0eHi1RMl3Zt9stGiFjnP2V03ZcFycwGt8GYTPuEU6U4SzlhOx/mbKOpm0z0Lo
         FyALlrXpRTFN7PdDP33mq3Z4p3bWNaDp1ZQD+PYmFGuhoiG1ZjiqfHiRzC+L2ED/ZVgh
         sKug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763637084; x=1764241884;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VMS34UwrZ8S2nle8FVRzl8w579va+uy0VBnhRljJShQ=;
        b=Pl8avo7hhXDXH/gR30J3QHRMKfmeYujyVTYBBd/SqSx+NJRUCMojxtqSmBl8RLq8oR
         WOvRpzwmnJIGdgwu9ZlwaatDQHAUtC2FhegnJ5+mNdeqD7LPcquUdUJV0O/1zLlB+IJM
         6xdt781rxXTqh8oVgKUIvWEcuO5rIxs3Ax3XD6a+rwf7EQl0VaDFqhx/Sgnztu4+3duH
         jyZ1g9SoVJHOZuKq+EkmNRMCnss9Z9y8PMpQKOxHoTWrMycMIWKAx3RHMMiRQ2an+OPX
         LbG+jGgKMSBf4obGQNCZfnx3Ez8bjooiiTahW4Gpuo97XDVr6mF76lJ8bM/Zp2T1QDrZ
         1bqw==
X-Forwarded-Encrypted: i=1; AJvYcCWRIT1TeTp60uB7oeV49itFauB6+8uQkr6HhtPp1aysGCWggbiWEVRKw399gTQ9AfjizmBs9peMRA98ZnA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1SvnbQwb+WqKspmpIx70cETMuMWJGd+ynLVOEr65xPrlJfRrh
	8AagFetBNDOAgNHksX+18eNkkX4n5Y7p5l7j0QXOHvBdIiq2DnAh442SDA6skoOsUXkVVxFJKWz
	2MaTEj6hQqbWEpq/uhe4SFj3AaUOkisw4IVBtdGSRe20cyCDMAGC5HloEb+MPHFnkqQ==
X-Gm-Gg: ASbGncs1c/q1IHdonStG89oK9RPpV4Ny5lc9/k3Q3INjFup2bDwD//u9hoOi5YHQzuK
	/6qe1cyFYTNaSoSdGY3nn8zOhtNu75bIWlp5anbFudZtVdWnwxqFXdJJfh42oS8VNE5zybcDVpP
	E/kvdyjsNskFE1vZq7/ydD+t9nuqtemQW/0fm/6iubmQMd5zgdkOa11RshDxHKm/WZjq9kxwUi+
	RXiVjkdhIAmCApgVFZzIY1ZVuHpjPsABN6yPCeAS28zwbYtLixNOq9BXGYNLDEKValWSnMQ5/t4
	9MaKEM0cNMM8WCL7EctQG18O+NJ5HpPCagAAljkqkwlX9I3ByOfks/1th/imoZGsW7wQnUFpPg7
	SgGZn0F7fra+b
X-Received: by 2002:a05:600c:21d6:b0:470:fe3c:a3b7 with SMTP id 5b1f17b1804b1-477b9ea4d28mr16744175e9.5.1763637084529;
        Thu, 20 Nov 2025 03:11:24 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE/fUTeDI0WH8NPmq3GHHJh/IHPYx2tPHiKQdM9TuqaRUB2LyRCR8etaEIrIUjerN5jw8l6jg==
X-Received: by 2002:a05:600c:21d6:b0:470:fe3c:a3b7 with SMTP id 5b1f17b1804b1-477b9ea4d28mr16743945e9.5.1763637084152;
        Thu, 20 Nov 2025 03:11:24 -0800 (PST)
Received: from [192.168.88.32] ([212.105.155.41])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-477a9ddef38sm63385435e9.3.2025.11.20.03.11.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Nov 2025 03:11:23 -0800 (PST)
Message-ID: <7d835eb1-f111-46e5-8834-a1fafb53bd8f@redhat.com>
Date: Thu, 20 Nov 2025 12:11:21 +0100
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Patch net-next v2] net: mana: Handle hardware recovery events
 when probing the device
To: longli@linux.microsoft.com, "K. Y. Srinivasan" <kys@microsoft.com>,
 Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>,
 Dexuan Cui <decui@microsoft.com>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Shradha Gupta <shradhagupta@linux.microsoft.com>,
 Simon Horman <horms@kernel.org>, Konstantin Taranov
 <kotaranov@microsoft.com>,
 Souradeep Chakrabarti <schakrabarti@linux.microsoft.com>,
 Erick Archer <erick.archer@outlook.com>, linux-hyperv@vger.kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-rdma@vger.kernel.org
Cc: Long Li <longli@microsoft.com>
References: <1763430724-24719-1-git-send-email-longli@linux.microsoft.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <1763430724-24719-1-git-send-email-longli@linux.microsoft.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/18/25 2:52 AM, longli@linux.microsoft.com wrote:
> From: Long Li <longli@microsoft.com>
> 
> When MANA is being probed, it's possible that hardware is in recovery
> mode and the device may get GDMA_EQE_HWC_RESET_REQUEST over HWC in the
> middle of the probe. Detect such condition and go through the recovery
> service procedure.
> 
> Fixes: fbe346ce9d62 ("net: mana: Handle Reset Request from MANA NIC")
> Signed-off-by: Long Li <longli@microsoft.com>

Does not apply cleanly anymore due to commit
934fa943b53795339486cc0026b3ab7ad39dc600, please rebase and repost.

> +static void mana_recovery_delayed_func(struct work_struct *w)
> +{
> +	struct mana_dev_recovery_work *work;
> +	struct mana_dev_recovery *dev, *tmp;
> +	unsigned long flags;
> +
> +	work = container_of(w, struct mana_dev_recovery_work, work.work);
> +
> +	spin_lock_irqsave(&work->lock, flags);
> +
> +	list_for_each_entry_safe(dev, tmp, &work->dev_list, list) {
> +		list_del(&dev->list);

Minor nit: here and in similar code below I find sligly more readable
something alike:

	while (!list_empty(&work->dev_list)) {
		dev = list_first_entry(&work->dev_list);
		list_del(dev);
		//...

as it's more clear that releasing the lock will not causes races, but no
strong opinion against the current style.

/P

/P


