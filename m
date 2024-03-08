Return-Path: <linux-hyperv+bounces-1698-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 43FA4876DF7
	for <lists+linux-hyperv@lfdr.de>; Sat,  9 Mar 2024 00:50:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 74BA21C220A5
	for <lists+linux-hyperv@lfdr.de>; Fri,  8 Mar 2024 23:50:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C28CC11707;
	Fri,  8 Mar 2024 23:50:05 +0000 (UTC)
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 429C14084E
	for <linux-hyperv@vger.kernel.org>; Fri,  8 Mar 2024 23:50:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709941805; cv=none; b=oC6uNc9wPlTu/BqCnsPkV23w3qhcHiX0XYEb5t948tSNlraJAFXSnJpj+WjTk21WVg2ytY+e60txxS9uOST88NP9TUyHnrKo1ZJ+SEFPxfqcJlU73/H/75iIoiXQITndedLMGi0KX2ByorZ/DSSVBWdnEAwsWSYo7iPEm2HlyE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709941805; c=relaxed/simple;
	bh=3opxjsCv7jMiquLBzb5ExZrne7HcckEGKoGZJf7dqeY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=raOTFhMovBuX/MKpPR69M2/aEzfbQahvOaiIyGlL7l9nFB5KwOZel13spkk7gnjbkOGgQsY7i5FxqXmi04I1cv8fjr87VuXobI/OhGtaKFzv4L+D7Ic57oJqjcFINptJlnM0a2Dys36j4ptYdZ+cvfdm+8lBJjymbTrDSs7ESJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-1dc1ff3ba1aso20850235ad.3
        for <linux-hyperv@vger.kernel.org>; Fri, 08 Mar 2024 15:50:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709941803; x=1710546603;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7dM1IZ7rjEv78mjMS5HaIEo0TawbwnsyEqX6tF+gErk=;
        b=mCKqmoMCl899sbNhFWB5Dtdz8jwpf6ZUbzqiKcq5Ykuj174Na33sEIe4/RWBIRMCQq
         VZpJ73RK6msd26Q4QAxDbr68rzis74aQc280PP/jVu1VX5BHCFPVMWC578stH7qz+MD5
         +6KrOZLzkRi1F+bY6OfkkpBdaY8mc2x2MhVhveLSL+9hRzVsJEvLSIxosVO9YDNlqgCt
         K5XpbJT/LjZz12sLNs/7r+UERlK3P/ulbxBZyr5ZyN/hJsPnNB8DsL1jj7tYnLA4H9IC
         NIdLAzCUWth8jf2N1eCwktJZO74cnJnJNCqC0tw1gZTQALSMQ6mlpyD0PeX80P7DMxnC
         9RiQ==
X-Forwarded-Encrypted: i=1; AJvYcCU/AQe4VPlmzjHnTHzMeIGQnskC2Z6ZIUyOjCagswTNk1tQou5JTxO3F3RVaAXurl4gMJMXHXoG2EssOFu0+rvzzKtrE2sWNlEaks03
X-Gm-Message-State: AOJu0Yw9IYAB8XM0oEvennJT4ezlwnTkQfIpLhhwi6B2jsKZfMjJPQ9r
	ZNF8lvUQARpiQGkFpa9hlT1hnllEEzSMP2wXGRxuKWgEcz5nUx+Y
X-Google-Smtp-Source: AGHT+IHqDm0xansHd1sSDYeVfuFhVzZmKHepPRsawaWqqYyEUuZyC8vvcFVTu+UfDyiIZY/Sed+w5g==
X-Received: by 2002:a17:902:cf0a:b0:1dc:63b2:7c2e with SMTP id i10-20020a170902cf0a00b001dc63b27c2emr224637plg.31.1709941803479;
        Fri, 08 Mar 2024 15:50:03 -0800 (PST)
Received: from liuwe-devbox-debian-v2 ([20.69.120.36])
        by smtp.gmail.com with ESMTPSA id y15-20020a17090264cf00b001dd744f97d0sm196561pli.273.2024.03.08.15.50.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Mar 2024 15:50:03 -0800 (PST)
Date: Fri, 8 Mar 2024 23:49:58 +0000
From: Wei Liu <wei.liu@kernel.org>
To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>
Cc: "K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
	linux-hyperv@vger.kernel.org, kernel@pengutronix.de
Subject: Re: [PATCH] hv: vmbus: Convert to platform remove callback returning
 void
Message-ID: <ZeukJmEAKtlO7GZ-@liuwe-devbox-debian-v2>
References: <920230729ddbeb9f3c4ff8282a18b0c0e1a37969.1709886922.git.u.kleine-koenig@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <920230729ddbeb9f3c4ff8282a18b0c0e1a37969.1709886922.git.u.kleine-koenig@pengutronix.de>

On Fri, Mar 08, 2024 at 09:51:08AM +0100, Uwe Kleine-König wrote:
> The .remove() callback for a platform driver returns an int which makes
> many driver authors wrongly assume it's possible to do error handling by
> returning an error code. However the value returned is ignored (apart
> from emitting a warning) and this typically results in resource leaks.
> 
> To improve here there is a quest to make the remove callback return
> void. In the first step of this quest all drivers are converted to
> .remove_new(), which already returns void. Eventually after all drivers
> are converted, .remove_new() will be renamed to .remove().
> 
> Trivially convert this driver from always returning zero in the remove
> callback to the void returning variant.
> 
> Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>

Applied to hyperv-next, thanks!

> ---
>  drivers/hv/vmbus_drv.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/hv/vmbus_drv.c b/drivers/hv/vmbus_drv.c
> index 7f7965f3d187..4cb17603a828 100644
> --- a/drivers/hv/vmbus_drv.c
> +++ b/drivers/hv/vmbus_drv.c
> @@ -2359,10 +2359,9 @@ static int vmbus_platform_driver_probe(struct platform_device *pdev)
>  		return vmbus_acpi_add(pdev);
>  }
>  
> -static int vmbus_platform_driver_remove(struct platform_device *pdev)
> +static void vmbus_platform_driver_remove(struct platform_device *pdev)
>  {
>  	vmbus_mmio_remove();
> -	return 0;
>  }
>  
>  #ifdef CONFIG_PM_SLEEP
> @@ -2542,7 +2541,7 @@ static const struct dev_pm_ops vmbus_bus_pm = {
>  
>  static struct platform_driver vmbus_platform_driver = {
>  	.probe = vmbus_platform_driver_probe,
> -	.remove = vmbus_platform_driver_remove,
> +	.remove_new = vmbus_platform_driver_remove,
>  	.driver = {
>  		.name = "vmbus",
>  		.acpi_match_table = ACPI_PTR(vmbus_acpi_device_ids),
> 
> base-commit: 8ffc8b1bbd505e27e2c8439d326b6059c906c9dd
> -- 
> 2.43.0
> 

