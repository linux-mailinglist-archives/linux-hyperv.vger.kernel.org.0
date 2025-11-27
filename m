Return-Path: <linux-hyperv+bounces-7858-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DBC2EC8C86A
	for <lists+linux-hyperv@lfdr.de>; Thu, 27 Nov 2025 02:18:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8E7AF3B0B63
	for <lists+linux-hyperv@lfdr.de>; Thu, 27 Nov 2025 01:18:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69E122236E3;
	Thu, 27 Nov 2025 01:18:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="JMxRlQgq"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4313319D08F
	for <linux-hyperv@vger.kernel.org>; Thu, 27 Nov 2025 01:18:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764206301; cv=none; b=IeMvMjFB7/1lrOc8XbXUCF7QFY/L0Cxyc/RvlEO+xr6duPx7zbrhk5e6N+7B4xBJndaLlXt1qLyD6YySc9HtaEBjiDb7lOJyFDpOmubPhKdoLjjGUON55R4nsJZFWDu5GCVnhfmEyRI+FC4LkOUh/qMtQyCQr4zy649SVWiqs1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764206301; c=relaxed/simple;
	bh=GQVRD0kDLnRr8PlGCc+5Hnmo5Omwya0ZZMgiPEA57KI=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Iah7HOvV9xbAmyCjEZ4DwYNU2zKzKALaohNZQ1715n4zKz/MkVOywUEIyho6rfkCiOHkRnD7RmP6vQZD83K9ch5QpAvdKCsEvgjl8cOHwjvdmSb37blCP+eEGcugZgtAyjgbs8jFL0a9+MnjrA+EBTXeEbwIj9HxMf+Dp/ZlUmg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=JMxRlQgq; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-477a1c28778so2840495e9.3
        for <linux-hyperv@vger.kernel.org>; Wed, 26 Nov 2025 17:18:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1764206298; x=1764811098; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:date:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HKgOFooMWN6cAHuCEA8Jqj3i0BZ6TtQryqGYElbczIg=;
        b=JMxRlQgqJV81zARc+UmZ8Yx75jfyYOkeJj/362TMiAkwyKCfIpRWooE0QbExftrBnR
         n0kFaOP4QWjIP9jfTFiTg6NkGeqGWUUknZNkkbp+9CZel31jLfMgrTI93NqSCj2MbPnn
         SZ180e9rEn4C+M3cnexGEmWUES+B0xf223fHxCH6GuyS7ctvUBQuHv0RK99GQc+wBxZZ
         H1tHOkNFIDdWdcLrboTrnFHjD99uMicQlGDWnm7lB8qBTnNzWoZBRqAw8LNmHoqX5h1i
         4pxspkoaEDCqv9Y2zuoK2qDR4/5Yv2M/d4ha7GCPpYUPyHx9tf9SNnS4jRaxIgyw9SZp
         h08Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764206298; x=1764811098;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:date:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=HKgOFooMWN6cAHuCEA8Jqj3i0BZ6TtQryqGYElbczIg=;
        b=vAdWua71AA6Byor+nGIyxNqCJs2yhCccWARo8BQ97gaDfetvu15+vDqZoHTOvwUFrs
         o14EsSayrCXGl0QPfEaIztDR8OMnn5ytE8jDfAN1JcYr9GnJnWLH4LMVBGSiFPlIy0hu
         7ZRyBcYzFB2pdSPTfJMEpRHU1wDtJ5nvqOdi25/nSlLCkXpyQBbPNOqOpkY/4bGBmOjj
         CzenNOfWkQDO+pRU2sW0cJ3XRP/9PfWS3KAcl+oI4e0xgmWNMiQJCUFZpMePwOEzbO2i
         IplRgiExeN2PrxWK3N+Mqpf+6EBOvL4hsUULstjULTGEvGfi5wVD3YtruI/seUxOehEC
         7Y7g==
X-Forwarded-Encrypted: i=1; AJvYcCVIxzEf2NlJWOXPYkNwYg1Q19K8LV6kgt7ErhGMNdZ/KlbSVhvyqttd4/tVh50rHbbnYqBdLTLRszwAIDk=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywxqs5mgE++09eWMuGxbZhb39CXZhUmxA1EzawLMw2w7IP4GIWO
	vcux0SGAxbjE6VN8ylTt695LS1zW6+BrIEJxwKP5b4GY0u12FYUMqZppHtlpxVP3kZ0=
