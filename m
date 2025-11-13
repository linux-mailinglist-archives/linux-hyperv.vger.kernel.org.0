Return-Path: <linux-hyperv+bounces-7553-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id CEA70C59D0A
	for <lists+linux-hyperv@lfdr.de>; Thu, 13 Nov 2025 20:43:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 0333D348D5B
	for <lists+linux-hyperv@lfdr.de>; Thu, 13 Nov 2025 19:42:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15C25313296;
	Thu, 13 Nov 2025 19:42:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="IucQNTYd"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azolkn19012037.outbound.protection.outlook.com [52.103.23.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22803313538;
	Thu, 13 Nov 2025 19:42:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.23.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763062923; cv=fail; b=bYbU/miwjCMs/A/sqvMJTPAabT5gAPLfjLQQYBNbW8jYvKD0B7HIFRrRHbK5njNJQKS4xWHOPXPFjO7e5U6o2UxCq52zJPxcDTHQheiouh9lWyoRsWpxVSuyFca3NsStT5L5Ll+zT2O0azyTrtdg+sUjx1OnVURowXGYKw/s1/s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763062923; c=relaxed/simple;
	bh=F9fFmIep1rM+QWnbJ3D6y4MflZsO50phz5fr3D4/f6Y=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=SpEQ4fTJcFboEkThMQbBt6BhIbkQwo+hltdXUVQc070xBx+DbRD/EYyt8Ndfaa7OEBY0oM3opnkv0/MSCq4ks0Oaga6eHk0FHi1bG0KN9WtWVuEtXKsJ5rasfpavJr2BeqinsJNDGYo7F94iTTBWqZifby4jQTE2MkmvZ3bNKdI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=IucQNTYd; arc=fail smtp.client-ip=52.103.23.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZzR59e6EXBHQA8SdMRRGHdZsVch6EorAFKvIotA05TYM9+iaSlGFQlSBRCiTUrgUWpDGBvv5oaMc9GMgqizmD38/M54nuENhBN+/PUk2gZ0PY0L1XYaFBWysl7WG3/4is75rBDI3aT5bVi9jxW76lFrUj21zPaxzIVXF++3lUH8OJl8ubckVQIBCjYIeh5cBjLawtiLykv1fMwYcBTLx+8DamQdUN6QQS5CO9dMsoT1jtRb4Xg5t7QRz+HJVihKcNdQGBRqX6xDPMrKkcxKoa2YfmWqhmf+oCfCi4OLMJorgS0LfrI8StQgL6mfP7hckCtpIRnEDE+baokAk0vOaTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ux32FzVQ6Z/ovZnnWO7XHo1yer/Pho0s3oI06wFkrLc=;
 b=kU6tNYaxJT1dCik8j9DV0qUMSyXyfuUit0bul2VC3kDr/bXJBpwXejUUxgr0eBKHZXD2YNhijh8CaVB80emNoHjHQsjK3RiNistGJ7bQRuawucHsIY1F1/V8AmDTDa6dNKEoOOe/G5VUEM29Q7uQ7bX3ArxDl+suavcMQnaFcYQP8RKs/ytRbY1cl9vkVWpgy6caW28RKJkCm4fVvwkvZjJPm2qNA6lu5vMaT3bHaPgu01Xek0hR4yh/EhcynVARtxL6dBLnMKfWGiYa8rZdhu5tzA3OUzPfCezb/64m6j/1cc0UC70dUK/ZuWvOM2KaiAkz842c6hCuf6+OHIsH8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ux32FzVQ6Z/ovZnnWO7XHo1yer/Pho0s3oI06wFkrLc=;
 b=IucQNTYdKE2QArzNfjG6Dfo4XurVNt8fhq5U5EakIPbwhWNpACGDbywYIFj3htVASIRvl3NaRhD50whUEG5LxbJHSr8MTxPU9ysAkY+50K+0ETteh7rmxTnGEy5uwv2nXlUgI8CDlVZriAkUCVUmWEwxOa8NGG5k/fKGLh7VlyyOWVQ/l1oDLhUVdFX7mZNbChirG2vyY1R8LOcFD6/TQXeXZhU2UqMIRuWlMjGZDnpjHf/EX6qt/41oMMcLXZQCXEMO4G0WgQGUoG9fhSzi38jjJiP0heCpPQDIcs4/KoFlEGnqsb3ZfPSl37YB3OeTVds7KEQJlEVWFCImBjgl/A==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by CYXPR02MB10195.namprd02.prod.outlook.com (2603:10b6:930:d7::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.16; Thu, 13 Nov
 2025 19:41:58 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df%2]) with mapi id 15.20.9320.013; Thu, 13 Nov 2025
 19:41:55 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: Praveen K Paladugu <prapal@linux.microsoft.com>, "kys@microsoft.com"
	<kys@microsoft.com>, "haiyangz@microsoft.com" <haiyangz@microsoft.com>,
	"wei.liu@kernel.org" <wei.liu@kernel.org>, "decui@microsoft.com"
	<decui@microsoft.com>, "tglx@linutronix.de" <tglx@linutronix.de>,
	"mingo@redhat.com" <mingo@redhat.com>, "linux-hyperv@vger.kernel.org"
	<linux-hyperv@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "bp@alien8.de" <bp@alien8.de>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>, "x86@kernel.org"
	<x86@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>, "arnd@arndb.de"
	<arnd@arndb.de>
