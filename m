Return-Path: <linux-hyperv+bounces-4665-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 02071A6C0A3
	for <lists+linux-hyperv@lfdr.de>; Fri, 21 Mar 2025 17:54:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3280D3B0A0F
	for <lists+linux-hyperv@lfdr.de>; Fri, 21 Mar 2025 16:53:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF26D22D4CD;
	Fri, 21 Mar 2025 16:53:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="HVQ+YsqO"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5511F33F6;
	Fri, 21 Mar 2025 16:53:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742576032; cv=none; b=ndzCuyRfUUesP3QTOJzo1yBTcq/tloJB7Eq0Udz1J9qSY9w8wevS7GG+njFJlgOXyi2ZyQuC8+06kocKSP69xaVqhS8q15G10SQ5Tl82a1c6pFhEZGyfWsggV3Vz8EnAi6otwI+DoNEz3oIlIzA5ysrpoawLQBokN3Fz3vqM5qQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742576032; c=relaxed/simple;
	bh=xuJm0HidAoKCnfhW1666JHCJSDxcYwFRLD2LCiqgF2Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QatxP4D0Rra+Mfn3uJrsl/2vIBd7c66YvIK3vq5zOwZeMCoi2iGRQILqCsIwyWzJVJCekl6EOVTIgPTZYLSdCkV5JXLl8F9osCyQuniLwcxC/0UUwbKhI8S/4pH6MUHewNK8iB2+oCeaNiSBdDD5AfHJTY12bFJbkHCLkuwMZ4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=HVQ+YsqO; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [10.0.0.114] (c-67-182-156-199.hsd1.wa.comcast.net [67.182.156.199])
	by linux.microsoft.com (Postfix) with ESMTPSA id BA974202538B;
	Fri, 21 Mar 2025 09:53:50 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com BA974202538B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1742576030;
	bh=Duhj4TbM5w1MlE9r7LL9/Dhla+NioJQGxxo6x7CC9bA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=HVQ+YsqO6ehTWh31vb+VHSj1QeTFi4EoW56Ph5X0g6i2U4I9Fg7FTJ3FKIn7LYgME
	 MLJ9tk4UOzhhGWD/7l0Xi+KPFd8bO19hLrDm4nqx1qUGyJwE4uKDRCYrA7hiTrFVTa
	 DwtJLbUcaAnqFWDTszZgRPkktSHujZYTfNAeuDsI=
Message-ID: <38525f8a-823c-4a79-ac55-68a2ef569a85@linux.microsoft.com>
Date: Fri, 21 Mar 2025 09:53:45 -0700
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH next] Drivers: hv: mshv: Prevent potential NULL
 dereference
To: Dan Carpenter <dan.carpenter@linaro.org>,
 "wei.liu@kernel.org" <wei.liu@kernel.org>
Cc: "K. Y. Srinivasan" <kys@microsoft.com>,
 Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>,
 Dexuan Cui <decui@microsoft.com>,
 Anirudh Rayabharam <anrayabh@linux.microsoft.com>,
 Praveen K Paladugu <prapal@linux.microsoft.com>,
 Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>,
 linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
 kernel-janitors@vger.kernel.org
References: <9fee7658-1981-48b1-b909-fb2b78894077@stanley.mountain>
Content-Language: en-US
From: Nuno Das Neves <nunodasneves@linux.microsoft.com>
In-Reply-To: <9fee7658-1981-48b1-b909-fb2b78894077@stanley.mountain>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/21/2025 7:35 AM, Dan Carpenter wrote:
> Move the NULL check on "partition" before the dereference.
> 
> Fixes: f5288d14069b ("Drivers: hv: Introduce mshv_root module to expose /dev/mshv to VMMs")
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
> ---
>  drivers/hv/mshv_synic.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/hv/mshv_synic.c b/drivers/hv/mshv_synic.c
> index a3daedd680ff..88949beb5e37 100644
> --- a/drivers/hv/mshv_synic.c
> +++ b/drivers/hv/mshv_synic.c
> @@ -151,13 +151,12 @@ static bool mshv_async_call_completion_isr(struct hv_message *msg)
>  	rcu_read_lock();
>  
>  	partition = mshv_partition_find(partition_id);
> -	partition->async_hypercall_status = async_msg->status;
> -
>  	if (unlikely(!partition)) {
>  		pr_debug("failed to find partition %llu\n", partition_id);
>  		goto unlock_out;
>  	}
>  
> +	partition->async_hypercall_status = async_msg->status;
>  	complete(&partition->async_hypercall);
>  
>  	handled = true;

Thanks for catching this one!
Wei could you please apply or squash this into the driver patch?

Thanks
Nuno

