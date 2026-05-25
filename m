Return-Path: <linux-hyperv+bounces-11188-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0YrYHVtjFGoxNAcAu9opvQ
	(envelope-from <linux-hyperv+bounces-11188-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Mon, 25 May 2026 16:57:31 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C2BAF5CBFCF
	for <lists+linux-hyperv@lfdr.de>; Mon, 25 May 2026 16:57:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E9B9D3006B31
	for <lists+linux-hyperv@lfdr.de>; Mon, 25 May 2026 14:57:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70FD0387566;
	Mon, 25 May 2026 14:57:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="A7LJb67+"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazolkn19012012.outbound.protection.outlook.com [52.103.14.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A49C34C808;
	Mon, 25 May 2026 14:57:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.14.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779721048; cv=fail; b=ebgjMbejhsAuXFFPEM8cc8aaup8AOjqqssODVuSomasab2fn9IuVNnCXsJgoOWQRvb9v5d3k6HkNfZtirjspdGAkWmwDocpPDuK6VTH9eDHdaVCk9rsdaI0vs4Si+Yz3GQLYhrheHmEEvKHlgQDVfava/nRWsbDbD9D8J9Cftk8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779721048; c=relaxed/simple;
	bh=+l6julWQGPtYAEGW0s3kjNh2+kfTsTPoI6d+DfBckpE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=rq+jiztzt9ZqxvIiMBDH6c5oEf6N/IZiny9skNivW4gzUruWXcg6hr/aU291bU1EmAa5QVUxRYFfrl3m4Fzn6BJg+SfgKIzQxu8mQSz4fTu9VNQ0OJNaDTzIrAWj/Q5Cu5rOMFL2S+lB2taRRCE2u7lKZZrdgR2uAaSjYdbEZf8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=A7LJb67+; arc=fail smtp.client-ip=52.103.14.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lGRpCbyAe4RKVMMEledvHqwLilUW1k7gorFesJkg3guasIx2BWtNpWfQrtW4X//O6iCm9OU3UD3JpPe9qc64NYgZLkazQfh1A9/FNz90Ijt1s0w2NI3PP+BfJzJwZ8RZcXKV0/4tZRrtk4ZNGytxf6pE8MaI61KWQary892BkvvrFviuCZFpdnNPEj5p56bWJWBYJ0aDJmLO1Afa8NiGWoK3cq5XY/ImWbWkJUrin5wrY4PquFLqxLLwjbqlI/1QqOaqsoOjT1fEwY6QoBUXeZ98fTOb/SPwczpXBHufDMFuVSqxhe7UbaLfPzmODFFTkx1xKErjVGbR9EVP4Towig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Xea8CpjiMpbGlX5dyWHPyqixI9JjWcBnpAD6OAuaemk=;
 b=LdyMb/a9btCgL504wyO3NY+BEhGQcu7hZZtp5TsjViggLowvrkjw5Od3NwrPYH0I7ZAgePMNXbm329pknzw//7482OMyjXfJ8t9Fvf2w5rGTcZRfE/s6JYrSNeHlAAe92hBRDvNDcBbwy7oh/BsiKecE0IYFXrjQWOX/udiLX7slVB670YC+UOu+rsfw4oodetdLnS3JjC9m0s1EBCWDy6IYE6q/f/6ApNKM4rh88didrZPFur7LiLSzpJubdM6C+24b3EO7e2KRl3+M0MY/WGQRpwWToIn6q7eJoUu90ZOiItZfnK6qkvnaruZiu9MggS9jIGmHAAiwhg9KXC8FJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Xea8CpjiMpbGlX5dyWHPyqixI9JjWcBnpAD6OAuaemk=;
 b=A7LJb67+Jz4h7BpciOp+CsvFc6RZD8Up1dC3J4rD/3SSmevbLRHv3GqGFHwOfSi7tTK4LwoSGGCFB6/9InUQflfBIBmwyG0gC6zssBuJz/xUbBvk5J3YopVzqJKqmHoIciExvjK3kh0eZ33LZjS1oi7VLtGDv1x/g8kfAP6O8OMY+5TjxYxZ1z4C5qdWyk+zcsli+OTRgE57BelyJDnlyXJnSET3PjZXTZxkX2oYJznNWV5uaKYcLJ0KQ/2v4nFBWfa/4sHP/ontQxI/0SuSTyOtf6MYg55fB/kqbugZffyDzrwJzYqaA3SaSBKuvv0IJFVFaKmUQwhVa0DBCjVQVw==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by PH0PR02MB7798.namprd02.prod.outlook.com (2603:10b6:510:5f::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.20; Mon, 25 May
 2026 14:57:24 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::900:1ccf:2b1e:52b6]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::900:1ccf:2b1e:52b6%3]) with mapi id 15.21.0048.019; Mon, 25 May 2026
 14:57:24 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: Hamza Mahfooz <hamzamahfooz@linux.microsoft.com>, Berkant Koc
	<me@berkoc.com>
