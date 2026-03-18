Return-Path: <linux-hyperv+bounces-9525-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8CQyO+C5umlWawIAu9opvQ
	(envelope-from <linux-hyperv+bounces-9525-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Wed, 18 Mar 2026 15:42:40 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C0832BD618
	for <lists+linux-hyperv@lfdr.de>; Wed, 18 Mar 2026 15:42:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6B9BB300BDBF
	for <lists+linux-hyperv@lfdr.de>; Wed, 18 Mar 2026 14:38:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A3F63A63EF;
	Wed, 18 Mar 2026 14:38:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="d4mFoa8+"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazolkn19010002.outbound.protection.outlook.com [52.103.13.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 194692309B2;
	Wed, 18 Mar 2026 14:38:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.13.2
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773844734; cv=fail; b=MUDc89SD3R0CgKWbLey+T05xaPYG5O3s9c4dNo3IDw3ZJpyZCfM1Ll8JTlLxxQ9DPi44WiNCHVh/aU59Qhl9wLjUCTzpzApofkOCpi8AMIQj046JhpJGPlHf4+4M1qJrh4TZTQRqGhg2TMv7TkqcgyzV2m0DiWtRvrkAszgvAXM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773844734; c=relaxed/simple;
	bh=qLGaFJ/sL6K2XJ9K4kMlZs5fAGfRl/u3vveLT0+0xwo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=J/ha8kVM41bruyckW7oR/r46U0ipLfrXZ4ntwX3IN24qlBppBgEdFbG0FuLbYF2HCCrgdTRNMiqhJgIx4qol0/ay8jAM6CcxVQ8oNcFuYHoDNhktQZcIDNDcfB+gLVMp4SXb9IzLj2IIolARs5w7I1vSPHSHVruvUREeEqK/jb4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=d4mFoa8+; arc=fail smtp.client-ip=52.103.13.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=L76QPj1B20M3Gn4uJvKCW/Tr8kktyQld+YHeDN2ghP0BnXZgYAuS+cS8aF7YMLlLk+Fh7yshyiMvLTz7DpMx8yLPQoxdrzk2O1iYBvQCiY1MwtmqCpp8nyUKEYHqu6M9O0c/GY0w0OQ2NpTmhAUyiYt3/Vfe54fKvwPuM63flS14kHf+JevUaqveMpRpNQsyDvL71Pi44QfJfZ9vugF2V7c1pPy6xLA/PuUJ9eOezmMaisSYO2Suukmxof7uAwJNG/X9e21xFBWyvXA4H9QzQoAyCz1KuxBFN0fZh5m0VX6OvWS6RRlUYmQTvZsAqw3ct/k9f8OCxfs6d8Q4sk09BQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Gjxa413yhqVs+X+EhsArfh6zuudkztdzQijCjO2sMfY=;
 b=o/lQtpYxhEMW1H/4SYzq/w1t/l3zP5h+sqm/wed32hlrMWIXphNG7zOIZ3IOqV8X+YyRSFjn5vx6Mhtg3MVz0XWwuHaKVL8dguEJHeP5csiJiFzK3QzGHQEArDnlLY2gNY13xYXKsjsmhTkjAcuwMm4G5YD53B7BDlUIxGUHQjqnCvxtf4PCaICh1u93Uh6nE2OtYAupum5G06HxBnV+i8HhnSQ3iddQ6LI8iV5Nu/dSBnbsJoLHCuaRD/5Ka8xO+v9V3fH4qzyPOEPET7SiIPpiDMo5m5n3EVA3dzol3NJMdOnJbvu3qHFf5Gevbr5XL80+ik7kK11t3hAD5xG2rg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Gjxa413yhqVs+X+EhsArfh6zuudkztdzQijCjO2sMfY=;
 b=d4mFoa8+578kp61jomvu0URm678JAprxlbXqUp34Dd0Y0hwHEtcYDizRTrkDxOO2ZDlsQ3ORVBOYDfa7XpqMo0sEdbf/wGs0fQpgj1xbA1mXsmrdD5YdUqm9oyr+pOB26VhihZylSHNfCtMQ94/WxwkXYBxquHXuhGIO77OqeVTU7f3b7uI4QrfXx9izGl+Op2TQYAtbB6dY7V+zjGpxQ6AwFFMF2qBy3RzO07zTpUpne0/CbmB54wIDL1JH4hUcsYozw8Joy5tKLjbkpYhiTUzyPlIES0QHqRW05VUYsVA9GJILejjP2S+oa4ytmGHmu4kjgsF+k227hjsH3LbKGA==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by DM6PR02MB7052.namprd02.prod.outlook.com (2603:10b6:5:22f::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.21; Wed, 18 Mar
 2026 14:38:50 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::900:1ccf:2b1e:52b6]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::900:1ccf:2b1e:52b6%6]) with mapi id 15.20.9723.018; Wed, 18 Mar 2026
 14:38:50 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: Wei Liu <wei.liu@kernel.org>, Michael Kelley <mhklinux@outlook.com>
