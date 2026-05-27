Return-Path: <linux-hyperv+bounces-11242-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kHV/G6wJF2pB2AcAu9opvQ
	(envelope-from <linux-hyperv+bounces-11242-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Wed, 27 May 2026 17:11:40 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id E31235E69DA
	for <lists+linux-hyperv@lfdr.de>; Wed, 27 May 2026 17:11:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8EC2C3010279
	for <lists+linux-hyperv@lfdr.de>; Wed, 27 May 2026 15:05:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2580741325B;
	Wed, 27 May 2026 15:05:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="dArCv6vv"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azolkn19011071.outbound.protection.outlook.com [52.103.23.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8A5C3BD638;
	Wed, 27 May 2026 15:05:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.23.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779894318; cv=fail; b=TZ0B093Pd40ndKD7L9gWxa0zxBsiPSfxsC3q3ldgsQ4Yhp/VEYbm5AfuTsEuME1sq43UuDyB7Qyee3Bh8XTDkOkDRXNboiSX5+ogKy8uo2Gd25Zqib4j26Zrjqgz7ldjXtuDbAy8lFlC2VbAH1q/1AI8aIJyWQpjxp1PJk0mfyM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779894318; c=relaxed/simple;
	bh=u5MiQpz1gOwpyC/i/00dVg3VWbictjpU7Z77qPWl5FQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=S8wUt4/ap9U53paKc9gepUPIIWaRqhIWH7nhJLhelqeLyGM6XlATlNE69iKQQG0Cpr+9Qke3taM7U1gqIe4muaYoHGuCeDHLb+Al+gIgfKEWqRf9FzhlWKSPCrTmjg+GPkHitVkR/M6CWNDe+9BeBOIncRNLQvYF4t6LaDVJnmw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=dArCv6vv; arc=fail smtp.client-ip=52.103.23.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Usrio8MCRwuZKZOcmhSOMVSfcJNQyPNMdHGnUA+hf8FjuxhpO/r+RkCmcWBOrvIJ9GWJY7eMusdCdaEVx9SkQBHLBcE3pxPxKeE+ndDNCtiZtOx+NG7brvfxg8uM8Q1nD4wNrcFYyBTldJYaoigiGpruyVYfYQFFLhLxfhnvDuVXRQEVL77BWjgjL+9nxSyyZxzBxfmCfxnfe34pcgJwp0TljK8xghNMA+jyup3LEiIXdnSbiN/zl04IBq+CoRTV3Q95rvlQtNJ2gJpY075RnIzWnqOBV0XvhXgXBK9qm8/REMrdCSX3d9DKSeScx0lPoaDHmFeXfOZ4so14XcynCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TpIyLntWVY1r3Rr1EhhgPM2dUfuLEubta5IewGZykfA=;
 b=ir7MGBhxskZ+HaqVXF4oRKcYqoFEogJIE64ajvk6CQBdbI5QVB6KlSCUfKsnrbxTjfc2x5o/uk4MSEp1L/4DpMJuDDJYIhL3d6WZP+5sL1EbSM+U72OUaQKLyj/NJWYMB48g69P0Q5BdineOOl1XM4/5D6O+PEQfV7QE24EsDFP7eaWIGRH2vNICOoYXxHsmfKqbVj8gg4bfT8SQqTr3HZT46wJ+leT9JRwiO/9u9hXMb74ya2uWMkrcoz0aGjBP6bC1ZlBxbhWZEcehqpoBrW87nlNZHixDDbcHsfoY3dcIpCGyj2eXXwcD0CsYNVGPFsaXMII36vJnNx2DJgsqeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TpIyLntWVY1r3Rr1EhhgPM2dUfuLEubta5IewGZykfA=;
 b=dArCv6vvVQNXr5UamgfUtw7tqU1Jhklsj2PTulrDJgGvE5nkPGtxb4oXOg0mxBypsvJc/1jNwNRQeDlA6lqG/L6XndRB2EUWv+Uq2Jz82403OrHUJ0qmVDB4L+hJXoJfIW81yriF9HZzuqrvOTZBg/4tCc6gWBYM7OAjubXmshpVwbg8fGB1dqRNHERnXoXpOMSQuLczgHYDgdpRvkgK54FIQDnd+f6hNdFRtmbhYm7lqM6eJFOZ/675w6SuTWrJ4tXIcTwcRoaUJCXqGtae856PZ/3HSOfuuIoQoxGiQZTrNrez6A1s2H9hjbUwLpSZpTdQkvjTsFG73IaIN23zHg==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by BY5PR02MB6594.namprd02.prod.outlook.com (2603:10b6:a03:20b::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.13; Wed, 27 May
 2026 15:05:14 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::900:1ccf:2b1e:52b6]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::900:1ccf:2b1e:52b6%3]) with mapi id 15.21.0071.011; Wed, 27 May 2026
 15:05:14 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: Hamza Mahfooz <hamzamahfooz@linux.microsoft.com>, Michael Kelley
	<mhklinux@outlook.com>
