Return-Path: <linux-hyperv+bounces-3347-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 351769D63FF
	for <lists+linux-hyperv@lfdr.de>; Fri, 22 Nov 2024 19:12:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3A7F7B2395A
	for <lists+linux-hyperv@lfdr.de>; Fri, 22 Nov 2024 18:11:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD22E1DE3C9;
	Fri, 22 Nov 2024 18:11:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="bXsjQlK7"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazolkn19012053.outbound.protection.outlook.com [52.103.7.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D881215B97D;
	Fri, 22 Nov 2024 18:11:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.7.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732299101; cv=fail; b=J5DtzWnWX7Hr1cMuY6AFGVyx/YmnqUnsTvCiFyhJxn4hODTRd7/EX4oUrWTrlI9IPOC1uDFF7tFS2dPOmPkfcVoTRb0O0Lx7z9bPtuxLczEcfHKYk8/4LXTL6gJaxtFcwfKt/Jn86YhMqUkLuiq9t6oc1Zw6PSnomZaZPLvGhpg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732299101; c=relaxed/simple;
	bh=PEnHOIsW9CWx5NQwPS+XSChJGJ266Ja8iia41vflW5s=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=sfqHlLsbMRAdD7adlDS2jB2iBT17acr3X6XnoPWIpzoB3OsRUgjPn8V73L8AUpkdkLBt0F8vmHH4SWTEEf4EYyLWClxOjX1en3yvZouM4aibYKV2Z3ymbOxRK/N8eDVZvAk0oRdMLt05KCHA4Gn1JuKUuxXU1oHAlDKvtdtMvx4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=bXsjQlK7; arc=fail smtp.client-ip=52.103.7.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IQjVdoDltf+NR93DyTVIFqMZrTyiA+kO9FZ8x4hD3JvVcE5uMxbsAObLvZ2OEq4pNolrXwACmZFCG2fmFhSole/r+D4mzjFvHVeGpHF6cDzUlohNj1W742j8yB83nl8SQ2G3icZBGI3y0xvL8TehJ4EbhB/m2bcZKRqxiWZvWl8frVwoyZUIH17l9yZvmRU96BAElXEj67JbiCbxEMY6di4zbvDDl4fb2v9LDW9aAmIsr9h3kAww+p97JSUKugDvCunfPNsFGwMPYJ4u+ZOkhpgPd5eQFm5fppdT2akTLvY2v3VsyqIOiIa+B04glguCeAlN8Ds5+c9G/reW7vP3Nw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rhEQmZH2X80e/x8VH9fciIozCph7cFkTwx1wusWZnJo=;
 b=fabOURpIF4YFFZd6FpGIP2UFroPJ/tshjEJAYT3rZ9ThBW7Xnfgc5+a42VDR1xv7+NlVfYA3ckKYdZeaEntIgOTwpK5DWswEAU+upEWDp/iWoeZehwMO9x66/0QWw03csXhFBmdVbEDYi3i+J0Rph+NWkGDLnCOUAUr59VJJDVZ4jibJek2D5wn/21LfOBlxfc1uDHU68pGapSxO3j0LSbXj7YKnJiUK/9PJNY2osvLi5CsbWDO2PhhXs0FfBVxeA2vcTx4x+5o5Fd7Rs5sc4Lkore5pIGp2ZPnogjLi1yrIzRN9p1F4J43D5VnmMRvqhDHibkypVg6xvF7JtpPdlQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rhEQmZH2X80e/x8VH9fciIozCph7cFkTwx1wusWZnJo=;
 b=bXsjQlK7OFAdRG1+XQcQUD7rt82KsV2k/PmfxXm57TAlYjP5y1Vk7CD7ZX9u3GhOWDBHj7Yb4G9TGOhdWIBmSTxym3ZCsIu4GN+57jkGrJdaVMov9eFmmpIevxiu5T8key1vwkJyu4CxoCsqG0a9ZXjMfCNrkpIqgaAmg0GaI87UXhR4L2GScJVxr2GAnsnH4JSd8gSewIQLL65guW2+aVyvXptOIBonZFf3A+EcjNqF9ie016ROtIOb7/+Fe1fSDOFpK3QnlgnbDIEWIPpuST0197ryffWu+nznGpxytT+OUw1GVhYBgQ18QCFtz36SAL9xXe3x+a56wZtSq9n8RA==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by SJ0PR02MB8355.namprd02.prod.outlook.com (2603:10b6:a03:3e7::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8182.18; Fri, 22 Nov
 2024 18:11:36 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df%6]) with mapi id 15.20.8158.024; Fri, 22 Nov 2024
 18:11:36 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: Cathy Avery <cavery@redhat.com>, "kys@microsoft.com" <kys@microsoft.com>,
	"martin.petersen@oracle.com" <martin.petersen@oracle.com>,
	"wei.liu@kernel.org" <wei.liu@kernel.org>, "haiyangz@microsoft.com"
	<haiyangz@microsoft.com>, "decui@microsoft.com" <decui@microsoft.com>,
	"jejb@linux.ibm.com" <jejb@linux.ibm.com>, "linux-hyperv@vger.kernel.org"
	<linux-hyperv@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-scsi@vger.kernel.org"
	<linux-scsi@vger.kernel.org>
