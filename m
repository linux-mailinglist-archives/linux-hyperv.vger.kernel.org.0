Return-Path: <linux-hyperv+bounces-11053-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sNf0AIy9DWrH2wUAu9opvQ
	(envelope-from <linux-hyperv+bounces-11053-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Wed, 20 May 2026 15:56:28 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FCDF58F25A
	for <lists+linux-hyperv@lfdr.de>; Wed, 20 May 2026 15:56:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E2B043101092
	for <lists+linux-hyperv@lfdr.de>; Wed, 20 May 2026 13:47:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9599D2C11D5;
	Wed, 20 May 2026 13:46:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="VUCYVvXU"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazolkn19010006.outbound.protection.outlook.com [52.103.13.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14AAC3939D3;
	Wed, 20 May 2026 13:46:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.13.6
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779284776; cv=fail; b=ikOs3jdUvBmCXB5o0jvQ8lm61a89mjR81pvO0aJwZ8plTHFMkybmxIV56LaJBP3ENlOuIBRZInFRQghaMswKDFOATLXaYaC6BXPwWJSolTznldLhXmV2TRgcmZFRlucw6/61D3zykk9LONbgyf/VAXSg5iwTXWRsqW20q3BrXHk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779284776; c=relaxed/simple;
	bh=dDkIHJCbktSzfXhjSE7dNINeQ3yLPz9/n/OLGKyyRwM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=qje8Z2+Bu10rMlWgDtCDYsAbU8PKMR+7k5MzsA02IrHqIRVy9acPmqZvm3f7Nf+GdrbKtOgBe4rw+McWheBiNwrooWackv7OvN9wE5qTBZqGM5rVHFGXdjcVC38dx862OJ04/1nGGwSyWcAjgIinjCdyEvrbco2LxtxdhFx9Gjk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=VUCYVvXU; arc=fail smtp.client-ip=52.103.13.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=m5OVp0Bw4ScXl9F2cszHr/PMF9HSoEM9n03VbUkgM/LhCZYYDypjvrL31HUJCcj9SSMxoUSotiu/jqgvObfu7W+yyJ5vG3QFC/2B/FUeseH4dx2g5RSgs8yHhlyIoA8WR87BlHG//GZaBmyG1OevDdXvpj49153D/Wa/djaBXp3rpaFoXOJveD+lKtpZ3xZXGj6yTnl5ER7vL+/F7Ei3PbE/vEc3jaMP8Kn4WJrILhlVTLxi/aSRi5UdJ9KbsxfETs2On/eP7vm2h50TGJDNUD8n7DYB7lQhf4qDubbmg63VVU9uwLkAMSgtPk38pBvGzpsawn3gm9juik8ic4HQbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gmFyI2hWIAKmen3cQNxvcdu/ZaKnKo5cwvtBu09jJ+E=;
 b=HuEdsOi/cY6lVbKA5kryHF/psbpOUImjsZweOarQY0uJhB94WU4ZL0CRpGzaXzCgrS3ELrVQ1C0RbQThUqQJfMB5ZaJawgU2tq9h5ILkFOYZLUzyXP1mK/YzZ5RUITMN+gaJSAOFwnqFnZJEOyj6eWlXCz1e2MPEtIWKVA0W+9vFIcZM/SspS8F9bPmdzfVisWSPndN3phWXStEhdF3KlqjatT331htMOtD/qfsx8GQopX6B+toMqFI6YNr39J5O9Km6Ogw3ohbFD/68zPi+C3wvW1gNGkGTdfF7L8KYYZy4mTCdY3jspNRQM2VRvNbQVpvMUezGQQGHvBQs1/7tCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gmFyI2hWIAKmen3cQNxvcdu/ZaKnKo5cwvtBu09jJ+E=;
 b=VUCYVvXUX9RGrcUUyQRv/C9Pvc+gRF3+l1Bo8lFsQUnSSOyIFgBUx9A5mUAjyYhwgO3Y8nHZhqA6OmqQ9okqaaHRH9by5R0LR4CnAlPGmoWk1jj+E0c82JvzCAH2c+QG/gLpEGFo2k2wbq25y25CtK0P8xqPLrQgsH5HNQOcZ77t7a8bRveISODP22hXgBfUvOp4mszJGt6CoVW+aF2IxCqgfdM944A43MmHHdMrEz32Fgo0i9akWZygSl6qVjPMTo06hCi1V99iqRzBOOncdk0/y6ws9I//JV45LeyFQ5JA6zcjskccNSZoBIDSabmhUgQH0y6JRKWRVLdhZVL+BQ==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by BN0PR02MB7967.namprd02.prod.outlook.com (2603:10b6:408:169::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.14; Wed, 20 May
 2026 13:46:12 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::900:1ccf:2b1e:52b6]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::900:1ccf:2b1e:52b6%5]) with mapi id 15.21.0048.013; Wed, 20 May 2026
 13:46:12 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: Arnd Bergmann <arnd@kernel.org>, "K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, Dexuan
 Cui <decui@microsoft.com>, Long Li <longli@microsoft.com>, "Anirudh
 Rayabharam (Microsoft)" <anirudh@anirudhrb.com>, Jork Loeser
	<jloeser@linux.microsoft.com>, Stanislav Kinsburskii
	<skinsburskii@linux.microsoft.com>
