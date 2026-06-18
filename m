Return-Path: <linux-hyperv+bounces-11638-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id TrusKzUvNGqQQwYAu9opvQ
	(envelope-from <linux-hyperv+bounces-11638-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Thu, 18 Jun 2026 19:47:33 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 05CB46A2001
	for <lists+linux-hyperv@lfdr.de>; Thu, 18 Jun 2026 19:47:33 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=outlook.com header.s=selector1 header.b=KLUKLx52;
	spf=pass (mail.lfdr.de: domain of "linux-hyperv+bounces-11638-lists+linux-hyperv=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-hyperv+bounces-11638-lists+linux-hyperv=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=outlook.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DB5753028809
	for <lists+linux-hyperv@lfdr.de>; Thu, 18 Jun 2026 17:46:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EF1832FA2B;
	Thu, 18 Jun 2026 17:46:37 +0000 (UTC)
X-Original-To: linux-hyperv@vger.kernel.org
Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazolkn19012065.outbound.protection.outlook.com [52.103.14.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14F8F301708;
	Thu, 18 Jun 2026 17:46:35 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781804797; cv=fail; b=jzsU1h/1K8Kw9sWbZa+hepd1ypmWJtR8mU3Sx0/Ra3gpV/EmxzrBQDXDy5x/fD50ggeqX3qsefBj7Ph5BPO8/qZBDO1J/MVQTCCPUSoLbMfy5S4i/3Iz/XgvAv19/OlpbClKmYSvlD1bd6LC28Fr96n7nN5ApV4OlRBd3qK8/Lg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781804797; c=relaxed/simple;
	bh=e8gdcThY8MXqcEx/HzJLSRSdQaURDC3j3BpJTmB7RNw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=hWSSq2z99oSRboCALI3013ALVfxBknMqpwSBZev9XmfdVKnl8EuX2NiGOGO5uM3X7prAhFgh7XO+cxibkhVRJPg38CxCPmXUIhObTNL87eBx/KqtdhhTf2qW6QaCzG/DfnudlZBOHjG6AToOzWDVF7XIvMQeTUqJ+mbfLMP4Aj0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=KLUKLx52; arc=fail smtp.client-ip=52.103.14.65
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VMTovgWgSTmpET1eg68Mx2TA5KQ+t7YrOng4tHiPvX/OoC7vnJbQPH6WigA9ZskHOGrZqhm1PlOy3b6lCFTviBE/f4FP2D9UlU4FW8ycwwBoCr5etznv3EGKGfFZ39rZMaAbczc1EixaKv1bkOXheV7LQmqVbM/Waa5iY+8NmAOEsKFq9hPnrasejUNy3PVqo+YCzFON/sBqQpti/HjACs/RlgcgH/MvnrGkZ91DsXFAk1Yv3roUcYY28CFQrDmee4Dz/6dlftqqS2QLcju3yWROEMcscncot4ZSlzzmAGxOx7QdlA+k906YsRHBl7LFK0P9EtnJ60mrzpKbomEH8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IBvZeznODaAFmuJUfDqCcQp5LmgNtAWeG7F7yArLKjY=;
 b=l0EKLfub2RoZtkbgj19vAY3hehoaHOiBuoHb0/0cAwd+bOK/F53SJv6fYgM5fkge+OBgb96tjq0f2MCZoBOeAvbr5HhP/MHkwgoF7CWspRIoBMV4pvun67LkPlbZJKQv3bp7YryTiDxTDBySkzfvLhghAD8Kp/s0RwBx2+8GX39+7sFG/eeEoTBdPR2WZ6FEVkpD9nCR949ne9RllFGMxmPvQDGW2bH8C6sx7V5jevLysVik1bNnnqy04JMVp7FriLaDw/dGkQopKnAALIpky3nlC7WhPP7hkB+iyo+tdWun72F+Eqx65YqkzXcwtdYOCJgsksCOoWY8RI72//BwNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IBvZeznODaAFmuJUfDqCcQp5LmgNtAWeG7F7yArLKjY=;
 b=KLUKLx52+Lrdl3GuoPlEemK+JVlwHcgb3GbjbaD8D8JrLEqFt1s0+kMaX69QvfdJ67+gWOOKCrcYz5ETNs/TI3HYiSEvwk0YHCKkth5Piis5rix0+oQtan4CMbwyPDyCGhzhluUiE80ErJ6ftKAGbCOSl4nseKy/j29PS71ebYc3o8OQZs9NGeoyetzY1mor06ATBiBHHXSF/ISvWbFh7tbfG/IT9XgFTl04P49qCCkUJGzq4XQUyiCRoxg+h+rKGjpi6nzExUoHxrZ/xGU9wsBsHNKTxeuM544vZUivqZjHIdv1DxwLkquVYFii9f/UYVdjLBw+QGnNoNlI0Tc4rQ==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by SA6PR02MB10791.namprd02.prod.outlook.com (2603:10b6:806:440::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.18; Thu, 18 Jun
 2026 17:46:31 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::900:1ccf:2b1e:52b6]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::900:1ccf:2b1e:52b6%3]) with mapi id 15.21.0139.009; Thu, 18 Jun 2026
 17:46:30 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: Kameron Carr <kameroncarr@linux.microsoft.com>, "kys@microsoft.com"
	<kys@microsoft.com>, "haiyangz@microsoft.com" <haiyangz@microsoft.com>,
	"wei.liu@kernel.org" <wei.liu@kernel.org>, "decui@microsoft.com"
	<decui@microsoft.com>, "longli@microsoft.com" <longli@microsoft.com>
CC: "catalin.marinas@arm.com" <catalin.marinas@arm.com>, "will@kernel.org"
	<will@kernel.org>, "mark.rutland@arm.com" <mark.rutland@arm.com>,
	"lpieralisi@kernel.org" <lpieralisi@kernel.org>, "sudeep.holla@kernel.org"
	<sudeep.holla@kernel.org>, "arnd@arndb.de" <arnd@arndb.de>,
	"thuth@redhat.com" <thuth@redhat.com>, "linux-hyperv@vger.kernel.org"
	<linux-hyperv@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-arch@vger.kernel.org"
	<linux-arch@vger.kernel.org>, Michael Kelley <mhklinux@outlook.com>
Subject: RE: [RFC PATCH 3/6] arm64: hyperv: Add per-CPU RSI host call
 infrastructure for CCA Realms
Thread-Topic: [RFC PATCH 3/6] arm64: hyperv: Add per-CPU RSI host call
 infrastructure for CCA Realms
Thread-Index: AQHc+DtPOuQtWWWiVEm0BFnDhje0VbZEpFGA
Date: Thu, 18 Jun 2026 17:46:30 +0000
Message-ID:
 <SN6PR02MB41577A7B554CCE8414041287D4E32@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <20260609181030.2378391-1-kameroncarr@linux.microsoft.com>
 <20260609181030.2378391-4-kameroncarr@linux.microsoft.com>
In-Reply-To: <20260609181030.2378391-4-kameroncarr@linux.microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|SA6PR02MB10791:EE_
x-ms-office365-filtering-correlation-id: 8611d60d-f759-4394-04df-08decd6187e8
x-ms-exchange-slblob-mailprops:
 qdrM8TqeFBvhuFgLLe5qs4jWk9CHdv0AGgV/B5l+/hqauZZNPspa+qsTJwVaV4ux0aUIbxw8qO3D9Q5IEDdyExo/IBuzhuGl4+T3HsbqMtRQnlGmxRbIU1N6Dhle25qWxp+GrzmG3qoHgyuBz4o2mVT/laLm2qyUOqW948Rwiwul4wOSDFfkhoT2Zdn9gnFbnyLZQXJqgs0d6PTtE4atSESAIzzk6urf4xMCRZzvbmOzAEBrs7Uj9gkfvpr0vbOO8kM8jSXopwykz/Mov8VTy3m0w30LElk/1JLk7nSPY/dTSdk70P4oO425UfVvK4b6VfT6dMGdK6q6yuaF0+868NfQOnLJnwkPr0ZZbcggj6K+PuMd9VpyEW8MU99v9zMcnAjro/m1N3mKOCouAfw1dRP9uBf6XBTS8XFQPTF7wge5nxofTyuPs2Sl2R6rUIwdruqawjQ6ECgPY4MBCjUVEiRSdhIchBNTQHhFzTdUrforFxt9IRhEsfmYVDaNaH2TGXKvCz09ijUGX7QrYHqusMMKnQGaxgi8ZVO8SEvolcSTwMExBRPVQiBCYrmBWfEHLafaH4zKEqHfYfBsi6jPO/BEhIvUZlRaLHL20Fm9JtlUQz3iPikhLuY5y91OgGmrXT0nPg2KzIC7uGTi5MIUN29eZJ1en+G0rESINkKYUXbe7x+xyhJQyXajXgfFngtK4PbPHektU7aUZjNZHPAhV7LhMlJOudvuQuTYSwdHoqlpLn17dUqCSSONKxbN+WrME8BxmOGWmNgDAIcvefwgYBskTLxr7e+6
x-microsoft-antispam:
 BCL:0;ARA:14566002|37011999003|41001999006|31061999003|8060799015|8062599012|15080799012|19110799012|19101099003|13091999003|51005399006|102099032|40105399003|3412199025|440099028|12091999003|1710799026;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?7uFNLHpSd1PjXRHCneQP1hpUOrKVcZeYcXNQmemT9NcCQeSjQ0i9i8Z8/ycK?=
 =?us-ascii?Q?ttrGNOF9+zBrX5405jEjvvr0/slwgs10VzX/2i+ESdDaGZWFIZjGWngijAOF?=
 =?us-ascii?Q?N9ss++vGWI+50/ruT70gMgctw5XKnmtaaSseB2v/jXqCIGY9xE+gkGIe5oC3?=
 =?us-ascii?Q?iHDDtqoRC3cONtUvM6IUi4hRr+KGcK9WGXNFxDks7nGNFPfEo0F2sbZdYnso?=
 =?us-ascii?Q?ByVSyIfLVz/NaKHg4Fuhuks+IrhYPdl5xW0fkUw/3ushacZcT7cAdGBevAmo?=
 =?us-ascii?Q?qDQXbagaHFxe25BXmm/tuvIH2UKdY+y7DuIAQFTjcUIBzs1nbfMpjPQYfRou?=
 =?us-ascii?Q?cAM33iigmA6ivcsWfhjeFDs8kkC+O/VT/efLZuNhQsEu9HgpNrn0i3sGY1BW?=
 =?us-ascii?Q?d0qV0mvxNGeT+wh+Rz/0TSSGL02cLpzrA35kNbK5FOZ4OxQDZt23gwcyr2tU?=
 =?us-ascii?Q?JSxnMxJKxEWVVbNOuJD1IwIvaoOFVwyVTrmhC2zFcE16Vpcon0xU1HoTBWFc?=
 =?us-ascii?Q?i2bRUKNY+6YxCRJ8QZuYP5YbBaU7BpkaQkIJdEuc6X5LIZYryToCH/CyK9Ei?=
 =?us-ascii?Q?tRda7r1qGkKD4DoqoSDHNixeDdWD+sZIC2oXWuqQfqKEUJgM2VLNvr2CiL48?=
 =?us-ascii?Q?78AGC9TszrDsUB+Ndmvn65tNmwo92wASYlrVKkABs9nH1fQzFoB5v2KgWCVY?=
 =?us-ascii?Q?m68KRHlDoTJNjSSeZrziRAJrQ8QeKHfUZM5kOPrITgAooKHm8orhlBx5jQUe?=
 =?us-ascii?Q?r5V5q7nftb3fAcO2fVO6ZQPODDJ3AtwXF6/LlFzrAimNVY4MvlH0ya7EbBdI?=
 =?us-ascii?Q?SekHC8lKWPQDXEZwA5NB8hfRCQCQhvcTIg+fKRIYxGWceuaAl+vcRnUX6MpH?=
 =?us-ascii?Q?Uaj8+pD+chpnyquSn0aFhBwIt2SrBUl0mPF3VgdFcb7SK9Lbv4lbiK/X8lGV?=
 =?us-ascii?Q?LIAwb2iX6AQCdL+4OMn1r7xdQK9Vyn5gq9vL6QpLt9j3uw4/L9YRrEJzfNgC?=
 =?us-ascii?Q?3BquW9A16rsF3Aw/F9PNJN2c8n1kNbuHYW4YpEZYvZ+WyKYqQFcYcH2DuqE5?=
 =?us-ascii?Q?PaSxnpd4VwDhW+0eK8sTJtNZGA9yfg=3D=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?Jl4Fn/QEMYuV/fMxqCdfW5ttKY2/5079iBr2JNRsDjDyafHFVudHQfL1FCaL?=
 =?us-ascii?Q?p+kXwukPPiDkBFMqOcD8tVORIeDuTy6pm5zUjZj16pHtLbILhxmVNpqYGXO4?=
 =?us-ascii?Q?WPk0M52PK765uImh3qEDMiNxmN7bA+7wnyG2IdY9Rgfn+6a7K7hb07yJnp26?=
 =?us-ascii?Q?77X/YYhkOPzqT5oZ9wWBV29jACF9rPCoEAeaFreStFF2O9hmvX4JKEmBEljx?=
 =?us-ascii?Q?0uaZQckV99AjQFgF96t7YRtT+WD32wRgi/wUiBxgZQ2Y05mMXGcmkmFg8RvV?=
 =?us-ascii?Q?/OP/y7lT7i9sC1XoEVId4aiZHscenVGs3ziWq46DANfpSokM1aFG7CYVLONi?=
 =?us-ascii?Q?+XDztwiaf1D3YtCnUxpI4uRYxpAJx9G5orrMXfRKj7BIt7A/gXQBADCuvX/D?=
 =?us-ascii?Q?2e0R+98MYtuGZa4L0q1TlDJqN9Jkez0C+NLBgjVAc7mFBM9zxQtKLisAoErs?=
 =?us-ascii?Q?xJXodAmWniNI5Lx/PBfWOi6wESqGjEiiraHMGBdfQwya2yVqYV46As2KLuN6?=
 =?us-ascii?Q?040Justa7sztS6dIv1uO+EM1SLPECHwT3Gw0QjtM/gkfzHOPwdBfhYVb2tQT?=
 =?us-ascii?Q?3DhCslyd8zxbn9Qw1h2df4KIiKMbW2CnC438wpXyEtcjcMPU/MKvymr5FkC8?=
 =?us-ascii?Q?YxtxNveFhTAiXSMm4MVt8aNz7oLeLbTV/qSVxLlxmw0hmMdZZepv2wjuey3S?=
 =?us-ascii?Q?og8XQoUsKXWRilRXy9kKIFYhIIkVNOgkPi1et5O7OL7rPUASMfFwVEK0a1+/?=
 =?us-ascii?Q?CbcG/77NKulOoDXMq3mmJ6cte5TuFzOplxnJc4Ox9qdZKcawmAS84+/sYQKh?=
 =?us-ascii?Q?imu/FADhXqEByR3Ow31CE4+vHvnYysqMp+0LxfcPkbVVOYiCovfYWxXxsNOm?=
 =?us-ascii?Q?CHg+gtKT8pvvmLozYl7SwCDm4NGQLO1CuVrDhAWqB6oYn5efJ1Vk15Searh0?=
 =?us-ascii?Q?Kz6X+8VghZ0WHJ3DQis6TOHatLIUt19/NjBGy8tEvV/K0hYYsfxcAQ7a55iG?=
 =?us-ascii?Q?7rTR6xKURCQhVtDYLb/ZVDQ3mSL6wIIS9uncz8eO2N93vSTGO5AlDY//a2Qm?=
 =?us-ascii?Q?RZ+FpwWn8H6a0Abtp/dszGvf6hlOPSdi/0/8SWpRDSFm++9tOW13HVwxSNpN?=
 =?us-ascii?Q?I3hOX2o+sppMnH3gVKiydY7zWf9sG3+UPXxjnS5ekB2E5EXvrZZeq7WvdOag?=
 =?us-ascii?Q?QgKCdQyn0HiwuL8EdbXIHWvaXaMlBSPiuv6fFu7aNtH6INiOClAlP8wjBdWu?=
 =?us-ascii?Q?Zj10l+n7mMKh8sqGb8iRaDqzQa8U4ABFdQWMPqtko00cGN8LzwinISz7dXZP?=
 =?us-ascii?Q?vGdJtYLDM91ohNjcqBBUgaJGguJgZTftSl7Y6O3NPrtCCx7yiH0kYcNw0LF0?=
 =?us-ascii?Q?/Lrtva4=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 8611d60d-f759-4394-04df-08decd6187e8
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jun 2026 17:46:30.8639
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA6PR02MB10791
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[outlook.com,none];
	R_DKIM_ALLOW(-0.20)[outlook.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-11638-lists,linux-hyperv=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:kameroncarr@linux.microsoft.com,m:kys@microsoft.com,m:haiyangz@microsoft.com,m:wei.liu@kernel.org,m:decui@microsoft.com,m:longli@microsoft.com,m:catalin.marinas@arm.com,m:will@kernel.org,m:mark.rutland@arm.com,m:lpieralisi@kernel.org,m:sudeep.holla@kernel.org,m:arnd@arndb.de,m:thuth@redhat.com,m:linux-hyperv@vger.kernel.org,m:linux-arm-kernel@lists.infradead.org,m:linux-kernel@vger.kernel.org,m:linux-arch@vger.kernel.org,m:mhklinux@outlook.com,s:lists@lfdr.de];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FORGED_SENDER(0.00)[mhklinux@outlook.com,linux-hyperv@vger.kernel.org];
	FREEMAIL_FROM(0.00)[outlook.com];
	FREEMAIL_CC(0.00)[arm.com,kernel.org,arndb.de,redhat.com,vger.kernel.org,lists.infradead.org,outlook.com];
	RCPT_COUNT_TWELVE(0.00)[18];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,outlook.com:dkim,outlook.com:from_mime,vger.kernel.org:from_smtp,SN6PR02MB4157.namprd02.prod.outlook.com:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 05CB46A2001

From: Kameron Carr <kameroncarr@linux.microsoft.com> Sent: Tuesday, June 9,=
 2026 11:10 AM
>=20
> Arm CCA Realms cannot issue Hyper-V hypercalls via HVC; the guest must
> route them through the RSI_HOST_CALL interface, which takes the IPA of a
> per-CPU rsi_host_call structure as its argument.
>=20
> Add hyperv_pcpu_hostcall_struct as a per-CPU pointer to that buffer and
> allocate it for the boot CPU during hyperv_init() and for each secondary
> CPU in hv_cpu_init(). The allocation is gated on is_realm_world() so
> non-Realm arm64 Hyper-V guests pay no memory cost.

I wonder if there's a simpler approach here. What about calculating the
total size of struct rsi_host_call needed for all CPUs, then doing a single
dynamic allocation to effectively create an array of entries? Each CPU
would just index into the array with its processor ID. You could still have
a per-cpu pointer that points to the correct array entry to avoid the need
to get the processor ID, but I wonder if even that is worth the trouble. Si=
nce
struct rsi_host_call size is a power of 2, the indexing is just a simple sh=
ift.

The hyperv_pcpu_input_page is allocated the way it is because it's much
bigger. But 16 struct rsi_host_call fit into a single 4 KiB, so there's no
danger of hitting a memory allocation limit at boot time. Even with 8192
CPUs the allocation is only 2 MiB.=20

Michael

>=20
> Signed-off-by: Kameron Carr <kameroncarr@linux.microsoft.com>
> ---
>  arch/arm64/hyperv/mshyperv.c      | 78 ++++++++++++++++++++++++++++++-
>  arch/arm64/include/asm/mshyperv.h |  3 ++
>  2 files changed, 79 insertions(+), 2 deletions(-)
>=20
> diff --git a/arch/arm64/hyperv/mshyperv.c b/arch/arm64/hyperv/mshyperv.c
> index 4fdc26ade1d74..08fec82691683 100644
> --- a/arch/arm64/hyperv/mshyperv.c
> +++ b/arch/arm64/hyperv/mshyperv.c
> @@ -15,10 +15,16 @@
>  #include <linux/errno.h>
>  #include <linux/version.h>
>  #include <linux/cpuhotplug.h>
> +#include <linux/slab.h>
> +#include <linux/percpu.h>
>  #include <asm/mshyperv.h>
> +#include <asm/rsi.h>
>=20
>  static bool hyperv_initialized;
>=20
> +void * __percpu *hyperv_pcpu_hostcall_struct;
> +EXPORT_SYMBOL_GPL(hyperv_pcpu_hostcall_struct);
> +
>  int hv_get_hypervisor_version(union hv_hypervisor_version_info *info)
>  {
>  	hv_get_vpreg_128(HV_REGISTER_HYPERVISOR_VERSION,
> @@ -60,6 +66,46 @@ static bool __init hyperv_detect_via_acpi(void)
>=20
>  #endif
>=20
> +static void hv_hostcall_free(void)
> +{
> +	int cpu;
> +
> +	if (!hyperv_pcpu_hostcall_struct)
> +		return;
> +
> +	for_each_possible_cpu(cpu)
> +		kfree(*per_cpu_ptr(hyperv_pcpu_hostcall_struct, cpu));
> +	free_percpu(hyperv_pcpu_hostcall_struct);
> +	hyperv_pcpu_hostcall_struct =3D NULL;
> +}
> +
> +static int hv_cpu_init(unsigned int cpu)
> +{
> +	void **hostcall_struct;
> +	gfp_t flags;
> +	void *mem;
> +
> +	if (hyperv_pcpu_hostcall_struct) {
> +		/* hv_cpu_init() can be called with IRQs disabled from hv_resume() */
> +		flags =3D irqs_disabled() ? GFP_ATOMIC : GFP_KERNEL;
> +
> +		hostcall_struct =3D (void **)this_cpu_ptr(hyperv_pcpu_hostcall_struct)=
;
> +		/*
> +		 * The hostcall_struct memory is not freed when the CPU
> +		 * goes offline. If a previously offlined CPU is brought
> +		 * back online, the memory is reused here.
> +		 */
> +		if (!*hostcall_struct) {
> +			mem =3D kzalloc_obj(struct rsi_host_call, flags);
> +			if (!mem)
> +				return -ENOMEM;
> +			*hostcall_struct =3D mem;
> +		}
> +	}
> +
> +	return hv_common_cpu_init(cpu);
> +}
> +
>  static bool __init hyperv_detect_via_smccc(void)
>  {
>  	uuid_t hyperv_uuid =3D UUID_INIT(
> @@ -73,6 +119,8 @@ static bool __init hyperv_detect_via_smccc(void)
>  static int __init hyperv_init(void)
>  {
>  	struct hv_get_vp_registers_output	result;
> +	void **hostcall_struct;
> +	void *mem;
>  	u64	guest_id;
>  	int	ret;
>=20
> @@ -85,6 +133,27 @@ static int __init hyperv_init(void)
>  	if (!hyperv_detect_via_acpi() && !hyperv_detect_via_smccc())
>  		return 0;
>=20
> +	/*
> +	 * The RSI host-call buffer is only ever used when
> +	 * is_realm_world() is true. Skip the per-CPU allocation on
> +	 * non-Realm guests.
> +	 */
> +	if (is_realm_world()) {
> +		hyperv_pcpu_hostcall_struct =3D alloc_percpu(void *);
> +		if (!hyperv_pcpu_hostcall_struct)
> +			return -ENOMEM;
> +
> +		hostcall_struct =3D (void **)this_cpu_ptr(hyperv_pcpu_hostcall_struct)=
;
> +		if (!*hostcall_struct) {
> +			mem =3D kzalloc_obj(struct rsi_host_call);
> +			if (!mem) {
> +				ret =3D -ENOMEM;
> +				goto free_hostcall_mem;
> +			}
> +			*hostcall_struct =3D mem;
> +		}
> +	}
> +
>  	/* Setup the guest ID */
>  	guest_id =3D hv_generate_guest_id(LINUX_VERSION_CODE);
>  	hv_set_vpreg(HV_REGISTER_GUEST_OS_ID, guest_id);
> @@ -106,12 +175,13 @@ static int __init hyperv_init(void)
>=20
>  	ret =3D hv_common_init();
>  	if (ret)
> -		return ret;
> +		goto free_hostcall_mem;
>=20
>  	ret =3D cpuhp_setup_state(CPUHP_AP_HYPERV_ONLINE,
> "arm64/hyperv_init:online",
> -				hv_common_cpu_init, hv_common_cpu_die);
> +				hv_cpu_init, hv_common_cpu_die);
>  	if (ret < 0) {
>  		hv_common_free();
> +		hv_hostcall_free();
>  		return ret;
>  	}
>=20
> @@ -125,6 +195,10 @@ static int __init hyperv_init(void)
>=20
>  	hyperv_initialized =3D true;
>  	return 0;
> +
> +free_hostcall_mem:
> +	hv_hostcall_free();
> +	return ret;
>  }
>=20
>  early_initcall(hyperv_init);
> diff --git a/arch/arm64/include/asm/mshyperv.h b/arch/arm64/include/asm/m=
shyperv.h
> index b721d3134ab66..65a00bd14c6cb 100644
> --- a/arch/arm64/include/asm/mshyperv.h
> +++ b/arch/arm64/include/asm/mshyperv.h
> @@ -63,4 +63,7 @@ static inline u64 hv_get_non_nested_msr(unsigned int re=
g)
>=20
>  #include <asm-generic/mshyperv.h>
>=20
> +/* Per-CPU RSI host call structure for CCA Realms */
> +extern void *__percpu *hyperv_pcpu_hostcall_struct;
> +
>  #endif
> --
> 2.45.4
>=20


