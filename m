Return-Path: <linux-hyperv+bounces-5072-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F0EC7A99820
	for <lists+linux-hyperv@lfdr.de>; Wed, 23 Apr 2025 20:49:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DD5F71B844D1
	for <lists+linux-hyperv@lfdr.de>; Wed, 23 Apr 2025 18:49:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53E1E265CB9;
	Wed, 23 Apr 2025 18:49:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="Z6VanbSf"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11020141.outbound.protection.outlook.com [52.101.56.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85244101F2;
	Wed, 23 Apr 2025 18:49:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.141
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745434152; cv=fail; b=YvZvMh1EqCcUCogAMIvvkiaIuvXV1+iAUA3Y4Rbds48W0KFeQwsS4U1+I0Ha0Qgj6nzpUw/zwI1ozT3fLnYxGe6JnovZAQ/9tUdJopu2iOLyIHP/UWVLFo2ff+pZb8zMwo4JWA0BWgNVQPi8aBsup5AdxHMPHlwjBcyyTLEdfw0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745434152; c=relaxed/simple;
	bh=fYmZr8kZ8u2r4qR8EF3AU+6pPK7f+jYzdG/PnkWScII=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=FK32XtOv+E7pn0c8227QAee36kK2E73EK7+GFExKg0HHax1HOfIoiLBJSq1ROo7J/yZYR6JAxTtJCq3yiC7ngkykwa/g3NZNMagjYFEY5elrQQN4eG7XPE2btOnwVIzBwRcAWWrp3ADbrv/BGZMh/AODq5Zl45f+JE9TqB50rW4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com; spf=pass smtp.mailfrom=microsoft.com; dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b=Z6VanbSf; arc=fail smtp.client-ip=52.101.56.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microsoft.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SRyHvrAcrNasVTc4K1/SMRhmvRabKBPWZ2wJlhWXAfT2dScyTUK/vQxr9nuFtJg/MUfhNSMIcsEV/SDAxx3gp3BCMtGjJO3/32FI8t4JcQn+9Uj1/h1oETBQYhKsRddiLLu27iH3saYqMPDjbCo3TqV44Nwd+eReWF2ym1hJ7c3DSbdQyiKO2VZUThcEp9Ge9IhIrxL+OwjUOi/vDNm6VpeqE2R5k/Azah1A1wWYTGSu23nH3ghpU4N2RHDPo84yUvRgN53PfeMepmjbaTDRWkP4oMxaIIIbK2Cx4k/x7sgZZQU3+2PNVVnndZRbkcj3B/6lgQTyVoSeuxQaS1BU7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JFmvduHMu49IPsYU83FUeMSUsuEzOjroQIgNT+7/TJw=;
 b=g5HLqKglkNcvNS1fIE+yGZht7GuVEc2woO1anm4uUKN8Sil1ktLsMtwVXyegKgIdiTTzJjme5GGnt9Zx4aFT1iVac1hXN71eEDXpEeu0DRDKfsw4t1GE5r3h38qom7LaEIKQsRu5DB+QksnfRHGYTX/Bdaj6RqGlzsNk3KLnpX0kJSMEhgGOhsSSm6zFMn7v6jze8Igb+zYRCWbfSW4xzm5xDVEkRyPx5Pz30qOgQ0YDLAx9vh7ZRENj2sFnmK549TpA/lE2Kh7hqitWa6Grb2HCsoLYvSPxE8BP7tkd1/5+EVrvfzu9E0XoLKu7QyZoXZBqKvZyrWfcskhiCOn3yQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JFmvduHMu49IPsYU83FUeMSUsuEzOjroQIgNT+7/TJw=;
 b=Z6VanbSfHuTsQwbgydsuc0wg2Ptx70Kra0XR/sbjfLj424j7uh8eYZTLNAvV/oQNYJ0Q5avhc0Ur6FcKg+3F7JSn0wxLH8SmFWwehVs4sSPdFwZdW8KrLHMFKs/4ySe7AlsSpy1e5VLLDLSbqx2r9R0RGyYh6Xn7fO5L623N/fU=
Received: from SA6PR21MB4231.namprd21.prod.outlook.com (2603:10b6:806:412::20)
 by SA6PR21MB4183.namprd21.prod.outlook.com (2603:10b6:806:416::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.4; Wed, 23 Apr
 2025 18:49:06 +0000
Received: from SA6PR21MB4231.namprd21.prod.outlook.com
 ([fe80::5c62:d7c6:4531:3aff]) by SA6PR21MB4231.namprd21.prod.outlook.com
 ([fe80::5c62:d7c6:4531:3aff%6]) with mapi id 15.20.8678.021; Wed, 23 Apr 2025
 18:49:06 +0000
From: Long Li <longli@microsoft.com>
To: Michael Kelley <mhklinux@outlook.com>, "longli@linuxonhyperv.com"
	<longli@linuxonhyperv.com>, KY Srinivasan <kys@microsoft.com>, Haiyang Zhang
	<haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, Dexuan Cui
	<decui@microsoft.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: RE: [PATCH 2/2] uio_hv_generic: Use correct size for interrupt and
 monitor pages
Thread-Topic: [PATCH 2/2] uio_hv_generic: Use correct size for interrupt and
 monitor pages
Thread-Index: AQHbslAqu1t1oBzgjUe5A6DI96oIBrOxmeAA
Date: Wed, 23 Apr 2025 18:49:06 +0000
Message-ID:
 <SA6PR21MB42310EAD1D095D16A6198467CEBA2@SA6PR21MB4231.namprd21.prod.outlook.com>
References: <1744936997-7844-1-git-send-email-longli@linuxonhyperv.com>
 <1744936997-7844-3-git-send-email-longli@linuxonhyperv.com>
 <BN7PR02MB41484C3B916A6D1DA7297277D4B92@BN7PR02MB4148.namprd02.prod.outlook.com>
In-Reply-To:
 <BN7PR02MB41484C3B916A6D1DA7297277D4B92@BN7PR02MB4148.namprd02.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=fecdb32a-b7c6-4ead-b81a-11d46ae77304;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2025-04-23T18:40:57Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Tag=10,
 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA6PR21MB4231:EE_|SA6PR21MB4183:EE_
x-ms-office365-filtering-correlation-id: 92e6e77e-6a96-4faa-5a7b-08dd8297868b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?QtZR1dBf5L04WYpFsL3OectKVUz1WCiudyX/d3fyb/b8mjr4tSbJnPSUGO2C?=
 =?us-ascii?Q?NqMpxRzltDcuwYP2EtpqiYYk5TDoRM+lwM+x5sQWFz7FTgny8QuDEqknQChE?=
 =?us-ascii?Q?VPuJxp7lIUWJmL0B40qU/Ie2N0SYwCHv78rcT2QjwnxDVFddiXEjw4Of3fXs?=
 =?us-ascii?Q?qHifBOLSsAFYur2CRwVJT58YrFucdut41iIReOOiV5S+nJRQhCzCUSRveT4u?=
 =?us-ascii?Q?c1BdAjDyUxyAKtrTirxEcSnQDKw6yIKwwaBXzLEvgUKVNXNg5HvEovbvBO++?=
 =?us-ascii?Q?Koq/3bOesw4jxY7xGFoGuqyjYY5f6OkWK65G3ziTB20egJHgEhUAO0wEt+8u?=
 =?us-ascii?Q?T+aejloRINXMGj1dC2k88+EA8ngYgun7yrxOiTY+JZ3L44pmgzqtl0n3++f0?=
 =?us-ascii?Q?POJAo7BoaWvsFBqV5UmPvTfnp2rsGAMSB1Lil1WfIoPElmjSBcyDbW3TVnbq?=
 =?us-ascii?Q?noI5jbaHySRWNb2peVdf+v9WRq+PZkO3JWH1RktWNInfRm462GiqTgHVHZJn?=
 =?us-ascii?Q?txwBiqC92q4zgi3F5vGx/PIUq2+qiPuROTpe9Z0HHD2ruQNA8a7ehi94aA8E?=
 =?us-ascii?Q?EKREObpMvO56i1HPUuPCvLolAV6kA5vR98E+jzLfHS6Tb8ByTIj5eJ+y+4GK?=
 =?us-ascii?Q?ikWjTd+aZaLWQ5pj1Vk3CkHP1englFJZMnfh5EAjRDrSuLAiHx/nHi09lvcB?=
 =?us-ascii?Q?6M5kaMniyRhg9leqD0Vp6vr6qCqZk9VxY7Gxi7N9IBgPZPMtfXudEqUzFLbn?=
 =?us-ascii?Q?P+3LnDZq74KooNyPb1RynzA2dj8XeoXQLx0TQsTkuArrPrFHY8PklolyumXF?=
 =?us-ascii?Q?DnkH7FUAdO9EdbiEXIaS7I7cx1jW8EYtI9brMwXYKIjRen4KTTBLXONUiRmq?=
 =?us-ascii?Q?R7Taf5Bdaj64gwBAe0O02cMELujkwOBmuroR7uI+dOIIhQXkgYwlmS+0J+aa?=
 =?us-ascii?Q?pun6kIdaJeHar8yx6G30uZTLszad6gs/sK5lpqkIcFwBHvGYebGzmTB38gEW?=
 =?us-ascii?Q?i/76ZE/Xb+aGFU0pSM9RSCfCjtxIxKWcRTKfETp6XcXWFALpn8MyGQ3U8RuI?=
 =?us-ascii?Q?x/VpO+zMu4QWx+9i474x0HX0u2B3fFoQIhq9pgAd0DbpEoB73LYE2X49ni+z?=
 =?us-ascii?Q?Fpl7Gd+4ApJtbnOTugA4pQLHs0Cl70QwXKj0DHRMO8WYuG8kkr0M0QP3EZJr?=
 =?us-ascii?Q?b6Cq9/SGRs6naz1i7Z0vlcjRwxpwryhrGQFrv+DcA2bAmZbbh7v4tOxkWprk?=
 =?us-ascii?Q?rbjErOfo4kFR1aVomLimfs7x/O6v6wTx3ZFfRS7UkAGVlBUdpCoWZ+NHrZC6?=
 =?us-ascii?Q?OTW2ITgYLqs7QQ7kdkfJbFHf0ceUZRZzJviJ+PGF3Lxc8atkqJkU/cosPmeg?=
 =?us-ascii?Q?CHliZa66hsOgEcokL09t/lIQnrczQIGPq7+jjnMf2WKbxXSCx6cu9xxTAvNm?=
 =?us-ascii?Q?/XkoCO6aL4Kt5aVv0iKugSaoCQ8ypuAeYa1mZdzc46qnD3EvO+qGnPqKmbwm?=
 =?us-ascii?Q?SMCIGmW4ic/rRUE=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA6PR21MB4231.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?HX1MxRP/gscNGQvm1gJlQbUw24kHY1FMt5lC4X/6+aldzITRW+gIY0Nv8fNQ?=
 =?us-ascii?Q?a2Lh15gpwkT/3KKUFUvnaeN6LMCXh/Ks2luc09zoe5NcLo4WLtPdaSTFxH5A?=
 =?us-ascii?Q?lftpGG64kzLHcjrQV4Ulquf8z+WScg7W2Thi80n46gg7hZOl0Tr+O4S0OOxn?=
 =?us-ascii?Q?S8dAPYdKvOO5PF0731muqyQqmRPKuUFHZaUf4g6QNkgevYmGZ6orHlOPP6QR?=
 =?us-ascii?Q?AV08ij7vb0A0aLSqMDFnXz/jDL5ZP/lVAqPv9/pFShKQAi/MEnmq1UDhtdDN?=
 =?us-ascii?Q?hj5YZ3UCIqtyGQ9PWaKg0YcTOP1jwsMOAhEmLJv92V1J/hIx3LA7NJtN2tX0?=
 =?us-ascii?Q?9dINPSyQMRoZ8jeQyqwFQ7X3AOguF+RNSG2waE7B+U7kJNiTBb/o1CunxaJ/?=
 =?us-ascii?Q?o+I8cFfaE7SlsHP1Bfkr/90SaeTE12tv+ABZ0daOFPq9jMdJbTU6yJlFY6eP?=
 =?us-ascii?Q?ThFFR18P3EAS1SVRYT+mobRu14/+rmIPhvJknmGCs1qCrU6ZHW35dngSUV8/?=
 =?us-ascii?Q?jtF6qqmxMTmmKCnkm+Tp64V6yEJEWoc7YMocfUNjwj+QatoFH0zUP3ScMz3t?=
 =?us-ascii?Q?AhntAAj2iVcqulc3HVe4XRnDsaYyZ1pAGTjA451zwHUkyJkjloWcPggmN07J?=
 =?us-ascii?Q?xMePqxJIbXtn+ilkRGQpl2MBbfiQ2KWkioiQEFv7so5zXu+FQrWe47cUOP/l?=
 =?us-ascii?Q?rcsUZIViQ2oriTG/Xg1HYgLXBKhkQyt9kW9BCD8BFYXEZRICNzQde8MegVn7?=
 =?us-ascii?Q?a17SKsm7b1p9TVLRN7LpnQXqRzKNa2TPzgpFjzeucOT2I3qSXqEFU5NRGepr?=
 =?us-ascii?Q?IzaqH7az+0QTD3y5bZABGd5oeDuYBEmO4UMYKd0DJLmxZbQkDPdIr+ZmTWyt?=
 =?us-ascii?Q?TahbylVqoBiGYV8ZT3Nz15y4SOoO4DU1yasSvHn9pvO+OPk36zhjEwTmMloM?=
 =?us-ascii?Q?DTAe8QYVOVruzzRsHobqzZLXMqgYQAyOLT1VinZt8lq9q5oTzrK0DOgCEcO4?=
 =?us-ascii?Q?f/sxPs1HMcVWiz+zP88IKKf2s+wYilEyaJjqqIepnv8Vawgy68jXrSIzG/n8?=
 =?us-ascii?Q?0xOuDzOyxKE5zjfbRnBdzOVki3wbeUPJTg4nbO5+Wk2CajIOsU9m/bA/USCd?=
 =?us-ascii?Q?bwxu0Z01wbruLxTCojovapZs6WT/46r6+byfM0TiQDjEBmSIEo2KN20R9B93?=
 =?us-ascii?Q?GtN8FBIdTiO0JKvBC0kAFYuMTv6X0PNE0Mjmcu/ZTWXUPvauYSaVXhOTujmq?=
 =?us-ascii?Q?F8Km7yM/ZyD1YgC+8DyChPvyBfUaAxqD7rj8FLhHUCdBAquYYQOgB8d0qKdh?=
 =?us-ascii?Q?GZeUO/zJcWjIsralMsnHX+mNA7iYw4p1qo+EFdPhPgLrvQ/VaSEOSg3fIrel?=
 =?us-ascii?Q?2B4X21W05iLtJFWN6o1XIz25x8i8g+AuEW1lxM8kbUSH8fF+6thNd6UKx2Hq?=
 =?us-ascii?Q?EzBaYz/DTk1oslZEh0bboEXDBvABDrP8Is6LgfkPTSQ1bEuu5/Wl2QMxjrNy?=
 =?us-ascii?Q?UoNAkx7f4SetpmaxKvHfqYBGM/NEZdpK6HgV4xruEbHtIVdJapSiwMNNqVJt?=
 =?us-ascii?Q?k+la3Ekh+317qzxJRu+r8zrU0QzDFWdSvKJ+h/rP?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 92e6e77e-6a96-4faa-5a7b-08dd8297868b
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Apr 2025 18:49:06.5271
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: F+Hpvd9tXjDZzGM9WG//ihvup6TL6RkmtvFu2RJVy2XOPM3oPjKpLF+pzPAigWfxdXRiNMjLJ4FAKthQnoklEQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA6PR21MB4183

> Subject: [EXTERNAL] RE: [PATCH 2/2] uio_hv_generic: Use correct size for
> interrupt and monitor pages
>=20
> From: longli@linuxonhyperv.com <longli@linuxonhyperv.com>
> >
> > Interrupt and monitor pages should be in Hyper-V page size (4k bytes).
> > This can be different to the system page size.
>=20
> I'm curious about this change. Since Patch 1 of the series changes the al=
locations
> to be the full PAGE_SIZE, what does it mean to set the mapping size to le=
ss than a
> full page (in the case PAGE_SIZE > HV_HYP_PAGE_SIZE)? mmap can only map f=
ull
> PAGE_SIZE pages, so uio_mmap() rounds up the INT_PAGE_MAP and
> MON_PAGE_MAP sizes to PAGE_SIZE when checking the validity of the mmap
> parameters.
>=20
> The changes in this patch do ensure that the INT_PAGE_MAP and
> MON_PAGE_MAP "maps" entries in sysfs always show the size as
> 4096 even if the full PAGE_SIZE is actually mapped, but I'm not sure if t=
hat
> difference is good or bad.

Kernel needs to tell the user-mode the correct length of the map. In this c=
ase, 4096 bytes are usable data regardless of what is actual mapped as long=
 as it's >4096.

The DPDK vmbus driver uses this length to setup checks for accessing the pa=
ge.

Long

>=20
> Michael
>=20
> >
> > Cc: stable@vger.kernel.org
> > Fixes: 95096f2fbd10 ("uio-hv-generic: new userspace i/o driver for
> > VMBus")
> > Signed-off-by: Long Li <longli@microsoft.com>
> > ---
> >  drivers/uio/uio_hv_generic.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/uio/uio_hv_generic.c
> > b/drivers/uio/uio_hv_generic.c index 1b19b5647495..08385b04c4ab 100644
> > --- a/drivers/uio/uio_hv_generic.c
> > +++ b/drivers/uio/uio_hv_generic.c
> > @@ -287,13 +287,13 @@ hv_uio_probe(struct hv_device *dev,
> >  	pdata->info.mem[INT_PAGE_MAP].name =3D "int_page";
> >  	pdata->info.mem[INT_PAGE_MAP].addr
> >  		=3D (uintptr_t)vmbus_connection.int_page;
> > -	pdata->info.mem[INT_PAGE_MAP].size =3D PAGE_SIZE;
> > +	pdata->info.mem[INT_PAGE_MAP].size =3D HV_HYP_PAGE_SIZE;
> >  	pdata->info.mem[INT_PAGE_MAP].memtype =3D UIO_MEM_LOGICAL;
> >
> >  	pdata->info.mem[MON_PAGE_MAP].name =3D "monitor_page";
> >  	pdata->info.mem[MON_PAGE_MAP].addr
> >  		=3D (uintptr_t)vmbus_connection.monitor_pages[1];
> > -	pdata->info.mem[MON_PAGE_MAP].size =3D PAGE_SIZE;
> > +	pdata->info.mem[MON_PAGE_MAP].size =3D HV_HYP_PAGE_SIZE;
> >  	pdata->info.mem[MON_PAGE_MAP].memtype =3D UIO_MEM_LOGICAL;
> >
> >  	if (channel->device_id =3D=3D HV_NIC) {
> > --
> > 2.34.1
> >


