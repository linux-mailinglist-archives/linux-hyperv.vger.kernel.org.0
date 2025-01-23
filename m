Return-Path: <linux-hyperv+bounces-3758-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D2552A19E09
	for <lists+linux-hyperv@lfdr.de>; Thu, 23 Jan 2025 06:45:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8F75E188E00C
	for <lists+linux-hyperv@lfdr.de>; Thu, 23 Jan 2025 05:46:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87AE613B7A3;
	Thu, 23 Jan 2025 05:45:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="V3AfShZM"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2115.outbound.protection.outlook.com [40.107.93.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B10A2C2FD;
	Thu, 23 Jan 2025 05:45:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.115
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737611153; cv=fail; b=eoZGtOHddQyx0EpzzFcGAB39wFuaNZQYepCA/qKaT7j0qmBp6BnTSJ2gH/CdweXn48XDW674BNRNpaYUM4tCGkAY9CO5jxQII08a3cDYJ/Ae9Cz2nfqZuJ+YJzgTtEomrD9cIh3zLPVyRI/uMCQHHBIPOnH6fHwF1H1+9GAQr0Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737611153; c=relaxed/simple;
	bh=ZCdfwYMnHgRfTTqC2lSt0AwtR+E3RIbp/eXBiTSwEFQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Yr3f7LcroN5Vz/GMN/CLSrlNscIyewkWD+xj3Fn1TK+DHVZJBo70Ee1Fk7Ve4rvQNhqEdOr55/WIoVvSosMb+fMZqCcKpza/DqvNXGkNkDDJQQoySFVkPpQzIadJtgpllMRkRFsL81rkTLWubhrUBnjs5Aw/KfRqas5mYxozmQw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com; spf=pass smtp.mailfrom=microsoft.com; dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b=V3AfShZM; arc=fail smtp.client-ip=40.107.93.115
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microsoft.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wiihF2cwsEZdp5CL0a0TVhmiBvc0FbsUWvwqNAhJM+uPFX99clz1Rd1lPNAW2Y/bd+Lg5GfsSUvCDvUpA33qovdkbM/NtwCDgh+aawgTRj8cD0wwoGnmU/RS3wzMDYsqYKB5USISPx+wYSPmaG4Wq8YhoIm8KEanN1je38DVFU03gViSatdGB4y9RbEmqdBve1YwRZZgwhp74o0SXIpouj/lQ7zvxja7cB5kuOzi9c1N3YgSH5RO2QXnSKJOtmSRgJMT2r0/q5XhDEmJvLkkbjbMbm6rjQkyj4vGsaIoxxzjnBWScaEX7l6wctRrFTaM5ZHB1AkHLISW3ElLTnt6JA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gmG/FhiBhQlS9/p45j96rNZzICQpIZkEpr6NbsDP3rE=;
 b=cdBt1tsfOctRO8W4Bn5/WqkNUUNBeUOky5EIEQSxuFovO9lS06TPKmLAd/lmRg1GUUlMNU4g9Qwy216qXUDJITqv4yoXnmVFUgXaLSfuymJdBfCTOz87buqaEORAx89yKNQCnD25sX6/e3tD+a4axEpEHtEbEuzFvE9R/al4geAwtulHT6CNRL6+1QW0fjuLkTmS9nOXduKAUvI6PV0oz60AB5m25wWKYYofGbXEjPuvKv33WGvexuj9pDT1MBCxQ3791icKXr3U0Fpl8pAB/RU5JDyqXd+KziJx/D3dCPom9pwKkH65NZxZ3mMXs2voItnxZliDLAzT0rlpdvRkTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gmG/FhiBhQlS9/p45j96rNZzICQpIZkEpr6NbsDP3rE=;
 b=V3AfShZMGdvLnBIVqnb9qDTX/zOrxgr7xZ995yD2/W+xxx5l3h+YdQF8N8bHM3Wjq3/fk8lyXuPhy3lpj3lr7MSyc1TtiA4KZ5TI1WUcKRcvcxl6TSdCKjSJxS2p3PCfXO5I5SBb6R+L/tORrWwtO3255VZOHqtNNADifirCwok=
Received: from SA6PR21MB4231.namprd21.prod.outlook.com (2603:10b6:806:412::20)
 by SA0PR21MB1867.namprd21.prod.outlook.com (2603:10b6:806:ef::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.8; Thu, 23 Jan
 2025 05:45:48 +0000
Received: from SA6PR21MB4231.namprd21.prod.outlook.com
 ([fe80::5c62:d7c6:4531:3aff]) by SA6PR21MB4231.namprd21.prod.outlook.com
 ([fe80::5c62:d7c6:4531:3aff%5]) with mapi id 15.20.8398.005; Thu, 23 Jan 2025
 05:45:48 +0000
From: Long Li <longli@microsoft.com>
To: Konstantin Taranov <kotaranov@linux.microsoft.com>, Konstantin Taranov
	<kotaranov@microsoft.com>, Shiraz Saleem <shirazsaleem@microsoft.com>,
	"pabeni@redhat.com" <pabeni@redhat.com>, Haiyang Zhang
	<haiyangz@microsoft.com>, KY Srinivasan <kys@microsoft.com>,
	"edumazet@google.com" <edumazet@google.com>, "kuba@kernel.org"
	<kuba@kernel.org>, "davem@davemloft.net" <davem@davemloft.net>, Dexuan Cui
	<decui@microsoft.com>, "wei.liu@kernel.org" <wei.liu@kernel.org>,
	"sharmaajay@microsoft.com" <sharmaajay@microsoft.com>, "jgg@ziepe.ca"
	<jgg@ziepe.ca>, "leon@kernel.org" <leon@kernel.org>
CC: "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>
Subject: RE: [PATCH rdma-next 06/13] RDMA/mana_ib: UD/GSI QP creation for
 kernel
Thread-Topic: [PATCH rdma-next 06/13] RDMA/mana_ib: UD/GSI QP creation for
 kernel
Thread-Index: AQHba2CX9gufIbLxvkiaY7bdEDyFrLMj3UzA
Date: Thu, 23 Jan 2025 05:45:48 +0000
Message-ID:
 <SA6PR21MB4231DDA85B6F970037701408CEE02@SA6PR21MB4231.namprd21.prod.outlook.com>
References: <1737394039-28772-1-git-send-email-kotaranov@linux.microsoft.com>
 <1737394039-28772-7-git-send-email-kotaranov@linux.microsoft.com>
In-Reply-To: <1737394039-28772-7-git-send-email-kotaranov@linux.microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=45fc2265-ec13-4f79-a71d-06cf15b694fb;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2025-01-23T05:45:36Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Tag=10,
 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA6PR21MB4231:EE_|SA0PR21MB1867:EE_
x-ms-office365-filtering-correlation-id: a8ba466e-fc3d-4789-97c2-08dd3b713049
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|376014|366016|1800799024|921020|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?GP5mdnv4rmBcbAv0nNbOulPGjUQaPMkyuYCWmuB1ehBBqy7yvlkXleLwMEl5?=
 =?us-ascii?Q?lOle8XWk1pr0mx2hQXGGECXRpTitpPl1wvsNbvb1VCUHlMdtz2jONl06cDuw?=
 =?us-ascii?Q?tykIu8FaszBBKuKY/P5AGnSK6/osT9CNCAMKEc0iLc/si8rGe0MHANGfS9qm?=
 =?us-ascii?Q?yBaq6y7NSo7XedFOaY8iRvZWGGgzBVqICz9AbzcWF1BeLxxlPjHegYM4sbid?=
 =?us-ascii?Q?GDera2i//alILI4iDxI569XxGpB5irJgYAx4E+BQ0caswEtnYmvdLxTIpK79?=
 =?us-ascii?Q?VwcIEXaTZysMr594XLqiCXbymXvvkp6TPyaPcNvUILnGASXMYfEjtKDjUa6H?=
 =?us-ascii?Q?+3Am54Jjr+ECV6c05Gib38jhGhu7J5zjJwLc1qVWq1HNDbCz3gslntYN1wOD?=
 =?us-ascii?Q?/2tmNNtQBT1dECXiI4wYnkPt/bEDRSm/SFxYoGV0jYlihI/ZTE+U+Qtr+Oh2?=
 =?us-ascii?Q?1VYaR7qoM8XUFpwfjElEA5R5jQHPXA1T9N2kdqX6T9i018CyAMKivdpN8L2h?=
 =?us-ascii?Q?UoO9eHLGIt35TCMBOtb28PqN60k+twa5L1Upbpk5IdCJeT4XBDr/le5YJQII?=
 =?us-ascii?Q?wQ9MZ/p3LUZm0Es6wCsrFPlbShTuomp334KkG4Y0r7o1hCFdB2OE/GGneZ13?=
 =?us-ascii?Q?vfIuMfagCQRpJKWQvLzG3o9J7oaz0rj4WcGizSZ2NQH0RaaFwpGSkju66gUa?=
 =?us-ascii?Q?g/FnNCJ4yDLxr1Rzlqr6eVqPCUUJjb9HjLXEkm+8d2c8MF2usBIA10tsxgz+?=
 =?us-ascii?Q?H3ANaqrO2NFnpz/JT0cBWA5ePRhhk01c/iPaHxmTqlCCo9VIFowYXl2TH9d2?=
 =?us-ascii?Q?4E2SpGjRGGjWSyWPpzdvinjp0ePw11MMNHNw8eSL9xZUpGGDRkRl8tFRbeLi?=
 =?us-ascii?Q?uJvdyQGsfnxBkhx0UvO+i967G6Yq8YopeZcXINVFG6Mji/QOUbvT3GuYCZm5?=
 =?us-ascii?Q?WKbbIbmvc4W7D0SeJ2VlMZUJmU8Gwi0Z9VzZ0XT0RqD5CmFFQmglx0g4ChTx?=
 =?us-ascii?Q?eglBAgXoAjvI1QsO7t8zz7Lt6qU4PSgRypM7HJ8q3bu+4QkGp8mYJNx40wTF?=
 =?us-ascii?Q?BSAW7egfDcwW/PqmrcJjqqFUpy3Fb401Gj17/bzQTJHhO5W1NkWhwwGT4qIu?=
 =?us-ascii?Q?qmOrS6jN0kRjl7JMgAF9MmdrgDhK3pYO08mQHd5L6DZN0AFHEo4LCySxSFIB?=
 =?us-ascii?Q?RaAkpXCZRNBqiv4ZD1A1tux+v/PuTWTVAq34gFCje8yZ8kWgny0xlJv+9uHd?=
 =?us-ascii?Q?Ri4Bqyrpax8xxNIMykWFKk5cw7AHumw6lj6a3u/XcRVfWpj4eJ8bUTXqhDt9?=
 =?us-ascii?Q?G4Dh36JR1x/xcIJY+YnqHOrtP8XaMBXFVoWELC1/dLlyrdbuaaGwfkYlrk0L?=
 =?us-ascii?Q?L7OcYtOUEhYdq4x+4QeN2r6lID6ZPUPb3yVGNGnTsi3MNjtBx+tRceSIrG45?=
 =?us-ascii?Q?H2/2l0BNAY9zi7ZQKlVE22eTR4dQqWBlqqzrI8oO8CfJsI7Yd8XwDg=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA6PR21MB4231.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(921020)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?fNKVxzifRRp0zoFBfrUAy3ZEnMnn/roJgsXaCLnCdkPms5jlGK4FgJ8kFeMh?=
 =?us-ascii?Q?EGEex03oxmRRQtWdJCe7/KZ+qr1plpVsBDZXjEIe8rktmICZb6MOus8iSYho?=
 =?us-ascii?Q?BEPKdf5v1mqsVpRErR5tbQXev1ZsnFhd9sBAs7VPvk8HuXvuXJpjlK0AxhCv?=
 =?us-ascii?Q?1Tw+nXEfVMWo1rrvOHnAn8fpAUZHJ5Pn7wG2xcggR6BOkDqzxRWn5kbvlXyp?=
 =?us-ascii?Q?Dezh80PGYm+gLvKi7+GSMDOwYCFKeoSzVeB7DLSqvUdxI+wmm/2CEKMFsWeX?=
 =?us-ascii?Q?aDscsTovqfIUZQMI/VdPgLSP9CwQjqoIBX1SMsBZiAQE/zIV3wAOiYtsEGRJ?=
 =?us-ascii?Q?BzELkme1fzQqGlghQAnALk2dDfGw4368n0QT2yc50UoCwUEMBDuxCsRy17S0?=
 =?us-ascii?Q?ysebffFZ1K8mtt0iPT+hL2w6I08cz9d+/JcGkyc2WUh5WzkWQGnsJnjUCdcL?=
 =?us-ascii?Q?UacKFq1hVMNVc0uyK1YdjlW9lRpoJ8A4PdcBiTjG/uQekhANnXy3BzDQ0DOu?=
 =?us-ascii?Q?tV5mLjc6B5V8BGpandCOa1VY3j+H2wYDYy5yNl/yRPNaOCJX7wh8LlgLrvUu?=
 =?us-ascii?Q?fFNHou+0KR71AYAa176zRo0MeqJxP0kJ8c+o3stacTDy/bFGkggEQ9ULnoO2?=
 =?us-ascii?Q?BiOTBr3iBFy4J7NQWWKGUbu/rI3N+xcOwGqf0B2ap81qdIAUHSOY8GA8sNe/?=
 =?us-ascii?Q?Vb3HjU09IBnW3rzKosL9s/NaWnz0QwF9WaxRa5YxU+klWDzWU2p9wPStYy3O?=
 =?us-ascii?Q?IeIx/NfRKcRNXdWFVlTMMGozXqIWix5aIl0SwLKucu3R/YGHycdLaCp9hjPq?=
 =?us-ascii?Q?hffj8mmBq2SuboStVvu2jgOBJ9zpR2sUJ4ioty8n1dAZlQy5+zYf97BV1mXy?=
 =?us-ascii?Q?/bW5Oy+g7EZRWYHkvUrQC8TfMtaVDVQPsnQFvnQMJvbDkX8x0tZ89ngWy/sa?=
 =?us-ascii?Q?SosCfjHNimmHARs55zvFcZxJphcCQgzYtbO2DVWoiC5vA2Qhcp6sO204fxci?=
 =?us-ascii?Q?CbQVi/aHxTuf6Nb11yU1maXHXnqfsxboJVXkhZxMsM7SAfLr2T2Ub4LKW3y8?=
 =?us-ascii?Q?uoY/QqNWijGcaT/Rqn/+AGRYWWtelsvsH0azfc+LxTnHu6yfYpvUBcUiMBMx?=
 =?us-ascii?Q?30SMavrwmiQQ0Oz6D87C7gaHH2iBbIuN99sr5KogEF3TudGHoITTVwN5SBbD?=
 =?us-ascii?Q?zWl9zc44aUNZHSSKf2AprdmiGXEAddbbgRdayCqf5iUu4tW7DKw4L9qDMMfU?=
 =?us-ascii?Q?7XqrfTINy1q36wmG/D7479RRyfutv0V2NYFZCe8Egm+pbzH6hc7ktl3GCL+D?=
 =?us-ascii?Q?o1yUTR50tj35zOQUAlZXo+VkHZp7DgcVhOB1uB0UL0jO3arAbo8zJ1Cc3DLz?=
 =?us-ascii?Q?h5WrmuBm30k67D+1hPajUeiDP60vxbEM+3GN4VVqGXRI3tJKRhTQTv34gjRy?=
 =?us-ascii?Q?mII5JsQ72nDeP8AEBzh+CSFPmGKVbfxgAM9iNRD3oliEEOVvfZ+Q2u0py3mz?=
 =?us-ascii?Q?/GP7lC2KyTlPbPofnuGrXyfO1DyeE1wlxcu/u0SqYrN/aATNzqBiqADeIKMr?=
 =?us-ascii?Q?v/JascSA4nU7KlNznGo4Rfxba/f16UrTdeP1SEtq?=
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
X-MS-Exchange-CrossTenant-AuthSource: SA6PR21MB4231.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a8ba466e-fc3d-4789-97c2-08dd3b713049
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jan 2025 05:45:48.3891
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: icXeRiHkvx3xdlHjLECanD9JUfHyjVmS2H5WbSyVVqaMZw4dO6v9baR41X/dP9ikzqqiD23t0EIPpHYvBSAo0w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR21MB1867

> Subject: [PATCH rdma-next 06/13] RDMA/mana_ib: UD/GSI QP creation for
> kernel
>=20
> From: Konstantin Taranov <kotaranov@microsoft.com>
>=20
> Implement UD/GSI QPs for the kernel.
> Allow create/modify/destroy for such QPs.
>=20
> Signed-off-by: Konstantin Taranov <kotaranov@microsoft.com>
> Reviewed-by: Shiraz Saleem <shirazsaleem@microsoft.com>

Reviewed-by: Long Li <longli@microsoft.com>

> ---
>  drivers/infiniband/hw/mana/qp.c | 115 ++++++++++++++++++++++++++++++++
>  1 file changed, 115 insertions(+)
>=20
> diff --git a/drivers/infiniband/hw/mana/qp.c b/drivers/infiniband/hw/mana=
/qp.c
> index 73d67c8..fea45be 100644
> --- a/drivers/infiniband/hw/mana/qp.c
> +++ b/drivers/infiniband/hw/mana/qp.c
> @@ -398,6 +398,52 @@ err_free_vport:
>  	return err;
>  }
>=20
> +static u32 mana_ib_wqe_size(u32 sge, u32 oob_size) {
> +	u32 wqe_size =3D sge * sizeof(struct gdma_sge) + sizeof(struct gdma_wqe=
)
> ++ oob_size;
> +
> +	return ALIGN(wqe_size, GDMA_WQE_BU_SIZE); }
> +
> +static u32 mana_ib_queue_size(struct ib_qp_init_attr *attr, u32
> +queue_type) {
> +	u32 queue_size;
> +
> +	switch (attr->qp_type) {
> +	case IB_QPT_UD:
> +	case IB_QPT_GSI:
> +		if (queue_type =3D=3D MANA_UD_SEND_QUEUE)
> +			queue_size =3D attr->cap.max_send_wr *
> +				mana_ib_wqe_size(attr->cap.max_send_sge,
> INLINE_OOB_LARGE_SIZE);
> +		else
> +			queue_size =3D attr->cap.max_recv_wr *
> +				mana_ib_wqe_size(attr->cap.max_recv_sge,
> INLINE_OOB_SMALL_SIZE);
> +		break;
> +	default:
> +		return 0;
> +	}
> +
> +	return MANA_PAGE_ALIGN(roundup_pow_of_two(queue_size));
> +}
> +
> +static enum gdma_queue_type mana_ib_queue_type(struct ib_qp_init_attr
> +*attr, u32 queue_type) {
> +	enum gdma_queue_type type;
> +
> +	switch (attr->qp_type) {
> +	case IB_QPT_UD:
> +	case IB_QPT_GSI:
> +		if (queue_type =3D=3D MANA_UD_SEND_QUEUE)
> +			type =3D GDMA_SQ;
> +		else
> +			type =3D GDMA_RQ;
> +		break;
> +	default:
> +		type =3D GDMA_INVALID_QUEUE;
> +	}
> +	return type;
> +}
> +
>  static int mana_table_store_qp(struct mana_ib_dev *mdev, struct mana_ib_=
qp
> *qp)  {
>  	refcount_set(&qp->refcount, 1);
> @@ -490,6 +536,51 @@ destroy_queues:
>  	return err;
>  }
>=20
> +static int mana_ib_create_ud_qp(struct ib_qp *ibqp, struct ib_pd *ibpd,
> +				struct ib_qp_init_attr *attr, struct ib_udata
> *udata) {
> +	struct mana_ib_dev *mdev =3D container_of(ibpd->device, struct
> mana_ib_dev, ib_dev);
> +	struct mana_ib_qp *qp =3D container_of(ibqp, struct mana_ib_qp, ibqp);
> +	struct gdma_context *gc =3D mdev_to_gc(mdev);
> +	u32 doorbell, queue_size;
> +	int i, err;
> +
> +	if (udata) {
> +		ibdev_dbg(&mdev->ib_dev, "User-level UD QPs are not
> supported, %d\n", err);
> +		return -EINVAL;
> +	}
> +
> +	for (i =3D 0; i < MANA_UD_QUEUE_TYPE_MAX; ++i) {
> +		queue_size =3D mana_ib_queue_size(attr, i);
> +		err =3D mana_ib_create_kernel_queue(mdev, queue_size,
> mana_ib_queue_type(attr, i),
> +						  &qp->ud_qp.queues[i]);
> +		if (err) {
> +			ibdev_err(&mdev->ib_dev, "Failed to create queue %d,
> err %d\n",
> +				  i, err);
> +			goto destroy_queues;
> +		}
> +	}
> +	doorbell =3D gc->mana_ib.doorbell;
> +
> +	err =3D mana_ib_gd_create_ud_qp(mdev, qp, attr, doorbell, attr->qp_type=
);
> +	if (err) {
> +		ibdev_err(&mdev->ib_dev, "Failed to create ud qp  %d\n", err);
> +		goto destroy_queues;
> +	}
> +	qp->ibqp.qp_num =3D qp->ud_qp.queues[MANA_UD_RECV_QUEUE].id;
> +	qp->port =3D attr->port_num;
> +
> +	for (i =3D 0; i < MANA_UD_QUEUE_TYPE_MAX; ++i)
> +		qp->ud_qp.queues[i].kmem->id =3D qp->ud_qp.queues[i].id;
> +
> +	return 0;
> +
> +destroy_queues:
> +	while (i-- > 0)
> +		mana_ib_destroy_queue(mdev, &qp->ud_qp.queues[i]);
> +	return err;
> +}
> +
>  int mana_ib_create_qp(struct ib_qp *ibqp, struct ib_qp_init_attr *attr,
>  		      struct ib_udata *udata)
>  {
> @@ -503,6 +594,9 @@ int mana_ib_create_qp(struct ib_qp *ibqp, struct
> ib_qp_init_attr *attr,
>  		return mana_ib_create_qp_raw(ibqp, ibqp->pd, attr, udata);
>  	case IB_QPT_RC:
>  		return mana_ib_create_rc_qp(ibqp, ibqp->pd, attr, udata);
> +	case IB_QPT_UD:
> +	case IB_QPT_GSI:
> +		return mana_ib_create_ud_qp(ibqp, ibqp->pd, attr, udata);
>  	default:
>  		ibdev_dbg(ibqp->device, "Creating QP type %u not supported\n",
>  			  attr->qp_type);
> @@ -579,6 +673,8 @@ int mana_ib_modify_qp(struct ib_qp *ibqp, struct
> ib_qp_attr *attr,  {
>  	switch (ibqp->qp_type) {
>  	case IB_QPT_RC:
> +	case IB_QPT_UD:
> +	case IB_QPT_GSI:
>  		return mana_ib_gd_modify_qp(ibqp, attr, attr_mask, udata);
>  	default:
>  		ibdev_dbg(ibqp->device, "Modify QP type %u not supported",
> ibqp->qp_type); @@ -652,6 +748,22 @@ static int
> mana_ib_destroy_rc_qp(struct mana_ib_qp *qp, struct ib_udata *udata)
>  	return 0;
>  }
>=20
> +static int mana_ib_destroy_ud_qp(struct mana_ib_qp *qp, struct ib_udata
> +*udata) {
> +	struct mana_ib_dev *mdev =3D
> +		container_of(qp->ibqp.device, struct mana_ib_dev, ib_dev);
> +	int i;
> +
> +	/* Ignore return code as there is not much we can do about it.
> +	 * The error message is printed inside.
> +	 */
> +	mana_ib_gd_destroy_ud_qp(mdev, qp);
> +	for (i =3D 0; i < MANA_UD_QUEUE_TYPE_MAX; ++i)
> +		mana_ib_destroy_queue(mdev, &qp->ud_qp.queues[i]);
> +
> +	return 0;
> +}
> +
>  int mana_ib_destroy_qp(struct ib_qp *ibqp, struct ib_udata *udata)  {
>  	struct mana_ib_qp *qp =3D container_of(ibqp, struct mana_ib_qp, ibqp);
> @@ -665,6 +777,9 @@ int mana_ib_destroy_qp(struct ib_qp *ibqp, struct
> ib_udata *udata)
>  		return mana_ib_destroy_qp_raw(qp, udata);
>  	case IB_QPT_RC:
>  		return mana_ib_destroy_rc_qp(qp, udata);
> +	case IB_QPT_UD:
> +	case IB_QPT_GSI:
> +		return mana_ib_destroy_ud_qp(qp, udata);
>  	default:
>  		ibdev_dbg(ibqp->device, "Unexpected QP type %u\n",
>  			  ibqp->qp_type);
> --
> 2.43.0


