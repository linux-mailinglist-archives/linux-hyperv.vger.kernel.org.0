Return-Path: <linux-hyperv+bounces-5590-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 57764ABE963
	for <lists+linux-hyperv@lfdr.de>; Wed, 21 May 2025 03:55:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 37E208A0D4F
	for <lists+linux-hyperv@lfdr.de>; Wed, 21 May 2025 01:54:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 491B322154A;
	Wed, 21 May 2025 01:54:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b="p/QC0DeZ"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from omta038.useast.a.cloudfilter.net (omta038.useast.a.cloudfilter.net [44.202.169.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A23EE19CC3A;
	Wed, 21 May 2025 01:54:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=44.202.169.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747792462; cv=none; b=jMCvw42VlJWMtw9UWIqLk4tZyyUfgdEfakif0PbQaCDiAjr6uCo3EBirI7PRkzhVnJINkTRoXg2CoOY4IVz8JOYiSKOSXkP9mzdfYTsIA2bnLv/C73nQOj3m+wT6E3n0tJdyOMyJ6Zf1N766Fl7Q8Galj5Wvs7sX1rqWk5ZEVLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747792462; c=relaxed/simple;
	bh=FRBU12wCTaCzoZ5TtifNKBgvl3lXOKevuBirxZjnEIs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MHM5c7Cvm9xySLzI8VLHAW82+/IYMhpWLoSmmPew/YSpDqSzFTm+Y0BUPg4baDn0s6epROVhCAjm2AcWFTwB5KNj7ovEwJkYo8SbiVzLSn42JdjfgjFh3eA6rcTNSOBVq5Z1hp0+GHO5N15WdCSiwYyGovi96U2MCefipcCtxUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com; spf=pass smtp.mailfrom=embeddedor.com; dkim=pass (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b=p/QC0DeZ; arc=none smtp.client-ip=44.202.169.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=embeddedor.com
Received: from eig-obgw-5004a.ext.cloudfilter.net ([10.0.29.221])
	by cmsmtp with ESMTPS
	id HVXFuuOjiiuzSHYewu07Qv; Wed, 21 May 2025 01:54:18 +0000
Received: from gator4166.hostgator.com ([108.167.133.22])
	by cmsmtp with ESMTPS
	id HYevuAubgjrgqHYevuhsS9; Wed, 21 May 2025 01:54:18 +0000
X-Authority-Analysis: v=2.4 cv=PK7E+uqC c=1 sm=1 tr=0 ts=682d324a
 a=1YbLdUo/zbTtOZ3uB5T3HA==:117 a=efVMuJ2jJG67FGuSm7J3ww==:17
 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=7T7KSl7uo7wA:10 a=VwQbUJbxAAAA:8
 a=jT_9lS9cAAAA:8 a=pGLkceISAAAA:8 a=J1Y8HTJGAAAA:8 a=1XWaLZrsAAAA:8
 a=20KFwNOVAAAA:8 a=jAoKAhDiyLNNFIt04WcA:9 a=QEXdDO2ut3YA:10
 a=Ec8Bv2-zM_L_lWdDgjzK:22 a=y1Q9-5lHfBjTkpIzbSAN:22 a=xYX6OU9JNrHFPr8prv8u:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=m0Sgv2xQObBfrVQ5o4f/G36TLeQWyWSFMFj3tSm1xxo=; b=p/QC0DeZWBoMfFQmEYO8zYmywp
	gUvDU/K3IwDn8tTqJo55ZHGzxFxuJROBdMK9HOfEDm4KuUdAL3fKX9WJ1Noque7KlutJ2VjZHe0Ra
	Ff3KfWQjbx8/nndfcLIBULP8MQeA6ebPdBOKgArsYtJZ4C/cmghkHbrRzdWdrNu6mRd+BnJWtA1b2
	sCUIcIwFpmNuP7TNaEcF0AgBSKbIG/KpYOV37upwXUJdo7Z4qOTDgs1MCk4+bHspuC6gu1LPlzHz6
	9HKuSL2pU20c4fCDAN3ELqTlFDLFNibvvrYejrntX+nAgwUPRw1day3awBaDB8IqsJ7S1TYpA/2S9
	98thY1HA==;
Received: from [177.238.17.151] (port=48738 helo=[192.168.0.27])
	by gator4166.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.98.1)
	(envelope-from <gustavo@embeddedor.com>)
	id 1uHVlQ-000000011s1-1d7y;
	Tue, 20 May 2025 17:48:49 -0500
Message-ID: <b5ead7f5-1bc1-442f-9d17-34564571b3ce@embeddedor.com>
Date: Tue, 20 May 2025 16:48:22 -0600
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/7] net/ncsi: Use struct sockaddr_storage for pending_mac
To: Kees Cook <kees@kernel.org>, Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: Samuel Mendoza-Jonas <sam@mendozajonas.com>,
 Paul Fertser <fercerpav@gmail.com>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
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
 Ido Schimmel <idosch@nvidia.com>, Alexander Aring <alex.aring@gmail.com>,
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
 <20250520223108.2672023-3-kees@kernel.org>
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
In-Reply-To: <20250520223108.2672023-3-kees@kernel.org>
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
X-Exim-ID: 1uHVlQ-000000011s1-1d7y
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: ([192.168.0.27]) [177.238.17.151]:48738
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 0
X-Org: HG=hgshared;ORG=hostgator;
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfAvcIswbcUWc4bBDOBjZtXxaoPiqdp+0efhrHksXO3x7koYuEZG38qQMCYn2bintxrM5ucCU/YQiLpCw2YkFmGGCdA5EALxS66F78PgQ/xMLAFB2Yz7j
 QlZnhXt9CZ2FZPSlGq5IhhWyRZI1NAWQCuz7xCQBiey+BUbqLrC0fmHGId16/MGNrkj8a0U2dtSdWwfFE41YF1NrJrkOxRLHS9yr6FNNseY/6cU5TL/9FLNX
 ZM+yLmA4DYxBVyPZRcDtR7nP8Y2BW3fRkZGN3CB/erB70+S0dXQQbZxWiRIO8iLVDHfphuYL+MHIWzJyq60837pBu6fQyjG/EtY4ExiYTvojiKiOydUL0s+9
 uj2V5rovYwmZrNBzfTstvW2Gy6jsHT1t452XbqzyEKtf2rLjcDc=



On 20/05/25 16:31, Kees Cook wrote:
> To avoid future casting with coming API type changes, switch struct
> ncsi_dev_priv::pending_mac to a full struct sockaddr_storage.
> 
> Signed-off-by: Kees Cook <kees@kernel.org>

Acked-by: Gustavo A. R. Silva <gustavoars@kernel.org>

Thanks!
-Gustavo

> ---
> Cc: Samuel Mendoza-Jonas <sam@mendozajonas.com>
> Cc: Paul Fertser <fercerpav@gmail.com>
> Cc: "David S. Miller" <davem@davemloft.net>
> Cc: Eric Dumazet <edumazet@google.com>
> Cc: Jakub Kicinski <kuba@kernel.org>
> Cc: Paolo Abeni <pabeni@redhat.com>
> Cc: Simon Horman <horms@kernel.org>
> Cc: <netdev@vger.kernel.org>
> ---
>   net/ncsi/internal.h    |  2 +-
>   net/ncsi/ncsi-manage.c |  2 +-
>   net/ncsi/ncsi-rsp.c    | 18 +++++++++---------
>   3 files changed, 11 insertions(+), 11 deletions(-)
> 
> diff --git a/net/ncsi/internal.h b/net/ncsi/internal.h
> index 2c260f33b55c..e76c6de0c784 100644
> --- a/net/ncsi/internal.h
> +++ b/net/ncsi/internal.h
> @@ -322,7 +322,7 @@ struct ncsi_dev_priv {
>   #define NCSI_DEV_RESHUFFLE	4
>   #define NCSI_DEV_RESET		8            /* Reset state of NC          */
>   	unsigned int        gma_flag;        /* OEM GMA flag               */
> -	struct sockaddr     pending_mac;     /* MAC address received from GMA */
> +	struct sockaddr_storage pending_mac; /* MAC address received from GMA */
>   	spinlock_t          lock;            /* Protect the NCSI device    */
>   	unsigned int        package_probe_id;/* Current ID during probe    */
>   	unsigned int        package_num;     /* Number of packages         */
> diff --git a/net/ncsi/ncsi-manage.c b/net/ncsi/ncsi-manage.c
> index b36947063783..0202db2aea3e 100644
> --- a/net/ncsi/ncsi-manage.c
> +++ b/net/ncsi/ncsi-manage.c
> @@ -1058,7 +1058,7 @@ static void ncsi_configure_channel(struct ncsi_dev_priv *ndp)
>   		break;
>   	case ncsi_dev_state_config_apply_mac:
>   		rtnl_lock();
> -		ret = dev_set_mac_address(dev, &ndp->pending_mac, NULL);
> +		ret = dev_set_mac_address(dev, (struct sockaddr *)&ndp->pending_mac, NULL);
>   		rtnl_unlock();
>   		if (ret < 0)
>   			netdev_warn(dev, "NCSI: 'Writing MAC address to device failed\n");
> diff --git a/net/ncsi/ncsi-rsp.c b/net/ncsi/ncsi-rsp.c
> index 8668888c5a2f..472cc68ad86f 100644
> --- a/net/ncsi/ncsi-rsp.c
> +++ b/net/ncsi/ncsi-rsp.c
> @@ -628,7 +628,7 @@ static int ncsi_rsp_handler_snfc(struct ncsi_request *nr)
>   static int ncsi_rsp_handler_oem_gma(struct ncsi_request *nr, int mfr_id)
>   {
>   	struct ncsi_dev_priv *ndp = nr->ndp;
> -	struct sockaddr *saddr = &ndp->pending_mac;
> +	struct sockaddr_storage *saddr = &ndp->pending_mac;
>   	struct net_device *ndev = ndp->ndev.dev;
>   	struct ncsi_rsp_oem_pkt *rsp;
>   	u32 mac_addr_off = 0;
> @@ -644,11 +644,11 @@ static int ncsi_rsp_handler_oem_gma(struct ncsi_request *nr, int mfr_id)
>   	else if (mfr_id == NCSI_OEM_MFR_INTEL_ID)
>   		mac_addr_off = INTEL_MAC_ADDR_OFFSET;
>   
> -	saddr->sa_family = ndev->type;
> -	memcpy(saddr->sa_data, &rsp->data[mac_addr_off], ETH_ALEN);
> +	saddr->ss_family = ndev->type;
> +	memcpy(saddr->__data, &rsp->data[mac_addr_off], ETH_ALEN);
>   	if (mfr_id == NCSI_OEM_MFR_BCM_ID || mfr_id == NCSI_OEM_MFR_INTEL_ID)
> -		eth_addr_inc((u8 *)saddr->sa_data);
> -	if (!is_valid_ether_addr((const u8 *)saddr->sa_data))
> +		eth_addr_inc(saddr->__data);
> +	if (!is_valid_ether_addr(saddr->__data))
>   		return -ENXIO;
>   
>   	/* Set the flag for GMA command which should only be called once */
> @@ -1088,7 +1088,7 @@ static int ncsi_rsp_handler_netlink(struct ncsi_request *nr)
>   static int ncsi_rsp_handler_gmcma(struct ncsi_request *nr)
>   {
>   	struct ncsi_dev_priv *ndp = nr->ndp;
> -	struct sockaddr *saddr = &ndp->pending_mac;
> +	struct sockaddr_storage *saddr = &ndp->pending_mac;
>   	struct net_device *ndev = ndp->ndev.dev;
>   	struct ncsi_rsp_gmcma_pkt *rsp;
>   	int i;
> @@ -1105,15 +1105,15 @@ static int ncsi_rsp_handler_gmcma(struct ncsi_request *nr)
>   			    rsp->addresses[i][4], rsp->addresses[i][5]);
>   	}
>   
> -	saddr->sa_family = ndev->type;
> +	saddr->ss_family = ndev->type;
>   	for (i = 0; i < rsp->address_count; i++) {
>   		if (!is_valid_ether_addr(rsp->addresses[i])) {
>   			netdev_warn(ndev, "NCSI: Unable to assign %pM to device\n",
>   				    rsp->addresses[i]);
>   			continue;
>   		}
> -		memcpy(saddr->sa_data, rsp->addresses[i], ETH_ALEN);
> -		netdev_warn(ndev, "NCSI: Will set MAC address to %pM\n", saddr->sa_data);
> +		memcpy(saddr->__data, rsp->addresses[i], ETH_ALEN);
> +		netdev_warn(ndev, "NCSI: Will set MAC address to %pM\n", saddr->__data);
>   		break;
>   	}
>   


