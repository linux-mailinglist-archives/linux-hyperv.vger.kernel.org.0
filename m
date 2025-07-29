Return-Path: <linux-hyperv+bounces-6437-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 27B9BB152F4
	for <lists+linux-hyperv@lfdr.de>; Tue, 29 Jul 2025 20:41:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0927E1889A4C
	for <lists+linux-hyperv@lfdr.de>; Tue, 29 Jul 2025 18:40:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 715DB29993A;
	Tue, 29 Jul 2025 18:39:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="YEqUA7Ox"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazolkn19010011.outbound.protection.outlook.com [52.103.20.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 929042989A2;
	Tue, 29 Jul 2025 18:39:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.20.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753814391; cv=fail; b=hoeMKdbYE8t1yu/ODJqL41Y9XGSxrt/2L0jSOEgeoWGS2HchTcjEUGPRx5y1UCUUsOlrTRRP+Ki6oyYbE6RQpTjGWvRNeypsapXwqtryS6ETytFcYL5lrKE/j9dyj9Vp5GjLAhM1+KS97qXGNw6bP3BdAUYCjUm+cEtidTWanwA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753814391; c=relaxed/simple;
	bh=spfbBdYgBZnzjJN+IelIhr/Jfs5MKJwv8C62KcMZn0I=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=inpWB/DFGobbq8DPivXB3w5caB50lQY0HWTe8SUJSXXlbuT95a17KS8jRDKXnp2ecyz+l38hmogiUQLk8F2EHwEnesjYsrE44QHdCdOcAk3L4/KknCXphauPUivRoffKIlNbnZyL5k6Ol/jUIuJlLnoPAGJBt0+Llr46vE0dO/M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=YEqUA7Ox; arc=fail smtp.client-ip=52.103.20.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=m9BP4OyEzWn8lpKNf1l5RqHxPEEADWNCiEp87Mq9BbP61NZsdOf/A4++z9ayNqgHolkTyCW53+LG5ztzG9HT6PEUYM/jgv2IfXoygiWJFwD3ceQd48yNLqNspJRjVBjOLrMlxPVU4q8lIyS0laycEX3WQpp9NXXH0PAsOBoBzEq8VNYFTPhPQT4w5ra5n9vx56TNZtSBwAP9CKuM2Zs9+LDgL6/7vvetxZiN+R0NpuEz7sDt+mTue0uWLtxgaKU9y3ucOEutTc5E6hOwAoK0wDARIPnNYDC6owQLihQc3C0z5l2CZFCsNuAqBgUTbrHB+d4qAStLqVQUQTMPZC7Zhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dt6NSzD7YxxcqqNSTVUBAH9MIiA4uM/jn+VTjwOpMHg=;
 b=VpnIZBckBcziDxDsllEB7iWKqrFCOL8ktcPI0KsbvG1UhmL1W/OGur+Hrpq0HwyIwestIWHPkyBggR8wzZLiXkCly6WB1xhqgin/Kx5Q3RvWpMbR6YvM/MBISHAz6R4FdfrDMI5dULhyzuP0oO7R/taU1Yylxl5ox6orhp4cbtGJckOTxO822SlbQeocWgjcz1ccssGgDPIe2gS5XECGj85k4Ge+XPl3ab372WBWxdBD1Vb4UrolXzIfFwlsToGXqlqZVcxckAicjF/9Vv/ewMtGmotEY5nAuhMAMVdXRKsk6d5xRZ791WPIaknq5WnjclFAvNOXoxt9Qv5fG5lXIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dt6NSzD7YxxcqqNSTVUBAH9MIiA4uM/jn+VTjwOpMHg=;
 b=YEqUA7OxKcrREyk4YgyaYhsICjHKgoNDii/4FcL2fqKcm/b2kk9EdMQTf5P50DuyhfoI0fxpyEb8vuBZ3WQX+rKTh3WBES3exMIw4lPKAxS7wfkJqTMdlgmzOTVftO7ySpog4o+BkuIOR7oBgAkg+oCwr032KPAYVWTdw1wbRFKAk4sO2QoTHK12qCmJs6kyllb86BsDuvnVRJhLId8OFHo9y6O0Z8MLeQpBIa7NXOpqmdo15gA39bcRM3sx0KOiDToAINlVwiUAU0HsPlerkBb55fWKEYsuEPddJlNMu54LktDCJZURWEpLXVI1Uuv04xtopAW9HWQZxRr+odSlOw==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by SJ0PR02MB8626.namprd02.prod.outlook.com (2603:10b6:a03:3fb::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.11; Tue, 29 Jul
 2025 18:39:45 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df%4]) with mapi id 15.20.8989.010; Tue, 29 Jul 2025
 18:39:45 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: Naman Jain <namjain@linux.microsoft.com>, "stable@vger.kernel.org"
	<stable@vger.kernel.org>, Wei Liu <wei.liu@kernel.org>, Dexuan Cui
	<decui@microsoft.com>
