Return-Path: <linux-hyperv+bounces-7136-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 23B96BC3185
	for <lists+linux-hyperv@lfdr.de>; Wed, 08 Oct 2025 02:56:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C915F4E13DF
	for <lists+linux-hyperv@lfdr.de>; Wed,  8 Oct 2025 00:56:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 506F62877D8;
	Wed,  8 Oct 2025 00:56:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="PCitwl8p"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11020084.outbound.protection.outlook.com [52.101.85.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7886C42AA6;
	Wed,  8 Oct 2025 00:56:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.84
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759884963; cv=fail; b=rU7IKgVkQHDuOyroYViJD1zdw+D1gYtSjDxxrFeKBBehbSh8oflyv7YTBI3AvGu077okW42ICBDlvJrx1PXPlAhERV+6iY3jIMEG/VlSQ+TM7caN3WfOd3zYkdAYW5VKw6s6y4s7ndvfF8eGIIPmf1LaGJQ38yFfoLmHULGdVhY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759884963; c=relaxed/simple;
	bh=NNhfTFeB5FFT7IbPMetUXL61rVIbhqftyXzbdU5ckEg=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=twzZXTsoT4mGbrhw8RA6+0Jyb4UYL2D1rtb823yV+FYh8UwaMMkZrcGMwAgm0wzxSq9OA6bbueDjuasTyTFzFrK2zV8bGXqUFoaXlDs7/e3AkiCvSB08HX4iBuhpPvrLwon8TsQelZALBdZ8veREwBUIXMbKwPzrVEUDvP6biyc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com; spf=pass smtp.mailfrom=microsoft.com; dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b=PCitwl8p; arc=fail smtp.client-ip=52.101.85.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microsoft.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=URZ3KKaUPf1vzHPzlbOH9qY56nwMSM27fzMhpy8lxtWdYl7siUhECymTGmi1Fvtdxbqegex3GqOq10x0vlzj4C+TImIk9rAh119pkxEvUDkg0G3afw3HAH2TU9j9naJzQv0wYPQ14QiOPJUMMgC1w/YhEDDwfiMPi6hck3rrgFWkN6Kku+dK34xutTvbGypDSnv0WOdSrgS7qJpogY+Gj2rN98isecVhVWXmbQnsWFF1nFLYjntvpGZt/kbBMcj+9R0xKQ2zzRJb+0y6VT+kr4TJBnymyf7cYCHdzItV0rPtCfrJAhNB/22mxYH2tdTDHfag61uwsWhZ3l62Cni1LQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xAANZ8uxxlLQR2u6H3wJzoPSb2nj/jcBEXVFSM09EEo=;
 b=xRAIs/ASGdxkaic+UxuU8ftnRGk7lF+vexQ6ssECwkO2tMlj3cFHy/EtDcjsT4ZAMqYoBfrM355tA+mW5vcgL9WLn0ckVl5TAtAWP3EBz6gbvSIUZD0TLL12KpDm8N91DqY5F5xc9F5wuldHqVANOcTqni2AyXFQhJRe7b5fHLySg/X4kdjT+0YvSnjd2pmoql2WJCgqWZbAR2L5YszQWB3BMCnmK1kWWmuTc6t+4eetysP2rEa7c2oB4sQ5sYhICQ6m8YrupTzZrR4ZqFSQcGmzj0JwmmkfTBit+zXKeeXmY7fclPQadrSshbVzZLF71HwcpRBCui+RkZwoejCajg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xAANZ8uxxlLQR2u6H3wJzoPSb2nj/jcBEXVFSM09EEo=;
 b=PCitwl8pVlegYUdaoWbBDz5EveuhJyx8IUE4LL1IiNh9mTIDDoUgEQbrwMtNPGOExW914F8Lla0nTzaLJieovd1P65qiupNBY+EzntckLINTxNVHEK4PS2AR4ZI88A5+T9Pv6O9s4pXhEBxRjuMf+0vY+P7YhqIugKA4IB/v+0I=
Received: from DS3PR21MB5735.namprd21.prod.outlook.com (2603:10b6:8:2e0::20)
 by DS4PR21MB5058.namprd21.prod.outlook.com (2603:10b6:8:29a::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.3; Wed, 8 Oct
 2025 00:55:57 +0000
Received: from DS3PR21MB5735.namprd21.prod.outlook.com
 ([fe80::ac75:c167:d3dd:5983]) by DS3PR21MB5735.namprd21.prod.outlook.com
 ([fe80::ac75:c167:d3dd:5983%7]) with mapi id 15.20.9203.007; Wed, 8 Oct 2025
 00:55:57 +0000
From: Long Li <longli@microsoft.com>
To: Michael Kelley <mhklinux@outlook.com>, "longli@linux.microsoft.com"
	<longli@linux.microsoft.com>, KY Srinivasan <kys@microsoft.com>, Haiyang
 Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, Dexuan Cui
	<decui@microsoft.com>, "James E.J. Bottomley"
	<James.Bottomley@HansenPartnership.com>, "Martin K. Petersen"
	<martin.petersen@oracle.com>, James Bottomley <JBottomley@Odin.com>,
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] scsi: storvsc: Prefer returning channel with the same CPU
 as on the I/O issuing CPU
Thread-Topic: [PATCH] scsi: storvsc: Prefer returning channel with the same
 CPU as on the I/O issuing CPU
Thread-Index: AQHcM1o09s0JbTr1WEyxyj44s5hnfrS22w6AgACK7gA=
Date: Wed, 8 Oct 2025 00:55:57 +0000
Message-ID:
 <DS3PR21MB573566DF7A81D555552DE8A7CEE1A@DS3PR21MB5735.namprd21.prod.outlook.com>
References: <1759381530-7414-1-git-send-email-longli@linux.microsoft.com>
 <SN6PR02MB4157B7FC3362C4C6838BAD3DD4E0A@SN6PR02MB4157.namprd02.prod.outlook.com>
In-Reply-To:
 <SN6PR02MB4157B7FC3362C4C6838BAD3DD4E0A@SN6PR02MB4157.namprd02.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=1cf71a9b-5da0-4d36-8afb-a428d2ab4a7e;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2025-10-07T23:58:57Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Tag=10,
 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS3PR21MB5735:EE_|DS4PR21MB5058:EE_
x-ms-office365-filtering-correlation-id: aef76337-03b2-4d9a-dab5-08de06057134
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|376014|1800799024|921020|38070700021;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?dzcJhk7fHlZfUe9UVUXwLLjUXt5gij5/o6iT3qakvoyhJ1w/MiEDI4RBwQtU?=
 =?us-ascii?Q?PRofmAWdR6+siN4Byij3YlVzXDF0r0UBL+4Nnx7c11BYl650FLmqFuMtmdF9?=
 =?us-ascii?Q?/RJbZLrOwOMqFZW4d1Y37HAXYFgX2V+a89UzQO6XKgvhzXYECuz3mWIUYCvx?=
 =?us-ascii?Q?4O3bMDnhqGZmQ4SXR/ppvVNnjdXQXOvwtgyIFkgligMc2CaMZZsEC0bkLMZt?=
 =?us-ascii?Q?xSWNO00gYKyQYo7GtCsaRAAxbbf0lLHfH9i3rwftPV/OnfuDtILsSdmJrPKh?=
 =?us-ascii?Q?VlzXJeNc4IQ2JRmhX22KehMRZ0/1+/TuUsB/51ReZvZyY74phZ0vzVHSB0zW?=
 =?us-ascii?Q?+IEdf9TKs8jM9+Vryu/+tC/gldntqXG5DyL6E/wDfPWOPXRldhycAlfMvfDX?=
 =?us-ascii?Q?nWH6fYt3OlOZBdXMWKsk86BLi8L+oYoZbBzFcKgL0bcaKCmKliXtOVGuQpLK?=
 =?us-ascii?Q?qs7RcnEtV3CnnJhoEtjsS6FpTulNy3C+gm95vheF5K5raU4LJPGSwZLJzS8d?=
 =?us-ascii?Q?AN+lmsZRbl8AoaR0qlq697uCiDFtW2gZwGuH2XVLDdxbmEqS3mv/zCCBbjqV?=
 =?us-ascii?Q?PeMZiBAFtfyrQp6iF3JixIpel4jYECw/soba9gRiTThjK/cjE0DT0yyPjmWC?=
 =?us-ascii?Q?qv++jfTuIl6rtCo2gxRC93KT+eED7oaMZQgDIMWVVwS+rmtkUTzOxB8A/TJA?=
 =?us-ascii?Q?aWQ7BUiZ79k9klJapZZuP9FYLLTVc6A7r2h8fQFWhWX7WbPazUzxaVZz7IsO?=
 =?us-ascii?Q?ke3R/avF4+0GdkVvhqp8ThudkAQtUdENVi+fgb6hnHxyTY7/ErnQALTBzkX/?=
 =?us-ascii?Q?V/Zgn7IkAB1qzLaO97WWh4xmf0kvLyJbcHATsXpNZczw+tx1Oo0aoVE8O01a?=
 =?us-ascii?Q?tbRNe+j4mOMqtRoLL/44LjZG9VTCbgJ5l5PpFk+s+O9fzc2S6JLSHuCQTUqU?=
 =?us-ascii?Q?jM6E3U5qS82plcapPAVIuOE1wLy1STT55ULXT6rIpJlJqTngu7hFXNnfxh3l?=
 =?us-ascii?Q?BAhs5+RjpZt33vwLFzGi3v5lN+WyO6yzs+PORoxsrTtgxASqhUa+5tmlhBYc?=
 =?us-ascii?Q?zq4jJpB8VVfkM5kYaf47Gxso8YwU9KtMoEESHrXrXRaBimD74CGw+Mvcjvlv?=
 =?us-ascii?Q?TwiV5wE6zPIA4DskSAmM9eIftUH6dGkn38/+X+UTbHZawAIZ4I962qDhrxkV?=
 =?us-ascii?Q?NI2Nt7NYudahlRgjFtypCENXPfgIFQT+TMeluR/NAVAbjc8o55URgZ6x1rV/?=
 =?us-ascii?Q?fWpSyFpSfl6FufNNdriIvd5tEtOHtW+qvlwje6Hd2kkVpcld8mD0Mw5Vapyt?=
 =?us-ascii?Q?oqoyS2a4czzFS5rN/P07eJuiR6nNFYLZRfJpBK3Oh3pBi2w0196LEq2U+l76?=
 =?us-ascii?Q?UbBQkaGg5gs20e0NpefVEn+kEpweAL/uLQ5lifvTKI8d9YrkzTLfzMl0btdD?=
 =?us-ascii?Q?Zyc9V2VywqYsAehXQonJqD5/TnAPrsF9YWC8WnIuAOP+usR72SaN8g+r7O14?=
 =?us-ascii?Q?i8vjkUfJ28cVhj1VrOH5pehJ0Zgv45wSNJXnbkHFtAKQ0WMHdGqLRNUc7w?=
 =?us-ascii?Q?=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS3PR21MB5735.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(921020)(38070700021);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?iHyshZvJfVYIKt7N2GNUdd3SvJWZ9idUJdEWNVZelecO5pc+KF/plTb5CuGL?=
 =?us-ascii?Q?LzccPXiyXQNk5d5NJemQvB8LfftjlpdwUXwDnV56V9UEF74K9sCMcsDaeM2V?=
 =?us-ascii?Q?34js3rcDEml8DrnYMLTeYCiBv2R7tDWXBnMEk0+G+8/KOQxEQpDh/OyKV/Up?=
 =?us-ascii?Q?/gZtq8GThxffIDVxSkqOSyEt8lF7PvrwaKULsPwJ86WfAF6IxIE/CeqX24Sr?=
 =?us-ascii?Q?TNZy9ptEEAck/nrl0i1suVooli7BkThEy2jA4Ch2XpjpNIIdaqO4Tw1ZlYKK?=
 =?us-ascii?Q?gWZ4n2lnMVL2A5m66ziW7x5EIXgO8gjcunuUirjWHUf9a8Og7MyfmUH3PKqt?=
 =?us-ascii?Q?LF3mPsOBI5lyEbBVuPcrHXA24C3RWzJ7yzgAm+kfpe2YH1AO4wbEgFs3NB6O?=
 =?us-ascii?Q?2BQHFDBwC9QqQZ10qAGdYAdvsNoxBboje8Iy9QT4RK7+ZP1STl3kGv/leRVm?=
 =?us-ascii?Q?tfK6i9UZ47mIyE/hluzTj2vdd7+MpPrNmwgQcVoiVynVq2tit9F+bmDalEdZ?=
 =?us-ascii?Q?VEeCyCMG+9Se/QYzlrKtuu2Sq4r3e33CPuQNjD7Ad6tdXeqA3s9Ju2FRqVlb?=
 =?us-ascii?Q?BzqJTKi60TKwgBHCM4yQcF6IijppHhwQ/RJ7l/sJms/F7GnGcp2HX8hKYdsq?=
 =?us-ascii?Q?ESwuGpNNTX0p6p27vEqbFl/5FLq5HVtO5A2Ntq65fF4EhWL+tv64MDk4SGC/?=
 =?us-ascii?Q?QDYr9Q4CaEaDDe8ccRuJvg5cbTW1f7BbrCJ3mvdyC6QFrGJ3k+AIpSIQRxcJ?=
 =?us-ascii?Q?kxKKS8x2AlC1HrbOSssR0058CnFyD+C1eM5fbFENFszFmSgs9n63ZxisH408?=
 =?us-ascii?Q?MDsLBAYk1GDi1LExK6NRJDzPAKRaYcHJ7BMrjlsLytQhL+zlt9b+RoAPHAtq?=
 =?us-ascii?Q?gF5cdo4oX1uH2BnwAFDCI02otP5yyIUmbnS8RsE3wf4yL3jY2S/O9ULg+/FX?=
 =?us-ascii?Q?Uy80mZwQzZzX2XEREGTkbroefvy7/vw23kmDFbe78jgo4s5NqYfGQ3IykR7J?=
 =?us-ascii?Q?NRBmzT5KIObajHtOTxNiybJWFrMRW8JJkGSH9s1xMutNTjvFHmjp34OOH/xS?=
 =?us-ascii?Q?DzGsKvt8vKVeUbAT3DPquVUeFv0vjbPodSuQ7x/vxrYJVbaP9ikqhJukXgA0?=
 =?us-ascii?Q?7hiOA7E7O0vjnYy5CUBHM8rS8PKFehfRk0DsDolbYMlsCowusRhpmrq5e8ok?=
 =?us-ascii?Q?fAOJgjRL8xeL+jc6jSKNI1epRQnbbgMqEpG9N6yH6AIqq+OOIVj03jWveCJR?=
 =?us-ascii?Q?iNqtMhFM2SbvSeQXsJgawYGQ7xcidEdX2LhI5/NFGmMfb1WqKE3iCE1QTNHp?=
 =?us-ascii?Q?8GafVpIJX/5HhOYpxd4xMs6CpK4rB4U7N0txJBLGBh2o3pUoPkVl27lGaxEm?=
 =?us-ascii?Q?rREEUxGJse1ISyQs4h50wVdu2Oo5EwXFmpMcRf+CuLCR9J1HgRMPTBBjSr2y?=
 =?us-ascii?Q?3lgk2cwNOLnTkJuVwSVjKZKp7T2q1DE/fGvOB5C3QYzu6B7KnHOkgUNNGk6B?=
 =?us-ascii?Q?TxjA1nHIWUZckyins5hB0ZaCvc7G5nB61R4me1h9ALtFdv+HqSlRw52Dqr8S?=
 =?us-ascii?Q?MUKGy432rkDLEY3jp90=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: aef76337-03b2-4d9a-dab5-08de06057134
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Oct 2025 00:55:57.6588
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KrPmFD6igCV6gPqGlTqa6AdYI0WZYfqG5GB0XqxRUhod2BRCSGdtSTj4+bTIRfMe2j6TG/keMOrk3qZmU+aD8A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PR21MB5058



> -----Original Message-----
> From: Michael Kelley <mhklinux@outlook.com>
> Sent: Tuesday, October 7, 2025 8:42 AM
> To: longli@linux.microsoft.com; KY Srinivasan <kys@microsoft.com>; Haiyan=
g
> Zhang <haiyangz@microsoft.com>; Wei Liu <wei.liu@kernel.org>; Dexuan Cui
> <decui@microsoft.com>; James E.J. Bottomley
> <James.Bottomley@HansenPartnership.com>; Martin K. Petersen
> <martin.petersen@oracle.com>; James Bottomley <JBottomley@Odin.com>;
> linux-hyperv@vger.kernel.org; linux-scsi@vger.kernel.org; linux-
> kernel@vger.kernel.org
> Cc: Long Li <longli@microsoft.com>
> Subject: [EXTERNAL] RE: [PATCH] scsi: storvsc: Prefer returning channel w=
ith the
> same CPU as on the I/O issuing CPU
>=20
> From: longli@linux.microsoft.com <longli@linux.microsoft.com> Sent:
> Wednesday, October 1, 2025 10:06 PM
> >
> > When selecting an outgoing channel for I/O, storvsc tries to select a
> > channel with a returning CPU that is not the same as issuing CPU. This
> > worked well in the past, however it doesn't work well when the Hyper-V
> > exposes a large number of channels (up to the number of all CPUs). Use
> > a different CPU for returning channel is not efficient on Hyper-V.
> >
> > Change this behavior by preferring to the channel with the same CPU as
> > the current I/O issuing CPU whenever possible.
> >
> > Tests have shown improvements in newer Hyper-V/Azure environment, and
> > no regression with older Hyper-V/Azure environments.
> >
> > Tested-by: Raheel Abdul Faizy <rabdulfaizy@microsoft.com>
> > Signed-off-by: Long Li <longli@microsoft.com>
> > ---
> >  drivers/scsi/storvsc_drv.c | 96
> > ++++++++++++++++++--------------------
> >  1 file changed, 45 insertions(+), 51 deletions(-)
> >
> > diff --git a/drivers/scsi/storvsc_drv.c b/drivers/scsi/storvsc_drv.c
> > index d9e59204a9c3..092939791ea0 100644
> > --- a/drivers/scsi/storvsc_drv.c
> > +++ b/drivers/scsi/storvsc_drv.c
> > @@ -1406,14 +1406,19 @@ static struct vmbus_channel *get_og_chn(struct
> storvsc_device *stor_device,
> >  	}
> >
> >  	/*
> > -	 * Our channel array is sparsley populated and we
> > +	 * Our channel array could be sparsley populated and we
> >  	 * initiated I/O on a processor/hw-q that does not
> >  	 * currently have a designated channel. Fix this.
> >  	 * The strategy is simple:
> > -	 * I. Ensure NUMA locality
> > -	 * II. Distribute evenly (best effort)
> > +	 * I. Prefer the channel associated with the current CPU
> > +	 * II. Ensure NUMA locality
> > +	 * III. Distribute evenly (best effort)
> >  	 */
> >
> > +	/* Prefer the channel on the I/O issuing processor/hw-q */
> > +	if (cpumask_test_cpu(q_num, &stor_device->alloced_cpus))
> > +		return stor_device->stor_chns[q_num];
> > +
>=20
> Hmmm. When get_og_chn() is called, we know that stor_device-
> >stor_chns[q_num] is NULL since storvsc_do_io() has already handled the n=
on-
> NULL case. And the checks are all done with stor_device->lock held, so th=
e
> stor_chns array can't change.
> Hence the above code will return NULL, which will cause a NULL reference =
when
> storvsc_do_io() sends out the VMBus packet.
>=20
> My recollection is that get_og_chan() is called when there is no channel =
that
> interrupts the current CPU (that's what it means for stor_device-
> >stor_chns[<current CPU>] to be NULL). So the algorithm must pick a chann=
el
> that interrupts some other CPU, preferably a CPU in the current NUMA node=
.
> Adding code to prefer the channel associated with the current CPU doesn't=
 make
> sense in get_og_chn(), as get_og_chn() is only called when it is already =
known
> that there is no such channel.

The initial values for stor_chns[] and alloced_cpus are set in storvsc_chan=
nel_init() (for primary channel) and handle_sc_creation() (for subchannels)=
.

As a result, the check for cpumask_test_cpu(q_num, &stor_device->alloced_cp=
us) will guarantee we are getting a channel. If the check fails, the code f=
ollows the old behavior to find a channel.

This check is needed because storvsc supports change_target_cpu_callback() =
callback via vmbus.

Thanks,

Long

>=20
> Or is there a case that I'm missing? Regardless, the above code seems
> problematic because it would return NULL.
>=20
> Michael

