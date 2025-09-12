Return-Path: <linux-hyperv+bounces-6846-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 62ED5B557CA
	for <lists+linux-hyperv@lfdr.de>; Fri, 12 Sep 2025 22:45:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E0A035A2B40
	for <lists+linux-hyperv@lfdr.de>; Fri, 12 Sep 2025 20:45:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67FC12D3EDD;
	Fri, 12 Sep 2025 20:45:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="KDISJU4c"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11020128.outbound.protection.outlook.com [52.101.201.128])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B81EA2D23B9;
	Fri, 12 Sep 2025 20:45:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.128
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757709915; cv=fail; b=DJ78JKT/6XEZR2aqqalP/aN6EGindL0V7VeVt3TKBUjuVEMg86DMehG13KemkPG93Cf2+WPKb6HS/zI54IOgrVeM9A6XolPnPtDZYRSBU628dumG9o/cwi26mov6N+cTgC7qLSwcFq/q1g7NLOcr8frXuwoVTEZJG07X0Q+sbRk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757709915; c=relaxed/simple;
	bh=XNzEeNIU/CVxKP7o3m8MNAuZbl4ZyQBgMF2V6szq/SU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=YF22RidClq+8kTjnVBoT97rWddTrrq33XG1jDm+O6n0iAZa4OCI62dPAgtDdAZYNUT3JGdqvGZn2b47H9Ra4teByOsh8ctq/1O7Rs3Z8JR2f0nYaBzkQ5KfvcndcjvBqhCynYtC6s7V5iMxtM6xn+gagkVxCHlNTUri2JWC3Qbg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com; spf=pass smtp.mailfrom=microsoft.com; dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b=KDISJU4c; arc=fail smtp.client-ip=52.101.201.128
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microsoft.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Xj1wwLdJBSn2usLpn99FPiKEHMppt/GYRtdhOTNf0se66/QreI8tKd4rO7xy80vrcll90To+S36Bjvc3Cr9t7stjtpBEFnXYvFh6g8PGebf/e+9zn7XmNhCBrWWGtV8n/dCKZ0s5izVkTp23UdIkZ7rKHUyW7mHjXMrfwVjxoZZXrnhtjhR4D8J/kOrJFlrXtssIVLg0Hd+4THhXgUPGUL4exs0hp6T3CYjmrN6ZCmdN4DluN9aXn8SKjxVGZdwFhw7olUPhc9w6g9vhsFH37YIpHrHM2dltB1dyhFI4y0whQ2KmgN/LsDYRTwG7MNSrprV78mj7ravocNe1rOH4aA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XNzEeNIU/CVxKP7o3m8MNAuZbl4ZyQBgMF2V6szq/SU=;
 b=Q6jEPEV4EcuvU7fjzYfe5A5l54E2R73azlOM6QrHKMpjseax1sOgXx+XpwyhV7ZGnfwdOmixXN9+UCVMe6D9foGq8hp8V9UxrMpx8wbrAunqUsUKArchcdGOaXwGSnX9qHxaJrQDLVwBECj06MBQDgq2fPn1baETwXEzVFMhNuy3gHptDmYKDRCMCLTmVdcupdBPSCbceE9qCELq91VsrFr8pbZdUVRt5ga1VIM+Zq1B9TjoNsh6MQt5bpLcp2LeJRt/MSpfSapuXnjirNTBXAQjmgj6/26xH9ZDOtYWVc5HtCwfwUxGH2kYiVINCd/fvOQ0ZZGuiviHy7IshhIVjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XNzEeNIU/CVxKP7o3m8MNAuZbl4ZyQBgMF2V6szq/SU=;
 b=KDISJU4cKpQvHfMi3IX8/rzlZHSHK6/BJrJeBtbm0Dxt1aAVBZebXUymtzaSzG6uDTLhvLe70xGPEmgtpGsx7OI1PZXlHIoHQKYF0T/NbR1yl+bd59VkuXo0+Q1et6SaCI8jZ8OcHEsswx6uJl3cD1SXloTStuvcWLQAHObozwQ=
