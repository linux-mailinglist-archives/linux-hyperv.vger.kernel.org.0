Return-Path: <linux-hyperv+bounces-7740-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id E269BC7779A
	for <lists+linux-hyperv@lfdr.de>; Fri, 21 Nov 2025 06:53:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sin.lore.kernel.org (Postfix) with ESMTPS id D9DF62C619
	for <lists+linux-hyperv@lfdr.de>; Fri, 21 Nov 2025 05:50:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C7553064B5;
	Fri, 21 Nov 2025 05:45:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="YpGkNagO"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazolkn19013084.outbound.protection.outlook.com [52.103.7.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FEE21D88D7;
	Fri, 21 Nov 2025 05:45:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.7.84
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763703929; cv=fail; b=lp2NQ6em92/CpKIweOpCdXJ371btOFhEAgnTcPyjoNZKfg0LiYGoQbC8dbSlbNoUpQth045NlhF6mnfAP1+me3YhYbFxh+1Vsf8eFKe40YsOUBRPNNa22NfTN6yTHvnyLnR7KlCnAhgxXLB3WoTLnzvI5ZHmOTpLsXjbMyC7KZg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763703929; c=relaxed/simple;
	bh=ldJTQS41pGLqVhBzWY1uD2h82K8xasJsrSqZTMzQuGg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=lKeuwlWrdwgsVj/cIkM7UjyDQ1y7u/+yyiZEE+cvcf0zJ3W2gLvbg1S8eGFVS5wzR12HuVworP1foa2CxNOWNkA38L5YI0RJSMCyjvMeSM9EGROGyEt+trGXLbutAunc0HACzn5T1oLwJtdwoaNq+TZ7/MonmzlpSTzp0+mSGfE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=YpGkNagO; arc=fail smtp.client-ip=52.103.7.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eY2GjIFyAmFjaNLfu0E1IVqJfdmQRKqTK8GMuf157Fq+yKap33/TEvYod7jWYgrURbg5iK1RZYHFAC9p7eINyN6fYd/SAHy6bhPrv9A9MrIvF+9C//tXspbj8rcFXi2LkO06WFhOWeooOtimQjd7gVcNPWsQSkcu2Yv6vxBeqpqi/euRyggCdJR7TWibl0ELEWaxGa0goED+h5p2uWZOB5F+RK8bc1LdLLdz1sY2d1u35pfo8geQaTygg/KcMVUb4sjzxOYYsDDQwGxSGbuM3h3Z8XLNaFvqWodbvfVWhY2ZdQJ6VUVMsEZxaFMlEkzP4gdC6tCd2vj0AcDNCqubGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qeklkpSTZSxTn3fx+GqXX3QrwjqQ7mdlI5msjtOHy4U=;
 b=FfwqP6XQ6CVjMhXTrliOIvuJTnCVBcoavbZDVjLJE6bev2gyWpzW6Jbc2NmKFCTnM7YLuAj1272OKkQI4wtMZEDNPhPUViKPE80SUKkrgdQZti9q/9qtbrtXUMkYRjkI8Vs4w+fE3X2lgdW41vKVzhYPHOruGzW62zRWjXM0Nn8d82VSQ409C3IA04aZymGTwYtpz4tSSIe++FlkWd/hFCc7mDm/ztc20Ks9SphfN4eCPK/YteSj88riOY7M1wjwSdJgP9j6867q4cUSsKV0hJvKj5NYjH0PRKFGMM81viHhleVZaRaZfmzgyqSWk+9DT4Hxd/ye4X+QjmwNOGDK0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qeklkpSTZSxTn3fx+GqXX3QrwjqQ7mdlI5msjtOHy4U=;
 b=YpGkNagOmEt3a54DdMlNdU7XRMPHkzW6O5Taxdk0lQ/kN0nWLnpavyZPXaCcIK07XCVpN0EEbYJSv7UzkBeAfAIfEDkFh0bOBI92CLdxTqs//4htqsbM192wdpCUm//xphjCoElavL/OEXhDHbmEmLqBaXty86kEZ0GHGOqmV4o+eSm41YoBE0XAwo/fpp4BOAX3lLL90dQ6dX4u8NlvMoJ7RbLZDZJJIRymykmonju47cEbD5A0UE/RtIi3UqJ85m3813VRIRxj4IIXNq2nmv9ePRPNpTLjGIzs5Qsh0shDNauXlP9ACM1H1A2Du74CYeF4IdZdYJJ2ODW8oSFN9Q==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by PH0PR02MB8600.namprd02.prod.outlook.com (2603:10b6:510:10d::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.11; Fri, 21 Nov
 2025 05:45:21 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::900:1ccf:2b1e:52b6]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::900:1ccf:2b1e:52b6%3]) with mapi id 15.20.9343.009; Fri, 21 Nov 2025
 05:45:20 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
