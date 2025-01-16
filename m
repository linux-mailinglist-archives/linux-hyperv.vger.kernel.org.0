Return-Path: <linux-hyperv+bounces-3699-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DD00A14396
	for <lists+linux-hyperv@lfdr.de>; Thu, 16 Jan 2025 21:46:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D3A04188CBAF
	for <lists+linux-hyperv@lfdr.de>; Thu, 16 Jan 2025 20:46:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7725222FDFD;
	Thu, 16 Jan 2025 20:46:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="swb6s1Rf"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12F6C158520;
	Thu, 16 Jan 2025 20:45:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737060361; cv=none; b=m7hBWl21KEYSMqxUwJXAENzcXmuDjQP5uQSRMBH9j5Ayyz0LaYpllWyBI+C1R55ZGv/uxehv1iKDSUOhfGcLDU7ejpcDpv0x1MR3bjhnWqfpHVvSb+0tYtoJj0e5h1yD5/7CYFdzMCj81J5FgZ/u1zifd+qfaqupvAXG4urc1ZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737060361; c=relaxed/simple;
	bh=857k75VGVZq3Jn8ImkYEnUApMM6JR6PKh5Sgv6enpE4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=E2g0Fd70PO28nqexIgkI3mdaa+4IytVu06ze5z+ID++VVhzsOGneBfoU2N0DRZlGi5s4AsLGTAxO/W8cHQV+aDVSuiAKG0Bmr0Wc69sGW3WkDLucjjKeuayfSdQJUqv/GECs73n9y6aGXiwOENsDvouv5vMWGfYwmTsO38iG4jc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=swb6s1Rf; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [10.137.184.60] (unknown [131.107.160.188])
	by linux.microsoft.com (Postfix) with ESMTPSA id 69ABF205919A;
	Thu, 16 Jan 2025 12:45:53 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 69ABF205919A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1737060353;
	bh=K7TQmpfPOEaXLhGQbBit9pnYRQxz7oZENIOpaN38BGU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=swb6s1Rf3wOZrXrLJLk2at1m5qDWQkJlMUrFFD9g5/Xsc8l4MHEoOnvFqIeQI6je3
	 hQ3pPWOVdrkfYlNLv4sw4V9VjUTbVMvgwpMdtd4RzqPuLGJbQ3LsxwdaSv13OyYsWV
	 DNPdohs1zIVVI4WhUA8kpI3MreJqDY+s8kEXiosw=
Message-ID: <d136130c-6895-4394-88c2-2911123afce5@linux.microsoft.com>
Date: Thu, 16 Jan 2025 12:45:53 -0800
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hv_netvsc: Replace one-element array with flexible array
 member
To: Thorsten Blum <thorsten.blum@linux.dev>,
 "K. Y. Srinivasan" <kys@microsoft.com>,
 Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>,
 Dexuan Cui <decui@microsoft.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: linux-hardening@vger.kernel.org, linux-hyperv@vger.kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250116201635.47870-2-thorsten.blum@linux.dev>
Content-Language: en-US
From: Roman Kisel <romank@linux.microsoft.com>
In-Reply-To: <20250116201635.47870-2-thorsten.blum@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 1/16/2025 12:16 PM, Thorsten Blum wrote:
> Replace the deprecated one-element array with a modern flexible array
> member in the struct nvsp_1_message_send_receive_buffer_complete.
> 
> Link: https://github.com/KSPP/linux/issues/79
> Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
> ---
>   drivers/net/hyperv/hyperv_net.h | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/hyperv/hyperv_net.h b/drivers/net/hyperv/hyperv_net.h
> index e690b95b1bbb..234db693cefa 100644
> --- a/drivers/net/hyperv/hyperv_net.h
> +++ b/drivers/net/hyperv/hyperv_net.h
> @@ -464,7 +464,7 @@ struct nvsp_1_message_send_receive_buffer_complete {
>   	 *  LargeOffset                            SmallOffset
>   	 */
>   
> -	struct nvsp_1_receive_buffer_section sections[1];
> +	struct nvsp_1_receive_buffer_section sections[];
>   } __packed;
>   
>   /*

1. How have you tested the change?

2. There is an instance of

`sizeof(struct nvsp_1_message_send_receive_buffer_complete))`

and your change decreases the size of the struct. Why do you think
that is fine?

-- 
Thank you,
Roman


