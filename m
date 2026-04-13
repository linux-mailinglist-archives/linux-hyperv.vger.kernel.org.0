Return-Path: <linux-hyperv+bounces-10141-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OOXPMGFc3WmadAkAu9opvQ
	(envelope-from <linux-hyperv+bounces-10141-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Mon, 13 Apr 2026 23:13:05 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 072113F371C
	for <lists+linux-hyperv@lfdr.de>; Mon, 13 Apr 2026 23:13:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0F55C3070894
	for <lists+linux-hyperv@lfdr.de>; Mon, 13 Apr 2026 21:08:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C946392822;
	Mon, 13 Apr 2026 21:08:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="j8uAo3z2"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazolkn19010023.outbound.protection.outlook.com [52.103.7.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0224E36921C;
	Mon, 13 Apr 2026 21:08:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.7.23
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776114501; cv=fail; b=cUsnzPSzkfMS7xVVAfqtbVrB6CpHU+O5YSkJY5rCPrO4VM9gIjSOM9IXD47alWxC+6oZ32ecMncc0qz4VUFNgKS9zaU+OjPLNR89u+gOcFlPsxSoSVzGyLe1KExwy3B7HtVhXqVo4NQEA3DiZo0JjVYZA2t9hnXw0cgPYhfndEw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776114501; c=relaxed/simple;
	bh=2S7y2Nnzbu7rb6YnDKD7Ar3AdT3c0kjM/DDh52XjqzA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=LaqTxyyHmhjbvl8gQ6wvzEY1zb9sYyV26pBfAW0WJuOcbcxPdpy2B1oThKc1qnx6cT3nuAfH878JMrLpsG4T5Wj9rj/OaS9KVZXlcfQrT/x5xGM8r1oL0E8clr65aVd8gskOQWYJox/k1LNJuXpPJoJwCl5nBrJhC4jJtLLduWo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=j8uAo3z2; arc=fail smtp.client-ip=52.103.7.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PlEQW7c5bDuJTLJzxrzXxmcJ1ZK5mkjk1LP/CfHgfplg035LBP0dOdQbdAzb3N2ROIhFq+1ryqN56Qj+za0L7JEVtFklZjnpH60JvC3k2XoA4TpbYkWXXXHpNP+Nqa/LFAP7tdTx55sulqe1Fo8Ga78ZXZgFnqEeHasxBfW4yta/l6JQYvVX29ZMJNh1MdSTKptxG3C5IH+dWkp6HrAHH24IyAITQhUF1Zfm9K0MBbqDs1N8D+c5sRKbJclY1M2G2NheFUjDRxO0xVZ1kQ1Si+RxrDMeVWgj/YsdJb/PBaJ2Ur/bnytdotHMHSDPseBKpsB1YdMSXDaW7S+WB1glEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ivMVC2WGsv75bd3ELf6b8EYWoFbvYgdX3XCOaxMy8D0=;
 b=LenoLar9w78LOzjr8yNgpMz+JgmI1qddJbGDMcPPdzkGmwm056GFSZ405tmJ2JQiFeQAS32CpbCs+G4EYV0Lw2P4xW4+TIxxjfAj7Ie6yZaGZ6I6VXDwJkCgEJqygk/RxG2QQ6LroNd8RK0pmV4pcL5UTgnL/NkSh2Yu84mQVuyHstqihV7de1ZABrIFOAWnQIx0xd09LtCcISWUM+TnweJVgdisIO3OAf3WqVQl5yYnd51NfHC826lSMZljdC6cPnPLwbkLlHgA/afmiS5AiHFI3YlSBqf00hF1QiTV9TE5MBcTPYHw05PFjNVrAn+ejJBcRHPGisWTd8pSZHU+rA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ivMVC2WGsv75bd3ELf6b8EYWoFbvYgdX3XCOaxMy8D0=;
 b=j8uAo3z2JY4X/80r2HCUc5bwW39zeLtn2PP1UT44q1LSAzYIXcUlIF6xmuM7LYHBJvT8iExa9k0uBmr+luk4H0MvIOQwN2hZ5AUYluFtIdCvy6qmgMBWuzbFRcB5KqxMLRNk5H3B+D+0dtw0M8twJzPNwecIRk77hna+AykQ7nZy9dLSDUEL9Q92KQMI9jgxp5zXNePGkvISI9I66fm8S6E8tnWDw69jnTP89MguoRSm/RqgEhRsZSBHJjML8jJbjoLKDou4faRXBvKZ8vkGUX5AtiKxXsCSLoyKgDZiePWrV4V1ELT+7c8xiY1/UyAP6eUoTKD4rkuRi35p5rN6mg==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by CH0PR02MB8057.namprd02.prod.outlook.com (2603:10b6:610:106::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.48; Mon, 13 Apr
 2026 21:08:16 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::900:1ccf:2b1e:52b6]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::900:1ccf:2b1e:52b6%6]) with mapi id 15.20.9769.046; Mon, 13 Apr 2026
 21:08:16 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>,
	"kys@microsoft.com" <kys@microsoft.com>, "haiyangz@microsoft.com"
	<haiyangz@microsoft.com>, "wei.liu@kernel.org" <wei.liu@kernel.org>,
	"decui@microsoft.com" <decui@microsoft.com>, "longli@microsoft.com"
	<longli@microsoft.com>
CC: "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 1/7] mshv: Convert from page pointers to PFNs
Thread-Topic: [PATCH 1/7] mshv: Convert from page pointers to PFNs
Thread-Index: AQIU4Z+TtrNiAr8jNsFOwdDCIL2bZAEyNeRRtWAzUaA=
Date: Mon, 13 Apr 2026 21:08:16 +0000
Message-ID:
 <SN6PR02MB4157CD26728B2D4BFD171DB7D4242@SN6PR02MB4157.namprd02.prod.outlook.com>
References:
 <177490099488.81669.3758562641675983608.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
 <177490105758.81669.969284388846280218.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
In-Reply-To:
 <177490105758.81669.969284388846280218.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|CH0PR02MB8057:EE_
