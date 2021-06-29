Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ACA4C3B6E3B
	for <lists+linux-hyperv@lfdr.de>; Tue, 29 Jun 2021 08:24:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231958AbhF2G1I (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 29 Jun 2021 02:27:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:36216 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231948AbhF2G1I (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 29 Jun 2021 02:27:08 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0221761DAC;
        Tue, 29 Jun 2021 06:24:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1624947881;
        bh=JQm7TBEan5fuUU1skoCbstInW3HKKM8cp7SkyYg1RU0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=i4K3gIFnBQ91+pbrPRMJViWSqzXyCWiIxohPLcgQuQvmPDqFpBmBbA8TsGWsnkwu5
         peHVHT2H3dEkE1KBO4A3AcRMQbaIOOWZpEQ2BMheVMKvtesHnf8qkZItrqXUGyqjcS
         AVBe7IjiOrrgI5muU/6BP4TRElV5nAonIhpQ8laQ=
Date:   Tue, 29 Jun 2021 08:24:39 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     longli@linuxonhyperv.com
Cc:     linux-kernel@vger.kernel.org, linux-hyperv@vger.kernel.org,
        Long Li <longli@microsoft.com>,
        Jonathan Corbet <corbet@lwn.net>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Maximilian Luz <luzmaximilian@gmail.com>,
        Mike Rapoport <rppt@kernel.org>,
        Ben Widawsky <ben.widawsky@intel.com>,
        Jiri Slaby <jirislaby@kernel.org>,
        Andra Paraschiv <andraprs@amazon.com>,
        Siddharth Gupta <sidgup@codeaurora.org>,
        Hannes Reinecke <hare@suse.de>, linux-doc@vger.kernel.org
Subject: Re: [Patch v2 2/3] Drivers: hv: add Azure Blob driver
Message-ID: <YNq8p1320VkH2T/c@kroah.com>
References: <1624689020-9589-1-git-send-email-longli@linuxonhyperv.com>
 <1624689020-9589-3-git-send-email-longli@linuxonhyperv.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1624689020-9589-3-git-send-email-longli@linuxonhyperv.com>
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Fri, Jun 25, 2021 at 11:30:19PM -0700, longli@linuxonhyperv.com wrote:
> +#ifdef CONFIG_DEBUG_FS
> +struct dentry *az_blob_debugfs_root;
> +#endif

No need to keep this dentry, just look it up if you need it.

> +
> +static struct az_blob_device az_blob_dev;
> +
> +static int az_blob_ringbuffer_size = (128 * 1024);
> +module_param(az_blob_ringbuffer_size, int, 0444);
> +MODULE_PARM_DESC(az_blob_ringbuffer_size, "Ring buffer size (bytes)");

This is NOT the 1990's, please do not create new module parameters.
Just make this work properly for everyone.

> +#define AZ_ERR 0
> +#define AZ_WARN 1
> +#define AZ_DBG 2
> +static int log_level = AZ_ERR;
> +module_param(log_level, int, 0644);
> +MODULE_PARM_DESC(log_level,
> +	"Log level: 0 - Error (default), 1 - Warning, 2 - Debug.");

A single driver does not need a special debug/log level, use the
system-wide functions and all will "just work"

> +
> +static uint device_queue_depth = 1024;
> +module_param(device_queue_depth, uint, 0444);
> +MODULE_PARM_DESC(device_queue_depth,
> +	"System level max queue depth for this device");
> +
> +#define az_blob_log(level, fmt, args...)	\
> +do {	\
> +	if (level <= log_level)	\
> +		pr_err("%s:%d " fmt, __func__, __LINE__, ##args);	\
> +} while (0)
> +
> +#define az_blob_dbg(fmt, args...) az_blob_log(AZ_DBG, fmt, ##args)
> +#define az_blob_warn(fmt, args...) az_blob_log(AZ_WARN, fmt, ##args)
> +#define az_blob_err(fmt, args...) az_blob_log(AZ_ERR, fmt, ##args)

Again, no.

Just use dev_dbg(), dev_warn(), and dev_err() and there is no need for
anything "special".  This is just one tiny driver, do not rewrite logic
like this for no reason.

> +static void az_blob_remove_device(struct az_blob_device *dev)
> +{
> +	wait_event(dev->file_wait, list_empty(&dev->file_list));
> +	misc_deregister(&az_blob_misc_device);
> +#ifdef CONFIG_DEBUG_FS

No need for the #ifdef.

> +	debugfs_remove_recursive(az_blob_debugfs_root);
> +#endif
> +	/* At this point, we won't get any requests from user-mode */
> +}
> +
> +static int az_blob_create_device(struct az_blob_device *dev)
> +{
> +	int rc;
> +	struct dentry *d;
> +
> +	rc = misc_register(&az_blob_misc_device);
> +	if (rc) {
> +		az_blob_err("misc_register failed rc %d\n", rc);
> +		return rc;
> +	}
> +
> +#ifdef CONFIG_DEBUG_FS

No need for the #ifdef

> +	az_blob_debugfs_root = debugfs_create_dir("az_blob", NULL);
> +	if (!IS_ERR_OR_NULL(az_blob_debugfs_root)) {

No need to check this.

> +		d = debugfs_create_file("pending_requests", 0400,
> +			az_blob_debugfs_root, NULL,
> +			&az_blob_debugfs_fops);
> +		if (IS_ERR_OR_NULL(d)) {

How can that be NULL?

No need to ever check any debugfs calls, please just make them and move
on.

thanks,

greg k-h
