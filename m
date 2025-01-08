Return-Path: <linux-hyperv+bounces-3604-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 695BAA052A2
	for <lists+linux-hyperv@lfdr.de>; Wed,  8 Jan 2025 06:32:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B9F673A43D1
	for <lists+linux-hyperv@lfdr.de>; Wed,  8 Jan 2025 05:32:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2807E1A08B8;
	Wed,  8 Jan 2025 05:32:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="r7dk2iUV"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11olkn2106.outbound.protection.outlook.com [40.92.18.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E582199FAB;
	Wed,  8 Jan 2025 05:32:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.18.106
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736314342; cv=fail; b=cp0ROCKh5E6Wnu83TPiTFN+qED47E2mfRf9utf3xUexWVu8wxOwEr1zwt5MOGrkrd6WJI3fdr8gPQBZ4ys/lU6euODjVaU3zKP9/F0F6YKlHvv6bkUYFKgmO/o38HhmfjeMg7+wkc+tOzBhk0EaPub2kqcn2siDoa1XMeGQS0ps=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736314342; c=relaxed/simple;
	bh=wAWFgCzLXoB5VLNDi7SbcRxqTxg0BsH7BEz4LnwWk5c=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=cezXKlPhxeTRhDToOdqcyOfOV0tJiWrmsaCTIBhL+UEvROOhk90Qtir7y1gLe9t+VRpuMIBXyHl9hRoab4WvUT/X4BonA02Va40Cw+/Dshn6gqZReQ8twdo9KhNPap46kHkRrcfB/MwMPOcXWkqRDEuZ2ds+5dc/SOd0xgT3eK8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=r7dk2iUV; arc=fail smtp.client-ip=40.92.18.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hphW3lfPOu+XmCLzP19w/c0acl/9bRmSev7fYva+C4gYp2WoSvehIBCwlSCCDW4+hk+ZKjLnQIKavQQNEF68cqAtDieVJx69EjNmvPspUyd1BfXnT7yj+cjiTu1pode526nOQ4dvV7FU3PY1yL7k+95jcl7OoxEn8gZSIEMR7a7uIrdYEOQZacDsDvYHPB3F7lAk+cM1uZYVRncXlB7hn8tgSbQ7Durkk2UjnTiIm5nJl1IhLL0EeO0MWM+PkUAUY/gmYLFeSb1XIodoAMK517o3cx1kzOtkIE/wQFPgRCd/9goU+wsqTnc5QjafHKLnFQtjOeo47ZbRc1NxVHMVoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/2yCdXjZdWAClyg4qWLNBaF7555+cSx+BotsFWT/nn8=;
 b=EGDa8IUMct4SzMhsSL0G0BJfT6bsrJVDXCpEMl8ttfrP5+EIGCCjaXrvT/bj2MQO+PYYjold9DxOndobshcOo/6iwsLUgYW7fj5gpGLCjsmzyo9LtthD037sSA977ob7JYTBqJipRlSqySqm9XvQJIUv9+DAPqLLBfhqEU2qsH0IHP1spanCOpew96yy1QB0KwVcGHRm3urlLUBUsY2BybNmPAe06Lo2czrR332RQsWKKtM48BRdOR7v0przE99AhxDKjJlyyJTBNKJlFwWo7Hqt3NZ2AAr5xwEsOmamA6q+WNSmhqyclutp3jkSGU1o0/w2gGv+MuWYtLFFw58WRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/2yCdXjZdWAClyg4qWLNBaF7555+cSx+BotsFWT/nn8=;
 b=r7dk2iUVNsw2A5xgcuDO/GTLp2YoO3Ao7QFm37LQ5DTkfTH3moLollDld2rMBpRLwvqGTfM78xtlYXWcbBiY30hOrHwcc67GO0LX5tJYl5PdFJ6D13Txr+3979DD2iz//zqHmfO6FHAMhukRQ3EQBk52eVUWSyT6VQ4zvq6WI4iQpIEhXWlOBhskMPBA9qYxo2uLW3TnxfMEkDw/bosLXfpO8p5ck2ECl3y0TPekywbuRBttmTENYBmU489pnUUjH0KaTd8F/w8tWPyKB1p0da1svKCbcHXO0LGBT1T5l4HGkX51BklaVp9FC/rJm40BL9loKt6ZeH8nmT9TID9sWQ==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by CH2PR02MB6648.namprd02.prod.outlook.com (2603:10b6:610:7c::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8314.17; Wed, 8 Jan
 2025 05:32:18 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df%2]) with mapi id 15.20.8314.015; Wed, 8 Jan 2025
 05:32:18 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: Easwar Hariharan <eahariha@linux.microsoft.com>, "K. Y. Srinivasan"
	<kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu
	<wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>, Long Li
	<longli@linux.microsoft.com>, Long Li <longli@microsoft.com>, "James E.J.
 Bottomley" <James.Bottomley@HansenPartnership.com>, "Martin K. Petersen"
	<martin.petersen@oracle.com>