CC: Saurabh Sengar <ssengar@linux.microsoft.com>, Dexuan Cui
	<decui@microsoft.com>, Long Li <longli@microsoft.com>,
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "K. Y.
 Srinivasan" <kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>, Wei
 Liu <wei.liu@kernel.org>, Michael Kelley <mhklinux@outlook.com>, Thomas
 Zimmermann <tzimmermann@suse.de>, Maarten Lankhorst
	<maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
	Deepak Rawat <drawat.floss@gmail.com>
Subject: RE: [PATCH v5 0/2] drm/hyperv: harden host message parsing
Thread-Topic: [PATCH v5 0/2] drm/hyperv: harden host message parsing
Thread-Index: AQHc6rxXbeGIcHdjcEGvwSATz8Ad/rYen/KAgAA4KpA=
Date: Mon, 25 May 2026 14:57:24 +0000
Message-ID:
 <SN6PR02MB4157F72302D2B4B86ECE553FD40A2@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <cover.1779542874.git.me@berkoc.com>
 <ahQ0NS1jrfU8ms1U@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
In-Reply-To:
 <ahQ0NS1jrfU8ms1U@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|PH0PR02MB7798:EE_
x-ms-office365-filtering-correlation-id: 29f74e71-09ee-4338-c127-08deba6dee4e
x-microsoft-antispam:
 BCL:0;ARA:14566002|51005399006|19101099003|37011999003|15080799012|8060799015|8062599012|19110799012|31061999003|13091999003|40105399003|3412199025|440099028|102099032|1710799026;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?Cj/sWSbEU2zp7WmXmWoIjZ5o+3h6J/YHL+i6ANw7hGBM3+x2OA0159i/X6cK?=
 =?us-ascii?Q?UH5NN5wWUsbdTMTHwUIXp0t/mHC2U9hnY8ugXfE6rXWZ61Vd6SU8ScWMnJcu?=
 =?us-ascii?Q?mzamMVhGikxQ7sGbCxFTuZI20PAy/RUs8cJWDURldEIoM3UWPs7+9bwEjqFY?=
 =?us-ascii?Q?SfU/Fat5Zcn3j9Z5hrId2IWTE0vCUuVIxjGgvX17lHnU/pHrRGcxOTcqv9d9?=
 =?us-ascii?Q?BhLjPA1rB1Z+cA3mTLBD+EY5pRaN0QlikkPYnk5nPXDYkeJKr/ACxpCgihsb?=
 =?us-ascii?Q?WtFOftl5PcPClRacHnvnd15II44u3coSAXJ+aR1d7+w4sXPAqBBKq3t0HrFX?=
 =?us-ascii?Q?NsDYza6NJ1lbRs5bAduVogzNt8tOa1W65QlQKJ+uvanHje/FJ9IivqOimpGW?=
 =?us-ascii?Q?mLcT7WLp09bTWgWVe3O902/BBQDfYVJy5IoWOOgfDRxRlznX9XdjJ5gBI59i?=
 =?us-ascii?Q?vuCgT271xuMd6mamx+kgy+t/wkyhVzVSHyGfPJrqwtuU2CHeZXhiL2UBB0OT?=
 =?us-ascii?Q?hiqahzqeXO6BzAARboHY0zYJd2fabbs0ksAvxJ0OLtEx6XBhUuLf6tSgcRuJ?=
 =?us-ascii?Q?wfMdbG3XnuYPHNCl9CHEZmXjUm/MBepqUwNEwu6m/U4EUlaVSbma9FHzvDEt?=
 =?us-ascii?Q?kJixx8ygxHKOzx2BVHqyiw8SgYV3AjK7yFuXeSHHcOV8s9yz+Udu03iGLaDL?=
 =?us-ascii?Q?F4kFlU51Iwpgpr6i1U1RltNhoPDMCBHPnbsLlaN4tOaCXA2oEf9KnuyV/YkF?=
 =?us-ascii?Q?UV4HEr/CCMDKmQtbs3XKL0rU4GiwB4cGgpBLNo5xIlpNnK/lRXQaEuS65HmC?=
 =?us-ascii?Q?5bikRy0+o5J1kuQEBj2mbpF8GaEfknbvb3j8wfymydLCvr9VY28TFccEPK3J?=
 =?us-ascii?Q?k4m9QK9QD/q9kjSw5zseWJozGYsrf33/qDpJqyicoX1HYGr1RuHl6bVTthfo?=
 =?us-ascii?Q?pbYIHc4nq+DnH3YDhz3K5Z5grOfF7sgNYgK2x/x5rE/uOWjGruzunEc8lin1?=
 =?us-ascii?Q?yjI1A/YBs7D51qRIqCveoPlrDw=3D=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?o52l6/eW5rHQSWXE5ejJ/HvQk3vLMGZsDw7Ili/75h+p/7m75SKbwXyqH42U?=
 =?us-ascii?Q?rFZ3+LfdCHCsi+rfoO9QOskZB9yNsLmBnGM5RGta57FAKezaZjJUqbXKEGSs?=
 =?us-ascii?Q?TOOpis6qvqv+wkEGP9Xc+7384EKuPEpLcvzicC/CNuU6EPswISj0XxkdqAcB?=
 =?us-ascii?Q?yQDb/ma0ubCnZywn7VvnraB1OfnKJkyx/++XCTiL512MJ6Gq3536H7VIOQ+4?=
 =?us-ascii?Q?RdxaSHf5x6F2dBdq4YSDa6jPWC1DVD86MvOmrowxcQsPhvvq694iuVRCP+91?=
 =?us-ascii?Q?VAar/gwUeVIIL/gKvimKb5N3teR6itl5GohhZokVgznjwE2vnlGh+HgqzzCz?=
 =?us-ascii?Q?GmkLraRkKTkd20O3N6qRkTMGWrndaQwKRZb+yQQOP7f1D+LIjhcvLag2VCDN?=
 =?us-ascii?Q?TF4cbdkD7wAUoDOruSkkCgztetdl6IDZA8ot0PT98umpnmiNZwhURYgq4H5w?=
 =?us-ascii?Q?5LdTOOyphcM/Cb6o+TbQKWVIf6g1wnCuZ0FkhVsUZcloBzjhCdqFUjOAs593?=
 =?us-ascii?Q?DoQGklfvVs/hFBekH5dEOezXAJ2As/FkLj1fveFJShSwSEEM07wlKfxlNM32?=
 =?us-ascii?Q?QXlblJ/DTVdXEIHCmR5vTqR11L5ZH8qZckd8EZm0CRfJXjF2EP+F7/aV5bBC?=
 =?us-ascii?Q?PRsxtCD955J5uq7MPGepyIR9LpWC8n+aUxfaChmT3eAWm76zJQqnvydiDPP8?=
 =?us-ascii?Q?X4TjL6+Xzqo3sx4AJr1WnapULwUuAZGAkgLOIA0tC8bH2JWP+U6mXR2wx1hx?=
 =?us-ascii?Q?H6QT9vMhdFo5p/1U+X8nqp3jj9gLiqe3MeZBiCGTE0noZxYK8jGPvFu2jkep?=
 =?us-ascii?Q?tOwRentD5yt1HrCQoo+sKIc0X18IBinovLnt+47IVRjfUrM5v9xhsjLtWuSe?=
 =?us-ascii?Q?d6mhrF2AO2bL87UFZiynwDgTwYBn4NtewQzG0PGfEELQykkl2KrUjD3Tb/TF?=
 =?us-ascii?Q?i1zVo0nzOMPdq1Fl6cWFxOBDsw2UcmwA1occ1xfWkcfIgdYu3X9XJwnGz431?=
 =?us-ascii?Q?i5+07kdX9dHJ1SZ2T26As3OlBY3YScoq8t+FsGMlu1Vr/IhccTyGRLQi5TpB?=
 =?us-ascii?Q?TFjIhBQl3iG1OsQDnVLXplWyIq7i22JkGqujZO+hX+IaTUNILJ+RE84PK0hp?=
 =?us-ascii?Q?+kd0BADqyDl0SFPVlmWmd3c9S39ZImlb6rNxBhK/1lh3JpNbvdG8anUIGVyV?=
 =?us-ascii?Q?4TduEVAYGPnMOqm0vZ42opE6S8+g/zAeFTDOJ659BRhNOGTUe6qwXCl9CH0Q?=
 =?us-ascii?Q?6WeTYO7GUpIby+w2Fr1nzvYOMiokmwha0F0L7ZJFKkkLSSOB428hPrwoEAEk?=
 =?us-ascii?Q?muV+RyDjNjNv0kPrIEPofBjXXgyhtcm6tF4G8O7lW1Hw2BL/t3fFpF2BGGoF?=
 =?us-ascii?Q?fxIhepk=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 29f74e71-09ee-4338-c127-08deba6dee4e
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 May 2026 14:57:24.4956
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR02MB7798
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[outlook.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	R_DKIM_ALLOW(-0.20)[outlook.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_FROM(0.00)[outlook.com];
	RCPT_COUNT_TWELVE(0.00)[16];
	TAGGED_FROM(0.00)[bounces-11188-lists,linux-hyperv=lfdr.de];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[linux.microsoft.com,microsoft.com,vger.kernel.org,lists.freedesktop.org,kernel.org,outlook.com,suse.de,linux.intel.com,gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[mhklinux@outlook.com,linux-hyperv@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[outlook.com:+];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[linux-hyperv];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,SN6PR02MB4157.namprd02.prod.outlook.com:mid]
X-Rspamd-Queue-Id: C2BAF5CBFCF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Hamza Mahfooz <hamzamahfooz@linux.microsoft.com> Sent: Monday, May 25=
, 2026 4:36 AM
>=20
> On Sat, May 23, 2026 at 03:27:54PM +0200, Berkant Koc wrote:
> > Two independent issues in the synthetic video driver that both stem
> > from trusting unvalidated host data.
> >
> > 1/2 bounds resolution_count from SYNTHVID_RESOLUTION_RESPONSE against
> > the supported_resolution[] array, and populates WIN8 defaults for
> > hv->screen_*_max / hv->preferred_* in both the WIN10-probe-failure
> > path and the pre-WIN10 path, so a failed or pre-WIN10 probe yields a
> > usable display instead of having drm_internal_framebuffer_create()
> > reject every userspace framebuffer with -EINVAL.
> >
> > 2/2 forwards bytes_recvd from vmbus_recvpacket() into the sub-handler,
> > rejects packets that do not cover the synthvid header, and requires
> > the type-specific payload size before memcpy/complete or before
> > reading the feature-change byte. Rejected packets are logged via
> > drm_err_ratelimited() instead of being silently dropped, matching the
> > CoCo-hardened pattern in hv_kvp_onchannelcallback().
> >
> > 1/2 is unchanged from v3/v4 and carries Michael Kelley's Reviewed-by.
> >

[snip]

> >
> > Berkant Koc (2):
> >   drm/hyperv: validate resolution_count and fix WIN8 fallback
> >   drm/hyperv: validate VMBus packet size in receive callback
> >
> >  drivers/gpu/drm/hyperv/hyperv_drm_proto.c | 113 +++++++++++++++++++---
> >  1 file changed, 97 insertions(+), 16 deletions(-)
> >
> >
>=20
> Applied, thanks!

Hamza -- which tree was this applied to?

Michael

