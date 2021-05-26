Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3249E39147A
	for <lists+linux-hyperv@lfdr.de>; Wed, 26 May 2021 12:08:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233830AbhEZKJn (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 26 May 2021 06:09:43 -0400
Received: from mail-wr1-f42.google.com ([209.85.221.42]:33638 "EHLO
        mail-wr1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233787AbhEZKJk (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 26 May 2021 06:09:40 -0400
Received: by mail-wr1-f42.google.com with SMTP id n2so540206wrm.0;
        Wed, 26 May 2021 03:08:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=3bo+c3S5QKp7gdHebx8LdhAWUc/HOzQNqyiFqhVHljE=;
        b=Nokw/GcI40kiAgn9bR+XmcEgIytbeQ9lkyqLwtknX4cImDKORZELPgR/UtDRc9a1EG
         Zg9KH4oL+TaZn+eFctTpi9zwFbBHkYeNTE9pKaAKeNiWsikK0TL28caT4pB6Y3k0ofjr
         LqwJIzzSknbU9YzkoLd/6mEcK3LPFIHe2EhrVNkuKDsBQv34ikQ9ZI1+zfdNSTe36mKr
         cujmhg0vD8Og0WwVkhecaB6Lo6CVThH0CL1/D9V1r/VV+vHYsRI75KdL4zDh23kOQt8B
         fJOIrNQXwmP10fnuBO35oxZlQMXWi7HDMxI8oNYjXjwBkO/ITzJpZcdtj1H5pcbPcSl0
         +qVA==
X-Gm-Message-State: AOAM530Z/WGuVFc4Isqd8D7XD520pikYayZAMi5UHFwtiSGaGMZHxlUg
        Edw/SW9hVQ2ZXu3Gh/w0+s8=
X-Google-Smtp-Source: ABdhPJziSRsXB9sJDjgqH8qbMWPhdLxWYa+hc6oCcPa0qqVjdQIl6Nq3piyW+u6w0WVlc1k8AMtgWw==
X-Received: by 2002:adf:fd81:: with SMTP id d1mr32269275wrr.37.1622023687273;
        Wed, 26 May 2021 03:08:07 -0700 (PDT)
Received: from liuwe-devbox-debian-v2 ([51.145.34.42])
        by smtp.gmail.com with ESMTPSA id v18sm23315208wro.18.2021.05.26.03.08.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 May 2021 03:08:06 -0700 (PDT)
Date:   Wed, 26 May 2021 10:08:05 +0000
From:   Wei Liu <wei.liu@kernel.org>
To:     Haiyang Zhang <haiyangz@microsoft.com>
Cc:     bhelgaas@google.com, lorenzo.pieralisi@arm.com, wei.liu@kernel.org,
        linux-hyperv@vger.kernel.org, linux-pci@vger.kernel.org,
        kys@microsoft.com, olaf@aepfle.de, vkuznets@redhat.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] pci-hyperv: Add check for hyperv_initialized in
 init_hv_pci_drv()
Message-ID: <20210526100805.xpeen7td45cswqsw@liuwe-devbox-debian-v2>
References: <1621984653-1210-1-git-send-email-haiyangz@microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1621984653-1210-1-git-send-email-haiyangz@microsoft.com>
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Tue, May 25, 2021 at 04:17:33PM -0700, Haiyang Zhang wrote:
> Add check for hv_is_hyperv_initialized() at the top of init_hv_pci_drv(),
> so if the pci-hyperv driver is force-loaded on non Hyper-V platforms, the
> init_hv_pci_drv() will exit immediately, without any side effects, like
> assignments to hvpci_block_ops, etc.
> 
> Signed-off-by: Haiyang Zhang <haiyangz@microsoft.com>
> Reported-and-tested-by: Mohammad Alqayeem <mohammad.alqyeem@nutanix.com>

Reviewed-by: Wei Liu <wei.liu@kernel.org>

> ---
>  drivers/pci/controller/pci-hyperv.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/pci/controller/pci-hyperv.c b/drivers/pci/controller/pci-hyperv.c
> index 6511648271b2..bebe3eeebc4e 100644
> --- a/drivers/pci/controller/pci-hyperv.c
> +++ b/drivers/pci/controller/pci-hyperv.c
> @@ -3476,6 +3476,9 @@ static void __exit exit_hv_pci_drv(void)
>  
>  static int __init init_hv_pci_drv(void)
>  {
> +	if (!hv_is_hyperv_initialized())
> +		return -ENODEV;
> +
>  	/* Set the invalid domain number's bit, so it will not be used */
>  	set_bit(HVPCI_DOM_INVALID, hvpci_dom_map);
>  
> -- 
> 2.25.1
> 
