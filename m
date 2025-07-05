Return-Path: <linux-hyperv+bounces-6107-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A417AF9E3D
	for <lists+linux-hyperv@lfdr.de>; Sat,  5 Jul 2025 05:54:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A7B6B56734B
	for <lists+linux-hyperv@lfdr.de>; Sat,  5 Jul 2025 03:54:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1365270EBD;
	Sat,  5 Jul 2025 03:54:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="Ui/2HMS6"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11olkn2094.outbound.protection.outlook.com [40.92.18.94])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BCC42E371A
	for <linux-hyperv@vger.kernel.org>; Sat,  5 Jul 2025 03:54:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.18.94
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751687644; cv=fail; b=HlaQJAhgH57erTy257UM4Z9aqC0Vp0I5zsz7rw5ZcTffrPhcTfKTw4V3rK7kTsmqyWFI2G3n+hCvvNSeqkVmVyeLlyqFOCRZJpyBR4DhOKlACNWYD8DbjpFy1bOOBlG2htEsvqlY8hLfpaY6iRa7MnTjdUc/mSXJQK8VWdz4tWI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751687644; c=relaxed/simple;
	bh=A+us5AF4UOA9OnyHOyOkdEOJZmajYXMMKl0/50HEjXI=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ge1iR6IZ1gs/I9YgxU6KRUBn34iC8oDiCVlUg0mQV9XwHV8+jPnyn9yOXMEu88Vvx7XAclLb4Bsfa1lAt79UvfAwEaU8U3m1E4kkx6CmiapfQyxb1o7kuKvmS/lpatpA+KilrQw1cpFfm3FNNsKyy0Dzr5lyXFd80WER9C/TmQE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=Ui/2HMS6; arc=fail smtp.client-ip=40.92.18.94
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CTvrxV3CmoCJbRM1qlCnumzKmQdan9ej3TTVu0FcxP9FtfcBv1VYYsf0h3+/dQ9Xf7V8DfijkGx2YeyXm6UBlOT7+qeh37p/Rx4Mxrx1SlQCMrKVx7FXsMkGtHK2IZkO3ik1HUeYQsy5GgfOA6sAKFMcdgSuWV/y4Ok+dS6IrGNCBgGYlxFejcshl8aMX03VjoIOzUyf3AJSjYlPinU9wfELaeBoTFRXeerMmrEbVSdwRCcu0Y7IF8UH0mL5t8jwE9ZwzVoL3hmHSJgFlnxJ/1y1zdoEiAKrFvLA3H98A0GdWWHYLMNTPjl/NmWy+0XXaVjmoWLLmCFFn2g3d2pymA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zOH8/g2q3KrQTh3116J6e/9g3LymLXMKtR0z7fsL6L0=;
 b=jGMh06S/2y/Blxdz/IAxpWbyXP8yWJt/MmHm4ftxJ7+ZnU6mjLsxv4SmSlQV3s25Xxs9jeIWBRPih6gH2UW9aVr+a+2BxxTR5Q86e7M6A5eMFFItRitJ4BZt2ebzHNckBcf/IiC/qxAyHdaiRjXwtHEUADJDZQYdEGQ82WPQsLmkNRGaNcpt6Hy06Qb3DGNGXlPrTrqi88GPu8X+j+nXf5oQRfEBoCZPK9carvfqEs8Gwb10oPmrb8qOulMgSs2iB1OaJOkYMuRCMzW8zrH07R7OwQo7V50WJ+lvMz0cPyYXz7/OXE7zeFaX+OJlmWOjxqz+6FswyZ3CN+EQxhMUPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zOH8/g2q3KrQTh3116J6e/9g3LymLXMKtR0z7fsL6L0=;
 b=Ui/2HMS64aFhoEj1WBsSdryX1LSXpTSkDhv1/wDgjRkBTXYvblVmc/XPlJ8V33NuflPK9TYbG6VpUsh5I+e2E0eOoTIHLrbunW+R9y5lC9uGGGNorBLmCenJVlYVzelUXrBPQdZWFXznwogE9xATjf4qBepp4CYVYCRcwrWK9EAkQwEHFfq7q2Gd6NUprhXLGiZ7k6hN8dIengbjmb9PB/mTxMOB2y9PBa1pQdsXBDPg76JnSQmR2l2/l72AqMGa7ndEyYXbJn7Yqy6vvb8zqx2Il1f+qNZl+Qjzff5DwtUjnxukBHRMkfEjgwQy34qBg5Uk4s6pb+mBDmZVE1BmsQ==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by SJ0PR02MB8579.namprd02.prod.outlook.com (2603:10b6:a03:3f8::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.28; Sat, 5 Jul
 2025 03:54:00 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df%4]) with mapi id 15.20.8901.018; Sat, 5 Jul 2025
 03:54:00 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: Nam Cao <namcao@linutronix.de>, Thomas Gleixner <tglx@linutronix.de>, "K .
 Y . Srinivasan" <kys@microsoft.com>, Bjorn Helgaas <bhelgaas@google.com>,
	Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, Dexuan
 Cui <decui@microsoft.com>, "linux-hyperv@vger.kernel.org"
	<linux-hyperv@vger.kernel.org>
