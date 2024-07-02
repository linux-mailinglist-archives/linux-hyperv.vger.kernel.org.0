Return-Path: <linux-hyperv+bounces-2516-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DF17391ED61
	for <lists+linux-hyperv@lfdr.de>; Tue,  2 Jul 2024 05:15:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0C63A1C213BD
	for <lists+linux-hyperv@lfdr.de>; Tue,  2 Jul 2024 03:15:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AF442209B;
	Tue,  2 Jul 2024 03:15:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="haAf5tdu"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10olkn2033.outbound.protection.outlook.com [40.92.41.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3718514293
	for <linux-hyperv@vger.kernel.org>; Tue,  2 Jul 2024 03:15:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.41.33
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719890111; cv=fail; b=JaHrG4pShP+fipZAFWnvzATb/b5tYNhkAgb26dCiccRMrzuWuKd5K9RkDQSNMYoX5enJaXMX2vqZM55p12Ul8TwlwNIt+hHo9yePIlrXL4z8U+xEOr6Jh5nnsGPAhoGftR9tYuIkzgLVjDiNdbsbtDCZVv2BYxVqrDNaRLvaA3g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719890111; c=relaxed/simple;
	bh=mRN+2Tae2GnvcENrkM4acXPRBbSjhnLkEzkN3Vrg+d4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=B+qger64tMhF3aS6ppUqtwup6Eey0EznLr0WhjnVUXHOS7fytI9a2u2v8vjkri5Fai8WgKD8QbSUmpuOQlOiOwYqjZUfEQnHeXO3nrpRxWhVDfmmgRZYNylNWGBwdAo6iaGR0NPHzADY8q7LrETRu+qflVzbEv5wQeW/lBLfXbI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=haAf5tdu; arc=fail smtp.client-ip=40.92.41.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lzPZa413qeUjYrHU5fKi8sXbn7DuesrsAIRl2OfTUhAG5+mISDixb547clATHDTWyEMwjDXf9p0O5+b0E8Zm8HxVU21vl/9ZFP9O5sAPIGW9AUFBMmCxtNQeMkFRkJWFtj/jVVUGVJdUTiY2bbLvK4wAnjdVEUgq1K/62nsOfdTYZ3FZmVwtXm4Vz35tbg40vz+Gj/BtG9lvxdD2o6n1q0w8L2SrleDXL34u99Srpj1FcIJJqQoq2LOgE3wWEeZBoE7w/EUB4k+Q5xsP0cBVBhpW3hIkRyma8I3iMi/bqc8auJzHIuDsLDVXKjGPF0pk+vvQv5Y9uhvX5DfbvhV3yQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ew94T1Xooq6ZY1d6Kn+6oyKIm/dvO+pe+riOg+kfCaE=;
 b=n/fQbuOadVnXHatUO7ETNgxlNuBpMP9sBICtznEuvcpXPl7Q8Nne4FR1CTexEh7DZf5Rk6J2dvl22AlTluew/mQ1/zO4WnZL7yYLpReqebXi3F7iWEVPlFGi5Tz6b7t9zN6A2ufRx8jCjhurOdY58wwDdEywEX577j6HKqm4O202KH82VuNZXnMrEDGVk/lFzs4R4JDCh4rKyKRI5kScSf06mj7l/i0der9qnpN9AKgiYzsJT7gGChT/rhUFGQtV+tZUzGcot7oGMv9k3M6a/2AXW/bBnfprZqeW2KbkzuIPXuZg2C9ZxOjvIEPBGI9zTAf9obia9fSBEKUoJZ/sAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ew94T1Xooq6ZY1d6Kn+6oyKIm/dvO+pe+riOg+kfCaE=;
 b=haAf5tdumH4+d5LV3b1QSV2h1E1HK8cbwlzehvQPlKrygyrNwQK+nkslQhXQPXZ3F9DByiywKR3W1Hz5VvRGM3WFQt4vM6WWsR3ndlVdlrjwIZpcu/D+OxhlfzJhJZGmakJlMjCo1m/S2q4MQNUyrIrKOdjxsKvD28ogxMe89CSofZc/a51/NpuEYG11VUojeNnAo7GottfK725RUMub4SBNeegpIpt6mkwQvM22uoLsJa4sh9pK+0J2ltIUNlC2LZqp3oXQt6NcklED1qYgCsTNG8Ymv/Ce3ZU8xYFv2lhKAFe+KJocZj1JqM5A5ajKqBuh/94iJrHyIcLcr+X/iQ==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by CH4PR02MB10611.namprd02.prod.outlook.com (2603:10b6:610:246::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.33; Tue, 2 Jul
 2024 03:15:07 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df%2]) with mapi id 15.20.7719.028; Tue, 2 Jul 2024
 03:15:06 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: Anthony Nandaa <profnandaa@gmail.com>, "linux-hyperv@vger.kernel.org"
	<linux-hyperv@vger.kernel.org>, "decui@microsoft.com" <decui@microsoft.com>
