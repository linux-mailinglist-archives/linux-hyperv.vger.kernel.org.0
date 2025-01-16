Return-Path: <linux-hyperv+bounces-3702-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B910CA14419
	for <lists+linux-hyperv@lfdr.de>; Thu, 16 Jan 2025 22:39:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1FEBA188D273
	for <lists+linux-hyperv@lfdr.de>; Thu, 16 Jan 2025 21:40:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA69D1DAC81;
	Thu, 16 Jan 2025 21:39:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="QkHQ0Nwk"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D9A51862;
	Thu, 16 Jan 2025 21:39:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737063594; cv=none; b=TgjE4LTWSRwvnfvxy3LEMrDrvatob9cd9sImTyB7HZdf1L0Eabqt3Xz+lSxV3A+egkkaCr6f961oADh/HOGlj/5eTac0THgjYlaQLnOEJHQvM+xUqNptS0ghhQOVdsgHCysSSIfrsywgm/vvxWQHspwfUkLXkP9+FGCgJ7e1t7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737063594; c=relaxed/simple;
	bh=O5hIhC8hK9dd/FJJFMeziJh5D0L749GqSVaZFzgO0tk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MqWJwiC9OsNCc0Ku8K6neXvwIczub0nUWwapILVu0BoBPpQNs0zVAvBt0YPKnh4uz/b/O3DA23YhT5PLxq/193JJ2e+kj5UQU7wTG0xBV2a+Mdv7HauPpi3VYLOwELzoTd4IkiPfB76r6LOw1U1+MwzLG/Z2bBLswhL0q0YwlnM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=QkHQ0Nwk; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [10.137.184.60] (unknown [131.107.160.188])
	by linux.microsoft.com (Postfix) with ESMTPSA id BE6C920BEBE1;
	Thu, 16 Jan 2025 13:39:52 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com BE6C920BEBE1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1737063592;
	bh=rcGjW2h/I7dfjipmLDUIFNKUPTe4UHw3iyCAskW7/9g=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=QkHQ0NwkonH8EGfIjyPd1VJ9YS+3jBgZ41brq5uwvVuuftGCIItS2pmSn/4DUm3Qb
	 2/eWo2Abm8CJ4buXGjP2QqL83Bw/8II4l5XR1XkHQDoGBUNKunZ2YerchxsyN1w9NU
	 1gNFxkFnH7v49bTnmiwDGaW30UPdQRfGXwNpQAMM=
Message-ID: <0927ebf9-db17-49f5-a188-e0d486ae4bda@linux.microsoft.com>
Date: Thu, 16 Jan 2025 13:39:52 -0800
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] hv_netvsc: Replace one-element array with flexible
 array member
To: Thorsten Blum <thorsten.blum@linux.dev>,
 "K. Y. Srinivasan" <kys@microsoft.com>,
 Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>,
 Dexuan Cui <decui@microsoft.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: linux-hardening@vger.kernel.org, linux-hyperv@vger.kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250116211932.139564-2-thorsten.blum@linux.dev>
Content-Language: en-US
From: Roman Kisel <romank@linux.microsoft.com>
In-Reply-To: <20250116211932.139564-2-thorsten.blum@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 1/16/2025 1:19 PM, Thorsten Blum wrote:
> Replace the deprecated one-element array with a modern flexible array
> member in the struct nvsp_1_message_send_receive_buffer_complete.
> 
> Use struct_size_t(,,1) instead of sizeof() to maintain the same size.

Thanks!

> 
> Compile-tested only.

The code change looks good to me now. I'll build a VM with this change
to clear my conscience (maybe the change triggers a compiler bug,
however unlikely that sounds) before replying with any tags. Likely next
Monday, but feel free to beat me to it, or perhaps, someone else will
tag this as reviewed by them and/or tested by them.

> 
> Link: https://github.com/KSPP/linux/issues/79
> Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
> ---
> Changes in v2:
> - Replace sizeof() with struct_size_t(,,1) to maintain the same size
>    after feedback from Roman Kisel (thanks!)
> - Link to v1: https://lore.kernel.org/r/20250116201635.47870-2-thorsten.blum@linux.dev/
> ---
>   drivers/net/hyperv/hyperv_net.h | 2 +-
>   drivers/net/hyperv/netvsc.c     | 3 ++-
>   2 files changed, 3 insertions(+), 2 deletions(-)
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
> diff --git a/drivers/net/hyperv/netvsc.c b/drivers/net/hyperv/netvsc.c
> index 9afb08dbc350..d6f5b9ea3109 100644
> --- a/drivers/net/hyperv/netvsc.c
> +++ b/drivers/net/hyperv/netvsc.c
> @@ -866,7 +866,8 @@ static void netvsc_send_completion(struct net_device *ndev,
>   
>   	case NVSP_MSG1_TYPE_SEND_RECV_BUF_COMPLETE:
>   		if (msglen < sizeof(struct nvsp_message_header) +
> -				sizeof(struct nvsp_1_message_send_receive_buffer_complete)) {
> +				struct_size_t(struct nvsp_1_message_send_receive_buffer_complete,
> +					      sections, 1)) {
>   			netdev_err(ndev, "nvsp_msg1 length too small: %u\n",
>   				   msglen);
>   			return;

-- 
Thank you,
Roman