Subject: RE: [PATCH] irqdomain: Export irq_domain_free_irqs_top()
Thread-Topic: [PATCH] irqdomain: Export irq_domain_free_irqs_top()
Thread-Index: AQHb7GBlYYUJrbV8DUWnPT3TxvoKGLQi5+WA
Date: Sat, 5 Jul 2025 03:54:00 +0000
Message-ID:
 <SN6PR02MB41576507F1C58F0CD5BD1E5DD44DA@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <20250703212054.2561551-1-namcao@linutronix.de>
In-Reply-To: <20250703212054.2561551-1-namcao@linutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|SJ0PR02MB8579:EE_
x-ms-office365-filtering-correlation-id: 1cfb323a-b17e-4e18-1d38-08ddbb779387
x-ms-exchange-slblob-mailprops:
 ScCmN3RHayHp2tL9cccfH6yYy+ymO9/BwZZDzVWtpr9NyYhX1QsL5vUcIBX6V33fb1ZAriTN2n8Xny9ARh8VnqQ7E+FqB43hQxkClCUOKooO3h9N5Fbp/PYgspnuwQPKrXGYN2Dzqq2njmhLkMOiunMRQNFS6vxqQ/0BNrtxRvuSTjVpJrtYWOt/8RLcDS0tT6+9iBhsNkItpTKlqgoctx02mqpbHs2ep9DYgKzI+ko8pOAdXfcpEgX1P1XYH0Cvu9aTXE1zYicrY50rn2mGrR8CGRc8iuvWxfGsQBKT7nR2VkvQnb9NUzD6jiY4XefiTN1ztL/x4pLtXZe5tQOTRTsT55vPviWtfXeXQoOmBZj4Y4652DtrzVbxOcVVoB5o7tPfKbg//seQoMTPh+JOAIc4mGAXxNWU2geuDmZh/CTa2I7ITi6QG4/vdn/8Cg0avrE0RLJ6Uu8w2sj8ipYMn9qxlF2sBoQ1DblwhZ/5V6Vz+KUA3Q1nsodjyB1WEtCS17MatP3ULl1caRN20KDpZ7wFr5iTtj7cL48BIYbgutb9/8xhLTgXl/RQhaIpUJPT+5MEWzpnzX26d2OsgFQZc1bXBwpwGUOD9ZoCX/wmF3R/Bhf9xJMq+fsle2Q5rgNPV60MW4NuKb7Jej1Moeink15AIWxE+cVMvJDheERi86HQ4bRbiBG97jVkc7VvjNv3fcCBX45wrVXRontSvG0PLlQTBuwX43TBEenzhxA1fx8=
