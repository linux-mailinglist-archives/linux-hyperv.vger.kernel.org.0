Return-Path: <linux-hyperv+bounces-5563-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A94BABCC54
	for <lists+linux-hyperv@lfdr.de>; Tue, 20 May 2025 03:34:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 02EA13AD40E
	for <lists+linux-hyperv@lfdr.de>; Tue, 20 May 2025 01:33:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AAE4253F31;
	Tue, 20 May 2025 01:34:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="SztRjr29"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazolkn19012040.outbound.protection.outlook.com [52.103.7.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86F5BAD4B;
	Tue, 20 May 2025 01:34:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.7.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747704843; cv=fail; b=X67xh2pKfuRDphDxHlyHaXpaPJQqo5IEa6gvvgNa8EdCs/Iz34wYdafGEKteHzh8Fu9u1ga4s012YHl+D3kOvTnlv1/l7EqmmaugaIgCpYNvCaMuTIntWtZ+CINz+GKJwlb3sw1Jj3+UUmZfaQJFiKHzh1sWSjiVch1FmPEWuho=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747704843; c=relaxed/simple;
	bh=uCUPf9xyPT07/aXygID8jHvIKfB3OuFfCw7TI1/eI38=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=C8b+2bTlc8ezDRL1f99cp4hYoPgkPSFXTbgfD+a6mm2c1k9r16ez0kt4WxtvF01UJ1pBSE4+FtWo4kVic8F4/kYvX3cg/rMEcrwxPiHcph2rWIJ/gdtlBNrbeXvSBNfSvcXDirh0V66k1t5uxuRFqz0+goCVXwVuGitpUYt5aEQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=SztRjr29; arc=fail smtp.client-ip=52.103.7.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=I3iv810AFAKjy3n2U9d2IqHoktQL+SkRcF1e2wuy/FHaEHoUwDcgpQprgVOPi6o/7AYcNQxHazoCn5yCtQ+D3c1JfMskD7yBiOUKiJMB9I+U+MJI0LjySlZa+P79vdl0Uw7vADxd5GbfB+xOWgZYcYQOWp0/vAeRaz6r4DfplLXXlhi+tBeX/ws+AUmHNo3M1NfwlWjz68dHSqXkc0H5aAhsthnq2qJ1I9TKoIRtlBPsQ+2ygCYldlzcsBSzC2fMPJw225AzP58RkdFgxPWl1MWOT/5ZUmUcoEULzUAu+wUAj/8mtOBUsy/lcl0gc9c3OT+GiM7oiNcqKUCHt7v9AA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YmS/9OUtezbRu5qzAZ/LcB5xuZuEKsFvuh6lsvC7YWc=;
 b=HL++r3ediAp/hc/1jaGK1oo79aZN2/AyUuegujFc1b0XYOX5NRb7RS9ENoQUlAifNaENCenRK3dINjbmTnd23Wt2uQCsLT9Nht+OxqtnElFuBdO5dKvRXZ60VdAeb/OwqtvZDMAsa6ysyEiDC4UNaO3fjK5xnkTA6ajeEXU/D2FRMEK88kcLhoGxJ1UdJYJyUkWN3XHf7C//xw8LMWNkD6Sgq2riCCaRKjhBBcZCwAHQ6XNSuLcBEr/3lvLyAeyWBl+abondcISZ6ZalDdm+xDGQ0j+EYH45HahEGM3M8S1LtcSYStgCsXYWuZv1SyMHn4RUHJUlpc+qtN3BHAaPxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YmS/9OUtezbRu5qzAZ/LcB5xuZuEKsFvuh6lsvC7YWc=;
 b=SztRjr29sRwxF06VPEjflViSKaoCuIISfvhlBFFu1X1Paa2YQz83bCsQPApEw0V92AT0SM+QuWakqkxQjkw7FB+SifDBmN/9asl7r7unt+KZZR6USYdY1OknWg8u+2hE1Y0PaogRncGw+51M7G+K140a9zBVl/mmefL39xjiNvhyq8/dXkKw72mKZWo+qEQz/8PKUzQh1KvDGPEDw8VTJtF/Br4EACqR0vMmj4VQePGveV7UjgfXx1ukgvxoEw8guWa5V6XzXiYTz8717I7HevHPDz2nei0mg/3Gmd1HyD4A0pzJTNtjac98/VJ5Axi+3Qw1jdnxrD0jiD7aJ2U3Cg==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by BY5PR02MB7044.namprd02.prod.outlook.com (2603:10b6:a03:232::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.16; Tue, 20 May
 2025 01:33:58 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df%3]) with mapi id 15.20.8722.027; Tue, 20 May 2025
 01:33:58 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>, "x86@kernel.org"
	<x86@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
	<conor+dt@kernel.org>, Rob Herring <robh@kernel.org>, "K. Y. Srinivasan"
	<kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu
	<wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>
