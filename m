Return-Path: <linux-hyperv+bounces-11136-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AN7OFndeD2pMJgYAu9opvQ
	(envelope-from <linux-hyperv+bounces-11136-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Thu, 21 May 2026 21:35:19 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 549855AB7CD
	for <lists+linux-hyperv@lfdr.de>; Thu, 21 May 2026 21:35:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 90D663044A91
	for <lists+linux-hyperv@lfdr.de>; Thu, 21 May 2026 17:07:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EC203B893A;
	Thu, 21 May 2026 17:07:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="Vk5GKYqZ"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azolkn19010000.outbound.protection.outlook.com [52.103.12.0])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C62F6383999;
	Thu, 21 May 2026 17:07:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.12.0
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779383272; cv=fail; b=FQQ6TebKzEoaPSo120kyLTZWGrY5gF7jUC2rRnG2siTlyRP6xisbks8tdX+VoCN4sxkB14C4D2SfHAQd5FdqO6WMETEpCQtFVSNoG35v2ZmfaC6pUuoCxpaFHkfBF5p1b9gpFknxwKESvMmWOqNhtsgYM+Xens7smv8yl5GGA5E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779383272; c=relaxed/simple;
	bh=v2nFB/8d824GX4sPwnrZs9+rhAl4kZVjcxmipB9VH+Q=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=J2J9vN+rBTztCH3nODq/L1oBp64cp1V3YV3R761ldJZ2BRsKnSTJPATi0JIDagEO1XuXiwj291cZXFQHS0kXSZmnamk41G5RJtw0p1Krn14wGSYQ0h2Y7CaqYsKVBs5Xz+nqyq2OVeo5si1+XQ6At+Hjyq5NrQZsCAYDs7HrsvQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=Vk5GKYqZ; arc=fail smtp.client-ip=52.103.12.0
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FchaoitPyrXDddQZD/mYu38LlVu1hBm/U2HnwIuJWDtJVLpN7kjzXMds2QnsbaDSjXGXrznBePjrwTjzD7xBztr0ALFp3XrQkgXoDcz4T2CBwUWRqJIPJTTQh6dHGAG3YNOtUxbEU0s2hbFx0Xv3FiGCJ1911qBmwLTF7MIkZJAi8tuDCBDR/rYxRnMtvPhYeoSA6H+se8Fr119dtikUu4DvBLHLIyk3HfmvtE3ttJ5889WS1lW45iqxJgjU5nUkOljkjxt4D4kN5rpQO4Mov1uUVk9rR1abB7I3sQ/Qi85UhVsOJBepG0MmItIs69pssXcZd+Mcn9BjH7L9q6T9Ig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W8Gno2s9P3ElZw+cCA2dIJ7DDooH95gEGcvjTXAtCyc=;
 b=j/mlIqlMSB/GOXJSTF/5Cm/9AToBgm6gEcMraBvqrpf9gMlb4rqOpmXlmZFCCIlR/GYpxWMYg862aJPpo7/a8euq1IVJhk1Ffeh0yDlKHY7BVo1ScNEWYRp201EsLwF8QJ06lTF4QpU9zaaygPaO5QfLELsIGhwvLFPPftVRisY6wdncgZtfYlf+zRlYSneX0r9lJ5XJYZLmLL7CubwSLRDgYLfOvLPwNk3rrbCC9tOZkgTJQI9N+bwlvrQ3y5i4l5tgkpo60Dv3vE/YZT3lw+qAZQ67U0HbExAoQxjSwa5dU0R7ZLuVkC6rSoNC6TlHxUh9YsxCtrYTm90ZGzKzew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W8Gno2s9P3ElZw+cCA2dIJ7DDooH95gEGcvjTXAtCyc=;
 b=Vk5GKYqZoRr3TEDEBIca2nc9UOlTCmq0l10PNVm2yOcnfxmM9ycAhy0brlPZiyaOwhxINyFqvltIUjGGfMJwn+dfRnO2yAZo+it7bUgPQVuRpAL5hMS1Uv/gSyGBWrV81OnVCgkJbIs4KF0hOfV9x528RgOTW9pJqAaR0wqkJtEsawvqKYqOYirEiYgAcy6jItmfzOO/eCTEtQDGXkBATIFxvzOG1CLsMIwzXhyimkdfPnXaKvj1QS9oiZV2z5lda2OrNpULOY6hENPZz/n/JylzcCVVDgEUvmRtJ/8EAe+PyUfGibzL1wUqnKaHVCQM/U6nL0pc1p7QikeK26wqlQ==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by PH7PR02MB10106.namprd02.prod.outlook.com (2603:10b6:510:2ef::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.18; Thu, 21 May
 2026 17:07:47 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::900:1ccf:2b1e:52b6]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::900:1ccf:2b1e:52b6%5]) with mapi id 15.21.0048.013; Thu, 21 May 2026
 17:07:47 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: Berkant Koc <me@berkoc.com>, Saurabh Sengar <ssengar@linux.microsoft.com>,
	Dexuan Cui <decui@microsoft.com>, Long Li <longli@microsoft.com>