Received: from DS3PR21MB5878.namprd21.prod.outlook.com (2603:10b6:8:2df::6) by
 DS4PR21MB5322.namprd21.prod.outlook.com (2603:10b6:8:2aa::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9137.4; Fri, 12 Sep 2025 20:45:11 +0000
Received: from DS3PR21MB5878.namprd21.prod.outlook.com
 ([fe80::72b7:dfed:2b1d:c845]) by DS3PR21MB5878.namprd21.prod.outlook.com
 ([fe80::72b7:dfed:2b1d:c845%4]) with mapi id 15.20.9115.002; Fri, 12 Sep 2025
 20:45:11 +0000
From: Dexuan Cui <decui@microsoft.com>
To: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>, "x86@kernel.org"
	<x86@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
	<conor+dt@kernel.org>, Rob Herring <robh@kernel.org>, KY Srinivasan
	<kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu
	<wei.liu@kernel.org>, Michael Kelley <mhklinux@outlook.com>, "Rafael J.
 Wysocki" <rafael@kernel.org>
CC: "ssengar@linux.microsoft.com" <ssengar@linux.microsoft.com>, Chris Oo
	<cho@microsoft.com>, "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Ricardo Neri
	<ricardo.neri@intel.com>, Yunhong Jiang <yunhong.jiang@linux.intel.com>,
	Thomas Gleixner <tglx@linutronix.de>
Subject: RE: [EXTERNAL] [PATCH v5 06/10] x86/realmode: Make the location of
 the trampoline configurable
Thread-Topic: [EXTERNAL] [PATCH v5 06/10] x86/realmode: Make the location of
 the trampoline configurable
Thread-Index: AQHb592zxvC9WLDsukioQqvkLElOQrSQfFkQ
Date: Fri, 12 Sep 2025 20:45:11 +0000
Message-ID:
 <DS3PR21MB5878ED61E035A30E36E62CFABF08A@DS3PR21MB5878.namprd21.prod.outlook.com>
References: <20250627-rneri-wakeup-mailbox-v5-0-df547b1d196e@linux.intel.com>
 <20250627-rneri-wakeup-mailbox-v5-6-df547b1d196e@linux.intel.com>
In-Reply-To: <20250627-rneri-wakeup-mailbox-v5-6-df547b1d196e@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=dac2d252-de39-4f73-b27f-9fbc3004bc63;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2025-09-12T20:44:31Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Tag=10,
 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS3PR21MB5878:EE_|DS4PR21MB5322:EE_
x-ms-office365-filtering-correlation-id: e09fb460-34ea-4d4a-ce65-08ddf23d446f
x-ld-processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|376014|10070799003|7416014|366016|38070700021|921020;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?SHIxfR6maqetxj/0C/SJN9HynAKKpEgMYX49G1bQPitRUIo0JPXYyehCwtuz?=
 =?us-ascii?Q?Qe3p3iXZ2f060BOPmfZwPj5QTSGgkEU3s3Qf/aAyquAMlSbLZEDTcGc6nvzY?=
 =?us-ascii?Q?Gu9t0usAMY55Vr5xK5VqXNSAjanLhfKxJwhaGzBkoqr1zLpfDWDa45eu6egp?=
 =?us-ascii?Q?wrU1kJdKkolHfbVlYnCOQjVLBYnsF8mlFE1xTanArLJ2ui6IqL7Heux5o1RH?=
 =?us-ascii?Q?13EBjKvom/Bjok08x0vvEW1YGLCe3Um8pkQ1cpbVvm9tntieTK88YsyJoOew?=
 =?us-ascii?Q?H8fni/VbWaXtfzwJa2Z70gu4W7eT9weXLFc/E5UGXvlWm7OCqDXXSH2YpwTA?=
 =?us-ascii?Q?9itFhhZYNCawKKQb5+yowP7bpzgiA+56MrJLvDhlVy7ZsT6nzLkcMOemlPJI?=
 =?us-ascii?Q?vtUgMFalyx5WY+D2o7uy+vGYyHgidZvPDKIoX845mTUQJ0Vzaa2SVjmQ8b3W?=
 =?us-ascii?Q?Nu4zz/DuZRG/iFjVOxxip2c4GfEqaslU9BMbSucT90nx0c4ZsTCVbzfK0jCm?=
 =?us-ascii?Q?KlyqOkUxJ3/yj24j4NRvZnHTkJ6XdJryctsbwzhOHi74/PG4+VK09NEbBOBT?=
 =?us-ascii?Q?0/6NmM16INnJm3QZoTIdf4tISbqu2Z6G/g42H21qq7VBzOYtRwYJB2fgpA5S?=
 =?us-ascii?Q?Grv5cZeo1VVa4EHQqg++uoDcfqQIE/VUfb0vVuBrXgn3Ns6fanRAxyPaJIbs?=
 =?us-ascii?Q?AzGToH1nuK9Y8Q9oq9mktRqHrTTxoTL9xM83JNaPHc44vop6t49IoAm85Nv4?=
 =?us-ascii?Q?4fvfeyDeY2mCdMMSAY2/i55FHjA0Jnwhbj8SC07/DHzjV1jTrLP2aVe0llaK?=
 =?us-ascii?Q?3iDiVBkFf1hW18aYsy0NqUQxDiesfSPlcAyv7uiI499N578bpM+1KKLrr6/F?=
 =?us-ascii?Q?vovPyt1WR4eQ/cki8JEq+3PyHL14I0JlWVb78uIBoYoRNn8OV+2GUkSntZuE?=
 =?us-ascii?Q?w2aWvMjoriPQRRjODebwS0yLOdr0FgK2p4ay2FFAg9eZoggEBNRr+VwyuVQ0?=
 =?us-ascii?Q?2u+awLuzKqAu/x4/XSwspZK6iNseogjGOBr3pyD79wlT4kIWKFCwPIHtnYvJ?=
 =?us-ascii?Q?fXBK7r7opUr5awO83K6uSztUbddjF8EUog95oiMJF0ksU26543VKsYhb8gcl?=
 =?us-ascii?Q?vljwDdP0DRIDI2Z5Ww9TZRCKud6Cs8psBQOefLZ7QRDRqxafF+ctQyP64o7T?=
 =?us-ascii?Q?FZTacslBitYyOUtacjogDgW4fei2Pvoqu5TIEcTNca7TFqUgFqTP2p2yEVuc?=
 =?us-ascii?Q?7CBdD3ifkfrccfVgBO6udhR30kYY4Pmh2lqqO0JMXsh1R3CZ8k4bK0klhS70?=
 =?us-ascii?Q?rn9YhoQdGZ1PZkP3NLh5o2flOCjox5yMQoVou0XwPcB4KsOvTKM1DCi/gL0f?=
 =?us-ascii?Q?ys9CT3FUvv7qZma3rc6f+FC2ysZPEVNfKWZUMytojKZNk8YEq0cEZaC7Qzum?=
 =?us-ascii?Q?JaczeD7MUblPWdFgUO63Ztx83qpCz10Ibrb3dzfwx00tV9mgdqBD5d+Wdhkv?=
 =?us-ascii?Q?/bngiKvxjInm8tI=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS3PR21MB5878.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(10070799003)(7416014)(366016)(38070700021)(921020);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?Ua1GFYRGAM4PWhAm2uK7SrvZummwzLW6sskAUheEchJ4B+A765F7GCOaT2gu?=
 =?us-ascii?Q?3x9tadcNS2UxbfORnEDqwQoJjPJmGDKAbhYykOUsTpeJcYut/6sGRdlY2YC7?=
 =?us-ascii?Q?P7Tpg9gc5kiTcy6PmY2dDA3yeSrGwvdZwQtnS+7psLtyYoTTUe8GAbqT2ioP?=
 =?us-ascii?Q?eZtYztaWrdmD1Qw+DT08cYSHTzZyRZ8Gprn975zHTERZXHeIbEFAk7L3tUNu?=
 =?us-ascii?Q?wUPxwghqAq4lvDSrvkyC79RMo9Jpz6SAWyZX6BcTTWWC0Eov7eM9MJO4MMcq?=
 =?us-ascii?Q?1I6xBKQBlHwSJUExCuGQ1rJEEM71TYmGmdo2UeNmQCPAVOctsUgtm/KnyAjk?=
 =?us-ascii?Q?QD5NAz6tKTpqm0tIdPGe4WeXQ4KbZoxIiP6feYJ7bXjASby4eYQvxbvwDlEy?=
 =?us-ascii?Q?gjEyU0Smc6jXZEJ9CIOrX/ErkbnawIaDcmZMK4a0dsYUG4kz4u5uRckDHgAX?=
 =?us-ascii?Q?Y07yKGd5mg3Dd8CxIaDyI6kKxdA1seMWkIfOSI1bhUfnTRG5rkIzA572VM7K?=
 =?us-ascii?Q?QtZa4OTxF5Ed3HdRRC6phJYt7HQYyXc2n0pBUEPQ1gYkO/4gWjEaVM49j83I?=
 =?us-ascii?Q?gTa5rB10k7/zIcNLLGgA/IQQnDsqi5PLlMtUq+JDGM4IteTmz9ko4gDXBCDI?=
 =?us-ascii?Q?NBcwcr5EanJSIBxUYvnQ56ATogCxbK1jyow0WuunCZTTChu8JXoErMJbYqwR?=
 =?us-ascii?Q?xB+s+K4U7LAmNpnV//exm3EFF2f4ZIssl4QzWsIq4zzVS5vuE4zTmcdNVPyt?=
 =?us-ascii?Q?RxNwHjg8S98i0ZEICbp2YA01o6dWPV6fZUs5jcn10S9O/o/xLDmSz4BbQmK5?=
 =?us-ascii?Q?eoL8cZUpG7N3j1zuaTpRosbQHBPyoxzr8eJKO4NCBpLwnHYPlwEfnwCBe6TQ?=
 =?us-ascii?Q?lK1xkLNeKOHNZQ54TpWAJvboLseplARlZxv1XBUZ7gZQWyrQuJJaBTSSznNb?=
 =?us-ascii?Q?G918ZvFPVjTIYm3DDtZcbXxsZ0V9jkuQJsDqlab4poqGmpd9VKZC0WLxxtaj?=
 =?us-ascii?Q?H81o3byIftIrheQtEVXsYSeWD6X0dZINWYtfIb2uZAQW1keoOjIyOXb+xS2K?=
 =?us-ascii?Q?wm3EtIxOUuSlZEkHrycIllJlCxJq2751Cgo5XlakizOdGqk2VEx30GNjNsNY?=
 =?us-ascii?Q?cRxVnue8mIVNdO42W+gofsCip0jPWyOi/ovbuKaO2INJlvnFB11Us3vsnYPn?=
 =?us-ascii?Q?08jVOUQ6d4r3Dylre5OQBB+nMiDdKb32mjxG+2Peg47uuRNQy9G6u/lLPV12?=
 =?us-ascii?Q?P5Z+vz5qcMudrnPXSs1JVcdLJhV8voDoht0WXUcRkRk1UjAULOE6YyKOCni8?=
 =?us-ascii?Q?lPLdwWEtoZUtSeByE7I5zKFJnrTovgovmYT7f+70YVuiAVN5/+6L4mHnAnrT?=
 =?us-ascii?Q?AxLt+wyUoZoFvjagnOnNndnq0ECwcy14ifj2xaCKL5FavxOlquKUmFPoDShU?=
 =?us-ascii?Q?0RLVCq6T3LVVICo72wS8f3gyLHLXLecpotVpkq4fiKcrRKGaYFqgBr+gIchm?=
 =?us-ascii?Q?Ag1RiDVZ4vji1izXPAMHQ1kLRBR1JcgjtMnfoWcnYlqo2ByhTTuee2ohV1aF?=
 =?us-ascii?Q?U2OUEVzO1E+m0CutW+0YO5c8ihmPu+iCPuWnhuqp7npqCNSVW7uJgHjtA7K+?=
 =?us-ascii?Q?i6LwFG6S+EWL2CvfrRVsJ9LjmX+W7gG0rpzWkZgWo7fU?=
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
X-MS-Exchange-CrossTenant-AuthSource: DS3PR21MB5878.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e09fb460-34ea-4d4a-ce65-08ddf23d446f
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Sep 2025 20:45:11.1408
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kRhssGKSJSf8kODJY3iA8+UFkKm+R0yjMbmN29cKidos4WcTvm9EVeoxZft9IlyQQmiKrQizu4O3uiDil1WITQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PR21MB5322

> From: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
> Sent: Friday, June 27, 2025 8:35 PM
> [...]
> From: Yunhong Jiang <yunhong.jiang@linux.intel.com>
>=20
> x86 CPUs boot in real mode. This mode uses 20-bit memory addresses (16-bi=
t
> registers plus 4-bit segment selectors). This implies that the trampoline
> must reside under the 1MB memory boundary.
>=20
> There are platforms in which the firmware boots the secondary CPUs,
> switches them to long mode and transfers control to the kernel. An exampl=
e
> of such mechanism is the ACPI Multiprocessor Wakeup Structure.
>=20
> In this scenario there is no restriction to locate the trampoline under 1=
MB
> memory. Moreover, certain platforms (for example, Hyper-V VTL guests) may
> not have memory available for allocation under 1MB.
>=20
> Add a new member to struct x86_init_resources to specify the upper bound
> for the location of the trampoline memory. Keep the default upper bound o=
f
> 1MB to conserve the current behavior.
>=20
> Reviewed-by: Michael Kelley <mhklinux@outlook.com>
> Originally-by: Thomas Gleixner <tglx@linutronix.de>
> Signed-off-by: Yunhong Jiang <yunhong.jiang@linux.intel.com>
> Signed-off-by: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
> ---

LGTM

Reviewed-by: Dexuan Cui <decui@microsoft.com>

