Return-Path: <linux-hyperv+bounces-5667-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 51AF2AC4B8C
	for <lists+linux-hyperv@lfdr.de>; Tue, 27 May 2025 11:29:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E91753BD3D7
	for <lists+linux-hyperv@lfdr.de>; Tue, 27 May 2025 09:28:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14199253F23;
	Tue, 27 May 2025 09:29:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="T09SUzSy"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A05C253B4C
	for <linux-hyperv@vger.kernel.org>; Tue, 27 May 2025 09:28:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748338142; cv=none; b=nS3G4uOxa3x6oFaWb28R4eCo7aE9c1fyNI6Wn57NmhpLx5e5PLBQ8+CiguwdkTZF6e5JbO2TGAmIFUVr+TNpqML5fFiXsCudHUhrPhYUwe7fYGFC9JbcxQHWBmz8nLS1QUwV9o3/suqJc1X0B0z+gCWKMLmZU6qrWYwpWLld52I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748338142; c=relaxed/simple;
	bh=jYEhg75W17+LrrRp5ozft0smLaCDvCUlIDdgZkc8Maw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CUDQhpXg7btu8vqNGwA+mxmp4ySZ33O9/hsr/c/t1woWoGIYjDz6wV7lSXLaxfkWYT9nleaSQRVcJpoGh5v7n0bJFVaSDb6uSMGbTYcm9/+hvnzKynjDrQ5vAVoR8MjemE9xc6Jg/bIJcnJHieQFKEN4RFMlXX/Mvua4y82/sBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=T09SUzSy; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1748338138;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=d2VX9MfL1HCTriT+S3B9Z1XwLwg3XDZQ+O6lDXv3bE4=;
	b=T09SUzSy2NC7IgyCNSVLSnyMEgMWIuWhcB5+wygbep231lGB+GPBn8In9BcS+QTeuJwUU7
	esa+ZfZF5cYi5FYouLJbx6KqUjBEgbCHxQ7wT6+b9wad/nQggEIBL+QH25lASCCpFrz0vu
	2RZkEq1EmRSz9r4BrqWTiuOPUc499BI=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-70-nFAvT57jNlurBv5OhuZrfQ-1; Tue, 27 May 2025 05:28:54 -0400
X-MC-Unique: nFAvT57jNlurBv5OhuZrfQ-1
X-Mimecast-MFC-AGG-ID: nFAvT57jNlurBv5OhuZrfQ_1748338133
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-43ceeaf1524so14282805e9.1
        for <linux-hyperv@vger.kernel.org>; Tue, 27 May 2025 02:28:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748338133; x=1748942933;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=d2VX9MfL1HCTriT+S3B9Z1XwLwg3XDZQ+O6lDXv3bE4=;
        b=kOYXh+pRTZ3C7LQ2081lZhU0Wqs8CCFPaw1Ni+1CvafqWRseCYr3X2L211KmInuFpP
         acwmtX67717Usf4+h/eb9HuQS7g1cpyWqGBtfwteQ/NimClof4fPhyBAgbkwWm9/Ap2K
         cmzMZ8/7gw3UORg5IeG06uCoO4rNjR5cr5CnYbcioZ+tGJtzrbVNjDymXnYKZqcSj1P8
         IS0mlscdb4oqhJKcuyVWPb8OL4vydW9oQIFPno4XDVeDnShYknHD5bGn9CSDAmoSBSFb
         7ePpRy87IWxwmk9VIsUiVtpwxrPElLGsgJygehEUn0PpoxstvBOtkqpdjIgJyVDmwdgQ
         lI8Q==
X-Forwarded-Encrypted: i=1; AJvYcCXp/WeXXLWR2Bi/nFek05GAud5/FUJ/hFOI34DxQxPVW8s/OuhF98GIF+kKJKbRZZGMe6pp4lKILDQ8R2A=@vger.kernel.org
X-Gm-Message-State: AOJu0YyIXvc0jBX8Lt0WdSqvLNFaNUPUtP8LMJFSfr1xY6xhJ+2Xaqtj
	FxuBm24/6rJjNCvTJERDsJg9Oq/EiaAf8O440pwM7uJ4exzDdQsyicq5iYFyv+NdRXiZv7AX9qQ
	irdWVLmnnTzVvRYN+pwVS9P29YV3Q341gm9jOsGIc1y9+r8FINqrOwSrCPUGONLFMYA==