CC: "bhull@redhat.com" <bhull@redhat.com>, "emilne@redhat.com"
	<emilne@redhat.com>, "loberman@redhat.com" <loberman@redhat.com>
Subject: RE: [PATCH] scsi: storvsc: Do not flag MAINTENANCE_IN return of
 SRB_STATUS_DATA_OVERRUN as an error
Thread-Topic: [PATCH] scsi: storvsc: Do not flag MAINTENANCE_IN return of
 SRB_STATUS_DATA_OVERRUN as an error
Thread-Index: AQHbPPrzCSHlA72PXEiQzfj0ZnqGwLLDkwHw
Date: Fri, 22 Nov 2024 18:11:35 +0000
Message-ID:
 <SN6PR02MB4157B4A80A1BCF778117DC13D4232@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <20241122162355.2859481-1-cavery@redhat.com>
In-Reply-To: <20241122162355.2859481-1-cavery@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|SJ0PR02MB8355:EE_
x-ms-office365-filtering-correlation-id: afdebe4c-4b00-44ef-683c-08dd0b211a49
x-microsoft-antispam:
 BCL:0;ARA:14566002|8060799006|461199028|8062599003|19110799003|15080799006|3412199025|440099028|102099032;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?uVRknVaIzlhUmpKPMDKyl6QTko+5QXVJwSoJ3pTRmOu3D64SLESEkd6vWvtK?=
 =?us-ascii?Q?t4Lq/iKsqz5ghS5Er/m4mpTaWBkXSzk5Mu7ChbXN2an4uikUItVP5glKHRKO?=
 =?us-ascii?Q?lZ8CTLH31FKMU7l9+tesUiZH/8yGTV3Gu4HdlIPXwM9T8bd9W4skOwVcKoms?=
 =?us-ascii?Q?olGs4yx5kA08KH2NSw6F+QcWNk2YP2h59OolG2b7LMVTwEM4pDBcXa0WDhps?=
 =?us-ascii?Q?1TEyQAQqJ71uqEkJ/SqRX79zzX6kEEWTJvlIHfofGfPyoJEWSWRiCqbL5DSO?=
 =?us-ascii?Q?PtWX9+QxvBih1Ry9U5LuAHxfFMuiJxvROiHwqslLHtrwnabr6alvmIlnjXRt?=
 =?us-ascii?Q?5UXDwE3/+K2vV6GNg01LAf7dx9eUo59ZiyKNC3codeJZKY+tMeFL+tjpA2KY?=
 =?us-ascii?Q?5KQA23lUCVeh4oHrXmTvYYxVITO9aAgPQyzm66pbOWlDq0qMp+JvqfQ3f1jr?=
 =?us-ascii?Q?4uTIzs/fnv8OLcrnKvxV+ZAdpZnOiOSun0yDVi8J3Zo9J+N8hYgssf/fE5aY?=
 =?us-ascii?Q?9RXVblr2anEY98xmCVVKttX/vtqcncfipKrndF9/LD5S3oNjGw5k4cBJ08ne?=
 =?us-ascii?Q?5Y54EEFeB3eRTwWgY81yBl0T2+f/KSiaKLdBat0qaRW0lcFlEhVjBLTo3q9D?=
 =?us-ascii?Q?zpMf7M+xYx3KckYfvU1VjtCJ8OWCYrNW+6/wIDy/IMYhFhDbJUA0gGq1MdPG?=
 =?us-ascii?Q?znY2268VEbH8bZplCNNrhgfzbPyyv2idrMflVeVlRMhjOY1WiseMbnid2LO6?=
 =?us-ascii?Q?whstCrWp+BISLrGWMYxZCxNXldssrGtIwus6IKweYsn4tTdyjlSU1thfjA1d?=
 =?us-ascii?Q?Z0MC5SgoV683iKv7O/IehFx4oEdv7JeK3+yNt+0wAjJGbs9AN15t7brhl6kL?=
 =?us-ascii?Q?uSIUZvzlN8GturlzBsRfBC+0ZB5E/3LdB62kpH3289hPsjnSYHgqPpeiDbE8?=
 =?us-ascii?Q?gf66f4TbzLwGpZFimgAQoSACT/UIWKIFEiDmhmvacGo6r2c3sTQNA8Rh2rep?=
 =?us-ascii?Q?uy9iv7V48tfeqrfloG6gMHvCIQ=3D=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?XvSyZ4UJqUZW06JtLTVwl1KbyeSKt1kXbFFlK7JRgz1zNNK1/NrOWurXDU98?=
 =?us-ascii?Q?iqnK9N3yKS1wWpyQ8mDj6NeC4z9rQJl4A2gf+jA8qHiaqVSlZlEbPJBvJE3O?=
 =?us-ascii?Q?Y19jxNk2ldQ1uwhOcBxWnT4lxp/Mm9kuqe4slYsx60st8jojVYD7I7QVY5OU?=
 =?us-ascii?Q?Jw/dw32NwsrtQl3g0MY60jGTX2kNc4MIxRxfzrm4gtNJPRSoWksdWlvt9O+o?=
 =?us-ascii?Q?pl1YSnacTUVVzm4kupMjXOA5J7EQe9yrOrpiMrGg+O0PkokhpKFS0lh69A1x?=
 =?us-ascii?Q?Otf2oFNv5JbDdDD4uyrAoI2IPUp0EUlvJsLjuaLn5b9vijwXp7d+vAXHKmV0?=
 =?us-ascii?Q?HBMCpbQgRiDMbf6cIW9Ho1TW32blmR0Hmsq30dyKw0HX07zsaB43+JRoxC7f?=
 =?us-ascii?Q?c4TFDFSDej7Ih04Go51RH2ZhOMuTh7/aKYORcYdySmT45qDwDZo5S1K0f8X9?=
 =?us-ascii?Q?gkUrDsJ7tZVYh+KYiDbYE2XHN2QuoF8N3W6gxOYmbZ/UCijXl3cCGVLbHF/6?=
 =?us-ascii?Q?gNgdP+QdBwpf8q82/qDHZ+3YKvyh8damTZcM8RrlNVzoGRugKZ4WJHfQPSQ2?=
 =?us-ascii?Q?y8A2xsXdBjHfmKvv3RTgUcfS8OkDWZcTYkxHomMd7i3TRJBqtX+O+EOmfXJ5?=
 =?us-ascii?Q?uZ/7W2ukBiE5uaLoFKd9qKa6Hb7KP4wrEIpzd4AJE7ScwA9ZQE83TWyc9ijV?=
 =?us-ascii?Q?GDvFrwAB7J0tvCKBcSLZpWh8WG47bYaSfDu3fICYm0/5s1XqP8s5XnXb8GYX?=
 =?us-ascii?Q?/R9KZZxoB73NMgqkkTiZ8kb9JE2767h64J44SnQjgTZa45y8tKTeDSjEorLd?=
 =?us-ascii?Q?tzauX3Kh2NV+H2oB/zhgh0s/53Qo2pcoHwI0ufDAwSWgTpZTM6bBJAqB2bj7?=
 =?us-ascii?Q?LwLb0Guz0noXYCb4KUBYPiMA+aFoYVn+GhbEQofdX5uThTGgG/UlEVXxUms3?=
 =?us-ascii?Q?JSwffEm9Babh32fEwWW8wv2HqTEQdBP5T2yIOuud5pZrdjInCno5Cr2qEKx8?=
 =?us-ascii?Q?TQLQfT7G9KZopLk2ReJzvH0z2uQc4gHcUQqxGBWIjw2dPDNG2Ja5rYRG+po5?=
 =?us-ascii?Q?Learj//RgcScAX4jiHWG5XKNBSBbBnH2TXo1YUqf/+gKRaBjXfpEa8DA6Gnn?=
 =?us-ascii?Q?7c+R+1QuiGRDafE8ol4QCCRrj8GAJei5Xh2RaQ1F12JsoL9iQ39IEHTSWH2v?=
 =?us-ascii?Q?u6Q9rAryVp9l/8+kuv0oTN8WZzDki9dTe+c9iMEXl+2OFAJXwBuaJiEcjws?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: afdebe4c-4b00-44ef-683c-08dd0b211a49
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Nov 2024 18:11:35.9267
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR02MB8355