CC: "kys@microsoft.com" <kys@microsoft.com>, "haiyangz@microsoft.com"
	<haiyangz@microsoft.com>, "wei.liu@kernel.org" <wei.liu@kernel.org>,
	"decui@microsoft.com" <decui@microsoft.com>, "linux-hyperv@vger.kernel.org"
	<linux-hyperv@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v6 5/5] Drivers: hv: Add support for movable memory
 regions
Thread-Topic: [PATCH v6 5/5] Drivers: hv: Add support for movable memory
 regions
Thread-Index: AQHcV+Ql1XC2uTrlrUiBnqvdm0eRorT3Vb7wgANoSQCAAdVjIA==
Date: Fri, 21 Nov 2025 05:45:20 +0000
Message-ID:
 <SN6PR02MB415740A80DA4FF9661040147D4D5A@SN6PR02MB4157.namprd02.prod.outlook.com>
References:
 <176339789196.27330.10517676002564595057.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
 <176339837995.27330.14240947043073674139.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
 <SN6PR02MB4157DB4154734C44B5D85A88D4D6A@SN6PR02MB4157.namprd02.prod.outlook.com>
 <aR5kjh-d6UAqy88t@skinsburskii.localdomain>
In-Reply-To: <aR5kjh-d6UAqy88t@skinsburskii.localdomain>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|PH0PR02MB8600:EE_
x-ms-office365-filtering-correlation-id: 0ac217c8-e5df-489b-ea08-08de28c1288d
x-ms-exchange-slblob-mailprops:
 02NmSoc12DdgSaIndyTpt8agEZdjfNIVsHTGWXspieU63EwX7QQkVNs4ctcLdGsm7zLdFcOdgWcf2KRyJXtVYN0Iuq35J4VfcnqTebgJssptIti+AdtXzMOhjg2rZyqcrd/CpieKMC4hrRnwDfpRV7zVU+jZM5BZVKXH+oIcVVTyRl4lZ+jUblZ7mZOm9OCKDe/hl9QGlEOTk+w/+qnKxRdHqC+SHiXC1rTC5Ge1rZi4V/m6NkNaMu4MpBaazdN1SS4xBZ/wlF8uqLTR0d2AcoEc9yj/7QGe6yB+ghEY2f/GIpfi3wgFKqrDTfjpHvm2lII8KbsAfm1kTPxnoZ2wK8XOqNe4P056Sk8YBoRtv9ug6oJVMZDWrG2rPz7yngmSLs7MweKw5TisqqfD121xtU1KjHUo0hw3u2xvOLOKXVtEoTEnetu3WsQlQpTRbp8QhKYsTr2Pli6ZVUPeG28OSxQr7kdP0Tp8Lwro0/nidLyoPlc3pyqA/DbAsOpvaXuYl5ViO+6EBbNs+iqV38czmIfKdHwq1OzUEGvuyEGFgzvcFNUSrTihUwA+7V8XPvwRwRZ2dQwCu9ML1AZZ0Hm9VAkYuI51fNk6yXAw912O/XGc5nSCUvwlnXa05pWDKXnpxWUpbbXEaSyDRH0ShSg9CnH7K6lPCe//7cSabWxPLX0sOaMPHjWy+wKLjFglxezprDvK2cyT9ZO6XqQpQmZiNm7Z8CB4jSSqT8AKwJkwgK7QbS5GXOrV9HuYhOJzW1Wh
