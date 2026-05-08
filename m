Return-Path: <linux-hyperv+bounces-10720-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CN3CAgcP/mlrmgAAu9opvQ
	(envelope-from <linux-hyperv+bounces-10720-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Fri, 08 May 2026 18:27:51 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 061AD4F9714
	for <lists+linux-hyperv@lfdr.de>; Fri, 08 May 2026 18:27:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 19A5630074F2
	for <lists+linux-hyperv@lfdr.de>; Fri,  8 May 2026 16:27:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCB8F3D75B1;
	Fri,  8 May 2026 16:27:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="nX/Lfx27"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazolkn19013089.outbound.protection.outlook.com [52.103.20.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3552437DEAF;
	Fri,  8 May 2026 16:27:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.20.89
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778257664; cv=fail; b=cpPy514xQYvmCe2Y/xbbGpGBPIRfhe+dB/0b+jz9w3AU+ZiNcfzDRqC8gt+MpHf2mWAkEkqoTRZU2JIAIi13lBRMsuvQBWS3yo+suzgGqLxUoge5LtYl5thNldVJ4DNBcBQMUeRq4ulCjNPHVe/LurziDlq/XOIPJIhfv6l9sFY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778257664; c=relaxed/simple;
	bh=3fCZUNFWfkRt6ZKIZSJrw8V3lo4unKpNH8juZl07jS4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=UvnNSQ4V4JhvwLThrVkzTM6rHR5vy+DrW0KAqvRpDm4fMFd5jHwPC2n+7JQqg6aSp+cY3snGhSzU5mlx5ryIwIIkt7Vni3Ma5TErFL31rhBhUBdH183VgDBloDbRuDvd46KU3aE0rk6yV8hlS2bVbufqwJhch40pDEKPwCzCyFs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=nX/Lfx27; arc=fail smtp.client-ip=52.103.20.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JAUVbAmQ/r8m5uKfWExaSd7g3exzXw7EogDkAofwTIFO6jt2mF66txdaawMslO1llGxlS157Qm0BG7/I81VX2IW+KHe0MA7K7RRUKDnlX3i0bwEszv6luAGPN6VIHEzeLaj6yoAnyYvMa8cfQAJHRAKGltPBWxF6m6/N6/+8fCjNG0ooCSDhS4GMVkLJaiBeuHW4po08SPkceRKCI3s7ciwjfv5VK875g5/Ck806u2miFXtroghYx7dVbH31eZFaMwhWAk9iprBQJyWS0TbN8Cuetj0NOhxfsEGwvAdprSc/ggNPbvBEPzWZHx4bWLRh8kmzzEMtkR5T6FRe56WSpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2nK44sliE914yUq3ZHHuN8JwUsZ6tdMlBQLzAc5pFks=;
 b=dWROrrqG2YpRA66ofWVfueeAOcJaWfXOhkM42E1cAr7erIFSnBmwGVBEu7+VOtK2t/5Jw3SSyZzvnJmjpX0Y7nGhnsUTOc11sH84H3cXin6egT7pkUY3Wo04WRdoxW43Nk6Q8NWgDE4OsQmd+UdatMOWKX1SbsuIFgKOQ/BUPDFMYd0fGEaitvCngjwjf4nbbL4qQh4JlKp6Ccu40pX9nkspzwSFIO/dNzmaTSOiuHnZ3aGNibsgLAZm1inBdRYQc1CK/bOm7yKNBSnXNF02eGNpVzspdb0sErE6CPUfMC20hoHPFBtGOwsmA1DNjlZC1GcSHdSoa8Z2onlu4pE/9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2nK44sliE914yUq3ZHHuN8JwUsZ6tdMlBQLzAc5pFks=;
 b=nX/Lfx27FmIZ/cF567gmStqczqMlZYwje48RqKi+EdnSsxDkg1k/IH1eIoL2DuXv3ZDLH6Eepnw9ns5n0RllMcpNJIh6AO8j60fD2RqA1eRsRLPhNfZSwQqkx81/JSNHqykF36UiksgbAFjNLBk9Z0E9gFJ8Dl/AsHDE/lrv9FyntCWkzZU+7x4UAmyH0z21IZc114gA2/J3UxbCmr/1mZe3orbjV9lW4Imno3r6yRkP7kLTW6iFn31urXBMc58BCY6yFZdIVwSfjPqgNMIq8TaUJx32ut3BdisI3AJLp54XsmzOGYV6pN1GCgucrt/Um2IQvLZsw7woUtWxBM+OVQ==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by MW4PR02MB7202.namprd02.prod.outlook.com (2603:10b6:303:7b::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.19; Fri, 8 May
 2026 16:27:39 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::900:1ccf:2b1e:52b6]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::900:1ccf:2b1e:52b6%6]) with mapi id 15.20.9891.019; Fri, 8 May 2026
 16:27:39 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: "Anirudh Rayabharam (Microsoft)" <anirudh@anirudhrb.com>, "K. Y.
 Srinivasan" <kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>, Wei
 Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>, Long Li
	<longli@microsoft.com>
