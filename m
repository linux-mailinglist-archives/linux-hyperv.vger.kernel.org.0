Return-Path: <linux-hyperv+bounces-10287-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oKGTG8q652mu/wEAu9opvQ
	(envelope-from <linux-hyperv+bounces-10287-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Tue, 21 Apr 2026 19:58:34 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 71A0243E443
	for <lists+linux-hyperv@lfdr.de>; Tue, 21 Apr 2026 19:58:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id B50273021FEB
	for <lists+linux-hyperv@lfdr.de>; Tue, 21 Apr 2026 17:57:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29EEE3A5E60;
	Tue, 21 Apr 2026 17:57:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="HD55wWam"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11022078.outbound.protection.outlook.com [52.101.53.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCFEB2BE02A;
	Tue, 21 Apr 2026 17:57:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.78
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776794252; cv=fail; b=o89+qElU1SdgOd687YjyGDe4v4JkHvQx3woCOVc76ZQIHi6+bUrf96uxGvNjMQTtvuBuPtYEzUYodXvY442fVHXfcuCd74271mdJyjahDltoAv+2bzs9x2DtYeO8lyQmpB3s7kqlksYfuU2YyJqa9hGpxe1B6pVWLZKWesztExo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776794252; c=relaxed/simple;
	bh=y8E/oSVYnxop7MO9lC2QpP13zJVZKGrWyVOX9uRV57Q=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=S8ptlTe9dz55GTd9SDHViwGkCYtD+sb4OEg4GsjCQt54LSSVjDmabb8cRZ0fjLC60oFg+6PiN2Dvtrf5Y8Rp1VrQrJX5Hl1fmV4DiyQfGd+FhPMQU1ygGXwGJm8GAFQyLThBJ9qWCQzV4z8UaOe+urDoK8C6IAL5hiqP4muel3E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com; spf=pass smtp.mailfrom=microsoft.com; dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b=HD55wWam; arc=fail smtp.client-ip=52.101.53.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microsoft.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kyJ5EfYiL/xwfThB7fV/3jzMEgS43pAEBm5KPKefw12OtqiBEaPBfVN8IEf8Ol8R9ysU7987aFvHOmwqOjHTLa5losngndJqiRGYW3dQu0+Q7fzOBPsGrG7yHM0h97JvMM3/1QJKxzHf4U82uiLeCYJ6MBtLdtudPp7pwJXAxxogGsAtDb7zIJeXcDbPva70KLXdZEQ9ZFC/PYsQfdyBKliJB3WxUdp0U8Tx0Ux6kR1tBhQjx8pU7cSBd4ZnZQA55Q/UmFzzaSedUdhAPNakNyu6BkUerdwGv90e8lAZ/1s1O0NYHOdYGElDT0ex6BKsrQwYs891GDVEHcAAXxJ/uw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y8E/oSVYnxop7MO9lC2QpP13zJVZKGrWyVOX9uRV57Q=;
 b=Ls2yS0PvKr5UgodNYEfG0WXYUmXSV8IhBXSsMZUodSyWMD0/aniVdXQF3fEspo/MxR1P+V7anj1DgP2fe8qi7M4pQOZCaRlRTvlfEB6wUreXT6EZM8CP4QWN25Qc5tjmaZbJzv/hBclufgN2FXQVCng6tx9YuCTdMBURKqKX/jBxleuuYvJ/C6mI6FQWFlLUGD5rYPBQ1TbLaDO0QKH/bmJTiz+f5vzfNJhGjozbFPPmShyqqtAQNUTch5Tb1X4ryBJh/tOHE12X9OC5CulUlzJVDthFy4+/KQrIpsbA6coD96r7anwzSkpN21xHC1uJB+1X7hYvLch6PCsKFWnBLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y8E/oSVYnxop7MO9lC2QpP13zJVZKGrWyVOX9uRV57Q=;
 b=HD55wWamNDxuYVbw7P9vSZ0+lhj4QOt4RUKDCDxe/jSSm+BxdFSg9+ciW2r5XmKt+cIyxV7aG1ZyUyWTRoOSF1X+bP8Qx8SG8CNh/Zr0DkywTjjI2Zc9j604jTFHOqxj/w9ORjVqxtnJ2kW6J3UVQaQqZBeIbItiYn9Lj7lAs50=
Received: from SA1PR21MB6921.namprd21.prod.outlook.com (2603:10b6:806:4a7::11)
 by SA1PR21MB6032.namprd21.prod.outlook.com (2603:10b6:806:4b0::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.15; Tue, 21 Apr
 2026 17:57:26 +0000
Received: from SA1PR21MB6921.namprd21.prod.outlook.com
 ([fe80::51cf:497c:e5df:f6d]) by SA1PR21MB6921.namprd21.prod.outlook.com
 ([fe80::51cf:497c:e5df:f6d%2]) with mapi id 15.20.9846.007; Tue, 21 Apr 2026
 17:57:26 +0000
From: Dexuan Cui <DECUI@microsoft.com>
To: Dexuan Cui <DECUI@microsoft.com>, KY Srinivasan <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>, "wei.liu@kernel.org"
	<wei.liu@kernel.org>, Long Li <longli@microsoft.com>, "sgarzare@redhat.com"
	<sgarzare@redhat.com>, "davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>, "kuba@kernel.org"
	<kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"horms@kernel.org" <horms@kernel.org>, "niuxuewei.nxw@antgroup.com"
	<niuxuewei.nxw@antgroup.com>, "linux-hyperv@vger.kernel.org"
	<linux-hyperv@vger.kernel.org>, "virtualization@lists.linux.dev"
	<virtualization@lists.linux.dev>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
CC: "stable@vger.kernel.org" <stable@vger.kernel.org>, Ben Hillis
	<Ben.Hillis@microsoft.com>, Mitchell Levy <levymitchell0@gmail.com>
Subject: RE: [PATCH net v3] hv_sock: Report EOF instead of -EIO for FIN
Thread-Topic: [PATCH net v3] hv_sock: Report EOF instead of -EIO for FIN
Thread-Index: AQHc0Tr7Kl+uT57hJUOpAG8vda2N+7XpzYJw
Date: Tue, 21 Apr 2026 17:57:26 +0000
Message-ID:
 <SA1PR21MB69219BCC4AACF92D73EF42B5BF2C2@SA1PR21MB6921.namprd21.prod.outlook.com>
References: <20260421025950.1099495-1-decui@microsoft.com>
In-Reply-To: <20260421025950.1099495-1-decui@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=34a112f6-de95-42f3-9f24-3289475f1184;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2026-04-21T17:55:05Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Tag=10,
 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR21MB6921:EE_|SA1PR21MB6032:EE_
x-ms-office365-filtering-correlation-id: 67699f15-ae0b-408f-8ddf-08de9fcf72e5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|7416014|366016|1800799024|18002099003|56012099003|22082099003|921020|38070700021;
x-microsoft-antispam-message-info:
 J93IF5HK1KBmtaC82m6m2i5xm8cfPrRiCtIO+fRPdV2z/aZ1Oxl6dAksPfi8YY57d3nBfcr7/lYZTKWy1WjhcanD/4jMAywBxvwcv2PScxbVwOseaTmMnWevQ6rrnHq9odoIM+otwQex5hoNPmRUOmO9znW0OXiOpeO4O/117Ungp8pmNaOy4lV9H2aAgHf9p7i17gz5SIt6c/Lg26bTDugDjwE8ySTOR0iLGnPtfceCB65jfwsCFqNClAf96bPDfedfssg6cGWhv5tV4bQOv9rnUtjhhuNfi1ixtgQvg7IRnYPDqLUIkYsKQZvFmRmQcFUK6qZPCbQMflfz8/YxaPgEW+W9g7TzErP7RHnF+Lkytm8vuzYCsZuS4FQkd0wd9uwhmYdeM4zOY8B4q1Oh6DwKrQBduUypoiJ9nBjAw2FpKgELcWtgmMEyqqRXP+pV7m3N4Yh68tKnDmz5X3XVmXD5OtDMjQ27lMkMkzaB1xCsvq271ZoXMrzK50AAMLDqHNn9htcTd1uYBfPabkua2VD/00BE4Yyq8k5YNUT4WEhICwL8ets+FySENHFo3+i3MF+uFqE3JGAy39BT9DbF5vIUkTwVN6r2ngtJ5IcR4IHgUpGky/6ny/B5CIJ6cH2VT8ysozcaWRNSptsl/LB5lgMr9flwP4u2xHzqBG8XOqY0xNei22B6GEcGLvCZCUihIlmKmgNkaJZKNQPHyBltPV3DtnW6W+WFSZVJifLe9O9lxERJRwj4HI+zhl4QXV5axg2UUskNZEGbIBuS/rm+ug==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR21MB6921.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(18002099003)(56012099003)(22082099003)(921020)(38070700021);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?Q/F4kpl6G8cLbQnRUANwpGToQqbAPs00BhkZpBn4wHB39dayaqVq0ki8FuEs?=
 =?us-ascii?Q?vQ8x1S9fGzs0sICLxKuq7h2dvmw1hPN8z3M4QzYsUx7FWAYd46YMV2D1BYRd?=
 =?us-ascii?Q?gslBbKB6N70a6XLL+5GWMZdqOQZmQGRZt1ta8LvLnBi5zHsHP+4GU8GdnF8T?=
 =?us-ascii?Q?LGQX8g1XJPQbG1Max8kuxv6Fmyoj5+tYjhb5phXvdbYq+vYSRilUYE/j4BNt?=
 =?us-ascii?Q?wDkHFOJu9utVLGfRGfqCgntukc+kzUjwNj7HE1K+KW+T5L7yhBwd8GiIKUbn?=
 =?us-ascii?Q?auTnuMXVOZc5ORGlWJelwuS2ADrcaVg2JYNJ83x6+uuS57tFVStBp6JBgSyd?=
 =?us-ascii?Q?9bET0JdKCDA80qoj1ZicXjukGeMDwe2mUCTGgM5lc+liKDfDrs+nszhIujyl?=
 =?us-ascii?Q?VRlsJgqO8F3FHrXovMujBAdWZDLSUwRWRZZsCiAkrd+9fBysrSsTDobrYCw7?=
 =?us-ascii?Q?ZLpspgSRpqLz+a0eaLEmn+RqnpNz0qBqcZ3t6C/UsEB0F3pOaaJ8bZ0ROnu+?=
 =?us-ascii?Q?Jx2/8zohInEwgQ8tNqMKdQjQNFR6plATWKLDRkPtAKUmmnKdeA0nttYCBsT6?=
 =?us-ascii?Q?TD+Bv2JxbRqIbOxKRk6OOszL9nf7um7aNRMkIVMyK2i+/h42BHo6lHCCCreD?=
 =?us-ascii?Q?uIPInp1Yemk2dC6huUtgqaRijvaqHdcsMeRfy8aTKMMb4q8L++lPLYtJxBul?=
 =?us-ascii?Q?m+uJMO2HqC7PyRWKDKqloFbVq4v+9VMtC94ZiF8kCn7fut7Ei2GJuLGJKhqs?=
 =?us-ascii?Q?9xYpqYADoBe9MixAUPlqE7CCx5UtZJW7GkCzLJlvFpHf568hvw3Tf4xe+DvX?=
 =?us-ascii?Q?HnaYlQU9nDEGSR3VK3FLjq5DkKtEUkkdWiHqBx8N+K4hiws45roNvzTqMg2D?=
 =?us-ascii?Q?Hvw4h6rl0qbxRas+ifHLLUdSlbJb9qcZWYYhk/oSp3EX+vHch9xxHMrSHfhF?=
 =?us-ascii?Q?+kJB5SNAfUF3uhLrTEe0gacSCC9LKozQTqfrv8WYmHFUuS17DGLZuajPFCuE?=
 =?us-ascii?Q?NdBweB9wb2YMc3nI+csFohKYkYm3VmPmtHY30ehXFFA7Z5e6OtvNXiNM4v6w?=
 =?us-ascii?Q?8C56ZxlPHkETWLWLWzA8TwcPgg1QmxB4rRbi2ZGDFEtLNN+ttWeATi7ZviR2?=
 =?us-ascii?Q?szVJTXv7nrj6ABtWURmYJalGzofEPBjn2XQSC3ey2nGNB831i38vlYc+lwzj?=
 =?us-ascii?Q?CmeCe+Y9LN/ifATsXLrgHOoEDe7XIyevEx0OEszVbo28i5HP47bbmeNAVQsF?=
 =?us-ascii?Q?OZFm9CjciYav2BMdD+uVDoCZmKVoEZ/iMuq+PX9XhTWM/reENjl688BtxobX?=
 =?us-ascii?Q?f1Si/AJsGRTselkwNRzW39Lrt0dLzUPb2NtySsxdutqpN1emHRXwefM0bpgx?=
 =?us-ascii?Q?XcZBNlhuAvauuNjr/0mLEgqJi7Cz81r1dc9HtoPBs6n60BOXu09Nq+KCUwpW?=
 =?us-ascii?Q?UPASYeE0j6S33mw5lkYRiDUSPievmbH+87DpxoWLkRFWC7cwe7c1kA2flLXq?=
 =?us-ascii?Q?lPefSbz27pHvIdmMc9XgLzQNfaRZen3SBmuxJI/3Dxswkb/+RZIekO3ISWvz?=
 =?us-ascii?Q?GzLbPnmyErBmcreEvPywQfx4HvVHAnwFKSwgU+C9vznm83W4cPVmhQ8snIPU?=
 =?us-ascii?Q?SZzE5TJj9yg0LWCAPmNmdB8envLaA+Vd61G7eB5CxfZaSmZhIM+9E85iXymk?=
 =?us-ascii?Q?yl0hlVmqj9DM0bhuvcHF0STze6ZccNuSfxHOX869TIO7Htyd?=
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
X-MS-Exchange-CrossTenant-AuthSource: SA1PR21MB6921.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 67699f15-ae0b-408f-8ddf-08de9fcf72e5
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Apr 2026 17:57:26.7547
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: eR6XvQR8l4ZM2hNZUK0nj1GgX2amcRoMVuYQYlQimCa73i9zy5EzPm0AcEc8Oi3Tp8u6yP678kPXxeWfEcyK9Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR21MB6032
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[microsoft.com,reject];
	R_DKIM_ALLOW(-0.20)[microsoft.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,microsoft.com,gmail.com];
	TAGGED_FROM(0.00)[bounces-10287-lists,linux-hyperv=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[19];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[microsoft.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[DECUI@microsoft.com,linux-hyperv@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-hyperv];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[SA1PR21MB6921.namprd21.prod.outlook.com:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 71A0243E443
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

> From: Dexuan Cui
> Sent: Monday, April 20, 2026 8:00 PM

Please ignore the email, as I just posted an incremental patch here:
https://lore.kernel.org/linux-hyperv/20260421174931.1152238-1-decui@microso=
ft.com/T/#u

See the link for more context:
https://lore.kernel.org/linux-hyperv/177672238581.1802062.15838493180057695=
674.git-patchwork-notify@kernel.org/T/#t