CC: "maarten.lankhorst@linux.intel.com" <maarten.lankhorst@linux.intel.com>,
	"mripard@kernel.org" <mripard@kernel.org>, "tzimmermann@suse.de"
	<tzimmermann@suse.de>, "airlied@gmail.com" <airlied@gmail.com>,
	"simona@ffwll.ch" <simona@ffwll.ch>, "decui@microsoft.com"
	<decui@microsoft.com>, "longli@microsoft.com" <longli@microsoft.com>,
	"ssengar@linux.microsoft.com" <ssengar@linux.microsoft.com>,
	"dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>
Subject: RE: [PATCH 1/1] drm/hyperv: Replace "hyperv_" with "hvdrm_" as symbol
 name prefix
Thread-Topic: [PATCH 1/1] drm/hyperv: Replace "hyperv_" with "hvdrm_" as
 symbol name prefix
Thread-Index: AQGYZGmpZbciqp3jXtRxdrQwqzIko7aq6eCAgAAhusA=
Date: Wed, 27 May 2026 15:05:13 +0000
Message-ID:
 <SN6PR02MB4157EC6C4CE3BBE2ACC3E86AD4082@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <20260526205239.1509-1-mhklkml@zohomail.com>
 <ahbr3aepFUuJ45Zg@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
In-Reply-To:
 <ahbr3aepFUuJ45Zg@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|BY5PR02MB6594:EE_
