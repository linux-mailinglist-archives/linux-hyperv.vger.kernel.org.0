Return-Path: <linux-hyperv+bounces-3110-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A88598F350
	for <lists+linux-hyperv@lfdr.de>; Thu,  3 Oct 2024 17:56:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A4A641C214B5
	for <lists+linux-hyperv@lfdr.de>; Thu,  3 Oct 2024 15:56:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 629881A3AB6;
	Thu,  3 Oct 2024 15:56:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="aN9ayp/N"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11022090.outbound.protection.outlook.com [52.101.43.90])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD0DF1A2C06;
	Thu,  3 Oct 2024 15:56:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.90
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727970974; cv=fail; b=W5erPB7lBc1BPVvppboelvk5P6DpmSV7QqSUtw08NHj4vYa/75rG4ulXAvrRd1eKNC+GpXyAY37eOy+NzMWkQrbLKxxSz3zbbLIloKyOB/A7OEgA2YiGFFbmppPXxZG9YYDWkck0DrzxAZBy+ceB4N6sfyR4muelMSaTFZ+hTxw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727970974; c=relaxed/simple;
	bh=jgHqy/Z3x7JifyFSAz1tPe91Uc9Jl4SITUOCcNJsN6w=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=qG1f916E70fxAU5NvNmfhl3PVt/NZTb2fU2pR6xfSdS2qSguHa3aV8sp/mNTkMX3BXyqdcNE4LSHGh7lorVtW97g5D9LhchMIhzEDSPo0CNk0JV6x0z4SzW4wcCQIqbbQEMNkGVrvAEEX8NLHG1wogkiWC6nxENhpNit46Ua73Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com; spf=pass smtp.mailfrom=microsoft.com; dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b=aN9ayp/N; arc=fail smtp.client-ip=52.101.43.90
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microsoft.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wiYGlWmao0STs2CyP2LcpYdCudAojSY+9CnjP56db/nuj7fL6Ns8HVKjT3Js//YfMiqrQunmbf1TK91Ztwl25FJ83nCJ/DAhQTHtB3RUaShYneXjctWfvVIAcVTrWgzTt1euY8eN+hwS+XZkzwkeJ7ZEFqj880LZdGVrzZJPU4f+BQdSBYOS0BXJhzoPLJTjWK2Gyk86jLAkTnp3gKpEmV+jR0/C//k9h3sxZA22Isz1NVEzD5xyxCk3gkV1z1xdSIAXv3VysxgTzcRM7fJKHm+Bfl4zMDIqN8sDDcvM7yDuzcpp/31fGSQST5FDrVl8HclbfSip3xQ3cr49BmaU9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jgHqy/Z3x7JifyFSAz1tPe91Uc9Jl4SITUOCcNJsN6w=;
 b=aI52zayWAIYmmYUvda6wYU3n6uXobxvvym4Gb0F1FfEK3oyQ7FluHuNhoJy49Fy2voWljleupcVgZWK0PQztT/w55iZEn7DxeLpSao5Coh9TSukfV+RYoG8ySE1+avRWqYiEGJUEr/CMpm65xSt1EWCBb+yxLqMWdXNAKHFGcd68M/lBY8cwmmkR+8Fxgch62hfTU+w4Y2xnsqRzBDD0ZYFLu0OnxoWSmO4RVHK8T1hzowJQAJKDHpTqW5ayhdpq5TSgv2hQU521HF9Y1uDAVqX5XU8+3O80AY0DN+9DFeb0662dkt/9hIjTev4CsGnsxn26OfvyrnAsW4iVedJ0Ug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jgHqy/Z3x7JifyFSAz1tPe91Uc9Jl4SITUOCcNJsN6w=;
 b=aN9ayp/NxcHz4iDQFaNHGe/JC4rrh5+s1rkcAXdD+miBbnLotwFEah3Dpv+6jS2cZ2JGoR71W8Ffm2A0cjaOBZIvP514PnC0mItmbl34YEpjmYOpRl15Lo2qE2Zsyu0korvGuWZ2Ulj1BVgO0vjaoOHYjMn2TEQZdEpp7iqnoBc=