CC: "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v3] mshv: support 1G hugepages by passing them as
 2M-aligned chunks
Thread-Topic: [PATCH v3] mshv: support 1G hugepages by passing them as
 2M-aligned chunks
Thread-Index: AQIvXS4g03wegVw2OM69lsL0rBxQLrVfOqbA
Date: Fri, 8 May 2026 16:27:39 +0000
Message-ID:
 <SN6PR02MB4157F88AC063966319373AE9D43D2@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <20260506-huge_1g-v3-1-26e1e4c439e4@anirudhrb.com>
In-Reply-To: <20260506-huge_1g-v3-1-26e1e4c439e4@anirudhrb.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|MW4PR02MB7202:EE_
x-ms-office365-filtering-correlation-id: 5666e40f-c0b3-4060-4919-08dead1eb8e6
x-microsoft-antispam:
 BCL:0;ARA:14566002|19101099003|31061999003|55001999006|41001999006|8062599012|12121999013|37011999003|51005399006|19110799012|8060799015|15080799012|13091999003|19061999003|1602099012|40105399003|440099028|4302099013|3412199025|10035399007|102099032;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?Z63Pp16K8hlAqpQj538G8aSP4O+UOyd6CdaZsNMFHNWHSdeYB/Ifl7WmbShD?=
 =?us-ascii?Q?7LPkIBVtVXYlEOmIaIdFKcQVu5iyza1mFekjXq3UHYJlx+J+hn7aO7OUgC5O?=
 =?us-ascii?Q?jFuQ7buxTCA90yTvYhUOmkorVI6PlII0cUBDtNjkUJfkWLEjGhztYndlKeO1?=
 =?us-ascii?Q?HhXI6Nns61nD0neEycJ33+RcaYlMOrEQU8PIw6GDRdDw+uGqHLb60N4zvjs9?=
 =?us-ascii?Q?COCjeNEfn61B2WUejvCzN4BFQ3xFF2OpTwXhtqWDX7TW13mLQgu1XcPwViNs?=
 =?us-ascii?Q?IRsJSbESWYI75tRz3KZaKNgqCo+yMe+F2I3VDjN8Jy27Ef/TNx/hcOAuWKAy?=
 =?us-ascii?Q?RPS2oi30Fil8OZ0FkyGh+Xdshl+EKNRRlhL+jTjPIGKwt0eF+47tmGkVUUSO?=
 =?us-ascii?Q?UwLh1W54XoJCd5o3WA/QSXNiTve2OCpXPYGpWGIvbTL595jWdiydGhh5ryac?=
 =?us-ascii?Q?yI72ao6q9iaxTT0u/hqZKPXAHtW6u3Ejks6rv7bw2myON53wd8F2RS6Un6qm?=
 =?us-ascii?Q?ofjuAcWCazl7vMGi/9yribfuuRfJSrZ1rzK5yhBGmmMigyQaCHIgnueRar6X?=
 =?us-ascii?Q?hpesFA/yolg+O2y8BPY21GzUN0q5iurZqxQLVba3JRhXY9PEAisxpVQuj3wJ?=
 =?us-ascii?Q?7n6oxEmkxOifVOf2lmQg0BwvsVCAtYMiufr2l0wf9fESTw8gUeH+V8HaXc34?=
 =?us-ascii?Q?NEo8+oPOhFFPiEpNljkNWnkheQQUH0br6s+KsFuuSYafRbjWC2icLu6V6sgL?=
 =?us-ascii?Q?UD5LWApbqnRqPT1DI5s1oC3xIVwgKoGet1NzQyxLW18nG3He3WNEmSh5UaUC?=
 =?us-ascii?Q?CUT/+Ikf16BJsH84mjMjMn43gT/GZUi2AYwYCCrrzwwtHIf1ZJ93TosaHxnQ?=
 =?us-ascii?Q?69pP8rTpYJp7d06o/oUdYKWIIG0qSBLntlDV25UseZURABrFUZMkj9Bzr3XT?=
 =?us-ascii?Q?ELbUBynkmvjsVg/sQ4jzZFULlQ3DK8f6ax/Xa7Y47XZ4LkzUW2E/J/85urUi?=
 =?us-ascii?Q?AurDuO4Ab1NaYqanlCXQg9EhKoySxSrnJuhXUkuKMaMYgwteO/p/yY3+wyNs?=
 =?us-ascii?Q?/4D0jSO3MehswWPgpkwjnP76Zlub0nqDscNTeGKXrIrivdRK6h3PsQMp61qo?=
 =?us-ascii?Q?7zjH/1K5UWoa18Tjo2P3kTBXpt+axokfoOM445lUMbMMS4fvJqfuT2LIDlyG?=
 =?us-ascii?Q?3h6vwivp2mr6C2B8AA833m7kpXAvLtssEXHfb3HyXUU5FzIMgsx2K83ChBs?=
 =?us-ascii?Q?=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?/NmThIhQ8qq3ViH2gpV7Tz0/H72YajqLP0vFofxXloO7lHLRde1+H9Bl1Dv8?=
 =?us-ascii?Q?smF8tKlEG4LHRnEqJKAHCztURek5VbEy4TnYbecSuQoXC2ORWE6+AqrUgo88?=
 =?us-ascii?Q?m9Jo63mrrneT5RxyCG1/vWgXQWj3S7Phm3v8q7c6fRy2ZFhT0TPA9qmd7n4A?=
 =?us-ascii?Q?5VH8d1CSLipZdKWb0AvidvDQ2iqemOLlNCOmbXIzTjmYLiPY+f2v6rw2WLDk?=
 =?us-ascii?Q?Qbzv4gEsPtpQNvif7mVwbo9RsK92dpNxFBcUR3n3PaoESzCOwqMyHJG0Rb2l?=
 =?us-ascii?Q?i5eGE8Zenu133GViZZ33+f/ORm6jeAL92zNR20JasppRwPiFWNAndtzapX6/?=
 =?us-ascii?Q?OEE4a5eRNMNAz7Dtmu7WVyGciEBH7k7VziIhP7FzGBS7sikTJLej3BDPr4Od?=
 =?us-ascii?Q?4mRlqWPy9/jFXUhfESdhr93AX3knmlx0LMwBdQRSoTKuMAkPBjH8y7FLOtLM?=
 =?us-ascii?Q?H1yYDkVwaNXrfl3dCHcVBeiQ/Eb4FAELvTcJsxSD6dq5GA4s/icRzYAD20hG?=
 =?us-ascii?Q?vze35NzIwYLuomezIkXQF8SVnpEWdGKEuPBQ/dQuorvnUFVG5a9HgmGfxyP+?=
 =?us-ascii?Q?k6q3sUBPMVRrJftefvak0HWwYQfYBab7AniZxWaNdrzYPuflhW5UleW6qy6F?=
 =?us-ascii?Q?Rq8hchcAd4Inq3EEywvOIxe0TYhu46N7OvDMxgYcxAI4QE+YBkC44UzCdpGq?=
 =?us-ascii?Q?YNZODrzIN/gehyi15PWJ1vmrFnxZbhrEgHEcqkSXA31XofJ0LjcSy4MAyLwf?=
 =?us-ascii?Q?hKN3QGOOJa27FEsm7FbpCTNdSNnNJt2naIFU3g1jYWz6xQGvWEfSGLB6D0aZ?=
 =?us-ascii?Q?4qYmjM34Ja60pYEnWWM5q6OjazEzI9EjhmkOj5U+jIj0yIN0wI874k6xTul2?=
 =?us-ascii?Q?OxG0dpq/Q6IygWpFw/kQ8XAEVezBXS1GBIm9IGIwRkTZCVb1N88vO55SI0ZH?=
 =?us-ascii?Q?ZouTZGQ1TCBpsSYgLvPhPt5tJeTQRgmdjhxPkVTwHw0V9NC0yAt53CtJxgsh?=
 =?us-ascii?Q?tmoMWyDWgUDoPvM38XpC6i/C9wnIv5pYZODkdic7OHD1n35Lcn9FQ1kl+q+K?=
 =?us-ascii?Q?DPJpFMcOcEqxxNBOQqOfAYdz8y7K1mq0wTe3mQ2B38+9khBjZIwvWELz/dst?=
 =?us-ascii?Q?N0ekHAKyJRV1ATbtUfUkG2miSFa/HTCME7XD7pkz+427PHOGwi4YtiDS8CZ/?=
 =?us-ascii?Q?ZVe1cWaQiGLJA9vkVxbg3RVd+e2YZbGUyMksC3SoWvpRhjV+InDbpMon9/PD?=
 =?us-ascii?Q?dLP/zbt7iB+0xhJ+GuZ5uczkI63HhhMLJrAV5KdF6G3JLeSbDNlOjMBI5Zrp?=
 =?us-ascii?Q?Drf3cvO3v7Oh9ZZejumGLul7Ou9rxvMfiju48Snnlr8kzIR7mNQSZ9+OfVyS?=
 =?us-ascii?Q?RGsvgmU=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 5666e40f-c0b3-4060-4919-08dead1eb8e6
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 May 2026 16:27:39.5373
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR02MB7202
X-Rspamd-Queue-Id: 061AD4F9714
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[outlook.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[outlook.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-10720-lists,linux-hyperv=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-hyperv];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,outlook.com:dkim,SN6PR02MB4157.namprd02.prod.outlook.com:mid]
X-Rspamd-Action: no action

