Return-Path: <linux-hyperv+bounces-11817-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id ud5pMvKVRmrmZAsAu9opvQ
	(envelope-from <linux-hyperv+bounces-11817-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Thu, 02 Jul 2026 18:46:42 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 683C26FA87C
	for <lists+linux-hyperv@lfdr.de>; Thu, 02 Jul 2026 18:46:42 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=outlook.com header.s=selector1 header.b=iffogYZn;
	spf=pass (mail.lfdr.de: domain of "linux-hyperv+bounces-11817-lists+linux-hyperv=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="linux-hyperv+bounces-11817-lists+linux-hyperv=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=outlook.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 595383058B77
	for <lists+linux-hyperv@lfdr.de>; Thu,  2 Jul 2026 16:39:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C83C8361656;
	Thu,  2 Jul 2026 16:38:05 +0000 (UTC)
X-Original-To: linux-hyperv@vger.kernel.org
Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azolkn19012049.outbound.protection.outlook.com [52.103.10.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 819C935F8C9;
	Thu,  2 Jul 2026 16:38:04 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783010285; cv=fail; b=UssQ0fHwZJbVvFGjvRDO+H+gBxlOTtKwFr5Do4Kbz5hl0IH6RMYybmHmROCaN8T189N86hG6EfHwLtGuUgUCwuy1s0jxpuRN4ZhFzrGDyHXC41PfUzbumL6WAYC2qbBwEKk/r+tPYtxh7HnwnXNqfxisidrgyyesOXcu3R9nx8A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783010285; c=relaxed/simple;
	bh=txmoZux9jmGQQEs6Z3DQxruJPgYH9HwxAFU2zj0Glxw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=BvZjHXJ0QD+GaKNQghIjJErN4RUohQPfBElKqQS6Sy168xkL6Eyi2vegI1Xw/JfQ6jY8gw/LpM/Q8EtJrOuhxdvdibwY2PkQh1dq8F7/2j5mKRAzttk3WMP7C05RuJoSTRYV16gL1CRj8VPGabwI6W/qwCLYoYzYhd3VLerdox8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=iffogYZn; arc=fail smtp.client-ip=52.103.10.49
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Q59o6ugM2xPa3Y+kcyz99+pW3+KLJAyPuz74WQ3UgpkiNyXVxdetdxJQHEFOmQPrSqdVjCLO6XadqtzRIMD6bLBDPCbZn0U8Tju1SBBlS9KXzvOmSOL/pO7Aws7BCf62L7jYwhVMEaSEFIJPf8iPVPxpgM2nqb0RfTEGcY5G1dTp3vnXwAW75sLa/UfPhbWQWE48zc8Na1sOERpJahzNF4JU5t5UQ1Pch5SgMWVZ4nSNMiz9nd9x/cQ13tk6fWDcSETEFKM2Wh6IeJZM13+tRIv/GHvChUPivJcOqHSEkSedvST2ZnCUk/Whj6y0yThwVwg8Mj0/mLFtkUsgfByRlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k7/LucrxzJnRdOU+NKyjs3gnx9DVNX+jRgQ+IFqLfN0=;
 b=BPdvpSmFf99DcF5L2Zdh+3Wz4YDQAoRwdDjvxKUovPmFy6vBZ+8ftKDV2QwYKFH0c82DGmK4MhnUTercWWToG1ZkjGQ679asJc089N7m+511q/bkgUDPrN4R3DK4TUHBH08oBVfzxI5pb5Bc0ws8PEeEYy2o7logKQABa15LGLW4bJqYkW4bVdnR/6edqY8xNgLBxdrh8WFhW/0FRqMJ+yYGWiyAxPdLCbnC5yX27QkdvXn5ip/1tsbRdg/dHY/WRntec891d6ghWj1C/9XtQwn/i/8takfevJB+Lc/MEnV2qkQFGuCWT19H1ucIJzpd0Q8QnsyP+m9+Ag6ib32cDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k7/LucrxzJnRdOU+NKyjs3gnx9DVNX+jRgQ+IFqLfN0=;
 b=iffogYZnHyF25VmTtTz01mDzaqPDNNgDrKw0HH69997hSAKwAjgZ/ZvTY292uLRNZxeuAeHutHZYla+07V/fLC7jRQkL8c2Q3pHf+gVO3pkMiwb/CXMFxZfbIbtsn3afmPuVZr8q0/J+q+299rrVqyILDerVOtOQZlNB/6EJ5huRKaomd2DDoFARQECka2Peyguvzf6DDNmtubvAHwPBQSWLDQ3JlYfmxmqKRxzG7i35U4RRsQrnfVLA+95ap/wR7Wr/5JgA0cDlfjoB/WMsl2SU9J6PeBHmPkna2tHHBn5ijIeBc3zVfLRL5KjCYL1ZFyY/fIHXHeOvHH+i6lVj+g==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by DS7PR02MB9626.namprd02.prod.outlook.com (2603:10b6:8:ee::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.10; Thu, 2 Jul
 2026 16:38:02 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::900:1ccf:2b1e:52b6]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::900:1ccf:2b1e:52b6%3]) with mapi id 15.21.0181.008; Thu, 2 Jul 2026
 16:38:02 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: =?iso-8859-1?Q?Uwe_Kleine-K=F6nig_=28The_Capable_Hub=29?=
	<u.kleine-koenig@baylibre.com>, Dexuan Cui <decui@microsoft.com>, Long Li
	<longli@microsoft.com>, Saurabh Sengar <ssengar@linux.microsoft.com>, Maarten
 Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard
	<mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, David Airlie
	<airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
CC: "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v1 4/4] drm/hyperv: Move MODULE_DEVICE_TABLE to the
 device_id arrays
Thread-Topic: [PATCH v1 4/4] drm/hyperv: Move MODULE_DEVICE_TABLE to the
 device_id arrays
Thread-Index: AQH1T0mALjaVnIZyp+48CYNcNiSnwgFKeGoIth+N1MA=
Date: Thu, 2 Jul 2026 16:38:02 +0000
Message-ID:
 <SN6PR02MB4157EBA6E5FEA78663793EDFD4F52@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <cover.1782925276.git.u.kleine-koenig@baylibre.com>
 <7f9d4a239c76b6bb384048ea5591a21ed87d9b0e.1782925276.git.u.kleine-koenig@baylibre.com>
In-Reply-To:
 <7f9d4a239c76b6bb384048ea5591a21ed87d9b0e.1782925276.git.u.kleine-koenig@baylibre.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|DS7PR02MB9626:EE_
x-ms-office365-filtering-correlation-id: 188ee82a-0601-470d-a706-08ded858491f
x-ms-exchange-slblob-mailprops:
 laRBL560oLSPhlJ95/U7v6W/AahuugGaLZ5PZHGLXzro5wJOYHf2YueJcwe7t7YJVqiC1Zj3psxNVN0LxuQkdk7dxpgRtvMQC9CB82mSF0nTAiDOABh/HdvcEXo7bVD551+CaFk5LSOqaOwofRHFNiIla8uMQiwMlAWSsBR4+7d5Q9IQSo2ukx+RKde4TIuotXTMQfKN2u1XY8CvJOOCP6G0VOd/Lhv5rAuWDtv0YqSSgnont+/ZbQdk3wSDlq4vlNAwzS1xxPtusDRv6SdxLC7gwLzGhwNngXDv8h2OzAi8fwZ0bjtZdpxQHm871f56JkQNNhEP8XHfcINpc8uclu+a/D+zN/fBzP6Do/j1BXQ89hh8ftx2flQY7DwJFnn0J5Fq7y3+ilXtog+yUP6Ity71TyRYNy4LeXjxpR+JH7NhT4MPGgGyH3Zb37K0OiuhNH7zaG1Js6dngRla5d6YWo4IODIn2poiKw1DE38RcAwcGjFvyVJH1ub0GhWtZ1f0jHNQ21dEuwsZkUE3Pv/e8W82SviTvtB1r7R80FSROFdCoxEgxej3iD/oXppTRNqDmJXP44BArJGmuEWyAir/liXwm4vNt9hMl3MIN6eF3x160AM9imJgOyYjFNMAPRq8LRBPK5CQDoqc8uMt/m+HEIaI8g2FlLCvrNRioRzLk3qKnUcgw7I/xNH7OsvIXZZ0WFuIkqANNSt32HtIJA577NA2pjoLbCFZFnvWHn0JPA9tmYC2eZYRUsBMQoQl0gaOZ7lDH4557csGA2K7kknWfKnmL785CQtf
x-microsoft-antispam:
 BCL:0;ARA:14566002|37011999003|25010399006|15080799012|19101099003|16051099003|31061999003|8062599012|19110799012|51005399006|8060799015|13091999003|3412199025|440099028|102099032|40105399003;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?ZowOIQT+mgpnRPE3htG1cQYBKZ2AYjS9MGPcLif5z83WXB5Bk3vUcdghqM?=
 =?iso-8859-1?Q?vDSuN/LblxNFr2wCoQpZ8wHtXsXZimK+eisPeJ4Q8YiuPomczAiqogoXNj?=
 =?iso-8859-1?Q?1oGkYOdjoeqNZcsx1bxjc2iByIZdYouyMkTco2KR2VSoaH2ApXt7Y5w5ZM?=
 =?iso-8859-1?Q?zxc/jDS5C8gebeu720cpmPh6XUgvXiPb3zUpF7M4Yb4w5EPBaWJkYddBnP?=
 =?iso-8859-1?Q?xBcQAg7PwqoLp1Xydl0nTNkj6a5SoeXY9JXAtFLV+HnxAJqQ2FvyahhHeJ?=
 =?iso-8859-1?Q?5X1IJUa3EISgvKDxKjM7u8VV938N4A7wFUiMjWvf5nR/g9VPWK6Ip/abKL?=
 =?iso-8859-1?Q?o89/Bv77K9Fpq8jqIwHgP6DcxDKOhHQexsWt4vL1xuyA9ZH7P2LJv9YITX?=
 =?iso-8859-1?Q?d6k+1wom/vBJJP7cAvcvugJeyyzmwzuxzKO7B/pul673ZulWi6v6eGrB6K?=
 =?iso-8859-1?Q?SKmoWiQXWk9KZ498g6eA/iOCbEKVsuG5VaYMoD+MznG7tvi/KXzzUIMOrc?=
 =?iso-8859-1?Q?w2O8ajlGtVz1NiAVEHacga3tmXa/Vz63Gtr9DDzMPlIfm/JDyqU5wWwzkL?=
 =?iso-8859-1?Q?xu/DBciXuLHdK3WZ+8fkm2nsiCQn0pKc0b5ZrNC+RzeLI/4++k8R84Jmhy?=
 =?iso-8859-1?Q?nzta3S5gF2bynBNygeoZv/Vw002m0re66h9QqUXnv85SBvGbTtoDF2NokG?=
 =?iso-8859-1?Q?37fXogNe0Wf1V+gww7DpEcsuhRl/w7zuSfQ8oJvOAYF2/7R5/NYcFqnlPt?=
 =?iso-8859-1?Q?X2Kr7Vkj7YxT3ZAmOA2McAeKiC65kKRzs3cuG+sR68M7KqlpWPzhguQHPk?=
 =?iso-8859-1?Q?hMwRuKPg/P3iDoKs1HyEq2qK2tpUnEA+D/Y/t+yxnS/9frOwjcvUmyX7Ca?=
 =?iso-8859-1?Q?KHxM/FWK1mkisjlVRrG1LQOwTz7GD5E+HXUUMDnYV5JmdWpPx7/rXWydCy?=
 =?iso-8859-1?Q?O24BkJ6CjPfV8YAHg+LWdP1BtmtmAs7dF9qsu7ctebx6B1rFHj48VqbLhr?=
 =?iso-8859-1?Q?GVpNX4IHU9DNXqodANkR+AS+X5bcaljnl7Lt8RM3rABbrE7uvaNUf+asMN?=
 =?iso-8859-1?Q?rw=3D=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?l8Tc5q6UsO0rSE8h8FwWiTH9CAw1jaH4/+9uhwIT9urQINo2bE7NhZzJZ2?=
 =?iso-8859-1?Q?tZX11G3So9SONdh0Xzhz1WLFA8BwFKoNVhgeRrPSmY3rdCbABEmqomoWy/?=
 =?iso-8859-1?Q?lHQsJjvxaUNxE9gFflaITVO1rVzaYZ3IJMiYJ6LWEmzu3j1+8YuTW6SSvr?=
 =?iso-8859-1?Q?AsdgKEVplRM0FTz0LRA2ovCeSDdwjTLjq3qcMz7JgBpPyNmGuqGhrETtoD?=
 =?iso-8859-1?Q?Stui8ZoTS5EeIlZKIXxz02UXSwyIYmwhr9CWfveofUFUG8X6xYmSxhkXCq?=
 =?iso-8859-1?Q?NnLJU1zKzVsadT3GczkN/ZxetJgtYwW5I85visvlYimKRrm7cAvwsnZRoY?=
 =?iso-8859-1?Q?fDrI2h+8wriVAQELyLbGZThN+nJDT2fdh1IVmEn+z72f6weJbQ/c8Qs+55?=
 =?iso-8859-1?Q?0Y7V7lE7MqelkE3MMagvfVZAofC84GH4us+PGo94gtg17t07iQCUTOcUE9?=
 =?iso-8859-1?Q?RuzMOjx/5JPqAIERte8Jkz1ASzgcEWNaEm61wYg/l+dKcSYbWSv8hW4c3R?=
 =?iso-8859-1?Q?IaTQfXksmtb5Xlg1JTqpWmWIua/MakUIpf/+Caf1W2hiUkfuaMvLVBu7O9?=
 =?iso-8859-1?Q?CVCdKI8T02dm4r7SLyGboCuHLelaXvWoJYhV12c26QqZfR8KxbUZFFzbx2?=
 =?iso-8859-1?Q?LUyLrTw8Eet6735Z6zbGPaY+Cf20jgRzyvI6UkhWorqlf1oe9H0++PphC5?=
 =?iso-8859-1?Q?nOC5SHXeBY+1JClNg5h3KWIsH+rUIeaJlKEMmLWiWRghp24A3CpWpxVlho?=
 =?iso-8859-1?Q?Bfz+eIoKVThClhiKNP7xhuSexB59iDE3PYv+tOMp2mOaAKgjUx0Nvno4gu?=
 =?iso-8859-1?Q?uTJ61BXUMwtALjyjBcOTrbVoay91njUqFudrmDWSG/FFFHH6ouXn3x8KpQ?=
 =?iso-8859-1?Q?8o4c1Kx36bL1cF3Lbc90ShETLJtS1tUb5/IS481OkSyj5RkdrvXc19Xa47?=
 =?iso-8859-1?Q?CWv15auZl40ta3zuC2b2splmHvGpO99OE0u8tjbTLQwXE56oAyDRdhW5Nu?=
 =?iso-8859-1?Q?bwRuVrtBAVoNabF2Awe2rSN+cBSxFbBhFUyvAUyHQOPqMITm93WJg7i/dv?=
 =?iso-8859-1?Q?KFOFnKrBi04XExUTWYnAPG3kpOW1BMwA7gIEtpvfR/nbTC8Tqb11K1wgdj?=
 =?iso-8859-1?Q?sUkC34jCR+1vQV6Z7Ko2uV5Elwa1AU9jyja7FmUhnYfHsMKqmku/vCxMWI?=
 =?iso-8859-1?Q?yvjbyqRqITdChLwBq7rSpSXI/faR/7AmBZHjdQO51D3Bh8DtsqwDd36RLx?=
 =?iso-8859-1?Q?XF3kMiQdD44L1V5HCY+q61t50UWLp71y8GuxMx8lnpZ4yKjGyO6NJvsdwF?=
 =?iso-8859-1?Q?ol7JD9EPWE406ExXjIZaaNQRwTV2rH2lbrYvosyJhEg1GeBvS0pnw3r9Rl?=
 =?iso-8859-1?Q?ARAC82kjIiBIGe8mNaKHLYAUJsZcWJ5JJcV2tyl21z5bm88TV1jgw=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 188ee82a-0601-470d-a706-08ded858491f
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Jul 2026 16:38:02.8340
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR02MB9626
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[outlook.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[outlook.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:u.kleine-koenig@baylibre.com,m:decui@microsoft.com,m:longli@microsoft.com,m:ssengar@linux.microsoft.com,m:maarten.lankhorst@linux.intel.com,m:mripard@kernel.org,m:tzimmermann@suse.de,m:airlied@gmail.com,m:simona@ffwll.ch,m:linux-hyperv@vger.kernel.org,m:dri-devel@lists.freedesktop.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-11817-lists,linux-hyperv=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[baylibre.com,microsoft.com,linux.microsoft.com,linux.intel.com,kernel.org,suse.de,gmail.com,ffwll.ch];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_FROM(0.00)[outlook.com];
	FORGED_SENDER(0.00)[mhklinux@outlook.com,linux-hyperv@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[12];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[baylibre.com:email,vger.kernel.org:from_smtp,outlook.com:dkim,outlook.com:email,outlook.com:from_mime,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,SN6PR02MB4157.namprd02.prod.outlook.com:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 683C26FA87C

From: Uwe Kleine-K=F6nig (The Capable Hub) <u.kleine-koenig@baylibre.com> S=
ent: Wednesday, July 1, 2026 10:05 AM
>=20
> It matches the usual coding style to have the MODULE_DEVICE_TABLE macro
> directly after the respective arrays.
>=20
> Signed-off-by: Uwe Kleine-K=F6nig (The Capable Hub) <u.kleine-koenig@bayl=
ibre.com>
> ---
>  drivers/gpu/drm/hyperv/hyperv_drm_drv.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/hyperv/hyperv_drm_drv.c
> b/drivers/gpu/drm/hyperv/hyperv_drm_drv.c
> index e3f41336a831..6a28048f687b 100644
> --- a/drivers/gpu/drm/hyperv/hyperv_drm_drv.c
> +++ b/drivers/gpu/drm/hyperv/hyperv_drm_drv.c
> @@ -52,6 +52,7 @@ static const struct pci_device_id hv_drm_pci_tbl[] =3D =
{
>  	},
>  	{ /* end of list */ }
>  };
> +MODULE_DEVICE_TABLE(pci, hv_drm_pci_tbl);
>=20
>  /*
>   * PCI stub to support gen1 VM.
> @@ -219,6 +220,7 @@ static const struct hv_vmbus_device_id hv_drm_vmbus_t=
bl[] =3D {
>  	{HV_SYNTHVID_GUID},
>  	{}
>  };
> +MODULE_DEVICE_TABLE(vmbus, hv_drm_vmbus_tbl);
>=20
>  static struct hv_driver hv_drm_hv_driver =3D {
>  	.name =3D KBUILD_MODNAME,
> @@ -260,8 +262,6 @@ static void __exit hv_drm_exit(void)
>  module_init(hv_drm_init);
>  module_exit(hv_drm_exit);
>=20
> -MODULE_DEVICE_TABLE(pci, hv_drm_pci_tbl);
> -MODULE_DEVICE_TABLE(vmbus, hv_drm_vmbus_tbl);
>  MODULE_LICENSE("GPL");
>  MODULE_AUTHOR("Deepak Rawat <drawat.floss@gmail.com>");
>  MODULE_DESCRIPTION("DRM driver for Hyper-V synthetic video device");
> --
> 2.55.0.11.g153666a7d9bb
>=20

Reviewed-by: Michael Kelley <mhklinux@outlook.com>


