Return-Path: <linux-hyperv+bounces-1635-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0335E86E913
	for <lists+linux-hyperv@lfdr.de>; Fri,  1 Mar 2024 20:04:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 94476289DAC
	for <lists+linux-hyperv@lfdr.de>; Fri,  1 Mar 2024 19:04:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA2A73F8C8;
	Fri,  1 Mar 2024 19:01:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="k7EXJNmF"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12olkn2085.outbound.protection.outlook.com [40.92.22.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52D3E3B1B7;
	Fri,  1 Mar 2024 19:01:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.22.85
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709319672; cv=fail; b=TMmRBABvWjveEbUZDAKA/F7S/5dOiUXhTnhKBc5RYZ5eWWJZhNANwQKloIGlpBLUTGYnvMfFg6v2NOZPGrHsAzoNPW3mgAQJ7FYqPd1T8+Yn0gGVTyZJNWzXJLWMcp7etuG+H/UryniRiMe94aMepkWiL3xa5hOuAyAkKCqNDUA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709319672; c=relaxed/simple;
	bh=mQp56tfCet8RAPbxXf2VBCIjBlim17mHrgfJK+IFyjI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=eGScZiP/ocIPydhHve+c5c2eCeRMXm6pbPOSZlgu5/T/wSSN/66ALQBtWBtAu/40Z7zFXLfqUVMNMQEnabmt5lDE5DxXqDm6xHa5zHTuFIGM+9kytqUGuBF2K+hPF8pZLBo4gJtOOwGqFc9G9YeI1k3ORqE2Jlb6VJkEg3S9/70=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=k7EXJNmF; arc=fail smtp.client-ip=40.92.22.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Wti0TNzuFl+ILGFMsxRAy86zUq1kEhNKWF/Jop+iGhqwEeVF4BIBJSE1T7Q25Eo6AMRM8o18DyzcBHdYgpNDcnn5iqn68FJYD7IbGh0dW6nUMNaBzJ5ffAofdCyvVVlWvZGgYnOCbg9BkBiAv9pdnCa49qk/JozRvJKxumpGWqZRJmz68LCsYO3RAd/GmOTYK0/9Fu5aBslMEyYI5OOM9SnZ0/vPaehEwhZen5o+i68m2ogh3AakIV/S8suRJn2OlzXJA7K7qpn69OquQJ8dm17eG0fKGb1PpjELD6DOpaX7fvo8J8pkl9xcqVx5hzeKBvqdqXoejOMmWnn0t3lDKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TbRdmz9C2pae8ZZYxJiyr/IvbLLmbrWMjLOJ03HqtpY=;
 b=cZp59LzGB+/fXJW6qGO/MqhMAdTxCChAWzfHv+utRrOh79mV7olfEFKX5/AyPeqzqziwN2kJ77obbFUYIRUhDooOBub06ZE3jrAjC5/q98zKVoaigjyrG9k6LGA96Pb5q+uwP+roedMuFXzrPujstDVAUWQ9NNLnu+cWBQM6i21zoyAWMolz1WoAVAu38Gp9JssixSXaOUnQOck1cvFOl7dGbilFKl72ov3yPfBQXbglACvrUxbcMidjJvRKTTa2c26UtMMNDSQX0sp6d4Rj4fczcA0lxdf7gJgYlV4uk2vJlOKID6rpa/OuGO7KRvSZY0tWqlFHjB/AGR8NWtREPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TbRdmz9C2pae8ZZYxJiyr/IvbLLmbrWMjLOJ03HqtpY=;
 b=k7EXJNmFYI/uRBDk9WfZkKxYfqxcp0OSyTFxYYaFMTFg84HZ3z0ZQsfXtnymGhO/J+ILT8Ih6AZHrbbOQ3YDSTMX7bOTs7os8Ux1ddfYrQsHpghWvZg8wmq9CwVeoVo7nqsjcay+mwqyuS7btynycYbqnLkEqbKpERsKO/fQyWc9bVuLFv5+/uNxtqBBeahfdKuAk6tk9+qTZ4VSos+C7UZuo4G2JNunNKhcqZcsqnouqZiZz4Y8FmbYumuM2TgtaKlUeJrTmSeyt6sn5/IayOAmOCCf6COK0MMehfge4DR+zVVLXcAjFMyoY9ZZeBlpm/v2PBkhnk1C+q84YsRVqg==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by CY5PR02MB8941.namprd02.prod.outlook.com (2603:10b6:930:3a::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.34; Fri, 1 Mar
 2024 19:01:08 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::67a9:f3c0:f57b:86dd]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::67a9:f3c0:f57b:86dd%5]) with mapi id 15.20.7339.031; Fri, 1 Mar 2024
 19:01:08 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: Rick Edgecombe <rick.p.edgecombe@intel.com>, "kys@microsoft.com"
	<kys@microsoft.com>, "haiyangz@microsoft.com" <haiyangz@microsoft.com>,
	"wei.liu@kernel.org" <wei.liu@kernel.org>, "decui@microsoft.com"
	<decui@microsoft.com>, "linux-hyperv@vger.kernel.org"
	<linux-hyperv@vger.kernel.org>, "gregkh@linuxfoundation.org"
	<gregkh@linuxfoundation.org>, "davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>, "kuba@kernel.org"
	<kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
	"linux-coco@lists.linux.dev" <linux-coco@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: "sathyanarayanan.kuppuswamy@linux.intel.com"
	<sathyanarayanan.kuppuswamy@linux.intel.com>, "elena.reshetova@intel.com"
	<elena.reshetova@intel.com>
