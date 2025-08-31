Return-Path: <linux-hyperv+bounces-6675-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 02F46B3D418
	for <lists+linux-hyperv@lfdr.de>; Sun, 31 Aug 2025 17:14:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2BF7C7A3C0E
	for <lists+linux-hyperv@lfdr.de>; Sun, 31 Aug 2025 15:13:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 810C826D4E8;
	Sun, 31 Aug 2025 15:14:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="mlJgERT6"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10olkn2061.outbound.protection.outlook.com [40.92.42.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D09DE269CE6;
	Sun, 31 Aug 2025 15:14:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.42.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756653281; cv=fail; b=YHB3Pyf43U28Vyl6cbO/fJMU34+y+KOtjnSEDV0DRr/ENpKSn907eJTImKSqGh2aHQKUo0LLImRkkM3FP4JUxzI843ZQGwNiqteGYtPs6EzSJogM2O9qBkZZeHyJGfTdkO6NZ8pJSN3syD5ABDfJkr9a+U9n/3T1SYNe5s1lNKk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756653281; c=relaxed/simple;
	bh=MY1SvPKDg8qQ4nzczdAwAyvOgAqnydSGNNJPLtgBsSc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=lApEXOw+jWeSOexU9aX40LtrhZARD75WyQfLz4EUoyKFCA0NYgWAg0B8/KqZ4mrx7toB5F1BS8VKSzFHZQITxtFgT/58eoF9HXsJvYmrKrub8ikpUb1I0kzxSPAmDW7epgl9fjglTmJhchpoXM26i65VLJaiJlRATbRpMELBo8Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=mlJgERT6; arc=fail smtp.client-ip=40.92.42.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=N82JmUc+YOdO9mfljgbkiVVi0oBE3q0L0Yvox3B6XVgLXPf2yUiXTvGsOws5FiYe0Co0cVaif4aXnx3uKSNndSiLeSNo2PhQD8tZl1RsJINVkicy66+xl7Bb2sLi97uZbSUTWuJBn1Lkw4A/r5g8Y2y+EKRx5DpTHchMjm8nVXMg4FTByGTQDoa2Ds+C36cCr59ioBxKPKrVyTxGiGFPEeA/aLNO0XHcO7Ci20wBzoIU1w2xOoOs11uqGvzivxy5a6B4eppgZaUd34hjP/BOuB89mUc4Ss6+N4dcUkMO/e+gEg1WHBJ4cRWxIZSiZNZa0i8xhGMsDlF5gug+JUAZMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AEAFKslf6ckmSUz5yaPTc1oUWUS6XLWngdnwHsqI3fI=;
 b=nunHYjcR5B7oPH0Kwo35XZ9eY4SjdBXjJdJ0Z/oQpbH+uKzjJEQqqexD5+6ZlrZ8f8KuPv6eqvaefxPraes2Y+PgnBCi3NMEPfQaj6vzkYxHoJVi8ORGhm+TnKNmSovZ/BX0kNKSuCkfciuQ7b/Rvuyu+5pvEleCJ4VXAYMMLCjh+7gKDpKv0aw7/6iCqYW6nPu3yxzca/i2LrxLiX6ujvxfBbSd+BsFuD9wR8xY+3abQwhQqrJ17mdLBkzgzI5Y6+Zmyepv0hd5a7vj65myKjEc3TKDhOpWJnK2BkJkBFh1gmDlaKQ2DorGPnyobcao9rizinSnKf25KhF6lKWvTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AEAFKslf6ckmSUz5yaPTc1oUWUS6XLWngdnwHsqI3fI=;
 b=mlJgERT6u6hSdpcARBj87zdNfRCunfCw5YkkEq7CoxHBQDSaqiIQ5XjVwUKDD1jTTdeYuZbrjNDIC9zQV42wCtl05HvhOhYhC5cZfjoNpGf3XMThTcX4n02tCz//rUI5VA5NVHSAl9CRbqadQ58OE+4CjN8Pt+0j0YUpuvkxF+Uhp4YGcMoN0Bm1zQAp4Zwu1vlY7HReVGZfPP6ofkVZtq2fbt52/bIChNfJ4fBfGfyHDuBgjiV0t1rNx23S2mYgbT4i7g3/c2POCm2NFi4p+lXzIO9jl3/fA/oSENmEBT0skdLNqbNHO2qsBRl9sB6IGNUOehHMJzHsEh3Dxu2o2A==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by DM3PR02MB10273.namprd02.prod.outlook.com (2603:10b6:0:46::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.27; Sun, 31 Aug
 2025 15:14:38 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df%4]) with mapi id 15.20.9052.019; Sun, 31 Aug 2025
 15:14:38 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: Nuno Das Neves <nunodasneves@linux.microsoft.com>,
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: "kys@microsoft.com" <kys@microsoft.com>, "haiyangz@microsoft.com"
	<haiyangz@microsoft.com>, "wei.liu@kernel.org" <wei.liu@kernel.org>,
	"decui@microsoft.com" <decui@microsoft.com>
