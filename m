Return-Path: <linux-hyperv+bounces-5407-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D13F1AAE556
	for <lists+linux-hyperv@lfdr.de>; Wed,  7 May 2025 17:49:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ED1179C39D3
	for <lists+linux-hyperv@lfdr.de>; Wed,  7 May 2025 15:49:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 660D028BA9D;
	Wed,  7 May 2025 15:47:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="pwvnQ1hR"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azolkn19010012.outbound.protection.outlook.com [52.103.10.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9577528BA9B;
	Wed,  7 May 2025 15:47:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.10.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746632866; cv=fail; b=UCGwStRxMNSeamJZu+0Sig9th1ydxB9l4oN7gAHY8/YnS/5zCYbleeWLwOIBWOr/wxuQMu0ND6jEdN8OdqlR9ZCIcEeE1aA60Ouw8k939SIILE0x1Lw4rRvwgBt7o8OP39dAUBrwvOdpcoA1voxhver3r017zIDJ4U8EN/MzGAk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746632866; c=relaxed/simple;
	bh=xyJq1s+Tl/nA67Y4PcS10r3WJtUI8Yfy9L+peDmdKQ8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=RfGV1XLdlE7vq9tkBx5JSwrKuB8k0eUzreoB+rhYSuumHgXuMNyFBDaiPSpp/gFPKNq6vegSGkHi8Yi/+6tQqHBZl6/Fdw1rtjv9l6k40baVT09sPPU1+cr7xC2OUoQQpC6D/cu+5Soe4HByqfLZuzB8MfQd1T/V85z4cjJ8H78=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=pwvnQ1hR; arc=fail smtp.client-ip=52.103.10.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=H4dXbJzVA4EnSVddw5bornCZEoHQu/SEKMuJ3J0MYF7QrsoFzDQIWsuLayc6HQzBGbLaTZLFx9xM5WzpvervHX9iGBomDiL741gRNIr603ruWU8nSwkO90tvBIgfmuudeiyX5R5klrfNT9TmQlMIHUVTJ0pnYl+encS3Vn3eAg6zp7yz+jZaq5t12BAHVd1deVuay0y/rBGCmDV+VKeQFLLGDYEcG2pCLKsiLivetNJ5fITT3egIUjaqznUCN8hEChK3ZJJ7YzW1SOVXt41aHaVJmNjQI9+xeSh5MH3hXJaiHoJGu6o3P+2YGmE3SsxzRm4/XQ6SE/r8mNHb5g8IKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z5La87ylzWZyInasXPcsjXaBe4VPM35GFodryMcqvN8=;
 b=ApHhlaYoqe7eegPSJ8jJyCBTEqP0VZ5D3sryMEHGILSaJE0uGk5I+SJFhYvAE6oEndeRBXLtTpe40SzFJAF60wiH8XwVWZNsC5NGMtav4/YkWOebBI0ecDz06Cq8Bp+r76aHSQK626kp7WrOwjpROV/w+ySiKKImyzlmEQZrmRzyzCTBEK/DAV+xN9IzcRzDfpumEJNXH03VlNmuJEwrd320FxuAuwCkM3X1VoXI82tWP96wpuuGiEny8Yn5kzYTeIGtO8KyCdUqDr+nkX8xhlle4ti+MNLg+OmfVEJysHzPPEKGRXPdy5k8tCHcM+MpJWB2rwqt9BIm07ACrD/2Eg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z5La87ylzWZyInasXPcsjXaBe4VPM35GFodryMcqvN8=;
 b=pwvnQ1hRYLJK3rwi5oQaID8xJc5tVX+xolXhi3Vh66ulsD5yZ5iJHFTAEIz5ftbb5hJehRfjKlH93S4Q1zEepzORebOh4itsiJl83gVtf2bTlgBX3n1M42oGi8XDEbwgCeI47vk4roCPcIlemtHnzcww5P6xg2YMAKbq+JZTz3NRcGzx6njFm9Cv8VLBhR+Tz6aSGNhOH7aySFh4jiEm8RFOEEomA9cbiJdWDflc0sY5dS2W61/Br9axwRyfxX/iq2KL/k0hB8kKjt89Zyg3iX7J4sxvhEyotF2GVGApTfHbGjlvMljycqIsjR/ykh0GLWa4lgRP4QBL2Q9FH20wgw==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by CY5PR02MB8989.namprd02.prod.outlook.com (2603:10b6:930:3a::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.13; Wed, 7 May
 2025 15:47:41 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df%3]) with mapi id 15.20.8699.022; Wed, 7 May 2025
 15:47:41 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: "longli@linuxonhyperv.com" <longli@linuxonhyperv.com>, "K. Y. Srinivasan"
	<kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu
	<wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>, Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>, "linux-hyperv@vger.kernel.org"
	<linux-hyperv@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
