Return-Path: <linux-hyperv+bounces-11708-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id FB1XAkfiQmq4GgoAu9opvQ
	(envelope-from <linux-hyperv+bounces-11708-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Mon, 29 Jun 2026 23:23:19 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E5236DEDC2
	for <lists+linux-hyperv@lfdr.de>; Mon, 29 Jun 2026 23:23:18 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=microsoft.com header.s=selector2 header.b=GkyIo5Km;
	spf=pass (mail.lfdr.de: domain of "linux-hyperv+bounces-11708-lists+linux-hyperv=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-hyperv+bounces-11708-lists+linux-hyperv=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=microsoft.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0B36A30097FA
	for <lists+linux-hyperv@lfdr.de>; Mon, 29 Jun 2026 21:23:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A00F53B19AB;
	Mon, 29 Jun 2026 21:23:16 +0000 (UTC)
X-Original-To: linux-hyperv@vger.kernel.org
Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11020092.outbound.protection.outlook.com [52.101.61.92])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B24D383339;
	Mon, 29 Jun 2026 21:23:14 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782768196; cv=fail; b=a0UEUjQvKrRt+P7Iuw0wHLLlErjBxeswKDTLsLZsZVfBV0m72Y7KcBZ8ndF7No+qLf/TbW4PI/MMw80sC70RyaldaduZjSQNur2qr+xymtr66ozpAaxMQ0h48U3kjIsoBAf2Fthibz04gmeTZiKBQ9DaIhu535zm5W71tNAyBH8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782768196; c=relaxed/simple;
	bh=hmXSYoui6aEzqEM1Px8nDm9cHpLCH4/gD0sXp5VZK6Q=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=OHFJd68YkyCzeUxZBv0R2vw4QItQRBMoSY38jbsG+QRD16ZrjaGAmHEJzOEocPdum+yZd/8ffZYL4wfcNJCCkapV7NDvv1GIZzJyz/I6qzcHn4GUs5e1maQ7uMmsPKXJvoQD32GnACCrEPwewqZIgIAJIXldBkMSTYZ51zj2zk8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com; spf=pass smtp.mailfrom=microsoft.com; dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b=GkyIo5Km; arc=fail smtp.client-ip=52.101.61.92
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lj7kpH5csak3vKXIYrhrf/Jt0LWSEtCqJ794a/leoNK21R8ZqEZ/zHFk+npEtNKFNUeHzKcs5lDYN3en1rPl4QQyxJlhA5BY9Rfmv5KlvP0LbcKx/jT7MSEJ1Rbzd5yitEGxluj4HVzPwXllBWjf4d9bx2mM9Z6O7ytz/6Pou8/1SXzTjM6PWPj3hqhp9G+C+P/ZcKpW9KKn+aDPvmfeSkw7THksERm7MTloziHLfOUbshEjcZFR7FTxyWFDz2PTer9n9NmKV6mghLEqZuNC6yi8offzmLTVtGjOmqBSoUz1Rx0oT4bPK6dih5/aNx0zbEkw2FhjajWuYsqH/Tkv6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hmXSYoui6aEzqEM1Px8nDm9cHpLCH4/gD0sXp5VZK6Q=;
 b=McV9As69zFLpcwNFfwbZ8d4u+op247NgCuYEKUelj12dDDce9qS+53ib5BdXFUysJFhvdrJLjTcZj6SJ2YDk6ygRhDRTEOQQk5PJMVCgbiAL6PIzky7wRRmr4SCMI2xsQ512yEewVztcD1qqGdzU/ofrzwoQoC+HSCg8VPiiCrSnhFB0Iu2iClOUUbOIxAFRLCAFF+iOYS6g+DRYxxcTa/bWgfv2/Wc6NSVWZac+YDEkPfhBhchasjdnfNXmJ0IRbINx9+21zCQb+36yd8gk40BElMC8eFtMP9qSFYdLzavfFPleoLU3QNuaMCHwpB3hoNlDcso0elZUoGO4xkdBXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hmXSYoui6aEzqEM1Px8nDm9cHpLCH4/gD0sXp5VZK6Q=;
 b=GkyIo5KmDNJYQJaybiploixBtiIwosUEekPomEJO7NRy0W93YlNE+DJcV6zVtDDub29UuADFy8GoAx02VYXiBrNASFx+n0owhi+PgiSh2wjMLnJ631TYRUsdtEeC2ak+p5AhMSR/6+D0Toyzb3QPkJ7p5rLKpH3gvlD8dFtqMzM=
Received: from SA3PR21MB3867.namprd21.prod.outlook.com (2603:10b6:806:2fc::15)
 by SA1PR21MB6249.namprd21.prod.outlook.com (2603:10b6:806:4a4::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.8; Mon, 29 Jun
 2026 21:23:12 +0000
Received: from SA3PR21MB3867.namprd21.prod.outlook.com
 ([fe80::d8ab:5f37:de73:8e6]) by SA3PR21MB3867.namprd21.prod.outlook.com
 ([fe80::d8ab:5f37:de73:8e6%5]) with mapi id 15.21.0181.008; Mon, 29 Jun 2026
 21:23:12 +0000
From: Haiyang Zhang <haiyangz@microsoft.com>
To: Jakub Kicinski <kuba@kernel.org>, Haiyang Zhang
	<haiyangz@linux.microsoft.com>
CC: "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, KY Srinivasan
	<kys@microsoft.com>, Wei Liu <wei.liu@kernel.org>, Dexuan Cui
	<DECUI@microsoft.com>, Long Li <longli@microsoft.com>, Andrew Lunn
	<andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Konstantin
 Taranov <kotaranov@microsoft.com>, Simon Horman <horms@kernel.org>, Shradha
 Gupta <shradhagupta@linux.microsoft.com>, Erni Sri Satya Vennela
	<ernis@linux.microsoft.com>, Dipayaan Roy <dipayanroy@linux.microsoft.com>,
	Aditya Garg <gargaditya@linux.microsoft.com>, Breno Leitao
	<leitao@debian.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-rdma@vger.kernel.org"
	<linux-rdma@vger.kernel.org>, Paul Rosswurm <paulros@microsoft.com>
Subject: RE: [EXTERNAL] Re: [PATCH net-next v4] net: mana: Add Interrupt
 Moderation support
Thread-Topic: [EXTERNAL] Re: [PATCH net-next v4] net: mana: Add Interrupt
 Moderation support
Thread-Index: AQHc+3d0u80ygACNHk60ldHaRw1ezbZAb0uAgBW0mcA=
Date: Mon, 29 Jun 2026 21:23:11 +0000
Message-ID:
 <SA3PR21MB38671F4EF8F9D0A6A786489CCAE82@SA3PR21MB3867.namprd21.prod.outlook.com>
References: <20260613205812.2659945-1-haiyangz@linux.microsoft.com>
 <20260615185449.6a496c1f@kernel.org>
In-Reply-To: <20260615185449.6a496c1f@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=1e680052-4390-4e56-a9b5-49fd0a098fe1;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2026-06-29T21:22:39Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Tag=10,
 3, 0, 1;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA3PR21MB3867:EE_|SA1PR21MB6249:EE_
x-ms-office365-filtering-correlation-id: e1a99436-59a0-4392-692f-08ded6249fb0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|1800799024|366016|7416014|23010399003|38070700021|6133799003|4143699003|22082099003|18002099003|56012099006|11063799006;
x-microsoft-antispam-message-info:
 jkB5hbQ7e3ixTgVc5MwQXd73mDs7eI4u5HqctfV36PHgf1pW6KucC08+YSzGN3YkKYYRG4Oq6kQQi3ocKhO109MaoEcI6ApksY0j06H0asDHomAJOsxGvr8EiUhOpDrexife3u1OHcTlV13dEOmg9tJAbXjHQ/srYHEK7AgayFIMx/LhIesT6WrTlU3jRIq3GDQ2VtDQorYzFdpwGi8C5EsTCGHGF06rfpCZqhSE0FgDpuTOvQbNOVjo/s++HmvlUdW2nsVEPaKYKxXWJQnEurLdHPaCuwjqWFLuHvVC+mD3qe+b8voC0kmP2g3R2S2bSUiIY9uGXvRH36Mp/Kmp8/ABfHKnbxlmk4ryqWvYqNQZF7vMfgp7npxkqPFrlH5n+AfHDLtull1RhGqDWtOVr9oRV7ypiBGKXMnlPWgFVRopIbWAfnqS2vaWks+A1D+KUwV3OZl0sociK6PxUReDwzPGT3THPhmXP5OAVfy8sQvE4wyQM2iNtMPSYQs/1mChk/7OMqsFutMCTbNz/azfS5IqMqCUaLe5b3reMgHo0Y7Z24RA3syKmW9+JzZWEV9vtTfnUf7VCK+pypnBUHVL/cCes1+OkFBZivKuXVEDjZMLc5Cm7cPaa2nDvOr3ZNgkQ+yWUpO+7AtVk6kyRzY48gBICns1PrD+Ywsi1fxbVp59h/ND4UA+Tbb5lagui/VQ97oL9VDgxMRrBmiqKMvr1Q==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR21MB3867.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(7416014)(23010399003)(38070700021)(6133799003)(4143699003)(22082099003)(18002099003)(56012099006)(11063799006);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?qVdmM+FmfFJo4J+QMHvNkTDhrKtTOFPO0dIKOklbLT4ScI9jBgpjvD3OCcsC?=
 =?us-ascii?Q?JjGnmPmV467hYzcPLhvtWppagbbFv5ktYC0yKgOcTI60C50X3uXt8g2E1GIi?=
 =?us-ascii?Q?dn8wlftAlBqWncVYgM2EzW9kVGGz3HVq0b+U4DO7O8uVydHtx9U0RKZYXIeF?=
 =?us-ascii?Q?L+QVJ2qb7ejYr27F+UijyysF5czGSQGEe5rTliU9Lp/rxLkkCzLMyG9NS4/g?=
 =?us-ascii?Q?2eAUlaP5+XZ1R1snUv+hNVP4QH2eTDT0uqLwChYQ7dZftc0rpzZBFiQIg+X9?=
 =?us-ascii?Q?C1XWY34IzTVjSyAYJ6cjJZiud336lRAKBj/dPMxfg/x/dWLFKwfnduS6W4uv?=
 =?us-ascii?Q?vU6PFgrUTbJkF+hKR7kq3sxBr3T5Y5o4vYUxe4TH96FeLjvuNCeLWO16+Kch?=
 =?us-ascii?Q?4PTFNScqtw6EGGV+qqAAdrD8CTZB8YFtaug6V3pg0XeTA98/micyqZ7KSwVd?=
 =?us-ascii?Q?VRFRykHKsGSwQdDxUKy00lIHaEbbMF5g1z2jk2ThYPNenXsvJfGicJEv2mk5?=
 =?us-ascii?Q?hhsdTXIBj7UN2rSWZOgDFKHALUJzwIMQrkgoRr9KTbUMPU9jhhr8vZUeZOnY?=
 =?us-ascii?Q?F5HHIRwzwHUQNmxMVom+eDiP910t2OnwHiW0CXCjvqQkqy0mOe/Sf2Im4xSy?=
 =?us-ascii?Q?8JE7H+RpLYo3F1uuoy0NFz1GJFlGqQhnkjSdGXiv+AKiaG7y5oT0lTO8MfzH?=
 =?us-ascii?Q?/PoKwJRDxo6a9WTuJcIS8tguaY2irsimOwOTGjviqM2H0y13LYLSmU61VEbc?=
 =?us-ascii?Q?k3a8BT3atEovBuufaNbAa/Uho4E+zE2O6sSX2ZZeLfJHqXSenMmw2vfhwtqc?=
 =?us-ascii?Q?Vjo2gOfBZknytydhTww8z2vY3Frn5krFiPMbp1PrOUwzHXIgShS/+mm9UlqJ?=
 =?us-ascii?Q?f6Q6EWIrxns57pPXIHDTQR2RXpUxZ1A4snaZIqnLW3Du3vEPQlKBeFdC4OOS?=
 =?us-ascii?Q?fJccHrARJ1ZAu1Tj7Q5Ctc1cusk7glsMfmlYfVoWSlbb9G+MuHDqwtA9TPO8?=
 =?us-ascii?Q?9a4TgcUEOWGwBtQzvU+/eIEJPE8j49racsO8jktc6TsyGeIDI5ly/N96WXNL?=
 =?us-ascii?Q?8CyFKM4F9atZ+W7A2VbL9i5wNiBw4REmZq5aAx4QmC27aiN7iaw7lbrh5WIb?=
 =?us-ascii?Q?xG7AlQh/3/0hanv5J0K0X22bXV6dbZVRBQfI+AnHF1XF3xBj1v/jjfmNwekF?=
 =?us-ascii?Q?Z4W/4cZijRcGfVdW4HHAsMTRL+uCVWPu6R+kMNJE2gMduZfWs5Cy7QwpJmx8?=
 =?us-ascii?Q?uJJTo2/zGBBrdqq9AamWeAei8X98ZwspvWI7+YD+/XrnwcrbA3iTFbvASTLJ?=
 =?us-ascii?Q?h6jHXnaAl4uOfUvDCk2IyjJkcGEXWP1wWMoWGV9frx50MUoW/YM8EpYLmHKg?=
 =?us-ascii?Q?N0k838hPLjog0ifBJS0F76dzWoBZzV4fxeOsU1GYox0DEW+9U/849K1o8qSo?=
 =?us-ascii?Q?n3Q2QYBlfaKUxRnhmCK84ax+Ma69LOKcRJnpPzRi/VeRMT86jeZ8tsieovhA?=
 =?us-ascii?Q?oSi0BEx2dqN3u/Ps4rTBVyYQfveEZQtwOAF+PZ5nPC1ETbCSBd9FOjOs5cgY?=
 =?us-ascii?Q?jnkzp3VbqBWiMsccHf8aAvibLb/TrpNrk1U5aqY7JcSqgIGTuot6rbDrueDr?=
 =?us-ascii?Q?VqZ7lig6bZW2qxoXs3ZCeA9j7N9AoAw7fuTGK3yX641CvBSjy1lTu4QUXnrk?=
 =?us-ascii?Q?1441t9BEKbi9cB3kvcYd0CRH4Tbayi/ym2TNeHJdwkU0fU+vp73ylubV0Ljv?=
 =?us-ascii?Q?WPFWFIEI7w=3D=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: e1a99436-59a0-4392-692f-08ded6249fb0
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jun 2026 21:23:11.8998
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VPx24k37fW5fYPTghI/SUVrTsi16qvIxrnD4PKHgiYjjJ7MFT+KnrYaIW74cv1g3NxLKH/ENTQBepTSG1TtfzQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR21MB6249
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[microsoft.com:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[microsoft.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[microsoft.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-11708-lists,linux-hyperv=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[22];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:kuba@kernel.org,m:haiyangz@linux.microsoft.com,m:linux-hyperv@vger.kernel.org,m:netdev@vger.kernel.org,m:kys@microsoft.com,m:wei.liu@kernel.org,m:DECUI@microsoft.com,m:longli@microsoft.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:pabeni@redhat.com,m:kotaranov@microsoft.com,m:horms@kernel.org,m:shradhagupta@linux.microsoft.com,m:ernis@linux.microsoft.com,m:dipayanroy@linux.microsoft.com,m:gargaditya@linux.microsoft.com,m:leitao@debian.org,m:linux-kernel@vger.kernel.org,m:linux-rdma@vger.kernel.org,m:paulros@microsoft.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[haiyangz@microsoft.com,linux-hyperv@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[haiyangz@microsoft.com,linux-hyperv@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[microsoft.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-hyperv,netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 4E5236DEDC2



> -----Original Message-----
> From: Jakub Kicinski <kuba@kernel.org>
> Sent: Monday, June 15, 2026 9:55 PM
> To: Haiyang Zhang <haiyangz@linux.microsoft.com>
> Cc: linux-hyperv@vger.kernel.org; netdev@vger.kernel.org; KY Srinivasan
> <kys@microsoft.com>; Haiyang Zhang <haiyangz@microsoft.com>; Wei Liu
> <wei.liu@kernel.org>; Dexuan Cui <DECUI@microsoft.com>; Long Li
> <longli@microsoft.com>; Andrew Lunn <andrew+netdev@lunn.ch>; David S.
> Miller <davem@davemloft.net>; Eric Dumazet <edumazet@google.com>; Paolo
> Abeni <pabeni@redhat.com>; Konstantin Taranov <kotaranov@microsoft.com>;
> Simon Horman <horms@kernel.org>; Shradha Gupta
> <shradhagupta@linux.microsoft.com>; Erni Sri Satya Vennela
> <ernis@linux.microsoft.com>; Dipayaan Roy
> <dipayanroy@linux.microsoft.com>; Aditya Garg
> <gargaditya@linux.microsoft.com>; Breno Leitao <leitao@debian.org>; linux=
-
> kernel@vger.kernel.org; linux-rdma@vger.kernel.org; Paul Rosswurm
> <paulros@microsoft.com>
> Subject: [EXTERNAL] Re: [PATCH net-next v4] net: mana: Add Interrupt
> Moderation support
>=20
> On Sat, 13 Jun 2026 13:57:54 -0700 Haiyang Zhang wrote:
> > Add Static and Dynamic Interrupt Moderation (DIM) support for
> > Rx and Tx.
> > Update queue creation procedure with new data struct with the related
> > settings.
> > Add functions to collect stat for DIM, and workers to update DIM data
> > and settings.
> > Update ethtool handler to get/set the moderation settings from a user.
> > To avoid detach/re-attach ops, ring DIM doorbell to change settings
> > at run time.
> > By default, adaptive-rx/tx (DIM) are enabled if supported by HW.
>=20
> The merge window has started and we need to start working on our PRs.
> This will need to be reposted after 7.2-rc1 is tagged, sorry

Sure I will repost it.

- Haiyang

