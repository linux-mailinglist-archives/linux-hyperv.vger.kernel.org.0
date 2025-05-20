Return-Path: <linux-hyperv+bounces-5583-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AFA81ABE776
	for <lists+linux-hyperv@lfdr.de>; Wed, 21 May 2025 00:48:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1913C3A5ECD
	for <lists+linux-hyperv@lfdr.de>; Tue, 20 May 2025 22:48:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A25FE2561CC;
	Tue, 20 May 2025 22:48:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b="Dg2rs5Hk"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from omta034.useast.a.cloudfilter.net (omta034.useast.a.cloudfilter.net [44.202.169.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C512922256C
	for <linux-hyperv@vger.kernel.org>; Tue, 20 May 2025 22:48:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=44.202.169.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747781307; cv=none; b=Jnhioxa87LSpwHQcm7rJrXHyL0bYq0MnfhN14cWfMKZNUQ/f1ZYZHU4eiqi3+Vmt0DuTSjpkyU25PNlDX2DdZzvX2zBpWqv42FuJRtIEPlGkOp61GyNfe+SZsnP9QjTGm2fvhihIw2SUY5B+/JeHrn4NHE/HzGfkKjb0Va29+Sg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747781307; c=relaxed/simple;
	bh=nsBsHgVZIn7v53pEHJNwcniuElU0WFLKLfRQY/VPFR8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mj1aAYTYL/rR6eNn65tqQzsK4VN9BFvL2ShdBVD2FRwsPp911DpJfAYu1y7iVeQx/rzYK59LPTNPvwFWOH0GmsHn6WV9yQEvQphFXMzpqNMizXKmmvn+NJbFkEBxmSRiu5+CitcWmFBadcWe16iZU2U5W0526IO5DHA0UZKBqyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com; spf=pass smtp.mailfrom=embeddedor.com; dkim=pass (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b=Dg2rs5Hk; arc=none smtp.client-ip=44.202.169.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=embeddedor.com
Received: from eig-obgw-5008a.ext.cloudfilter.net ([10.0.29.246])
	by cmsmtp with ESMTPS
	id HRQJuNbslXshwHVl2ur0cE; Tue, 20 May 2025 22:48:24 +0000
Received: from gator4166.hostgator.com ([108.167.133.22])
	by cmsmtp with ESMTPS
	id HVl2uSdeECFxwHVl2u3fCy; Tue, 20 May 2025 22:48:24 +0000
X-Authority-Analysis: v=2.4 cv=AfG3HWXG c=1 sm=1 tr=0 ts=682d06b8
 a=1YbLdUo/zbTtOZ3uB5T3HA==:117 a=efVMuJ2jJG67FGuSm7J3ww==:17
 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=7T7KSl7uo7wA:10 a=VwQbUJbxAAAA:8
 a=J1Y8HTJGAAAA:8 a=1XWaLZrsAAAA:8 a=20KFwNOVAAAA:8 a=Ikd4Dj_1AAAA:8
 a=vggBfdFIAAAA:8 a=DJTdb95cQ3q3fOx0NTQA:9 a=QEXdDO2ut3YA:10
 a=y1Q9-5lHfBjTkpIzbSAN:22 a=xYX6OU9JNrHFPr8prv8u:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=sQ1KdJsLeNFUGVUFftkX6bJiPEcnX1VunVFKPkYeT8w=; b=Dg2rs5HkQrM8cFMSQZir7ibl2U
	r5MJYf81XgVpvLxj8m1pVUZqk7lCt9GSHaLZ+INTR9ZihlXQyi/EyPjA+pr7zZntKW9rFIYCIgl8p
	QZ5bwrUY4I/bUQucRupRcXHboiCC0OfM2oSzAnrloBmVLy549XLcLJn52gOSknTpemZ0RcHiDWQC9
	QPpsw6cqmuToNqJPYEMq+208VDKgI8A74qVKhdtfKdKfqTBpXsIDx4w4b0ZjolrLLQW8Jc51rCOU7
	mBY3St5V168Y9AXi88vYgRCgkRj9Nmds/3rAH+lSb1HOP6PZNz5EgPnrzK3/kAbyM3roxKpc/3DVK
	Kfr8N0Fw==;
Received: from [177.238.17.151] (port=48738 helo=[192.168.0.27])
	by gator4166.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.98.1)
	(envelope-from <gustavo@embeddedor.com>)
	id 1uHVku-000000011s1-0VVi;
	Tue, 20 May 2025 17:48:16 -0500
Message-ID: <c57bd8e0-75b7-4f17-9326-d8d0d7a2301c@embeddedor.com>
Date: Tue, 20 May 2025 16:47:33 -0600
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/7] net: core: Switch netif_set_mac_address() to struct
 sockaddr_storage
To: Kees Cook <kees@kernel.org>, Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 Andrew Lunn <andrew+netdev@lunn.ch>, Stanislav Fomichev <sdf@fomichev.me>,
 Cosmin Ratiu <cratiu@nvidia.com>, Lei Yang <leiyang@redhat.com>,
 Ido Schimmel <idosch@nvidia.com>, netdev@vger.kernel.org,
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
 Chaitanya Kulkarni <kch@nvidia.com>,
 "Martin K. Petersen" <martin.petersen@oracle.com>,
 Mike Christie <michael.christie@oracle.com>,
 Max Gurtovoy <mgurtovoy@nvidia.com>, Maurizio Lombardi
 <mlombard@redhat.com>, Dmitry Bogdanov <d.bogdanov@yadro.com>,
 Mingzhe Zou <mingzhe.zou@easystack.cn>,
 Christophe Leroy <christophe.leroy@csgroup.eu>,
 "Dr. David Alan Gilbert" <linux@treblig.org>,
 Samuel Mendoza-Jonas <sam@mendozajonas.com>,
 Paul Fertser <fercerpav@gmail.com>, Alexander Aring <alex.aring@gmail.com>,
 Stefan Schmidt <stefan@datenfreihafen.org>,
 Miquel Raynal <miquel.raynal@bootlin.com>, Hayes Wang
 <hayeswang@realtek.com>, Douglas Anderson <dianders@chromium.org>,
 Grant Grundler <grundler@chromium.org>, Jay Vosburgh <jv@jvosburgh.net>,
 "K. Y. Srinivasan" <kys@microsoft.com>,
 Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>,
 Dexuan Cui <decui@microsoft.com>, Jiri Pirko <jiri@resnulli.us>,
 Eric Biggers <ebiggers@google.com>, Milan Broz <gmazyland@gmail.com>,
 Philipp Hahn <phahn-oss@avm.de>, Ard Biesheuvel <ardb@kernel.org>,
 Al Viro <viro@zeniv.linux.org.uk>, Ahmed Zaki <ahmed.zaki@intel.com>,
 Alexander Lobakin <aleksander.lobakin@intel.com>,
 Xiao Liang <shaw.leon@gmail.com>, linux-kernel@vger.kernel.org,
 linux-nvme@lists.infradead.org, linux-scsi@vger.kernel.org,
 target-devel@vger.kernel.org, linux-wpan@vger.kernel.org,
 linux-usb@vger.kernel.org, linux-hyperv@vger.kernel.org,
 linux-hardening@vger.kernel.org
References: <20250520222452.work.063-kees@kernel.org>
 <20250520223108.2672023-2-kees@kernel.org>
Content-Language: en-US
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
In-Reply-To: <20250520223108.2672023-2-kees@kernel.org>
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
X-Exim-ID: 1uHVku-000000011s1-0VVi
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: ([192.168.0.27]) [177.238.17.151]:48738
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 2
X-Org: HG=hgshared;ORG=hostgator;
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfE4yCgpmcwuiCYQdbDjykmjZgc+bi22sotx7shTXRmgv4mfBACZS2D1MDw8kiZNyuNU2fwXp79uAqY3yxnpalZ5tPZRDjvZDHYETuAPmLg/4ID6L3Y1F
 33Jc0Z+0cOMwDRHfc1gN4mrA8w88Ox6hd6TPNfl5X+KVOKhSUNcwAUni3R5o1ZxctR3KXAtXfnXpjRAsc0aVtZvjM3kqkpismO5Z2ctu9iKQM7ONiFzKwuQE



On 20/05/25 16:31, Kees Cook wrote:
> In order to avoid passing around struct sockaddr that has a size the
> compiler cannot reason about (nor track at runtime), convert
> netif_set_mac_address() to take struct sockaddr_storage. This is just a
> cast conversion, so there is are no binary changes. Following patches
> will make actual allocation changes.
> 
> Signed-off-by: Kees Cook <kees@kernel.org>

Acked-by: Gustavo A. R. Silva <gustavoars@kernel.org>

Thanks!
-Gustavo

> ---
> Cc: "David S. Miller" <davem@davemloft.net>
> Cc: Eric Dumazet <edumazet@google.com>
> Cc: Jakub Kicinski <kuba@kernel.org>
> Cc: Paolo Abeni <pabeni@redhat.com>
> Cc: Simon Horman <horms@kernel.org>
> Cc: Andrew Lunn <andrew+netdev@lunn.ch>
> Cc: Stanislav Fomichev <sdf@fomichev.me>
> Cc: Cosmin Ratiu <cratiu@nvidia.com>
> Cc: Lei Yang <leiyang@redhat.com>
> Cc: Kuniyuki Iwashima <kuniyu@amazon.com>
> Cc: Ido Schimmel <idosch@nvidia.com>
> Cc: <netdev@vger.kernel.org>
> ---
>   include/linux/netdevice.h |  2 +-
>   net/core/dev.c            | 10 +++++-----
>   net/core/dev_api.c        |  4 ++--
>   net/core/rtnetlink.c      |  2 +-
>   4 files changed, 9 insertions(+), 9 deletions(-)
> 
> diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
> index ea9d335de130..47200a394a02 100644
> --- a/include/linux/netdevice.h
> +++ b/include/linux/netdevice.h
> @@ -4212,7 +4212,7 @@ int netif_set_mtu(struct net_device *dev, int new_mtu);
>   int dev_set_mtu(struct net_device *, int);
>   int dev_pre_changeaddr_notify(struct net_device *dev, const char *addr,
>   			      struct netlink_ext_ack *extack);
> -int netif_set_mac_address(struct net_device *dev, struct sockaddr *sa,
> +int netif_set_mac_address(struct net_device *dev, struct sockaddr_storage *ss,
>   			  struct netlink_ext_ack *extack);
>   int dev_set_mac_address(struct net_device *dev, struct sockaddr *sa,
>   			struct netlink_ext_ack *extack);
> diff --git a/net/core/dev.c b/net/core/dev.c
> index fccf2167b235..f8c8aad7df2e 100644
> --- a/net/core/dev.c
> +++ b/net/core/dev.c
> @@ -9655,7 +9655,7 @@ int dev_pre_changeaddr_notify(struct net_device *dev, const char *addr,
>   }
>   EXPORT_SYMBOL(dev_pre_changeaddr_notify);
>   
> -int netif_set_mac_address(struct net_device *dev, struct sockaddr *sa,
> +int netif_set_mac_address(struct net_device *dev, struct sockaddr_storage *ss,
>   			  struct netlink_ext_ack *extack)
>   {
>   	const struct net_device_ops *ops = dev->netdev_ops;
> @@ -9663,15 +9663,15 @@ int netif_set_mac_address(struct net_device *dev, struct sockaddr *sa,
>   
>   	if (!ops->ndo_set_mac_address)
>   		return -EOPNOTSUPP;
> -	if (sa->sa_family != dev->type)
> +	if (ss->ss_family != dev->type)
>   		return -EINVAL;
>   	if (!netif_device_present(dev))
>   		return -ENODEV;
> -	err = dev_pre_changeaddr_notify(dev, sa->sa_data, extack);
> +	err = dev_pre_changeaddr_notify(dev, ss->__data, extack);
>   	if (err)
>   		return err;
> -	if (memcmp(dev->dev_addr, sa->sa_data, dev->addr_len)) {
> -		err = ops->ndo_set_mac_address(dev, sa);
> +	if (memcmp(dev->dev_addr, ss->__data, dev->addr_len)) {
> +		err = ops->ndo_set_mac_address(dev, ss);
>   		if (err)
>   			return err;
>   	}
> diff --git a/net/core/dev_api.c b/net/core/dev_api.c
> index f9a160ab596f..b5f293e637d9 100644
> --- a/net/core/dev_api.c
> +++ b/net/core/dev_api.c
> @@ -91,7 +91,7 @@ int dev_set_mac_address_user(struct net_device *dev, struct sockaddr *sa,
>   
>   	down_write(&dev_addr_sem);
>   	netdev_lock_ops(dev);
> -	ret = netif_set_mac_address(dev, sa, extack);
> +	ret = netif_set_mac_address(dev, (struct sockaddr_storage *)sa, extack);
>   	netdev_unlock_ops(dev);
>   	up_write(&dev_addr_sem);
>   
> @@ -332,7 +332,7 @@ int dev_set_mac_address(struct net_device *dev, struct sockaddr *sa,
>   	int ret;
>   
>   	netdev_lock_ops(dev);
> -	ret = netif_set_mac_address(dev, sa, extack);
> +	ret = netif_set_mac_address(dev, (struct sockaddr_storage *)sa, extack);
>   	netdev_unlock_ops(dev);
>   
>   	return ret;
> diff --git a/net/core/rtnetlink.c b/net/core/rtnetlink.c
> index 8a914b37ef6e..9743f1c2ae3c 100644
> --- a/net/core/rtnetlink.c
> +++ b/net/core/rtnetlink.c
> @@ -3100,7 +3100,7 @@ static int do_setlink(const struct sk_buff *skb, struct net_device *dev,
>   
>   		memcpy(sa->sa_data, nla_data(tb[IFLA_ADDRESS]),
>   		       dev->addr_len);
> -		err = netif_set_mac_address(dev, sa, extack);
> +		err = netif_set_mac_address(dev, (struct sockaddr_storage *)sa, extack);
>   		kfree(sa);
>   		if (err) {
>   			up_write(&dev_addr_sem);