CC: Long Li <longli@microsoft.com>, "stable@vger.kernel.org"
	<stable@vger.kernel.org>
Subject: RE: [Patch v3 2/5] uio_hv_generic: Use correct size for interrupt and
 monitor pages
Thread-Topic: [Patch v3 2/5] uio_hv_generic: Use correct size for interrupt
 and monitor pages
Thread-Index: AQHbvlE/jlMiglj75UOsI0DA60jqNbPHUexA
Date: Wed, 7 May 2025 15:47:41 +0000
Message-ID:
 <SN6PR02MB4157EB4847E376C34A1D0E84D488A@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <1746492997-4599-1-git-send-email-longli@linuxonhyperv.com>
 <1746492997-4599-3-git-send-email-longli@linuxonhyperv.com>
In-Reply-To: <1746492997-4599-3-git-send-email-longli@linuxonhyperv.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|CY5PR02MB8989:EE_
x-ms-office365-filtering-correlation-id: 6e67355a-cf43-4b4b-27ea-08dd8d7e802e
x-ms-exchange-slblob-mailprops:
 znQPCv1HvwVu6ov8hlKZu5ytU8AWxKlx+tWgxoOdogjUaE/QkmOw9ylbTh8kyPO5czyF67s08kYUEVjhjcFTpwajzvFf407bRsbVQsVvHLA+UInKMtA9zVI1ciLLRrUyrwGZ7GJvy0t1mPH3TN/GOcnGoXMZbfuM0kqEVjA6ZvvbMN16ysGlqloloijLaguVrGwJ4v/aJDByEaEiTretDeoY/xCsdC+3diE8f1PRqO7LfLf2zvaDLW2HeaI9qfY1z0MxCJqZr33cuxjWRwc1iWiROzvm1MbZWFbfiRKdbHQEMewofr8MbfTG8lweTj/O4IeJUtihAjIqq4XSv8bv2/oZPN9U+sLwaI2oaPdAp2goHaPKspGBUTHpW6S+U/NWK67meCX312mdgHFeQ9PXgGEH1ErZBjVhcnnBnK3HwRki+RjOoIGfJjIjG32XjD0zD5A7cwBvSIab3esMPe11xvIiIx14DiFk2OpFP7qcFEeTONg810w5V+HL0UgbDqjr/5VvL3qkCQlUQ+tlnV1ksuCOLwpT+a2AIOSwxC5o/88Tbe/zh4Ixz9df14tLfNDlORkTGt+tOnKRAeq+67jP8bmp8cUHX2M1tRe0Avv2U3tgBBVj+tUa69usVWVNOlRLkun+17wTTaRAs486WpGbcJ8gg3eQ3eLEBcoCxQ/M6B4KFrBo8tuv3aQ/xbf2MOQKlPdK/cUWD/42VmbmzPug44Gwj7yaBE+5HiKd4N4UiOkUMn5IJw/ey4ZM+4jzSmb8ZilybGT8/vE=
