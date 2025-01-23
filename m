Return-Path: <linux-hyperv+bounces-3762-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7960AA1A985
	for <lists+linux-hyperv@lfdr.de>; Thu, 23 Jan 2025 19:20:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 40B59188DAEA
	for <lists+linux-hyperv@lfdr.de>; Thu, 23 Jan 2025 18:20:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31BF815746B;
	Thu, 23 Jan 2025 18:20:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="he3P+qz6"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from SJ2PR03CU002.outbound.protection.outlook.com (mail-westusazon11023092.outbound.protection.outlook.com [52.101.44.92])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B3C71BC4E;
	Thu, 23 Jan 2025 18:20:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.44.92
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737656439; cv=fail; b=Jetpekz5UYRPCA8TKh7eJDuJE88qBi55dZUR/Uj/2uSdISh6Zqrwz3kPufACj2ssAqampZCijj+EMEE5cEank94HW5Rj10MWwfStgW6py7eJ+JMfTL4Xnpj4Hh7K9U0XJmbpXGEVnxHLUJgRMR0N0ZbWHEs/az+lJx7zEhk4iGE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737656439; c=relaxed/simple;
	bh=iT0DUM89ASQdcvvUuFIZGloD5d3A5WifgHcisGycslE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=RNgce1DDJaW41LUr6xvf4MsItrsb+bZg+M0A4JECxQiNLjzxIuof/ol+xhJhrZsb5wuJk+kCTpa8scvooUk9Oo3XzKGL4Gmpkwf8zWIW3412iJCyuvaHJbKyyH08HbspUePfL+2h+JMdz1K16cdBalEpM1nXQyLrbTChOxMN0iU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com; spf=pass smtp.mailfrom=microsoft.com; dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b=he3P+qz6; arc=fail smtp.client-ip=52.101.44.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microsoft.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kT/JOdkSUpTyD+6mpV3wOhBEdjuisfoOm78BJatLzAT6z9ZGlI+QTHt2bApSuGLHq0ASffHcqRSRhDLSIdLNsTNe9qcoQHMrcSSgQW9vYu8dw37RxhGNnJjzxQCELVyRu4IiM7sZZXS9jAsaXmXyNcDoSjMFbc6KKMl8sLRkL9dpyf7zMoeLjb5Gqqi0uBaXx0gTqoB1O9mDnAXWEPuL4bocsKnXsWtnSwTTnFvNEnk/apGVHoWrxdLQb1ii1Ja1SesY+F9r20oSOO0JgJuMd+pQ3myvcvqpiGkOTHVsl9HyAl2+TLxds0ENqFcwWWYo/f1VXyaY3Yrx2m5izF5TmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W490K6TqsUeqv4uqE+UBXy4BmLANNA5tACnev7xHI2E=;
 b=tk5MBAAHeX0XEkQKkDmQvsdQej9QqRKij3jR7H7h3fJsCkDxZZcN+cigK78/ktxwphnwR8nSSfY7vIh9RcLYO2fFacbhm2PKudfHAM1khZPAwbEJfwtIAsKkdotyzDmysLJ72bvMTvXhLdRG9oz2bwvApqmAij0EoNPaDUrHwRlf+TRAQqrBs3QEmmPoB1gkIkBB5UR/6CLrgYCVBkk5CMcWUyXLvDipYlm0l8gxj7OASygNzuG/Q2won3gEsJyLigOn2Aymy7c9gnggNUfgpTl3vW3yW4c8G0hO6uTACKftGkdUuzgsvrhlPFelB2dQsuvRzeGvScbuFM+wM1OxDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W490K6TqsUeqv4uqE+UBXy4BmLANNA5tACnev7xHI2E=;
 b=he3P+qz6wA69yZRfmy6eUSEliUgXSICr6HZ8+27wagWKmSCUCJ36Y1sQMw3iG2VBCuSEb4CdZHrmmhgNznVYH6JTc210RoVaqQToZfM6j/bd6bhlVZr3SlGP/BtlOFEnSaKzzacXH0mTeY2YmKdV6HfsSthwxZH1pzwySNohZzA=
