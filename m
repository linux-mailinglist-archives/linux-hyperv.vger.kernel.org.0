Return-Path: <linux-hyperv+bounces-9091-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CAwDOWu9pWn8FQAAu9opvQ
	(envelope-from <linux-hyperv+bounces-9091-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Mon, 02 Mar 2026 17:40:11 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 888BE1DD0D8
	for <lists+linux-hyperv@lfdr.de>; Mon, 02 Mar 2026 17:40:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 096843032043
	for <lists+linux-hyperv@lfdr.de>; Mon,  2 Mar 2026 16:38:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 355C74219F1;
	Mon,  2 Mar 2026 16:38:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="h1IdLLjh"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11020073.outbound.protection.outlook.com [52.101.56.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDE1712B94;
	Mon,  2 Mar 2026 16:38:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.73
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772469515; cv=fail; b=RMouayb9WiU3ur5+RxpJv58pPYbAmF/1Z70l//9TWNcwbZPwGayNUOkBoJKW3+FXDGX80KLdeS/N+5aPe4PkE0Y4FLserIfFoMDF8RAJNMdhRsnlm0CqgssV3F2g2iMObshO1/PJQ0DBNYMvWkKJmapzv2R1UzKSWHDZrZ1GhlM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772469515; c=relaxed/simple;
	bh=6RokbGdvWpa+YTRLO7TVz0weCH9yp0EW3sWonBnuEAo=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=lfE5qmSbMB5wAmaG+HhY6tN8h0CR2jlhFBIkVoXgTVJsSp/2Hq90ePEDcxueWdKeUTx9qkOmGmcfsSxywea7ymjlxcd5Mjp9yLvDUJIxu53JDbf/8djU7SjZrI5MtXwl6GKqKmuGDqe1bqm0deTRObhsq93rIvTKl++HugTvgdg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com; spf=pass smtp.mailfrom=microsoft.com; dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b=h1IdLLjh; arc=fail smtp.client-ip=52.101.56.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microsoft.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RZc7vMDtbHkcZVenXgu/3g4eNMkuOEPjcDHFedeFWjMqIS3XSVqThwHUfwTm/goleoblRMaB/6LeYvVkerjSYjKptuqbWV2aFXmuCkaWDIzSYdkztGrvggjPRvR+HTr6uyzyz9yVP7SnXN6KVWCRljqvjXItFzRVt4lRc4+SXn99HXU6QrtVTvsgG9hdU86gYjvja6nXgueuPeOTacTRuNkDjgyvWspPr19dfGocoO0JL99/5kOvsyAU/+cKa9K04RL6YyzE6nNeQP00vQJfYEkl5/YUYer6791byJoUVXT+wY7GSgnj3EFYjLZO44hl6PJuEODvvr41CGXKg38cFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jT9jxC9Eu71JqOjnCNMnfti3qhP8k7faMWbLPEvfNrw=;
 b=ad7vSrHR4Xt8wICGSqky7QqHDHEWwL2azp2IualeCwTEmVWMYgdIUObQ9LSb1YmfTP9bLytsCMsAafQID/J7m/KJu1mXW1UxO56zMvIleOLQm+QeCilzcdzMUaTelTOVRlDQl4uPoOtSeBlrAFNc9NALXFjSYKigksdPT6c8H3cD1ZW6ILeOrSZqG46yujUmK8LSoMDGV9RYzj31oL6R0A09c0Rk2dlWKQp4+FeSnLcT+/RwXUsybX3gtBp1f2SYauOYHiHu94khYT9guV7Jz5EBE3JHBwnWOgX28RbXgtGT80wHLutF2j8HbyuCRVnoHN9kG5IKOkmnIWI3yf9mnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jT9jxC9Eu71JqOjnCNMnfti3qhP8k7faMWbLPEvfNrw=;
 b=h1IdLLjhKdSK7STI8NKBcCN12LWeV9gKU1HwJP7TUNDwM9wOaHpotEMglCEgzEO04MTat5CB0dGaPYy+jU5UwA8dq8OJ+tkABZQdCKAd7oxdNFXp92U0nbEoIgWXHMlUYCCCG3JNU+zAw2t55cK6tg41j2tnXFdXCI8SbvTPPCs=
Received: from SA3PR21MB3867.namprd21.prod.outlook.com (2603:10b6:806:2fc::15)
 by LV0PR21MB6597.namprd21.prod.outlook.com (2603:10b6:408:338::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9678.9; Mon, 2 Mar
 2026 16:38:30 +0000
Received: from SA3PR21MB3867.namprd21.prod.outlook.com
 ([fe80::70ff:4d3:2cb6:92a3]) by SA3PR21MB3867.namprd21.prod.outlook.com
 ([fe80::70ff:4d3:2cb6:92a3%6]) with mapi id 15.20.9678.009; Mon, 2 Mar 2026
 16:38:30 +0000
From: Haiyang Zhang <haiyangz@microsoft.com>
To: Dipayaan Roy <dipayanroy@linux.microsoft.com>, KY Srinivasan
	<kys@microsoft.com>, "wei.liu@kernel.org" <wei.liu@kernel.org>, Dexuan Cui
	<DECUI@microsoft.com>, "andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>,
	"davem@davemloft.net" <davem@davemloft.net>, "edumazet@google.com"
	<edumazet@google.com>, "kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>, "leon@kernel.org" <leon@kernel.org>,
	Long Li <longli@microsoft.com>, Konstantin Taranov <kotaranov@microsoft.com>,
	"horms@kernel.org" <horms@kernel.org>, "shradhagupta@linux.microsoft.com"
	<shradhagupta@linux.microsoft.com>, "ssengar@linux.microsoft.com"
	<ssengar@linux.microsoft.com>, "ernis@linux.microsoft.com"
	<ernis@linux.microsoft.com>, Shiraz Saleem <shirazsaleem@microsoft.com>,
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>, Dipayaan Roy
	<dipayanroy@microsoft.com>
Subject: RE: [PATCH net-next] net: mana: Force full-page RX buffers for 4K
 page size on specific systems.
Thread-Topic: [PATCH net-next] net: mana: Force full-page RX buffers for 4K
 page size on specific systems.
Thread-Index: AQHcp9H4wCTe+Gu2bUGZgZ0a5XoGnLWbdgnw
Date: Mon, 2 Mar 2026 16:38:30 +0000
Message-ID:
 <SA3PR21MB3867F70563A30975A6CB5FDACA7EA@SA3PR21MB3867.namprd21.prod.outlook.com>
References:
 <aaFusIxdbVkUqIpd@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
In-Reply-To:
 <aaFusIxdbVkUqIpd@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=52b16135-4a6a-4a8f-9985-b7a647e444f7;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2026-03-02T16:37:19Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Tag=10,
 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA3PR21MB3867:EE_|LV0PR21MB6597:EE_
x-ms-office365-filtering-correlation-id: 289aca05-331f-44b3-9c9f-08de787a2319
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|7416014|376014|366016|7053199007|921020|38070700021;
x-microsoft-antispam-message-info:
 LUBjasQ8Jd5Ftx/JJpPumaNGtNp1hajoJyuXkxEmnDkbnIVs0jJOkPzZWuy5MkVNmjpMT46iKtRR21GKClacwG/XyK57LWImaga56l+XO9e7zBbJcXsTESf+XjPhIpYekA6k4Thmcge7AUR8MDwF+J6Vh4z2i0LrmgSaNUP+nFmd8QWavN99fOm8DCPrW8AOKY2qm6vgQg9igYRooA48ymh+K/ozWB01uVbC3ivvFjKNI8b13XMsNYtstRjO7DsmkkghEz3BD1nzQfxDYtORqdZlCzHFGom8pJjOqjtLpA4ECgWUlLEjwsUS7uj9TfUjardfhmzvUg1m1t0wVN3c2bYnFgYHRuywgxOfWNVpQ1td8p+HShdk5/JfGIjwW0NK3adkbL9MEvcEe4+4V3CJ9ebaGNPYReV2E9ofrsS68n0Je8+8cKT2fdMYX1o8N+wt6kJ499D66TIuqCTkm9fwP6PMne3wSI5MFSb52PMBoY5NY0Mu0+6SZZLFHoVlfAhJOt/E99o7c5YJjV76xS8oaryrktC+978tvNU0dZ9zcQvcqc7eutzplCjbHTGru5fyYTzHv44SXLMfou662tOyLR4mkX3WBw4o9CVdm5CaaKy3uNSNZBpYyzIU4DwzX3MhXl0vHZSrNKFtXnFzXZh3INTkayku3SvOMjEJzK+CU5Ee9uWC+PIAnyVK7EZeWk8Tu3XELnJ73ZF+MRYCgItFQA9g1TzDVcGdY4I0t1Co1bMFn/WlsGlaqDE3yecEtwPUND6NaX53ZHgBPuXp5MnCCGXmmOvq7JwhHDQVA0JNua1QedFWCp9RPRxOIKoUckdc
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR21MB3867.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(7053199007)(921020)(38070700021);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?bxtQbgX7uX65MnyREqFCsov6+ZFXo27JuhVqocXe2t0paCXkr/kZWiYxbyH+?=
 =?us-ascii?Q?Ht/eej8Ay7wbBku3Vqt089FZs8xQhxdq6Hvke3Di32lW3n+A6ovmuNGjenvW?=
 =?us-ascii?Q?JgGKTl0mpjacGHGKjtUjn931DxhNGLBJUUjGvFCUdg7Bzkhd/3RpDJql4NJD?=
 =?us-ascii?Q?T+iRQ/eiHsLe8/67hWtt4qDAfHfqM4Fc5wHofTMi6wNxO7rAyY/E7MwCoodA?=
 =?us-ascii?Q?wU9kyVRweO5S12okFEJ4HE8NuGomwlEqmYCM5e00e8rSrhnBktAy7yaqsUB6?=
 =?us-ascii?Q?LEWnIjnkpdYMf7hT5NGlfMAS/gHCtbrXpLGSd86wp+tgBKWl7jTncRpmV2cI?=
 =?us-ascii?Q?na4QaTlFQbXb+XMLgOmpMjExqGOddkXUWzeSVJT3cVd0KP6ZK+wjAFEatOM0?=
 =?us-ascii?Q?H375g9XMAboQEj658w6qxClCgc5fniVzwM5zzi/z8kD8nRL3K82iQ+R5BmLb?=
 =?us-ascii?Q?QsTjZOBnmVtqqIO8EHHa9fthhLcfAzT2Wr/qjdM0y3SFet78lsOIhDjXYaYM?=
 =?us-ascii?Q?pDAK+p+4NTpfx3TCd1KHWbiudCr8LlvDwHl9bZ2bGNsQJdrP8CfsO6J3TrRS?=
 =?us-ascii?Q?f2vYwHR4vWc1/l9/j0unv/YLn4HzGGZWQbckambmuSZJSDCyez1sZ9n1SU9s?=
 =?us-ascii?Q?ObGNRusbsv3jawNo5Kf+U5L4hG4g6uCoStlwY+L7xXoV8XogIK9+yXVFwfyY?=
 =?us-ascii?Q?zgkb0oFmvKlvl67zONnCZ3Nj54imjdgwEzOMGEmbfWsiO9UvBSAj25RC1xlK?=
 =?us-ascii?Q?xxSp7GlnkOCRln8+ZIKQ5cG1MEAVJugHX1ddDJ7Uq6GiSxuqrXbElGqRNhqD?=
 =?us-ascii?Q?MZGTI0Y0QBrDEMx/QAevhxlbIwnC2+n5ir6SNGntZlD4pUxmMcgFshyHeIlZ?=
 =?us-ascii?Q?2oYgRxvoAF4IBdOwWO3ed23g1w2gdo55GPTB8/7lT1dwh4xktbXELeuJZK4P?=
 =?us-ascii?Q?8kRWbZow9HmzOpM/BZEmtmduCUeuI0HPX7CHvZMt1I4uQsKaJCbiIpv5ZZJU?=
 =?us-ascii?Q?aGWGkGQq2BFnIOflXHJCcJkkQPEhoMLgeatLO75Ad2kITjcbmXTDoSsh6YCy?=
 =?us-ascii?Q?kn1juXbB5Vtu5g1qxyl9lJLkM6yK99G+erSY4a6IWY6m3ig3NWQxUFRmIJJ8?=
 =?us-ascii?Q?ZsAPys4ZxYw3vkt6q+W65qTdD2hRGnBhdenow7x1g0TxZAfV1SqjmrG6T25Z?=
 =?us-ascii?Q?15+siUs9EsKaeIVYUWB4kLALawReTSSAvP/4/0nLd5z6Cqz7HneN5G7CY9cd?=
 =?us-ascii?Q?XZbUiI62nIN9ie2z5E+bAGXtOvVXdEGsc/Obf8uOabT/tD0wjxO2Ozd1gBma?=
 =?us-ascii?Q?W5obWQUbVYq8byOsf6vHEz/NMp847qxxnUTYWUKLUXwJBd9Q8Z21PfOBtYZJ?=
 =?us-ascii?Q?yPZvkGwgYjs1vAfZGK6KyuV9LBCqflv12fqVgaj0QMb9cTGclKrFhL/52qOj?=
 =?us-ascii?Q?3PEaPKUAFI3yiMOYdLic7k6BBLSbbK897pwJXUPfeeodzgzxPajvX7BEj8eS?=
 =?us-ascii?Q?g9AtdG0cy6UJz0LJ3zmFUw+XshCIOby/DqkIIBnd9lHfJ4IeCQmEW4kmFofR?=
 =?us-ascii?Q?ywJ6JhuXVNkQ/noHHaxLQbvX8yrI/KgVUMNoTFdu7F67+nXxo/a9AwAgTQLG?=
 =?us-ascii?Q?mkb84Ek7GN+0RTPZmihhlLwIBFxE70l4oua+faaUz2PIg/y/YzPVOOLgDk1+?=
 =?us-ascii?Q?cpOm5pcoU85uokNoGZW7kgaEbA2tey7NljY7qe3SjRZqI5VOm2BOZCrnXgDA?=
 =?us-ascii?Q?YI5BKFPGAQ=3D=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 289aca05-331f-44b3-9c9f-08de787a2319
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Mar 2026 16:38:30.2792
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pJVUAjyrfMSHgegCMXtqDocmn33ffpmJrydsxysvmAqyksn1/K7yAJOWdXT6jDP7+tDgB8M7Zjj9Y33rL80XvQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV0PR21MB6597
X-Rspamd-Queue-Id: 888BE1DD0D8
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[microsoft.com,reject];
	R_DKIM_ALLOW(-0.20)[microsoft.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-9091-lists,linux-hyperv=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[microsoft.com:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[22];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[haiyangz@microsoft.com,linux-hyperv@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-hyperv,netdev];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TO_DN_SOME(0.00)[]
X-Rspamd-Action: no action



> -----Original Message-----
> From: Dipayaan Roy <dipayanroy@linux.microsoft.com>
> Sent: Friday, February 27, 2026 5:15 AM
> To: KY Srinivasan <kys@microsoft.com>; Haiyang Zhang
> <haiyangz@microsoft.com>; wei.liu@kernel.org; Dexuan Cui
> <DECUI@microsoft.com>; andrew+netdev@lunn.ch; davem@davemloft.net;
> edumazet@google.com; kuba@kernel.org; pabeni@redhat.com; leon@kernel.org;
> Long Li <longli@microsoft.com>; Konstantin Taranov
> <kotaranov@microsoft.com>; horms@kernel.org;
> shradhagupta@linux.microsoft.com; ssengar@linux.microsoft.com;
> ernis@linux.microsoft.com; Shiraz Saleem <shirazsaleem@microsoft.com>;
> linux-hyperv@vger.kernel.org; netdev@vger.kernel.org; linux-
> kernel@vger.kernel.org; linux-rdma@vger.kernel.org; Dipayaan Roy
> <dipayanroy@microsoft.com>
> Subject: [PATCH net-next] net: mana: Force full-page RX buffers for 4K
> page size on specific systems.
>=20
> On certain systems configured with 4K PAGE_SIZE, utilizing page_pool
> fragments for RX buffers results in a significant throughput regression.
> Profiling reveals that this regression correlates with high overhead in
> the
> fragment allocation and reference counting paths on these specific
> platforms, rendering the multi-buffer-per-page strategy counterproductive=
.
>=20
> To mitigate this, bypass the page_pool fragment path and force a single R=
X
> packet per page allocation when all the following conditions are met:
>   1. The system is configured with a 4K PAGE_SIZE.
>   2. A processor-specific quirk is detected via SMBIOS Type 4 data.
>=20
> This approach restores expected line-rate performance by ensuring
> predictable RX refill behavior on affected hardware.
>=20
> There is no behavioral change for systems using larger page sizes
> (16K/64K), or platforms where this processor-specific quirk do not
> apply.
>=20
> Signed-off-by: Dipayaan Roy <dipayanroy@linux.microsoft.com>

Reviewed-by: Haiyang Zhang <haiyangz@microsoft.com>
Thanks.