From: Cathy Avery <cavery@redhat.com> Sent: Friday, November 22, 2024 8:24 =
AM
>=20
> This patch partially reverts
>=20
> 	commit 812fe6420a6e789db68f18cdb25c5c89f4561334
> 	Author: Michael Kelley <mikelley@microsoft.com>
> 	Date:   Fri Aug 25 10:21:24 2023 -0700
>=20
> 	scsi: storvsc: Handle additional SRB status values
>=20
> HyperV does not support MAINTENANCE_IN resulting in FC passthrough
> returning the SRB_STATUS_DATA_OVERRUN value. Now that
> SRB_STATUS_DATA_OVERRUN
> is treated as an error multipath ALUA paths go into a faulty state as mul=
tipath
> ALUA submits RTPG commands via MAINTENANCE_IN.
>=20
> [    3.215560] hv_storvsc 1d69d403-9692-4460-89f9-a8cbcc0f94f3:
> tag#230 cmd 0xa3 status: scsi 0x0 srb 0x12 hv 0xc0000001
> [    3.215572] scsi 1:0:0:32: alua: rtpg failed, result 458752
>=20
> This patch essentially restores the previous handling of MAINTENANCE_IN
> along with supressing any logging noise.
>=20
> Signed-off-by: Cathy Avery <cavery@redhat.com>
> ---
>  drivers/scsi/storvsc_drv.c | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
>=20
> diff --git a/drivers/scsi/storvsc_drv.c b/drivers/scsi/storvsc_drv.c
> index 7ceb982040a5..088fefe40999 100644
> --- a/drivers/scsi/storvsc_drv.c
> +++ b/drivers/scsi/storvsc_drv.c
> @@ -149,6 +149,8 @@ struct hv_fc_wwn_packet {
>  */
>  static int vmstor_proto_version;
>=20
> +static bool hv_dev_is_fc(struct hv_device *hv_dev);
> +
>  #define STORVSC_LOGGING_NONE	0
>  #define STORVSC_LOGGING_ERROR	1
>  #define STORVSC_LOGGING_WARN	2
> @@ -980,6 +982,13 @@ static void storvsc_handle_error(struct vmscsi_reque=
st
> *vm_srb,
>  	void (*process_err_fn)(struct work_struct *work);
>  	struct hv_host_device *host_dev =3D shost_priv(host);
>=20
> +	// HyperV FC does not support MAINTENANCE_IN ignore
> +	if ((scmnd->cmnd[0] =3D=3D MAINTENANCE_IN) &&
> +		(SRB_STATUS(vm_srb->srb_status) =3D=3D SRB_STATUS_DATA_OVERRUN) &&
> +		hv_dev_is_fc(host_dev->dev)) {
> +		return;
> +	}
> +

Could use the following coding instead to avoid the explicit check of srb_s=
tatus:

@@ -981,6 +981,16 @@ static void storvsc_handle_error(struct vmscsi_request=
 *vm_srb,
        struct hv_host_device *host_dev =3D shost_priv(host);

        switch (SRB_STATUS(vm_srb->srb_status)) {
+       case SRB_STATUS_DATA_OVERRUN:
+               /*
+                * Hyper-V does not support MAINTENANCE_IN, resulting in FC
+                * passthrough returning DATA_OVERRUN. But treating as an
+                * error incorrectly puts ALUA paths into a fault state.
+                */
+               if ((scmnd->cmnd[0] =3D=3D MAINTENANCE_IN) &&
+                               hv_dev_is_fc(host_dev->dev))
+                       return;
+               fallthrough;
        case SRB_STATUS_ERROR:
        case SRB_STATUS_ABORTED:
        case SRB_STATUS_INVALID_REQUEST:
@@ -988,7 +998,6 @@ static void storvsc_handle_error(struct vmscsi_request =
*vm_srb,
        case SRB_STATUS_TIMEOUT:
        case SRB_STATUS_SELECTION_TIMEOUT:
        case SRB_STATUS_BUS_RESET:
-       case SRB_STATUS_DATA_OVERRUN:
                if (vm_srb->srb_status & SRB_STATUS_AUTOSENSE_VALID) {
                        /* Check for capacity change */

>  	switch (SRB_STATUS(vm_srb->srb_status)) {
>  	case SRB_STATUS_ERROR:
>  	case SRB_STATUS_ABORTED:
> @@ -1161,6 +1170,12 @@ static void storvsc_on_io_completion(struct storvs=
c_device *stor_device,
>  	stor_pkt->vm_srb.sense_info_length =3D min_t(u8, STORVSC_SENSE_BUFFER_S=
IZE,
>  		vstor_packet->vm_srb.sense_info_length);
>=20
> +	// HyperV FC does not support MAINTENANCE_IN ignore

For consistency, prefer to not use C++ style comments.

> +	if ((SRB_STATUS(vstor_packet->vm_srb.srb_status) =3D=3D SRB_STATUS_DATA=
_OVERRUN) &&
> +		(stor_pkt->vm_srb.cdb[0] =3D=3D MAINTENANCE_IN) &&
> +		hv_dev_is_fc(device))
> +		goto skip_logging;
> +

Just wondering:  There's already a hack earlier in this function for
INQUIRY and MODE_SENSE commands that sets scsi_status and
srb_status to indicate success. What if this case did the same? Then
nothing would be logged, and a special case would not be needed in
storvsc_handle_error().  Or do you still need the error and sense info to
propagate to higher levels?  (in which case what you've done here is OK)

Michael

>  	if (vstor_packet->vm_srb.scsi_status !=3D 0 ||
>  	    vstor_packet->vm_srb.srb_status !=3D SRB_STATUS_SUCCESS) {
>=20
> @@ -1181,6 +1196,7 @@ static void storvsc_on_io_completion(struct storvsc=
_device *stor_device,
>  			vstor_packet->status);
>  	}
>=20
> +skip_logging:
>  	if (vstor_packet->vm_srb.scsi_status =3D=3D SAM_STAT_CHECK_CONDITION &&
>  	    (vstor_packet->vm_srb.srb_status & SRB_STATUS_AUTOSENSE_VALID))
>  		memcpy(request->cmd->sense_buffer,
> --
> 2.42.0