CC: "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "K. Y.
 Srinivasan" <kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>, Wei
 Liu <wei.liu@kernel.org>, Michael Kelley <mhklinux@outlook.com>, Thomas
 Zimmermann <tzimmermann@suse.de>, Maarten Lankhorst
	<maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
	Deepak Rawat <drawat.floss@gmail.com>
Subject: RE: [PATCH v3 1/2] drm/hyperv: validate resolution_count and fix WIN8
 fallback
Thread-Topic: [PATCH v3 1/2] drm/hyperv: validate resolution_count and fix
 WIN8 fallback
Thread-Index: AQHc581tCSmX9PdhTUe+2Nbmy0E9aLYYuRWg
Date: Thu, 21 May 2026 17:07:47 +0000
Message-ID:
 <SN6PR02MB4157B761899BF5A8F77126FDD40E2@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <cover.1779221339.git.me@berkoc.com>
 <1b88bc7edeb2f0153475225b67f19aaca629eca8.1779221799.git.me@berkoc.com>
In-Reply-To:
 <1b88bc7edeb2f0153475225b67f19aaca629eca8.1779221799.git.me@berkoc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|PH7PR02MB10106:EE_
x-ms-office365-filtering-correlation-id: a9cba4a5-2376-438b-222f-08deb75b7b93
x-ms-exchange-slblob-mailprops:
 WaIXnCbdHrNUHEYKyaIg10gAWKced6rzsCe/BmiDHtXwX/LdJ7U7ZeMe1Ijk8FRKYPsR/fuKLA8h/Bc//O77zF1CfXrZC3S0ML436yh15kVFSt8KVMPl+e894htv7fFkxPJ9FqqJ4GBgJ6NHMUA4/lc4ZO6PEoc23/LrqwVxshCH6ccGoRdyXwPQ/+osrm/4jque7CF+DO5g4f2iCdH8Wixb6LCpUwGIKEtB2DnB+Uti6RHvGfqy/h8Dh0NUd50qK7Hv8FE2JBEC3/xlMauiOunZK0s533mDGoB70sBNr5owjrBg5WG7xAw2nCbg6PE5/bKTzPuIlrsigQcI2apGqcqClU8WJOyTM2pzQZYL1Q3I/ElIEqoI74wXVYrveyKv9mHoAltXIOoR/+yW4fYQEXBWC1JFox3/RMRdW3Ja45eC+4TXCa1ecHb/SEJFD2c31xRrQEH+/v//2yQjv3EsKDtvB+taIXV7BlGmiAJ01E+lCkST7nvulYBpJgcMpgRMWkBQS/HIdQ3XgkoKoACborFids+SuPi5eZcnHJc+b5epUptlrYCbKR11mkWtE/5XINrSXwPqPWza8VOQrvFqfTADrOFQv4HNlgz2SdeCLHGFr1t+jbSveklzQrRtDu8oNfNygyiXUrvB32whZDqAa6HfVRdptPUm+C13+P4FZT3oYpLoIt0lMc9wij/4xEMdT+/LbHSDUMP3Nf5acL2Ahn74JybkEiPKyDJXjOI4k9OqXcq5EUGdcSZ9kiw4YgeDMHg4bbbimRo=
