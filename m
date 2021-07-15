Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB05C3C9ED8
	for <lists+linux-hyperv@lfdr.de>; Thu, 15 Jul 2021 14:41:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234549AbhGOMoq (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 15 Jul 2021 08:44:46 -0400
Received: from mail-wm1-f46.google.com ([209.85.128.46]:38682 "EHLO
        mail-wm1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237422AbhGOMoq (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 15 Jul 2021 08:44:46 -0400
Received: by mail-wm1-f46.google.com with SMTP id b14-20020a1c1b0e0000b02901fc3a62af78so5959417wmb.3;
        Thu, 15 Jul 2021 05:41:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=O+M79BeIDhVxQMgy3sWJEueXStEdWGM0NwaNbUc7J0U=;
        b=TvjY9mxKzzY5f+viYkVwvLEyysfn//OyXoqnJK1HOw4Bf6LRhjiOqITAFuiM0WTcUQ
         Jo/Sx13E6NWbgTFyjSpOfv5SvRC4xQvZGtWaHcxbBRCA39KHeljU95UogRsnQzabCSh0
         2mD1Uv1dyYiD9D1sKzbPOiAg94orIUznKPtYF6weKy34ieE36l4fnT2SgT9rWNjaobGG
         dtzXkWLcUxIZE5UOsYJmDxhmJQrsfxIF7ORZer5aqKAJkRBmKo3baclIpyif+KUspSvn
         /MNWtyN+0FXtf8Y9R9HyNg5t5ikuAzgn9uv+SFDCFVoTzVFtijtrBmEnMGiI1AvHMw3k
         gvVQ==
X-Gm-Message-State: AOAM533H+rG4CzViu07zoWKOyVlv8rVuTBmdkdX7K0gmndR8tjuFYzdD
        HMDfo7PbKXqXNCNhmhKxQvs=
X-Google-Smtp-Source: ABdhPJw4oTEykLpOhMa5XYDn+I227/hwlyerTSfZaX8R1JcoHZ5I/ELuigkif0DBqS58jDM/hImNJA==
X-Received: by 2002:a05:600c:8a9:: with SMTP id l41mr10569478wmp.152.1626352912160;
        Thu, 15 Jul 2021 05:41:52 -0700 (PDT)
Received: from liuwe-devbox-debian-v2 ([51.145.34.42])
        by smtp.gmail.com with ESMTPSA id r16sm8148995wmg.11.2021.07.15.05.41.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Jul 2021 05:41:51 -0700 (PDT)
Date:   Thu, 15 Jul 2021 12:41:50 +0000
From:   Wei Liu <wei.liu@kernel.org>
To:     Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc:     kernel@pengutronix.de, linux-kernel@vger.kernel.org,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
        linux-hyperv@vger.kernel.org,
        virtualization@lists.linux-foundation.org
Subject: Re: [PATCH v2 4/4] bus: Make remove callback return void
Message-ID: <20210715123636.ychn4zea2dltnwxg@liuwe-devbox-debian-v2>
References: <20210706154803.1631813-1-u.kleine-koenig@pengutronix.de>
 <20210706154803.1631813-5-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210706154803.1631813-5-u.kleine-koenig@pengutronix.de>
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

(Drop irrelevant CCs to avoid spamming people)

On Tue, Jul 06, 2021 at 05:48:03PM +0200, Uwe Kleine-König wrote:
>  drivers/hv/vmbus_drv.c                    | 5 +----

Acked-by: Wei Liu <wei.liu@kernel.org>

> diff --git a/drivers/hv/vmbus_drv.c b/drivers/hv/vmbus_drv.c
> index 57bbbaa4e8f7..392c1ac4f819 100644
> --- a/drivers/hv/vmbus_drv.c
> +++ b/drivers/hv/vmbus_drv.c
> @@ -922,7 +922,7 @@ static int vmbus_probe(struct device *child_device)
>  /*
>   * vmbus_remove - Remove a vmbus device
>   */
> -static int vmbus_remove(struct device *child_device)
> +static void vmbus_remove(struct device *child_device)
>  {
>  	struct hv_driver *drv;
>  	struct hv_device *dev = device_to_hv_device(child_device);
> @@ -932,11 +932,8 @@ static int vmbus_remove(struct device *child_device)
>  		if (drv->remove)
>  			drv->remove(dev);
>  	}
> -
> -	return 0;
>  }
>  
