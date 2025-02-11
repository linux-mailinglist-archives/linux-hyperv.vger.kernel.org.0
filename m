Return-Path: <linux-hyperv+bounces-3897-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7406AA30FFC
	for <lists+linux-hyperv@lfdr.de>; Tue, 11 Feb 2025 16:41:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CC98A18892EC
	for <lists+linux-hyperv@lfdr.de>; Tue, 11 Feb 2025 15:41:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A9A8253334;
	Tue, 11 Feb 2025 15:40:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="C9uAzLz0"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from CY4PR02CU008.outbound.protection.outlook.com (mail-westcentralusazon11021142.outbound.protection.outlook.com [40.93.199.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FCFF253B6E;
	Tue, 11 Feb 2025 15:40:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.199.142
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739288450; cv=fail; b=XD2o1H8bQxLmjd1jcyYhjl0en3oKtoAn+/JgxJGFfG8kBYwTg2VTJu1c7gZU0Pu0j1kZtGgqsW7LuIJxnPr7jd/Zdot9hClPhNbi0bmJRpfRqi8Wq4QbR/XsVeyVF5O8u/WnBEqLf3/gzwC+XUbNl6Hl90php1t3aFTj8VRBTFY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739288450; c=relaxed/simple;
	bh=BVnGhCu4K0UAvZTvcAhloIYI2G/p4RYFKdLkq6PlVNU=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=MkQluFRYW0wQV2mEsxjADfMejiZUGzVusKGzdOwzwsUdi5+zOj03has9K7Ja0w+I7R8wqc19KgPzn3i4mOh2Q/197ZChmgmqMjkKsZfq/2V9U8whnfRzj7u2PydIN0A/c5sZPep4AAiCt6yhtNqP1KqKlTPf05Tg5oIjj26+Mm4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com; spf=pass smtp.mailfrom=microsoft.com; dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b=C9uAzLz0; arc=fail smtp.client-ip=40.93.199.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microsoft.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fYlnXZKUiRrqL0HAqGbjQKtBzwLBfk3RhQiMoCcl+S2Olo3FgDm6HgzFMjQ+AlJgbBmweEcpV9lu/MNd6MZm3HREvevH+ueAAbemtdXtrYlVh4aRnXe6oMaHiXpX01y6FeIm2z/lSLfBxSFoVNnwvmAKEYUfTSn3cyMk+jvkw6oH9xae+QM0ntYqx2i/ZxGEgu1/kr7KFjdCm6ZEoWJi5eEi/VtCwpExtDz2pRhiDxmt4PQiSbTlOIig4upBTS43h465MoyNTtQRFJD1PDvZ8uFIs0icvaF6PYUa5f18o5ddXAmZDZoTnQAmVZjPpbN3NHs0/sxz8D1aCidDSjRhJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wdMocC085pSrKnHh9MCwgwV/sTb7lVvHTSrOn7h/A50=;
 b=dwbk/t7csCEp/6aE13g1MAbIWIPAVkShj0jQMR70oESPpPqocMWV78MKWaxT6o1xE76d9qyMD2kDt56htk8pKd8/HNPuxriudZrhp+Gqg97lKXN4z0mJLS7vE+o7mLsvT0w3gsX4Sq0mUcgMYz2t/ucxHd04oeCg3ZP0p6x99haILlBKprXXjdfI1Ks9YMXWh2szHdRYNrDRVnx9DhR06PXK5j1QHX2ZfzjwqKZqe2suh+NT7KDP6UDOE77nL5pl2dWZEDZCFmiKXKacDfLWqEdwyqrbNrnM0uv46o28TkwxDdWne4obpafacZi2VrRrwoF7PHrbkda1BTva0DJRkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wdMocC085pSrKnHh9MCwgwV/sTb7lVvHTSrOn7h/A50=;
 b=C9uAzLz0Mkb/uSjAyueZNKEMhHi3a/eXWrru/qDo8sZmiDDRz3pm3f8H++h/z09mW/wxf2Yx3W2mA1L9z4ulUs1Xws7imJIpW5oxNEqOGC4oWQhve7M5Y4EJ0I9IwHaMWpBnES9lnQ3/MXgFTQ5O7PSoFGaTN8H8lnsp2Za2bwk=
Received: from MN0PR21MB3437.namprd21.prod.outlook.com (2603:10b6:208:3d2::17)
 by MN0PR21MB3751.namprd21.prod.outlook.com (2603:10b6:208:3ca::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.3; Tue, 11 Feb
 2025 15:40:45 +0000
Received: from MN0PR21MB3437.namprd21.prod.outlook.com
 ([fe80::5125:461:1c07:1a97]) by MN0PR21MB3437.namprd21.prod.outlook.com
 ([fe80::5125:461:1c07:1a97%3]) with mapi id 15.20.8466.000; Tue, 11 Feb 2025
 15:40:45 +0000
From: Haiyang Zhang <haiyangz@microsoft.com>
To: Erni Sri Satya Vennela <ernis@linux.microsoft.com>, KY Srinivasan
	<kys@microsoft.com>, "wei.liu@kernel.org" <wei.liu@kernel.org>, Dexuan Cui
	<decui@microsoft.com>, "andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>,
	"davem@davemloft.net" <davem@davemloft.net>, "edumazet@google.com"
	<edumazet@google.com>, "kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>, "michal.swiatkowski@linux.intel.com"
	<michal.swiatkowski@linux.intel.com>, "mlevitsk@redhat.com"
	<mlevitsk@redhat.com>, "yury.norov@gmail.com" <yury.norov@gmail.com>,
	"shradhagupta@linux.microsoft.com" <shradhagupta@linux.microsoft.com>,
	Konstantin Taranov <kotaranov@microsoft.com>, "peterz@infradead.org"
	<peterz@infradead.org>, "brett.creeley@amd.com" <brett.creeley@amd.com>,
	"mhklinux@outlook.com" <mhklinux@outlook.com>,
	"schakrabarti@linux.microsoft.com" <schakrabarti@linux.microsoft.com>,
	"kent.overstreet@linux.dev" <kent.overstreet@linux.dev>, Long Li
	<longli@microsoft.com>, "leon@kernel.org" <leon@kernel.org>,
	"erick.archer@outlook.com" <erick.archer@outlook.com>,
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] net: mana: Add debug logs in MANA network driver
Thread-Topic: [PATCH] net: mana: Add debug logs in MANA network driver
Thread-Index: AQHbfGqwmOqTXRkwe0SgU5Dbc+hIwLNCPY5Q
Date: Tue, 11 Feb 2025 15:40:45 +0000
Message-ID:
 <MN0PR21MB34372ADDA26E499D9A6A2B32CAFD2@MN0PR21MB3437.namprd21.prod.outlook.com>
References: <1739267515-31187-1-git-send-email-ernis@linux.microsoft.com>
In-Reply-To: <1739267515-31187-1-git-send-email-ernis@linux.microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=1132aff8-9231-4cce-a774-745da514cddc;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2025-02-11T15:39:53Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Tag=10,
 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR21MB3437:EE_|MN0PR21MB3751:EE_
x-ms-office365-filtering-correlation-id: 0fece065-fde9-4049-9df3-08dd4ab27330
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|7416014|376014|38070700018|7053199007|921020;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?+zI5Y5NhFKBtj9b25m7gynpKbru3/ps0MPfGI0nZeuiKr9MNRAq26LPrGrvo?=
 =?us-ascii?Q?O9P+UnsmgQ/WiGhUhsFaDADUpF43tRLcvcsGdHhFNQGiXIaiau0Q1rq3J8cO?=
 =?us-ascii?Q?1TXk9a+lUvYhHMf39ZVGLjYGSDEy/PIdaKFDoeHxXjKbcqJl21Ic1nhkCyxQ?=
 =?us-ascii?Q?yBVNtuEi/WIRN11OI0APd7qE1mqtE3IetkUH6mGs5ByuItEcv9+AZSWK5p1P?=
 =?us-ascii?Q?C0yH9WSajiP8N5lEla/sMsd3WtCMnP8X8TldNTBLUP1W6nA1DfnQJMLQGf00?=
 =?us-ascii?Q?ZogTnroSUImBWn+QOkk9cAz5WM0xhUJLHRKxWyK3WdCi1gOPEovUOq/Bvxyf?=
 =?us-ascii?Q?7WRfi4wOKGFF2Mod1YcJL7cqwzwFcQXgT7U8Vt+hoR+ePFxkdn7WimzO3rOG?=
 =?us-ascii?Q?COpWaFpBsMCyTK4rXQZr0NBkp4WmAcKV8IW6MKXbu6PFSH5gurX+SOw3Cdwk?=
 =?us-ascii?Q?kEzQ+gDn2VVHAxEOfDI++a+5ZhM20+1V2xdUXoYu2gQmOopy6395V8bUHoT0?=
 =?us-ascii?Q?S4O5vaBSaBD6ar8Qcq+DKvUjBUyRY0rWU1vFUCOBbOonCVCaBQcMh/DGfkec?=
 =?us-ascii?Q?EoQzuhx+F/9IIaV275HLAxRHJOx2W5E0xjYwzGiRAPOMHDmPZ3uX93NW2Y8F?=
 =?us-ascii?Q?Auh+VvX6afY2NjPIKjkY1nH4PV5RzkIqnbxiadFUOGhSKoSJXGVSvZg28Ma4?=
 =?us-ascii?Q?rB7VpsePk49i0BO/h5H1zUxK52YUwp6fuQJSM4TJPA9hgft0OcXJKkEafevT?=
 =?us-ascii?Q?IIPiqFxgLC1Jfr4Cw17RzhZvb4ymywQuG38Pp4iINBWzRx67ttNRDswoVnYt?=
 =?us-ascii?Q?ZnkHyqIUUsv2TQY41/xZJIFd6psH5+rk4aIIpYHfJx1t0FSyOyaWTf3oC1LA?=
 =?us-ascii?Q?qp1n4KYq+X3isuCqojxQXJbFkOA9SOoHa/lryGk3QQtVM8dHDNDWYRJp9mVD?=
 =?us-ascii?Q?n0d8Q9uQufRat/zopLSBFDfIqXCo+z+X7F/CkvmuKxilntft926h2TGpzFGV?=
 =?us-ascii?Q?126Qr/AYgPL2TwwUnTVQTUqV9s2M3/wmix8k4InNxAb/40C1PUnnmkXiQS6y?=
 =?us-ascii?Q?cb1SVEh3UCcdUFWar6A3HkfwpuhLLrwfaPKeeigRorAstwrIrUQIwGBy9CoK?=
 =?us-ascii?Q?OmhhrX2nihNNUgQP2Q+Eaxj8oz0aACmtwZDO62zLbTZGUrcB3BjUdyTpPpdt?=
 =?us-ascii?Q?eXQULwTKRVv+VOOBr9wurMVu7Yee5+jFoDMnb15oVT2MVbvxCdKL3jSuLKEL?=
 =?us-ascii?Q?6dO7cKzslltowNJXc6HwngOMUTIQ538uxJ3/kCONweVQMl7uAO7BSE7GRHi0?=
 =?us-ascii?Q?KggyavkbdKDrboCuSve1iEUisxEfDXJSFCM1ypvj6ls5HU/3QIgZusbc68nH?=
 =?us-ascii?Q?QNMZp6R5KoR12OV5G289hYKhwooGM04G7vhnm0qR0Y/VbYi90PUJtdn6x9L1?=
 =?us-ascii?Q?tgihbFklVgYGS83+zv8cB48jL6/+gQKL?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR21MB3437.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(38070700018)(7053199007)(921020);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?dR212yalqrXMAuLjh4Z17P7DhG/Uy0UQPk4WO8w7VxeaJZ5iG0r/L4nYZtHh?=
 =?us-ascii?Q?DAwXhuCW9KEfQmm5//3oOIuKKZmbTlN/Fx/jbpo/LM61N1uOoJFTexu9MAYm?=
 =?us-ascii?Q?Hj5Ca+9oM2wF9kGhr09VY/I02GgZEeUsGerXVsdf6QLmtIPSTqCHj/Ypqbh8?=
 =?us-ascii?Q?3F8Nc1U/He5cSZMRWsR0RuHARqNlLIZMKOzJ+OZmqxxP6Ufm58eb8J9pzqtH?=
 =?us-ascii?Q?/MVn2Bx4ubcmAHLM/SaSw3hgB/gRuFYwZVWSmq9Lcsm8Cy3XTX5NpSVEO703?=
 =?us-ascii?Q?BeBpB3Iq6B/qMnyXMDthBc1pD262TjqOhIj3B1c90qOH4EIsenCflg4GNrJX?=
 =?us-ascii?Q?3WrNjMGRPUqLFZ5nDmAlPPWocea3GgXVSztOQJUtL62sOyc0IProTmT3HnYa?=
 =?us-ascii?Q?AOMW6N3DS+Rp6vjw06/D9hU/3I45bazx+wpvjBT/BaRdMNMRKWkY8LWydz0w?=
 =?us-ascii?Q?8rUF9FYP9Q00BcQsSPUQMyhJ9hxNBgy+qCgIHOQow81ZamdkDJh9GQ3Fbv95?=
 =?us-ascii?Q?stfwfKJNNSox69Go1paLpw0ipOrdzVA6duETkYN0q588asAieHQTlY6Hi60H?=
 =?us-ascii?Q?++lCwX5q1VHTJDPhZmDaDJKrEoRLw+Jq9kmswcCwNsvm+BpVIKnxqmRAGDO5?=
 =?us-ascii?Q?j+JMopXMeUqbkv75qwX25jZH83gFcPCXbmgwFrADXtj/MvZmHRJFcjRD5Hak?=
 =?us-ascii?Q?eALI1oAM2SVp9cp0TFKIXiBmJ/rwAxJJGSxQui1N8hi+bcM21L81BHt6k5+x?=
 =?us-ascii?Q?KFgu8O17OFbC+7Zf2Uft4h7dNtinP4wvcqLD0HIWz79HXs6+tYwnDa1kL/Yo?=
 =?us-ascii?Q?roYduu+GL/Xl1bdaFx4S8eHrlMEi+tV9lvl5EMab8tzgLrGsWqvL+uILRIT7?=
 =?us-ascii?Q?4FSr7P3Tkabb3+gnuzqf5QUof4qMSnFZPEVfedN3/PiRcDqhONs/A4OhTHkZ?=
 =?us-ascii?Q?x0usejPEif2mLu7etryRFt8E4A4LVD0tOLbBNNAUu5zV5MUSAuwwxBD2XsI3?=
 =?us-ascii?Q?QRkvSmsyDq/db/M2RkLdnI17KjD9j9T5m5CJM83MBcod7y41UrOde9EWIDEk?=
 =?us-ascii?Q?8ZqewDca4Gs5pM3Cs7wIM9XsGx6XSx3cDhMvp817PBVt7v69u0ZcLxn9xRLZ?=
 =?us-ascii?Q?XS9l1iP9xlvkek+ito5B8whN3nTQIrDZT3ymZzRx6BqgftO7t36MRlgbToz2?=
 =?us-ascii?Q?YbnIhvJnL+HAN1YkTbrxsWhPFY5mOSyO4ojJQPWH0Wk/qzalN/L3Ux5YEfGb?=
 =?us-ascii?Q?yEq4EfKniUwBuiWFO5g5Azk9fayCwQ5fnsDeuzWiI0oTwAr/svax5Fk6b6Bq?=
 =?us-ascii?Q?hii8q89Fo/ED96sRFWarmXCB9khBpTplBfZhr3/vJSGsXCzir7ucxjJYDron?=
 =?us-ascii?Q?majaYb1Y2Ap8PU3F/Bwb1E3aVcnJZR3SKkp5OGY/0mchTaQmFp2Zh2Os2/K7?=
 =?us-ascii?Q?Ria6KqWazbKcf+mb3OxrWsyI2zu7b/XreUdmOMHOWPKPGg1loFemfxk9cMR/?=
 =?us-ascii?Q?1Xu1vAqzNDJNoOXYg/gwgKGXExjEh9TFQTkx0ks9Rhh11TAPewNIFU3fKHVD?=
 =?us-ascii?Q?MzTxV6ZsAVdKGw3cJVp9QwZoYSV/STO4zaBtpaTO?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 0fece065-fde9-4049-9df3-08dd4ab27330
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Feb 2025 15:40:45.3060
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Pt9natNcJgp3UUDMhojL5MuQknQCcIoz8/8aS29m0MOI4++oQGmg1CcCM8MUkils2XyG8RFJea+LxninSgfNSQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR21MB3751



> -----Original Message-----
> From: Erni Sri Satya Vennela <ernis@linux.microsoft.com>
> Sent: Tuesday, February 11, 2025 4:52 AM
> To: KY Srinivasan <kys@microsoft.com>; Haiyang Zhang
> <haiyangz@microsoft.com>; wei.liu@kernel.org; Dexuan Cui
> <decui@microsoft.com>; andrew+netdev@lunn.ch; davem@davemloft.net;
> edumazet@google.com; kuba@kernel.org; pabeni@redhat.com;
> michal.swiatkowski@linux.intel.com; mlevitsk@redhat.com;
> yury.norov@gmail.com; shradhagupta@linux.microsoft.com; Konstantin
> Taranov <kotaranov@microsoft.com>; peterz@infradead.org;
> ernis@linux.microsoft.com; brett.creeley@amd.com; mhklinux@outlook.com;
> schakrabarti@linux.microsoft.com; kent.overstreet@linux.dev; Long Li
> <longli@microsoft.com>; leon@kernel.org; erick.archer@outlook.com; linux-
> hyperv@vger.kernel.org; netdev@vger.kernel.org; linux-
> kernel@vger.kernel.org
> Subject: [PATCH] net: mana: Add debug logs in MANA network driver
>=20
> Add debug statements to assist in debugging and monitoring
> driver behaviour, making it easier to identify potential
> issues  during development and testing.
>=20
> Signed-off-by: Erni Sri Satya Vennela <ernis@linux.microsoft.com>

Reviewed-by: Haiyang Zhang <haiyangz@microsoft.com>
Thanks.


