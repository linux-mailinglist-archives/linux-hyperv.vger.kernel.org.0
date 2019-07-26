Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4EA7376E7E
	for <lists+linux-hyperv@lfdr.de>; Fri, 26 Jul 2019 18:06:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727164AbfGZQGP (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 26 Jul 2019 12:06:15 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:33510 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726138AbfGZQGP (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 26 Jul 2019 12:06:15 -0400
Received: by mail-pl1-f195.google.com with SMTP id c14so24868207plo.0
        for <linux-hyperv@vger.kernel.org>; Fri, 26 Jul 2019 09:06:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=HHON1nH6ApNYulEeI4MQrYQT7JZ4z53kVY1K132PFRs=;
        b=Qiwh1Jd1kb/5Vlo9Rc8U7P/Tq79cqEo6XipidsPbuYcLD0EH+gnQicBMdS75tfBWF0
         1tqzCB/vtph8QuGQv2VVHVbw+210vfXgXrI8RBKsSIK4P7eiU3s74k2Evg0vhn1NNYBG
         pbpKOLPc8yLdL52jRN5bfhIrAQAyJCcvhrg7dCbxIEuuQXeRhfMu/XvNEaGxcJQq6r2F
         VP4txtBb+MchTGX/0hk+U/HhkTGJWc4IHBJTv47k/YX7Y3jSHT6wpZL4fRJZjd302bKC
         zp2oSegrl5WsGMXndRDO3SIf/q2G3HV0+Y1hOcjNInPY541c9XgApE+MUBYCAjmg5JHN
         b4ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HHON1nH6ApNYulEeI4MQrYQT7JZ4z53kVY1K132PFRs=;
        b=Cp04m+7PZwM/BXT/twV9+YSN/psN1yswCZX0d6e29ixmgoZyy0iWgdVAI88ECkpxaX
         JIqrCOFhl2AutLLdnc/7lTE52l0AloQLRMN7cNd3FlTHFLr/XwWC84KmD5TmlnxcNJ7A
         YF1Ls7upW3zqqKbrUHyTmBZ29KrHLrfioNPpVKxAD2AvzVaJ0hGffVNzMnNQQLNvIdTM
         w0iIX/hlflQEcmHpYKdQMKBaXXInSe1PQKzvb6XTAq6s4fkviKNlxhCJoWtwasVxjrn2
         0pIKoLtveKcOEcRR4Bx1s44zjlePg3OeEENQZd8h8UE+Ur2af1ufWz5EyaPYJF3+vLwG
         ziyg==
X-Gm-Message-State: APjAAAXaKCmO5N4J2QklEvMcFsWpeN5F9X4w5q8BEvB84+snkW/fIHiP
        fsYjSB1/ZuXCKT1cZoU7M3o=
X-Google-Smtp-Source: APXvYqyJ/5zjLMX4clx7iTtWzW9coVoBjAfvFt4UQ4cDn/fxmOcd1CN2LbdbGe9iLph9ntk8Gt0F/g==
X-Received: by 2002:a17:902:7d8b:: with SMTP id a11mr43603616plm.306.1564157174117;
        Fri, 26 Jul 2019 09:06:14 -0700 (PDT)
Received: from hermes.lan (204-195-22-127.wavecable.com. [204.195.22.127])
        by smtp.gmail.com with ESMTPSA id i124sm101011798pfe.61.2019.07.26.09.06.13
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 26 Jul 2019 09:06:14 -0700 (PDT)
Date:   Fri, 26 Jul 2019 09:06:05 -0700
From:   Stephen Hemminger <stephen@networkplumber.org>
To:     "Himadri Pandya" <himadrispandya@gmail.com>
Cc:     "Michael Kelley" <Michael.H.Kelley@microsoft.com>,
        "KY Srinivasan" <kys@messages.microsoft.com>,
        "Haiyang Zhang" <haiyangz@microsoft.com>,
        "Stephen Hemminger" <sthemmin@microsoft.com>, <sashal@kernel.org>,
        <linux-hyperv@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        "himadri18.07" <himadri18.07@gmail.com>
Subject: Re: [PATCH 2/2] Drivers: hv: util: Specify ring buffer size using
 Hyper-V page size
Message-ID: <20190726090605.5026de8c@hermes.lan>
In-Reply-To: <20190725050315.6935-3-himadri18.07@gmail.com>
References: <20190725050315.6935-1-himadri18.07@gmail.com>
        <20190725050315.6935-3-himadri18.07@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Wed, 24 Jul 2019 22:03:15 -0700
"Himadri Pandya" <himadrispandya@gmail.com> wrote:

> VMbus ring buffers are sized based on the 4K page size used by
> Hyper-V. The Linux guest page size may not be 4K on all architectures
> so use the Hyper-V page size to specify the ring buffer size.
> 
> Signed-off-by: Himadri Pandya <himadri18.07@gmail.com>
> ---
>  drivers/hv/hv_util.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/hv/hv_util.c b/drivers/hv/hv_util.c
> index c2c08f26bd5f..766bd8457346 100644
> --- a/drivers/hv/hv_util.c
> +++ b/drivers/hv/hv_util.c
> @@ -413,8 +413,9 @@ static int util_probe(struct hv_device *dev,
>  
>  	hv_set_drvdata(dev, srv);
>  
> -	ret = vmbus_open(dev->channel, 4 * PAGE_SIZE, 4 * PAGE_SIZE, NULL,
> 0,
> -			srv->util_cb, dev->channel);
> +	ret = vmbus_open(dev->channel, 4 * HV_HYP_PAGE_SIZE,
> +			 4 * HV_HYP_PAGE_SIZE, NULL, 0, srv->util_cb,
> +			 dev->channel);
>  	if (ret)
>  		goto error;
>  

hv_util doesn't need lots of buffering. Why not define a fixed
value across all architectures. Maybe with some roundup to HV_HYP_PAGE_SIZE.
