Return-Path: <linux-hyperv+bounces-11816-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id m6TOCkqURmrzYwsAu9opvQ
	(envelope-from <linux-hyperv+bounces-11816-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Thu, 02 Jul 2026 18:39:38 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 792FE6FA55D
	for <lists+linux-hyperv@lfdr.de>; Thu, 02 Jul 2026 18:39:37 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=outlook.com header.s=selector1 header.b="r/dplYAB";
	spf=pass (mail.lfdr.de: domain of "linux-hyperv+bounces-11816-lists+linux-hyperv=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="linux-hyperv+bounces-11816-lists+linux-hyperv=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=outlook.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9BFCF30316CB
	for <lists+linux-hyperv@lfdr.de>; Thu,  2 Jul 2026 16:39:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D684346FA7;
	Thu,  2 Jul 2026 16:38:01 +0000 (UTC)
X-Original-To: linux-hyperv@vger.kernel.org
Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazolkn19013077.outbound.protection.outlook.com [52.103.7.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA642340412;
	Thu,  2 Jul 2026 16:37:59 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783010281; cv=fail; b=e7lsfef7tmNabRU58EXaSLq4JFlYX1lKmvErQwwx4zZ+8me2dUsXPuR8m52e96Ib2WhlXGzs5jDO6dIVpGULY+H4NbUUlrSjSL3OijbGyGZuhJDIhceK0TOs1tyU/pxlVGYP/bOrD8kaLcAWPetAFcM1lO0etsiFmUEa8umeaAY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783010281; c=relaxed/simple;
	bh=iLZbFxrVmkx0Yte3yQTLzOZdhuI1nx3PH0mhVKySzYA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ZLUf3oYMz/i2SqDQ2vV9AC+xSC0nZMzGrH9WO6DbJ0Ha/9OeDQ5ZfRk1xOrmw5JDHdKPNjVizsvS5rOyyQaXHRxH+ChvhWFsqDuFRl+O0ipwzOC+iCiYdrUum0zokBnXVBGsQXPHT1PvbLv6kC0xYqAD/VVYEPeXC04Cm2080ns=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=r/dplYAB; arc=fail smtp.client-ip=52.103.7.77
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=C4oUlgsm/ii29BdN+FTK3EoeBSHBaB5wkoSb/BEYgBBbVjXbyPx+ZCzPghD1CEpBzFYnsucRUsZpohnawzZu//5Mi2PLmX9ywt9qx7g/jjSD+YgjejbzsMwzcoHvSdq4j88mBgfi63Epbuxcf4dJkLPuHDmkNq7YyowlL62MjMt9qWMpuK9vVmKKVkdkokMehwRETWLASeNchZzvR7jZufcOtwkB7igtlDjplSAy72LFzMTqcJ8onJTpM7/+tghDs/6f21AndUo2yLM3nIHqzs8mFmxTjXfCcjEJ7p8U+4zNAw08Pkxa+Jlooyt5fXoCjObF7+oxsPcsmFyOqGoTVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Yvlid7JsNPE+aopLTSvJxGDDJwmQs3e/fcjSlP8B0P8=;
 b=DU8IfOinLkj3TvlLzLkjqZ3pqlQAjS2C2+FR3Ngv176dHYL7Bfcbws/MA0agyCpOXr0VTKHy5p46F1mdcGCg+xEbCSuXZ9U5H/v3G7Jb7S1ToMYfGU4obsquhf7nhS1EqlVsCbJFbjvcwmKYQGUfX9YHa/+vDWe5tfWXCBw8D7USQKvM5mj2QMSZ+mmS0GR8HpV8/BqyKmZHyCq2GvfEKjyti2mqn/NN2iPrFquZkpJ84Z5WzITXrNCaQ2ISCgf8LIm2qQnPICohhRroOgzBwvABvdTbxAC2KaOHf7UpLk4t+DUxgmRLYy+XbeihvMmlJ2I4kUmkF3l4ufV8LPG/lQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Yvlid7JsNPE+aopLTSvJxGDDJwmQs3e/fcjSlP8B0P8=;
 b=r/dplYABT8YAtjhRCbfMsJVzKr6HVvtDQSqIZyoFk4q0lZK1dCZrvvD+XqOA8kxsM6rrlrJH3RmCNbY5FB0M+hWCxcba5oCHkBKBn2MMYgHerR6eDyX+QbdEjWApvmZDIGzo7t8A9+gQYWa2XS1OyY/hOOZKrUeF71VA59lN+XGOSYDi4WpvS4PnMdpsMmackluyUYbZitFlF4p/2n2GXyhvL778f7lgdE7MV0Rp1PltvqCGsi38hNIFP+GPnftORYmBOwZRNA3nGxhKkKqEYaEN2z4J7pbKtOWYmzSMzWQQe3p6pQoJzfZSqsy+VgSiJvy6Ba4XENRckyo1+OuDXw==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by DS7PR02MB9626.namprd02.prod.outlook.com (2603:10b6:8:ee::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.10; Thu, 2 Jul
 2026 16:37:57 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::900:1ccf:2b1e:52b6]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::900:1ccf:2b1e:52b6%3]) with mapi id 15.21.0181.008; Thu, 2 Jul 2026
 16:37:57 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: Thomas Zimmermann <tzimmermann@suse.de>,
	=?iso-8859-1?Q?Uwe_Kleine-K=F6nig_=28The_Capable_Hub=29?=
	<u.kleine-koenig@baylibre.com>
CC: Dexuan Cui <decui@microsoft.com>, Long Li <longli@microsoft.com>, Saurabh
 Sengar <ssengar@linux.microsoft.com>, Maarten Lankhorst
	<maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v1 2/4] drm/hyperv: Explicitly set subvendor and subdevice
 for pci match array