x-microsoft-antispam:
 BCL:0;ARA:14566002|461199028|15080799009|8062599006|8060799009|19110799006|102099032|3412199025|440099028;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?DfEeGO2CpOBI5rm7b34Mlbgn6dCvq/xciDUXrOSzB4kquCjCTqu1D4vbagvK?=
 =?us-ascii?Q?osE+wZuPpUsWh0QldzbhplAOkHYTJfZMLqMypmjeHssDI+oY7hlf/atsgA1+?=
 =?us-ascii?Q?+7TXw811J6RsMmh6YmgFYgSbMGjceRNIrzvPCy+9j12ciPpKEdGU0MRQmNlt?=
 =?us-ascii?Q?km1jrPcoHiJFla9mQ9gdM2Chud/2dz1ncy5ONtdIRlehvXA6oC1ccktoxabP?=
 =?us-ascii?Q?FmCCduQ3tjuVpyw8yb7eppJeg2I+7wueFiIO7ZBxb+uNCv0AaLL0GXUXRQ/5?=
 =?us-ascii?Q?nzuAWbpt2VdHC9J+ON2pkWHP4AUFYyj2Y9Vvx0N736ECRIbUq3zlk2w2Cs7x?=
 =?us-ascii?Q?zracyhdUbrkq7Ek5UQRID6lXcS7YRbVQlTmq1/vPVuIS7HbkDpIX8f/ERP43?=
 =?us-ascii?Q?Oo3HQ3B/gN/DC3YuDGGO6bjijoGYhEjvfcbaufrbfz4+FVx6yohK56+EpR2i?=
 =?us-ascii?Q?+9cscAMjFW7SkeUDicrqRWq5nbckZCBrwxdKc6e7hrlBfsQt3Dsfa9h3Tfn1?=
 =?us-ascii?Q?xWdSiAUNaN+mIoaI5Jvb/xd0Q9UrpyMhYNFBlLBOu9eGB06gQZtY06VZw1oH?=
 =?us-ascii?Q?OKQz/XK+puOcqlHyNOIbvBxcA+8N+r//xAYKAqEmJfegG9N4f+svacoWqdUe?=
 =?us-ascii?Q?iTtSEQbJcXdNQQcoQyYSRtFWjAhcFkMorucOQrlfo7x5bPG80xIBViJpRpJj?=
 =?us-ascii?Q?GglkLbCFIgq0rWgZ2k2omgFrX8tHezOdOKMUvs/wOK8sbIWyZ8YLfHwbMV/R?=
 =?us-ascii?Q?QHXfpKhRivei0s7WqqqfcCZVP9acbgCwuVacjL+GJU/G5zKcYc2Ws+6X6H0s?=
 =?us-ascii?Q?DOfw1elkt9qHm66pw9wVe/e4bJQagZGKmxpGuGL8HbhhNqJb9Af5dDbhNRiZ?=
 =?us-ascii?Q?IFF5VY/KzwVslFJYe0CjLa3edHifs6PQAtrkQCq0wla06WP8zcSj3jTsMpQW?=
 =?us-ascii?Q?h23jqChvbk9wMz09Ny6PueRhvsOE/7WeqfMHHNT52Vn+UCCk0hoHbVghMowt?=
 =?us-ascii?Q?BUyyReAfqJ5yK2jSfmRnEfTbSxW+w7eoNw+bvZL/1FeFUoY8D/l32QKQwffc?=
 =?us-ascii?Q?Eqj42stSahlf/cKIJarjdjOXaFBS6g=3D=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?F7ATwMhoydqWrq4yfk6kbg+cm6waH+GSei/66gYjP93cyYbB3jdRV+4MyK5U?=
 =?us-ascii?Q?OfVNlkcxMj1QAyWQ0DG0KOP3btMtqaY0zUYWYL3jlPQ2M4c7GasrqeEl23yz?=
 =?us-ascii?Q?BsAVoq6sa7NjHshlWXBPxeFVUijAcE6NyYhR5vUOeCORxmXF+sN0n//Rjnkk?=
 =?us-ascii?Q?SbAiS6R3QLMKRFLnDHqVD+QegHW9FUzDpGIf3x2HHuNyggbxsye7fL9c41Tr?=
 =?us-ascii?Q?zcu1shYMggx73JgWUnfT4tkaU4f8XUdKi8ccuRySPjtBg273HMy3BiGWVz+z?=
 =?us-ascii?Q?Dbpgkk0sGdYefto735eiJQUQ2+iPiZFXrto7qTZO1H12tjDbo35MzOiLh2qk?=
 =?us-ascii?Q?MN9qdiGbJ8AMhiKVtbjV7wq3x1slRE24VKjKsTW85vCvm+9n8wTXXdWMqbyz?=
 =?us-ascii?Q?d2cQZ6XWim/LfruAX08R4/d339SJ9gJp35jbSd8YtRruAztluP29ZPTupAOP?=
 =?us-ascii?Q?dXj7XNqOa8NcgJFi2wa+HXXDNBK14iNlicuP4ogarZu0yb+sHt+Lc2o2hpQe?=
 =?us-ascii?Q?TTjCVvUNoF5lkSqY2xH40miGAKOc8w7lz1nC+xwJgpk78oIuAkRIJXVAoye1?=
 =?us-ascii?Q?XpkprvJqWVzmc5KLe2hAWdk5hx7aiqi60jCSA5TsAFSiCq4YJdLQxPAZqM9M?=
 =?us-ascii?Q?k2csXP7AOrHjArJm+dxNLYkShgs4cIMZyZwyA62zYpJ23voP3/B89H+RCmn+?=
 =?us-ascii?Q?ZJ73gL0uEDGb+cDnureYnnR/s4QAoTzXY3NQh+LYZPC1j3HJwB1dBf7Ya4zE?=
 =?us-ascii?Q?i59XOMbCWnPiDWA2CRSIFYRUznZoICNGTFWX3zpfXneI+yKBWO0OMiNZHJLw?=
 =?us-ascii?Q?u6kQTvT3CQz9TOPfWf2bTDjqWh4Yes9DOW29rkoIpm9/NIB6HclxRT3BVAj/?=
 =?us-ascii?Q?M8eHua8PqITh1TabQkblUhrw5q7nmO+KdRtSl+Pp/niYLT382XpWhv1nS/lN?=
 =?us-ascii?Q?Tii4d/XdvInCkF99/2LqeuP+6W/B4EtkNbPUrZn5K1w7UPod4c+qVTFUIJjE?=
 =?us-ascii?Q?+QoDthv9DO0tNw/m2eeSLT8MHTSDqp8GdwGVEWclZihj+NDnrp7mMl9sZNaW?=
 =?us-ascii?Q?iyWidFLslHgbQm2peoVpA595+y1RwfZ3FpMy0c0hlNOwbFMa507TW/2+dzYy?=
 =?us-ascii?Q?hswufozgu9TyWSqLUHSW6Y6SBbGlbaScijUYGXhyBBFEDlSRjkH3wK5r59WE?=
 =?us-ascii?Q?fZoSX7Vxz3JpNC/3CQ4DH4CshPtU7Cnxvbm9l6V5fqmEzw2CYBifITXVFiQ?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e67355a-cf43-4b4b-27ea-08dd8d7e802e
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 May 2025 15:47:41.1823
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR02MB8989

