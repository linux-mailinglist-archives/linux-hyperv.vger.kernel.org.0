Return-Path: <linux-hyperv+bounces-11310-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QGNjOsRLGGr4iggAu9opvQ
	(envelope-from <linux-hyperv+bounces-11310-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Thu, 28 May 2026 16:05:56 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7004B5F359C
	for <lists+linux-hyperv@lfdr.de>; Thu, 28 May 2026 16:05:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7D73530FB752
	for <lists+linux-hyperv@lfdr.de>; Thu, 28 May 2026 13:54:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3466282F17;
	Thu, 28 May 2026 13:54:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="hWKWBe9Z"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazolkn19012086.outbound.protection.outlook.com [52.103.20.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36F29275B1A;
	Thu, 28 May 2026 13:54:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.20.86
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779976462; cv=fail; b=PBKS8oEFB8a4Lar7B7/HFnkg6I5eTxKhydt5vhybjEqP0noPeMsFFOXJ8oEPQZvpXmYdi1FNnNZYpbE9/+/kGcv2l8hM9Bqqr22WA0zrGgJ+wCfLM3xWIsAS+ORFqujzsEkYxWC+nU5aXs73T0uFmsg7jJqQd7icPbYLsn8pDTg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779976462; c=relaxed/simple;
	bh=0kttSxputzrZ2nk+Yg4XD+x5n16GYrc/8Dp4PAQwBi8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=FY8NXkIuxxx7rFxDZU536nYaA8yX2Ec8BTV4wYJmJyY9l1VOLiURY8WG+88We3Z/HZ+lq8d6c1iYvuixbexFs0SEa7zn6fJXeMSeSFwuEKxmbzqRMfKJHyWkrHE4zz/AUgLAWWgBZWo7H037Wyf03GPaJOTb925sl4f6rpaI7ZM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=hWKWBe9Z; arc=fail smtp.client-ip=52.103.20.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DBhU+PLwB6con+xIrbuFeThCpfyLOO5t+9/OVF6OG6gEl9B0+238rsNs45uNnktiyR0miAQMQhasS5pXJWjz1IBAoHSwmvgBr7uLpKKNPuHM6Qs0CvUF1gxyqzlPRu2o/B4leIeuF1OpWvcQbPxTDCAXRgUwzEWXmUIWoYu3aDOau5T7lOP6jRQZgQl81wZRFgB+63/Qt9upG/kXnjv3O8e23J3mFYWrKGbwKAAe3ZNje3tk/03oYzLMF3LKeAKgVqDuVMKbQRR+L+Zd4VbxKSyjcRytX/D+Z/JazGmF44TMf0FCJD+hcteTkaz00F8Wr8WgG1L8FzfZDAbID+luHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TLHtXXW3t5imumU6tX5NvOAaMXNw1RdDRNwA2GPcDfI=;
 b=R8e9/8capRsk+evHq5hYSmfS9N+hgfcQ8yO+SjlfpmmCWnC2b2dmV+WpGpJwP6xn+FfTXskvSFWHSmmEPMOrFSJcjJRYHi00QHb0rErn3h7n4T/2gAdJ+lG7b1+zUbC/yN1DEPxwBxWAa7HoTGUaDXHnmad2ns6hVaf7ZMHSYCYp1suGGSwjaWOeUaVXhr3nDMkqzku0GVjrOVy0Yxeb2y+lpkjOuuhdwezgGgqeExguWAKhesKKpOMEHj7YgwFDQj7KBxMBg7vIIgnWWIYCDCGBO1cjOUX6jAennz7PNTgSMYQJW0KKlFA6oCpTFZ3FLhyFZujXZjsk7cWDTIKqOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TLHtXXW3t5imumU6tX5NvOAaMXNw1RdDRNwA2GPcDfI=;
 b=hWKWBe9ZokbB2NhNP2w2wsyBIAMGn1KHAK7j5Z8f9UdipJ+kVWd1vDSDBMSdteq7VNlzQrN4hhdpZ1dIexVXFWNe9OEoyJMAY8g34fxs+8rkWX0JVJq+AULqCVzqiFApsymKLWC2i6s4MNtCYKh4TTvLjc63vBSVrZrQ1piOdMCRmqV9ZQUMXK64RZt550dCfbHsFS457q7SxRfyfbsmOZEvQB5sQM6GVb15aaQkDHPfPWJcRf3dTrJ/izOE3OCOQHTkgKDAkflvGPoAqR3Vuw0xFqwGXT0K/KhtsM/Er/myiTpClqunr9b8/UOQyNmBfy5fo8kvFB/kVVtqg3toTg==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by BL3PR02MB7905.namprd02.prod.outlook.com (2603:10b6:208:350::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.14; Thu, 28 May
 2026 13:54:12 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::900:1ccf:2b1e:52b6]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::900:1ccf:2b1e:52b6%3]) with mapi id 15.21.0071.011; Thu, 28 May 2026
 13:54:12 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: Dexuan Cui <DECUI@microsoft.com>, Michael Kelley <mhklinux@outlook.com>,
	Hamza Mahfooz <hamzamahfooz@linux.microsoft.com>