x-microsoft-antispam:
 BCL:0;ARA:14566002|19101099003|51005399006|41001999006|37011999003|19110799012|13091999003|12121999013|8062599012|8060799015|31061999003|15080799012|56899033|40105399003|3412199025|440099028|102099032|12091999003|1710799026;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?LCoJ8bp242nn14F+ZmbsQ1NsDAGiSKVea1IrkdFxVrynsItBOdv333MqGPi2?=
 =?us-ascii?Q?YbCxNJiGEsaQTRljTlWk6hL1vKQeosQp2CpFAB/rcQWoOyAb6BjNDrADg0lI?=
 =?us-ascii?Q?ojmKOnEY4upeaRCJH1DrZN7Y8t0m2Bub/OojfaAUugdA45/aV98unS0WXTXI?=
 =?us-ascii?Q?BtRqwnjZ2BA6GFLp7I3ew3fPGwJxfXLwOQkXZcui8F0ha/NibjpoH8KZToXA?=
 =?us-ascii?Q?oB6MOWRPK3wKDTK4JlQVRWvWeKtxuoD3wYrnvTjfHCaHyddzJlIHtlC3EtFk?=
 =?us-ascii?Q?O936OpZ0fN9Sb746BeZHxp0tZsfWtC1v42ab1bmCj9iqyhFA+wDU7NWzf1ES?=
 =?us-ascii?Q?KKdgbmzUyVIWHx5adC16eQJtOK09Os8s26sreDVTHJwSDbCP8HjgDdQrYQs4?=
 =?us-ascii?Q?KglIN2kCOtqRzb32uDMPVStEig8FGbuSMcs+/Xo3t2ixaYjPZ8YndrfkLPGN?=
 =?us-ascii?Q?M1vqr8CB+Y0bT6bnjCbt9Cujjl776Rs9RXUCfIKpDrmN1Q/KBTcLju9MEaCK?=
 =?us-ascii?Q?XDD2xZKEn5/7ZQGq3HCwgaKKQd4SNXlrQOZG10zkzng6RNlC4I3BWZvlHOgI?=
 =?us-ascii?Q?5E5P6ASxbPijwqirBnbcaAsKzD67fvtlLRXFAXTOZg19wqdgoOuTb2SHK8df?=
 =?us-ascii?Q?CvX+G406743G8JwaY32qQ+9TFZ2RJi4SmvVVl6gZ79wcF6+sRe85W7mTLUK+?=
 =?us-ascii?Q?kqwzGwQnU1wI1ZcZEWoGdnzrgGcbRTRX+0TyR0wbrV8OOx0vc8bqpCahL/b3?=
 =?us-ascii?Q?g9e5PdafV0E+7i4Yr25utOK7LNfydkHmnsoQZ2XsDXWEBqgzdfHfbex+vE7q?=
 =?us-ascii?Q?xR+Izu6iH7DqlGIX/gDMGy+a+Cz/yPwsI2ZhvA/B1+swz/vXpttJF3LrZw9e?=
 =?us-ascii?Q?cdkDASVDjRhal8aPxigHEp9E32k69QTf70dv/VL8F2g1cT5sttlcdPmQOoHh?=
 =?us-ascii?Q?qg32IFdffvtm/+ayq8tq3h/OX6DaHckXXbHWgTt2aXdv5g9n/40lqVGvQyhF?=
 =?us-ascii?Q?8J8vyfz8fqVNhG2QwSmhuay33XScUrR1TEm3vp2jmWlsgTEoMr3LwaYAYibb?=
 =?us-ascii?Q?lhiK9WQ+zE8pWVCCdfcGS3onDK12l8uHkUg+KuCaLICAB56U0Os4I/2mA60k?=
 =?us-ascii?Q?fZ3h5PCkHjzw?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?KV5aGZZQSO8dbcBKAFH9gliSTrPiLvC3ZZ/jruO5StC0gznqUhc0IWSejOsZ?=
 =?us-ascii?Q?PBPiN8TvnmP1/20xge/s7YkbzPl6VTpP5/Wn+YFKJEJXZD2uT8MmPhw6hcDq?=
 =?us-ascii?Q?oLOXTbGMfURxfAzKxcVyYnixrS9ojWrV4fEHBmV+aGfgpt5wIzmDysTluQGq?=
 =?us-ascii?Q?CAAadL8pkJ7raMDYSlzdCFc+62z8JzQXL2EeptsCpjCEp9DyocqfCWW7xcMq?=
 =?us-ascii?Q?tr1utTO7P4Hw65JMhRDDsaBTYrdZqywID8zB0sr+wyZyzJHAArZIooq2F278?=
 =?us-ascii?Q?+EWlllbAWTOvEja69CE2Ovx6gmY8FeaTdXED6nhLA/eMjLdW5VxSjYrKEkq4?=
 =?us-ascii?Q?xungbwhfxhoYF84hyEZfdt4zzsmDwlcHwLEWn8PlAq3UDhxNdLhAgR7/UVbR?=
 =?us-ascii?Q?5uRxCB3p7OwzrQdJVEuaUnjxCMvvkNgvW/b2n6flkv0hLk91eNKJYWdUGmk8?=
 =?us-ascii?Q?5hxyzU5mcvNOAmceTRBoLIyeWXAiW2AFKrdmqvMt6L5y9vgAHGpQSpXli2zE?=
 =?us-ascii?Q?x3cgIN8YhjKOlPO2VTVO86bLNuL2YRrb1fgW8IH3HOHGIAilU4kKHv3CAZaE?=
 =?us-ascii?Q?4CVcrMsdO0C+U5L+WZK/ZlS6I0eSRsAehlcgftiLogipZa1Px4gnHLbmfmLz?=
 =?us-ascii?Q?YleyyM0qJ++Cga4T3UWiF6jOahiWNU15oo76ECDWLSgC+Gh6cZeYYjFwpoDR?=
 =?us-ascii?Q?sgH8cAb8FO/B7mDFYu+MjwptqhMRqatcCCGYZv9uaHjq/H8VJXwO39FrjhFg?=
 =?us-ascii?Q?J/zwtFHrSQaxYb8O4T0nDBIfYQH8VD0Km0r0t2hPKEa5azlxPPL7YLKdD4Ic?=
 =?us-ascii?Q?1qfi3M8W2Jlygg20dLqrF/DIK29gLj7dkams8ArFnxygLW4C3k4gL3iD41hn?=
 =?us-ascii?Q?s+glQLwUDhLrVbktlr7pjZcfc9TTN5H8flH1LxKViKlBwVTOPtrQHKuI4vkd?=
 =?us-ascii?Q?pGPwuuD0fqJBiCSYCV6V7ATZoM6JvanZzE2I08z/gofsprIH0EHo/4LEOM4V?=
 =?us-ascii?Q?hbbx5pTXktxSqUjRykVyGPBsQiSXUoOjgTeSiNlWX/ub8ZqRoD8/kRuZYP6C?=
 =?us-ascii?Q?7l0lB/CHJ3h+sod4lddSmIw4AUPu1/WSvXbFyPOf4rExKUMNtPjqevhUNZsJ?=
 =?us-ascii?Q?8aMbhGTEevafXsU6fGUIsfasSOrAGrrHc0TWrawiqZwGzW/1cnr6GYYS2dsi?=
 =?us-ascii?Q?Y6LFXrGc48nHMdkkXgDUfz20PnimRAKY7YwdBMo8jU90Z7NJdfl1Cxev+u61?=
 =?us-ascii?Q?Whcp0h0dVlrquGjrWRGn8MjS2wVDjBRCnjLnR3dEuCDzsn1OMcPPL1Gbrp8Y?=
 =?us-ascii?Q?HbXl9XoOZbiDXQ/e1Z4XK9TeS8OVz9GQi6J9SXsLhIl6fUlgNTL2mGc1lZq7?=
 =?us-ascii?Q?cGpe4aA=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: a9cba4a5-2376-438b-222f-08deb75b7b93
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 May 2026 17:07:47.6005
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR02MB10106
X-Spamd-Result: default: False [5.34 / 15.00];
	SEM_URIBL_FRESH15(3.00)[berkoc.com:email];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MAILLIST(-0.15)[generic];
	BAD_REP_POLICIES(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-11136-lists,linux-hyperv=lfdr.de];
	R_DKIM_ALLOW(0.00)[outlook.com:s=selector1];
	GREYLIST(0.00)[pass,body];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FREEMAIL_FROM(0.00)[outlook.com];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.freedesktop.org,microsoft.com,kernel.org,outlook.com,suse.de,linux.intel.com,gmail.com];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	DMARC_POLICY_ALLOW(0.00)[outlook.com,none];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mhklinux@outlook.com,linux-hyperv@vger.kernel.org];
	DKIM_TRACE(0.00)[outlook.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	TAGGED_RCPT(0.00)[linux-hyperv];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	R_SPF_ALLOW(0.00)[+ip4:104.64.211.4:c];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,outlook.com:email,outlook.com:dkim]