CC: "K . Y . Srinivasan" <kys@microsoft.com>, Haiyang Zhang
	<haiyangz@microsoft.com>, Long Li <longli@microsoft.com>, Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>, "linux@weissschuh.net" <linux@weissschuh.net>,
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 6.12] Drivers: hv: Make the sysfs node size for the ring
 buffer dynamic
Thread-Topic: [PATCH 6.12] Drivers: hv: Make the sysfs node size for the ring
 buffer dynamic
Thread-Index: AQHb+5+3htBXBucy0kuMwXQVrrilg7RJdcBA
Date: Tue, 29 Jul 2025 18:39:45 +0000
Message-ID:
 <SN6PR02MB41579080792040E166B5EB69D425A@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <20250723070200.2775-1-namjain@linux.microsoft.com>
In-Reply-To: <20250723070200.2775-1-namjain@linux.microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|SJ0PR02MB8626:EE_
x-ms-office365-filtering-correlation-id: 066d4ca4-0072-4efd-b8d9-08ddcecf4a16
x-microsoft-antispam:
 BCL:0;ARA:14566002|8060799015|8062599012|19110799012|15080799012|41001999006|461199028|3412199025|40105399003|51005399003|440099028|102099032;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?3qOr6HcsQVFSzTA4ETloP/Dfnep/BjO1LaiZSDbCVfKDlp/uUrTLSgUTQpL5?=
 =?us-ascii?Q?UDfC6UKorB/19tc7VYp7kO3Kcg5zzbb4tf/D9UZrv4xLg/J9lGr6pFe8xhuK?=
 =?us-ascii?Q?n6Oa98sbd+XsHz3Gye9nxxQBAyRXD1sOZLpAnL/YDfrkaZ0lAURaoCXib5UH?=
 =?us-ascii?Q?WiOGQJBfQHmijuIW2WCpqJWKq5X1/6994ZY1BhhemcRCb5bcXMEemW3X1SXe?=
 =?us-ascii?Q?v+bi73F6WHwnwPep8F972PNtJcKnkDffZO0Vf8EeaWhJNMKlUv+sPcKblOt7?=
 =?us-ascii?Q?Z+fKFBXoULO2uVhjCiqnX8DCjhwChLpiWpJEsv3eXhx5B24Zy/NwVaz1sh49?=
 =?us-ascii?Q?PI79z33MQOgxfJZuZdv3Tpm+06/9IJDQiyY2GgIEu00d7LhTUnNzTOeTYXS+?=
 =?us-ascii?Q?5lLTPirxLET/nskN4PGCJf8xOS/eDe/jDxBh+SNtBtJJq/ZwBFaC9wiijI/9?=
 =?us-ascii?Q?WiimpZ6jyHyUxuTBm9j2mBFjd+OFG1gTHj+dDxgEAo4VRLd6uuhgq5qH06ya?=
 =?us-ascii?Q?XaoyLxbnYlwSREsv4HMJ0GqaiEFH9NwJDPmEMMYbkOxsZVUMwFRxesrstaYO?=
 =?us-ascii?Q?PlgppVWYtGF2X1gR8lsK7Lor/81CveM+/Va8Uiefvm+o93DJMYn6wxD9KiNj?=
 =?us-ascii?Q?dqwkg2eG6dwfpCGSYGN6669pg+RjMUf7tknilVZTdyXOGmN56cNhn9o0vwVJ?=
 =?us-ascii?Q?LQMAWhcMyuG5FR+9uQuCf/Y5wJhVa0tkvLpeRtj/M3iano+WEO+LKikbL2pT?=
 =?us-ascii?Q?vOQ0JcTY6ETqqVzOOdTDbzVvnXbHLZX6FvvwDCZwJiAdMoWBrxRrdrDrmsJi?=
 =?us-ascii?Q?11vCSfzqOJ+ifTnY6F55aB8lh/wJiGeV9/kUXSsJP/hnRRzqnwE+LthlHrVc?=
 =?us-ascii?Q?ovEnloP0OAN4m4td/GqUr9+4JSZbL79/TFIh87NONwYtyjHOOxxzEfVlVWiN?=
 =?us-ascii?Q?j30ANR1KEVYTSo9fN4/I1YXp/p6WID+RUQu+uIYKQ97UTAfIg4jC8BkOiPpL?=
 =?us-ascii?Q?6NAcqU3i+KgMrcN0YnHAQWwa2uJ3qJuB3VyEkf8Pj6WxvvWczG6hys0ioxh+?=
 =?us-ascii?Q?ETe1I3fT6HsxBY9BEpHKAsKxT9es31g8DG0BoWITlw12Ky0iAc+OryV5zS1S?=
 =?us-ascii?Q?7I9RHBXtR2TGcEUTf6uMZJFxW8ulTCzFoeljK0VfbDec63wYP34YQi8=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?Uq+aCwt2RonoSVUZQ/HaTdZfHHxvu8qQspAOgiZlVyL9DgeVol3vyOreqhtE?=
 =?us-ascii?Q?81zdkkR54OcqYaCtOnV2+uFG3Ih2WW/fDVxX3tZ/85V23068/VStHXzujLBC?=
 =?us-ascii?Q?zXgWbfeohfSkLekGljWTovfeaW6l/Q3ARiX0+BvVJP3hWgJjV/tBwTdYMxcv?=
 =?us-ascii?Q?dbiUPUadNFEaGw4epHx4mK0Pi2yFqjWQB/h0qksLPx4ONkDsAw16ik4aszMs?=
 =?us-ascii?Q?krrKjBU9rlcoXIUzl4OxI3jOy7jww0t2C8129MYQWJ2HN80JLOmwP7BEZWgV?=
 =?us-ascii?Q?gGp0WmJDmgmkw1ACysBidSN29aG3Q62Rt1BEoVYCS+ebFUby4vEjHOl3Z6IU?=
 =?us-ascii?Q?pOGDsJ/KVaSTuKomxfrttBTs0zAIrRWnm8uR3zYqbP0nvoGsj5PLibtirgYv?=
 =?us-ascii?Q?jIn9ZIIpntcHJ2CWByce1kmtu8yeeM/Cu6kjzfdMJqS5f1sz03ZThTw+TdAI?=
 =?us-ascii?Q?l20d+42H+UmWtx4zPQZeUSTuGWITUPYldalDGwkcs8R37Z0iSO4V10nFZYPV?=
 =?us-ascii?Q?tguCrM/LLXgIGz0U5yzWtUGqPQy7VUpGkm8olCBqCnfNZGlwtBAhD3ste/lf?=
 =?us-ascii?Q?gnPDCPib0W06qmvpjcXnkwXRqhUbp5sNujEIRTCTCtY32NmLUT9WJ545dAiD?=
 =?us-ascii?Q?07zRUuXcYfqkExQ9jS9UrX9eMDmurnXIrlHfrx7U/w/PySDWjQe6SlVMiJ27?=
 =?us-ascii?Q?EGp7B5uaS4IHCjwTqnNjGUriwJJZZYrHwxz+kRgM6ADsdoehJnVIA03mIF7l?=
 =?us-ascii?Q?HZmVT4vhW8tQPS5KSuB1I2xR4d+xERJSgSlPks+wFZ132gc+TGqEqHEU7uvB?=
 =?us-ascii?Q?NcpnwfQANamX3Wsg9+e2K9RZio7Z/+c/pPf1VqXVLegAmNEf4jdZ9HB2TMrs?=
 =?us-ascii?Q?V9QsICNGfqA2ulc73cL5zPC4DLUpEhPwQ/orXlG/2HhkTFY+qnWxIPksYZqX?=
 =?us-ascii?Q?p3MrfCSStEn6BeGCfoyIsx9Ig6EGigC4dneutVNat+gDIIPEmnLs47+6pGZd?=
 =?us-ascii?Q?Vi5VhF563cU2RrfUXinorqtaDjcoKe4unLzV84dmp6Z3dKXYFbgn6OPOD6oB?=
 =?us-ascii?Q?6ww5BJ59GlPFC1by9PCAeZZL1xO0Cx2yy2v0CMZ8rSciGj0lr5WfuOr4nDUF?=
 =?us-ascii?Q?qCFNEZrS0KG5jWYe9nAbOrhduyoWEyeE6cPu8hAz7Dn2VeR0gaE/dNQxpiPG?=
 =?us-ascii?Q?sSmzFpOIVwKTUZ+p+573zSnaxDP8Pw04Z8WjA008dJ3Pdb+9QEstfNAqSBI?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 066d4ca4-0072-4efd-b8d9-08ddcecf4a16
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jul 2025 18:39:45.2934
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR02MB8626