CC: "kys@microsoft.com" <kys@microsoft.com>
Subject: RE: [PATCH] tools: hv: lsvmbus: change shebang to use python3
Thread-Topic: [PATCH] tools: hv: lsvmbus: change shebang to use python3
Thread-Index: AQHay5H1x4TPlTPMlkuf+5R6W//9HbHiwFRA
Date: Tue, 2 Jul 2024 03:15:04 +0000
Message-ID:
 <SN6PR02MB4157668B1A29D9E0F5E01C77D4DC2@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <20240701083554.11967-1-profnandaa@gmail.com>
In-Reply-To: <20240701083554.11967-1-profnandaa@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-tmn: [YQS8qpD/AcJXboYGQACL0QCxmDrJbxRC]
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|CH4PR02MB10611:EE_
x-ms-office365-filtering-correlation-id: 8a06eeb3-d6f9-410c-2cba-08dc9a452ae3
x-microsoft-antispam:
 BCL:0;ARA:14566002|8060799006|461199028|440099028|3412199025|102099032;
x-microsoft-antispam-message-info:
 aXGuLZv3PrtOGdMdZRz0jw0ZitQxj5RW4ZDSfG3mZqAfYtzGw+AcPP6XRRDWf7vuArVFM/tcqCnLiIIgBOYWQT6a+tCVTt6HdMx1Iie5rob38OaZXQdflAf/7Xr9Owtw+vgtp271qsRwi4+aXbklezst1DxzbZazh9Trirl6GBIkCG+9QlhmHTeym3j7YxD1wpNBFg1A29mA46SPK040kCgnjCkVJsiUvt7NEVin3eheysFZk/eibhVX0MhbaXw065S95FxI5ngm3ZK0gm3J/mUTM3Q9+ATDzIcUS0p+PscqcDK9sbK8z2b7RwR5fpAs/HkijQ93tawYIdJrxhXLt2sZmOLpj3Zu+5NkMAog14y/sIUZmCByIsb/zbdrJAAiO+W5GheSMxjZDwxUeSE3kvckKym0Xfq6KQ89FOam962w6lf5rMkj7g2UoygqSUqweqVO7sAFgsNo6lPXHouALHGB2RVegn/I7mNzUwKUZ/pmtuTK/0WHnlK+zn2pnCBgaytit6naRUVO3JtuSmc0mh4Bio/EbIMNZUwbwexZF0CHMaSmx6RARvtUOwY59Quje2LcASYNH7M0+wlW12s58t+k5Zjuea7b9/ssq7SD71Ul1EYO52reCIRogRfJnaIR
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?cduzNOIFF+qdLOgC9ytK6SjbdMtLHR0wIW4oyY13tIJn7KxoAyTQifk+2e8g?=
 =?us-ascii?Q?hiyZl1AAnN2votVxI6cF8/xNmUHQOdB81ihNcxmoQQ6WCKa97bveqKaDXwJD?=
 =?us-ascii?Q?7zy5rzDtp6and0kZqPU7/KZgwZ3/2onFHcC95Khv5Jo93oTBeFStnIUmCRJs?=
 =?us-ascii?Q?xj5RZtGpJJRm/KZzFIMeFo6PWaYg5ibzlVhce6y8HxUF9fzYH1vMKxtu1hCf?=
 =?us-ascii?Q?o2gHVecut/SYzot3w8DzELvDjG7TDlLBbf26dL87alHihw567pRYyWSjNtSt?=
 =?us-ascii?Q?ybHlHX6sfj73OWWWD9oK5YSYP084GnV69KvqB2UabGVVu0iwGdZKPvX0n14M?=
 =?us-ascii?Q?5eHHaHkCj8HI6zR9OIas41tlbpFXUTWVB6NpexSmTf6XvueWnWZqJUtFaAw0?=
 =?us-ascii?Q?G4hDF6KdUW9tGiyqbLak2lOniQjovh/dL5bgprWvTC5tpi+xEaHsy3PmFTvo?=
 =?us-ascii?Q?UO7+D6s/490MOZ8lN+3/DrS9e5I76xgnKK2mutIef/Xe1kbzbfMa6P+cMilc?=
 =?us-ascii?Q?SeKWYri4SkUtt0PgI5rpPgjy0oW5WERbHjiNzjLkOdyeHLssfvO2vEZ8Tn5T?=
 =?us-ascii?Q?UchSTtbNa8VfsaW5HuxWGsQN1fKzDIopbuvfxdXoMIMlW0+9lQj0JWAEQXNk?=
 =?us-ascii?Q?E5L6Ovao7I+EEU6XNJJcKfqOXAsVhafxJjKWCuHYhOAk9IH3VQMB8E3X1Opw?=
 =?us-ascii?Q?kcDRljwV7gFahmluoALM51qYnBRJic2NOXstndwuZmODseXZh4vl2GE94ssI?=
 =?us-ascii?Q?pSyNBefU6bKVRWL2MCsIn79cQzkr9aYvq1smEjGBaoathel6lEdtPHL88Prl?=
 =?us-ascii?Q?U2VVC7KK5VBk0EL3lFviLgxY2FMnGyupPhI3FdbzjQkqFKsji1plY93pASEB?=
 =?us-ascii?Q?HN6MFEyRB86meYZnhaF2+U+lwGNdi6M1edD+I9yY4mIbzlgqw/24xEbqVUdi?=
 =?us-ascii?Q?iHVE+kA9AsX1qjPb31IKEAWIFNa7aUbIg1Db5W3vMhqCuGQGGcm3wXjLEnwq?=
 =?us-ascii?Q?fUne3Rqf9vGlP2dty0PABGu/W4eWFkHpwK4N9bCVHDmDzA8HnCHUODni11Hz?=
 =?us-ascii?Q?/HNxnKs5+4xwl5f1y3BuD2qdwj72IZvqt/OzP4TUWDAFrqdFx7UcMt77pmxK?=
 =?us-ascii?Q?hZa+0Kqgeeez+zpOWz98Pm4wrfeou8dpzvdhX6Nmg6ALDh8ZSvzH99mDv6Af?=
 =?us-ascii?Q?X9kawjaIscDmx9qZ32ocnS30K3LwTRsis3S3Udq/DEAseoz7TO2V7m/yyqw?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a06eeb3-d6f9-410c-2cba-08dc9a452ae3
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Jul 2024 03:15:04.2104
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH4PR02MB10611

