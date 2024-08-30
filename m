Return-Path: <linux-hyperv+bounces-2922-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D1676966819
	for <lists+linux-hyperv@lfdr.de>; Fri, 30 Aug 2024 19:36:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 01E601C23AF1
	for <lists+linux-hyperv@lfdr.de>; Fri, 30 Aug 2024 17:36:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D4B41BAEFC;
	Fri, 30 Aug 2024 17:36:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="M9JRhsyw"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11020112.outbound.protection.outlook.com [52.101.61.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BF0815C153;
	Fri, 30 Aug 2024 17:36:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725039383; cv=fail; b=E71OkPXv7HMTNhxj03yp165IOBuguP+rrFA7ciQM2YnpGJQTEzl7fOhXOUp4KZu2Ff/YFh+TkiWtmQZ7ZycGJX5yfKpx09VFKgLcsakV5Xn5Qa/fBMFuoZYMdx55xv6mBmrswJGPy7uctiYYnhqmV0ZC4rcfPOqAxMnVyfuCLhE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725039383; c=relaxed/simple;
	bh=Fk6nwa3iYRS3icnLh52AJiF61F2kngImezMoKDqIY3Q=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=W0R2wx1iXLACIfRgnsAtj9LjgoexPhVCkHP98KR5lIUusehSk8mZIi+DaQTDmIESJsFSmDPPefSfwgpzvSSgMIc79hbbOsydbe4zU4Pn2VNIyYwutHhrvrECpBG/a3V7wYVHZ52ZzKfLzpeY23CO7myHE098K/JfqhCo7yikSMo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com; spf=pass smtp.mailfrom=microsoft.com; dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b=M9JRhsyw; arc=fail smtp.client-ip=52.101.61.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microsoft.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BNAZv56BIv8dLdi8ftxe+Tc5PjsyrACqXRGS156tJ2fU6qTOF/+WPlZHG0Ov32FUaDvmJJhJEqdrtC+OHUiu28CkhHye9KVdKmlQNOXtOPW0tegzGgOXs6KR8f0o+iS8qkGFT/OOphMeXrxGjekA4XjWQ5g6GncEeBveDtDkq2XyGB2Lu3SCM5NVG/9DKSyMTHy/Q6VHtIScWJWRlEFPSBCGnBHKWyZGGkvnCFA0qJ9W4L1AYmhoTaqgcEDOsDrP4ZclAWgtATWMGyOFxQqtUXYRSFEyoYnJ5v0rsVckF+CVEvMaCyQoAXzYLMBVIVaWIkzkH4oyvvbgJUGolsjebg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lECmH+nxX8c96NDE61s/Qj4abeg4ol3ZAdHK6S9o1Gg=;
 b=gmIM+e6WsflPtmVw51FSLQBr8c4lqhMfE1GTfNE0wDfx49GX57JekrNYNYIreE16V9RGPdpibn1uzfUajsWESuc9C6MnyedVO0G/5CN/dLpve5Wz9dORphIforIyejIK/7QUQpZkn4A/tcNYrufN/as1TY5o2W/OOzUtoCwtsnam3l/oIHNZi/SnRjQScOtyKpD93dxi5o3oXEC9/2xGBckwb7fVshqcy9ffXDATKNA910blHgfHFx7/YW1z2Bp+iLqveAgDhdfona7zh/jvrCle24XGTIyKIL2PlfBohPYDGOvt8tsGfKYEl9JYyuLNsxJpgAa90HhKQECMNsecdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lECmH+nxX8c96NDE61s/Qj4abeg4ol3ZAdHK6S9o1Gg=;
 b=M9JRhsywPVjc2pQzuhry/6Ci3CdXfNdBafAMCbOMgTtqg61nUCVTyp/SNu503x9pLHh4rjjgZj7mVfjjxcbIWk5C+VWKbmLwvg8vNalRCl4nXiiBr712vTfbE88d/Yk+nISYcAunVTMp0A6uuwVCTkEUcVlLONAVj79RTaDNRw8=
Received: from BL1PR21MB3256.namprd21.prod.outlook.com (2603:10b6:208:398::16)
 by LV3PR21MB4255.namprd21.prod.outlook.com (2603:10b6:408:272::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.8; Fri, 30 Aug
 2024 17:36:18 +0000
Received: from BL1PR21MB3256.namprd21.prod.outlook.com
 ([fe80::944b:ec13:2f2f:92b1]) by BL1PR21MB3256.namprd21.prod.outlook.com
 ([fe80::944b:ec13:2f2f:92b1%7]) with mapi id 15.20.7918.006; Fri, 30 Aug 2024
 17:36:18 +0000
From: Haiyang Zhang <haiyangz@microsoft.com>
To: Shradha Gupta <shradhagupta@linux.microsoft.com>, Souradeep Chakrabarti
	<schakrabarti@linux.microsoft.com>
CC: KY Srinivasan <kys@microsoft.com>, "wei.liu@kernel.org"
	<wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>, "davem@davemloft.net"
	<davem@davemloft.net>, Long Li <longli@microsoft.com>,
	"ssengar@linux.microsoft.com" <ssengar@linux.microsoft.com>,
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>, Souradeep
 Chakrabarti <schakrabarti@microsoft.com>, "stable@vger.kernel.org"
	<stable@vger.kernel.org>
Subject: RE: [PATCH V3 net] net: mana: Fix error handling in
 mana_create_txq/rxq's NAPI cleanup
Thread-Topic: [PATCH V3 net] net: mana: Fix error handling in
 mana_create_txq/rxq's NAPI cleanup
Thread-Index: AQHa+e6j7hVwv/g+nkyjJvATfz6ZwbI/U7iAgACcznA=
Date: Fri, 30 Aug 2024 17:36:18 +0000
Message-ID:
 <BL1PR21MB3256A6BE2A1A5D523FA1AF36CA972@BL1PR21MB3256.namprd21.prod.outlook.com>
References:
 <1724920610-15546-1-git-send-email-schakrabarti@linux.microsoft.com>
 <20240830061355.GA2986@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
In-Reply-To:
 <20240830061355.GA2986@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
Accept-Language: en-US
Content-Language: en-US
X-Mentions: schakrabarti@linux.microsoft.com
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=ff70d3d8-4636-4132-990a-4061df14368e;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2024-08-30T15:35:09Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR21MB3256:EE_|LV3PR21MB4255:EE_
x-ms-office365-filtering-correlation-id: 83e21d6c-5bf5-4c24-919b-08dcc91a4175
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?eLCQ+CrMI9J/eDzLKcU9JjUcAS795JwwiKFrTCApqJH6cxCQxabbo8ZFhq8M?=
 =?us-ascii?Q?2/XmupBj1mnEc8hKXuKpzxzrjeq3wP9Qp6q9mQDayglnsYgJgZk/lSHkKEK1?=
 =?us-ascii?Q?Sme0hrTX1j0rTcFLd2tk9XeXdG4JQEM8kGftE5SgwdW6WsfVgRyDOKynT38K?=
 =?us-ascii?Q?ibA7qjCFAOFYsYbyvoJesHX9x7EQt/BKWzSzO9YHqiA7qGSmbVc4UluacNhD?=
 =?us-ascii?Q?e+60VZq6wYNdM173Zp1sTRq4wAB7NPwfFwJqUvzZekPc0v9Vsq8fBw16hghC?=
 =?us-ascii?Q?62ywl9QHLhcV8F9RiI5WbL8qISw59QD6KIPUQ6w41iQYEpAW49+rBgtbIHXU?=
 =?us-ascii?Q?fazJ52ez+x99GUOTmJefvISAL+GXWBaWv972SsFRATJ2yqnFhKEIgMCV8mVe?=
 =?us-ascii?Q?TuiyyP4UyIbsJKk4PytSfIh01wGYmMlsyXzb6wbjlFinpLSwEM4Cgt1vdQef?=
 =?us-ascii?Q?BoLKozdMO16+CJwHkY7zL/reid2M8J1lb78lp9D8Uw8lNDXOSQwgqgzzt88l?=
 =?us-ascii?Q?QkHWzhMzsCDgy4V07W3074e5z/f4GRUJebLRIGL0ZiuUoGJX/JuZfZM2dBi1?=
 =?us-ascii?Q?aqcV5BeksJJf9jUG+vgNdrssIFCr0mam4cNZ9ib39Aq15q3y45la2YwcFqo5?=
 =?us-ascii?Q?U6QbzBE+dWg0LcRCO/G3uDavVxFdF1usCMic4E+a/LzvBwOyDO4N643Ep1I9?=
 =?us-ascii?Q?hoTIqHtygMU3vpu6/KjFrZPsyL72FnGomtmp5Rg9iIXnDbTidz+UHR/no6Xm?=
 =?us-ascii?Q?LzetgMX1vMDUEEamygHrpMYWlvTGEUHg84v8yYmt50o6MQkwFZfEuLR9nofW?=
 =?us-ascii?Q?pxxx0lz2TRwPzTCilwrRHj4xn/C4Z7WZrQVbgkblclVZTGrDOPTRBWC/aL0b?=
 =?us-ascii?Q?iUiNSxbSOdSV9VfRqYUEX3hM883sNw/dEdLA5h7y1vLnWkKqjTbVTxPfigd8?=
 =?us-ascii?Q?ASDVLXmet1b8zVFwdplEmQ+wWybUj8x4vL5nv9CvKbX9Okg7Dt9jL4cqEpvR?=
 =?us-ascii?Q?UUapjEHwSWz9lxeMOQ+gHVwBbBGJgFLp40SUYrp5M+ckWyWzoGn6QcbTLAn9?=
 =?us-ascii?Q?79IoY1QlZFsuf97N8bT0ag4nW7j/UnPzapmuBIioSDl8juEurnLunSwJ35um?=
 =?us-ascii?Q?NaT13C2BrWuYCVeNCigqwTHbveMA7h4W3yu1L2yYCwvv+evFQ2MScCHk+tyf?=
 =?us-ascii?Q?zDj8hkhdIDJ10GDYjvKgAHmHJudEdFGb+4PTHJ3exc79MYxxRnLQGGjlGgit?=
 =?us-ascii?Q?DpWooUWIho7my1mkQhNs82du4upSRTOvffSn5gYDllDrGJXO7mjI4AvZeOm4?=
 =?us-ascii?Q?vTtdRN7jmQL8R5IUhcrD7JZfeCIStY1usYyoGZYaJ37c4Eg865/1lYph9jJr?=
 =?us-ascii?Q?gvKR4L+xJaRNu9Jt9dGdEIrnAqy3y8p9bD8dFxmLjdFGb6bGYA=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR21MB3256.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?UqQGylzHPa5nUMTHvxviem3IVGCxkw7vPEvHRy9fGY12fIkXKxnhDNNCEEre?=
 =?us-ascii?Q?hCTgeMJ/uWuHU6mFVZmp+xGA+02mq5LBpApTVCGZsWQkFG5Bs8UEHkm7MO8y?=
 =?us-ascii?Q?o1XUB/jlBA3ckGxJdf2sao4j1CXtAVGx9wFmdT5Q5WrF+cQLJI/mU0c+6Mw2?=
 =?us-ascii?Q?7vYIhebFpVj9Jtf/GrLtn+v/z49rADxHolyT1U28ocsSLA7/HMNWCFzsXKgs?=
 =?us-ascii?Q?64VV4XTH4WqFpstRPGXYHUoP/MEKrQVF2ZsidOQrvB/A6UJ+fUU9axmdO1gq?=
 =?us-ascii?Q?zO0IO2NRfC9Yvx+9lpIxXCWD1kYL4BWh4Hf11gtcnBpRP47JcRE+5Ju31R4h?=
 =?us-ascii?Q?ALVcU7DiizoZZUP5Y74lq1qYdL3Rh/6faObTZ1zcV2GN8amE1QFI7tLPhdK5?=
 =?us-ascii?Q?S82iGZqMfPcDpGgTMPfs7Ahv0U4fZ8R3XGBrMiTcT5pL7yq5P3rWJs6TiZbS?=
 =?us-ascii?Q?aodsSq8Q5deOwxX83QcIFqWRzqQHhf5EsB0eyCy8w45Urdq9Fp60uVMHovX6?=
 =?us-ascii?Q?hYSwbPsaQHGte9DQHMGxvJyyYwpu8tqVozZTd6HpdQYeBVXNOIlJvcYnsNf3?=
 =?us-ascii?Q?+DCv5+RBYA9CSYU/3XuvMO3r14JpAQ6w/sor900qbcXNBpuWDS31Oj7dWT4c?=
 =?us-ascii?Q?YWM2ipotsEENmmFSWvQaoOejDsm2jWfn7XzV5KpyLEHjCd/H+t0AcX3e1+vC?=
 =?us-ascii?Q?UWIXS0hYSPP9zydCU2hfE7p4zIndlT6MU1jRhU63J5tfPrcKeZValjVPEbHF?=
 =?us-ascii?Q?nIs9zkqKf8hjHaGrvtW+n45h+VjrwqDYL3p14+vCHTkA453SEoh3P6C3gRYC?=
 =?us-ascii?Q?ebE9lqwbsaXfagmrn4OrL+HZkTj7FRVLJ6YEv8G7m0pAFKAp5Z3sGM/Vq/D4?=
 =?us-ascii?Q?L8jIMt2nJTNBWhC/C9MGmYGGA5YhuCxllSLll6XK2itdmoGiIHm6h8f9upth?=
 =?us-ascii?Q?zW3B0XM32DFFQLZQRSw9G3EngUQcdbYWDOdGiu4jgxpBWfiKNRTR51w8MDMT?=
 =?us-ascii?Q?qFbcXAzeoehoNvgGyEatVeFJUGnFZyauhPeZraX7wc08Wy3Ku4tAJL+iDfra?=
 =?us-ascii?Q?ORifkVcABEkLlkR6Qd1fzM3xlrzGI3h5S8Nx06bo1ao1vDxCneXuRRS9mlKY?=
 =?us-ascii?Q?prg1OT4HuNtwNC4hvwStp4fAVDLeJLMSxAbomJjURBxN+okT/87NQcSMzfHb?=
 =?us-ascii?Q?wyrpbXzlQl/Dorf1RZexobHEhmMOFGxskF5Z2SkpehyhXAkHz0ukaVtLp140?=
 =?us-ascii?Q?BVY7kTp3kg5pkkUbVPpUw82poiz0mqB4EyTbU6CUePD8XtNcew/osqzKc1GX?=
 =?us-ascii?Q?DOwTISMSGYkZrBuJVjqDLMlCyjD8RFju/JDuc+sCs3KviXs9OsCgh2RpFqlF?=
 =?us-ascii?Q?xnp7zvEQk4b4NY1cDgHQloTJ5R6U9nreYEWq8Lg772WOluWgrnt0wRtRLVv1?=
 =?us-ascii?Q?vynWR5a6kawKcUVoleFMaeAULVXYAEz7jmpg5Y4EGJ1v6U2Wcaln95D+kGwf?=
 =?us-ascii?Q?qJ9rXoHUP/NlHYM0ZIC66bOWdvPXRHGeswstnokcSp4oEUpZxDJ1y9DDki+I?=
 =?us-ascii?Q?xobS+m0507EM/QVlmgVLXnzSUDc7NPYbDV3XDZMJ?=
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
X-MS-Exchange-CrossTenant-AuthSource: BL1PR21MB3256.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 83e21d6c-5bf5-4c24-919b-08dcc91a4175
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Aug 2024 17:36:18.3815
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mTSBzMJrE4xJmUP6DzywF/UjZsZkhdp8j1I+PrhkkcvzfSw/hctMzOPDEJtrNamOx2/0X2yWoo+I7Lfn8ufLOQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR21MB4255

> -----Original Message-----
> From: Shradha Gupta <shradhagupta@linux.microsoft.com>
> Sent: Friday, August 30, 2024 2:14 AM
> To: Souradeep Chakrabarti <schakrabarti@linux.microsoft.com>
> Cc: KY Srinivasan <kys@microsoft.com>; Haiyang Zhang
> <haiyangz@microsoft.com>; wei.liu@kernel.org; Dexuan Cui
> <decui@microsoft.com>; davem@davemloft.net; Long Li
> <longli@microsoft.com>; ssengar@linux.microsoft.com; linux-
> hyperv@vger.kernel.org; netdev@vger.kernel.org; linux-
> kernel@vger.kernel.org; linux-rdma@vger.kernel.org; Souradeep Chakrabarti
> <schakrabarti@microsoft.com>; stable@vger.kernel.org
> Subject: Re: [PATCH V3 net] net: mana: Fix error handling in
> mana_create_txq/rxq's NAPI cleanup
>=20
> On Thu, Aug 29, 2024 at 01:36:50AM -0700, Souradeep Chakrabarti wrote:
> > Currently napi_disable() gets called during rxq and txq cleanup,
> > even before napi is enabled and hrtimer is initialized. It causes
> > kernel panic.
> >
> > ? page_fault_oops+0x136/0x2b0
> >   ? page_counter_cancel+0x2e/0x80
> >   ? do_user_addr_fault+0x2f2/0x640
> >   ? refill_obj_stock+0xc4/0x110
> >   ? exc_page_fault+0x71/0x160
> >   ? asm_exc_page_fault+0x27/0x30
> >   ? __mmdrop+0x10/0x180
> >   ? __mmdrop+0xec/0x180
> >   ? hrtimer_active+0xd/0x50
> >   hrtimer_try_to_cancel+0x2c/0xf0
> >   hrtimer_cancel+0x15/0x30
> >   napi_disable+0x65/0x90
> >   mana_destroy_rxq+0x4c/0x2f0
> >   mana_create_rxq.isra.0+0x56c/0x6d0
> >   ? mana_uncfg_vport+0x50/0x50
> >   mana_alloc_queues+0x21b/0x320
> >   ? skb_dequeue+0x5f/0x80
> >
> > Cc: stable@vger.kernel.org
> > Fixes: e1b5683ff62e ("net: mana: Move NAPI from EQ to CQ")
> > Signed-off-by: Souradeep Chakrabarti <schakrabarti@linux.microsoft.com>
> > Reviewed-by: Haiyang Zhang <haiyangz@microsoft.com>
> > Reviewed-by: Shradha Gupta <shradhagupta@linux.microsoft.com>
> > ---
> > V3 -> V2:
> > Instead of using napi internal attribute, using an atomic
> > attribute to verify napi is initialized for a particular txq / rxq.
> >
> > V2 -> V1:
> > Addressed the comment on cleaning up napi for the queues,
> > where queue creation was successful.
> > ---
> >  drivers/net/ethernet/microsoft/mana/mana_en.c | 30 ++++++++++++-------
> >  include/net/mana/mana.h                       |  4 +++
> >  2 files changed, 24 insertions(+), 10 deletions(-)
> >
> > diff --git a/drivers/net/ethernet/microsoft/mana/mana_en.c
> b/drivers/net/ethernet/microsoft/mana/mana_en.c
> > index 39f56973746d..bd303c89cfa6 100644
> > --- a/drivers/net/ethernet/microsoft/mana/mana_en.c
> > +++ b/drivers/net/ethernet/microsoft/mana/mana_en.c
> > @@ -1872,10 +1872,12 @@ static void mana_destroy_txq(struct
> mana_port_context *apc)
> >
> >  	for (i =3D 0; i < apc->num_queues; i++) {
> >  		napi =3D &apc->tx_qp[i].tx_cq.napi;
> > -		napi_synchronize(napi);
> > -		napi_disable(napi);
> > -		netif_napi_del(napi);
> > -
> > +		if (atomic_read(&apc->tx_qp[i].txq.napi_initialized)) {
> > +			napi_synchronize(napi);
> > +			napi_disable(napi);
> > +			netif_napi_del(napi);
> > +			atomic_set(&apc->tx_qp[i].txq.napi_initialized, 0);
> > +		}
> >  		mana_destroy_wq_obj(apc, GDMA_SQ, apc->tx_qp[i].tx_object);
> >
> >  		mana_deinit_cq(apc, &apc->tx_qp[i].tx_cq);
> > @@ -1931,6 +1933,7 @@ static int mana_create_txq(struct
> mana_port_context *apc,
> >  		txq->ndev =3D net;
> >  		txq->net_txq =3D netdev_get_tx_queue(net, i);
> >  		txq->vp_offset =3D apc->tx_vp_offset;
> > +		atomic_set(&txq->napi_initialized, 0);
> >  		skb_queue_head_init(&txq->pending_skbs);
> >
> >  		memset(&spec, 0, sizeof(spec));
> > @@ -1997,6 +2000,7 @@ static int mana_create_txq(struct
> mana_port_context *apc,
> >
> >  		netif_napi_add_tx(net, &cq->napi, mana_poll);
> >  		napi_enable(&cq->napi);
> > +		atomic_set(&txq->napi_initialized, 1);
> >
> >  		mana_gd_ring_cq(cq->gdma_cq, SET_ARM_BIT);
> >  	}
> > @@ -2023,14 +2027,18 @@ static void mana_destroy_rxq(struct
> mana_port_context *apc,
> >
> >  	napi =3D &rxq->rx_cq.napi;
> >
> > -	if (validate_state)
> > -		napi_synchronize(napi);
> > +	if (atomic_read(&rxq->napi_initialized)) {
> >
> > -	napi_disable(napi);
> > +		if (validate_state)
> > +			napi_synchronize(napi);
>=20
> Is this validate_state flag still needed? The new napi_initialized
> variable will make sure the napi_synchronize() is called only for rxqs
> that have napi_enabled.
>=20

Yes, the validate_state flag for mana_destroy_rxq() can be combined/renamed=
.

@Souradeep Chakrabarti, As Jakub suggested in V2, you may:
Rename the parameter validate_state to napi_initialized. The two callers
below can still call like before.
1 mana_en.c mana_create_rxq    2296 mana_destroy_rxq(apc, rxq, false);
2 mana_en.c mana_destroy_vport 2340 mana_destroy_rxq(apc, rxq, true);

So you don't need to add napi_initialized struct mana_rxq.

In mana_destroy_rxq() you can have code like this
if (napi_initialized) {
        napi =3D &rxq->rx_cq.napi;

        napi_synchronize(napi);

        napi_disable(napi);

        xdp_rxq_info_unreg(&rxq->xdp_rxq);

        netif_napi_del(napi);
}

For mana_destroy_txq, it looks more complex, your adding napi_initialized
to struct mana_txq is good.

Thanks,
- Haiyang