CC: Arnd Bergmann <arnd@arndb.de>, "linux-hyperv@vger.kernel.org"
	<linux-hyperv@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] mshv: add vmbus dependency
Thread-Topic: [PATCH] mshv: add vmbus dependency
Thread-Index: AQMqr82JznkC2EbJbGYN+Tz224qT+bN7W6xA
Date: Wed, 20 May 2026 13:46:12 +0000
Message-ID:
 <SN6PR02MB4157CDF10D33D62DD8709D63D4012@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <20260520074044.923728-1-arnd@kernel.org>
In-Reply-To: <20260520074044.923728-1-arnd@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|BN0PR02MB7967:EE_
x-ms-office365-filtering-correlation-id: 57d0eb00-6879-46c9-2525-08deb67627dc
x-microsoft-antispam:
 BCL:0;ARA:14566002|15080799012|13091999003|8062599012|31061999003|8060799015|19110799012|51005399006|19101099003|37011999003|3412199025|440099028|102099032|40105399003;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?CASdM4KjlsxWs5Xix713kTGcEzjgHsgCUJObn3KB2wj53nhAbaWWERjp/vKb?=
 =?us-ascii?Q?CJwebXKE7iqNpZQyCCz2QblmkGgTZzPDzTn8Tk7+IXwhCWIDagdfVmjeYmQD?=
 =?us-ascii?Q?fjNDVknrgkAvttqrBKZOjRk/MMSffHtypfbtmFjaMaWHgykDgpVdZKyzGCQK?=
 =?us-ascii?Q?4ii3Iz+pd82WeDyMDbmghil4baQq1RJbs0jfnLYgXPDx7Ebmh/azqyXdCELP?=
 =?us-ascii?Q?F3Ui2YtMmy1JWb5Tig8d56fwVx5Rfd163F3EMLNcY7YDl73mRrr2ZvYus7t2?=
 =?us-ascii?Q?GLC4ojHf6rSXqOPpW36vt6tufhXa+5FMjym2RmU+jAyLfWsNofEqsgsdH+Hv?=
 =?us-ascii?Q?hpkYKcr6cOZ/y/eLP5a6KPOlYY6buVBm981W68fEcpeCTMR7UkGz0yrw3iNa?=
 =?us-ascii?Q?HfOvVRopUkSsuMY0wkbCTlq980rf/LtPkM5unVcvYIPfN7eNivFzPn4rI3oC?=
 =?us-ascii?Q?sP2Tr+w6uUzsk2Wj0gk4SQ209d3bwEg/HkEljvpWIs95XqdEfrA/iGCkNonS?=
 =?us-ascii?Q?ZATP4AQyYPrKXZU/tbSxe2+xKQO/8SAYs26+gXFD7hLc8RJXtT2SFUUYBgg6?=
 =?us-ascii?Q?kkfI5fTGpXs8WdY1PDB7a2QGfqCb//7jvX7K0Ld1/ywpAtrJvHRdBBNUybyg?=
 =?us-ascii?Q?ejI2vZJrNwxv/csZtfIWBBGJJwKjzuj5j62D4pulU0LnMxuD33hCq6oG3IfC?=
 =?us-ascii?Q?DwZqy6rH1M1i5VxttQY2O77M7zlK1RcoDImR0VdDq+1kmJmfhXJl2xbDjeKW?=
 =?us-ascii?Q?tGQ9bOf/paeHxlu1jJtTikRavjZIkICdZVTuU34QXqLpWFV6yqGXBoYgYAUu?=
 =?us-ascii?Q?nME/1ABD/dUSpwso7LiuacezdPI9ldOGJI58L8duYD/4H+skpqSUXD9QOQoT?=
 =?us-ascii?Q?HE4a0c1nJnonShL74kVfbwUqIvPw6y7mqDs2CHTi54xkWPfkBxxQXnQxtmh3?=
 =?us-ascii?Q?azTtO4Ve9dx4g0tjJtR2NOI5n2p3vvqabJgjxl25tZadwXCsFACBAjsxNxFC?=
 =?us-ascii?Q?FQLh?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?IEVkGF80SltaMx3TD58cb+i8sPIolT2CRaPNy/D8o3CE86I8CAtwhV6LcoME?=
 =?us-ascii?Q?76fvqayqreV5IyTX7uEimH3PEkuh+wUQTE6ZU97p5Dwh/h4ieGv/YfpcSEyX?=
 =?us-ascii?Q?X4KapirLCcsp8pGs5H9OUWTEbOCdREtEP0Z2lX+FjFW7fABz8kzK+RXqyEul?=
 =?us-ascii?Q?ef+uuAgChJ26nwplm/7O12iAB0M7cnqrhEtqXRch5pJswSofWZWHg4py126N?=
 =?us-ascii?Q?Xilx5p2HJbO1cTVq2OFH5H16PhTtX/vJc+UGo8BPaffZQR7yCwHAIddU/ro0?=
 =?us-ascii?Q?jR7gFu+76/zxjtpg5kAlwGg/u2YvTvSJwXqxI2tfm0niPA35VFaRj/u8d0ZR?=
 =?us-ascii?Q?kU/nPYYZEBr+atkjfDgAjAGusF8fVm//D+H134NK6M39ysb2wOT+0JPNM1hM?=
 =?us-ascii?Q?MeW5W+kaIhUsyW1XLdXa2Pu3xrTpNfpqOQx9BmyHcuGLrneiWAKWnWLBQoU3?=
 =?us-ascii?Q?PGdyqtetpAmXOtNu7JKwm6DOwbF7DJ2t8dRPoicH/LY2XSkn7FzQE6CxPBJ0?=
 =?us-ascii?Q?6QiR0Mj+WaAASXV3wE5uqiMp9klVTHqL6kPZ6k+ioIPtZV/+h14RFLfCsLWw?=
 =?us-ascii?Q?Q4GVZs3VAsXRpjI1qIKoKIG1v/TTIcZItCXCNWUX/nmKnoLH4dUCCPYKFDxE?=
 =?us-ascii?Q?IqBa3dzz8vhQ6fg4IE5SRxV1gkp8juqkxQXl7qZwcywiXqPWQBBjJbt1l1rB?=
 =?us-ascii?Q?j+ifw6Z52M6LipTQCWRXGCPKyoQOv5vWhBideaPqLSBXDlaSueyVN1b2fyaF?=
 =?us-ascii?Q?MKekz6q5znHuXjz34pZerqb5meyQvAveiZ48STNS2b2MNaDj1I82Iv+GARFm?=
 =?us-ascii?Q?6T2yFKT1Sy1FuxKAUs8H79hGPo2QzqHsnNxySLu8NK8Ht9BGJMRU410eUq2U?=
 =?us-ascii?Q?t9F1dgyWFFyz3lGPBarkl5Cs0xTQpMOd2WnmnojTezQVXtwwL6FLdYKZFWPt?=
 =?us-ascii?Q?LGLWySZcRsYmjCpi2oMqIB3wRg5e7wpHPehWN3tbdbreW9AaQ6FLGy0jWFUx?=
 =?us-ascii?Q?7srh1zzIzAMJzPvKjuQ+hHWx4hm0Ji/89GsQ1BOfnB2Djr+nn97X0JNu6EMo?=
 =?us-ascii?Q?Y7kaJW46Ikst6ZY995d7S7lJ/QzYsHcUR48LC1qxaJi01+IM9cjTKYFq7Um2?=
 =?us-ascii?Q?aRM/9/bzF/LG7iTTIvClk33s1cjQpVOjGJWirVooQVxYScKxYV/4PyODp7Cy?=
 =?us-ascii?Q?gvYXCQCagm8PZaYp1YAqgvrGzojyVkhsHFYCHctwY6T9NG4/118bhJlCh8ZN?=
 =?us-ascii?Q?88mLhbptx7reXg8ZXLBHlle2SOJYNpkc0o0ZG/5TWwYrtSioSgL11aGmlxzB?=
 =?us-ascii?Q?CUwRCjjV6JAeAha9wzN1IxGh8nBzYnwwFgzN8+8hFZFog5ExeWvAVtqmAgEQ?=
 =?us-ascii?Q?iGTC71o=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 57d0eb00-6879-46c9-2525-08deb67627dc
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 May 2026 13:46:12.4025
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR02MB7967
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[outlook.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[outlook.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-11053-lists,linux-hyperv=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FREEMAIL_FROM(0.00)[outlook.com];
	RCPT_COUNT_TWELVE(0.00)[12];
	DKIM_TRACE(0.00)[outlook.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mhklinux@outlook.com,linux-hyperv@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[linux-hyperv];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,arndb.de:email,outlook.com:dkim,SN6PR02MB4157.namprd02.prod.outlook.com:mid]
X-Rspamd-Queue-Id: 6FCDF58F25A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Arnd Bergmann <arnd@kernel.org> Sent: Wednesday, May 20, 2026 12:40 A=
M
>=20
> When the vmbus driver is not part of the kernel, the mvhv_root
> driver now fails to link:
>=20
> ERROR: modpost: "hv_vmbus_exists" [drivers/hv/mshv_root.ko] undefined!
>=20
> Avoid this by adding an explicit Kconfig dependency. Note that
> stubbing out the hv_vmbus_exists() based on configuration would
> also work for some cases, but not with MSHV_ROOT=3Dy and HYPERV_VMBUS=3Dm=
.

Conceptually, the MSHV root code should not have a dependency on
VMBus. The "does VMBus exist?" question should handled differently
by setting up a boolean in the core Hyper-V code that defaults to "false".
If the VMBus driver loads, it would set the boolean to "true". MSHV
root code would query the boolean.

Michael

>=20
> Fixes: f1a9e67c1138 ("mshv: limit SynIC management to MSHV-owned resource=
s")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  drivers/hv/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/drivers/hv/Kconfig b/drivers/hv/Kconfig
> index 52af086fdeb2..21193b571a80 100644
> --- a/drivers/hv/Kconfig
> +++ b/drivers/hv/Kconfig
> @@ -75,6 +75,7 @@ config MSHV_ROOT
>  	# e.g. When withdrawing memory, the hypervisor gives back 4k pages in
>  	# no particular order, making it impossible to reassemble larger pages
>  	depends on PAGE_SIZE_4KB
> +	depends on HYPERV_VMBUS
>  	select EVENTFD
>  	select VIRT_XFER_TO_GUEST_WORK
>  	select HMM_MIRROR
> --
> 2.39.5
>=20


