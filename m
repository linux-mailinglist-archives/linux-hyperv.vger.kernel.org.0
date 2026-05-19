Return-Path: <linux-hyperv+bounces-11019-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MH/NIznVC2qaOgUAu9opvQ
	(envelope-from <linux-hyperv+bounces-11019-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Tue, 19 May 2026 05:12:57 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 110BC576B97
	for <lists+linux-hyperv@lfdr.de>; Tue, 19 May 2026 05:12:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0CFA43030D2F
	for <lists+linux-hyperv@lfdr.de>; Tue, 19 May 2026 03:12:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2ABCA30FF1D;
	Tue, 19 May 2026 03:12:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="ov3M5S5I"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazolkn19012013.outbound.protection.outlook.com [52.103.14.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E267332EDE
	for <linux-hyperv@vger.kernel.org>; Tue, 19 May 2026 03:12:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.14.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779160374; cv=fail; b=KsOMUnt1VdTCDd/BRrnZJKa0VPFxyDvP8A6vF/13EI1Mwddl3mVDIRRDChENJ9GwoLknB+Sagdg2MMubTanWJSR8Q08/XJPbauaFLOiOMnhqh4SW2/bRMg3sS2BveoOkMc2TDJDpnEDXPt/Yp+d+gY4jnu7db/foe7RD8ipvsqM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779160374; c=relaxed/simple;
	bh=MetAT3isqrW0oMoMRao1TKRda5Ja7NSRB1e4e2ptCOE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Lg/cjlBNwviavNzJRwZEU1cqwkC4LlCuwJbhqbwp0wocI98zhaB1MFNBQB72/pidnSchNdjUOnBJ/bazFlyC0baQDf3fr+gMOh+wKohaO/5zRhMBXCYcJlT7uMq09khRjW07LCx77qNyoiV4GykjeTwW6JrA0XLur1SM8CGFkio=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=ov3M5S5I; arc=fail smtp.client-ip=52.103.14.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=f2eLAiYMuB6NlmbO2j9hKqw+nJKOHZ0BQcocFhOo7tXdNX6Zs+QkJ6AaFdeDROuuFA8QCpzR8murXWNL46g18J2Dv0l7JkVq8cs3cRsp3aJh/a1DFZCiyiEUeIlESBikftd7HpRNsQ2+vIGUHgqu/i0rsOeuGyyRNbPV+wRRjFl2mfVeVWRzxeLI2Rczfes16JpvfxZw6Rgn9NS61isO9vABNtVQt1/tonsZbZ3tCZUxivODZ6qpVdHRYGTfN79s5rLHAwojgR6YdKPjhTtb7voL4fjV81loG7Tef/hSiFNOmOLaJYwpgOooS+aNru0r6QhNzlnATd+zfOGnm/Hdrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hjJfkWxvnJV7pvJVm56z2jMLgFj5ensFy5uZxM8pbi4=;
 b=kaV6IfZ11XeASUFG10XbpMhYAnj9hBulQgRKZ7cw3slxDOeLaU9xx8bfwF3stSUZm56OIp9pFxKueuKYAhxftQjwrlMi/i1WQHJ4gCGCxA04U8t9AgCDPlxy+hWAlJq6y6SKFpMF2Aby5XpR8D7cOiSqX7zp6x/s7lQyOLisO1wKXnKkW6wnUOhjcIEfyXOMSceII3saaCsl/EoP9dcqWSW131wgVjsfOfPjjfj9d/fe4BsGdH4/B1NAFroBnSAJdd/cjsB6faEBVOouRvCxcumdn9/MUeERwow/KjREVDuBNJ704UMkG0HIGFeB2q7pvy4MPau69nJh6mEsXzfxVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hjJfkWxvnJV7pvJVm56z2jMLgFj5ensFy5uZxM8pbi4=;
 b=ov3M5S5IOLZKAhMQvHHPfyYC79kEP9Ay/qg2nYKLJ+9drEQ7NMeGdhxmhPozsgQaTCOsFBL2xlqa4U5d87AdfaQ+OJw0ypuQBUJJsRpTRRYGHwl0XEX5hReCnwrdUAHqkrcnSVOKwa/fukP06TuyeM28arzj7GkDPteOE/Idnga91Gk0eES3EIe40pcRjBpVlzhBjKxXIdnoUf78pdwgS5+9qN8jAyMaNKcZhDzFD4CD36Tc6XjJdEorjhpmi9pYw55nCtEYnTSWXm2H/6xJJnDZu6Mry7O6EWOLjasvavP3cAp0Z+G/cCiWQH3UQeRVwJkHyjP1tk6V00orAkDcxA==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by DS0PR02MB9245.namprd02.prod.outlook.com (2603:10b6:8:131::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.17; Tue, 19 May
 2026 03:12:50 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::900:1ccf:2b1e:52b6]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::900:1ccf:2b1e:52b6%5]) with mapi id 15.21.0025.022; Tue, 19 May 2026
 03:12:50 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: Sean Christopherson <seanjc@google.com>, "sashiko-reviews@lists.linux.dev"
	<sashiko-reviews@lists.linux.dev>
