Return-Path: <linux-hyperv+bounces-10142-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kFDVJvRc3WmadAkAu9opvQ
	(envelope-from <linux-hyperv+bounces-10142-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Mon, 13 Apr 2026 23:15:32 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1844C3F377B
	for <lists+linux-hyperv@lfdr.de>; Mon, 13 Apr 2026 23:15:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6ECAC307C877
	for <lists+linux-hyperv@lfdr.de>; Mon, 13 Apr 2026 21:08:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 104413859D9;
	Mon, 13 Apr 2026 21:08:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="biUqhy81"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azolkn19010030.outbound.protection.outlook.com [52.103.23.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A118836921C;
	Mon, 13 Apr 2026 21:08:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.23.30
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776114514; cv=fail; b=RtChWOVviOicYqSQGh6cuRYSAjVIj3ndCgOkPhiXZ4YSHN7iW3LUhi421JxinjaQk9SZIQNcRiQNx+KDXPAvecg57Ogrxw7FYGLRDud0v8yrfL25BA14jZZdybvdbY4gwKFuEFle7Y18/3sXooap+JcpiM7pDVRXJ6wTwyBV/uo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776114514; c=relaxed/simple;
	bh=azdrsuYfwZr1131C4qrmYPLDO2IwoaW8xabXgPnNFhQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=hqWQTX/EomNJ57wzzvgvMlNbRYCIDes0ktwg9Bj6zKAPkFfctKklroQhWriNyul/EZ/2m/kjYhmU57virXYB6cMCf5Lwkb0iiK/ls/ocFSbGZk3xXeqgH26h1BpH+FLNnriQZN5QwUNimgzL1/2armv0alSO22XJESkRbEX+f/c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=biUqhy81; arc=fail smtp.client-ip=52.103.23.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NpD4BCis9MB9sdjul8ZYP0mjmCfh5+MGTnucLnSZbubRR8vHgG5zs/TAj6Nyuq7/q7Mwh2Os3XVfXClvRxvpiXheVh2/azh7kCCOwmSABRTd0bYq4tHR7c5Rr9THjyTCRwxN2Gjw73efegHb5BlAfmlhqntyUX3oRSu4V9NlPBbNopj73k62TR8waZURLe/MWArW6o03+Vbg+20G/O4Fm16G/sm+ests1WPZ+RP4LkinFX5hl9zvBb5CIHUhBSxkGez0/XQ6y4paDL/eHvFGqjr7eFmmJTQJAXITscDvAHe/t2T7Yld3LxaVYc39w7TtpZoFn/kdY6m2ymk4Tr8wwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2lgTnP/hJmrKLvE3iLDiWRXbSeUfw49wMWHGwXc2/fU=;
 b=ZVlQEt6FlTMfKBsIpulmSeK1jyt5w7Kk0HCiL2Tezucx1Yu97uVnFplaYAbLBoY1VIQSVBqkyfRGTfFMxwC8FP6aE0Sj0YV1YPs9bMZBYrMI9hURKE7QWbNQenV6Rkq7zyi7lcAqAjsO6ZZQG3gowxsNVLXBBAKKi6A3aycPRUmHlakbwKvaBXkCcCkbrjNPY+9PkQ9SJ1mAl0TjQ7115KgTjnSfSxB4ZAVvdZdPsBJCEUd2+zJO4Wqf51u2bRG1gRiHjiHXQdOChg+koQ3JT5gl/TUQreumD9+jwgMO26LDQjJkVpSyBtpxM0uL9qllmDD6iB0sTmPwizYYxsxWyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2lgTnP/hJmrKLvE3iLDiWRXbSeUfw49wMWHGwXc2/fU=;
 b=biUqhy81YMj2D6NhZ09amfPugMSFLZx/0ED7KRXGfQlLZCEjy6KcGfazmIxBVEybkrTgYBfC4xds95x/lQdlGIdUAuBtnNKJN4idOw7hIJvpDGxZkkT3co0MJ0TbeI9FPP0Wv4XWU++Kzbuc2N7SfKiv3/CnUNYNrjFjIyyBF/FnZ+zm6o5b87X5u74CbDxKnnJVdR5yW/aaPVzP/CNNLbB78eMyhUkwCupufxmxGf5EMmHZCRsbCDjudXM2OpxUu90U/jqbNUHbJbAKIW1HtjuXPkazDAQtwZTH730JNs9hzrwm0EVXJR7s9trTG3iCFp3qWwP3h/iVdrOJtx5tjA==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by CH0PR02MB8057.namprd02.prod.outlook.com (2603:10b6:610:106::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.48; Mon, 13 Apr
 2026 21:08:32 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::900:1ccf:2b1e:52b6]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::900:1ccf:2b1e:52b6%6]) with mapi id 15.20.9769.046; Mon, 13 Apr 2026
 21:08:31 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>,
	"kys@microsoft.com" <kys@microsoft.com>, "haiyangz@microsoft.com"
	<haiyangz@microsoft.com>, "wei.liu@kernel.org" <wei.liu@kernel.org>,
	"decui@microsoft.com" <decui@microsoft.com>, "longli@microsoft.com"
	<longli@microsoft.com>
