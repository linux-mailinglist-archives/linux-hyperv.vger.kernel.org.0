Return-Path: <linux-hyperv+bounces-8473-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UF3gHBJ3cmn3lAAAu9opvQ
	(envelope-from <linux-hyperv+bounces-8473-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Thu, 22 Jan 2026 20:14:26 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A67A6CEC4
	for <lists+linux-hyperv@lfdr.de>; Thu, 22 Jan 2026 20:14:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 2BDB73003BD8
	for <lists+linux-hyperv@lfdr.de>; Thu, 22 Jan 2026 19:14:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00D2A3904E2;
	Thu, 22 Jan 2026 19:14:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="PUZPWN43"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11021078.outbound.protection.outlook.com [40.93.194.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E34B374739;
	Thu, 22 Jan 2026 19:14:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.78
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769109258; cv=fail; b=qKLzNu8V6/lWcKllx8gvRI8QFIb61YsGA80v/VovMr0TUQ1iYw5nLZr17HexAXXGBglrFl3PT1LidSdpJ6LAehu3kxG2ZNRIWyK0vzEcDvzbKO/Gh578OjCcxZNBJDXaGdbKfxI+jOsshpBWMLoII6U0G+wohjy/ZUtd7VGJKVg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769109258; c=relaxed/simple;
	bh=amOd8hA+Hkj91zgKN5wmY8cSJFkKaZH05t26qYCRaBQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=topzpckiCnDgam6GmNP+tPJZe4dBe08+80/OZHGxXmOn0vQQBM32gJ+5T2She9dJFuLPGIEIt2Bt3Mv3EET2FGU+tguKO+GRY7PFkqBVuMxAfVQV23NyxXrzgHQM5UKaDYvzLZYCsMpu54IJSUjvKUblDtLlleFSIzuTVlEdNks=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com; spf=pass smtp.mailfrom=microsoft.com; dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b=PUZPWN43; arc=fail smtp.client-ip=40.93.194.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microsoft.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=k0+0G9WAJy7ANQKbAGMpt4knfEn/kuD9PHo8zPlxcdqprOqcgH176qdrIY7PJ2LCti4iKalb2KjnhDoN25ZAtAetNI2y+spAakxxiJ6WGl3k7osz8HMqpnV/cbv1JtHH47o/vPynSqW9wQVVuX6aILPIPaqUE2Lo10r5ZBqSBbNe49LMSLsioKVWIWdw6zTvyMMVgiKKpvMNTSBzueB64OnuL4LkZi/rNJtDRaqsu1yZDDzO/10YCRO19R0dLTWqwfjGADJgSgRQLM2d+E6GPcPNUrc+XEvOqLQOpAvyUMFmsRZOT5LN6WgaRtHWgBGhgbEd8LhscFhmkqji8nRY5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0wM/uISa1ZTicUtslFYMtbkdcy8EFf6MbYe1hnlMZDg=;
 b=YjSr8vZR28TBco1pViPjRbQdRnps18SVu6o7c4G9kYGceQ0XN1q4T4TmwytPdrJZwA6LuDD7Qj1qb/E9V+hM52GPNwxyIMZ3MFmym5oczdu4FGxnexl4u6002X8ez+EseePCmV1s7nm7PjxiBMSL6oV7EsnhePMhRXmkWItaAu/gFCIewXvwqUQMKEw0o2Z+LI0xg2ajuJxdu23P2hcelAIC7+hMWoYTCFYH86vSDhTW6RKhIGD/OoEGkTU8n1cnkGycAJ3Vp485MJvmejNaT8oZJI/zU0Q3JPQvwn3mfW6R09xXOrxMgl8s9Mh3BdBI9tuU/OJRIzo4NOWrSWNcEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0wM/uISa1ZTicUtslFYMtbkdcy8EFf6MbYe1hnlMZDg=;
 b=PUZPWN43kYrUXX34+NxQdK4/t5v7XYLj/+Xmf+wMY596eQnUWYwXjGmE6pJWGlJahvkp0gw8OpVBirln6a8n3EZ/jncw7Pk2nARCAcblYCQtEmRBqbhnM7ZLykrv2+q7IzWZtRDnF3HVojVIRqt7oGYrAjZ1FYa+o+MVA4skd5g=
Received: from DS3PR21MB5735.namprd21.prod.outlook.com (2603:10b6:8:2e0::20)
 by DS0PR21MB4074.namprd21.prod.outlook.com (2603:10b6:8:1cb::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.3; Thu, 22 Jan
 2026 19:14:02 +0000
Received: from DS3PR21MB5735.namprd21.prod.outlook.com
 ([fe80::a3f4:6107:de7c:5925]) by DS3PR21MB5735.namprd21.prod.outlook.com
 ([fe80::a3f4:6107:de7c:5925%3]) with mapi id 15.20.9542.007; Thu, 22 Jan 2026
 19:14:02 +0000
From: Long Li <longli@microsoft.com>
To: Michael Kelley <mhklinux@outlook.com>, Dexuan Cui <DECUI@microsoft.com>,
	KY Srinivasan <kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>,
	"wei.liu@kernel.org" <wei.liu@kernel.org>, "lpieralisi@kernel.org"
	<lpieralisi@kernel.org>, "kwilczynski@kernel.org" <kwilczynski@kernel.org>,
	"mani@kernel.org" <mani@kernel.org>, "robh@kernel.org" <robh@kernel.org>,
	"bhelgaas@google.com" <bhelgaas@google.com>, Jake Oshins
	<jakeo@microsoft.com>, "linux-hyperv@vger.kernel.org"
	<linux-hyperv@vger.kernel.org>, "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
CC: "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: RE: [PATCH] PCI: hv: Allocate MMIO from above 4GB for the config
 window
Thread-Topic: [PATCH] PCI: hv: Allocate MMIO from above 4GB for the config
 window
Thread-Index: AQHci0NeXwKN+Tqwx0if+HSmK2JVkrVdxd0AgADHoZA=
Date: Thu, 22 Jan 2026 19:14:02 +0000
Message-ID:
 <DS3PR21MB5735C620871D15F75A9B7BAFCE97A@DS3PR21MB5735.namprd21.prod.outlook.com>
References: <20260122020337.94967-1-decui@microsoft.com>
 <BN7PR02MB41486A6DBF839D5BC5D5BC2ED497A@BN7PR02MB4148.namprd02.prod.outlook.com>
In-Reply-To:
 <BN7PR02MB41486A6DBF839D5BC5D5BC2ED497A@BN7PR02MB4148.namprd02.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=04fd0f2d-618b-490a-a536-685b349fef9a;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2026-01-22T19:05:02Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Tag=10,
 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS3PR21MB5735:EE_|DS0PR21MB4074:EE_
x-ms-office365-filtering-correlation-id: 562e1eb6-a15d-4601-448b-08de59ea672e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|7416014|376014|921020|38070700021;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?YNWRjTSe1oWb7h2ciJ6pF7fwU9+Yu1XRXFterSPS7ouokqVexRook9roRB2T?=
 =?us-ascii?Q?hSoOyBc0hEwIgQxK2bbiXfb/Oa6aLMLWMk7z5//SomqRDP7eyaTuf1vT89gb?=
 =?us-ascii?Q?URGIKUZXHGkj9cQPxTeqe66jnSdntt7xmOFnZSoTXzQUbvokEoD5A/c2zeNV?=
 =?us-ascii?Q?yUDU098NZ7gX1oKL/uNGGSODoy4dhvl1mvVcZ0rpwIwzbMKRK5kq1moCHDDe?=
 =?us-ascii?Q?pylf3ez5UHcvA2b0StvA4JZgRQaU54HVYYeBLExJ7bNFcSnd4adQ2IoIIL3t?=
 =?us-ascii?Q?XPEJbcy8SqBRJKpRVc1m1HD8Mxvatzs3HHIN08eVx0YmRdfxuIX2RgQouBai?=
 =?us-ascii?Q?W7fig9lLX/JhPim/ZEwJ6560ZthyqkxBMM3dR1QWQ5nn/uyGQgZbqpRB3SMn?=
 =?us-ascii?Q?/n79q/da+whKm4TlE4Hefo1bFGfPy0VhVCZb9NH/KU/SRTMC88bAfvv8/ES4?=
 =?us-ascii?Q?4oXvNoQo5OBqHcbdTf6Fc4idtOHO5A+X4djazy0ONaxthZAmIxh+530z58zK?=
 =?us-ascii?Q?aNwasSNjLRU8YhFNSl8bNJdOlg/s6dtu0TbqQ/KwvI0aagK4cqlwtQhzpGIQ?=
 =?us-ascii?Q?wnlPOu15b6HXoSvSIlwys7ngcwG8aMzmctNjob0faEdk0SRn3laXxUuiXsXj?=
 =?us-ascii?Q?r2jK35qV3zp7HEm4ivkA9+fkKbCpCZ7s+z0yMKQF5u7TyB06I5PV28pZALO/?=
 =?us-ascii?Q?xXuWSege5ihlIHsVflMzLHTUywxZdtQcMvHP2dF76PrJ5A43+6ZWzp6zkfXz?=
 =?us-ascii?Q?GfuQUKNC51UPzuYesWS47sLD09EUwQDZmpL0a+vqM1GypFqd93+wEjnt2I4R?=
 =?us-ascii?Q?yIIF8SRee7ZDIrVL4fN+bv8UlqvqaNangv1xXfOFiDLYe7ORD7jmTyej6eRl?=
 =?us-ascii?Q?mHTknwaQm9a1tHTLSP4Ao5qDz/dUw5vayGhg5+BVy2NKnLjSLGvuAK+jVD3m?=
 =?us-ascii?Q?mqmXyrDay7cZ0UIKkYlMM7w4IJj7/1n5aHRdixsnd3zcDdKieG4F4MAC/prp?=
 =?us-ascii?Q?xeMhUPZcOQMmXO4AFB16whSUHIoSYZ4QReiJyBcsPu6NmRXYTvUmBiIdBGNw?=
 =?us-ascii?Q?POXVE1HGOda2BShOOwpqM3SLD3LMUfRXOeTS0h/1et4MvGXT2KSLsqq+YyrT?=
 =?us-ascii?Q?8GOQXGt5ztphRNlFD9N75HSAqvHQwO5R2Psvc51A8j3i4JWXFfsBldgvUFOr?=
 =?us-ascii?Q?GXMeGwwinZnpFFKO9tOHs1dpnKMr1I1eKidrZf6gd5eVblztHBQ22Td7n/3g?=
 =?us-ascii?Q?/iXQKLX/FX+r5+aTruigTMvMys6OImrwieelq/pPru7ywqFaVBIqR21dhCpx?=
 =?us-ascii?Q?nIdfdXtcybQzc6Tlg2NbW6MItRlwEfRvkDFFSvDRXa6afSAfux84DOm6CtXy?=
 =?us-ascii?Q?Hr6fvdafC+/659XxuWg4hOykzT3LzfKo9KEUdONfQrd1JlZ3JyeSIu6OnKF/?=
 =?us-ascii?Q?sgyV+Qzm01cbgeIvuMdGiYh/bYhSiu2BcZoYZTK7RosS/RAoO8RK0AIxJ51t?=
 =?us-ascii?Q?P6HqaKkHzQ85QRpkADMFSNrj9gzaA0MZfYQt1P3eQOG4uOa3Zd4t9Aav9Flb?=
 =?us-ascii?Q?6vu7WQOazg8M7lY4OYw7ZLZGcj7zpaGtxZCo/rFMp7WwTYxd++zuhvcU/hb+?=
 =?us-ascii?Q?CVaXMcNRqB3UVEdqGK7pK1ywx+8SGN67Gu8MjQwVv5Ib?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS3PR21MB5735.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(921020)(38070700021);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?cfRwvvHMdhrkJsELiy1pOcB0WNTBgE4NdXvfjcdvcqv0pAuQWES8vWTHCVMs?=
 =?us-ascii?Q?NthEXblfC7JQk1IUSGJmb1k8+TMFcDBdU+lnfW1z2P4laspEI8lZD7TXC8Ip?=
 =?us-ascii?Q?KJI7qbsFUE8LNy47lQQR6FE0Y/2F/8oVqE8vGNKk6Ox8GwpUevo9UXFEQ1X6?=
 =?us-ascii?Q?nGTELF7s69DWdAuEySI9SCB5FpZOjwQKUVZ8vT7Cgn8wmSeu8zrPKRx60YVr?=
 =?us-ascii?Q?NShw1172uji++DDqq/spjFHbVCmHdFBE0iLUBdqH2a3H3Mj610jTKLpB4Ji3?=
 =?us-ascii?Q?cCsk11Nf/F+np3RXqxOYCiv0ThBWAyaUgMV+JxtH0w1ofDY1hymZ5FDa+1+r?=
 =?us-ascii?Q?IGneQwuMF7Jv2re9djjLg+TF/UFW4WwlI14R2D+P/6X0J4T2mn9YG26aN2hQ?=
 =?us-ascii?Q?dZqcNnkCajtBccl/dVHY39IymExk81mNkIMoiGow8wro6hSey3vy8uMT5x0U?=
 =?us-ascii?Q?rVNnCCAmriPhmp4DkLcPCLN47ghb/Hoj5NvBqIDIs3+IZzrgJNBG4rbMjYdA?=
 =?us-ascii?Q?uG7Ui59IrDEnbF2NP7DBmToeUZpzrNyJbMokW8OfXv54gfY91ajxyIq/MvPA?=
 =?us-ascii?Q?bSxVEAqffaiR1NAGAtkFfiJyYjyQ1TSahoHrfktL23Bbh4buT4GeHCpXruHA?=
 =?us-ascii?Q?6kSMG6ktne4Vom0ny16uVxhYCgHn9UxgYYdYcx0NW4dONdoo0QNA4+s8ng7L?=
 =?us-ascii?Q?kkwGIRye8OR08WtdISGppC+hjA/cKScZFoFHnDrVS7mjvI9aDlbqWC+d6fn4?=
 =?us-ascii?Q?V6s4Jr+lIv/EmyX/yf/F8ntwvULVHUgkHHiT5y/SjUv8FuFRu4MucBpXhLqZ?=
 =?us-ascii?Q?t3DagCAeZ0evJBoaXeBEMRJeL9WWkKn3HambtljgshxvxI/JepxwdKEtjMpM?=
 =?us-ascii?Q?UIT5HNrGyUS1wsYLxOuaRkTvVBY2WyYXgMeEtuQYc0cb+d3HuKaEGTMRBjhu?=
 =?us-ascii?Q?LcWZvOuRxNwsoCEVOtDN24CtxCnbUlToeaY6ddM3CETBbCOg1egC4/EdH2oY?=
 =?us-ascii?Q?DHv4ZDDb1iCgbymdBFInzJzZhW5wZ/vGk6sWtVqr+fGWRko99W5bHeP5t7uy?=
 =?us-ascii?Q?YN1fDPNM3843eOIXeK09QdE5E4/kMRkxlKlh6P+rhW7QInh+YWPy2fXjgEsg?=
 =?us-ascii?Q?/4YzE8Ic+yvaX2UJ0zkuA5ymGrWAfN9HV0JkO5k5ZjzMEbjNCCqxQLKPsPRC?=
 =?us-ascii?Q?sw92GqfltIohxuwPK8DFt1W7VzkiES0KsbR4Nh+q7q4wAd36ILplycVxunjE?=
 =?us-ascii?Q?3nm0l5KtL2aSn7C38W6YSEDIiT4gauy/7kLEFv0pIJB18jz+nXvd2m3K301j?=
 =?us-ascii?Q?T+RRfMCKvft7z+VyavmUZwzD58aB00rXQbjnw0Rb6Ib5E2xShZV3TjuXOXcw?=
 =?us-ascii?Q?Nc9CYJLCjyfV+rd9UNZmDxobac09CMdQLts8/ZHThPt4LF71UPP2p5SHbNF9?=
 =?us-ascii?Q?bgLwtuEIBrv0kZ1o4o2dgBF1r/xBdTopCEIOiBfiQj38ExOsPHlbMj0PkLYJ?=
 =?us-ascii?Q?TLgKNcuS8Y80sYpxgsb0CExgvfdmAf1cNiZ39G3efr8fgeYS8vW3/+BBz+uT?=
 =?us-ascii?Q?RI2uoMpX9DKZLaX29vHRLui4DZDQt361eg+epjqAA1e7I3MmHLNKs/TdBc6s?=
 =?us-ascii?Q?ulCXRUWkE6KT3r2s051pd/jW39LP6/goLmj/chlpccSdLiBUf4g+hd2uStFe?=
 =?us-ascii?Q?JTLvMzix9YYSmWmcMop66QAkjO+v56UjLeukhxJUGuL4K5ok?=
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
X-MS-Exchange-CrossTenant-AuthSource: DS3PR21MB5735.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 562e1eb6-a15d-4601-448b-08de59ea672e
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jan 2026 19:14:02.0910
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6uAMq9q7JN0rDnujzv5KVx+YFIBaHKKTE+mhZrw97n4FbRkJkMGIzOhuZyjLM2ltecf0RxnGuw+U8yJ1h1hk0A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR21MB4074
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[microsoft.com,reject];
	R_DKIM_ALLOW(-0.20)[microsoft.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-8473-lists,linux-hyperv=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FREEMAIL_TO(0.00)[outlook.com,microsoft.com,kernel.org,google.com,vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[microsoft.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[longli@microsoft.com,linux-hyperv@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-hyperv];
	NEURAL_HAM(-0.00)[-0.996];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 9A67A6CEC4
X-Rspamd-Action: no action

> From: Dexuan Cui <decui@microsoft.com> Sent: Wednesday, January 21, 2026
> 6:04 PM
> >
> > There has been a longstanding MMIO conflict between the pci_hyperv
> > driver's config_window (see hv_allocate_config_window()) and the
> > hyperv_drm (or hyperv_fb) driver (see hyperv_setup_vram()): typically
> > both get MMIO from the low MMIO range below 4GB; this is not an issue
> > in the normal kernel since the VMBus driver reserves the framebuffer
> > MMIO in vmbus_reserve_fb(), so the drm driver's hyperv_setup_vram()
> > can always get the reserved framebuffer MMIO; however, a Gen2 VM's
> > kdump kernel fails to reserve the framebuffer MMIO in
> > vmbus_reserve_fb() because the screen_info.lfb_base is zero in the
> > kdump kernel: the screen_info is not initialized at all in the kdump
> > kernel, because the EFI stub code, which initializes screen_info, doesn=
't run in
> the case of kdump.
>=20
> I don't think this is correct. Yes, the EFI stub doesn't run, but screen_=
info should
> be initialized in the kdump kernel by the code that loads the kdump kerne=
l into
> the reserved crash memory. See discussion in the commit message for commi=
t
> 304386373007.

On AMD64 the screen_info is passed through kexec system call. But this is n=
ot the case for ARM64, it relies on EFI to get screen_info.

However, Hyper-v guarantees the framebuffer MMIO is below 4GB. So, the patc=
h works by allocating PCI MMIO separately from that of the framebuffer.

Long

>=20
> I wonder if commit a41e0ab394e4 broke the initialization of screen_info i=
n the
> kdump kernel. Or perhaps there is now a rev-lock between the kernel with =
this
> commit and a new version of the user space kexec command.
>=20
> There's a parameter to the kexec() command that governs whether it uses t=
he
> kexec_file_load() system call or the kexec_load() system call.
> I wonder if that parameter makes a difference in the problem described fo=
r this
> patch.
>=20
> I can't immediately remember if, when I was working on commit 30438637300=
7, I
> tested kdump in a Gen 2 VM with an NVMe OS disk to ensure that MMIO space
> was properly allocated to the frame buffer driver (either hyperv_fb or
> hyperv_drm). I'm thinking I did, but tomorrow I'll check for any definiti=
ve notes on
> that.
>=20
> Michael
>=20
> >
> > When vmbus_reserve_fb() fails to reserve the framebuffer MMIO in the
> > kdump kernel, if pci_hyperv in the kdump kernel loads before
> > hyperv_drm loads, pci_hyperv's vmbus_allocate_mmio() gets the
> > framebuffer MMIO and tries to use it, but since the host thinks that
> > the MMIO range is still in use by hyperv_drm, the host refuses to
> > accept the MMIO range as the config window, and pci_hyperv's
> hv_pci_enter_d0() errors out:
> > "PCI Pass-through VSP failed D0 Entry with status c0370048".
> >
> > This PCI error in the kdump kernel was not fatal in the past because
> > the kdump kernel normally doesn't reply on pci_hyperv, and the root
> > file system is on a VMBus SCSI device.
> >
> > Now, a VM on Azure can boot from NVMe, i.e. the root FS can be on a
> > NVMe device, which depends on pci_hyperv. When the PCI error occurs,
> > the kdump kernel fails to boot up since no root FS is detected.
> >
> > Fix the MMIO conflict by allocating MMIO above 4GB for the
> > config_window.
> >
> > Note: we still need to figure out how to address the possible MMIO
> > conflict between hyperv_drm and pci_hyperv in the case of 32-bit PCI
> > MMIO BARs, but that's of low priority because all PCI devices
> > available to a Linux VM on Azure should use 64-bit BARs and should not
> > use 32-bit BARs -- I checked Mellanox VFs, MANA VFs, NVMe devices, and
> > GPUs in Linux VMs on Azure, and found no 32-bit BARs.
> >
> > Fixes: 4daace0d8ce8 ("PCI: hv: Add paravirtual PCI front-end for
> > Microsoft Hyper-V VMs")
> > Signed-off-by: Dexuan Cui <decui@microsoft.com>
> > Cc: stable@vger.kernel.org
> > ---
> >  drivers/pci/controller/pci-hyperv.c | 8 ++++++--
> >  1 file changed, 6 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/pci/controller/pci-hyperv.c
> > b/drivers/pci/controller/pci-hyperv.c
> > index 1e237d3538f9..a6aecb1b5cab 100644
> > --- a/drivers/pci/controller/pci-hyperv.c
> > +++ b/drivers/pci/controller/pci-hyperv.c
> > @@ -3406,9 +3406,13 @@ static int hv_allocate_config_window(struct
> > hv_pcibus_device *hbus)
> >
> >  	/*
> >  	 * Set up a region of MMIO space to use for accessing configuration
> > -	 * space.
> > +	 * space. Use the high MMIO range to not conflict with the hyperv_drm
> > +	 * driver (which normally gets MMIO from the low MMIO range) in the
> > +	 * kdump kernel of a Gen2 VM, which fails to reserve the framebuffer
> > +	 * MMIO range in vmbus_reserve_fb() due to screen_info.lfb_base being
> > +	 * zero in the kdump kernel.
> >  	 */
> > -	ret =3D vmbus_allocate_mmio(&hbus->mem_config, hbus->hdev, 0, -1,
> > +	ret =3D vmbus_allocate_mmio(&hbus->mem_config, hbus->hdev, SZ_4G, -1,
> >  				  PCI_CONFIG_MMIO_LENGTH, 0x1000, false);
> >  	if (ret)
> >  		return ret;
> > --
> > 2.43.0


