Return-Path: <linux-hyperv+bounces-4209-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D61CA4D289
	for <lists+linux-hyperv@lfdr.de>; Tue,  4 Mar 2025 05:22:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 48DE11885D81
	for <lists+linux-hyperv@lfdr.de>; Tue,  4 Mar 2025 04:22:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59F0B18A6B7;
	Tue,  4 Mar 2025 04:22:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="W8p/T9gl"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azolkn19010021.outbound.protection.outlook.com [52.103.12.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 848F0225D6;
	Tue,  4 Mar 2025 04:21:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.12.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741062120; cv=fail; b=hz41sD/cYJTfheiHvGH4kUjKC3zI3sK7KkP6GL9igsy/vu7bj6gbMvPz0gqe6AphZvNVtG6E62oZmWbNbfQeQnOQ25ajBs5h31OI2njOSds+JVu2jEJjJffP7spJu7Hg10m0/MFCP2x8EZ8ilIkrroKDDnRcXrOxAhiWubgOth4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741062120; c=relaxed/simple;
	bh=AQQfsD1BNvW9DfR4w2enzQxu/ez76qFB3QeEL7CSRyM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=I9oCzno1qj9YWMLbafOxMo6iI5vyfARXSLlC+oOnugCz1GLtGA6uObAn82bq60rFb3Hs1lXHbSLTqz1oCg3MrqQ7HtijPiTdMNAZgoisqr+ReIzWqtQevPk09o+r7xMjhOt0z1YsyA2SwXrqVsAW8eJnEpF1y7qpegGLgsC6SNA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=W8p/T9gl; arc=fail smtp.client-ip=52.103.12.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NFuy9xc7upuZh1k4p26vfiBlTnMZLpcKr6jXAEwmnAqmHr4w9XirqpECaA7xhsml6SqYHiAeecA4iyVU7es/ntxXIb/uKH5T3vn571h3jUsHItnUdoqGfFMdpe/zJvJ4AbuiD8ZG+NoFvAjgeY5jgWbeiRwXG1xdWtM2Z0V67wuVCuMi8oaoD5i4ZQrQAUilb7aorwtOixWoa5ZRvvIwTONJGN7nh7Al1u5pMIHFj0DwfUsqMOi2YZNqu7TafQCGHuzgrDPwOI+7/vPYKMJ7m0Axhvt9kgUuMZTBsMYSNxwOU0XejimvY8Q38EPP3x5dCxviEuPUwpfIR1/u7OkvMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UY2oMWp3OfauMKYflhkuEHqxxQpnF99J+FJONL+RMY0=;
 b=esvkPEKNm0isBBOR8rUiObAmdv/amvs05J7GDaQu48shxsuEsD9m3uvWTnG+qbnoJ1wBwu6tddqfhwqdhm1f5tMV0uUNh3e14olQXceMWSRh64LRAo/raGaXFmZ84ikSNRfnf0isieHOXHNmc2bfYztUQ5UZIUy3n3U948uXCoNgKkD/Plwua/VWsH5DJmilEcbjQXmhJEMbyT5/6355t4ip6WJU/jv3lXdoyWi6GgyYKZlFvfrn/wTfgzJeLy0yALY3JbUjI/T8BEOqDQ0dP1qPgz0ppKE8hqTSiEAA/oNjY1zjKxkXXLsur+6GrUGppiXh4MODVG9c2ulaYglB6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UY2oMWp3OfauMKYflhkuEHqxxQpnF99J+FJONL+RMY0=;
 b=W8p/T9gl6gILnlIwgSU/E6a6HZ4vQK5iHNn9gvy+mf3kdHIRVlE4n2Hcd5nD68uhDhDktq3Eyz3wjDYsqbFuKS1nvMUjmNre9imfWnbd0HT8sj2zcU+sVMEaYmSWXLcFkA1Z/Qi4Y6Dk9q5DMF9IXNcC+dkpISbJheLM3dG39Bupeq7bCHJOhF+a26j4x92rpT0xVd43EGS6RtuxnOJACUzjnLWCDgxJDpqkQhtoXvZ/Cmd6rwucoG6A9HJUrtPJe+dzXnl6XMTQd2MiPOGF6+7ktiBgRRcbjYBbOAEK5rU8wTCw81sr2LyHLjbeMONvYKRc2dJIacjugd7MU8OzDA==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by PH8PR02MB10184.namprd02.prod.outlook.com (2603:10b6:510:224::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.26; Tue, 4 Mar
 2025 04:21:55 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df%3]) with mapi id 15.20.8489.025; Tue, 4 Mar 2025
 04:21:55 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: Roman Kisel <romank@linux.microsoft.com>, "eahariha@linux.microsoft.com"
	<eahariha@linux.microsoft.com>, "kys@microsoft.com" <kys@microsoft.com>,
	"haiyangz@microsoft.com" <haiyangz@microsoft.com>, "wei.liu@kernel.org"
	<wei.liu@kernel.org>, "decui@microsoft.com" <decui@microsoft.com>,
	"James.Bottomley@HansenPartnership.com"
	<James.Bottomley@HansenPartnership.com>, "martin.petersen@oracle.com"
	<martin.petersen@oracle.com>, "linux-hyperv@vger.kernel.org"
	<linux-hyperv@vger.kernel.org>, "linux-scsi@vger.kernel.org"
	<linux-scsi@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