x-ms-office365-filtering-correlation-id: ca92c9c8-bb2f-4307-f1c7-08de99a0c801
x-microsoft-antispam:
 BCL:0;ARA:14566002|461199028|13091999003|12121999013|31061999003|8060799015|8062599012|15080799012|41001999006|51005399006|19110799012|37011999003|440099028|3412199025|12091999003|26121999003|102099032|40105399003;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?ezxDVNXXWbEd9sSgJNJxXvMwNhI4g5554K+H886lxjY6Eoj9m3AkaH0rbhEM?=
 =?us-ascii?Q?5uLuiQueTBuaOuEZ/B83MfQJ0C0jTycZOdjZZ1S1et21jKYfP1vvyAJv11vk?=
 =?us-ascii?Q?qK90qkug1hVT4TQkb1PjePBQkPpOgwB2t5reyS3G/pFwjJ4E1uGeC8+r+jLH?=
 =?us-ascii?Q?DJdwT5eIbvaFhDVt0GRvnJB84zk8Qv0+/Ic+wN0lTTfmCTWUJ17dvvKNjKQt?=
 =?us-ascii?Q?Fp8PWeSF1lbmqhORU2LJx3vFsUlFDLUJ7kvch0gX0nnH7kU3cck+/RKJUELX?=
 =?us-ascii?Q?M+lQSknzBfOefOCYf+2TSiQK/QiNny5YYOgaNorjj/yjvNJ+caFbZ8RN8mP6?=
 =?us-ascii?Q?nZdZP6kuGUlyvtkw0Jr7RMdgNc1+4SrUxb7TVUaQVawQ3nKE2nghFm3Ulakd?=
 =?us-ascii?Q?2K8iDH2hYERNvsoxnvIAV6L3Ak9Svc9Z4c4huT31JadBwADQ691mcfOvkK6F?=
 =?us-ascii?Q?kxk1REWI5vcYvLwr4EARD3o9pynfCNub+JHD7AS/PP7YmHM4Rgp4UddiPy1g?=
 =?us-ascii?Q?BgQpsBVtZ3Mi4gyxBR4AkLZfRmXQbaS4xAH7+BQLx4QDtlb7jL+mIv29fOD7?=
 =?us-ascii?Q?aU/dhROPxURAVYDt+Fl/V5hVK3OCDP8MFDoKfOfxLj8AaZZkwcVSpA2o0W0p?=
 =?us-ascii?Q?0PNXiElj2Q1FUBDRz/A2i/abZzeK6DC76XOWixswnZtbx+sSW0a9lojfh3XQ?=
 =?us-ascii?Q?lFz69F1KZluzsZa4LhZR684aUXXoFtVCuY3VX6UROjHIzl+ADX7UE1mG2qrH?=
 =?us-ascii?Q?OOq3RVbUx3WN7YyD1HD6zcf+xEmNqVn+UDU7EF6X9NaQBMlHrZLfvWhm3puF?=
 =?us-ascii?Q?L+8E7Swq50+TN36TYl9wLyA+Czx+wfX9mJ9F19EhzcOkziqWOK0u5QN0+HF/?=
 =?us-ascii?Q?U/MxTkWfVrAVOkPkOIsqBxwFNtk7SHxIIq0qq5EaAdmGbAgolnxUzYhAcIkw?=
 =?us-ascii?Q?uKnsjtVWptXInefXMTkNblK6lm0VQv+PXuwuF2zkEhRi1diS+/9L2TO8PyeA?=
 =?us-ascii?Q?/DeCT1rHoEaV11VrThj7jcmTiH2AamEZqt0b5nxOGq81yfipWE6zPh62u2h8?=
 =?us-ascii?Q?RV7/VaYGgLQsRtU19fMNlnFKHWYHQgLdc0n1ip2F+9zSmy+YiWs=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?YuhU3Atrj4PJDFVjHe58RZ32QBxzIagVqNeEMNalXBX5omDhHr+Z+2zvenUh?=
 =?us-ascii?Q?Q6qD35xncyBLFoTgFD9i5G2DJ+PhZc2nL6ZMOh26gyiVuPa+s6CFZDJewSlY?=
 =?us-ascii?Q?nadg3wteGb1cYsEh7vIQiV/Ujl/wxsloUi7RBvVGP9EarzJ6EtaosyKp5iVg?=
 =?us-ascii?Q?aT0cFjlp23YSDB0UTUW8XRII7zG3gLX9Md+umIOp+WRvrIsMscifwInOovxi?=
 =?us-ascii?Q?OySiQG0EKa99EPojNWQbiztzU3e3qkCMqCFrZvAzXsC6+xwPgZKoL8IbmJpN?=
 =?us-ascii?Q?C9ccpQpwuxzs7BfJYRQTSDf79MzrnNET96a7zJ8bNOjiILX5Xe3GKyVB0LJX?=
 =?us-ascii?Q?uszZ6vMZLkp5LR694j/5PCNqtH0MqDd58IEib693wlK+yrxYUpqlZRzzItt2?=
 =?us-ascii?Q?HfxZ1BbXqw4dwJpy3K4GWR1bjU1P05qcDmfDW8sUdZy6Cqw2bhuvJoUt4UBg?=
 =?us-ascii?Q?g7nhEDU+qqwyIFM8XYX5kgWLR8kRlG7hK/vJE2h3G4572iqQYtDt/2f1py6O?=
 =?us-ascii?Q?rpnfubpcLhfjjDtAJcH9hntfTeqj3+ep77dPFsStpEyfO/YMz3Qmccc/qtOp?=
 =?us-ascii?Q?Uv2IkMejidSkHEN/4bLBvHh5KRZ/YWRbf8UfodLob0V3f2YY/T4oMoUeNv5l?=
 =?us-ascii?Q?QFMFcHdqTAaQ8dx9E0yqUUQ2S651Ajp+184fBsxTguAsWdEJ/0pQwNoqR6PH?=
 =?us-ascii?Q?jk9ArCZvv25XpuBH3C0hrzX4DDBR8WDvpe4x3u5O/NasRj8ZNkJh2CtZYQkl?=
 =?us-ascii?Q?m7U3e+tqq8mZcJ8whF8W/QlhCjtIbTxrL99PLp/rHRqbWHu49UikeCAppq4J?=
 =?us-ascii?Q?rif9BJdV4RR2SNr4fi5tSFHodWIZyDyDd4vRlDidCqs3uPQFJ3vKevsDmSgn?=
 =?us-ascii?Q?4SBvHqgYsBwsRTC3DSo7UCdu8blipQe1rTDvFoF1xCQA2biRLa4ZhVRleT/0?=
 =?us-ascii?Q?+uZgq8RKRN6kUmMRHmASe9CH5j9pBMD6xFtGjiHw6qVVbrhddG3PC6zQQ6TY?=
 =?us-ascii?Q?4W3pWIEu9kc/Ul8xm3bafiu3/EDWZokzC58wck1w3mfsx1ilgzucuqjgsFiq?=
 =?us-ascii?Q?r9gMN3n8THYXuiyHoUMlDGVyikDPAZ76zurjjl8yTMzJLKn7gcai9Safwk+N?=
 =?us-ascii?Q?ERsW0z51Z/jgaoPGTkgBiEBqOZurK/I+zvz5WVfSOq7eWqxYjCrhVolIEBBs?=
 =?us-ascii?Q?TdHTYb1h62bIcAeyU1J6dCD99b//F7b02gUsU/IEeRuXnsX9V2Wmwfv+75R/?=
 =?us-ascii?Q?ixoejB0nUHrhz/CbYgvBa3f0fXFND7JGJvMke07LdQvPoZhkPEUhk5IPZ05n?=
 =?us-ascii?Q?qsnKijUsWmcOCZ8equK+5pOv/ywxacfKBIwZBPiijJFOz3xVOEmReZuUxCH4?=
 =?us-ascii?Q?//WLQjI=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: ca92c9c8-bb2f-4307-f1c7-08de99a0c801
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Apr 2026 21:08:16.2440
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR02MB8057
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[outlook.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[outlook.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-10141-lists,linux-hyperv=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_FROM(0.00)[outlook.com];
	DKIM_TRACE(0.00)[outlook.com:+];
	MISSING_XM_UA(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mhklinux@outlook.com,linux-hyperv@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[linux-hyperv];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,SN6PR02MB4157.namprd02.prod.outlook.com:mid,outlook.com:dkim]
X-Rspamd-Queue-Id: 072113F371C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com> Sent: Monday=
, March 30, 2026 1:04 PM
>=20
> The HMM interface returns PFNs from hmm_range_fault(), and the
> hypervisor hypercalls operate on PFNs. Storing page pointers in
> between these interfaces requires unnecessary conversions and
> temporary allocations.
>=20
> Store PFNs directly in memory regions to match the natural data flow.
> This eliminates the temporary PFN array allocation in the HMM fault
> path and reduces page_to_pfn() conversions throughout the driver.
> Convert to page structs via pfn_to_page() only when operations like
> unpin_user_page() require them.

General comment for this series:  PFN fields are typed as "unsigned long".
But pfn_offset and pfn_count are "u64".  GFNs are also "u64".  Any
reason not to make PFNs also "u64"? I know that pfn_valid() takes
an "unsigned long" input, but see comment below about pfn_valid().

>=20
> Signed-off-by: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
> ---
>  drivers/hv/mshv_regions.c      |  297 ++++++++++++++++++++++------------=
------
>  drivers/hv/mshv_root.h         |   20 +--
>  drivers/hv/mshv_root_hv_call.c |   50 +++----
>  drivers/hv/mshv_root_main.c    |   30 ++--
>  4 files changed, 212 insertions(+), 185 deletions(-)
>=20
> diff --git a/drivers/hv/mshv_regions.c b/drivers/hv/mshv_regions.c
> index fdffd4f002f6..b1a707d16c07 100644
> --- a/drivers/hv/mshv_regions.c
> +++ b/drivers/hv/mshv_regions.c
> @@ -18,12 +18,13 @@
>  #include "mshv_root.h"
>=20
>  #define MSHV_MAP_FAULT_IN_PAGES				PTRS_PER_PMD
> +#define MSHV_INVALID_PFN				ULONG_MAX
>=20
>  /**
>   * mshv_chunk_stride - Compute stride for mapping guest memory
>   * @page      : The page to check for huge page backing
>   * @gfn       : Guest frame number for the mapping
> - * @page_count: Total number of pages in the mapping
> + * @pfn_count: Total number of pages in the mapping

Nit: The colons are misaligned after this change.

>   *
>   * Determines the appropriate stride (in pages) for mapping guest memory=
.
>   * Uses huge page stride if the backing page is huge and the guest mappi=
ng
> @@ -32,18 +33,18 @@
>   * Return: Stride in pages, or -EINVAL if page order is unsupported.
>   */
>  static int mshv_chunk_stride(struct page *page,
> -			     u64 gfn, u64 page_count)
> +			     u64 gfn, u64 pfn_count)
>  {
>  	unsigned int page_order;
>=20
>  	/*
>  	 * Use single page stride by default. For huge page stride, the
>  	 * page must be compound and point to the head of the compound
> -	 * page, and both gfn and page_count must be huge-page aligned.
> +	 * page, and both gfn and pfn_count must be huge-page aligned.
>  	 */
>  	if (!PageCompound(page) || !PageHead(page) ||
>  	    !IS_ALIGNED(gfn, PTRS_PER_PMD) ||
> -	    !IS_ALIGNED(page_count, PTRS_PER_PMD))
> +	    !IS_ALIGNED(pfn_count, PTRS_PER_PMD))
>  		return 1;
>=20
>  	page_order =3D folio_order(page_folio(page));
> @@ -57,60 +58,61 @@ static int mshv_chunk_stride(struct page *page,
>  /**
>   * mshv_region_process_chunk - Processes a contiguous chunk of memory pa=
ges
>   *                             in a region.
> - * @region     : Pointer to the memory region structure.
> - * @flags      : Flags to pass to the handler.
> - * @page_offset: Offset into the region's pages array to start processin=
g.
> - * @page_count : Number of pages to process.
> - * @handler    : Callback function to handle the chunk.
> + * @region    : Pointer to the memory region structure.
> + * @flags     : Flags to pass to the handler.
> + * @pfn_offset: Offset into the region's PFNs array to start processing.
> + * @pfn_count : Number of PFNs to process.
> + * @handler   : Callback function to handle the chunk.
>   *
> - * This function scans the region's pages starting from @page_offset,
> - * checking for contiguous present pages of the same size (normal or hug=
e).
> - * It invokes @handler for the chunk of contiguous pages found. Returns =
the
> - * number of pages handled, or a negative error code if the first page i=
s
> - * not present or the handler fails.
> + * This function scans the region's PFNs starting from @pfn_offset,
> + * checking for contiguous valid PFNs backed by pages of the same size
> + * (normal or huge). It invokes @handler for the chunk of contiguous val=
id
> + * PFNs found. Returns the number of PFNs handled, or a negative error c=
ode
> + * if the first PFN is invalid or the handler fails.
>   *
> - * Note: The @handler callback must be able to handle both normal and hu=
ge
> - * pages.
> + * Note: The @handler callback must be able to handle valid PFNs backed =
by
> + * both normal and huge pages.
>   *
>   * Return: Number of pages handled, or negative error code.
>   */
> -static long mshv_region_process_chunk(struct mshv_mem_region *region,
> -				      u32 flags,
> -				      u64 page_offset, u64 page_count,
> -				      int (*handler)(struct mshv_mem_region *region,
> -						     u32 flags,
> -						     u64 page_offset,
> -						     u64 page_count,
> -						     bool huge_page))
> +static long mshv_region_process_pfns(struct mshv_mem_region *region,
> +				     u32 flags,
> +				     u64 pfn_offset, u64 pfn_count,
> +				     int (*handler)(struct mshv_mem_region *region,
> +						    u32 flags,
> +						    u64 pfn_offset,
> +						    u64 pfn_count,
> +						    bool huge_page))
>  {
> -	u64 gfn =3D region->start_gfn + page_offset;
> +	u64 gfn =3D region->start_gfn + pfn_offset;
>  	u64 count;
> -	struct page *page;
> +	unsigned long pfn;
>  	int stride, ret;
>=20
> -	page =3D region->mreg_pages[page_offset];
> -	if (!page)
> +	pfn =3D region->mreg_pfns[pfn_offset];
> +	if (!pfn_valid(pfn))
>  		return -EINVAL;
>=20
> -	stride =3D mshv_chunk_stride(page, gfn, page_count);
> +	stride =3D mshv_chunk_stride(pfn_to_page(pfn), gfn, pfn_count);
>  	if (stride < 0)
>  		return stride;
>=20
>  	/* Start at stride since the first stride is validated */
> -	for (count =3D stride; count < page_count; count +=3D stride) {
> -		page =3D region->mreg_pages[page_offset + count];
> +	for (count =3D stride; count < pfn_count ; count +=3D stride) {
> +		pfn =3D region->mreg_pfns[pfn_offset + count];
>=20
> -		/* Break if current page is not present */
> -		if (!page)
> +		/* Break if current pfn is invalid */
> +		if (!pfn_valid(pfn))

pfn_valid() is a relatively expensive test to be doing in a loop
on what may be every single page. It does an RCU lock/unlock
and make other checks that aren't necessary here. Since
mreg_pfns[] is populated from mm calls, the only invalid PFNs
would be MSHV_INVALID_PFN that code in this module has
explicitly put there. Just testing against MSHV_INVALID_PFN
would be a lot faster here and elsewhere in this module. It's
really a "pfn set/not set" test. Defining a pfn_set() macro
here in this module that tests against MSHV_INVALID_PFN
would accomplish the same thing more efficiently.

>  			break;
>=20
>  		/* Break if stride size changes */
> -		if (stride !=3D mshv_chunk_stride(page, gfn + count,
> -						page_count - count))
> +		if (stride !=3D mshv_chunk_stride(pfn_to_page(pfn),
> +						gfn + count,
> +						pfn_count - count))
>  			break;
>  	}
>=20
> -	ret =3D handler(region, flags, page_offset, count, stride > 1);
> +	ret =3D handler(region, flags, pfn_offset, count, stride > 1);
>  	if (ret)
>  		return ret;
>=20
> @@ -118,70 +120,73 @@ static long mshv_region_process_chunk(struct mshv_m=
em_region *region,
>  }
>=20
>  /**
> - * mshv_region_process_range - Processes a range of memory pages in a
> - *                             region.
> - * @region     : Pointer to the memory region structure.
> - * @flags      : Flags to pass to the handler.
> - * @page_offset: Offset into the region's pages array to start processin=
g.
> - * @page_count : Number of pages to process.
> - * @handler    : Callback function to handle each chunk of contiguous
> - *               pages.
> + * mshv_region_process_range - Processes a range of PFNs in a region.
> + * @region    : Pointer to the memory region structure.
> + * @flags     : Flags to pass to the handler.
> + * @pfn_offset: Offset into the region's PFNs array to start processing.
> + * @pfn_count : Number of PFNs to process.
> + * @handler   : Callback function to handle each chunk of contiguous
> + *              valid PFNs.
>   *
> - * Iterates over the specified range of pages in @region, skipping
> - * non-present pages. For each contiguous chunk of present pages, invoke=
s
> - * @handler via mshv_region_process_chunk.
> + * Iterates over the specified range of PFNs in @region, skipping
> + * invalid PFNs. For each contiguous chunk of valid PFNS, invokes
> + * @handler via mshv_region_process_pfns.
>   *
> - * Note: The @handler callback must be able to handle both normal and hu=
ge
> - * pages.
> + * Note: The @handler callback must be able to handle PFNs backed by bot=
h
> + * normal and huge pages.
>   *
>   * Returns 0 on success, or a negative error code on failure.
>   */
>  static int mshv_region_process_range(struct mshv_mem_region *region,
>  				     u32 flags,
> -				     u64 page_offset, u64 page_count,
> +				     u64 pfn_offset, u64 pfn_count,
>  				     int (*handler)(struct mshv_mem_region *region,
>  						    u32 flags,
> -						    u64 page_offset,
> -						    u64 page_count,
> +						    u64 pfn_offset,
> +						    u64 pfn_count,
>  						    bool huge_page))
>  {
> +	u64 pfn_end;

In Patch 2 of this series, "pfn_end" is changed to just "end", and
the references are adjusted. Patch 2 could be a few lines smaller if it
was named "end" here and Patch 2 didn't have to change it.

>  	long ret;
>=20
> -	if (page_offset + page_count > region->nr_pages)
> +	if (check_add_overflow(pfn_offset, pfn_count, &pfn_end))
> +		return -EOVERFLOW;
> +
> +	if (pfn_end > region->nr_pfns)
>  		return -EINVAL;
>=20
> -	while (page_count) {
> +	while (pfn_count) {
>  		/* Skip non-present pages */
> -		if (!region->mreg_pages[page_offset]) {
> -			page_offset++;
> -			page_count--;
> +		if (!pfn_valid(region->mreg_pfns[pfn_offset])) {
> +			pfn_offset++;
> +			pfn_count--;
>  			continue;
>  		}
>=20
> -		ret =3D mshv_region_process_chunk(region, flags,
> -						page_offset,
> -						page_count,
> -						handler);
> +		ret =3D mshv_region_process_pfns(region, flags,
> +					       pfn_offset, pfn_count,
> +					       handler);
>  		if (ret < 0)
>  			return ret;
>=20
> -		page_offset +=3D ret;
> -		page_count -=3D ret;
> +		pfn_offset +=3D ret;
> +		pfn_count -=3D ret;
>  	}
>=20
>  	return 0;
>  }
>=20
> -struct mshv_mem_region *mshv_region_create(u64 guest_pfn, u64 nr_pages,
> +struct mshv_mem_region *mshv_region_create(u64 guest_pfn, u64 nr_pfns,
>  					   u64 uaddr, u32 flags)
>  {
>  	struct mshv_mem_region *region;
> +	u64 i;
>=20
> -	region =3D vzalloc(sizeof(*region) + sizeof(struct page *) * nr_pages);
> +	region =3D vzalloc(sizeof(*region) + sizeof(unsigned long) * nr_pfns);

Use struct_size(region, mreg_pfns, nr_pfns) instead of open coding the arit=
hmetic?

>  	if (!region)
>  		return ERR_PTR(-ENOMEM);
>=20
> -	region->nr_pages =3D nr_pages;
> +	region->nr_pfns =3D nr_pfns;
>  	region->start_gfn =3D guest_pfn;
>  	region->start_uaddr =3D uaddr;
>  	region->hv_map_flags =3D HV_MAP_GPA_READABLE | HV_MAP_GPA_ADJUSTABLE;
> @@ -190,6 +195,9 @@ struct mshv_mem_region *mshv_region_create(u64 guest_=
pfn, u64 nr_pages,
>  	if (flags & BIT(MSHV_SET_MEM_BIT_EXECUTABLE))
>  		region->hv_map_flags |=3D HV_MAP_GPA_EXECUTABLE;
>=20
> +	for (i =3D 0; i < nr_pfns; i++)
> +		region->mreg_pfns[i] =3D MSHV_INVALID_PFN;
> +
>  	kref_init(&region->mreg_refcount);
>=20
>  	return region;
> @@ -197,15 +205,15 @@ struct mshv_mem_region *mshv_region_create(u64 gues=
t_pfn, u64 nr_pages,
>=20
>  static int mshv_region_chunk_share(struct mshv_mem_region *region,
>  				   u32 flags,
> -				   u64 page_offset, u64 page_count,
> +				   u64 pfn_offset, u64 pfn_count,
>  				   bool huge_page)
>  {
>  	if (huge_page)
>  		flags |=3D HV_MODIFY_SPA_PAGE_HOST_ACCESS_LARGE_PAGE;
>=20
>  	return hv_call_modify_spa_host_access(region->partition->pt_id,
> -					      region->mreg_pages + page_offset,
> -					      page_count,
> +					      region->mreg_pfns + pfn_offset,
> +					      pfn_count,
>  					      HV_MAP_GPA_READABLE |
>  					      HV_MAP_GPA_WRITABLE,
>  					      flags, true);
> @@ -216,21 +224,21 @@ int mshv_region_share(struct mshv_mem_region *regio=
n)
>  	u32 flags =3D HV_MODIFY_SPA_PAGE_HOST_ACCESS_MAKE_SHARED;
>=20
>  	return mshv_region_process_range(region, flags,
> -					 0, region->nr_pages,
> +					 0, region->nr_pfns,
>  					 mshv_region_chunk_share);
>  }
>=20
>  static int mshv_region_chunk_unshare(struct mshv_mem_region *region,
>  				     u32 flags,
> -				     u64 page_offset, u64 page_count,
> +				     u64 pfn_offset, u64 pfn_count,
>  				     bool huge_page)
>  {
>  	if (huge_page)
>  		flags |=3D HV_MODIFY_SPA_PAGE_HOST_ACCESS_LARGE_PAGE;
>=20
>  	return hv_call_modify_spa_host_access(region->partition->pt_id,
> -					      region->mreg_pages + page_offset,
> -					      page_count, 0,
> +					      region->mreg_pfns + pfn_offset,
> +					      pfn_count, 0,
>  					      flags, false);
>  }
>=20
> @@ -239,30 +247,30 @@ int mshv_region_unshare(struct mshv_mem_region *reg=
ion)
>  	u32 flags =3D HV_MODIFY_SPA_PAGE_HOST_ACCESS_MAKE_EXCLUSIVE;
>=20
>  	return mshv_region_process_range(region, flags,
> -					 0, region->nr_pages,
> +					 0, region->nr_pfns,
>  					 mshv_region_chunk_unshare);
>  }
>=20
>  static int mshv_region_chunk_remap(struct mshv_mem_region *region,
>  				   u32 flags,
> -				   u64 page_offset, u64 page_count,
> +				   u64 pfn_offset, u64 pfn_count,
>  				   bool huge_page)
>  {
>  	if (huge_page)
>  		flags |=3D HV_MAP_GPA_LARGE_PAGE;
>=20
> -	return hv_call_map_gpa_pages(region->partition->pt_id,
> -				     region->start_gfn + page_offset,
> -				     page_count, flags,
> -				     region->mreg_pages + page_offset);
> +	return hv_call_map_ram_pfns(region->partition->pt_id,
> +				    region->start_gfn + pfn_offset,
> +				    pfn_count, flags,
> +				    region->mreg_pfns + pfn_offset);
>  }
>=20
> -static int mshv_region_remap_pages(struct mshv_mem_region *region,
> -				   u32 map_flags,
> -				   u64 page_offset, u64 page_count)
> +static int mshv_region_remap_pfns(struct mshv_mem_region *region,
> +				  u32 map_flags,
> +				  u64 pfn_offset, u64 pfn_count)
>  {
>  	return mshv_region_process_range(region, map_flags,
> -					 page_offset, page_count,
> +					 pfn_offset, pfn_count,
>  					 mshv_region_chunk_remap);
>  }
>=20
> @@ -270,38 +278,50 @@ int mshv_region_map(struct mshv_mem_region *region)
>  {
>  	u32 map_flags =3D region->hv_map_flags;
>=20
> -	return mshv_region_remap_pages(region, map_flags,
> -				       0, region->nr_pages);
> +	return mshv_region_remap_pfns(region, map_flags,
> +				      0, region->nr_pfns);
>  }
>=20
> -static void mshv_region_invalidate_pages(struct mshv_mem_region *region,
> -					 u64 page_offset, u64 page_count)
> +static void mshv_region_invalidate_pfns(struct mshv_mem_region *region,
> +					u64 pfn_offset, u64 pfn_count)
>  {
> -	if (region->mreg_type =3D=3D MSHV_REGION_TYPE_MEM_PINNED)
> -		unpin_user_pages(region->mreg_pages + page_offset, page_count);
> +	u64 i;
> +
> +	for (i =3D pfn_offset; i < pfn_offset + pfn_count; i++) {
> +		if (!pfn_valid(region->mreg_pfns[i]))
> +			continue;
> +
> +		if (region->mreg_type =3D=3D MSHV_REGION_TYPE_MEM_PINNED)
> +			unpin_user_page(pfn_to_page(region->mreg_pfns[i]));
>=20
> -	memset(region->mreg_pages + page_offset, 0,
> -	       page_count * sizeof(struct page *));
> +		region->mreg_pfns[i] =3D MSHV_INVALID_PFN;
> +	}
>  }
>=20
>  void mshv_region_invalidate(struct mshv_mem_region *region)
>  {
> -	mshv_region_invalidate_pages(region, 0, region->nr_pages);
> +	mshv_region_invalidate_pfns(region, 0, region->nr_pfns);
>  }
>=20
>  int mshv_region_pin(struct mshv_mem_region *region)
>  {
> -	u64 done_count, nr_pages;
> +	u64 done_count, nr_pfns, i;
> +	unsigned long *pfns;
>  	struct page **pages;
>  	__u64 userspace_addr;
>  	int ret;
>=20
> -	for (done_count =3D 0; done_count < region->nr_pages; done_count +=3D r=
et) {
> -		pages =3D region->mreg_pages + done_count;
> +	pages =3D kmalloc_array(MSHV_PIN_PAGES_BATCH_SIZE,
> +			      sizeof(struct page *), GFP_KERNEL);
> +	if (!pages)
> +		return -ENOMEM;
> +
> +	for (done_count =3D 0; done_count < region->nr_pfns; done_count +=3D re=
t) {
> +		pfns =3D region->mreg_pfns + done_count;
>  		userspace_addr =3D region->start_uaddr +
>  				 done_count * HV_HYP_PAGE_SIZE;
> -		nr_pages =3D min(region->nr_pages - done_count,
> -			       MSHV_PIN_PAGES_BATCH_SIZE);
> +		nr_pfns =3D min(region->nr_pfns - done_count,
> +			      MSHV_PIN_PAGES_BATCH_SIZE);
>=20
>  		/*
>  		 * Pinning assuming 4k pages works for large pages too.
> @@ -311,39 +331,44 @@ int mshv_region_pin(struct mshv_mem_region *region)
>  		 * with the FOLL_LONGTERM flag does a large temporary
>  		 * allocation of contiguous memory.
>  		 */
> -		ret =3D pin_user_pages_fast(userspace_addr, nr_pages,
> +		ret =3D pin_user_pages_fast(userspace_addr, nr_pfns,
>  					  FOLL_WRITE | FOLL_LONGTERM,
>  					  pages);
> -		if (ret !=3D nr_pages)
> +		if (ret !=3D nr_pfns)
>  			goto release_pages;
> +
> +		for (i =3D 0; i < ret; i++)
> +			pfns[i] =3D page_to_pfn(pages[i]);
>  	}
>=20
> +	kfree(pages);
>  	return 0;
>=20
>  release_pages:
>  	if (ret > 0)
>  		done_count +=3D ret;
> -	mshv_region_invalidate_pages(region, 0, done_count);
> +	mshv_region_invalidate_pfns(region, 0, done_count);
> +	kfree(pages);
>  	return ret < 0 ? ret : -ENOMEM;
>  }
>=20
>  static int mshv_region_chunk_unmap(struct mshv_mem_region *region,
>  				   u32 flags,
> -				   u64 page_offset, u64 page_count,
> +				   u64 pfn_offset, u64 pfn_count,
>  				   bool huge_page)
>  {
>  	if (huge_page)
>  		flags |=3D HV_UNMAP_GPA_LARGE_PAGE;
>=20
> -	return hv_call_unmap_gpa_pages(region->partition->pt_id,
> -				       region->start_gfn + page_offset,
> -				       page_count, flags);
> +	return hv_call_unmap_pfns(region->partition->pt_id,
> +				  region->start_gfn + pfn_offset,
> +				  pfn_count, flags);
>  }
>=20
>  static int mshv_region_unmap(struct mshv_mem_region *region)
>  {
>  	return mshv_region_process_range(region, 0,
> -					 0, region->nr_pages,
> +					 0, region->nr_pfns,
>  					 mshv_region_chunk_unmap);
>  }
>=20
> @@ -427,8 +452,8 @@ static int mshv_region_hmm_fault_and_lock(struct mshv=
_mem_region *region,
>  /**
>   * mshv_region_range_fault - Handle memory range faults for a given regi=
on.
>   * @region: Pointer to the memory region structure.
> - * @page_offset: Offset of the page within the region.
> - * @page_count: Number of pages to handle.
> + * @pfn_offset: Offset of the page within the region.
> + * @pfn_count: Number of pages to handle.
>   *
>   * This function resolves memory faults for a specified range of pages
>   * within a memory region. It uses HMM (Heterogeneous Memory Management)
> @@ -437,7 +462,7 @@ static int mshv_region_hmm_fault_and_lock(struct mshv=
_mem_region *region,
>   * Return: 0 on success, negative error code on failure.
>   */
>  static int mshv_region_range_fault(struct mshv_mem_region *region,
> -				   u64 page_offset, u64 page_count)
> +				   u64 pfn_offset, u64 pfn_count)
>  {
>  	struct hmm_range range =3D {
>  		.notifier =3D &region->mreg_mni,
> @@ -447,13 +472,13 @@ static int mshv_region_range_fault(struct mshv_mem_=
region *region,
>  	int ret;
>  	u64 i;
>=20
> -	pfns =3D kmalloc_array(page_count, sizeof(*pfns), GFP_KERNEL);
> +	pfns =3D kmalloc_array(pfn_count, sizeof(*pfns), GFP_KERNEL);
>  	if (!pfns)
>  		return -ENOMEM;
>=20
>  	range.hmm_pfns =3D pfns;
> -	range.start =3D region->start_uaddr + page_offset * HV_HYP_PAGE_SIZE;
> -	range.end =3D range.start + page_count * HV_HYP_PAGE_SIZE;
> +	range.start =3D region->start_uaddr + pfn_offset * HV_HYP_PAGE_SIZE;
> +	range.end =3D range.start + pfn_count * HV_HYP_PAGE_SIZE;
>=20
>  	do {
>  		ret =3D mshv_region_hmm_fault_and_lock(region, &range);
> @@ -462,11 +487,15 @@ static int mshv_region_range_fault(struct mshv_mem_=
region *region,
>  	if (ret)
>  		goto out;
>=20
> -	for (i =3D 0; i < page_count; i++)
> -		region->mreg_pages[page_offset + i] =3D hmm_pfn_to_page(pfns[i]);
> +	for (i =3D 0; i < pfn_count; i++) {
> +		if (!(pfns[i] & HMM_PFN_VALID))
> +			continue;
> +		/* Drop HMM_PFN_* flags to ensure PFNs are valid. */
> +		region->mreg_pfns[pfn_offset + i] =3D pfns[i] & ~HMM_PFN_FLAGS;
> +	}
>=20
> -	ret =3D mshv_region_remap_pages(region, region->hv_map_flags,
> -				      page_offset, page_count);
> +	ret =3D mshv_region_remap_pfns(region, region->hv_map_flags,
> +				     pfn_offset, pfn_count);
>=20
>  	mutex_unlock(&region->mreg_mutex);
>  out:
> @@ -476,24 +505,24 @@ static int mshv_region_range_fault(struct mshv_mem_=
region *region,
>=20
>  bool mshv_region_handle_gfn_fault(struct mshv_mem_region *region, u64 gf=
n)
>  {
> -	u64 page_offset, page_count;
> +	u64 pfn_offset, pfn_count;
>  	int ret;
>=20
>  	/* Align the page offset to the nearest MSHV_MAP_FAULT_IN_PAGES. */
> -	page_offset =3D ALIGN_DOWN(gfn - region->start_gfn,
> -				 MSHV_MAP_FAULT_IN_PAGES);
> +	pfn_offset =3D ALIGN_DOWN(gfn - region->start_gfn,
> +				MSHV_MAP_FAULT_IN_PAGES);
>=20
>  	/* Map more pages than requested to reduce the number of faults. */
> -	page_count =3D min(region->nr_pages - page_offset,
> -			 MSHV_MAP_FAULT_IN_PAGES);
> +	pfn_count =3D min(region->nr_pfns - pfn_offset,
> +			MSHV_MAP_FAULT_IN_PAGES);
>=20
> -	ret =3D mshv_region_range_fault(region, page_offset, page_count);
> +	ret =3D mshv_region_range_fault(region, pfn_offset, pfn_count);
>=20
>  	WARN_ONCE(ret,
> -		  "p%llu: GPA intercept failed: region %#llx-%#llx, gfn %#llx, page_of=
fset %llu, page_count %llu\n",
> +		  "p%llu: GPA intercept failed: region %#llx-%#llx, gfn %#llx, pfn_off=
set %llu, pfn_count %llu\n",
>  		  region->partition->pt_id, region->start_uaddr,
> -		  region->start_uaddr + (region->nr_pages << HV_HYP_PAGE_SHIFT),
> -		  gfn, page_offset, page_count);
> +		  region->start_uaddr + (region->nr_pfns << HV_HYP_PAGE_SHIFT),
> +		  gfn, pfn_offset, pfn_count);
>=20
>  	return !ret;
>  }
> @@ -523,16 +552,16 @@ static bool mshv_region_interval_invalidate(struct =
mmu_interval_notifier *mni,
>  	struct mshv_mem_region *region =3D container_of(mni,
>  						      struct mshv_mem_region,
>  						      mreg_mni);
> -	u64 page_offset, page_count;
> +	u64 pfn_offset, pfn_count;
>  	unsigned long mstart, mend;
>  	int ret =3D -EPERM;
>=20
>  	mstart =3D max(range->start, region->start_uaddr);
>  	mend =3D min(range->end, region->start_uaddr +
> -		   (region->nr_pages << HV_HYP_PAGE_SHIFT));
> +		   (region->nr_pfns << HV_HYP_PAGE_SHIFT));
>=20
> -	page_offset =3D HVPFN_DOWN(mstart - region->start_uaddr);
> -	page_count =3D HVPFN_DOWN(mend - mstart);
> +	pfn_offset =3D HVPFN_DOWN(mstart - region->start_uaddr);
> +	pfn_count =3D HVPFN_DOWN(mend - mstart);
>=20
>  	if (mmu_notifier_range_blockable(range))
>  		mutex_lock(&region->mreg_mutex);
> @@ -541,12 +570,12 @@ static bool mshv_region_interval_invalidate(struct =
mmu_interval_notifier *mni,
>=20
>  	mmu_interval_set_seq(mni, cur_seq);
>=20
> -	ret =3D mshv_region_remap_pages(region, HV_MAP_GPA_NO_ACCESS,
> -				      page_offset, page_count);
> +	ret =3D mshv_region_remap_pfns(region, HV_MAP_GPA_NO_ACCESS,
> +				     pfn_offset, pfn_count);
>  	if (ret)
>  		goto out_unlock;
>=20
> -	mshv_region_invalidate_pages(region, page_offset, page_count);
> +	mshv_region_invalidate_pfns(region, pfn_offset, pfn_count);
>=20
>  	mutex_unlock(&region->mreg_mutex);
>=20
> @@ -558,9 +587,9 @@ static bool mshv_region_interval_invalidate(struct mm=
u_interval_notifier *mni,
>  	WARN_ONCE(ret,
>  		  "Failed to invalidate region %#llx-%#llx (range %#lx-%#lx, event: %u=
, pages %#llx-%#llx, mm: %#llx): %d\n",
>  		  region->start_uaddr,
> -		  region->start_uaddr + (region->nr_pages << HV_HYP_PAGE_SHIFT),
> +		  region->start_uaddr + (region->nr_pfns << HV_HYP_PAGE_SHIFT),
>  		  range->start, range->end, range->event,
> -		  page_offset, page_offset + page_count - 1, (u64)range->mm, ret);
> +		  pfn_offset, pfn_offset + pfn_count - 1, (u64)range->mm, ret);
>  	return false;
>  }
>=20
> @@ -579,7 +608,7 @@ bool mshv_region_movable_init(struct mshv_mem_region =
*region)
>=20
>  	ret =3D mmu_interval_notifier_insert(&region->mreg_mni, current->mm,
>  					   region->start_uaddr,
> -					   region->nr_pages << HV_HYP_PAGE_SHIFT,
> +					   region->nr_pfns << HV_HYP_PAGE_SHIFT,
>  					   &mshv_region_mni_ops);
>  	if (ret)
>  		return false;
> diff --git a/drivers/hv/mshv_root.h b/drivers/hv/mshv_root.h
> index 947dfb76bb19..f1d4bee97a3f 100644
> --- a/drivers/hv/mshv_root.h
> +++ b/drivers/hv/mshv_root.h
> @@ -84,15 +84,15 @@ enum mshv_region_type {
>  struct mshv_mem_region {
>  	struct hlist_node hnode;
>  	struct kref mreg_refcount;
> -	u64 nr_pages;
> +	u64 nr_pfns;
>  	u64 start_gfn;
>  	u64 start_uaddr;
>  	u32 hv_map_flags;
>  	struct mshv_partition *partition;
>  	enum mshv_region_type mreg_type;
>  	struct mmu_interval_notifier mreg_mni;
> -	struct mutex mreg_mutex;	/* protects region pages remapping */
> -	struct page *mreg_pages[];
> +	struct mutex mreg_mutex;	/* protects region PFNs remapping */
> +	unsigned long mreg_pfns[];
>  };
>=20
>  struct mshv_irq_ack_notifier {
> @@ -282,11 +282,11 @@ int hv_call_create_partition(u64 flags,
>  int hv_call_initialize_partition(u64 partition_id);
>  int hv_call_finalize_partition(u64 partition_id);
>  int hv_call_delete_partition(u64 partition_id);
> -int hv_call_map_mmio_pages(u64 partition_id, u64 gfn, u64 mmio_spa, u64
> numpgs);
> -int hv_call_map_gpa_pages(u64 partition_id, u64 gpa_target, u64 page_cou=
nt,
> -			  u32 flags, struct page **pages);
> -int hv_call_unmap_gpa_pages(u64 partition_id, u64 gpa_target, u64 page_c=
ount,
> -			    u32 flags);
> +int hv_call_map_mmio_pfns(u64 partition_id, u64 gfn, u64 mmio_spa, u64 n=
umpgs);
> +int hv_call_map_ram_pfns(u64 partition_id, u64 gpa_target, u64 pfn_count=
,
> +			 u32 flags, unsigned long *pfns);
> +int hv_call_unmap_pfns(u64 partition_id, u64 gpa_target, u64 pfn_count,
> +		       u32 flags);
>  int hv_call_delete_vp(u64 partition_id, u32 vp_index);
>  int hv_call_assert_virtual_interrupt(u64 partition_id, u32 vector,
>  				     u64 dest_addr,
> @@ -329,8 +329,8 @@ int hv_map_stats_page(enum hv_stats_object_type type,
>  int hv_unmap_stats_page(enum hv_stats_object_type type,
>  			struct hv_stats_page *page_addr,
>  			const union hv_stats_object_identity *identity);
> -int hv_call_modify_spa_host_access(u64 partition_id, struct page **pages=
,
> -				   u64 page_struct_count, u32 host_access,
> +int hv_call_modify_spa_host_access(u64 partition_id, unsigned long *pfns=
,
> +				   u64 pfns_count, u32 host_access,
>  				   u32 flags, u8 acquire);
>  int hv_call_get_partition_property_ex(u64 partition_id, u64 property_cod=
e, u64 arg,
>  				      void *property_value, size_t property_value_sz);
> diff --git a/drivers/hv/mshv_root_hv_call.c b/drivers/hv/mshv_root_hv_cal=
l.c
> index cb55d4d4be2e..a95f2cfc5da5 100644
> --- a/drivers/hv/mshv_root_hv_call.c
> +++ b/drivers/hv/mshv_root_hv_call.c
> @@ -188,17 +188,16 @@ int hv_call_delete_partition(u64 partition_id)
>  	return hv_result_to_errno(status);
>  }
>=20
> -/* Ask the hypervisor to map guest ram pages or the guest mmio space */
> -static int hv_do_map_gpa_hcall(u64 partition_id, u64 gfn, u64 page_struc=
t_count,
> -			       u32 flags, struct page **pages, u64 mmio_spa)
> +static int hv_do_map_pfns(u64 partition_id, u64 gfn, u64 pfns_count,
> +			  u32 flags, unsigned long *pfns, u64 mmio_spa)
>  {
>  	struct hv_input_map_gpa_pages *input_page;
>  	u64 status, *pfnlist;
>  	unsigned long irq_flags, large_shift =3D 0;
>  	int ret =3D 0, done =3D 0;
> -	u64 page_count =3D page_struct_count;
> +	u64 page_count =3D pfns_count;
>=20
> -	if (page_count =3D=3D 0 || (pages && mmio_spa))
> +	if (page_count =3D=3D 0 || (pfns && mmio_spa))
>  		return -EINVAL;
>=20
>  	if (flags & HV_MAP_GPA_LARGE_PAGE) {
> @@ -227,14 +226,14 @@ static int hv_do_map_gpa_hcall(u64 partition_id, u6=
4 gfn, u64 page_struct_count,
>  		for (i =3D 0; i < rep_count; i++)
>  			if (flags & HV_MAP_GPA_NO_ACCESS) {
>  				pfnlist[i] =3D 0;
> -			} else if (pages) {
> +			} else if (pfns) {
>  				u64 index =3D (done + i) << large_shift;
>=20
> -				if (index >=3D page_struct_count) {
> +				if (index >=3D pfns_count) {
>  					ret =3D -EINVAL;
>  					break;
>  				}
> -				pfnlist[i] =3D page_to_pfn(pages[index]);
> +				pfnlist[i] =3D pfns[index];
>  			} else {
>  				pfnlist[i] =3D mmio_spa + done + i;
>  			}
> @@ -266,37 +265,37 @@ static int hv_do_map_gpa_hcall(u64 partition_id, u6=
4 gfn, u64 page_struct_count,
>=20
>  		if (flags & HV_MAP_GPA_LARGE_PAGE)
>  			unmap_flags |=3D HV_UNMAP_GPA_LARGE_PAGE;
> -		hv_call_unmap_gpa_pages(partition_id, gfn, done, unmap_flags);
> +		hv_call_unmap_pfns(partition_id, gfn, done, unmap_flags);
>  	}
>=20
>  	return ret;
>  }
>=20
>  /* Ask the hypervisor to map guest ram pages */
> -int hv_call_map_gpa_pages(u64 partition_id, u64 gpa_target, u64 page_cou=
nt,
> -			  u32 flags, struct page **pages)
> +int hv_call_map_ram_pfns(u64 partition_id, u64 gfn, u64 pfn_count,
> +			 u32 flags, unsigned long *pfns)
>  {
> -	return hv_do_map_gpa_hcall(partition_id, gpa_target, page_count,
> -				   flags, pages, 0);
> +	return hv_do_map_pfns(partition_id, gfn, pfn_count, flags,
> +			      pfns, 0);
>  }
>=20
> -/* Ask the hypervisor to map guest mmio space */
> -int hv_call_map_mmio_pages(u64 partition_id, u64 gfn, u64 mmio_spa, u64 =
numpgs)
> +int hv_call_map_mmio_pfns(u64 partition_id, u64 gfn, u64 mmio_spa,
> +			  u64 pfn_count)
>  {
>  	int i;
>  	u32 flags =3D HV_MAP_GPA_READABLE | HV_MAP_GPA_WRITABLE |
>  		    HV_MAP_GPA_NOT_CACHED;
>=20
> -	for (i =3D 0; i < numpgs; i++)
> +	for (i =3D 0; i < pfn_count; i++)
>  		if (page_is_ram(mmio_spa + i))
>  			return -EINVAL;
>=20
> -	return hv_do_map_gpa_hcall(partition_id, gfn, numpgs, flags, NULL,
> -				   mmio_spa);
> +	return hv_do_map_pfns(partition_id, gfn, pfn_count, flags,
> +			      NULL, mmio_spa);
>  }
>=20
> -int hv_call_unmap_gpa_pages(u64 partition_id, u64 gfn, u64 page_count_4k=
,
> -			    u32 flags)
> +int hv_call_unmap_pfns(u64 partition_id, u64 gfn, u64 page_count_4k,
> +		       u32 flags)
>  {
>  	struct hv_input_unmap_gpa_pages *input_page;
>  	u64 status, page_count =3D page_count_4k;
> @@ -1009,15 +1008,15 @@ int hv_unmap_stats_page(enum hv_stats_object_type=
 type,
>  	return ret;
>  }
>=20
> -int hv_call_modify_spa_host_access(u64 partition_id, struct page **pages=
,
> -				   u64 page_struct_count, u32 host_access,
> +int hv_call_modify_spa_host_access(u64 partition_id, unsigned long *pfns=
,
> +				   u64 pfns_count, u32 host_access,
>  				   u32 flags, u8 acquire)
>  {
>  	struct hv_input_modify_sparse_spa_page_host_access *input_page;
>  	u64 status;
>  	int done =3D 0;
>  	unsigned long irq_flags, large_shift =3D 0;
> -	u64 page_count =3D page_struct_count;
> +	u64 page_count =3D pfns_count;
>  	u16 code =3D acquire ? HVCALL_ACQUIRE_SPARSE_SPA_PAGE_HOST_ACCESS :
>  			     HVCALL_RELEASE_SPARSE_SPA_PAGE_HOST_ACCESS;
>=20
> @@ -1051,11 +1050,10 @@ int hv_call_modify_spa_host_access(u64 partition_=
id, struct page **pages,
>  		for (i =3D 0; i < rep_count; i++) {
>  			u64 index =3D (done + i) << large_shift;
>=20
> -			if (index >=3D page_struct_count)
> +			if (index >=3D pfns_count)
>  				return -EINVAL;
>=20
> -			input_page->spa_page_list[i] =3D
> -						page_to_pfn(pages[index]);
> +			input_page->spa_page_list[i] =3D pfns[index];
>  		}
>=20
>  		status =3D hv_do_rep_hypercall(code, rep_count, 0, input_page,
> diff --git a/drivers/hv/mshv_root_main.c b/drivers/hv/mshv_root_main.c
> index f2d83d6c8c4f..685e4b562186 100644
> --- a/drivers/hv/mshv_root_main.c
> +++ b/drivers/hv/mshv_root_main.c
> @@ -619,7 +619,7 @@ mshv_partition_region_by_gfn(struct mshv_partition *p=
artition, u64 gfn)
>=20
>  	hlist_for_each_entry(region, &partition->pt_mem_regions, hnode) {
>  		if (gfn >=3D region->start_gfn &&
> -		    gfn < region->start_gfn + region->nr_pages)
> +		    gfn < region->start_gfn + region->nr_pfns)
>  			return region;
>  	}
>=20
> @@ -1221,20 +1221,20 @@ static int mshv_partition_create_region(struct ms=
hv_partition *partition,
>  					bool is_mmio)
>  {
>  	struct mshv_mem_region *rg;
> -	u64 nr_pages =3D HVPFN_DOWN(mem->size);
> +	u64 nr_pfns =3D HVPFN_DOWN(mem->size);
>=20
>  	/* Reject overlapping regions */
>  	spin_lock(&partition->pt_mem_regions_lock);
>  	hlist_for_each_entry(rg, &partition->pt_mem_regions, hnode) {
> -		if (mem->guest_pfn + nr_pages <=3D rg->start_gfn ||
> -		    rg->start_gfn + rg->nr_pages <=3D mem->guest_pfn)
> +		if (mem->guest_pfn + nr_pfns <=3D rg->start_gfn ||
> +		    rg->start_gfn + rg->nr_pfns <=3D mem->guest_pfn)
>  			continue;
>  		spin_unlock(&partition->pt_mem_regions_lock);
>  		return -EEXIST;
>  	}
>  	spin_unlock(&partition->pt_mem_regions_lock);
>=20
> -	rg =3D mshv_region_create(mem->guest_pfn, nr_pages,
> +	rg =3D mshv_region_create(mem->guest_pfn, nr_pfns,
>  				mem->userspace_addr, mem->flags);
>  	if (IS_ERR(rg))
>  		return PTR_ERR(rg);
> @@ -1372,21 +1372,21 @@ mshv_map_user_memory(struct mshv_partition *parti=
tion,
>  		 * the hypervisor track dirty pages, enabling pre-copy live
>  		 * migration.
>  		 */
> -		ret =3D hv_call_map_gpa_pages(partition->pt_id,
> -					    region->start_gfn,
> -					    region->nr_pages,
> -					    HV_MAP_GPA_NO_ACCESS, NULL);
> +		ret =3D hv_call_map_ram_pfns(partition->pt_id,
> +					   region->start_gfn,
> +					   region->nr_pfns,
> +					   HV_MAP_GPA_NO_ACCESS, NULL);
>  		break;
>  	case MSHV_REGION_TYPE_MMIO:
> -		ret =3D hv_call_map_mmio_pages(partition->pt_id,
> -					     region->start_gfn,
> -					     mmio_pfn,
> -					     region->nr_pages);
> +		ret =3D hv_call_map_mmio_pfns(partition->pt_id,
> +					    region->start_gfn,
> +					    mmio_pfn,
> +					    region->nr_pfns);
>  		break;
>  	}
>=20
>  	trace_mshv_map_user_memory(partition->pt_id, region->start_uaddr,
> -				   region->start_gfn, region->nr_pages,
> +				   region->start_gfn, region->nr_pfns,
>  				   region->hv_map_flags, ret);
>=20
>  	if (ret)
> @@ -1424,7 +1424,7 @@ mshv_unmap_user_memory(struct mshv_partition *parti=
tion,
>  	/* Paranoia check */
>  	if (region->start_uaddr !=3D mem.userspace_addr ||
>  	    region->start_gfn !=3D mem.guest_pfn ||
> -	    region->nr_pages !=3D HVPFN_DOWN(mem.size)) {
> +	    region->nr_pfns !=3D HVPFN_DOWN(mem.size)) {
>  		spin_unlock(&partition->pt_mem_regions_lock);
>  		return -EINVAL;
>  	}
>=20
>=20


