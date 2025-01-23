Return-Path: <linux-hyperv+bounces-3764-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E7F8A1AA3A
	for <lists+linux-hyperv@lfdr.de>; Thu, 23 Jan 2025 20:17:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A97443ABB42
	for <lists+linux-hyperv@lfdr.de>; Thu, 23 Jan 2025 19:17:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28D7A165F13;
	Thu, 23 Jan 2025 19:17:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="LyFMZLLi"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2091.outbound.protection.outlook.com [40.107.220.91])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26F3E14D44D;
	Thu, 23 Jan 2025 19:17:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.91
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737659845; cv=fail; b=s0lqice5I8LXqz71oyay+TQpj2aXdxVohbrdM/orO51LUyeFK3C28SscKIIlucLNsgtD24HJ4WBhymZg2+UdKaLnZEYfllY2KA8SkSCGk5gSiwusX95FceRaUG57b3k7pFvrCjbGEokmE0/XeamCnsMrvq1GbR4UeJziRG82+vg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737659845; c=relaxed/simple;
	bh=pQW2wnc7gaw/3WlyKtbNV1q5HmAi51dVpH7AtTT0ogU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=oSIWj59gKVtevUvbVE5P3AVZ6PkN2sePW/2w2/oM89BrQsRh7v+X8sE9i7dQeatV7BNUKCn8TJ+iLe8CA1nMDvZkzTK8c0q0hs5JRzlpLoUCFzQA/t36HSL117iHKAojidiEuTaNu9HOhsCKo/tzLm43Xz5wFQCFtkqj6Tr8RDc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com; spf=pass smtp.mailfrom=microsoft.com; dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b=LyFMZLLi; arc=fail smtp.client-ip=40.107.220.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microsoft.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rlwse1i5wn53+Z9MHFMkG7i5ORkdS74Wlz8vMCYnAEVxc0YI5qTFlveIrzo5UXC/wdSXOCngmIY4MKdi+FbyNI0Bo9YyX5ISUuEdpl8AmmHDG50f52C/Cin/mizFInJLIJnS3iq1+0M6JLc4s2JifYQWPzkWhXirwquSSM783rMlDt5oRdbXlcx/4kQ7GaFgXoo4LCVAyOGdc+ht8gub5nBL5DI/LyqqyNMwnXORMirLsSqI76sFfqxpvVNeuLr/4ZF2jYkdHbn02NOoPUU1zMIrs16AgqyTPpSzkGBIEfcbCbt2peUJQnzuL4G+ChuFGLlcmwBt8i0qI5XnFVwEXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BXSt76ydyqYWkt3kaL5naLjIbzf8mt8x/m72wh/V0ew=;
 b=Jt5PRUFWahiZFDyFLOH3iOMPC3QKt7n/PiIU+wYRWKlt9Mip/Mym+UnB8DOEITbVgXpXL88fZOma3VEaz8SQJ4Pm+gvJhq4GhsTikmT1dfADzyH8qgL5Rij5cXLfWaqlhV3FFy924orZ88KlzCxNqxdlfdeyTFt4IrbBmvUZWQ9monps9GnIke9TMxfUxJ+FMzG2G4AuZsnGqeMbCANGyhjmWjcRuUxzckkwAd+0e2CdnWZbgth2t1ZdJ89o5KZKZw1op0g2FVrCyqqM92jmdUMh/WNlm1sn1arEXIdr94z8SDhIAxmvww0+4QOIdPWL7YvtZhH76yRAlgyWzlHwGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BXSt76ydyqYWkt3kaL5naLjIbzf8mt8x/m72wh/V0ew=;
 b=LyFMZLLiKM3YtYN4RCjZGU3u0Rp5CflpipOhnlC+DnEcSF7JtjBcoQOaJAh3m5+LnuR3v4FhSAd6W3Am/bNasGX9hkYqypQ+S/mbAd8VOkjQbhb2iQ7u6kVKkQOitZH5IdORi7+/DL4tfY8qsJjYG3y5kLt970JKbP0/4hYq/d4=
