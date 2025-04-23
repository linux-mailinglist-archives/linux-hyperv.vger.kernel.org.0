Return-Path: <linux-hyperv+bounces-5074-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D115A99942
	for <lists+linux-hyperv@lfdr.de>; Wed, 23 Apr 2025 22:14:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 08ED61B83B14
	for <lists+linux-hyperv@lfdr.de>; Wed, 23 Apr 2025 20:14:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E86CE2741B2;
	Wed, 23 Apr 2025 20:14:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="tkus0FV9"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10olkn2038.outbound.protection.outlook.com [40.92.40.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F40DD4315F;
	Wed, 23 Apr 2025 20:14:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.40.38
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745439276; cv=fail; b=CIHPtfB8bLLDptZ7/ptP4dMk5dfackcxQAE3yCxI0GPjSBIUTl4SM3yKX5QWF7E8kGgQ8l6YoL11YKRWzDQFJQrkXg1nyvksZxItZh2T3rWlJaYXq62G7Mk5SlgEFv3CjuSCmPOD0q9XZg3PQyLkkl4CYq8iSHWIcakkRkwf+UY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745439276; c=relaxed/simple;
	bh=h4D0rLgxFTYTG+Ysm5mBERnG7CI6h78age24ofjRi24=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=XKSElEAXUkVr4lSeNVdWsQ+PSZHOJJYrPV7tNx6lW6JswxRdXum6sFSZAGxJVybMbD2+H3YiB49wuLmk3miowBo5hi+fWAgQqykYU4sWIDwLrshbSN3ILzhYpY9CjXhrD7hCLNtdNzumvqN+PZ5kgeVhrUYmZKwd4/MWvNzo+Ks=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=tkus0FV9; arc=fail smtp.client-ip=40.92.40.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=leIWihCYlnqpMWhTbthvtSVvKROHiNEbM+ReTvHEyDbw7q84CcTJZOh6wJdd+7jq4v5748U5byXwgIL0RYUjNzYC7SKfylN3mhid12lWysumO/tVnkRsMzgCNfMnYXmBbze29/085UEd5JEwky0oaH1qIlgdv7odPncBIgNtZBapSUFaCgn2aksrTS2x0hrE5t/6f2Ipa22aitGY06duaN6uekMGn/2bpt5WJvIpWqepeJ3eAxSuIy8+Yi3T3HoiI9ASN2uOQhpt3z9RmHn8HA4wrHu4jcO3HYwoiWD1iS7Js4XEttxei88Pqxo0xWFkzcW09lKDNuzT0xjtiHqmGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bUyhvXJIlxZ5Jcx0lB24egl9wKpG41pXyxZOLl+f4F4=;
 b=pYIDikQEkZ1n5Bbm7+jubuyE3YwV8oimnmnosJQ9OjFUP0apFA01HFGc5OtOJspmYHZdCJG77b7kjmGMxG+PzxO4sMACz9/5sskK/EuWFJMSRbAebsUh8iKBGXW1jz1/uFFjhcRSRXxIdhK9ROf5cOMHWAXpAXw5J2hgIlM6MuN/V+L7xkot2ytohcPwFiTDg9wk96N+8W6KJ9kUcTRTXrbakZPIPfZbHbfFN/hScsos6EjIIm4vo3qG5VchWsSxE3m2gXq1mXEq2amKEtRT5U2UUirvSrQQ7WHmEw7LIbJL2Mk8Ny3+OcVu2mn8nsFQpJxRLZgokKfWy6dJgmkFzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bUyhvXJIlxZ5Jcx0lB24egl9wKpG41pXyxZOLl+f4F4=;
 b=tkus0FV9et+V0egrl0cxBtn1w0VzNfzn/shV6G2LUu03nlGQXTb5BLmn7m4rlbItkgA23+oujtNZwP4dffV1n1OCjj3/Ds2fw1egL3tAINOlfSYC6nIH43c7w9ZWa5bihYWuRAGEDzo+MGAqPfHcNQ8eynzzxgeIUuo+gwNfTrGIv/GR0M4nk57yZs6jdoYvzlP9c3V5Ohsf/Ob1bxX740QP3q0vwDk9le2kQg80PoedfSCFe9zsLTpTe1GLQ8OTGJsiRDxMtvdS/LdnytyET+eXicK3AlSqgh+YKYzaxmvlM3qcVQHfmQaGzbkOEC7In0m3zGwYeyZT9mrmmCeSuA==
Received: from BN7PR02MB4148.namprd02.prod.outlook.com (2603:10b6:406:f6::17)
 by PH0PR02MB7622.namprd02.prod.outlook.com (2603:10b6:510:59::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.9; Wed, 23 Apr
 2025 20:14:32 +0000
Received: from BN7PR02MB4148.namprd02.prod.outlook.com
 ([fe80::1c3a:f677:7a85:4911]) by BN7PR02MB4148.namprd02.prod.outlook.com
 ([fe80::1c3a:f677:7a85:4911%4]) with mapi id 15.20.8678.021; Wed, 23 Apr 2025
 20:14:31 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: Long Li <longli@microsoft.com>, "longli@linuxonhyperv.com"
	<longli@linuxonhyperv.com>, KY Srinivasan <kys@microsoft.com>, Haiyang Zhang
	<haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, Dexuan Cui
	<decui@microsoft.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: RE: [PATCH 1/2] Drivers: hv: Allocate interrupt and monitor pages
 aligned to system page boundary
Thread-Topic: [PATCH 1/2] Drivers: hv: Allocate interrupt and monitor pages
 aligned to system page boundary
Thread-Index: AQHbr/rwXw225NB9F0670E4RtdFKXrOsoFgQgAT92wCAABk54A==
Date: Wed, 23 Apr 2025 20:14:31 +0000
Message-ID:
 <BN7PR02MB4148D3E7BEB015390E813910D4BA2@BN7PR02MB4148.namprd02.prod.outlook.com>
References: <1744936997-7844-1-git-send-email-longli@linuxonhyperv.com>
 <1744936997-7844-2-git-send-email-longli@linuxonhyperv.com>
 <BN7PR02MB414817742F4B15AB928450E6D4B92@BN7PR02MB4148.namprd02.prod.outlook.com>
 <SA6PR21MB4231F82E3042311244A8A101CEBA2@SA6PR21MB4231.namprd21.prod.outlook.com>
In-Reply-To:
 <SA6PR21MB4231F82E3042311244A8A101CEBA2@SA6PR21MB4231.namprd21.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=2bfdd413-4300-4f6d-a850-8a697434bd94;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2025-04-23T18:34:38Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Tag=10,
 3, 0, 1;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN7PR02MB4148:EE_|PH0PR02MB7622:EE_
x-ms-office365-filtering-correlation-id: 390c27ea-53ac-4e33-afd3-08dd82a3753f
x-ms-exchange-slblob-mailprops:
 znQPCv1HvwU46ctkesNAQSdI89rGQphJKK7Is2TrQ46nu9ZF6UpXGMYLRI62sJZcdBOThsSUlULLHq7LMpozSDuKHBO9843bt0SFEQaQBEX68XzcFQsEEVm+f9whN1y4Iosd/8g5ODLOTn+o31wyYTEIl+lrtGaWfbvMOHzbggjJeYridqm0XcHNlaBwm18X2rjzFYTzmrEOGa5QfMQrVI8wl14isAhvGgGlRxtfsCnXfvEI1JrLDslbYZRqGak89e4obITuq8R/grjFwpQ8MpORyjEYn1UHMm4HdT8aLZSFKX/tJTl/Hp08EygXHv9k579M3Idj1rYILbHbMmPwlaQsxxGULbrY7QdEmCPkYOtVXeY7GfP3Bl+8S3kjsxZibYViq86lQbR7DpuZYFj2SOXgz3db9T42RxasN/UB4+q1YmZ3Nk8U7I9uuQyMN0tdmYIDs7o1zUjZcq81p3mCS3moUeqvoogb3LasvWXgwbxVIm7Aj3+v1pyXD8QIqjGHQSJuxsje0J7e/E+adzSOFdJohor3C12EqH1U2Svr6W3TwBU7vgGV7f2NmrfOUmu6CpL5T/bicB2zQegXfnTOW3nC9wGCFAshVhKZJvzMHCYcKzzGIRSf874DI8upM9Rt5nQvsgNmbik2cIUvBAJRFUA1l7x3eh51ZvvicYBGEQKGZSKv6Pe3Phlbl0slADxXt7DKh+gAXCPT/nenHIwedz6rpCt8BEev/sLJ3JziDZaR6M9D+sRHktRR4c2aUK1L9pDSExgizJw=
x-microsoft-antispam:
 BCL:0;ARA:14566002|8062599003|461199028|8060799006|19110799003|15080799006|102099032|440099028|3412199025|41001999003|12091999003;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?CBnOTgE75UTdtnoCyhXyFm957+Bn4RCOqpu0L+J3gCMdTBCMCftYZpfDzW3x?=
 =?us-ascii?Q?zj+oeZomabuGosj8tr9har08CWNgcpjXc/Oa6jj7MdsSH1l0DdBFEx5pD6iR?=
 =?us-ascii?Q?ZQirhHc2gjgygjYhbSOHM8mpuEgbBuCWgK4Yddt0J5ALv8ehtmvrF8/Tx4Fm?=
 =?us-ascii?Q?Wpn4cLxG/zhWctcyEIAmSHXCgOFQNjkxuMk0iGNn2zLgT6bAFJMoQezfItKR?=
 =?us-ascii?Q?Oo6cWYnWMT+W2PUWQ2xALSyY4GuRvF2BlFRyLplQifzaZ1SMx9rJm3inihwe?=
 =?us-ascii?Q?ZKHAX1IMR414k6/j51HOZn11uJ0iO5/2TahUDZWKJuJMkpi2tQYuaDvTwFa1?=
 =?us-ascii?Q?VFPogWHwYG15Ts0+BKHTVN2omhNE0P6vu4P+MgIiGVPrTMuM0VN2kw7TfQx4?=
 =?us-ascii?Q?UHTKhLbYTk3k4rgjD74UQGEDZqMXdvoD2ic9PoryA4M7sObqf40B1sm7a+9y?=
 =?us-ascii?Q?yAbA8HRol75Z0Ce82l2W9lOZ3PHawwmoY7VuadzbKlE5zByYVzt1J1YMnQ9E?=
 =?us-ascii?Q?tmJv17dtSc7GGwMiuEH7fqBz9bc9g6L+xSJv5jOnbLOvAAltlma7YvDGj+Kn?=
 =?us-ascii?Q?gQX3RWVp0Z/cOiXHutGke4oW0AhRVyPxuLdLKUvZUV758uj1YsX2pzfEwqB4?=
 =?us-ascii?Q?2/iAHv7gy4M+DCJzk4oQi3GCJRbicZkGv9ZkapaEwVYL+9e3kZ4BMdw8EBrv?=
 =?us-ascii?Q?vVfBOX25oZ0BvNoFgbRObDUDii1VjdZ+/FGNWyyQRf4AgfeRZhTvIyovUsVP?=
 =?us-ascii?Q?qCk0Bjb40v5J5ZqUWGaEO5c2Nqr7zn+0hlUZetAmz7/keSMBPeEuF1jMJqVT?=
 =?us-ascii?Q?fAEQUaFP7OJReBkYGiJ97sIZEJfM6bydG9RAZpMNS+oZ8X/YLNq+tO2/aIEs?=
 =?us-ascii?Q?3rBmpHzyQm21lQDu8RIhNofyItWgyLwBJaRLjj/+Hgu32zX5piHwd8pbcM0N?=
 =?us-ascii?Q?PWUKtR8uUeOKINDeCriGh/E+3vMzgTnzBi1BcZKJLhr0LJlDPj8LXuWXufqt?=
 =?us-ascii?Q?t/p3FmgN6wlhe5zWCg+jgFpp/KnfB1XtiLM/+DcKJpLi4+obTdxy62WmsdPG?=
 =?us-ascii?Q?nYNztZUhtv1mwQZEThwuJ0br3ZMEOTM8io8MDBWE8AfHrxZ727uLRwGZ5/EX?=
 =?us-ascii?Q?CNKKzntZ1vXUs+TvBkvL2T6entKL7wuM7A=3D=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?1yul+FQJxdt9SI8C4wHfKEbhVoigIxHhdH7iZniqZAKbDqG7qPMtQJUbx1cL?=
 =?us-ascii?Q?k7R1NjK07fMUZtzIy5j6ksVY2Zax+pQKtwWRQ7T+XdbKkm9xYnbuWPpdgcQi?=
 =?us-ascii?Q?OZj0UoO7p0Q3rAoMgYnjMTDxGq/yWacuKWRp16oiJW9zLzQ4M2S51GCUR5M4?=
 =?us-ascii?Q?zLj1cMVQP+RC19zJdUPIT6VdFDYTUkwAXAPsLBlkl99B9qNthjcRrb3hTTI9?=
 =?us-ascii?Q?8oTd3FbNosVkI6wYNGuLH+Q8XTVlIvjrQzuFQJvTEjn7RtkgWRl0uNZw7G+8?=
 =?us-ascii?Q?5MfUrPyjV4zJi49yJLRa2txihNxerykt2KJ8/gWAdmb0EGzyF0tnycWUelEP?=
 =?us-ascii?Q?MSLNqsHaiVufM+3wYN+ThS7nUYBhURbpTgaq0lGKCsIzJ/hKaDAocm3hZJ62?=
 =?us-ascii?Q?ZZhVW0c4VQc5JuujURtSlb7Q523x3ZciBXaibJqqJepeLMpr77BlDpEf2AMZ?=
 =?us-ascii?Q?HfL/Wz3Ux3H8rWQXOdCDxFjXMEhVsQ7cOfWZc7fL6tP7EuQbOXujZu6Oue1b?=
 =?us-ascii?Q?/Mtl6+XHSqMhEKe22DafddyTS1+lt6bpOmye6Fxov8Uc/ZNDZ6JKqwYq3o+U?=
 =?us-ascii?Q?hzXq4hbkpXcGzkv44TbrHWtig8hZX3nrAvG/E4Bs+utKm47Vxm7Esd3b6G4t?=
 =?us-ascii?Q?AstKaOSAmRR6evxfEHgK06p3H71H6gNY3ad/+6CfDW06jdlqyWUmUv4VHUN9?=
 =?us-ascii?Q?TBQrJuNy34RbH7ajgekyPvlPZhi6zW50mkZF3yV13qo2zE87S8ygUh81CegL?=
 =?us-ascii?Q?bX1Pd4Ur5q4mjzXFxzc9/246vlmxSHBbqNY9wFkyL+z2GnvcaKdBVLQdHeat?=
 =?us-ascii?Q?b9rWJOgrKZYPtA0t6J+lxm9quUWwjvDKrBp2cRMoUHAw4vqMQTgueI0hkd3H?=
 =?us-ascii?Q?DqBW6PNbTHqJlqfttCPQi7ecO85Enn9DQJ+phBtkkhH8XFyIsFDhCVIgbj/G?=
 =?us-ascii?Q?+UXYJ8ljHQP+jiXvEJRe5VZqD0S2E20i9DuRmZOVHc0u6NWq+sQPVfhVJZKU?=
 =?us-ascii?Q?VW7yrkJ5Q7hlH9I2rjd7zcD1g4R3zmFiuOx1L9wIdaXO9saPU3Nru9PqvOxT?=
 =?us-ascii?Q?SufvPD//NcEBjCmpwWf2u93KdpMhy/IeF0cel+Vh08OyLkMO74yrh/MV8Pr9?=
 =?us-ascii?Q?tnBv91xt/6XGkxKKDoalVYK8XQSIscmAoWgyxq+d7F1khoJHq1QVJmLFBreo?=
 =?us-ascii?Q?tF+BBZONR9eVbnKV/hDBEkxNaLBJfeg69MW3T1pZig4W+gTYka7IeNb571Q?=
 =?us-ascii?Q?=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN7PR02MB4148.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 390c27ea-53ac-4e33-afd3-08dd82a3753f
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Apr 2025 20:14:31.4627
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR02MB7622

From: Long Li <longli@microsoft.com> Sent: Wednesday, April 23, 2025 11:40 =
AM
> > >
> > > There are use cases that interrupt and monitor pages are mapped to
> > > user-mode through UIO, they need to be system page aligned. Some
> > > Hyper-V allocation APIs introduced earlier broke those requirements.
> > >
> > > Fix those APIs by always allocating Hyper-V page at system page bound=
aries.
> >
> > I'd suggest doing away with the hv_alloc/free_*() functions entirely si=
nce they are
> > now reduced to just being a wrapper around __get_free_pages(), which do=
esn't
> > add any value. Once all the arm64 support and CoCo VM code settled out,=
 it
> > turned out that these functions to allocate Hyper-V size pages had dwin=
dling
> > usage.
>=20
> There is a BUILD_BUG_ON(PAGE_SIZE < HV_HYP_PAGE_SIZE) in those functions,=
 but it
> probably doesn't do anything.

You could move the BUILD_BUG_ON() to vmbus_connection() where
one of the calls to __get_free_pages() is made. That would codify the
assumption that __get_free_pages() returns memory at least as large as
HV_HYP_PAGE_SIZE.

Michael

>=20
> If there is no objection, I can remove these functions.
>=20
> Long
>=20
> >
> > Allocation of the interrupt and monitor pages can use __get_free_pages(=
) directly,
> > and that properly captures the need for those allocations to be a full =
page. Just
> > add a comment that this wastes space when PAGE_SIZE
> > > HV_HYP_PAGE_SIZE, but is necessary because the page may be mapped
> > into user space by uio_hv_generic.
> >
> > The only other use is in hv_kmsg_dump_register(), and it can do
> > kzalloc(HV_HYP_PAGE_SIZE), since that case really is tied to the Hyper-=
V page
> > size, not PAGE_SIZE. There's no need to waste space by allocating a ful=
l page.
> >
> > Michael
> >
> > >
> > > Cc: stable@vger.kernel.org
> > > Fixes: ca48739e59df ("Drivers: hv: vmbus: Move Hyper-V page allocator
> > > to arch neutral
> > > code")
> > > Signed-off-by: Long Li <longli@microsoft.com>
> > > ---
> > >  drivers/hv/hv_common.c | 29 +++++++----------------------
> > >  1 file changed, 7 insertions(+), 22 deletions(-)
> > >
> > > diff --git a/drivers/hv/hv_common.c b/drivers/hv/hv_common.c index
> > > a7d7494feaca..f426aaa9b8f9 100644
> > > --- a/drivers/hv/hv_common.c
> > > +++ b/drivers/hv/hv_common.c
> > > @@ -106,41 +106,26 @@ void __init hv_common_free(void)  }
> > >
> > >  /*
> > > - * Functions for allocating and freeing memory with size and
> > > - * alignment HV_HYP_PAGE_SIZE. These functions are needed because
> > > - * the guest page size may not be the same as the Hyper-V page
> > > - * size. We depend upon kmalloc() aligning power-of-two size
> > > - * allocations to the allocation size boundary, so that the
> > > - * allocated memory appears to Hyper-V as a page of the size
> > > - * it expects.
> > > + * A Hyper-V page can be used by UIO for mapping to user-space, it
> > > + should
> > > + * always be allocated on system page boundaries.
> > >   */
> > > -
> > >  void *hv_alloc_hyperv_page(void)
> > >  {
> > > -	BUILD_BUG_ON(PAGE_SIZE <  HV_HYP_PAGE_SIZE);
> > > -
> > > -	if (PAGE_SIZE =3D=3D HV_HYP_PAGE_SIZE)
> > > -		return (void *)__get_free_page(GFP_KERNEL);
> > > -	else
> > > -		return kmalloc(HV_HYP_PAGE_SIZE, GFP_KERNEL);
> > > +	BUILD_BUG_ON(PAGE_SIZE < HV_HYP_PAGE_SIZE);
> > > +	return (void *)__get_free_page(GFP_KERNEL);
> > >  }
> > >  EXPORT_SYMBOL_GPL(hv_alloc_hyperv_page);
> > >
> > >  void *hv_alloc_hyperv_zeroed_page(void)
> > >  {
> > > -	if (PAGE_SIZE =3D=3D HV_HYP_PAGE_SIZE)
> > > -		return (void *)__get_free_page(GFP_KERNEL | __GFP_ZERO);
> > > -	else
> > > -		return kzalloc(HV_HYP_PAGE_SIZE, GFP_KERNEL);
> > > +	BUILD_BUG_ON(PAGE_SIZE < HV_HYP_PAGE_SIZE);
> > > +	return (void *)__get_free_page(GFP_KERNEL | __GFP_ZERO);
> > >  }
> > >  EXPORT_SYMBOL_GPL(hv_alloc_hyperv_zeroed_page);
> > >
> > >  void hv_free_hyperv_page(void *addr)
> > >  {
> > > -	if (PAGE_SIZE =3D=3D HV_HYP_PAGE_SIZE)
> > > -		free_page((unsigned long)addr);
> > > -	else
> > > -		kfree(addr);
> > > +	free_page((unsigned long)addr);
> > >  }
> > >  EXPORT_SYMBOL_GPL(hv_free_hyperv_page);
> > >
> > > --
> > > 2.34.1
> > >
>=20