CC: "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 2/7] mshv: Add support to address range holes remapping
Thread-Topic: [PATCH 2/7] mshv: Add support to address range holes remapping
Thread-Index: AQIU4Z+TtrNiAr8jNsFOwdDCIL2bZAIUeV0jtVyXriA=
Date: Mon, 13 Apr 2026 21:08:31 +0000
Message-ID:
 <SN6PR02MB4157D44B15BAA0F3CA8B078BD4242@SN6PR02MB4157.namprd02.prod.outlook.com>
References:
 <177490099488.81669.3758562641675983608.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
 <177490106397.81669.13650500489059864399.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
In-Reply-To:
 <177490106397.81669.13650500489059864399.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|CH0PR02MB8057:EE_
x-ms-office365-filtering-correlation-id: 4d3e0fe4-61ea-40d4-0b18-08de99a0d158
x-microsoft-antispam:
 BCL:0;ARA:14566002|461199028|13091999003|12121999013|31061999003|8060799015|8062599012|15080799012|41001999006|51005399006|19110799012|37011999003|440099028|3412199025|26121999003|102099032|13041999003|40105399003;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?drR8/e83SMlQtORMcv8bJvCU9jKFIaarSzpy8EopQuJObv0aKsAFVZCioJX6?=
 =?us-ascii?Q?/kOXy0qIxvoQ6iTQFw+qKoO+ZtwbNEwUMIK6vXwB5JRUOD4Ag7BSmxU/6Mdd?=
 =?us-ascii?Q?BO559Lt21nJ1ke/y8zEM3/XujRAlTDGobJuOzX9B26Halb01kfBQ3EiR5+ZH?=
 =?us-ascii?Q?8qNBJ/i7MMQ9w9kFKPKo1hzM4btr8jcw+0AvDlH8ogO2zoEZCN9bgaUekEXV?=
 =?us-ascii?Q?V2H/Y4fzayZ0ArOdhP6Jp0R50IZhyedzuJma2e5EJ0dHMpqLWqvgrp6KDME1?=
 =?us-ascii?Q?FCWbUCp7fooETfHsFJ20/tiALh43wt5ut6gLFnu5lHcdS4I2cbn9t8ff1Tu1?=
 =?us-ascii?Q?TnsjGs40iVA6oK9p+oN6Z9an8Q9IX1tsYC48HYCws1S58twDAvJ0G9rOd2g1?=
 =?us-ascii?Q?Q9JjWUN5x/oI9WwMcjMdewEJP8/SbXS4PKJjdVcTK994KVHfOy1+Nps23wI8?=
 =?us-ascii?Q?JjlYohsWxcWObALXLoe9k1GY8Gy2Ihvh/i2+0XSauO9e+o5jBQY6veSmTL4z?=
 =?us-ascii?Q?lTQDWtc+PtpunuhiyCGK8Idyp5/SAWyT5XA9dJwwgnZWzKl8wAwtQtrJq91S?=
 =?us-ascii?Q?FrIgGfeqqfqG+dqEr5zDVYHnQjgffHUsU4CZ15DuOL0SePz7Zo9U9hTan3H/?=
 =?us-ascii?Q?AcTjLIcXXkJtLJ1u1oWw7D21hB2qTZuZ+R21UcXlNu2OxDvIKDDV5R+gH3bG?=
 =?us-ascii?Q?hCX956yUIDhCMfkAMXkpj9K50/+ZsUC11Joz2fpG8aprQWZ5fyjvKHfjYD87?=
 =?us-ascii?Q?hcLKdNGFUg4pBlsuZeKZKH748TmjIiM/YOMdQYxnRz7Cznt892W7Bg/JBO5Y?=
 =?us-ascii?Q?Mxx1nvlQ4gwjQBwVkJkkpH2Fpoy+oTY5cBtuLl3Aib4n3TxmEph0RZwJ6V4D?=
 =?us-ascii?Q?DYFFIhL+ICRe8AzvOxLyechxFUuZn/9svVtH7U2G0V2brb7oChm5dJJYEeLx?=
 =?us-ascii?Q?wzqE7RTdO4F/TlJPZ8X4zZSdYd9qA1SIrWxDe7iexJG8H40QWAIXiQkA0ziB?=
 =?us-ascii?Q?N4jlGLQmhXVBJSWxk6d0cN1VHfGYWLajpDwVRg/tTsQ43gIqAnsyiSohTOzM?=
 =?us-ascii?Q?q2PPpjNEiTJL6RBtRgOr3vORUYUeh/ruhDQTqAsPpjzEAFH5zmQ=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?dI5QUl3pHOa8FlisjtOJRizF2TKYiAw1/0LeSFn5w0bFsYz2u8BKxXtKGoL7?=
 =?us-ascii?Q?7iQ11wETW6H2aXP9ZFuZs2mEOYlYfm+8GQhR7CDjU7Q+zbYYCUfcIOtnRlBk?=
 =?us-ascii?Q?oli8DusCXBwwkfzveyKbfpIcizrrB2v51/qaOAodyMKThrH9GOcfEJ9SQsN7?=
 =?us-ascii?Q?xH4tvggJh8Wdpg5bFyyT9tmt4XvMTadPq+7Mcu1P/FfAf3iLaHBG6VZCvxGe?=
 =?us-ascii?Q?O/+7PL6X1FtrWmMPKZl1Ou50G5GiQD1p6gwc7tiLE1qT3xlshFi3ofs8U6tM?=
 =?us-ascii?Q?d8fHu7hOZf0lR34FgdUWPt/WAHMcdoRAYvoGbSV+eZIs566C/3wSWN2UEp2e?=
 =?us-ascii?Q?z453mK3ZPDpxLQek+adrZI5+GAfWCOFfjysNbtnGff1dQNY1q6gBqG+4Tb7g?=
 =?us-ascii?Q?lHd78UKj+nPDfjqLHpQnv7C3J3SoAEKd0fZdLr1T+adMVkhZs7nRdCqS2mcu?=
 =?us-ascii?Q?lRS2DhKFgpu6do+qcOcGNktE7UfHZHt+g0CW7y5c9VKlNkCzk4A3H03JO85w?=
 =?us-ascii?Q?nRlu9pYbyA3+URhAw9ykW65UhTZD2vj7RL7bpObBUUvGukpGnc1gpXEWlwvW?=
 =?us-ascii?Q?MVoeTfemdBaLV4lK7i6lIieleawTYkECKPpvYWH1Q3tcQiqcmDTuKQ5Djqip?=
 =?us-ascii?Q?8Hs/uRzDo58zQZH2YInnvaK1iDuYEbWnBtueAaZsubPgcKp/jXuIz42JstqS?=
 =?us-ascii?Q?ru6sWBaTWWW4+0E/4pDupipu4wykHbcCvkPoz0NkF4aHFw2GonBhO7sWUI/r?=
 =?us-ascii?Q?FOSIs/7BO7cOaWZpLnOOMFFAltr1xLAfFDxLp4ODmoJXk/8j4pVQwLinKXAz?=
 =?us-ascii?Q?W2W1oxemjvJZL2VvcSiRF/PIRCUFqByYCq07CC3WRjR6jGFi+/9TmCkXI/zl?=
 =?us-ascii?Q?0plGFEM33s5ILUPkeYQpDMKnG/pbux2Utbw958Yq3DYe5NyIeJLjjbgWCS2m?=
 =?us-ascii?Q?C6V01osvPhvsGQhc+8FZi4qTNVsSST2h/LiEWfUmxMEYdqyumHIlHuaB05PA?=
 =?us-ascii?Q?RRz8+vzz0Lz4UCez4I5hyYiueUcaK+klkgGKQ1LZZULCBXJSDaAYWF0hkjoY?=
 =?us-ascii?Q?hMOMkD6opPrFKtWfltZyyEQls5QDYZdstFYMthrVoz4+4tD8vQ8Q76nymg9W?=
 =?us-ascii?Q?0yEzyb3Ep9e4JWSjLK0RGhpIwd+CCwR+aliZ/yDwAmY5qvbVxsB/vvSs5pf1?=
 =?us-ascii?Q?FhiaXe2eyzjgT1k9pi0IqeyX2vlWqUGX6Pg4jsAz/GpmfmgUvwDm0lFERHMR?=
 =?us-ascii?Q?WZH2dh/JSEfxcL468whXzW7WKESnG7X02cspYRdzNDl3ADMXhJJOfVHCoGQD?=
 =?us-ascii?Q?vGWlvLKAEW/v4QsZEW62x/eNB36Qcu37KEStSGbOo92VPONx73j3y+DaZmxV?=
 =?us-ascii?Q?evMfzbc=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d3e0fe4-61ea-40d4-0b18-08de99a0d158
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Apr 2026 21:08:31.8692
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR02MB8057
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[outlook.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[outlook.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-10142-lists,linux-hyperv=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	URIBL_MULTI_FAIL(0.00)[outlook.com:server fail,SN6PR02MB4157.namprd02.prod.outlook.com:server fail,sea.lore.kernel.org:server fail];
	FREEMAIL_FROM(0.00)[outlook.com];
	TO_DN_SOME(0.00)[];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-hyperv];
	DBL_BLOCKED_OPENRESOLVER(0.00)[SN6PR02MB4157.namprd02.prod.outlook.com:mid,outlook.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 1844C3F377B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com> Sent: Monday=
, March 30, 2026 1:04 PM
>=20
> Consolidate memory region processing to handle both valid and invalid PFN=
s
> uniformly. This eliminates code duplication across remap, unmap, share, a=
nd
> unshare operations by using a common range processing interface.
>=20
> Holes are now remapped with no-access permissions to enable
> hypervisor dirty page tracking for precopy live migration.
>=20
> This refactoring is a precursor to an upcoming change that will map
> present pages in movable regions upon region creation, requiring
> consistent handling of both mapped and unmapped ranges.
>=20
> Signed-off-by: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
> ---
>  drivers/hv/mshv_regions.c |  108
> ++++++++++++++++++++++++++++++++++++++++-----
>  1 file changed, 95 insertions(+), 13 deletions(-)
>=20
> diff --git a/drivers/hv/mshv_regions.c b/drivers/hv/mshv_regions.c
> index b1a707d16c07..ed9c55841140 100644
> --- a/drivers/hv/mshv_regions.c
> +++ b/drivers/hv/mshv_regions.c
> @@ -119,6 +119,57 @@ static long mshv_region_process_pfns(struct mshv_mem=
_region *region,
>  	return count;
>  }
>=20
> +/**
> + * mshv_region_process_hole - Handle a hole (invalid PFNs) in a memory
> + *                            region
> + * @region    : Memory region containing the hole
> + * @flags     : Flags to pass to the handler function
> + * @pfn_offset: Starting PFN offset within the region
> + * @pfn_count : Number of PFNs in the hole
> + * @handler   : Callback function to invoke for the hole
> + *
> + * Invokes the handler function for a contiguous hole with the specified
> + * parameters.
> + *
> + * Return: Number of PFNs handled, or negative error code.
> + */
> +static long mshv_region_process_hole(struct mshv_mem_region *region,
> +				     u32 flags,
> +				     u64 pfn_offset, u64 pfn_count,
> +				     int (*handler)(struct mshv_mem_region *region,
> +						    u32 flags,
> +						    u64 pfn_offset,
> +						    u64 pfn_count,
> +						    bool huge_page))
> +{
> +	long ret;
> +
> +	ret =3D handler(region, flags, pfn_offset, pfn_count, 0);
> +	if (ret)
> +		return ret;
> +
> +	return pfn_count;
> +}
> +
> +static long mshv_region_process_chunk(struct mshv_mem_region *region,
> +				      u32 flags,
> +				      u64 pfn_offset, u64 pfn_count,
> +				      int (*handler)(struct mshv_mem_region *region,
> +						     u32 flags,
> +						     u64 pfn_offset,
> +						     u64 pfn_count,
> +						     bool huge_page))
> +{
> +	if (pfn_valid(region->mreg_pfns[pfn_offset]))
> +		return mshv_region_process_pfns(region, flags,
> +				pfn_offset, pfn_count,
> +				handler);
> +	else
> +		return mshv_region_process_hole(region, flags,
> +				pfn_offset, pfn_count,
> +				handler);
> +}
> +
>  /**
>   * mshv_region_process_range - Processes a range of PFNs in a region.
>   * @region    : Pointer to the memory region structure.
> @@ -146,33 +197,47 @@ static int mshv_region_process_range(struct mshv_me=
m_region *region,
>  						    u64 pfn_count,
>  						    bool huge_page))
>  {
> -	u64 pfn_end;
> +	u64 start, end;
>  	long ret;
>=20
> -	if (check_add_overflow(pfn_offset, pfn_count, &pfn_end))
> +	if (!pfn_count)
> +		return 0;
> +
> +	if (check_add_overflow(pfn_offset, pfn_count, &end))
>  		return -EOVERFLOW;
>=20
> -	if (pfn_end > region->nr_pfns)
> +	if (end > region->nr_pfns)
>  		return -EINVAL;
>=20
> -	while (pfn_count) {
> -		/* Skip non-present pages */
> -		if (!pfn_valid(region->mreg_pfns[pfn_offset])) {
> -			pfn_offset++;
> -			pfn_count--;
> +	start =3D pfn_offset;
> +	end =3D pfn_offset + 1;
> +
> +	while (end < pfn_offset + pfn_count) {
> +		/*
> +		 * Accumulate contiguous pfns with the same validity
> +		 * (valid or not).
> +		 */
> +		if (pfn_valid(region->mreg_pfns[start]) =3D=3D
> +		    pfn_valid(region->mreg_pfns[end])) {
> +			end++;
>  			continue;
>  		}
>=20
> -		ret =3D mshv_region_process_pfns(region, flags,
> -					       pfn_offset, pfn_count,
> -					       handler);
> +		ret =3D mshv_region_process_chunk(region, flags,
> +						start, end - start,
> +						handler);
>  		if (ret < 0)
>  			return ret;
>=20
> -		pfn_offset +=3D ret;
> -		pfn_count -=3D ret;
> +		start +=3D ret;
>  	}
>=20
> +	ret =3D mshv_region_process_chunk(region, flags,
> +					start, end - start,
> +					handler);
> +	if (ret < 0)
> +		return ret;
> +
>  	return 0;
>  }
>=20
> @@ -208,6 +273,9 @@ static int mshv_region_chunk_share(struct mshv_mem_re=
gion *region,
>  				   u64 pfn_offset, u64 pfn_count,
>  				   bool huge_page)
>  {
> +	if (!pfn_valid(region->mreg_pfns[pfn_offset]))
> +		return -EINVAL;
> +
>  	if (huge_page)
>  		flags |=3D HV_MODIFY_SPA_PAGE_HOST_ACCESS_LARGE_PAGE;
>=20
> @@ -233,6 +301,9 @@ static int mshv_region_chunk_unshare(struct mshv_mem_=
region *region,
>  				     u64 pfn_offset, u64 pfn_count,
>  				     bool huge_page)
>  {
> +	if (!pfn_valid(region->mreg_pfns[pfn_offset]))
> +		return -EINVAL;
> +
>  	if (huge_page)
>  		flags |=3D HV_MODIFY_SPA_PAGE_HOST_ACCESS_LARGE_PAGE;
>=20
> @@ -256,6 +327,14 @@ static int mshv_region_chunk_remap(struct mshv_mem_r=
egion *region,
>  				   u64 pfn_offset, u64 pfn_count,
>  				   bool huge_page)
>  {
> +	/*
> +	 * Remap missing pages with no access to let the
> +	 * hypervisor track dirty pages, enabling precopy live
> +	 * migration.
> +	 */
> +	if (!pfn_valid(region->mreg_pfns[pfn_offset]))
> +		flags =3D HV_MAP_GPA_NO_ACCESS;

Is it OK to wipe out any other flags that might be set? Certainly, any prev=
ious
flags in PERMISSIONS_MASK should be removed, but what about ADJUSTABLE
and NOT_CACHED?

> +
>  	if (huge_page)
>  		flags |=3D HV_MAP_GPA_LARGE_PAGE;
>=20
> @@ -357,6 +436,9 @@ static int mshv_region_chunk_unmap(struct mshv_mem_re=
gion *region,
>  				   u64 pfn_offset, u64 pfn_count,
>  				   bool huge_page)
>  {
> +	if (!pfn_valid(region->mreg_pfns[pfn_offset]))
> +		return 0;
> +
>  	if (huge_page)
>  		flags |=3D HV_UNMAP_GPA_LARGE_PAGE;
>=20
>=20
>=20


