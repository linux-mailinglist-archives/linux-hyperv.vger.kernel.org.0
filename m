Return-Path: <linux-hyperv+bounces-3795-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E339DA215C1
	for <lists+linux-hyperv@lfdr.de>; Wed, 29 Jan 2025 01:48:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1BF401888977
	for <lists+linux-hyperv@lfdr.de>; Wed, 29 Jan 2025 00:48:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9809142A9D;
	Wed, 29 Jan 2025 00:48:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="QgTvWEtZ"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azon11021098.outbound.protection.outlook.com [52.101.57.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39EB01802B;
	Wed, 29 Jan 2025 00:48:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.57.98
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738111694; cv=fail; b=SAtvpgL1wph0ng7FFJiuqDOah1ddDagYFPBzCjKhv3IdkpM/Cjlq27HrQ+k4HQw+vJgfUDZ76CNGG7YMrLAFvEsssyhb+3d5H8rxfocxJoCYfmi5eZF6t2CpXP976ug9hQr2nOX2MKfCLIYt1YHEJFMsCYzNTEteM3zSyQjiGFY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738111694; c=relaxed/simple;
	bh=oWiNcYiV1xbhpzaSpfOb5+kxfnmc5vw/cDJJ97Tl55k=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=uZhMLeEluuN5Fb96HTUD0EiBiko6cPCySQK4yKVOyENVi46fNS+es7J83bxqrrGvulLbIwoMyzlckY581+vpOwv9q6RXlWqGGvu3UMdkygnQflJ+LzfRyQXOZ9z3L2VbO428jiJuoDkypnG9Jlw9J7/nUkVxk47hrJKNFO1I/cI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com; spf=pass smtp.mailfrom=microsoft.com; dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b=QgTvWEtZ; arc=fail smtp.client-ip=52.101.57.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microsoft.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AgclMPk44C/3afHUJmIOQ4tu8ABb/9kAyb+2kfSuOwH+910xpOPh3Aa7hWvuVO3ghTsd1ecTQrdjuikDo2cxUZsFRFTq7akwpREQNLU9cCYdkHegtaQix6INMHKxNR9KoPaJURD/0gwWHZOsAmUraZ3BniUYehgv2LrR5iVyHwPNaLLHRum6GDiwCEPccyprqnt2XdwFMk87yq/mrbn5/KpwKTpiofVqKE9raCeSxYPAcKW7ifqQXrZrrwo66RTOO9ynmzShBtK459Tl/wXq+4LhHidi6IPceY1k5DL4l9zN4BV6AMMzKWkbaaafj+OC/MD57eSl+munWQkJGmiX8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gr6CVjRmCdiv1U1oOcCgBbRXK7af7lyoklaPsx1/oZo=;
 b=KIHWJm7mHj1J5FV8rpcfI2SMMc7x6VwlZxgHuyA8heGJU7kO+aMmV7F9T47G0Cs98nG9wQZJ3gMXEPx2ydOjJxfxuoI1XyNAgzzT1e6Fk/LBZRuEkQV4FXBCvsgVVYwc/orQpnWqqxVTfmd1LiDsX//vE2KsG3QFOBdZYlla6QeFPBPNbrJ+7rOtYQS9d/A05oXMD4TIoIh93yzLA6DP8biGsZIqqGUyRI1YIir/EdTYff29bYTMYqP5ZttPFJpJNcgqTStya0+8YilElzcSlni/VxqXvngj8PY079xiM55D1H+f5zRqRcPzgkAzf00MvTx0+IY2oRvspdo++91LHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gr6CVjRmCdiv1U1oOcCgBbRXK7af7lyoklaPsx1/oZo=;
 b=QgTvWEtZBTK4x+M3o3OmtDZsULEdsp9N9FkNfXzueTvJ/2sxvj0kk6RshdeW+xiGTVn5Dpf4FqbMrZnUN8d85WtcXkH0goKidj10Ck+ynHk9U5IVHHOKkF2rwZSbfOC4RaDM2ZT+OpeJbzjEmbm4tnqrwP++irrDya7QqXIKiJM=
Received: from SA6PR21MB4231.namprd21.prod.outlook.com (2603:10b6:806:412::20)
 by SA1PR21MB2052.namprd21.prod.outlook.com (2603:10b6:806:1b7::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.4; Wed, 29 Jan
 2025 00:48:09 +0000
Received: from SA6PR21MB4231.namprd21.prod.outlook.com
 ([fe80::5c62:d7c6:4531:3aff]) by SA6PR21MB4231.namprd21.prod.outlook.com
 ([fe80::5c62:d7c6:4531:3aff%5]) with mapi id 15.20.8398.014; Wed, 29 Jan 2025
 00:48:08 +0000
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
Subject: RE: [PATCH rdma-next 04/13] RDMA/mana_ib: create kernel-level CQs
Thread-Topic: [PATCH rdma-next 04/13] RDMA/mana_ib: create kernel-level CQs
Thread-Index: AQHba2CX673w+Di5EEyvbnDtOFQ6ZbMs+BTg
Date: Wed, 29 Jan 2025 00:48:08 +0000
Message-ID:
 <SA6PR21MB42314C58980568578F7DF05DCEEE2@SA6PR21MB4231.namprd21.prod.outlook.com>
References: <1737394039-28772-1-git-send-email-kotaranov@linux.microsoft.com>
 <1737394039-28772-5-git-send-email-kotaranov@linux.microsoft.com>
In-Reply-To: <1737394039-28772-5-git-send-email-kotaranov@linux.microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=355c59fa-14bf-4b57-9972-3209481aba1c;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2025-01-29T00:47:48Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Tag=10,
 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA6PR21MB4231:EE_|SA1PR21MB2052:EE_
x-ms-office365-filtering-correlation-id: 8698241f-f26e-4661-5afe-08dd3ffe99a6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|10070799003|1800799024|366016|7416014|376014|921020|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?8AL+VdrD366sv0FvVcvAYMZJtV6FYhohk853xlpOmEt8xPjFQ9xWM51n7FuZ?=
 =?us-ascii?Q?nOUjIMLMqmPpvv9H8iadSiH6uWrKpxdqveUdGpLvcldl36uxT/Kw8JUxy9Xc?=
 =?us-ascii?Q?L1P7OH3o4+2i8u6WnLLXNPc00IDn2wwwxEfSuJBPjlHhBvSoavXwfgFBOTx6?=
 =?us-ascii?Q?IJ21VjnoRUYa7x9lW/JSXgbIBmucYxVQqOKjb2ZhATMhk6WJNpYMAMprtEQ2?=
 =?us-ascii?Q?tBvrBy7tneVu4wBow7fv/fZaaA3duBF4ZpqAsUxnvvbzz4CW2gSKp77+ZeeZ?=
 =?us-ascii?Q?jkmRLIQuQypZK7FGbhUY6/BkmYOQPu8P1EelO8n0+rxV281cOIweGQheHLP9?=
 =?us-ascii?Q?dSE7kcmH69M51UrTQwFgfp5xPWFHCYkE72p4/TrgYpBGdJqAbnE2Jz4j2M6T?=
 =?us-ascii?Q?caeUlsGwlaF0NP9q9rohxtq0UUfGgc8hwK6KbsltEz4JeSqE/KpgfViSje87?=
 =?us-ascii?Q?UvHV8BPANC/3KRMWo77FL/Q4yxtwkIAbryar1YCKD3SoQ4areBmYCdY39wa7?=
 =?us-ascii?Q?06ZhdsgPJ2wg2j9E+DFAgaWtHxBfXXGOpeLGafU6tEsuSr8GYx22l4Kvb8kW?=
 =?us-ascii?Q?1wTwWnOrykby3tlfhQFZiU2ty4ZSPTNOLPXcC0/GGgmnpZg9+qt4W4xXHHK1?=
 =?us-ascii?Q?qQDIphbPXhI3qWjfNvb3UXEbncQzfL4IkeeCgO5IUmCL6FrTfDx7VI7osbj1?=
 =?us-ascii?Q?q9K32Hy//HEDrLMuqzgev+gOOAowdh649sNVnnmGFIsEf7pMnPu7PZkZ3pXt?=
 =?us-ascii?Q?V8qhFdSD/KOYUhsiT9xxS+WX/ukz92Zi0goXS/qaYfY1OAxlQVRPg+qKf+SX?=
 =?us-ascii?Q?pHveUsS4o2E05c5ruzaJmPp6wGL0cjRZcRvAr7hm67Ch61Tzy6bPmewmP2Dz?=
 =?us-ascii?Q?RJP7KBHhcwHyqKA4xWryd6fdFhE9Po9MVKDUeMPeienSdJdURC1bye3P4WaD?=
 =?us-ascii?Q?BhegPrBOwg8JUmaD+OUorOMOB9cGZtQSUyQJtb/eyVKmRefQFLZgwvEaCSTs?=
 =?us-ascii?Q?95DDiAamImAEQUcPveuQVHlfhGWKO6Dp7m6vud+2uIZuxsr2COC7pzqag2yA?=
 =?us-ascii?Q?va0AMoWDHxIk7uhNaYTHgxl4PkIiOUy87viWhNc2EybwewLLOR1KTQKY8r6J?=
 =?us-ascii?Q?nsVZ90y6dptkvlOsK5yxw4ntxtkeA9+IV3xVIWVLVvxAug3POz7JeDAKiXn8?=
 =?us-ascii?Q?KzbrsmnOGPWdhVgK9pXnD1a8JCkMFCCwDMAHD+jVJbIuXemhzuaGYpvlGTAB?=
 =?us-ascii?Q?9MFdUmm1VBSVZjFJITK9rRUwZyCusObp2VFCyOrB8JtovwyxU3JKmDLGe21A?=
 =?us-ascii?Q?W9ww62c3YKqti+CTgwwJtJNiH1PcpWVSZbukd3lmfSf1tGu7jh1fyX1BLj9H?=
 =?us-ascii?Q?Sv3t6cxOyH8hBozpenxO7gjQPZvcORU0h2HtXz8l1pJ1OsQpF3i1zAf/ZPZE?=
 =?us-ascii?Q?ojqTS9cJUeIq+9RhYY0BbrZjZtSgO9nG6bQxNhkSYitr+EDo4ybbTQ=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA6PR21MB4231.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(1800799024)(366016)(7416014)(376014)(921020)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?hsX6rfKL/A4PW6Djyt0rci5+zCeGcHSe48clPtqUzr31W/voY3pxWM8kzwaE?=
 =?us-ascii?Q?jwuxJ4VS0EvOGpVPXI/FI9zCR5JpZa5oK5HFIuwjfW+jz+kqAqj/V/6gpXtQ?=
 =?us-ascii?Q?HF5CqR1tE4CNpU9uXLpyU2G1femCT60ukvN6x3SaYSQYTCEcOMMZUJ1b11G7?=
 =?us-ascii?Q?yOjx6V454KMfTbjlUuvTUBBZRwDeFhxOpLrrxM0znN1DbxIA1gU5dqzXM7Xr?=
 =?us-ascii?Q?1TIEFlLGg98Z06sk1i+A0zhtIdJVZWT2rqOD3nWAAbqZT98Y2C9Tb1nOkTIA?=
 =?us-ascii?Q?0tszbCPOsOFV7K1bg2NDoU5afdGVELYjA2A3WOUIdywCdQVllROtF9pfaOsP?=
 =?us-ascii?Q?snlfge2B5DnH++Wk8cZvE+uTknWnmPoBXPaVORfL9+dWv9RdzR5zRI8Zf2RU?=
 =?us-ascii?Q?Q91+LX3PuS8+miodvXi3t6o26WYfvbjApLdyoeBDEez2wMIuQ4yeWigQLnN4?=
 =?us-ascii?Q?qGho0lpMM3n2Apvxqq9aKB2Zh1TPD6xKAS6zHqT8mc50PPEl9TwQhNNk+XS8?=
 =?us-ascii?Q?Sswod/vrHpCzrAoWUS+/gjWBJ8EKfz5l8l8obXHKChgrMBWSIJqUNI1cjpd4?=
 =?us-ascii?Q?X/XM0bwta/iu8jBQuBtIS8XtuqwuiEQkltDzJwwAK83kdMINFrBtDSAXdaT5?=
 =?us-ascii?Q?xjckDctfYa28GgVGaKfqiCkOb+MS8pB98W43XZPg07j7RkQB/TxuaBLopSeL?=
 =?us-ascii?Q?Z1s/+6E/BvfWhJfsR31v35jCKgwnDshHjC7jQ9QK+QIfdtpnVWDl3Grs8CvT?=
 =?us-ascii?Q?M8Hb9Ryw/KsbQQFxrXaYjbioQXKVU2uSyHmGSMSMA0l/X9xWmi4QLXBfT9uH?=
 =?us-ascii?Q?5Ny3eDXuLfy3jrGJowQK2Cy9yfWiG6FaKK+/NeJ/oeKBbX08o8Kym3cEoCu6?=
 =?us-ascii?Q?1jPCDZsaSsRcVJdwamDoA4i03wPwVbueczUOEpV22fiato0BBWc3LkDYuZk8?=
 =?us-ascii?Q?9FQrj1GpHTtL4RB/mVgtRIeRTdxvhgr+FeW/Cit0DNW8KKCyy/bT4Hk5+9PN?=
 =?us-ascii?Q?kETTecRfTZ1ho5k9Je4l7WdHi6SPofo7o3LYox8SKfsEI3nBSbADlvPs0aZK?=
 =?us-ascii?Q?PreGydnOStY19TOsJW+6i7bx0zoTV1nsjpwIaC2ihv9DlHGy+E6mtzMQleQ7?=
 =?us-ascii?Q?vdL+XiwpZQMy/U3GWlXOrVPLc6CNN5VjblzIr3ibzQDKb2s3lPMaz6McNWdf?=
 =?us-ascii?Q?dKoFX7tLZr7EhG0SACdNrwjW7ibhDB9gRWpCorJavjiDFvu3z4Twmcab4hBl?=
 =?us-ascii?Q?Hu+fODu45oBaEcUi3dNvZmB1Hp7segXQ3ZSF0dlr1KINuBuFgYgdbwlm6kSE?=
 =?us-ascii?Q?STMmBZ5YsDq7BErxi8g2uerVD+Qtru8qfB7pdoK36eQGQ5Mw/pTd7k4UWItB?=
 =?us-ascii?Q?NApjTZkk/M/2V1gQCFnZw+ZB2/XI6rz6P1W4gLTytCLPAY8W4aN6kVrezOrG?=
 =?us-ascii?Q?wVoWQUsYTImCZIXOUydY7p1GMTjz9L29z/CvoGcMas8MMwKRel6r2KinBcew?=
 =?us-ascii?Q?uCT0J5k+6N0bDnmX1Czd4sdTg5uEorKn1g1/aNr6QS1QFTRMj8DZdFqt6gVw?=
 =?us-ascii?Q?vRCFcX8q2lSSgB+ZXqFj13X1PuGAs/ttXusDSUTPesPkDYQ/iLPdgUcK5YDW?=
 =?us-ascii?Q?zcV4h17FFgfsBPhE6EKnyAOBLXhp1CJ/UK9HobVm0xDE?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 8698241f-f26e-4661-5afe-08dd3ffe99a6
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jan 2025 00:48:08.8041
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lmteia6gPaF7VOiYLzpdr/tfRvdeFUO3gxY5W9UgZ+Rz0tQAbzvvtmk1oAALLp0QUKtcYbyaOIqPPZm5ERIeGA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR21MB2052

> Subject: [PATCH rdma-next 04/13] RDMA/mana_ib: create kernel-level CQs
>=20
> From: Konstantin Taranov <kotaranov@microsoft.com>
>=20
> Implement creation of CQs for the kernel.
>=20
> Signed-off-by: Konstantin Taranov <kotaranov@microsoft.com>
> Reviewed-by: Shiraz Saleem <shirazsaleem@microsoft.com>

Reviewed-by: Long Li <longli@microsoft.com>

> ---
>  drivers/infiniband/hw/mana/cq.c | 80 +++++++++++++++++++++------------
>  1 file changed, 52 insertions(+), 28 deletions(-)
>=20
> diff --git a/drivers/infiniband/hw/mana/cq.c
> b/drivers/infiniband/hw/mana/cq.c index f04a679..d26d82d 100644
> --- a/drivers/infiniband/hw/mana/cq.c
> +++ b/drivers/infiniband/hw/mana/cq.c
> @@ -15,42 +15,57 @@ int mana_ib_create_cq(struct ib_cq *ibcq, const
> struct ib_cq_init_attr *attr,
>  	struct ib_device *ibdev =3D ibcq->device;
>  	struct mana_ib_create_cq ucmd =3D {};
>  	struct mana_ib_dev *mdev;
> +	struct gdma_context *gc;
>  	bool is_rnic_cq;
>  	u32 doorbell;
> +	u32 buf_size;
>  	int err;
>=20
>  	mdev =3D container_of(ibdev, struct mana_ib_dev, ib_dev);
> +	gc =3D mdev_to_gc(mdev);
>=20
>  	cq->comp_vector =3D attr->comp_vector % ibdev->num_comp_vectors;
>  	cq->cq_handle =3D INVALID_MANA_HANDLE;
>=20
> -	if (udata->inlen < offsetof(struct mana_ib_create_cq, flags))
> -		return -EINVAL;
> +	if (udata) {
> +		if (udata->inlen < offsetof(struct mana_ib_create_cq, flags))
> +			return -EINVAL;
>=20
> -	err =3D ib_copy_from_udata(&ucmd, udata, min(sizeof(ucmd), udata-
> >inlen));
> -	if (err) {
> -		ibdev_dbg(ibdev,
> -			  "Failed to copy from udata for create cq, %d\n", err);
> -		return err;
> -	}
> +		err =3D ib_copy_from_udata(&ucmd, udata, min(sizeof(ucmd),
> udata->inlen));
> +		if (err) {
> +			ibdev_dbg(ibdev, "Failed to copy from udata for create
> cq, %d\n", err);
> +			return err;
> +		}
>=20
> -	is_rnic_cq =3D !!(ucmd.flags & MANA_IB_CREATE_RNIC_CQ);
> +		is_rnic_cq =3D !!(ucmd.flags & MANA_IB_CREATE_RNIC_CQ);
>=20
> -	if (!is_rnic_cq && attr->cqe > mdev->adapter_caps.max_qp_wr) {
> -		ibdev_dbg(ibdev, "CQE %d exceeding limit\n", attr->cqe);
> -		return -EINVAL;
> -	}
> +		if (!is_rnic_cq && attr->cqe > mdev-
> >adapter_caps.max_qp_wr) {
> +			ibdev_dbg(ibdev, "CQE %d exceeding limit\n", attr-
> >cqe);
> +			return -EINVAL;
> +		}
>=20
> -	cq->cqe =3D attr->cqe;
> -	err =3D mana_ib_create_queue(mdev, ucmd.buf_addr, cq->cqe *
> COMP_ENTRY_SIZE, &cq->queue);
> -	if (err) {
> -		ibdev_dbg(ibdev, "Failed to create queue for create cq, %d\n",
> err);
> -		return err;
> -	}
> +		cq->cqe =3D attr->cqe;
> +		err =3D mana_ib_create_queue(mdev, ucmd.buf_addr, cq->cqe *
> COMP_ENTRY_SIZE,
> +					   &cq->queue);
> +		if (err) {
> +			ibdev_dbg(ibdev, "Failed to create queue for create cq,
> %d\n", err);
> +			return err;
> +		}
>=20
> -	mana_ucontext =3D rdma_udata_to_drv_context(udata, struct
> mana_ib_ucontext,
> -						  ibucontext);
> -	doorbell =3D mana_ucontext->doorbell;
> +		mana_ucontext =3D rdma_udata_to_drv_context(udata, struct
> mana_ib_ucontext,
> +							  ibucontext);
> +		doorbell =3D mana_ucontext->doorbell;
> +	} else {
> +		is_rnic_cq =3D true;
> +		buf_size =3D MANA_PAGE_ALIGN(roundup_pow_of_two(attr-
> >cqe * COMP_ENTRY_SIZE));
> +		cq->cqe =3D buf_size / COMP_ENTRY_SIZE;
> +		err =3D mana_ib_create_kernel_queue(mdev, buf_size,
> GDMA_CQ, &cq->queue);
> +		if (err) {
> +			ibdev_dbg(ibdev, "Failed to create kernel queue for
> create cq, %d\n", err);
> +			return err;
> +		}
> +		doorbell =3D gc->mana_ib.doorbell;
> +	}
>=20
>  	if (is_rnic_cq) {
>  		err =3D mana_ib_gd_create_cq(mdev, cq, doorbell); @@ -66,11
> +81,13 @@ int mana_ib_create_cq(struct ib_cq *ibcq, const struct
> ib_cq_init_attr *attr,
>  		}
>  	}
>=20
> -	resp.cqid =3D cq->queue.id;
> -	err =3D ib_copy_to_udata(udata, &resp, min(sizeof(resp), udata-
> >outlen));
> -	if (err) {
> -		ibdev_dbg(&mdev->ib_dev, "Failed to copy to udata, %d\n",
> err);
> -		goto err_remove_cq_cb;
> +	if (udata) {
> +		resp.cqid =3D cq->queue.id;
> +		err =3D ib_copy_to_udata(udata, &resp, min(sizeof(resp),
> udata->outlen));
> +		if (err) {
> +			ibdev_dbg(&mdev->ib_dev, "Failed to copy to udata,
> %d\n", err);
> +			goto err_remove_cq_cb;
> +		}
>  	}
>=20
>  	return 0;
> @@ -122,7 +139,10 @@ int mana_ib_install_cq_cb(struct mana_ib_dev
> *mdev, struct mana_ib_cq *cq)
>  		return -EINVAL;
>  	/* Create CQ table entry */
>  	WARN_ON(gc->cq_table[cq->queue.id]);
> -	gdma_cq =3D kzalloc(sizeof(*gdma_cq), GFP_KERNEL);
> +	if (cq->queue.kmem)
> +		gdma_cq =3D cq->queue.kmem;
> +	else
> +		gdma_cq =3D kzalloc(sizeof(*gdma_cq), GFP_KERNEL);
>  	if (!gdma_cq)
>  		return -ENOMEM;
>=20
> @@ -141,6 +161,10 @@ void mana_ib_remove_cq_cb(struct mana_ib_dev
> *mdev, struct mana_ib_cq *cq)
>  	if (cq->queue.id >=3D gc->max_num_cqs || cq->queue.id =3D=3D
> INVALID_QUEUE_ID)
>  		return;
>=20
> +	if (cq->queue.kmem)
> +	/* Then it will be cleaned and removed by the mana */
> +		return;
> +
>  	kfree(gc->cq_table[cq->queue.id]);
>  	gc->cq_table[cq->queue.id] =3D NULL;
>  }
> --
> 2.43.0


