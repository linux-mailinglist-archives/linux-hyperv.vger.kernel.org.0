Return-Path: <linux-hyperv+bounces-9151-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SNMpLvbcqWm4GgEAu9opvQ
	(envelope-from <linux-hyperv+bounces-9151-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Thu, 05 Mar 2026 20:43:50 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id BBED2217B10
	for <lists+linux-hyperv@lfdr.de>; Thu, 05 Mar 2026 20:43:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id E2D57301A6A8
	for <lists+linux-hyperv@lfdr.de>; Thu,  5 Mar 2026 19:43:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C53183E556A;
	Thu,  5 Mar 2026 19:43:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="EV62gYOQ"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazolkn19012009.outbound.protection.outlook.com [52.103.14.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D747303A26;
	Thu,  5 Mar 2026 19:43:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.14.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772739798; cv=fail; b=AwS0I4ieFQC2uA42jADr49R/dhCVEW680+HZg+PQepJbnkhbIhK4nyM6XjSgTshAMObuKh1ypXvGsXE30w3NljVJ6e2PFhXlFvyM9Ay26z/g/Abv9lJNj/AgjDPdbQIewtcWaVJ64f+7QHx2GmmkqbpI8QssRPorD0zAtDU8Ogg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772739798; c=relaxed/simple;
	bh=miyCs6/jA8ZazQEk1vNRHoPmh4xyQEeG4UwRrbLnnLQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=EFhzSr8ISNeC+tWp1sCbPk08lGFbTkmsCbIz414+YoylOYzTtHg/wWoFRm+33OsqmUhs8Ywdofm1UB6o/pOz7TjoFrTq9rljkrg9S4FRrJxF0h9xK81T6ovgAJkJYZfO0Pt2heGkx0ku+nwAr4KEi5tZxOUXjdOP1JUVhvgAxgE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=EV62gYOQ; arc=fail smtp.client-ip=52.103.14.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zMlnTTdTFa+sB9JGu8nttEv6fJJDc08ebt9DOH7y9Qmtbp8lOgLpS4Q0n+YNeHtFCzaz75XANrIouti2znKBJMnFf9tzajidKDthh7/O/GPUjpV3yAZL5maT6igfWjX05cjd2GEUjzROSyxbZbX8yGRjdh3ygX6tw8NaV9TyF5qSNAhhp4341DA5aqvrW5Nnkvps9TXkcA8fXquuX/EyfZ4i2AfcGT3Tm0Lq/JcvNxvK5bOOW0MEoPZ0Wz6L+sDNsONeBhKU3WZkxt7+o3H02124vm91450ozMFXcdOy1lcOIjzKnsinw81ndPj8LJaUqTDwtKtRl1kXjdIBBsLtsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j2BFSW8uXKGbemGoUzwQXwfkHO/WnuBShkI126K3Qeg=;
 b=YZa8XTPZyq4RWZoDFJ4cKtepN7rpcn6JheFljcS8oYi91YokokOAVxvI2hRc3REUeYZbB/1SIE41J5vJgx6s7otAsKHzl64AZybHhNUwPcDQCAiigpnf/HJEbe79Osn6EyFSr7ru15+HftwMNvOHfHRpJ7Gn3sCV9IpMizo5C+DkorqdDYMZxG4bv0gmyn01B56hgWKD2hnp2ufxCFp+UthzASzPpfVcKjMxC+Zvz5kGRmmrpMoaEbrbtcHbC5xdYM/NgVfhic6i5znjkdZf5wMotuFMgY9ZtlgyMuaj+gIrOw5zHWHvggPQzrVLaBo1vNjxkHDxPt+ZRxKeh053xQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j2BFSW8uXKGbemGoUzwQXwfkHO/WnuBShkI126K3Qeg=;
 b=EV62gYOQQt7Pey6Hm/afBNuZQF1zCvwpE6f+U7GCJ81qzDZ7+4lo6ATO4isO3k+ZEqttI+SCaLLmqIwRnev9mE1Pr4ThhbulwfRRrFphvpfciJgqWcPbBdZOjCnbJOsLrVcey0lXMF8QQzTyDtC4st7p1PbMhFiZDQInYl98cQg6N7kUgOUzBBEIIfstwuAIUTcU4UbxVZSOBR7L7jiNxNRq1vJ5+ghsuW7E8sxtI6JGh0QithkWjiAVOlqfRnGvF/TyqECAwu2/y3msHyhOxpFWi06L5ssoNvGZhZMIev6yBLwBQ1ggz2QwpV7KEVMx+A1mXywD78FH+pMQVJ7xDw==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by SN4PR0201MB8726.namprd02.prod.outlook.com (2603:10b6:806:1e9::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.22; Thu, 5 Mar
 2026 19:43:15 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::900:1ccf:2b1e:52b6]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::900:1ccf:2b1e:52b6%6]) with mapi id 15.20.9678.017; Thu, 5 Mar 2026
 19:43:15 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>,
	"kys@microsoft.com" <kys@microsoft.com>, "haiyangz@microsoft.com"
	<haiyangz@microsoft.com>, "wei.liu@kernel.org" <wei.liu@kernel.org>,
	"decui@microsoft.com" <decui@microsoft.com>, "longli@microsoft.com"
	<longli@microsoft.com>