Subject: RE: [RFC RFT PATCH 3/4] hv_nstvsc: Don't free decrypted memory
Thread-Topic: [RFC RFT PATCH 3/4] hv_nstvsc: Don't free decrypted memory
Thread-Index: AQHaZTRYyLuO6L4H/k6p47hU50Sf0rEjRGOQ
Date: Fri, 1 Mar 2024 19:01:08 +0000
Message-ID:
 <SN6PR02MB4157DBE049E6628D0B7CBADBD45E2@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <20240222021006.2279329-1-rick.p.edgecombe@intel.com>
 <20240222021006.2279329-4-rick.p.edgecombe@intel.com>
In-Reply-To: <20240222021006.2279329-4-rick.p.edgecombe@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-tmn: [ZpsFFHmXkCDZ/elA+JHltteRw1BuljVg]
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|CY5PR02MB8941:EE_
x-ms-office365-filtering-correlation-id: 732d9606-8282-41c6-4c33-08dc3a21f46a
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 TPHlY2E/CKhwPqgCiso/aUVmihZF9Cgxb+B5LSeaVZzlqcmKiJUA/9OAOS393SobNjIUJTshD/tfSQPEIZYvtPMjjtougvG3ecI6aqRlsrFTt7RT3Hr4BSsl+ocPYqWtUzlvX9YX9yExR10Q+c4zM3cUxqFmoiR6gp6/BjHMEdryj+QuRF1NlQ85EqxaKyvil0hAxwpw3IDS5zIqWoJ2opKZN2WKmX8wUZVEEWQTUy4HKdGp8AIguS3Z0xIsreQLyaDoAaSkV740dwuycnXWOISvg6LSnij5VrsVG7kEMrHZmV0mq3e0QxAK8G2MBy4bjwpoPzE8LqZd4g4hWkH/t7s8ClD2H9SXNXzEep2fB1fCX0UsGdKDX+ON1XW8zzYuLZvDvQzOyaz84sc81s3oHMHSg/1ul3/K/T+xdwYVOIWgtKk+Z52Bq4dFb0LI5vGk8bkYi5wI9xL2M6CSkHTu6guPpxchFx8YJiFf61bLsIqP2SqFONmthDN9CIZ0++t+hocxiyhazGuRa0V1qAStQvVpLlzy+dYlCNsLlYBLGn4PeWhhPagXJsDuyfACSPPo
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?0k2xh09BIVmzOxsiAeIev2XfkTiZGqywl7pWt1LZx79lSNu6kMQEhOCiT92E?=
 =?us-ascii?Q?HFV1yCgb6RJp+Ffc2u391Nfjl5d1/89HcoW+0bvgJoiryoZr3oWfHXNuV9EV?=
 =?us-ascii?Q?UnIgthiMn9x7P2o+8dyu5kMmzfDS6JNOLnBsLBWywrL/k95AUDEVCJNpaaBG?=
 =?us-ascii?Q?0PRkMShI/l2M8KeeAUpsVq9+p34hPAGTWt5zSkwCn/wbXprYzp8dV2lneF31?=
 =?us-ascii?Q?SfnIpdEBjy4c9OJLf1nVXPqLKtdr3mLzzXwh1bidmRdAErDizVQPx+o4vYk/?=
 =?us-ascii?Q?DECJUsOtK/2rVuQqhxiwAiR8ejbKdFMa4ALvN20fxjP+GHEEhQbeQoiYjDHv?=
 =?us-ascii?Q?x4QEDauP74Hk7qf7xmVfOuRA9sNc3NIlDKw9I1Iiyte8dPSoI2rf6Yw/urR+?=
 =?us-ascii?Q?nARRj45pT7G9BFBVnjjmZtg/TmwwjDxdr/4cwOlmfEekAKw2n3BbIxLk3UFT?=
 =?us-ascii?Q?RElyf1YkW0VLR1DNSIZZ+tM591OYwDpihWtHM52D4fbWXlnmWkVSgKlTHMh1?=
 =?us-ascii?Q?FcB0gVQuUjT2mnwqJzscB2lC3OzthAe62bA8YxIZIa1W4pC37wOdR/eGxWqj?=
 =?us-ascii?Q?uKv9m+FBR7+Ov/vZy9RqO7LBgj587uk1s3suXxj4pg6u4SpgrZvy8tXHdfjf?=
 =?us-ascii?Q?FuAXsWCgv6KjISZ20R0YCo4lqOIR7uKW7g2tXcJQ3jatbMluVZf/AdAJvX3R?=
 =?us-ascii?Q?ruRueq8jiEjZL38K+xqrLoX2B+AZ9gwgAcMPIkslUQ8bXOG4FnmNUyYDKkDP?=
 =?us-ascii?Q?GaMppoWCqaES4u5tGRWHYrnP8caAuNWwIz9VGmlHYpOvatHQEWKPdYwGbUnu?=
 =?us-ascii?Q?B6Hp7vOYvSAFTVOHp695izv25yWx/j5KGYnObVUXQ8ibpYq7V/XIgp2N1Xzk?=
 =?us-ascii?Q?M/ER1mKljh27lebYD3O4X4a24QLyMB3Ea64cEt40hioGZUvsbrCalWWW+4EC?=
 =?us-ascii?Q?OXzcXwxBj/xOs8y+R5wu5LRl5eEa/IevMLK7z3/UtLJSgYVkZdvXjEf3YjRU?=
 =?us-ascii?Q?TNIBJAGtWlxOgpj3sZHt4C4YXCWLJFlx8BVOW4LcSUHGAMFUC0PCCakTm69F?=
 =?us-ascii?Q?vOtLpV6zFvOuZGIAa0ppssFjY/wzIzOK5FlFSgSSsGpcQo5ma1we+lrRIcoO?=
 =?us-ascii?Q?TMGjhaiJNaWQq5a88Thp+6iSYMzNMnQY1czyKqW8ZDG/ZO9GDBkZDeGH/LiN?=
 =?us-ascii?Q?9GSHjLr3bH7Ptjtq+9V+S2982Z+jSTcfWlxXPQ=3D=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 732d9606-8282-41c6-4c33-08dc3a21f46a
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Mar 2024 19:01:08.8190
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR02MB8941