CC: "anbelski@linux.microsoft.com" <anbelski@linux.microsoft.com>,
	"easwar.hariharan@linux.microsoft.com"
	<easwar.hariharan@linux.microsoft.com>, "nunodasneves@linux.microsoft.com"
	<nunodasneves@linux.microsoft.com>, "skinsburskii@linux.microsoft.com"
	<skinsburskii@linux.microsoft.com>
Subject: RE: [PATCH v4 1/3] hyperv: Add definitions for MSHV sleep state
 configuration
Thread-Topic: [PATCH v4 1/3] hyperv: Add definitions for MSHV sleep state
 configuration
Thread-Index: AQHcUDRFEi6Z4vuUckOumRuYLZoAGrTxBDKg
Date: Thu, 13 Nov 2025 19:41:55 +0000
Message-ID:
 <SN6PR02MB4157FD3C208A593FB391932AD4CDA@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <20251107221700.45957-1-prapal@linux.microsoft.com>
 <20251107221700.45957-2-prapal@linux.microsoft.com>
In-Reply-To: <20251107221700.45957-2-prapal@linux.microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|CYXPR02MB10195:EE_
x-ms-office365-filtering-correlation-id: 404ff4f8-724c-453f-0159-08de22ecb3ca
x-microsoft-antispam:
 BCL:0;ARA:14566002|13091999003|31061999003|461199028|8060799015|41001999006|19110799012|51005399006|8062599012|15080799012|440099028|3412199025|40105399003|102099032;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?ZM4aeZVosG6nWWBmQ9a4ywx1NOgcswVcPm4stXDxeGcZS+X8eUIdjkBhQUR4?=
 =?us-ascii?Q?X6a5sZLBdItDSccXLNe70vkR4isWKsE4H4L93m+N3FpTg26IM2HSkg7s18c0?=
 =?us-ascii?Q?ERuFFqoTrg434DXUYNi6iSNWH0Gxzz1e8vnOeods9C4neIo2OsbfwB4BtTgn?=
 =?us-ascii?Q?COLmWqJVk49s6EA+SARb7Wjc8EzqdHRR/a+jo+YMQcXotMRdZP4yDmv0FSO0?=
 =?us-ascii?Q?6O+4pMaVmkjZmyrnevNplPtAzXF8rHppkv+VBBcqolyAsSW0vok5W1KCT19/?=
 =?us-ascii?Q?f2+uJDzyzomgWxAUHwlz/9ZvjAHj2TNfmYcsxW25Odw7wnP4mpqW1liyQAZ1?=
 =?us-ascii?Q?OrCKWlbbXY4e2maASOiteE56FYaIMfJWWDNmvDEK+5rjXncJRUMdvv9niJdC?=
 =?us-ascii?Q?ajk8UoDDU8h0ekRM+jEbA0sLhIZ7gl5p9DBdCcUEcA9aV/QTFSqU8qFWBtF3?=
 =?us-ascii?Q?v1zd2q9M7bX5meCzImfy9QwOagG0dOhZkoSI3io2HAYujXpTywYtMFa/kUPj?=
 =?us-ascii?Q?Cb2eLvDwY5u4T4/SnEOUe63/3aTcfFhxO9WK5o+HftUjZI5YTPVwDaPhLfiH?=
 =?us-ascii?Q?bE4KuG53djldQUFQww3EYL8ugqYglAdiyV/MyIN1P7NpxWGyhFg9gSimqbnF?=
 =?us-ascii?Q?QBBTSgpgwXX88RSTwHZ+1Ho2mOapUVH6FO14Il5rcHxpcLuKJQe+tDvNpPZD?=
 =?us-ascii?Q?TKK3s6RBQn1gH7QJnaaFhlhlmvG9Q6OxeToYyCjo7P8TtkQSUEy66R0AiK8g?=
 =?us-ascii?Q?cYRn/KcataYnlTOUpiFRFTTraTj3++fk8Y43UrMm5oys7Iew4EQPmofRfCcw?=
 =?us-ascii?Q?40eO2wwelAssuaHUDQtm+V4BnAjx/xpftiZrknAROroey2cM7NSdbeoNKF8w?=
 =?us-ascii?Q?K5Qpoii8SwC7khITo15G6Iegrpw+w6sQOIiBtAx2X/a+Xt8Nsp3bu2IIzUWH?=
 =?us-ascii?Q?pHas/h47B5DTYZA0WHjpv51Qus2Nmrs/VxNRHAD/Q6Y6ouvbwtfMbhl0j00c?=
 =?us-ascii?Q?dchcvoKs0/S31zZtrMBPScmmCp9z+ed6QUMflJqFpYKDpRK6U+4nx2jnOWu5?=
 =?us-ascii?Q?sDHZgXhs1AkX0s6aAl+EJozMMAvt2yxbcaoXLduafjCqwxq85YzihmifE+Qy?=
 =?us-ascii?Q?k+o9XgB+yjRC3tQoJqMDDfcmTsfnjvAzsJefIJV5yM8ECgpJhCMfhlW/tKyU?=
 =?us-ascii?Q?x2UZmWhvuqHRkqm6NJ3WBVenPyxYf8n6PeOF7Q3aNK2h3CuKMmPQz22dZ4c?=
 =?us-ascii?Q?=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?JoWfb+gPBnoFYo3nhtSCJmoSbqlKxSPzGJ780LqAc1Pa9WVitUHKVkSL5zA1?=
 =?us-ascii?Q?z8uUC/dgSd/U6tqkGmvoqzXy6FYR2E4P00mMT1Ts9n4miVDZzkN4+9ENmYb6?=
 =?us-ascii?Q?MWRgiYRuR7o2QT5nhS5kfUJoNWlwtHHnJ/PCZxgB8ifyo0YneojeYXiqbhm0?=
 =?us-ascii?Q?yc4dGi3YFcH2ALwU7keDNgX1RwsbdP9fFTyj2/PhC/5awl9ioJJ5uUlktgHZ?=
 =?us-ascii?Q?rzJB4z8fBNnGMaue7i6EkUrXh6N1CooUpghmkJWLZPtd9Kx+EiXGcd3eJ4fY?=
 =?us-ascii?Q?do+3gHtkNXc5upXmdGrzKo3KENL5pyOUVvHE1Mb7xJnsy7kY/OBLwfhXP55l?=
 =?us-ascii?Q?iDoGa8++j/XWYyG/mBI9iCLLG4TN54I7CZTH+y6kNo+jCnu6lnTLbQ69V4Y4?=
 =?us-ascii?Q?6aTUNT3oAecHijpOiygcSsEN7BXYr++7wg6w4onVk0vJEBk5C9YgSYpaDT6t?=
 =?us-ascii?Q?VPQ8JJapW6gS7VfZaxKdBb+d0S+9ZX+irW4T48W2qATrYcYdWxO1G8H0tRFb?=
 =?us-ascii?Q?wWKunUWASCulFeWu1ke7azF064rv+qdfqVnkd3ZmLwD2xQZJc+WfNf4HaELr?=
 =?us-ascii?Q?2SVeN2U0poi9IhR8gRSCM+9WACpegGfxQSyh9akmj8Vqc9eiJmfvEw97AAFF?=
 =?us-ascii?Q?2UzO7mOGkQdLLsbeJCELdnf2bddzzB+Z43zkcPVj7StFbEWZJ8W5PrHMc5iY?=
 =?us-ascii?Q?4YTvUpTOhUegXdaAYVylWM+hdwz//ZWEBNijY9muDCavn/cB5GqC8Wx6gkiu?=
 =?us-ascii?Q?fndU8fns/u9/iqQcUbm8XJG1u/Uun8pZk8GUheMbBQSyMoMqw/DhcquKKKyG?=
 =?us-ascii?Q?7ZfzNYOn3L8Gc/BnQXWKj9pU9ZmcMuVKL0ayyszthOPsdV6epOsV1tpAmghH?=
 =?us-ascii?Q?xnS8UUV1AqzQuscbTlocAVORC3dD1aYHtdEHK1pMgZe8/ygRvcQogAaWvizG?=
 =?us-ascii?Q?bXSSzXOuCbkYCJWJh9HQnWd2xsfvuzUnSdpbZ5nUerU10cTTk791H1oEaFCN?=
 =?us-ascii?Q?TMh0Wy7cI4VRAwanwooLzybdczEpOVxpWxQ2L+xlzg0mRRwDiExM32sW7tXk?=
 =?us-ascii?Q?/Psc/sjLQ0VHoyvj8AP7RR/jZKcidywNp0X9d+jH88m998jCjS754zNSQ9wy?=
 =?us-ascii?Q?ohKammIfWd6TCAp/4LyjrAyFbw6+dCdLOs9sok77GFnzxP3UAJeCBxWVV/8o?=
 =?us-ascii?Q?P88oXAke1YqDeFD6J7gXvplfpyhzdOO/awCrE2oU2VFFUgxMPGHdqlUic5c?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 404ff4f8-724c-453f-0159-08de22ecb3ca
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Nov 2025 19:41:55.6980
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR02MB10195