x-microsoft-antispam:
 BCL:0;ARA:14566002|13091999003|41001999006|8062599012|8060799015|15080799012|19110799012|12121999013|51005399006|461199028|31061999003|56899033|40105399003|3412199025|440099028|102099032|12091999003;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?m/FL+D/zzNBayxjif361fZu5DQFXpheNnOfO2wZZZffEkqv8oW6d/oy23eWS?=
 =?us-ascii?Q?rwJcLN397U4DSbQUMl0tcpm7ZiSuFBsvACQUx9Ll5bmFjNOm6jtTZv+5Bgtd?=
 =?us-ascii?Q?3m22mJF3gk3G6vKkOnqPxVjTXPnTYL3Qh3w0lARcq+xGgoQaPFzIJMoDmml+?=
 =?us-ascii?Q?qjYzZYOqiGiVHdlp+Rlglc7265EEPs8OBdA9KjMra1h7h44XkdA4kcNVo96P?=
 =?us-ascii?Q?8j+TakzUk+eTKQOVp9dYxaPOhWyY9vWpv6SHBhE8SwaheOXoYCUyCxa6U3hV?=
 =?us-ascii?Q?kN5LSMOCDxDboy8sOkEG53XljM8p/OYwGORz2pm40XSjXw2Gc+UL9GZJSCbD?=
 =?us-ascii?Q?JIvNALNkzuxtG9Z1SrrJeeeQITmUuIOCHbZyR8g7WbM1PmjfHEvjE/8Y8iOP?=
 =?us-ascii?Q?NQblK5zoVZm7johDbQY4gYiaKmFScH2KdRetfT6Pd/7iwO1fsj7MXlRPTcvh?=
 =?us-ascii?Q?KzXxhvZDZTDFde8bcdiCFIG7aXrxRhl3uJ1UVrdetC/7DUnWUmUmlbPb6Fe+?=
 =?us-ascii?Q?QOLa83yu8EX+CJHOrPmg+Hf2LFTqwVFt3Fi1SyOXRM1llVGIuA4eQ89WzHGa?=
 =?us-ascii?Q?uaQzeyOr10FmoLxxRAHuf4c0Q1OnSEXn6dSsjGdW4diTUh6qk7DzqioriQBw?=
 =?us-ascii?Q?jF0GTxEVbYrDEunEZoMSMm6L0fQ5mUbdti2A43QNqE6dnBqWrOpaZcvUHF+n?=
 =?us-ascii?Q?dW651Qkm0Pb/H71HY19JgV1I/dSazFHXswJdMUdNC+xVoNs/GhpdyBs38Jfy?=
 =?us-ascii?Q?4umMXjy3aUgP+GIBPFrR7u23y/kjdw5zUOxG68mggUmapQrCcB+KI7JlHObA?=
 =?us-ascii?Q?ET707GSgIO8n6OIOJnTxe2dPs6pKsWtN0KB7Ezf5gH9xIAaETIbKENUtTh8B?=
 =?us-ascii?Q?gr4vLFspCvKGlRgFuE7EmqOeIr0YSfz0wkV+9aKsq32aqNT2a46xXU5JOMJn?=
 =?us-ascii?Q?t0XVXQBlYyTJLY2asbUXRIw2czt4npHwFguv9DJWTvEPk/EvsyPBSWJY7E9m?=
 =?us-ascii?Q?+Zsop5VvWrI9JyjX2fO4a4zTW0Yw+5Ym6b+gGmaEYzPtcyA9vwQNUbyaca+H?=
 =?us-ascii?Q?v37jGr7MBHQrF9cYQdK+DaCpWYdurI0odq1T8pgMQ1gkPV9z10mfwyN0kxKY?=
 =?us-ascii?Q?q5ZXbTnAAUpqW8ew8NT9T+OG1sS27MWUcOqmY3CGCUxyvOf/9yBgoxnXuA0p?=
 =?us-ascii?Q?tt+w9SStdPRX2G9jVPBs95XNsQV8TeKDyqGpKH+KZJzL8goPrnkzthUzfvug?=
 =?us-ascii?Q?Eg10FxfvK6jFXJqxm17toEbY7zlPf5IDSysFpbmXIxQlZsZDYa5RxXnwHQnl?=
 =?us-ascii?Q?QrUwX8Tklyn6dejNHtNn8agx?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?vH3Q3+Rb5Rz4lRsncKOMmhfX0fmzCYDglpxHNx/zbsoYEkbc9GqSblt7Ods7?=
 =?us-ascii?Q?7KDCIH2rEsOYZPK4hc5NRknp1dSW0ebdziv/bVKy6D6N7gg/Rs2w+XrDXmDU?=
 =?us-ascii?Q?PonX0Xw+o+bvQ7oKiIuA0jkdvh+zUA2XjAuwIKgyFxYAHJhZH1um60/anYaE?=
 =?us-ascii?Q?7JZN2rsxqZNX4ti2tbzuejnUin5EX/k81sWrDyREPBuJRFsR843AM3Ll2EYd?=
 =?us-ascii?Q?20yzVQEX9/CQyQCw0hbdkJUDInortn2wlQK0AiiBwxKaM/sIoXV9gavoPVtB?=
 =?us-ascii?Q?98WZzZLob1xD+wGCqK2jiKcUt6Oy4dWSqprD7RRkjRa7jUvubiuV0q/YGF+i?=
 =?us-ascii?Q?0VbZ81yUDp7SqeJUwKDEVPA9PqCqKBfIrcMSOmNjs5lLut8F3lDcuz9SzYCs?=
 =?us-ascii?Q?qkI5oE0QGb4MXNS3d70CznsthyEho7FzLJdWu3nR7+RGnBSMobxtD9l+n2zS?=
 =?us-ascii?Q?NcazWj0pfjJ1lQYR0daqYPL1mDhucZB89JR6vekplcg7BkstP/u8mWZmR9H4?=
 =?us-ascii?Q?RSiSkaMRXzdkDKlmcLXIaJCdpz0akK8OHanLC6auPw6uvmS4vXk5r+VYhUza?=
 =?us-ascii?Q?VRV0pJz5SOVuHch5OntY/TZ7BrlpBv5aN+ZzRN97bKkzMLGyjOrcrcMJSiLL?=
 =?us-ascii?Q?fCcdxMZG5lHkUVKtYE9mkmARKQDbSa0W+AcG4BjadS6qchzOu/BbRrH8ka1L?=
 =?us-ascii?Q?Lf84x5ycv2pgrCWVlwjT4MBL69D5WOAEdiZcgWOTriJ9q1tMQolXnzql9tH7?=
 =?us-ascii?Q?BT8IlImmKYCRRlN2DOIKbuffzBZdsynU9LhfkefM20csdxW68I4+KRp68gf3?=
 =?us-ascii?Q?2qEXHiX/tXrVY1DFS1jj2rGI7ocxFuK9Lzv5cI7zyObVyZgJt30LTxZwc0X/?=
 =?us-ascii?Q?Ci53FyGeBnP7RX2F1GOKGpRvXQcQLqJBL7KyzxVi5u8XxiB2HHAXs7zgqJ2q?=
 =?us-ascii?Q?oYYz9Fkjx248ucjk87bhz5x08bW63mvga+x2exjPUQ001KRrAtV2vu/KFDnQ?=
 =?us-ascii?Q?kUlobc8cNFc4IaXPgSKFmShcnIc1DXJe+k+lOQNELFoBVvpY77bzb1ppHsKP?=
 =?us-ascii?Q?fy4O2ssCWBPc3wJTcDAmi4iYrFeP0lJWv3/2FMtHYr5vwXC49x1WUwQk+icP?=
 =?us-ascii?Q?CoU/9nrOw+kz0hLEmhaMU7KDqFsWOGKJGCkKD8vk7jLXT+a/3+zHj/1P+dbv?=
 =?us-ascii?Q?Ul7dJg6llaSVRS8rg1lf5WX7ZQPZ98U4jgti3bK4wthXU49mJoIvKjKuDZg?=
 =?us-ascii?Q?=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ac217c8-e5df-489b-ea08-08de28c1288d
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Nov 2025 05:45:20.7275
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR02MB8600

