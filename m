Return-Path: <linux-hyperv+bounces-11815-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id xs1aMM6VRmrQZAsAu9opvQ
	(envelope-from <linux-hyperv+bounces-11815-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Thu, 02 Jul 2026 18:46:06 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B4A46FA831
	for <lists+linux-hyperv@lfdr.de>; Thu, 02 Jul 2026 18:46:06 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=outlook.com header.s=selector1 header.b=MX9BnE0P;
	spf=pass (mail.lfdr.de: domain of "linux-hyperv+bounces-11815-lists+linux-hyperv=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="linux-hyperv+bounces-11815-lists+linux-hyperv=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=outlook.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 75ADD30A3218
	for <lists+linux-hyperv@lfdr.de>; Thu,  2 Jul 2026 16:39:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 706E633F583;
	Thu,  2 Jul 2026 16:37:38 +0000 (UTC)
X-Original-To: linux-hyperv@vger.kernel.org
Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazolkn19011009.outbound.protection.outlook.com [52.103.1.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B301341077;
	Thu,  2 Jul 2026 16:37:36 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783010258; cv=fail; b=WqEVA+Y3YV3FXuSRvO9qHJrfNuakgTP50s8X4/q4tD7FLYv9r8VQ97EI4txmn8mzkAbW6CBoRhkIvDhiDTlo1+A/PF5DPegT6CRpEeBThz9SUbI/TJ/MhFN17ZfCekiw4OXeWwM0ZkcQHs2JmsYMFvryMCqmzcLn2+3XV8+vEUc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783010258; c=relaxed/simple;
	bh=5/w3JzO+AkzwmRFJCnLrzRdxa9qrlO6//2tPS3sFqus=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=KJMztWzc3EYi/y7CM7imDWURJhSSm8UV8hAlT3isu/oNpvju2tP9ec+VZgj53PUfY3cDl+gDpPalgfwUdJT64cimIgiDkr3XBIrlC6NRJdzTjDtrPTIIlTgHA/fseOhhKx7CJt1Ev8HfJUSBX7mj3fchniOgXKSXk7NwQ0vbVhM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=MX9BnE0P; arc=fail smtp.client-ip=52.103.1.9
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TjyGbjYrMfcH/3NWSuwcgQYp0A/4ccW+OwrQJGwAnrO48deX//9wIis4/sOeN/I+Q8wsGopKNJSeVpEUo9Q6EsYz2QltjYbmPpF4K0w9caZUJ3EObdRaI4K9/ncl6mF+PLeWgoRa0bfckI2DW/8KI/PGrk/+8U7vIvGVMANR4Lip+MzDLKrUiylF3MXVmciUefDErxtzUzvSqDWAfOaVexCSBZWLFL4JpZAdpcoYWbbSEurPRPPcIY9ezTR0zFUNAS8WpR5XE20xh/81rKEfshwn60HdK9Vf2hiFHOB5ycTqosnpv6SW4ux2MiPjTdddfxpYErW0JfAj+5TJyEM7lg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ES1O9YJGfOC3eFy1PD04gtlBWvYNQs7UIs08La0NjdI=;
 b=LZKyzNOgsuYWV6Pv3clHRhViWnJ9jTaEVLNL/AOotWAI77ElkitMii9hl6SlHTBz04z+HhVpeBqEPyrxrlGbyBZKyQe8/V0Apze/Fp25BzkhxCYq73JioN1L4GIxwW75amF+xhq4fXhsb+sDoI8Oy/2rqA9+ueDy03II5CItfAXCdDISds+3WghmA7JIAIqv8ncSKGOl7AJzayjRdB0uD15+pHdHPj4+GexWDD4YVV2eRg1DnQtxwas+E/bmjIQ57QEH83QEQaQv7dHIdvMYZmdgBuTj2nHOYpvgFg5cUveS7IpvMmP14iQLL0UAqQQ7XsYTgb7KBQOxd+LUxGMRsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ES1O9YJGfOC3eFy1PD04gtlBWvYNQs7UIs08La0NjdI=;
 b=MX9BnE0P1wUd0MNvmz4pGJTNWd3Td3e/vvplZWgFbN3P3jZa6fAp/JBsuXuySKxxQe3OzjusSSXw3B0QC6avs/YstXx+5iKmYWBR/+QW0BMsodwoZzHGcQ0V6DgmfgIehlXmsKrBeQ/ZlAUxc9I8G35HfxjV3WCxzNoTnh6Axk73jSMTvcM/A/DYV1XVhp9+lX9xkh8tTDyxgsu8U+UjrDFUDUV0R7rGsJOOiHxbP4vfl/clqpfw8uWB4wGinl/jUL9UXM1gVKVcXVzyr/RqC3VmbQvu1+G8V4fQlfemd7iO8sRHCRjH0huIag2qSqGaSpQ+6uNIUvnn8idZpFsqSQ==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by DS7PR02MB9626.namprd02.prod.outlook.com (2603:10b6:8:ee::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.10; Thu, 2 Jul
 2026 16:37:34 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::900:1ccf:2b1e:52b6]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::900:1ccf:2b1e:52b6%3]) with mapi id 15.21.0181.008; Thu, 2 Jul 2026
 16:37:34 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: =?iso-8859-1?Q?Uwe_Kleine-K=F6nig_=28The_Capable_Hub=29?=
	<u.kleine-koenig@baylibre.com>, Dexuan Cui <decui@microsoft.com>, Long Li
	<longli@microsoft.com>, Saurabh Sengar <ssengar@linux.microsoft.com>, Maarten
 Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard
	<mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, David Airlie
	<airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, Deepak Rawat
	<drawat.floss@gmail.com>
CC: "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v1 1/4] drm/hyperv: Unregister pci driver in error path
 before module unload
Thread-Topic: [PATCH v1 1/4] drm/hyperv: Unregister pci driver in error path
 before module unload
Thread-Index: AQH1T0mALjaVnIZyp+48CYNcNiSnwgKLiPUpthV/QcA=
Date: Thu, 2 Jul 2026 16:37:34 +0000
Message-ID:
 <SN6PR02MB4157A80CB2D95AEFC6F33A89D4F52@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <cover.1782925276.git.u.kleine-koenig@baylibre.com>
 <4b7dbf00ce4ff664b7d5dd74b2f39d8d87c1ade9.1782925276.git.u.kleine-koenig@baylibre.com>
In-Reply-To:
 <4b7dbf00ce4ff664b7d5dd74b2f39d8d87c1ade9.1782925276.git.u.kleine-koenig@baylibre.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|DS7PR02MB9626:EE_
x-ms-office365-filtering-correlation-id: 5a8b4bd7-9f36-4a82-c818-08ded8583834
x-ms-exchange-slblob-mailprops:
 feAVlmA1hHWA2BEffU3cZHEVyr7UW34wPzQ+EZd1sL1piOxC7LpGqO+5qVWSDUos+Q8Yh5P+zBbQrEMUoFTo1pz8s3CjlnuxRnbiJNWZG2sCAXpEaE00H8tFJqOGuxaU9999DlvynJz+ObjKFs2SWUUIqeLO+0qOVHtTIfKISGhacDAoIdleGVhgyJQkGHgIXJMG48TU/uh1vKVDhfA7W3S/4Yrudv9TJ1lRjSuUfSVeSAefvuM8qHSULFr/x2KaXe9nY6JVCUWhMsz6h53CuZU23pmnq7ly1HU0yGCcznH8nskDiruDcavLQ2GjV4769dWrBE9U6GLpDJi6b/BasU487vBzCJwgDI5aIxegDpDYeV+MiYtdMpiUDSUP/zXxvSV/pEcMOAyjb9F/ytQn5PgdcghjmnT5Vh05lEYhNehTPsguGQyxExHKxIFEV5oT5EHYDAZB3OBvMsgExw3s31ssuMjbWswyoM7aCTxhMuSxUuJEXJFxU2dJshu8nQqOcLM9uGxSGEQ52ZnDhLS9VGZ40BUTJ8UksjdXAj0RgjA/0hUA6vf34cY7IskJuJWxX3eGbve+KmdnxFctNwmPjQRRDZ91YBvrZsdsmRiVVAgv3A5NVSqjVFnwYTb42YfjfcNRKKsUz8Cbcy8A0oycu2xxMbrIFHY7nlRgzvCuLdpnicMD5cQuIHuUs64linJGcDoEn6MLGdf2oqAJna5ilA==
x-microsoft-antispam:
 BCL:0;ARA:14566002|37011999003|25010399006|4140399003|15080799012|12121999013|19101099003|31061999003|8062599012|19110799012|51005399006|8060799015|13091999003|41001999006|3412199025|440099028|102099032|40105399003;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?biMPxtab9l83rOHCJn1Jn4fTYv7ywLAf79Pd7nFy0HNhLUEOPRsvQfeidF?=
 =?iso-8859-1?Q?24CRdG9eGXy7guADFZwbOdaca/+JDDS1W5CyAIT71OaJo+EndKaJLO+lN+?=
 =?iso-8859-1?Q?KF8tBFR2JZYrBlveK+Nw+tUk0sKvc5lr1NEu3/bl9CtyfsJNpu6YiVAsFJ?=
 =?iso-8859-1?Q?peW8RTYGeFGI31tPim8zjncgbYRxw/GxGHlFhwf5Jdxm0arXKGX8BbV1UA?=
 =?iso-8859-1?Q?8OQfY5IwDPNGcLfNcOur6LfL6Ms2GLZ7O4r0q74dJl4qrgt2SaRgBzlIyi?=
 =?iso-8859-1?Q?f1uST8KqNprThn7o9XkpcjUvTrkRuhHyifbBOYdrmMPttkFtlOFuO8g4b+?=
 =?iso-8859-1?Q?riikLGq8HOz783sv6CDHFZG66Tw311bvQ34TG+7S1i3/LY233dgTVIH8FZ?=
 =?iso-8859-1?Q?yG7fkD8igY2bRqzqm+FmSZC4yMvNu3Wpf6uOo0Fvh99LAb3n92i6M9eZ2w?=
 =?iso-8859-1?Q?yDH2CvjuxcZpJTbIE/iUk2mU9UFxkQTIw8KVhs9WgdMsEfblKDbvZr86Lj?=
 =?iso-8859-1?Q?SqiCfy1XmT2TuKxZ7l1bMP5iUzGNh7WldPbQD2KrbIIfBUAtmsKqu1Tt3A?=
 =?iso-8859-1?Q?jUDDbTDos8vVKjVEqauR8LwuVfQtn9WEyPm5DvW0eIuVTlMvg7Vj3OmKCA?=
 =?iso-8859-1?Q?WK+fCA9KMjR1gOnv+rgXwmYRe3IRld3sU43JzVZrQ6KNooPqGmLaquk6qF?=
 =?iso-8859-1?Q?UUOLsmrWK1ALrVUiQrg6xIkXHf4823aq8i+VylyutDL5g45uG0NiuEGjZO?=
 =?iso-8859-1?Q?YxvjtiHVKcGffYWJ7exwiGFL5m/4AVM6eJ/StukfRjN4SXjux2S2JFc1oJ?=
 =?iso-8859-1?Q?b0yuz72ufL5y+ggOuAyz5TLMHa9mdLuNcpKsv/pFwF682qa/CMpp3Zf3Mp?=
 =?iso-8859-1?Q?4WpAV9AcqlLHU59f8Quqj7eEEc2MyL2Wzg11B2y7E3VFXtBn6cvSq5Qsfq?=
 =?iso-8859-1?Q?35BelFPpJAL87l5SjuU7w1FgZp/kmh0rCubXCnqTwyhlIKbn4f814RhKFs?=
 =?iso-8859-1?Q?OvoFY4vB/gtquAY55Uj91Z5wFNuzF/feuI8IulYyc2nn9/N6uDG+hCnuNy?=
 =?iso-8859-1?Q?G5h0Mt+UyljICxVVxVOXisjmWJj0XETXqV7A1eaKMfiV?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?Bpt3itaO7ow7LxuQhcV4wQhFxLF1z2RjaF8a7gEzZyVcZQIVLbquHAQerv?=
 =?iso-8859-1?Q?MgY7u2o5YJC/nfLQaaRTfOEapsCSP6JEn+loBLjxpVylB72WK/S5sKUS66?=
 =?iso-8859-1?Q?IscjzGLm/mF0XqIUotrFZwU9/9BD3Kw9B9/Kkg60r7mJ2TagDci6dt6XTE?=
 =?iso-8859-1?Q?I69/vhWk0Y4Bd6Y5S9vrn0h4M1/eF3ZhCArUIVXz7ClUTw1nIOSYPwaJR0?=
 =?iso-8859-1?Q?QujBZDX7uaNekjew8pFhGC7g/53pS1w56oMmZSoONaH+d+mzDpmve0U/Yq?=
 =?iso-8859-1?Q?Fg1u/RuCyfncCOS4cYgPWnjE3WvTEkyZyrRUhqWgPV2603wOXo/zCaHKiA?=
 =?iso-8859-1?Q?nA7ElR8DfB2rNnXV5bPXL+dM5Iz1vkHAzucWuOVf/JyIhYjHfDBfc1G8G0?=
 =?iso-8859-1?Q?8OpfDy8/UcG05SSMDu/V6qn4RZy8cHLrwhxLx9Fdujw0CA9Er4X3OkSwR6?=
 =?iso-8859-1?Q?NVjwRsKTBn3+62aHzhwmkcsTWYaDvW+oSFtd/ZNcs18Y7FLKRQ0I/HRyjI?=
 =?iso-8859-1?Q?Q0/zC/HYnFrYOs9Oxo7LNZaIo8tnd/omoKby01NkdU8jUCQMe0OzI3Z3/A?=
 =?iso-8859-1?Q?U2F74hmDI0F0jNq1NIzS/YKTsE+AROYnxZ4KqWJYjKtqrmitdrabY1LVNz?=
 =?iso-8859-1?Q?rco75jS/hLrzevClG8MvmgSmEoyF7toddOInufopRxMUj20PBEBK9HQNVP?=
 =?iso-8859-1?Q?xTciNWDlAZoHhe3s0ytDsaeu063gECI+gy2Io8BI2c4ep+UuPm2kAWJ7Aq?=
 =?iso-8859-1?Q?ITJ9c9ebsQq+m59FIgQh+8bMwSkdPkPCwt5obMWfxUjlWKBVDPhCgp5ML4?=
 =?iso-8859-1?Q?B/7eDsdkATgY6r1D9NdWgu8fdIkXAfCQdH+Ey60kQeQqcyhrrc6dRWAf2r?=
 =?iso-8859-1?Q?lJHetmSCOErrb6XfC/kGQWuZNfBFSLKqIq71oqDYTVaFlkfI201UeoBPZU?=
 =?iso-8859-1?Q?/0hfM080Ba3HX1zE01S8+sNbjIjw1aVZvRZReSyawQTzxWjATUX/9wBOSW?=
 =?iso-8859-1?Q?4+4JCJVXk51NC154dYQJmWBYeLTsDvlw0dX+sXVOv+72StQlVlV6IbNBK+?=
 =?iso-8859-1?Q?kZrvgRUeYbKPdIvpTAq42nBjI/lmNO6uXDfN5vxnMnMASGldLidMK7aOLZ?=
 =?iso-8859-1?Q?jc0prh0+A36KY7iOo9J1ZAKgxvzPLi1CzBEo62AkxL8zXHQ9hEl5vpQkBW?=
 =?iso-8859-1?Q?3K4aqeblOiu2HAYHQzVk8A6FlYcXPK4VzuJP6F8/ce0yLKOfjFt+1pRmyE?=
 =?iso-8859-1?Q?ve2kGgOVDf+MVTGw8QmTPff5nk84cKzamtqC5YU/eYOrMxqMhLxn8VM59a?=
 =?iso-8859-1?Q?bpvqjZi1kh+OaGEhN8lyAzfuBc0p9cgNqZVbYT6pV1T/wkRXz4hBEnjlsA?=
 =?iso-8859-1?Q?xJUj3Pge8EDtelmJzbSixXC+7XHZKTbYIZSWgGiaUZfqStSX4uz9I=3D?=
Content-Type: text/plain; charset="iso-8859-1"
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a8b4bd7-9f36-4a82-c818-08ded8583834
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Jul 2026 16:37:34.4340
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR02MB9626
X-Rspamd-Action: no action
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[outlook.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[outlook.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	TAGGED_FROM(0.00)[bounces-11815-lists,linux-hyperv=lfdr.de];
	FREEMAIL_FROM(0.00)[outlook.com];
	FORGED_SENDER(0.00)[mhklinux@outlook.com,linux-hyperv@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[baylibre.com,microsoft.com,linux.microsoft.com,linux.intel.com,kernel.org,suse.de,gmail.com,ffwll.ch];
	FORGED_RECIPIENTS(0.00)[m:u.kleine-koenig@baylibre.com,m:decui@microsoft.com,m:longli@microsoft.com,m:ssengar@linux.microsoft.com,m:maarten.lankhorst@linux.intel.com,m:mripard@kernel.org,m:tzimmermann@suse.de,m:airlied@gmail.com,m:simona@ffwll.ch,m:drawat.floss@gmail.com,m:linux-hyperv@vger.kernel.org,m:dri-devel@lists.freedesktop.org,m:linux-kernel@vger.kernel.org,m:drawatfloss@gmail.com,s:lists@lfdr.de];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mhklinux@outlook.com,linux-hyperv@vger.kernel.org];
	DKIM_TRACE(0.00)[outlook.com:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-hyperv];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[outlook.com:dkim,outlook.com:email,outlook.com:from_mime,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,vger.kernel.org:from_smtp,baylibre.com:email,SN6PR02MB4157.namprd02.prod.outlook.com:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 5B4A46FA831

From: Uwe Kleine-K=F6nig (The Capable Hub) <u.kleine-koenig@baylibre.com> S=
ent: Wednesday, July 1, 2026 10:05 AM
>=20
> The pci driver must not kept registered if the module is unloaded after
> vmbus_driver_register() fails. So check the return value of
> vmbus_driver_register() and unregister the pci driver on failure.
>=20
> Fixes: 76c56a5affeb ("drm/hyperv: Add DRM driver for hyperv synthetic vid=
eo device")
> Signed-off-by: Uwe Kleine-K=F6nig (The Capable Hub) <u.kleine-koenig@bayl=
ibre.com>
> ---
>  drivers/gpu/drm/hyperv/hyperv_drm_drv.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/gpu/drm/hyperv/hyperv_drm_drv.c
> b/drivers/gpu/drm/hyperv/hyperv_drm_drv.c
> index 20f35c48c0b8..2e75fb793495 100644
> --- a/drivers/gpu/drm/hyperv/hyperv_drm_drv.c
> +++ b/drivers/gpu/drm/hyperv/hyperv_drm_drv.c
> @@ -249,7 +249,11 @@ static int __init hv_drm_init(void)
>  	if (ret !=3D 0)
>  		return ret;
>=20
> -	return vmbus_driver_register(&hv_drm_hv_driver);
> +	ret =3D vmbus_driver_register(&hv_drm_hv_driver);
> +	if (ret)
> +		pci_unregister_driver(&hv_drm_pci_driver);
> +
> +	return ret;
>  }
>=20
>  static void __exit hv_drm_exit(void)
> --
> 2.55.0.11.g153666a7d9bb
>=20

Reviewed-by: Michael Kelley <mhklinux@outlook.com>


