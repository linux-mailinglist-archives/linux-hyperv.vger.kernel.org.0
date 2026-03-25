Return-Path: <linux-hyperv+bounces-9775-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wLQSBd46xGnkxQQAu9opvQ
	(envelope-from <linux-hyperv+bounces-9775-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Wed, 25 Mar 2026 20:43:26 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 28E4D32B68E
	for <lists+linux-hyperv@lfdr.de>; Wed, 25 Mar 2026 20:43:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 25BD1300BE3D
	for <lists+linux-hyperv@lfdr.de>; Wed, 25 Mar 2026 19:43:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CA0A3DD525;
	Wed, 25 Mar 2026 19:42:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="NSSFqO9E"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11021120.outbound.protection.outlook.com [52.101.52.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 647F23DB63A;
	Wed, 25 Mar 2026 19:42:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.120
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774467779; cv=fail; b=qwPUjT9drk8GCwiDZxCUljYelucH5d31QKVW1s+E4bIqsH6GyJQxLDPzJp4fqfYZ70fMQRiW645hE8L7713FCvq/FRPh0YQcHhMMGebij+svJ8VrwNFdJwl8+RgivWvVIDMUteVuy47P7F523cVoMZhFVkWc5kCMfVmzS3ZxVlg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774467779; c=relaxed/simple;
	bh=QNQka3SQnxi8mHUof0aV57qGv3FV7svZsE9uOBGakjs=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Z1efAIBwVx3mg6zgjueaTba6N5wkPoPeXxPIiki1hqY4I31+rgQZr2oF5/XjE8USdDMGirAN7NPZZVI/CrU/iBpcHzm1tQVLZ+0uWzqTp686iP7CYaGq5/Fpy7Mtax3P1dR1iBQkYad914h21+nMMXTK/vi2tF65bG1DAjOAhEU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com; spf=pass smtp.mailfrom=microsoft.com; dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b=NSSFqO9E; arc=fail smtp.client-ip=52.101.52.120
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microsoft.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=V7lw3KsCDKzW5Jd9Ps71BcBwFez7YiNmhsYcjx5oGf3BMbUNQJO5ZxZvrb5+IUJiEyiRArrj23+d2qb9YLSuRHZE8AcVMzB+JVtkE4WvRVSX2lWcAXNGXxStT3VZeYWyaHNccqwcFuF5+AGcaibvZWm0jQ3SoIpSQdi19s+S4Nhe77Ca1KTG0ZpomRXePe5Q252UKsQe/s3ZOYarIW7duWe2AQicaB40XrH668xDZhK0dL/bY86pnad/PXmfz/fUokZKUwTwXZTzfzfqGtJNAqHeiEiIYvkkBjU7fvheBhzjt3ttL2cKO7kWg6BvRRJhUiJFSgqaGspIhdnSn+1PsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e6sxiEMhWCUxmn8YjdJLCIR8w4TGJYe4UOJbAth7k3U=;
 b=AxhUyl+lxCZnQuIjsr08rzTZkCtqW5Y6EQAqyCX2ZfNNiHoVImrehibXaseMRRKlohKaLbW0uUNNG//OCDAY5jBfUReKtYQlPole37vpQhsrYvVs6FuXGl2LN6qt4zrPzmku9XTYNn8qV3t6L/lIZADSXTauAsPpfea3OEUg+RIeFOtljc2nD0bOMLuiUtSq1Z6QdakyXF7DDmHDM3KLj17hTArR5mbCD+7RCXN7eU2zOVic9mag4XobdMf9o3r2XqiffU3tzgQJe7v/tk6tQ1DkaPQjXDh4IR9D9BDPmHoGMjGUdWd/YlNawe1C1CbIUweN/w5FCArpeI7skVxlNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e6sxiEMhWCUxmn8YjdJLCIR8w4TGJYe4UOJbAth7k3U=;
 b=NSSFqO9EeVlaJuWNs9Kup6dHicfY0RlNs5cvHM3aodYdq6j2tN1XJDy+eCRVSk1q18G98x1YOIzIR2ZNEI19M5W5JrQbkd/9THYRlk9SmFg5Xaeg7poO8eHxX7XbWM38gvskpNdDVTBEFwvHp/xEozi2c/4joQXEYkK7nizs1cY=
Received: from SA1PR21MB6683.namprd21.prod.outlook.com (2603:10b6:806:4a4::6)
 by SA1PR21MB6874.namprd21.prod.outlook.com (2603:10b6:806:4a4::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.18; Wed, 25 Mar
 2026 19:42:54 +0000
Received: from SA1PR21MB6683.namprd21.prod.outlook.com
 ([fe80::879f:eec1:ca0e:d219]) by SA1PR21MB6683.namprd21.prod.outlook.com
 ([fe80::879f:eec1:ca0e:d219%3]) with mapi id 15.20.9769.006; Wed, 25 Mar 2026
 19:42:53 +0000
From: Long Li <longli@microsoft.com>
To: Leon Romanovsky <leon@kernel.org>
CC: Konstantin Taranov <kotaranov@microsoft.com>, Jakub Kicinski
	<kuba@kernel.org>, "David S . Miller" <davem@davemloft.net>, Paolo Abeni
	<pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>, Andrew Lunn
	<andrew+netdev@lunn.ch>, Jason Gunthorpe <jgg@ziepe.ca>, Haiyang Zhang
	<haiyangz@microsoft.com>, KY Srinivasan <kys@microsoft.com>, Wei Liu
	<wei.liu@kernel.org>, Dexuan Cui <DECUI@microsoft.com>, Simon Horman
	<horms@kernel.org>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: RE: [EXTERNAL] Re: [PATCH rdma v2] RDMA/mana_ib: Disable RX steering
 on RSS QP destroy
Thread-Topic: [EXTERNAL] Re: [PATCH rdma v2] RDMA/mana_ib: Disable RX steering
 on RSS QP destroy
Thread-Index: AQHcuwE38p0i/et8k0e/DtDt99DqcrW++WiAgACvSjA=
Date: Wed, 25 Mar 2026 19:42:53 +0000
Message-ID:
 <SA1PR21MB6683E4284B7C6DF6E9B6F984CE49A@SA1PR21MB6683.namprd21.prod.outlook.com>
References: <20260323201106.1768705-1-longli@microsoft.com>
 <20260325091357.GP814676@unreal>
In-Reply-To: <20260325091357.GP814676@unreal>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=24882efd-9473-4cd6-ab50-6a0f1d82a5fb;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2026-03-25T19:41:19Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Tag=10,
 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR21MB6683:EE_|SA1PR21MB6874:EE_
x-ms-office365-filtering-correlation-id: 642fce14-42c2-43ca-3b94-08de8aa6b4fa
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|7416014|376014|38070700021|22082099003|56012099003|18002099003;
x-microsoft-antispam-message-info:
 0xKnWZ+PUu2CkNIqgxX2UOP+KMsQ0hcCc2UfPFq2lyKHwHt3s9AaFIoCpsBuwHIZ7o9VEP2SYo9fAUK9zWCYdEcMTa1vdw4jFVmt/x5okNaAe+fDvlw6EwU0RwpiVlYsrUQ8TZRgFdrzqu2ZIabnH0hdQ1PQyPPCLLjYhPhQmTP1Jb2mR2Pxdknbzm/Cuv+wf04BU9zmJUM9fwWnog8vno8NMV8T05lzaJRaaVdr86yJF6nD9X8amAegqrHGpNmHGHP/l8J0TRRizr2QCx0viav4f27FjSmHmgURI5/VUSQwqTDOtJfmDvVaZaw2WPOkEbfsUuNk1I31W41IlgiI6ZzGI3hRw91Bi7vYRRg02oXl9ILmLK50QZFu2+WS3laBNFRPcvMKpVft5/BennH6QzOCZg483ZitBr95JM3nVpeBXdtFdnu2tBn5DkDhGQkBuCIeYa+/N22D2sVDXnLcvazCC6NZ+RpBRSX+iSYT1kfwTBnSymlIh3WdAwmHxkKVZ2p849Np0zt5CUsDGkz4wTSngF8JNYppDjo1jvsMkthZmZ86smQFTQ8l16rwyYHZ/vf/BPedrl/3T9LFBzqFQKLV55Vlz0kTQ5qwDrO0P2+H9N2CV8lo+v2Vd/ub7GOx1irTqFJlRmohniCjhWd0BlPumvu9n0v7xIelvnYet/Yzdu4asnOLsqz/r/10d7xis+GWKyQu5mpWaSSzVwD7t0rZC07DxUF/YBXlqfN84FEgL/cgnRNPZJ7F6bC/GQW/
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR21MB6683.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(38070700021)(22082099003)(56012099003)(18002099003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?krSyhna+sgrum49jkGHFq9sdTO5DSCOisILsns5szueICKsPyyoAuvP2uvJy?=
 =?us-ascii?Q?q0zYEMah2RqY9WA6CEOCp0V8Po/KklRNS9gNRFJhspopoqmipVfYJPaTLqNz?=
 =?us-ascii?Q?S3PFf3TQHdf/saNrlWEvde+OdqAI1g6+GLwa42u0zmbOOpx/zjFVZnH3+8kP?=
 =?us-ascii?Q?Wocw/GhykYFaI9RRI8PFRWmn4Lt2KQ8yEROYUnmxQR2NwahO7HOeXdpBOPSS?=
 =?us-ascii?Q?VuTCVBLCm7SNYyA303ZdoOU3eByobVH0oQDGOkUSt1rg0mgtVM4s1pMxD1ei?=
 =?us-ascii?Q?y8cTEZ1bbs2rRe2xvwyrKDSj/6Rl4wHCJEvCJb20NSnqnr+cRX2tciaWHK/h?=
 =?us-ascii?Q?bbVBpgS6Jm5EswjmUVSzseFWvHBtVdkGzwlRPO8tSIxvItitP5KC8G6v0iYa?=
 =?us-ascii?Q?+eO8JOnhTBmCPX1IMXi+Bpk3Jlej13/FIVn6mx9F5hlR581ElT9paOhPSWmh?=
 =?us-ascii?Q?p/8o4I0DGLdwsGOne0Pqq5Sk2S5bwJiE70pBNQazkg6s+2PBLAMW42Ohe52v?=
 =?us-ascii?Q?FQhY0Y/2GEKLIVHAILb4Eu2TDefJZWIC2O8B0Pv9rL33v1+P/4e9q1jyKrxQ?=
 =?us-ascii?Q?1yi4GCHG/UKiy+q3Wzc5fC/gbOCcPJMC+aeYvgC4mOCL6RfV+oM6gRkV8qx6?=
 =?us-ascii?Q?PAbctWY0Kh80vuutUwbz+R7DHekfyMazX7ac9GY/LEpKOWVTlLSdwRHhNkXs?=
 =?us-ascii?Q?vpV/w53I2XIdnf0uvATEl1Lx1gIxvnus1xN4y/Hd6XXSpR7n1dRSb8F99ZmI?=
 =?us-ascii?Q?uqS+1ac251VypHGdb0FQooyQNHVOHUnyvsz0spMBr3b3+i0Nq+lGpButJ8XM?=
 =?us-ascii?Q?NjJNiEWN2OY7wd2OMj/ulpOv9DDDFWClvNSRQylsbnHJ6eGWO4Es3JOXB86O?=
 =?us-ascii?Q?p/aurv5scIdgsXiDLvQBUylZe0QFqUWqN5bV/30x3xLxYuqU3QwuvqMzjXb6?=
 =?us-ascii?Q?y8SAFFxClztigkPLtEmnGNrs5G6QaNf6/HEM5HWQFWwzjNw3OqI39xHXoWNJ?=
 =?us-ascii?Q?R4wTWRoGOyvbzt+EG1+5w9xZNlE3iX1usb5SEmCBBXa9WhEmjUlcsLLQKWmL?=
 =?us-ascii?Q?6D+V0HQAKi/sgw8Pj7AuZA6VzzhacUJ4amA9CxYuAjCThB5MN71MaWj7miTA?=
 =?us-ascii?Q?GvHs8+QFKvuzY4/XioTRVXqwBuHdLtvbu/JthXWcWm60Zgn3gKWuZwryHY/k?=
 =?us-ascii?Q?b+u3oFocGeBlon1eqA4yMvlWBPArO7MwxodUzmtHXdhtvEehMIAQCe8R7vH1?=
 =?us-ascii?Q?WFiG689vPTKr93d4uqBjPgr5SlbXK/tZkhD5mbMlb4q102Ban7mXobltPiOy?=
 =?us-ascii?Q?oUqF+gi4MjPZ7gTNsqxUeFUgFqFpCN2XZJxP6kBfNcC+amkcmpGMQp0fq38j?=
 =?us-ascii?Q?UueSjzSiTPaitHvAUbaH4Tjct70eB7o6+xI+MfUOmDS+GYV/9Qj3iRDMVOQ3?=
 =?us-ascii?Q?3R+kA2Zs4Xaet/lyljrTqqigEqi6J3HgzMhFx/m4AZNlFgVMhEGVNFZNj/t+?=
 =?us-ascii?Q?agdPs8xGLbKDUHkAyTne4+lc7Cyjp6C3KmBs2PofEu6ZOyCIkfYfdtHcr06D?=
 =?us-ascii?Q?anCACXnrmvZyI2X4QH63xIOasFWFSgwreOcH3eaVqUBSP4tdMF/ACoN5ox7D?=
 =?us-ascii?Q?adh6zrBDouPEdege+VA8pOkKEn6bWp98fySezzrXP63E+I2/h7M+2MowvKOe?=
 =?us-ascii?Q?tSjp5LO5KgFpYpjn8QD8wWWtp7aR5jdB6TFYVWyfjE3iUG/E?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR21MB6683.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 642fce14-42c2-43ca-3b94-08de8aa6b4fa
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Mar 2026 19:42:53.8278
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kNfk1efBHUk6eKw+XeNkgTnqnpMXdFQKYMtFhctw2oE/oLCU2T3QcdrefTzqv0VOsEfhZUBxVwMEBUpziW65AA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR21MB6874
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[microsoft.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[microsoft.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-9775-lists,linux-hyperv=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[microsoft.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[longli@microsoft.com,linux-hyperv@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-hyperv,netdev];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,outlook.com:url,SA1PR21MB6683.namprd21.prod.outlook.com:mid,lore:url]
X-Rspamd-Queue-Id: 28E4D32B68E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

> On Mon, Mar 23, 2026 at 01:10:56PM -0700, Long Li wrote:
> > When an RSS QP is destroyed (e.g. DPDK exit), mana_ib_destroy_qp_rss()
> > destroys the RX WQ objects but does not disable vPort RX steering in
> > firmware. This leaves stale steering configuration that still points
> > to the destroyed RX objects.
> >
> > If traffic continues to arrive (e.g. peer VM is still transmitting)
> > and the VF interface is subsequently brought up (mana_open), the
> > firmware may deliver completions using stale CQ IDs from the old RX
> objects.
> > These CQ IDs can be reused by the ethernet driver for new TX CQs,
> > causing RX completions to land on TX CQs:
> >
> >   WARNING: mana_poll_tx_cq+0x1b8/0x220 [mana]  (is_sq =3D=3D false)
> >   WARNING: mana_gd_process_eq_events+0x209/0x290 (cq_table lookup
> > fails)
> >
> > Fix this by disabling vPort RX steering before destroying RX WQ objects=
.
> > Note that mana_fence_rqs() cannot be used here because the fence
> > completion is delivered on the CQ, which is polled by user-mode (e.g.
> > DPDK) and not visible to the kernel driver.
> >
> > Refactor the disable logic into a shared mana_disable_vport_rx() in
> > mana_en, exported for use by mana_ib, replacing the duplicate code.
> > The ethernet driver's mana_dealloc_queues() is also updated to call
> > this common function.
> >
> > Fixes: 0266a177631d ("RDMA/mana_ib: Add a driver for Microsoft Azure
> > Network Adapter")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Long Li <longli@microsoft.com>
> > ---
> > v2:
> >   - Removed redundant ibdev_err on mana_disable_vport_rx() failure as
> >     mana_cfg_vport_steering() already logs all failure scenarios.
> >   - Added comment clarifying this is best effort.
> >  drivers/infiniband/hw/mana/qp.c               | 15 +++++++++++++++
> >  drivers/net/ethernet/microsoft/mana/mana_en.c | 11 ++++++++++-
> >  include/net/mana/mana.h                       |  1 +
> >  3 files changed, 26 insertions(+), 1 deletion(-)
>=20
>=20
> It doesn't apply to rdma-rc.

Sorry for the mistake. I have rebased it to rdma for-rc.

Thanks,
Long

>=20
> Looking up
> https://nam06.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flore.
> kernel.org%2Fall%2F20260323201106.1768705-1-
> longli%40microsoft.com%2F&data=3D05%7C02%7Clongli%40microsoft.com%7
> Cf884f054e1bd45e83ae808de8a4edeeb%7C72f988bf86f141af91ab2d7cd0
> 11db47%7C1%7C0%7C639100268646867690%7CUnknown%7CTWFpbGZs
> b3d8eyJFbXB0eU1hcGkiOnRydWUsIlYiOiIwLjAuMDAwMCIsIlAiOiJXaW4zMiIs
> IkFOIjoiTWFpbCIsIldUIjoyfQ%3D%3D%7C0%7C%7C%7C&sdata=3D6saLMRy7P
> Ck6nvTomdtqYFzc6iX%2FC50UG9YnfN0HILc%3D&reserved=3D0
> Grabbing thread from lore.kernel.org/all/20260323201106.1768705-1-
> longli@microsoft.com/t.mbox.gz
> Checking for newer revisions
> Grabbing search results from lore.kernel.org Analyzing 3 messages in the
> thread Looking for additional code-review trailers on lore.kernel.org Ana=
lyzing
> 0 code-review messages Checking attestation on all messages, may take a
> moment...
> ---
>   [PATCH v2] RDMA/mana_ib: Disable RX steering on RSS QP destroy
>     + Link:
> https://nam06.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fpatc
> h.msgid.link%2F20260323201106.1768705-1-
> longli%40microsoft.com&data=3D05%7C02%7Clongli%40microsoft.com%7Cf88
> 4f054e1bd45e83ae808de8a4edeeb%7C72f988bf86f141af91ab2d7cd011d
> b47%7C1%7C0%7C639100268646881774%7CUnknown%7CTWFpbGZsb3d
> 8eyJFbXB0eU1hcGkiOnRydWUsIlYiOiIwLjAuMDAwMCIsIlAiOiJXaW4zMiIsIkF
> OIjoiTWFpbCIsIldUIjoyfQ%3D%3D%7C0%7C%7C%7C&sdata=3DfrtDMKrk5c3xz
> 8FOgRy5UM2HbpeTUBXcuwGTbw3k33w%3D&reserved=3D0
>     + Signed-off-by: Leon Romanovsky <leon@kernel.org>
>   ---
>   NOTE: install dkimpy for DKIM signature verification
> ---
> Total patches: 1
> ---
> Applying: RDMA/mana_ib: Disable RX steering on RSS QP destroy Patch faile=
d
> at 0001 RDMA/mana_ib: Disable RX steering on RSS QP destroy
> error: patch failed: drivers/net/ethernet/microsoft/mana/mana_en.c:3339
> error: drivers/net/ethernet/microsoft/mana/mana_en.c: patch does not appl=
y
> hint: Use 'git am --show-current-patch=3Ddiff' to see the failed patch
> hint: When you have resolved this problem, run "git am --continue".
> hint: If you prefer to skip this patch, run "git am --skip" instead.
> hint: To restore the original branch and stop patching, run "git am --abo=
rt".
> hint: Disable this message with "git config set advice.mergeConflict fals=
e"
> Press any key to continue...
>=20
> Thanks