From: Anirudh Rayabharam (Microsoft) <anirudh@anirudhrb.com> Sent: Wednesda=
y, May 6, 2026 6:45 AM
>=20
> The hypervisor's map GPA hypercall coalesces contiguous 2M-aligned
> chunks into 1G mappings when alignment permits, so the driver can
> support 1G hugepages by feeding them in as 2M chunks. Note that this
> is the only way to make 1G mappings; there is no way to directly map
> a 1G hugepage using the hypercall.
>=20
> Update mshv_chunk_stride() to:
>=20
>   - Accept 2M-aligned tail pages of a larger folio. The previous
>     PageHead() check rejected every page after the head of a 1G
>     hugepage and fell back to 4K mappings for the remaining 1022 MB.
>     Replace it with a PFN alignment check so any 2M-aligned page of a
>     sufficiently large folio is acceptable.
>=20
>   - Always emit a 2M (PMD_ORDER) stride for the huge-page case. The
>     hypercall has no 1G stride, so 1G folios are processed as a
>     sequence of 2M chunks. Folios whose order is neither PMD_ORDER nor
>     PUD_ORDER (e.g. mTHP) fall back to single-page stride; mapping
>     them as 2M would fail in the hypervisor anyway.
>=20
> Assisted-by: Copilot-CLI:claude-opus-4.7
> Signed-off-by: Anirudh Rayabharam (Microsoft) <anirudh@anirudhrb.com>
> ---
> Changes in v3:
> - Fixed various corner cases reported by Sashiko.
> - Link to v2: https://lore.kernel.org/r/20260505-huge_1g-v2-1-
> b6a91327a88d@anirudhrb.com
>=20
> Changes in v2:
> - Handled the case where we can have 2M aligned pages in the middle of a
>   1G page
> - Brought back the page order check but expanded it to include 1G
> - Clamp stride to requested page count in mshv_region_process_chunk
> - Link to v1: https://lore.kernel.org/r/20260416-huge_1g-v1-1-
> e066738cddfb@anirudhrb.com
> ---
>  drivers/hv/mshv_regions.c | 32 +++++++++++++++-----------------
>  1 file changed, 15 insertions(+), 17 deletions(-)
>=20
> diff --git a/drivers/hv/mshv_regions.c b/drivers/hv/mshv_regions.c
> index fdffd4f002f6..1756b733968c 100644
> --- a/drivers/hv/mshv_regions.c
> +++ b/drivers/hv/mshv_regions.c
> @@ -29,29 +29,28 @@
>   * Uses huge page stride if the backing page is huge and the guest mappi=
ng
>   * is properly aligned; otherwise falls back to single page stride.
>   *
> - * Return: Stride in pages, or -EINVAL if page order is unsupported.
> + * Return: Stride in pages.
>   */
> -static int mshv_chunk_stride(struct page *page,
> -			     u64 gfn, u64 page_count)
> +static unsigned int mshv_chunk_stride(struct page *page, u64 gfn,
> +				      u64 page_count)
>  {
> -	unsigned int page_order;
> +	unsigned int page_order =3D folio_order(page_folio(page));
>=20
>  	/*
>  	 * Use single page stride by default. For huge page stride, the
> -	 * page must be compound and point to the head of the compound
> -	 * page, and both gfn and page_count must be huge-page aligned.
> +	 * page must be compound, the page's PFN must itself be 2M-aligned
> +	 * (so that a 2M-aligned tail page of a larger folio is acceptable),
> +	 * and both gfn and page_count must be huge-page aligned.
>  	 */
> -	if (!PageCompound(page) || !PageHead(page) ||
> +	if (!PageCompound(page) ||
> +	    !IS_ALIGNED(page_to_pfn(page), PTRS_PER_PMD) ||
>  	    !IS_ALIGNED(gfn, PTRS_PER_PMD) ||
> -	    !IS_ALIGNED(page_count, PTRS_PER_PMD))
> +	    !IS_ALIGNED(page_count, PTRS_PER_PMD) ||
> +	    (page_order !=3D PMD_ORDER && page_order !=3D PUD_ORDER))

One more thought on this patch:

This test could be unnecessarily restrictive. For example, if
there was a 4 MiB contiguous physical memory allocation,
page_order would be PMD_ORDER+1. There's no reason to
map such memory as single pages. While today there may
be no way for the user space VMM process address space
to be populated with a 4 MiB contiguous physical memory
range, who knows what the mm subsystem might do in the
future. I'd suggest doing (page_order < PMD_ORDER) to
allow page_orders of PMD_ORDER or bigger to be
processed in PMD-size chunks.

Michael

>  		return 1;
>=20
> -	page_order =3D folio_order(page_folio(page));
> -	/* The hypervisor only supports 2M huge page */
> -	if (page_order !=3D PMD_ORDER)
> -		return -EINVAL;
> -
> -	return 1 << page_order;
> +	/* Use 2M stride always i.e. process 1G folios as 2M chunks */
> +	return 1 << PMD_ORDER;
>  }
>=20
>  /**
> @@ -86,15 +85,14 @@ static long mshv_region_process_chunk(struct
> mshv_mem_region *region,
>  	u64 gfn =3D region->start_gfn + page_offset;
>  	u64 count;
>  	struct page *page;
> -	int stride, ret;
> +	unsigned int stride;
> +	int ret;
>=20
>  	page =3D region->mreg_pages[page_offset];
>  	if (!page)
>  		return -EINVAL;
>=20
>  	stride =3D mshv_chunk_stride(page, gfn, page_count);
> -	if (stride < 0)
> -		return stride;
>=20
>  	/* Start at stride since the first stride is validated */
>  	for (count =3D stride; count < page_count; count +=3D stride) {
>=20
> ---
> base-commit: cd9f2e7d6e5b1837ef40b96e300fa28b73ab5a77
> change-id: 20260416-huge_1g-e44461393c8f
>=20
> Best regards,
> --
> Anirudh Rayabharam (Microsoft) <anirudh@anirudhrb.com>
>=20


