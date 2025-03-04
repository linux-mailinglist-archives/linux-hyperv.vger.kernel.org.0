Return-Path: <linux-hyperv+bounces-4203-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E98A2A4D248
	for <lists+linux-hyperv@lfdr.de>; Tue,  4 Mar 2025 05:06:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1921F1897DA9
	for <lists+linux-hyperv@lfdr.de>; Tue,  4 Mar 2025 04:07:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5D8A194080;
	Tue,  4 Mar 2025 04:06:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="ZcqUaMT+"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 530B8BA38;
	Tue,  4 Mar 2025 04:06:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741061212; cv=none; b=pyqZsuE3YqwIc8hqJiP4u+HFGn03G017+AJg3iCPGmU4PaOzrqilPHlPMiPNpVGh7BYZPSPnjtHNgeee6doXGTd0+AYcOk8J8aeMDiRuEqjUJPaseqKL5MD8Vt3Kb6RHxGmr5A7W5BcmphEIN1lE4wk9UOeVXsQGgTZ09VLB/ZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741061212; c=relaxed/simple;
	bh=UMa6kWI8fJ13n4g6a7z63hvdadSJ6Teei4kSz0xsxuo=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=nZPwPvw+qTOxTvNKEHP/sOxXncgaxY0IE0LPM9ilrZpJ2SoI54Jxl/cjiscPFMY+uVUuaBLTcfJRQ932nlA/xf7VFFnFDmNWhCZ4sNVcStVxNtR95bwRFn73LkRtd8u39x5OUDa11hUjmIkLgm3QGLo7/wb3upSWdwg9+RsvITE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=ZcqUaMT+; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [192.168.35.166] (c-24-22-154-137.hsd1.wa.comcast.net [24.22.154.137])
	by linux.microsoft.com (Postfix) with ESMTPSA id 690EE210EAD6;
	Mon,  3 Mar 2025 20:06:50 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 690EE210EAD6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1741061210;
	bh=7pce9h2xpZ33Aa1h16Y8PwGQ7BepmFEpWmVz0TiSisc=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=ZcqUaMT+vKLe5YzAdj/i57N58IpZc+6hg1dd8RWHxvwdFl8YkhiQ6m9Rx3ah0ZA9t
	 k3Sh+DNKLrpy5Xtds8TOHCszWhEZ7pEviSq27KnjkVSlUxhTmehWFtB3TDFkJ8Eqvn
	 H40aMGRfyOQ/BBQHVsZlpSkWE1QcCciJl2oiY/rk=
Message-ID: <223fceb2-927b-4b2e-ae35-30b7810a797f@linux.microsoft.com>
Date: Mon, 3 Mar 2025 20:06:54 -0800
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: mhklinux@outlook.com, kys@microsoft.com, haiyangz@microsoft.com,
 wei.liu@kernel.org, decui@microsoft.com,
 James.Bottomley@HansenPartnership.com, martin.petersen@oracle.com,
 linux-hyperv@vger.kernel.org, linux-scsi@vger.kernel.org,
 linux-kernel@vger.kernel.org, eahariha@linux.microsoft.com,
 apais@microsoft.com, benhill@microsoft.com, sunilmut@microsoft.com
Subject: Re: [PATCH hyperv-next v2 1/1] scsi: storvsc: Don't report the host
 packet status as the hv status
To: Roman Kisel <romank@linux.microsoft.com>
References: <20250304000940.9557-1-romank@linux.microsoft.com>
 <20250304000940.9557-2-romank@linux.microsoft.com>
From: Easwar Hariharan <eahariha@linux.microsoft.com>
Content-Language: en-US
In-Reply-To: <20250304000940.9557-2-romank@linux.microsoft.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/3/2025 4:09 PM, Roman Kisel wrote:
> The log statement reports the packet status code as the hv
> status code which causes confusion when debugging as "hv"
> might refer to a hypervisor, and sometimes to the host part
> of the Hyper-V virtualization stack.
> 
> Fix the name of the datum being logged to clearly indicate
> the component reporting the error. Also log it in hexadecimal
> everywhere for consistency.
> 
> Signed-off-by: Roman Kisel <romank@linux.microsoft.com>
> ---
>  drivers/scsi/storvsc_drv.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/scsi/storvsc_drv.c b/drivers/scsi/storvsc_drv.c
> index a8614e54544e..35db061ae3ec 100644
> --- a/drivers/scsi/storvsc_drv.c
> +++ b/drivers/scsi/storvsc_drv.c
> @@ -776,7 +776,7 @@ static void  handle_multichannel_storage(struct hv_device *device, int max_chns)
>  
>  	if (vstor_packet->operation != VSTOR_OPERATION_COMPLETE_IO ||
>  	    vstor_packet->status != 0) {
> -		dev_err(dev, "Failed to create sub-channel: op=%d, sts=%d\n",
> +		dev_err(dev, "Failed to create sub-channel: op=%d, host=0x%x\n",
>  			vstor_packet->operation, vstor_packet->status);
>  		return;
>  	}
> @@ -1183,7 +1183,7 @@ static void storvsc_on_io_completion(struct storvsc_device *stor_device,
>  			STORVSC_LOGGING_WARN : STORVSC_LOGGING_ERROR;
>  
>  		storvsc_log_ratelimited(device, loglevel,
> -			"tag#%d cmd 0x%x status: scsi 0x%x srb 0x%x hv 0x%x\n",
> +			"tag#%d cmd 0x%x status: scsi 0x%x srb 0x%x host 0x%x\n",
>  			scsi_cmd_to_rq(request->cmd)->tag,
>  			stor_pkt->vm_srb.cdb[0],
>  			vstor_packet->vm_srb.scsi_status,

Looks good to me.

Reviewed-by: Easwar Hariharan <eahariha@linux.microsoft.com>