CC: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>,
	"kys@microsoft.com" <kys@microsoft.com>, "haiyangz@microsoft.com"
	<haiyangz@microsoft.com>, "decui@microsoft.com" <decui@microsoft.com>,
	"longli@microsoft.com" <longli@microsoft.com>, "linux-hyperv@vger.kernel.org"
	<linux-hyperv@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] mshv: Fix error handling in mshv_region_populate_pages
Thread-Topic: [PATCH] mshv: Fix error handling in mshv_region_populate_pages
Thread-Index: AQDgALApYlkUd2/WEALJAJdREysOHAIA2hn9ASIgFZO3lK+/4A==
Date: Wed, 18 Mar 2026 14:38:49 +0000
Message-ID:
 <SN6PR02MB4157A6D37C19379C74C88ACCD44EA@SN6PR02MB4157.namprd02.prod.outlook.com>
References:
 <177375989324.25621.6532741522672582851.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
 <SN6PR02MB4157D2316EC9E5B0BAE656C0D441A@SN6PR02MB4157.namprd02.prod.outlook.com>
 <20260318062001.GA262287@liuwe-devbox-debian-v2.local>
In-Reply-To: <20260318062001.GA262287@liuwe-devbox-debian-v2.local>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|DM6PR02MB7052:EE_
x-ms-office365-filtering-correlation-id: d9caa594-6a4e-4b24-29b8-08de84fc11ea
x-microsoft-antispam:
 BCL:0;ARA:14566002|51005399006|461199028|37011999003|8060799015|8062599012|13091999003|31061999003|13031999003|19110799012|15080799012|41001999006|1602099012|40105399003|4302099013|3412199025|440099028|10035399007|102099032|1710799026;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?bdu/Lw+wTBVszRmeH6bcP+ZmHmuN6PAgfOsdqhZad3Kun1rUdB8AhrLpBs2w?=
 =?us-ascii?Q?GbU7w5eEL2pjYfDn8ETq5DWoMw3vsGt0ol//Af+U7zBJyYo9eqnZ77Dxabin?=
 =?us-ascii?Q?SzgsLWA9J6vDbgK1Lt7QhmjG6dj04iKsSTIO38Dpwqan7c5ycc2mWDEgxiG5?=
 =?us-ascii?Q?Z7FCOx4MKwELU4ejQ4YRTUaXQLW+DURtkJGZF6Pn7CBllmA4uX/1J5CAskML?=
 =?us-ascii?Q?eKJQANteFgkFNHm9GOfRnBCOy+YJOIc4Ze+h/39hganoDfd2mTwTLhfr0CRK?=
 =?us-ascii?Q?z9Juh/Ops+tsgSfna8m8pgthtkZoonCv9O5GJcA46hRQy9XmzAJ/UWD2bxpI?=
 =?us-ascii?Q?cWS+qAiq8OMihbE21stbgDXW3y3+HNslsULFg08/6Q3Rf9Koab+jF7qMOyJd?=
 =?us-ascii?Q?abr4C6CNhorZ1ZziCKEbSnqeCnfLnutDUZXlr9mdTdqndMN5UI6LmjwPEQf+?=
 =?us-ascii?Q?c5uIQ5X3ckV3hTfBWVaS5yWQM0PzwORlbgSF8U3bU9fvy26N+D97fP3yDm10?=
 =?us-ascii?Q?aaCJ7D9tqX6Wl8d1AK/2OoGkpexq4elkSzAVNwFOoh/WGkoOfjJGk3pDt4yv?=
 =?us-ascii?Q?Xw7EgZCCrayEGfqsYVVggMghEsDrsD1RTPvBYEnbqe+lyFMj2iG4MPAQIa7q?=
 =?us-ascii?Q?0npGmuGwZUkRgS7BcnD4Ijd9LAAQprYWKVROmZ8xTaiibKTQIRjrS9Ah31LK?=
 =?us-ascii?Q?fmy9Ji0ceC+HeqVpbjw24weJc2Wn9C7MtHN/Be/5ElSNq2e5ex9KsdKkGptF?=
 =?us-ascii?Q?HEr0quM7Ir6iEKAucglre97Lipj53oLW3UE+x1MmJO+GoEBEKZZzFe4L7/LW?=
 =?us-ascii?Q?jOMJOc5zfgQIfvETjqS5VvRVVVQeu3jxQTD0JU/jXqMktXUcVjsAJmz+CX3d?=
 =?us-ascii?Q?/O9VAdg5VtZfqaZ//yfxiGKacdPxQzxyhiBzANV7FgQ6ntHJDAzmCNigdUAO?=
 =?us-ascii?Q?lsPz26CTd4ayAdrq8nbRMdK9jOb82mWJd3+nBQq/Lh+UsftFrRT1ZKAQIJY8?=
 =?us-ascii?Q?NmgjsXYmTnyE5AaDpBF1V6dA8H4kPweYkiYh0Q6M5dhu9DQ8HdDWPKtKNy8K?=
 =?us-ascii?Q?TeWhkHMNPEaQXfbw8f6hB5VFFP4o1cpeVE1AgJO7CdY94CbeoFjzXZab5vH0?=
 =?us-ascii?Q?CHcWhyv9LoBp?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?fWkkoFTRCYKzC8uRbEKbHYJ0J/CEas9frBk2tyUR5UwwA9HTpl9UBFw6gOed?=
 =?us-ascii?Q?aezDyHyDV4Ctp/LJBkHiylSYWYKrXidYxTl5X7d5wEGD99YkazZ2neKKg74L?=
 =?us-ascii?Q?bs1TlcswYksHtiaAukVlIrRf1Dvo0ncOId8JkSTggLFb8rci92E4inTAt1Rq?=
 =?us-ascii?Q?BdERQ+edcE+f7TR583Z3rz4Epc6F59NPLfSWvbUHYic3pLVrjw0rEPTrJ5Dp?=
 =?us-ascii?Q?8oPGJdVxzSZ2QdBhEiWgcn/lQLV6tY07PMgUePbn3g2tm0ZIgeLgD3M3Hlp2?=
 =?us-ascii?Q?LNRXjTQUpQA8lX8Nh5QmHo6uB8efk9stf8uJYKrgUUFFnuyiY/6r1ZEBlHzn?=
 =?us-ascii?Q?1Y8wp3CkKusj2K5/OUBCdU/hClqDgek10mGIBvoK5jl7SKZi4oAYOfOuA4+4?=
 =?us-ascii?Q?bTFCvoSiO0PR3HKUxUZGTz5cssGV93OaneE5LLuKpEFelKl1Y+0ttzo/zIhv?=
 =?us-ascii?Q?Cb6KL4Q/txIyyKUyJ87GS3scLr08VgFO+00zSU1CPMVKD25ysaPu9Ixs1q2n?=
 =?us-ascii?Q?h2AHd2uu+p0CX498ro3jWiOgXT29ZPRnaWxqtfNmnWQp1N34Ei3LOA6+EFAC?=
 =?us-ascii?Q?eMnYYF1Ei/URvyix+KMq/Vche5SFZfQMGHFFpkQ1acBuZ3ud/2HYgr2I3fFM?=
 =?us-ascii?Q?cp/8P53DS+TaGbIj8Gf54y46nrNRx/01PlOsAAba6CjOFJeZJ6R13JAevX2E?=
 =?us-ascii?Q?F8W0QVXeyMOL4pGjdYaA9Xj0qhccfRGY8y4qhFFzC+szi9GTMvMhleXEBxm4?=
 =?us-ascii?Q?ZW6I02RMI00vKHxjvH+2JGoxa8T3z+uH+dO+F+przqbKa4E0BisO5EVTnb0J?=
 =?us-ascii?Q?u6fmWCHix5KPDS04DDkT0dO4kR9dNeFm+r59pD2A3NslPDbCm313Zq6XfZoO?=
 =?us-ascii?Q?FX3cuwKAlNW6XurH/Ehzj4LKdbSslNZiToGR91FyrBPgNy1O+veaqLMk9862?=
 =?us-ascii?Q?1g47Uc2dCVzAt4xcIqVT4qDOK7+++Su8x2OllfZxvaafCAfDu3qFU3kuaCAq?=
 =?us-ascii?Q?Wa95z076Nd2V3CFa2kLoGCLHFZPSGm5YMnOgpup6rO21/6YS/HpfefzgD+Ts?=
 =?us-ascii?Q?OdzwM0a/Tc3PHdRzMEMgcrEcoo31ZJmWCj7Gr2wD0O891M99lAfhC65I0xWo?=
 =?us-ascii?Q?GmdpZRzc8WNWr6o7M5fVdt9nFWHUo9WtSCIF43fuz6qduYfolF2xjTDYsFFJ?=
 =?us-ascii?Q?ry8iAgoppdNowAybISAKUgA/CXr+XKd1F3D2mOh2EZLuJrAn9xwJmAU/BZef?=
 =?us-ascii?Q?h6z/ZENMn73t9mHW2XSXeqnwbB6ZlQwQ8VI+/deaJc7G7LsdguwM8ptCGXiX?=
 =?us-ascii?Q?e+0OrcDDCw4tf5lSNuzv/Nb/TEbRekQuoiayfz9WFO0y3kn00EahDeOU+kli?=
 =?us-ascii?Q?tdI7wsg=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: d9caa594-6a4e-4b24-29b8-08de84fc11ea
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Mar 2026 14:38:50.0129
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR02MB7052
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[outlook.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[outlook.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-9525-lists,linux-hyperv=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[kernel.org,outlook.com];
	FREEMAIL_FROM(0.00)[outlook.com];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[outlook.com:+];
	MISSING_XM_UA(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mhklinux@outlook.com,linux-hyperv@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.951];
	RCPT_COUNT_SEVEN(0.00)[9];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-hyperv];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,sashiko.dev:url,outlook.com:dkim,outlook.com:email,SN6PR02MB4157.namprd02.prod.outlook.com:mid]