CC: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Saurabh Sengar
	<ssengar@linux.microsoft.com>, Chris Oo <cho@microsoft.com>,
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>, "Kirill A.
 Shutemov" <kirill.shutemov@linux.intel.com>, "linux-acpi@vger.kernel.org"
	<linux-acpi@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
	Ricardo Neri <ricardo.neri@intel.com>
Subject: RE: [PATCH v3 12/13] x86/hyperv/vtl: Mark the wakeup mailbox page as
 private
Thread-Topic: [PATCH v3 12/13] x86/hyperv/vtl: Mark the wakeup mailbox page as
 private
Thread-Index: AQHbvF8D+XvM94WOtk2/+Ku78EZ3zrPa1Xdw
Date: Tue, 20 May 2025 01:33:58 +0000
Message-ID:
 <SN6PR02MB4157721C6C8CE7425534A869D49FA@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <20250503191515.24041-1-ricardo.neri-calderon@linux.intel.com>
 <20250503191515.24041-13-ricardo.neri-calderon@linux.intel.com>
In-Reply-To: <20250503191515.24041-13-ricardo.neri-calderon@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|BY5PR02MB7044:EE_
x-ms-office365-filtering-correlation-id: 44f6d882-aeea-482b-9134-08dd973e6452
x-ms-exchange-slblob-mailprops:
 Vs63Iqe4sQlVobdhjoRt/HQUSkoYJhJh8Kgow2v1Hrit5393buZXmG7cUiBYwaszg/DrUTWt6ssGqaATQeOwJ+1fG9C6aA5uyrpKMFudHDr7J5lG3FLpva9PZ5lP3FFQxt5PGMC1QKrh+DKTUVIMj0slA95xGnkVlqv3l1HcoyMAj61vTQC/y59OtHXk9Ya+0tAxmX9PM37K51q/kG217RfIIdVnPw29+GvJFFcVfa3wWkx006mB4ToMELPaOwyNzH/jIyfZM6KOWo9sWcua1JAv94LmDmiM2m8sV9MYPpMvf0UsBQYoiCq1jXn+eJ2SPjlW1h7mO/iIw90s5oYMdd0VRCc1kLJl6JIn0P7HlzjpP4qkFeWB0qINWXVLSsKGYBVfZny+LWgwPJSXUwGBMNg2mnCCS/iXc8ZwlxVAV4BA/VUEJT5Sen5b626J68PfnE60K39HmqXdDhJnqVM+xIW7+C+3/Z3Tf80a7qL8bKM02OlTTcn9ij204VdCvBwY719Nm99N7ob3XKWcgI1wP4mQAhbl9OxwYGMJLogqcWmr+NX0n+GBDcdmP9oa1y3Ah7o/KLJxezApiXJOecyl+w2aOA8uYAr4UAjwNVH6ZIhqRjOmOLEt8keBNcMbnOuAcOtZVMSSAK/AmgFtr7hXQjmRCAyiTTpFXI0v12DBCtq96gMpHy0Y4w7dRZS82eijSKxqpjTa9iAdf0hHVFF214rvL8eeaUlGDZ2BKRcAKA8=