CC: "apais@microsoft.com" <apais@microsoft.com>, "benhill@microsoft.com"
	<benhill@microsoft.com>, "sunilmut@microsoft.com" <sunilmut@microsoft.com>
Subject: RE: [PATCH hyperv-next v2 1/1] scsi: storvsc: Don't report the host
 packet status as the hv status
Thread-Topic: [PATCH hyperv-next v2 1/1] scsi: storvsc: Don't report the host
 packet status as the hv status
Thread-Index: AQHbjJm9EpwhEe8n1UachPV3bNTU47NiYC9g
Date: Tue, 4 Mar 2025 04:21:55 +0000
Message-ID:
 <SN6PR02MB4157DD35957FC26640C6F629D4C82@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <20250304000940.9557-1-romank@linux.microsoft.com>
 <20250304000940.9557-2-romank@linux.microsoft.com>
In-Reply-To: <20250304000940.9557-2-romank@linux.microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|PH8PR02MB10184:EE_
x-ms-office365-filtering-correlation-id: d28f3a16-e422-4902-aacd-08dd5ad418ec
x-microsoft-antispam:
 BCL:0;ARA:14566002|19110799003|8060799006|15080799006|12121999004|461199028|8062599003|41001999003|13041999003|102099032|3412199025|440099028;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?4Gi+ccTRb8bjOCvf/f+LzpBscFKMmqRR5M8//iD/FktBgGMVaA/Py7RXIMmz?=
 =?us-ascii?Q?6+JAZ3I7m1ds7Nb4H7kFsEZn0Nw4kDsjtM0prOj7evGf5MBWanDqNfsDTck0?=
 =?us-ascii?Q?gGPFkKuHVX8JrC3vsGGA4HbSgCsanZkyg95/AVSweglzQFntGkTJFb5naLvy?=
 =?us-ascii?Q?cj2ijySCEl7KL4ZZ3puTDOp1+cRyQTN7z1DmzbsdlmSO/Pi7gsiftTf78olC?=
 =?us-ascii?Q?4jIWo6D8W7IePk0p7TGCUXX7hWW8ilSYq8lLOhSkqCqVXFGO5su9oFpkos+y?=
 =?us-ascii?Q?rBULUkxB1GyTMOFxtv78S3u82Lr+GQvFvvfPAiZvg55PqLJ7laLXWYRiQUv8?=
 =?us-ascii?Q?Jrl1fYaklLvHYOzksXjjVBHapauMU4pkpribtsroQWK7/nDuQTE3mJlrb2LJ?=
 =?us-ascii?Q?i6M1uKSLknZ7Yo2o+AFLzU5uYl0v+F05JWnjjG2KemtTXoT6MDVoTNWuFNqZ?=
 =?us-ascii?Q?OxRPsdc3viMFqx0HeQ2R6XuSBkpIJ5BzK37Q/EGzlsDRFmRgpaSpEQyO/g9B?=
 =?us-ascii?Q?RdH7ddmtHkrYzV3lLCmm84J00zFnH8yYxIHjhnwWmeqee9xmp445HVK8Ad6f?=
 =?us-ascii?Q?S8Ttkk2kClWAwDGUJxm1aAxMtWk0ouLUgabt4lxOev3Eou66r793pSiLIrCY?=
 =?us-ascii?Q?vKEYkmgtb5kKjH5Zmr76cMYj4O7SFEqK4f8vQEZgOhqZkA2djMV8DwKPaMZW?=
 =?us-ascii?Q?MzARl0yTGO9BoMwdWlkJ4b0zoQRKruPyBfJSADGDK+No0S2NGIXcukQfq+8f?=
 =?us-ascii?Q?e2upZu0T2FYHXgF4ZbTdzfpx4N6X+W4Z5o8OWX3HM7UHXs03MXGlruKcJ57l?=
 =?us-ascii?Q?zY5ikuzwr92gRrWTYRmoMDY4LcODPYe+cjRWGl2XJH4XlvRdfDLBBBA7Tar9?=
 =?us-ascii?Q?zGY0B32NJmJj3V+3PFZ736wALEOUC8pbTO3V5dSttIboI/3odh0JDiU0uVih?=
 =?us-ascii?Q?bH34GNY+MlY9UZjQPAiOfBACiOfD+kJlgh5p3SGxYeADi61FjSnikcrMc+Mw?=
 =?us-ascii?Q?ZLloojhu5f3UtxR496O06VhnatlOBUHMOoqeFosHZm+k4NS3F9VJylNBLNun?=
 =?us-ascii?Q?UGTNGgjuxRfTyet8W58EnmDvRmBJ48+3qrR2FOFi9d3SEPwWGarChH5L02Zs?=
 =?us-ascii?Q?jQA1FkI8EHAlPOxEn7B/An5BiR1+DBuAoQ=3D=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?eLfXBrCBeepbBTY1o44gGST+5AQ7+7OXw0ib4UCNkhx1cyvcDJoQDD2IuDtn?=
 =?us-ascii?Q?xMa2cc6YnhP8wlGtZzS/iRhOIVpFI+BzO5uwUnwmOTJzZ1Ziv7Qka0N0vm1G?=
 =?us-ascii?Q?wxZ6I5VWDl3Rspg32aM9yLiN3Y4dWiCOpiUdoR1G5kZT4ik9l36EU0o7qtWw?=
 =?us-ascii?Q?KR7buPA+6YqM6TXJbaPdWU6bpnceT12ECCHpAOilf9b8/u8bIM+WvR7Nm5zT?=
 =?us-ascii?Q?SfDZFbOQQAKCmsEz3xecgWQdA+K8DB9GbT3zlahAQWrvXCRv0AR4lZnerVt9?=
 =?us-ascii?Q?KFdJq7ybeYe2hhNvwfVirzwyM5alyzFiY7z72TIRXGaLSCCHCDN468/wNQdu?=
 =?us-ascii?Q?ZljaC3m6Nin+uV6wHNI2CfcBU7sfzZO1l7xuvhXQOJHBDBw7T1Ampw4pDCpM?=
 =?us-ascii?Q?81dWvrOhTTW8WzyTl+6ezFwCjqxIpHtKoIMJJw3OC6ykw6gy1+Hnf8pdBLzM?=
 =?us-ascii?Q?zGxu6ySjx1FtWMdnqSn+Ujyrwsij2DLanMS+XetQWDusXdsZCm1BfyGow8JC?=
 =?us-ascii?Q?ykK7TrVATVGCjBWkkjY4Yl/wQzsEuf7+JERkl9cKQQE7C+4c3kgYeBcYKgzP?=
 =?us-ascii?Q?J3CCl78Bl4RWKILiyxaM2ghUkT5eJ6ZQteAN11+wy32RzIdpSIKzdqk8Bdvi?=
 =?us-ascii?Q?CaSgM59StWSXgmw0rnG3/XIqVMzDEYtZK6M63mpW14bOm+13EfMpJpw5NNHr?=
 =?us-ascii?Q?0uZckjAmn5C3jGI2idUSAm+hs6aXPxixaDjz8UIdMYSd4Bb9i6PO97ErYRQ3?=
 =?us-ascii?Q?jSdyQbVP/KHVBqXmXolh0zhBUSCFm0bwJ/hZ7jDBBnqkNq29OZpZHa1B8mpt?=
 =?us-ascii?Q?yWQXd1VqxR1IMu9VwDQ0ldlfEhfmYl+gCEBihpV4/dkS60A6L25xOaV6dD6x?=
 =?us-ascii?Q?6x0kdYdICKvkpbVNfpfQgXp8bQJquPHwra/Jl+U/kWxK/MV1UQm3V+v4f404?=
 =?us-ascii?Q?edp5SS2rnBzpAOp42tvbpY7T66u5IfL4ZsX30vpjMUTT9giVyJ+++nWc98ey?=
 =?us-ascii?Q?iZ0XqSx+lxmxvLFORxhk3HMWa8WobGA6nElRKXFNWEwgWd04+mInThGXCvoH?=
 =?us-ascii?Q?kUJbARVf2qv6mldN3YBQxNJeV88f30AeU/6FefdXaMfdfeMuh+yVsIhzdZ9w?=
 =?us-ascii?Q?L+S+hHdHFiPyQ9XwFFjsbu+PvPv4WuC7njT9smvocwSZaGOd/fXdrUqK/+Go?=
 =?us-ascii?Q?fsl5Ok2E2Nh6w9Uw5FWIOiR2O8BdgjKg4KBPKMVO0SoqKd9+lrUlATqfhBg?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: d28f3a16-e422-4902-aacd-08dd5ad418ec
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Mar 2025 04:21:55.3616
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR02MB10184

