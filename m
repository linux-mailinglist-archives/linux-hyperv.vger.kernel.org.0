Return-Path: <linux-hyperv+bounces-3364-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D70FE9D9B80
	for <lists+linux-hyperv@lfdr.de>; Tue, 26 Nov 2024 17:34:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9831B286AD5
	for <lists+linux-hyperv@lfdr.de>; Tue, 26 Nov 2024 16:34:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D69101D8A10;
	Tue, 26 Nov 2024 16:34:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="sUnItZTN"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 520DA1D63CA;
	Tue, 26 Nov 2024 16:34:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732638841; cv=none; b=OY+LNlhmYn5iFkmf1cEd64AFVclaKayUdUpwPKoDqld/71aOGxx4GugX5bukwAdqAeIW77gJfwGZB0Q3cDFbYgCmOwsdQS1aYBerc3F/vtJTGJbwbG10qx4QI2gp1Wo/47Xa53f9TAtuNnrDGUp2Pw4GXB5yMdmIuwZlukqWmfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732638841; c=relaxed/simple;
	bh=x+nQwHusXpcnj31rvF2k2BWPkCdcVU2fjxLJ1YARKGI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HTAFiy/d231U14vorSlbxeP41fqhTUPq4LfiiLDuNCFcQaeQopSVlcI2KYvALRiW3WqSsOXesMglT6fx19YyczKYwyMyKkn8ya2mQNcEZiHF5s7n8SGBwGHQo37OojlK6ORlYqGJ0GSnddsw5xAShnINEOPANNN87SQ6YXM/eQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=sUnItZTN; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1127)
	id 0B48720545A9; Tue, 26 Nov 2024 08:33:54 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 0B48720545A9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1732638834;
	bh=vzU0D9wWMC/jVMbki8859Mj7Ksvs6U9VGwiazMGudQ0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sUnItZTNiFwekERdEZYDS58A3ZztX9J9J1mRV89cgZG/+pMpYkD9USPSFj0AqrRDz
	 6+is2Fzc3oEfuYYFr1eWV2XqXvWIQIJMoptdcemsBxkxn1lfL4jilFLgZNz728aBM9
	 mU/xI8FtUCX4aM34UjykWXssNgBqpuk7ODDP0ido=
Date: Tue, 26 Nov 2024 08:33:54 -0800
From: Saurabh Singh Sengar <ssengar@linux.microsoft.com>
To: Naman Jain <namjain@linux.microsoft.com>
Cc: "K . Y . Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] uio_hv_generic: Add a check for HV_NIC for send, receive
 buffers setup
Message-ID: <20241126163354.GA5185@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <20241125125015.1500-1-namjain@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241125125015.1500-1-namjain@linux.microsoft.com>
User-Agent: Mutt/1.5.21 (2010-09-15)

On Mon, Nov 25, 2024 at 12:50:15PM +0000, Naman Jain wrote:
> Support for send and receive buffers was added for networking usecases
> in UIO devices. There is no known usecase of these buffers for devices
> other than HV_NIC. Add a check for HV_NIC in probe function to avoid
> memory allocation and GPADL setup which would save 47 MB memory per
> device type.

Thanks for the patch. How about rephrasing the commit message like this:

Receive and send buffer allocation was originally introduced to support
DPDK's networking use case. These buffer sizes were further increased to
meet DPDK performance requirements. However, these large buffers are
unnecessary for any other UIO use cases.

Restrict the allocation of receive and send buffers only for HV_NIC device
type, saving 47 MB of memory per device.

