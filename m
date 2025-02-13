Return-Path: <linux-hyperv+bounces-3938-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 18D97A33570
	for <lists+linux-hyperv@lfdr.de>; Thu, 13 Feb 2025 03:20:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 750651889C43
	for <lists+linux-hyperv@lfdr.de>; Thu, 13 Feb 2025 02:20:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F7711F8EEF;
	Thu, 13 Feb 2025 02:20:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="Mm2wAI7n"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2116.outbound.protection.outlook.com [40.107.93.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0A4C7082D;
	Thu, 13 Feb 2025 02:20:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.116
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739413228; cv=fail; b=Q0qOXEOikaynMqTTsWNgeI+Go6OUaLHzOeB2N8KKMM7HIiR73gsaW97rstkixDOiUJoDX8xS7DWNyN8c2jCxa/1zGfBOFxASk/ixJJ08VFeJrhiN7X6yE1qoiMauwNBwMQdTcLeIyZquiYVnrVqusoNeotrGv+CRCfl2hylWRG0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739413228; c=relaxed/simple;
	bh=4I8dPKQ/9BSeBJeq+CJ5G3Pthk/mV4Q/8wNPxjO/VGU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=e49OONCEQQcHXHzQwx866eGVOmMc8OEq8lkw8L+pJi//8nzDmK2DFhVXR5yLWg2gBqS9Ycbiez1WLitfZpdFioHnx18c0twvPbGs9RNoXWnxIBUQwdKsNg9XhbBBtoW6KiezXXUZiiU0nYf36Q0GASymg2889dvWj8QZKH3A+Lg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com; spf=pass smtp.mailfrom=microsoft.com; dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b=Mm2wAI7n; arc=fail smtp.client-ip=40.107.93.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microsoft.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QRLN8EIW0Bfk4zsodcno2VzWEnN9FfJgGBECyEqm/b/chZ1TaYAo4rlQVxqFIeJw0CFX8SSY3RJHsC/pPpjvmiEbflf7ipyQpJERG7BeJBlSEo1nxkjVLio8MKD6eqJyBYP2trZwAI+PoC5F8GZArxWDEgk57ZbAFKOsMDpMkVnXZdf+yD0bRvX72OU6cENTTlwa1kkbkxPyW03oqaNNt20IaVYszwaq9MMCXyqQuj4xWLKsvt7PvJQYhb4xWQOurufr5+fwrgjWvZQTpgw1bd/ygynotWKA8pro4PM4tbkOdkDrzs7Lj4gstZqQ8NW6hV75h4yN1OvXVhUYCDqCoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4I8dPKQ/9BSeBJeq+CJ5G3Pthk/mV4Q/8wNPxjO/VGU=;
 b=aZMOQxV8KC0c4wrhwcYYigRxrpOo9W1xF9OTusRJ82R1VfQBW353b/HzjTZE7xbHhmZmLQM9XPZ9KI/+tVA9nlPg5xzZffrteLgSade4P8nn79dRSR+RgNoFrLfrWZXArcCyDYgYvyyBd9wLuaiekvtuBKjzZApsAISPSKgg9vjKpY8CMnRuUhln/Cr4EeRR+lMmsMxAsHFO085fq/Uh32JurMI/eeJqVhuDdN8iE66YvbozsiSlQIDS1qNCuelMQry+/95rxz5FhY/iVSvYz7eLeaQX8OEFH/rxpRug8AtJ602hQYmcUDPP9csm8x+UZ6o6cXLvbShmX58X5Fwuyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4I8dPKQ/9BSeBJeq+CJ5G3Pthk/mV4Q/8wNPxjO/VGU=;
 b=Mm2wAI7nBXKb/aGXsOXdTB/GcM7edAS42Ptb40qR6GXRc/2UUrHq4xBUzWoPfxCFhVpMnNDdYe3qrI1kgO+SbKcBnkQfgjBEHP+a7leDqFAnIs7Q7gKHkpf63K82mTDAHTgwrKtMFN6QFH/21tx5o0dw/MlFpL3qCgY56jwty0M=
Received: from SA6PR21MB4231.namprd21.prod.outlook.com (2603:10b6:806:412::20)
 by SA6PR21MB4230.namprd21.prod.outlook.com (2603:10b6:806:415::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.5; Thu, 13 Feb
 2025 02:20:23 +0000
Received: from SA6PR21MB4231.namprd21.prod.outlook.com
 ([fe80::5c62:d7c6:4531:3aff]) by SA6PR21MB4231.namprd21.prod.outlook.com
 ([fe80::5c62:d7c6:4531:3aff%4]) with mapi id 15.20.8466.004; Thu, 13 Feb 2025
 02:20:23 +0000
From: Long Li <longli@microsoft.com>
To: Leon Romanovsky <leon@kernel.org>, "longli@linuxonhyperv.com"
	<longli@linuxonhyperv.com>, Stephen Hemminger <stephen@networkplumber.org>
CC: Jason Gunthorpe <jgg@ziepe.ca>, Ajay Sharma <sharmaajay@microsoft.com>,
	Konstantin Taranov <kotaranov@microsoft.com>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	"linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>
Subject: RE: [EXTERNAL] Re: [Patch v2 0/3] IB/core: Fix GID cache for bonded
 net devices
Thread-Topic: [EXTERNAL] Re: [Patch v2 0/3] IB/core: Fix GID cache for bonded
 net devices
Thread-Index: AQHbetdgKRp079ZsDUmF8noRMO9zmbNEcZXw
Date: Thu, 13 Feb 2025 02:20:23 +0000
Message-ID:
 <SA6PR21MB42311935C1955034D9EDFF5ECEFF2@SA6PR21MB4231.namprd21.prod.outlook.com>
References: <1738964178-18836-1-git-send-email-longli@linuxonhyperv.com>
 <20250209094528.GB17863@unreal>
In-Reply-To: <20250209094528.GB17863@unreal>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=731106bf-25e9-4181-a21e-4b0f43a64082;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2025-02-13T01:07:21Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Tag=10,
 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA6PR21MB4231:EE_|SA6PR21MB4230:EE_
x-ms-office365-filtering-correlation-id: 38895db0-def0-4925-00d5-08dd4bd4f8f7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|376014|10070799003|7416014|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?niIhuW5fCXa+9PBu28Ajo7HVVwGGmSV0kadXZ8MbAagyCcFMNhdEhJjfAKUg?=
 =?us-ascii?Q?ehP7D8O8Xz3mqEPsZHxF2pwIZ/DPPK3HlW34bzG+qOBJZ4WPLtBy1qI8Pwoj?=
 =?us-ascii?Q?2ZY8nAz6WIcGWT6qeDlZZYEowHLLSFusuA/sqN6ilExaOy3X8UuoaJK1mbVb?=
 =?us-ascii?Q?XAEadyRyQizILPFqyMNNpq8xXwv7+Pl+lJCxWvWkgr5NgvBSFC19sbrpreoD?=
 =?us-ascii?Q?+zElCUU3FlqYkTic5d5QK2Yu7I60RsuiRHz9NUITUw/Mu3OzozGhkqakpRep?=
 =?us-ascii?Q?ZAVTD4dmlxsDATjd7Qaf5nf+jnRTFczGWFaP3Rk0YIW0L7gniRE/cso7jTq9?=
 =?us-ascii?Q?iA71Sg3m7TqKUrySBmbM7QIoRS1CZmrkLiog0ZrupCAk6yitAVqftaNhDc+z?=
 =?us-ascii?Q?NygjfDsYmbkxqr6wYj3VcxvuQ/yBkgDgEq/kx+AWZn3dZi0mMxiJZF7v31WX?=
 =?us-ascii?Q?C74+RR6JnDtqWlcteIesZJr52q62877Dxm7NOlgvzFWnLxsut28UKAXI4IXL?=
 =?us-ascii?Q?4DcEqS6OaIywNKLNIf9qI1AnWMW37b98wq5OCjuLMW7eaTIjlHZ505oJ4iQz?=
 =?us-ascii?Q?vQOenFxYrBzX5IQFsOGxbAGRJf+6wjeJTWWZI0aySeCYN+2snzmSABkryTfx?=
 =?us-ascii?Q?j/YOjwJaabktd3ydRkVD4O7CszFNPzDtHaXvH41OwQr1bOOVkJ7W2nXAopXG?=
 =?us-ascii?Q?cKTo/tOG4tmSnsrlddr5/K8SvGOcLbXJ7ww7YFekX9fX8wfBr4QH87Y5SSlA?=
 =?us-ascii?Q?bVAujBbrxLUVQLIi42fOY3Yj5R20fOh9hPrxeuRexJmg3HvAy1/Sw2riVwC7?=
 =?us-ascii?Q?TtsBHgrS2wvYSZbmq4O0aTGXjsnza7Y7XGMl75hEMIUIpEiDpRpLBxdZpxB0?=
 =?us-ascii?Q?/wj19E3Yyn9STAZdlQR7sJCQgkAtKiulTjanaduJxfUi73p3GG8uw3JLUQTa?=
 =?us-ascii?Q?ClVN0oNuBzgaCtOJekwKGmdaFSdAwqTjYFhD44wbkmhKg7BFn4I/ABdPO6x2?=
 =?us-ascii?Q?dG8TDL2nqovYvy9BEKTymAuPO4z7/QDS1jsBq1NTN1wtH974+LFjS+Ny1y82?=
 =?us-ascii?Q?3qa/MPoqZQk97ccsgugE8x+CYMl6Zw4CtZGj0Lo7Xe20VZ0GxCEu9kkAQpmM?=
 =?us-ascii?Q?10rC61WfVB1IlM1b94GNqGCroft7gnYlJhpr5ZW7NbLEciY8Y3ZWHL4JBqal?=
 =?us-ascii?Q?HE89AiVC6WIJrhsAtSrfSDdC/dSl8FnWXHJRYmexMKfFD1KwvJUmG2eZKwou?=
 =?us-ascii?Q?naY//+Lq3HqY+SOfgeu4gW/BOE4AU/SY9ZhTPNudGrQcU0zPL2Vp17ZR+yHo?=
 =?us-ascii?Q?EX1OQbWAfmMFgfgakQE/auO4Dj+8dDZB3STEDbxU5CYAYm6U6rMAE8Yu1QFF?=
 =?us-ascii?Q?Dx+HTYUoK860ERZ1ZPfaxmZTWID16U6nfKWPAoIDPUVBZNWZKIln0bxC55nt?=
 =?us-ascii?Q?I2RRQ8CJ6cA65QSi7KHOS74clEy4XLTe?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA6PR21MB4231.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(10070799003)(7416014)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?ZL1+bfdlbak55ON3dw9Xi3WD7QNuko+U8FzGYrVJSMpwvMx8NlAm/zVB3cXz?=
 =?us-ascii?Q?K+ZFxtgvbBjWuhgN/Wh5x0L+FWvHe/NXtBXph7h7ao5OUAj9anxoeDfTUiZW?=
 =?us-ascii?Q?PX4hm4N/Yhm1E6FHXvASVmgveO/5hEvAIufSGdSYwnxDsH8yuGxizUR87Ylf?=
 =?us-ascii?Q?PYGEHLUINDxnXyBfzxQ8HQrpYJOX/WT24/aKY+a5iupTJpjiVRQGnKN7YtB9?=
 =?us-ascii?Q?6wbZR2x0wM1yekw0aoBtitmj46rKwtGHpDahiDhrxbaf2wlyuwTa/cNPNCgH?=
 =?us-ascii?Q?4TKZfUnDK4HG6k2CA/SPuzTdsD/IEAXkC17wCKQWCG5FJP6/T80KBEXF2UdL?=
 =?us-ascii?Q?ai05Lntc3AaSh8grkaOuS9IoPl8cZEOtuxJ4bUCy9NoMHkh+Yq6Syp1P+qCF?=
 =?us-ascii?Q?xkb8uRhOOH4iPz5TgR1gdHelPmeiBsW4AMl5UgfqVFhQ79tyf1HFqTMbmM5Q?=
 =?us-ascii?Q?q6H+nOWE9NPd7nuEnPg65WoJnjCOlnnuPbP6Ink3d/b7nxSsTmf31ShLcxR2?=
 =?us-ascii?Q?dQIEK4/BvJBDEyOGiZjyvVHlVelHNuLSR/Ofjy48J5hKW8ixEq/rPtcOr8hP?=
 =?us-ascii?Q?mYLQe8FlVdMon82zQgYgux19zTa3Gkxn1K21PIWjTzvD7iPUOIx9z+p2rk0q?=
 =?us-ascii?Q?gkJH9s8rnuC5Q69/GQD0/TwGf/xVGF09admk7OSu0PfrcZHF42adtSsad5P6?=
 =?us-ascii?Q?S41FF5TOyMMWT6qXAgX7C8VapCexLS/SCePWoGQRFW9FLYdg6tQ/RXYrrM8/?=
 =?us-ascii?Q?Usrz4QUSfhf20YaZFec+AjG8+cY/QqdGZUP+QSxWcfIuNbzYq5Sa9xEfzWjT?=
 =?us-ascii?Q?m0AlVxRlw+oZ2OznBXM+TukkvtfNOff/3ZfTk+5KMRFYpHXWRWThYnpmRz4m?=
 =?us-ascii?Q?pV2ck5Y4vEuZ9Hg/2FR4ZCNAKWQSqueTNd+xePDo9Ab9OHaBxh7u+p+QeFaA?=
 =?us-ascii?Q?dsxo/OQnHXotWrI5Zr3rlo5MaKgwtHgHMVzBEvktW1thRhqeGBHYEZ4Z0rzl?=
 =?us-ascii?Q?0HO4D+AS5GwXV1nTWH4CTKm4LqKEjnCIU2xNNhvOcm9h6qI6zBJlXhL32OZ8?=
 =?us-ascii?Q?N5zkvVGaoY/LnjvNykBGX+KDFN7lk//xbIdu3hMl2BnyapdwWE1dsesdNfvg?=
 =?us-ascii?Q?0gUb/y5gAZUrg1oLILrRbQG5wbKfYg8k6XT+fRg+IZRDNBlqHHHzA0+MIJqT?=
 =?us-ascii?Q?gyrv0vgOr3xh7ZPqPnHIXdY1KZpEwPUZPuEkbrG1DCUt++vTAEzitRe7xyPp?=
 =?us-ascii?Q?uf128GxJMG6KGgtIq0Az17SoSdW8N8BYsX3lNyQB2fgnx20grcSmJFxp4tmL?=
 =?us-ascii?Q?zBAbMS9xfvstB/MFGqDv8kig1hYKSw/oMkvKK4QMr77wObeX42nHopzssTnf?=
 =?us-ascii?Q?d2zgNgvqnCDpdt3lIWIM5S2foI5ZPRHccF7FDk2TWLn1I4Y/xuzY/Ej47O9G?=
 =?us-ascii?Q?f9lq9QwRKKObfWVWFuwGw82hnJJqdkvLEWlj7kbZ3x+CY5olg0st7bqxokAo?=
 =?us-ascii?Q?plMHf4eJ12W1R7CyjMeqOr31sjmt/ETVRRYOtWo6ahBRSaG3Q+DMCVkCH7Hm?=
 =?us-ascii?Q?jXcCLJ/Xxs1laHwRPUwXyHtiIhrZSY9fJhECCPyJ2gQXtSuYfXTPs7scriLB?=
 =?us-ascii?Q?2z41liMozrtfBav9EnI3B1dz7CvXGCBcAICWOGsDO84i?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 38895db0-def0-4925-00d5-08dd4bd4f8f7
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Feb 2025 02:20:23.8270
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: K7BHyYbPxGicfQl9y0iLVTZ1FlliG/7dmWSPmzL6gI4qS+7uAexs+jm8Zi7eUjd2qu/zHg8UlhAE4M3ygB3rAA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA6PR21MB4230

> Subject: [EXTERNAL] Re: [Patch v2 0/3] IB/core: Fix GID cache for bonded =
net
> devices
>=20
> On Fri, Feb 07, 2025 at 01:36:15PM -0800, longli@linuxonhyperv.com wrote:
> > From: Long Li <longli@microsoft.com>
> >
> > When populating GID cache for net devices in a bonded setup, it should
> > use the master device's address whenever applicable.
> >
> > The current code has some incorrect behaviors when dealing with bonded
> devices:
> > 1. It adds IP of bonded slave to the GID cache when the device is
> > already bonded 2. It adds IP of bonded slave to the GID cache when the
> > device becomes bonded (via NETDEV_CHANGEUPPER notifier) 3. When a
> bonded slave device is unbonded, it doesn't add its IP to the default tab=
le in GID
> cache.
>=20
> I took a look at the patches and would like to see the reasoning why curr=
ent
> behaviour is incorrect and need to be changed. In addition, there is a ne=
ed to add
> examples of what is "broken" now and will start to work after the fixes.
>=20
> Thanks


Thanks for looking. I will work on another set of patches based on feedback=
 from:
https://lore.kernel.org/lkml/20250211163735.18d0fd02@hermes.local/

I have some questions on the RDMA GID cache code determining GID cache base=
d on bonded device states. Please see following.

For an IB device, the RDMA GID cache code (rdma_roce_rescan_device() in dri=
vers/infiniband/core/roce_gid_mgmt.c) looks at the following devices for it=
s default GIDs:
1. This IB device if it is not a bonded slave (if this IB device is a slave=
 but not bonded, it will be used for default GIDs)
2. This IB device's bonded master devices
Please see is_ndev_for_default_gid_filter() as its filtering function

And for those devices for this IB device's non-default GIDs:
1. An upper device to this IB device that is not bonded
2. An upper device to this IB device that is bonded to this IB device, and =
this IB device is the current active bonded slave
3. This IB device if it's not a VLAN type
See is_eth_port_of_netdev_filter() as its filtering function

To summarize, the GID caching behavior for an IB device which is also a sla=
ve device, looks like below:
1. It seems all upper devices (bonded or not) to this IB device will be use=
d in the GID cache, but only its bonding master is used for the default GID=
 cache
2. The IB device will not be used in default GID cache if it's bonded
3. The IB device will always be used in non-default GID caches. (assuming i=
t's not VLAN)

My understanding is that the default GID cache will look for bonded master =
when checking on a slave device and its upper devices. The non-default GID =
cache just takes this IB device and all its upper devices.

Why the default GID cache needs to check bonded devices?

Thanks,
Long

