Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BF165E697D
	for <lists+linux-hyperv@lfdr.de>; Thu, 22 Sep 2022 19:19:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230141AbiIVRTr (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 22 Sep 2022 13:19:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231391AbiIVRTq (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 22 Sep 2022 13:19:46 -0400
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15181397;
        Thu, 22 Sep 2022 10:19:45 -0700 (PDT)
Received: by mail-wr1-f48.google.com with SMTP id y5so16662931wrh.3;
        Thu, 22 Sep 2022 10:19:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=5hiam4Rd+NTu+6XogJRYY70Z3eZ5FhQLv+wWdqT3ju0=;
        b=inGa3thtRL4uP0gidHG0ExHCh5BVWfUhNEALcEQAysNgVibS98UB5zUFRLpRnyhtP0
         vGyKKXeFruoCy6rR9sEhDVLZcE8j+E/GDCtiTP9e0B5r5HumBx29+VIOuN182KHiX2Vi
         svsj5vlP6DJ99pRdwATUhg1XIkuTczj+VADTX89i/3J1PKM3TwK52y0eH40L4yvQ67GC
         njoCLRG7v0RhEHYo7y6wNpeoICfhkJGP5xyK9oVbTOV7/rMPBmxxbnlyadHWidLDMMo+
         QpWCBu/iXGwUvlRsIZMelwHIRlRpw42rH1FjBWg8P8ukDovCsCWv33KDl2nmOrVqOyM1
         u3vg==
X-Gm-Message-State: ACrzQf0C/6F7DWUbaUKQFyBLrlbVavcbRZdgAB7lntQCbAcI2LI8b992
        AAxkhE2n/cRDivR00aQR/OAdkcWfp2M=
X-Google-Smtp-Source: AMsMyM6b0M1oqtkiZsvCKUVcdJY7TvE/ogZBGWFCFyROmWpKqfp6rWwDcLfske10ndwy6aSb+JmqBw==
X-Received: by 2002:a5d:4247:0:b0:22a:df99:ce06 with SMTP id s7-20020a5d4247000000b0022adf99ce06mr2863743wrr.513.1663867183258;
        Thu, 22 Sep 2022 10:19:43 -0700 (PDT)
Received: from liuwe-devbox-debian-v2 ([51.145.34.42])
        by smtp.gmail.com with ESMTPSA id q16-20020a1cf310000000b003a5fa79007fsm150268wmq.7.2022.09.22.10.19.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Sep 2022 10:19:42 -0700 (PDT)
Date:   Thu, 22 Sep 2022 17:19:40 +0000
From:   Wei Liu <wei.liu@kernel.org>
To:     Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
Cc:     skinsburskii@microsoft.com,
        Stanislav Kinsburskiy <stanislav.kinsburskiy@gmail.com>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
        linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
        Michael Kelley <mikelley@microsoft.com>
Subject: Re: [PATCH] Drivers: hv: vmbus: Don't wait for the ACPI device upon
 initialization
Message-ID: <YyyZLMMiDfExQI2v@liuwe-devbox-debian-v2>
References: <166378554568.581670.1124852716698789244.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <166378554568.581670.1124852716698789244.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Wed, Sep 21, 2022 at 06:39:05PM +0000, Stanislav Kinsburskii wrote:
> From: Stanislav Kinsburskiy <stanislav.kinsburskiy@gmail.com>
> 
> Waiting to 5 seconds in case of missing VMBUS ACPI device is redundant as the
> device is either present already or won't be available at all.
> This patch enforces synchronous probing to make sure the bus traversal,
> happening upon driver registering will either find the device (if present) or
> not spend any additional time if device is absent.
> 
> Signed-off-by: Stanislav Kinsburskiy <stanislav.kinsburskiy@gmail.com>
> CC: "K. Y. Srinivasan" <kys@microsoft.com>
> CC: Haiyang Zhang <haiyangz@microsoft.com>
> CC: Stephen Hemminger <sthemmin@microsoft.com>
> CC: Wei Liu <wei.liu@kernel.org>
> CC: Dexuan Cui <decui@microsoft.com>
> CC: linux-hyperv@vger.kernel.org
> CC: linux-kernel@vger.kernel.org

Looks good to me. I will wait for a few days for others to chime in.

CC Michael.

> ---
>  drivers/hv/vmbus_drv.c |   13 ++++---------
>  1 file changed, 4 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/hv/vmbus_drv.c b/drivers/hv/vmbus_drv.c
> index 7b9f3fc3adf7..32d0009631a6 100644
> --- a/drivers/hv/vmbus_drv.c
> +++ b/drivers/hv/vmbus_drv.c
> @@ -46,8 +46,6 @@ struct vmbus_dynid {
>  
>  static struct acpi_device  *hv_acpi_dev;
>  
> -static struct completion probe_event;
> -
>  static int hyperv_cpuhp_online;
>  
>  static void *hv_panic_page;
> @@ -2468,7 +2466,6 @@ static int vmbus_acpi_add(struct acpi_device *device)
>  	ret_val = 0;
>  
>  acpi_walk_err:
> -	complete(&probe_event);
>  	if (ret_val)
>  		vmbus_acpi_remove(device);
>  	return ret_val;
> @@ -2647,6 +2644,7 @@ static struct acpi_driver vmbus_acpi_driver = {
>  		.remove = vmbus_acpi_remove,
>  	},
>  	.drv.pm = &vmbus_bus_pm,
> +	.drv.probe_type = PROBE_FORCE_SYNCHRONOUS,
>  };
>  
>  static void hv_kexec_handler(void)
> @@ -2719,7 +2717,7 @@ static struct syscore_ops hv_synic_syscore_ops = {
>  
>  static int __init hv_acpi_init(void)
>  {
> -	int ret, t;
> +	int ret;
>  
>  	if (!hv_is_hyperv_initialized())
>  		return -ENODEV;
> @@ -2727,8 +2725,6 @@ static int __init hv_acpi_init(void)
>  	if (hv_root_partition)
>  		return 0;
>  
> -	init_completion(&probe_event);
> -
>  	/*
>  	 * Get ACPI resources first.
>  	 */
> @@ -2737,9 +2733,8 @@ static int __init hv_acpi_init(void)
>  	if (ret)
>  		return ret;
>  
> -	t = wait_for_completion_timeout(&probe_event, 5*HZ);
> -	if (t == 0) {
> -		ret = -ETIMEDOUT;
> +	if (!hv_acpi_dev) {
> +		ret = -ENODEV;
>  		goto cleanup;
>  	}
>  
> 
> 