x-microsoft-antispam:
 BCL:0;ARA:14566002|41001999006|8060799009|461199028|19110799006|15080799009|8062599006|102099032|3412199025|440099028;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?90cnBay703vZB7zQiSwcnOH+/XaJ0MWWw2Y1JL37t5GOFLRd/s6nMQVANXRS?=
 =?us-ascii?Q?s5oIJsYIle4gEaBnXswjOSPA/s8Cm5Soc6u0/QSare1dUY0mKaO2IVPqNjbD?=
 =?us-ascii?Q?0vKiciQBXxCH/X3QILYGfI1xDZani+wvTu3cQEfTrZC1pzHodoV2Fi51UCHQ?=
 =?us-ascii?Q?RQrPPfoqrji2paI+ta4qdKAOukiSScBy9bOhIYnsEWaDoK67yFU9WYpKE8S1?=
 =?us-ascii?Q?EL5tsia+ZyxNVqSHZroykAlBDDNLIlB37Bpw3R+zclqw8wH+jitGo+o+8aBc?=
 =?us-ascii?Q?Te/+FI7wX7eAaOpS6i3G+PXQDeknG5TJwtcPdkZudjU3tM2jkg/4oNUvITmW?=
 =?us-ascii?Q?RmsohcZCOBI1N+cjcwDoAzVclDlwGk9qaBH+D7XmpFN1HYT3gNJ1mR133vJ1?=
 =?us-ascii?Q?xNeJde2szFlWiQqO++hX78Nnv5ASRrWHsHx547zxtxQerVe2XBthAZwfLtmV?=
 =?us-ascii?Q?ubf9z7XS2mCm7vFA+6ZSnlWNRUGYw+b5I/jFnicAet2GD1KTCvS3wIX60016?=
 =?us-ascii?Q?RnWC2DZ4SXYBc3h2lHnE0yTOWyuDWOPWrMn8xdu8OYMTNNL1hiW1ro65uFxb?=
 =?us-ascii?Q?u7yrcbFg4lkihgvTisHel7+0luypve8MkBK8bufPBCC5VOlk+Knqr7bO7yKN?=
 =?us-ascii?Q?+6ZxhJf9Q/eJfF+6Y7aLPljRYLRWHaMybjtL9K6NgF+4Ppzm7Z+o6RXOq9MY?=
 =?us-ascii?Q?RVIzbN6mdgVNh7kjv6ZdRaHyNSXAoZ9am85wYlvrT9G2tWJX0iZPpJeCZzVv?=
 =?us-ascii?Q?H4zEAnBpM59O7EI7vkc29fucyI+PU+BaG0zEMHmtycKskksByJg0bvjft3r9?=
 =?us-ascii?Q?zirUgziebNoupXyoxovkrAjLXVGGDJTaSv8eyzW8qwoszreRJ2IUlYwtc2w3?=
 =?us-ascii?Q?LpxlQgz+JdOS4+6mxHb631y5YptBTj2wwbjFu2/3mBeHj/7ZGLyqZVfRzXAi?=
 =?us-ascii?Q?Ad+mN3EEC/WPtC6yoniCxgMWwu6ZVwbuVEJq8vAK2TlSrVlAYi/Ja8Usn6p/?=
 =?us-ascii?Q?Jc3q7psjR1A2COMS9BnxunLqD5JNO3muqGxCmdlKnXi4Urc6JOsB5oAV0wQ8?=
 =?us-ascii?Q?7G05oqFhpDksQqXKLOOIZyfbBl+YfOuQmJgQy+OIk7AOofqg1h4=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?ghw9nRidfp1zFCZpQuOUoN9UeMsMev64KvrNomwu99Rtla+T+o88Cda6CppD?=
 =?us-ascii?Q?OBAPzD8904pMB8R3IE555zacQDSSWjoSuZFBgFFd3qMgg5K+mOhjCEOHKcL1?=
 =?us-ascii?Q?HJ7GKdjYNuqbJ8DhPY0zwNva8IsGcXa+/JwEC7+QsUPPj5+yMoIMg2sT6+1y?=
 =?us-ascii?Q?i/ylX0lGRpBQYSABrfj3wn4NxiIxnjQK6vo6cVhXoI4m8rFdmQqVYDGJO5pw?=
 =?us-ascii?Q?5Fbg7+ZwV6YS4UZCpr7bvIxeS3YcrvDrOL276pV6sK579AYIEFQTaYAwiWHl?=
 =?us-ascii?Q?pnhRQZ9LSw7/Ufnj3fzY70equsg2TDDT7xEFxk5aWTaTyBlvT+Wd95oVCzct?=
 =?us-ascii?Q?UyfHNSTmkM3xVNkI0GlUlRz+jrF5aQNzxdZc1LHsdE1sO+KX2wHdTQQg9iMq?=
 =?us-ascii?Q?un3K0wJG9LxT92W7L9IvaPeQ+5i+cVX2i4MJL6z8W+2v+0EPQ4RCBxivwruq?=
 =?us-ascii?Q?vvOtcvysVAnCFAwbznemThhDdeqMcaXJJKZvlOzU6rfjo43LkRMZH+46jV9U?=
 =?us-ascii?Q?9HMPJOywjGIMTrpXLGjxdCYWVS/9qbw5FncAca75c6+AoI5RziN/r7k7Fg7k?=
 =?us-ascii?Q?Jo9H2aN9HQk4z8EjQrzCGhvQmInJlQv/mVurFbuFwLQbmoyOIML63Hzyo5Q7?=
 =?us-ascii?Q?PM0onCEJiAUCdJmebzcgHJ5GfC+X2ht0v8kryQHbMAhtwRvKUohJM4yyiDLK?=
 =?us-ascii?Q?HjPhV3oOQVWOEf6I4DaC+i6DhYf9yD7QpH15xcLo3bPpSt3QuFsHNTeLenGH?=
 =?us-ascii?Q?e6iGiG78n9RQSrp0mYXwMKNr//idhnDEA8eEuq3IL0M+nGGWFAt5il2/hA2l?=
 =?us-ascii?Q?RO25hReq64c1wVFSh698wJKoZWU717NGTpcHQDQ5JXtOJuuJBH4SSBOypmKI?=
 =?us-ascii?Q?7WOrS/o8JqR2Gu/h54nbCBj3ylbA4Ed3YWd5VLpZyo5HLUSKsvX1toOTVj6I?=
 =?us-ascii?Q?giYsI/ysDcPiNwjSVfwZ6z97Ek6mIIYArQyx4QQ0U188j0aHTIxtG7Z1e0wn?=
 =?us-ascii?Q?/L5AYMhbHjN0WxyNxPyZEOM124zcX8BDAkXAlc77HmszhTdI0aBMoMx8aELh?=
 =?us-ascii?Q?fC9uZe+bqrfKsvEpSoqu4em6fzHZEbRhXTiTGdkiQhHl57azDVbNS32EDFmz?=
 =?us-ascii?Q?m107ZP1NNMCGG6f+tG+Q6BP+avs8vnHg+3eP3O1yJE3+Pgz2/TfNYWMF9uHL?=
 =?us-ascii?Q?DiIvyQ2S1zRzeCGvmt6Q4M7/Rgsx/1DXFWLHb3E2S9jDQqt2/JyvmLDHnN4?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 44f6d882-aeea-482b-9134-08dd973e6452
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 May 2025 01:33:58.2884
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR02MB7044