From: Roman Kisel <romank@linux.microsoft.com> Sent: Monday, March 3, 2025 =
4:10 PM
>=20
> The log statement reports the packet status code as the hv
> status code which causes confusion when debugging as "hv"
> might refer to a hypervisor, and sometimes to the host part
> of the Hyper-V virtualization stack.
>=20
> Fix the name of the datum being logged to clearly indicate
> the component reporting the error. Also log it in hexadecimal
> everywhere for consistency.
>=20
> Signed-off-by: Roman Kisel <romank@linux.microsoft.com>
> ---
>  drivers/scsi/storvsc_drv.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/scsi/storvsc_drv.c b/drivers/scsi/storvsc_drv.c
> index a8614e54544e..35db061ae3ec 100644
> --- a/drivers/scsi/storvsc_drv.c
> +++ b/drivers/scsi/storvsc_drv.c
> @@ -776,7 +776,7 @@ static void  handle_multichannel_storage(struct hv_de=
vice *device, int max_chns)
>=20
>  	if (vstor_packet->operation !=3D VSTOR_OPERATION_COMPLETE_IO ||
>  	    vstor_packet->status !=3D 0) {
> -		dev_err(dev, "Failed to create sub-channel: op=3D%d, sts=3D%d\n",
> +		dev_err(dev, "Failed to create sub-channel: op=3D%d, host=3D0x%x\n",
>  			vstor_packet->operation, vstor_packet->status);
>  		return;
>  	}
> @@ -1183,7 +1183,7 @@ static void storvsc_on_io_completion(struct storvsc=
_device *stor_device,
>  			STORVSC_LOGGING_WARN : STORVSC_LOGGING_ERROR;
>=20
>  		storvsc_log_ratelimited(device, loglevel,
> -			"tag#%d cmd 0x%x status: scsi 0x%x srb 0x%x hv 0x%x\n",
> +			"tag#%d cmd 0x%x status: scsi 0x%x srb 0x%x host 0x%x\n",
>  			scsi_cmd_to_rq(request->cmd)->tag,
>  			stor_pkt->vm_srb.cdb[0],
>  			vstor_packet->vm_srb.scsi_status,

I had not realized that handle_multichannel_storage() was displaying the ho=
st status
in decimal! Ugh.

Reviewed-by: Michael Kelley <mhklinux@outlook.com>