X-Rspamd-Queue-Id: 3C0832BD618
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Wei Liu <wei.liu@kernel.org> Sent: Tuesday, March 17, 2026 11:20 PM
>=20
> On Tue, Mar 17, 2026 at 09:56:07PM +0000, Michael Kelley wrote:
> > From: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com> Sent: Tu=
esday, March 17, 2026 8:05 AM
> > >
> > > The current error handling has two issues:
> > >
> > > First, pin_user_pages_fast() can return a short pin count (less than
> > > requested but greater than zero) when it cannot pin all requested pag=
es.
> > > This is treated as success, leading to partially pinned regions being
> > > used, which causes memory corruption.
> > >
> > > Second, when an error occurs mid-loop, already pinned pages from the
> > > current batch are not released before calling mshv_region_evict_pages=
(),
> > > causing a page reference leak.
> >
> > There's now an online LLM-based tool that is automatically reviewing
> > kernel patches.  For this patch, the results are here:
> >
> >
> https://sashiko.dev/#/patchset/177375989324.25621.6532741522672582851.stg=
it
> %40skinsburskii-cloud-desktop.internal.cloudapp.net
> >
> > It has flagged the commit message as incorrectly referencing the
> > function mshv_region_evict_pages(), which doesn't exist.
> >
> > FWIW, the announcement about sashiko.dev is here:
> >
> > https://lore.kernel.org/lkml/7ia4o6kmpj5s.fsf@castle.c.googlers.com/
> >
> > Other than the commit message reference, this looks good to me.
> >
> > Reviewed-by: Michael Kelley <mhklinux@outlook.com>
>=20
> The second point is written as if the code here should release the
> already pinned pages before calling mshv_region_invalidate_pages(), but
> the code actually relies on mshv_mem_region_invalidate_pages() to
> release the pages. The change here fixes the accounting.
>=20
>  Second, when an error occurs mid-loop, already pinned pages from the
>  current batch are not accounted for before calling
>  mshv_region_invalidate_pages(), causing a page reference leak.
>=20
> And queued up the patch to hyperv-fixes.