> 
> While at it, fix some of the syntax related issues in the touched code
> which are reported by "--strict" option of checkpatch.
> 
> Signed-off-by: Naman Jain <namjain@linux.microsoft.com>
> ---
>  drivers/uio/uio_hv_generic.c | 86 ++++++++++++++++++------------------
>  1 file changed, 43 insertions(+), 43 deletions(-)
> 
> diff --git a/drivers/uio/uio_hv_generic.c b/drivers/uio/uio_hv_generic.c
> index 3976360d0096..1b19b5647495 100644
> --- a/drivers/uio/uio_hv_generic.c
> +++ b/drivers/uio/uio_hv_generic.c
> @@ -296,51 +296,51 @@ hv_uio_probe(struct hv_device *dev,
>  	pdata->info.mem[MON_PAGE_MAP].size = PAGE_SIZE;
>  	pdata->info.mem[MON_PAGE_MAP].memtype = UIO_MEM_LOGICAL;
>  
> -	pdata->recv_buf = vzalloc(RECV_BUFFER_SIZE);
> -	if (pdata->recv_buf == NULL) {
> -		ret = -ENOMEM;
> -		goto fail_free_ring;
> +	if (channel->device_id == HV_NIC) {
> +		pdata->recv_buf = vzalloc(RECV_BUFFER_SIZE);
> +		if (!pdata->recv_buf) {
> +			ret = -ENOMEM;
> +			goto fail_free_ring;
> +		}
> +
> +		ret = vmbus_establish_gpadl(channel, pdata->recv_buf,
> +					    RECV_BUFFER_SIZE, &pdata->recv_gpadl);
> +		if (ret) {
> +			if (!pdata->recv_gpadl.decrypted)
> +				vfree(pdata->recv_buf);
> +			goto fail_close;
> +		}
> +
> +		/* put Global Physical Address Label in name */
> +		snprintf(pdata->recv_name, sizeof(pdata->recv_name),
> +			 "recv:%u", pdata->recv_gpadl.gpadl_handle);
> +		pdata->info.mem[RECV_BUF_MAP].name = pdata->recv_name;
> +		pdata->info.mem[RECV_BUF_MAP].addr = (uintptr_t)pdata->recv_buf;
> +		pdata->info.mem[RECV_BUF_MAP].size = RECV_BUFFER_SIZE;
> +		pdata->info.mem[RECV_BUF_MAP].memtype = UIO_MEM_VIRTUAL;
> +
> +		pdata->send_buf = vzalloc(SEND_BUFFER_SIZE);
> +		if (!pdata->send_buf) {
> +			ret = -ENOMEM;
> +			goto fail_close;
> +		}
> +
> +		ret = vmbus_establish_gpadl(channel, pdata->send_buf,
> +					    SEND_BUFFER_SIZE, &pdata->send_gpadl);
> +		if (ret) {
> +			if (!pdata->send_gpadl.decrypted)
> +				vfree(pdata->send_buf);
> +			goto fail_close;
> +		}
> +
> +		snprintf(pdata->send_name, sizeof(pdata->send_name),
> +			 "send:%u", pdata->send_gpadl.gpadl_handle);
> +		pdata->info.mem[SEND_BUF_MAP].name = pdata->send_name;
> +		pdata->info.mem[SEND_BUF_MAP].addr = (uintptr_t)pdata->send_buf;
> +		pdata->info.mem[SEND_BUF_MAP].size = SEND_BUFFER_SIZE;
> +		pdata->info.mem[SEND_BUF_MAP].memtype = UIO_MEM_VIRTUAL;
>  	}
>  
> -	ret = vmbus_establish_gpadl(channel, pdata->recv_buf,
> -				    RECV_BUFFER_SIZE, &pdata->recv_gpadl);
> -	if (ret) {
> -		if (!pdata->recv_gpadl.decrypted)
> -			vfree(pdata->recv_buf);
> -		goto fail_close;
> -	}
> -
> -	/* put Global Physical Address Label in name */
> -	snprintf(pdata->recv_name, sizeof(pdata->recv_name),
> -		 "recv:%u", pdata->recv_gpadl.gpadl_handle);
> -	pdata->info.mem[RECV_BUF_MAP].name = pdata->recv_name;
> -	pdata->info.mem[RECV_BUF_MAP].addr
> -		= (uintptr_t)pdata->recv_buf;
> -	pdata->info.mem[RECV_BUF_MAP].size = RECV_BUFFER_SIZE;
> -	pdata->info.mem[RECV_BUF_MAP].memtype = UIO_MEM_VIRTUAL;
> -
> -	pdata->send_buf = vzalloc(SEND_BUFFER_SIZE);
> -	if (pdata->send_buf == NULL) {
> -		ret = -ENOMEM;
> -		goto fail_close;
> -	}
> -
> -	ret = vmbus_establish_gpadl(channel, pdata->send_buf,
> -				    SEND_BUFFER_SIZE, &pdata->send_gpadl);
> -	if (ret) {
> -		if (!pdata->send_gpadl.decrypted)
> -			vfree(pdata->send_buf);
> -		goto fail_close;
> -	}
> -
> -	snprintf(pdata->send_name, sizeof(pdata->send_name),
> -		 "send:%u", pdata->send_gpadl.gpadl_handle);
> -	pdata->info.mem[SEND_BUF_MAP].name = pdata->send_name;
> -	pdata->info.mem[SEND_BUF_MAP].addr
> -		= (uintptr_t)pdata->send_buf;
> -	pdata->info.mem[SEND_BUF_MAP].size = SEND_BUFFER_SIZE;
> -	pdata->info.mem[SEND_BUF_MAP].memtype = UIO_MEM_VIRTUAL;
> -
>  	pdata->info.priv = pdata;
>  	pdata->device = dev;
>  
> 
> base-commit: 85a2dd7d7c8152cb125712a1ecae1d0a6ccac250

overall change looks good to me.

- Saurabh