From: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com> Sent: Wednes=
day, November 19, 2025 4:45 PM
>=20
> On Tue, Nov 18, 2025 at 04:29:56PM +0000, Michael Kelley wrote:
> > From: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com> Sent: Mo=
nday, November 17, 2025 8:53 AM

[snip]

> > > diff --git a/drivers/hv/Kconfig b/drivers/hv/Kconfig
> > > index 0b8c391a0342..5f1637cbb6e3 100644
> > > --- a/drivers/hv/Kconfig
> > > +++ b/drivers/hv/Kconfig
> > > @@ -75,6 +75,7 @@ config MSHV_ROOT
> > >  	depends on PAGE_SIZE_4KB
> > >  	select EVENTFD
> > >  	select VIRT_XFER_TO_GUEST_WORK
> > > +	select HMM_MIRROR
> >
> > Couldn't you also do "select MMU_NOTIFIER" to avoid the #ifdef's
> > and stubs for when it isn't selected? There are other Linux kernel
> > drivers that select it. Or is the intent to allow building an image tha=
t
> > doesn't support unpinned memory, and the #ifdef's save space?
> >
>=20
> That's an interesting question. This driver can function without MMU noti=
fiers
> by pinning all memory, which might be advantageous for certain real-time
> applications.
> However, since most other virtualization solutions use MMU_NOTIFIER, ther=
e
> doesn't appear to be a strong reason for this driver to deviate.

