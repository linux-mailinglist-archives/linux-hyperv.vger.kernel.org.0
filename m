Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F33E480C52
	for <lists+linux-hyperv@lfdr.de>; Tue, 28 Dec 2021 19:04:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231452AbhL1SES (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 28 Dec 2021 13:04:18 -0500
Received: from mail-cusazon11020014.outbound.protection.outlook.com ([52.101.61.14]:48868
        "EHLO na01-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231502AbhL1SER (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 28 Dec 2021 13:04:17 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Xql57pJE15hwWPs4fZ/B9QcTf1edVCDuDs4x+FQ4IxZp9RNHtnzRO7S1PZcb/mt4r+WOIeyIffstTNDSF6p+JXFE2yXBhXzeJW4NaQzIOHJhBMbY44oAL20L2aTgpFURdwcLxMjE193M+1XY4Tcs+sU/QriE1CkVYkepjUocvExrMtCKD62EcgKP1TrU0iFn+oJUFsY/af8rEpCl6nbbRevNTE3ZI+IMb2/UgN9EVkuSTreR51osLQhEWg+skjOIZ4+lk+PHRImkBmuv2i02JGgWsDUX70/abNTwVpfdheszG/lpp+Knw+O3L8Qt0a02wc2DG70BBEIuoD2cq0wK1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hfv7h816d1pI66JxFcqfm67cju3hdxiaQtmFk29oK8A=;
 b=IU0yg8h57LwUlZrhVDyGLZrSkSk4zvBKDakKbQKWQGx50wVPK27pzw8jhU84BNG9IjrQhNw1j5QUBsCph7eQhC27F3wYrpJqoRo5BTsd7ZX61fzFoVHirVH4tDseJlbleQq94LlSu2s7l7uDAMtbQvzY7i9jQEO8pRVR8NSSykJ70BK5aqBrFPOofx8mHtGTdxixiknQVwZAzji0sLnBo4MneQ6jt0y6Pkpj+WtVbNs3HYDAccIdmRXlcu1saD7wqvKaOd2k2qI4WSN5SS5MCNsDgreJ2G8mh484RjpsJ8Qx72zmtR63Xqe7eytSGXA5k9KeO30tu0j+wF3WqKUM8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hfv7h816d1pI66JxFcqfm67cju3hdxiaQtmFk29oK8A=;
 b=g01xZpx6tRxvitPXRM3p0aDtu2Zwjoeg/Z5CFAgjjKUoGDDSqx2f0oWSKDUwTSa5mXtFO9BarYdD7RvZ2dXrf1e1UuRwQPBIdsicTfKqeuwBr+Yw+WzXvCSx04JZr9eIJ+xD1/Y+WL8bRwJ1bZYlFoXgLqe7CN07bT+OP35bELE=
Received: from MWHPR21MB1593.namprd21.prod.outlook.com (2603:10b6:301:7c::11)
 by PH0PR21MB1974.namprd21.prod.outlook.com (2603:10b6:510:19::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4823.8; Tue, 28 Dec
 2021 18:04:11 +0000
Received: from MWHPR21MB1593.namprd21.prod.outlook.com
 ([fe80::4de:2eb4:7729:dd4b]) by MWHPR21MB1593.namprd21.prod.outlook.com
 ([fe80::4de:2eb4:7729:dd4b%6]) with mapi id 15.20.4867.003; Tue, 28 Dec 2021
 18:04:11 +0000
From:   "Michael Kelley (LINUX)" <mikelley@microsoft.com>
To:     YueHaibing <yuehaibing@huawei.com>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "wei.liu@kernel.org" <wei.liu@kernel.org>,
        Dexuan Cui <decui@microsoft.com>,
        "jejb@linux.ibm.com" <jejb@linux.ibm.com>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>,
        Tianyu Lan <Tianyu.Lan@microsoft.com>,
        Long Li <longli@microsoft.com>
CC:     "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2 -next] scsi: storvsc: Fix unsigned comparison to zero
Thread-Topic: [PATCH v2 -next] scsi: storvsc: Fix unsigned comparison to zero
Thread-Index: AQHX+ta2hkoFcgCpmEKSnk86KQZhY6xINKZQ
Date:   Tue, 28 Dec 2021 18:04:11 +0000
Message-ID: <MWHPR21MB1593956D9F46D0AC20C0CDD3D7439@MWHPR21MB1593.namprd21.prod.outlook.com>
References: <20211227040311.54584-1-yuehaibing@huawei.com>
In-Reply-To: <20211227040311.54584-1-yuehaibing@huawei.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=6f2727a7-5dfe-46d3-8bcf-fadbdd4fbb0d;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2021-12-28T18:03:05Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5b51fe4a-fd5b-438c-fb1d-08d9ca2c73bd
x-ms-traffictypediagnostic: PH0PR21MB1974:EE_
x-microsoft-antispam-prvs: <PH0PR21MB1974351FFC24D66F5E8182C8D7439@PH0PR21MB1974.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2733;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: uKPrk+wOoYc/kW9hkZ4IPB3Z+gTCl0a69j+sLxu1l7iyJULbV0rgbCu78Qfr/iO9BaL+xYvILXwB4ZN0/zT3olkBvLe4ClAXkoGC0zhWMCUuHy3GRrfj+ckS460i6JSthCbL6pthPEHHhpniObJdZYHoG0683RlhpKdavJOk4NHrusx3UlDZVNFVhmYX7OXi0ogslrvUpEUBQq8iBQVCYweu75YXlEuLxgG6SmrA6yX5xq0Z4J1BPBnT6jenzj8tkwIzXhpY55S51WPQiaQdk6UR3OoY+Qx2spTZbWnq/mxMO1NN6Gb+EQElpvoejvf4IegsEm6wiTMtD4DkMq/wjz8+/DQkXGO23+yZLPPkjVGRYgFv2G617Nb0VcvwVvMKvvx3le+ZHA66fs1KA9Itlb87uI88Z82Np570YjM8XPqVZ9CKLrT9gPU05DXBW0pMVunNhdfLAQaN51qCJ2hwP/nzxk5r5kEHz9farEW2KwtRrWj87RxfspcPRF0jX9g4lWvpmuWirumitXlZI0jIY1NgAfsTuqkEQTQZhR1dMPo6g9qENeInFdUem0RGpS/7wtctzzO8NhiRAH1d5vXXKMi/voUXpsNxscqTOCCKhlLAHFXdIen+sTBT/ArZECKKaq5lKJRcQhCkfDXvWINQXR9jw0BDBPAnehjgkPzA/LzPd6fY49Q9gbbxhR+9BcMUJ3S7w3Y+JlCBqR/b/SaP7ibJ6nXkbVUqkbKUyjbbEJURQHfaXsv29U0W0KjPhyIjOUlMZmIe/jcnVAdKAvoslQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR21MB1593.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(26005)(2906002)(66476007)(8990500004)(186003)(5660300002)(38100700002)(6506007)(38070700005)(66556008)(64756008)(82950400001)(33656002)(55016003)(83380400001)(86362001)(921005)(8676002)(8936002)(82960400001)(66446008)(4326008)(66946007)(110136005)(9686003)(76116006)(122000001)(10290500003)(54906003)(52536014)(71200400001)(7696005)(508600001)(6636002)(316002)(20210929001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?LYf2Dum0f5nHUxWGzObv66yxSze2U488VvOjFH8BuOBbShIor678owl91XHG?=
 =?us-ascii?Q?ajMmMDF4EwWqBNPcPMpSg+2WWc22NajmLBU1jsdIokXoNlYu70BulNsTczBs?=
 =?us-ascii?Q?LfxbBw65k7du1t+249kDCeYUrfW8tRt3alOaXE+pSOhzuLEUYGOjyiqTHMT+?=
 =?us-ascii?Q?uVL1sXrOhoIm7u79JjkXxLTctQHDJ298RtB3bmdmhGED6SxnZpsFAlljS0Q3?=
 =?us-ascii?Q?G+WQlHKGiUrM9Gp8DbYwrAd3Lmy1VGjbEUSt9Iwi1v4YFzPRvWCbFnlwq+S8?=
 =?us-ascii?Q?gLbDIANaU2ro3Nj6Tx4kZlcizu+E08GzHwfdRFxV8QxnHOt/SAr872/Tkrqz?=
 =?us-ascii?Q?0UdlHPO/rHzUotxLEIl1HDJBNXK1wuC3CkbeVFmV+Sy8fCE7GUDcl8XvL0yw?=
 =?us-ascii?Q?NkFBE1m/Hf25IzO8oaxg88VERP+617uGAOJSe3K2vBEak2DG2ZlCfW9mKwyG?=
 =?us-ascii?Q?0rUIQMkX+9P5q8IJnjIZyTQAniDHscxahX63IG9TRFS+Qwe+z9MynEfNHQtW?=
 =?us-ascii?Q?My3abfXAUDssMofv+VZsbRPzYBbO4p+asIDAbFTUYy9CoEoaOKbcsOYbwM81?=
 =?us-ascii?Q?pwm8ey6T37yGjOC6q5LmgY0ZjQ1yAzl6kISGCJoCDJSjnAayWmnIa/AXtTHG?=
 =?us-ascii?Q?LpJvPkSP6rFqmMDzuvlDcujRw4Mtbmj7IMNC+uP4Riu2853AChJ8y2CFcyGO?=
 =?us-ascii?Q?zTtOgClMf8QCsjAQaJkJWMlDaCpqMVQf+l3FAVLZSEwAkhWz4VlJudc2ZTel?=
 =?us-ascii?Q?SQGJM+nxNPpIljOa9kUY1ZeLkkBLRV2cn/Egsrr9dhIOjSdg6NH8ZGOV2RE5?=
 =?us-ascii?Q?gIN7ajEbX9GvOXuOamArJKa1kLJKPJRjejwx5ir95+b7ux8PJW+UKIh0Jn/0?=
 =?us-ascii?Q?y3OofJFXYyjT2rCyj+HA/o9VXDpCe3pd8mEcgkn1jq/tFnQZA4ZgUeMh1p6k?=
 =?us-ascii?Q?5m1TLE0GuqwctaAPOWtFBqILaLmJGRSwSjYjis1dAZ5tOvpZ1ndcJPdsX9mU?=
 =?us-ascii?Q?ShguPkUWyHEnVFVaPTux1wC1VC/gVDO7ZipBk6jvz+yutiiJkbPC6uhZsSpX?=
 =?us-ascii?Q?ZY/hUmwOBBnwKYNaMvjUDBdwEfrNt3+qfaAhEmVYbYOJcQltw60of4pS6odA?=
 =?us-ascii?Q?xgdFVH7eNgi9hrNNPY+GwnPG1EHxy3L7yhzURMCGJ45r0It59fI0/JO294rx?=
 =?us-ascii?Q?y7/NkAuq12PT2FzTtvfNbuZHIFin2Yv1p6OsksNr3vJ+UijZUgCzou45EKPh?=
 =?us-ascii?Q?Z5C7QUmrGk/sqFlNVZSzddUB+ue9poEN7r+5LEkUUFV/56U2bW8DNEEIQL1m?=
 =?us-ascii?Q?E9oua6z2WZzk0XqAGFK4EpfGNIpXVMzaE12QK9ZIBLc6EVq9gzEN3jWogvJa?=
 =?us-ascii?Q?4HiHVQaW+wDLkVy9JVXI/ihrc6k5n30uLUbCvwKety8jsfIMYau4tkDOrybD?=
 =?us-ascii?Q?l/W91UXeWqH+TxJsBGk6DDRtv4FWjqQPt06w7oLTxn1lhTv2iJRkGGIkH7/E?=
 =?us-ascii?Q?gOhbp5H+/7jKGzSRNFEkOcO4jLvqb4e4+oSAFiicNdTAgvhGleG3cx/7lvW5?=
 =?us-ascii?Q?7qGW7aTHaYSKP75uVoyouYJ3Vh+rkWKxjvF0bIkb6kJkMkBQtigHZjL0hA/C?=
 =?us-ascii?Q?xSEbF3FsePzdyQmYA+uB085bnGYcfm5VvgfDQBSW3wzSUbUPpgK6dcfnEDFO?=
 =?us-ascii?Q?SEtGUw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR21MB1593.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b51fe4a-fd5b-438c-fb1d-08d9ca2c73bd
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Dec 2021 18:04:11.7638
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: IcdUbWaM3RHAw55GBFXqhPwYZDsPB1Bkceg+Do4NKGFQAVVYf57WrkAVe0gPiYpMmK6UA/8aU1/MWaXDFqU6C0hvhhTR2CTYKl9oyqpOQqY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR21MB1974
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

From: YueHaibing <yuehaibing@huawei.com> Sent: Sunday, December 26, 2021 8:=
03 PM
>=20
> The unsigned variable sg_count is being assigned a return value
> from the call to scsi_dma_map() that can return -ENOMEM.
>=20
> Fixes: 743b237c3a7b ("scsi: storvsc: Add Isolation VM support for storvsc=
 driver")
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> ---
> v2: define sg_count as int type
> ---
>  drivers/scsi/storvsc_drv.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
>=20
> diff --git a/drivers/scsi/storvsc_drv.c b/drivers/scsi/storvsc_drv.c
> index ae293600d799..2273b843d9d2 100644
> --- a/drivers/scsi/storvsc_drv.c
> +++ b/drivers/scsi/storvsc_drv.c
> @@ -1753,7 +1753,6 @@ static int storvsc_queuecommand(struct Scsi_Host *h=
ost, struct scsi_cmnd *scmnd)
>  	struct hv_device *dev =3D host_dev->dev;
>  	struct storvsc_cmd_request *cmd_request =3D scsi_cmd_priv(scmnd);
>  	struct scatterlist *sgl;
> -	unsigned int sg_count;
>  	struct vmscsi_request *vm_srb;
>  	struct vmbus_packet_mpb_array  *payload;
>  	u32 payload_sz;
> @@ -1826,18 +1825,17 @@ static int storvsc_queuecommand(struct Scsi_Host =
*host, struct scsi_cmnd *scmnd)
>  	memcpy(vm_srb->cdb, scmnd->cmnd, vm_srb->cdb_length);
>=20
>  	sgl =3D (struct scatterlist *)scsi_sglist(scmnd);
> -	sg_count =3D scsi_sg_count(scmnd);
>=20
>  	length =3D scsi_bufflen(scmnd);
>  	payload =3D (struct vmbus_packet_mpb_array *)&cmd_request->mpb;
>  	payload_sz =3D sizeof(cmd_request->mpb);
>=20
> -	if (sg_count) {
> +	if (scsi_sg_count(scmnd)) {
>  		unsigned long offset_in_hvpg =3D offset_in_hvpage(sgl->offset);
>  		unsigned int hvpg_count =3D HVPFN_UP(offset_in_hvpg + length);
>  		struct scatterlist *sg;
>  		unsigned long hvpfn, hvpfns_to_add;
> -		int j, i =3D 0;
> +		int j, i =3D 0, sg_count;
>=20
>  		if (hvpg_count > MAX_PAGE_BUFFER_COUNT) {
>=20
> --
> 2.17.1

Reviewed-by: Michael Kelley <mikelley@microsoft.com>

