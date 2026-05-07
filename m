Return-Path: <linux-hyperv+bounces-10693-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OEkDAy/Y/GnxUQAAu9opvQ
	(envelope-from <linux-hyperv+bounces-10693-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Thu, 07 May 2026 20:21:35 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 67FF54ED5A5
	for <lists+linux-hyperv@lfdr.de>; Thu, 07 May 2026 20:21:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 361A83010525
	for <lists+linux-hyperv@lfdr.de>; Thu,  7 May 2026 18:21:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7612144E044;
	Thu,  7 May 2026 18:21:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="EQSTViGW"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazolkn19010020.outbound.protection.outlook.com [52.103.7.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEA8F3C0623;
	Thu,  7 May 2026 18:21:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.7.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778178084; cv=fail; b=rFc/sF7v7j2BCKZlRhe4VMq7NlZ1ZnKBNx4znBeVfGrtdejJp8cpf9hL1vY66yTVA0npg5O595kMRxp9gzJn1PlxjbXzH73eH29NFoN0mDsQv/hsFVfThMtHltSY7dLJr0bU0LxnKmwfmV7/P3CdXLCLTL1+DmghyHCDUVJdT4o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778178084; c=relaxed/simple;
	bh=dzzJIPA8tN/WU6aEkZiq10oYlS1xvlxUyKfrGuyVDB0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=gRGmyxAjfrlnod5lIC6yvQCtXCPquWOB0demND5IrSat1kb7LBpir3NbnwkB7yh+u5z5LiRAqqbX4JEqZM5aMlkBIcZNJOLWeuMBVMgi5Xjt7qFQ7V3MgY1D+/pRvvmdVYQR256IKCEGX5oaQJ/9YzLo896APfyeM8liRh0eOko=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=EQSTViGW; arc=fail smtp.client-ip=52.103.7.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SuadNKDEvbEBjmmYlZE6jtV2AWp8zK6jz8saZRyRLdLYxiHUg0nb0Z/a2g3q9aBJdpyMJ3YSGdYZKb3l4ELCBy9zIALOS/Sj8oLTmiFzfIi9q3VbbnvrBpMOGyb7iRHDxTpSCmSqpyW0AGKCiHBS2iCwu7ehQ7LUiTshOkS8A5aX2NLgAsT4DKeXjfwy4+IvoK2E9sE8iiU2Cxp2OsQZf3gTpjBaJrbDznjLELuWKdwYvSHrjgtzsqZtWB/2DxNlbhlKTdsjPVOzwO4WGxS21AOenGw2clvZ6QTodJfcbs96jk8Ix5OprqcLDQH5BFTkzlt6xDLwFDy2+D09lOj09g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i2W62nk+PlXhAk2S25cymVQw4AUc4RSYGFQhArFZQKY=;
 b=ZUDBB/mN5Uc0JxKVkOApBRayAF//lLmvegQjd5LJnhm4DZ6HJ3wQlcyOHFEW1oGwVnwvxTK61SWqXhYx4wnPigLDZ7SRNuYC4rNAXlsmwF4RLjQQ3QJd460/cgCOdxc8TZ6MLL4shGnq1UmZn4CE97d4OHhwujOnfWGunMEeZsEgcjDHKjXrMevz4BSEl49cU1NanLlPh+MrKCPHc78/cvee6wSXVCiuei3GkxSLDyVpkTqm49ZPLuiqp2NbhIypwvN6mR0MN/yldnaXOM9fMzBF68N49qvjJHdm853U7ycrZ/mmgGtcblx82YyuH4845kI+0irMQo4NbMp5Bu9JnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i2W62nk+PlXhAk2S25cymVQw4AUc4RSYGFQhArFZQKY=;
 b=EQSTViGWLb8Xvhv5BlGqLgVPcsgPcqHZqaolSvKFmpcamr/9bbxvETiAHafvO/groncq+M+hgpNcCT2U5HsHfuJVzT6Z0ZeLmFkJPXRF8BCJsz33zKALf5HRAbOG3j72zV5M5RYU5TtNEvQl4HuAgRpU9tzxKrw1mMyZc3iT73gdnxhBtKs4P3cjEpuyGJuBl11HnSeXRIvej2SdxhMrOpQ3fZ/6wJp1/Fpt8fgzCOWuaUsDjfsXk0QaCCKSgzyRL1xe8RxWqY6yYTXbLbdwzjFyiHNqzQU8XAY1xx9uSBKRBcZcQnZe3Tfkppk+z6snVkweFGCRGaCBNYyWhPBFvA==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by CH3PR02MB10059.namprd02.prod.outlook.com (2603:10b6:610:19c::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.15; Thu, 7 May
 2026 18:21:20 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::900:1ccf:2b1e:52b6]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::900:1ccf:2b1e:52b6%6]) with mapi id 15.20.9891.008; Thu, 7 May 2026
 18:21:20 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>,
	"kys@microsoft.com" <kys@microsoft.com>, "haiyangz@microsoft.com"
	<haiyangz@microsoft.com>, "wei.liu@kernel.org" <wei.liu@kernel.org>,
	"decui@microsoft.com" <decui@microsoft.com>, "longli@microsoft.com"
	<longli@microsoft.com>
