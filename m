Return-Path: <linux-hyperv+bounces-9514-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0OueCULnuWnBPQIAu9opvQ
	(envelope-from <linux-hyperv+bounces-9514-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Wed, 18 Mar 2026 00:44:02 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 835B72B46D1
	for <lists+linux-hyperv@lfdr.de>; Wed, 18 Mar 2026 00:44:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 47E2F30774C3
	for <lists+linux-hyperv@lfdr.de>; Tue, 17 Mar 2026 23:44:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFEF2373BE8;
	Tue, 17 Mar 2026 23:43:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="BoVHIrdo"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11021141.outbound.protection.outlook.com [52.101.52.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C6CF342507;
	Tue, 17 Mar 2026 23:43:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.141
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773791039; cv=fail; b=l67TO2Lhm4uo5ZAp0rAWai97JmOS4lc9LA/5rZx9qwqXpDcJKlL9rjGs6ad0FIgPYDXlH//R4BvOae80L1T6WOZb0pncmvCgd5jA4xVG33VEpznUJQm7kNg9G3rnZfMxEVkk1t8KgahE3exenHrOI3r3Xq4mcpAwR48pVdDKiWE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773791039; c=relaxed/simple;
	bh=WKXljsKlH4zDB0lgy/7K2miBeK3pA8RdS9i/0a7JHTM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=VhMZe4w7w3aiYI+qFvBWM10gnyqIZVnt4wAYMrWfnZyVLmwH5MyCfjFVKrwk9A7eiOuN6CPTtIUnaKPUHOy1MOe0h5J9r6X8xLbndaepdrzzCOlsZ0KRPR/8P8M7ePa0EyTie2fvKRbCesMqf0NWHusR2w8nRNrUaihtozJClpY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com; spf=pass smtp.mailfrom=microsoft.com; dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b=BoVHIrdo; arc=fail smtp.client-ip=52.101.52.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microsoft.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PkZhG2p3W5PCtafiXvAPKecyIKsitLDjhyfUh6KP17SBJzRdM3SA+91Ex38HZynPszSDpsbUgS1yg5JvLO27pIDU7P7jgdiCCma3BqM7y7GwOkJh6dXDqYujLMSQll9im5SyDinDoOFpJr+ETFuTEwQyLyZkpC22uIAZyvsjxCyf72+p6QjGF8xKv6TFvKoiVi2yW9kQVBpvqlUsuy56ysqv8TVPQ3RW5gLGJ0UHqx2lkxG3l5aDKDKlkyNvNWyJbzkiJ/fpfFIDhBnr51SsLh+MYUcwCdl6/l6tVnKrV7sjjbVkdXp4NlKAEJHl6HqDVApkDSDUJwoJnar6vHTYjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WKXljsKlH4zDB0lgy/7K2miBeK3pA8RdS9i/0a7JHTM=;
 b=BIFKt1Z7EufkNeUBgXU0KZzK7J66TwL5b3O8cRQGZ5vC4VQ0F1UFHLlKx4j2VmPijFGv5bcheaDv/vAloQu6VvOkp4jdrVYyrhc9z6ikLF9CVzl045HHc29LswduI8AOpGTOXoZYP9+XFzWSwYE3sgEejVZD/b8muHqTb7Znuy2DYVrj1EaUlgpc2U1mhvfd2B/LQcuS3s/7ljFhi+8PzXAod5C2xxru45ZH/PmXKJvoPEfNDZmffaFaS0+Pzye7D0OUa8MjCTQiDQe+wWvs0ACFrGidn/cXHRjuhTBpz0Row0v6gYQa9CodowyKIOP18Ey0r1Kl/ukibGTuyloiwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WKXljsKlH4zDB0lgy/7K2miBeK3pA8RdS9i/0a7JHTM=;
 b=BoVHIrdo04x0mxPk4eXcp2MPydRkPYXwZPid7UU1MfUj4iJSokA2TAd2BvpeDMcgECxnX+/zp/dYDrRfCp2kst/nOjQyeH0tygekguMMMjp+Pnfn+SN48Ahbcy10DXdvKkYgl78IISmApI3yw6DuPsyU4XY6epqGmjE94ejgnkw=
Received: from SA1PR21MB6683.namprd21.prod.outlook.com (2603:10b6:806:4a4::6)
 by SA1PR21MB6896.namprd21.prod.outlook.com (2603:10b6:806:4ab::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.8; Tue, 17 Mar
 2026 23:43:54 +0000
Received: from SA1PR21MB6683.namprd21.prod.outlook.com
 ([fe80::879f:eec1:ca0e:d219]) by SA1PR21MB6683.namprd21.prod.outlook.com
 ([fe80::879f:eec1:ca0e:d219%3]) with mapi id 15.20.9723.008; Tue, 17 Mar 2026
 23:43:49 +0000
From: Long Li <longli@microsoft.com>
To: Leon Romanovsky <leon@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>
CC: Konstantin Taranov <kotaranov@microsoft.com>, Jakub Kicinski
	<kuba@kernel.org>, "David S . Miller" <davem@davemloft.net>, Paolo Abeni
	<pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>, Andrew Lunn
	<andrew+netdev@lunn.ch>, Haiyang Zhang <haiyangz@microsoft.com>, KY
 Srinivasan <kys@microsoft.com>, Wei Liu <wei.liu@kernel.org>, Dexuan Cui
	<DECUI@microsoft.com>, Simon Horman <horms@kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [EXTERNAL] Re: [PATCH rdma-next 0/8] RDMA/mana_ib: Handle service
 reset for RDMA resources
Thread-Topic: [EXTERNAL] Re: [PATCH rdma-next 0/8] RDMA/mana_ib: Handle
 service reset for RDMA resources
Thread-Index: AQHcrdRi82O3B6rCEU2l9i36Kc60QrWjVrAAgAljKACABOvfgIAByZFQ
Date: Tue, 17 Mar 2026 23:43:49 +0000
Message-ID:
 <SA1PR21MB66832D0A369DE7E411ACCDEDCE41A@SA1PR21MB6683.namprd21.prod.outlook.com>
References: <20260307014723.556523-1-longli@microsoft.com>
 <20260307173814.GN12611@unreal> <20260313165928.GH1704121@ziepe.ca>
 <20260316200843.GK61385@unreal>
In-Reply-To: <20260316200843.GK61385@unreal>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=50099115-4d0d-4cf8-ba11-9f5a625814e9;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2026-03-17T23:26:24Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Tag=10,
 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR21MB6683:EE_|SA1PR21MB6896:EE_
x-ms-office365-filtering-correlation-id: dfb8fc14-1b31-40c2-d430-08de847f09f6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|7416014|376014|38070700021|56012099003|22082099003|18002099003;
x-microsoft-antispam-message-info:
 WVUIRiET9DPYMkK4HoZTcCtem+OjYqi4MZh9+wAQCSA/tYcUcmaXoPHsR2BMZSls/gxWgkVet2vgRpOb4/0g9GH6Uad1rz40voer/8vQLw60f2SW5BbgPxMzGrr4K9VkcSNcTXJv6QIwZij9tfW4Yalvl87BpQ3kgGusyKYHTfwaUshTeYsG5FlBId6GHGbpyXtj8zDQC4NVWMt4MfWXoRgSQu7U5iXY0UuOdDyCBZmUF346Dyo3g60fxYnfJsX5xz+okS5R61PycyBBDOUpkBYUcxz9byDrRU25ZCvNqqsdg3bwryur2A6KgtDMqvLAKqblu8I9ZwkC9hacikfvOUMgradVPrgVcjp8spSWqBVcAyeu2w6GPS7G11WGE1o/p3zb6DPmOPuf4iWP2fzKyxBz1eH/x8kX7SiGsKEUkZsuus4IxFzROcytnWXcfdC7OiAsyKGmQsiE54zWEgyuHOvad1Ia5yeodsi/v8JMZfWC35BhS6mskpk0/dPzuqY6c56RZFIQ3TnEXGXLatrCOx4ZXxCKmNeBQmMAS6R1bxqjHlxz7oiwWhx36jr0dQF/JxJOZ1i6D9Sr0WtCtvcRj5QM66+0sInvg/JcnmXXbBf2pKkbmJeTC7m7KyGy7VmCwY/QLUijaTsht9A9LL7ZLocwHermIIapaOuqpR/emUqeRFHobGar3AL0jACTUcOj+vdq21VRbFVGSmbnexV4HO1i7mqFBhTMrv9Ai9OzDn0=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR21MB6683.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(38070700021)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?NmVFMnVCSDBwN0NRV1pOU2k4TkR0dlFneU40MmVreHNhWE1hWjd6aitNQWFT?=
 =?utf-8?B?K0htdk4wcVE5RkV1WjdyNnRZRVBiSjl5Z0JCMytnbnByQy9HdzhxY2RnQis4?=
 =?utf-8?B?M3RHZ3pQNjIzTzVIUWVNdFhqWFl6cSs3WThrK1pJYXFrZTJta1VlME1xY1hG?=
 =?utf-8?B?dEU0WUNlQitlYXIwZHdzcG5yQ1kvYUtZZk84ckM2RFdjbUF5V1ZjdEFhT2h3?=
 =?utf-8?B?R1JiTW5ERTAzdFNHTDdzUnNQd2gvRER0ZjY4bElvNDVySGJUakwwS3ovWlNo?=
 =?utf-8?B?cEpNZ01KRkt5QkdaMmUweE9lTmdKS1laSlJLSWVpSVFNZnNKVW5wa3JZYldu?=
 =?utf-8?B?K0xPaEN5VGZzNDdCNkc3WkVnazNHalJwOEg5ako4aEFQdkg5UVUvN2xWUERN?=
 =?utf-8?B?dE1rSXFUbzMydEI2WG1RMmJoTytVT2t0SC9DeXl5ZFpWNEQ5N2RHZnlLUmhW?=
 =?utf-8?B?NUxGWmpUN1Buc2pwdEFxcnE3b0JReWNWQ2UyYnV6TUJmaXRoN1NYejIyOG5Y?=
 =?utf-8?B?M1hnb0Uvb1VidTdyK09PazFXT2c4S05pbGp3YndyUk9vZ2NGOUFJTlk4aEw5?=
 =?utf-8?B?emZaV001Ym5SdS85QVJqT3lQWEVEb1FuS2NCVTVKTFpUZ3RaSDRwNmNodHB1?=
 =?utf-8?B?eWs1aTBzeEdRWWhjc21UT0JSVVJleTRHaWdjVjVJb2VvY2FUUjJuOWxYQnpo?=
 =?utf-8?B?UjRlc2tOUDNvQk5Ha2NxNXRjaldMeEdhMjJhbG94eGJYSkFMZXF2LzBoVmox?=
 =?utf-8?B?Yllib0pHTXd3L3o2UjgreVZScmJFdzVtUFVmMFZYLzd3emtoYmgrRS9RSlpE?=
 =?utf-8?B?ZEU0MEdMNnNrSkRWdW1oUXJCQ09jWktsWkF6MCt5dzZtaWg3KzV6UUNycEZy?=
 =?utf-8?B?a3Z2eGRPZXloZzJLVlRrVmhPKzRPN1RkZVFrYzNucEV6QTBrcVFFRXVPaTli?=
 =?utf-8?B?MmdHSk1ZK1BRdUpyaVJldDFJOGVxVUd2UVJ3UVZIbGswMUxYV1I1Y0NYZkVn?=
 =?utf-8?B?VmVDQytSWDltTWRnQURpVkx2ZU93VnNGRU4xdTN0ZlhaZHhWeWRoRjFnV2Yv?=
 =?utf-8?B?ZHBLN2lxWWtFMkdZdC9tOStacW9PVmlvRU50RTBndnMybDA5YThIb2wzYWlj?=
 =?utf-8?B?WXMvY2Z2eVRZdEVnV0hZTXcrNDdxZ1RUb3laTFU0ZXdYekVHSk5YbUl5TjRx?=
 =?utf-8?B?NHh2a0NpemJPdVllUE1mNThiWlExVG1UbXdLalQvd0VScjZ2VEg0VTJycDR4?=
 =?utf-8?B?MFlpY1ZjTEZ0UCtQM25reXBoc2wrdVRldUFBQXd3SEZPd0hBVFRJZnYrWENx?=
 =?utf-8?B?M3dxODFZUE5yTStqN3M3SEkramZ5eUk2eGxqcXlDR2JNN3NyanAvZjRFWFBC?=
 =?utf-8?B?MHl3cDRCaTdwUjBOQ09IUHFFVUxZTzlXSWlEdTY4K3YyNFErUlo4Mk9JK3pW?=
 =?utf-8?B?MVF1NHl0dEJXei92eUxKMGFSODZjYzViTnd2YWJXTnp6bXZWWHlMU0w4SitP?=
 =?utf-8?B?UXduRlNhVnljNXBIaUlPZlplN1FYbUgzcDBvMFhRVWtUYTZVdUhsMmVjdG5n?=
 =?utf-8?B?N2NoSWc3Mm44QWhkTVJISS9ISjJ4ZjE5VEt1OFVJcWd4KzMrVHdXV1IvRGtM?=
 =?utf-8?B?djNmM1ZscDc3OUdtWUp2cFdvMThlVWkwdTNGZU05M211bUppWUxVc2JUbHJv?=
 =?utf-8?B?elpMOENaNkZNYmYrdThvVFVsdXpGWWFiUmxidzBJRTBySVlWT2lhbnJPTDhz?=
 =?utf-8?B?QXhKMklQMjV1N1BLS1lBRVgxREdpcXNNanN0UFhRRXozbWdQZkZGdVJtaTRI?=
 =?utf-8?B?bG9ud2hFWHJIdzZsK3VhTlRGcmhNemZnWmg2ZVptS3ZDTlp1czA2elo2cFZi?=
 =?utf-8?B?clpwN01zbXBmTXh2QkJwZUVqOVVBMjRFZXQ4OUZIK3hXQVhkM0pFWStFME4z?=
 =?utf-8?B?d0dGdmtPOVB4MVVrVUNpeVdJTnJ0MEpuWmg0eE1lUGRjVzdrai9VTjA0NENO?=
 =?utf-8?B?ajdRQjNVMTM4alVzbkh2VEhicFFFbGV5bmkvNW94SUxsd1lPL2tCS3ZiWC9w?=
 =?utf-8?B?dFFrWk1GRFlHM1FwR1I0ZmZuZklvbTVxeFpRWmFoazNJYklMS2MrMkZiR0dR?=
 =?utf-8?B?M0VxUXl1QVFqM0RqeTUxelQxVjJFUGVkUzdMYWh6OEpBZTVuMlJ5Ry90SzFk?=
 =?utf-8?B?N2gzZHM3MGtDTzlyYkhtR1hUQU53V2NNV1kvbDJvdSs1eHBhdlYrZVd0RjB6?=
 =?utf-8?B?UWtuUDQ0RC94WjdsdXRIOGJ5TUVXdFQyUm9qU1FZZzFac3FDQmwzTk1TL2hX?=
 =?utf-8?Q?7RRlp3xLRoPtYSy5Rs?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR21MB6683.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dfb8fc14-1b31-40c2-d430-08de847f09f6
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Mar 2026 23:43:49.5586
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wzrbOnRR8Qj/2ItGZTtATfdiQ41It4VborqV9oWSI/gcs6muX5at6PaOBIMh7FDMCrgk18i7ue8UDVV/0LfkYw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR21MB6896
X-Spamd-Result: default: False [1.44 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[microsoft.com,reject];
	R_DKIM_ALLOW(-0.20)[microsoft.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-9514-lists,linux-hyperv=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[17];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[longli@microsoft.com,linux-hyperv@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[microsoft.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-hyperv,netdev];
	NEURAL_HAM(-0.00)[-0.999];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,SA1PR21MB6683.namprd21.prod.outlook.com:mid]
X-Rspamd-Queue-Id: 835B72B46D1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

PiANCj4gT24gRnJpLCBNYXIgMTMsIDIwMjYgYXQgMDE6NTk6MjhQTSAtMDMwMCwgSmFzb24gR3Vu
dGhvcnBlIHdyb3RlOg0KPiA+IE9uIFNhdCwgTWFyIDA3LCAyMDI2IGF0IDA3OjM4OjE0UE0gKzAy
MDAsIExlb24gUm9tYW5vdnNreSB3cm90ZToNCj4gPiA+IE9uIEZyaSwgTWFyIDA2LCAyMDI2IGF0
IDA1OjQ3OjE0UE0gLTA4MDAsIExvbmcgTGkgd3JvdGU6DQo+ID4gPiA+IFdoZW4gdGhlIE1BTkEg
aGFyZHdhcmUgdW5kZXJnb2VzIGEgc2VydmljZSByZXNldCwgdGhlIEVUSA0KPiA+ID4gPiBhdXhp
bGlhcnkgZGV2aWNlDQo+ID4gPiA+IChtYW5hLmV0aCkgdXNlZCBieSBEUERLIHBlcnNpc3RzIGFj
cm9zcyB0aGUgcmVzZXQgY3ljbGUg4oCUIGl0IGlzDQo+ID4gPiA+IG5vdCByZW1vdmVkIGFuZCBy
ZS1hZGRlZCBsaWtlIFJDL1VEL0dTSSBRUHMuIFRoaXMgbWVhbnMgdXNlcnNwYWNlDQo+ID4gPiA+
IFJETUEgY29uc3VtZXJzIHN1Y2ggYXMgRFBESyBoYXZlIG5vIHdheSBvZiBrbm93aW5nIHRoYXQg
ZmlybXdhcmUNCj4gPiA+ID4gaGFuZGxlcyBmb3IgdGhlaXIgUEQsIENRLCBXUSwgUVAgYW5kIE1S
IHJlc291cmNlcyBoYXZlIGJlY29tZSBzdGFsZS4NCj4gPiA+DQo+ID4gPiBOQUsgdG8gYW55IG9m
IHRoaXMuDQo+ID4gPg0KPiA+ID4gSW4gY2FzZSBvZiBoYXJkd2FyZSByZXNldCwgbWFuYV9pYiBB
VVggZGV2aWNlIG5lZWRzIHRvIGJlIGRlc3Ryb3llZA0KPiA+ID4gYW5kIHJlY3JlYXRlZCBsYXRl
ci4NCj4gPg0KPiA+IFllYWgsIHRoYXQgaXMgb3VyIGdlbmVyYWwgbW9kZWwgZm9yIGFueSBzZXJp
b3VzIFJBUyBldmVudCB3aGVyZSB0aGUNCj4gPiBkcml2ZXIncyB2aWV3IG9mIHJlc291cmNlcyBi
ZWNvbWVzIG91dCBvZiBzeW5jIHdpdGggdGhlIEhXLg0KPiA+DQo+ID4gWW91IGhhdmUgdGVhciBk
b3duIHRoZSBpYl9kZXZpY2UgYnkgcmVtb3ZpbmcgdGhlIGF1eCBhbmQgdGhlbiBicmluZw0KPiA+
IGJhY2sgYSBuZXcgb25lLg0KPiA+DQo+ID4gVGhlcmUgaXMgYW4gSUJfRVZFTlRfREVWSUNFX0ZB
VEFMLCBidXQgdGhlIHB1cnBvc2Ugb2YgdGhhdCBldmVudCBpcyB0bw0KPiA+IHRlbGwgdXNlcnNw
YWNlIHRvIGNsb3NlIGFuZCByZS1vcGVuIHRoZWlyIHV2ZXJicyBGRC4NCj4gPg0KPiA+IFdlIGRv
bid0IGhhdmUgYSBtb2RlbCB3aGVyZSBhIHV2ZXJicyBGRCBpbiB1c2Vyc3BhY2UgY2FuIGNvbnRp
bnVlIHRvDQo+ID4gd29yayBhZnRlciB0aGUgZGV2aWNlIGhhcyBhIGNhdGFzcm9waGljIFJBUyBl
dmVudC4NCj4gPg0KPiA+IFRoZXJlIG1heSBiZSByb29tIHRvIGhhdmUgYSBtb2RlbCB3aGVyZSB0
aGUgaWIgZGV2aWNlIGRvZXNuJ3QgZnVsbHkNCj4gPiB1bnBsdWcvcmVwbHVnIHNvIGl0IHJldGFp
bnMgaXRzIG5hbWUgYW5kIHRoaW5ncywgYnV0IHRoYXQgaXMgY29yZSBjb2RlDQo+ID4gbm90IGRy
aXZlciBzdHVmZi4NCj4gDQo+IEdvb2QgbHVjayB3aXRoIHRoYXQgbW9kZWwuIEl0IGlzIGdvaW5n
IHRvIGJyZWFrIFJETUEtQ00gaG90cGx1ZyBzdXBwb3J0Lg0KPiANCg0KICAgSSB0aGluayB3ZSBj
YW4gcHJlc2VydmUgUkRNQS1DTSBiZWhhdmlvciB3aXRob3V0IHJlcXVpcmluZyBpYl9kZXZpY2UN
CiAgIHVucmVnaXN0ZXIvcmUtcmVnaXN0ZXIuDQoNCiAgIE9uIGRldmljZSByZXNldCwgdGhlIGRy
aXZlciBjYW4gZGlzcGF0Y2ggSUJfRVZFTlRfREVWSUNFX0ZBVEFMIChvciBhDQogICBuZXcgcmVz
ZXQgZXZlbnQpIHRocm91Z2ggaWJfZGlzcGF0Y2hfZXZlbnQoKS4gUkRNQS1DTSBhbHJlYWR5IGhh
bmRsZXMNCiAgIGRldmljZSBldmVudHMg4oCUIHdlIHdvdWxkIGFkZCBhIGhhbmRsZXIgdGhhdCBp
dGVyYXRlcyBhbGwgcmRtYV9jbV9pZHMNCiAgIG9uIHRoZSBkZXZpY2UgYW5kIHNlbmRzIFJETUFf
Q01fRVZFTlRfREVWSUNFX1JFTU9WQUwgdG8gZWFjaCwgc2FtZQ0KICAgYXMgY21hX3Byb2Nlc3Nf
cmVtb3ZlKCkgZG9lcyB0b2RheS4gVGhlIGRpZmZlcmVuY2U6IGNtYV9kZXZpY2Ugc3RheXMNCiAg
IGFsaXZlLCBzbyBhcHBsaWNhdGlvbnMgY2FuIHJlY29ubmVjdCBvbiB0aGUgc2FtZSBkZXZpY2Ug
YWZ0ZXIgcmVjb3ZlcnkNCiAgIGluc3RlYWQgb2Ygd2FpdGluZyBmb3IgYSBuZXcgb25lIHRvIGFw
cGVhci4NCg0KICAgVGhlIG1vdGl2YXRpb24gZm9yIGtlZXBpbmcgaWJfZGV2aWNlIGFsaXZlIGlz
IHRoYXQgc29tZSBSRE1BIGNvbnN1bWVycw0KICAg4oCUIERQREsgYW5kIE5DQ0wg4oCUIGRvbid0
IHVzZSBSRE1BLUNNIGF0IGFsbC4gVGhleSB1c2UgcmF3IHZlcmJzIGFuZA0KICAgbWFuYWdlIFFQ
IHN0YXRlIHRoZW1zZWx2ZXMuIEZvciB0aGVzZSB1c2VycywgYSBwZXJzaXN0ZW50IGliX2Rldmlj
ZQ0KICAgd2l0aCBJQl9FVkVOVF9QT1JUX0VSUiAvIElCX0VWRU5UX1BPUlRfQUNUSVZFIG5vdGlm
aWNhdGlvbnMgZW5hYmxlcw0KICAgcmVsaWFibGUgaW4tcGxhY2UgcmVjb3Zlcnkgd2l0aG91dCBy
ZW9wZW5pbmcgdGhlIGRldmljZS4NCg0KICAgVGhpcyBtYXR0ZXJzIGVzcGVjaWFsbHkgZm9yIFBD
SSBEUEMgcmVjb3ZlcnksIHdoaWNoIGlzIGJlY29taW5nDQogICBjcml0aWNhbCBmb3IgbGFyZ2Ut
c2NhbGUgR1BVL3N0b3JhZ2UgZGVwbG95bWVudHMuIFNlZSB0aGlzIHRhbGsgZm9yDQogICBjb250
ZXh0IG9uIHRoZSB2YWx1ZSBvZiBzdXJ2aXZpbmcgRFBDIGV2ZW50czoNCiAgIGh0dHBzOi8vd3d3
LnlvdXR1YmUuY29tL3dhdGNoP3Y9VHBOTmVNR0VzZFUmdD0xNjE5cw0KDQogICBUb2RheSBhIERQ
QyBldmVudCBvbiBvbmUgTklDIGtpbGxzIGFsbCBSRE1BIGNvbm5lY3Rpb25zIGFuZCBjYW4NCiAg
IGNyYXNoIGVudGlyZSB0cmFpbmluZyBqb2JzLiBJZiB0aGUgaWJfZGV2aWNlIHBlcnNpc3RzIGFu
ZCB0aGUgZHJpdmVyDQogICByZWNyZWF0ZXMgZmlybXdhcmUgcmVzb3VyY2VzIGFmdGVyIHJlY292
ZXJ5LCByYXcgdmVyYnMgdXNlcnMgY2FuDQogICByZXN1bWUgd2l0aG91dCBmdWxsIHRlYXJkb3du
LCBhbmQgUkRNQS1DTSB1c2VycyBnZXQgdGhlIHNhbWUNCiAgIGRpc2Nvbm5lY3QvcmVjb25uZWN0
IGJlaGF2aW9yIHRoZXkgaGF2ZSB0b2RheS4NCg0KVGhhbmtzLA0KTG9uZw0K

