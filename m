Return-Path: <linux-hyperv+bounces-3711-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 907E5A157F8
	for <lists+linux-hyperv@lfdr.de>; Fri, 17 Jan 2025 20:12:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BF48716492B
	for <lists+linux-hyperv@lfdr.de>; Fri, 17 Jan 2025 19:12:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD9801A9B23;
	Fri, 17 Jan 2025 19:11:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="THkOS3Bo"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51E421A239F;
	Fri, 17 Jan 2025 19:11:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737141095; cv=none; b=Ype/7UQ96hl3kUuzypLsrb6ZPHpzDz55KHtmcKY2BulfKQj1Ju0x/mAISem/9OTwos2idUSU6C1zckdvUwZonksCvBWVDW4YWJEpLBBwrxscHzuZ9WGNRfXwstnFyBfn3c/1k4wx0/lMDpXcvcsvDxE/kryyWRcJoC0vPIgsdts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737141095; c=relaxed/simple;
	bh=/8ei8rbOGK64Vfb0fbQyCL9+KpPjR8G10qKS/soRWD0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tfNdMdgcPPCtt+/04C3n+oEykIrvT/IOvzNu34ih994R/7A3qEzGwNd6MJeRKEiYFRFMe6lHMuOlzIX2Oqway/4vduFtQ/CiaKvfDpG9nc7suF9f+WwDcsBLzjkSNuTZu24vhdHe7fFElHdS/7IvNhd23PYfxZv9wawkZoiJWUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=THkOS3Bo; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [10.137.184.60] (unknown [131.107.160.188])
	by linux.microsoft.com (Postfix) with ESMTPSA id C0BC020591BB;
	Fri, 17 Jan 2025 11:11:33 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com C0BC020591BB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1737141093;
	bh=k+LySx4MMjUII9cOznURPNM+w9ida7uqom5MhS8WGmQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=THkOS3BodcFPL6nf6jQJric1wbtXyJn4VMpAH+eWlKuZtkwOL44txVDUZBsWsvj1+
	 dSEisn+qc7RYeHWwSeWdHk8bUz/6igIcERab1Nt+GExRwpdC/i3tyMrZdhiEMpIdAp
	 Bv/SWbdlxIosuDm+9PkHvLem2BChuMMRkcwtfFOE=
Message-ID: <c3e23b3f-d83f-431e-b19d-691fae0041cf@linux.microsoft.com>
Date: Fri, 17 Jan 2025 11:11:34 -0800
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] scsi: storvsc: Set correct data length for sending SCSI
 command without payload
To: longli@linuxonhyperv.com, "K. Y. Srinivasan" <kys@microsoft.com>,
 Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>,
 Dexuan Cui <decui@microsoft.com>,
 "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
 "Martin K. Petersen" <martin.petersen@oracle.com>,
 James Bottomley <JBottomley@Odin.com>, linux-hyperv@vger.kernel.org,
 linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Long Li <longli@microsoft.com>, stable@kernel.org,
 "benhill@microsoft.com" <benhill@microsoft.com>
References: <1737071998-4566-1-git-send-email-longli@linuxonhyperv.com>
Content-Language: en-US
From: Roman Kisel <romank@linux.microsoft.com>
In-Reply-To: <1737071998-4566-1-git-send-email-longli@linuxonhyperv.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 1/16/2025 3:59 PM, longli@linuxonhyperv.com wrote:
> From: Long Li <longli@microsoft.com>
> 
> In StorVSC, payload->range.len is used to indicate if this SCSI command
> carries payload. This data is allocated as part of the private driver
> data by the upper layer and may get passed to lower driver uninitialized.
> 
> If a SCSI command doesn't carry payload, the driver may use this value as
> is for communicating with host, resulting in possible corruption.
> 
> Fix this by always initializing this value.

Awesome that you've caught that elusive critter, thank you! :)

Tested-by: Roman Kisel <romank@linux.microsoft.com>
Reviewed-by: Roman Kisel <romank@linux.microsoft.com>

> 
> Fixes: be0cf6ca301c ("scsi: storvsc: Set the tablesize based on the information given by the host")
> Cc: stable@kernel.org
> Signed-off-by: Long Li <longli@microsoft.com>
> ---
>   drivers/scsi/storvsc_drv.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/scsi/storvsc_drv.c b/drivers/scsi/storvsc_drv.c
> index 7ceb982040a5..ca5e5c0aeabf 100644
> --- a/drivers/scsi/storvsc_drv.c
> +++ b/drivers/scsi/storvsc_drv.c
> @@ -1789,6 +1789,7 @@ static int storvsc_queuecommand(struct Scsi_Host *host, struct scsi_cmnd *scmnd)
>   
>   	length = scsi_bufflen(scmnd);
>   	payload = (struct vmbus_packet_mpb_array *)&cmd_request->mpb;
> +	payload->range.len = 0;
>   	payload_sz = 0;
>   
>   	if (scsi_sg_count(scmnd)) {

-- 
Thank you,
Roman