Received: from MW4PR21MB1859.namprd21.prod.outlook.com (2603:10b6:303:7f::6)
 by CH3PR21MB4332.namprd21.prod.outlook.com (2603:10b6:610:1d3::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.2; Thu, 3 Oct
 2024 15:56:10 +0000
Received: from MW4PR21MB1859.namprd21.prod.outlook.com
 ([fe80::a12d:cc9:6939:9559]) by MW4PR21MB1859.namprd21.prod.outlook.com
 ([fe80::a12d:cc9:6939:9559%6]) with mapi id 15.20.8048.007; Thu, 3 Oct 2024
 15:56:09 +0000
From: Haiyang Zhang <haiyangz@microsoft.com>
To: Stephen Hemminger <stephen@networkplumber.org>, Paolo Abeni
	<pabeni@redhat.com>
CC: "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, KY Srinivasan
	<kys@microsoft.com>, "wei.liu@kernel.org" <wei.liu@kernel.org>, Dexuan Cui
	<decui@microsoft.com>, "edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>, "davem@davemloft.net"
	<davem@davemloft.net>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "stable@vger.kernel.org"
	<stable@vger.kernel.org>
Subject: RE: [PATCH net] hv_netvsc: Fix VF namespace also in netvsc_open
Thread-Topic: [PATCH net] hv_netvsc: Fix VF namespace also in netvsc_open
Thread-Index: AQHbER+TDt3OdK8iTESj8UX/9+N5+bJ0zLyAgABocQCAAADKwA==
Date: Thu, 3 Oct 2024 15:56:09 +0000
Message-ID:
 <MW4PR21MB1859AFA5D5D7F97928813F43CA712@MW4PR21MB1859.namprd21.prod.outlook.com>
References: <1727470464-14327-1-git-send-email-haiyangz@microsoft.com>
	<a96b1e00-70e3-46d8-a918-e4eb2e7443e8@redhat.com>
 <20241003084838.32c3b03b@hermes.local>
In-Reply-To: <20241003084838.32c3b03b@hermes.local>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=9b9716d4-94ba-4ea1-8fd7-9f27a476b173;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2024-10-03T15:51:27Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW4PR21MB1859:EE_|CH3PR21MB4332:EE_
x-ms-office365-filtering-correlation-id: 5b6319f7-a242-456e-f1df-08dce3c3e628
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|7416014|376014|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?hsx2lfT61O0NXd/A7cj0fKqojlk7tjebeWup0mf9n1FRvNiWZ8t+UqR6SqMT?=
 =?us-ascii?Q?buagJPh3hHz2Aa/RG2Ltjx3mqwy4C69hYtkgrFyZPek8D7q1bvVG7ah0KiOO?=
 =?us-ascii?Q?hfwioZRKQSyvjg7FZ1cpWG8LtS+Vq1xGxtxpxetXLVNRhiQdPstk/rXFPvuE?=
 =?us-ascii?Q?L3ZOBiFXIPFseb7bTWd6mVsgVL/9n62yzuYFsFr9wrZdoc0lr+gcKcGd3+Fc?=
 =?us-ascii?Q?+FgphqpB1ZQ2IMmSNYNBPmWIh04x58JjYSixQxN+NKhaaGYuSkFaTebpmrFj?=
 =?us-ascii?Q?H+60kWlnAV+E7z9wMCHt2YV5+IdkjJ1WjnU4Cn17Z1dFVI1RXS8GEVxh8gS2?=
 =?us-ascii?Q?KxkmOf/NP9Csldz2ecCV7dw19VoDsw+CjKe1e45LA08l0uM1sLVO0BZRCbGz?=
 =?us-ascii?Q?lJtZYiRf1aCSrJiWrd80WyXDvFGiFp9Qp8qxzGiIBfGqBD47Cn9mGr3NwIT9?=
 =?us-ascii?Q?LcQ4bkxCp8qEY1Mtz0FtElZl0+OUd3GosdKN4brSb+FEiqITwCwTQ6hy0o/F?=
 =?us-ascii?Q?H1PHEPB4Q06RpchPzJLuQm/88wwS7QvFU1XcXj/M2HEH62fMg+4AWNkDuz4l?=
 =?us-ascii?Q?nQAHLxrKdKk1fiboT95cj/ZFTAZHzgz8zRVMWHGvE+R7z7Jtm5bp9G+CexZI?=
 =?us-ascii?Q?yzCafP66OlgjANAMtcng/ASOclorb04oKA7bOBlHRvlQbhn9KCQoeiDRBxG/?=
 =?us-ascii?Q?oyVLks5r5tvmpsrLYbfbJvNJJM/4EgxlxbUzTQn6h1gKT0+ULWtMPew7ZQzB?=
 =?us-ascii?Q?G3CTSy9rEaN22Av05dkLmW/qykwgtcban+28v/BvZNogcUrZoaqObXnAtHhj?=
 =?us-ascii?Q?wSdra4no3bc0xFhNmhcJJhUSv+wYeipPW3ka2nfYYx1kYzxGOz0MCEt3+k0/?=
 =?us-ascii?Q?l18BElXdTKEhnns57uGwWLCHD3Nocl60o1YtnPGSV56t8jP7LQgtNXYE6hSr?=
 =?us-ascii?Q?ck5gThQ4GzfV7BzuVDqV+1CkAr5STw0dxfe385UU3MNS0AEkirVq586u6T+x?=
 =?us-ascii?Q?5/6IY4F1wnzLueJAkgmyJHHCai+cd2OVo4V+sSbZzkcaZOWe1jGxfdoyt/y4?=
 =?us-ascii?Q?8wYVz4bitOhY9kZW1hWsn4sObRsUCjuEcop2z5aHttpL8wyLnCZtqo7hMI8T?=
 =?us-ascii?Q?UA2KR8REeAZ5QYmB9znKSUJL94+otl2CY7vFevi9LwDWNXecsT4W9iQt/eEy?=
 =?us-ascii?Q?9O/qbBcK4Twresc+P9VIsZ1yM0exf3AwqPELu24YJJFHWgUHp18Wal4CqcM0?=
 =?us-ascii?Q?9+cWpSax7knS6mNdP4h7L43twL6xhoTRRnk28NzlGbg6Mv0JqB+u2hT6Hv0V?=
 =?us-ascii?Q?kCMkYC2x/R5eyWaEs4SW441Vm4dNaDM6ElfSn82/IvdNjw=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR21MB1859.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?/c+d94tvu/jbTZhtTo5+EuUUAvwWLDwCChj2rgvRG5WdpVw0zFbd9J07sIaU?=
 =?us-ascii?Q?ZkCZlNlX+ItmgENdN0Kqs9qtKROPshBuIvHRtLlTVFdPumQ8XkGdnTxsI8bY?=
 =?us-ascii?Q?F5+feiFljOpNfe5v3+EQiOnCWnUxjEburjOnH6VtQCPowfUBbvuZsiLXulBg?=
 =?us-ascii?Q?VDoFP2v6CnZENJhVJ6rV0Av0BDtF5QXU3qyrrIx66yvIALXZTg226W23FOxS?=
 =?us-ascii?Q?VrRn0A0lL3jhoYRBsAwsaPFs1DKGQvsqqtMENqT6mS7eYp7LBmKnu5CdE2ba?=
 =?us-ascii?Q?bEh3kyAFi4gBsck6HRnMCDBAQ2CapmkVinlKUSdMQwv25zCOB7xM2b/nxvHX?=
 =?us-ascii?Q?7JA9cK2bnB1QbSZuX2W57vuPeap4cEMaz+1cH1HB4d2nbPHjp3jvSwmFBklv?=
 =?us-ascii?Q?OKhF1CNXeYAlKAQQ/1wCvx0xuT04SgzdEjy9ldMkjkHZAiPP1p7GkfswpHpc?=
 =?us-ascii?Q?QaZ1jDzuzRdf3B3XH0FL4oXiJT6p7Ja9PEBQqas27Ytng1eQ/AdGbEzfQzek?=
 =?us-ascii?Q?ztHxK8HTr3EWKRg/ZH/orcHexrLsdoxSy/M89y26y8O6Kev1/MRPptUw7ZK1?=
 =?us-ascii?Q?p6LnGK79gQPOO1fqdv6yabNubx5GmaoTZzg5IPCtV8GMkw2WuVgOHSp6QZDU?=
 =?us-ascii?Q?t7GEt2E0/nlZTSwnw9Eelv8jQvUYUPpzDLxLi6oDZHTyWxbGoPAx89tq3FW8?=
 =?us-ascii?Q?FfUH5Ewhib1x7C5QtgUCIK9wALzoKq42SW5kvMTGyULNN+2ugUVmex8y8ZD7?=
 =?us-ascii?Q?RTFbo1raBFh582i1xHJfSvLsCH0uhhj7cba1DR1VtHz1BEzotYgEQm1rMsA6?=
 =?us-ascii?Q?FqY+YC8KpCp5m9uEgJNrL4KX+E9NMvuRbhgmGfsJCdyrliJWb2ukaeUyYPLo?=
 =?us-ascii?Q?x90fRkvDBd/gu1vhghjsouBJiqgXqy627KqMuqs5wuI5QGrh3Li0AKjc1sjO?=
 =?us-ascii?Q?FAvWiII1UltHD17YyrEj/5QwPOyFw5IuyCfdihUbuPPkjshwb35hbJmgZj/m?=
 =?us-ascii?Q?TB/f2yJXG2Ef1DxnVjrP7LMIe6j2oRhnitXWCDasKZNT21ofX69Avbmw86j5?=
 =?us-ascii?Q?m4hiVWVmvOg2dVsfA47THawASopCKuFxds66DOf1nQ/9jwo4Fj3YGnVZHjRi?=
 =?us-ascii?Q?h37DOK3FRNKEHzfWMthLgNs3KQDZqvkGHnQQ3dkZuaCRkBN4Hm3Vlir7uXNh?=
 =?us-ascii?Q?AgpzrDx8NA+IUKPO6QWf4cjqlPuJcux2egq7znwDlgls4ltkDh4BU4j7PwIm?=
 =?us-ascii?Q?CUm+cU2MxC+xxMG87y2V1WmkOOUepV4FJUHhsi9pcTq+Kq7Ek0WlTuCKh90U?=
 =?us-ascii?Q?UjpuFtz1l1uOEaCrTlz4XIE6KN2lPlNaFSECgoOfSIdwR05rA/yVsOcP/O0Z?=
 =?us-ascii?Q?UYmsg0pirsR5aY+DBH/B15IlMVVr5d2EERqIbJshv0ukaxz46gElwnAPsSAZ?=
 =?us-ascii?Q?GVBqk2Gwm6TaL0DiC9/LSawSFL0oBWZ1ozwmLh2LXCaA7PrqjKSqZxGbEj8e?=
 =?us-ascii?Q?CYP7IdjGgflGbU7aQKlpcbWMeYOCRf099xLPlUtwNjReg0QrhKQi6ljyyinJ?=
 =?us-ascii?Q?SgzBvHIfV2PccSb4u8CHyo3k0d4otKl7haWoRWKj?=
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
X-MS-Exchange-CrossTenant-AuthSource: MW4PR21MB1859.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b6319f7-a242-456e-f1df-08dce3c3e628
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Oct 2024 15:56:09.9303
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: P/J/GUqafs1v1fenyddb8RW0aQRuQkeFT/64alh4rit1yc1T1DOcwihQWFlP4VNA2sHQHUgjbF2wproejXNDwQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR21MB4332



> -----Original Message-----
> From: Stephen Hemminger <stephen@networkplumber.org>
> Sent: Thursday, October 3, 2024 11:49 AM
> To: Paolo Abeni <pabeni@redhat.com>
> Cc: Haiyang Zhang <haiyangz@microsoft.com>; linux-hyperv@vger.kernel.org;
> netdev@vger.kernel.org; KY Srinivasan <kys@microsoft.com>;
> wei.liu@kernel.org; Dexuan Cui <decui@microsoft.com>;
> edumazet@google.com; kuba@kernel.org; davem@davemloft.net; linux-
> kernel@vger.kernel.org; stable@vger.kernel.org
> Subject: Re: [PATCH net] hv_netvsc: Fix VF namespace also in netvsc_open
>=20
> On Thu, 3 Oct 2024 11:34:49 +0200
> Paolo Abeni <pabeni@redhat.com> wrote:
>=20
> > On 9/27/24 22:54, Haiyang Zhang wrote:
> > > The existing code moves VF to the same namespace as the synthetic
> device
> > > during netvsc_register_vf(). But, if the synthetic device is moved to
> a
> > > new namespace after the VF registration, the VF won't be moved
> together.
> > >
> > > To make the behavior more consistent, add a namespace check to
> netvsc_open(),
> > > and move the VF if it is not in the same namespace.
> > >
> > > Cc: stable@vger.kernel.org
> > > Fixes: c0a41b887ce6 ("hv_netvsc: move VF to same namespace as netvsc
> device")
> > > Signed-off-by: Haiyang Zhang <haiyangz@microsoft.com>
> >
> > This looks strange to me. Skimming over the code it looks like that
> with
> > VF you really don't mean a Virtual Function...
>=20
> In Hyper-V/Azure, there is a feature called "Accelerated Networking"
> where
> a Virtual Function (VF) is associated with the synthetic network
> interface.
> The VF may be added/removed by hypervisor while network is running and
> driver
> needs to follow and track that.
>=20
> >
> > Looking at the blamed commit, it looks like that having both the
> > synthetic and the "VF" device in different namespaces is an intended
> > use-case. This change would make such scenario more difficult and could
> > possibly break existing use-cases.
>=20
> That commit was trying to solve the case where a network interface
> was isolated at boot. The VF device shows up after the
> synthetic device has been registered.
>=20
>=20
> > Why do you think it will be more consistent? If the user moved the
> > synthetic device in another netns, possibly/likely the user intended to
> > keep both devices separated.
>=20
> Splitting the two across namespaces is not useful. The VF is a secondary
> device and doing anything directly on the VF will not give good results.
> Linux does not have a way to hide or lock out network devices, if it did
> the VF would be so marked.
>=20
> This patch is trying to handle the case where userspace moves
> the synthetic network device and the VF is left in wrong namespace.
>=20
> Moving the device when brought up is not the best solution. Probably
> better to
> do it when the network device is moved to another namespace.
> Which is visible in driver as NETDEV_REGISTER event.
> The driver already handles this (for VF events) in netvsc_netdev_event()
> it would just have to look at events on the netvsc device as well.
Thank you for the suggestion. I will look into this idea: let the netvsc_ne=
tdev_event()=20
to monitor the NETDEV_REGISTER from netvsc devices.
This will come from __dev_change_net_namespace -> call_netdevice_notifiers(=
NETDEV_REGISTER, dev).

- Haiyang