Thread-Topic: [PATCH v1 2/4] drm/hyperv: Explicitly set subvendor and
 subdevice for pci match array
Thread-Index: AQH1T0mALjaVnIZyp+48CYNcNiSnwgKUtWwRAcEWc5ADCeFhcQGOcpuateJrUhA=
Date: Thu, 2 Jul 2026 16:37:57 +0000
Message-ID:
 <SN6PR02MB4157529D811F41571F4EA791D4F52@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <cover.1782925276.git.u.kleine-koenig@baylibre.com>
 <019450ffb519d02821364afca32b9f48bcd8d2b6.1782925276.git.u.kleine-koenig@baylibre.com>
 <7a747d47-d275-48ad-a4ea-1e4897df1d28@suse.de> <akYkWQzXIo-y3n4J@monoceros>
 <4e421c5a-1ecc-4155-8262-69c163af9624@suse.de>
In-Reply-To: <4e421c5a-1ecc-4155-8262-69c163af9624@suse.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|DS7PR02MB9626:EE_
x-ms-office365-filtering-correlation-id: 9ad46654-1e6f-4265-b837-08ded85845dc
x-ms-exchange-slblob-mailprops:
 WaIXnCbdHrO+2YmbT5jW+WUSUt4IT5vRXxyz3X6psCGoZx9vGmVHV3CQfStJLl2zlJKqc6zSH5PPGogIZbKfczBY72kNi4XUNYAnYrOz9FrNTM0DRvnxeO5spRM216gdAzr3RKkx+vaH4DJApWUzggP1XcmoWc/4IqGWecJ3oebMnBJ8mh/ceTQisMS0wZ6zfGmWBEv1Shng9li5fEtPTUU/vKbbNsCWVT2iTs6KyDAIkRW+JGyBeZHdVKhTV3++zcjSpwH5MvP3rVFoMnJI4D9ttLvSPTyNrRu0ufxfPc1ii0PtwdsPwzGZDG+LhpnwNIXe99k7KLPOVdHfBQHM5L60wZoKUV+x6eeythoWEyC9NsFpbSiGk6WCm3rzrEFXyDSMgQqYFSJb6/R33hB/xz8+UnSlk8AQHjUdG4EDBL17IRdynPtKn2LjZD+8B6FzknRh8zxEUtdxOIsbveXaCiLQPpqjRywXg15DzxWc8nMCXvq7MnM1SnV3zSFxGIc8+K501NWrAX2ptxNmGYRIFy3dziqU2so8RCaNO/j/aVKLH+K/XVsqTJqCPyYIDNVfqwDl7iI04gry25b5oCq15jBywjnpMAyWd86Rvfu6sT7zI8DFoL42Yb9RgfLHFATvix6EGIr2AI2+DZuAg/AOenOmQSF3/AuhT2/D0mXWvqQrFJhO9vIX+moCFdJGD7k/9jNbNLwhs1FPKqNU2T7rXIOTdfNa8xxsJmhQySI8/Gqf66B4f7vJhxmCnhrP9mrAzp/AiHfAtzc=
