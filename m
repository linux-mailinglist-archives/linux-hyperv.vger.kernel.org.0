Return-Path: <linux-hyperv+bounces-5591-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C1963ABE992
	for <lists+linux-hyperv@lfdr.de>; Wed, 21 May 2025 04:12:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7C8604E29B8
	for <lists+linux-hyperv@lfdr.de>; Wed, 21 May 2025 02:12:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49AEF22AE48;
	Wed, 21 May 2025 02:12:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b="VSV6PJzY"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from omta036.useast.a.cloudfilter.net (omta036.useast.a.cloudfilter.net [44.202.169.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2A1922ACFA;
	Wed, 21 May 2025 02:12:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=44.202.169.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747793531; cv=none; b=iYVJzLd0CGn7b2dDUtuTGsG3JKjoYwe9rk6DAErm6HTEkVm1y6pfla0mD7zP9YJuPmXAEXhOcMG0zN7kUNUq1+8NvSHoe95NYb6TUyCwB29O1KBQjetZduRNvxOpN4FULeOX1sfQ74pJ/L4DOSAvygO2GR9eN26UtuHAQg/KmiA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747793531; c=relaxed/simple;
	bh=fqB2Gh+fCRyr+zOMXeymLiXY3vMa/MT5Utk3xtKbfGw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pV6I9xV5P3P4RcLDWAXRQj7ti1Png2OO0VALtetPQj0GWWM8jGQkL1Uer4bXxaTsEwDQxkElhrpr7R2y1X88yzfZfDn7NYBumMayo8JPSHSqRPE1Begmf1hBwU4fUWqpOw5D0CDGJoc3MZm8YxcNT/K6r6p685/Hf/pefBVL3o4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com; spf=pass smtp.mailfrom=embeddedor.com; dkim=pass (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b=VSV6PJzY; arc=none smtp.client-ip=44.202.169.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=embeddedor.com
Received: from eig-obgw-5002a.ext.cloudfilter.net ([10.0.29.215])
	by cmsmtp with ESMTPS
	id HUC1ulKYyzZPaHYwBuWrUa; Wed, 21 May 2025 02:12:07 +0000
Received: from gator4166.hostgator.com ([108.167.133.22])
	by cmsmtp with ESMTPS
	id HYwAurzAnJ4PgHYwBua7wX; Wed, 21 May 2025 02:12:07 +0000
X-Authority-Analysis: v=2.4 cv=ZaLWNdVA c=1 sm=1 tr=0 ts=682d3677
 a=1YbLdUo/zbTtOZ3uB5T3HA==:117 a=efVMuJ2jJG67FGuSm7J3ww==:17
 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=7T7KSl7uo7wA:10 a=VwQbUJbxAAAA:8
 a=pGLkceISAAAA:8 a=sEkq5x4IAAAA:8 a=P-IC7800AAAA:8 a=J1Y8HTJGAAAA:8
 a=1XWaLZrsAAAA:8 a=20KFwNOVAAAA:8 a=gngr1YUT0vIlzbvq1ooA:9 a=QEXdDO2ut3YA:10
 a=llby-PD1hR8gYtG5ERSV:22 a=d3PnA9EDa4IxuAV0gXij:22 a=y1Q9-5lHfBjTkpIzbSAN:22
 a=xYX6OU9JNrHFPr8prv8u:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=7P7k8gutjP8wk9Jbfv5pLHYgNfWP20/s0ynYFVASyHQ=; b=VSV6PJzYxmzLKICGhF42m8Vi2R
	OaT63JSAPdu+cq8rEXrP4DtdJBB20u5rEkBzK3Ff8VnoSTWNRCOBHDQ6LmxlDC0l4MZKiCt7zeFI3
	fjX2bnEH9qeumhXPOsOuLxAb7ZARIsGyPSGvWXRr5bFW95dQBfjqKxEVkdw4vFK7rdxK10h7quROX
	1ZXwJf6nIZUWxB7ef0Hf1m2CXne63iEscWFv8Jk0DN1QI+Jl8W3CtWTnQlGzC7OxvXLmMXvDYt7zj
	3sYsgqQrg5wUqYmgbf5u2GzGGm9xZHvjeSfu6yTgZdbyeb4tjuUacLvfbcmmtnglDrD1zPdczfUMu
	8DzK67iQ==;
Received: from [177.238.17.151] (port=37062 helo=[192.168.0.27])
	by gator4166.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.98.1)
	(envelope-from <gustavo@embeddedor.com>)
	id 1uHVmK-000000014bO-0QiZ;
	Tue, 20 May 2025 17:49:44 -0500
Message-ID: <96e156aa-0882-46e6-bd8b-8285e76481e7@embeddedor.com>
Date: Tue, 20 May 2025 16:49:17 -0600
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/7] ieee802154: Use struct sockaddr_storage with
 dev_set_mac_address()
To: Kees Cook <kees@kernel.org>, Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: Alexander Aring <alex.aring@gmail.com>,
 Stefan Schmidt <stefan@datenfreihafen.org>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, linux-wpan@vger.kernel.org,
 netdev@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
 Sagi Grimberg <sagi@grimberg.me>, Chaitanya Kulkarni <kch@nvidia.com>,
 "Martin K. Petersen" <martin.petersen@oracle.com>,
 Mike Christie <michael.christie@oracle.com>,
 Max Gurtovoy <mgurtovoy@nvidia.com>, Maurizio Lombardi
 <mlombard@redhat.com>, Dmitry Bogdanov <d.bogdanov@yadro.com>,
 Mingzhe Zou <mingzhe.zou@easystack.cn>,
 Christophe Leroy <christophe.leroy@csgroup.eu>,
 "Dr. David Alan Gilbert" <linux@treblig.org>,
 Andrew Lunn <andrew+netdev@lunn.ch>, Stanislav Fomichev <sdf@fomichev.me>,
 Cosmin Ratiu <cratiu@nvidia.com>, Lei Yang <leiyang@redhat.com>,
 Ido Schimmel <idosch@nvidia.com>, Samuel Mendoza-Jonas
 <sam@mendozajonas.com>, Paul Fertser <fercerpav@gmail.com>,
 Hayes Wang <hayeswang@realtek.com>, Douglas Anderson
 <dianders@chromium.org>, Grant Grundler <grundler@chromium.org>,
 Jay Vosburgh <jv@jvosburgh.net>, "K. Y. Srinivasan" <kys@microsoft.com>,
 Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>,
 Dexuan Cui <decui@microsoft.com>, Jiri Pirko <jiri@resnulli.us>,
 Eric Biggers <ebiggers@google.com>, Milan Broz <gmazyland@gmail.com>,
 Philipp Hahn <phahn-oss@avm.de>, Ard Biesheuvel <ardb@kernel.org>,
 Al Viro <viro@zeniv.linux.org.uk>, Ahmed Zaki <ahmed.zaki@intel.com>,
 Alexander Lobakin <aleksander.lobakin@intel.com>,
 Xiao Liang <shaw.leon@gmail.com>, linux-kernel@vger.kernel.org,
 linux-nvme@lists.infradead.org, linux-scsi@vger.kernel.org,
 target-devel@vger.kernel.org, linux-usb@vger.kernel.org,
 linux-hyperv@vger.kernel.org, linux-hardening@vger.kernel.org
References: <20250520222452.work.063-kees@kernel.org>
 <20250520223108.2672023-4-kees@kernel.org>
Content-Language: en-US
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
In-Reply-To: <20250520223108.2672023-4-kees@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 177.238.17.151
X-Source-L: No
X-Exim-ID: 1uHVmK-000000014bO-0QiZ
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: ([192.168.0.27]) [177.238.17.151]:37062
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 0
X-Org: HG=hgshared;ORG=hostgator;
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfHoararcu8F0EYKq9Ut2ArH204U1J+nskEJ25RXfoDo6rpPd9AIuBJxTaggsQkzESsEQSLVdFyJF8RAdd8rOwmkm4siOWVPnbBq9aR5hLlU3jwVwSx/s
 xdzx86ckgn30XiMyxnN2d+Ot/kCXJ33VCLRR0J0zFvA3vrLns5L4vwQuKzJP1lyj9sTgOWVuTK4x9aW7Wq5w4kTMyfWGzvIRD+Na+AhStKyz+Hypiwazoold
 DCx4cZ6kvWcZzGsfhevuLfxAXXF8MH73RDNogWKNXZJZoOIt/EnJvatdqZa/hBB5x+70JT3OiF7gr3m4HUm0/Qx21OylLf+c6pHHnnilnWxOggNFsGJKeIJX
 oNZPEwff+RnHiBYdKAmiSJiyoD2apy0+vvP9MGijKAayAak7APzzAoZqX9A7TU4swsoqdCpsrWcg870/ogCGtdAL6Q/1zwEVBH1bu4ZVQ3mqChAm19ve3DEw
 DQpxYHAI0QTy08bkY0cKRLOsPGwqUWbzdyRaAA==



On 20/05/25 16:31, Kees Cook wrote:
> Switch to struct sockaddr_storage for calling dev_set_mac_address(). Add
> a temporary cast to struct sockaddr, which will be removed in a
> subsequent patch.
> 
> Signed-off-by: Kees Cook <kees@kernel.org>

Acked-by: Gustavo A. R. Silva <gustavoars@kernel.org>

Thanks!
-Gustavo

> ---
> Cc: Alexander Aring <alex.aring@gmail.com>
> Cc: Stefan Schmidt <stefan@datenfreihafen.org>
> Cc: Miquel Raynal <miquel.raynal@bootlin.com>
> Cc: "David S. Miller" <davem@davemloft.net>
> Cc: Eric Dumazet <edumazet@google.com>
> Cc: Jakub Kicinski <kuba@kernel.org>
> Cc: Paolo Abeni <pabeni@redhat.com>
> Cc: Simon Horman <horms@kernel.org>
> Cc: <linux-wpan@vger.kernel.org>
> Cc: <netdev@vger.kernel.org>
> ---
>   net/ieee802154/nl-phy.c | 8 ++++----
>   1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/net/ieee802154/nl-phy.c b/net/ieee802154/nl-phy.c
> index 359249ab77bf..ee2b190e8e0d 100644
> --- a/net/ieee802154/nl-phy.c
> +++ b/net/ieee802154/nl-phy.c
> @@ -224,17 +224,17 @@ int ieee802154_add_iface(struct sk_buff *skb, struct genl_info *info)
>   	dev_hold(dev);
>   
>   	if (info->attrs[IEEE802154_ATTR_HW_ADDR]) {
> -		struct sockaddr addr;
> +		struct sockaddr_storage addr;
>   
> -		addr.sa_family = ARPHRD_IEEE802154;
> -		nla_memcpy(&addr.sa_data, info->attrs[IEEE802154_ATTR_HW_ADDR],
> +		addr.ss_family = ARPHRD_IEEE802154;
> +		nla_memcpy(&addr.__data, info->attrs[IEEE802154_ATTR_HW_ADDR],
>   			   IEEE802154_ADDR_LEN);
>   
>   		/* strangely enough, some callbacks (inetdev_event) from
>   		 * dev_set_mac_address require RTNL_LOCK
>   		 */
>   		rtnl_lock();
> -		rc = dev_set_mac_address(dev, &addr, NULL);
> +		rc = dev_set_mac_address(dev, (struct sockaddr *)&addr, NULL);
>   		rtnl_unlock();
>   		if (rc)
>   			goto dev_unregister;


