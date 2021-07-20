Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F35D53CF722
	for <lists+linux-hyperv@lfdr.de>; Tue, 20 Jul 2021 11:45:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232210AbhGTJFL (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 20 Jul 2021 05:05:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:52226 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231491AbhGTJFH (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 20 Jul 2021 05:05:07 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 53DE660230;
        Tue, 20 Jul 2021 09:45:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1626774345;
        bh=GzkEUvsF5I5Iycp8XGCl9JHLEk0fziZZjrZebdcBdS4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BHk1PR2WKGPlC01tvbAK5JcCGeBmZIyL3xY0HhPCKsiCgP0oSU/fYN48n7gfvWos8
         wBhCWul17l02+z/Ob+8+UIVcBTaQmwBNJCchE2NvrB+BkaoHgjdhiFRCFaHsol7Yyc
         Q3cJzR/E1/0kjSZ+lQScy3+ZsbIdT5YyOgLpMdns=
Date:   Tue, 20 Jul 2021 09:34:29 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     longli@linuxonhyperv.com
Cc:     linux-fs@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hyperv@vger.kernel.org,
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
Subject: Re: [Patch v4 2/3] Drivers: hv: add Azure Blob driver
Message-ID: <YPZ8hX7sx1RFL0c5@kroah.com>
References: <1626751866-15765-1-git-send-email-longli@linuxonhyperv.com>
 <1626751866-15765-3-git-send-email-longli@linuxonhyperv.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1626751866-15765-3-git-send-email-longli@linuxonhyperv.com>
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Mon, Jul 19, 2021 at 08:31:05PM -0700, longli@linuxonhyperv.com wrote:
> +struct az_blob_device {
> +	struct hv_device *device;
> +
> +	/* Opened files maintained by this device */
> +	struct list_head file_list;
> +	/* Lock for protecting file_list */
> +	spinlock_t file_lock;
> +
> +	/* The refcount for this device */
> +	refcount_t count;

Just use a kref please if you really need this.  Are you sure you do?
You already have 2 other reference counted objects being used here, why
make it 3?

> +	/* Pending requests to VSP */
> +	atomic_t pending;

Why does this need to be atomic?


> +	wait_queue_head_t waiting_to_drain;
> +
> +	bool removing;

Are you sure this actually works properly?  Why is it needed vs. any
other misc device?


> +/* VSC->VSP request */
> +struct az_blob_vsp_request {
> +	u32 version;
> +	u32 timeout_ms;
> +	u32 data_buffer_offset;
> +	u32 data_buffer_length;
> +	u32 data_buffer_valid;
> +	u32 operation_type;
> +	u32 request_buffer_offset;
> +	u32 request_buffer_length;
> +	u32 response_buffer_offset;
> +	u32 response_buffer_length;
> +	guid_t transaction_id;
> +} __packed;

Why packed?  If this is going across the wire somewhere, you need to
specify the endian-ness of these values, right?  If this is not going
across the wire, no need for it to be packed.

> +
> +/* VSP->VSC response */
> +struct az_blob_vsp_response {
> +	u32 length;
> +	u32 error;
> +	u32 response_len;
> +} __packed;

Same here.

> +
> +struct az_blob_vsp_request_ctx {
> +	struct list_head list;
> +	struct completion wait_vsp;
> +	struct az_blob_request_sync *request;
> +};
> +
> +struct az_blob_file_ctx {
> +	struct list_head list;
> +
> +	/* List of pending requests to VSP */
> +	struct list_head vsp_pending_requests;
> +	/* Lock for protecting vsp_pending_requests */
> +	spinlock_t vsp_pending_lock;
> +	wait_queue_head_t wait_vsp_pending;
> +
> +	pid_t pid;

Why do you need a pid?  What namespace is this pid in?

> +static int az_blob_probe(struct hv_device *device,
> +			 const struct hv_vmbus_device_id *dev_id)
> +{
> +	int ret;
> +	struct az_blob_device *dev;
> +
> +	dev = kzalloc(sizeof(*dev), GFP_KERNEL);
> +	if (!dev)
> +		return -ENOMEM;
> +
> +	spin_lock_init(&dev->file_lock);
> +	INIT_LIST_HEAD(&dev->file_list);
> +	atomic_set(&dev->pending, 0);
> +	init_waitqueue_head(&dev->waiting_to_drain);
> +
> +	ret = az_blob_connect_to_vsp(device, dev, AZ_BLOB_RING_SIZE);
> +	if (ret)
> +		goto fail;
> +
> +	refcount_set(&dev->count, 1);
> +	az_blob_dev = dev;
> +
> +	// create user-mode client library facing device
> +	ret = az_blob_create_device(dev);
> +	if (ret) {
> +		dev_err(AZ_DEV, "failed to create device ret=%d\n", ret);
> +		az_blob_remove_vmbus(device);
> +		goto fail;
> +	}
> +
> +	dev_info(AZ_DEV, "successfully probed device\n");

When drivers are working properly, they should be quiet.

And what is with the AZ_DEV macro mess?

And can you handle more than one device in the system at one time?  I
think your debugfs logic will get really confused.

thanks,

greg k-h
