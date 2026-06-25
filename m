Return-Path: <linux-hyperv+bounces-11670-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id NAeoGtxgPWre2AgAu9opvQ
	(envelope-from <linux-hyperv+bounces-11670-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Thu, 25 Jun 2026 19:09:48 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id BF4A36C7B70
	for <lists+linux-hyperv@lfdr.de>; Thu, 25 Jun 2026 19:09:47 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=google.com header.s=20251104 header.b=MF7qQ7LY;
	spf=pass (mail.lfdr.de: domain of "linux-hyperv+bounces-11670-lists+linux-hyperv=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-hyperv+bounces-11670-lists+linux-hyperv=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=google.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A7EC73067F2F
	for <lists+linux-hyperv@lfdr.de>; Thu, 25 Jun 2026 17:07:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 237553EA947;
	Thu, 25 Jun 2026 17:07:04 +0000 (UTC)
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85F143A7F4B
	for <linux-hyperv@vger.kernel.org>; Thu, 25 Jun 2026 17:07:02 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782407224; cv=pass; b=qwYOIGQwixZDYqZf1l08QxXeuikottOkZtupiwN45qoMNgHS+ERxaL2B4ZoF2pKChumcwOWRaTH98L8AsIVpoL5BiqdiGsnfAbQ7WL0a5pY6DQbxwHop98EiN8UW8JVNyrCZOMDRrEjJNirA43sKQK0/zTcwdErb8BSyogvKrLI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782407224; c=relaxed/simple;
	bh=VjRITrebxS2FdeRwvnzE4jeb1dxN32OgyohK3nseGuM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=E2yEOVUf+PN2XeaE2Mi+wGu1PWZjNaF3KfGPqNobGW+B6/YKtFL5ADGweBet2+d9HzaJe+9UMleg0Kbhz56MWQjrW2cOs+ldNNKCluicagYf5FsgNpUEEFtP960frgjw5Vpaf94q6eDUUbv9ueziI3FwRyjN3gIswSNMgnGWYoA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=MF7qQ7LY; arc=pass smtp.client-ip=209.85.214.175
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2c6b7bd4e8dso2555ad.0
        for <linux-hyperv@vger.kernel.org>; Thu, 25 Jun 2026 10:07:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782407222; cv=none;
        d=google.com; s=arc-20260327;
        b=DbCvF3cmYFIiuRbTwqiKO69k9mhRQmxS4Vxfq56fy8cRfrdCyY6NBlRk26vPLuJydX
         TjgNCpZXCBkWzRsLBKQBsX7G8LhJf0L2D7Gj7n7DYdDmtos+0aGdEvSOUYlN/dLaA+5W
         xjI2wA8Pw6mF2mHksdjL1YwsQOrMffj8vc2D4/wO54CNA7JL93KqLBrMLWfWfNu+0Fbo
         ZbRuc4DTwF9LaEwMKe9a357Wwz6thsIfJB1Um4xzKy53nq0xjSSLQKHIVd4DprxWmSIr
         Us/2NKqc7ZGhz4Ev6/rK+055QpWue9NCeJ28K//xp7zo0yNNiyy0OzQaK0sjntvYkUpz
         Htww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=+gv2iN67Jx4lTvpF672Ju0BKZFVsTqTbFLT3m2N3fpU=;
        fh=dYkKRLzD1wZorDI0qHaaBWtgXypK/HapWZXjlIR78VE=;
        b=khwH7HPMqUyyLBMSkWA0dRJboK4nO7IhUT7EMBIKwzneSuOqgjfb165K9/NCajopoM
         35e9MwWiHdx9j/c3lMbyPNbCpmyqA9L98DwxecvSVPO4Sgmeksi6GJbcrylUi+WIbD4s
         GPE6/WFLV6b57Sv6/B8VOPdisnMhrvhX8BjKN2YnFzULEtI8/XP+M4Bq8337dObmkN0S
         jaNVXicyAE01HJ36+EVHBrx2e/OiaKAlo69LK14UXdEBrj4vXZXHddzY3467k7yFRr3s
         1N4c/WJJJJAxPsRUbk9QjYhYaybgw1zRQzYxTOpYbrMwT7JOv/r/SyqVEFbKajJZRta/
         +33g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782407222; x=1783012022; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=+gv2iN67Jx4lTvpF672Ju0BKZFVsTqTbFLT3m2N3fpU=;
        b=MF7qQ7LYGHOmI5z3G6mIxi5Ruh6TuiHaEfAas4kKSoAEiHZIjodWB7eVDUsgU3Ed3W
         B9zzYKIR1FA/2Fx4a/kuM/UVszs9R4MbxfH+f5DkEolB4ZZPcGkuyJbIAH6QhL8udEcN
         xmaITaPiA3qSQAfURuF3d9O2VLWgbTISEokh9hA8h2vlMhFQlfaPYKMls0mpivTdbBzp
         k4SIdsDdurvykXHjh8FH6V4pV63QaFFn7l9PbwoIc6YUklK10FNhi42gOEh1YDonGN7f
         WjEyJ9H96hSNzs8jKD7bX1KWrEl2NOSrXpxqB3Gowbq5Q5ibna1FAqtDInFLmshyXfLD
         fPYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782407222; x=1783012022;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+gv2iN67Jx4lTvpF672Ju0BKZFVsTqTbFLT3m2N3fpU=;
        b=NnI6lhjAZzTJsIdNoAuCALHWeTXNjotsr68v7/A+Z+edJbd5bywRT6k216eW9ZmCsu
         k/1UHxhrgsHWq74e+aCe0b+kazgBzzx7zYMqKaja8+cLwhcys2bDd31NHYNIYb0VF6og
         gzZ8L/Su02WqxJdLhlBiSDDGrkc76B3ang3hLDdCM23nKy12aPqg+N5Mvd88aefsWnHv
         vzoFp5dgh4SXWnaLxKmeSknjp7ASom3YimA7b8WTVGBvdo/wokKISdlrXLYjIklZ++YK
         mrrW9VdnVKup8vTRwdYyfosXPjRaqumCRDohrasWfD23Cfxf9lBr/k2Fr6Re0dLkiUtE
         sBXg==
X-Forwarded-Encrypted: i=1; AHgh+RqnRKRZ29dU1dNbc1o4NVzEQTaWKmYSSG4AHKe7OgQ85o45Vzf/Qe649cC1XyURkZ0PM1OIo/wSMbODbWk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyHTv1G6LYyGWrgQIBKUFrKmXcZ3Y5dQwcQBmmrNwrUqwZOvoLg
	1H58M7g6dRRFc5A+Fy1s9HoFkK+vFlhYxeRomQn/Rd1lLGCESv/K+wmF+VNjSw1kLAbRx0435zE
	fWj7MaHJuourQHJdA5y5RMXdJho5jNmuGllnw5tPq
X-Gm-Gg: AfdE7cl5KkKCpv5gtw2tRlLF0jPH+/81NNV8/HbKjXFYjaM9bu/QAKk9HJAiU8MdYHD
	w1JQ5tKBy1zuR6YwdnbpglSZzQ07zPaKbslzOGgwaukLTqtbbcef5D5X9V3RvkEb0oNpSs+Mqb+
	FUCrkSA2RPObDzEvl8dprsGDXk0FnQ0IFSNMNSiAy4kCEq9KLsZRdeS/g97t9U3B+IXf/3HDa85
	o6gDQVnpmaco5R2zmeCBA8hMV0F4AIv8p2tncBH1Oab8xMv1d9E4sYAl77ezQTywaopCX3ED8LI
	1ARJ/Azzeh9FCp6ICUAZmcYmOKnkqb/ah0dafr6cJCgQEF0SELADI/nysJp6ZGNXWE3wJWKDCUB
	fpYEZYQ==
X-Received: by 2002:a17:903:38c4:b0:2c6:99be:9dd with SMTP id
 d9443c01a7336-2c813c543a6mr36575ad.12.1782407221354; Thu, 25 Jun 2026
 10:07:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260624190439.2521219-1-kuba@kernel.org>
In-Reply-To: <20260624190439.2521219-1-kuba@kernel.org>
From: Harshitha Ramamurthy <hramamurthy@google.com>
Date: Thu, 25 Jun 2026 10:06:48 -0700
X-Gm-Features: AVVi8Ce8evT7ej994ABhnHYTPuwIOx5wiakXBTtpYDqzSv4ZHL5uBAZxG7V0oTI
Message-ID: <CAEAWyHfDMjZ7b9LphcUn_Xrz2yWXdSD9cDj3bwW57+=2y+UsmA@mail.gmail.com>
Subject: Re: [PATCH net] net: ethtool: keep rtnl_lock for ops using ethtool_op_get_link()
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com, 
	pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org, 
	Breno Leitao <leitao@debian.org>, joshwash@google.com, anthony.l.nguyen@intel.com, 
	przemyslaw.kitszel@intel.com, saeedm@nvidia.com, tariqt@nvidia.com, 
	mbloch@nvidia.com, leon@kernel.org, alexanderduyck@fb.com, 
	kernel-team@meta.com, kys@microsoft.com, haiyangz@microsoft.com, 
	wei.liu@kernel.org, decui@microsoft.com, longli@microsoft.com, 
	jordanrhee@google.com, jacob.e.keller@intel.com, nktgrg@google.com, 
	debarghyak@google.com, mohsin.bashr@gmail.com, ernis@linux.microsoft.com, 
	sdf@fomichev.me, gal@nvidia.com, linux-rdma@vger.kernel.org, 
	linux-hyperv@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:kuba@kernel.org,m:davem@davemloft.net,m:netdev@vger.kernel.org,m:edumazet@google.com,m:pabeni@redhat.com,m:andrew+netdev@lunn.ch,m:horms@kernel.org,m:leitao@debian.org,m:joshwash@google.com,m:anthony.l.nguyen@intel.com,m:przemyslaw.kitszel@intel.com,m:saeedm@nvidia.com,m:tariqt@nvidia.com,m:mbloch@nvidia.com,m:leon@kernel.org,m:alexanderduyck@fb.com,m:kernel-team@meta.com,m:kys@microsoft.com,m:haiyangz@microsoft.com,m:wei.liu@kernel.org,m:decui@microsoft.com,m:longli@microsoft.com,m:jordanrhee@google.com,m:jacob.e.keller@intel.com,m:nktgrg@google.com,m:debarghyak@google.com,m:mohsin.bashr@gmail.com,m:ernis@linux.microsoft.com,m:sdf@fomichev.me,m:gal@nvidia.com,m:linux-rdma@vger.kernel.org,m:linux-hyperv@vger.kernel.org,m:andrew@lunn.ch,m:mohsinbashr@gmail.com,s:lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-11670-lists,linux-hyperv=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[hramamurthy@google.com,linux-hyperv@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[32];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[google.com:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hramamurthy@google.com,linux-hyperv@vger.kernel.org];
	FREEMAIL_CC(0.00)[davemloft.net,vger.kernel.org,google.com,redhat.com,lunn.ch,kernel.org,debian.org,intel.com,nvidia.com,fb.com,meta.com,microsoft.com,gmail.com,linux.microsoft.com,fomichev.me];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-hyperv,netdev];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: BF4A36C7B70

On Wed, Jun 24, 2026 at 12:04=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> w=
rote:
>
> Breno reports following splats on mlx5:
>
>   RTNL: assertion failed at net/core/dev.c (2241)
>   WARNING: net/core/dev.c:2241 at netif_state_change+0xed/0x130, CPU#5: e=
thtool/1335
>   RIP: 0010:netif_state_change+0xf9/0x130
>   Call Trace:
>     <TASK>
>      __linkwatch_sync_dev+0xea/0x120
>      ethtool_op_get_link+0xe/0x20
>      __ethtool_get_link+0x26/0x40
>      linkstate_prepare_data+0x51/0x200
>      ethnl_default_doit+0x213/0x470
>      genl_family_rcv_msg_doit+0xdd/0x110
>
> Looks like I missed ethtool_op_get_link() trying to sync linkwatch,
> which needs rtnl_lock. Not all drivers do this - bnxt doesn't,
> it just returns the link state, so add an opt-in bit.
>
> Reported-by: Breno Leitao <leitao@debian.org>
> Fixes: 45079e00133e ("net: ethtool: optionally skip rtnl_lock on Netlink =
path for GET ops")
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
> CC: joshwash@google.com
> CC: hramamurthy@google.com
> CC: anthony.l.nguyen@intel.com
> CC: przemyslaw.kitszel@intel.com
> CC: saeedm@nvidia.com
> CC: tariqt@nvidia.com
> CC: mbloch@nvidia.com
> CC: leon@kernel.org
> CC: alexanderduyck@fb.com
> CC: kernel-team@meta.com
> CC: kys@microsoft.com
> CC: haiyangz@microsoft.com
> CC: wei.liu@kernel.org
> CC: decui@microsoft.com
> CC: longli@microsoft.com
> CC: jordanrhee@google.com
> CC: jacob.e.keller@intel.com
> CC: nktgrg@google.com
> CC: debarghyak@google.com
> CC: leitao@debian.org
> CC: mohsin.bashr@gmail.com
> CC: ernis@linux.microsoft.com
> CC: sdf@fomichev.me
> CC: gal@nvidia.com
> CC: linux-rdma@vger.kernel.org
> CC: linux-hyperv@vger.kernel.org
> ---
>  include/linux/ethtool.h                                 | 2 ++
>  net/ethtool/common.h                                    | 4 ++++
>  drivers/net/ethernet/google/gve/gve_ethtool.c           | 3 ++-
>  drivers/net/ethernet/intel/iavf/iavf_ethtool.c          | 1 +
>  drivers/net/ethernet/mellanox/mlx5/core/en_ethtool.c    | 3 ++-
>  drivers/net/ethernet/mellanox/mlx5/core/en_rep.c        | 3 ++-
>  drivers/net/ethernet/mellanox/mlx5/core/ipoib/ethtool.c | 4 +++-
>  drivers/net/ethernet/meta/fbnic/fbnic_ethtool.c         | 3 ++-
>  drivers/net/ethernet/microsoft/mana/mana_ethtool.c      | 3 ++-
>  9 files changed, 20 insertions(+), 6 deletions(-)
>
> diff --git a/include/linux/ethtool.h b/include/linux/ethtool.h
> index 1b834e2a522e..5d491a98265e 100644
> --- a/include/linux/ethtool.h
> +++ b/include/linux/ethtool.h
> @@ -942,6 +942,7 @@ struct kernel_ethtool_ts_info {
>  #define ETHTOOL_OP_NEEDS_RTNL_GPAUSEPARAM      BIT(5)
>  #define ETHTOOL_OP_NEEDS_RTNL_SPAUSEPARAM      BIT(6)
>  #define ETHTOOL_OP_NEEDS_RTNL_RSS              BIT(7)
> +#define ETHTOOL_OP_NEEDS_RTNL_GLINK            BIT(8)
>
>  /**
>   * struct ethtool_ops - optional netdev operations
> @@ -978,6 +979,7 @@ struct kernel_ethtool_ts_info {
>   *      - phylink helpers (note that phydev is currently unsupported!)
>   *      - netdev_update_features()
>   *      - netif_set_real_num_tx_queues()
> + *      - ethtool_op_get_link() (syncs link watch under rtnl_lock)
>   *
>   * @get_drvinfo: Report driver/device information. Modern drivers no
>   *     longer have to implement this callback. Most fields are
> diff --git a/net/ethtool/common.h b/net/ethtool/common.h
> index 2b3847f00801..4e5356e26f40 100644
> --- a/net/ethtool/common.h
> +++ b/net/ethtool/common.h
> @@ -113,6 +113,8 @@ ethtool_nl_msg_needs_rtnl(const struct net_device *de=
v, u8 cmd)
>                 return ops->op_needs_rtnl & ETHTOOL_OP_NEEDS_RTNL_SPAUSEP=
ARAM;
>         case ETHTOOL_MSG_RSS_SET:
>                 return ops->op_needs_rtnl & ETHTOOL_OP_NEEDS_RTNL_RSS;
> +       case ETHTOOL_MSG_LINKSTATE_GET:
> +               return ops->op_needs_rtnl & ETHTOOL_OP_NEEDS_RTNL_GLINK;
>         case ETHTOOL_MSG_TSCONFIG_GET:
>         case ETHTOOL_MSG_TSCONFIG_SET:
>                 /* tsconfig calls ndos (ndo_hwtstamp_set/get), not ethtoo=
l ops.
> @@ -159,6 +161,8 @@ ethtool_ioctl_needs_rtnl(const struct net_device *dev=
, u32 ethcmd)
>         case ETHTOOL_SRXFH:
>         case ETHTOOL_SRXFHINDIR:
>                 return ops->op_needs_rtnl & ETHTOOL_OP_NEEDS_RTNL_RSS;
> +       case ETHTOOL_GLINK:
> +               return ops->op_needs_rtnl & ETHTOOL_OP_NEEDS_RTNL_GLINK;
>         }
>         return false;
>  }
> diff --git a/drivers/net/ethernet/google/gve/gve_ethtool.c b/drivers/net/=
ethernet/google/gve/gve_ethtool.c
> index 7cc22916852f..8199738ba979 100644
> --- a/drivers/net/ethernet/google/gve/gve_ethtool.c
> +++ b/drivers/net/ethernet/google/gve/gve_ethtool.c
> @@ -984,7 +984,8 @@ const struct ethtool_ops gve_ethtool_ops =3D {
>         .supported_ring_params =3D ETHTOOL_RING_USE_TCP_DATA_SPLIT |
>                                  ETHTOOL_RING_USE_RX_BUF_LEN,
>         .op_needs_rtnl =3D ETHTOOL_OP_NEEDS_RTNL_SCHANNELS |
> -                        ETHTOOL_OP_NEEDS_RTNL_SRINGPARAM,
> +                        ETHTOOL_OP_NEEDS_RTNL_SRINGPARAM |
> +                        ETHTOOL_OP_NEEDS_RTNL_GLINK,

Acked-by: Harshitha Ramamurthy <hramamurthy@google.com>

Thanks for the fix!
>         .get_drvinfo =3D gve_get_drvinfo,
>         .get_strings =3D gve_get_strings,
>         .get_sset_count =3D gve_get_sset_count,
> diff --git a/drivers/net/ethernet/intel/iavf/iavf_ethtool.c b/drivers/net=
/ethernet/intel/iavf/iavf_ethtool.c
> index a615d599b88e..e7cf12eaa268 100644
> --- a/drivers/net/ethernet/intel/iavf/iavf_ethtool.c
> +++ b/drivers/net/ethernet/intel/iavf/iavf_ethtool.c
> @@ -1855,6 +1855,7 @@ static const struct ethtool_ops iavf_ethtool_ops =
=3D {
>         .supported_coalesce_params =3D ETHTOOL_COALESCE_USECS |
>                                      ETHTOOL_COALESCE_USE_ADAPTIVE,
>         .supported_input_xfrm   =3D RXH_XFRM_SYM_XOR,
> +       .op_needs_rtnl          =3D ETHTOOL_OP_NEEDS_RTNL_GLINK,
>         .get_drvinfo            =3D iavf_get_drvinfo,
>         .get_link               =3D ethtool_op_get_link,
>         .get_ringparam          =3D iavf_get_ringparam,
> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_ethtool.c b/drive=
rs/net/ethernet/mellanox/mlx5/core/en_ethtool.c
> index 2f5b626ba33f..112926d07634 100644
> --- a/drivers/net/ethernet/mellanox/mlx5/core/en_ethtool.c
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/en_ethtool.c
> @@ -2721,7 +2721,8 @@ const struct ethtool_ops mlx5e_ethtool_ops =3D {
>         .rxfh_max_num_contexts  =3D MLX5E_MAX_NUM_RSS,
>         .op_needs_rtnl          =3D ETHTOOL_OP_NEEDS_RTNL_SCHANNELS |
>                                   ETHTOOL_OP_NEEDS_RTNL_SRINGPARAM |
> -                                 ETHTOOL_OP_NEEDS_RTNL_SPFLAGS,
> +                                 ETHTOOL_OP_NEEDS_RTNL_SPFLAGS |
> +                                 ETHTOOL_OP_NEEDS_RTNL_GLINK,
>         .supported_coalesce_params =3D ETHTOOL_COALESCE_USECS |
>                                      ETHTOOL_COALESCE_MAX_FRAMES |
>                                      ETHTOOL_COALESCE_USE_ADAPTIVE |
> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_rep.c b/drivers/n=
et/ethernet/mellanox/mlx5/core/en_rep.c
> index 1a8a19f980d3..c8b76d301c92 100644
> --- a/drivers/net/ethernet/mellanox/mlx5/core/en_rep.c
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/en_rep.c
> @@ -419,7 +419,8 @@ static const struct ethtool_ops mlx5e_rep_ethtool_ops=
 =3D {
>                                      ETHTOOL_COALESCE_MAX_FRAMES |
>                                      ETHTOOL_COALESCE_USE_ADAPTIVE,
>         .op_needs_rtnl     =3D ETHTOOL_OP_NEEDS_RTNL_SCHANNELS |
> -                            ETHTOOL_OP_NEEDS_RTNL_SRINGPARAM,
> +                            ETHTOOL_OP_NEEDS_RTNL_SRINGPARAM |
> +                            ETHTOOL_OP_NEEDS_RTNL_GLINK,
>         .get_drvinfo       =3D mlx5e_rep_get_drvinfo,
>         .get_link          =3D ethtool_op_get_link,
>         .get_strings       =3D mlx5e_rep_get_strings,
> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/ipoib/ethtool.c b/dr=
ivers/net/ethernet/mellanox/mlx5/core/ipoib/ethtool.c
> index 9b3b32408c64..01ddc3def9ac 100644
> --- a/drivers/net/ethernet/mellanox/mlx5/core/ipoib/ethtool.c
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/ipoib/ethtool.c
> @@ -286,7 +286,8 @@ const struct ethtool_ops mlx5i_ethtool_ops =3D {
>                                      ETHTOOL_COALESCE_MAX_FRAMES |
>                                      ETHTOOL_COALESCE_USE_ADAPTIVE,
>         .op_needs_rtnl      =3D ETHTOOL_OP_NEEDS_RTNL_SCHANNELS |
> -                             ETHTOOL_OP_NEEDS_RTNL_SRINGPARAM,
> +                             ETHTOOL_OP_NEEDS_RTNL_SRINGPARAM |
> +                             ETHTOOL_OP_NEEDS_RTNL_GLINK,
>         .get_drvinfo        =3D mlx5i_get_drvinfo,
>         .get_strings        =3D mlx5i_get_strings,
>         .get_sset_count     =3D mlx5i_get_sset_count,
> @@ -309,6 +310,7 @@ const struct ethtool_ops mlx5i_ethtool_ops =3D {
>  };
>
>  const struct ethtool_ops mlx5i_pkey_ethtool_ops =3D {
> +       .op_needs_rtnl      =3D ETHTOOL_OP_NEEDS_RTNL_GLINK,
>         .get_drvinfo        =3D mlx5i_get_drvinfo,
>         .get_link           =3D ethtool_op_get_link,
>         .get_ts_info        =3D mlx5i_get_ts_info,
> diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_ethtool.c b/drivers/ne=
t/ethernet/meta/fbnic/fbnic_ethtool.c
> index cb34fc166ef9..0e47088ec44b 100644
> --- a/drivers/net/ethernet/meta/fbnic/fbnic_ethtool.c
> +++ b/drivers/net/ethernet/meta/fbnic/fbnic_ethtool.c
> @@ -2024,7 +2024,8 @@ static const struct ethtool_ops fbnic_ethtool_ops =
=3D {
>                                           ETHTOOL_OP_NEEDS_RTNL_GPAUSEPAR=
AM |
>                                           ETHTOOL_OP_NEEDS_RTNL_SPAUSEPAR=
AM |
>                                           ETHTOOL_OP_NEEDS_RTNL_SCHANNELS=
 |
> -                                         ETHTOOL_OP_NEEDS_RTNL_SRINGPARA=
M,
> +                                         ETHTOOL_OP_NEEDS_RTNL_SRINGPARA=
M |
> +                                         ETHTOOL_OP_NEEDS_RTNL_GLINK,
>         .get_drvinfo                    =3D fbnic_get_drvinfo,
>         .get_regs_len                   =3D fbnic_get_regs_len,
>         .get_regs                       =3D fbnic_get_regs,
> diff --git a/drivers/net/ethernet/microsoft/mana/mana_ethtool.c b/drivers=
/net/ethernet/microsoft/mana/mana_ethtool.c
> index 94e658d07a27..881df597d7f9 100644
> --- a/drivers/net/ethernet/microsoft/mana/mana_ethtool.c
> +++ b/drivers/net/ethernet/microsoft/mana/mana_ethtool.c
> @@ -597,7 +597,8 @@ static int mana_get_link_ksettings(struct net_device =
*ndev,
>  const struct ethtool_ops mana_ethtool_ops =3D {
>         .supported_coalesce_params =3D ETHTOOL_COALESCE_RX_CQE_FRAMES,
>         .op_needs_rtnl          =3D ETHTOOL_OP_NEEDS_RTNL_SCHANNELS |
> -                                 ETHTOOL_OP_NEEDS_RTNL_SRINGPARAM,
> +                                 ETHTOOL_OP_NEEDS_RTNL_SRINGPARAM |
> +                                 ETHTOOL_OP_NEEDS_RTNL_GLINK,
>         .get_ethtool_stats      =3D mana_get_ethtool_stats,
>         .get_sset_count         =3D mana_get_sset_count,
>         .get_strings            =3D mana_get_strings,
> --
> 2.54.0
>

