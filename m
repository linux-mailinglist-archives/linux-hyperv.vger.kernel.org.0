Return-Path: <linux-hyperv+bounces-4936-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FF95A8AA37
	for <lists+linux-hyperv@lfdr.de>; Tue, 15 Apr 2025 23:41:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 921D31685ED
	for <lists+linux-hyperv@lfdr.de>; Tue, 15 Apr 2025 21:41:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3091F257ACA;
	Tue, 15 Apr 2025 21:41:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="YYGpZlyv"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2138.outbound.protection.outlook.com [40.107.236.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A74B9253357;
	Tue, 15 Apr 2025 21:41:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.138
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744753265; cv=fail; b=LFZy7PF26M1oJYYfeP1nU1kCb6Rnww41cRFSd8cApoPWm9xLOuHpWvtX2NJlqxZR8t/JCfGXc/xvsPoHlgHcL1Z8HaYDZWczBoxf8uqU0RpUQgc6OkYD3k5u9bKaI4H76krYKJ/93P5PVHQKfQsB8EXXLKwsQxu2VGfkksRek1M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744753265; c=relaxed/simple;
	bh=lQSmX073CiRuxchoXOxcpsKjzQzc40fnlNIa1VeoIsA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=bq07JGJx+w8f5Nm/R70CgNEjMw9BMLmGOF4wPyVldWp1cetpjOBfVonKb4o1Aa24u4qO68SeucPZvz4ki4dRy2xiX5AKri9CWGfO531/bcAqzlpSCB+i7C1L59IqCYd70t8iTVkldkqkwpm+geIm7yLHQlYVY3GCUF2G6vqBoIs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com; spf=pass smtp.mailfrom=microsoft.com; dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b=YYGpZlyv; arc=fail smtp.client-ip=40.107.236.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microsoft.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FxFYp+wigDzQsv54Du0pORHiVo8CDP+PVwYeBZxrQIrABgC3eWAF6XBi7iMRiOyNAvuCvZrON/7qv//z7qqvsGb1oWuWTiz12Sj51uUa7c61pFzGILzjfsazQA+VZtSNJ68cMOzEo53cFxHuNvmSWyvanuKNKy8RXAoT6eAaX6ldJosdjN/nHJVO0/Y6ufn4c03cnSsWsvHibIInHxwbDC7tXF1U7LJlBf8D3aYM2tbI3wqBTNUFOplIBSEiz2JcINtDetB8rlaZhBFG7Ggp6gGyG/+63F2cmizB05Ij6P9l5L8J/QLpLROaRF13YRKd2kypPF2gZ8v4Z1TkfdHUxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eglABzwV7MA94EScdEP3tlSkBoO9wtrJFX3G4F5dHIc=;
 b=pfTFQpvkZtDGl1s4pNG3VLuuRHjGkQeGrw0l8MSxh7eZzEbjGUAS2eyUcq9gigjOMrtuqBFdoGyZG8qfYRlN/c2g3bcfYcUonl9RWaSFpbzIw2mwzk04pV0W9I+BdeFR9SJY7V7dO0MNqVGQcTDkFAMX8Is1/Zifs/MS6aspdvJR9n8JfpMSctKjnyobERaas13zU2kNW8nKnM+uitoPbE79vo2idbKHedIDeIEPcD8XeHjg5wx4s6jcuUkX/f2+RG6b5X4UFWjUMQye8AjAeeoVxCwEKlA46zW2kD/QTqUThYZUpXyHPiWBzj82hf7y8pGD09xKiPsA6p3fp+PN+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eglABzwV7MA94EScdEP3tlSkBoO9wtrJFX3G4F5dHIc=;
 b=YYGpZlyvtUdR8wSZhvJQ7Z20IauuvRcZSYJS2WOXGtmid0Mi7OORjNnSjqUnKOzcMqB5cvwyqBil287UqY5mkMaq6IzpAIKZkTQDlBtJ8aUc1NlxXh9Ro7pozcxmA2ZyZ5rFGRpNWLIS1Igl0SQV49f1atpLFVEuqqy3HE7KCcw=
Received: from MN0PR21MB3437.namprd21.prod.outlook.com (2603:10b6:208:3d2::17)
 by MN0PR21MB3096.namprd21.prod.outlook.com (2603:10b6:208:374::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8655.14; Tue, 15 Apr
 2025 21:40:55 +0000
Received: from MN0PR21MB3437.namprd21.prod.outlook.com
 ([fe80::5125:461:1c07:1a97]) by MN0PR21MB3437.namprd21.prod.outlook.com
 ([fe80::5125:461:1c07:1a97%2]) with mapi id 15.20.8655.012; Tue, 15 Apr 2025
 21:40:55 +0000
From: Haiyang Zhang <haiyangz@microsoft.com>
To: "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"akpm@linux-foundation.org" <akpm@linux-foundation.org>, "corbet@lwn.net"
	<corbet@lwn.net>, "linux-mm@kvack.org" <linux-mm@kvack.org>,
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, "Mike Rapoport
 (Microsoft)" <rppt@kernel.org>, Mike Rapoport <mikerapoport@microsoft.com>
CC: Dexuan Cui <decui@microsoft.com>, KY Srinivasan <kys@microsoft.com>, Paul
 Rosswurm <paulros@microsoft.com>, "olaf@aepfle.de" <olaf@aepfle.de>, vkuznets
	<vkuznets@redhat.com>, "davem@davemloft.net" <davem@davemloft.net>,
	"wei.liu@kernel.org" <wei.liu@kernel.org>, Long Li <longli@microsoft.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 0/2] mm: Explicitly check & doc fragsz limit
Thread-Topic: [PATCH 0/2] mm: Explicitly check & doc fragsz limit
Thread-Index: AQHbpN6KPzTPjggRZ0qY2lc9NTFwp7OlUxwA
Date: Tue, 15 Apr 2025 21:40:55 +0000
Message-ID:
 <MN0PR21MB3437DAF312FA4DF8F7D01E6BCAB22@MN0PR21MB3437.namprd21.prod.outlook.com>
References: <1743715309-318-1-git-send-email-haiyangz@microsoft.com>
In-Reply-To: <1743715309-318-1-git-send-email-haiyangz@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=3ae28bae-b123-4e70-98eb-8ad76cb67454;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2025-04-15T21:36:18Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Tag=10,
 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR21MB3437:EE_|MN0PR21MB3096:EE_
x-ms-office365-filtering-correlation-id: a8729b2e-b860-45e6-521b-08dd7c66340e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|376014|1800799024|366016|7053199007|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?kOoFls+YN9M7j/KW4lClS1jNmi8U0rwyQu3GSV8Ie8QxAmXqZKw8XorZ0Zcd?=
 =?us-ascii?Q?b7EodhKxOtsSR5Z+QkiQ6ZKYJZ6YHpRgtc9vx2DfBkRUrk73sDYrBMNSD3eK?=
 =?us-ascii?Q?1UiutnzhBshS0jQsUbcvHEiyV/xzw82SQT4WMMlsJvK2snqLXWWzHzoC2oov?=
 =?us-ascii?Q?SEk8Ij9oaxihJ2G8h0HlP7qbWyVeuHYexUsTNfGRvIsjMFe/jJOnf9cIiqI3?=
 =?us-ascii?Q?Z1XdRN5jzhcCyERANgM6FhT+xI+1lwyz/wvI/N/jErHhsjTUNNugrreqo3IK?=
 =?us-ascii?Q?6tKOYktbiKhKYiOeEfgEqh15viMR/VR6MR+kuPhKhelOxC/a3WScrHfzFrn1?=
 =?us-ascii?Q?/67P4Ka1YIfOl9PXDQoz6Qva5zOIrj5LT4XjlKSrd9z1GCW+87hB3Q6FGYRB?=
 =?us-ascii?Q?z/QnNCrt70WloYCCt6m4uQdEOn9HvdaEd8eNY9OkPwNWIP2bzfivTVQjKa/6?=
 =?us-ascii?Q?Q6fzcO3owpflCkLmId195UzXDDP3GvEIl/Sq7IVlpSHP+fj7IKmHc99wRDqz?=
 =?us-ascii?Q?hDWYFByMBEnLXtSjn1hE/lMgEB8croNcSmmxkMkbku37r+HCd6WPWgMoVFmM?=
 =?us-ascii?Q?p+vkoUVveHYfJVV8G1pL4PE95wCNTK//Ea9mG8QgxMZ0kaMVHsEAB7if7nrS?=
 =?us-ascii?Q?pvk6Bim+weYKG3TBKYwGmtb2qer7OGAV5d176+xbueoqKqm82iNA7TRSX114?=
 =?us-ascii?Q?GmafbJqPGko1mnZqwIWWbMubaUdV4kl5K5rH6rYLRkkC/qYQ4MR8f2rLno1u?=
 =?us-ascii?Q?AaGIy+ue9iayln0pS1m+1RZwsl18r4fBI+2bKKbiouc0SEeOxOi8j5vIi4Gi?=
 =?us-ascii?Q?o3GNG2CXRRzQrKmH0LqWAqSssewTqrbiKppe5uqoeS8d291wuPcOvGjyTusc?=
 =?us-ascii?Q?TJhwwhaIi/rYuhSStyBb4bxpcYnR1m1VFL3kkjcpPO1LWysiOEooAq1C9nMS?=
 =?us-ascii?Q?lBwWetV9fdEvdFl50OqVcyAzg4yBBWq5jL2mu1j+7pK6f1a3B4mPNckjO3yv?=
 =?us-ascii?Q?iea62wBE+2YxKcjJdzZOmZFQ8GrFwV11BD6pH7fRBVdDMWZHOT3Ul1FaM7Sq?=
 =?us-ascii?Q?yfeix9kH2f+ZIMi6olhcHLWEokVdC5clP8sshIDCCq3tSKKDz1M+EAyIR4PR?=
 =?us-ascii?Q?USdmcaLlyZxkPARlK3tZikKIKlptX/1tzd2gmQrgukL2dPghDXoM3kB5wN1x?=
 =?us-ascii?Q?yDWwsl2fZGgzrbJd2DhjqUyMsUBEzYqnrA0e62CdsdGipOz/6mjvVdOPmrRA?=
 =?us-ascii?Q?I2WNXqZ+w4z1iQvOh5IZych8pwzzQmhyDByBclq4ayhNdPNjj5LUtEu9u1y/?=
 =?us-ascii?Q?JV6EN0JmrcoZhTgJVUCWCEiq0rzwubAP4bzrDk1deSvWqLm7aUGodyrTSy1v?=
 =?us-ascii?Q?wL0FmEpHOyDO8DAf9mSsY5sVreoiBc6nFEbm5hvwgv+nHW0tJVCFIN4EiNzg?=
 =?us-ascii?Q?u1Z8tndb5QS0P157MylTdRtwtHOd0upaCK7TRzFTjU2WlKNzQYZA5A=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR21MB3437.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(7053199007)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?fbKJkcj2kdhtSWhlTxCgywdBD6GCtkhiNCsmbmjWuSzuABaZ332TS4AdN7BF?=
 =?us-ascii?Q?tpTEccmCd/5h/QVRogzRVs2jjO9rYgAVEg0XwGnXeMOj+E/ee6eC/yVFe3bk?=
 =?us-ascii?Q?LhQAyfhnS4YHaws3X2b703ASn6CDCOSibwRmmeLkLxtmlVG8MonQ6uWYAm5i?=
 =?us-ascii?Q?PhDMv46uWb1rnkZMN2oIcdF2lXo2cgOkZHn4Qs3u+/boDdRuOlaoOdikila3?=
 =?us-ascii?Q?paazV5Y7DLHcnCIsmh3UhJk908lkVPbSN78oUYjkzKIUS5fmp1dDqSN2sa9h?=
 =?us-ascii?Q?SJFqkF1focfj/yavsSadJSUv6ZD+NcPSyVR6SIw8lsB5jQD2pqum4+cEYtwz?=
 =?us-ascii?Q?8LTuFBy9ulGkTzoR482MaF014oB9egQDZR2Xp2jsj1h2sLUm/O+xfH5Fh7Bl?=
 =?us-ascii?Q?rj0MTUapIesfx2ZaCOklMh+hmv6kU9S0z76khsNUQX6csUBmLLrNyI3u2q1c?=
 =?us-ascii?Q?DXIR4Y0YSBKArlkpZalziq9YuyjCK6zxxxQ8ox7uSKv80VzNtiglMX9V6DVv?=
 =?us-ascii?Q?Ro5JjpekVlQW9+PDfYoquiq5hLFxBYje9LHc+FesOowkR++6FHNG80aINDi+?=
 =?us-ascii?Q?ASyPAxCP68RosqXjzCqgPSFRTLl+hGfmWyV9dEswLobp/souEZnHwfU/KBGx?=
 =?us-ascii?Q?YuFGweNrjb0sXNSjY98q8uQKJ06Xyp47Fl12h+6kzt7XzhMDp8o9L3N0EK6y?=
 =?us-ascii?Q?qxvdAGmLp+rIO+y7hxtlVsQdsf8fjRWr7+UkvJkkWCNBVYHmc/45w5OnYrjY?=
 =?us-ascii?Q?cSbIQiQO/edfR1UGW3nt27EqKWtn5albGSYU6Knofl156GEd5CRaME9I06w3?=
 =?us-ascii?Q?hxFZBcUSJJZVDluD1esigXpk52jqTS2cYbXKBUJhn7QssUqYyu1l8lJfn1i6?=
 =?us-ascii?Q?9jycIVy8I6pV0SfrdxEUHlWknnTfP7ARDGHReLU92VCactV3QlRoFNCsnjoY?=
 =?us-ascii?Q?GXtK4uoNSMBEe4/PK8u5erJKccqGnQEygIGxXnvnvs3l0LxWi2xRhDxHPQ5g?=
 =?us-ascii?Q?7Uk1rXHlKYVGA4F3G23vS9+Ua/77cDwXIPPip5D4LCRhMJdON6Sl4vMZHn6t?=
 =?us-ascii?Q?8s9MzVXqnn8QLDpmc5PGTcdf1QHB71XNt4uzxA+Cylm3qkcqiIyKjWmV+aVV?=
 =?us-ascii?Q?Di7Lx9SoYSFZVWMvuBJoBFdSLQjWRbtcHyV2Oi82hV6v9VWN0gTMnkbHlaoW?=
 =?us-ascii?Q?y6DDPxH7S3P9Eat6C0CuvvH5QnOkheGYXKI3NX3SgQtcoN8Rjuuk52zNGEkk?=
 =?us-ascii?Q?5tgPcjnYklZmMWvJYTfVusQyAD5LhnGaxWFIn7dYDeB9UeQVCSXQmQQAOs4C?=
 =?us-ascii?Q?A8Q85XDAZFjXovr/m4NGn7ObZvRP9aZ2ZwWZNuAlD4/76nY+TlSB7ZBQ46mK?=
 =?us-ascii?Q?lhmUue2/xuiC2cMLEbEPX+sKhWucwu/dA2+7vSBJkEMDXE5VF1yK898Q4fSk?=
 =?us-ascii?Q?l7UwFHPIBn8LcnOqvtUtz3+jTBOq14iYEYM6h196D/zWJnHo361lcfdUu4VU?=
 =?us-ascii?Q?oqszWnWK97nrQQhljAF6edoYRNavmTyoL9amTM6UiqBVGJfktN4VaUiJ7+ht?=
 =?us-ascii?Q?5QXnlc4Ah1DXexFzpbWiFJtJ1rc5LCYmQvrT/7t9?=
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
X-MS-Exchange-CrossTenant-AuthSource: MN0PR21MB3437.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a8729b2e-b860-45e6-521b-08dd7c66340e
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Apr 2025 21:40:55.8032
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SyC+WIsH8zOvzkoolgwhFKk3h82rSHVy5dWmIzk1tY1gvLi2dFn4+eyB2aQnGG/HJvkJBr7KmGpXOYHg7DtiVw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR21MB3096



> -----Original Message-----
> From: LKML haiyangz <lkmlhyz@microsoft.com> On Behalf Of Haiyang Zhang
> Sent: Thursday, April 3, 2025 5:22 PM
> To: linux-hyperv@vger.kernel.org; akpm@linux-foundation.org;
> corbet@lwn.net; linux-mm@kvack.org; linux-doc@vger.kernel.org
> Cc: Haiyang Zhang <haiyangz@microsoft.com>; Dexuan Cui
> <decui@microsoft.com>; KY Srinivasan <kys@microsoft.com>; Paul Rosswurm
> <paulros@microsoft.com>; olaf@aepfle.de; vkuznets <vkuznets@redhat.com>;
> davem@davemloft.net; wei.liu@kernel.org; Long Li <longli@microsoft.com>;
> linux-kernel@vger.kernel.org
> Subject: [PATCH 0/2] mm: Explicitly check & doc fragsz limit
>=20
> The page frag allocator is not designed for fragsz > PAGE_SIZE.
> Explicitly check it in the function & document the fragsz limit.
>=20
> Haiyang Zhang (2):
>   mm: page_frag: Check fragsz at the beginning of
> __page_frag_alloc_align()
>   docs/mm: Specify page frag size is not bigger than PAGE_SIZE
>=20
>  Documentation/mm/page_frags.rst |  2 +-
>  mm/page_frag_cache.c            | 22 +++++++++-------------
>  2 files changed, 10 insertions(+), 14 deletions(-)
>=20

+@Mike Rapoport (Microsoft) <rppt@kernel.org>
Hi Mike, since you have a lot experience in mm subsystem, could you please=
=20
review my patch set?

Thanks,
- Haiyang


