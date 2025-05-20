Return-Path: <linux-hyperv+bounces-5585-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AF81ABE83D
	for <lists+linux-hyperv@lfdr.de>; Wed, 21 May 2025 01:46:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 088014C7B5B
	for <lists+linux-hyperv@lfdr.de>; Tue, 20 May 2025 23:46:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 202FF25392C;
	Tue, 20 May 2025 23:46:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b="RkOEIL8H"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from omta036.useast.a.cloudfilter.net (omta036.useast.a.cloudfilter.net [44.202.169.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B311544C7C;
	Tue, 20 May 2025 23:46:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=44.202.169.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747784804; cv=none; b=e7o1j9LbPyGK8DHmeetQeuz9gPqjCK8uGpXsiBcYLtg/d8baf+t1d84A7zIOs6e9noaRE2NGRBiu0VV7HGugD80B9iw/Rc5h3HJjiFKzV2/WBeUw0BL9bktCnDKncSO+luAXpcmLVq5v3+yPhdkQCtFryWQNs6yHvxZRtvmeajg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747784804; c=relaxed/simple;
	bh=bLUFl9S0ppuDBraRW5HPCuSaH2HqBMXggxUmwVMjqpY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=g2gG/HeyNXm/i6m5oHezu4Iff6iGGIL64VhHD9UYCXLf1+N669MtX1iWOnUZdiwyZZI9VnQNKUc+1Q4K6VP6k8MR09HmhA5/8VTgIY+fGAzF9aQMNLp0pWPcLGlmlZldmKyEgszpKgeh8P6NeEM/I7gG6jV/n6r/oIugaGd9KrY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com; spf=pass smtp.mailfrom=embeddedor.com; dkim=pass (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b=RkOEIL8H; arc=none smtp.client-ip=44.202.169.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=embeddedor.com
Received: from eig-obgw-5002a.ext.cloudfilter.net ([10.0.29.215])
	by cmsmtp with ESMTPS
	id HV1mulW5czZPaHWfQuWA9E; Tue, 20 May 2025 23:46:40 +0000
Received: from gator4166.hostgator.com ([108.167.133.22])
	by cmsmtp with ESMTPS
	id HWfPupK4YJ4PgHWfPuXVMp; Tue, 20 May 2025 23:46:40 +0000
X-Authority-Analysis: v=2.4 cv=ZaLWNdVA c=1 sm=1 tr=0 ts=682d1460
 a=1YbLdUo/zbTtOZ3uB5T3HA==:117 a=efVMuJ2jJG67FGuSm7J3ww==:17
 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=7T7KSl7uo7wA:10 a=VwQbUJbxAAAA:8
 a=vggBfdFIAAAA:8 a=1XWaLZrsAAAA:8 a=J1Y8HTJGAAAA:8 a=20KFwNOVAAAA:8
 a=Ikd4Dj_1AAAA:8 a=80Ll13GqqWtdygCPsrQA:9 a=QEXdDO2ut3YA:10
 a=y1Q9-5lHfBjTkpIzbSAN:22 a=xYX6OU9JNrHFPr8prv8u:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=GCSOMPC5nSp6vXCJCOyw43TeCqRPw0aHopDjgStRrEo=; b=RkOEIL8HdLqtSdBneGawhJ03KC
	V5lylhiwlA4tjpIzNUfTJZWG/JI7KZeu0R6u6RT1Wgrna+sdG1TDsjQp636L0eq6FZoYKWChuB7Fw
	OZ0G0KSPZ070n11fgREH1/0pK0bKpUB1DPc5b1W9aIcMOqclPtiHhEqQxW+bGAm7kgVZE2mo/dh/j
	6zJNBFSYvPNpVvAkrfTJ/WhewMnZXFW4+yGGQzgISc7mhKsZql+BSiIpOk5uDOG5GEinCO8EkqnBy
	s1A4m2PG6KKo5ero7hH8QxQugRIrdkWVBAN3yDhtTyq0bNE9UoLHmAnxwgN9oLTnhDbcmdEAAKCgY
	iZ1Mg+vw==;
Received: from [177.238.17.151] (port=45184 helo=[192.168.0.27])
	by gator4166.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.98.1)
	(envelope-from <gustavo@embeddedor.com>)
	id 1uHVnL-00000001711-3dD6;
	Tue, 20 May 2025 17:50:47 -0500
Message-ID: <2af2857c-d4b9-45c1-b241-dffa23ff4f32@embeddedor.com>
Date: Tue, 20 May 2025 16:50:29 -0600
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 7/7] rtnetlink: do_setlink: Use struct sockaddr_storage
To: Kees Cook <kees@kernel.org>, Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 "David S. Miller" <davem@davemloft.net>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, Ido Schimmel <idosch@nvidia.com>,
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
 <20250520223108.2672023-7-kees@kernel.org>
Content-Language: en-US
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
In-Reply-To: <20250520223108.2672023-7-kees@kernel.org>
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
X-Exim-ID: 1uHVnL-00000001711-3dD6
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: ([192.168.0.27]) [177.238.17.151]:45184
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 0
X-Org: HG=hgshared;ORG=hostgator;
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfBhr7T620cDl5hmzjg9cEWPDyFpOpeDCN3E8pMcuns6h52ziAfClC024x3YzYQB9UuuHs0ergmKEnlhuUPx2EMZeelFPRFED6kM2tjNFw0h4tTPU82ev
 k0jzQe6m/V3iFOQr0NTmNrdVZG8pspKVOYw6Br7t7Ur9kNaso/5mMlupVCzYCafeWP003u6gI6CmPk0m5LdWdY1XQ+F2WpHR6N+OvSC2JJjhskRms7+0iVRl
 vddpxGoS1RcLWQdFZQuohRk40h+aC25VdQcOSD+kKHTNcv/e4zjBNTW6mbc6UyKjiD3b/zDiGan5FKTXK+JOmGvqL/QGnvXubkU1Afr1fcPynffeDhr/X+DP
 hQSfaTcViH/DPoSSPDTfs09bDhuRWa6IMguBtVWRJhIBkVdJNU2WSCkEO+9JUONeFp65nquPRuULRWDFfjZktxL8PEhi9JpQDHEPxLGh0jWvqoQePSAYTtj/
 517k4M1TV2Tf2IMlI5gBCNFLKR2Bs00YNWYe/w==



On 20/05/25 16:31, Kees Cook wrote:
> Instead of a heap allocating a variably sized struct sockaddr and lying
> about the type in the call to netif_set_mac_address(), use a stack
> allocated struct sockaddr_storage. This lets us drop the cast and avoid
> the allocation.
> 
> Putting "ss" on the stack means it will get a reused stack slot since
> it is the same size (128B) as other existing single-scope stack variables,
> like the vfinfo array (128B), so no additional stack space is used by
> this function.
> 
> Signed-off-by: Kees Cook <kees@kernel.org>

Acked-by: Gustavo A. R. Silva <gustavoars@kernel.org>

Thanks!
-Gustavo

> ---
> Cc: Kuniyuki Iwashima <kuniyu@amazon.com>
> Cc: Eric Dumazet <edumazet@google.com>
> Cc: Jakub Kicinski <kuba@kernel.org>
> Cc: "David S. Miller" <davem@davemloft.net>
> Cc: Paolo Abeni <pabeni@redhat.com>
> Cc: Simon Horman <horms@kernel.org>
> Cc: Ido Schimmel <idosch@nvidia.com>
> Cc: <netdev@vger.kernel.org>
> ---
>   net/core/rtnetlink.c | 19 ++++---------------
>   1 file changed, 4 insertions(+), 15 deletions(-)
> 
> diff --git a/net/core/rtnetlink.c b/net/core/rtnetlink.c
> index 9743f1c2ae3c..f9a35bdc58ad 100644
> --- a/net/core/rtnetlink.c
> +++ b/net/core/rtnetlink.c
> @@ -3080,17 +3080,7 @@ static int do_setlink(const struct sk_buff *skb, struct net_device *dev,
>   	}
>   
>   	if (tb[IFLA_ADDRESS]) {
> -		struct sockaddr *sa;
> -		int len;
> -
> -		len = sizeof(sa_family_t) + max_t(size_t, dev->addr_len,
> -						  sizeof(*sa));
> -		sa = kmalloc(len, GFP_KERNEL);
> -		if (!sa) {
> -			err = -ENOMEM;
> -			goto errout;
> -		}
> -		sa->sa_family = dev->type;
> +		struct sockaddr_storage ss = { };
>   
>   		netdev_unlock_ops(dev);
>   
> @@ -3098,10 +3088,9 @@ static int do_setlink(const struct sk_buff *skb, struct net_device *dev,
>   		down_write(&dev_addr_sem);
>   		netdev_lock_ops(dev);
>   
> -		memcpy(sa->sa_data, nla_data(tb[IFLA_ADDRESS]),
> -		       dev->addr_len);
> -		err = netif_set_mac_address(dev, (struct sockaddr_storage *)sa, extack);
> -		kfree(sa);
> +		ss.ss_family = dev->type;
> +		memcpy(ss.__data, nla_data(tb[IFLA_ADDRESS]), dev->addr_len);
> +		err = netif_set_mac_address(dev, &ss, extack);
>   		if (err) {
>   			up_write(&dev_addr_sem);
>   			goto errout;