CC: "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>
Subject: RE: [PATCH v3 31/41] x86/tsc: Pass KNOWN_FREQ and RELIABLE as params
 to registration
Thread-Topic: [PATCH v3 31/41] x86/tsc: Pass KNOWN_FREQ and RELIABLE as params
 to registration
Thread-Index: AQHc5J/+S6zzZLK3PkGQwXsR4aATVbYUXy+BgABF6OA=
Date: Tue, 19 May 2026 03:12:50 +0000
Message-ID:
 <SN6PR02MB4157D50A944A2794475E32FED4002@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <20260515191942.1892718-32-seanjc@google.com>
 <20260515194535.56B84C2BCB0@smtp.kernel.org> <aguQIJQYsarMScnl@google.com>
In-Reply-To: <aguQIJQYsarMScnl@google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|DS0PR02MB9245:EE_
x-ms-office365-filtering-correlation-id: 94419396-2637-4b4b-e87d-08deb554828c
x-ms-exchange-slblob-mailprops:
 ZILSnhm0P3nNOD8SPijBf0RiyXdupYBk9D/1og6rDnXE2hYTzymXoFwrpMavoO9zCkgFjsFD6XVSODi7GIgfX4b8N9EjDeLbji98Zkd/vCAZfc3H/s6skROIV6EKovGYZ2G7Q3VQzcH0Xe6/8uHBbSH1IdSrunLV6F5HX0Z59nd0icYz0xSbRofl/uoo7oZ6+sk75LHmz2tBTnketDvb+1TtAMxhI+OZbc8+dne00R1mM0NGifauA2NmJQmqGjtDmpAOr7YP4655xkdugsM6jDvhgCWURJDnjGUWheF+VoocACTErjgeBtimwzs6lG0ZtGZjPUm0WeZJyvPvCot2DeSSdVBMVp7hWAUebFQNLncp79PiJ0fa7rD6byr1NrJzQ2hIm7xQ7XwHL5Sdeat/fVtpVgVO8eOW5X1Vdkg+lG8nBzWA1DVxIb5C6vOxGCBLtoCmFPuzBtWBAf6LR0twVQiM/euCeqeVUUj55+Tw4vzd/kYqPGgJNCNtsukX2+5fih6WiN4qUEz53/WXHZ40WXQzbJhEQfpZiWF1KiiNGQm9v0ajUdDOf6sdccIM8NEaKLMFddUL7Fc0YRExPp+a2FFRKjQn9asaqqgq2skf/KQWMb267OsR9EoUVNfD5dlYklkg3GhWT+LUEbaoQtdVvGCPdommmdjuVl24sV7l3O/KhXEvTUWHXBx6W6nfo2JX35Yu4DL9J+k62PvncxNnsiCkOOd2v/0y4LDgJDItSVCNqdHMluUn1O1aDjmEliwlQbkSXmKB3zMozOSQZFRfRtHbkchm6BKX