X-Gm-Gg: ASbGncuDuMqV4yW+0NvQxdlgzWJOfW4KGW3PVgB3ww7vHza91hyHVHdm30sg7/ARF1C
	w/YitTtF172VkzW0scP52W90wjgZsgaBR4ui8ytM55FYxaPvMHoK66Mj7LGBJzQOVWm0GQ0bize
	/rrfsgXeADHOR7hxUm0TbSV5ZYTVTiKDbfGiRmwBL4HBOq2DZA/dAXS/Kd9sAYTFLZuTMdk6kGR
	u8uudhOTjOGqjmMkAZczcpau5q2eaF7G0gnu7y0WJdUq7r74NUuUgKg8QqxG9k2Ycddxchb+02t
	8v4aOWzGDIOEKKFIkKKX771Rasw0mpZDmUnvWIF9GplLDdBuNQonGGLkamlV3nAiW6q9DQa64Bb
	RnJZPVKfYBMVzAwzCfBM0FksivPc4sVrIph2AgRkcWs+cIEXBmLnhYcBs6JDkhXiqh3XpDrDHlZ
	4jpRqwUHnwW1I47Gs13aKF497xXOPdmi/a
X-Google-Smtp-Source: AGHT+IHKRsRzIcI/YdpyjCx/e6RWPSP3syqAgwQHcfAEZoMWkqQomccWOuW4YSvp5SYEElJFnjRGrw==
X-Received: by 2002:a05:600c:19ce:b0:477:79c7:8994 with SMTP id 5b1f17b1804b1-47904b25e63mr87066215e9.30.1764206297510;
        Wed, 26 Nov 2025 17:18:17 -0800 (PST)
Received: from r1chard (1-169-246-18.dynamic-ip.hinet.net. [1.169.246.18])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29b5b1075ddsm207261215ad.3.2025.11.26.17.18.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Nov 2025 17:18:17 -0800 (PST)
From: Richard Lyu <richard.lyu@suse.com>
X-Google-Original-From: Richard Lyu <r1chard@r1chard>
Date: Thu, 27 Nov 2025 09:18:09 +0800
To: Thomas Zimmermann <tzimmermann@suse.de>, ardb@kernel.org,
	javierm@redhat.com, arnd@arndb.de, helgaas@kernel.org
Cc: x86@kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-efi@vger.kernel.org,
	loongarch@lists.linux.dev, linux-riscv@lists.infradead.org,
	dri-devel@lists.freedesktop.org, linux-hyperv@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-fbdev@vger.kernel.org,
	Thomas Zimmermann <tzimmermann@suse.de>
Subject: Re: [PATCH v3 3/9] sysfb: Add struct sysfb_display_info
Message-ID: <aSem0a7jTfCNTdX-@r1chard>
References: <20251126160854.553077-1-tzimmermann@suse.de>
 <20251126160854.553077-4-tzimmermann@suse.de>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251126160854.553077-4-tzimmermann@suse.de>
User-Agent: Mutt/2.2.13 (2024-03-09)


Reviewed-by: Richard Lyu <richard.lyu@suse.com>

On 2025/11/26 17:03, Thomas Zimmermann wrote:
> Add struct sysfb_display_info to wrap display-related state. For now
> it contains only the screen's video mode. Later EDID will be added as
> well.
> 
> This struct will be helpful for passing display state to sysfb drivers
> or from the EFI stub library.
> 
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> Acked-by: Arnd Bergmann <arnd@arndb.de>
> Acked-by: Ard Biesheuvel <ardb@kernel.org>
> ---
>  include/linux/sysfb.h | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/include/linux/sysfb.h b/include/linux/sysfb.h
> index 8527a50a5290..8b37247528bf 100644
> --- a/include/linux/sysfb.h
> +++ b/include/linux/sysfb.h
> @@ -8,6 +8,7 @@
>   */
>  
>  #include <linux/err.h>
> +#include <linux/screen_info.h>
>  #include <linux/types.h>
>  
>  #include <linux/platform_data/simplefb.h>
> @@ -60,6 +61,10 @@ struct efifb_dmi_info {
>  	int flags;
>  };
>  
> +struct sysfb_display_info {
> +	struct screen_info screen;
> +};
> +
>  #ifdef CONFIG_SYSFB
>  
>  void sysfb_disable(struct device *dev);
> -- 
> 2.51.1
> 