From: longli@linuxonhyperv.com <longli@linuxonhyperv.com> Sent: Monday, May=
 5, 2025 5:57 PM
>=20
> Interrupt and monitor pages should be in Hyper-V page size (4k bytes).
> This can be different from the system page size.
>=20
> This size is read and used by the user-mode program to determine the
> mapped data region. An example of such user-mode program is the VMBus
> driver in DPDK.
>=20
> Cc: stable@vger.kernel.org
> Fixes: 95096f2fbd10 ("uio-hv-generic: new userspace i/o driver for VMBus"=
)
> Signed-off-by: Long Li <longli@microsoft.com>
> ---
>  drivers/uio/uio_hv_generic.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/uio/uio_hv_generic.c b/drivers/uio/uio_hv_generic.c
> index 1b19b5647495..08385b04c4ab 100644
> --- a/drivers/uio/uio_hv_generic.c
> +++ b/drivers/uio/uio_hv_generic.c
> @@ -287,13 +287,13 @@ hv_uio_probe(struct hv_device *dev,
>  	pdata->info.mem[INT_PAGE_MAP].name =3D "int_page";
>  	pdata->info.mem[INT_PAGE_MAP].addr
>  		=3D (uintptr_t)vmbus_connection.int_page;
> -	pdata->info.mem[INT_PAGE_MAP].size =3D PAGE_SIZE;
> +	pdata->info.mem[INT_PAGE_MAP].size =3D HV_HYP_PAGE_SIZE;
>  	pdata->info.mem[INT_PAGE_MAP].memtype =3D UIO_MEM_LOGICAL;
>=20
>  	pdata->info.mem[MON_PAGE_MAP].name =3D "monitor_page";
>  	pdata->info.mem[MON_PAGE_MAP].addr
>  		=3D (uintptr_t)vmbus_connection.monitor_pages[1];
> -	pdata->info.mem[MON_PAGE_MAP].size =3D PAGE_SIZE;
> +	pdata->info.mem[MON_PAGE_MAP].size =3D HV_HYP_PAGE_SIZE;
>  	pdata->info.mem[MON_PAGE_MAP].memtype =3D UIO_MEM_LOGICAL;
>=20
>  	if (channel->device_id =3D=3D HV_NIC) {
> --
> 2.34.1
>=20

Reviewed-by: Michael Kelley <mhklinux@outlook.com>