CC: "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 1/4] mshv: Support larger memory deposits
Thread-Topic: [PATCH 1/4] mshv: Support larger memory deposits
Thread-Index: AQGf/CXhq+vihj2DXZ0/OE6Cmc0kFAKn37hBtgRqHTA=
Date: Thu, 5 Mar 2026 19:43:14 +0000
Message-ID:
 <SN6PR02MB4157CB6A57E15E00E472AA64D47DA@SN6PR02MB4157.namprd02.prod.outlook.com>
References:
 <177258296744.229866.4926075663598294228.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
 <177258381446.229866.108795434668770412.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
In-Reply-To:
 <177258381446.229866.108795434668770412.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|SN4PR0201MB8726:EE_
x-ms-office365-filtering-correlation-id: 72bcd70b-aa4e-4888-aa02-08de7aef7159
x-microsoft-antispam:
 BCL:0;ARA:14566002|41001999006|461199028|51005399006|13091999003|12121999013|15080799012|8062599012|19110799012|37011999003|31061999003|8060799015|40105399003|3412199025|440099028|102099032|18061999006;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?2DlsXdN0+bLdnn2b5/iks5cQuFdY+7WbnNlUVR6s1JFr3KNqKubdnUE0EdC+?=
 =?us-ascii?Q?1IGfEh6jj27HFddGead5q+OQhgsHPYLJQJ4EJ1Fvln/u3hbL7NjAF4XClkPu?=
 =?us-ascii?Q?YRiNiewanT38JkUZ4KlTTJqWAJZJ1l5FXTjcl2mJvzb7/wfzcJdAGYaLyl8L?=
 =?us-ascii?Q?HnIBrrO5QkTTZfPeRsx5Vc3cqNjkW/6INDxwbDSc6fdJOIFCAHCcMxpdnWN5?=
 =?us-ascii?Q?yIXP3kmwfbaFWp8xT6C91Ndqk9gonn4xBipQb7GYLqvTrtm7C5N+5SLJivVh?=
 =?us-ascii?Q?VU+qSrHPb+daNCGuI7PNuqbq/azZbUsiEZwgDak2+tACgF+5+Zu+LFCPeTeD?=
 =?us-ascii?Q?0JtrtW+lgYVBFNvLIcMCM9iC2z/9vrXmeDsDc4yNF9hFF1cJRRs3oiQf3t5t?=
 =?us-ascii?Q?qCLnRo0nWX4KlSxurvUf+zuN/jX/UWfu45pex5P5iaVLZwlJ673DFNvYR9Vd?=
 =?us-ascii?Q?bBwX41G6fZ6JQQCH1n4kF39B9K2d3Kde3hN0YjZtayy8jkts985CvR/eXAX7?=
 =?us-ascii?Q?NdyoFf7kIu+24Nw17KlTyJBccZt52mqqTwJ3WlLWcGLpPLCJGY75iSV7BUY/?=
 =?us-ascii?Q?N9CriQCI5evkguuECG9/ihvhq76JoiB8Mc6VPgpNFev9VEElm8xYMIyeg6ej?=
 =?us-ascii?Q?X3q2AmBTP0ZUG6jutQ+zqZr+jx1DLKURfrwNNzRlThoBirn7HLJyxo5AvQHL?=
 =?us-ascii?Q?nHGfG8MEkvXhe8TOEHrRdFUXcXO2aeUwGBfc1Cc0r6IEszPld0ou5mSubL2Q?=
 =?us-ascii?Q?VOf8Cx1/CSVdmCQuszXD4k9LfmWceGXEt8wpUKf1mDulCxFL2rx4ttq9X5ne?=
 =?us-ascii?Q?jWX5uu+ogUnqPEPzPXHirUvf73Dwl5ngPWIRQKQdOKXWPMK4ed1MHoNnMMy3?=
 =?us-ascii?Q?y75389KMck5QhF1C0UujDMr5Wy6/c8El3amLiU6s1Pq8b1rhHbmOn5BhFjoE?=
 =?us-ascii?Q?3GoUTRrqh+pFQXc4zEvBBLLLTxDExgiIQe+TVqa1/3Sn309YH0nauB0V9tKw?=
 =?us-ascii?Q?mGy5d8iLOKgDkeusYHjRjGhzdfhZ6bAOhboSwYris+9UK9BPLTfgf6uL91lm?=
 =?us-ascii?Q?zzQZfTDc?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?lmqTgG9SppY3ci9KFEk3uGxfQD0gtn2NijouBx3KNdyxGbhwjU1Nhg4iFchZ?=
 =?us-ascii?Q?cX5mhh0NLsYygRwX6q5NqHO6/ngGfrZwhhliQ15lzzW+mQKVXtm2GJYjUWlF?=
 =?us-ascii?Q?HSWnpjmIGeEM+PLEk9/Jo8XL3U8hZnWNAq0vuJIcEOMscAaSqjy2ZI4x8kT/?=
 =?us-ascii?Q?4ugMkFpe4OuRNM9RDDcwkpn31l0Omz9lhcIM3AMy8wnMIw96ba1nhK1fdzQJ?=
 =?us-ascii?Q?MzkiAe2NgtMpVZeNtd0mdkqMYlNEYmrDWFDj6ofeJWpH60TibRFPgVa/uQ9a?=
 =?us-ascii?Q?/3s78b/nNDFIC9EcbTP0qAVJFyKQGWUzj+6JkZE+mloZnQ1of/I4aHHkq226?=
 =?us-ascii?Q?g3i/kRkuKQ7QSduvB4S7db8t+17jMR8V7kAtgyIV9dzXYPR35vJVk4opA7bh?=
 =?us-ascii?Q?fc6MHROnHMTQedZn+fd2MIoby3fFvO6rlnE4tILxk2HmEROtO8MUmQXQfQE8?=
 =?us-ascii?Q?rGXBPLojn/ad06q9qwuxSrxaTxT8iGQjiUcPbkk4+ZvOnwd80Wx0Rfvftdom?=
 =?us-ascii?Q?OJgZz6KvFhdYzEwEViUTZsoMEgG+lxrcb4tCO9VhOzjKpnE2f4ro2pkQ/bHN?=
 =?us-ascii?Q?3DRMxh4Key1jZdE9O/EbY7MNUpr/BBJP97grTYPQHPztGy+S+HUjPkgBg1jp?=
 =?us-ascii?Q?rQTtDRQTb5VpgN8+wuxtBiTJ82/ugyYnjg/p5KJcuXnF/6BbkfV9kzZ3cYaL?=
 =?us-ascii?Q?tiBHHqEtlTC9ftsnmJvaC5ndPolENdlRdirPMPAdD+LAAH52dztrrojW7zgp?=
 =?us-ascii?Q?TA4EZzH4SWCsnNQLdgPODTojNqx6mPu2WrS/96E20sh3crQ3BcjrgtyFqPJo?=
 =?us-ascii?Q?s3ZLatkzT7zbsa4wnyWHTZ3w6es7mDbnb7d3SbQioUh9Hnv6R2xnZIjAzT/A?=
 =?us-ascii?Q?sI2CAZ/GVXRRDaOp/08vKlFx8wI+t/68cDOywvc7crkEPcca8Ho6oORv6zSG?=
 =?us-ascii?Q?UHRdEf3Xz+OP8yRsvb7AgP353yATRabbU4RTFXeCwWYqSjUmHWpfUySsfLPy?=
 =?us-ascii?Q?lsAbx25U235Q1Z3veKu5WmQICDuwyCvQ9UHL3EDeKHxvC53LG3MY+dyoFf+c?=
 =?us-ascii?Q?5p6mh7vERlZfaHebllq/9xucSZNGpBqg8hrvrFxwyEJ0EEScM24FpOR30HzC?=
 =?us-ascii?Q?5ttvlRjnPB+Bog7uJtuocylYQgWEp6Q4rQCDOAQkJkabxXue0AUnkpoqulmP?=
 =?us-ascii?Q?1evCHXYGRe8zCZctqvD4XYOHBuuJsXwB2/yZVzLxDKuOoQDS8EO53xdTbSep?=
 =?us-ascii?Q?yiE+789cLazrxPcSZEKdK3gGveaqtyPLyo5eQpIxsZxfazfbQA6fyJSo/rF9?=
 =?us-ascii?Q?BakFBaKN1n1uyi3GJjPFGPNbsXv/EUWFdI6+m7/cn0ikkmXxlk/cdcjEue24?=
 =?us-ascii?Q?4t3oqQs=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 72bcd70b-aa4e-4888-aa02-08de7aef7159
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Mar 2026 19:43:14.9660
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR0201MB8726
X-Rspamd-Queue-Id: BBED2217B10
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[outlook.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[outlook.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-9151-lists,linux-hyperv=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-hyperv];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,outlook.com:dkim,SN6PR02MB4157.namprd02.prod.outlook.com:mid]
X-Rspamd-Action: no action