x-microsoft-antispam:
 BCL:0;ARA:14566002|55001999006|8062599012|31061999003|41001999006|37011999003|8060799015|13091999003|19110799012|15080799012|19101099003|19061999003|52005399003|40105399003|440099028|3412199025|102099032;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?eP6T4wOwdDbd6bM21UnnSU3nHFIWaEmy4biHnmI+Q+HoEi5Y0hxnbK9VfOlT?=
 =?us-ascii?Q?ugxWwNN84VGwRxaF4B+Mhup8ThRz05hWHo/qJ8seGLzUN/Pdqu3iwEcbo6Nz?=
 =?us-ascii?Q?00dQSSYVSqWnmZ+PTvsfMVDGJMX6OL8HZDuyQqWwjRhWX+tolWJEPkW3kmvp?=
 =?us-ascii?Q?mhoBYOml0jD+CxsMNWxb27Wb0sKqzYMkVZzJrDt/ZXU2avzGWOzjNlPXU8OD?=
 =?us-ascii?Q?89LXPbFlEPaLoppmJ+nlWxTfQEr4yMHSR92fIqZz9SUCwPmNCwymSIW86RUN?=
 =?us-ascii?Q?+f5eIY/LOQCw5hZWZFv8UyNqQ5wZEAlfR+qLQy6wbRNmtRtwPL35axb26OrD?=
 =?us-ascii?Q?wP4mZtuh6WuDgijHsgIYVyFdcGxXulOetuUud3A7j6MccSDQsVy7cI3JLWWV?=
 =?us-ascii?Q?ID827UGpZqF5pofIrZES516UhRhac7kk9+D9EcIyNyT4r5nSyzh16NB+UgYL?=
 =?us-ascii?Q?He5dlJyWIoPlFpXSyQqbj1TEPbioP2N38CxO78M9cAEEr0B1M4/vYtDLhtrP?=
 =?us-ascii?Q?yZ9V5xaXXQq31XwJSBV3b5KubHAdN8ex5T9+bUj+7XEhYR5fa5m54qCKbuUO?=
 =?us-ascii?Q?QPFx2NjOje/hgkbkRWELMKpv0OTTjoDoIz2WoB/MFeplL1hJboXo1dC+rQPs?=
 =?us-ascii?Q?drDcLB9kEbCPMQ61RakGgN/gx3K3pK52GxJB+PoOad+EsLOffkDwXT5ugpWj?=
 =?us-ascii?Q?rdEtricg5aBoI8yHghKqNst05pyLd3B7eaR25d7Twra6Jz8H+AEm8yxHT/ST?=
 =?us-ascii?Q?iABVtTIbuciwilyaA/rSjPgB2FCIhBl41YuAyzXX0N+8M/cAisU7ble5++j4?=
 =?us-ascii?Q?BX7qEyyaRNaGGG3adamLAsQcny8kWaX/IB6f+OJdCHd1DUKGryDqtSg7o0Gs?=
 =?us-ascii?Q?eAq9bu915i2W+h9XmHXXag44awtAYJr4uCt88oV3kkVom5/D8iDzVJK9nDO2?=
 =?us-ascii?Q?HD24sNICPFi+0MK+ThWFR8PDCJvGsyYAG6kx1i10aEkzTPCCqtngCBvNESWA?=
 =?us-ascii?Q?64OTde/0Z2tz37hQlKS07frPwZDYHlPE2ZRB2w7YjBeCePiDck6q1cJxNoXg?=
 =?us-ascii?Q?Vk3PsmI2y6JtuoXzrZzJlY73KV/RUmnOt149VKfBqgp5AR6FNrY=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?089zRRTqUwBw67hYGvH/7sIxtHr1d3zhRm9j0fM8oN7ZDwZDWL7bDBAWncCA?=
 =?us-ascii?Q?r/GeV8XnysSdhzJZPJ72wEprq39zx2A+Ad4S5tHAFyF7zaP52Xm2QxfdZnWy?=
 =?us-ascii?Q?ng1xYL6l05xTQSl5ffLtsQnRSVRUWrZksclm802BJwb/KbhtFX2HeCjvzoj5?=
 =?us-ascii?Q?T9NEu863cht1p+GCzUb39lpgnFXy0up1Y8cDt8MiU6uyJzEg567+dHinPihe?=
 =?us-ascii?Q?KhUXSM20XS6qs71srWo6lMVdV3QKHeBHIV9QNir0nWGJ+OqzG946R0tTub3I?=
 =?us-ascii?Q?FkNFHNau6kyhU+Hc76AGuj8PVTmppkmN0xeLsXxJ7WFZi95FpnSkxpD5zXnH?=
 =?us-ascii?Q?qJ3Ota6Q7tGhZbqqRuSFSQexPRyaUGZ1jzeQlTOKdtXsAOSDcO/etLsFYdVQ?=
 =?us-ascii?Q?jZ7kN3w1cMBFrftdg5L6afZVn9UELxzDw7cHUcc4Sjp++I6idI90BdpFDMbZ?=
 =?us-ascii?Q?apF5VPJAzZ8INWz+Gn17yK9JFJIvxEqDmq2WTc0PnW8AevdHe2mXxXHZk5of?=
 =?us-ascii?Q?nfrf/z5Gqz8SkEYel3DMnUfSotvredV1n7jqh2KH/B5IhcFb0fxhJt5I2HM/?=
 =?us-ascii?Q?PEmbkNlFpG3Qsw/t3DdOisStBMp6vNpYb+fsmd2bD+jGyVqKs71Ak/Qst4Ib?=
 =?us-ascii?Q?9fTjozxOeWzJ+Z/NuosgPhNysPAbSUAaD1VSjcaeOx0wMNWU+T5JgzXImvDr?=
 =?us-ascii?Q?ZebHZ00JD+jB4Kti74Qhhg7KQO5eRVg6tffaDjitL7TcEyBzifYs0pq4zetQ?=
 =?us-ascii?Q?aIJmA5iZ2MTV2l5mx5UEIy0LRmMMR2pUrtwvaxPSprQDpg0ydIQ8p9a7zfn6?=
 =?us-ascii?Q?xe5egMmMyczKfbHmfSyEoFvFBwZaDYAUTGRMryMWm3LuCDyhIjghwJ75C88M?=
 =?us-ascii?Q?NkHDA5OA5M4DBUNIBcxlhtbDOVsczDA32DwHEXWBp2ItpKJxujLiOo7IA7ST?=
 =?us-ascii?Q?BaepX0BpCLh4uI7zVbjG/boBMRqGVTbR2WeZyVYqMZtYqRODF2V8kFT3Tv0U?=
 =?us-ascii?Q?Z9w9iknAzqatDlWskqHOjFHM2nd0KAnB3fqyYbeP1Ejm4sePEP8BlZnOaMe2?=
 =?us-ascii?Q?fISvdhHVFPBD6mPoaTV5hOxDYWfmk/dheceDX8rpUU62Rs8isLw5GbLGByKK?=
 =?us-ascii?Q?+2XsKo/kOCgHtsRWmWJ6Hk4RgdbOfgLhh4AsQKsY75TqVkEhotE/UWP+ELPZ?=
 =?us-ascii?Q?7VOViiq2MF1k7FOyh93LKK84pGeloxBYNhLEuzrddlOLoQ4qB2uhJlfsYLM8?=
 =?us-ascii?Q?CzfrD6vrZN27iYJC/yMv856qaM1YwG970GSA94LG9hnTIe+hD5S+BSPLGZc0?=
 =?us-ascii?Q?RWNfRKtQBQ7SHpnFw4YnunyOjPKPlTEtuaAHo0E7d2bp8ilE7j6HWB4GPkXt?=
 =?us-ascii?Q?nOfpyjw=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR02MB4157.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 94419396-2637-4b4b-e87d-08deb554828c
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 May 2026 03:12:50.4519
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR02MB9245
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[outlook.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[outlook.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-11019-lists,linux-hyperv=lfdr.de];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[outlook.com];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mhklinux@outlook.com,linux-hyperv@vger.kernel.org];
	DKIM_TRACE(0.00)[outlook.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[linux-hyperv];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,outlook.com:dkim,SN6PR02MB4157.namprd02.prod.outlook.com:mid]