CC: "maarten.lankhorst@linux.intel.com" <maarten.lankhorst@linux.intel.com>,
	"mripard@kernel.org" <mripard@kernel.org>, "tzimmermann@suse.de"
	<tzimmermann@suse.de>, "airlied@gmail.com" <airlied@gmail.com>,
	"simona@ffwll.ch" <simona@ffwll.ch>, Long Li <longli@microsoft.com>,
	"ssengar@linux.microsoft.com" <ssengar@linux.microsoft.com>,
	"dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>
Subject: RE: [PATCH 1/1] drm/hyperv: Replace "hyperv_" with "hvdrm_" as symbol
 name prefix
Thread-Topic: [PATCH 1/1] drm/hyperv: Replace "hyperv_" with "hvdrm_" as
 symbol name prefix
Thread-Index: AQGYZGmpZbciqp3jXtRxdrQwqzIko7aq6eCAgAAhusCAAEsHcIABM3WQ
Date: Thu, 28 May 2026 13:54:12 +0000
Message-ID:
 <SN6PR02MB4157FA02F09ED49D58F2B39FD4092@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <20260526205239.1509-1-mhklkml@zohomail.com>
 <ahbr3aepFUuJ45Zg@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
 <SN6PR02MB4157EC6C4CE3BBE2ACC3E86AD4082@SN6PR02MB4157.namprd02.prod.outlook.com>
 <SA1PR21MB6921A2C91F67C10F272E9430BF082@SA1PR21MB6921.namprd21.prod.outlook.com>
In-Reply-To:
 <SA1PR21MB6921A2C91F67C10F272E9430BF082@SA1PR21MB6921.namprd21.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|BL3PR02MB7905:EE_