From: Praveen K Paladugu <prapal@linux.microsoft.com> Sent: Friday, Novembe=
r 7, 2025 2:17 PM
>=20
> Add the definitions required to configure sleep states in mshv hypervsior=
.
>=20
> Signed-off-by: Praveen K Paladugu <prapal@linux.microsoft.com>
> Co-developed-by: Anatol Belski <anbelski@linux.microsoft.com>
> Signed-off-by: Anatol Belski <anbelski@linux.microsoft.com>
> Reviewed-by: Easwar Hariharan <easwar.hariharan@linux.microsoft.com>
> Reviewed-by: Nuno Das Neves <nunodasneves@linux.microsoft.com>
> ---
>  include/hyperv/hvgdk_mini.h |  4 +++-
>  include/hyperv/hvhdk_mini.h | 33 +++++++++++++++++++++++++++++++++
>  2 files changed, 36 insertions(+), 1 deletion(-)
>=20
> diff --git a/include/hyperv/hvgdk_mini.h b/include/hyperv/hvgdk_mini.h
> index 7499a679e60a..b43fa1c9ed2c 100644
> --- a/include/hyperv/hvgdk_mini.h
> +++ b/include/hyperv/hvgdk_mini.h
> @@ -465,19 +465,21 @@ union hv_vp_assist_msr_contents {	 /*
> HV_REGISTER_VP_ASSIST_PAGE */
>  #define HVCALL_RESET_DEBUG_SESSION			0x006b
>  #define HVCALL_MAP_STATS_PAGE				0x006c
>  #define HVCALL_UNMAP_STATS_PAGE				0x006d
> +#define HVCALL_SET_SYSTEM_PROPERTY			0x006f
>  #define HVCALL_ADD_LOGICAL_PROCESSOR			0x0076
>  #define HVCALL_GET_SYSTEM_PROPERTY			0x007b
>  #define HVCALL_MAP_DEVICE_INTERRUPT			0x007c
>  #define HVCALL_UNMAP_DEVICE_INTERRUPT			0x007d
>  #define HVCALL_RETARGET_INTERRUPT			0x007e
>  #define HVCALL_NOTIFY_PARTITION_EVENT                   0x0087
> +#define HVCALL_ENTER_SLEEP_STATE			0x0084
>  #define HVCALL_NOTIFY_PORT_RING_EMPTY			0x008b
>  #define HVCALL_REGISTER_INTERCEPT_RESULT		0x0091
>  #define HVCALL_ASSERT_VIRTUAL_INTERRUPT			0x0094
>  #define HVCALL_CREATE_PORT				0x0095
>  #define HVCALL_CONNECT_PORT				0x0096
>  #define HVCALL_START_VP					0x0099
> -#define HVCALL_GET_VP_INDEX_FROM_APIC_ID			0x009a
> +#define HVCALL_GET_VP_INDEX_FROM_APIC_ID		0x009a
>  #define HVCALL_FLUSH_GUEST_PHYSICAL_ADDRESS_SPACE	0x00af
>  #define HVCALL_FLUSH_GUEST_PHYSICAL_ADDRESS_LIST	0x00b0
>  #define HVCALL_SIGNAL_EVENT_DIRECT			0x00c0
> diff --git a/include/hyperv/hvhdk_mini.h b/include/hyperv/hvhdk_mini.h
> index f2d7b50de7a4..06cf30deb319 100644
> --- a/include/hyperv/hvhdk_mini.h
> +++ b/include/hyperv/hvhdk_mini.h
> @@ -140,6 +140,7 @@ enum hv_snp_status {
>=20
>  enum hv_system_property {
>  	/* Add more values when needed */
> +	HV_SYSTEM_PROPERTY_SLEEP_STATE =3D 3,
>  	HV_SYSTEM_PROPERTY_SCHEDULER_TYPE =3D 15,
>  	HV_DYNAMIC_PROCESSOR_FEATURE_PROPERTY =3D 21,
>  	HV_SYSTEM_PROPERTY_CRASHDUMPAREA =3D 47,
> @@ -155,6 +156,19 @@ union hv_pfn_range {            /* HV_SPA_PAGE_RANGE=
 */
>  	} __packed;
>  };
>=20
> +enum hv_sleep_state {
> +	HV_SLEEP_STATE_S1 =3D 1,
> +	HV_SLEEP_STATE_S2 =3D 2,
> +	HV_SLEEP_STATE_S3 =3D 3,
> +	HV_SLEEP_STATE_S4 =3D 4,
> +	HV_SLEEP_STATE_S5 =3D 5,
> +	/*
> +	 * After hypervisor has received this, any follow up sleep
> +	 * state registration requests will be rejected.
> +	 */
> +	HV_SLEEP_STATE_LOCK =3D 6
> +};
> +
>  enum hv_dynamic_processor_feature_property {
>  	/* Add more values when needed */
>  	HV_X64_DYNAMIC_PROCESSOR_FEATURE_MAX_ENCRYPTED_PARTITIONS =3D
> 13,
> @@ -184,6 +198,25 @@ struct hv_output_get_system_property {
>  	};
>  } __packed;
>=20
> +struct hv_sleep_state_info {
> +	u32 sleep_state; /* enum hv_sleep_state */
> +	u8 pm1a_slp_typ;
> +	u8 pm1b_slp_typ;
> +} __packed;
> +
> +struct hv_input_set_system_property {
> +	u32 property_id; /* enum hv_system_property */
> +	u32 reserved;
> +	union {
> +		/* More fields to be filled in when needed */
> +		struct hv_sleep_state_info set_sleep_state_info;
> +	};
> +} __packed;

Because struct hv_sleep_state_info is 6 bytes long, this
hypercall input struct ends up being 14 bytes long, which is
unusual. Hyper-V almost always makes hypercall input size
a multiple of 8 bytes, though in a few cases the last 4 bytes
might be ignored, making it a multiple of 4 bytes. So I'm
wondering if there should be a 2 byte "reserved" field in
struct hv_sleep_state_info so that everything ends up
being a multiple of 8 bytes.

Since there aren't any fields after such a putative "reserved"
field, there's nothing currently at the wrong offset. But it would
affect how much space gets zero'ed in hv_initialize_sleep_states().
Zero'ing those last 2 bytes might prove useful if future versions
of the hypervisor were to use those 2 bytes for an additional
field or two.

> +
> +struct hv_input_enter_sleep_state {     /* HV_INPUT_ENTER_SLEEP_STATE */
> +	u32 sleep_state;        /* enum hv_sleep_state */
> +} __packed;
> +
>  struct hv_input_map_stats_page {
>  	u32 type; /* enum hv_stats_object_type */
>  	u32 padding;
> --
> 2.51.0


