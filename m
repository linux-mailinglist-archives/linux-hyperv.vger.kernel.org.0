Return-Path: <linux-hyperv+bounces-10126-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EGdGODWo3GkEUgkAu9opvQ
	(envelope-from <linux-hyperv+bounces-10126-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Mon, 13 Apr 2026 10:24:21 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4060E3E9116
	for <lists+linux-hyperv@lfdr.de>; Mon, 13 Apr 2026 10:24:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1EB2830037C4
	for <lists+linux-hyperv@lfdr.de>; Mon, 13 Apr 2026 08:22:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5176D3A6EF7;
	Mon, 13 Apr 2026 08:22:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="Ic8JAjCP"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from OS8PR02CU002.outbound.protection.outlook.com (mail-japanwestazon11022141.outbound.protection.outlook.com [40.107.75.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFEEE3A5442;
	Mon, 13 Apr 2026 08:22:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.75.141
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776068570; cv=fail; b=NDEvHN/ei71AZx1uNAQ3Kn/fCfOk6ImPi02Ymk786mzSbrhs0eJQTTN/VvB7l11PX+L8SP6udeRpaO1mVgpH7tghU/3dS5S0sLpJOzL5Mwj/4PiaiVsY3/iVUkejEnARo9yWVjFdLBjtLaTGv5wmI8u72kHigDTw1CW8g9jRlpw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776068570; c=relaxed/simple;
	bh=Bn+07jouffh68jbKsSPXmXBTbBEakPHdaUHWRVUELf8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=N7gLdRiV70gjwkj4spQuuXgl5hAVMmYrbrQ2YQwlAHGsJ7PQyhCAmaX27yLzej2C3iI2Nvp+i0Rso3y9ncTcCJltd9gAFAuYqvb5E9OoprGqIC/zWHogubkw2SmXMlJjRpR1/LrM+MWh4kQQA35Gt4+vvnZhzXxYz+3Yt5uS6pI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com; spf=pass smtp.mailfrom=microsoft.com; dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b=Ic8JAjCP; arc=fail smtp.client-ip=40.107.75.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microsoft.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=m2IQj7CT4+2Gsr+Wdck155BJQoAMTloVkcwbhkK0yIWaeu7WpbQTIUkRUt4w3SCJjkoJb7XiTe+MyIh24HMewXE5BlZbbBeh1VAfohAMJcbrnvoSgmjXvHTggDrT3UokUTTnv3r5V/9H5ltUkAEZaxMBUJRCG89Q5IuINlfCJ0xd4f3TJxLQqo/X7CsnEIbwaErAXCGf+XvaVKK7FjyAlfJRBJw7BAEv8CVDhl1UX8LvlG0pAAiAA6SYjyz8kwsVaVntlOD9SUvHTUHHljKnF2thy0tg621t+MJt0yq6udgbPvuCpSJG3bLgcTdezTbG3G3UQ0KqCP/GfJiMaTfh2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oj3IM4W0nIOuffDuch4Mhpo9XPuJdr9Bhj2brT8H+dw=;
 b=nOZASgSv5pGQ5EUKMMDE4quMoCHTx1DeNVUOA8APheHPnftdN7bcsoiH5uY3/rxnmJ3dQh+ubmwM+iSCUuUeEQlC3Ys8a6wh9aWs9yjc+R6NbxQ/xnw7EKwTRWwrJZyIJyjc6ecgcuSxIUGZucCTvDC6qMM2kOhPSNmArhV4dsg6mQ+fFf3RWptXO15JzbAnvP0gWiTP/3kYaUAWBZ1kQYZ0oqp+zC8RUc75bL06yRjsoTvIIYoGbjMHVSb1+Lgm5tCPkJBOYqHmAd3N+4ml6u27sBx5gfnKnXlOLul+WkEX141nFNiTJMTwewkeItI/R5DnvC8HIya5p8MG+ZTvUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oj3IM4W0nIOuffDuch4Mhpo9XPuJdr9Bhj2brT8H+dw=;
 b=Ic8JAjCPc6W5FerLFyUaAA5Pqcx757Dp+4xVmAR/luoD+p6mBERHaDZcqEZ+cxhg4NyQp7srxThptXWTr1vnG5OodV8ESNbandSk68slRPfZ18XGYInhfH5HzcjAot1lLgrHsvtFRYKYQmFJEX5qaksS6XREz+J0zJRCB0Puo0g=
Received: from KUZP153MB1444.APCP153.PROD.OUTLOOK.COM (2603:1096:d10:36::22)
 by OSNP153MB1643.APCP153.PROD.OUTLOOK.COM (2603:1096:604:48b::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.20; Mon, 13 Apr
 2026 08:22:39 +0000
Received: from KUZP153MB1444.APCP153.PROD.OUTLOOK.COM
 ([fe80::c9fa:b931:702:dbac]) by KUZP153MB1444.APCP153.PROD.OUTLOOK.COM
 ([fe80::c9fa:b931:702:dbac%5]) with mapi id 15.20.9818.017; Mon, 13 Apr 2026
 08:22:39 +0000
From: Saurabh Singh Sengar <ssengar@microsoft.com>
To: Thomas Zimmermann <tzimmermann@suse.de>, "javierm@redhat.com"
	<javierm@redhat.com>, "arnd@arndb.de" <arnd@arndb.de>, "ardb@kernel.org"
	<ardb@kernel.org>, "ilias.apalodimas@linaro.org"
	<ilias.apalodimas@linaro.org>, "chenhuacai@kernel.org"
	<chenhuacai@kernel.org>, "kernel@xen0n.name" <kernel@xen0n.name>,
	"maarten.lankhorst@linux.intel.com" <maarten.lankhorst@linux.intel.com>,
	"mripard@kernel.org" <mripard@kernel.org>, "airlied@gmail.com"
	<airlied@gmail.com>, "simona@ffwll.ch" <simona@ffwll.ch>, KY Srinivasan
	<kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>,
	"wei.liu@kernel.org" <wei.liu@kernel.org>, Dexuan Cui <DECUI@microsoft.com>,
	Long Li <longli@microsoft.com>, "deller@gmx.de" <deller@gmx.de>
CC: "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "loongarch@lists.linux.dev"
	<loongarch@lists.linux.dev>, "linux-efi@vger.kernel.org"
	<linux-efi@vger.kernel.org>, "linux-riscv@lists.infradead.org"
	<linux-riscv@lists.infradead.org>, "dri-devel@lists.freedesktop.org"
	<dri-devel@lists.freedesktop.org>, "linux-hyperv@vger.kernel.org"
	<linux-hyperv@vger.kernel.org>, "linux-fbdev@vger.kernel.org"
	<linux-fbdev@vger.kernel.org>, Michael Kelley <mhklinux@outlook.com>, Saurabh
 Sengar <ssengar@linux.microsoft.com>, "stable@vger.kernel.org"
	<stable@vger.kernel.org>, Wei Liu <wei.liu@kernel.org>
Subject: RE: [EXTERNAL] Re: [PATCH 1/8] hv: Select CONFIG_SYSFB only for
 CONFIG_HYPERV_VMBUS
Thread-Topic: [EXTERNAL] Re: [PATCH 1/8] hv: Select CONFIG_SYSFB only for
 CONFIG_HYPERV_VMBUS
Thread-Index: AQHcwo6UUBvHYaEr8EK6Q8BbiI9wobXcpfeAgAAR2iA=
Date: Mon, 13 Apr 2026 08:22:39 +0000
Message-ID:
 <KUZP153MB1444885C302B353C02C2FA2FBE242@KUZP153MB1444.APCP153.PROD.OUTLOOK.COM>
References: <20260402092305.208728-1-tzimmermann@suse.de>
 <20260402092305.208728-2-tzimmermann@suse.de>
 <KUZP153MB14449BBE44CBAEEA7621A4A0BE51A@KUZP153MB1444.APCP153.PROD.OUTLOOK.COM>
 <2fe8ce91-2dc5-4cf2-b7cf-d495e5cff14b@suse.de>
In-Reply-To: <2fe8ce91-2dc5-4cf2-b7cf-d495e5cff14b@suse.de>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=68f474dc-35e8-4341-9b89-6427baf0a9e0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2026-04-13T08:21:02Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Tag=10,
 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: KUZP153MB1444:EE_|OSNP153MB1643:EE_
x-ms-office365-filtering-correlation-id: b0e52200-d9d8-4bef-a66f-08de9935d373
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|376014|7416014|921020|38070700021|56012099003|18002099003|22082099003;
x-microsoft-antispam-message-info:
 I3U20ShaxuoG82qDbE9AmG2Fz51hvpKldpGKZWDPoC11L7xxI428h2BC/d/ColrU++0jWQiBJPKW9xHcueYyYCgmmi0obTXp8iyVYI/WSEKb+BfX7RXf8ddQD8f41bac+MK/XsfXbAUNuNqqYpOutLRz9KHHme+qK/qsiKfm5QO9sFPAZjHZtGNioszPxfWEc6TaBvJpYCFA9tu7Ja9s/MFcEWHV97qv3hNQAYD7T4AYot6pYHscASSgIp+jdU9VRlBEWTlnFYtWGouGZ8krLDYe0bUTcV08mqyUn/9paVfXm/POpM1S+gqNqccTaDB2BiCP7tZPAUSnbc/8mX5ajlG+Plgd6j9yJNaUtHXs+ubJtMmkpSainpTBTvb4u2PPbzmBtgieT2OyBQEHXHHR3W8lV3eVq3G76DF10bLZA9SbTG8OK/9C8ioHguZrsC7amM6TcYEHBSo6slkLAxcZ/yzAoyXLu74xWmJLdApAYHw7JnKdXZSEVaOt6vZ71y4zeyAKPtPMe8PINxOO8Mb5EsoCGOALCFu3026Q+Yl27KIn0GfCpME8Dl0wnjyLQwNm6WmgxJNLBlKWT0E93TxzOdQvOPisSVVfpxdhKkGYvZ0uwu2hQaE76620HhV11KK5FKI5431wyvJBWpr+I1apYrc5VI9QJYVk7ezHRNNujbr3sI4Tya0R9/OzzaTn0MrQaDuaxIlTzL1ZH4YcrMtZ/6k9xerzv9P7gMEJ+/aTzRUdIl410zOmly+6A3x1aXM0KVTm7k6qoYf+UTIRMZBnuntNnnMjmr0sFvv2D424rpFoUOah6rllJfnijKe2Uj5e
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:KUZP153MB1444.APCP153.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(921020)(38070700021)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?DP/3v7cfq2p/Twep2bhGAfX0psnOHmwg8K0Hnp586FDvZuSuP/MwT78PppU0?=
 =?us-ascii?Q?Vy4h+xLi1L++h/2nGv1qAnmQpDzQSDsDm31PcMEAuYrU46BQYIDItCLuFwwt?=
 =?us-ascii?Q?xOq0xhWsMBnJju6dp5tXWYg2TDYDjhJNCAgdrJcHIW4826vxz+9rRhb/26KN?=
 =?us-ascii?Q?c4u5PKvuFLmpJEVSPOjxjUQdDI7BSqMiYIALW1FWRW1opg6uJ8p7ZqemRSlC?=
 =?us-ascii?Q?aYIpc44fvlHAcb6auh/DSyXsjYMSa2nvB8bKeTPhYX9yRNdeReg2uMc+6fLG?=
 =?us-ascii?Q?T4sU+XiuhsHQgrTapRHfHcgKp+zfxu700hyzhDH5LVzEcaBverpH9tzmNeWM?=
 =?us-ascii?Q?ImH5XRh626oG495JZT2008djZCzNfC2lcrM1xC4LZqhEiQjikR0MGwVU7ODL?=
 =?us-ascii?Q?c50R4KQpOVat6zApNkjOVA4bP5u9ujpAgrndRHUwFf77BaDvMfkMITA6w4EX?=
 =?us-ascii?Q?DWhLFgKvIVr2kcPoTH8arhMFr1mvqw2nVWZFCAgNp7pBefdTfJyWAKDrHFkm?=
 =?us-ascii?Q?XQoDTRMSm7dYmsT0Y/jLcQL9AdYXfV/S2YAD9dZYWSWrKdPLc3Ckl62SpBVf?=
 =?us-ascii?Q?S06mMKwYc+nbMITmjZDYxidYqVklhzNeyZImschtWkKRyVH/nycjsOVkTNqk?=
 =?us-ascii?Q?x/JEnvcMJ+CJ0GTfc0ee+KYHIJZXAw9FZJNBVFBJvPatN5A0vxK6uzffWO1D?=
 =?us-ascii?Q?yOY/tcS5NnlfComt+X61IH/XZ7sKiHN8pLU4plpk10+TT/gHASg4Ukn20F2u?=
 =?us-ascii?Q?Y+Kz3QLQKOfdFid798hKnnELg3M/riSohUEJBA3ksxBf5JwuskODz//5ysJS?=
 =?us-ascii?Q?2VWs8aSDGA5kChFsYGjrOA1lv5DOIU5HIJFO2cpUT9WK+E7vSH06LpcSiD7r?=
 =?us-ascii?Q?gE9K77triBPOPoqX5WXzj5HSFBP3lL9ZERHWkkWfNbqE5MDI3ZhsI+t9Ngf4?=
 =?us-ascii?Q?2DXeiQDctDg03XdbGHF+fAW6Pn619si+UTNXnZIX6INI/mWQdj1YY9KBXSoO?=
 =?us-ascii?Q?JzaabPF2BvHLxWpRNEEvKxwW6prOmMGYc9XZBhd5OD4zCZD+iiGQIKWuQVT+?=
 =?us-ascii?Q?tcDfXC1uTpaIMdF+bK2p+TISGSp40ln8r1YY+2szjsj755c5IS/OX2xLMIVV?=
 =?us-ascii?Q?LkI49RAHEVnzUCYLuItCWFFtVjSJm27snegQzUbZIdVZYOec5+wWGn23ydRd?=
 =?us-ascii?Q?UQw8wSVFD4TCDJ1rypZYQhrNBOD0aRfxPzqdhwl8lzEEr68Y2nFFY3ji/G8u?=
 =?us-ascii?Q?kddfboNoG4frIA/JcxH59ngPl0GhjcQHYsr3uvbu0s//dShLlPSQXKp9JFvr?=
 =?us-ascii?Q?dBd1iIHhdp3JBK1ddwOIn2fAuDZTHwe1n5ttocXB5QJkvRdBx4n1dkJHPZxN?=
 =?us-ascii?Q?os+9tt66JojejU8k0hQ97eGmguchXSG4LMIYEfh5dmQVs5GpjzYOp6mKQSPz?=
 =?us-ascii?Q?0lKTrd8oecs7GTayg+PdEH0RrTUoiHva2co9tuaUWA0asuEtuzg/goTjuQLl?=
 =?us-ascii?Q?7zGUbRbJ84d6AqiHNYW5oCYoPJVobvaOCCG9QxpIIyWBgJOsmM8hR3/hjC0j?=
 =?us-ascii?Q?B5VnZgUNh2s0y2DfHJrt8BovCiZHyLmbOtQbDnurED+TRphRy5RHPnaqoRRx?=
 =?us-ascii?Q?HN75gScwGwa5UHbw3du0OGZPsAn0LSKCgiK07vtEdiLgAklp2Y75bdMuMUv5?=
 =?us-ascii?Q?jW+Akw=3D=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: b0e52200-d9d8-4bef-a66f-08de9935d373
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Apr 2026 08:22:39.2445
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VPiXmaOgRbFAAm2fUll+rjiMXM/SiMs67XoBxn68DK73fbfmApE2gnCIKLho+LmN8PJoeyXtHXRWdY4clBtGdA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSNP153MB1643
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[microsoft.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[microsoft.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-10126-lists,linux-hyperv=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[28];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FREEMAIL_TO(0.00)[suse.de,redhat.com,arndb.de,kernel.org,linaro.org,xen0n.name,linux.intel.com,gmail.com,ffwll.ch,microsoft.com,gmx.de];
	FREEMAIL_CC(0.00)[lists.infradead.org,lists.linux.dev,vger.kernel.org,lists.freedesktop.org,outlook.com,linux.microsoft.com,kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ssengar@microsoft.com,linux-hyperv@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[microsoft.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-hyperv];
	NEURAL_HAM(-0.00)[-0.999];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,outlook.com:email,KUZP153MB1444.APCP153.PROD.OUTLOOK.COM:mid,suse.de:email]
X-Rspamd-Queue-Id: 4060E3E9116
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

> Hi
>=20
> Am 02.04.26 um 12:50 schrieb Saurabh Singh Sengar:
> >> Hyperv's sysfb access only exists in the VMBUS support. Therefore
> >> only select CONFIG_SYSFB for CONFIG_HYPERV_VMBUS. Avoids sysfb code
> >> on systems that don't need it.
> >>
> >> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> >> Fixes: 96959283a58d ("Drivers: hv: Always select CONFIG_SYSFB for
> >> Hyper-V
> >> guests")
> >> Cc: Michael Kelley <mhklinux@outlook.com>
> >> Cc: Saurabh Sengar <ssengar@linux.microsoft.com>
> >> Cc: Wei Liu <wei.liu@kernel.org>
> >> Cc: "K. Y. Srinivasan" <kys@microsoft.com>
> >> Cc: Haiyang Zhang <haiyangz@microsoft.com>
> >> Cc: Dexuan Cui <decui@microsoft.com>
> >> Cc: Long Li <longli@microsoft.com>
> >> Cc: linux-hyperv@vger.kernel.org
> >> Cc: <stable@vger.kernel.org> # v6.16+
> >> ---
> >>   drivers/hv/Kconfig | 2 +-
> >>   1 file changed, 1 insertion(+), 1 deletion(-)
> >>
> >> diff --git a/drivers/hv/Kconfig b/drivers/hv/Kconfig index
> >> 7937ac0cbd0f..2d0b3fcb0ff8 100644
> >> --- a/drivers/hv/Kconfig
> >> +++ b/drivers/hv/Kconfig
> >> @@ -9,7 +9,6 @@ config HYPERV
> >>   	select PARAVIRT
> >>   	select X86_HV_CALLBACK_VECTOR if X86
> >>   	select OF_EARLY_FLATTREE if OF
> >> -	select SYSFB if EFI && !HYPERV_VTL_MODE
> >>   	select IRQ_MSI_LIB if X86
> >>   	help
> >>   	  Select this option to run Linux as a Hyper-V client operating @@
> >> -62,6
> >> +61,7 @@ config HYPERV_VMBUS
> >>   	tristate "Microsoft Hyper-V VMBus driver"
> >>   	depends on HYPERV
> >>   	default HYPERV
> >> +	select SYSFB if EFI && !HYPERV_VTL_MODE
> >>   	help
> >>   	  Select this option to enable Hyper-V Vmbus driver.
> >>
> >> --
> >> 2.53.0
> > Reviewed-by: Saurabh Sengar <ssengar@linux.microsoft.com>
>=20
> This fix is independent from the rest of the series. Do you want to merge=
 it or
> can I take it into DRM trees?

Please feel free to take it via DRM tree.
CC : Wei Liu

- Saurabh