x-ms-office365-filtering-correlation-id: 96d3cb4f-d364-4ad1-e317-08debcc09982
x-microsoft-antispam:
 BCL:0;ARA:14566002|37011999003|15080799012|51005399006|19101099003|8060799015|8062599012|13091999003|31061999003|19110799012|440099028|3412199025|102099032|40105399003|1710799026;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?ZqM/3LQC/bfvnfUDUDc2+L5ND7SJO2LdjfaFw8HoLalByB9m8Qwc6CbbRqAO?=
 =?us-ascii?Q?9VFpVG3CRAUYcQ7M+WWP6uMIoy68jyjeBbDNSlz2VCo3q3YsqOa4VlKF4dNp?=
 =?us-ascii?Q?KmoOHLmRr0xYmdUlRVF7QHyMKjLvVoaBoaU9xTF2fmX1aPrvTGzXWe1WpQuY?=
 =?us-ascii?Q?3NclXwr+aGcbqp6akKF8A5sk4qu6DHt22GjbnbUx4N/2r7dd6zULwy+6sKBr?=
 =?us-ascii?Q?swtPIK6MYpstMMV5849G4VGxevqL0WxZjcyXc2i3sNKIsgSxKZ9/j2YpnpvC?=
 =?us-ascii?Q?eYFdq031E7mbxpqM0g28+vqaqRIjYrciWBLRxSkHlYABM4kgUqB0vKFqWyZW?=
 =?us-ascii?Q?mbNd5sDGKRCRd8lPXD6/wFCriQ/ZM0flGe+KZfEeZnrmQT9dkvXI9r2bxFpP?=
 =?us-ascii?Q?Jnf+Ulx1RQo+RGd//WKqMw4wr7TrruLetNONRQWn/Qc00BbEGd4XuCIj8M2L?=
 =?us-ascii?Q?bnLJlI0gpd0tnamva0SpdDY+HFUTcHSJiD76xH+xGJMvXdFxeb5H1RHX7r4T?=
 =?us-ascii?Q?MaXIDuR5ZxTPU+tliKFHRHzExYvNoLUHRRl02jR/g2SKAxNGuG905hNnZHON?=
 =?us-ascii?Q?0c9KTnMpdcxq0/WObxyJFSqTgebYy8Zcp6O49UVUVOg0101E4al2wbEyQa7i?=
 =?us-ascii?Q?YYassDpU03MBF4ePa/HFDLoWkLRJjYFjGdD5AMfAR5mGda1D4SVUsvc2Akuh?=
 =?us-ascii?Q?2UCz2+xstb5QLO/L9TTp7ZLGPpXsFZbtsXxZpz41eJXLuQI7mPOz7i5zrs2T?=
 =?us-ascii?Q?Fln20bbDn4XtpjUFyP4O0K21bLq7Ol+nULmiPgSCsARTHKOfmsKvHFClLwsh?=
 =?us-ascii?Q?a1jFqDm4hequVAd4VpRgp3xPgnXVzeNK3rewHeP9ZdNNDsupaGPjFI0Yqy/t?=
 =?us-ascii?Q?+GJpG9TNFD1KtzJyyjNlBAdr5cVmBFoP1LnVcTmH9nMyBzmrmibgW6NwwIuV?=
 =?us-ascii?Q?MJf50N072JFe/rBTw5imotVd+/4ETpEX0UtjtYdgkcBxGt4BaU/cXoqygjZl?=
 =?us-ascii?Q?RbYC7foR2P+IyBoOzUp3Ef9anQ=3D=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?rolPEmSvFbwkbfppHNYBwXCqCqBqnbgIALn4vSXUoFSg3kEKJ9F/bwo2jCkZ?=
 =?us-ascii?Q?o8kMy9+cV9TFxEG5+gNLzqw1yQsUJJOdw7zRshI24CMrJQlBIpugH8QRRuSX?=
 =?us-ascii?Q?2BMeyKObNfd3sFth3ZOJd3t3EkI4to5LjKRe3TCAIenKwyS2vASBi1PS+5Wt?=
 =?us-ascii?Q?6U8mD+sDBMKkOzIMluFb50EjNF/WIYM0408aPI/xc/F/IdAVtO6dt8osV+eg?=
 =?us-ascii?Q?F2YzZ+QXs7znM4qBfIBbTVXhUvS2Doe5NQAdbECQ9gbnTXpBH47fAMQ/y0w3?=
 =?us-ascii?Q?4mceWg0KI/epEKLEEsz+5xQh79nrZaBbkjEoEJORzc/cFLP1GI1inxyifqfJ?=
 =?us-ascii?Q?loTzgDv2en+OZyDSHtoYeDjdj3oiFn5L5cZ0BKjBQIq/IdQy6QpNAPDqewRJ?=
 =?us-ascii?Q?Vgn+JnoNSv2RmTHTXaY0qzJtb8phT9t6nRnvMbje3s1dBTWXKaFkaG0DJ+4v?=
 =?us-ascii?Q?IAOeUgCuJBaqrzVMNVCtMczac1rEDZtdTIRn01lvwG35yHQD94uGHgaCDkrH?=
 =?us-ascii?Q?KJ4iqoXzdvTrfFOodUjUq4rYPCISB4O0e3S0M76DvVnChCqX9QLTsINX0BCM?=
 =?us-ascii?Q?XhoVp3fWiz9fpejTf7c6IlPY5lnO47XYKrAn1/MtxYsJ3L3+z5eAhuc31Eu/?=
 =?us-ascii?Q?OydNX898I99d1nQ+A5NW5WkNr2RZ/t4Kz6b0LBDAQL/D3w5WF3cJxaJmZMs1?=
 =?us-ascii?Q?oR1YC0fwyro6kN9kxrdmRbKer3IYkuAefJye57/vjYl5ejrfFTl49jNrfiv0?=
 =?us-ascii?Q?xOaB6NKWr2wm5WJTPOFj+61KaG6WRlVasHJ99sL/epcPb4VXFYD2L9W0e7oG?=
 =?us-ascii?Q?5ycuufwI2T51i2+bhTGCYa0A2R/AV7bqojycWbb9C/boVvQoKRyas7+z/AHL?=
 =?us-ascii?Q?g7XQ54HpNH+9OTn7idyauboNXvl5rf0UpQpZzScLLQtW2Q/2U2saeyr50UDU?=
 =?us-ascii?Q?N/6QSvqCiMk0JSiyt8SY6P2b9wJEVOi1UF5K0x3mEGkEuqUSOA7vlgijIsYO?=
 =?us-ascii?Q?eXibG8t7fns5cSGG8xpUWplM1Rb0URPGPGKOhyedZ6dRHBZrzaXouKx2eb/q?=
 =?us-ascii?Q?bS9ZkXh0Rx87CjT/gh2bzcu9/OQHtvXD6QwP9DLsEBqln+pARvXjoVxSUvDX?=
 =?us-ascii?Q?iVncDE5jYCFknZnE+EHexXlgMm5KZGYaVG08FAx3yPB4rF+ww8Q+Y6PR/MwK?=
 =?us-ascii?Q?g6EM2nj4ehAu+mjEsI7koHVfgRF6OEId+sDEecfKlQpCHvH8H54nBNgWsr4w?=
 =?us-ascii?Q?+tTdgLGeuxXQ6j0uIaOBrZu1dKVkUSx7vZFGvRAGn2wAkr7hXWW6IqqQI2F4?=
 =?us-ascii?Q?DzddkdheHzfnjM8R0bpkhTryUeGUCOzmyyPRPN4cU1+Det3OLc3Vgv+vtLWn?=
 =?us-ascii?Q?c2PWvho=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 96d3cb4f-d364-4ad1-e317-08debcc09982
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 May 2026 13:54:12.8136
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR02MB7905
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[outlook.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[outlook.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-11310-lists,linux-hyperv=lfdr.de];
	FREEMAIL_FROM(0.00)[outlook.com];
	RCPT_COUNT_TWELVE(0.00)[13];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[microsoft.com,outlook.com,linux.microsoft.com];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,outlook.com:email,outlook.com:dkim]