Subject: RE: [PATCH] fixup! mshv: Add support for a new parent partition
 configuration
Thread-Topic: [PATCH] fixup! mshv: Add support for a new parent partition
 configuration
Thread-Index: AQHcGSIJjdvxnEFq5EOgHk4XZb0OrrR84Tpw
Date: Sun, 31 Aug 2025 15:14:37 +0000
Message-ID:
 <SN6PR02MB4157682D9C40AF8C00D89399D404A@SN6PR02MB4157.namprd02.prod.outlook.com>
References:
 <1756498672-17603-1-git-send-email-nunodasneves@linux.microsoft.com>
In-Reply-To:
 <1756498672-17603-1-git-send-email-nunodasneves@linux.microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|DM3PR02MB10273:EE_
x-ms-office365-filtering-correlation-id: b269ea1c-9773-4cac-da8f-08dde8a11a06
x-microsoft-antispam:
 BCL:0;ARA:14566002|8062599012|8060799015|19110799012|13091999003|461199028|31061999003|41001999006|15080799012|3412199025|40105399003|440099028|102099032;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?l/DyqJQ/ZEZnofw46yxaY8/YCsOSsZxbALu+RgB1WnbZcrqPcau0Ic3NR0Ip?=
 =?us-ascii?Q?mVwYuJMiRUstuoggwVGLE8WiJj90j62vQyv5Z4HFS5RRPkKVLsOwvEq7ED/e?=
 =?us-ascii?Q?SloeJpIfCxXOvOs2WAbsEW0ND44ABvl45iw5xGjjApenaj0pp9AVilQ1amoq?=
 =?us-ascii?Q?XDU5GNiwxb0qROJKFO14UBWvHOxftBcrwnxuGI6JsvsEzSSnUIUCqJr2SQDi?=
 =?us-ascii?Q?WIbHP7CWbxkd17KM4U6ZxS2zYdvKyQFJVi9jBxuID33Fb7jRQ7GU+2n9D8iB?=
 =?us-ascii?Q?tEfgkMVAQI8F+zZXCnTTmU9p44YpQ9wl9agdJ4/ASU4qAHcAFBdWAl/6ogGq?=
 =?us-ascii?Q?F+zRq7gI5Cf+z3TmRehLpVdNHYsZFgnO/1wknjk1fJwWeFCrGcIKgye7eSCV?=
 =?us-ascii?Q?DlTFO+pqCy/kqBR/fjWg9Oby9753BcVWNW2Xj7/Fzq/ACGm0RFhvPo2+47aq?=
 =?us-ascii?Q?8L7BsHatkiz0ruPz5i9BHoVgMDQhdLRtY5eisOyzFCrvlHH5xR6XD10v0zkw?=
 =?us-ascii?Q?DMQSD2Sl+LFv7DysUASbJu/JyM6QzzQJh7NwGOFGWM7p4k2X9/lbzdBo+KJp?=
 =?us-ascii?Q?O4B3wz/kZbDH6f5Am1W1mmuXkb+Uba3MnagQEcKUfw34adpqfe6tq5awuobR?=
 =?us-ascii?Q?n+iAmJE5Op5bHJc9aQWfejST5x18h3dD/uFs6pqCnA2LIy25v6DRMvoMEmPK?=
 =?us-ascii?Q?kVHliOFO9A7d6p8K+mcrQPpRIDa/HmXc0llIbyu7AA/8klYmNPTX1+4c5hOa?=
 =?us-ascii?Q?akDddQb10kMPSSPS8yXmwf4EmHUkyXuFxdLQALHwB3JjpOdnNr53214jtKhb?=
 =?us-ascii?Q?LPqOf0h/ehvlcl1X+LusP1zlonYKzx+hp5YLWEkCA+kEDbuSj3ytPXDnUB2K?=
 =?us-ascii?Q?nb2b0fSLxyZrZdk7k6I86PSARV1ZNY6aCSQJFQF2PNbiRqtoHTMi2WdD7REk?=
 =?us-ascii?Q?7lgT8ykL0SlZ1WC8S/Hdz4anJJwiDLK/2qfhQbY3pBD2GWKOju7tLfzJaBQs?=
 =?us-ascii?Q?EuCJ2tePFMoDLdH+ECknn+HlYZHEIWjDMDDCawqvtKJwcCdlAawZT9Jdttb1?=
 =?us-ascii?Q?Bq7/SiE4aGwWsecF8vGsZpUnYCtnleOT1lMfGPFrbTtWLIH/2+7iZX7+5DKD?=
 =?us-ascii?Q?yUYyNelku0QoTROwxUrwMsSZAGMZfCrZe7byfz/HWe2IT0z84Fqbz6azQhvX?=
 =?us-ascii?Q?oul2lVcZUtjZ4aAKV+qx7luCKVwP0AYzTNJVNA=3D=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?u8PowvVwWV9aKYY5F6bYbUnj/7X0GU3rjWrMPcVFqz2VgK6JoxF02+p8jGgG?=
 =?us-ascii?Q?15dH+F4qxFm9aay4/GxoEDHxtjAjlmRp3B53cxHcn6rLCoY68v/wSETEeFHC?=
 =?us-ascii?Q?jkr3QGQh2mTZrWlVib5KlyNKehdTe4BGNEK8vS4TUl6/NW2J2Ok5L1bhXr/C?=
 =?us-ascii?Q?lClT99oHS+uisjWbXGfRyqb2OmxHQ6AaAAC/i1iFSkLeEEuOkqYpJDLUaMAH?=
 =?us-ascii?Q?fP2OShMaT64PumxoHq2TR112qlKZRXbVtGqP6kt9ecaNsEBGVLcw0XzgGEvi?=
 =?us-ascii?Q?TguhzQLZFTxYo2GUMyYjzTISzaVUPhPXEjqOXgpYyDND1dDkk5FfsqavlqbS?=
 =?us-ascii?Q?1xrh9Ch200do0r6OjYNJ9LoIv+e4U1RbvzFwtzE04TlfVIAVVCkzuPDXMn1r?=
 =?us-ascii?Q?jdzanPArsj/pVh/MvGh+snormuUmTzQ5ivkeNccJzPlTjCK8n9H+ZLZ/Kz9W?=
 =?us-ascii?Q?tEqm4mOooa6a/sN5wdWqQVNXXE0f8CnpxINmDciQL7QUlN2DBb9FmXX1wAsq?=
 =?us-ascii?Q?wH2XLPegvhxS7uZLwZhlPlrEo6BwvuBTxcF9p8TNLmjFAmW2wmc7RNbfYtI4?=
 =?us-ascii?Q?GltPXbqwUIjrZv5CfaDwnc39YwMwsN+zjPphO5IJ6xWAAAFWVtlmkYqoFL6F?=
 =?us-ascii?Q?ctykmOtj5ge/MeLg+VOT1nPfBODybGKR1/kH+cH0CRhCwMjZ7c33+XnxCCpW?=
 =?us-ascii?Q?UJ607MmF0W4zNz6Kx3z+bgISHkdIyBJXKPzTMl6dMVboSCl6IAoh4UbwJjTM?=
 =?us-ascii?Q?p/aiHi4Otu1OX+QoWKKnLncwTZvADUJVqpgYVgpuAPUmbizREumZCOyG+krh?=
 =?us-ascii?Q?uYOfDOrOKEvS0NKj99eueIzcrcFupci0qf0NmLn7KJeKvcZnxl10YFWhJ0nO?=
 =?us-ascii?Q?ZyWw9bWatbVz3aKUgUWlNLALppXU6wwXHaBuEuOxJzJivmtGZayFvIR5L2k5?=
 =?us-ascii?Q?NABTUiPD7rFAtwNxV/KCAv5MeUMJ14yFfEXOUmH6H4KSiEwwi6DMl3PJOmzD?=
 =?us-ascii?Q?KR3uJJYL2JwzzzbF2TzIWMIUmIQMRE8DBUK7IdnlbaHsPUmiDiYJ06esPHdS?=
 =?us-ascii?Q?ybZ9j4asx1wYARrdVRylYn5mC3QsFZNMmV0bOQdpuemcOhOHxgbvlDfQkQDr?=
 =?us-ascii?Q?bS3m0bau9HaADACdrJK1+IDSifj3LC8DhwgMGMT3gWeunuCloIIwv1y6YQiE?=
 =?us-ascii?Q?w7bY2JXBiiLfKDfG6nUoQF4ExloXmdxFu3ggra6r0yQRgt9laetfN1lNKo4?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: b269ea1c-9773-4cac-da8f-08dde8a11a06
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Aug 2025 15:14:37.9993
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR02MB10273

From: Nuno Das Neves <nunodasneves@linux.microsoft.com> Sent: Friday, Augus=
t 29, 2025 1:18 PM
>=20
> ---
>  drivers/hv/hv_common.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/hv/hv_common.c b/drivers/hv/hv_common.c
> index 8836cf9fad40..e109a620c83f 100644
> --- a/drivers/hv/hv_common.c
> +++ b/drivers/hv/hv_common.c
> @@ -257,7 +257,7 @@ static void hv_kmsg_dump_register(void)
>=20
>  static inline bool hv_output_page_exists(void)
>  {
> -	return hv_root_partition() || IS_ENABLED(CONFIG_HYPERV_VTL_MODE);
> +	return hv_parent_partition() || IS_ENABLED(CONFIG_HYPERV_VTL_MODE);
>  }
>=20
>  void __init hv_get_partition_id(void)
> --
> 2.34.1
>=20

Reviewed-by: Michael Kelley <mhklinux@outlook.com>


