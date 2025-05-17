Return-Path: <linux-hyperv+bounces-5540-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 88653ABA826
	for <lists+linux-hyperv@lfdr.de>; Sat, 17 May 2025 06:38:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EB4CF7ADD72
	for <lists+linux-hyperv@lfdr.de>; Sat, 17 May 2025 04:37:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20BCA17A317;
	Sat, 17 May 2025 04:38:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="COY62Dr4"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from TYPPR03CU001.outbound.protection.outlook.com (mail-japaneastazon11022140.outbound.protection.outlook.com [52.101.126.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 557A929CEB;
	Sat, 17 May 2025 04:38:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.126.140
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747456699; cv=fail; b=UuE/jDahWaSuVDgJOvmN5AngJArzof/Oc0Ep/jghCGzhHv190+IyEMFdgK9Dg+nQea5XSpVSKlAU2QmHQEOJoXQoFlbdluwAqBOJEnWiZKupWHpDAQnObC2X7s7cj0ow2y8c4GofZVaJS+ZyqXOiIReM4lq23FdBsKFh9ZPvtiw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747456699; c=relaxed/simple;
	bh=awafyEMF3ZA8VzKmIbkXomNx1WRWsFXGHgIjBfGXTxo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=IWsEngTCFItJUn036Jlk4QK+JIsJH8zTVNo64I426da/KNB6WbPQt4/XyVKG4GM6uk5CITfGVXW4qfrmctOiuNrHdMJ4wfaiXIh/DRo//zIVSrpwyLAoQ7kS3FEmw/+V2PKMrRbGx4pvAetKxiN3EW8h8CG2E7Idp+qaTm8u9wg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com; spf=pass smtp.mailfrom=microsoft.com; dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b=COY62Dr4; arc=fail smtp.client-ip=52.101.126.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microsoft.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wouDwPME4pPn/1BBBkCtg3xPl1EI+GTeUOawwTUEzJ/O2tZbPA4QYOFY28zT2gxByeuT3N2HGfjib/m/FDmQcOGGkzSzM5fajEgowwpVLM8nsb4kKel8xpa8NYQyGU5CEZ44Od3CT267fP9KNgjsGJC6JNGgQ94B+oV6plCP3M9h5U9oMLzLVoHr3KYBgEeRs2eH5LYYCWrMcZxuBXGk5YDDZ78HgATvVwchOg/intApoli39dx2jYeIpBPpJnxjeIh3EL90ftAxAHc3g3mwW7L/ZEA37PzU03DONbausoU7ZMAM9RNimpzx+Qn70g2r0HrZh01uXcixGriJVRL1/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=awafyEMF3ZA8VzKmIbkXomNx1WRWsFXGHgIjBfGXTxo=;
 b=ZTch9veG0WuM8LaiKpcjosM+1Mt822iDPCQemxq11lHX8wPz6Mr7kyeBfyAUKr8SGcyiO6beM1kxKJ5nQC0XhrlSkJCnil6exaU/OVbL2V2XdtotJ5qCkbfzbaB2dNVtXGnC9X/X51yAS6rFvlaR2R/GA4Zg8FHBAB8bXesU8cWIAftQT8akz4+y/0zrH8gY2WF6GJvCpZeYj67pngOfSUwmBGTppbltNpy95xLwpLGHFLBkbggUIEg3rDnAGMxW2CTc0wxyaMrArVS2mk5f3kFb9juBWMaDrC6MLPX1K2Xwv6jksTEeyuvcun2pOTdtk0S6avHtjbmlGzMD0qjrBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=awafyEMF3ZA8VzKmIbkXomNx1WRWsFXGHgIjBfGXTxo=;
 b=COY62Dr4lsvZawp3CrPlkumk4ti3MU7/WsOEXUek6CWM84lLbG33vJTB6+eUPmU92YX/B+pRwkj2gEZOEl4GthVKTLO7EiVKMLywOJ4x0hLl2BzKp99ZOpgivE8rEpXR2XWxGi8vNGwiZtK2nPu/6Mx8ZVzb0QeGwXVl2nzQU5M=
Received: from KUZP153MB1444.APCP153.PROD.OUTLOOK.COM (2603:1096:d10:36::22)
 by SEZP153MB0792.APCP153.PROD.OUTLOOK.COM (2603:1096:101:a7::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.10; Sat, 17 May
 2025 04:37:57 +0000
Received: from KUZP153MB1444.APCP153.PROD.OUTLOOK.COM
 ([fe80::1d66:c349:800b:f365]) by KUZP153MB1444.APCP153.PROD.OUTLOOK.COM
 ([fe80::1d66:c349:800b:f365%6]) with mapi id 15.20.8769.001; Sat, 17 May 2025
 04:37:53 +0000
From: Saurabh Singh Sengar <ssengar@microsoft.com>
To: "mhklinux@outlook.com" <mhklinux@outlook.com>, KY Srinivasan
	<kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>,
	"wei.liu@kernel.org" <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
	"deller@gmx.de" <deller@gmx.de>, "javierm@redhat.com" <javierm@redhat.com>,
	"arnd@arndb.de" <arnd@arndb.de>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: RE: [EXTERNAL] [PATCH 1/1] Drivers: hv: Always select CONFIG_SYSFB
 for Hyper-V guests
Thread-Topic: [EXTERNAL] [PATCH 1/1] Drivers: hv: Always select CONFIG_SYSFB
 for Hyper-V guests
Thread-Index: AQHbxr5ySnaNfFUt8EO7pmq66j83WLPWPFMA
Date: Sat, 17 May 2025 04:37:53 +0000
Message-ID:
 <KUZP153MB144472E667B0C1A421B49285BE92A@KUZP153MB1444.APCP153.PROD.OUTLOOK.COM>
References: <20250516235820.15356-1-mhklinux@outlook.com>
In-Reply-To: <20250516235820.15356-1-mhklinux@outlook.com>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=7629be49-67cd-41df-bae8-102768aa5e60;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2025-05-17T04:33:58Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Tag=10,
 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: KUZP153MB1444:EE_|SEZP153MB0792:EE_
x-ms-office365-filtering-correlation-id: bb90a9d0-9777-442b-041d-08dd94fc965c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|376014|1800799024|10070799003|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?bpG2xVj9CASdyHa8HFqSyLzQXwzFJjALtrHjRniTaDg4tGYu0He8BQnB4wwN?=
 =?us-ascii?Q?ksveFeiOJPbQ4jiUxOACREoMFxpddp2fI+WDo3qPqYObGU2krKHHojJoo6Kt?=
 =?us-ascii?Q?+ChJAZHmQSz2g78vuHo/Rav/n5wbjSUozVwFJvD6RsRKJ2fl44H0laEla37J?=
 =?us-ascii?Q?iGlJ1dOWIbGNStZAz4J0ixmpFqrbGiKPF6TwF8kY1mtGN/lxXPkbd2rq+QVa?=
 =?us-ascii?Q?+67w21WK22CioTWeA3fSYlZ7tp5Y3cMoqZcklxtNdK8u3pxjZbm++HQewyrB?=
 =?us-ascii?Q?WxDTMwIzAdH2/Hl8MsT5LEGN8mc+O9G/9MKruhhbIk+zF9Ky9u3E2JkFz3z1?=
 =?us-ascii?Q?WHZn9DcpTyQz5f6pAJxDgyMlfIey9LJuTwxnm9+cNNv+nE66x4H1QIv2z++A?=
 =?us-ascii?Q?oAGoDB4jLHC9Ye4wZikPGBQk8KKehDRy5GkXyHx9wNJBxmsrXY/pxFI8ZDxc?=
 =?us-ascii?Q?+SUhK2Fds1VRbcsEu/Du8TG+KwDkOQCS6vTP19PfJwZH7eTyC+TL5yAK3qEG?=
 =?us-ascii?Q?oUfqfQdFudcQF1LPrchtM0TITNUGgrjYfLHDvyx+EPRv0sU8zDM6GUy14sHL?=
 =?us-ascii?Q?tLefKHakANFGsVmQ7EstNtV21nEZ6adaK9ZqtHiFt0WYkYfsw+pavRu9O1x7?=
 =?us-ascii?Q?CJAiY2YD0ByyrSyOHcJsAcoRidl0AoWDWrIXWl1zZRBIJ8iJizm2K1fOAh//?=
 =?us-ascii?Q?wOLY5udPXIClKnteYy1Msr/chJ92FhkelF6wDbUNpBE7ew6LcZZNCtdt8ORM?=
 =?us-ascii?Q?/INEoSIBn8/BO5pd90vyTrzpI0B41u2fMqAjkcUxZ4F1PmR1HhlNJ9PlmH//?=
 =?us-ascii?Q?Na4Os+LOgGUW68aduKb5bVXqwHbCzRag9u1h4S/0eoZoGRXNsmTz8jLhedC1?=
 =?us-ascii?Q?7pbY6Gu+LtfHUZfFf28GiffyZDP7lStP8nu2nl8aJb069LBwa/XbZdiC9tV2?=
 =?us-ascii?Q?7I21rnKnXbzf5M8IrOxXTVi6tCsMSXvloKPqCdvQbOHjxH90zJZsqgOyqQJE?=
 =?us-ascii?Q?0eLEpCgFal79uaDkNDfmGxWBglR9rMNXF5VZT+kZPgEY0bwGlO4sJr+eP9fj?=
 =?us-ascii?Q?4oD39F8D+/SCE2hGT+KEGqlC5xVx9RwXDvYYM0Xu1rQ3Fj1ERP3yFwTXkUmc?=
 =?us-ascii?Q?0R9XcBJRdKKU7X2nMO/w/YXfOdqy8Tvto1OVqdD3TIWcDAVMwGS6qcnmEeni?=
 =?us-ascii?Q?uZkqW1uKCZv1obC1FGU2RlJUonsJUaWp2W4jE4M7Ct0VO59QkFnpePNwdDGD?=
 =?us-ascii?Q?BfIhvf1xgBNB7nboazf2Mhkg/mhphxGIYIMtRVQOcPo5EH/SXl1EI+HCcHIu?=
 =?us-ascii?Q?MedcrpfOA99xqhioLtWubuWVjscOiOp4Dcv2vkc1hwHXSRli87uGlkWeMtoO?=
 =?us-ascii?Q?mLtIl6qYbDzUOzOMou+LDsW0CLjP2Bc9UTrpS+OZyBtRl75ZxmB5DJ7GaZ77?=
 =?us-ascii?Q?V5++edHERYSbl6yzJBvxBEEA96MJAeUadQILmWTwSZ7ohQKj3g6u3ejWxU2A?=
 =?us-ascii?Q?i9pEX8bSTsmI3co=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:KUZP153MB1444.APCP153.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(10070799003)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?hlCQIZgq4bQJfzD36ojoQ9JdFFDiz8kAuUnlUbc02HTNtsD8oCUr05s+oH52?=
 =?us-ascii?Q?jjwkhfGdGeB0Be7TdOyN1iozMSUxJI7PAS3YnvRWVYsOZ1GdrZcjeaoMrw+B?=
 =?us-ascii?Q?npltr/wv9ruk59Lvh+0ayx4Gr0oWRSgPtzKKldukR3Rapt/RG2KQUSvs/yK5?=
 =?us-ascii?Q?VTKxK+2BnhOK1Y+UQuIKAxy8fLPo9GcTtQljalz/acxStmNle2v+cUSTDqKZ?=
 =?us-ascii?Q?hVC4QBbL35urXL6QysF0EdoZJRkIU73TQICl2enZYdnyN3jQae+1VY28qqMG?=
 =?us-ascii?Q?+gHd/zSacrZNKZQaFiSMIwW+f3UnR9XxmZgPOmpitKvv5tuHHefBf8V5VRDJ?=
 =?us-ascii?Q?zCqU1L0qLeDZjYMDAGemttEMD9yhi57OPiR2PWuWzN4yeEBMG420m3p0Vv0s?=
 =?us-ascii?Q?pu6hAWv1aCFZSYMLM3dmpo14gyRxfsTLWOYMLlCWo0B0OJoRCml1VeOLHiiS?=
 =?us-ascii?Q?AL8Lj/iFoAniSfaVc5gVR1GLfChMSgOdJwV0YrQaPiTAD0DxKf15h0KgI0Ns?=
 =?us-ascii?Q?OyEMCbdzO69IH+RaRSDlkbjlmGDPTZD+mZSYO4Z8k/kFOi/IshYFDJYSyuup?=
 =?us-ascii?Q?gm6rPoVEobT5Gwf06CP2K2qGix7vXyVUzGAzOTJMGmWvZmpiIsuXTTYEaWhb?=
 =?us-ascii?Q?DSpEYGBPLpHhOQ8UbLwMWsfJIVMqennRUzubDjnFimbZnsIqaeJmNzXrzNkL?=
 =?us-ascii?Q?Mrguzj0ZXccfyWCImz8YeND76za5X8ScSUga55+YtW/2Z9A73eLBAQHgpITX?=
 =?us-ascii?Q?jwrw+KeSAwhBGXrzpe2IAkMOYq8sAPAbstnCKMucxoJ/g+T6vALv96PxQGFt?=
 =?us-ascii?Q?idUsSwudfeJyh2+m08/6evipL4TXK3xGHnGqPe4nYdr0p3Uj19bLAchFlJAt?=
 =?us-ascii?Q?H6gM8c/ynF3Y40IJqZ6FhSkTOq2pEJ+BlKvtyk8m7XK+UgS/irHEa8a8zgxo?=
 =?us-ascii?Q?D0IASBjLMGDQRxMwnS34AyFc3CtXAMnIWte8iUSeFJBFt5iVxwS5lhZNVHW/?=
 =?us-ascii?Q?0t3rLKQmXj5gNzbxJLqsUJJfJML8TIcz8msSNTSzRZyIQHMNPZQ5TOoLrjvS?=
 =?us-ascii?Q?/SMXFiWPzI4sCtzvRawR3RUMF7ZfnRmYq43XxVtggkd7Hpz2f4gB/QmNDx0h?=
 =?us-ascii?Q?1YFKVN8rkww2DRiQg/uu7FqPlQH1fanOS5ggjvPsfkhT/kAQbt4iS3pdf54p?=
 =?us-ascii?Q?w72PxBnvOZa9fVgY9+Xieae3Vjg5Rx/rgRG6pS90fhZ2Bm4pEiS7FzeU8qkH?=
 =?us-ascii?Q?5NHA2kQSQmvMQjYr2/5OAvCwzmC8abhqkB5JAtWx2gQcUbATNyxF1lDJPxFx?=
 =?us-ascii?Q?lh6C9BwVoFCivPBasVwedvS0euTu05yYCuABXXXAow0fBXKEzljQZlSjPcxo?=
 =?us-ascii?Q?b+ORsndN69zg/6qTAFOk2tDmbs/YJxQpHS9coc81SDSVPdGEh59Zv4q1oL3Y?=
 =?us-ascii?Q?1hm+iaeInIB9XDIeiOal8WGQS/YT9n7VZehT7Vrf988LlVhL2/owSIO0SinW?=
 =?us-ascii?Q?Mk/1xkWpUKf6FIIeS0hPqzDjfxOorFySnjssCC997+2nnavgUpB8SSxXjYMV?=
 =?us-ascii?Q?00DuCIEyczyxEfcc5x9xZo5L25q00aKxk/3A0wEP?=
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
X-MS-Exchange-CrossTenant-AuthSource: KUZP153MB1444.APCP153.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: bb90a9d0-9777-442b-041d-08dd94fc965c
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 May 2025 04:37:53.1278
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +8JNOU8gGAJZqVRIDz6i4mJNF5VcoN5t3oF7k0yD1F3BiTvnfPJIx7nu+M/DF577JZlGEdkUL1uPRELWs1JdnQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZP153MB0792

> From: Michael Kelley <mhklinux@outlook.com>
>=20
> The Hyper-V host provides guest VMs with a range of MMIO addresses that
> guest VMBus drivers can use. The VMBus driver in Linux manages that MMIO
> space, and allocates portions to drivers upon request. As part of managin=
g
> that MMIO space in a Generation 2 VM, the VMBus driver must reserve the
> portion of the MMIO space that Hyper-V has designated for the synthetic
> frame buffer, and not allocate this space to VMBus drivers other than gra=
phics
> framebuffer drivers. The synthetic frame buffer MMIO area is described by
> the screen_info data structure that is passed to the Linux kernel at boot=
 time,
> so the VMBus driver must access screen_info for Generation 2 VMs. (In
> Generation 1 VMs, the framebuffer MMIO space is communicated to the
> guest via a PCI pseudo-device, and access to screen_info is not needed.)
>=20
> In commit a07b50d80ab6 ("hyperv: avoid dependency on screen_info") the
> VMBus driver's access to screen_info is restricted to when CONFIG_SYSFB i=
s
> enabled. CONFIG_SYSFB is typically enabled in kernels built for Hyper-V b=
y
> virtue of having at least one of CONFIG_FB_EFI, CONFIG_FB_VESA, or
> CONFIG_SYSFB_SIMPLEFB enabled, so the restriction doesn't usually affect
> anything. But it's valid to have none of these enabled, in which case
> CONFIG_SYSFB is not enabled, and the VMBus driver is unable to properly
> reserve the framebuffer MMIO space for graphics framebuffer drivers. The
> framebuffer MMIO space may be assigned to some other VMBus driver, with
> undefined results. As an example, if a VM is using a PCI pass-thru NVMe
> controller to host the OS disk, the PCI NVMe controller is probed before =
any
> graphic devices, and the NVMe controller is assigned a portion of the
> framebuffer MMIO space.
> Hyper-V reports an error to Linux during the probe, and the OS disk fails=
 to
> get setup. Then Linux fails to boot in the VM.
>=20
> Fix this by having CONFIG_HYPERV always select SYSFB. Then the VMBus
> driver in a Gen 2 VM can always reserve the MMIO space for the graphics
> framebuffer driver, and prevent the undefined behavior.

One question: Shouldn't the SYSFB be selected by actual graphics framebuffe=
r driver
which is expected to use it. With this patch this option will be enabled ir=
respective
if there is any user for it or not, wondering if we can better optimize it =
for such systems.

- Saurabh

<Snip>

