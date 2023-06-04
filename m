Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65846721542
	for <lists+linux-hyperv@lfdr.de>; Sun,  4 Jun 2023 09:10:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230168AbjFDHKD (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Sun, 4 Jun 2023 03:10:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbjFDHKC (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Sun, 4 Jun 2023 03:10:02 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20866DF;
        Sun,  4 Jun 2023 00:10:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8EE4960FC3;
        Sun,  4 Jun 2023 07:10:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A9A5C433D2;
        Sun,  4 Jun 2023 07:09:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1685862599;
        bh=Mu+bP2JRfT64I7YPTD+3Z8tPS/8uXc2gY63jtDT9NPw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NSZrp22U/WYpgnBSleUZKbb5vs2BTEzYRjzPjP/tFZZzTfl0+0iyHGImxo0XWLUzo
         2FDeq/lJG/qujcU5YkT34kagUzKLX1aoyaeX5bO38sQrTvWcyOtNOiwBRyRAS3L/LZ
         XfyemIR23kKcmH1Ku7jOgekKgpSJGBU69C6yro94=
Date:   Sun, 4 Jun 2023 09:09:57 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Saurabh Sengar <ssengar@linux.microsoft.com>
Cc:     kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
        decui@microsoft.com, mikelley@microsoft.com,
        linux-kernel@vger.kernel.org, linux-hyperv@vger.kernel.org
Subject: Re: [PATCH 1/5] uio: Add hv_vmbus_client driver
Message-ID: <2023060421-unclothed-hungry-cb3e@gregkh>
References: <1685692629-31351-1-git-send-email-ssengar@linux.microsoft.com>
 <1685692629-31351-2-git-send-email-ssengar@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1685692629-31351-2-git-send-email-ssengar@linux.microsoft.com>
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Fri, Jun 02, 2023 at 12:57:05AM -0700, Saurabh Sengar wrote:
> + * Since the driver does not declare any device ids, you must allocate
> + * id and bind the device to the driver yourself.  For example:
> + * driverctl -b vmbus set-override <dev uuid> uio_hv_vmbus_client

Shouldn't this be documented somewhere?

> + */
> +
> +#include <linux/device.h>
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/uio_driver.h>
> +#include <linux/hyperv.h>
> +#include <linux/vmalloc.h>
> +#include <linux/sysfs.h>
> +
> +#define DRIVER_VERSION	"0.0.1"

Why this number?  Why not "1"?

The whole "driver version" thing doesn't really make sense here, we
should just drop it from the uio later, right?

> +#define DRIVER_AUTHOR	"Saurabh Sengar <ssengar@microsoft.com>"
> +#define DRIVER_DESC	"Generic UIO driver for low speed VMBus devices"
> +
> +#define DEFAULT_HV_RING_SIZE	VMBUS_RING_SIZE(3 * HV_HYP_PAGE_SIZE)
> +static int ring_size = DEFAULT_HV_RING_SIZE;
> +
> +struct uio_hv_vmbus_dev {
> +	struct uio_info info;
> +	struct hv_device *device;
> +	atomic_t refcnt;

Why is this refcnt needed?

Have you seen the other threads about how attempting to block multiple
opens in UIO drivers really does not work at all?  Please drop all of
that logic, it is not correct.


> +static ssize_t ring_size_show(struct device *dev, struct device_attribute *attr,
> +			      char *buf)
> +{
> +	return scnprintf(buf, PAGE_SIZE, "%d\n", ring_size);

Did you use checkpatch?

It should have said to use sysfs_emit(), right?

> +	ret = sysfs_create_file(&dev->device.kobj, &dev_attr_ring_size.attr);

If you ever have to use a sysfs_* call in a driver, that's a huge hint
something is wrong.  Please fix this to not race with userspace and
loose.

> +	if (ret)
> +		dev_notice(&dev->device, "sysfs create ring size file failed; %d\n", ret);

Why not just use dev_err() for this and other errors?  Why "notice"?

> +MODULE_VERSION(DRIVER_VERSION);

This means nothing, please drop.

thanks,

greg k-h