I'm not clear on your last sentence. Could you elaborate?

>=20
> > >  	default n
> > >  	help
> > >  	  Select this option to enable support for booting and running as r=
oot

[snip]

> > > +
> > > +	for (i =3D 0; i < page_count; i++)
> > > +		region->pages[page_offset + i] =3D hmm_pfn_to_page(pfns[i]);
> >
> > The comment with hmm_pfn_to_page() says that the caller is assumed to
> > have tested the pfn for HMM_PFN_VALID, which I don't see done anywhere.
> > Is there a reason it's not necessary to test?
>=20
> The reason is the HMM_PFN_REQ_FAULT range flag, which requires all PFNs t=
o be
> faulted and populated, or mshv_region_hmm_fault_and_lock will return -EFA=
ULT.
> Additionally, note that mshv_region_hmm_fault_and_lock returns with
> region->mutex held upon success, ensuring that no page can be moved until=
 the
> lock is released.

OK, that makes sense.

>=20
> > > +
> > > +	if (PageHuge(region->pages[page_offset]))
> > > +		region->flags.large_pages =3D true;
> >
> > See comment below in mshv_region_handle_gfn_fault().
> >
> > > +
> > > +	ret =3D mshv_region_remap_pages(region, region->hv_map_flags,
> > > +				      page_offset, page_count);
> > > +
> > > +	mutex_unlock(&region->mutex);
> > > +out:
> > > +	kfree(pfns);
> > > +	return ret;
> > > +}
> > > +#else /* CONFIG_MMU_NOTIFIER */
> > > +static int mshv_region_range_fault(struct mshv_mem_region *region,
> > > +				   u64 page_offset, u64 page_count)
> > > +{
> > > +	return -ENODEV;
> > > +}
> > > +#endif /* CONFIG_MMU_NOTIFIER */
> > > +
> > > +static bool mshv_region_handle_gfn_fault(struct mshv_mem_region *reg=
ion, u64 gfn)
> > > +{
> > > +	u64 page_offset, page_count;
> > > +	int ret;
> > > +
> > > +	if (WARN_ON_ONCE(region->flags.range_pinned))
> > > +		return false;
> > > +
> > > +	/* Align the page offset to the nearest MSHV_MAP_FAULT_IN_PAGES. */
> > > +	page_offset =3D ALIGN_DOWN(gfn - region->start_gfn,
> > > +				 MSHV_MAP_FAULT_IN_PAGES);
> > > +
> > > +	/* Map more pages than requested to reduce the number of faults. */
> > > +	page_count =3D min(region->nr_pages - page_offset,
> > > +			 MSHV_MAP_FAULT_IN_PAGES);
> >
> > These computations make the range defined by page_offset and page_count
> > start on a 512 page boundary relative to start_gfn, and have a size tha=
t is a
> > multiple of 512 pages. But they don't ensure that the range aligns to a=
 large page
> > boundary within gfn space since region->start_gfn may not be a multiple=
 of
> > 512. Then mshv_region_range_fault() tests the first page of the range f=
or
> > being a large page, and if so, sets region->large_pages. This doesn't m=
ake
> > sense to me if the range doesn't align to a large page boundary.
> >
> > Does this code need to make sure that the range is aligned to a large
> > page boundary in gfn space? Or am I misunderstanding what the
> > region->large_pages flag means? Given the fixes in this v6 of the
> > patch set, I was thinking that region->large_pages means that every
> > large page aligned area within the region is a large page. If region->
> > start_gfn and region->nr_pages aren't multiples of 512, then there
> > may be an initial range and a final range that aren't large pages,
> > but everything in between is. If that's not a correct understanding,
> > could you clarify the exact meaning of the region->large_pages
> > flag?
> >
>=20
> That's a good catch. Initially, the approach to memory deposit involved p=
inning
> and depositing all pages. The code assumes that if the first page in the =
region
> is huge, it is sufficient to use the "map huge page" flag in the hypercal=
l.

Right. But even for pinned regions as coded today, is that assumption
correct? Due to memory being fragmented at the time of region creation,
it would be possible that some 2Meg ranges in a region are backed by a larg=
e
page, while other 2Meg ranges are not. In that case, a single per-region fl=
ag
isn't enough information. Or does the hypercall work OK if the "map huge
page" flag is passed when the range isn't a huge page? I'm not clear on wha=
t
the hypercall requires as input.

>=20
> With this series, the region is sparse by default, reducing the likelihoo=
d of
> huge pages in the region. As a result, using this flag seems neither corr=
ect
> nor reasonable.

Yep.

>=20
> Ideally, whether to use the flag should be determined during each guest m=
emory
> map/unmap operation, rather than relying on the flag set during the initi=
al
> region mapping.
>=20
> For now, I will remove the large_pages flag for movable regions in this
> series, as it is the least intrusive change. However, I plan to investiga=
te
> this further and potentially replace the large_pages flag with a runtime
> check in the next series.

OK.  So what is the impact? Losing the perf benefit of mapping guest
memory in the SLAT as a 2 Meg large page vs. a bunch of individual 4K
pages? Anything else?

>=20
> > > +
> > > +	ret =3D mshv_region_range_fault(region, page_offset, page_count);
> > > +
> > > +	WARN_ONCE(ret,
> > > +		  "p%llu: GPA intercept failed: region %#llx-%#llx, gfn %#llx, pag=
e_offset %llu, page_count %llu\n",
> > > +		  region->partition->pt_id, region->start_uaddr,
> > > +		  region->start_uaddr + (region->nr_pages << HV_HYP_PAGE_SHIFT),
> > > +		  gfn, page_offset, page_count);
> > > +
> > > +	return !ret;
> > > +}
> > > +
> > > +/**
> > > + * mshv_handle_gpa_intercept - Handle GPA (Guest Physical Address) i=
ntercepts.
> > > + * @vp: Pointer to the virtual processor structure.
> > > + *
> > > + * This function processes GPA intercepts by identifying the memory =
region
> > > + * corresponding to the intercepted GPA, aligning the page offset, a=
nd
> > > + * mapping the required pages. It ensures that the region is valid a=
nd
> > > + * handles faults efficiently by mapping multiple pages at once.
> > > + *
> > > + * Return: true if the intercept was handled successfully, false oth=
erwise.
> > > + */
> > > +static bool mshv_handle_gpa_intercept(struct mshv_vp *vp)
> > > +{
> > > +	struct mshv_partition *p =3D vp->vp_partition;
> > > +	struct mshv_mem_region *region;
> > > +	struct hv_x64_memory_intercept_message *msg;
> > > +	u64 gfn;
> > > +
> > > +	msg =3D (struct hv_x64_memory_intercept_message *)
> > > +		vp->vp_intercept_msg_page->u.payload;
> > > +
> > > +	gfn =3D HVPFN_DOWN(msg->guest_physical_address);
> > > +
> > > +	region =3D mshv_partition_region_by_gfn(p, gfn);
> > > +	if (!region)
> > > +		return false;
> >
> > Does it ever happen that the gfn is legitimately not found in any
> > region, perhaps due to a race? I think the vp_mutex is held here,
> > so maybe that protects the region layout for the VP and "not found"
> > should never occur. If so, should there be a WARN_ON here?
> >
> > If "gfn not found" can be legitimate, perhaps a comment to
> > explain the circumstances would be helpful.
> >
>=20
> This is possible, if hypervisor returns some invalid GFN.
> But there is also a possibility, that this code can race with region remo=
val from a guest.
> I'll address it in the next revision.

In either of these cases, what happens next? The MSHV_RUN_VP ioctl
will return to user space with the unhandled HVMSG_GPA_INTERCEPT
message. Is there anything user space can do to enable the VP to make
progress past the fault? Or does user space just have to terminate the
guest VM?

>=20
> > > +
> > > +	if (WARN_ON_ONCE(!region->flags.is_ram))
> > > +		return false;
> > > +
> > > +	if (WARN_ON_ONCE(region->flags.range_pinned))
> > > +		return false;
> > > +
> > > +	return mshv_region_handle_gfn_fault(region, gfn);
> > > +}
> > > +
> > > +#else	/* CONFIG_X86_64 */
> > > +
> > > +static bool mshv_handle_gpa_intercept(struct mshv_vp *vp) { return f=
alse; }
> > > +
> > > +#endif	/* CONFIG_X86_64 */
> > > +
> > > +static bool mshv_vp_handle_intercept(struct mshv_vp *vp)
> > > +{
> > > +	switch (vp->vp_intercept_msg_page->header.message_type) {
> > > +	case HVMSG_GPA_INTERCEPT:
> > > +		return mshv_handle_gpa_intercept(vp);
> > > +	}
> > > +	return false;
> > > +}
> > > +
> > >  static long mshv_vp_ioctl_run_vp(struct mshv_vp *vp, void __user *re=
t_msg)
> > >  {
> > >  	long rc;
> > >
> > > -	if (hv_scheduler_type =3D=3D HV_SCHEDULER_TYPE_ROOT)
> > > -		rc =3D mshv_run_vp_with_root_scheduler(vp);
> > > -	else
> > > -		rc =3D mshv_run_vp_with_hyp_scheduler(vp);
> > > +	do {
> > > +		if (hv_scheduler_type =3D=3D HV_SCHEDULER_TYPE_ROOT)
> > > +			rc =3D mshv_run_vp_with_root_scheduler(vp);
> > > +		else
> > > +			rc =3D mshv_run_vp_with_hyp_scheduler(vp);
> > > +	} while (rc =3D=3D 0 && mshv_vp_handle_intercept(vp));
> > >
> > >  	if (rc)
> > >  		return rc;
> > > @@ -1194,6 +1385,110 @@ mshv_partition_region_by_gfn(struct mshv_part=
ition *partition, u64 gfn)
> > >  	return NULL;
> > >  }
> > >
> > > +#if defined(CONFIG_MMU_NOTIFIER)
> > > +static void mshv_region_movable_fini(struct mshv_mem_region *region)
> > > +{
> > > +	if (region->flags.range_pinned)
> > > +		return;
> > > +
> > > +	mmu_interval_notifier_remove(&region->mni);
> > > +}
> > > +
> > > +/**
> > > + * mshv_region_interval_invalidate - Invalidate a range of memory re=
gion
> > > + * @mni: Pointer to the mmu_interval_notifier structure
> > > + * @range: Pointer to the mmu_notifier_range structure
> > > + * @cur_seq: Current sequence number for the interval notifier
> > > + *
> > > + * This function invalidates a memory region by remapping its pages =
with
> > > + * no access permissions. It locks the region's mutex to ensure thre=
ad safety
> > > + * and updates the sequence number for the interval notifier. If the=
 range
> > > + * is blockable, it uses a blocking lock; otherwise, it attempts a n=
on-blocking
> > > + * lock and returns false if unsuccessful.
> > > + *
> > > + * NOTE: Failure to invalidate a region is a serious error, as the p=
ages will
> > > + * be considered freed while they are still mapped by the hypervisor=
.
> > > + * Any attempt to access such pages will likely crash the system.
> > > + *
> > > + * Return: true if the region was successfully invalidated, false ot=
herwise.
> > > + */
> > > +static bool
> > > +mshv_region_interval_invalidate(struct mmu_interval_notifier *mni,
> > > +				const struct mmu_notifier_range *range,
> > > +				unsigned long cur_seq)
> > > +{
> > > +	struct mshv_mem_region *region =3D container_of(mni,
> > > +						struct mshv_mem_region,
> > > +						mni);
> > > +	u64 page_offset, page_count;
> > > +	unsigned long mstart, mend;
> > > +	int ret =3D -EPERM;
> > > +
> > > +	if (mmu_notifier_range_blockable(range))
> > > +		mutex_lock(&region->mutex);
> > > +	else if (!mutex_trylock(&region->mutex))
> > > +		goto out_fail;
> > > +
> > > +	mmu_interval_set_seq(mni, cur_seq);
> > > +
> > > +	mstart =3D max(range->start, region->start_uaddr);
> > > +	mend =3D min(range->end, region->start_uaddr +
> > > +		   (region->nr_pages << HV_HYP_PAGE_SHIFT));
> >
> > I'm pretty sure region->start_uaddr is always page aligned. But what
> > about range->start and range->end?  The code here and below assumes
> > they are page aligned. It also assumes that range->end is greater than
> > range->start so the computation of page_count doesn't wrap and so
> > page_count is >=3D 1. I don't know whether checks for these assumptions
> > are appropriate.
> >
>=20
> There is a check for memory region size to be non-zero and page aligned
> in mshv_partition_ioct_set_memory function, which is the only caller for
> memory region creation. And region start is defined in PFNs.
>=20

Right -- no disagreement that the region start and size are page aligned
and non-zero. But what about the range that is being invalidated?
(i.e., range->start and range->end) The values in that range are coming
from the mm subsystem, and aren't governed by how a region is created.
If that range is a subset of the MSHV region, then
mshv_region_internal_invalidate() will be operating on whatever subset
was provided in the 'range' argument.

mshv_region_interval_invalidate() is ultimately called from
mmu_notifier_invalidate_range_start(), which has about 30 different
callers in the kernel, mostly in the mm subsystem. It wasn't
clear to me what rules, if any, those 30 callers are following when they
set up the range to be invalidated.=20

Michael

