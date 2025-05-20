Return-Path: <linux-hyperv+bounces-5592-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B356DABE999
	for <lists+linux-hyperv@lfdr.de>; Wed, 21 May 2025 04:14:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A00CE1BA2473
	for <lists+linux-hyperv@lfdr.de>; Wed, 21 May 2025 02:14:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9785F22B586;
	Wed, 21 May 2025 02:14:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b="pq93Ee/p"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from omta034.useast.a.cloudfilter.net (omta034.useast.a.cloudfilter.net [44.202.169.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6E10223DE7;
	Wed, 21 May 2025 02:14:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=44.202.169.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747793667; cv=none; b=qNIni8idlFY56PMrqvor3t7c+vf9oy30vzfopfnt+7S4KcZwYwrrrD9N3G8YZlu9Jqh8nIIfMtAASiKgi5eK4RcVl4gcPqaNd0+iWDeR7OQgMGNSw3HXRP/G+dwDm7iNCKPrHqCoy2Z6bb5MWj8gLEMpfsN46WVihPAWAwY+iF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747793667; c=relaxed/simple;
	bh=5dSJXEDQi8PMEO1eXgZcA0/aIw2iExHGcGyRDhju+VU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rrlJiUKRsgetH5VfNRLFHvU6iqsag8NF9tnbNDw+jqtYzsEw2O0/SJNzHPQK/y0Z+vVTDCxRTQEdDAQ4bhIq88w02omKwvAU0NOFuCvhK9XLULab5+hpdIXnm9PPNp2BNPgGy0SW/aMO8tNor3f0sFEZsCit1BEFy5swIJaHy1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com; spf=pass smtp.mailfrom=embeddedor.com; dkim=pass (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b=pq93Ee/p; arc=none smtp.client-ip=44.202.169.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=embeddedor.com
Received: from eig-obgw-6002a.ext.cloudfilter.net ([10.0.30.222])
	by cmsmtp with ESMTPS
	id HXoSuP5GxXshwHYyNus2eg; Wed, 21 May 2025 02:14:23 +0000
Received: from gator4166.hostgator.com ([108.167.133.22])
	by cmsmtp with ESMTPS
	id HYyMuC51p1vNyHYyMuKzfi; Wed, 21 May 2025 02:14:23 +0000
X-Authority-Analysis: v=2.4 cv=VMQWnMPX c=1 sm=1 tr=0 ts=682d36ff
 a=1YbLdUo/zbTtOZ3uB5T3HA==:117 a=efVMuJ2jJG67FGuSm7J3ww==:17
 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=7T7KSl7uo7wA:10 a=VwQbUJbxAAAA:8
 a=2OjVGFKQAAAA:8 a=J1Y8HTJGAAAA:8 a=1XWaLZrsAAAA:8 a=20KFwNOVAAAA:8
 a=yMhMjlubAAAA:8 a=pGLkceISAAAA:8 a=sEkq5x4IAAAA:8 a=P-IC7800AAAA:8
 a=jT_9lS9cAAAA:8 a=n9Sqmae0AAAA:8 a=cm27Pg_UAAAA:8 a=Ikd4Dj_1AAAA:8
 a=fQFL_EnMmO_aX3xUukgA:9 a=QEXdDO2ut3YA:10 a=IYbNqeBGBecwsX3Swn6O:22
 a=y1Q9-5lHfBjTkpIzbSAN:22 a=llby-PD1hR8gYtG5ERSV:22 a=d3PnA9EDa4IxuAV0gXij:22
 a=Ec8Bv2-zM_L_lWdDgjzK:22 a=UmAUUZEt6-oIqEbegvw9:22 a=xYX6OU9JNrHFPr8prv8u:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=f4M9wQ/xJCfVbP+uI2qJaGBQcW82zL/k1H+h9bb3gwM=; b=pq93Ee/pWRPMwnrNpwLiWezV0S
	uhtfDWd5sB8NTfDIVF398YF8v3PcXdKwoAguMJtZH33potpILK4JBmQ74EEg9LWnksv9EPr2vy0Z5
	RsnBGMKP9W4GwFSrJQQ/oG0Qn+FJ6N5I06B8m4voSWD6mAnCRdi+gDuMYS23kwRoJxTLLU4GXqOj2
	xL55ZUCL0ENOlMi1A5kIYlMpQLhJ0nnOMtZI4QNYlXI1XJGcpNmLAIppYKhp43kqBThIpObaUSfhd
	SO1q9GjJXVtboFTZILMDThCKYdKT65ls/1fnX322rMVQQUiyoGDJ8f9lAc0q/IyIvrTpxCuoNN+Fy
	ix3YcBfw==;
Received: from [177.238.17.151] (port=45184 helo=[192.168.0.27])
	by gator4166.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.98.1)
	(envelope-from <gustavo@embeddedor.com>)
	id 1uHVnU-00000001711-2mbS;
	Tue, 20 May 2025 17:50:56 -0500
Message-ID: <6a0ecc78-6e9e-453e-83e5-f281c6c85476@embeddedor.com>
Date: Tue, 20 May 2025 16:50:09 -0600
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6/7] net: core: Convert dev_set_mac_address() to struct
 sockaddr_storage
To: Kees Cook <kees@kernel.org>, Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: Jakub Kicinski <kuba@kernel.org>, Jay Vosburgh <jv@jvosburgh.net>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>, "K. Y. Srinivasan" <kys@microsoft.com>,
 Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>,
 Dexuan Cui <decui@microsoft.com>, Jiri Pirko <jiri@resnulli.us>,
 Simon Horman <horms@kernel.org>, Alexander Aring <alex.aring@gmail.com>,
 Stefan Schmidt <stefan@datenfreihafen.org>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 Samuel Mendoza-Jonas <sam@mendozajonas.com>,
 Paul Fertser <fercerpav@gmail.com>, Hayes Wang <hayeswang@realtek.com>,
 Douglas Anderson <dianders@chromium.org>,
 Grant Grundler <grundler@chromium.org>, Stanislav Fomichev
 <sdf@fomichev.me>, Cosmin Ratiu <cratiu@nvidia.com>,
 Lei Yang <leiyang@redhat.com>, netdev@vger.kernel.org,
 linux-hyperv@vger.kernel.org, linux-usb@vger.kernel.org,
 linux-wpan@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
 Sagi Grimberg <sagi@grimberg.me>, Chaitanya Kulkarni <kch@nvidia.com>,
 "Martin K. Petersen" <martin.petersen@oracle.com>,
 Mike Christie <michael.christie@oracle.com>,
 Max Gurtovoy <mgurtovoy@nvidia.com>, Maurizio Lombardi
 <mlombard@redhat.com>, Dmitry Bogdanov <d.bogdanov@yadro.com>,
 Mingzhe Zou <mingzhe.zou@easystack.cn>,
 Christophe Leroy <christophe.leroy@csgroup.eu>,
 "Dr. David Alan Gilbert" <linux@treblig.org>,
 Ido Schimmel <idosch@nvidia.com>, Eric Biggers <ebiggers@google.com>,
 Milan Broz <gmazyland@gmail.com>, Philipp Hahn <phahn-oss@avm.de>,
 Ard Biesheuvel <ardb@kernel.org>, Al Viro <viro@zeniv.linux.org.uk>,
 Ahmed Zaki <ahmed.zaki@intel.com>,
 Alexander Lobakin <aleksander.lobakin@intel.com>,
 Xiao Liang <shaw.leon@gmail.com>, linux-kernel@vger.kernel.org,
 linux-nvme@lists.infradead.org, linux-scsi@vger.kernel.org,
 target-devel@vger.kernel.org, linux-hardening@vger.kernel.org
References: <20250520222452.work.063-kees@kernel.org>
 <20250520223108.2672023-6-kees@kernel.org>
Content-Language: en-US
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
In-Reply-To: <20250520223108.2672023-6-kees@kernel.org>
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
X-Exim-ID: 1uHVnU-00000001711-2mbS
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: ([192.168.0.27]) [177.238.17.151]:45184
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 0
X-Org: HG=hgshared;ORG=hostgator;
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfAqSQIhSgc6ncz4E+4MUe6rsd95A/Zv8QgBnY25J7byOAjywVqtGoKwiuxRiOp+Ti4JAXb4UetrN+pkiMj80XmQ4RI2WBUFSlcM1SA33mTHDbhZ+yEOV
 q3HyEq8RiiBgj9+AE2MmxAVx6UYs1eDHpYjJUhrgdQVO2JXD0HGp77AOdTsSSEKMmDGPsqqP3nG1mpG/Flc54KxnYI2ndBsr7lI5x/VP6qiRcdSw2h69D71r
 3QX2tzmA4pU4AWExCNjWyJoZBWyKjcNcQx0EyuFxUB0H6LOauRymxrmy6RYQ7USyE5k9UoCDbmHZN5jRBPmDF7D7iUj177/WaJSS5QSADojPdHOX3etTKTmd
 LI0eHYyC8xzSxNT1veguFDvzNxAil6e+O19NSBwR94J2vHOOXHpVG8EYhOjAi+Oxnbf1mdYL2l7ID65gtaCTVdebrOmnS5YhKRpM8caClP3/dCLdfcDDN7hJ
 q+ryUSmarCHXySre3Of55Rm7gZ8+wQdGnj3qFg==



On 20/05/25 16:31, Kees Cook wrote:
> All users of dev_set_mac_address() are now using a struct sockaddr_storage.
> Convert the internal data type to struct sockaddr_storage, drop the casts,
> and update pointer types.
> 
> Signed-off-by: Kees Cook <kees@kernel.org>

Acked-by: Gustavo A. R. Silva <gustavoars@kernel.org>

Thanks!
-Gustavo

> ---
> Cc: Jakub Kicinski <kuba@kernel.org>
> Cc: Jay Vosburgh <jv@jvosburgh.net>
> Cc: Andrew Lunn <andrew+netdev@lunn.ch>
> Cc: "David S. Miller" <davem@davemloft.net>
> Cc: Eric Dumazet <edumazet@google.com>
> Cc: Paolo Abeni <pabeni@redhat.com>
> Cc: "K. Y. Srinivasan" <kys@microsoft.com>
> Cc: Haiyang Zhang <haiyangz@microsoft.com>
> Cc: Wei Liu <wei.liu@kernel.org>
> Cc: Dexuan Cui <decui@microsoft.com>
> Cc: Jiri Pirko <jiri@resnulli.us>
> Cc: Simon Horman <horms@kernel.org>
> Cc: Alexander Aring <alex.aring@gmail.com>
> Cc: Stefan Schmidt <stefan@datenfreihafen.org>
> Cc: Miquel Raynal <miquel.raynal@bootlin.com>
> Cc: Samuel Mendoza-Jonas <sam@mendozajonas.com>
> Cc: Paul Fertser <fercerpav@gmail.com>
> Cc: Hayes Wang <hayeswang@realtek.com>
> Cc: Douglas Anderson <dianders@chromium.org>
> Cc: Grant Grundler <grundler@chromium.org>
> Cc: Stanislav Fomichev <sdf@fomichev.me>
> Cc: Cosmin Ratiu <cratiu@nvidia.com>
> Cc: Lei Yang <leiyang@redhat.com>
> Cc: <netdev@vger.kernel.org>
> Cc: <linux-hyperv@vger.kernel.org>
> Cc: <linux-usb@vger.kernel.org>
> Cc: <linux-wpan@vger.kernel.org>
> ---
>   include/linux/netdevice.h       |  2 +-
>   drivers/net/bonding/bond_alb.c  |  8 +++-----
>   drivers/net/bonding/bond_main.c | 10 ++++------
>   drivers/net/hyperv/netvsc_drv.c |  6 +++---
>   drivers/net/macvlan.c           | 10 +++++-----
>   drivers/net/team/team_core.c    |  2 +-
>   drivers/net/usb/r8152.c         |  2 +-
>   net/core/dev.c                  |  1 +
>   net/core/dev_api.c              |  6 +++---
>   net/ieee802154/nl-phy.c         |  2 +-
>   net/ncsi/ncsi-manage.c          |  2 +-
>   11 files changed, 24 insertions(+), 27 deletions(-)
> 
> diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
> index 47200a394a02..b4242b997373 100644
> --- a/include/linux/netdevice.h
> +++ b/include/linux/netdevice.h
> @@ -4214,7 +4214,7 @@ int dev_pre_changeaddr_notify(struct net_device *dev, const char *addr,
>   			      struct netlink_ext_ack *extack);
>   int netif_set_mac_address(struct net_device *dev, struct sockaddr_storage *ss,
>   			  struct netlink_ext_ack *extack);
> -int dev_set_mac_address(struct net_device *dev, struct sockaddr *sa,
> +int dev_set_mac_address(struct net_device *dev, struct sockaddr_storage *ss,
>   			struct netlink_ext_ack *extack);
>   int dev_set_mac_address_user(struct net_device *dev, struct sockaddr *sa,
>   			     struct netlink_ext_ack *extack);
> diff --git a/drivers/net/bonding/bond_alb.c b/drivers/net/bonding/bond_alb.c
> index 7edf0fd58c34..2d37b07c8215 100644
> --- a/drivers/net/bonding/bond_alb.c
> +++ b/drivers/net/bonding/bond_alb.c
> @@ -1035,7 +1035,7 @@ static int alb_set_slave_mac_addr(struct slave *slave, const u8 addr[],
>   	 */
>   	memcpy(ss.__data, addr, len);
>   	ss.ss_family = dev->type;
> -	if (dev_set_mac_address(dev, (struct sockaddr *)&ss, NULL)) {
> +	if (dev_set_mac_address(dev, &ss, NULL)) {
>   		slave_err(slave->bond->dev, dev, "dev_set_mac_address on slave failed! ALB mode requires that the base driver support setting the hw address also when the network device's interface is open\n");
>   		return -EOPNOTSUPP;
>   	}
> @@ -1273,8 +1273,7 @@ static int alb_set_mac_address(struct bonding *bond, void *addr)
>   			break;
>   		bond_hw_addr_copy(tmp_addr, rollback_slave->dev->dev_addr,
>   				  rollback_slave->dev->addr_len);
> -		dev_set_mac_address(rollback_slave->dev,
> -				    (struct sockaddr *)&ss, NULL);
> +		dev_set_mac_address(rollback_slave->dev, &ss, NULL);
>   		dev_addr_set(rollback_slave->dev, tmp_addr);
>   	}
>   
> @@ -1763,8 +1762,7 @@ void bond_alb_handle_active_change(struct bonding *bond, struct slave *new_slave
>   				  bond->dev->addr_len);
>   		ss.ss_family = bond->dev->type;
>   		/* we don't care if it can't change its mac, best effort */
> -		dev_set_mac_address(new_slave->dev, (struct sockaddr *)&ss,
> -				    NULL);
> +		dev_set_mac_address(new_slave->dev, &ss, NULL);
>   
>   		dev_addr_set(new_slave->dev, tmp_addr);
>   	}
> diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_main.c
> index 98cf4486fcee..b92e8935d686 100644
> --- a/drivers/net/bonding/bond_main.c
> +++ b/drivers/net/bonding/bond_main.c
> @@ -1112,8 +1112,7 @@ static void bond_do_fail_over_mac(struct bonding *bond,
>   			ss.ss_family = bond->dev->type;
>   		}
>   
> -		rv = dev_set_mac_address(new_active->dev,
> -					 (struct sockaddr *)&ss, NULL);
> +		rv = dev_set_mac_address(new_active->dev, &ss, NULL);
>   		if (rv) {
>   			slave_err(bond->dev, new_active->dev, "Error %d setting MAC of new active slave\n",
>   				  -rv);
> @@ -1127,8 +1126,7 @@ static void bond_do_fail_over_mac(struct bonding *bond,
>   				  new_active->dev->addr_len);
>   		ss.ss_family = old_active->dev->type;
>   
> -		rv = dev_set_mac_address(old_active->dev,
> -					 (struct sockaddr *)&ss, NULL);
> +		rv = dev_set_mac_address(old_active->dev, &ss, NULL);
>   		if (rv)
>   			slave_err(bond->dev, old_active->dev, "Error %d setting MAC of old active slave\n",
>   				  -rv);
> @@ -2455,7 +2453,7 @@ int bond_enslave(struct net_device *bond_dev, struct net_device *slave_dev,
>   		bond_hw_addr_copy(ss.__data, new_slave->perm_hwaddr,
>   				  new_slave->dev->addr_len);
>   		ss.ss_family = slave_dev->type;
> -		dev_set_mac_address(slave_dev, (struct sockaddr *)&ss, NULL);
> +		dev_set_mac_address(slave_dev, &ss, NULL);
>   	}
>   
>   err_restore_mtu:
> @@ -2649,7 +2647,7 @@ static int __bond_release_one(struct net_device *bond_dev,
>   		bond_hw_addr_copy(ss.__data, slave->perm_hwaddr,
>   				  slave->dev->addr_len);
>   		ss.ss_family = slave_dev->type;
> -		dev_set_mac_address(slave_dev, (struct sockaddr *)&ss, NULL);
> +		dev_set_mac_address(slave_dev, &ss, NULL);
>   	}
>   
>   	if (unregister) {
> diff --git a/drivers/net/hyperv/netvsc_drv.c b/drivers/net/hyperv/netvsc_drv.c
> index d8b169ac0343..14a0d04e21ae 100644
> --- a/drivers/net/hyperv/netvsc_drv.c
> +++ b/drivers/net/hyperv/netvsc_drv.c
> @@ -1371,7 +1371,7 @@ static int netvsc_set_mac_addr(struct net_device *ndev, void *p)
>   	struct net_device_context *ndc = netdev_priv(ndev);
>   	struct net_device *vf_netdev = rtnl_dereference(ndc->vf_netdev);
>   	struct netvsc_device *nvdev = rtnl_dereference(ndc->nvdev);
> -	struct sockaddr *addr = p;
> +	struct sockaddr_storage *addr = p;
>   	int err;
>   
>   	err = eth_prepare_mac_addr_change(ndev, p);
> @@ -1387,12 +1387,12 @@ static int netvsc_set_mac_addr(struct net_device *ndev, void *p)
>   			return err;
>   	}
>   
> -	err = rndis_filter_set_device_mac(nvdev, addr->sa_data);
> +	err = rndis_filter_set_device_mac(nvdev, addr->__data);
>   	if (!err) {
>   		eth_commit_mac_addr_change(ndev, p);
>   	} else if (vf_netdev) {
>   		/* rollback change on VF */
> -		memcpy(addr->sa_data, ndev->dev_addr, ETH_ALEN);
> +		memcpy(addr->__data, ndev->dev_addr, ETH_ALEN);
>   		dev_set_mac_address(vf_netdev, addr, NULL);
>   	}
>   
> diff --git a/drivers/net/macvlan.c b/drivers/net/macvlan.c
> index 7045b1d58754..69e879780c36 100644
> --- a/drivers/net/macvlan.c
> +++ b/drivers/net/macvlan.c
> @@ -754,13 +754,13 @@ static int macvlan_sync_address(struct net_device *dev,
>   static int macvlan_set_mac_address(struct net_device *dev, void *p)
>   {
>   	struct macvlan_dev *vlan = netdev_priv(dev);
> -	struct sockaddr *addr = p;
> +	struct sockaddr_storage *addr = p;
>   
> -	if (!is_valid_ether_addr(addr->sa_data))
> +	if (!is_valid_ether_addr(addr->__data))
>   		return -EADDRNOTAVAIL;
>   
>   	/* If the addresses are the same, this is a no-op */
> -	if (ether_addr_equal(dev->dev_addr, addr->sa_data))
> +	if (ether_addr_equal(dev->dev_addr, addr->__data))
>   		return 0;
>   
>   	if (vlan->mode == MACVLAN_MODE_PASSTHRU) {
> @@ -768,10 +768,10 @@ static int macvlan_set_mac_address(struct net_device *dev, void *p)
>   		return dev_set_mac_address(vlan->lowerdev, addr, NULL);
>   	}
>   
> -	if (macvlan_addr_busy(vlan->port, addr->sa_data))
> +	if (macvlan_addr_busy(vlan->port, addr->__data))
>   		return -EADDRINUSE;
>   
> -	return macvlan_sync_address(dev, addr->sa_data);
> +	return macvlan_sync_address(dev, addr->__data);
>   }
>   
>   static void macvlan_change_rx_flags(struct net_device *dev, int change)
> diff --git a/drivers/net/team/team_core.c b/drivers/net/team/team_core.c
> index d8fc0c79745d..a64e661c21a1 100644
> --- a/drivers/net/team/team_core.c
> +++ b/drivers/net/team/team_core.c
> @@ -55,7 +55,7 @@ static int __set_port_dev_addr(struct net_device *port_dev,
>   
>   	memcpy(addr.__data, dev_addr, port_dev->addr_len);
>   	addr.ss_family = port_dev->type;
> -	return dev_set_mac_address(port_dev, (struct sockaddr *)&addr, NULL);
> +	return dev_set_mac_address(port_dev, &addr, NULL);
>   }
>   
>   static int team_port_set_orig_dev_addr(struct team_port *port)
> diff --git a/drivers/net/usb/r8152.c b/drivers/net/usb/r8152.c
> index b18dee1b1bb3..d6589b24c68d 100644
> --- a/drivers/net/usb/r8152.c
> +++ b/drivers/net/usb/r8152.c
> @@ -8432,7 +8432,7 @@ static int rtl8152_post_reset(struct usb_interface *intf)
>   
>   	/* reset the MAC address in case of policy change */
>   	if (determine_ethernet_addr(tp, &ss) >= 0)
> -		dev_set_mac_address(tp->netdev, (struct sockaddr *)&ss, NULL);
> +		dev_set_mac_address(tp->netdev, &ss, NULL);
>   
>   	netdev = tp->netdev;
>   	if (!netif_running(netdev))
> diff --git a/net/core/dev.c b/net/core/dev.c
> index f8c8aad7df2e..1f1900ec26b2 100644
> --- a/net/core/dev.c
> +++ b/net/core/dev.c
> @@ -9683,6 +9683,7 @@ int netif_set_mac_address(struct net_device *dev, struct sockaddr_storage *ss,
>   
>   DECLARE_RWSEM(dev_addr_sem);
>   
> +/* "sa" is a true struct sockaddr with limited "sa_data" member. */
>   int dev_get_mac_address(struct sockaddr *sa, struct net *net, char *dev_name)
>   {
>   	size_t size = sizeof(sa->sa_data_min);
> diff --git a/net/core/dev_api.c b/net/core/dev_api.c
> index b5f293e637d9..e80404e76ca9 100644
> --- a/net/core/dev_api.c
> +++ b/net/core/dev_api.c
> @@ -319,20 +319,20 @@ EXPORT_SYMBOL(dev_set_allmulti);
>   /**
>    * dev_set_mac_address() - change Media Access Control Address
>    * @dev: device
> - * @sa: new address
> + * @ss: new address
>    * @extack: netlink extended ack
>    *
>    * Change the hardware (MAC) address of the device
>    *
>    * Return: 0 on success, -errno on failure.
>    */
> -int dev_set_mac_address(struct net_device *dev, struct sockaddr *sa,
> +int dev_set_mac_address(struct net_device *dev, struct sockaddr_storage *ss,
>   			struct netlink_ext_ack *extack)
>   {
>   	int ret;
>   
>   	netdev_lock_ops(dev);
> -	ret = netif_set_mac_address(dev, (struct sockaddr_storage *)sa, extack);
> +	ret = netif_set_mac_address(dev, sa, extack);
>   	netdev_unlock_ops(dev);
>   
>   	return ret;
> diff --git a/net/ieee802154/nl-phy.c b/net/ieee802154/nl-phy.c
> index ee2b190e8e0d..4c07a475c567 100644
> --- a/net/ieee802154/nl-phy.c
> +++ b/net/ieee802154/nl-phy.c
> @@ -234,7 +234,7 @@ int ieee802154_add_iface(struct sk_buff *skb, struct genl_info *info)
>   		 * dev_set_mac_address require RTNL_LOCK
>   		 */
>   		rtnl_lock();
> -		rc = dev_set_mac_address(dev, (struct sockaddr *)&addr, NULL);
> +		rc = dev_set_mac_address(dev, &addr, NULL);
>   		rtnl_unlock();
>   		if (rc)
>   			goto dev_unregister;
> diff --git a/net/ncsi/ncsi-manage.c b/net/ncsi/ncsi-manage.c
> index 0202db2aea3e..b36947063783 100644
> --- a/net/ncsi/ncsi-manage.c
> +++ b/net/ncsi/ncsi-manage.c
> @@ -1058,7 +1058,7 @@ static void ncsi_configure_channel(struct ncsi_dev_priv *ndp)
>   		break;
>   	case ncsi_dev_state_config_apply_mac:
>   		rtnl_lock();
> -		ret = dev_set_mac_address(dev, (struct sockaddr *)&ndp->pending_mac, NULL);
> +		ret = dev_set_mac_address(dev, &ndp->pending_mac, NULL);
>   		rtnl_unlock();
>   		if (ret < 0)
>   			netdev_warn(dev, "NCSI: 'Writing MAC address to device failed\n");


