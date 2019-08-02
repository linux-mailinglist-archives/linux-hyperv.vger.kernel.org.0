Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 267257ED84
	for <lists+linux-hyperv@lfdr.de>; Fri,  2 Aug 2019 09:34:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389785AbfHBHep (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 2 Aug 2019 03:34:45 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:34919 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389761AbfHBHep (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 2 Aug 2019 03:34:45 -0400
Received: by mail-wr1-f68.google.com with SMTP id y4so76109606wrm.2
        for <linux-hyperv@vger.kernel.org>; Fri, 02 Aug 2019 00:34:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=3z/XjlqQ+U0upcsy+zCqEqLj7uveq+FerIfINm1EQYg=;
        b=jL+emJmRNqnhBHkVW23UUGcn6L/0ksqTFsvvotp6h1HLBiVKDrzX52/z+QY/Gc0mQd
         amfaxk2rlA9p6Afpy25wJS63iHry71H79kosemqf9mB4epXqdaOPIyU3uPuM5cjp9bh/
         pWTlRqB7AmgGTmShCgWMIlCy2+1feGEotAxVETKHqTzVOlMlfvKUBqIs56sc5dxvHUOj
         YCLyPeINbskrX+Lm7Tk2B2lBEWGrCz6nzk9JaPeZvdh+k1bTqAxktKA+YdaG5xWxiOtD
         3U7sQ5mZB3gsaQLa3CW+CRo2+s+pkNqXB/YDGYC6dwItZVrcC1aMmViwQEfxhSMXJyKn
         jIOQ==
X-Gm-Message-State: APjAAAVcf+BSQQtad/GKB7VBiD+hl6/ASzYNXY6Jqhsy0puo6FAN/XLI
        73QTU47ubQ232VxHIwgeU2lPfg==
X-Google-Smtp-Source: APXvYqyDcHNOHDrN1B3sxwAdkKrHXAPTt73YgtuP1P4V9QyZxdkuE1ibEjXG/N8AINCuCf7chdE/kg==
X-Received: by 2002:a5d:4ec1:: with SMTP id s1mr135829022wrv.19.1564731282930;
        Fri, 02 Aug 2019 00:34:42 -0700 (PDT)
Received: from vitty.brq.redhat.com (ip-89-176-127-93.net.upcbroadband.cz. [89.176.127.93])
        by smtp.gmail.com with ESMTPSA id b2sm97905340wrp.72.2019.08.02.00.34.41
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 02 Aug 2019 00:34:42 -0700 (PDT)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Branden Bonaby <brandonbonaby94@gmail.com>
Cc:     linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
        kys@microsoft.com, haiyangz@microsoft.com, sthemmin@microsoft.com,
        sashal@kernel.org
Subject: Re: [PATCH 2/3] drivers: hv: vmbus: add fuzz test attributes to sysfs
In-Reply-To: <20f96dba927eaa42fceeebfc7a6a37f3b1a9ee65.1564527684.git.brandonbonaby94@gmail.com>
References: <cover.1564527684.git.brandonbonaby94@gmail.com> <20f96dba927eaa42fceeebfc7a6a37f3b1a9ee65.1564527684.git.brandonbonaby94@gmail.com>
Date:   Fri, 02 Aug 2019 09:34:40 +0200
Message-ID: <87a7csggvj.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Branden Bonaby <brandonbonaby94@gmail.com> writes:

> Expose the test parameters as part of the sysfs channel attributes.
> We will control the testing state via these attributes.
>
> Signed-off-by: Branden Bonaby <brandonbonaby94@gmail.com>
> ---
>  Documentation/ABI/stable/sysfs-bus-vmbus | 22 ++++++
>  drivers/hv/vmbus_drv.c                   | 97 +++++++++++++++++++++++-
>  2 files changed, 118 insertions(+), 1 deletion(-)
>
> diff --git a/Documentation/ABI/stable/sysfs-bus-vmbus b/Documentation/ABI/stable/sysfs-bus-vmbus
> index 8e8d167eca31..239fcb6fdc75 100644
> --- a/Documentation/ABI/stable/sysfs-bus-vmbus
> +++ b/Documentation/ABI/stable/sysfs-bus-vmbus
> @@ -185,3 +185,25 @@ Contact:        Michael Kelley <mikelley@microsoft.com>
>  Description:    Total number of write operations that encountered an outbound
>  		ring buffer full condition
>  Users:          Debugging tools
> +
> +What:           /sys/bus/vmbus/devices/<UUID>/fuzz_test_state

I would prefer this to go under /sys/kernel/debug/ as this is clearly a
debug/test feature.


> +Date:           July 2019
> +KernelVersion:  5.2
> +Contact:        Branden Bonaby <brandonbonaby94@gmail.com>
> +Description:    Fuzz testing status of a vmbus device, whether its in an ON
> +		 state or a OFF state
> +Users:          Debugging tools
> +
> +What:           /sys/bus/vmbus/devices/<UUID>/fuzz_test_buffer_delay
> +Date:           July 2019
> +KernelVersion:  5.2
> +Contact:        Branden Bonaby <brandonbonaby94@gmail.com>
> +Description:    Fuzz testing buffer delay value between 0 - 1000
> +Users:          Debugging tools
> +
> +What:           /sys/bus/vmbus/devices/<UUID>/fuzz_test_message_delay
> +Date:           July 2019
> +KernelVersion:  5.2
> +Contact:        Branden Bonaby <brandonbonaby94@gmail.com>
> +Description:    Fuzz testing message delay value between 0 - 1000
> +Users:          Debugging tools
> diff --git a/drivers/hv/vmbus_drv.c b/drivers/hv/vmbus_drv.c
> index 92b1874b3eb3..0c71fd66ef81 100644
> --- a/drivers/hv/vmbus_drv.c
> +++ b/drivers/hv/vmbus_drv.c
> @@ -22,7 +22,7 @@
>  #include <linux/clockchips.h>
>  #include <linux/cpu.h>
>  #include <linux/sched/task_stack.h>
> -
> +#include <linux/kernel.h>
>  #include <asm/mshyperv.h>
>  #include <linux/notifier.h>
>  #include <linux/ptrace.h>
> @@ -584,6 +584,98 @@ static ssize_t driver_override_show(struct device *dev,
>  }
>  static DEVICE_ATTR_RW(driver_override);
>  
> +static ssize_t fuzz_test_state_store(struct device *dev,
> +				     struct device_attribute *attr,
> +				     const char *buf, size_t count)
> +{
> +	struct hv_device *hv_dev = device_to_hv_device(dev);
> +	struct vmbus_channel *channel = hv_dev->channel;
> +	int state;
> +	int delay = kstrtoint(buf, 0, &state);
> +
> +	if (delay)
> +		return count;
> +	if (state)
> +		channel->fuzz_testing_state = 1;
> +	else
> +		channel->fuzz_testing_state = 0;
> +	return count;
> +}
> +
> +static ssize_t fuzz_test_state_show(struct device *dev,
> +				    struct device_attribute *dev_attr,
> +				    char *buf)
> +{
> +	struct hv_device *hv_dev = device_to_hv_device(dev);
> +	struct vmbus_channel *channel = hv_dev->channel;
> +
> +	return sprintf(buf, "%u\n", channel->fuzz_testing_state);
> +}
> +static DEVICE_ATTR_RW(fuzz_test_state);
> +
> +static ssize_t fuzz_test_buffer_delay_store(struct device *dev,
> +					    struct device_attribute *attr,
> +					    const char *buf, size_t count)
> +{
> +	struct hv_device *hv_dev = device_to_hv_device(dev);
> +	struct vmbus_channel *channel = hv_dev->channel;
> +	int val;
> +	int delay = kstrtoint(buf, 0, &val);
> +
> +	if (delay)
> +		return count;
> +	if (val >= 1 && val <= 1000)
> +		channel->fuzz_testing_buffer_delay = val;
> +	/*Best to not use else statement here since we want
> +	 *the buffer delay to remain the same if val > 1000
> +	 */
> +	else if (val <= 0)
> +		channel->fuzz_testing_buffer_delay = 0;
> +	return count;
> +}
> +
> +static ssize_t fuzz_test_buffer_delay_show(struct device *dev,
> +					   struct device_attribute *dev_attr,
> +					   char *buf)
> +{
> +	struct hv_device *hv_dev = device_to_hv_device(dev);
> +	struct vmbus_channel *channel = hv_dev->channel;
> +
> +	return sprintf(buf, "%u\n", channel->fuzz_testing_buffer_delay);
> +}
> +static DEVICE_ATTR_RW(fuzz_test_buffer_delay);
> +
> +static ssize_t fuzz_test_message_delay_store(struct device *dev,
> +					     struct device_attribute *attr,
> +					     const char *buf, size_t count)
> +{
> +	struct hv_device *hv_dev = device_to_hv_device(dev);
> +	struct vmbus_channel *channel = hv_dev->channel;
> +	int val;
> +	int delay = kstrtoint(buf, 0, &val);
> +
> +	if (delay)
> +		return count;
> +	if (val >= 1 && val <= 1000)
> +		channel->fuzz_testing_message_delay = val;
> +	/*Best to not use else statement here since we want
> +	 *the message delay to remain the same if val > 1000
> +	 */
> +	else if (val <= 0)
> +		channel->fuzz_testing_message_delay = 0;
> +	return count;
> +}
> +
> +static ssize_t fuzz_test_message_delay_show(struct device *dev,
> +					    struct device_attribute *dev_attr,
> +					    char *buf)
> +{
> +	struct hv_device *hv_dev = device_to_hv_device(dev);
> +	struct vmbus_channel *channel = hv_dev->channel;
> +
> +	return sprintf(buf, "%u\n", channel->fuzz_testing_message_delay);
> +}
> +static DEVICE_ATTR_RW(fuzz_test_message_delay);
>  /* Set up per device attributes in /sys/bus/vmbus/devices/<bus device> */
>  static struct attribute *vmbus_dev_attrs[] = {
>  	&dev_attr_id.attr,
> @@ -615,6 +707,9 @@ static struct attribute *vmbus_dev_attrs[] = {
>  	&dev_attr_vendor.attr,
>  	&dev_attr_device.attr,
>  	&dev_attr_driver_override.attr,
> +	&dev_attr_fuzz_test_state.attr,
> +	&dev_attr_fuzz_test_buffer_delay.attr,
> +	&dev_attr_fuzz_test_message_delay.attr,
>  	NULL,
>  };

-- 
Vitaly