CC: "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v3] mshv: Simplify GPA map/unmap hypercall helpers
Thread-Topic: [PATCH v3] mshv: Simplify GPA map/unmap hypercall helpers
Thread-Index: AQLEyT/u56p58UqNrwhp5FFtB5fEwLQzB4UQ
Date: Thu, 7 May 2026 18:21:20 +0000
Message-ID:
 <SN6PR02MB4157E1222F3E3C85EF7B1F59D43C2@SN6PR02MB4157.namprd02.prod.outlook.com>
References:
 <177756065245.17889.140699174692055235.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
In-Reply-To:
 <177756065245.17889.140699174692055235.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|CH3PR02MB10059:EE_
x-ms-office365-filtering-correlation-id: 99dc17a8-c59d-4973-ba57-08deac657004
x-microsoft-antispam:
 BCL:0;ARA:14566002|15080799012|37011999003|12121999013|41001999006|19110799012|13091999003|51005399006|55001999006|461199028|19101099003|31061999003|8060799015|8062599012|440099028|3412199025|102099032|12091999003|40105399003;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?WcfPsZDYaE85N+XqWxdkk7DR8JQnCo0Bo0sCPybw5kCAc4/Xo4Oy3BceT3eI?=
 =?us-ascii?Q?TQ16WFsmwtKATfez8jwbIqXT/PlZ20tW9zxBlwO4U4aTu86wErPjV1OMXhod?=
 =?us-ascii?Q?Ex9WiWJqkGFuW1yg7AXqISgcXChTdLTdFxCpjtWMl89gESqKRUTARXRSSNjz?=
 =?us-ascii?Q?k7FIWm5KoF9OE/ETz+n/ELN0ALsTBz6YqcLjXtcssZQfi6lhsZUbVuKVVCjB?=
 =?us-ascii?Q?eFimObLjL34aqEdUKixvxoxYB4UDFg6rRKjTBwgagiqyklOH/KE7Ra8JYbJ/?=
 =?us-ascii?Q?cgSiBq2+fDJ8iUs2D3U7XhiEaVVwEuJHbOp/nJbQ7chcXXAX2wl3JNHM5Llv?=
 =?us-ascii?Q?6Y0UZ/XNRDmwrtexk7nOR7pOQF1WlZ2x2p4PDc5ctvzo5rlvu+E3XeKqm4sD?=
 =?us-ascii?Q?mbO0n4eumkUh0+fNmw3pIxBeuQkTtu/hwgbOl1bDIrb6yPBzOxeQh2Sd8hXC?=
 =?us-ascii?Q?WRhwvbE/UjIUxyQbVZIWV3p5AApiUdHluYzSPXaTFUklzTpzCwSKTRD+oHAS?=
 =?us-ascii?Q?roqgvTEIeI2JcxHxpilqYsY7ldCmV+2KU6CtdDX8h74t54uN7O5UGxPse5L/?=
 =?us-ascii?Q?tJHqo3o5dZDQwinGntjxCknyeg98AsHJt6aR5f/dabIIfG6vHVodmNjFx7V5?=
 =?us-ascii?Q?FJp3OzYWbsEe3dN5hbPX2QKoUG89CggMBa4v7uQ4Eu48O67Q3QH7kqvCmJg3?=
 =?us-ascii?Q?cUcvos2EMUSwljz1AmEl1a9VzYVgIU8YjsKF6iKmjvNZ4DspoyVtXe5xfqur?=
 =?us-ascii?Q?Nr61gqcPzzX8BOFtP6M8aIElMekzyFgzPfdoaRfqNPpaWybYvem8tLyROrO/?=
 =?us-ascii?Q?s6hcwCmOtoLpI8Sg9rK7Ipd8/hryPF1g3OrILaDK6KtBRS3SIOxGcvbWCh2s?=
 =?us-ascii?Q?TwgTQ8oUqapRIrV4v22gA4CW9AGz1E9iMHSwwcUjpIU5WSIo4372PUcUj2QJ?=
 =?us-ascii?Q?AKFWspRZXkk4CapLlMldQK7odJXqzI+l4jtuImmRTjwIaPOqRQq8W82xr9OM?=
 =?us-ascii?Q?T416FNHftkkkf4qQbYEIppGS1/Sch639g4WVaX3UbEvnQklN6wS4uMzsoZXy?=
 =?us-ascii?Q?HDMDMaODZPCg3Mex9pws0smo7j3/u2yApucw2z0kLjvJv0P3hDKnhp1FbFBt?=
 =?us-ascii?Q?+pUKDMLO9mJe?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?Fdw58xNZni2/3xga6LL6gtxa4iR0dGO+j/cxOCKE7MQxKpIU/umSxRxsknj5?=
 =?us-ascii?Q?KcG8SgN4WZoEyV8BlD+QGcurXnntfNksLxutiEAThTthEK6HhWG9XeuZwu8a?=
 =?us-ascii?Q?eMLOyo5DJ00w2afCrnmAASdd65jeiK+9/IVMR3Bw1cqP4pQg+6ScED9n7Yt3?=
 =?us-ascii?Q?T+73mmsCTEV1rA7IFcnZmzbF+4IVjZKrjHXlwGYOROqP1NmfRoOSJZEguGw2?=
 =?us-ascii?Q?a9LK5yNGJ3K0hcT2Jx2Aks5B8XQHMJ+Nekr8jQKfNZHfedwXZ2xjjwBjQi81?=
 =?us-ascii?Q?fRHDGXdPKtWGXGBuNf1sKjvZKnLnJCggO8knQ8wv7TE3wYrxwcyyvBIwhpgY?=
 =?us-ascii?Q?FItXEedrsiWdUAtSiLK8WJvNTVAfD2mzqn66/GEO/fkQeaX+tDptuHaNN0mS?=
 =?us-ascii?Q?KZ7EJJ7lxrIpCWOEq943GInFv/kT0Fui5S3QizaDfFka5lHdyjfltbNp5Seo?=
 =?us-ascii?Q?AVgdOytMX5aFr5RYfPAS7OFxnunNawBUsiCjK56SuxbAgaClJC+cifNCilG+?=
 =?us-ascii?Q?DNo+8yyB0U9jcVvTg+UywKWZoWZOVtYhNpjG44kInCAt1i+LPWMz5wdD4pOT?=
 =?us-ascii?Q?k1s97dxX1vqsgfJkLTW3Lmu2Ka5DHdu1oynzKCHhSYMPM/MybF3hij10atek?=
 =?us-ascii?Q?6w349tarsIDMLdnKRKgjB/kalVee8xEay+YLjBFuS5g+fxvSqhv9bTxDVufJ?=
 =?us-ascii?Q?Hjs6PEuyzk2n2DF76NqOlbY4tcQIteIKZOyctNoEOtGtEj9rJ+NRct/2OiNf?=
 =?us-ascii?Q?76avLK5qKG3DAqFV+mnG4HeRhk5T9bqbE++nk7+zf0ktKEY872F/U6qX6Ysc?=
 =?us-ascii?Q?O/DVum6YgRsMEr8FQenbK56sUJnrQ+N370sskvy3ssBHF709kXIVmK3TO/mb?=
 =?us-ascii?Q?o6xLGQs+jWHCTIZYaEDNIGRU6kJBgKBYAboIHEABWZVKaKq/g6s0TByWSH1e?=
 =?us-ascii?Q?UwmrW9axiwCEBxJwyrSEO68Mde0fkPC1oFQc9s8Zc1RwyPyLXkfmBPX9+e4M?=
 =?us-ascii?Q?0si/MJcEOu7Iwv8uBGrVZpgnrFioGo05RxzOpubmnFZeSdG6My7lg2i8LFBC?=
 =?us-ascii?Q?fq+EA3ogHaJIKD8HEOsEsIRZMXY7q9r1VpQbjNqi8MVOX8vfBBo7kvogyayf?=
 =?us-ascii?Q?OK+KDuY099aHUHNSUtAs9uqscGqNewqa1t+d1BYyFIgwg4xiHgV2rTSAGtmV?=
 =?us-ascii?Q?dSup3DcEgKHio+ehhXwq73HS+RsQO7Mr6fAB0JiYyp/3/F+9gOLwumnEZAof?=
 =?us-ascii?Q?1V+JqLJxuzsV9pcmjuH1TtWLYQFi6h5qPa1o1nXwBbWGvt9Ho7D/JSL6IBL+?=
 =?us-ascii?Q?v3JZmz1MWpNnAIy3j0Y2waR7d6LrtAkid0WvvG7uZ8Vau3gfKIFGP4cMABjj?=
 =?us-ascii?Q?40YTp2c=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 99dc17a8-c59d-4973-ba57-08deac657004
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 May 2026 18:21:20.3013
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR02MB10059
X-Rspamd-Queue-Id: 67FF54ED5A5
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[outlook.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[outlook.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-10693-lists,linux-hyperv=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_FROM(0.00)[outlook.com];
	DKIM_TRACE(0.00)[outlook.com:+];
	MISSING_XM_UA(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mhklinux@outlook.com,linux-hyperv@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-hyperv];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,outlook.com:dkim,SN6PR02MB4157.namprd02.prod.outlook.com:mid]
X-Rspamd-Action: no action

From: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com> Sent: Thursd=
ay, April 30, 2026 7:52 AM
>=20
> Clean up hv_do_map_gpa_hcall() and hv_call_unmap_gpa_pages() after the
> preceding bug-fix patches:
>=20
> Move "done +=3D completed" before the status checks so that pages mapped
> by a partially-successful batch are included in the error cleanup unmap.
> Previously these mappings were leaked on failure.
>=20
> While here, improve type safety and readability:
>  - Change "int done" to "u64 done" to match the u64 page_count it is
>    compared against, avoiding signed/unsigned comparison hazards.
>  - Use u64 for loop iteration and batch size variables consistently.
>  - Add proper braces to the for-loop body in hv_do_map_gpa_hcall().
>  - Remove unnecessary "ret" variable from hv_call_unmap_gpa_pages().
>  - Simplify the error-path unmap to use "done << large_shift" directly
>    instead of mutating done in place.
>=20
> v3: aligned changes by 80 colons
> v2: replaced min with min_t
>=20
> Fixes: 621191d709b14 ("Drivers: hv: Introduce mshv_root module to expose =
/dev/mshv to
> VMMs")
> Signed-off-by: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
> ---
>  drivers/hv/mshv_root_hv_call.c |   56 +++++++++++++++-------------------=
------
>  1 file changed, 21 insertions(+), 35 deletions(-)
>=20
> diff --git a/drivers/hv/mshv_root_hv_call.c b/drivers/hv/mshv_root_hv_cal=
l.c
> index e5992c324904a..e1f9e28d5a19b 100644
> --- a/drivers/hv/mshv_root_hv_call.c
> +++ b/drivers/hv/mshv_root_hv_call.c
> @@ -195,8 +195,8 @@ static int hv_do_map_gpa_hcall(u64 partition_id, u64 =
gfn, u64 page_struct_count,
>  	struct hv_input_map_gpa_pages *input_page;
>  	u64 status, *pfnlist;
>  	unsigned long irq_flags, large_shift =3D 0;
> -	int ret =3D 0, done =3D 0;
> -	u64 page_count =3D page_struct_count;
> +	u64 done =3D 0, page_count =3D page_struct_count;
> +	int ret =3D 0;
>=20
>  	if (page_count =3D=3D 0 || (pages && mmio_spa))
>  		return -EINVAL;
> @@ -213,8 +213,8 @@ static int hv_do_map_gpa_hcall(u64 partition_id, u64 =
gfn, u64 page_struct_count,
>  	}
>=20
>  	while (done < page_count) {
> -		ulong i, completed, remain =3D page_count - done;
> -		int rep_count =3D min(remain, HV_MAP_GPA_BATCH_SIZE);
> +		u64 i, completed, remain =3D page_count - done;
> +		u64 rep_count =3D min_t(u64, remain, HV_MAP_GPA_BATCH_SIZE);
>=20
>  		local_irq_save(irq_flags);
>  		input_page =3D *this_cpu_ptr(hyperv_pcpu_input_arg);
> @@ -224,23 +224,14 @@ static int hv_do_map_gpa_hcall(u64 partition_id, u6=
4 gfn, u64 page_struct_count,
>  		input_page->map_flags =3D flags;
>  		pfnlist =3D input_page->source_gpa_page_list;
>=20
> -		for (i =3D 0; i < rep_count; i++)
> -			if (flags & HV_MAP_GPA_NO_ACCESS) {
> +		for (i =3D 0; i < rep_count; i++) {
> +			if (flags & HV_MAP_GPA_NO_ACCESS)
>  				pfnlist[i] =3D 0;
> -			} else if (pages) {
> -				u64 index =3D (done + i) << large_shift;
> -
> -				if (index >=3D page_struct_count) {
> -					ret =3D -EINVAL;
> -					break;
> -				}
> -				pfnlist[i] =3D page_to_pfn(pages[index]);
> -			} else {
> +			else if (pages)
> +				pfnlist[i] =3D page_to_pfn(pages[(done + i) <<
> +							 large_shift]);
> +			else
>  				pfnlist[i] =3D mmio_spa + done + i;
> -			}
> -		if (ret) {
> -			local_irq_restore(irq_flags);
> -			break;
>  		}
>=20
>  		status =3D hv_do_rep_hypercall(HVCALL_MAP_GPA_PAGES, rep_count, 0,
> @@ -248,29 +239,26 @@ static int hv_do_map_gpa_hcall(u64 partition_id, u6=
4 gfn, u64 page_struct_count,
>  		local_irq_restore(irq_flags);
>=20
>  		completed =3D hv_repcomp(status);
> +		done +=3D completed;

A further cleanup: local variable "completed" is only used in these
two statements.  Drop the local variable and just do:

		done +=3D hv_repcomp(status);=20

>=20
>  		if (hv_result_needs_memory(status)) {
>  			ret =3D hv_call_deposit_pages(NUMA_NO_NODE, partition_id,
>  						    HV_MAP_GPA_DEPOSIT_PAGES);
>  			if (ret)
>  				break;
> -
>  		} else if (!hv_result_success(status)) {
>  			ret =3D hv_result_to_errno(status);
>  			break;
>  		}
> -
> -		done +=3D completed;
>  	}
>=20
>  	if (ret && done) {
>  		u32 unmap_flags =3D 0;
>=20
> -		if (flags & HV_MAP_GPA_LARGE_PAGE) {
> +		if (flags & HV_MAP_GPA_LARGE_PAGE)
>  			unmap_flags |=3D HV_UNMAP_GPA_LARGE_PAGE;
> -			done <<=3D large_shift;
> -		}
> -		hv_call_unmap_gpa_pages(partition_id, gfn, done, unmap_flags);
> +		hv_call_unmap_gpa_pages(partition_id, gfn,
> +					done << large_shift, unmap_flags);
>  	}
>=20
>  	return ret;
> @@ -305,7 +293,7 @@ int hv_call_unmap_gpa_pages(u64 partition_id, u64 gfn=
, u64 page_count_4k,
>  	struct hv_input_unmap_gpa_pages *input_page;
>  	u64 status, page_count =3D page_count_4k;
>  	unsigned long irq_flags, large_shift =3D 0;
> -	int ret =3D 0, done =3D 0;
> +	u64 done =3D 0;
>=20
>  	if (page_count =3D=3D 0)
>  		return -EINVAL;
> @@ -319,8 +307,8 @@ int hv_call_unmap_gpa_pages(u64 partition_id, u64 gfn=
, u64 page_count_4k,
>  	}
>=20
>  	while (done < page_count) {
> -		ulong completed, remain =3D page_count - done;
> -		int rep_count =3D min(remain, HV_UMAP_GPA_PAGES);
> +		u64 completed, remain =3D page_count - done;
> +		u64 rep_count =3D min_t(u64, remain, HV_UMAP_GPA_PAGES);
>=20
>  		local_irq_save(irq_flags);
>  		input_page =3D *this_cpu_ptr(hyperv_pcpu_input_arg);
> @@ -333,15 +321,13 @@ int hv_call_unmap_gpa_pages(u64 partition_id, u64 g=
fn, u64 page_count_4k,
>  		local_irq_restore(irq_flags);
>=20
>  		completed =3D hv_repcomp(status);
> -		if (!hv_result_success(status)) {
> -			ret =3D hv_result_to_errno(status);
> -			break;
> -		}
> -
>  		done +=3D completed;

Same here. Drop "completed" and just do:

		done +=3D hv_repcomp(status);


> +
> +		if (!hv_result_success(status))
> +			return hv_result_to_errno(status);
>  	}
>=20
> -	return ret;
> +	return 0;
>  }
>=20
>  int hv_call_get_gpa_access_states(u64 partition_id, u32 count, u64 gpa_b=
ase_pfn,
>=20
>=20

Michael