CC: Mitchell Levy <levymitchell0@gmail.com>, Mitchell Levy
	<mitchelllevy@linux.microsoft.com>, "linux-hyperv@vger.kernel.org"
	<linux-hyperv@vger.kernel.org>, "linux-scsi@vger.kernel.org"
	<linux-scsi@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, Vijay Balakrishna
	<vijayb@linux.microsoft.com>
Subject: RE: [PATCH] scsi: storvsc: Ratelimit warning logs to prevent VM
 denial of service
Thread-Topic: [PATCH] scsi: storvsc: Ratelimit warning logs to prevent VM
 denial of service
Thread-Index: AQHbYSnJRbSaAvZITUGMoLZZY++OcrMMWWKQ
Date: Wed, 8 Jan 2025 05:32:18 +0000
Message-ID:
 <SN6PR02MB41576E90A65C9ADA0FA14BCCD4122@SN6PR02MB4157.namprd02.prod.outlook.com>
References:
 <20250107-eahariha-ratelimit-storvsc-v1-1-7fc193d1f2b0@linux.microsoft.com>
In-Reply-To:
 <20250107-eahariha-ratelimit-storvsc-v1-1-7fc193d1f2b0@linux.microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|CH2PR02MB6648:EE_
x-ms-office365-filtering-correlation-id: 7ac03c51-be98-42eb-139c-08dd2fa5d13c
x-microsoft-antispam:
 BCL:0;ARA:14566002|19110799003|461199028|8062599003|8060799006|15080799006|10035399004|102099032|3412199025|440099028;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?+QMhYGsQFyO1QTGhnS7KGCK0aUcLBLSIadBwpDQK9BrUtB/GBwkGqKaVdSJu?=
 =?us-ascii?Q?n/CEqs9Qe/Cc7Y6+nQTKJnFBMnfZ8ehn9RisAnl0L2UogPzKc8VijmtrlH6a?=
 =?us-ascii?Q?tCyzsAr3MOs7X2Vm4ngRB9CTTwzkHvs7BJLhyjGbp+tvcWYV73leG/cpbMAr?=
 =?us-ascii?Q?sd+fIl7GISHUkEMIjx9yex9hWFTZsGI4F3bc2j3PbUPBbWOVxzl0ACns3DXn?=
 =?us-ascii?Q?K8h1gdAtqbE2/qnlzs8DKPTGodDu70Hz2gtZhqFAP76S/kwBoJ0+1s4ys9gS?=
 =?us-ascii?Q?2lgeVJrZypYPFaUuXspdjFC2sod4oamVDbL+gIbtL5xlp4wLpG/Sdhinj/vF?=
 =?us-ascii?Q?WuplueovbltUwOFSL6EJOxbNwWkLiikP0g0mbUhED0KNbS/XnPBmDEdQRiWl?=
 =?us-ascii?Q?vTSVUb7ixmFsadr5RB8zKBHqCCWgCYbzJk9lHiwRySZTLy+QuUZ6AYBzKz4s?=
 =?us-ascii?Q?3R7so3+qzdJxG01murMaznbDxHzd7/C0EP0McXbqtahZI4JOgXG4xm9klnYA?=
 =?us-ascii?Q?69qv4hgGOYZY5I2W3KVzX+NYsrFr+VTU3DcuD/H9ElZaX+ae787XQvEEeN83?=
 =?us-ascii?Q?uc8roFbiqXtGgALNaoVExBBA8fcLFGArT8uHblotgNaeSa70TldvlDqfLtxV?=
 =?us-ascii?Q?gTTsi3TRK8nDLF2etAFFFBNhR7bVc0hANbIyAr8x4GEMD4X300AoLCtwfmYr?=
 =?us-ascii?Q?/xwBQxwB8hS0x9FyTuyJihwMQ4F+d01r3HXOJm0ACQOEgteu49ukBEZFUXG+?=
 =?us-ascii?Q?5WRTpGoe98F5lgjIE+nNGJksKYM2LNcYIQXzhEoqTEnfxMPMYGkIimjaeOOx?=
 =?us-ascii?Q?3u1ZhI4L3c2fDFQro3ZzsORgaqMjQMCaOYmdaDS5Z9ZHNerMv2nelZ1Yyvsr?=
 =?us-ascii?Q?Gv5z42+Agjm8YIQgdKitvFTaoo1yfkvLa3p4R7TEhSTvaB2JyfFOzt2Wo6+5?=
 =?us-ascii?Q?HbDbf3M2DeJnsunmUaBaxFO/eH1m08GHNzkMYVtri+Lq7xkOSVM0tcl/01du?=
 =?us-ascii?Q?JW2qP4gTP8zZAgFZ1kPA4pm0j5vn3P/UX6xAvdURisEf267Q8Dp9WSQ+FwGn?=
 =?us-ascii?Q?guUZdK6egl8LENVmNGyRpCTRRNDG0aJMUwda2AjZm1M85YTmN2jplkaTZhgt?=
 =?us-ascii?Q?HqBVvXJQTqP7K+lrIWyMvdZqbsej+uNkdA=3D=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?6ExXfhWZym/Q9gzEx4gbx3j0xz2V07gJEERh/n+1jLm+lqOKxN8dJ3pOndAH?=
 =?us-ascii?Q?38cf9X0OFtuhkAwEy7o2LsQ2ozEQbuwjhIaG4lrfBZd2oNkpDlxGlkMQpuwI?=
 =?us-ascii?Q?mtGzM3Vkbz+xXSZzybr1Cad0DL9UyiS5KcdHTDiAnr4xiG8d/aLBO+fYxPAA?=
 =?us-ascii?Q?BkmSMjv5OYIcOFG4JRQVWbZ1W8JDNYRdPXAH+hUIaQTAOkRvUS9LrcEoakL+?=
 =?us-ascii?Q?Nk6K2x36KrXS3hPxrfPeUj67BgC4AL5HI5MDHjJIrARFx5rHcghEfLCbx+pw?=
 =?us-ascii?Q?zLiUJN8f8ywaPbEhtum9MTczSRp836RqkxfFkHbtN/J3dtndeQlerfgK61oR?=
 =?us-ascii?Q?t3l4FMmU96MHY4pIAqKZdbiR8jsaJYNsf6SXhUxJev4MbM0LV8ddfJpSoQWc?=
 =?us-ascii?Q?O0DHi1NO3XYVbqrAzTTpuFEd0F5nS3z04gjNdxiHgQ2hWGYOWCL8xNS42Bmm?=
 =?us-ascii?Q?Qiytphf3TGhOejiemddVqWy/5BZ12fhJPvdu7X6YNn57Tf2ErLgh88JDk5lM?=
 =?us-ascii?Q?rCPFepzzR5okAqzic9D0ud3Dk0WP+zXJsnJJ1o7YuCQDcHQy0ymcKbwIJPVz?=
 =?us-ascii?Q?5a9YlacSSg4LnvNpAnjLDoSPiMiisn6B1x5dEgOuSPLtYI34Gn7nDztYzSuC?=
 =?us-ascii?Q?oKFn+A9oUwlfi5o6SijE5oQJG+qgjOOoJBcZO+QkaFDX/wlzIS1A2A6UVDXO?=
 =?us-ascii?Q?uGxE8s8zsPmAt/b/boF19vizYOu48CTG5RM0CAkRBQeYRnYn754CYiMZ9w4V?=
 =?us-ascii?Q?OXgNfseo9yw9OpgKDKiAV2EtRb1PjaP25ITp2Fe97k8AuC0OfEpkqDiD3s86?=
 =?us-ascii?Q?jT7W9CcuVRw7Uk8eVzKQ5sIU++QFpbfEMiWZBCkLZCy4XTPFts65vg6BLS4T?=
 =?us-ascii?Q?mM9W4vNy8zqL3EO/VuSUuybf+D8a6zlYo3dpuKUObcvr5Jy1aBXj+x6zPoBm?=
 =?us-ascii?Q?F6B+p23ilj+Vo8v4iKxMQ7bq+8UtH+myht2z2UGKCA3If6pUyI1WnrmQrzG0?=
 =?us-ascii?Q?Qlhk2NdvsBFpCgB09+bOvol8eSQyx7DcfGpJoCdqTifiYMRPwlniHdd4LE+d?=
 =?us-ascii?Q?hCLtVPIpcHRPaJ9J5GbDTuGObKRb0JAk1gdjQMQBqliHtcES2cCkzEv5pWJb?=
 =?us-ascii?Q?7wOvTwuAuW5rB9Zgjj0/zL2tKtJ5WmXgp6S9lvIdNvFNeM1sufoBDsi9vw0o?=
 =?us-ascii?Q?Xv2yGFVmekayXUQGtV09xkRXJTN8EIWX7+RNNZrZnILvAoFlExFI47o4e38?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ac03c51-be98-42eb-139c-08dd2fa5d13c
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jan 2025 05:32:18.2614
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR02MB6648