x-microsoft-antispam:
 BCL:0;ARA:14566002|37011999003|25010399006|15080799012|19101099003|31061999003|8062599012|19110799012|51005399006|8060799015|13091999003|3412199025|440099028|102099032|40105399003;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?UF2eES+xWiaBzzTW/Z4CWWgdiG1DCjYhUQrKwcneXsaUcWuO4F04p2oKGl?=
 =?iso-8859-1?Q?D1JBYycDrz21OmeoV9AdZtCOsd2K5cf00RWlqNxMQLn9qzFA9PUDPrjm1t?=
 =?iso-8859-1?Q?jmoJeIIsUuLtLnE7g+OhQRAPBx9zSCmJxJyvOtIjiFTOiDTIDuD7CjNBKz?=
 =?iso-8859-1?Q?JJIj+UoT5Aoen8GxYcNah7soDbfrfX7L8H/Re7Ii+CW8RHsnHcyMZ6QhIb?=
 =?iso-8859-1?Q?f9sJMOjIPHIHjLtuJx3+tU+fmIgvQEguz0OKDsvr117FvhDiFw128x1YIo?=
 =?iso-8859-1?Q?aWcnsLDDyw9lZhk3UR9dfBGbGjVNsVDQwc2jISl1NJpN3+G3BHpJ8Me3Q4?=
 =?iso-8859-1?Q?/Cq+1tCrzmrzcn2ftqIIu7LPIldvOeB/gLHypQ999yVfBF9n6DLXXtxM41?=
 =?iso-8859-1?Q?MNq6v9KbMmR7vTmOKVeFH5U7x8BKKf854FwGUyG0Oi9Z1xG3FhQ9qThj+h?=
 =?iso-8859-1?Q?0/5MGfncBHw1b6LXNPy5KinCqRO8oaNA4JjD60lDVyD52DjXq+AGZXe7Yp?=
 =?iso-8859-1?Q?hb2CzF+E2YCyV61yd7N2pc9JNLxUz9JPXCSq3v33e0dHqgWRz8vQfrQ9Tf?=
 =?iso-8859-1?Q?0h/GLZ2TCyPODF4OS5+BX8UdwomrcQMU/puJsSQQ6v/D18nAbf3Gfr3zpx?=
 =?iso-8859-1?Q?hO38LhXHzL3QbOYKlz51xZGFvFj9Pq9Z6F/r4AJWXDWcHV0f/XBMUkAdie?=
 =?iso-8859-1?Q?S3BP6uam6qBfEpy49AXhlI/kX7Zh1qqapQYHxd++knicaJ6ejfl5Ek5kil?=
 =?iso-8859-1?Q?n3OWG7doU5Y/lYmulb4Mxp8QkB0Qy0Vk6iDdlI6OqMjOW5Ito0MPY011Gf?=
 =?iso-8859-1?Q?b+nJWH7gaowc00RLWtrlDq8blp+kXeMxK8gfHuAmzI9HSD6bWvZb7zx9ew?=
 =?iso-8859-1?Q?cH/hgd9Yhm6dK7ZegTq8ItFTLcYJRKsUeX0/QGRDXxivXPwZbGMKMQNz7U?=
 =?iso-8859-1?Q?yWDZngO81XDr2aHrDt6RkawUsyrI2qj+58l0b2zpfD+3MA/zs+VTAAnVKG?=
 =?iso-8859-1?Q?PqlLBvbTsvVtTuaVPbY4Pzi8GNMz7mUT4tf+Sm?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?pkmMPpRmgSDQbN4o2AzfC11l3hT33Z+kvZVxrVVU45M837fMB4KwcVT45a?=
 =?iso-8859-1?Q?Y4+MRIrUpIraxtl0TejSUfzYdxkReh1dJ+TL+S+/zHfWBmnigb1FbkiVIy?=
 =?iso-8859-1?Q?wFVCU4Jpz2NxQZ0D/qlKYcFILq70WEUVz2gflUpfh8+6qMxMnUpn6piqg5?=
 =?iso-8859-1?Q?95SH0jok3JvjHmfcYZ+wEx0lHLgIkDsjVwrV8L76jbaYwrMqgHUD+0DgrH?=
 =?iso-8859-1?Q?10Gjdh2um8DAe5+EZu9qkB57fH5qN0G1dww3AT3g3HiI2MR5X4aRmlor8X?=
 =?iso-8859-1?Q?Cv/co8mAyRDORjkFaxnECU9UuTXgLs8ap1THyIdCt1zBjUkNXqFmF9Zwtv?=
 =?iso-8859-1?Q?279zLw22spszrzmYsdneohKEK93NnTnp7DaxEhp3q33/7JQ54x2z+vj4ik?=
 =?iso-8859-1?Q?C+0Fkrb1P1C6O16UUUhwqYUc+CYNG6EkgLAq1qc5Yh+OThpRxfZMxpoURK?=
 =?iso-8859-1?Q?590PPMtVTMUNaBqbxoAmy+jBo2PLt38U4lR4BawDhULAVPu7u/EGfZC012?=
 =?iso-8859-1?Q?AYx1gXHtEiYWWM3sd74iXdQPtKTPOBCQFRSiKeegr+++Snzvn97oQ3CvPg?=
 =?iso-8859-1?Q?E/adOwsS0sTOx0d/OQ0SRfQr1DzTd0scKRuvgm/uTGWN/DhlApANfg1f2o?=
 =?iso-8859-1?Q?KzVr3mLwxK8qN2RE0D6nYZtnq5z6dY/kIkm8E4LLyExC3P+QIw44zIz/vI?=
 =?iso-8859-1?Q?KfDwb5OBMfvIK6QJ5JIV5j+ivtufC+2XVlUKSLnzicwVYMHebuFYr3dfgh?=
 =?iso-8859-1?Q?BD3M6jq2pUTCwELn4hp64luGr6uNUkahGb7gfXELHHB9C1sic1R36usWd6?=
 =?iso-8859-1?Q?CTpAij4qiZScNmilvC5QqV8tJe7RltHV4Baf0i34EGkTKqAXdU7aZ4kfoC?=
 =?iso-8859-1?Q?xhhuoTHsa+6o6t1ZtQdFC3j0TMVg7U74J0FcYyxlAGmsCQbH6Q+JBtTB8R?=
 =?iso-8859-1?Q?9W5ZGBfOBNci2zjtwr6KpE0tJESdzrH9n+XppqORNomwT1+jxhso0N/p50?=
 =?iso-8859-1?Q?OgDL7A2J0JWj2mo5U9JHbqHaGr2hVJsJJWpCKemO7GN6BLW2/PWNyrV2ro?=
 =?iso-8859-1?Q?nVH5RSW1eCNb5LXM1vQK/OVL/RyFTXLJmOx9xds6IowNDdv7xjDrPDnD07?=
 =?iso-8859-1?Q?HyQuKwymq6ZQ2oK1bVfngRdU0S7HCJ2q/knwgRhRkLo4k8vIcX+AVADfy+?=
 =?iso-8859-1?Q?Ggs2YML9mIFdFIhCE1fw8bTFy9+8q7hBlSVqea65V+wIMjsnY0yGwkCDfc?=
 =?iso-8859-1?Q?5QlHxFlYm5918flLjXt42qiMkneayn26LiY3j8iVSGHorv0Rj3QgJZgmTx?=
 =?iso-8859-1?Q?tbM0if0+ktoQLkOvH5gbz3KfxvDLkSr6WA7TIyXOBF6MagBaDXZQIbdiei?=
 =?iso-8859-1?Q?72x6nKFOeTR92jQF7xaYipudKqXPRr//1tZ1EQMe2waa8huO/pENc=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ad46654-1e6f-4265-b837-08ded85845dc
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Jul 2026 16:37:57.3413
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR02MB9626
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[outlook.com,none];
	R_DKIM_ALLOW(-0.20)[outlook.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-11816-lists,linux-hyperv=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:tzimmermann@suse.de,m:u.kleine-koenig@baylibre.com,m:decui@microsoft.com,m:longli@microsoft.com,m:ssengar@linux.microsoft.com,m:maarten.lankhorst@linux.intel.com,m:mripard@kernel.org,m:airlied@gmail.com,m:simona@ffwll.ch,m:linux-hyperv@vger.kernel.org,m:dri-devel@lists.freedesktop.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FORGED_SENDER(0.00)[mhklinux@outlook.com,linux-hyperv@vger.kernel.org];
	FREEMAIL_FROM(0.00)[outlook.com];
	FREEMAIL_CC(0.00)[microsoft.com,linux.microsoft.com,linux.intel.com,kernel.org,gmail.com,ffwll.ch,vger.kernel.org,lists.freedesktop.org];
	RCPT_COUNT_TWELVE(0.00)[12];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,baylibre.com:email,outlook.com:dkim,outlook.com:email,outlook.com:from_mime,suse.de:email,vger.kernel.org:from_smtp,SN6PR02MB4157.namprd02.prod.outlook.com:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 792FE6FA55D

From: Thomas Zimmermann <tzimmermann@suse.de> Sent: Thursday, July 2, 2026 =
2:15 AM

>=20
> Hi
>=20
> Am 02.07.26 um 10:52 schrieb Uwe Kleine-K=F6nig (The Capable Hub):
> > Hallo Thomas,
> >
> > On Thu, Jul 02, 2026 at 08:43:32AM +0200, Thomas Zimmermann wrote:
> >> Am 01.07.26 um 19:05 schrieb Uwe Kleine-K=F6nig (The Capable Hub):
> >>> .subvendor and .subdevice were set to 0 implicitly, so only devices w=
ith
> >>> these two values set to 0 in hardware can probe automatically. Make t=
his
> >>> requirement explicit.
> >>>
> >>> While touching this array item, also make use of the pci macro design=
ed
> >>> for that case.
> >>>
> >>> Signed-off-by: Uwe Kleine-K=F6nig (The Capable Hub) <u.kleine-koenig@=
baylibre.com>
> >>> ---
> >>>    drivers/gpu/drm/hyperv/hyperv_drm_drv.c | 4 ++--
> >>>    1 file changed, 2 insertions(+), 2 deletions(-)
> >>>
> >>> diff --git a/drivers/gpu/drm/hyperv/hyperv_drm_drv.c b/drivers/gpu/dr=
m/hyperv/hyperv_drm_drv.c
> >>> index 2e75fb793495..e766d87b7a9d 100644
> >>> --- a/drivers/gpu/drm/hyperv/hyperv_drm_drv.c
> >>> +++ b/drivers/gpu/drm/hyperv/hyperv_drm_drv.c
> >>> @@ -51,8 +51,8 @@ static void hv_drm_pci_remove(struct pci_dev *pdev)
> >>>    static const struct pci_device_id hv_drm_pci_tbl[] =3D {
> >>>    	{
> >>> -		.vendor =3D PCI_VENDOR_ID_MICROSOFT,
> >>> -		.device =3D PCI_DEVICE_ID_HYPERV_VIDEO,
> >>> +		PCI_VDEVICE_SUB(MICROSOFT, PCI_DEVICE_ID_HYPERV_VIDEO,
> >>> +				0, 0),
> >> IDK, but it looks like an oversight to me.=A0 Setting the sub-fields t=
o ANY
> >> seems like the better fix.
> > That was my initial reflex, too. However while writing the commit log
> > for that change I noticed that since commit d750785f305e ("Staging: hv:
> > fix hv_utils module to properly autoload") from 2010 (applied to
> > v2.6.35-rc4) the driver never worked for hardware with .subvendor !=3D =
0
> > or .subdevice !=3D 0. I cannot believe that something like that is
> > discovered 16 years later by chance during a rework by someone who
> > didn't try to run that hardware. And if I understand correctly, this is
> > emulated hardware and so I guess used quite a lot.
>=20
> I wouldn't be surprised. To my knowledge, there's just one
> implementation of this device, which is Windows. If they clear their
> host-side structures to 0 and pass them to the guest, no one would ever
> notice the issue. But let's see what the driver maintainers can comment
> on the issue.
>=20

Yes, the device is a synthetic device provided by a host that implements
VMBus. Historically that's Windows Hyper-V, but alternate VMBus
implementations are arising, such as in the paravisor used in some
Azure VMs. That paravisor is also provided by Microsoft, though
conceptually a customer could provide their own paravisor.

Since current code is defaulting to requiring .subvendor and .subdevice
to be zero, I think that requirement should continue even with this
cleanup. That maintains strict consistency with current code. If
there's ever a case where a different implementation of VMBus
needs to identify the synthetic frame buffer device differently, that's
likely because of other changes in how the device presents itself.
Any tweaks to the device id matching can be included then as part
of whatever other changes are needed to the driver.

Just my $.02 ....

As such,

Reviewed-by: Michael Kelley <mhklinux@outlook.com>