x-microsoft-antispam:
 BCL:0;ARA:14566002|461199028|8062599006|8060799009|15080799009|19110799006|102099032|40105399003|3412199025|440099028|11031999003|12091999003;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?r2UZ95BKIYgid6aBGUulru5cDowR2hX/dM+1VBKSpFTJFIHmxvqHD7drsek6?=
 =?us-ascii?Q?eradyqkcYWRHfUUWy7TdLJ0ltzithQeIYXq2YYOMDhTEAwMwsLT/H02ITuTX?=
 =?us-ascii?Q?8cNsPICcHlN8qelgOJ6DTVX2cbx7lD0EEkoAU/1168AOqzuXRge7+BKmKtf8?=
 =?us-ascii?Q?HUvoL1EYP1YKHbsZKNM1nVbViq7j71/BKSEvdOufvV9Vj2CdfzRvZTVME9l0?=
 =?us-ascii?Q?clu8haPub4v0tB8P9jeDslU+VJrYlccXUYiP3BG2wel3TtJ+ofR4T0XqWAHy?=
 =?us-ascii?Q?Tl1G1fXPVj8HYWudYmeQjsT+Awhm3EzuGJ/Ro2TAkfqWkMJZr+CrvKFcbHVD?=
 =?us-ascii?Q?EPiXyFBN7xm7cQpa2byX/2Rn+YPdgqbn0N8I++gdFdOAJi+1dLS/Rd1689N9?=
 =?us-ascii?Q?mnqgW1OyyH2ughnqP8LLqiEoo2yiObnYmVTaBJekSEJdyZqcbvJSY7RBi6ED?=
 =?us-ascii?Q?kk2hFI57rbJ1IN0x838LJnvuoMVvvrvYAuJC7qGgMgeQJdiWNonf30+r44Zd?=
 =?us-ascii?Q?Grhm/NxHtMOW+fSR2U+CgcKYrD1hHhm3f6h9LiLkn427hywSSLtW07j6qMlg?=
 =?us-ascii?Q?igzz7Fi74WQu8DqfgfHoUXCSj5sZQOTrugMskV4ruAY8qNJwNhAj4aIKb+yK?=
 =?us-ascii?Q?Za32Q53X+BTiHB9d3XVaxNoPQTntXe/LZbCQ/AzDv7hfcHlg/i+1Vb/JO11v?=
 =?us-ascii?Q?yjI+BgdeW1jOUM5nyKKppzpPm+IFNdQT78T54qkt2ki1FPN3YFRMwX1I2Myc?=
 =?us-ascii?Q?wJIzb8Sx54xQ23oDzeGR4b/8M+wGrl7oj8SoU19Lfxovy1UVmpBMIS/ePPsv?=
 =?us-ascii?Q?Vuey0wyImRNb2wZukkjme0PNnyP4/ZIu1yIXFpl7v54KW9iaQoobcpGZVeBH?=
 =?us-ascii?Q?EnP41WjfTQT2+E50eOghJwDuFkBh1jod654tEaHBVp5UVtMRQrQU5AjGe5FX?=
 =?us-ascii?Q?OEIV+v0HMBM/8BHVcnlOPuRPUcGZubOXCkizVN/ABrOmB0XltCqvF3ihikYG?=
 =?us-ascii?Q?WhHaP3dX6BSR+5tw0BlH1Bw+fxk6OOCdVABHXYjceS6q/sH7XGjwXX8s2ge/?=
 =?us-ascii?Q?kqeCNAeyfIS8eK7OU5xha9Psumftk2687bH5lGAklhHDjrlyLTNglfOqkgp1?=
 =?us-ascii?Q?iLQQ7UNuY/L2L8KTcnM1toGJXAC1D/FnQDjMQrgYdxE0iNERXjYENd18kHG6?=
 =?us-ascii?Q?qQnNoExZUiyfyCK4?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?qGjwbAscKGE3u4323mjGGrJnU3q/w/DZDXpsLockei2fyOsqRZo3mXFkFWrs?=
 =?us-ascii?Q?OfBY0B5plYDZEc3tHd4SKi4DJ15/qQxXoZWNf4fV/3Ciu46lHCG82UvUgrSV?=
 =?us-ascii?Q?woMFad8OD/ekqEYXbOkkswsTGKPyJF6eF7kXvHlc2J9/Wd/fiYzHmwJetrft?=
 =?us-ascii?Q?jMjLxLEeka2HrWJE8stxCi2J3x9H98E3w5csZhrulN87GXAlUvGfmnlIpDz8?=
 =?us-ascii?Q?0HVUDzIrYBUX4hXdDADDuWhvk8UaqpmWp9JsTpWvc2V8FRIO/4M4kHnBmAda?=
 =?us-ascii?Q?2Ea42MJUR+9A0ShlrumdGFLTNuagxQxl0BoRfW5B9Fkh8kTbUM5CA0C9VhC6?=
 =?us-ascii?Q?LWKpfb5kxKj6Z+QdfHyGJ/Kq7gutlBuPNwKFfilU39vAAFVRY7M2R747k4V5?=
 =?us-ascii?Q?Q9ff61UblYD+1Br4b6euOC6r/qNyjYYPBxpzPlVnALniR5GIFgp0td8zGGI1?=
 =?us-ascii?Q?gPffc1RxivYYEAd4j4rv5AXhZwBikCSYVTAVNC2y0vDioFHAxiWepC7Qg38U?=
 =?us-ascii?Q?Q5iyLpR2Y6SXc1e/6MoUWlS6Av7Dy5NN7XjAkY/TO7DKzoyhh3byKf9KW5ph?=
 =?us-ascii?Q?Xnw0O9ojkM5wkwG5eaVT6br6jmfA53qOdyuzz328sqhklUKCtzNUjrm6Xpyr?=
 =?us-ascii?Q?ed0mD8mSrBIPHPdSpg3sa/ZqWhy3CqkmQ6Bn+7TWiiI3i6hGUioBm/rsy3jX?=
 =?us-ascii?Q?D7BUoJ8ABYNqWjtaLCCzDd4zX/lpc5iBPTdihBU8cvSjRd6GqSPpWO3rfJlW?=
 =?us-ascii?Q?ApRgIMJ45ot8+VtTHAvlCixRSwULNI82S5TG/ljDOyxLr4BVFtFHI8HMkGM3?=
 =?us-ascii?Q?MA712KCkWW8w7THl5Y1ouOyQKAfrDiAwo0ppnX4w3E5TXghuhbC/36i7fotu?=
 =?us-ascii?Q?9foBcj+G7lQ0+5PA4/3top6vItrgftWbuhMzd0lneX3Ry9+QFoULH80j+R9Q?=
 =?us-ascii?Q?etmg9Ur8UbiSeAGfzRn0NjxoeTMo2/fCTlUY9/1nfjrASjRlDG03Cp51UOMs?=
 =?us-ascii?Q?DU9jkiuddw80rfrjdRdKilEA1GmADN9ZAim/0yetyAZ+7KyXfF0Z9T8GxP8C?=
 =?us-ascii?Q?2tqQ1/M6nsvRCabXslR9lHIJIzPZKb6eOVL6XjautVeMp4rRroiOeOBQPH4c?=
 =?us-ascii?Q?CtUp9PcjxXA17LKCwYfoqANjIYQafLZpAfshxWmVUhAD1jQrqUOwoXYr23AQ?=
 =?us-ascii?Q?wig4JGzoth3DO7epQw7NJJWaQtaAjRgMLPGwDWISTOihJYf9zlHjd4lEjys?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 1cfb323a-b17e-4e18-1d38-08ddbb779387
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jul 2025 03:54:00.6470
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR02MB8579

From: Nam Cao <namcao@linutronix.de> Sent: Thursday, July 3, 2025 2:21 PM
>=20
> Export irq_domain_free_irqs_top(), making it usable for drivers compiled =
as
> modules.
>=20
> Signed-off-by: Nam Cao <namcao@linutronix.de>
> ---
>  kernel/irq/irqdomain.c | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/kernel/irq/irqdomain.c b/kernel/irq/irqdomain.c
> index c8b6de09047b..46919e6c9c45 100644
> --- a/kernel/irq/irqdomain.c
> +++ b/kernel/irq/irqdomain.c
> @@ -1561,6 +1561,7 @@ void irq_domain_free_irqs_top(struct irq_domain *do=
main, unsigned int virq,
>  	}
>  	irq_domain_free_irqs_common(domain, virq, nr_irqs);
>  }
> +EXPORT_SYMBOL_GPL(irq_domain_free_irqs_top);
>=20
>  static void irq_domain_free_irqs_hierarchy(struct irq_domain *domain,
>  					   unsigned int irq_base,
> --
> 2.39.5

Reviewed-by: Michael Kelley <mhklinux@outlook.com>


