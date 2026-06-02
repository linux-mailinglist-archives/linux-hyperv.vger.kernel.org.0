Return-Path: <linux-hyperv+bounces-11457-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id OjczF69dH2qIlAAAu9opvQ
	(envelope-from <linux-hyperv+bounces-11457-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Wed, 03 Jun 2026 00:48:15 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id EEBD46328DB
	for <lists+linux-hyperv@lfdr.de>; Wed, 03 Jun 2026 00:48:14 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=microsoft.com header.s=selector2 header.b="H/CvHp9l";
	spf=pass (mail.lfdr.de: domain of "linux-hyperv+bounces-11457-lists+linux-hyperv=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-hyperv+bounces-11457-lists+linux-hyperv=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=microsoft.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DA65C30134AF
	for <lists+linux-hyperv@lfdr.de>; Tue,  2 Jun 2026 22:48:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBC1D36CE1E;
	Tue,  2 Jun 2026 22:48:09 +0000 (UTC)
X-Original-To: linux-hyperv@vger.kernel.org
Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11021104.outbound.protection.outlook.com [40.93.194.104])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F31F32ABCA;
	Tue,  2 Jun 2026 22:48:08 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780440489; cv=fail; b=j1KndQHCewx1+LLcfHSNkeHSpBtDyUv5m2eBc+LpJ62wPscfYewzFiWT9jOUmwumStIVycAO0VSSQlp2P9I0tL8njApFVmSO+jAiPp+jec4TEaNKWkouZLIuOiVVN2pVjSUnBejvwG0OZ8W6UiZY5c3E8nw+jx7Lud0SyP/KfXE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780440489; c=relaxed/simple;
	bh=16HoGVDRMUYMeuY1iSdt3BvVbpIU8GMGhgr9N3mdxZI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=XZK+c7lfew3XzaiPMeZ0CKMt9sjyxUBUFNiRUhEpn5eAO399VIVeUrIav97xQ7EFXM8RoYgMgDadZPWWH0PaDb2RCjz3hj3PqGIDQQ4j/3vo6zOchNjvF/ZtBOR1aEWVsWmp7NYz/EpetHux0Cq14CkLJxKcx/fDzyKF6yBv/lU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com; spf=pass smtp.mailfrom=microsoft.com; dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b=H/CvHp9l; arc=fail smtp.client-ip=40.93.194.104
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=T5gQeEjfKkMJ3hMsTVsN954baCa9bEiKbRnF3hjku4Dw2oiC+sANLfPJ+deAnsfEeQ9eyhCbVWBWRYmHYr3ryMsR2MrL20Kg/Qo/XSSZ3MBq4r838VV5HX/KnrxPVUfJCDXzLl8ys+F4TbUCr3Zm/Hf9PPwmmOPH3APA5TYppz7LFUD8g8kcgM10Y0Mc3aRcQ2A9RO8jkR1EID2Lovd3k0BIC3XUwPSm3Yll1WhvLfJuVCqntvvY/mY/0yc7PWru08EiBl5yF39DajU+M+6FAa3rpo2ByMfgEoBSfG3LX4S5rQmlDwsFLPamLXESOv5ruTHoXpiLzdZ2Af2s5A14Tw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KEW0I5HuxP+R1RUE9ouXyit4Hv0S/kk1fDDAKGQZzMM=;
 b=bMtVzDIaFWHXaXbLUoELSCobvVWg+xqzcXeDeSLJvqG3ptbkLQsC1ncMA3/Rf8BUMVHxmBhgcKOPNX1KgmOV7LqmgSDUPa/HZ/MdRvLT9JRfIXKYelsQ5RMLtuYsZK7f/HaDy7NWQMvn7Qp4+Lq1WjO2J48FJ+euk3ve/9vGqVYEHJhkSon/Ya9CFz6sBxvwxBbUhRp9000EgvSg4z8NKdU+aqAgOSI/Rqgvsnj9a6LX3Xq/9DPWwqqRGrqn6z0RbGnrnqgKqzDw0AM7JyQfKEZ/A6lTCBng8yaw1UmVveilYXCBnOvtFegSVak3S0lkfe6urz1Nj8/+7hgpDKgG5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KEW0I5HuxP+R1RUE9ouXyit4Hv0S/kk1fDDAKGQZzMM=;
 b=H/CvHp9lt4bvQhUdf5sX1xLoNBkMYwmYv+PX/3ox2ycvMFRKXJS3XxLHyCaU17pYCGDgsMzXIMj8HOeTh5nKWfip6P4Z9qO7D+lM2WEcZrNcTUdwMfsQ/kOyt3yyPgwTyN1x5+0v5BiHW5nI4roqThdwtvahvNO8rSbcYwg+zq0=
Received: from SA1PR21MB6683.namprd21.prod.outlook.com (2603:10b6:806:4a4::6)
 by SA3PR21MB5845.namprd21.prod.outlook.com (2603:10b6:806:492::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.6; Tue, 2 Jun 2026
 22:48:05 +0000
Received: from SA1PR21MB6683.namprd21.prod.outlook.com
 ([fe80::8bad:6294:8a07:fe18]) by SA1PR21MB6683.namprd21.prod.outlook.com
 ([fe80::8bad:6294:8a07:fe18%3]) with mapi id 15.21.0092.004; Tue, 2 Jun 2026
 22:48:05 +0000
From: Long Li <longli@microsoft.com>
To: Jakub Kicinski <kuba@kernel.org>
CC: Konstantin Taranov <kotaranov@microsoft.com>, "David S . Miller"
	<davem@davemloft.net>, Paolo Abeni <pabeni@redhat.com>, Eric Dumazet
	<edumazet@google.com>, Andrew Lunn <andrew+netdev@lunn.ch>, Jason Gunthorpe
	<jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>, Haiyang Zhang
	<haiyangz@microsoft.com>, KY Srinivasan <kys@microsoft.com>, Wei Liu
	<wei.liu@kernel.org>, Dexuan Cui <DECUI@microsoft.com>,
	"shradhagupta@linux.microsoft.com" <shradhagupta@linux.microsoft.com>, Simon
 Horman <horms@kernel.org>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [EXTERNAL] Re: [PATCH net-next v11 0/6] net: mana: Per-vPort EQ
 and MSI-X management
Thread-Topic: [EXTERNAL] Re: [PATCH net-next v11 0/6] net: mana: Per-vPort EQ
 and MSI-X management
Thread-Index: AQHc6lhTyIkZh41VFEGbRGEZk/VnV7YivmWAgAFG0OCAB+hzAA==
Date: Tue, 2 Jun 2026 22:48:05 +0000
Message-ID:
 <SA1PR21MB6683230E973519C12E2AB797CE122@SA1PR21MB6683.namprd21.prod.outlook.com>
References: <20260523020258.1107742-1-longli@microsoft.com>
 <20260527192735.34a794cf@kernel.org>
 <SA1PR21MB6683A7B2415BEAF17BD0EB4ECE092@SA1PR21MB6683.namprd21.prod.outlook.com>
In-Reply-To:
 <SA1PR21MB6683A7B2415BEAF17BD0EB4ECE092@SA1PR21MB6683.namprd21.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=b6f8d270-dfd8-4186-906b-7ff7b9b59e84;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2026-05-28T21:57:17Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Tag=10,
 3, 0, 1;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR21MB6683:EE_|SA3PR21MB5845:EE_
x-ms-office365-filtering-correlation-id: 8c39bf8c-392b-4631-a9f8-08dec0f90264
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|376014|7416014|366016|38070700021|18002099003|22082099003|6133799003|4143699003|11063799006|4133799003|56012099006;
x-microsoft-antispam-message-info:
 Y4UhRbS9wiIHwxoYbaiyzUXLtvTHmjFfXtmpS4VFcQI6iS4cFkhwRKBkj5HPg+h0sMIWBLkA+jOUQsFOqjFVDAo2LCt0Dm13OWNLXiDyG960iylW0vngjuIo7DGEPuDbS/a7a29esrI8sENCiLYyO2Bg6PsLJzUXD5thVl/N/BYuhRTUXB7PkjUf3YY4HVawcJil6CuV4L4G25E6CRVA8nYmVdMMQdJjdm2RNqgtaEaZtRSru1ZX9tfryGoSO0yiLTjHNOQ3KvKNjT36U+gygESO+YXq42jrgQEsKiAHUIJR5ix/O6sE6KTnXaJHNxtPPWWLnk6Id0xUej1igJI+s4vocQt2ib36X16WGnZrwIGM3qqBDBXFQq6W4x2VuxSFv3YMnFw8q1vR2Z5pne3OKUIc1/XAO9a7gOdcg50gvVicEr3cHEQC0LUzs7gFy1ksa4am8Z+L+H9QZEJkK7EB8z2YWWRcJ/1Gsx6pfPaoPJhkIFuYgJnNPRFLlcZoWWxEF1GBZrB8S2KWjKnLwpjk8NipRp+H+IpIQ4p+8BK24uyr1EApAbar8tn9VUenan8tqMyNhdqWdP2VZYFKBrNljUODCMldlJuvoNpDeAp+jpmq5jmUOINmI6jk4oC6OCiAH1R72J0smioJH1lnSj4R3znUATs84jLRd3xL/SXjJk0ghtVHnfhMMtpQczEKKFIgWVtHAqLWugK+7ZN5JiFFcOU8cSlji0JFqIao4AHJ30CJ6CyFVJAXh8SGa1YnS8lp
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR21MB6683.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(38070700021)(18002099003)(22082099003)(6133799003)(4143699003)(11063799006)(4133799003)(56012099006);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?iWeGtQ/WpWQjPD4Ed4aqvfa3/Jb6JKbhTDK1xuy2K/uwGky1JYF6dDypJ64f?=
 =?us-ascii?Q?2mYIbpamxS2vPYiTfjoVgO1TAt4suFKg6MAvkHgcc7VW+AoVVpatIuFoApDV?=
 =?us-ascii?Q?ID58DsKGERt7nnEuWhAunHzTy+Jt2e9VmONgXcXsJ/x63B5qDdGIksYmF/oM?=
 =?us-ascii?Q?iIbcc18z/T6wpWDwAvw4FnUZz00aBywgySeKcYer4v/DYQFIkkR/HLKCxOss?=
 =?us-ascii?Q?xvgFCWees3cpwRltQP3E02WK8cN8gs4wfEgdeiqLuAsV5uFAWV1Kg9OfEuGV?=
 =?us-ascii?Q?lyMTTY63Z4GSY0CcL1eSLpnTl+G5CPmetqpR4zyM7XZDNqSDw/60fv6zsHJJ?=
 =?us-ascii?Q?AElAKQ/3sPcOnrFSKdCwqnVYWzczZn4TFHQlZ7jhmduDihALL9pl/l8KVkH+?=
 =?us-ascii?Q?b/s2GyBYQKW03mnVx021z24snWquFOPzuqUO3UUnCPQBm+M1KB4Vf7r70iwX?=
 =?us-ascii?Q?n9F5ctuaQl3lhw0jhteRa5DYXzDWdlJ+dupLlZFL0wQjAMn2TNAQMp1/dq9d?=
 =?us-ascii?Q?FeAeY33g65Mn8s46NND1RKbOcixpU+ae6RPgFhec4wQhFSitasxvKqWYTmhS?=
 =?us-ascii?Q?s9IEsLou+FDs+N4dAi8ra9amGeJWLZE3SuDKTRvuLKGiE9Y0uo1K52eKvgsv?=
 =?us-ascii?Q?QPuFHINtCGvfLW4smV4EmJ9133sD97M1m08gx5CwngQRzV9NaPSpcj+QfAMn?=
 =?us-ascii?Q?92wgMtjpF0kebZhYGK7WCq611ak5d534OwXAF8ROkY6pM8sfs4rCcIw8A9db?=
 =?us-ascii?Q?OJ4R5s1HDAl4zlWIYaj3NtSEc4zSUcAF/mkC5GPLal4EeBtuv2g6a9US+8R1?=
 =?us-ascii?Q?OtW6uAk0hk0f9F/U62CqioVo5V3Dyx1QMp1/bOl6Eq1AC7UV0oOdfWEXjwID?=
 =?us-ascii?Q?g//5vltNZNpS3UJlR4zfYGB2/w+OhZH7mfMyuPb8VQlRSrw763mOypDtiVGc?=
 =?us-ascii?Q?ebq/zPb9n6v5qZP5vVfj+UtoIbmnigUTUlgFik3grZcOy+NnHONB+a1M5BZJ?=
 =?us-ascii?Q?CxE/JkAgMTj2iHon0C3zAWzOhyPPSO6YcZARGl9rSUUg0zmxfuLy8ImHAaFH?=
 =?us-ascii?Q?lyjBEZ/rslE0mMCc+Qsjd5misr1KoIGV0OmteLea5KHtrNUBAhOyJBmoNT4D?=
 =?us-ascii?Q?9/IClHTJgWGz9a/B60eLKCOlxvBwcszNV4FstA7NN8+SZYeCYNaR3I7VrGxr?=
 =?us-ascii?Q?dEugAbrOd6WMnOzMGoVICZWEZSFOpDreB/ki16+aG9IYdYO5c+gp1HKznc4G?=
 =?us-ascii?Q?9dmzhdh3t36UFFKa0Yn6DTmGjCYFNrni+mSeocs/vOzLnUoFMBaStShwqOHO?=
 =?us-ascii?Q?FheRj6HCTZ1ARQDninv4J/cRRElXMdJow3tRv7wAvZhOOYLUCPvoGmI/t5xb?=
 =?us-ascii?Q?Z1nPQJxjcChsmCOtMU3ryNb62w+Ts7xrqZ3DCe8mrwsWda1S25rRKvbt501/?=
 =?us-ascii?Q?EiRu19lVg/9n8ARiC0J1U6Yfs9xFpsPYWBY0W4tRsDsB+KT5CxjJ8mYbySTm?=
 =?us-ascii?Q?9KxgUVXQl+75w3c1/f8Rm+bTd0Mp8KbfByiR+xHDjI0NsbbkY6eEwrR9AgFu?=
 =?us-ascii?Q?vSDH62jN38wWwV2gtGoDJOrz02o8HZJV44qQzJTYzSUALdhoX8bTqNsNFN4c?=
 =?us-ascii?Q?mdnNJxqXuNTFqO2i4cBwdUhCbijrmrfoXCiET8eknTHRpluP1Ss/pz5qWOFO?=
 =?us-ascii?Q?FBzUxe+5/K/G2XhHsuMs7c2Sx+xRwm2w+PT9JlLpaOp1nSGv?=
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
X-MS-Exchange-CrossTenant-AuthSource: SA1PR21MB6683.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c39bf8c-392b-4631-a9f8-08dec0f90264
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Jun 2026 22:48:05.2228
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5Nlm6uVVP9nVRzMz6Rp51TvBshCe+5Jp271sV6UeZEgMZZi0KiLzqSQ7QO6WEWg+KbTdI20urmFGA/Ze1I46fA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR21MB5845
X-Rspamd-Action: no action
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[microsoft.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[microsoft.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-11457-lists,linux-hyperv=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:kuba@kernel.org,m:kotaranov@microsoft.com,m:davem@davemloft.net,m:pabeni@redhat.com,m:edumazet@google.com,m:andrew+netdev@lunn.ch,m:jgg@ziepe.ca,m:leon@kernel.org,m:haiyangz@microsoft.com,m:kys@microsoft.com,m:wei.liu@kernel.org,m:DECUI@microsoft.com,m:shradhagupta@linux.microsoft.com,m:horms@kernel.org,m:netdev@vger.kernel.org,m:linux-rdma@vger.kernel.org,m:linux-hyperv@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	FORGED_SENDER(0.00)[longli@microsoft.com,linux-hyperv@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[longli@microsoft.com,linux-hyperv@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[microsoft.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-hyperv,netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,outlook.com:url,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: EEBD46328DB

>=20
> > On Fri, 22 May 2026 19:02:50 -0700 Long Li wrote:
> > > The following changes since commit
> > 95fab46aea57d6d7b76b319341acbefe8a9293c8:
> > >
> > >   Merge branch
> > > 'net-convert-atm-xdp-af_iucv-l2tp_ppp-rxrpc-tipc-to-getsockopt_iter'
> > > (2026-05-22 11:11:12 -0700)
> > >
> > > are available in the Git repository at:
> > >
> > >
> > >
> > https://nam06.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fgit=
h
> > >
> > ub.com%2Flonglimsft%2Flinux.git&data=3D05%7C02%7Clongli%40microsoft.co
> > m%
> > >
> > 7C36237239bb6949843c7508debc60af6c%7C72f988bf86f141af91ab2d7c
> > d011db47%
> > >
> > 7C1%7C0%7C639155320616840917%7CUnknown%7CTWFpbGZsb3d8eyJF
> > bXB0eU1hcGkiO
> > >
> > nRydWUsIlYiOiIwLjAuMDAwMCIsIlAiOiJXaW4zMiIsIkFOIjoiTWFpbCIsIldUIjoy
> > fQ%
> > >
> > 3D%3D%7C0%7C%7C%7C&sdata=3D43aUwSeHYaOhd%2Bmd1lwfmCqmrAObg
> > MWJoDRpKDhmCt8
> > > %3D&reserved=3D0 tags/mana-eq-msi-v11
> > >
> > > for you to fetch changes up to
> > a26d11135abba51e81ae8b9689e288718af95088:
> > >
> > >   RDMA/mana_ib: Allocate interrupt contexts on EQs (2026-05-22
> > > 20:35:43 +0000)
> >
> > The branch is no good, it needs to be your patches applied on top of a
> > commit already in Linus's tree. The current branch is on top of
> > net-next, RDMA would have to pull in 100s of networking commits togethe=
r
> with your changes.
>=20
> Hi Jakub,
>=20
> Thanks for looking into this. Since the RDMA patch (patch 6) depends on t=
he
> networking changes in patches 1-5, could this series go through net-next?=
 I've
> verified that the tag pulls cleanly into the latest net-next.
>=20
> Leon, Jason - could you provide an Acked-by for patch 6 ("RDMA/mana_ib:
> Allocate interrupt contexts on EQs") so it can be taken through the netwo=
rking
> tree?
>=20
> Thanks,
> Long

Hi Jakub,

Thank you for the feedback. Since the RDMA patch builds on the networking c=
hanges, would it be possible to take this series through net-next? I've con=
firmed the tag merges cleanly into the current net-next head.

Leon has acked patch 6 on v2 [1]. There are no significant structural chang=
es to the RDMA driver since then - the differences are minor:

Changes in patch 6 from v2 to v11:

 - Error handling updated from NULL/-ENOMEM to IS_ERR()/PTR_ERR() for mana_=
gd_get_gic() return values
 - Added mdev->eqs[i]->eq.irq =3D gic->irq to populate the irq field on all=
 RDMA EQs for consistency with the Ethernet path
 - Introduced a separate msi variable instead of modifying spec.eq.msix_ind=
ex directly
 - Commit message updated

The gdma.h changes are identical to v2.

[1] https://lore.kernel.org/all/20260304145923.GE12611@unreal/

Thanks,
Long