From: Naman Jain <namjain@linux.microsoft.com> Sent: Wednesday, July 23, 20=
25 12:02 AM
>=20
> The ring buffer size varies across VMBus channels. The size of sysfs
> node for the ring buffer is currently hardcoded to 4 MB. Userspace
> clients either use fstat() or hardcode this size for doing mmap().
> To address this, make the sysfs node size dynamic to reflect the
> actual ring buffer size for each channel. This will ensure that
> fstat() on ring sysfs node always returns the correct size of
> ring buffer.
>=20
> This is a backport of the upstream commit
> 65995e97a1ca ("Drivers: hv: Make the sysfs node size for the ring buffer =
dynamic")
> with modifications, as the original patch has missing dependencies on
> kernel v6.12.x. The structure "struct attribute_group" does not have
> bin_size field in v6.12.x kernel so the logic of configuring size of
> sysfs node for ring buffer has been moved to
> vmbus_chan_bin_attr_is_visible().
>=20
> Original change was not a fix, but it needs to be backported to fix size
> related discrepancy caused by the commit mentioned in Fixes tag.
>=20
> Fixes: bf1299797c3c ("uio_hv_generic: Align ring size to system page")
> Cc: <stable@vger.kernel.org> # 6.12.x
> Signed-off-by: Naman Jain <namjain@linux.microsoft.com>
> ---
>=20
> This change won't apply on older kernels currently due to missing
> dependencies. I will take care of them after this goes in.
>=20
> I did not retain any Reviewed-by or Tested-by tags, since the code has
> changed completely, while the functionality remains same.
> Requesting Michael, Dexuan, Wei to please review again.
>=20
> ---
>  drivers/hv/vmbus_drv.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/hv/vmbus_drv.c b/drivers/hv/vmbus_drv.c
> index 1f519e925f06..616e63fb2f15 100644
> --- a/drivers/hv/vmbus_drv.c
> +++ b/drivers/hv/vmbus_drv.c
> @@ -1810,7 +1810,6 @@ static struct bin_attribute chan_attr_ring_buffer =
=3D {
>  		.name =3D "ring",
>  		.mode =3D 0600,
>  	},
> -	.size =3D 2 * SZ_2M,
>  	.mmap =3D hv_mmap_ring_buffer_wrapper,
>  };
>  static struct attribute *vmbus_chan_attrs[] =3D {
> @@ -1866,6 +1865,7 @@ static umode_t vmbus_chan_bin_attr_is_visible(struc=
t kobject *kobj,
>  	/* Hide ring attribute if channel's ring_sysfs_visible is set to false =
*/
>  	if (attr =3D=3D  &chan_attr_ring_buffer && !channel->ring_sysfs_visible=
)
>  		return 0;
> +	attr->size =3D channel->ringbuffer_pagecount << PAGE_SHIFT;

Suppose a VM has two devices using UIO, such as DPDK network device with
a 2MiB ring buffer, and an fcopy device with a 16KiB ring buffer. Both devi=
ces
will be referencing the same static instance of chan_attr_ring_buffer, and =
the
.size field it contains. The above statement will change that .size field
between 2MiB and 16KiB as the /sys entries are initially populated, and as
the visibility is changed if the devices are removed and re-instantiated (w=
hich
is much more likely for fcopy than for netvsc). That changing of the .size
value will probably work most of the time, but it's racy if two devices wit=
h
different ring buffer sizes get instantiated or re-instantiated at the same=
 time.

Unfortunately, I don't see a fix, short of backporting support for the
.bin_size function, as this is exactly the problem that function solves.

Michael

>=20
>  	return attr->attr.mode;
>  }
> --
> 2.34.1


