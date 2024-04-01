Return-Path: <linux-hyperv+bounces-1891-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6ECB5893C54
	for <lists+linux-hyperv@lfdr.de>; Mon,  1 Apr 2024 16:48:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D85DC1F22382
	for <lists+linux-hyperv@lfdr.de>; Mon,  1 Apr 2024 14:48:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E9A943AD9;
	Mon,  1 Apr 2024 14:47:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="TpIS40V/"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03olkn2019.outbound.protection.outlook.com [40.92.59.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9D1022093;
	Mon,  1 Apr 2024 14:47:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.59.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711982878; cv=fail; b=cTfXeZa/4Dkf+cEiff6A3xOryPxXk9LNpAnJdYv48SHKW/hwexIymhVlpZI1BH2PIfJh8bVXWyZkfliA1LlpvAkTCt5ZCLoVYUsHvgBhgLrMtajwaxItrz5y/gWlSl2P7pQjS8vl13yw9ipNN51ONdMhKdTII96JxGEoRXfS6uc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711982878; c=relaxed/simple;
	bh=jSTBOeHvBUifJVkPO02Bz3SuHtbS0McW09maEwwhGHw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=uXDywtKxOthEGlpwYEhswjWETAm210T3cM3GhjrL/uBg0fdyPYoENjaJa6nmfZ+Z/64E97wnljrQHH7MOrWBtLyC+nRdZhNH+1qgiB7hBk42SCO3F05+/4QfcZHatu2dlHCiZWxPO1d3VTviZMWbBYpzJ0TN78shZ7JFZnU1xr4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=TpIS40V/; arc=fail smtp.client-ip=40.92.59.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dQl6xllowE/IzAgKaSDg4s5qKNjm4p4DD9VIGmbH8hDCUEJIaBX+zzgui+UTBiZAARJZ4mHUocxeUZFZWezRBuJbv3TREiNP/p/MCYzJfICeh/66iyi5XrKH1G7BfrVbWQGP7KK+NoECf8y1bGAozXsYiJwS1rBJ6ky8nlAHowhbsxTAacDE173dfRsSyHJfLFPit9Oi2+gIm7TkKAZEowWFU5lL29Uu1pFNc15bVtUgNIUhcQHoxhUPmnCNjvlnVV0LRgAuVsJvWxnicZ32uwCuZhZ/deZQi2NMGxDEZw0bDJGh+UmVTZGBGcD27jnahy15StCw5aJxwAd+WblT9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2W6TM4Yr1yOdzb14mH/6ntiPngvX8spSubNkpoXGLyw=;
 b=JerXPPlQR6/higdtNnInE+sj10jQJp5PSmYcZjt0QoYGkl9olp6uyrgX0Jcc/nyz1UDyAi86cpCiJ3Gl9wH5YpQuEqyeoJeHinovA/BN91u/RnwAayORdjIRwDuRaWQQjmWBNcjldo7LjhFkIZFGe02r/29V4C6o6ELqeuP1Oqy6MVzA6qMXL3HwNMgkHN81I9VlS0/w8dIRQMGtw2eoXtLmoXRFOE7wY8pTM8tl7FhBjacOeGZcv3i1+oohJDqII2tJ6lKVSzcbHsobjG2kLHgfpAtjov2+Mx2RwCqw8cMozupuzIwPqeWGcG6LE/Zp/aYwy2vCcKB5a3R0Gk2MWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2W6TM4Yr1yOdzb14mH/6ntiPngvX8spSubNkpoXGLyw=;
 b=TpIS40V/aRc9Do3t7HTgBvSiLlCSPXzEB6gTnhc+JJ8dU0H8gz1fu29EahuFBIlJyDq1M+2GDLgeK1oKCMJtCm5/GgsWc4S8JyW5+KwUhK9F5OMjv6jRRqj0TgrsG4P1z68C/cR631Fsw0w2S+MdL1Q17a7CnZUf5+82v3E7UqQYPtS7U8kn3RDxv1jdOzVgtHYDRoGAxy1jkLmoKfaFUuAs6h+IJLC1WKWiC8ZhN1YMMXxnzlUItcmqoFjfzfCPJVQCH887Vv7z4mCwSof1nMDbBQEoSQdHWZEVgGteb2sJY8r1JABa17g8C1/3z1t6ro6m8oDkC7H5F/q1X0FQkw==
Received: from AS8PR02MB7237.eurprd02.prod.outlook.com (2603:10a6:20b:3f1::10)
 by VI1PR02MB6096.eurprd02.prod.outlook.com (2603:10a6:800:189::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Mon, 1 Apr
 2024 14:47:52 +0000
Received: from AS8PR02MB7237.eurprd02.prod.outlook.com
 ([fe80::9817:eaf5:e2a7:e486]) by AS8PR02MB7237.eurprd02.prod.outlook.com
 ([fe80::9817:eaf5:e2a7:e486%4]) with mapi id 15.20.7409.042; Mon, 1 Apr 2024
 14:47:52 +0000
Date: Mon, 1 Apr 2024 16:47:40 +0200
From: Erick Archer <erick.archer@outlook.com>
To: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc: Erick Archer <erick.archer@outlook.com>, Long Li <longli@microsoft.com>,
	Ajay Sharma <sharmaajay@microsoft.com>,
	Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>,
	"K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Shradha Gupta <shradhagupta@linux.microsoft.com>,
	Konstantin Taranov <kotaranov@microsoft.com>,
	Kees Cook <keescook@chromium.org>, linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-hyperv@vger.kernel.org,
	netdev@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] RDMA/mana_ib: Add flex array to struct
 mana_cfg_rx_steer_req_v2
Message-ID:
 <AS8PR02MB72377480DEF6222736BF72AE8B3F2@AS8PR02MB7237.eurprd02.prod.outlook.com>
References: <AS8PR02MB7237974EF1B9BAFA618166C38B382@AS8PR02MB7237.eurprd02.prod.outlook.com>
 <1be10e9c-e521-4974-b2ed-808a2e3a1a9d@embeddedor.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1be10e9c-e521-4974-b2ed-808a2e3a1a9d@embeddedor.com>
X-TMN: [nOdnsXHVYSR5RruHAWWh/lFIMnzZU5mR]
X-ClientProxiedBy: MA2P292CA0029.ESPP292.PROD.OUTLOOK.COM (2603:10a6:250::19)
 To AS8PR02MB7237.eurprd02.prod.outlook.com (2603:10a6:20b:3f1::10)
X-Microsoft-Original-Message-ID: <20240401144740.GA3664@titan>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR02MB7237:EE_|VI1PR02MB6096:EE_
X-MS-Office365-Filtering-Correlation-Id: 01ebd0ac-8329-409b-a8c5-08dc525ab50e
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	tvEMghliWOOj9OKltKDKXiEz6xku36p2ZIo0eDLDBm0unkSyilvVuJzHrqnJTorLF7xUmtD2mnflJQvAvLGClRmkaW/R/quG/0YpPzoyPoIgj5GlPuWP1G7z9IEJdVvtcJUNQqGOeXEb4Ir++unb0vNBxMx9iyl/Q4Gfu11+473iKlvqGo3cXlAmYpXeRKHNwBARaxLoZ4Yj0V/98o8OLHl/id7Q56EzvMxf6pWx2Ct9tzgixznGFNuYUmpdTqdDa34QzHEWiOvtvwcBWpC8rIpLqjyStNo7uhJ2vE/7S1YCavQIRBc0Z/5yHXTWc6e8NiNtB/DBSFSJlbt+m/Hyn7rRMBd+Kmadk405oAxMs6cHMOsG9zxdL8pFnYhinmGk5Cu29p5Xqa/R8pNK2bPeB1fCtY7KtktYIzI8RznShSVaxDNiwb///0RSPJZDJ9Xva9/HM0krYx6UEfii1giUZPo8Viri7a1o+R/s6q6INHNDpIwHEU1KcQ/V6as8QGQBLdS8GLCxNgAn5gdsfx3kqAL9rfXGhPzTgEpT2i5Xw0JYB4QBPxvw2pNl8JSbisHFXx+MrWqx41yjm6fnj47AxAoe2aBqrgitoJEEuYQ8ogKL/W3H/+Guz3ToTTOi3/j8GV9m39SeHxoZemU7nfqqU9cMbeYbQp4dMqR1BEc0UOsaqyziSEmuR/JOdMsR2Spu
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?eNx3sH1829DKsdOreYhrpU/HscpM1pPmhXlaC8Mld6AwG1IYbm7kXfHP1Ic4?=
 =?us-ascii?Q?+FvCfdeSjmTAqJMnk6cejmSceQkpPIOvtS5PGdGUNso3Kz8INENGTgAFmB9N?=
 =?us-ascii?Q?tb11Kdg9r2Vuv9uHvP/Ww91ZjYxOkJC3ZVbMdUUk01WLlOm3TYcSD3DRrY3l?=
 =?us-ascii?Q?MTvBTrNXUEFEkVebBpcj0Fh+WpRYIhQXeBuqsWfNC02vtG82Q0cr1ugD/ZGY?=
 =?us-ascii?Q?VpVg4Rw/BucVmiFT/cPHkYDsdN+CqdXPHToCGbnAxSqTF6dzSIDJlw94axTN?=
 =?us-ascii?Q?g/3m33zB9RILgHhcclKMyPZKls8RVn+myzjPo0xPH+hdyWHu7BVlkbbuew2P?=
 =?us-ascii?Q?AJWopAXnQIl3PvLsW4Ts6VXKutUTyq2WTBQLdYpI2NeFY4g57dxUp8czeZXh?=
 =?us-ascii?Q?4LEfSLQN9l6tjMpNS0KkMtol/c9wpWfYz28sgFGJ1Yay5BYgeeiSE9QOzfx6?=
 =?us-ascii?Q?GYWslCqJj7dRXa/2oD/WFcKwBgqlRADGvzu8ViLSBK94DnhOTHWxrlmR1tk9?=
 =?us-ascii?Q?vrlraUjZv/kyxHAERnTqH9cjGLXua7I8Dmy7SyDbaCsXvCesdh2Aad+DBrEo?=
 =?us-ascii?Q?Wb2I7xJ62+KXv29FQ1HuFelZaal/T6qxGrLOYFHQpvYqTdwR2LPep05kSaV7?=
 =?us-ascii?Q?BWPweTVHeGPeUDkA0epTYrHaZwOy2WAtI3cknG3E0IlhLOheqLKkIoFi0N2P?=
 =?us-ascii?Q?yEX3IdsxUTtR7cmSlwaWFn3Mt+qBL5PySgWAHBpMsmQtRVlyw5By4Cm9arRs?=
 =?us-ascii?Q?K5tEQ21DthBQtsODRo2XAZofWCCvoOjlVVAeU5gn0nkQseiXGHwfG2SvkyHC?=
 =?us-ascii?Q?RXYcWML/y9UmdVU6e3ZVg37WkZliqWH5YytTVwWAPwssc3kK1QgslZINxMQw?=
 =?us-ascii?Q?zERt715pgrxDWELMOKXqKkM5VeF/vOjEhTWykCC1cc9WgJ21b69bod0oJMiP?=
 =?us-ascii?Q?MyxSfZaAua6sqDfmDOuBS0PcldIXjEOmvCVd/O6qVm5s5BfMGnHY+A6p6hsr?=
 =?us-ascii?Q?CYHU+CwovhrdVd3/KEWCYeT5/5QRu1tcXYYyosdP+VPiy0Q08cuMjtulKoLs?=
 =?us-ascii?Q?bOxGF55TImcxYtM4QM19RpYtqTncCp82SLPP4M0sAzXPv1hJhOtI3+sKH2OV?=
 =?us-ascii?Q?GrTCXCoGbmv88rbczhHZWwr2oYX7nB4PcEykhOYV4Cj3/f7MVGhCdcKA/gSL?=
 =?us-ascii?Q?xTQCOS1Xf2tCCT0Y9+yX9fRrsw4mIq/K23QB+Qt8z+HkPhbSvrrHDOEUbiAi?=
 =?us-ascii?Q?0FvrI46z9NfghMbn5wmn?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 01ebd0ac-8329-409b-a8c5-08dc525ab50e
X-MS-Exchange-CrossTenant-AuthSource: AS8PR02MB7237.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Apr 2024 14:47:51.9632
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR02MB6096

Hi Gustavo,

On Sun, Mar 31, 2024 at 08:53:07PM -0600, Gustavo A. R. Silva wrote:
> 
> 
> On 31/03/24 09:04, Erick Archer wrote:
> > The "struct mana_cfg_rx_steer_req_v2" uses a dynamically sized set of
> > trailing elements. Specifically, it uses a "mana_handle_t" array. So,
> > use the preferred way in the kernel declaring a flexible array [1].
> > 
> > Also, avoid the open-coded arithmetic in the memory allocator functions
> > [2] using the "struct_size" macro.
> > 
> > Moreover, use the "offsetof" helper to get the indirect table offset
> > instead of the "sizeof" operator and avoid the open-coded arithmetic in
> > pointers using the new flex member.
> > 
> > Now, it is also possible to use the "flex_array_size" helper to compute
> > the size of these trailing elements in the "memcpy" function.
> > 
> > Link: https://www.kernel.org/doc/html/next/process/deprecated.html#zero-length-and-one-element-arrays [1]
> > Link: https://www.kernel.org/doc/html/next/process/deprecated.html#open-coded-arithmetic-in-allocator-arguments [2]
> > Signed-off-by: Erick Archer <erick.archer@outlook.com>
> > ---
> >   drivers/infiniband/hw/mana/qp.c               | 8 ++++----
> >   drivers/net/ethernet/microsoft/mana/mana_en.c | 9 +++++----
> >   include/net/mana/mana.h                       | 1 +
> >   3 files changed, 10 insertions(+), 8 deletions(-)
> > 
> > diff --git a/drivers/infiniband/hw/mana/qp.c b/drivers/infiniband/hw/mana/qp.c
> > index 6e7627745c95..c2a39db8ef92 100644
> > --- a/drivers/infiniband/hw/mana/qp.c
> > +++ b/drivers/infiniband/hw/mana/qp.c
> > @@ -22,8 +22,7 @@ static int mana_ib_cfg_vport_steering(struct mana_ib_dev *dev,
> >   	gc = mdev_to_gc(dev);
> > -	req_buf_size =
> > -		sizeof(*req) + sizeof(mana_handle_t) * MANA_INDIRECT_TABLE_SIZE;
> > +	req_buf_size = struct_size(req, indir_tab, MANA_INDIRECT_TABLE_SIZE);
> >   	req = kzalloc(req_buf_size, GFP_KERNEL);
> >   	if (!req)
> >   		return -ENOMEM;
> > @@ -44,11 +43,12 @@ static int mana_ib_cfg_vport_steering(struct mana_ib_dev *dev,
> >   		req->rss_enable = true;
> >   	req->num_indir_entries = MANA_INDIRECT_TABLE_SIZE;
> > -	req->indir_tab_offset = sizeof(*req);
> > +	req->indir_tab_offset = offsetof(struct mana_cfg_rx_steer_req_v2,
> > +					 indir_tab);
> >   	req->update_indir_tab = true;
> >   	req->cqe_coalescing_enable = 1;
> > -	req_indir_tab = (mana_handle_t *)(req + 1);
> > +	req_indir_tab = req->indir_tab;
> 
> It seems that `req_indir_tab` can be removed, and `req->indir_tab` be directly used.

It seems reasonable to me. Thanks for looking at this.

Regards,
Erick

> 
> >   	/* The ind table passed to the hardware must have
> >   	 * MANA_INDIRECT_TABLE_SIZE entries. Adjust the verb
> >   	 * ind_table to MANA_INDIRECT_TABLE_SIZE if required
> > diff --git a/drivers/net/ethernet/microsoft/mana/mana_en.c b/drivers/net/ethernet/microsoft/mana/mana_en.c
> > index 59287c6e6cee..04aa096c6cc4 100644
> > --- a/drivers/net/ethernet/microsoft/mana/mana_en.c
> > +++ b/drivers/net/ethernet/microsoft/mana/mana_en.c
> > @@ -1062,7 +1062,7 @@ static int mana_cfg_vport_steering(struct mana_port_context *apc,
> >   	u32 req_buf_size;
> >   	int err;
> > -	req_buf_size = sizeof(*req) + sizeof(mana_handle_t) * num_entries;
> > +	req_buf_size = struct_size(req, indir_tab, num_entries);
> >   	req = kzalloc(req_buf_size, GFP_KERNEL);
> >   	if (!req)
> >   		return -ENOMEM;
> > @@ -1074,7 +1074,8 @@ static int mana_cfg_vport_steering(struct mana_port_context *apc,
> >   	req->vport = apc->port_handle;
> >   	req->num_indir_entries = num_entries;
> > -	req->indir_tab_offset = sizeof(*req);
> > +	req->indir_tab_offset = offsetof(struct mana_cfg_rx_steer_req_v2,
> > +					 indir_tab);
> >   	req->rx_enable = rx;
> >   	req->rss_enable = apc->rss_state;
> >   	req->update_default_rxobj = update_default_rxobj;
> > @@ -1087,9 +1088,9 @@ static int mana_cfg_vport_steering(struct mana_port_context *apc,
> >   		memcpy(&req->hashkey, apc->hashkey, MANA_HASH_KEY_SIZE);
> >   	if (update_tab) {
> > -		req_indir_tab = (mana_handle_t *)(req + 1);
> > +		req_indir_tab = req->indir_tab;
> 
> Ditto.
> 
> Thanks
> --
> Gustavo
> 
> >   		memcpy(req_indir_tab, apc->rxobj_table,
> > -		       req->num_indir_entries * sizeof(mana_handle_t));
> > +		       flex_array_size(req, indir_tab, req->num_indir_entries));
> >   	}
> >   	err = mana_send_request(apc->ac, req, req_buf_size, &resp,
> > diff --git a/include/net/mana/mana.h b/include/net/mana/mana.h
> > index 76147feb0d10..20ffcae29e1e 100644
> > --- a/include/net/mana/mana.h
> > +++ b/include/net/mana/mana.h
> > @@ -671,6 +671,7 @@ struct mana_cfg_rx_steer_req_v2 {
> >   	u8 hashkey[MANA_HASH_KEY_SIZE];
> >   	u8 cqe_coalescing_enable;
> >   	u8 reserved2[7];
> > +	mana_handle_t indir_tab[];
> >   }; /* HW DATA */
> >   struct mana_cfg_rx_steer_resp {