From: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com> Sent: Tuesda=
y, March 3, 2026 4:24 PM
>=20
> Convert hv_call_deposit_pages() into a wrapper supporting arbitrary numbe=
r
> of pages, and use it in the memory deposit code paths.
>=20
> Signed-off-by: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
> ---
>  drivers/hv/hv_proc.c |   50
> +++++++++++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 49 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/hv/hv_proc.c b/drivers/hv/hv_proc.c
> index 5f4fd9c3231c..0f84a70def30 100644
> --- a/drivers/hv/hv_proc.c
> +++ b/drivers/hv/hv_proc.c
> @@ -16,7 +16,7 @@
>  #define HV_DEPOSIT_MAX (HV_HYP_PAGE_SIZE / sizeof(u64) - 1)
>=20
>  /* Deposits exact number of pages. Must be called with interrupts enable=
d.  */
> -int hv_call_deposit_pages(int node, u64 partition_id, u32 num_pages)
> +static int __hv_call_deposit_pages(int node, u64 partition_id, u32 num_p=
ages)
>  {
>  	struct page **pages, *page;
>  	int *counts;
> @@ -108,6 +108,54 @@ int hv_call_deposit_pages(int node, u64 partition_id=
, u32 num_pages)
>  	kfree(counts);
>  	return ret;
>  }
> +
> +/**
> + * hv_call_deposit_pages - Deposit memory pages to a partition
> + * @node        : NUMA node from which to allocate pages
> + * @partition_id: Target partition ID to deposit pages to
> + * @num_pages   : Number of pages to deposit
> + *
> + * Deposits memory pages to the specified partition. The deposit is
> + * performed in chunks of HV_DEPOSIT_MAX pages to handle large requests
> + * efficiently.
> + *
> + * Return: 0 on success, negative error code on failure

For the failure case, a key fact seems to be that there's no attempt to
withdraw any pages that might have been successfully deposited. In
such failure case, the caller has no information about how many pages
were, or were not, deposited. The 2x for L1VH further muddies the
picture.

__hv_call_deposit_pages() apparently assumes that if the underlying
hypercall fails, none of the pages were deposited.  So it frees all the
allocated pages. But I wonder if that's really true. The hypercall is
a rep hypercall, which can get partly through the list, return to the
guest, then restart where it left off.  If there's a failure after a
restart, I wonder if the hypercall goes back and withdraws any
pages that were successfully deposited before the restart. The
restart behaves like a new invocation of the hypercall.

> + */
> +int hv_call_deposit_pages(int node, u64 partition_id, u32 num_pages)

