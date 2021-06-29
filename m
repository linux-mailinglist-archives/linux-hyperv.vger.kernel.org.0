Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE2863B6F97
	for <lists+linux-hyperv@lfdr.de>; Tue, 29 Jun 2021 10:43:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232429AbhF2Ipf (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 29 Jun 2021 04:45:35 -0400
Received: from mail-ed1-f48.google.com ([209.85.208.48]:35674 "EHLO
        mail-ed1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232401AbhF2Ipf (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 29 Jun 2021 04:45:35 -0400
Received: by mail-ed1-f48.google.com with SMTP id df12so30204705edb.2;
        Tue, 29 Jun 2021 01:43:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=vr9wv3OGfZSryviafokTMo7ZyJHMYGFWE5upUcJfT6g=;
        b=Uz4CMLbxX6eoqXBOqtxElSJkTOrgh6V0tphBTvlAuHRFV88vah7RxXRcpi7amg7tOq
         jOy2WIp9/NTTJzq+VT6z44pMrghqmwh5aFuHoyZUQ8ai7EaWQjLam/JB/LyWXlRUdDNn
         Xer9SXUeX+C+2ikVuwOwZ1v5TFVyFkth0WH9JCCpjJakKmRDhaOR/gZ2T8BsrFn0VU0k
         RYmXytxyTcWd55gUw3iQv8SE1709/Z33pP8Xqma8b4dxOuoNU8mPVNRcjXq/a106y1gn
         GfF0vyR4C0OMQA77UedqnqLfVXIggyirFXJ7bOCtNbL+/B6ca0XE4jOl6vKR430s6dfE
         FXbg==
X-Gm-Message-State: AOAM5330GqqGkgIs77iqfT9/57s7a0/i6M7ktDV0I/q3pLgkMsNvJHIC
        lW7Dq0abJzrcj36/2qgzMgKHjBBswpO6Nw==
X-Google-Smtp-Source: ABdhPJzLc2HwWhEsTCwtnIcTW1x53+fUQkhioghQMxKM6EYv525La+1RWENlgbXjHHFqo8Dk65LMpQ==
X-Received: by 2002:aa7:c54b:: with SMTP id s11mr29079920edr.373.1624956185789;
        Tue, 29 Jun 2021 01:43:05 -0700 (PDT)
Received: from ?IPv6:2a0b:e7c0:0:107::49? ([2a0b:e7c0:0:107::49])
        by smtp.gmail.com with ESMTPSA id c23sm10917610eds.57.2021.06.29.01.43.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Jun 2021 01:43:05 -0700 (PDT)
Subject: Re: [Patch v2 2/3] Drivers: hv: add Azure Blob driver
To:     longli@linuxonhyperv.com, linux-kernel@vger.kernel.org,
        linux-hyperv@vger.kernel.org
Cc:     Long Li <longli@microsoft.com>, Jonathan Corbet <corbet@lwn.net>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Maximilian Luz <luzmaximilian@gmail.com>,
        Mike Rapoport <rppt@kernel.org>,
        Ben Widawsky <ben.widawsky@intel.com>,
        Andra Paraschiv <andraprs@amazon.com>,
        Siddharth Gupta <sidgup@codeaurora.org>,
        Hannes Reinecke <hare@suse.de>, linux-doc@vger.kernel.org
References: <1624689020-9589-1-git-send-email-longli@linuxonhyperv.com>
 <1624689020-9589-3-git-send-email-longli@linuxonhyperv.com>
From:   Jiri Slaby <jirislaby@kernel.org>
Message-ID: <f5155516-4054-459a-c23c-a787fa429e5e@kernel.org>
Date:   Tue, 29 Jun 2021 10:43:03 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <1624689020-9589-3-git-send-email-longli@linuxonhyperv.com>
Content-Type: text/plain; charset=iso-8859-2; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On 26. 06. 21, 8:30, longli@linuxonhyperv.com wrote:
> Azure Blob storage provides scalable and durable data storage for Azure.
> (https://azure.microsoft.com/en-us/services/storage/blobs/)
> 
> This driver adds support for accelerated access to Azure Blob storage. As an
> alternative to REST APIs, it provides a fast data path that uses host native
> network stack and secure direct data link for storage server access.
> 
...
> Cc: Jiri Slaby <jirislaby@kernel.org>

I am just curious, why am I CCed? Anyway, some comments below:

> --- /dev/null
> +++ b/drivers/hv/azure_blob.c
> @@ -0,0 +1,655 @@
...
> +static void az_blob_on_channel_callback(void *context)
> +{
> +	struct vmbus_channel *channel = (struct vmbus_channel *)context;

Have you fed this patch through checkpatch?

> +	const struct vmpacket_descriptor *desc;
> +
> +	az_blob_dbg("entering interrupt from vmbus\n");
> +	foreach_vmbus_pkt(desc, channel) {
> +		struct az_blob_vsp_request_ctx *request_ctx;
> +		struct az_blob_vsp_response *response;
> +		u64 cmd_rqst = vmbus_request_addr(&channel->requestor,
> +					desc->trans_id);
> +		if (cmd_rqst == VMBUS_RQST_ERROR) {
> +			az_blob_err("incorrect transaction id %llu\n",
> +				desc->trans_id);
> +			continue;
> +		}
> +		request_ctx = (struct az_blob_vsp_request_ctx *) cmd_rqst;
> +		response = hv_pkt_data(desc);
> +
> +		az_blob_dbg("got response for request %pUb status %u "
> +			"response_len %u\n",
> +			&request_ctx->request->guid, response->error,
> +			response->response_len);
> +		request_ctx->request->response.status = response->error;
> +		request_ctx->request->response.response_len =
> +			response->response_len;
> +		complete(&request_ctx->wait_vsp);
> +	}
> +
> +}
...
> +static long az_blob_ioctl_user_request(struct file *filp, unsigned long arg)
> +{
> +	struct az_blob_device *dev = &az_blob_dev;
> +	struct az_blob_file_ctx *file_ctx = filp->private_data;
> +	char __user *argp = (char __user *) arg;
> +	struct az_blob_request_sync request;
> +	struct az_blob_vsp_request_ctx request_ctx;
> +	unsigned long flags;
> +	int ret;
> +	size_t request_start, request_num_pages = 0;
> +	size_t response_start, response_num_pages = 0;
> +	size_t data_start, data_num_pages = 0, total_num_pages;
> +	struct page **request_pages = NULL, **response_pages = NULL;
> +	struct page **data_pages = NULL;
> +	struct vmbus_packet_mpb_array *desc;
> +	u64 *pfn_array;
> +	int desc_size;
> +	int page_idx;
> +	struct az_blob_vsp_request *vsp_request;

Ugh, see further.

> +
> +	/* Fast fail if device is being removed */
> +	if (dev->removing)
> +		return -ENODEV;
> +
> +	if (!az_blob_safe_file_access(filp)) {
> +		az_blob_dbg("process %d(%s) changed security contexts after"
> +			" opening file descriptor\n",
> +			task_tgid_vnr(current), current->comm);
> +		return -EACCES;
> +	}
> +
> +	if (copy_from_user(&request, argp, sizeof(request))) {
> +		az_blob_dbg("don't have permission to user provided buffer\n");
> +		return -EFAULT;
> +	}
> +
> +	az_blob_dbg("az_blob ioctl request guid %pUb timeout %u request_len %u"
> +		" response_len %u data_len %u request_buffer %llx "
> +		"response_buffer %llx data_buffer %llx\n",
> +		&request.guid, request.timeout, request.request_len,
> +		request.response_len, request.data_len, request.request_buffer,
> +		request.response_buffer, request.data_buffer);
> +
> +	if (!request.request_len || !request.response_len)
> +		return -EINVAL;
> +
> +	if (request.data_len && request.data_len < request.data_valid)
> +		return -EINVAL;
> +
> +	init_completion(&request_ctx.wait_vsp);
> +	request_ctx.request = &request;
> +
> +	/*
> +	 * Need to set rw to READ to have page table set up for passing to VSP.
> +	 * Setting it to WRITE will cause the page table entry not allocated
> +	 * as it's waiting on Copy-On-Write on next page fault. This doesn't
> +	 * work in this scenario because VSP wants all the pages to be present.
> +	 */
> +	ret = get_buffer_pages(READ, (void __user *) request.request_buffer,

Does this need __force for sparse not to complain?

> +		request.request_len, &request_pages, &request_start,
> +		&request_num_pages);
> +	if (ret)
> +		goto get_user_page_failed;
> +
> +	ret = get_buffer_pages(READ, (void __user *) request.response_buffer,
> +		request.response_len, &response_pages, &response_start,
> +		&response_num_pages);
> +	if (ret)
> +		goto get_user_page_failed;
> +
> +	if (request.data_len) {
> +		ret = get_buffer_pages(READ,
> +			(void __user *) request.data_buffer, request.data_len,
> +			&data_pages, &data_start, &data_num_pages);
> +		if (ret)
> +			goto get_user_page_failed;
> +	}
> +
> +	total_num_pages = request_num_pages + response_num_pages +
> +				data_num_pages;
> +	if (total_num_pages > AZ_BLOB_MAX_PAGES) {
> +		az_blob_dbg("number of DMA pages %lu buffer exceeding %u\n",
> +			total_num_pages, AZ_BLOB_MAX_PAGES);
> +		ret = -EINVAL;
> +		goto get_user_page_failed;
> +	}
> +
> +	/* Construct a VMBUS packet and send it over to VSP */
> +	desc_size = sizeof(struct vmbus_packet_mpb_array) +
> +			sizeof(u64) * total_num_pages;
> +	desc = kzalloc(desc_size, GFP_KERNEL);

Smells like a call for struct_size().

> +	vsp_request = kzalloc(sizeof(*vsp_request), GFP_KERNEL);
> +	if (!desc || !vsp_request) {
> +		kfree(desc);
> +		kfree(vsp_request);
> +		ret = -ENOMEM;
> +		goto get_user_page_failed;
> +	}
> +
> +	desc->range.offset = 0;
> +	desc->range.len = total_num_pages * PAGE_SIZE;
> +	pfn_array = desc->range.pfn_array;
> +	page_idx = 0;
> +
> +	if (request.data_len) {
> +		fill_in_page_buffer(pfn_array, &page_idx, data_pages,
> +			data_num_pages);
> +		vsp_request->data_buffer_offset = data_start;
> +		vsp_request->data_buffer_length = request.data_len;
> +		vsp_request->data_buffer_valid = request.data_valid;
> +	}
> +
> +	fill_in_page_buffer(pfn_array, &page_idx, request_pages,
> +		request_num_pages);
> +	vsp_request->request_buffer_offset = request_start +
> +						data_num_pages * PAGE_SIZE;
> +	vsp_request->request_buffer_length = request.request_len;
> +
> +	fill_in_page_buffer(pfn_array, &page_idx, response_pages,
> +		response_num_pages);
> +	vsp_request->response_buffer_offset = response_start +
> +		(data_num_pages + request_num_pages) * PAGE_SIZE;
> +	vsp_request->response_buffer_length = request.response_len;
> +
> +	vsp_request->version = 0;
> +	vsp_request->timeout_ms = request.timeout;
> +	vsp_request->operation_type = AZ_BLOB_DRIVER_USER_REQUEST;
> +	guid_copy(&vsp_request->transaction_id, &request.guid);
> +
> +	spin_lock_irqsave(&file_ctx->vsp_pending_lock, flags);
> +	list_add_tail(&request_ctx.list, &file_ctx->vsp_pending_requests);
> +	spin_unlock_irqrestore(&file_ctx->vsp_pending_lock, flags);
> +
> +	az_blob_dbg("sending request to VSP\n");
> +	az_blob_dbg("desc_size %u desc->range.len %u desc->range.offset %u\n",
> +		desc_size, desc->range.len, desc->range.offset);
> +	az_blob_dbg("vsp_request data_buffer_offset %u data_buffer_length %u "
> +		"data_buffer_valid %u request_buffer_offset %u "
> +		"request_buffer_length %u response_buffer_offset %u "
> +		"response_buffer_length %u\n",
> +		vsp_request->data_buffer_offset,
> +		vsp_request->data_buffer_length,
> +		vsp_request->data_buffer_valid,
> +		vsp_request->request_buffer_offset,
> +		vsp_request->request_buffer_length,
> +		vsp_request->response_buffer_offset,
> +		vsp_request->response_buffer_length);
> +
> +	ret = vmbus_sendpacket_mpb_desc(dev->device->channel, desc, desc_size,
> +		vsp_request, sizeof(*vsp_request), (u64) &request_ctx);
> +
> +	kfree(desc);
> +	kfree(vsp_request);
> +	if (ret)
> +		goto vmbus_send_failed;
> +
> +	wait_for_completion(&request_ctx.wait_vsp);

Provided this is ioctl, this should likely be interruptible. You don't 
want to account to I/O load. The same likely for az_blob_fop_release.

> +
> +	/*
> +	 * At this point, the response is already written to request
> +	 * by VMBUS completion handler, copy them to user-mode buffers
> +	 * and return to user-mode
> +	 */
> +	if (copy_to_user(argp +
> +			offsetof(struct az_blob_request_sync,
> +				response.status),
> +			&request.response.status,

This is ugly, why don't you make argp the appropriate pointer instead of 
char *? You'd need not do copy_to_user twice then, right?

> +			sizeof(request.response.status))) {
> +		ret = -EFAULT;
> +		goto vmbus_send_failed;
> +	}
> +
> +	if (copy_to_user(argp +
> +			offsetof(struct az_blob_request_sync,
> +				response.response_len),

The same here.

> +			&request.response.response_len,
> +			sizeof(request.response.response_len)))
> +		ret = -EFAULT;
> +
> +vmbus_send_failed:
> +	spin_lock_irqsave(&file_ctx->vsp_pending_lock, flags);
> +	list_del(&request_ctx.list);
> +	if (list_empty(&file_ctx->vsp_pending_requests))
> +		wake_up(&file_ctx->wait_vsp_pending);
> +	spin_unlock_irqrestore(&file_ctx->vsp_pending_lock, flags);
> +
> +get_user_page_failed:
> +	free_buffer_pages(request_num_pages, request_pages);
> +	free_buffer_pages(response_num_pages, response_pages);
> +	free_buffer_pages(data_num_pages, data_pages);
> +
> +	return ret;
> +}

This function is overly long. Care to split it (e.g. moving away the 
initialization of the structs and the debug stuff)?

> +
> +static long az_blob_fop_ioctl(struct file *filp, unsigned int cmd,
> +	unsigned long arg)
> +{
> +	long ret = -EIO;

EINVAL would be more appropriate.

> +
> +	switch (cmd) {
> +	case IOCTL_AZ_BLOB_DRIVER_USER_REQUEST:
> +		if (_IOC_SIZE(cmd) != sizeof(struct az_blob_request_sync))
> +			return -EINVAL;

How can that happen, provided the switch (cmd) and case?

> +		ret = az_blob_ioctl_user_request(filp, arg);
> +		break;

Simply:
return az_blob_ioctl_user_request(filp, arg);

> +
> +	default:
> +		az_blob_dbg("unrecognized IOCTL code %u\n", cmd);
> +	}
> +
> +	return ret;

So return -EINVAL here directly now.

> +}
...
> +static int az_blob_connect_to_vsp(struct hv_device *device, u32 ring_size)
> +{
> +	int ret;
...
> +	int rc;


Sometimes ret, sometimes rc, could you unify the two?

> +static int __init az_blob_drv_init(void)
> +{
> +	int ret;
> +
> +	ret = vmbus_driver_register(&az_blob_drv);
> +	return ret;

Simply:
return vmbus_driver_register(&az_blob_drv);

regards,
-- 
-- 
js
suse labs