From: Ricardo Neri <ricardo.neri-calderon@linux.intel.com> Sent: Saturday, =
May 3, 2025 12:15 PM
>=20
> From: Yunhong Jiang <yunhong.jiang@linux.intel.com>
>=20
> The current code maps MMIO devices as shared (decrypted) by default in a
> confidential computing VM.
>=20
> In a TDX environment, secondary CPUs are booted using the Multiprocessor
> Wakeup Structure defined in the ACPI specification. The virtual firmware
> and the operating system function in the guest context, without
> intervention from the VMM. Map the physical memory of the mailbox as
> private. Use the is_private_mmio() callback.
>=20
> Signed-off-by: Yunhong Jiang <yunhong.jiang@linux.intel.com>
> Signed-off-by: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
> ---
> Changes since v2:
>  - Use the new helper function get_mp_wakeup_mailbox_paddr().
>  - Edited the commit message for clarity.
>=20
> Changes since v1:
>  - Added the helper function within_page() to improve readability
>  - Override the is_private_mmio() callback when detecting a TDX
>    environment. The address of the mailbox is checked in
>    hv_is_private_mmio_tdx().
> ---
>  arch/x86/hyperv/hv_vtl.c | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
>=20
> diff --git a/arch/x86/hyperv/hv_vtl.c b/arch/x86/hyperv/hv_vtl.c
> index 8b497c8292d3..cd48bedd21f0 100644
> --- a/arch/x86/hyperv/hv_vtl.c
> +++ b/arch/x86/hyperv/hv_vtl.c
> @@ -54,6 +54,18 @@ static void  __noreturn hv_vtl_restart(char __maybe_un=
used *cmd)
>  	hv_vtl_emergency_restart();
>  }
>=20
> +static inline bool within_page(u64 addr, u64 start)
> +{
> +	return addr >=3D start && addr < (start + PAGE_SIZE);
> +}
> +
> +static bool hv_vtl_is_private_mmio_tdx(u64 addr)
> +{
> +	u64 mb_addr =3D get_mp_wakeup_mailbox_paddr();
> +
> +	return mb_addr && within_page(addr, mb_addr);
> +}
> +
>  void __init hv_vtl_init_platform(void)
>  {
>  	pr_info("Linux runs in Hyper-V Virtual Trust Level\n");
> @@ -61,6 +73,8 @@ void __init hv_vtl_init_platform(void)
>  	/* There is no paravisor present if we are here. */
>  	if (hv_isolation_type_tdx()) {
>  		x86_init.resources.realmode_limit =3D SZ_4G;
> +		x86_platform.hyper.is_private_mmio =3D hv_vtl_is_private_mmio_tdx;
> +
>  	} else {
>  		x86_platform.realmode_reserve =3D x86_init_noop;
>  		x86_platform.realmode_init =3D x86_init_noop;
> --
> 2.43.0

Reviewed-by: Michael Kelley <mhklinux@outlook.com>