x-ms-office365-filtering-correlation-id: fae870ec-5f72-40da-5de1-08debc015aff
x-microsoft-antispam:
 BCL:0;ARA:14566002|51005399006|37011999003|15080799012|19101099003|13091999003|19110799012|31061999003|8060799015|8062599012|440099028|3412199025|102099032|40105399003|1710799026;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?E2Jj0gAKB91P4LZVeSoFIqypkWpRvBCaAKLoL9JuUIVTH+QNb7AGe7VA4Tnv?=
 =?us-ascii?Q?OKs95ZkssTg70RJHcb15uIHyybUpQSd/QhHwcm65FzQHvGodtRXWkTbLkD0g?=
 =?us-ascii?Q?mCdLkJSRbYbfzJ03I4ZeK4zyueciF5a3VBH3N0rcDhVY5MSjM6kSwlJinzsZ?=
 =?us-ascii?Q?DdP/iOegymTa66Flv5sycogqzb4l6uf4bgU4pdTCOlquieIwr0DfeLetqnyh?=
 =?us-ascii?Q?WBtx1RAXeGUbvxCfHiI8wjPZb0x5spcF1KpjnbKmrhtspCBWq7jD7PBlaDgv?=
 =?us-ascii?Q?N/xpwYJm7SXv0cMxPftWVznxyaHvghHkXZjv/BOAzbwzwW51+gsocbogHsku?=
 =?us-ascii?Q?Iqnmear1NeACfgz/BLY9qM55OAPR2D6bLNelYXnJWyNJXyYafqjlMN0OBsYJ?=
 =?us-ascii?Q?RUwW5cwvd7xJIBbCgg/ojFtcfuYGYCKWI/Y4sY0j/KdaccXuMpMACldq3o8F?=
 =?us-ascii?Q?gKKdTgGSQpTpRADO2ZMSA9D7AF8hBpq/ghDLTsakshI6v1U2cs2IJab5gLOr?=
 =?us-ascii?Q?EcwPv80WokLsiHP7geOq2RszX9p/V6oXFQdEKgKJN4fQfwrAS+By0maiUuez?=
 =?us-ascii?Q?6IqmsAJ7Xl0+t+bNNL/zV7J2Usd/FjWc6G0o3kO5CzSA+UdRT6mz40KJzs1D?=
 =?us-ascii?Q?FMn4rPrjZm1LgXgHLMfjEM1F72QB02dl7tQ9inETzscigmOLEbBaGqAQS9eN?=
 =?us-ascii?Q?m4PA7EWbHsNRTlbL1pJdEUh2IqyovOGEHOqfuW0Lww7tC8R4/EtQNfGwVZyx?=
 =?us-ascii?Q?PWCXS9dKaMCV/RADL2/Qz0AJd0UDSUlKZAmp6KQNsKHIeFjKjCGj6yWQFUqe?=
 =?us-ascii?Q?y1AeXMlX64bsd3Pr1IGxo/Ai/Vm993s6MpxYVZgPm4sPAqI6P55fPuFl8wNJ?=
 =?us-ascii?Q?0qOS/cedm36RjKloABgpDa1EnpJ7mg+jZzwIuSMxNNN1lJFR42T/5jM/IUPj?=
 =?us-ascii?Q?OlE5wz1F5vFD35G7c6Lusqem7k99Ix82RUGIPvCZuhQv2mS9+0NGvR/YV3j9?=
 =?us-ascii?Q?2Vu5QUUjNSMSPv70wqCm0TwGVw=3D=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?LyP+wOQwTrA47E8cw2MeCbR0yDI/iP5YTwQC05YJiHyN54QPStnGUhCzjAs9?=
 =?us-ascii?Q?lxV+n4gUTRf0i5U+VuYkc6FnTJ7bk9vmhmbesXoKYy4zDlIwg+f8Nx/sfV5T?=
 =?us-ascii?Q?CP4Zw4jdtUqvDT3RbiyAPAt7uW90GSDQwLsTfyJ4xgYxFakyVuO/L+ua42MX?=
 =?us-ascii?Q?EMXKC64WN8Qm7RfYhUN7XR42tVknY42nv0p6g7jrnnEwozkaXcAuj7GG+EYy?=
 =?us-ascii?Q?sNgEvnEGXia0j2HDSqK8ernfZ+rJNuz/boiMqDpmeGlM5QrfZD2xjXoQcbJm?=
 =?us-ascii?Q?NpkC9rc2jQn1Tl2PviTqRjFkeej47XkGW2+dOVfQ02/rWXYL5FhOcIMxyCnT?=
 =?us-ascii?Q?1oR0GsM9qyTSJ96NKsmJUaOpPu7SOozuPlC7VcYntRG5OR82q+jigOGbR+lT?=
 =?us-ascii?Q?OXaDjO8FTaI38pm3Xt4infyHoOK/hFvId78jNIr5KteOnrBwpF3hZa9Eokvq?=
 =?us-ascii?Q?qBZ5s9R/p5jMmnMoJ8qsuduuF77SXMJSvlyfG0uSdLsF0GW1smKgeUuN/hg+?=
 =?us-ascii?Q?StHclMPPGvrfmzFO4woLwDoocykrmlXLRPJuVr8n74kddhM5XUY5vzMuguVZ?=
 =?us-ascii?Q?Pr2WLcnHD0GuXaYEC3Vm4BXvCU0vJWOhUGvZq+zwdcnV3QbzF3SOwddXnD8U?=
 =?us-ascii?Q?xtqYAcxt0SLhQWjSbk83nMx7+0347gHI0ymIrPuhKOHp+uNLhmZg8a5/2EEN?=
 =?us-ascii?Q?dCuIdfezfIEQvcsgK/zaT4yQM4El9pHEd/gXg3JbRthOwvXH5NKgWWK2Ip9B?=
 =?us-ascii?Q?PJtcAQezxaFF875+PSmZ5zD1pOhwO15kstBkFAsRfUQGxSyc8pCRmNxJyaBR?=
 =?us-ascii?Q?ibbAjdHuWvuToSbbmWU/fUt+su94yWD3a00i9eET6KQBK/TCbRpJvPYE367n?=
 =?us-ascii?Q?xUOQhM7JVttUS0c/hWbVrHy7Yj/7u//LurLAFOgmln3pMUlhQ6VVvcDr4oCo?=
 =?us-ascii?Q?DSVu+voViVJvRRtsofg1MaeT4v1Rg5lFmWNbCILpcHNQYABgN7F+xa55RK9B?=
 =?us-ascii?Q?Ab7oqOqRyDD/cME/Lb4bAYKeMUUscmiVDkox/UY3CNiAApEg+CBgodJCVZnN?=
 =?us-ascii?Q?S6Aq0VcPtMh1zwxm326a5yQowdGQaDrg2bYbdTIwfAxkohlO5PKyLNMPRQVd?=
 =?us-ascii?Q?xEw0VqdNSU+xl0ey500NYxapppVdtRBUT90PbYZuVcJyALOGhwXvo8l9ROMz?=
 =?us-ascii?Q?id9ltxl5oLDMAZv/lNksLJmHTUiMEA3DR03VgUJhF5RC+qZUC7nI7XiVCq54?=
 =?us-ascii?Q?BXgpgp39skw1ThSpz3GFLoI8bSfwk30Q9+6pfwF75S4xslQH+oz6P0amea1h?=
 =?us-ascii?Q?3fnx8c2RRr6RIqP80yfevXaM71luHMdNkWrE0hw1EmDmp2nBXW0r5JFlMTS+?=
 =?us-ascii?Q?75x70x4=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: fae870ec-5f72-40da-5de1-08debc015aff
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 May 2026 15:05:13.8811
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR02MB6594
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[outlook.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114];
	R_DKIM_ALLOW(-0.20)[outlook.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-11242-lists,linux-hyperv=lfdr.de];
	FREEMAIL_FROM(0.00)[outlook.com];
	RCPT_COUNT_TWELVE(0.00)[13];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[linux.microsoft.com,outlook.com];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[linux.intel.com,kernel.org,suse.de,gmail.com,ffwll.ch,microsoft.com,linux.microsoft.com,lists.freedesktop.org,vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[mhklinux@outlook.com,linux-hyperv@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[outlook.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-hyperv];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[SN6PR02MB4157.namprd02.prod.outlook.com:mid,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,outlook.com:email,outlook.com:dkim]
X-Rspamd-Queue-Id: E31235E69DA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Hamza Mahfooz <hamzamahfooz@linux.microsoft.com> Sent: Wednesday, May=
 27, 2026 6:04 AM
>=20
> On Tue, May 26, 2026 at 01:52:39PM -0700, Michael Kelley wrote:
> > From: Michael Kelley <mhklinux@outlook.com>
> >
> > Function and structure names in the Hyper-V DRM driver currently
> > use "hyperv_" as the prefix. This conflicts with usage in core Hyper-V
> > and VMBus code, and incorrectly implies that functions and structures
> > in this driver apply generically to Hyper-V. A specific conflict arises
> > for "hyperv_init", which is an initcall for generic Hyper-V
> > initialization on arm64. The conflict prevents the use of
> > initcall_blacklist on the kernel boot line to skip loading this driver.
> >
> > Fix this by substituting "hvdrm_" as the prefix for all functions and
>=20
> I would personally prefer "hv_drm_", since it seems clearer.

My choice of "hvdrm" mimics the old Hyper-V FBdev driver, which
uses "hvfb" as the prefix. However, looking through everything that
starts with "hv" in /proc/kallsyms, I also see prefixes with the additional
underscore.  "hv_kbd_" in the Hyper-V keyboard driver is an example.
The Hyper-V utils drivers have both forms -- I see "hv_vss_", "hv_ptp_",
and "hv_kvp_", but also "hvt" (for Hyper-V Transport). So the historical
practice is inconsistent.

I'm OK going either way.  Does anyone else want to express a
preference?

>=20
> > structures in this driver. This prefix marries the existing "hv" prefix
> > for Hyper-V related code with "drm" to indicate this driver.
> >
> > The changes are all mechanical text substitution in symbol names.
> > There are no other code or functional changes.
> >
> > Signed-off-by: Michael Kelley <mhklinux@outlook.com>
> > ---
> > This patch is built against linux-next20260526.
> >
> >  drivers/gpu/drm/hyperv/hyperv_drm.h         |  20 ++--
> >  drivers/gpu/drm/hyperv/hyperv_drm_drv.c     |  88 ++++++++--------
> >  drivers/gpu/drm/hyperv/hyperv_drm_modeset.c | 110 ++++++++++----------
> >  drivers/gpu/drm/hyperv/hyperv_drm_proto.c   |  70 ++++++-------
> >  4 files changed, 144 insertions(+), 144 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/hyperv/hyperv_drm.h
> b/drivers/gpu/drm/hyperv/hyperv_drm.h
> > index 9e776112c03e..66bd8730aad2 100644
> > --- a/drivers/gpu/drm/hyperv/hyperv_drm.h
> > +++ b/drivers/gpu/drm/hyperv/hyperv_drm.h
> > @@ -8,7 +8,7 @@
> >
> >  #define VMBUS_MAX_PACKET_SIZE 0x4000
> >
> > -struct hyperv_drm_device {
> > +struct hvdrm_drm_device {
>=20
> "hvdrm_drm_device" looks kinda redundant, perhaps
> s/hyperv_drm_device/hv_drm_device would be more sensible.

Yes, I'll make this change. And in looking through kallsyms, I
see that the Hyper-V DRM driver has "hv_fops", which did not
get changed in the mechanical substitution because it doesn't
start with "hyperv_".  I'll change it to hv_drm_fops.

Michael

