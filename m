Return-Path: <linux-hyperv+bounces-3183-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B126B9ACBD5
	for <lists+linux-hyperv@lfdr.de>; Wed, 23 Oct 2024 16:01:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4ABC1B2340D
	for <lists+linux-hyperv@lfdr.de>; Wed, 23 Oct 2024 14:01:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AEE6159583;
	Wed, 23 Oct 2024 14:01:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cloudbasesolutions.com header.i=@cloudbasesolutions.com header.b="P2qja0xk"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2115.outbound.protection.outlook.com [40.107.21.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F1721BD50C
	for <linux-hyperv@vger.kernel.org>; Wed, 23 Oct 2024 14:01:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.115
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729692079; cv=fail; b=oyoi5xE591S5oqEBIuMS23l0El+lYFkAfPH5B/qZBNrXNWcasqQBV1t9gI4O/I9ZrUSKkxtXXEb/GfPPEWpEKGN9b8YdVji0ifDEgFQ0i9KswcE37iF2yx3W85tYXBorCMte9gUopIp1T1J0sXBPhm+QwvFJNOAtwY4s2LcylbU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729692079; c=relaxed/simple;
	bh=QkZvuWRR9S7zHCmqo4EA4TMumC/irN5imI2HyYBHTJA=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=Zqxan6OPLk/Ui49xP6KKRZJhFvHjWgcOiy7ltjQsMxuyN5eJ+6gmphkusDiDylK1JXlGdgtQEljwj0ET67W2k2/jYhDLKKdA6kvCgW6JYe2E80RQiZdBk5RtlvrlUomeqZKawlvMI1vYhRarGi/xuq6AlbpqEmWff/8jqsM4qIQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cloudbasesolutions.com; spf=pass smtp.mailfrom=cloudbasesolutions.com; dkim=pass (1024-bit key) header.d=cloudbasesolutions.com header.i=@cloudbasesolutions.com header.b=P2qja0xk; arc=fail smtp.client-ip=40.107.21.115
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cloudbasesolutions.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudbasesolutions.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EY3Iw9LWjS2HwYiKGIob9+QgkgRsWuuWxcm//a86hHaeQH2YdBwg0TZAQEJ3239yWaSkr0VI5fZkgUEEuahANYMNe/Bj219JDzLVyaju4kCtRIVT6EoB+fxD3/ZtAIuc3auLj8NzgAwX+bWb/MLbyyiM7sK7vAaOnp3wwudFoZtdOvrr5yfhlj8oINbpfOyUzE2uvxbOfN4UwEt3hLgLTNpQ2DlqnTe2gLJLFIrx4l5hfQj9RNLkLcZPXuZvWMOjBVZdALpXMfYcrufxbyuKzvrVd28th9U7WUIK/2nD1+2BpM6T1tTLXvmUDYO5SIypMYebuBt7SWTc/Z9+dpZkQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QkZvuWRR9S7zHCmqo4EA4TMumC/irN5imI2HyYBHTJA=;
 b=XJRcGP29Z3EHRr4Em9sebC1nSXSE6dFztxzYBwVvFlkSnVAhELBViMMox7Y/f8qLL2UvI6xYp3fAABL9NKe+t2u+OxhHb56DIHcvmP81po/Gx4GwRidJIXRd3ITPwUXcmHtxlUiwBWw47pFuCSf1qCNNyqNLKB2tVywKhOuB0ZXHU8Wq4A1thQAN49TWUG/y+zQCWFEXDKevdNBVJrxHRyHTfNyZY68ltjwSCiYCxXwuakTRp9GZn2wdOL/shwIYO7nHtxA+P5uNQmb+BYy3ekHUS7ZTItVSpEc7SoQH7edkU2E0b67OSzy3ANe5QbxKmcV8fyzr6eL4ThLnxZ1pIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cloudbasesolutions.com; dmarc=pass action=none
 header.from=cloudbasesolutions.com; dkim=pass
 header.d=cloudbasesolutions.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cloudbasesolutions.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QkZvuWRR9S7zHCmqo4EA4TMumC/irN5imI2HyYBHTJA=;
 b=P2qja0xkuwr8IuvNma/orV77RHFv7v9MfwUuwdRZXVnWLYFNke5/Pm9v6Gf9OGGDG3W7+VRYqIZYA6SlT5Ajb08LtBdc91sbI9AuMY06+DfWUfXQGN7O/5Wxtejvz06PK/irmbqQjrfAMPjgLgibKu/F2LiOfTKve4X22HuzyKw=
Received: from PR3PR09MB5411.eurprd09.prod.outlook.com (2603:10a6:102:17e::10)
 by DB9PR09MB6714.eurprd09.prod.outlook.com (2603:10a6:10:4c5::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.28; Wed, 23 Oct
 2024 14:01:12 +0000
Received: from PR3PR09MB5411.eurprd09.prod.outlook.com
 ([fe80::4b11:ef50:8555:59fc]) by PR3PR09MB5411.eurprd09.prod.outlook.com
 ([fe80::4b11:ef50:8555:59fc%4]) with mapi id 15.20.8069.027; Wed, 23 Oct 2024
 14:01:12 +0000
From: Adrian Vladu <avladu@cloudbasesolutions.com>
To: "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>
CC: Alessandro Pilotti <apilotti@cloudbasesolutions.com>, Mathieu Tortuyaux
	<mtortuyaux@microsoft.com>
Subject: kernel: fix hv tools build for arm64 when cross-built
Thread-Topic: kernel: fix hv tools build for arm64 when cross-built
Thread-Index: AQHbJVIVJh9jlXaGHkuzaKBwEi8qpw==
Date: Wed, 23 Oct 2024 14:01:12 +0000
Message-ID:
 <PR3PR09MB54119DB2FD76977C62D8DD6AB04D2@PR3PR09MB5411.eurprd09.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cloudbasesolutions.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PR3PR09MB5411:EE_|DB9PR09MB6714:EE_
x-ms-office365-filtering-correlation-id: 271fe9fa-5842-4c96-59d3-08dcf36b270c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?whHoYYwRqPEu+DjbiWc605eAB6KoMazwl1Qijrqe5fFoTP27o0JHCBNb4f?=
 =?iso-8859-1?Q?iW/zqGrdCm1tmt0K8GBduSxfeoJ9plX6HnVefc91t0sxwB+iHaxTmP2Anm?=
 =?iso-8859-1?Q?Mvo7UruzF8u6n6sTO4LRZYGqDQJhRP1NgYocipicV4S8TmvIs0GlAeCfUk?=
 =?iso-8859-1?Q?rWPsrU6k/h6oxu8B+YRcRVH7Q5Qko9vrUU1mYUMxcBEF3Nsb5PSAcH+BWx?=
 =?iso-8859-1?Q?nLsQWR8OJ+ZDSgD+x7A/+A4ReMbGMRsJJk4tNTm4WGWhfHuXUtpu8T5nYe?=
 =?iso-8859-1?Q?9j6f1J5CKcTtuvZC5tIFgBRFriWh7Qlw144hNhiteEFqudHqk2oZXNv2Yh?=
 =?iso-8859-1?Q?xUPq3G9mJY+J4CSAe2HwNO97s+nNlulKvwMzF0pAbSY6cXCuQxIywcKx47?=
 =?iso-8859-1?Q?Sb+1OGpxeCKjXp6n9MiwlH8LkxsKG8bD30kgMl99g1UltgOawMVNgD/M0X?=
 =?iso-8859-1?Q?GKAkaKXHn79CZ23kbHQJ0J6WwFjZeABSv1JaBeWYqzZVkJ3Mq1bhz25TsG?=
 =?iso-8859-1?Q?GtXwXqB6kVlw0Y1Oy1DUP2WFlV1BbpBjES58NfKwV/dyA046EZKllHbpUv?=
 =?iso-8859-1?Q?AFJsfleRDPnEJsUW9YlAgwdpkExdBKEkeOJpX9i2QIA/bsff3zXfDeTcXS?=
 =?iso-8859-1?Q?nklw41lfRF2Prruy0XY1L7kW5LxR53SJJHp5oBJc/QU2w+tcjrYrerac5r?=
 =?iso-8859-1?Q?nFNf48aV5Oez1Ej8k1YBKxIp/H5Tw2bssMDFLT3IWVRcyNib/EEVp8r9Ik?=
 =?iso-8859-1?Q?XIEDNBBXJgjkXO0flXskZ6+gEHaFBD0DZcY4KR7lg1uhU0hOSSGWfuLVt6?=
 =?iso-8859-1?Q?69/oVIIKfck+aaPA+j307CXcnpY2F8dIK/4J7i9Do8mtGAESqBbb+MDtQS?=
 =?iso-8859-1?Q?lIHvd+BSN1MEzaUCI6w9wDKUpoJelOpTqwoW+f98gOXrG4kK5l2mUeVBME?=
 =?iso-8859-1?Q?FKv9z9RiOI/977dbaDUqbOAMRW0oYekurYfRkBnOZKM16kMbfQkNQEmClU?=
 =?iso-8859-1?Q?3QoQzIIYsa/qiWVB7zMxyzwqm6x339Es3+HziZ50DOznj7CuArfwMbg6O4?=
 =?iso-8859-1?Q?3Fb7Us+BRQZj50ZEeQR7mfiR5h0VbdaYPuHEIbSPJNtDPSYJ/0Kfg+hteX?=
 =?iso-8859-1?Q?/M7awA52F+xfHpylnXd+2k2RDpOkfdYiXmgUomEP0YPZSXwhGEHYnpN/o7?=
 =?iso-8859-1?Q?CMV+uteINQiILrTzkupOJUxsutiNimzEAFNicrxxm+2sHKJXp4GTHNyZAf?=
 =?iso-8859-1?Q?KychNqCIROiLDuXyBkdsemA3ZiRZT21coN2sma9QvkS7O9BTSLuNzhSOox?=
 =?iso-8859-1?Q?/k67OlevFFFi7kdggxWNcqBX6NsG5H2Gb7UlK7jjFNf+XJiUxpnsDsGV1N?=
 =?iso-8859-1?Q?VlQ62DDCl0?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PR3PR09MB5411.eurprd09.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?hcKC+1dWfX2VEmpApXteTlJeinA7F5nr7Wry1WUn9Ftd2HeFjXb1RnsgfM?=
 =?iso-8859-1?Q?0FFBt37orO+HW83zr1W3W2vF2TiirfeG6QLduj5j+4n/DShMSHA6zoHBZP?=
 =?iso-8859-1?Q?oTAg4LVBr0eHUM37uGEmXv7BNK0WUp13hlGes88QEMhZY3wrOR6UWyB+wT?=
 =?iso-8859-1?Q?cTXmZWE3OHnQq6ZuwBtme48RBbb9eqDoZGAySInpRUO/0o27kTIDHKJ/Ba?=
 =?iso-8859-1?Q?v2HepwEwU4Yde1LaZ36nhowl1TGkmqJMpuvFXglr2bLu9lfUXL3xUxKv5b?=
 =?iso-8859-1?Q?fMo1IdREeXEeDisG3yOPbN7I1wAl3RiSPepW+eZlRQHdfXlJD4qFlGFH1U?=
 =?iso-8859-1?Q?K7SXzSmGrHr02pv0Pm9Ouwt/weu3OSo9ruUgAcWcYpIdbhMMUE+P0vxvh8?=
 =?iso-8859-1?Q?3QxLsBcjS3SWZcyJdJWkwt4UfBbapHwg4eSHzWv17x95q+TECyvm3WTczc?=
 =?iso-8859-1?Q?t6WWfIDaO2vm0wjSCKi4D4BA3yWK6+Ov/4H3hjTa/bGj1Dun5UYx4M+Wrx?=
 =?iso-8859-1?Q?EPeFcuW5EoHlx87QipTBzbflNAlfZSh69DoSoAisHJvKJB6qo0SuhYuNs7?=
 =?iso-8859-1?Q?VpiVjTzTqrOnzoWij8QPuBQHd2DyWZ4Zxfx3+bD5jnqVVxwXRX2YPUQtF6?=
 =?iso-8859-1?Q?NxzrKDElrfLE9Vsluj1mIRtVnePFubAtljTiJgtcAEa0stqWTS+NoHe20V?=
 =?iso-8859-1?Q?Rk3IV8bbhEutlg5vBaZXtrnLdHK430dy03DZBBd7u9DF3xNuU3dV/us8tv?=
 =?iso-8859-1?Q?PhcwSR6MUCMyaWa16hp/zaYx4w15+OSXuEaw5sdugqcTjIOaj5iiCBbkot?=
 =?iso-8859-1?Q?z/B4iCLXUrDveyWZyl0/vvbpyWvfh5pdkE8/H4Uh4mkvRfpJiDgPYuu4Ph?=
 =?iso-8859-1?Q?wQTPkTv1z6qeSHZAM7/nOkBhrk0GsBpDof/Z3HQbI31t9LeStkL34+X4lW?=
 =?iso-8859-1?Q?bfIm3OavoCnJkqye3B+41lIsLgR+AXq+LnhQA2QmolEJat5ks8yXDknFcO?=
 =?iso-8859-1?Q?QvUdzYcI4g2SzVv6NRtvD2Q6cVVWpfRLMhvKUJSdsAB9SC6H/+6bsp5NPW?=
 =?iso-8859-1?Q?qGGfSZgxbckz4r/aLg7ykkxDms2qP+YPMLgqVZFgUw13knTlUwzLW5df0d?=
 =?iso-8859-1?Q?zRs78qEUKcIfpsk4W+DR8kHf4nz7LM5k2SZNgKBI27cLNrte5+UegugVr9?=
 =?iso-8859-1?Q?4l4gxe9yJQ3Yji3EWY6UhTOXax5mr9/mK+BrTfvx1CTkA8MzHKC+G6g7bo?=
 =?iso-8859-1?Q?8ZrdgNomnAQGTzvFBEkJCfhXKeW1poKCKxHAJozbqu56TPuJC40E1TTXn4?=
 =?iso-8859-1?Q?flWFqFQ56UuHZQQQNaoFq7ST2Zrz9jNXiPeH9hG0TZBB/QRUTwTxQTEojh?=
 =?iso-8859-1?Q?pwLmCa88tAxyyRJIhtm2HK58TJYAa4FCV/9qpJ3nTEFvj1KH9DVOFAA+kR?=
 =?iso-8859-1?Q?nakgoopN7LtKcJbmrmWJUfhKp6y4QZhxgseUZ+JiwwO2qjJxaiUFtsBqD3?=
 =?iso-8859-1?Q?3JSaXHfPwWl6eABnveGu6fOaNlNwaeUEvYt+VzIB2uEYrx27t4lKM2X+w8?=
 =?iso-8859-1?Q?09cYX2JPR1/eTeOGf7bFwLX2ZFA5divF7vU0DAbItckup53AsKDfvwKs2V?=
 =?iso-8859-1?Q?mYnvm4f9doOEK1y/r9bWbqVtPnksGpJEKYo27coLC5zS3rQU8ruYicDQ?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: cloudbasesolutions.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PR3PR09MB5411.eurprd09.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 271fe9fa-5842-4c96-59d3-08dcf36b270c
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Oct 2024 14:01:12.1433
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c94c12d7-c30b-4479-8f5a-417318237407
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WNtJUf4Q/9mp3afIhJJTqKqUQ3UxNjiAZcasias3Q5x/yKPMNOuLz4wVB67T2tTVPl8os6+pF+hpxYyN5i7Uu0OPYXalZzJ0yJbMgy1yHcQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR09MB6714

Hello,=0A=
=0A=
While trying to build the LIS daemons for Flatcar Container Linux for ARM64=
 (https://www.flatcar.org/), as we are doing Gentoo based cross-building fr=
om X64 boxes, there was an error while building those daemons, because the =
cross-compile scenario was not working, as ` ARCH :=3D $(shell uname -m 2>/=
dev/null)` always returns `x86_64`.=0A=
=0A=
I have a working patch for the Linux kernel here that was already applied i=
n the Flatcar context and it works:=0A=
https://github.com/flatcar/scripts/blob/94b1df1b19449eb5aa967fd48ba4c1f4a6d=
5f415/sdk_container/src/third_party/coreos-overlay/sys-kernel/coreos-source=
s/files/6.10/z0008-tools-hv-fix-cross-compilation-for-ARM64.patch=0A=
=0A=
Raw patch link here: https://raw.githubusercontent.com/flatcar/scripts/94b1=
df1b19449eb5aa967fd48ba4c1f4a6d5f415/sdk_container/src/third_party/coreos-o=
verlay/sys-kernel/coreos-sources/files/6.10/z0008-tools-hv-fix-cross-compil=
ation-for-ARM64.patch=0A=
=0A=
Sorry for the delivery method via github link, but I cannot send proper pat=
ches from my work email address currently, as the email server does not sup=
port it.=0A=
=0A=
Please let me know if I need to send the patch via the recommended way or i=
f the patch can be used directly.=0A=
=0A=
Also, maybe there is a better way to address the cross-compilation issue, I=
 just wanted to report the bug and also provide a possible fix.=0A=
=0A=
Thank you,=0A=
Adrian Vladu=