X-Gm-Gg: ASbGncucyMY308vygWzVVbkN6+24xaxbfIUAD3HDs8TgwKtOMVRWWpHoXiyj9VwLGWb
	4yw/Q01Sy3A6XebNJThzYCU8AWIhOwfUgw3RjK5XF+qogRbQPrn8qCEqB4j/Es3ZHzpR9GIyb8X
	+XM24JXC7NGuu7CZPf5vP2Vtogqoxd8ICwYNHzeleUlOqOwplK4v0ruaJGDWI0LfbL2XqgLcWXP
	U4+hVrC0Uf8kxk8eyGWZYu4FvEolF4meKPfkjumalXUfdfpq+nfBpOc+XB/Jvz6Ee3GxraYZqrg
	8ag7JCMw1l/UHSqs924=
X-Received: by 2002:a05:600c:1d0a:b0:43d:186d:a4bf with SMTP id 5b1f17b1804b1-44c77bf3aa2mr98283875e9.0.1748338133532;
        Tue, 27 May 2025 02:28:53 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFW/XvOutq354S3u3kVQy6maNZpndfNYmmZuqtvnQwyMkFCqY+qleAw2OpAQBAisEp90oBu4Q==
X-Received: by 2002:a05:600c:1d0a:b0:43d:186d:a4bf with SMTP id 5b1f17b1804b1-44c77bf3aa2mr98283485e9.0.1748338133127;
        Tue, 27 May 2025 02:28:53 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:2728:e810::f39? ([2a0d:3344:2728:e810::f39])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a4e4c4739csm290454f8f.0.2025.05.27.02.28.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 May 2025 02:28:52 -0700 (PDT)
Message-ID: <ea6b8065-76e4-45c8-a51f-858abab4d639@redhat.com>
Date: Tue, 27 May 2025 11:28:50 +0200
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next,v5] net: mana: Add handler for hardware servicing
 events
To: Haiyang Zhang <haiyangz@microsoft.com>, linux-hyperv@vger.kernel.org,
 netdev@vger.kernel.org
Cc: decui@microsoft.com, stephen@networkplumber.org, kys@microsoft.com,
 paulros@microsoft.com, olaf@aepfle.de, vkuznets@redhat.com,
 davem@davemloft.net, wei.liu@kernel.org, edumazet@google.com,
 kuba@kernel.org, leon@kernel.org, longli@microsoft.com,
 ssengar@linux.microsoft.com, linux-rdma@vger.kernel.org,
 daniel@iogearbox.net, john.fastabend@gmail.com, bpf@vger.kernel.org,
 ast@kernel.org, hawk@kernel.org, tglx@linutronix.de,
 shradhagupta@linux.microsoft.com, andrew+netdev@lunn.ch,
 kotaranov@microsoft.com, horms@kernel.org, linux-kernel@vger.kernel.org
References: <1747873343-3118-1-git-send-email-haiyangz@microsoft.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <1747873343-3118-1-git-send-email-haiyangz@microsoft.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/22/25 2:22 AM, Haiyang Zhang wrote:
> @@ -400,6 +448,33 @@ static void mana_gd_process_eqe(struct gdma_queue *eq)
>  		eq->eq.callback(eq->eq.context, eq, &event);
>  		break;
>  
> +	case GDMA_EQE_HWC_FPGA_RECONFIG:
> +		dev_info(gc->dev, "Recv MANA service type:%d\n", type);
> +
> +		if (gc->in_service) {
> +			dev_info(gc->dev, "Already in service\n");
> +			break;
> +		}
> +
> +		if (!try_module_get(THIS_MODULE)) {
> +			dev_info(gc->dev, "Module is unloading\n");
> +			break;
> +		}
> +
> +		mns_wk = kzalloc(sizeof(*mns_wk), GFP_ATOMIC);
> +		if (!mns_wk) {
> +			module_put(THIS_MODULE);
> +			break;
> +		}
> +
> +		dev_info(gc->dev, "Start MANA service type:%d\n", type);
> +		gc->in_service = true;
> +		mns_wk->pdev = to_pci_dev(gc->dev);
> +		pci_dev_get(mns_wk->pdev);

Acquiring both the device and the module reference is confusing and
likely unnecessary. pci_dev_get() should suffice.

/P