X-Rspamd-Queue-Id: 7004B5F359C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Dexuan Cui <DECUI@microsoft.com> Sent: Wednesday, May 27, 2026 12:55 =
PM
>=20
> > From: Michael Kelley <mhklinux@outlook.com>
> > Sent: Wednesday, May 27, 2026 8:05 AM
> > > >
> > > > Function and structure names in the Hyper-V DRM driver currently
> > > > use "hyperv_" as the prefix. This conflicts with usage in core Hype=
r-V
> > > > and VMBus code, and incorrectly implies that functions and structur=
es
> > > > in this driver apply generically to Hyper-V. A specific conflict ar=
ises
> > > > for "hyperv_init", which is an initcall for generic Hyper-V
> > > > initialization on arm64. The conflict prevents the use of
> > > > initcall_blacklist on the kernel boot line to skip loading this dri=
ver.
>=20
> I also hit the issue. Thanks for the fix!
>=20
> > > > Fix this by substituting "hvdrm_" as the prefix for all functions a=
nd
> > >
> > > I would personally prefer "hv_drm_", since it seems clearer.
> >
> > My choice of "hvdrm" mimics the old Hyper-V FBdev driver, which
> > uses "hvfb" as the prefix. However, looking through everything that
> > starts with "hv" in /proc/kallsyms, I also see prefixes with the additi=
onal
> > underscore.  "hv_kbd_" in the Hyper-V keyboard driver is an example.
> > The Hyper-V utils drivers have both forms -- I see "hv_vss_", "hv_ptp_"=
,
> > and "hv_kvp_", but also "hvt" (for Hyper-V Transport). So the historica=
l
> > practice is inconsistent.
> >
> > I'm OK going either way.  Does anyone else want to express a
> > preference?
>=20
> I also prefer "hv_drm_".
>=20
> > > > -struct hyperv_drm_device {
> > > > +struct hvdrm_drm_device {
> > >
> > > "hvdrm_drm_device" looks kinda redundant, perhaps
> > > s/hyperv_drm_device/hv_drm_device would be more sensible.
>=20
> s/hyperv_drm_device/hv_drm_dev/ seems better to me.
>=20
>=20
> > Yes, I'll make this change. And in looking through kallsyms, I
> > see that the Hyper-V DRM driver has "hv_fops", which did not
> > get changed in the mechanical substitution because it doesn't
> > start with "hyperv_".  I'll change it to hv_drm_fops.
> >
> > Michael
>=20
> Some comments need to be updated accordingly, e.g.
> /* hvdrm_drm_modeset */
> /* hvdrm_drm_proto */
>=20
> This needs to be updated as well:
> +static const struct drm_encoder_funcs hvdrm_drm_simple_encoder_funcs_cle=
anup
>=20

Dexuan and Hamza -- thanks for your feedback! I have incorporated
all of it into the "v2" that I just posted.

Michael

