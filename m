Return-Path: <linux-hyperv+bounces-10196-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0ONoLkdA4WmaqgAAu9opvQ
	(envelope-from <linux-hyperv+bounces-10196-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Thu, 16 Apr 2026 22:02:15 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3944D4146A7
	for <lists+linux-hyperv@lfdr.de>; Thu, 16 Apr 2026 22:02:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D78C731282E8
	for <lists+linux-hyperv@lfdr.de>; Thu, 16 Apr 2026 19:59:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D83353EDAB2;
	Thu, 16 Apr 2026 19:59:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="KuFUJdMp"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11022123.outbound.protection.outlook.com [52.101.53.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BABA3EDABA;
	Thu, 16 Apr 2026 19:58:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.123
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776369545; cv=fail; b=cfaYnkWiV/dYk2DLao4/tWGRf+nx+ui3hLydOXBV9Ku0wyUbeFWkp2FZpgzYbcSoTHALHAPcdQg7dEeGX2axMvBuKzQ91yGmNwsISJInfIYNKD81/Vr3w+yRp/rfMOLpYcsHKG6P9fMjCf7uwGRCXcabyxUJXwfU4l2cksQX4vc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776369545; c=relaxed/simple;
	bh=reI7pqNodcvnWIAPyhlC14rIjwhle/CVnpLouyeWtsw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=rhOo7MCQZiocHH/YslyOVMocRZnPAIrb5B1XWD6RRS3Cr8TNNCONv195hqRRNSi7lCF05Mnw8Knq7PJ2nNe7Bhibhhu8hDMw2Y5N4JkJfsi+KuKqrWIk/xu57gYSIzgs6NzyNUI3cg949RXNCY+anmUq0PlqsLAMdoJVXSY6aHA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com; spf=pass smtp.mailfrom=microsoft.com; dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b=KuFUJdMp; arc=fail smtp.client-ip=52.101.53.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microsoft.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Z4yrvC9I2rOAV1PfgCjP/jjCgy5iwCW4w8UdvGBEP/djFLjSyWi2p1kixSlrqA9n0b+csJhhTtVxZ+Bq3zakFe91PDa+5sKMkT4t5/Cr8e4ETKO/3XK8qratCJWioz0/dfvOxZ+PMCR9MkwKHH4biIa/Bagf4mr+aSkH2NwtVQQEStduyFKCo82nWsQUM3Ihxdbwi5sTrPfuXqI1Eu1nJiYG1MYIiSS2sWD188RakjikFH5w59z2/qd6BSrUSWO3ltpC7kUrmflRSykJfyOkHqDS8O8JA8ulRYGIwEmbVxkwTwV+xCUjws25zrUHjepAM9mCqQmhgHNAxfyIJtwxxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=reI7pqNodcvnWIAPyhlC14rIjwhle/CVnpLouyeWtsw=;
 b=JnIH+n1LJFAWf5HJoJx1GGANkiPz1jWdZYtjYo2MPT2EWilVEB1dSpi0CkMvZUUZjzaw7XBHjYxq+wDzqtHmgtbuta5WhevMxOhxtKDmjDYhM4GBAnokN5A83nUEoDgBd3hi1EMrwCF5xehXbT89O/V662/cz+8U7jyUkfENRKpGwL6B6L4668sj4WnTInMaLT7R9Rv+E6b9ODGbEEQp+t0BhRGb92q/RK8cjp/Pwcs0HcID23RI5Rd/paRhQ9ZAwQgmEBCyNmBHFgA7ogxUhnIqMvrKUi5wVxxJFXXY+s1U90nNwP4A0SwHMlVAiyvDCf8YIu0J2n38bFlx9raJZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=reI7pqNodcvnWIAPyhlC14rIjwhle/CVnpLouyeWtsw=;
 b=KuFUJdMppZjOoAhAKwu9I95G4r/95mqdYlrsGR0qUPijwlX1twlevaSVH3CnWHNqqr4+HVpSKxDiQ0VTO6EcTqlPiADTdFIjywhI5cASQS8V5Ywuf4kX6803Mh3tzOwMe3NKHmlLf3qAzOkcpVEX7s1RfCOSnRHnhfjkTbEFpe8=
Received: from SA1PR21MB6921.namprd21.prod.outlook.com (2603:10b6:806:4a7::11)
 by SA1PR21MB6515.namprd21.prod.outlook.com (2603:10b6:806:4b0::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.20; Thu, 16 Apr
 2026 19:58:52 +0000
Received: from SA1PR21MB6921.namprd21.prod.outlook.com
 ([fe80::51cf:497c:e5df:f6d]) by SA1PR21MB6921.namprd21.prod.outlook.com
 ([fe80::51cf:497c:e5df:f6d%2]) with mapi id 15.20.9818.017; Thu, 16 Apr 2026
 19:58:52 +0000
From: Dexuan Cui <DECUI@microsoft.com>
To: Dexuan Cui <DECUI@microsoft.com>, KY Srinivasan <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>, "wei.liu@kernel.org"
	<wei.liu@kernel.org>, Long Li <longli@microsoft.com>,
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"mhklinux@outlook.com" <mhklinux@outlook.com>,
	"matthew.ruffell@canonical.com" <matthew.ruffell@canonical.com>,
	"johansen@templeofstupid.com" <johansen@templeofstupid.com>
CC: "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: RE: [PATCH] Drivers: hv: vmbus: Improve the logc of reserving fb_mmio
 on Gen2 VMs
Thread-Topic: [PATCH] Drivers: hv: vmbus: Improve the logc of reserving
 fb_mmio on Gen2 VMs
Thread-Index: AQHczdtyn1PdG2gkFEeUWQdp0QjV5Q==
Date: Thu, 16 Apr 2026 19:58:52 +0000
Message-ID:
 <SA1PR21MB6921B40AF0D80E1CE08D528BBF232@SA1PR21MB6921.namprd21.prod.outlook.com>
References: <20260416183529.838321-1-decui@microsoft.com>
In-Reply-To: <20260416183529.838321-1-decui@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=d55b939d-2596-4a52-8847-9fc711535274;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2026-04-16T19:56:44Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Tag=10,
 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR21MB6921:EE_|SA1PR21MB6515:EE_
x-ms-office365-filtering-correlation-id: e9a28acf-61cc-4793-86ab-08de9bf2954e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|376014|921020|18002099003|22082099003|56012099003|38070700021;
x-microsoft-antispam-message-info:
 3Q0f9mk3lHtjwzfPCw+sEX7o2l5OTEErggIwMg8LCZVJzwPW2195oPiSiFCa3M6U84sATNOtPOFH7SWSAU9X3HoVEl/ScBrhMijbeNjALC6Zc+UTFSSk3IDeSWrQHiNNkWQA/yeXQBfyoZt7LZjDdu0EAZDB8VeaT624/qxMOFCCDzB5jTYvF9uENPil2QWrxBuT1LzXVtg9AhaOcoE0mXmExJFCrd7jnIps7dXfiLGhnfHp7QsJwH08q3aIRelQn1DxpC3It1VTY9TfMInbRTgRjEP6ob8JlSrmTlb5TlHJ2yuqtIxLArhpLOUw5M5DOhFYUfhL7Eci7T7XiJa6Dpy2KiYn0QoAjHOrpkiuWkJM/OJWlXdcuUv4BSFRz24UgSu1GpNYIBxczupm++o0jhBYDrlIigFKOckq5QjWC+o8G80WMjF4dQNwO3qEPg4glqc2jh6xTkxEQ+Xdsa5OaxvYrsMMTugWeDQVOQL3x5UxNtIDNRqWp100hENXaXklIz4/vPp3y0Ng4fLoG84QjlTc11JfxaFqwI3fulxB+JiegiznGWdtXmQdmonxD89qAMKPPY2f3PELrSDPrWfz57h7OpD3YdsXkvC2SIrHa1sk8F/TTPO9LGJNMDb99vXaA0Ejek/04NAerPMCGXspTiiHeOJ2H6kR6PjUNYdPNuVOvfUdnDXedjA/RH4c3MQsZK5YwBHBzWDD0PEbfrNDuBJXhSeOsDiFyKCa68gYCw+I1qNppFqIuaD9p9ekVDPXOzrs4WH+gvwwLj/yXotmDwqsSZn6xT7Ev+lcujHSFJDzxbaJECMOXUjziYd02FSf
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR21MB6921.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(921020)(18002099003)(22082099003)(56012099003)(38070700021);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?DQuFDAYkRZyDBehqtFOv6kZkXPbGKp7OesdmuL4y4NWgEQocPRiddP18spc8?=
 =?us-ascii?Q?Lh35Klbfg/0eJ+emfkmi2x3btNBHuTCt+cn/vvJFIlyojIYln5gpS/8ppXlD?=
 =?us-ascii?Q?USYnUI46+ZwBa++QPOGGMkKkz18BfmraBEvV+zIp2jSlQWaUkfexbVbgKouo?=
 =?us-ascii?Q?BBG8UB2IHY4LLEWfBVQU1Jw0ZxXybko7RsInDinvQV/2OJavCXIaR3YrcAQA?=
 =?us-ascii?Q?AVhkwZY/SUEweyrz1DAW+RuquMah1+NPj42iLlxJfgAujsphoGvtiFOsdkuY?=
 =?us-ascii?Q?9ShvzeV8Z8TFkI+Mi7T5qwhh9+OJrNVvVOGk4dv1jACX4nvqj/7IEDsTuw0F?=
 =?us-ascii?Q?exbKWSKhjzVDmgx+36/ax1HgsUqL7hkpmKDgxOKzMXrPXaHGwQ8h8oSTWbGQ?=
 =?us-ascii?Q?HGc5o/laP8hOz7SIYZFhA+vhkb30y5HdExbG1qWZ8bmFUxf7lS0Qa01xX3Xv?=
 =?us-ascii?Q?P/7nGk6B1cF5+kMXrX8ngNykOaAGt9CeglC9+YmrregAzdSc+0xtpSFedii2?=
 =?us-ascii?Q?tuScKE0y67B3BR0Xr1oGtMCKBBj0nGQ4FHrgcaNPaMUsz4dJ6Ucaw5h3RxQz?=
 =?us-ascii?Q?oz3oHbB0935n6MrcwXW6F2cTUwd/FVV8xoQ7EVdNAw1uJoLnGtroSwGdgq6C?=
 =?us-ascii?Q?Itz2hMSG0bA+y+egMjfS+kUtFZuVQfBZyqq/x6QLdSSKt+FsANdmdfz8sH0r?=
 =?us-ascii?Q?O5tzOpO+93477o3Gg/l4eqSa/uA1nRAcdCjBJR48s2FWdu3PG7xY9OqSlytn?=
 =?us-ascii?Q?oFaU0qjVRbmbpIsW82XaVsz1su4o9nTKIDG1kxpI8Jyu05p9Jg+TeSV4Rv5z?=
 =?us-ascii?Q?JHYxW+0JsCZiyy5LB9ri/DyzVl6glJ13em6AK4xh9LZyHvXUmmycjrvqm9YC?=
 =?us-ascii?Q?bV68jl6NgdUX4HMIhck/7bkq2ZtSuI7GBCG4l85WH0XsjkkHguGCQKonygVw?=
 =?us-ascii?Q?RLzVYzLbyJFPIyKO3t9tbiy4OtSyGj/1+tSlquQcGZekJWA0i0EZJOLNuSJm?=
 =?us-ascii?Q?ISZRsoHK07gac23K8mmFmTJEChEZqT+gwlnYzs9hJ1wqPBOs3aujJSuUeQkT?=
 =?us-ascii?Q?MWWDP44sUcDsPr1w+iVQ0gX+soyugsdK18gPU3ORYiMy2MCklp5oXnXGxRSk?=
 =?us-ascii?Q?5rHD1rAFBKGIi9ubfmgPkL1nSSProxVhQk6CAv7rwhMw78l8odhqPTF9yT2m?=
 =?us-ascii?Q?LxA4gItkCsnDdlo/kwutm8DLyg+Ypyg51P5nToZC4w0W8yLxK5frp0/j/gjf?=
 =?us-ascii?Q?grVhGQENogYhuVSQtgQd3kiQVaR8mqXb9SSAP0x4j+vaB58ElXfsYGALGfk+?=
 =?us-ascii?Q?GZ3VKUBmhNHRqwfPDfD88tpJFRCzXnHokz7m9KNQh/m/cparh8MeHGq833xz?=
 =?us-ascii?Q?S31hucQp6NGYcy1MfyS9124a6qtMyxHcOp6k12MM1pJi1AqPTPWr3Ti6uykk?=
 =?us-ascii?Q?txKTC3hu39Wwk+u0tcNfp+X+xTHktUW4zQ+EyBNX1mn1/jQyXVA3Nw6hUl/D?=
 =?us-ascii?Q?7fA737RPW3P3C7I0f7cy5cxm70qAAlktLjJzt/yk2nvyeHZe0tXwBTymEYRV?=
 =?us-ascii?Q?jxKkFIctv4ivMHODiMQZiwLnOj608cidCFUqrUJ41RmnS+M5JESWkkZrVYk7?=
 =?us-ascii?Q?NOthnZULeIcAmFDUkNz4rz5LQ4mscCMe4DOVrHLvZHOqya/BRSKPZkaEg0mA?=
 =?us-ascii?Q?R65gg5xUrNt/Gy91KmEaOJXMa+fj7IbyvGQruXg73BD9GAPx?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: e9a28acf-61cc-4793-86ab-08de9bf2954e
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Apr 2026 19:58:52.2248
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: s2W5btOS/3YnZXXPE6kOrHihw+JmWYbCzel+Bql4TycGgSGSV2ZATZbAkCkBjUqOjxnABASEQJK0pi+zFeohvA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR21MB6515
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[microsoft.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[microsoft.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-10196-lists,linux-hyperv=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[microsoft.com,kernel.org,vger.kernel.org,outlook.com,canonical.com,templeofstupid.com];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[microsoft.com:+];
	MISSING_XM_UA(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[DECUI@microsoft.com,linux-hyperv@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-hyperv];
	RCPT_COUNT_SEVEN(0.00)[11];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,SA1PR21MB6921.namprd21.prod.outlook.com:mid]
X-Rspamd-Queue-Id: 3944D4146A7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

> Subject: [PATCH] Drivers: hv: vmbus: Improve the logc of reserving fb_mmi=
o on
> Gen2 VMs

Sorry for the typo in the subject -- the "logc" should be "logic". If this =
is the only
issue, I guess Wei can fix it for me :-)


