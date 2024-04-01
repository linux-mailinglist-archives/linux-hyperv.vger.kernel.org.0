Return-Path: <linux-hyperv+bounces-1890-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C6950893783
	for <lists+linux-hyperv@lfdr.de>; Mon,  1 Apr 2024 04:53:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DD3A8B21081
	for <lists+linux-hyperv@lfdr.de>; Mon,  1 Apr 2024 02:53:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BAAFA48;
	Mon,  1 Apr 2024 02:53:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b="DgKaBX8A"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from omta040.useast.a.cloudfilter.net (omta040.useast.a.cloudfilter.net [44.202.169.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C023FA5F
	for <linux-hyperv@vger.kernel.org>; Mon,  1 Apr 2024 02:53:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=44.202.169.39
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711940003; cv=none; b=JG9cHzBzpohhA/AFA5o6u9SP1tP4q3rbFvrreNM2fBsvOZE7YCeOhtOdlZ+puM7sY4T6haBj7mGRA6VAtYtKRydc7pLncIivHDR5LvK7syRx4Ze5oH7wVwxL4tbpDRZMHU+axs51m5RnO+MzQCKOUBfzmI94vg4bMRT9YaujQ6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711940003; c=relaxed/simple;
	bh=NItB/iOyW385ke3Wb64kZWH68badp87GEEAzPho8s4Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oH6iNv4ATsX/93xPLbJrj4rIXVokDGBFv4XuIsaIaG8HMYoDCCCshe8UwLUOLP7SlXAFQ3cmixBS+PiJxKMhX9SJKV/21LfpJ7wbcfK4Pzbi/HQ0QegacSsGWBLBMJV7NIDbV3gWLko3LGHR9k1BMd/I29S/G/5giiRMZgH8NWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com; spf=pass smtp.mailfrom=embeddedor.com; dkim=pass (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b=DgKaBX8A; arc=none smtp.client-ip=44.202.169.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=embeddedor.com
Received: from eig-obgw-6005a.ext.cloudfilter.net ([10.0.30.201])
	by cmsmtp with ESMTPS
	id qylBrfstkl9dRr7nOrJl13; Mon, 01 Apr 2024 02:53:14 +0000
Received: from gator4166.hostgator.com ([108.167.133.22])
	by cmsmtp with ESMTPS
	id r7nNr9MjqHHoAr7nNriVTH; Mon, 01 Apr 2024 02:53:13 +0000
X-Authority-Analysis: v=2.4 cv=dskQCEg4 c=1 sm=1 tr=0 ts=660a2199
 a=1YbLdUo/zbTtOZ3uB5T3HA==:117 a=zXgy4KOrraTBHT4+ULisNA==:17
 a=IkcTkHD0fZMA:10 a=K6JAEmCyrfEA:10 a=wYkD_t78qR0A:10 a=VwQbUJbxAAAA:8
 a=UqCG9HQmAAAA:8 a=ULve-GQanhtCPmNiPXUA:9 a=QEXdDO2ut3YA:10 a=9cHFzqQdt-sA:10
 a=PUnBvhIW4WwA:10 a=AjGcO6oz07-iQ99wixmX:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=75BIkSv+82gmLssfiqp91Yj+hWnhvj/bJubjcKhhBFk=; b=DgKaBX8A+Dm2oX7EOhaSTi1lmR
	hWHL+0p8srhxDq5zJQWqdLDjTjOPM6z77Gqz6MVMNf2KEXhJsLn0PQy+NzuxUrfDOBA097Ybve3ZM
	R9AS/hexPTxq+TALHm7b0kru/WJTI2Ui2wDg5WDFx1ID4AiJA609AjVovFB+/xfgk1a/qGifZs6yq
	SuwKXmIxr3SSnfbK+dPb42SaGqS2CJam276LwoawYLqdYwJ5f38SYUmK7zT9zgx9opfgdWexToFGH
	zgpBz0Q4ZFTsfpHT3M/FbOvQrqV5o9dFhu0EUfj8QirhVBlsxB7TFTB3j6cIvbprUUiJEJblTZ34X
	eYJBRcUQ==;
Received: from [201.172.173.147] (port=40326 helo=[192.168.15.14])
	by gator4166.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.96.2)
	(envelope-from <gustavo@embeddedor.com>)
	id 1rr7nK-0045H6-2R;
	Sun, 31 Mar 2024 21:53:10 -0500
Message-ID: <1be10e9c-e521-4974-b2ed-808a2e3a1a9d@embeddedor.com>
Date: Sun, 31 Mar 2024 20:53:07 -0600
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] RDMA/mana_ib: Add flex array to struct
 mana_cfg_rx_steer_req_v2
To: Erick Archer <erick.archer@outlook.com>, Long Li <longli@microsoft.com>,
 Ajay Sharma <sharmaajay@microsoft.com>, Jason Gunthorpe <jgg@ziepe.ca>,
 Leon Romanovsky <leon@kernel.org>, "K. Y. Srinivasan" <kys@microsoft.com>,
 Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>,
 Dexuan Cui <decui@microsoft.com>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>,
 Shradha Gupta <shradhagupta@linux.microsoft.com>,
 Konstantin Taranov <kotaranov@microsoft.com>,
 Kees Cook <keescook@chromium.org>,
 "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-hyperv@vger.kernel.org, netdev@vger.kernel.org,
 linux-hardening@vger.kernel.org
References: <AS8PR02MB7237974EF1B9BAFA618166C38B382@AS8PR02MB7237.eurprd02.prod.outlook.com>
Content-Language: en-US
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
In-Reply-To: <AS8PR02MB7237974EF1B9BAFA618166C38B382@AS8PR02MB7237.eurprd02.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 201.172.173.147
X-Source-L: No
X-Exim-ID: 1rr7nK-0045H6-2R
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: ([192.168.15.14]) [201.172.173.147]:40326
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 3
X-Org: HG=hgshared;ORG=hostgator;
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfGrgeZgiZz9QoUtoA3uE0mQxr8I9xtpgPBUTWiU/W0DZof+DYR16MmnifwYUfrP8ERhI5yBcbjmi4jdZnbz5b4j4aXdIACv/DN0a98xpdv0V+IxmxVVv
 0SzncdIarWGZqJb6VBGTrDbSHSeM5u6m/qJugWVZmMEZPUyo9xkbhWiBkg3Wsr4U1TPrl9N5tn4abbtlutKcNxL7XzoNY2yJCwuSqxwoKyY4o/uBUeWi788Q



On 31/03/24 09:04, Erick Archer wrote:
> The "struct mana_cfg_rx_steer_req_v2" uses a dynamically sized set of
> trailing elements. Specifically, it uses a "mana_handle_t" array. So,
> use the preferred way in the kernel declaring a flexible array [1].
> 
> Also, avoid the open-coded arithmetic in the memory allocator functions
> [2] using the "struct_size" macro.
> 
> Moreover, use the "offsetof" helper to get the indirect table offset
> instead of the "sizeof" operator and avoid the open-coded arithmetic in
> pointers using the new flex member.
> 
> Now, it is also possible to use the "flex_array_size" helper to compute
> the size of these trailing elements in the "memcpy" function.
> 
> Link: https://www.kernel.org/doc/html/next/process/deprecated.html#zero-length-and-one-element-arrays [1]
> Link: https://www.kernel.org/doc/html/next/process/deprecated.html#open-coded-arithmetic-in-allocator-arguments [2]
> Signed-off-by: Erick Archer <erick.archer@outlook.com>
> ---
>   drivers/infiniband/hw/mana/qp.c               | 8 ++++----
>   drivers/net/ethernet/microsoft/mana/mana_en.c | 9 +++++----
>   include/net/mana/mana.h                       | 1 +
>   3 files changed, 10 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/infiniband/hw/mana/qp.c b/drivers/infiniband/hw/mana/qp.c
> index 6e7627745c95..c2a39db8ef92 100644
> --- a/drivers/infiniband/hw/mana/qp.c
> +++ b/drivers/infiniband/hw/mana/qp.c
> @@ -22,8 +22,7 @@ static int mana_ib_cfg_vport_steering(struct mana_ib_dev *dev,
>   
>   	gc = mdev_to_gc(dev);
>   
> -	req_buf_size =
> -		sizeof(*req) + sizeof(mana_handle_t) * MANA_INDIRECT_TABLE_SIZE;
> +	req_buf_size = struct_size(req, indir_tab, MANA_INDIRECT_TABLE_SIZE);
>   	req = kzalloc(req_buf_size, GFP_KERNEL);
>   	if (!req)
>   		return -ENOMEM;
> @@ -44,11 +43,12 @@ static int mana_ib_cfg_vport_steering(struct mana_ib_dev *dev,
>   		req->rss_enable = true;
>   
>   	req->num_indir_entries = MANA_INDIRECT_TABLE_SIZE;
> -	req->indir_tab_offset = sizeof(*req);
> +	req->indir_tab_offset = offsetof(struct mana_cfg_rx_steer_req_v2,
> +					 indir_tab);
>   	req->update_indir_tab = true;
>   	req->cqe_coalescing_enable = 1;
>   
> -	req_indir_tab = (mana_handle_t *)(req + 1);
> +	req_indir_tab = req->indir_tab;

It seems that `req_indir_tab` can be removed, and `req->indir_tab` be directly used.

>   	/* The ind table passed to the hardware must have
>   	 * MANA_INDIRECT_TABLE_SIZE entries. Adjust the verb
>   	 * ind_table to MANA_INDIRECT_TABLE_SIZE if required
> diff --git a/drivers/net/ethernet/microsoft/mana/mana_en.c b/drivers/net/ethernet/microsoft/mana/mana_en.c
> index 59287c6e6cee..04aa096c6cc4 100644
> --- a/drivers/net/ethernet/microsoft/mana/mana_en.c
> +++ b/drivers/net/ethernet/microsoft/mana/mana_en.c
> @@ -1062,7 +1062,7 @@ static int mana_cfg_vport_steering(struct mana_port_context *apc,
>   	u32 req_buf_size;
>   	int err;
>   
> -	req_buf_size = sizeof(*req) + sizeof(mana_handle_t) * num_entries;
> +	req_buf_size = struct_size(req, indir_tab, num_entries);
>   	req = kzalloc(req_buf_size, GFP_KERNEL);
>   	if (!req)
>   		return -ENOMEM;
> @@ -1074,7 +1074,8 @@ static int mana_cfg_vport_steering(struct mana_port_context *apc,
>   
>   	req->vport = apc->port_handle;
>   	req->num_indir_entries = num_entries;
> -	req->indir_tab_offset = sizeof(*req);
> +	req->indir_tab_offset = offsetof(struct mana_cfg_rx_steer_req_v2,
> +					 indir_tab);
>   	req->rx_enable = rx;
>   	req->rss_enable = apc->rss_state;
>   	req->update_default_rxobj = update_default_rxobj;
> @@ -1087,9 +1088,9 @@ static int mana_cfg_vport_steering(struct mana_port_context *apc,
>   		memcpy(&req->hashkey, apc->hashkey, MANA_HASH_KEY_SIZE);
>   
>   	if (update_tab) {
> -		req_indir_tab = (mana_handle_t *)(req + 1);
> +		req_indir_tab = req->indir_tab;

Ditto.

Thanks
--
Gustavo

>   		memcpy(req_indir_tab, apc->rxobj_table,
> -		       req->num_indir_entries * sizeof(mana_handle_t));
> +		       flex_array_size(req, indir_tab, req->num_indir_entries));
>   	}
>   
>   	err = mana_send_request(apc->ac, req, req_buf_size, &resp,
> diff --git a/include/net/mana/mana.h b/include/net/mana/mana.h
> index 76147feb0d10..20ffcae29e1e 100644
> --- a/include/net/mana/mana.h
> +++ b/include/net/mana/mana.h
> @@ -671,6 +671,7 @@ struct mana_cfg_rx_steer_req_v2 {
>   	u8 hashkey[MANA_HASH_KEY_SIZE];
>   	u8 cqe_coalescing_enable;
>   	u8 reserved2[7];
> +	mana_handle_t indir_tab[];
>   }; /* HW DATA */
>   
>   struct mana_cfg_rx_steer_resp {