Perhaps the num_pages parameter should be a u64. The u32 imposes
a limit of 8 Tbytes on the amount of memory that can be deposited
(allowing for the 2x multiplier for L1VH partitions). Azure has VM sizes
today with up to 30 Tbytes of memory, so it's certainly possible.

> +{
> +	u32 done;

Same here. Use u64.

> +	int ret =3D 0;
> +
> +	/*
> +	 * Do a double deposit for L1VH. This reserves enough memory for
> +	 * Hypervisor Hot Restart (HHR).
> +	 *
> +	 * During HHR, every data structure must be recreated in the new
> +	 * ("proto") hypervisor. Memory is required by the proto hypervisor
> +	 * to do this work.
> +	 *
> +	 * For regular L1 partitions, more memory can be requested from the
> +	 * root during HHR by sending an asynchronous message. But this is
> +	 * not supported for L1VHs. A guest must not be allowed to block
> +	 * HHR by refusing to deposit more memory.
> +	 *
> +	 * So for L1VH a deposit is always required for both current needs
> +	 * and future HHR work.
> +	 */
> +	if (hv_l1vh_partition())
> +		num_pages *=3D 2;
> +
> +	for (done =3D 0; done < num_pages; done +=3D HV_DEPOSIT_MAX) {
> +		u32 to_deposit =3D min(num_pages - done, HV_DEPOSIT_MAX);
> +
> +		ret =3D __hv_call_deposit_pages(node, partition_id,
> +					      to_deposit);
> +		if (ret)
> +			break;
> +	}
> +
> +	return ret;
> +}
>  EXPORT_SYMBOL_GPL(hv_call_deposit_pages);
>=20
>  int hv_deposit_memory_node(int node, u64 partition_id,
>=20
>=20


