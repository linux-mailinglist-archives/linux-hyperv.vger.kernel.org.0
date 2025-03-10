Return-Path: <linux-hyperv+bounces-4354-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C80E3A5A37A
	for <lists+linux-hyperv@lfdr.de>; Mon, 10 Mar 2025 19:57:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 03F0D170213
	for <lists+linux-hyperv@lfdr.de>; Mon, 10 Mar 2025 18:57:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBB6123315A;
	Mon, 10 Mar 2025 18:57:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="VXNjrw/v"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11022100.outbound.protection.outlook.com [40.107.200.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ECD5374EA;
	Mon, 10 Mar 2025 18:57:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.100
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741633057; cv=fail; b=DfCnrhpPcHXXm7pMg4UZVDjTUCSh8lQLDHrUB4y8x4b6CucYTJs5tIEFthLK5JTx0Zjf9uBbcnrNw1YDAd7J9voRDzcKE9omqBfZH4fOmL/IAtcp+S2qRAXouuCjaTMoRhWmjbFuWHN56S3TkZh+lSQ31CmYqN9zdrtEBvJL0hU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741633057; c=relaxed/simple;
	bh=xo52ZN8h9hX0oxYfLc7zKaee8iX/Tq8u4Ud9X8pHKyo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=F7o18dT3z6U4ERh4Q6G3J2VHfRV5/6cSiYEZW+aYSC0mvUpI9v9QBlQEDB6sQZsVMKnLlyqHKPTxumJzI8jkzyfygfb/MPdX0RfrPTCPc/Hv/er4PqhI0RDzhHHRlwTr1rPwxFU4R1+3oNlcxPKgnoKulZTVbZ31HTdgN4pla7A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com; spf=pass smtp.mailfrom=microsoft.com; dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b=VXNjrw/v; arc=fail smtp.client-ip=40.107.200.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microsoft.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sjD50ohD8GmKgrmMW61Nb2VlBvOuFv0OAWgyn9xFceu/JfMJt/dd/1nPhUa1pZav9jdXMJx5yXmwD65AWea4lT5QSTm8U0AVH6hPzXj6uAM9zgF7d6u6MEEQz4SQ8rWGWrGiGKHcG0aRYHqJ/KUsMUzUC7fhM7NTzMY3yYc8HVYnUBEP9oz5XcdtfqORbPIVKHdDCDDZetn3XOwgchUmUAxyn2MRVNPeLMjGWoHvX9BQVOY/wMpvkM/wbq5Iq+F0UdmXGCaQXHZ9LD/T/cRoS4/BQLZf0kHcNvJRNeW0MI0SRWxLoKUGsK7g2e6To1HzI32AAHpe+7KCuvfjVJuGTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2fOKcb5B6HWVdibxl5Og0SQDe9TOeQ4EYjUO+VF17yw=;
 b=V6qCqUwMZrMerIJe7GDv3fDwzG12uGdfAT08/hTDTjhJx4m0CA9OxyFFtJbTQKfYaylrdzpc/YDn0TuWY+WxKnaKB874AAUUephGffMgq1Dxf/Bwaw11rkWWV/C06Y0Kd2+O0wT/EwKQYjFWGN22C7kzt/Hw79ZYNVf0v7F8t10uv93FrVle9I40aTK/LdFqQWdjjxjealCuAqRzoeKdNZpZhcdD9W4Bt/eK6by7uoJqyBecFuI6NEB2d3H+DOnwx5MgtOMVOW4Ftf9oCbDc1ZcCbzdAeDhKsIFZrcErJSINY2FyC82KhPwtJWuf4xmDad/TWmItE8pKVSPc9fUFHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2fOKcb5B6HWVdibxl5Og0SQDe9TOeQ4EYjUO+VF17yw=;
 b=VXNjrw/vi0gh7SSzHX0EfITAgww108VAsjl48KdGjaGjLckake53Pj7Z4h78/GGt4m46Mr/TV4ccREOWUPP94Wzjedvg87kB7mM/S7QVdr/xX0yM+UMIvokKo5u+WRvkYRTw+I7GPAVblZm4EwdyjrT4ChtnEYjo/xfqS6JSIhU=
Received: from SA6PR21MB4231.namprd21.prod.outlook.com (2603:10b6:806:412::20)
 by SA1PR21MB4035.namprd21.prod.outlook.com (2603:10b6:806:38f::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.20; Mon, 10 Mar
 2025 18:57:33 +0000
Received: from SA6PR21MB4231.namprd21.prod.outlook.com
 ([fe80::5c62:d7c6:4531:3aff]) by SA6PR21MB4231.namprd21.prod.outlook.com
 ([fe80::5c62:d7c6:4531:3aff%4]) with mapi id 15.20.8534.012; Mon, 10 Mar 2025
 18:57:33 +0000
From: Long Li <longli@microsoft.com>
To: Saurabh Singh Sengar <ssengar@linux.microsoft.com>
CC: "longli@linuxonhyperv.com" <longli@linuxonhyperv.com>, KY Srinivasan
	<kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu
	<wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>, Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>, "linux-hyperv@vger.kernel.org"
	<linux-hyperv@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [Patch v2] uio_hv_generic: Set event for all channels on the
 device
Thread-Topic: [Patch v2] uio_hv_generic: Set event for all channels on the
 device
Thread-Index: AQHbkLbABa8gGB7X4UeqrCpzK0MNDLNsnU3QgAAFwYCAABbgoA==
Date: Mon, 10 Mar 2025 18:57:33 +0000
Message-ID:
 <SA6PR21MB4231EDFB5B349A4C59131ABFCED62@SA6PR21MB4231.namprd21.prod.outlook.com>
References: <1740780854-7844-1-git-send-email-longli@linuxonhyperv.com>
 <20250309054727.GA24737@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
 <SA6PR21MB4231D4A8F6D942B405777BECCED62@SA6PR21MB4231.namprd21.prod.outlook.com>
 <20250310173123.GA12960@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
In-Reply-To:
 <20250310173123.GA12960@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=3c5cb4f3-db8c-462e-95ec-0f874f527e4e;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2025-03-10T18:53:15Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Tag=10,
 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA6PR21MB4231:EE_|SA1PR21MB4035:EE_
x-ms-office365-filtering-correlation-id: 1358c943-d90b-42c7-f4f5-08dd60056a6b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|366016|1800799024|7053199007|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?wxOXBvls6VLbIb86Rb7c96xZHoaDeBDoG1zMdnTCA0kCxAhewwv/e6mRBTT6?=
 =?us-ascii?Q?o5bPcS8OSXWoH0goHlmm3NDX4TIzHgYUt1bEOqvzmedBbBIc3MO6gpUBc706?=
 =?us-ascii?Q?/ey7xrNRuZ5q82o3DnY0ljCuHRTwpQD6KFAv0nR7lzc6tF3wveigfPgt9Oyt?=
 =?us-ascii?Q?i2VxcAQZar1OjiIGnxWjATesv+vNzcM6RpY3SxnRmFS3mJ+kdTHMjcQWQF+x?=
 =?us-ascii?Q?RncxqHXu4O4xBtpvB25EpeK3f8i+5wFfNxVfxZEOtWZqYeKntJpiuQCcRF07?=
 =?us-ascii?Q?csMfrmaJXs3T7if/dMphdHewlVj63g0Ldfp/y0hkTJXlViWU9Ymtnj1KIHvL?=
 =?us-ascii?Q?ifLRRR4JQOhCi30BbNfBjMf1Dxrxehv43qJtPpP99skbp7bF1Dtbp8M53oUV?=
 =?us-ascii?Q?isXp3SXiOQKA4JJ6vcqKbno3WpBD1WURjej1vbiqkVvjU8uAonS2YgvH+pBL?=
 =?us-ascii?Q?qnQtBN3pVXHVhDQiQO9lU+STRUrXR7ZHAva9KtMBGQloJwOZGTFuoJNwGhoF?=
 =?us-ascii?Q?/C+f4nTcwjmINUv4u+3iFfEBzO/eokdKwv1Y6SsaTmXHcNADS5kw3ZSaBxT8?=
 =?us-ascii?Q?CxGbbi19wwwR8v1zO795JFUIiirfDMtb5y0Kp/Ot3HjITLe6y+hz+4poLO9j?=
 =?us-ascii?Q?FokexWou2WHQicOwFjfYpp9W7fd8sbaxS5tUz+IEqf2xiwBtfqP1l53nC3B/?=
 =?us-ascii?Q?XqGQleeWNkPLjXVdeGHHWubAJzGiFvIvMJMcAt09LsN9w+cnQAylUfswuufe?=
 =?us-ascii?Q?ZJcbmZ83gOmP6i9y5c6DZFEh1J17IxzZKGzIJpd0GMHXe6lxE490vhSdxIB/?=
 =?us-ascii?Q?PRqcLbuEKpRnfiIbio+LM3CaiXLAI+cxsFF1TG3eLzCC0unDXnDx1CA3Sg3T?=
 =?us-ascii?Q?4lo6+n8FHbYxseojcdbrDBbBH6nkz6UPRRVtTUDwvFQo6fKDe9lC6H3s/rEm?=
 =?us-ascii?Q?0A68jD2oGWRCZH/YMjIiI7LZJEvkxo0gHfn7Yog/hm7QMtgwOirCbELkXZmr?=
 =?us-ascii?Q?zGPiD+Zq4+f7jqOINxN0XU1+KwSqhWlEn4RXMXTHtRAtc7husG0QJm19ciQr?=
 =?us-ascii?Q?5yghxFFRxSg0bZhoPPvgNQTw7cDbJMAME7QVbnjeDaL+eUqCKk//Y0/SY98l?=
 =?us-ascii?Q?lYCpi7ZR2EMX5BtJrugp3rjccaReMip642DaOeB1mwHFk7AiZ3PGfcBgAr/Z?=
 =?us-ascii?Q?VE3nbEfhcPLY4ZZA4HZUm69F/8dnHKyCGRR56/aMGMAOLCnM1mJIdmsWIR0n?=
 =?us-ascii?Q?XnmNGpv6TX+EtwMo2pbe7e0q5K4UJ8mOLcNgH8LJH3OkAI6d1n2FCWT315x1?=
 =?us-ascii?Q?O4dAFbalmJrOQV4G3khLgapN3/VnwIyj3UoN/0ktOjjCchCu8Tj7L23+OEHH?=
 =?us-ascii?Q?YgMIcFyVhqKedjsQFzPkiIvWQnvUqxnYvQl58uHavBE5WkdKdfUVOSRN5VNf?=
 =?us-ascii?Q?hHm0H8sWuCdPIznbTIFFrlvCMymHAZHU?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA6PR21MB4231.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(7053199007)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?hh6P5m8ZkvAENoz7OHFsmIwJg+8FyXLCiYvYoVeLa+UgV29gFqwR47Zcghss?=
 =?us-ascii?Q?5p2UYFVcWBhedwbwc4x5Y4Ilpmat6l1CzOfhp7LU3ylW3RyLaVr4Na/Z+ae0?=
 =?us-ascii?Q?dYcnv1blgv1+IdxqSgtbq5vThIeYtP4X3FK9uxBf1WoV1av7rIvfwaSX1vYU?=
 =?us-ascii?Q?flYvYdRAvm/1i5ys9nQZagC5QudY5yTze+t/fwqMUbavFflPoO6DYGGUPXiF?=
 =?us-ascii?Q?TNyRRHF/Yg8Y0V6Rd4Trhf8qTYaGdO8GjCl+zg68+lbbzOzbDGvbqwCL7J9H?=
 =?us-ascii?Q?nZrQx8sy6Ifdx+ekPsJJbKRYFeMEZLavvtbhZxjogmdSRS2fgXjdKTEamaqc?=
 =?us-ascii?Q?pGZDbBluY2dUTj0RD/80GwD/URCIUBSlq+HrzXzn/IJCzcewnd82esYHD4Do?=
 =?us-ascii?Q?awAhwfwYbTbLzUEkbg9tTJGVDdop8IX0h2gDuo84zNSXu6cnJVj0TDWriDqa?=
 =?us-ascii?Q?PK+y7KqCBxfSHIPL5SD2igEG6QvhRG1JubAeBfl/AIwfKeQ7i6BAYJq8nmQ8?=
 =?us-ascii?Q?b5zyqAOY/Q2NExx/e+39uW0zAht7VmlKDtapgLbt6VAAKxLpZZaqdJ2j2ZbD?=
 =?us-ascii?Q?hvlU/LqMrQemyEKVS1uvqGlhDGNEEMemvbnrrjWB275NGUVYc0qVXodQZlb8?=
 =?us-ascii?Q?i5SNDPlX+L9CwSCAjHexfjIUj0sRq4Jb7QMYpIvHY0/PwHDRVWGik4M7hzW+?=
 =?us-ascii?Q?9aP64CWEt2hIa9HZB9hGSqr5iYaR0DaCXFOIoM0NE8Zwk+8QFi7WQZHZZcKn?=
 =?us-ascii?Q?wgtPuuZHitqlpAjzq8BI538qYrzaFYRZrriq6z37uftQ1neEZQM9sX58KGFi?=
 =?us-ascii?Q?MZvGuS0+KD/0g/iqoRxKnawZ0TKkCR8d/W4gT9NKUw0eIS5ofEs9hug+59L9?=
 =?us-ascii?Q?u/U4LQnsC7MCy3X4BJ/RTcBw7sKBH8/RHi3aK7miev3AMZ7DtYc8AqmvslxQ?=
 =?us-ascii?Q?jWQZeGjJzDlFYNgoVdRJj4GBpKUlhNRLB+jQzSYVLuS//ilhbqa4JXFnqppC?=
 =?us-ascii?Q?E6sDdkVqGYYUcrDYSkCWUOGaHojIfdl92OWNvcRTiXspr4pRiDxY+fQ6PwHw?=
 =?us-ascii?Q?10/N+HI+o7jaNBcVdZ2h5LJBO1FhLTA4ALsuh4I8AFGl3/CK22nOWvRzlYl6?=
 =?us-ascii?Q?3w7L/SqC5n8EXH1Ed6zujmqhz22f0OG4vnKoRRNeAfZTUBxcDVOGPKwLAqRe?=
 =?us-ascii?Q?an4YS/awifTvRz0F0Hqi9GsonvpdFyO4VFWDKTec+tgMEDNy2Gq1PQzrtbX7?=
 =?us-ascii?Q?Sogh2fFWX9QdbIyYUOic+yczeSI5P5YhTmv5MLbRJxnCQzlIfhtul4t085Cv?=
 =?us-ascii?Q?wa0X5b4JZzzHC9Dn9uf400vMkrc9F2W6F9GuB2WUUmlBzNuHdPyChTm1vHQh?=
 =?us-ascii?Q?WTpfBs5a5wgCPu+TDGQRoF2RWLAnt1fNDq9VAoBIU6/mMuNmxMUm3DsSIuy9?=
 =?us-ascii?Q?bsoiyFRo61z58ODInb8AtDayQqDqUrAVJHbUxqt6fbM6QDYJBZzFEeW25qxw?=
 =?us-ascii?Q?CfQohBgzdBleiOG9I11sHJOHqspiqPey24yYqNYimSFN6kAQXYIokLvdq3R/?=
 =?us-ascii?Q?av17X7NP6j6wSQGB2VezvCF2+YJN96lknAQOISKV?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 1358c943-d90b-42c7-f4f5-08dd60056a6b
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Mar 2025 18:57:33.2478
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ycmA5fUEHX1Ww0fApromQ1cb7meduZ4Vnqwik285V0kTygwL4c2Fc2Hfi+18ye2JbqVxiNh8zgp8Mh21yYi6YQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR21MB4035



> -----Original Message-----
> From: Saurabh Singh Sengar <ssengar@linux.microsoft.com>
> Sent: Monday, March 10, 2025 10:31 AM
> To: Long Li <longli@microsoft.com>
> Cc: longli@linuxonhyperv.com; KY Srinivasan <kys@microsoft.com>; Haiyang
> Zhang <haiyangz@microsoft.com>; Wei Liu <wei.liu@kernel.org>; Dexuan Cui
> <decui@microsoft.com>; Greg Kroah-Hartman <gregkh@linuxfoundation.org>;
> linux-hyperv@vger.kernel.org; linux-kernel@vger.kernel.org
> Subject: Re: [Patch v2] uio_hv_generic: Set event for all channels on the=
 device
>=20
> On Mon, Mar 10, 2025 at 05:16:15PM +0000, Long Li wrote:
> > > Subject: Re: [Patch v2] uio_hv_generic: Set event for all channels
> > > on the device
> > >
> > > On Fri, Feb 28, 2025 at 02:14:14PM -0800, longli@linuxonhyperv.com wr=
ote:
> > > > From: Long Li <longli@microsoft.com>
> > > >
> > > > Hyper-V may offer a non latency sensitive device with subchannels
> > > > without monitor bit enabled. The decision is entirely on the
> > > > Hyper-V host not configurable within guest.
> > > >
> > > > When a device has subchannels, also signal events for the
> > > > subchannel if its monitor bit is disabled.
> > > >
> > > > Signed-off-by: Long Li <longli@microsoft.com>
> > > > ---
> > > > Change log
> > > > v2: Use vmbus_set_event() to avoid additional check on monitored bi=
t
> > > >     Lock vmbus_connection.channel_mutex when going through
> > > > subchannels
> > > >
> > > >  drivers/uio/uio_hv_generic.c | 32
> > > > ++++++++++++++++++++++++++------
> > > >  1 file changed, 26 insertions(+), 6 deletions(-)
> > > >
> > > > diff --git a/drivers/uio/uio_hv_generic.c
> > > > b/drivers/uio/uio_hv_generic.c index 3976360d0096..45be2f8baade
> > > > 100644
> > > > --- a/drivers/uio/uio_hv_generic.c
> > > > +++ b/drivers/uio/uio_hv_generic.c
> > > > @@ -65,6 +65,16 @@ struct hv_uio_private_data {
> > > >  	char	send_name[32];
> > > >  };
> > > >
> > > > +static void set_event(struct vmbus_channel *channel, s32 irq_state=
) {
> > > > +	channel->inbound.ring_buffer->interrupt_mask =3D !irq_state;
> > > > +	if (!channel->offermsg.monitor_allocated && irq_state) {
> > > > +		/* MB is needed for host to see the interrupt mask first */
> > > > +		virt_mb();
> > >
> > > Why is memory barrier not getting called for 'faster' channels ?
> > >
> > > - Saurabh
> >
> > No, the memory barrier is not needed. Even with a barrier, There is no
> guarantee that all pending IRQs are flushed when hv_uio_irqcontrol() retu=
rns. If
> user-mode depends on this guarantee, that user-mode has a bug. This barri=
er
> adds unnecessary costs when walking through subchannels.
> >
>=20
> Thanks for the details. However I didn't understand if memory barrier is =
not
> required why have it only for 'slow' devices (ie !monitor_allocated) ?

Because memory barrier is needed between setting interrupt mask and calling=
 vmbus_set_event().

>=20
> This change also removes the MB for primary channel (if it supports moito=
r bits), if
> this is intentional, we should call out this in commit message.

Okay, I'm adding it to the commit message.

Long