Received: from SA6PR21MB4231.namprd21.prod.outlook.com (2603:10b6:806:412::20)
 by SA6PR21MB4287.namprd21.prod.outlook.com (2603:10b6:806:418::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.7; Thu, 23 Jan
 2025 19:17:15 +0000
Received: from SA6PR21MB4231.namprd21.prod.outlook.com
 ([fe80::5c62:d7c6:4531:3aff]) by SA6PR21MB4231.namprd21.prod.outlook.com
 ([fe80::5c62:d7c6:4531:3aff%5]) with mapi id 15.20.8398.005; Thu, 23 Jan 2025
 19:17:15 +0000
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
Subject: RE: [PATCH rdma-next 12/13] RDMA/mana_ib: polling of CQs for GSI/UD
Thread-Topic: [PATCH rdma-next 12/13] RDMA/mana_ib: polling of CQs for GSI/UD
Thread-Index: AQHba2CXU+t+zLdAA0CtHlFUtkX+c7MkwAPA
Date: Thu, 23 Jan 2025 19:17:15 +0000
Message-ID:
 <SA6PR21MB42316DD7CD50572BEA692BE9CEE02@SA6PR21MB4231.namprd21.prod.outlook.com>
References: <1737394039-28772-1-git-send-email-kotaranov@linux.microsoft.com>
 <1737394039-28772-13-git-send-email-kotaranov@linux.microsoft.com>
In-Reply-To:
 <1737394039-28772-13-git-send-email-kotaranov@linux.microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=6edb2d33-7036-453b-addf-ae615f605427;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2025-01-23T19:17:03Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Tag=10,
 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA6PR21MB4231:EE_|SA6PR21MB4287:EE_
x-ms-office365-filtering-correlation-id: e4cc39e7-a9f6-4611-f405-08dd3be28bf8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|376014|7416014|38070700018|921020;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?lV1mwvSJ8eCBoXpGvWd4Nyb/JL749RMecPQ5rLV8xAcPzq5RoJP0B72Zl26+?=
 =?us-ascii?Q?2YZErQyJj6p6FbRiS06cJ0ZxAjsW5Ecj6hWe3FUuox6nboJzm/kjFpGhLrOh?=
 =?us-ascii?Q?zv8gxRALhO17Kps9s5DWFi/J/+iPsOWKx/H5Di+Q6z6xphy4X9MfcXyObYq6?=
 =?us-ascii?Q?CtuejPPTxKY5jdy66TiwyTrnHZZUFOpKtAZ7TRUYbVPZB7abSJnpaaHvfg6t?=
 =?us-ascii?Q?INOYdA2Gp0xeDIKAmooSLLnS+9eNUD6qSm6s7AFMMLMkzTJTWHR0ptpWmQVe?=
 =?us-ascii?Q?/IBJakX535iLuH+Aji+S/qKj4xMjhBoggNGxf2nW8+D82iyqWVqqdW0312qt?=
 =?us-ascii?Q?X4WMdcu7wcroZXuZ/n3QFUPuUQ5LFpsI7xgnSlEC5IyTc7f154ykMvjejSNl?=
 =?us-ascii?Q?YpTIcXrVRT1v4E4JPStJJGAGc+rMFUX8LrPdhmD4Bdp8R4/OohpEtHXIVO+n?=
 =?us-ascii?Q?QFhGRIkTF68QfYVN5HBCYyodhwngzcQ3FiwYmQHOKY17odBFOG+ms23RJ62R?=
 =?us-ascii?Q?w8/QpG7JP1ozol9Eb198Kd8cI11sVSrjo0qFhsYmszsaiXUhmFyV/dxtmc+X?=
 =?us-ascii?Q?pDD9aUC8jPRA9YmMiz5euSKjCzpEGwzgT1Jsve4TyJgJIg8UJWBSwrJaweOC?=
 =?us-ascii?Q?NHabNNrl62DiryvvSD/ASTMrxfa8dc/q27+4GkVxnQnFIUhVyuQAOjYKObTO?=
 =?us-ascii?Q?i1VqXhgbB+cH7IS8JzOR+t35DS6JjZ/34Y/cMMGq3st4f9zsMNc0/ftmzXk6?=
 =?us-ascii?Q?/V1ngw41Qv7mK+3wY9+D/ubGldLp3dIA2eiXHT/taHkruZ4tReg3uk/b5vP7?=
 =?us-ascii?Q?HcJ38cOQTP8bWm4KItNEaiXM8+2h5AVwbiYC0gVwLgyMoXC+fcuTc62Ppv0L?=
 =?us-ascii?Q?SBD/7CeoKv0SO9xFqNlrKGpqRkkqNYhJ5B3YzFO5pxqS/oRHH4sFF3xH5tGO?=
 =?us-ascii?Q?5XzeWnGAPhOGfAFbTRJVaclMEemQPyt4sbYd9QFljXajsEyepHWgPbr7wDph?=
 =?us-ascii?Q?7mVCZbOwjnYfKu2Q1ASDGGf1h5wF7+VYE9pewleUrBtH0Qt9A0xUE6XfjJ3m?=
 =?us-ascii?Q?YstKrjlwt+8sUVPsTNJy9LDXhgEA/EWdc47k7aC1muA/loRXGLQ4YLP8k8e1?=
 =?us-ascii?Q?gWc4CTgd0Zq9LORzUXhgDvYr3yApS4IZI1Lb8rY0FxkDaMQS7aqRW6CL6cVW?=
 =?us-ascii?Q?UaCxia/hH3jQh090ttwudv2MF6GTnd2R/iotVmbvymmOglyRAhdx+ryqtj6j?=
 =?us-ascii?Q?mJbIUBnjpr6T17siz4lVhVzwyvr3kDf2Cz/87H3VkI6+7Bt1g+o5HV+xd6RV?=
 =?us-ascii?Q?3wYt/gTtmmRyklTDwM/TaQRBGkMBTGqaM+kwidQVrpLBQLY7XzFYBEfL+98a?=
 =?us-ascii?Q?rXcI36FEEYJikbBjrU47B3dY/3E5+7/Q3L9lcyQS6l3V/nmbUfvmuiapinxy?=
 =?us-ascii?Q?020RITMn4XuhLCEtfOxsgmuQg8bTuhwd8QlS2vyQayv1CS/iGXQ4Ew=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA6PR21MB4231.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(38070700018)(921020);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?qSBAWygmiV432Cfgid4E5lS1jsyevpmn+MdBcrNe04sLnhyc1TH9MEVAYrsL?=
 =?us-ascii?Q?A01Fn9szUESW5DVOisMqx2v9ai2KUWkOnw5XaaY15h7YpMko9L+YZQ+M/Iek?=
 =?us-ascii?Q?lnekSO9YGt0D9G/LeG7DeM84y5hLOQfk20UPwaqevdgxaeKi+ynJf0fr4/bW?=
 =?us-ascii?Q?v8VNfxwz9QPrx+LaiPtgAKTzJCKVYm6KwpOGHk6UN1Xnu1rImTcdwYvOMwcN?=
 =?us-ascii?Q?03hceLtPoHrSDhG+jeSEJ4ouoFwDzqgAAiRwRE8jLrF1fpYRjqAH1QlJKKJn?=
 =?us-ascii?Q?IC0eF4Kb44tHA0I/PcVWisihnrz2tzUHmj9Ncw7UNz49QxZkOTjl34pX7tbC?=
 =?us-ascii?Q?kotvusWMofOoAZKiy53kwrzHU3v+UCEeHUfFFp+AOCoMdOLR81bozTlJm2uT?=
 =?us-ascii?Q?1JaoVBgVzxnVS07sGFtl/b0Zt89A+j1FlJ7J98iUc4OA8P+N3gymtmqBI6iI?=
 =?us-ascii?Q?Ia4IJSDPiRY7hEvNc7X/8XjyF5WbnhQauJ5W4AJlltDQ6iVhVSKWxIv42/vu?=
 =?us-ascii?Q?7Ry7SgAmrxudym9lVkOxX9T5YpNNY/tUuyoTdpVGC90ix7U1/sYZ1LZjKXRH?=
 =?us-ascii?Q?amjyzv0411+TztlYCepvK+kFdXfi2e4imGo5ioAYUsFXkbmmw+wINiHpmsRq?=
 =?us-ascii?Q?DeR7UlwcnUxQ47vPmXTWm2uuz942AB/1UcQgzzWGqNIo+7OxfqXThh9rVvvg?=
 =?us-ascii?Q?RYf+BeyQ9PgvT+AZklVqBLbMImNVvMBTVbr6upMvW0BMH6tHqKj22lY2fMLf?=
 =?us-ascii?Q?hy4Gn4nlgIjJM1Wr4CFOYi/bnNVPMjl7qiu08LHzsyJi4gW6kWxmAq9sxvga?=
 =?us-ascii?Q?w6dJ/chYrzsAVmlZfcscUl9cPh3tt2h/NC7POQVaHstD4uYof1hjlPfg0d9h?=
 =?us-ascii?Q?WBKG3iK6a9eLicf8JkovP2QBQtpfEJYpJlQDrGLaoEHVtk8LJkGe9BVHOEjL?=
 =?us-ascii?Q?YQ1TahsZHtLWK+DyZjcC/hQc3uCl6u/rl9QDymIMkEPSc9Ln5F39KcX+AE9b?=
 =?us-ascii?Q?fNm7zGaFtDqpAqCP1JKBlW305dZLmLxS+xvz02aluhwyq4vHnKxHaIVZAR06?=
 =?us-ascii?Q?/vxFQAloG4rlia5kJgiHXCQpJOUxtRJyf4nFxtqbWCVw8ibTUqRLRoDySOaM?=
 =?us-ascii?Q?D5pcMayTMDDkaQ0JL7GpHB/yPQVw5XRfFJcmZQ2pqRD3AC8bjUHc/L6rURT/?=
 =?us-ascii?Q?/wK1TtQEC48jDzSw2l7pNVV1NZE0bOp9LT7yFdbqCihqdQh0SvJnTLzDzbod?=
 =?us-ascii?Q?nNZ61jkFgnPu9Xdv497vUjHofX+YnJr3BnPGTYojw5lNRR6HoPZkLhROw3uG?=
 =?us-ascii?Q?dmz8wscWQidAA9stm+xoqQu4MUcDGq2TvOLvIX6OvtkYizidU1jT/FhZFkbq?=
 =?us-ascii?Q?m7q05MFxc0mbxu/Hny6BRL4PAmi4PCh0q1OCdCnKZr0ZDPnx0lGJDHJBr/Ao?=
 =?us-ascii?Q?WypUeyD4kPUwMLuYVOi64JbLSVWgKQF//pL0w9COcotKA7vlNAE2by3/mpW7?=
 =?us-ascii?Q?EaL+RXZyxWLr5Jguvw7I7TJ2n+usfU+iBkduiYRl6Ne0eK775pTAq8+IJODR?=
 =?us-ascii?Q?kyENzkylucpeOY5H9nFTYS1df2ICo/X4tgyWA/9b?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: e4cc39e7-a9f6-4611-f405-08dd3be28bf8
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jan 2025 19:17:15.3059
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KdwcLsv1/l4pyzUxk/E60oZatoFQd+HTfRpUOLeMEl9becDpZ5r6Bk1D33hwta3/Wfo09nSnJ+o2PZHne9e9AQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA6PR21MB4287

> Subject: [PATCH rdma-next 12/13] RDMA/mana_ib: polling of CQs for GSI/UD
>=20
> From: Konstantin Taranov <kotaranov@microsoft.com>
>=20
> Add polling for the kernel CQs.
> Process completion events for UD/GSI QPs.
>=20
> Signed-off-by: Konstantin Taranov <kotaranov@microsoft.com>
> Reviewed-by: Shiraz Saleem <shirazsaleem@microsoft.com>

Reviewed-by: Long Li <longli@microsoft.com>

> ---
>  drivers/infiniband/hw/mana/cq.c               | 135 ++++++++++++++++++
>  drivers/infiniband/hw/mana/device.c           |   1 +
>  drivers/infiniband/hw/mana/mana_ib.h          |  32 +++++
>  drivers/infiniband/hw/mana/qp.c               |  33 +++++
>  .../net/ethernet/microsoft/mana/gdma_main.c   |   1 +
>  5 files changed, 202 insertions(+)
>=20
> diff --git a/drivers/infiniband/hw/mana/cq.c b/drivers/infiniband/hw/mana=
/cq.c
> index 82f1462..5c325ef 100644
> --- a/drivers/infiniband/hw/mana/cq.c
> +++ b/drivers/infiniband/hw/mana/cq.c
> @@ -90,6 +90,10 @@ int mana_ib_create_cq(struct ib_cq *ibcq, const struct
> ib_cq_init_attr *attr,
>  		}
>  	}
>=20
> +	spin_lock_init(&cq->cq_lock);
> +	INIT_LIST_HEAD(&cq->list_send_qp);
> +	INIT_LIST_HEAD(&cq->list_recv_qp);
> +
>  	return 0;
>=20
>  err_remove_cq_cb:
> @@ -180,3 +184,134 @@ int mana_ib_arm_cq(struct ib_cq *ibcq, enum
> ib_cq_notify_flags flags)
>  	mana_gd_ring_cq(gdma_cq, SET_ARM_BIT);
>  	return 0;
>  }
> +
> +static inline void handle_ud_sq_cqe(struct mana_ib_qp *qp, struct
> +gdma_comp *cqe) {
> +	struct mana_rdma_cqe *rdma_cqe =3D (struct mana_rdma_cqe *)cqe-
> >cqe_data;
> +	struct gdma_queue *wq =3D qp-
> >ud_qp.queues[MANA_UD_SEND_QUEUE].kmem;
> +	struct ud_sq_shadow_wqe *shadow_wqe;
> +
> +	shadow_wqe =3D shadow_queue_get_next_to_complete(&qp-
> >shadow_sq);
> +	if (!shadow_wqe)
> +		return;
> +
> +	shadow_wqe->header.error_code =3D rdma_cqe->ud_send.vendor_error;
> +
> +	wq->tail +=3D shadow_wqe->header.posted_wqe_size;
> +	shadow_queue_advance_next_to_complete(&qp->shadow_sq);
> +}
> +
> +static inline void handle_ud_rq_cqe(struct mana_ib_qp *qp, struct
> +gdma_comp *cqe) {
> +	struct mana_rdma_cqe *rdma_cqe =3D (struct mana_rdma_cqe *)cqe-
> >cqe_data;
> +	struct gdma_queue *wq =3D qp-
> >ud_qp.queues[MANA_UD_RECV_QUEUE].kmem;
> +	struct ud_rq_shadow_wqe *shadow_wqe;
> +
> +	shadow_wqe =3D shadow_queue_get_next_to_complete(&qp-
> >shadow_rq);
> +	if (!shadow_wqe)
> +		return;
> +
> +	shadow_wqe->byte_len =3D rdma_cqe->ud_recv.msg_len;
> +	shadow_wqe->src_qpn =3D rdma_cqe->ud_recv.src_qpn;
> +	shadow_wqe->header.error_code =3D IB_WC_SUCCESS;
> +
> +	wq->tail +=3D shadow_wqe->header.posted_wqe_size;
> +	shadow_queue_advance_next_to_complete(&qp->shadow_rq);
> +}
> +
> +static void mana_handle_cqe(struct mana_ib_dev *mdev, struct gdma_comp
> +*cqe) {
> +	struct mana_ib_qp *qp =3D mana_get_qp_ref(mdev, cqe->wq_num,
> +cqe->is_sq);
> +
> +	if (!qp)
> +		return;
> +
> +	if (qp->ibqp.qp_type =3D=3D IB_QPT_GSI || qp->ibqp.qp_type =3D=3D IB_QP=
T_UD)
> {
> +		if (cqe->is_sq)
> +			handle_ud_sq_cqe(qp, cqe);
> +		else
> +			handle_ud_rq_cqe(qp, cqe);
> +	}
> +
> +	mana_put_qp_ref(qp);
> +}
> +
> +static void fill_verbs_from_shadow_wqe(struct mana_ib_qp *qp, struct ib_=
wc
> *wc,
> +				       const struct shadow_wqe_header
> *shadow_wqe) {
> +	const struct ud_rq_shadow_wqe *ud_wqe =3D (const struct
> ud_rq_shadow_wqe
> +*)shadow_wqe;
> +
> +	wc->wr_id =3D shadow_wqe->wr_id;
> +	wc->status =3D shadow_wqe->error_code;
> +	wc->opcode =3D shadow_wqe->opcode;
> +	wc->vendor_err =3D shadow_wqe->error_code;
> +	wc->wc_flags =3D 0;
> +	wc->qp =3D &qp->ibqp;
> +	wc->pkey_index =3D 0;
> +
> +	if (shadow_wqe->opcode =3D=3D IB_WC_RECV) {
> +		wc->byte_len =3D ud_wqe->byte_len;
> +		wc->src_qp =3D ud_wqe->src_qpn;
> +		wc->wc_flags |=3D IB_WC_GRH;
> +	}
> +}
> +
> +static int mana_process_completions(struct mana_ib_cq *cq, int nwc,
> +struct ib_wc *wc) {
> +	struct shadow_wqe_header *shadow_wqe;
> +	struct mana_ib_qp *qp;
> +	int wc_index =3D 0;
> +
> +	/* process send shadow queue completions  */
> +	list_for_each_entry(qp, &cq->list_send_qp, cq_send_list) {
> +		while ((shadow_wqe =3D
> shadow_queue_get_next_to_consume(&qp->shadow_sq))
> +				!=3D NULL) {
> +			if (wc_index >=3D nwc)
> +				goto out;
> +
> +			fill_verbs_from_shadow_wqe(qp, &wc[wc_index],
> shadow_wqe);
> +			shadow_queue_advance_consumer(&qp->shadow_sq);
> +			wc_index++;
> +		}
> +	}
> +
> +	/* process recv shadow queue completions */
> +	list_for_each_entry(qp, &cq->list_recv_qp, cq_recv_list) {
> +		while ((shadow_wqe =3D
> shadow_queue_get_next_to_consume(&qp->shadow_rq))
> +				!=3D NULL) {
> +			if (wc_index >=3D nwc)
> +				goto out;
> +
> +			fill_verbs_from_shadow_wqe(qp, &wc[wc_index],
> shadow_wqe);
> +			shadow_queue_advance_consumer(&qp->shadow_rq);
> +			wc_index++;
> +		}
> +	}
> +
> +out:
> +	return wc_index;
> +}
> +
> +int mana_ib_poll_cq(struct ib_cq *ibcq, int num_entries, struct ib_wc
> +*wc) {
> +	struct mana_ib_cq *cq =3D container_of(ibcq, struct mana_ib_cq, ibcq);
> +	struct mana_ib_dev *mdev =3D container_of(ibcq->device, struct
> mana_ib_dev, ib_dev);
> +	struct gdma_queue *queue =3D cq->queue.kmem;
> +	struct gdma_comp gdma_cqe;
> +	unsigned long flags;
> +	int num_polled =3D 0;
> +	int comp_read, i;
> +
> +	spin_lock_irqsave(&cq->cq_lock, flags);
> +	for (i =3D 0; i < num_entries; i++) {
> +		comp_read =3D mana_gd_poll_cq(queue, &gdma_cqe, 1);
> +		if (comp_read < 1)
> +			break;
> +		mana_handle_cqe(mdev, &gdma_cqe);
> +	}
> +
> +	num_polled =3D mana_process_completions(cq, num_entries, wc);
> +	spin_unlock_irqrestore(&cq->cq_lock, flags);
> +
> +	return num_polled;
> +}
> diff --git a/drivers/infiniband/hw/mana/device.c
> b/drivers/infiniband/hw/mana/device.c
> index 63e12c3..97502bc 100644
> --- a/drivers/infiniband/hw/mana/device.c
> +++ b/drivers/infiniband/hw/mana/device.c
> @@ -40,6 +40,7 @@ static const struct ib_device_ops mana_ib_dev_ops =3D {
>  	.mmap =3D mana_ib_mmap,
>  	.modify_qp =3D mana_ib_modify_qp,
>  	.modify_wq =3D mana_ib_modify_wq,
> +	.poll_cq =3D mana_ib_poll_cq,
>  	.post_recv =3D mana_ib_post_recv,
>  	.post_send =3D mana_ib_post_send,
>  	.query_device =3D mana_ib_query_device,
> diff --git a/drivers/infiniband/hw/mana/mana_ib.h
> b/drivers/infiniband/hw/mana/mana_ib.h
> index 5e4ca55..cd771af 100644
> --- a/drivers/infiniband/hw/mana/mana_ib.h
> +++ b/drivers/infiniband/hw/mana/mana_ib.h
> @@ -127,6 +127,10 @@ struct mana_ib_mr {  struct mana_ib_cq {
>  	struct ib_cq ibcq;
>  	struct mana_ib_queue queue;
> +	/* protects CQ polling */
> +	spinlock_t cq_lock;
> +	struct list_head list_send_qp;
> +	struct list_head list_recv_qp;
>  	int cqe;
>  	u32 comp_vector;
>  	mana_handle_t  cq_handle;
> @@ -169,6 +173,8 @@ struct mana_ib_qp {
>  	/* The port on the IB device, starting with 1 */
>  	u32 port;
>=20
> +	struct list_head cq_send_list;
> +	struct list_head cq_recv_list;
>  	struct shadow_queue shadow_rq;
>  	struct shadow_queue shadow_sq;
>=20
> @@ -435,6 +441,31 @@ struct rdma_send_oob {
>  	};
>  }; /* HW DATA */
>=20
> +struct mana_rdma_cqe {
> +	union {
> +		struct {
> +			u8 cqe_type;
> +			u8 data[GDMA_COMP_DATA_SIZE - 1];
> +		};
> +		struct {
> +			u32 cqe_type		: 8;
> +			u32 vendor_error	: 9;
> +			u32 reserved1		: 15;
> +			u32 sge_offset		: 5;
> +			u32 tx_wqe_offset	: 27;
> +		} ud_send;
> +		struct {
> +			u32 cqe_type		: 8;
> +			u32 reserved1		: 24;
> +			u32 msg_len;
> +			u32 src_qpn		: 24;
> +			u32 reserved2		: 8;
> +			u32 imm_data;
> +			u32 rx_wqe_offset;
> +		} ud_recv;
> +	};
> +}; /* HW DATA */
> +
>  static inline struct gdma_context *mdev_to_gc(struct mana_ib_dev *mdev) =
 {
>  	return mdev->gdma_dev->gdma_context;
> @@ -602,5 +633,6 @@ int mana_ib_post_recv(struct ib_qp *ibqp, const struc=
t
> ib_recv_wr *wr,  int mana_ib_post_send(struct ib_qp *ibqp, const struct
> ib_send_wr *wr,
>  		      const struct ib_send_wr **bad_wr);
>=20
> +int mana_ib_poll_cq(struct ib_cq *ibcq, int num_entries, struct ib_wc
> +*wc);
>  int mana_ib_arm_cq(struct ib_cq *ibcq, enum ib_cq_notify_flags flags);  =
#endif
> diff --git a/drivers/infiniband/hw/mana/qp.c b/drivers/infiniband/hw/mana=
/qp.c
> index 2528046..b05e64b 100644
> --- a/drivers/infiniband/hw/mana/qp.c
> +++ b/drivers/infiniband/hw/mana/qp.c
> @@ -600,6 +600,36 @@ destroy_queues:
>  	return err;
>  }
>=20
> +static void mana_add_qp_to_cqs(struct mana_ib_qp *qp) {
> +	struct mana_ib_cq *send_cq =3D container_of(qp->ibqp.send_cq, struct
> mana_ib_cq, ibcq);
> +	struct mana_ib_cq *recv_cq =3D container_of(qp->ibqp.recv_cq, struct
> mana_ib_cq, ibcq);
> +	unsigned long flags;
> +
> +	spin_lock_irqsave(&send_cq->cq_lock, flags);
> +	list_add_tail(&qp->cq_send_list, &send_cq->list_send_qp);
> +	spin_unlock_irqrestore(&send_cq->cq_lock, flags);
> +
> +	spin_lock_irqsave(&recv_cq->cq_lock, flags);
> +	list_add_tail(&qp->cq_recv_list, &recv_cq->list_recv_qp);
> +	spin_unlock_irqrestore(&recv_cq->cq_lock, flags); }
> +
> +static void mana_remove_qp_from_cqs(struct mana_ib_qp *qp) {
> +	struct mana_ib_cq *send_cq =3D container_of(qp->ibqp.send_cq, struct
> mana_ib_cq, ibcq);
> +	struct mana_ib_cq *recv_cq =3D container_of(qp->ibqp.recv_cq, struct
> mana_ib_cq, ibcq);
> +	unsigned long flags;
> +
> +	spin_lock_irqsave(&send_cq->cq_lock, flags);
> +	list_del(&qp->cq_send_list);
> +	spin_unlock_irqrestore(&send_cq->cq_lock, flags);
> +
> +	spin_lock_irqsave(&recv_cq->cq_lock, flags);
> +	list_del(&qp->cq_recv_list);
> +	spin_unlock_irqrestore(&recv_cq->cq_lock, flags); }
> +
>  static int mana_ib_create_ud_qp(struct ib_qp *ibqp, struct ib_pd *ibpd,
>  				struct ib_qp_init_attr *attr, struct ib_udata
> *udata)  { @@ -654,6 +684,8 @@ static int mana_ib_create_ud_qp(struct ib_=
qp
> *ibqp, struct ib_pd *ibpd,
>  	if (err)
>  		goto destroy_qp;
>=20
> +	mana_add_qp_to_cqs(qp);
> +
>  	return 0;
>=20
>  destroy_qp:
> @@ -840,6 +872,7 @@ static int mana_ib_destroy_ud_qp(struct mana_ib_qp
> *qp, struct ib_udata *udata)
>  		container_of(qp->ibqp.device, struct mana_ib_dev, ib_dev);
>  	int i;
>=20
> +	mana_remove_qp_from_cqs(qp);
>  	mana_table_remove_qp(mdev, qp);
>=20
>  	destroy_shadow_queue(&qp->shadow_rq);
> diff --git a/drivers/net/ethernet/microsoft/mana/gdma_main.c
> b/drivers/net/ethernet/microsoft/mana/gdma_main.c
> index 823f7e7..2da15d9 100644
> --- a/drivers/net/ethernet/microsoft/mana/gdma_main.c
> +++ b/drivers/net/ethernet/microsoft/mana/gdma_main.c
> @@ -1222,6 +1222,7 @@ int mana_gd_poll_cq(struct gdma_queue *cq, struct
> gdma_comp *comp, int num_cqe)
>=20
>  	return cqe_idx;
>  }
> +EXPORT_SYMBOL_NS(mana_gd_poll_cq, NET_MANA);
>=20
>  static irqreturn_t mana_gd_intr(int irq, void *arg)  {
> --
> 2.43.0


