Return-Path: <linux-hyperv+bounces-5805-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B5588AD1E88
	for <lists+linux-hyperv@lfdr.de>; Mon,  9 Jun 2025 15:12:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7A04F168818
	for <lists+linux-hyperv@lfdr.de>; Mon,  9 Jun 2025 13:12:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C11E258CED;
	Mon,  9 Jun 2025 13:12:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="moY5uzeB"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BEFD2580FB;
	Mon,  9 Jun 2025 13:12:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749474734; cv=none; b=lvKRtsXpga3zddPorAYqN/s8w/vuwA1cAp5VycmKbRbjSqMJugJSVBME8LFAOJGyVlrDuEXXdMPP24xjSTaFQeq5s47n+7EpuSfrr1TLSe+ea3AVJaEnOMpFBDB80Kah9UchCVGB5ixwxe8MzLAvf1i9lLY5WV04fjvJgO+978A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749474734; c=relaxed/simple;
	bh=stsYB19kvNMiOtdGkTwrlQK7Kp9C7qzJIuPKVcqaSDc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TIw0brWqwx914FFi6yOtBqweVJqQBFRoVGgdh+eHlAbN0bYgYZTr5CreN4CC9nR4/INPj1Z0W14JtedSE2GISG4E/ff32jFwNtMMhWhVTv1idGoG36JSh1ATebk38KOYcwkymQ7IPrZB1x6i+5JRbQ3WCXucSKN/ydScGzlZV5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=moY5uzeB; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [100.79.192.63] (unknown [4.194.122.170])
	by linux.microsoft.com (Postfix) with ESMTPSA id 04848211159D;
	Mon,  9 Jun 2025 06:12:10 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 04848211159D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1749474732;
	bh=Mm5qTjStuEDu3spD8do/ijIMQ+1bdgf911KwqiR4qf4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=moY5uzeBsrsv3nOl9p2ozVAHXNesYbqO70vCNB3lq7foe97EtMmZtbgdmKt+XsEkD
	 oskrrgpQVWj05YZehZRrG+IXuTqjXtqbWw7pwHB65eV/9xu8pNgzLVTcbqGixEXaJN
	 LtoVRTLZ/Cx1Ugb1xvvTAVnepLc9hyOIt1hEZrLY=
Message-ID: <632c1404-cbf6-4ee6-909a-a18e78c1f96e@linux.microsoft.com>
Date: Mon, 9 Jun 2025 18:42:09 +0530
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drivers: hv: Constify 'struct bin_attribute'
To: =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>,
 "K. Y. Srinivasan" <kys@microsoft.com>,
 Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>,
 Dexuan Cui <decui@microsoft.com>
Cc: linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250609-sysfs-const-bin_attr-hv-v1-1-bfed20083800@weissschuh.net>
Content-Language: en-US
From: Naman Jain <namjain@linux.microsoft.com>
In-Reply-To: <20250609-sysfs-const-bin_attr-hv-v1-1-bfed20083800@weissschuh.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 6/9/2025 4:35 PM, Thomas Weißschuh wrote:
> The sysfs core now allows instances of 'struct bin_attribute' to be
> moved into read-only memory. Make use of that to protect them against
> accidental or malicious modifications.
> 
> Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
> ---
>   drivers/hv/vmbus_drv.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/hv/vmbus_drv.c b/drivers/hv/vmbus_drv.c
> index 33b524b4eb5ef89d0111442a34d39874f02f0b70..38d2775dbe8730fd223d21188519b5f2b72e0804 100644
> --- a/drivers/hv/vmbus_drv.c
> +++ b/drivers/hv/vmbus_drv.c
> @@ -1845,7 +1845,7 @@ static int hv_mmap_ring_buffer_wrapper(struct file *filp, struct kobject *kobj,
>   	return channel->mmap_ring_buffer(channel, vma);
>   }
>   
> -static struct bin_attribute chan_attr_ring_buffer = {
> +static const struct bin_attribute chan_attr_ring_buffer = {
>   	.attr = {
>   		.name = "ring",
>   		.mode = 0600,
> @@ -1871,7 +1871,7 @@ static struct attribute *vmbus_chan_attrs[] = {
>   	NULL
>   };
>   
> -static const struct bin_attribute *vmbus_chan_bin_attrs[] = {
> +static const struct bin_attribute *const vmbus_chan_bin_attrs[] = {
>   	&chan_attr_ring_buffer,
>   	NULL
>   };
> 
> ---
> base-commit: 19272b37aa4f83ca52bdf9c16d5d81bdd1354494
> change-id: 20250609-sysfs-const-bin_attr-hv-135c9e53b325
> 
> Best regards,

Hello Thomas,
There is a recent change which leads to a conflict with your change
on latest linux-next tip as it brings half of the functionality
from your patch.

"drivers: hv: fix up const issue with vmbus_chan_bin_attrs"

Can you please rebase this.

The other part LGTM, considering you recently got this change
merged: "sysfs: constify attribute_group::bin_attrs"

Regards,
Naman

