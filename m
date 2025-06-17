Return-Path: <linux-hyperv+bounces-5936-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 81A9DADD187
	for <lists+linux-hyperv@lfdr.de>; Tue, 17 Jun 2025 17:32:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AA5A8189704D
	for <lists+linux-hyperv@lfdr.de>; Tue, 17 Jun 2025 15:32:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C91112E9737;
	Tue, 17 Jun 2025 15:32:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="I2WGwzfF"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11023111.outbound.protection.outlook.com [40.93.201.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89D5A2ECD0A;
	Tue, 17 Jun 2025 15:32:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.111
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750174325; cv=fail; b=m3SuRAAoWA7fvQNYaBvzKGwH/pXYB9QiOey74BSdf3wwVAmi2phJV77Cp3KcQcqHld+WEZ+yfP4BqqM4CbXsSZC0abllpByutgKJsXnMVFerQUNAfIl11Gk7jYckm/gSFURM5ME0YmtmMxc9htgti8gwboVn6tdeDbwGHbwD2c0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750174325; c=relaxed/simple;
	bh=XYvS83oYAG3seyXg3uilXJ0GfimPNMbR52Zn3D/qdrQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=PZWBy9e2IWlwsH+jLhWILyXhESTg16rYGt7whkj0+qNHxP+KOO0MQCao7p2odXXgIQ+gdHVVFjObpZCJSI1VoKGBlm7lcrkDxbSh2sg0/ar8/lc4t0OTciqglxmh96/Kx1jLZA9QzbWFSrmSjPN6QSBJrymHA/X9QY/POVx1Bp4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com; spf=pass smtp.mailfrom=microsoft.com; dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b=I2WGwzfF; arc=fail smtp.client-ip=40.93.201.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microsoft.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Hpk1lfz1YzrhtxMYrbafIM0hPHUc4tRKvTPLfSUjs6W8Seai4bS+26pOfDH9MZHyWuQYbAvO2BS10HsfFvFjjsTnKKsxPYZMCHllXC7bbKlCPcRdq89a8N4t5sRAvZ5Agny+XItE6nrYhhzT3xQiD0RIuLdK2Tgb7i4hzUyXmiY3n+S8hJyefFXn0F8v9RIf+c+z0RMgexZDVqsk0Pp0lY28eBinq1l4NkybS49ENFxk8B5z3eVO8bZxqEyXH4Z6uz8s8ii92i5SSduDBepMLMzqos+zeddLXfiEMy9tXHn8/n24PsBkkb3ZD8EfywOenO1z2Y4g2J8TO2U+jUmO6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XYvS83oYAG3seyXg3uilXJ0GfimPNMbR52Zn3D/qdrQ=;
 b=EFtzZyU4SICqV3GZQy1Nzjk3ov7AVU041cAivPzD0chGPXxdkeyyThvGVUAdC+jDcXZ0RhNuEd/1HSdkHm/SeE4wyYcRVB+F43Zu3VHkbS3ki6n1yie4DlRHx8H81y/SpShVtQeDWwDzqSfaheh6s37rXGzQij5GE0HZHJCLBzKlzCl1JYmF7vbhw8HlD4tpQJbas66YI28SHhp/Wl7hQ9oerp8gGaFE86xxOKWT/XeiPBHb84CGbHvpKTMS6GX+YPBrLiZ5gWcm6OsV2pNi2UoxkDvz1yuWQ08lOxjamQlSQyl3M4mpOjHAv1fEBb7z33ESzZvlG6E7691B4i5UXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XYvS83oYAG3seyXg3uilXJ0GfimPNMbR52Zn3D/qdrQ=;
 b=I2WGwzfFzqQEh8MHH5SfV7KMrPK01iZbDyt0xPc4XVFOdH+jRCrWOjy0x7lAF7tUphadz7uZXwAH699cKyq+A6MfODLO6TL8ynaNmsm9SleHvL4SCrc2Am2Di7/J/bQx+Z6TXaCVewv3j0EOY+F98Gtr5HFbmE4I7Yj9YMupwZw=
Received: from SN6PR2101MB0943.namprd21.prod.outlook.com (2603:10b6:805:f::12)
 by SA6PR21MB4412.namprd21.prod.outlook.com (2603:10b6:806:422::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.6; Tue, 17 Jun
 2025 15:31:56 +0000
Received: from SN6PR2101MB0943.namprd21.prod.outlook.com
 ([fe80::c112:335:8240:6ecf]) by SN6PR2101MB0943.namprd21.prod.outlook.com
 ([fe80::c112:335:8240:6ecf%6]) with mapi id 15.20.8880.004; Tue, 17 Jun 2025
 15:31:50 +0000
From: Haiyang Zhang <haiyangz@microsoft.com>
To: Shradha Gupta <shradhagupta@linux.microsoft.com>, Dexuan Cui
	<decui@microsoft.com>, Wei Liu <wei.liu@kernel.org>, KY Srinivasan
	<kys@microsoft.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Konstantin Taranov
	<kotaranov@microsoft.com>, Souradeep Chakrabarti
	<schakrabarti@linux.microsoft.com>, Erni Sri Satya Vennela
	<ernis@linux.microsoft.com>, Long Li <longli@microsoft.com>, Dipayaan Roy
	<dipayanroy@linux.microsoft.com>, Shiraz Saleem <shirazsaleem@microsoft.com>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Paul Rosswurm
	<paulros@microsoft.com>, Shradha Gupta <shradhagupta@microsoft.com>
Subject: RE: [PATCH net-next] net: mana: Set tx_packets to post gso processing
 packet count
Thread-Topic: [PATCH net-next] net: mana: Set tx_packets to post gso
 processing packet count
Thread-Index: AQHb33uylD82leaymEmBsNhs3CnzjrQHenEw
Date: Tue, 17 Jun 2025 15:31:50 +0000
Message-ID:
 <SN6PR2101MB0943F7B2345EFD61E3EBDF41CA73A@SN6PR2101MB0943.namprd21.prod.outlook.com>
References:
 <1750160021-24589-1-git-send-email-shradhagupta@linux.microsoft.com>
In-Reply-To:
 <1750160021-24589-1-git-send-email-shradhagupta@linux.microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=1e5d2ae4-d312-4282-94c9-fae123fa986f;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2025-06-17T15:30:06Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Tag=10,
 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR2101MB0943:EE_|SA6PR21MB4412:EE_
x-ms-office365-filtering-correlation-id: 47ea12ec-9a2b-4353-79dd-08ddadb4148c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|376014|921020|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?aovlH1pHXbphknPUgxLl7DhdU5gxUqPQf190QhJL47AcZJCOT7TYdhjC5RgN?=
 =?us-ascii?Q?bHFfbZ8tlz972mJHlIcE4Lo5ifIkVL8EkmWlEZVSiwt1EXq0kUQGkf/Az1f/?=
 =?us-ascii?Q?69bwCsEPu6blOD1b4Wx9AY2GBxUlst1ixhuxkHeKQHxKBngrL+1+BbqpiVsM?=
 =?us-ascii?Q?hpAaxdtzEg31z8Si5/2cNxCPmr0jeWTtLV8c+12o043aoovP5ZPSDkmwKGEd?=
 =?us-ascii?Q?LYkTztmcApKuJTTAy9TzS18tirJUIhlYqC3GWVGocfWeLmv0AungkoUG6yMj?=
 =?us-ascii?Q?RbGrlVLKWdvKWH1G4hxZT9la7uO4eIxZ6vdR9IzfX3eZZiHrTcFJpVVImAXV?=
 =?us-ascii?Q?xZPZNAVLrKUM42MEMAYKJUFIlmEQP8gRWWPs+XbZgq0kRm9mrCA2Hqs0QAyx?=
 =?us-ascii?Q?/wsfVOpy9IzCw69wsy+cX698LqvJRvVH33huzgY416FvoCD2QbBD7Q1jE8uW?=
 =?us-ascii?Q?WpfblY1RzEVrbtSX3QppJwXnrmObd7aqeBG+cf7gSatZPL+vayLFrP2XmqNd?=
 =?us-ascii?Q?VqIE1s00oXqLKJvVG6VIeYvzu99DaHWDFS+Lp9vMQnnLw/wOdwo5qqmjr2NB?=
 =?us-ascii?Q?B3XSI3i1f/SbPr2NNY1PU9x7MCn6NL04oUJFbg2izEunA3+M9wPVVOoTMW52?=
 =?us-ascii?Q?cj1Xe0KyrRrz6DzxRur3h0zQjjrlVTqg415n1zZKVJqg5IPTO8IyXjbzaR6Q?=
 =?us-ascii?Q?xoxNjzQgiBiSH5Gy/HBqxesDB+E3pDB/c1Ko7NA+SiutkmkIbeYSrRxXRX1U?=
 =?us-ascii?Q?mWl1ToVR0WLelbjtHk0QBSsZWso5EPmhf2oHmTx3Nmn64/d8cC3Xot6k1P+B?=
 =?us-ascii?Q?7l4o3lyMOJf05mwxfxTKLNUYlE+l3k0cT281xAEdjlwd2iv8S7PLH5mH9FcG?=
 =?us-ascii?Q?SY2yh+SKaJwliOj3aOucqRtQBzmq96UrIo/UjkUvZgdTqHKskJPBsQTFrqoP?=
 =?us-ascii?Q?YmEXVYkBTVHI9Dq/DRzjZJvTxeHRlDOv9HbzYuiGbUvGTc4XkwUsl9EMWDJS?=
 =?us-ascii?Q?26vXYWFwm9u3m1OND+ZFHyDn0rsic39nqxhe+jaf/lH6iJM/MBK5J+hic5wo?=
 =?us-ascii?Q?jDEHWwFM3mwTsExTApAC6iJ9CdveTok6EvkceZJw1aDHgyvVFbgGEu4qBCmg?=
 =?us-ascii?Q?NDLTT3PHWK+RrLvnnqOZ0kCIeSA5xvjvYdh3ku8pa0gM3xxxEgIyK6ztLt4O?=
 =?us-ascii?Q?fLpUIanSF3zuFlryMMudHFuta1cQmZQUlcta28o6yuyVTo3tBpi0HddzGcAJ?=
 =?us-ascii?Q?cDmc7w1mYHkUVttiBH9zKW+jLrN5zlBNTwEbaLJA3AM6kflQEeEMUtvKVh0A?=
 =?us-ascii?Q?fHbM63eK/DuZoIakkC1tvKQgMtSj0QieUEFeXtRn/uVWGosbjR1zF5p4f5om?=
 =?us-ascii?Q?lPYrTk5TduoKS1ZLsvVBHqH7JRQgm+aDLFDC2a/GBOqJSW6mWwTsMAJ6Du1t?=
 =?us-ascii?Q?sBfkeTsQM8HZ5b28a5QCE+mzkuJUknfxAN7gSx6/penkl6WZ+FtYgLF1tP0F?=
 =?us-ascii?Q?CSdIFtkUFsRzn20=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR2101MB0943.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(921020)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?VcnRSET8nCrbNYFbc1BPfB4HwEJ2pPUZFesSUwfteh3VBOYFGmMtqY6EmGlW?=
 =?us-ascii?Q?jIaRi3oJDH5YYsQhZQmkAya0Y/+EEzORGyM3EM8EX5cjaR8XX9mU8h7Zj0dr?=
 =?us-ascii?Q?hD/CbG+K/nhq0mBPDZ/WHWFvY26ZcEuoqy6FLB6wzUbSbdyBbXqWNT8lI2bU?=
 =?us-ascii?Q?6x7gB1D2t7TUHNu6AkhfWJir3MkLoU020OgOULGut63aF4Lti9OwTmIrRrfv?=
 =?us-ascii?Q?L1Jv6VPezAVRuyMmtNT9Nb/vsG+2UOiyzF+7LvV8pNbnaacHxUmPyX8LkfZO?=
 =?us-ascii?Q?9cDV5Vgn9uC0il26e2av/NdkAlH2Ih7UFbFvhQOUSymqBXYV2d4QIwKwNzxO?=
 =?us-ascii?Q?HsgWeecW/u+pxln1Ul+exoua+5UiujBfgC5Vsi50FshnKNuEorr4ln38Y4sN?=
 =?us-ascii?Q?NKvbIAqvwcrqdg8w5HPpEABFNRan8Df2qjR+F+TQowE2sh/+TgDWuNH2gy3v?=
 =?us-ascii?Q?qrXIms9OAHUb9occukVy38jKwizqtTZgNOjZrz3wg9QEqL9jdZVc2wGq/nPl?=
 =?us-ascii?Q?yhwzwECvPdoKyZUGCcS59NMQPIKmiYWZERKmvKRRjsliHgh4ZbIHi6Q+Zuc7?=
 =?us-ascii?Q?plUzSCCEdA3+GHfQJ3bAku1IkTHstzFWOM1MaKLP2KlMIS/ypJo3HesWSRRf?=
 =?us-ascii?Q?o9k7wMJRiI1RjOheSfadbv2cHcy6ockAaNG1qWh9IxVk8pxu7DSl0BHTelqL?=
 =?us-ascii?Q?Q7Y8PnDJT1+MQHxzhPz8D247kl7zWgYv3NdncdodgN8LGyii3DfcA5Zu8Kns?=
 =?us-ascii?Q?KPR4SPHsI/oRhkCGTVrvKs5tJ10FGMP6jS9fix0iNC1hvMvTT5VGM8oEVbTO?=
 =?us-ascii?Q?JD+LPVI3+zkUwJCy+s7AwVqnX4NeZceYP1RDiG2WTM1AfkZnEadOLYARm6gW?=
 =?us-ascii?Q?uE5SqrJN0Rk5/womDki9HsY38c6ruhmTA4BNP6/ZeFeBmOQPRIqy85bSGauW?=
 =?us-ascii?Q?i+n+qiuRQAYfYP6JDAUcfCHiD5y+IoOMmbWJyZG4TqrhbHGTBnanwNL/YF7T?=
 =?us-ascii?Q?gar/5n2HSahsoLdC5PiTPCPXigjF9aiWwPvPoSpUpQJ4C5/p3TUCxqW2VYN+?=
 =?us-ascii?Q?ioKFWt44CFAYAVWcgsy5NKdTW5w2r1ojvQ/AZHixUKzfAkcy0mfZyR1Scpw4?=
 =?us-ascii?Q?/AA68WC7NiCE9a/QOY8Rers90I8RcNMBFKi6qfyiCLoQ+ayjlbkEMR8gMcRW?=
 =?us-ascii?Q?OWWAMWDDG1KFVHlpLOjiEczN/flTFDTIOLXUwFOgVyQZAGBcZvM2cGLcvAr2?=
 =?us-ascii?Q?kEKT4sAuEk+6CN+HeTVc49AlSd01f/lHU17wCsBZ9X/daoNhkpKCmvWExDOx?=
 =?us-ascii?Q?twcHbEiQn76p7VLhCXFitcaBFfvnsR8GKQ3cME6Rc7EgTy2BPaSl7EbyeAno?=
 =?us-ascii?Q?lUf/jO/h8CQBNMFt9UkscD8TjYyTL4mxGuaYBTKyXy6ppjROgej74lU542oc?=
 =?us-ascii?Q?ODxMYnT36PmoOVv4qZWfmD5SD/2hwfHDdlmoB82qzLzgGVxowgIhwROh6+Ya?=
 =?us-ascii?Q?cn3HEu4iupkw6Fo8hdhplGZEDKEuNjMdYkkuNqlsZHbnHFrtg4xiLO/E/RwE?=
 =?us-ascii?Q?Gx5D1kESIy/62u+c9+wP4pChoto4Ji1fHvmgRDMm?=
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
X-MS-Exchange-CrossTenant-AuthSource: SN6PR2101MB0943.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 47ea12ec-9a2b-4353-79dd-08ddadb4148c
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jun 2025 15:31:50.6857
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: koTI6+N1i+luIHW5LVXdS0fESPKA9uDhYHAoyCDN/bvg9htwGw1kBO1qO3ntQTcSBHG7Wt1saXB+MjwwXoO18w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA6PR21MB4412



> -----Original Message-----
> From: Shradha Gupta <shradhagupta@linux.microsoft.com>
> Sent: Tuesday, June 17, 2025 7:34 AM
> To: Dexuan Cui <decui@microsoft.com>; Wei Liu <wei.liu@kernel.org>;
> Haiyang Zhang <haiyangz@microsoft.com>; KY Srinivasan <kys@microsoft.com>=
;
> Andrew Lunn <andrew+netdev@lunn.ch>; David S. Miller
> <davem@davemloft.net>; Eric Dumazet <edumazet@google.com>; Jakub Kicinski
> <kuba@kernel.org>; Paolo Abeni <pabeni@redhat.com>; Konstantin Taranov
> <kotaranov@microsoft.com>; Souradeep Chakrabarti
> <schakrabarti@linux.microsoft.com>; Erni Sri Satya Vennela
> <ernis@linux.microsoft.com>; Long Li <longli@microsoft.com>; Dipayaan Roy
> <dipayanroy@linux.microsoft.com>; Shiraz Saleem
> <shirazsaleem@microsoft.com>
> Cc: Shradha Gupta <shradhagupta@linux.microsoft.com>;
> netdev@vger.kernel.org; linux-hyperv@vger.kernel.org; linux-
> kernel@vger.kernel.org; Paul Rosswurm <paulros@microsoft.com>; Shradha
> Gupta <shradhagupta@microsoft.com>
> Subject: [PATCH net-next] net: mana: Set tx_packets to post gso processin=
g
> packet count
>=20
> Allow tx_packets and tx_bytes counter in the driver to represent
> the packets transmitted post GSO processing.
>=20
> Currently they are populated as bigger pre-GSO packets and bytes
>=20
> Signed-off-by: Shradha Gupta <shradhagupta@linux.microsoft.com>

Reviewed-by: Haiyang Zhang <haiyangz@microsoft.com>


