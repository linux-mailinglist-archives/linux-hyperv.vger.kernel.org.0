Return-Path: <linux-hyperv+bounces-9168-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kPDlEQQ9q2n7bQEAu9opvQ
	(envelope-from <linux-hyperv+bounces-9168-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Fri, 06 Mar 2026 21:45:56 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D23E2279B9
	for <lists+linux-hyperv@lfdr.de>; Fri, 06 Mar 2026 21:45:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F3D9C3068F39
	for <lists+linux-hyperv@lfdr.de>; Fri,  6 Mar 2026 20:45:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A72BC48164C;
	Fri,  6 Mar 2026 20:45:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="BFvmurmk"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11022079.outbound.protection.outlook.com [52.101.43.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 576D5481641;
	Fri,  6 Mar 2026 20:45:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.79
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772829932; cv=fail; b=EJuhAbHWWEk+Bkq1xwwsXe7BeqHoIPM+shqV/E6QFKfTgtaT0QSHJ1OyOS+pkIEAOZHrwr6SkKcwctCygCx2bSPXaRctYvq9Zo4jtF7Z/Julj1KC1UngwaSufqSnnr429henCd+U39DAos5ij8D953zP8n8dfeIHZrdxVwXQOic=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772829932; c=relaxed/simple;
	bh=ow16MWFSXLU7gGnaVB5pcHxS+eEIq41+5kisFOd2SS4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=HVTAW5UwLR624GV9p9a7tyRNHHGAz5P7Y7lVARGPCcBQnpp7s8ZF1+QEFYGV+anbuPy8kRYCw25UQvg+AwaUf6loyZmcW2hTTrjjs5DEtPrr3Wij3xY4Iu7J05IoYsmOkJrlLVe/DCNezrM5wboWXr6OSb9YgI+QlM5fDbKGjdM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com; spf=pass smtp.mailfrom=microsoft.com; dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b=BFvmurmk; arc=fail smtp.client-ip=52.101.43.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microsoft.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MbZcsIDpe2tBeG4+qegzZZO+GWd4h2bFWWC83QzewA4wdIj9bAIbHKmRFeoff57eacpvwHW+Rkp9xuDKSjTcf2Lh8tbAAI/dbc+VvSBzrNewesFrlv2rluJ+TEKOYoXqu47ptOH7iTxfmo/aXX8NxsjvCdNuhHwS058yrTVa/SFhXRNROuiGx7vciPtSa1vEVnePUirHibGekR1COo9ghkaXyBDx0Nn3QBVovpEDdbh8LTJ/OwfgET3KWlcsdWOJJRi5qPLV+phdM2tmYotC8N0fJfHem1DFQ2A9N4+wj1gpmA7Rx7jjn06QWdYTZUTpzL/cwkMzrHl0SOZVQ39l6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2l0OiZmT9Qns6yzQuMhCI11OM3e9gHK3oKI0kdLC1r4=;
 b=P4TOYI0aA3IHjY+SeStlhySa8evONk/nuwlWQDWJufzWplfov9BkA8Rwn+BjqCzuup/wrKLBZiwPcUgoR6F7qVZsH5MsinILZu0ovT+L6++kTReLF6M+GBw1cc2t55A/eA8UDesN/98Yu6A50KaHyhjFsU2VgLleisXt+4rNnxZbrQhk6jMoMRWbbJ7pRKKv73ZD0d6DRefuv1iVsF3dYNCSZ+5bkjJALjHAlRg3gvUx+Faff/xX4gui8vwSKk5NYcDqxWm7mFxeUSG9DoslWkBT1sm+auiUgrWT7wR8gNYfVynUT32XY061SSa7NJcoKrIF+126Hcf1/TB3qgOV3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2l0OiZmT9Qns6yzQuMhCI11OM3e9gHK3oKI0kdLC1r4=;
 b=BFvmurmkfFkaYWZakG6xjypohAsFxuAeuglboLr0hEbYZSjGGO/x2qfnb69uHFXG9+UVZ6sfX2aYLqh3/nVgeQcV/z/E7jivtw2a+xdkSJBpswqyGuSlRdlcnyYrBnSawUllxsFYBxEhzZdfOvss0BcMhQTdwfqcfKQytFJxhT4=
Received: from SA1PR21MB6683.namprd21.prod.outlook.com (2603:10b6:806:4a4::6)
 by SA1PR21MB6609.namprd21.prod.outlook.com (2603:10b6:806:4ab::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.4; Fri, 6 Mar
 2026 20:45:28 +0000
Received: from SA1PR21MB6683.namprd21.prod.outlook.com
 ([fe80::879f:eec1:ca0e:d219]) by SA1PR21MB6683.namprd21.prod.outlook.com
 ([fe80::879f:eec1:ca0e:d219%3]) with mapi id 15.20.9700.003; Fri, 6 Mar 2026
 20:45:31 +0000
From: Long Li <longli@microsoft.com>
To: Simon Horman <horms@kernel.org>
CC: "davem@davemloft.net" <davem@davemloft.net>, "edumazet@google.com"
	<edumazet@google.com>, Haiyang Zhang <haiyangz@microsoft.com>,
	"linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"kuba@kernel.org" <kuba@kernel.org>, "wei.liu@kernel.org"
	<wei.liu@kernel.org>, "shradhagupta@linux.microsoft.com"
	<shradhagupta@linux.microsoft.com>, "pabeni@redhat.com" <pabeni@redhat.com>,
	Konstantin Taranov <kotaranov@microsoft.com>,
	"schakrabarti@linux.microsoft.com" <schakrabarti@linux.microsoft.com>,
	"erick.archer@outlook.com" <erick.archer@outlook.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, KY Srinivasan
	<kys@microsoft.com>, Dexuan Cui <DECUI@microsoft.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: RE: [EXTERNAL] Re: [v2,net-next,1/6] net: mana: Create separate EQs
 for each vPort
Thread-Topic: [EXTERNAL] Re: [v2,net-next,1/6] net: mana: Create separate EQs
 for each vPort
Thread-Index: AQHcrYN/u6GUinjubEOWc/e/2ACdAbWh9ndA
Date: Fri, 6 Mar 2026 20:45:31 +0000
Message-ID:
 <SA1PR21MB66835ECED7F9A8F195BD18F2CE7AA@SA1PR21MB6683.namprd21.prod.outlook.com>
References: <20260304000017.333312-2-longli@microsoft.com>
 <20260306160820.525640-1-horms@kernel.org>
In-Reply-To: <20260306160820.525640-1-horms@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=3041ac6f-ab36-4265-8468-1fe110caa59d;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2026-03-06T20:35:19Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Tag=10,
 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR21MB6683:EE_|SA1PR21MB6609:EE_
x-ms-office365-filtering-correlation-id: 517cc537-1730-4cd7-30b3-08de7bc14f01
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|7416014|366016|376014|38070700021;
x-microsoft-antispam-message-info:
 VwL4xTuLIFH3R19pZypA1U3OgI6KghAVt9mmw3Zz1OCm+Fq8pBTQhi8fyJYs8v+KKFmTG6aT8hgNMEMlrlDmwALKI7parlqlYW6oIyvITyEKBwgrAQA5FrviNYY7Yr0VTpa2aiziJbMgZcWPsqBZWc8twrAKAlgWEEquSGzuSEK/4fWAHuYC04OjhlFXn+qdNh4oyPQBBHbyfA6jVIyOH5HR/FRo9RopU0vrCwiKmR/H7ShKFrxMloO4CDFmyiIUovPXMjml1aqMXPycbGvAjJCOnyk5+Elb1rnm6VP1W4VUeR1NNmf1RJE0LvchGv3KHLjRnvjN1gcnnpHCFMEW2gle3UBh5sfQRXXGZNdMr2kgi5odulnJx3E2LfE1jlj+mLbCVs4ESotBW7PcDDZiH5ZB2XZWWrh7ci0BMC+OMvtZYMXMh0SNj4MoM3SGypbg4ldt40ANwS0gJ4Wzlw9m50P5RpE0iLyvSdZDg3TD7TTyjfRpnY+cf0GGubZZ8QnDZta3bN6IaBopoiDZcYzxuEasqoeJMJgg9gAclSyojrHY2dK4oLZ/DRb1IBam+52DJKZN/4LuqkR75q9lBGtDn/7fALPeFKtdUJV1T4+EoXsWFgt36cnQE/aiAZgZoOjtk3dPesMayzWAfnn/GFujK/bJ7xoqWsGQFeZTacoALlQYvjsIk85QThkYy4dfEmyvsRCSJRYXI2ZIwVzh+CCJXTqsIUS4l4uVEywO/sRfuixlp7TaDTQ/Gu4A21SZqwUVI4wsNq6VE7nfdEzaB1AWEuFpaI3FeItW8h0Snn53yrk=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR21MB6683.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(366016)(376014)(38070700021);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?1mifVLuuGfmRUc8F7wGlUW6Ni8aK9rsy9HAKg+2SO7vDMHt2pRfd2b4dNVss?=
 =?us-ascii?Q?yWF0roFULmTHBBQ9u3biZL/4DYjbxacKFUJdEZsK3j/FRILT+fyCTTPEFpM0?=
 =?us-ascii?Q?hQSYKrm/Dh82TxF62xRHX7DHesM6eLRitQAu62E8smkjaXWXqqY8NAvvifDZ?=
 =?us-ascii?Q?Po11FAkxe550Ikwwm1/56SnpPW1K6a7/WDF9p9y9iT2ATC9c6hKZZsuG4rjT?=
 =?us-ascii?Q?KPNPNZsAnveQXElxlfNIXlJFwhCXKY6tfPXpgorFPdR2Svorv4SJvl3riPOw?=
 =?us-ascii?Q?E5FHO+1u1dCrTGVjrEehoAaA7QmWgeLnROAM1qFfTWtkXtucOGP8WnxJMRhf?=
 =?us-ascii?Q?gLbDDx6CU0IXKA4seQ9LiPhuseJzraAR1LipI2Hj7VaJWxmO0HgNeeRn5kR3?=
 =?us-ascii?Q?6ZCq36J8NHTFQ1FqU/ebB90+XVAGuP6Z+9octCdYIgE4S/NsIV3eER2M7yf1?=
 =?us-ascii?Q?VTk86POY0IR60j7rLCZlQxZRvXTUlkL6OGPaaUg8igdTvo+iouo8LP7wy5lg?=
 =?us-ascii?Q?XDUzbELO53cqicCOWvKLPvwe1gQ6/64lpvadsMAPmHBSY6pqP/eQUbebwLFx?=
 =?us-ascii?Q?TpdYpMPrOX62+OEBXlpZ4+3uge0iafvfImbe9NwgZaIa8i3+IYUM0nHYigUs?=
 =?us-ascii?Q?KyJUrsyf0JLxp+4Q012g+BzJLFCIL3ypyaU9gNHWAyf6miSl69EAFQJgDIAj?=
 =?us-ascii?Q?mh1OMPqgesJFsUkTzdD8cLP2j6QBhLPqUH8oVr4NSLmI1OHNlJI2seUDcAL6?=
 =?us-ascii?Q?dqALTLd6WKwPgJAniy63o79uouPzM9rs5ZE2N7L7K2D50CLIuv4jnvG8lMRL?=
 =?us-ascii?Q?clEYdRz//0gzXN8iu7lmXomXejKBKQQQEEXmnmbg7wx+RV/brK9e9C992XGn?=
 =?us-ascii?Q?mL4+ikS9a3pXKvhHSrJZwVzkhEMkbFGDI/y40uMceu/iC4wkdwrYxpxgMmEm?=
 =?us-ascii?Q?cCzgt+wYE8eyC7TJVu7EVw4oos98WYBdLq1KOsoq1smQVSkoOknPSvsuwivd?=
 =?us-ascii?Q?4tBmjnoVi0KfHgsaaINwUrA9RxXDwsiB0e536q/HJr8FxSxG4Ae3jXxKS+cD?=
 =?us-ascii?Q?ZB2C0EAYXMF+GOwVBsuoswjQCwFl/ZqQrWKyHTaeWe5H+D6yDyCJmVniGyT0?=
 =?us-ascii?Q?Q4D4GjRezE0xlHkBHj3+1WiAFwirv/7gDHqHq/Rn8OxhWukUoCZYpYijv8tK?=
 =?us-ascii?Q?NwUzYqzuGeM+upqeoAThuSGzX92T29AqCl+/f3i7KsiC6ypVWXcuTzcGuRy0?=
 =?us-ascii?Q?GzSKRQLeOe8sQ46wsvSb1GzXEvcI4g99cZJ7QzNIKTmqXEfGpS+kwDAYgTqf?=
 =?us-ascii?Q?QMeNpb7quDYW6xEg4FOqzlbGNJaJIS1lcKwKOYFb2qiHxmOtZJXhB6Zb64Ba?=
 =?us-ascii?Q?fB+dEWoGdLKbZPfCyAe8PegzgUJYuP+rM/x+7cxlGPsK6F+yS6nXOj8cwHAv?=
 =?us-ascii?Q?IsL+R7QX0jreKIhHpEHiq3kY4KiSHUf7UP5HerFdFSH38QIxji4XtzyLEvQk?=
 =?us-ascii?Q?j1nnln7NYko3AyLI1Ia1xgn9hhtkjX575K7PzLstw7cJvp6uGzgenLR6zck0?=
 =?us-ascii?Q?Sna0vN5HzQ/SJTYFzt9yswgEFcdb6KQkJvDuPwldaWEHVMr+t4di25HPgMBx?=
 =?us-ascii?Q?06lprUhJeXxpnBmmv4nH5HSdk836saxtfSeCwpCToQmZ0bi3lXLpPbALunmq?=
 =?us-ascii?Q?8tx9U6LEmrhqfTSDUmEeKeuJ5ngP8gOev0hHV5hqQ2GX1d5C?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 517cc537-1730-4cd7-30b3-08de7bc14f01
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Mar 2026 20:45:31.7388
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: iK4zbNRN3s6url50bNVB+NnwanbzPSl85Qiw3+WFuLU/50gTf1CHousyxomUPOyYDsFe9TfKCpS4mnyfMASkkg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR21MB6609
X-Rspamd-Queue-Id: 9D23E2279B9
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[microsoft.com,reject];
	R_DKIM_ALLOW(-0.20)[microsoft.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[davemloft.net,google.com,microsoft.com,vger.kernel.org,kernel.org,linux.microsoft.com,redhat.com,outlook.com];
	TAGGED_FROM(0.00)[bounces-9168-lists,linux-hyperv=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[microsoft.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[longli@microsoft.com,linux-hyperv@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-hyperv];
	NEURAL_HAM(-0.00)[-0.980];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[outlook.com:url,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

> Subject: [EXTERNAL] Re: [v2,net-next,1/6] net: mana: Create separate EQs =
for
> each vPort
>=20
> This is an AI-generated review of your patch. The human sending this emai=
l has
> considered the AI review valid, or at least plausible.
>=20
> For local reproduction steps see
> https://nam06.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fnetde=
v-
> ai.bots.linux.dev%2Fai-
> local.html&data=3D05%7C02%7Clongli%40microsoft.com%7C070979f149574e63
> e15a08de7b9aa19e%7C72f988bf86f141af91ab2d7cd011db47%7C1%7C0%7C6
> 39084101208945710%7CUnknown%7CTWFpbGZsb3d8eyJFbXB0eU1hcGkiOnR
> ydWUsIlYiOiIwLjAuMDAwMCIsIlAiOiJXaW4zMiIsIkFOIjoiTWFpbCIsIldUIjoyfQ%3
> D%3D%7C0%7C%7C%7C&sdata=3DCs%2BZwNguYa8FGbpb4H0naVDhDzhjzBvDU7
> 5aZekerzc%3D&reserved=3D0
> ---
> net: mana: Create separate EQs for each vPort
>=20
> To prepare for assigning vPorts to dedicated MSI-X vectors, this commit
> removes EQ sharing among vPorts and creates dedicated EQs for each vPort.
> The EQ definition is moved from struct mana_context to struct
> mana_port_context and related support functions are updated.
>=20
> > diff --git a/include/net/mana/mana.h b/include/net/mana/mana.h
> > --- a/include/net/mana/mana.h
> > +++ b/include/net/mana/mana.h
>=20
> [ ... ]
>=20
> > @@ -499,6 +497,9 @@ struct mana_port_context {
> >
> >  	u8 mac_addr[ETH_ALEN];
> >
> > +	struct mana_eq *eqs;
> > +	struct dentry *mana_eqs_debugfs;
> > +
> >  	enum TRI_STATE rss_state;
> >
> >  	mana_handle_t default_rxobj;
>=20
> [ ... ]
>=20
> > diff --git a/drivers/infiniband/hw/mana/qp.c
> > b/drivers/infiniband/hw/mana/qp.c
> > --- a/drivers/infiniband/hw/mana/qp.c
> > +++ b/drivers/infiniband/hw/mana/qp.c
> > @@ -188,7 +188,7 @@ struct mana_obj_spec cq_spec =3D {};
> >  		cq_spec.gdma_region =3D cq->queue.gdma_region;
> >  		cq_spec.queue_size =3D cq->cqe * COMP_ENTRY_SIZE;
> >  		cq_spec.modr_ctx_id =3D 0;
> > -		eq =3D &mpc->ac->eqs[cq->comp_vector];
> > +		eq =3D &mpc->eqs[cq->comp_vector % mpc->num_queues];
>                            ^^^^^^^
> >  		cq_spec.attached_eq =3D eq->eq->id;
>=20
> Can mpc->eqs be NULL here? Looking at the initialization paths:
>=20
> Before this patch, mpc->ac->eqs was allocated during mana_probe() and was
> always non-NULL after driver initialization.
>=20
> After this patch, mpc->eqs is only allocated in two places:
> 1. mana_alloc_queues() - called when the Ethernet interface is brought up=
 2.
> mana_ib_cfg_vport() - called when RDMA RAW QPs configure the vport
>=20
> However, mana_ib_create_qp_rss() doesn't call mana_ib_cfg_vport(). If an =
RSS
> QP is created via RDMA verbs before the Ethernet port is brought up and
> before any RAW QP has configured the vport, mpc->eqs would still be NULL.
>=20
> Computing &mpc->eqs[cq->comp_vector % mpc->num_queues] from a NULL
> pointer produces an invalid address, and the subsequent dereference eq->e=
q-
> >id would crash the kernel.
>=20
> Should there be a NULL check here, or should mana_ib_create_qp_rss() ensu=
re
> EQs are created before reaching this point?

I'm fixing it in v3.

Thank you,
Long