X-Rspamd-Queue-Id: 110BC576B97
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Sean Christopherson <seanjc@google.com> Sent: Monday, May 18, 2026 3:=
18 PM
>=20
> +Michael (sashiko was quite stingy with its Cc list)
>=20
> On Fri, May 15, 2026, sashiko-bot@kernel.org wrote:
> > Thank you for your contribution! Sashiko AI review found 1 potential is=
sue(s) to consider:
> > - [High] Hyper-V VMs with an invariant TSC but no frequency MSRs lose t=
he X86_FEATURE_TSC_RELIABLE capability.
> > --
> >
> > commit 0c0fbc4f0451c30c0e87e0e3591ea4f487eff75c
> > Author: Sean Christopherson <seanjc@google.com>
> >
> > x86/tsc: Pass KNOWN_FREQ and RELIABLE as params to registration
> >
> > This commit adds a tsc_properties parameter to the paravirtual TSC
> > calibration registration routine to consolidate feature flag tracking.
> > It updates various hypervisor initialization paths to pass combined fla=
gs
> > instead of manually setting the CPU capabilities.
> >
> > > diff --git a/arch/x86/kernel/cpu/mshyperv.c b/arch/x86/kernel/cpu/msh=
yperv.c
> > > --- a/arch/x86/kernel/cpu/mshyperv.c
> > > +++ b/arch/x86/kernel/cpu/mshyperv.c
> > > @@ -516,8 +516,13 @@ static void __init ms_hyperv_init_platform(void)
> > >
> > >  	if (ms_hyperv.features & HV_ACCESS_FREQUENCY_MSRS &&
> > >  	    ms_hyperv.misc_features & HV_FEATURE_FREQUENCY_MSRS_AVAILABLE) =
{
> > > -		tsc_register_calibration_routines(hv_get_tsc_khz, hv_get_tsc_khz);
> > > -		setup_force_cpu_cap(X86_FEATURE_TSC_KNOWN_FREQ);
> > > +		enum tsc_properties tsc_properties =3D TSC_FREQUENCY_KNOWN;
> > > +
> > > +		if (ms_hyperv.features & HV_ACCESS_TSC_INVARIANT)
> > > +			tsc_properties =3D TSC_FREQ_KNOWN_AND_RELIABLE;
> > > +
> > > +		tsc_register_calibration_routines(hv_get_tsc_khz, hv_get_tsc_khz,
> > > +						  tsc_properties);
> > >  	}
> >
> > [ ... ]
> >
> > > @@ -629,7 +634,6 @@ static void __init ms_hyperv_init_platform(void)
> > >  		 * is called.
> > >  		 */
> > >  		wrmsrq(HV_X64_MSR_TSC_INVARIANT_CONTROL, HV_EXPOSE_INVARIANT_TSC);
> > > -		setup_force_cpu_cap(X86_FEATURE_TSC_RELIABLE);
> > >  	}
> >
> > If a Hyper-V VM exposes an invariant TSC but lacks the frequency MSRs,
> > does it bypass the tsc_register_calibration_routines() block entirely?
>=20
> Yes.
>=20
> > Without the standalone setup_force_cpu_cap(X86_FEATURE_TSC_RELIABLE) ca=
ll
> > here, it looks like these VMs will lose the reliable flag.
> >
> > Will this inadvertently enable the TSC watchdog, potentially causing a
> > performance regression if the system falsely marks the TSC as unstable =
due
> > to virtualization scheduling delays?
>=20
> Hmm, I was going to say that the change was intentional and desriable, bu=
t looking
> at this yet again, I don't think that's true.  Enabling HV_EXPOSE_INVARIA=
NT_TSC
> just means the kernel will (probably) set X86_FEATURE_CONSTANT_TSC and
> X86_FEATURE_NONSTOP_TSC during early_init_intel(), AFAICT it doesn't lead=
 to