From: Anthony Nandaa <profnandaa@gmail.com> Sent: Monday, July 1, 2024 1:36=
 AM
>=20
> This patch updates the shebang in the lsvmbus tool to use python3
> instead of python. The change is necessary because Python 2 has
> reached its end of life as of January 1, 2020, and is no longer
> maintained[1]. Many modern systems do not have python pointing to
> Python 2, and instead use python3.
>=20
> By explicitly using python3, we ensure compatibility with modern
> systems since Python 2 is no longer being shipped by default.
>=20
> This change also updates the file permissions to make the script
> executable, so that the script runs out of the box.
> Also, similar scripts within `tools/hv` have mode `755`:
>=20
> ```
> -rwxr-xr-x 1 labuser labuser   930 Jun 28 16:15 hv_get_dhcp_info.sh
> -rwxr-xr-x 1 labuser labuser   622 Jun 28 16:15 hv_get_dns_info.sh
> -rwxr-xr-x 1 labuser labuser  1888 Jun 28 16:15 hv_set_ifconfig.sh
> ```
>=20
> Before fix, this is what you get when you attempt to run `lsvmbus`:
> ```
> /usr/bin/env: 'python': No such file or directory
> ```
>=20

A note about commit message style. The guidelines in
Documentation/process/submitting-patches.rst specifically say to
use imperative mood and avoid "This patch" (and by extension,
"This change"). For a patch that is fixing a problem, I usually
describe the problem first, and then start a new paragraph with
"Fix this problem by .....". So for your patch, I would suggest
something like:

In many modern Linux distros, running "lsvmbus" returns the error:

/usr/bin/env: 'python': No such file or directory

because 'python' doesn't point anywhere. Now that python2 has
reached end of life as of January 1, 2020 and is no longer
maintained[1], these distros have python3 instead. Also, the script
isn't executable by default because the permissions are set to
mode 644.

Fix this by updating the shebang in the lsvmbus to use python3
instead of python. Also fix the permissions to be 755 so that it is
executable by default, which matches other similar scripts in tools/hv.

Michael

