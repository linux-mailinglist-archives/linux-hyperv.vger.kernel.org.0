Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 880D04C1DCE
	for <lists+linux-hyperv@lfdr.de>; Wed, 23 Feb 2022 22:33:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242770AbiBWVdv (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 23 Feb 2022 16:33:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234865AbiBWVdu (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 23 Feb 2022 16:33:50 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 501CB4ECF1
        for <linux-hyperv@vger.kernel.org>; Wed, 23 Feb 2022 13:33:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1645652000;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=JVrDSsHDee470/2N5kdB0CUYnm9UIRcjrM+Vqrir8YU=;
        b=RAzwl9Sez1TeT+nmEa1yYBZAZQ4KRu+18SqJ5YvCiLsN5ZoOFX4CZPFTlGdfYriTr4/+WA
        XXnR0ENpAnH0WVYQ6IDWFU8hF6VB+UXAFAgohlr+Zsldn+5r5XNapYpdZ3IxnHR1NhHHKK
        OVHzWqSkiwNvtpVRgw7agSTzlkdlpqo=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-527-1QtltKQdP4qt39CzNY-vtA-1; Wed, 23 Feb 2022 16:33:19 -0500
X-MC-Unique: 1QtltKQdP4qt39CzNY-vtA-1
Received: by mail-wr1-f70.google.com with SMTP id c5-20020adffb05000000b001edbbefe96dso3243wrr.8
        for <linux-hyperv@vger.kernel.org>; Wed, 23 Feb 2022 13:33:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=JVrDSsHDee470/2N5kdB0CUYnm9UIRcjrM+Vqrir8YU=;
        b=brPhO5ucAcLvFxNp8m7svjyb+LX6tExN9w8zOl4YnYe0HOmbWNBVQLuNdgf7ZuCFt5
         QF+WIW4aCvQgUtwjT5v35nKiOR3DFx99auZnV+bEiwGH99ool1s0gC1iMYnDMn6JsXwA
         fPFS6E2q8cAlHIlry3nfrXaFBHK9GgfQcG8zvhIbC+lQ1TIjosSX0M4o2+Q5O0/yNcje
         vMQ5VetoHFn+jA5XPVNrKUaWRp043RBoovD6YWhK26ChldMFndprEHA6F9/wnz4Hxvlv
         5RMeJj4Sx23lFHAvv8hXA1NUvVS92Kw21goRFPgBY/4Ojato7vxCc6fjwQJohhGcgXrA
         6/JA==
X-Gm-Message-State: AOAM533sUV2JWPGWOPtesTPxhRVcVXycznGCwsrFZm3+YxUI4XqIRcAX
        +wuEnR5K/tJyZ1mJ3WMCglBbtYtgW3sGw+cH7vZCRXul8V4gYz9XifnEhVg6ZqfNQ2K5iiSELvC
        wX9GuxcVkoYH9QZG6FPV+6bGW
X-Received: by 2002:a5d:6f0a:0:b0:1e4:a354:a7e with SMTP id ay10-20020a5d6f0a000000b001e4a3540a7emr1081147wrb.423.1645651998036;
        Wed, 23 Feb 2022 13:33:18 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzVh3zKelOjcgzztRyyTOBFC5U69RZ7Dwi6phYx+UQ7pZLlXHi6mmPrXmx8tSFwquULC08JMw==
X-Received: by 2002:a5d:6f0a:0:b0:1e4:a354:a7e with SMTP id ay10-20020a5d6f0a000000b001e4a3540a7emr1081114wrb.423.1645651997698;
        Wed, 23 Feb 2022 13:33:17 -0800 (PST)
Received: from redhat.com ([2.55.166.187])
        by smtp.gmail.com with ESMTPSA id l5sm677279wmq.7.2022.02.23.13.33.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Feb 2022 13:33:17 -0800 (PST)
Date:   Wed, 23 Feb 2022 16:33:10 -0500
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Stuart Yoder <stuyoder@gmail.com>,
        Laurentiu Tudor <laurentiu.tudor@nxp.com>,
        Abel Vesa <abel.vesa@nxp.com>, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Vineeth Vijayan <vneethv@linux.ibm.com>,
        Peter Oberparleiter <oberpar@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Andy Gross <agross@kernel.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        Jason Wang <jasowang@redhat.com>, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, NXP Linux Team <linux-imx@nxp.com>,
        linux-arm-kernel@lists.infradead.org, linux-hyperv@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-remoteproc@vger.kernel.org,
        linux-s390@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        alsa-devel@alsa-project.org, linux-spi@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: Re: [PATCH v2 01/11] driver: platform: add and use helper for safer
 setting of driver_override
Message-ID: <20220223162538-mutt-send-email-mst@kernel.org>
References: <20220223191310.347669-1-krzysztof.kozlowski@canonical.com>
 <20220223191310.347669-2-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220223191310.347669-2-krzysztof.kozlowski@canonical.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Wed, Feb 23, 2022 at 08:13:00PM +0100, Krzysztof Kozlowski wrote:
> Several core drivers and buses expect that driver_override is a
> dynamically allocated memory thus later they can kfree() it.
> 
> However such assumption is not documented, there were in the past and
> there are already users setting it to a string literal. This leads to
> kfree() of static memory during device release (e.g. in error paths or
> during unbind):
> 
>     kernel BUG at ../mm/slub.c:3960!
>     Internal error: Oops - BUG: 0 [#1] PREEMPT SMP ARM
>     ...
>     (kfree) from [<c058da50>] (platform_device_release+0x88/0xb4)
>     (platform_device_release) from [<c0585be0>] (device_release+0x2c/0x90)
>     (device_release) from [<c0a69050>] (kobject_put+0xec/0x20c)
>     (kobject_put) from [<c0f2f120>] (exynos5_clk_probe+0x154/0x18c)
>     (exynos5_clk_probe) from [<c058de70>] (platform_drv_probe+0x6c/0xa4)
>     (platform_drv_probe) from [<c058b7ac>] (really_probe+0x280/0x414)
>     (really_probe) from [<c058baf4>] (driver_probe_device+0x78/0x1c4)
>     (driver_probe_device) from [<c0589854>] (bus_for_each_drv+0x74/0xb8)
>     (bus_for_each_drv) from [<c058b48c>] (__device_attach+0xd4/0x16c)
>     (__device_attach) from [<c058a638>] (bus_probe_device+0x88/0x90)
>     (bus_probe_device) from [<c05871fc>] (device_add+0x3dc/0x62c)
>     (device_add) from [<c075ff10>] (of_platform_device_create_pdata+0x94/0xbc)
>     (of_platform_device_create_pdata) from [<c07600ec>] (of_platform_bus_create+0x1a8/0x4fc)
>     (of_platform_bus_create) from [<c0760150>] (of_platform_bus_create+0x20c/0x4fc)
>     (of_platform_bus_create) from [<c07605f0>] (of_platform_populate+0x84/0x118)
>     (of_platform_populate) from [<c0f3c964>] (of_platform_default_populate_init+0xa0/0xb8)
>     (of_platform_default_populate_init) from [<c01031f8>] (do_one_initcall+0x8c/0x404)
>     (do_one_initcall) from [<c0f012c0>] (kernel_init_freeable+0x3d0/0x4d8)
>     (kernel_init_freeable) from [<c0a7def0>] (kernel_init+0x8/0x114)
>     (kernel_init) from [<c01010b4>] (ret_from_fork+0x14/0x20)
> 
> Provide a helper which clearly documents the usage of driver_override.
> This will allow later to reuse the helper and reduce amount of
> duplicated code.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
> ---
>  drivers/base/driver.c           | 44 +++++++++++++++++++++++++++++++++
>  drivers/base/platform.c         | 24 +++---------------
>  include/linux/device/driver.h   |  1 +
>  include/linux/platform_device.h |  6 ++++-
>  4 files changed, 54 insertions(+), 21 deletions(-)
> 
> diff --git a/drivers/base/driver.c b/drivers/base/driver.c
> index 8c0d33e182fd..79efe51bb4c0 100644
> --- a/drivers/base/driver.c
> +++ b/drivers/base/driver.c
> @@ -30,6 +30,50 @@ static struct device *next_device(struct klist_iter *i)
>  	return dev;
>  }
>  
> +/*
> + * set_driver_override() - Helper to set or clear driver override.
> + * @dev: Device to change
> + * @override: Address of string to change (e.g. &device->driver_override);
> + *            The contents will be freed and hold newly allocated override.
> + * @s: NULL terminated string, new driver name to force a match, pass empty

Don't you mean NUL terminated?
Do all callers really validate that it's NUL terminated?

> + *     string to clear it
> + *
> + * Helper to setr or clear driver override in a device, intended for the cases

set?

> + * when the driver_override field is allocated by driver/bus code.
> + *
> + * Returns: 0 on success or a negative error code on failure.
> + */
> +int driver_set_override(struct device *dev, char **override, const char *s)
> +{
> +	char *new, *old, *cp;
> +
> +	if (!dev || !override || !s)
> +		return -EINVAL;
> +
> +	new = kstrndup(s, strlen(s), GFP_KERNEL);


what's the point of this kstrndup then? why not just kstrdup?

> +	if (!new)
> +		return -ENOMEM;
> +
> +	cp = strchr(new, '\n');
> +	if (cp)
> +		*cp = '\0';
> +
> +	device_lock(dev);
> +	old = *override;
> +	if (strlen(new)) {

We are re-reading the string like 3 times here.

> +		*override = new;
> +	} else {
> +		kfree(new);
> +		*override = NULL;
> +	}
> +	device_unlock(dev);
> +
> +	kfree(old);
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(driver_set_override);
> +
>  /**
>   * driver_for_each_device - Iterator for devices bound to a driver.
>   * @drv: Driver we're iterating.
> diff --git a/drivers/base/platform.c b/drivers/base/platform.c
> index 6cb04ac48bf0..d8853b32ea10 100644
> --- a/drivers/base/platform.c
> +++ b/drivers/base/platform.c
> @@ -1275,31 +1275,15 @@ static ssize_t driver_override_store(struct device *dev,
>  				     const char *buf, size_t count)
>  {
>  	struct platform_device *pdev = to_platform_device(dev);
> -	char *driver_override, *old, *cp;
> +	int ret;
>  
>  	/* We need to keep extra room for a newline */
>  	if (count >= (PAGE_SIZE - 1))
>  		return -EINVAL;

Given everyone seems to repeat this check, how about passing
in count and doing the validation in the helper?
We will then also avoid the need to do strlen and strchr.


> -	driver_override = kstrndup(buf, count, GFP_KERNEL);
> -	if (!driver_override)
> -		return -ENOMEM;
> -
> -	cp = strchr(driver_override, '\n');
> -	if (cp)
> -		*cp = '\0';
> -
> -	device_lock(dev);
> -	old = pdev->driver_override;
> -	if (strlen(driver_override)) {
> -		pdev->driver_override = driver_override;
> -	} else {
> -		kfree(driver_override);
> -		pdev->driver_override = NULL;
> -	}
> -	device_unlock(dev);
> -
> -	kfree(old);
> +	ret = driver_set_override(dev, &pdev->driver_override, buf);
> +	if (ret)
> +		return ret;
>  
>  	return count;
>  }
> diff --git a/include/linux/device/driver.h b/include/linux/device/driver.h
> index 15e7c5e15d62..81c0d9f65a40 100644
> --- a/include/linux/device/driver.h
> +++ b/include/linux/device/driver.h
> @@ -151,6 +151,7 @@ extern int __must_check driver_create_file(struct device_driver *driver,
>  extern void driver_remove_file(struct device_driver *driver,
>  			       const struct driver_attribute *attr);
>  
> +int driver_set_override(struct device *dev, char **override, const char *s);
>  extern int __must_check driver_for_each_device(struct device_driver *drv,
>  					       struct device *start,
>  					       void *data,
> diff --git a/include/linux/platform_device.h b/include/linux/platform_device.h
> index 7c96f169d274..37ac14459499 100644
> --- a/include/linux/platform_device.h
> +++ b/include/linux/platform_device.h
> @@ -31,7 +31,11 @@ struct platform_device {
>  	struct resource	*resource;
>  
>  	const struct platform_device_id	*id_entry;
> -	char *driver_override; /* Driver name to force a match */
> +	/*
> +	 * Driver name to force a match, use
> +	 * driver_set_override() to set or clear it.
> +	 */
> +	char *driver_override;
>  
>  	/* MFD cell pointer */
>  	struct mfd_cell *mfd_cell;
> -- 
> 2.32.0

