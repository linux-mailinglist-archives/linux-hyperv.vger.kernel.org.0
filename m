Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 57AE7249BC7
	for <lists+linux-hyperv@lfdr.de>; Wed, 19 Aug 2020 13:30:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727884AbgHSLaa (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 19 Aug 2020 07:30:30 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:38428 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727869AbgHSLaZ (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 19 Aug 2020 07:30:25 -0400
Received: by mail-wr1-f68.google.com with SMTP id a14so21173675wra.5;
        Wed, 19 Aug 2020 04:30:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ijq/eOVTt4WGVZZrPhxwtbhfjRio5pBRGbeqfm+WtYY=;
        b=j4KOndKQ3Cf+/SMw+sOZ3IBvdiU9cGyBZP1noDIAYATbdOW1HRi8UtOsT3SAaqEn/G
         KZ5FpsRbbi+rce33fPlA7yKXfu7mAlPLp26L0g5XX6q/ZwFMHCgX2sbPhlflfxVRy2rq
         BFDFSAuzpMrvdHDySgHvM1KP0kCa4FYg4ZCO4NnwW+y5KkNytyVZHKrwRCySmM8PG/Qq
         3Ov+27C5rfqWGEZ0J7lOKfdX/Qt0j8GPpzyTCJ7mobdxp8JeOhybzusQ0OKkfKJo2cDN
         IBBuVNr0MIDSx/zaVm/bNDsEGso1FQX4/YBRcCMh2tGxks4xZAKkbg6PpfIIvcg1lYDk
         IVmg==
X-Gm-Message-State: AOAM533I4i9jaHEG/tBjl/klgmAbwLYQyBorjX1bMkQjJYeuWs4f+yl8
        Z76irB5DtwBIEizjOfAv5Q8=
X-Google-Smtp-Source: ABdhPJxxQJvyTyxK07hmiDHAD+i0FQmAlP7uWxW/JyS+RY1F4/v6Pbpg3ByTXyhZU8mUnTPjvMreFQ==
X-Received: by 2002:a5d:4c45:: with SMTP id n5mr3723014wrt.68.1597836618075;
        Wed, 19 Aug 2020 04:30:18 -0700 (PDT)
Received: from liuwe-devbox-debian-v2 ([51.145.34.42])
        by smtp.gmail.com with ESMTPSA id k15sm39349945wrp.43.2020.08.19.04.30.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Aug 2020 04:30:17 -0700 (PDT)
Date:   Wed, 19 Aug 2020 11:30:16 +0000
From:   Wei Liu <wei.liu@kernel.org>
To:     Olaf Hering <olaf@aepfle.de>
Cc:     linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>
Subject: Re: [PATCH v1] tools: hv: remove cast from hyperv_die_event
Message-ID: <20200819113016.6uz7onkfybylaxcx@liuwe-devbox-debian-v2>
References: <20200819090510.28995-1-olaf@aepfle.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200819090510.28995-1-olaf@aepfle.de>
User-Agent: NeoMutt/20180716
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Wed, Aug 19, 2020 at 11:05:09AM +0200, Olaf Hering wrote:
> No need to cast a void pointer.
> 
> Signed-off-by: Olaf Hering <olaf@aepfle.de>

Applied to hyperv-next.

I also changed "tools" to "drivers".

> ---
>  drivers/hv/vmbus_drv.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/hv/vmbus_drv.c b/drivers/hv/vmbus_drv.c
> index 910b6e90866c..187809977360 100644
> --- a/drivers/hv/vmbus_drv.c
> +++ b/drivers/hv/vmbus_drv.c
> @@ -83,7 +83,7 @@ static int hyperv_panic_event(struct notifier_block *nb, unsigned long val,
>  static int hyperv_die_event(struct notifier_block *nb, unsigned long val,
>  			    void *args)
>  {
> -	struct die_args *die = (struct die_args *)args;
> +	struct die_args *die = args;
>  	struct pt_regs *regs = die->regs;
>  
>  	/* Don't notify Hyper-V if the die event is other than oops */