X-Rspamd-Queue-Id: 549855AB7CD
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Berkant Koc <me@berkoc.com> Sent: Tuesday, May 19, 2026 1:08 PM
>=20
> A SYNTHVID_RESOLUTION_RESPONSE with resolution_count > 64 walks past
> the supported_resolution[SYNTHVID_MAX_RESOLUTION_COUNT] array in the
> parse loop. Bound resolution_count against the array size, folded
> into the existing zero-check.
>=20
> When the WIN10 resolution probe fails, the caller in
> hyperv_connect_vsp() left hv->screen_*_max / preferred_* unpopulated,
> which sets mode_config.max_width / max_height to 0 and makes
> drm_internal_framebuffer_create() reject every userspace framebuffer
> with -EINVAL. The pre-WIN10 branch had the same gap for
> preferred_width / preferred_height. Use a single post-probe fallback
> guarded by screen_width_max =3D=3D 0 so both paths converge on the WIN8
> defaults.
>=20
> Signed-off-by: Berkant Koc <me@berkoc.com>
> Assisted-by: Claude:claude-opus-4-7 berkoc-pipeline
> Fixes: 76c56a5affeb ("drm/hyperv: Add DRM driver for hyperv synthetic vid=
eo device")
> Cc: stable@vger.kernel.org # 5.14+
> ---
>  drivers/gpu/drm/hyperv/hyperv_drm_proto.c | 13 ++++++++++---
>  1 file changed, 10 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/hyperv/hyperv_drm_proto.c
> b/drivers/gpu/drm/hyperv/hyperv_drm_proto.c
> index 051ecc526..c3d0ff229 100644
> --- a/drivers/gpu/drm/hyperv/hyperv_drm_proto.c
> +++ b/drivers/gpu/drm/hyperv/hyperv_drm_proto.c
> @@ -391,8 +391,11 @@ static int hyperv_get_supported_resolution(struct hv=
_device
> *hdev)
>  		return -ETIMEDOUT;
>  	}
>=20
> -	if (msg->resolution_resp.resolution_count =3D=3D 0) {
> -		drm_err(dev, "No supported resolutions\n");
> +	if (msg->resolution_resp.resolution_count =3D=3D 0 ||
> +	    msg->resolution_resp.resolution_count >
> +	    SYNTHVID_MAX_RESOLUTION_COUNT) {
> +		drm_err(dev, "Invalid resolution count: %d\n",
> +			msg->resolution_resp.resolution_count);
>  		return -ENODEV;
>  	}
>=20
> @@ -508,9 +511,13 @@ int hyperv_connect_vsp(struct hv_device *hdev)
>  		ret =3D hyperv_get_supported_resolution(hdev);
>  		if (ret)
>  			drm_err(dev, "Failed to get supported resolution from host, use defau=
lt\n");
> -	} else {
> +	}
> +
> +	if (!hv->screen_width_max) {
>  		hv->screen_width_max =3D SYNTHVID_WIDTH_WIN8;
>  		hv->screen_height_max =3D SYNTHVID_HEIGHT_WIN8;
> +		hv->preferred_width =3D SYNTHVID_WIDTH_WIN8;
> +		hv->preferred_height =3D SYNTHVID_HEIGHT_WIN8;
>  	}
>=20
>  	hv->mmio_megabytes =3D hdev->channel->offermsg.offer.mmio_megabytes;
> --
> 2.47.3
>=20

Looks good to me.

Reviewed-by: Michael Kelley <mhklinux@outlook.com>

