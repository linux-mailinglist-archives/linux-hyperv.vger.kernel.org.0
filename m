Return-Path: <linux-hyperv+bounces-6202-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CE550B02CD3
	for <lists+linux-hyperv@lfdr.de>; Sat, 12 Jul 2025 22:00:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AE1BC7A3CFA
	for <lists+linux-hyperv@lfdr.de>; Sat, 12 Jul 2025 19:59:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9EE42750FB;
	Sat, 12 Jul 2025 20:00:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="Hqaoy4YL"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11022075.outbound.protection.outlook.com [40.93.195.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E57BE1F3FC6;
	Sat, 12 Jul 2025 20:00:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752350441; cv=fail; b=fhxQ0+3hfUn8ce5mrrhp2PQiEVF/lCQYnFH3+6RHITNC3GBj+BhhPifPNlf0ntrnuRrAQQRJN8qiWOQWRw4XLCUiprlp/ij3zS3gIKQ6y67Tw4Yc0Qmh/ckwWMBTLK9wcUB5vjKXjznH6iB8VLupQjzAO4iAjClvVvtJGa9oRrk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752350441; c=relaxed/simple;
	bh=3SzJ9dkx5ow4Cict7iO+RjrYpXVGTOw2XlFf2KbpGy8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=SjtkxEgqDMZCwPhK/gVMpr+9nK3hEHIZFcMpfhsGVbCuLirr5wPHw+Aac53g2NI39mzb3qyojl4t2t0eljP/n41UzCyGsW8tttM1V1K0Mp97O1Nl5p0nFnuGwPlAl1Ml7+KUCXM4JAuXO6Fpdw2LUS4kUn7Q8At51BdPgtD9gRY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com; spf=pass smtp.mailfrom=microsoft.com; dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b=Hqaoy4YL; arc=fail smtp.client-ip=40.93.195.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microsoft.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BRjy684lvw55dAAKIk2fzAFKsdazLy0ZQwfHY+DLnenCtIGmzQNsQUjZQGKJo1alfT7P6t6UUVw6P1O/oU4A2E2piLH7Q89rnuQm4In1Fpke2ax3EFegcNT5G47ITjy4kipoQ32cxhvMEDY+B16KM+nwd3uPnFyd9EdjqtwPtkari9OFKCiqve2E4O6oKZSZkVgEaxj71NlzPy9aAZ0bUJpuaPMoj3TQq3YHvqqmrJifu5k2Wv4UEwZ1VtNGXqk/LmiX0KHdp1hM6EllJeh/bV6AHHRaxJwHdKvC+6esO7EoftaMGBvi6mjom+lr9zfvNQezUZAbprmV3FTsT5hzKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FeBDHpLOdfgzPAJO4Gkc8Fbap3tYMhr/HOdUedBeAzg=;
 b=apabe6ksKfbL3me43qZewue9MMt7XkqdeeZV3debHxICu2GTMkEpLaNE5DM56CYtCbishIihdGFW+Ak0kSTTg7LWW/Iz22PxP0Q4/aIUV8qffQQIHVecSNzyl+BPq2eOZWBXuVk5XyELPksUKVOLKZA+JeXd3Da79QuguW9vE2Gwd3QGQdsdbX4HoVM8SIElxpSNqew260fG8yW1WR+3hCGXrLI405WCjPKBjr90jBofhdr7i1ApBo7/EsKbMjAVBXsYZs9gCxSc7PqEcYK2ckZbAmf+1pHmB6H+wQWNSia9y7oLRExOtsE/ptH9n4kcWHFQVwBLDQXb4TKOywat1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FeBDHpLOdfgzPAJO4Gkc8Fbap3tYMhr/HOdUedBeAzg=;
 b=Hqaoy4YLIjZzBsqJ0ZpdC/tmnJvq0Yihkx2S+rGaiVGADUPrODDD5KrKsjDpL7IFRBBiLsnWPXckqhg4lCbwB+JzoBGUS1Zzt6JHE+R3CyDLBNcazygr88ZxwhqO82VWaGgxL/T51RXMXljVi7JtUlmu4DyvVs8TG25vIlBs66g=
Received: from DS2PR21MB5181.namprd21.prod.outlook.com (2603:10b6:8:2b8::22)
 by DS7PR21MB3295.namprd21.prod.outlook.com (2603:10b6:8:7f::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8943.12; Sat, 12 Jul
 2025 20:00:35 +0000
Received: from DS2PR21MB5181.namprd21.prod.outlook.com
 ([fe80::f4b2:7fb6:e90e:432d]) by DS2PR21MB5181.namprd21.prod.outlook.com
 ([fe80::f4b2:7fb6:e90e:432d%4]) with mapi id 15.20.8943.001; Sat, 12 Jul 2025
 20:00:35 +0000
From: Long Li <longli@microsoft.com>
To: Naman Jain <namjain@linux.microsoft.com>, KY Srinivasan
	<kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu
	<wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>, Michael Kelley
	<mhklinux@outlook.com>
CC: "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Olaf Hering
	<olaf@aepfle.de>, Saurabh Sengar <ssengar@linux.microsoft.com>
Subject: RE: [PATCH v4] tools/hv: fcopy: Fix irregularities with size of ring
 buffer
Thread-Topic: [PATCH v4] tools/hv: fcopy: Fix irregularities with size of ring
 buffer
Thread-Index: AQHb8ipLnObTa2Up7kGYvgDjJtmEYbQsch4AgAJ4yAA=
Date: Sat, 12 Jul 2025 20:00:35 +0000
Message-ID:
 <DS2PR21MB51816F322B9D204B75D9A4B6CE4AA@DS2PR21MB5181.namprd21.prod.outlook.com>
References: <20250711060846.9168-1-namjain@linux.microsoft.com>
 <326fcccb-1563-4cb7-a137-993d4ce3cedc@linux.microsoft.com>
In-Reply-To: <326fcccb-1563-4cb7-a137-993d4ce3cedc@linux.microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=7a4af337-da7b-4c80-bfd0-22ae62199859;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2025-07-12T20:00:28Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Tag=10,
 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS2PR21MB5181:EE_|DS7PR21MB3295:EE_
x-ms-office365-filtering-correlation-id: dc9e84e8-8588-4347-5ed2-08ddc17ec3e2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|376014|38070700018|13003099007;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?1rrby/6RpsUbEYc1w6SiPMclqVcTTPObtm25vLNfFGh5FRuaHokNuT3/TgzU?=
 =?us-ascii?Q?F50XUahxxDifb+zd0JDW4zATRJviErxkX5+JGQ8jzD27evPV4YpFFlNs7u8D?=
 =?us-ascii?Q?+35UUlX46bdt+yS9gtui7ExJ/PqL49++p5Q7U84DZNkqpptUXij26Cd+b7bK?=
 =?us-ascii?Q?q2CiGX8J6/U3Db1s93hWVva+9mWHsgk0/B9jRjfHo7On8H3hgFnWkSJw3HbZ?=
 =?us-ascii?Q?hdc/trjk3tnULi1Hce//ftN5rXMB1nwUqig1dIadu8PAb/5ST73M30anXzuj?=
 =?us-ascii?Q?In70FZOxrczhyidH5y1CZIesQ3OPKOezNdlxcT/2806VTTlpTzd2kMcMgkdM?=
 =?us-ascii?Q?3qnr6RMJVbF0rOc+sEIWUpHk2oxrBQi0+Gda8dlzkkzKviCv0Tp6foy+3WpA?=
 =?us-ascii?Q?VGKMxSf2qaHZaA9SNJbmAxF/9yw9b57vjSNFWScCujKNrLqeiYxnyEvsxs6t?=
 =?us-ascii?Q?M4e/z5rIQVoyw9+BBv8RMu53Rqcft92BbGRW2m+JLDjkQofpQdpUnsJY7ybf?=
 =?us-ascii?Q?Hd2KFM9HcGVavyNQUw6MGzWsYLIGQT3XIzc+y8i3kQbok+UvRAsZ5E/8Reg8?=
 =?us-ascii?Q?oW7GgEF3014W61ls5hRholr/sqBbmzXcJfw/ysHmmSiS+OWJd9FI8z2NDrRz?=
 =?us-ascii?Q?AA1CwAB9gPbc7zCU99Q/K+K5zUvmnQdpBo+sKd1R8Atnfg3VPf4sMoLRcywt?=
 =?us-ascii?Q?nxLn6NtoVf2bDf5HZ42glQ12VQ9IyuVGaFbmudl1zWvAD5s8+ODwnG1H/Hix?=
 =?us-ascii?Q?hl7CfmC0QEhHwE10j/bu+7xLk+F7OILfq06R6eZFw2nOgPxEd/Op6OYQWIAT?=
 =?us-ascii?Q?EPZMnR1RH568T6/0C10XPZLbSevLpt/eq1RYf4l+MUM92LnzInsq7EQ8YBC1?=
 =?us-ascii?Q?0ckqCVUDjr4wfxbyUxre8B9fl+iHRsp/3fQQ7aFKdJCenwm/YXpPJcSMQkCU?=
 =?us-ascii?Q?8TuIw6PCl/vzP5ATtbBWtif0W0d9VKe9T+Oe78ts4/oG9wa2QFUdwYDyVu49?=
 =?us-ascii?Q?ax2But+oEfKXNuBh7DY0275NgUVVOylv6XB9hsZgRIdhdjqNdydJvVWoaz96?=
 =?us-ascii?Q?3+Qnd8tRVVoOFnWMvXvjFQYL+b+Y3YQAOaTdhpXMw55VRZTRnmEZyDJMlMxR?=
 =?us-ascii?Q?SVwcZK8qnuHWpunt+sSxkZ0n7K5S+wkGMaT7XK/DqxVNvFE2Pxoe0ga/Xb8m?=
 =?us-ascii?Q?if+LWFoca6YP0lZciPHTskJFNxsNYefc7CMJNWOd9NGyy/sxHxnqvdWz2gp1?=
 =?us-ascii?Q?LWquxBc23QvmYwVdaJhBneOB5aWZxtBhv/lBQjqLIw/SYdyUL11VGGqnQDpU?=
 =?us-ascii?Q?TEjecPFcoQneBRtlGQBInLee61wMYROdjkVxcSfVgZphSUG/wyYxJbcgswnZ?=
 =?us-ascii?Q?VORs/XGQj7F2nY+vmkKvIGplMBob98Whedkk/0lZgCe+dioavZt4tBUvgYgZ?=
 =?us-ascii?Q?3MIFapcSJ1s=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS2PR21MB5181.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018)(13003099007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?kaW+JaLVCTTquJtS3O9JeW3uGJv+WDwYHmawlVKeUFEGuvrUo/XkicYgy36H?=
 =?us-ascii?Q?bxlTVwcZU0NQcAgM2sn6LEe4ba1MLVuOt99yFPy0YYsp/q5D9Pd23XAMlfSC?=
 =?us-ascii?Q?4CY4Q3owqDrxRRjmkxybikEWNKJ8xcyzJmVa9uEW+cl7GwTD/xLZaREfleSJ?=
 =?us-ascii?Q?NSjLj3fuGh4rCCSbJ5CKBKxqHj344axIL5BqNm03DMeDfPnKTzvHrqWd5ghA?=
 =?us-ascii?Q?AyPYMbMs91pwvY6z26dlM/8JIeXeMGfjOsWxzuVWblof7dowjpOS/pksgUeQ?=
 =?us-ascii?Q?vOwoG8ZblJtAW2Iy9Djf0T1DupgVQLZTHwzBVNMiWNncu4uG4YSwICdBIWvz?=
 =?us-ascii?Q?tTAO1y/6377g7fwRiFPkh6tDwPYMAGUl6eqFcjTp2Q8G84LM+Sc+YRgVVtMa?=
 =?us-ascii?Q?addsi5glE22UNcffcLRJpW6YCunY9o9qAb+IMzQqNk0OLVXFUQtbUfxhZ7yL?=
 =?us-ascii?Q?w3erF6DbT87rt2wjwqWjmJ+Z0rpuJSFCyK2a18HJCP0Xb5ZwNQT6CfrJSrye?=
 =?us-ascii?Q?KgFrygrmhRre4jUI2OidiGxv9oQQK40tzBwEZb0azdaetF26t0q/q7OEVTfh?=
 =?us-ascii?Q?NlU1NiRKv8BQSrKZa0+0n9x6AOgnrp41ffp8eIA0ytbMEABqXkzEqnwiqaRW?=
 =?us-ascii?Q?/EGfnDvAe9+JC4cE8KF1MgNRn63/0lEJlrCTVJV5GW4S1y6WMydXU/gbNrWM?=
 =?us-ascii?Q?Th6AJQdlVwcIhMwBsU6H763d79iCnVQTIyqPXTSOffswt2XZNmSnexDlAuSi?=
 =?us-ascii?Q?Iv5lq/1H9PVzBuo57TgwK5zm41qqXx9U/gNbJMH0qmX4R92v/texG1jBWMQg?=
 =?us-ascii?Q?YvRYs3YfKkdt6jKZOB8sMNnIBPBNUw61e+AmFPPieif0HAPnFzaaMr/rdl++?=
 =?us-ascii?Q?6g6jwKwr1AD1zAeiSaKpR58AtvqONs+e1wOpMOPjYutBwGqlyL7Zvqd7S6gm?=
 =?us-ascii?Q?cuznoGQ2hAc3TIStn3OpTrVIQ7h28ZprGeZM8eEPVGiBKlK14O5CNuKaM1/C?=
 =?us-ascii?Q?6hgdpRZuuOmDeq0MmeLb+K44UJRFmq0Xk+2UcSPGYHJZoXyOBlJZUuJt3VrI?=
 =?us-ascii?Q?eo8GAjIQvhtEryQ6n2MO5V+Dh8YgA9XF8WypsOcF/WdVlgXugu+pHKVFgQfh?=
 =?us-ascii?Q?638WSCLzV9tAGc/N1oenMVHSwebKwXk38c4v12HZgalo5coeYWrUdwrREX71?=
 =?us-ascii?Q?x1yO5SugWMdiBOqWLo7XLHz/9L4USC2wlSWTTbdt/KqG8HOlmQTfWIkZpMPA?=
 =?us-ascii?Q?uBo70eITohckgZq39fRy/m6uTy3HDmOvlAJ1w/94/9TeTrYzt2kNe8rsbjsA?=
 =?us-ascii?Q?b9W84TbZYhuXJsBnLZtOI3GoWSnbPm4WqoZtARHZAkUhml8Y6xPdcSNbsdPl?=
 =?us-ascii?Q?S2QY1p8+Ygt1XbkPVDZ76BmM2PzNiUCEaIsSmrUaDlOh71bnqJqsE4Wk2xTt?=
 =?us-ascii?Q?0+ELdMrYgwNlbv4NrO+ZeekUvZP65xo882wgNxc+Ew3mAq+HyHFgbdMMgcox?=
 =?us-ascii?Q?SmS8sQXiVIEaSGORpa8GxvdpmwEQDCea/pJuAN7n6B2VzW/URm0avV3jN47P?=
 =?us-ascii?Q?Sd2vCWLFgqkcX8IWm5MSs/lqnyUR2DHDdQCxl/u3?=
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
X-MS-Exchange-CrossTenant-AuthSource: DS2PR21MB5181.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dc9e84e8-8588-4347-5ed2-08ddc17ec3e2
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Jul 2025 20:00:35.2330
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: L0NTlm8JGElbx2STFcXJav6v5Z6EJ+6ZVLaBRRucRBfK1vUp9wG6llHS62bnMspEvJ8Wfwww8xSjIkRBj2EmNA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR21MB3295

> Subject: Re: [PATCH v4] tools/hv: fcopy: Fix irregularities with size of =
ring buffer
>
>
>
> On 7/11/2025 11:38 AM, Naman Jain wrote:
> > Size of ring buffer, as defined in uio_hv_generic driver, is no longer
> > fixed to 16 KB. This creates a problem in fcopy, since this size was
> > hardcoded. With the change in place to make ring sysfs node actually
> > reflect the size of underlying ring buffer, it is safe to get the size
> > of ring sysfs file and use it for ring buffer size in fcopy daemon.
> > Fix the issue of disparity in ring buffer size, by making it dynamic
> > in fcopy uio daemon.
> >
> > Cc: stable@vger.kernel.org
> > Fixes: 0315fef2aff9 ("uio_hv_generic: Align ring size to system page")
> > Signed-off-by: Naman Jain <namjain@linux.microsoft.com>
> > Reviewed-by: Saurabh Sengar <ssengar@linux.microsoft.com>

Reviewed-by: Long Li <longli@microsoft.com>

> > ---
>
> Noticed that I missed adding change logs (again). Adding them now.
>
> Changes since v3:
> https://lore.kern/
> el.org%2Fall%2F20250708080319.3904-1-
> namjain%40linux.microsoft.com%2F&data=3D05%7C02%7Clongli%40microsoft.com
> %7C5061a1ac57814cbe542b08ddc042614e%7C72f988bf86f141af91ab2d7cd011
> db47%7C1%7C0%7C638878113544016320%7CUnknown%7CTWFpbGZsb3d8eyJ
> FbXB0eU1hcGkiOnRydWUsIlYiOiIwLjAuMDAwMCIsIlAiOiJXaW4zMiIsIkFOIjoiTWF
> pbCIsIldUIjoyfQ%3D%3D%7C0%7C%7C%7C&sdata=3DloiQdbSCzLluXmFECiIrrHbbK9
> fqxJBbLTSAB26%2Bd0k%3D&reserved=3D0
> * Added a goto label for freeing desc memory. (Saurabh)
> * Avoided declaring device path twice by using FCOPY_DEVICE_PATH(subdir)
> (Saurabh)
> * Removed extra len variable assignment in main() (Saurabh)
> * added Reviewed-by tag from Saurabh
>
> Changes since v2:
> https://lore.kern/
> el.org%2Fall%2F20250701104837.3006-1-
> namjain%40linux.microsoft.com%2F&data=3D05%7C02%7Clongli%40microsoft.com
> %7C5061a1ac57814cbe542b08ddc042614e%7C72f988bf86f141af91ab2d7cd011
> db47%7C1%7C0%7C638878113544051861%7CUnknown%7CTWFpbGZsb3d8eyJ
> FbXB0eU1hcGkiOnRydWUsIlYiOiIwLjAuMDAwMCIsIlAiOiJXaW4zMiIsIkFOIjoiTWF
> pbCIsIldUIjoyfQ%3D%3D%7C0%7C%7C%7C&sdata=3DPZ9GdNL7%2FD6NfxZPhCOX
> 7zQ2DbspDgQs%2BS75PFGAFG4%3D&reserved=3D0
> * Removed fallback mechanism to default size, to keep fcopy behavior cons=
istent
> (Long's suggestion). If ring sysfs file is not present for some reason, t=
hings are
> already bad and its the right thing for fcopy to abort.
>
> Changes since v1:
> https://lore.kern/
> el.org%2Fall%2F20250620070618.3097-1-
> namjain%40linux.microsoft.com%2F&data=3D05%7C02%7Clongli%40microsoft.com
> %7C5061a1ac57814cbe542b08ddc042614e%7C72f988bf86f141af91ab2d7cd011
> db47%7C1%7C0%7C638878113544063634%7CUnknown%7CTWFpbGZsb3d8eyJ
> FbXB0eU1hcGkiOnRydWUsIlYiOiIwLjAuMDAwMCIsIlAiOiJXaW4zMiIsIkFOIjoiTWF
> pbCIsIldUIjoyfQ%3D%3D%7C0%7C%7C%7C&sdata=3DLQsSaTjbam4DPAzMQmy1%
> 2BMB0%2BKb6L7d3xKkM954mpls%3D&reserved=3D0
>
> * Removed unnecessary type casting in malloc for desc variable (Olaf)
> * Added retry mechanisms to avoid potential race conditions (Michael)
> * Moved the logic to fetch ring size to a later part in main (Michael)
>
>
>
> >   tools/hv/hv_fcopy_uio_daemon.c | 91 ++++++++++++++++++++++++++++++--
> --
> >   1 file changed, 81 insertions(+), 10 deletions(-)
> >
> > diff --git a/tools/hv/hv_fcopy_uio_daemon.c
> > b/tools/hv/hv_fcopy_uio_daemon.c index 0198321d14a2..7d9bcb066d3f
> > 100644
> > --- a/tools/hv/hv_fcopy_uio_daemon.c
> > +++ b/tools/hv/hv_fcopy_uio_daemon.c
> > @@ -35,7 +35,10 @@
> >   #define WIN8_SRV_MINOR            1
> >   #define WIN8_SRV_VERSION  (WIN8_SRV_MAJOR << 16 |
> WIN8_SRV_MINOR)
> >
> > -#define FCOPY_UIO          "/sys/bus/vmbus/devices/eb765408-105f-49b6-
> b4aa-c123b64d17d4/uio"
> > +#define FCOPY_DEVICE_PATH(subdir) \
> > +   "/sys/bus/vmbus/devices/eb765408-105f-49b6-b4aa-c123b64d17d4/"
> #subdir
> > +#define FCOPY_UIO_PATH          FCOPY_DEVICE_PATH(uio)
> > +#define FCOPY_CHANNELS_PATH     FCOPY_DEVICE_PATH(channels)
> >
> >   #define FCOPY_VER_COUNT           1
> >   static const int fcopy_versions[] =3D { @@ -47,9 +50,62 @@ static
> > const int fw_versions[] =3D {
> >     UTIL_FW_VERSION
> >   };
> >
> > -#define HV_RING_SIZE               0x4000 /* 16KB ring buffer size */
> > +static uint32_t get_ring_buffer_size(void) {
> > +   char ring_path[PATH_MAX];
> > +   DIR *dir;
> > +   struct dirent *entry;
> > +   struct stat st;
> > +   uint32_t ring_size =3D 0;
> > +   int retry_count =3D 0;
> > +
> > +   /* Find the channel directory */
> > +   dir =3D opendir(FCOPY_CHANNELS_PATH);
> > +   if (!dir) {
> > +           usleep(100 * 1000); /* Avoid race with kernel, wait 100ms a=
nd
> retry once */
> > +           dir =3D opendir(FCOPY_CHANNELS_PATH);
> > +           if (!dir) {
> > +                   syslog(LOG_ERR, "Failed to open channels
> directory: %s", strerror(errno));
> > +                   return 0;
> > +           }
> > +   }
> > +
> > +retry_once:
> > +   while ((entry =3D readdir(dir)) !=3D NULL) {
> > +           if (entry->d_type =3D=3D DT_DIR && strcmp(entry->d_name, ".=
") !=3D 0
> &&
> > +               strcmp(entry->d_name, "..") !=3D 0) {
> > +                   snprintf(ring_path, sizeof(ring_path), "%s/%s/ring"=
,
> > +                            FCOPY_CHANNELS_PATH, entry->d_name);
> > +
> > +                   if (stat(ring_path, &st) =3D=3D 0) {
> > +                           /*
> > +                            * stat returns size of Tx, Rx rings combin=
ed,
> > +                            * so take half of it for individual ring s=
ize.
> > +                            */
> > +                           ring_size =3D (uint32_t)st.st_size / 2;
> > +                           syslog(LOG_INFO, "Ring buffer size from %s:=
 %u
> bytes",
> > +                                  ring_path, ring_size);
> > +                           break;
> > +                   }
> > +           }
> > +   }
> >
> > -static unsigned char desc[HV_RING_SIZE];
> > +   if (!ring_size && retry_count =3D=3D 0) {
> > +           retry_count =3D 1;
> > +           rewinddir(dir);
> > +           usleep(100 * 1000); /* Wait 100ms and retry once */
> > +           goto retry_once;
> > +   }
> > +
> > +   closedir(dir);
> > +
> > +   if (!ring_size)
> > +           syslog(LOG_ERR, "Could not determine ring size");
> > +
> > +   return ring_size;
> > +}
> > +
> > +static unsigned char *desc;
> >
> >   static int target_fd;
> >   static char target_fname[PATH_MAX];
> > @@ -406,7 +462,7 @@ int main(int argc, char *argv[])
> >     int daemonize =3D 1, long_index =3D 0, opt, ret =3D -EINVAL;
> >     struct vmbus_br txbr, rxbr;
> >     void *ring;
> > -   uint32_t len =3D HV_RING_SIZE;
> > +   uint32_t ring_size, len;
> >     char uio_name[NAME_MAX] =3D {0};
> >     char uio_dev_path[PATH_MAX] =3D {0};
> >
> > @@ -437,7 +493,20 @@ int main(int argc, char *argv[])
> >     openlog("HV_UIO_FCOPY", 0, LOG_USER);
> >     syslog(LOG_INFO, "starting; pid is:%d", getpid());
> >
> > -   fcopy_get_first_folder(FCOPY_UIO, uio_name);
> > +   ring_size =3D get_ring_buffer_size();
> > +   if (!ring_size) {
> > +           ret =3D -ENODEV;
> > +           goto exit;
> > +   }
> > +
> > +   desc =3D malloc(ring_size * sizeof(unsigned char));
> > +   if (!desc) {
> > +           syslog(LOG_ERR, "malloc failed for desc buffer");
> > +           ret =3D -ENOMEM;
> > +           goto exit;
> > +   }
> > +
> > +   fcopy_get_first_folder(FCOPY_UIO_PATH, uio_name);
> >     snprintf(uio_dev_path, sizeof(uio_dev_path), "/dev/%s", uio_name);
> >     fcopy_fd =3D open(uio_dev_path, O_RDWR);
> >
> > @@ -445,17 +514,17 @@ int main(int argc, char *argv[])
> >             syslog(LOG_ERR, "open %s failed; error: %d %s",
> >                    uio_dev_path, errno, strerror(errno));
> >             ret =3D fcopy_fd;
> > -           goto exit;
> > +           goto free_desc;
> >     }
> >
> > -   ring =3D vmbus_uio_map(&fcopy_fd, HV_RING_SIZE);
> > +   ring =3D vmbus_uio_map(&fcopy_fd, ring_size);
> >     if (!ring) {
> >             ret =3D errno;
> >             syslog(LOG_ERR, "mmap ringbuffer failed; error: %d %s", ret=
,
> strerror(ret));
> >             goto close;
> >     }
> > -   vmbus_br_setup(&txbr, ring, HV_RING_SIZE);
> > -   vmbus_br_setup(&rxbr, (char *)ring + HV_RING_SIZE, HV_RING_SIZE);
> > +   vmbus_br_setup(&txbr, ring, ring_size);
> > +   vmbus_br_setup(&rxbr, (char *)ring + ring_size, ring_size);
> >
> >     rxbr.vbr->imask =3D 0;
> >
> > @@ -472,7 +541,7 @@ int main(int argc, char *argv[])
> >                     goto close;
> >             }
> >
> > -           len =3D HV_RING_SIZE;
> > +           len =3D ring_size;
> >             ret =3D rte_vmbus_chan_recv_raw(&rxbr, desc, &len);
> >             if (unlikely(ret <=3D 0)) {
> >                     /* This indicates a failure to communicate (or wors=
e) */
> @@
> > -492,6 +561,8 @@ int main(int argc, char *argv[])
> >     }
> >   close:
> >     close(fcopy_fd);
> > +free_desc:
> > +   free(desc);
> >   exit:
> >     return ret;
> >   }
> >
> > base-commit: b551c4e2a98a177a06148cf16505643cd2108386


