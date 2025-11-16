Return-Path: <linux-hyperv+bounces-7618-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 988C9C61DE1
	for <lists+linux-hyperv@lfdr.de>; Sun, 16 Nov 2025 22:51:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 1F5C3356E1A
	for <lists+linux-hyperv@lfdr.de>; Sun, 16 Nov 2025 21:51:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A920827B4F7;
	Sun, 16 Nov 2025 21:50:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="CZ7C2f+2"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11020139.outbound.protection.outlook.com [52.101.46.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BB1027B34D;
	Sun, 16 Nov 2025 21:50:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.139
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763329849; cv=fail; b=H8SmZiuI8zMdZEQ1zSW7/knkj+b1HfqYzexMpGlVOvYB84zSIaj/kMJdG9FYR3ywrJ2XeaW0OsDYjiCnupAZ7HqE39OGlt77flWioUCVV81zhQi2cwlp9Ctp5fcu7XHMDT5jglY2mVMrtgx1ongecxiTrMyXXrbHc7SGJBxWSSU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763329849; c=relaxed/simple;
	bh=NUtmTnA2H+27Uf/rdax2/aHOD8BaAumLuofa5Z5s3DU=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ANC+YQxm8A7MJy3Fh5c0DlVTWHPIRDi9UlLjCLy0DVKWkYU302RGoKmlyP3ONtpKMraH8PqvqEy3Ij+AU8jnvBjXB0k64bypacgk1vPWc4mOYY9UL+U1yWu/ovjgJjhTyuwBOPPOrsxZ7NVItgDUhSPiz5tzgzErneiiyFnuGgw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com; spf=pass smtp.mailfrom=microsoft.com; dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b=CZ7C2f+2; arc=fail smtp.client-ip=52.101.46.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microsoft.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GIaOexf7YlZltE0skoMKFEMjAzRtoQEh+RTx6AYZpSlg/B6GoCmBERScyxjr3ODqhal79ApQzB1WRSrgE/7vBn4K55Yvm6BuDfY/wvJkapKwUjmnujDyQj02Z350olvb3xqIxgtiUEWlc/OcNVK/9IevV8pV6BVzpcy79uSPQ0aEd1P6jYcGh6ZNKxJnOximeRYnWSeh245yHftzYENDjCridRHo2T4wiDGdnVQZDyi59AyR3gm9UQ377h2Gx5yjFvrroUbGLRwX77LvVCUegrAeZgU9U38yVydsZcQWRYFkP8n8ml8+y/QFxb2Hh/CBY3SBh+CtGVNACNQC3lX6bw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NUtmTnA2H+27Uf/rdax2/aHOD8BaAumLuofa5Z5s3DU=;
 b=cGEqknA9QHcfaasjNexCay3pjU4TxV2S+MskhED/XaMIJEuahPJbHwRerckRZJpduDwbk14D++2Q+bBOVVDj67n8l3NJjT/JdUHZmukAnBxFnJMixusnNny9dl9jQIJb0x1I/ee0zI/Ij0fv9AXdELEX7wIrB4EKYY0IrBUzWgryVctMTFkI/0q512BAWArrOLzsMnG15U3oFCSdRmnpwAloES8NV/vxz3K+qev3R7OPmKGD8OGxShl2xBmkN5CE8HV8EMgp5gJdsxaTdmMkJNEWbjtvgtGDLZwsVer74B1S8zJZhXx7nJyeHJLU3f1fmJ7BB1udAw9pTd82SIxJiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NUtmTnA2H+27Uf/rdax2/aHOD8BaAumLuofa5Z5s3DU=;
 b=CZ7C2f+2ke/BtMZCLyYFJ/L+qzbCX6nH9YIbbjGspTdowJ3PiOWjuask0/OhIKz34d1p5n+U0zUhM0YSHYPlmji1lzcfVeKwaFuN8zixusNatcYY44MPNEhIX33v/bXtaeKn09z1c/lJRasaGG9FWCq7aiDc6/Cxmte8/c1NZ0E=
Received: from SA3PR21MB3867.namprd21.prod.outlook.com (2603:10b6:806:2fc::15)
 by LV5PR21MB5066.namprd21.prod.outlook.com (2603:10b6:408:2f9::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.7; Sun, 16 Nov
 2025 21:50:43 +0000
Received: from SA3PR21MB3867.namprd21.prod.outlook.com
 ([fe80::70ff:4d3:2cb6:92a3]) by SA3PR21MB3867.namprd21.prod.outlook.com
 ([fe80::70ff:4d3:2cb6:92a3%4]) with mapi id 15.20.9343.006; Sun, 16 Nov 2025
 21:50:43 +0000
From: Haiyang Zhang <haiyangz@microsoft.com>
To: Erni Sri Satya Vennela <ernis@linux.microsoft.com>, KY Srinivasan
	<kys@microsoft.com>, "wei.liu@kernel.org" <wei.liu@kernel.org>, Dexuan Cui
	<DECUI@microsoft.com>, "andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>,
	"davem@davemloft.net" <davem@davemloft.net>, "edumazet@google.com"
	<edumazet@google.com>, "kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>, Long Li <longli@microsoft.com>,
	Konstantin Taranov <kotaranov@microsoft.com>, "horms@kernel.org"
	<horms@kernel.org>, "shradhagupta@linux.microsoft.com"
	<shradhagupta@linux.microsoft.com>, "ssengar@linux.microsoft.com"
	<ssengar@linux.microsoft.com>, "dipayanroy@linux.microsoft.com"
	<dipayanroy@linux.microsoft.com>, Shiraz Saleem <shirazsaleem@microsoft.com>,
	"sbhatta@marvell.com" <sbhatta@marvell.com>, "linux-hyperv@vger.kernel.org"
	<linux-hyperv@vger.kernel.org>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-rdma@vger.kernel.org"
	<linux-rdma@vger.kernel.org>
Subject: RE: [PATCH net-next v3 2/2] net: mana: Add standard counter
 rx_missed_errors
Thread-Topic: [PATCH net-next v3 2/2] net: mana: Add standard counter
 rx_missed_errors
Thread-Index: AQHcVVvkf03sEc2SfEG7uu84+Y3Lc7T12vhA
Date: Sun, 16 Nov 2025 21:50:43 +0000
Message-ID:
 <SA3PR21MB3867743127EB14750197FF11CAC8A@SA3PR21MB3867.namprd21.prod.outlook.com>
References: <1763120599-6331-1-git-send-email-ernis@linux.microsoft.com>
 <1763120599-6331-3-git-send-email-ernis@linux.microsoft.com>
In-Reply-To: <1763120599-6331-3-git-send-email-ernis@linux.microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=c85e4be3-607e-408a-88a0-1bd22dac07a5;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2025-11-16T21:49:12Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Tag=10,
 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA3PR21MB3867:EE_|LV5PR21MB5066:EE_
x-ms-office365-filtering-correlation-id: ddcb7055-5f51-4da4-030d-08de255a313b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|7416014|366016|1800799024|7053199007|38070700021|921020;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?aJRkrFc3yVxCfhEkg1qUgTEQwG05R2Zm2VEI43ejG8roC6WH9Nf0bDmAaJ4b?=
 =?us-ascii?Q?oZ3b1OtLhtznnd47wxo90JdcMJtrqMbYKrrJoi3QRpVv5UQPQdA18Q8pO6fj?=
 =?us-ascii?Q?N7SYJCKsmE7IfjWIqXucgxewOuBKnudLCT6PzdPcOkoIWqsv77R3tbE4S8Jc?=
 =?us-ascii?Q?4M7SlagIGXriymHLLXQmTJ/xTBlVX52WpkBUufiLkCgJidAR07T0jUnjbJs4?=
 =?us-ascii?Q?Zp3s4p/hhZLmiJqYK/9t410XlpvHOnw6kNdx7/7IRuqy1iQ4UjwWroaj5K0p?=
 =?us-ascii?Q?x/4BszuOrazJGnQLpLrvFi+P16HQpSDLVEECC9z5eFhH6j6sM9Rh0uSDHaKC?=
 =?us-ascii?Q?9IEL47+CBp5drq43qUS0raTW2xI93A23EgDBLHPo+d7ATQ3vGsC0MLvO9CGF?=
 =?us-ascii?Q?oh+NkjMcl5Ya3vDAtk0JHnZmzBwe02olwJCbHjPFGK10ezTy+ulbUiSn+thI?=
 =?us-ascii?Q?UVXUPQSuWUUbI1FRCg4WG+p7QmrtKO3r0CDvhwNuvpg154BE/GXIYm7DGc8c?=
 =?us-ascii?Q?wGkP1qFkMIk+1LiGsSXRn2kaNlLdRF79+xe/taHnEHX9ZEzabfTy30v1ptkZ?=
 =?us-ascii?Q?zObBbo7CgQ4cxwYH0KlGhQJYwugpPZa15oD/bU7mUIb1HR5C3xHfVlgBTH6r?=
 =?us-ascii?Q?oL6Br/IA2E1YkrbfFen7z2rhQAeSXi9aX8KNPhAy4GJtK1qrdY5vCVYuXJvW?=
 =?us-ascii?Q?Ewdh9o0N3sg61kVX/vSbcLNW74NUhTERSHjc7F3oEV1fsE/lupRrVCl8Fs1v?=
 =?us-ascii?Q?eelQ6eI8pwBAVzrfOwMgRrFGkf9/awWD7xOFaXm9psB2aQ7i3J16ZbjOEWT5?=
 =?us-ascii?Q?ziGyYoE+pkHWsOyDelymuzAUE8jqAsi8ZgRaVMhAwryXkBtT2xJ+5Ct9vWwv?=
 =?us-ascii?Q?vo6QqPPKBo3Z2HmhZK9hSA3OsoWHAiv0fycWxNOrbnec9Zea6CQtuGwR4xiX?=
 =?us-ascii?Q?F/TqD3FTyBMCiEdADGlsf6bGI8FVnbvd3coAmt7VOEYuTE/r8NJkkxvscBEa?=
 =?us-ascii?Q?aC3uOYPB0bHbVd0aSfdnHyabTW12wbiOyXGfZu7p63kqSvjg4P5IVTd4ooef?=
 =?us-ascii?Q?z/CpUWRNWghUskPynJiG67OW9E+4H/WhdW2wp42+uxP8cSkqYfQj4jqP87JS?=
 =?us-ascii?Q?av0A1qwFwULqrOZbb2A0NvI3ImY5JmlColO+LqYnYJFhGB56scS1p6pd8Tel?=
 =?us-ascii?Q?Xvie6dhicaQ+Fq7VhO3KbAGGJ4dqCX/TawCIQzO3v9+eh4eWgMuBun5+1TMY?=
 =?us-ascii?Q?JvOe7w1akSVEx/j9uxx0lmfYdivyliWKeZSPG3JODe58rblnnag3tZWRU8UW?=
 =?us-ascii?Q?MgPNdmgUVPCRZUhS+DjjrQc7+4hDfWTwpdkisuDHNV+hakpVhaRMrUUKIycw?=
 =?us-ascii?Q?KhgcIoK5Q5NMuESZrakt/AMPf2Bm53x/V8O9sW+2aBWDQgnRb5zgellhfwAt?=
 =?us-ascii?Q?HJbJctpE0N3mEf5Us35JQKzcL1n728wFnTZZFu1v2djDygTPFngKKwknDoDO?=
 =?us-ascii?Q?gTpNkOHAKpgGZZ+X1iagKO8fIXtoodLYqj3zsMPvGEfeq8oHZ0UpI5xFSQ?=
 =?us-ascii?Q?=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR21MB3867.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(7053199007)(38070700021)(921020);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?lbRYjLTfZkdllm2OtK6KrxBUGqazYgCMYaw+WdRSQeJ7Vpikyj4Jgb5Ff6Nw?=
 =?us-ascii?Q?ro87CGw0NdKeaCzzep106v5l60hNpAfSTC7Q/A0iNX4dKGWJ/2SrQS5vc3nM?=
 =?us-ascii?Q?iCvR0BFWp7cPgSTcwUK6qa1hdYqqyVY1wTUk11u6atQHBqWt89eeBiQDO9Zu?=
 =?us-ascii?Q?4W/viBwFwnXWR+Bo68vWcjQFohB8E118F/oYg5eP+ERlQnPZpZToE77bsG7C?=
 =?us-ascii?Q?NHYgDhm9WyQTefhndvIq7+r0wwjZudORtnkjXw15Z8WqnM7fPZiSH6l2m6GW?=
 =?us-ascii?Q?3YX1swNq2vg6OPmQERTEaq3HyY+WavX+MJPqH10yA4+50b4Q/G/FxntF7ija?=
 =?us-ascii?Q?8tChX5UVN/qavGDyqJveuzqESeIave+hVlnrScrvUQRPwj8UM2u1UqGABIhc?=
 =?us-ascii?Q?MabGs2B2Ny7WkBk0DQNncP8quYLCZKSR2V23cN7asBTCm0zF1F/zohSwglLf?=
 =?us-ascii?Q?OGxA3qeQsNYCOGoilOTaHmw+ifpRm6lNbyT3+5Ioz9Oy4TTKhtmIqIVWrGRO?=
 =?us-ascii?Q?mKUBMh+MyzIb6YyMUhiga76IexgDnKMBMkGKjUBFaZvRg0o/xNJRQhK0LSVN?=
 =?us-ascii?Q?OpbxAJdsRVnOU+XjYcehtEd3ZIPu0yIQG2onzFjLVYyRselRwfLhvytikUD/?=
 =?us-ascii?Q?gUF1mfK66K1bGHEnAy6rAqXCetW/dt8vkhVrQtrc0YwpciECLIJQdvqQhrV/?=
 =?us-ascii?Q?ZgzIxzNr3SstVKB8ycTrxXEK6OWLwdDhwISvyYhQr33SSH5EnStS1YkpU76Z?=
 =?us-ascii?Q?GyV0aIYgrW29PLap+nVPVrArRBznGrNJtV7U1hTzLw5P7uzJIU+I2GPo+lS/?=
 =?us-ascii?Q?g84BocH40UooaD1zSU6HUUCZOp6tnky0mDoOiOpJhQcdLldXyPIjJ4CWYzxA?=
 =?us-ascii?Q?Ok4cs+31B+RCt6QCSoohOSpXZD1t2tzqjzUGblOT3tv9h4UR3IXRn1IRcQQm?=
 =?us-ascii?Q?zMQfhsILErzK1tmKpozrHxTv5+CZx7P+ot3ohr/fvw7ZEArZEIfxf3o7nvf/?=
 =?us-ascii?Q?HSTscHD3v5tE0l0g5L1VbJsTfZQBPBSk5V5DiG2jcYyde+cBNOpOH+3T78jY?=
 =?us-ascii?Q?bKdZtmyGfN3YfZrKUuRz+7DHZlYQiSaCq5AgerRW2CF9Fne6ZMP8rGJC2puP?=
 =?us-ascii?Q?2ruYjlMrFbXtRm0/5gnZi0WvdzU8XtZaVvduwmS9RArQN8v6/6A/TOI2iU2A?=
 =?us-ascii?Q?mzFJOGYDbpNvP0x8mMmf0sajhH73DNeNOhS8JmyLSsvyXDn/b8uT1evK/rdm?=
 =?us-ascii?Q?5s/48HNYPKBsJHaUbTR71EwIX8PiUTk1iaweGZOfsnmNhrcj0oxdOK6FeU+6?=
 =?us-ascii?Q?c+7cDGxRyuzkQiE9qgiDb0fx1JsHt0pSawA+ov4PB5SmhhB7ixYrB4s0tfzx?=
 =?us-ascii?Q?YCnTNHYKV194XyMBMhkFi5bgVb3XvsYxQe5sibytOK4LPBfarfraPvo+FpwQ?=
 =?us-ascii?Q?ETUPpLYkbUTNqtLvIAR1IVl7520YF3e7NBKdPtt6net3c0rZP7Y9NCPBn9bg?=
 =?us-ascii?Q?Iwgli+f+P9jFQqf7THa20OUIPp7rTqfErMkXjkg4BMyfiGawd1dN3GbnSJQ3?=
 =?us-ascii?Q?5P5pfBGVTARzvGT6efjVIYnFPSxeXoZvL/a1UA48?=
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
X-MS-Exchange-CrossTenant-AuthSource: SA3PR21MB3867.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ddcb7055-5f51-4da4-030d-08de255a313b
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Nov 2025 21:50:43.6113
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: E84y4bkmZ6R5ksEkJ5EtLEBqgw/McGPiso2uquAPUBgy4hIgp56GYmTkkHWD6fCF1dYpOxr4XnxJuqpuc2eDyQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV5PR21MB5066



> -----Original Message-----
> From: Erni Sri Satya Vennela <ernis@linux.microsoft.com>
> Sent: Friday, November 14, 2025 6:43 AM
> To: KY Srinivasan <kys@microsoft.com>; Haiyang Zhang
> <haiyangz@microsoft.com>; wei.liu@kernel.org; Dexuan Cui
> <DECUI@microsoft.com>; andrew+netdev@lunn.ch; davem@davemloft.net;
> edumazet@google.com; kuba@kernel.org; pabeni@redhat.com; Long Li
> <longli@microsoft.com>; Konstantin Taranov <kotaranov@microsoft.com>;
> horms@kernel.org; shradhagupta@linux.microsoft.com;
> ssengar@linux.microsoft.com; ernis@linux.microsoft.com;
> dipayanroy@linux.microsoft.com; Shiraz Saleem
> <shirazsaleem@microsoft.com>; sbhatta@marvell.com; linux-
> hyperv@vger.kernel.org; netdev@vger.kernel.org; linux-
> kernel@vger.kernel.org; linux-rdma@vger.kernel.org
> Subject: [PATCH net-next v3 2/2] net: mana: Add standard counter
> rx_missed_errors
>=20
> Report standard counter stats->rx_missed_errors
> using hc_rx_discards_no_wqe from the hardware.
>=20
> Add a global workqueue to periodically run
> mana_query_gf_stats every 2 seconds to get the latest
> info in eth_stats and define a driver capability flag
> to notify hardware of the periodic queries.
>=20
> To avoid repeated failures and log flooding, the workqueue
> is not rescheduled if mana_query_gf_stats fails on HWC timeout
> error and the stats are reset to 0. Other errors are transient
> which will not need a VF reset for recovery.
>=20
> Signed-off-by: Erni Sri Satya Vennela <ernis@linux.microsoft.com>

Reviewed-by: Haiyang Zhang <haiyangz@microsoft.com>