One other thing I noticed:  The "Subject" of the patch is wrong. It
mentions mshv_region_populate_pages(), but the function being
modified is actually mshv_region_pin().

Michael

>=20
> Wei
>=20
> >
> > >
> > > Fix by treating short pins as errors and explicitly unpinning the
> > > partial batch before cleanup.
> > >
> > > Signed-off-by: Stanislav Kinsburskii <skinsburskii@linux.microsoft.co=
m>
> > > ---
> > >  drivers/hv/mshv_regions.c |    6 ++++--
> > >  1 file changed, 4 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/drivers/hv/mshv_regions.c b/drivers/hv/mshv_regions.c
> > > index c28aac0726de..fdffd4f002f6 100644
> > > --- a/drivers/hv/mshv_regions.c
> > > +++ b/drivers/hv/mshv_regions.c
> > > @@ -314,15 +314,17 @@ int mshv_region_pin(struct mshv_mem_region *reg=
ion)
> > >  		ret =3D pin_user_pages_fast(userspace_addr, nr_pages,
> > >  					  FOLL_WRITE | FOLL_LONGTERM,
> > >  					  pages);
> > > -		if (ret < 0)
> > > +		if (ret !=3D nr_pages)
> > >  			goto release_pages;
> > >  	}
> > >
> > >  	return 0;
> > >
> > >  release_pages:
> > > +	if (ret > 0)
> > > +		done_count +=3D ret;
> > >  	mshv_region_invalidate_pages(region, 0, done_count);
> > > -	return ret;
> > > +	return ret < 0 ? ret : -ENOMEM;
> > >  }
> > >
> > >  static int mshv_region_chunk_unmap(struct mshv_mem_region *region,
> > >
> > >
> >