Received: from SA6PR21MB4231.namprd21.prod.outlook.com (2603:10b6:806:412::20)
 by BL4PR21MB4602.namprd21.prod.outlook.com (2603:10b6:208:584::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.8; Thu, 23 Jan
 2025 18:20:34 +0000
Received: from SA6PR21MB4231.namprd21.prod.outlook.com
 ([fe80::5c62:d7c6:4531:3aff]) by SA6PR21MB4231.namprd21.prod.outlook.com
 ([fe80::5c62:d7c6:4531:3aff%5]) with mapi id 15.20.8398.005; Thu, 23 Jan 2025
 18:20:34 +0000
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
Subject: RE: [PATCH rdma-next 09/13] RDMA/mana_ib: UD/GSI work requests
Thread-Topic: [PATCH rdma-next 09/13] RDMA/mana_ib: UD/GSI work requests
Thread-Index: AQHba2CX3ffDor3vFUi6KFFqK+OQ4LMkrtiw
Date: Thu, 23 Jan 2025 18:20:34 +0000
Message-ID:
 <SA6PR21MB4231D21C388D916D759B2833CEE02@SA6PR21MB4231.namprd21.prod.outlook.com>
References: <1737394039-28772-1-git-send-email-kotaranov@linux.microsoft.com>
 <1737394039-28772-10-git-send-email-kotaranov@linux.microsoft.com>
In-Reply-To:
 <1737394039-28772-10-git-send-email-kotaranov@linux.microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=079c16a4-b71d-473c-b0c3-0feb8632244b;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2025-01-23T18:15:36Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Tag=10,
 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA6PR21MB4231:EE_|BL4PR21MB4602:EE_
x-ms-office365-filtering-correlation-id: 9da23671-d3a1-468f-0e3e-08dd3bdaa0c1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|7416014|1800799024|366016|7053199007|38070700018|921020;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?4SZUuxlbNRhJXgheojk7+v0TfpCtYKvtTlnAlgvQGvORKcgLfZKKelXLtjqU?=
 =?us-ascii?Q?csoU78KVFvqlkpNpdw1mY8Y5qFMP++bZGQVVPrH1EyHKDVBCC8RznS2KSUy4?=
 =?us-ascii?Q?28NSntxUMPlkrVHL16DUix6OI5HsmNzo5+O5yRlWyq1DpVKlSu6hw5TSxF7x?=
 =?us-ascii?Q?wkeY8rolOfaQv9m8NdpduAae+5ncGIxPwRZvJpfJMgLV6b7RM8hPGX5QqJUg?=
 =?us-ascii?Q?G7Xe3BloQ4R2WqGGSAZGVnHRZK42BSlwWtUuokH+qQUALcIzYfY9+Wp+S+oI?=
 =?us-ascii?Q?dvaKZ9Qu+Kpm2ejfgqlK9qPdg0BG8NAuYbbf9UoZ4cdYSbgT6oTdsbUH33Xk?=
 =?us-ascii?Q?GyyWXMBJBE41fFJDYwEEsqT/ckXuBuXM4t2fETpsVl+M1v+rDfHTBHi6MO9W?=
 =?us-ascii?Q?8glGs3bLVtuZml5n1SivO9HxR4knMI9yezfEsec7b1repN7pretXAdrIIhs9?=
 =?us-ascii?Q?EWZidZy3m4a0T8BOaAJRZSA9G6UpytPlapwME3UIV2q0mNFICtVdWduwbxOC?=
 =?us-ascii?Q?g+0a7SQ7C3vQbITPJvrZ89wE5lAagTAE1bGkg0JYTbZ7/OUhhQNDiVtXEi2j?=
 =?us-ascii?Q?LEVdl7SvIlXWN1gdE83+9xFhANEVmdGW/cOxSfYN4IZrft809yJgogVLLcxc?=
 =?us-ascii?Q?5dN6+1qCrpuZ821JzTrZIdSaqd+kdob5eUgK64GYV0o6bXpjUfpzG5VHFNjJ?=
 =?us-ascii?Q?D9jTLuU6MRIUqus0xS/ZfYvdTMTrnStRHQyXuiyYFCCaeGZfj/JsiXTL968s?=
 =?us-ascii?Q?1dOgq1BU71Gayj7mMdFl7e7w3DVDx0iE7vxyDrh64qx7hGvzgek54NCPIz+N?=
 =?us-ascii?Q?NT9Q2fYzRCrfxruLjKVjGp8N9Ie2eJgOExNSvCR6w03Rf6td8reIaqYn07JP?=
 =?us-ascii?Q?olPRXFVjtmxtmGWZuZVMsMpQ+hn73Tqla1p9c/CxYVqs3RiqhfE4RjtcZiHw?=
 =?us-ascii?Q?DuHJB56/MG8uR3TJaoiqvMaXbGTEuftK4MzUBWCUQUYo0nRJ8JLxDBOQ8ehw?=
 =?us-ascii?Q?aoPSwqqqa9oK4B53VSFpEaFWq/G8HiOPZHKaMxv0BRCHr1o/AUekxxyTPANb?=
 =?us-ascii?Q?XncF+VYcxZXisUhFxLqOyR/EXdJk18Z8/i7yrZnTl/+Yd7UN7wASMTYLNCaF?=
 =?us-ascii?Q?MkSrXuhsdSAu1SRwYVKRQ47mP03hgwxsMf2N9xQAr8iY7CqONL2pcN/j24pN?=
 =?us-ascii?Q?gJHrabdh0iBt/gd8RQ3UpAlTQoJw9y/yB1Z+FlrsXAq7LTmleEWC2fJnM/Zp?=
 =?us-ascii?Q?kcoYByci0U8h+JKdq1eCzmTMC1MpIaG/NZDTH/5nQ79fuI7xWIENI4bkPRuv?=
 =?us-ascii?Q?+pdpZUDk4aoIVCuEWfF2euPmdJqQCs1NdLyrPBD1zQ4kbdrglLDABEqaraT8?=
 =?us-ascii?Q?bcnDGKyH5WJZUFmyb5DNxe2+qWhS4GYwK75dnzlIVwQmJRL7za3pZf8P3Obe?=
 =?us-ascii?Q?jxmHJOWEvRoB3gdydpkTngQsOYAqztBF1Bs973jSGmx89IFyIZOkaw=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA6PR21MB4231.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(7053199007)(38070700018)(921020);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?LChTIEqiQVSxGK1E/CzCbdQfV1/ieqLKzthN5JiRWZ4+MjACTjXTT1CmncJ2?=
 =?us-ascii?Q?NRqP1x525z8bPU8RNKG35V2Q6EArnBdV7t4p9VDoTRhoHkTkp+sFWsnMNxQ7?=
 =?us-ascii?Q?wGRuw2WYInZk3rgVsVy3CeZPL8H2JM2ljtdXn/zSqka21SKgjy/p3DQoPcek?=
 =?us-ascii?Q?iy3pcfl+qlvP4+mAxOilCbYwFi/tdsrqwvRnvuZ/P4EeZUM2B2pZ1ZmmIAR4?=
 =?us-ascii?Q?7fhWBIya07YnGeUqEiQTLU2BiMzhWytpiMQtc2mjVLrHTXhKXLzCn1eLLr1E?=
 =?us-ascii?Q?Zakp2wpmnfHR/tN+7zt1T/sCEfwiHQQkZlyME5/73RZFBUqFlqf6BtSHCeSx?=
 =?us-ascii?Q?zJEEHOWm97JU7xoQl5oxUmSmFBAPlW1Ic2fhVesc4yWL+eLe98PFzN3VZMT3?=
 =?us-ascii?Q?mqDDQK9q36pipcYluABqcVQQSV0wmCaMfK7v/UqAObszN8zMkVSeLRPj7S/a?=
 =?us-ascii?Q?NnaVWmZ+zRq/A+p4WwHJ8TWwJFddxYGLI5vBo3rFsv3AGqYtUQaQmzxX10gs?=
 =?us-ascii?Q?tlwgvs5gGwNvJRf/0OIee+xYScIrkQUQR9CuHjV3UgQwE+3HLL2474HYv3ez?=
 =?us-ascii?Q?Ne1lI59tFvch4+GQvbYDPoSx6nxw5vxDHq1r/k7yYIdFeX6Ogp3d/FBjl9IU?=
 =?us-ascii?Q?++Pd9pfgdxf0HcI6UR4XChpygrTwtbb7qUVBo6mLIhI8AKGQsS+RtPGwNn89?=
 =?us-ascii?Q?9hoEoSJI4a3cu9069jjsQMEgLvNVU/Q6ACa8Os5tAgiTmCQGhscC+gPrE7vr?=
 =?us-ascii?Q?63O1P8ervPRXO4hUFwBhV/SzCtTTI9Qy2HmA3iCoTrQEVHfrHe7FqLgOscaD?=
 =?us-ascii?Q?Rk/XFHZZWLZROnyA+3snZ4OaAXzJJYgMiGRgCGm2wLxsD/VdJd+WIQCbcyd5?=
 =?us-ascii?Q?Ig42vF10TO1tEdk33/ul6nQudfMgaqugoF2FZBeoBwhGtSK/O7jkWlzDu89Q?=
 =?us-ascii?Q?BXjq7Axp2cj/8RYHut42gwyH6qJdoLJ6ymOUEl4htoDANTAGtMLMyPfMdJ0M?=
 =?us-ascii?Q?z3ADf7HEkp2meuzneYdY0L/2gScjEqZoNsdTI1mVCa3WhRsY9LYEdCflbqB5?=
 =?us-ascii?Q?nJb8WlWzdRJnlIyHw4D7aEW8bclLYwMNSTrRDJXLF+SJSLIz+agqANiD/mY9?=
 =?us-ascii?Q?DSIrPUdocwmdiNlGnu7FesLu5Hcb/ZBWrWFsWZVrTEXgedgxnL0Kp1QMJzNe?=
 =?us-ascii?Q?XiTPyyXpQlo7AG8J3qgbRUZ5bJxufgWjI4wSlmEepn2qynQQRrfwMzZZe5Sg?=
 =?us-ascii?Q?RUzbzLMeB1EKff9RU39sBIM3SAQ18gKl64RXo4V1ueVsKiCeb42l4p8davs1?=
 =?us-ascii?Q?9ajWW9e8geMkXzibQJwT0BE37c2V70HJTHclJMjZoHxPBWybtmBc4biQPu2y?=
 =?us-ascii?Q?dRugbzdWn5NL4rYHt0QrbYLhN2K2RDbojFZKrKfnirvKIX4CnmhMfGXtBrvc?=
 =?us-ascii?Q?KA8JT6X/FFp4PG9YgN6Qin4Vj+l9iI7tZ6bZ4zvwCqs7ZOAfxucKJpWoXrS2?=
 =?us-ascii?Q?HZ5sTRcda6t0EGyFyCBRn35o6l3eZUC4l8B5sxbb4sqBYYMsqX7j+c8zs/z1?=
 =?us-ascii?Q?n72KupPdR6dwOdjrj/vGYYe+bVaNB56wJX0MISnY?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 9da23671-d3a1-468f-0e3e-08dd3bdaa0c1
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jan 2025 18:20:34.1923
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Mfn4UC3zZwvH7joyEu2OTF3LPIr/QlpoNhQmmPhDYnhX9kU9x/TqYAhhlz/WFjyX4tCHRCCcjIXVODa9qNIXIg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL4PR21MB4602



> -----Original Message-----
> From: Konstantin Taranov <kotaranov@linux.microsoft.com>
> Sent: Monday, January 20, 2025 9:27 AM
> To: Konstantin Taranov <kotaranov@microsoft.com>; Shiraz Saleem
> <shirazsaleem@microsoft.com>; pabeni@redhat.com; Haiyang Zhang
> <haiyangz@microsoft.com>; KY Srinivasan <kys@microsoft.com>;
> edumazet@google.com; kuba@kernel.org; davem@davemloft.net; Dexuan Cui
> <decui@microsoft.com>; wei.liu@kernel.org; sharmaajay@microsoft.com; Long
> Li <longli@microsoft.com>; jgg@ziepe.ca; leon@kernel.org
> Cc: linux-rdma@vger.kernel.org; linux-kernel@vger.kernel.org;
> netdev@vger.kernel.org; linux-hyperv@vger.kernel.org
> Subject: [PATCH rdma-next 09/13] RDMA/mana_ib: UD/GSI work requests
>=20
> From: Konstantin Taranov <kotaranov@microsoft.com>
>=20
> Implement post send and post recv for UD/GSI QPs.
> Add information about posted requests into shadow queues.
>=20
> Co-developed-by: Shiraz Saleem <shirazsaleem@microsoft.com>
> Signed-off-by: Shiraz Saleem <shirazsaleem@microsoft.com>
> Signed-off-by: Konstantin Taranov <kotaranov@microsoft.com>
> ---
>  drivers/infiniband/hw/mana/Makefile           |   2 +-
>  drivers/infiniband/hw/mana/device.c           |   2 +
>  drivers/infiniband/hw/mana/mana_ib.h          |  33 ++++
>  drivers/infiniband/hw/mana/qp.c               |  21 ++-
>  drivers/infiniband/hw/mana/shadow_queue.h     | 115 ++++++++++++
>  drivers/infiniband/hw/mana/wr.c               | 168 ++++++++++++++++++
>  .../net/ethernet/microsoft/mana/gdma_main.c   |   2 +
>  7 files changed, 341 insertions(+), 2 deletions(-)  create mode 100644
> drivers/infiniband/hw/mana/shadow_queue.h
>  create mode 100644 drivers/infiniband/hw/mana/wr.c
>=20
> diff --git a/drivers/infiniband/hw/mana/Makefile
> b/drivers/infiniband/hw/mana/Makefile
> index 6e56f77..79426e7 100644
> --- a/drivers/infiniband/hw/mana/Makefile
> +++ b/drivers/infiniband/hw/mana/Makefile
> @@ -1,4 +1,4 @@
>  # SPDX-License-Identifier: GPL-2.0-only
>  obj-$(CONFIG_MANA_INFINIBAND) +=3D mana_ib.o
>=20
> -mana_ib-y :=3D device.o main.o wq.o qp.o cq.o mr.o ah.o
> +mana_ib-y :=3D device.o main.o wq.o qp.o cq.o mr.o ah.o wr.o
> diff --git a/drivers/infiniband/hw/mana/device.c
> b/drivers/infiniband/hw/mana/device.c
> index d534ef1..1da86c3 100644
> --- a/drivers/infiniband/hw/mana/device.c
> +++ b/drivers/infiniband/hw/mana/device.c
> @@ -40,6 +40,8 @@ static const struct ib_device_ops mana_ib_dev_ops =3D {
>  	.mmap =3D mana_ib_mmap,
>  	.modify_qp =3D mana_ib_modify_qp,
>  	.modify_wq =3D mana_ib_modify_wq,
> +	.post_recv =3D mana_ib_post_recv,
> +	.post_send =3D mana_ib_post_send,
>  	.query_device =3D mana_ib_query_device,
>  	.query_gid =3D mana_ib_query_gid,
>  	.query_pkey =3D mana_ib_query_pkey,
> diff --git a/drivers/infiniband/hw/mana/mana_ib.h
> b/drivers/infiniband/hw/mana/mana_ib.h
> index 7b079d8..6265c39 100644
> --- a/drivers/infiniband/hw/mana/mana_ib.h
> +++ b/drivers/infiniband/hw/mana/mana_ib.h
> @@ -14,6 +14,7 @@
>  #include <linux/dmapool.h>
>=20
>  #include <net/mana/mana.h>
> +#include "shadow_queue.h"
>=20
>  #define PAGE_SZ_BM                                                      =
       \
>  	(SZ_4K | SZ_8K | SZ_16K | SZ_32K | SZ_64K | SZ_128K | SZ_256K |        =
\
> @@ -165,6 +166,9 @@ struct mana_ib_qp {
>  	/* The port on the IB device, starting with 1 */
>  	u32 port;
>=20
> +	struct shadow_queue shadow_rq;
> +	struct shadow_queue shadow_sq;
> +
>  	refcount_t		refcount;
>  	struct completion	free;
>  };
> @@ -404,6 +408,30 @@ struct mana_rnic_set_qp_state_resp {
>  	struct gdma_resp_hdr hdr;
>  }; /* HW Data */
>=20
> +enum WQE_OPCODE_TYPES {
> +	WQE_TYPE_UD_SEND =3D 0,
> +	WQE_TYPE_UD_RECV =3D 8,
> +}; /* HW DATA */
> +
> +struct rdma_send_oob {
> +	u32 wqe_type	: 5;
> +	u32 fence	: 1;
> +	u32 signaled	: 1;
> +	u32 solicited	: 1;
> +	u32 psn		: 24;
> +
> +	u32 ssn_or_rqpn	: 24;
> +	u32 reserved1	: 8;
> +	union {
> +		struct {
> +			u32 remote_qkey;
> +			u32 immediate;
> +			u32 reserved1;
> +			u32 reserved2;
> +		} ud_send;
> +	};
> +}; /* HW DATA */
> +
>  static inline struct gdma_context *mdev_to_gc(struct mana_ib_dev *mdev) =
 {
>  	return mdev->gdma_dev->gdma_context;
> @@ -562,4 +590,9 @@ int mana_ib_gd_destroy_ud_qp(struct mana_ib_dev
> *mdev, struct mana_ib_qp *qp);  int mana_ib_create_ah(struct ib_ah *ibah,
> struct rdma_ah_init_attr *init_attr,
>  		      struct ib_udata *udata);
>  int mana_ib_destroy_ah(struct ib_ah *ah, u32 flags);
> +
> +int mana_ib_post_recv(struct ib_qp *ibqp, const struct ib_recv_wr *wr,
> +		      const struct ib_recv_wr **bad_wr); int
> mana_ib_post_send(struct
> +ib_qp *ibqp, const struct ib_send_wr *wr,
> +		      const struct ib_send_wr **bad_wr);
>  #endif
> diff --git a/drivers/infiniband/hw/mana/qp.c b/drivers/infiniband/hw/mana=
/qp.c
> index fea45be..051ea03 100644
> --- a/drivers/infiniband/hw/mana/qp.c
> +++ b/drivers/infiniband/hw/mana/qp.c
> @@ -562,10 +562,23 @@ static int mana_ib_create_ud_qp(struct ib_qp *ibqp,
> struct ib_pd *ibpd,
>  	}
>  	doorbell =3D gc->mana_ib.doorbell;
>=20
> +	err =3D create_shadow_queue(&qp->shadow_rq, attr->cap.max_recv_wr,
> +				  sizeof(struct ud_rq_shadow_wqe));
> +	if (err) {
> +		ibdev_err(&mdev->ib_dev, "Failed to create shadow rq
> err %d\n", err);
> +		goto destroy_queues;
> +	}
> +	err =3D create_shadow_queue(&qp->shadow_sq, attr->cap.max_send_wr,
> +				  sizeof(struct ud_sq_shadow_wqe));
> +	if (err) {
> +		ibdev_err(&mdev->ib_dev, "Failed to create shadow sq
> err %d\n", err);
> +		goto destroy_shadow_queues;
> +	}
> +
>  	err =3D mana_ib_gd_create_ud_qp(mdev, qp, attr, doorbell, attr->qp_type=
);
>  	if (err) {
>  		ibdev_err(&mdev->ib_dev, "Failed to create ud qp  %d\n", err);
> -		goto destroy_queues;
> +		goto destroy_shadow_queues;
>  	}
>  	qp->ibqp.qp_num =3D qp->ud_qp.queues[MANA_UD_RECV_QUEUE].id;
>  	qp->port =3D attr->port_num;
> @@ -575,6 +588,9 @@ static int mana_ib_create_ud_qp(struct ib_qp *ibqp,
> struct ib_pd *ibpd,
>=20
>  	return 0;
>=20
> +destroy_shadow_queues:
> +	destroy_shadow_queue(&qp->shadow_rq);
> +	destroy_shadow_queue(&qp->shadow_sq);
>  destroy_queues:
>  	while (i-- > 0)
>  		mana_ib_destroy_queue(mdev, &qp->ud_qp.queues[i]); @@ -
> 754,6 +770,9 @@ static int mana_ib_destroy_ud_qp(struct mana_ib_qp *qp,
> struct ib_udata *udata)
>  		container_of(qp->ibqp.device, struct mana_ib_dev, ib_dev);
>  	int i;
>=20
> +	destroy_shadow_queue(&qp->shadow_rq);
> +	destroy_shadow_queue(&qp->shadow_sq);
> +
>  	/* Ignore return code as there is not much we can do about it.
>  	 * The error message is printed inside.
>  	 */
> diff --git a/drivers/infiniband/hw/mana/shadow_queue.h
> b/drivers/infiniband/hw/mana/shadow_queue.h
> new file mode 100644
> index 0000000..d8bfb4c
> --- /dev/null
> +++ b/drivers/infiniband/hw/mana/shadow_queue.h
> @@ -0,0 +1,115 @@
> +/* SPDX-License-Identifier: GPL-2.0 OR Linux-OpenIB */
> +/*
> + * Copyright (c) 2024, Microsoft Corporation. All rights reserved.
> + */
> +
> +#ifndef _MANA_SHADOW_QUEUE_H_
> +#define _MANA_SHADOW_QUEUE_H_
> +
> +struct shadow_wqe_header {
> +	u16 opcode;
> +	u16 error_code;
> +	u32 posted_wqe_size;
> +	u64 wr_id;
> +};
> +
> +struct ud_rq_shadow_wqe {
> +	struct shadow_wqe_header header;
> +	u32 byte_len;
> +	u32 src_qpn;
> +};
> +
> +struct ud_sq_shadow_wqe {
> +	struct shadow_wqe_header header;
> +};
> +
> +struct shadow_queue {
> +	/* Unmasked producer index, Incremented on wqe posting */
> +	u64 prod_idx;
> +	/* Unmasked consumer index, Incremented on cq polling */
> +	u64 cons_idx;
> +	/* Unmasked index of next-to-complete (from HW) shadow WQE */
> +	u64 next_to_complete_idx;
> +	/* queue size in wqes */
> +	u32 length;
> +	/* distance between elements in bytes */
> +	u32 stride;
> +	/* ring buffer holding wqes */
> +	void *buffer;
> +};
> +
> +static inline int create_shadow_queue(struct shadow_queue *queue,
> +uint32_t length, uint32_t stride) {
> +	queue->buffer =3D kvmalloc(length * stride, GFP_KERNEL);
> +	if (!queue->buffer)
> +		return -ENOMEM;
> +
> +	queue->length =3D length;
> +	queue->stride =3D stride;
> +
> +	return 0;
> +}
> +
> +static inline void destroy_shadow_queue(struct shadow_queue *queue) {
> +	kvfree(queue->buffer);
> +}
> +
> +static inline bool shadow_queue_full(struct shadow_queue *queue) {
> +	return (queue->prod_idx - queue->cons_idx) >=3D queue->length; }
> +
> +static inline bool shadow_queue_empty(struct shadow_queue *queue) {
> +	return queue->prod_idx =3D=3D queue->cons_idx; }
> +
> +static inline void *
> +shadow_queue_get_element(const struct shadow_queue *queue, u64
> +unmasked_index) {
> +	u32 index =3D unmasked_index % queue->length;
> +
> +	return ((u8 *)queue->buffer + index * queue->stride); }
> +
> +static inline void *
> +shadow_queue_producer_entry(struct shadow_queue *queue) {
> +	return shadow_queue_get_element(queue, queue->prod_idx); }
> +
> +static inline void *
> +shadow_queue_get_next_to_consume(const struct shadow_queue *queue) {
> +	if (queue->cons_idx =3D=3D queue->next_to_complete_idx)
> +		return NULL;
> +
> +	return shadow_queue_get_element(queue, queue->cons_idx); }
> +
> +static inline void *
> +shadow_queue_get_next_to_complete(struct shadow_queue *queue) {
> +	if (queue->next_to_complete_idx =3D=3D queue->prod_idx)
> +		return NULL;
> +
> +	return shadow_queue_get_element(queue, queue-
> >next_to_complete_idx); }
> +
> +static inline void shadow_queue_advance_producer(struct shadow_queue
> +*queue) {
> +	queue->prod_idx++;
> +}
> +
> +static inline void shadow_queue_advance_consumer(struct shadow_queue
> +*queue) {
> +	queue->cons_idx++;
> +}
> +
> +static inline void shadow_queue_advance_next_to_complete(struct
> +shadow_queue *queue) {
> +	queue->next_to_complete_idx++;
> +}
> +
> +#endif
> diff --git a/drivers/infiniband/hw/mana/wr.c b/drivers/infiniband/hw/mana=
/wr.c
> new file mode 100644 index 0000000..1813567
> --- /dev/null
> +++ b/drivers/infiniband/hw/mana/wr.c
> @@ -0,0 +1,168 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Copyright (c) 2024, Microsoft Corporation. All rights reserved.
> + */
> +
> +#include "mana_ib.h"
> +
> +#define MAX_WR_SGL_NUM (2)
> +
> +static int mana_ib_post_recv_ud(struct mana_ib_qp *qp, const struct
> +ib_recv_wr *wr) {
> +	struct mana_ib_dev *mdev =3D container_of(qp->ibqp.device, struct
> mana_ib_dev, ib_dev);
> +	struct gdma_queue *queue =3D qp-
> >ud_qp.queues[MANA_UD_RECV_QUEUE].kmem;
> +	struct gdma_posted_wqe_info wqe_info =3D {0};
> +	struct gdma_sge gdma_sgl[MAX_WR_SGL_NUM];
> +	struct gdma_wqe_request wqe_req =3D {0};
> +	struct ud_rq_shadow_wqe *shadow_wqe;
> +	int err, i;
> +
> +	if (shadow_queue_full(&qp->shadow_rq))
> +		return -EINVAL;
> +
> +	if (wr->num_sge > MAX_WR_SGL_NUM)
> +		return -EINVAL;
> +
> +	for (i =3D 0; i < wr->num_sge; ++i) {
> +		gdma_sgl[i].address =3D wr->sg_list[i].addr;
> +		gdma_sgl[i].mem_key =3D wr->sg_list[i].lkey;
> +		gdma_sgl[i].size =3D wr->sg_list[i].length;
> +	}
> +	wqe_req.num_sge =3D wr->num_sge;
> +	wqe_req.sgl =3D gdma_sgl;
> +
> +	err =3D mana_gd_post_work_request(queue, &wqe_req, &wqe_info);
> +	if (err)
> +		return err;
> +
> +	shadow_wqe =3D shadow_queue_producer_entry(&qp->shadow_rq);
> +	memset(shadow_wqe, 0, sizeof(*shadow_wqe));

I would avoid using memset since this is on data path.

The patch looks good otherwise.

Long