From: Easwar Hariharan <eahariha@linux.microsoft.com> Sent: Tuesday, Januar=
y 7, 2025 9:29 AM
>=20
> If there's a persistent error in the hypervisor, the scsi warning for
> failed IO can flood the kernel log and max out CPU utilization,
> preventing troubleshooting from the VM side. Ratelimit the warning so
> it doesn't DOS the VM.
>=20
> Closes:
> https://github.com/microsoft/WSL/issues/9173
> Signed-off-by: Easwar Hariharan <eahariha@linux.microsoft.com>
> ---
> If there's a persistent error in the hypervisor, the scsi warning for
> failed IO can overwhelm the kernel log and max out CPU utilization,
> preventing troubleshooting. Ratelimit the warning so it doesn't DOS the
> VM.
>=20
> This is not super critical and can be deferred to an 6.14 rc since it
> mostly occurs when there's a problem with the host disk or filesystem.
> ---
>  drivers/scsi/storvsc_drv.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/scsi/storvsc_drv.c b/drivers/scsi/storvsc_drv.c
> index
> 45665d4aca925a10ce4293edf40cebdc4d4997f2..5a101ac06c478aad9b01072e7a6c
> 5af48219f5c8 100644
> --- a/drivers/scsi/storvsc_drv.c
> +++ b/drivers/scsi/storvsc_drv.c
> @@ -171,6 +171,12 @@ do {
> 	\
>  		dev_warn(&(dev)->device, fmt, ##__VA_ARGS__);	\
>  } while (0)
>=20
> +#define storvsc_log_ratelimited(dev, level, fmt, ...)				\
> +do {										\
> +	if (do_logging(level))							\
> +		dev_warn_ratelimited(&(dev)->device, fmt, ##__VA_ARGS__);	\
> +} while (0)
> +
>  struct vmscsi_request {
>  	u16 length;
>  	u8 srb_status;
> @@ -1176,7 +1182,7 @@ static void storvsc_on_io_completion(struct storvsc=
_device *stor_device,
>  		int loglevel =3D (stor_pkt->vm_srb.cdb[0] =3D=3D TEST_UNIT_READY) ?
>  			STORVSC_LOGGING_WARN : STORVSC_LOGGING_ERROR;
>=20
> -		storvsc_log(device, loglevel,
> +		storvsc_log_ratelimited(device, loglevel,
>  			"tag#%d cmd 0x%x status: scsi 0x%x srb 0x%x hv 0x%x\n",
>  			scsi_cmd_to_rq(request->cmd)->tag,
>  			stor_pkt->vm_srb.cdb[0],
>=20
> ---
> base-commit: 4e16367cfe0ce395f29d0482b78970cce8e1db73
> change-id: 20241023-eahariha-ratelimit-storvsc-b3fe53f02a58
>=20
> Best regards,
> --
> Easwar Hariharan <eahariha@linux.microsoft.com>
>=20

Reviewed-by: Michael Kelley <mhklinux@outlook.com>