From: Rick Edgecombe <rick.p.edgecombe@intel.com> Sent: Wednesday, February=
 21, 2024 6:10 PM
>=20

"Subject:" prefix should be hv_netvsc:

> On TDX it is possible for the untrusted host to cause

Same comment about TDX vs. CoCo VM.

> set_memory_encrypted() or set_memory_decrypted() to fail such that an
> error is returned and the resulting memory is shared. Callers need to tak=
e
> care to handle these errors to avoid returning decrypted (shared) memory =
to
> the page allocator, which could lead to functional or security issues.
>=20
> hv_nstvsc could free decrypted/shared pages if set_memory_decrypted()

s/hv_nstvsc/hv_netvsc/

> fails. Check the decrypted field in the gpadl before freeing in order to
> not leak the memory.
>=20
> Only compile tested.
>=20
> Cc: "K. Y. Srinivasan" <kys@microsoft.com>
> Cc: Haiyang Zhang <haiyangz@microsoft.com>
> Cc: Wei Liu <wei.liu@kernel.org>
> Cc: Dexuan Cui <decui@microsoft.com>
> Cc: linux-hyperv@vger.kernel.org
> Signed-off-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
> ---
>  drivers/net/hyperv/netvsc.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/net/hyperv/netvsc.c b/drivers/net/hyperv/netvsc.c
> index a6fcbda64ecc..2b6ec979a62f 100644
> --- a/drivers/net/hyperv/netvsc.c
> +++ b/drivers/net/hyperv/netvsc.c
> @@ -154,8 +154,11 @@ static void free_netvsc_device(struct rcu_head
> *head)
>  	int i;
>=20
>  	kfree(nvdev->extension);
> -	vfree(nvdev->recv_buf);
> -	vfree(nvdev->send_buf);
> +
> +	if (!nvdev->recv_buf_gpadl_handle.decrypted)
> +		vfree(nvdev->recv_buf);
> +	if (!nvdev->send_buf_gpadl_handle.decrypted)
> +		vfree(nvdev->send_buf);
>  	bitmap_free(nvdev->send_section_map);
>=20
>  	for (i =3D 0; i < VRSS_CHANNEL_MAX; i++) {
> --
> 2.34.1


