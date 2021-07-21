Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A2953D0813
	for <lists+linux-hyperv@lfdr.de>; Wed, 21 Jul 2021 07:09:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231139AbhGUE2V (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 21 Jul 2021 00:28:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:45718 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231706AbhGUE2S (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 21 Jul 2021 00:28:18 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id BC94F60FED;
        Wed, 21 Jul 2021 05:08:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1626844134;
        bh=8xr7SyJ/SR+q3zattaqRhO8P9X6cQlSVhvKXj24mG14=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=glJ5go50QoloMAjuogRswx0DYYhRGv87+a6Spv0UB5uTfI2h/tHCRC4ufEPmotwkF
         htVW/51PPjwaj3G4bOeMIrCxdQpXl0Xi9KJ2NxNV54M5WQHNiuoeqVCXeNsBMKMv6I
         5/NeHcjzJlZqglMsYQ3sJgh7q6Tz4Q/UR7rwbD7Y=
Date:   Wed, 21 Jul 2021 07:08:51 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Long Li <longli@microsoft.com>
Cc:     "longli@linuxonhyperv.com" <longli@linuxonhyperv.com>,
        "linux-fs@vger.kernel.org" <linux-fs@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Hans de Goede <hdegoede@redhat.com>,
        "Williams, Dan J" <dan.j.williams@intel.com>,
        Maximilian Luz <luzmaximilian@gmail.com>,
        Mike Rapoport <rppt@kernel.org>,
        Ben Widawsky <ben.widawsky@intel.com>,
        Jiri Slaby <jirislaby@kernel.org>,
        Andra Paraschiv <andraprs@amazon.com>,
        Siddharth Gupta <sidgup@codeaurora.org>,
        Hannes Reinecke <hare@suse.de>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>
Subject: Re: [Patch v4 2/3] Drivers: hv: add Azure Blob driver
Message-ID: <YPer41ckT5njYW4G@kroah.com>
References: <1626751866-15765-1-git-send-email-longli@linuxonhyperv.com>
 <1626751866-15765-3-git-send-email-longli@linuxonhyperv.com>
 <YPZ8hX7sx1RFL0c5@kroah.com>
 <BY5PR21MB1506A52AD22240E22A0D6DE5CEE29@BY5PR21MB1506.namprd21.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BY5PR21MB1506A52AD22240E22A0D6DE5CEE29@BY5PR21MB1506.namprd21.prod.outlook.com>
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Tue, Jul 20, 2021 at 07:57:56PM +0000, Long Li wrote:
> > Subject: Re: [Patch v4 2/3] Drivers: hv: add Azure Blob driver
> > 
> > On Mon, Jul 19, 2021 at 08:31:05PM -0700, longli@linuxonhyperv.com wrote:
> > > +struct az_blob_device {
> > > +	struct hv_device *device;
> > > +
> > > +	/* Opened files maintained by this device */
> > > +	struct list_head file_list;
> > > +	/* Lock for protecting file_list */
> > > +	spinlock_t file_lock;
> > > +
> > > +	/* The refcount for this device */
> > > +	refcount_t count;
> > 
> > Just use a kref please if you really need this.  Are you sure you do?
> > You already have 2 other reference counted objects being used here, why make
> > it 3?
> 
> The "count" is to keep track how many user-mode instances and vmbus instance
> are opened on this device.

That will not work at all, sorry.  Please NEVER try to count "open"
calls to a driver, as the driver will never be told how many userspace
programs are accessing it at any time, nor should it even ever care.

Use the existing apis, there is no need to attempt to count this as you
will always get it wrong (hint, what happens when processes share file
descriptors...)

> Being a VMBUS device, this device can be removed 
> at any time (host servicing etc). We must remove the device when this happens
> even if the device is still opened by some user-mode program. The "count" will
> guarantee the lifecycle of the device object after all user-mode has released the device.

No it will not, just use the existing apis and all will be fine.

> I looked at using "file_list" (it's used for tracking opened files by user-mode) for this purpose, 
> but I found out I still need to manage the device count at the vmbus side. 

Again, you should not need this.  As proof, no other driver needs
this...

> > > +	/* Pending requests to VSP */
> > > +	atomic_t pending;
> > 
> > Why does this need to be atomic?
> 
> "pending' is per-device maintained that could change when multiple-user access
> the device at the same time.

How do you know this, and why does it matter?

> > > +	wait_queue_head_t waiting_to_drain;
> > > +
> > > +	bool removing;
> > 
> > Are you sure this actually works properly?  Why is it needed vs. any other misc
> > device?
> 
> When removing this device from vmbus, we need to guarantee there is no possible packets to
> vmbus.

Why?  Shouldn't the vmbus api handle this for you automatically?  Why is
this driver unique here?

> This is a requirement before calling vmbus_close(). Other drivers of vmbus follows
> the same procedure.

Ah.  Why not fix this in the vmbus core?  That sounds like extra logic
that everyone would have to duplicate for no good reason.

> The reason why this driver needs this is that the device removal can happen in the middle of
> az_blob_ioctl_user_request(), which can send packet over vmbus.

Sure, but the bus should handle that for you.

> > > +/* VSC->VSP request */
> > > +struct az_blob_vsp_request {
> > > +	u32 version;
> > > +	u32 timeout_ms;
> > > +	u32 data_buffer_offset;
> > > +	u32 data_buffer_length;
> > > +	u32 data_buffer_valid;
> > > +	u32 operation_type;
> > > +	u32 request_buffer_offset;
> > > +	u32 request_buffer_length;
> > > +	u32 response_buffer_offset;
> > > +	u32 response_buffer_length;
> > > +	guid_t transaction_id;
> > > +} __packed;
> > 
> > Why packed?  If this is going across the wire somewhere, you need to specify
> > the endian-ness of these values, right?  If this is not going across the wire, no
> > need for it to be packed.
> 
> Those data go through the wire.
> 
> All data structures specified in the Hyper-V and guest VM use Little Endian byte
> ordering.  All HV core drivers have a dependence on X86, that guarantees this
> ordering.

Then specify little endian please.

> > > +	struct completion wait_vsp;
> > > +	struct az_blob_request_sync *request; };
> > > +
> > > +struct az_blob_file_ctx {
> > > +	struct list_head list;
> > > +
> > > +	/* List of pending requests to VSP */
> > > +	struct list_head vsp_pending_requests;
> > > +	/* Lock for protecting vsp_pending_requests */
> > > +	spinlock_t vsp_pending_lock;
> > > +	wait_queue_head_t wait_vsp_pending;
> > > +
> > > +	pid_t pid;
> > 
> > Why do you need a pid?  What namespace is this pid in?
> 
> It's a request from user library team for production troubleshooting
> purposes. It's exposed as informal in debugfs.

Then it will be wrong.  Put all of your "debugging" stuff into one place
so it is obvious what it is for, and so that people can ignore it.

> > > +static int az_blob_probe(struct hv_device *device,
> > > +			 const struct hv_vmbus_device_id *dev_id) {
> > > +	int ret;
> > > +	struct az_blob_device *dev;
> > > +
> > > +	dev = kzalloc(sizeof(*dev), GFP_KERNEL);
> > > +	if (!dev)
> > > +		return -ENOMEM;
> > > +
> > > +	spin_lock_init(&dev->file_lock);
> > > +	INIT_LIST_HEAD(&dev->file_list);
> > > +	atomic_set(&dev->pending, 0);
> > > +	init_waitqueue_head(&dev->waiting_to_drain);
> > > +
> > > +	ret = az_blob_connect_to_vsp(device, dev, AZ_BLOB_RING_SIZE);
> > > +	if (ret)
> > > +		goto fail;
> > > +
> > > +	refcount_set(&dev->count, 1);
> > > +	az_blob_dev = dev;
> > > +
> > > +	// create user-mode client library facing device
> > > +	ret = az_blob_create_device(dev);
> > > +	if (ret) {
> > > +		dev_err(AZ_DEV, "failed to create device ret=%d\n", ret);
> > > +		az_blob_remove_vmbus(device);
> > > +		goto fail;
> > > +	}
> > > +
> > > +	dev_info(AZ_DEV, "successfully probed device\n");
> > 
> > When drivers are working properly, they should be quiet.
> 
> The reason is that in production environment when dealing with custom support
> cases, there is no good way to check if the channel is opened on the device. Having
> this message will greatly clear confusions on possible mis-configurations.

Again, no, the driver should be quiet.  If you REALLY need this type of
thing, the bus should be the one doing that type of notification for all
devices on the bus.  Do not make this a per-driver choice.

> > And what is with the AZ_DEV macro mess?
> 
> It's not required, it's just for saving code length. I can put "&az_blob_dev->device->device"
> in every dev_err(), but it makes the code look a lot longer.

Then perhaps your structures are not correct?  Please spell it out so
that we can see that your implementation needs fixing.

> > And can you handle more than one device in the system at one time?  I think
> > your debugfs logic will get really confused.
> 
> There can be one device object active in the system at any given time. The debugfs grabs
> the current active device object. If the device is being removed, removed or added, 
> the current active device object is updated accordingly.

If I remember, your debugfs initialization seems to not use the device
name, but rather a "driver" name, which implies that this is not going
to work well with multiple devices.  But I could be wrong.

thanks,

greg k-h