> X86_FEATURE_TSC_RELIABLE being set.  And I think in this case, marking th=
e TSC
> as reliable makes sense; even if the kernel doesn't user Hyper-V's calibr=
ation
> info, the host is still clearly telling the guest that the TSC is reliabl=
e.

Yes, I agree. But I'm doubtful that such a combination ever occurs in pract=
ice.
I've never seen an occurrence of a Hyper-V (even really old versions) guest
where the frequency MSRs are not available or are not accessible. The
Hyper-V spec allows for either condition, so we have the code to test the
flags. I've thought of the flags as always set, though I suppose one never
knows what the future holds.

>=20
> Michael, does keeping the
>=20
> 		setup_force_cpu_cap(X86_FEATURE_TSC_RELIABLE);
>=20
> but also passing TSC_FREQ_KNOWN_AND_RELIABLE to the calibration routine m=
ake
> sense?

I don't see that it would break anything. But it seems a bit disjointed in
that HV_ACCESS_TSC_INVARIANT is tested in two places in
ms_hyperv_init_platform(). Does TSC_RELIABLE *need* to be passed to
tsc_register_calibration_routines() if later code in ms_hyperv_init_platfor=
m()
does setup_force_cpu_cap(X86_FEATURE_TSC_RELIABLE)? In other words,
I'm suggesting let tsc_register_calibration_routines() handle the=20
TSC_FREQ_KNOWN case since that's what the calibration routines are
all about. Leave the setting of X86_FEATURE_TSC_RELIABLE to the
later code that tests HV_ACCESS_TSC_INVARIANT, instead of
duplicating the setup_force_cpu_cap() operation.

While combining FREQUENCY_KNOWN and RELIABLE into
tsc_register_calibration_routines() is convenient, the two
concepts turn out to be independent when looking strictly at
the Hyper-V spec and code written to follow that spec.
Combining them into the same function ends up being clumsy
in this case.

Michael

