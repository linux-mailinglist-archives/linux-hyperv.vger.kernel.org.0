Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 78761422D8E
	for <lists+linux-hyperv@lfdr.de>; Tue,  5 Oct 2021 18:11:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236427AbhJEQND (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 5 Oct 2021 12:13:03 -0400
Received: from mail-co1nam11on2099.outbound.protection.outlook.com ([40.107.220.99]:9522
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S236402AbhJEQNB (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 5 Oct 2021 12:13:01 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nh+gQ2xn1ZiyZJnClaCcAezo13KdRsWqFSlc50aZGcXQEhYRW8FI31uggdKyEVGZ0iMF1R8/86mgy4P0vSfalO5ab+FnPQtXEUUlLNRTi0fr25WIdBf0sl2zXYDJZlZFVMEiHu+cd9TVqdOugxpvX9m7FIYE90c73R01NiNdYpmldlVyzZTgwQW6ovRJV4oI4KvjzqsR/uOe44vI8JpVBEXCnzDKY3CwS/0tVrR++A+aLhRmQiIkgisoUFBDHIr839GEJ5AiyEi4PdzEHWSwW1LjT6SgxZYJpSqeJKG+6SdhhQmeyrQ33PrkZjzy7yXYP1bLl0ZhCjLgfJFp9To+bQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ehgsRqOdD1J0X0WgS45WTjvg2Re61R1xadzIcetQ6bg=;
 b=Y8ZTXwinQQYSGQmmWIx/U3yjEjwcdKjDvnQSbYSZt+srsaHqK/3ghJw92ha7Iodq8Q6MLTt4n2saa6RHQxZzxv7RwR8pCZyvTiVVaQAj/g7sxuCm3l1FZ+qcu/uQmbIAom2hyhUHDieXOal/cD702yVRaA+87/Dt9NRjjJ8EI9Ya6/TxTx0507B2vEP6QNpjNV4oD8W34MehDHQyJHifqL9OTLsaoYl8nJH1L9HC5TcjYn8fDgK7zdG6aXCN4vfSgQdhr1aj5DOthlHrVfxY4THLDmj89+xSLF+SSbc48XrnfT4HV8jACl0ImHsVnkTxUVRaMBIEXF1qgdLDYxr2ZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ehgsRqOdD1J0X0WgS45WTjvg2Re61R1xadzIcetQ6bg=;
 b=XpB8dTWDQP3mxe2ifAuc1FyJanv2SZ8tnt832z9OypLtDltoRjxpOWuGNvBZmXsGU1ofxbAbGTfUKbeQ5wHWQWqmFsL8S1qODNxE97R3atB6/sD0erX+f6Zhm/THPb7ngTB33MuoD1s46byPg2Hz19Y9ZvMjlFKLM/U407yWfdA=
Received: from MWHPR21MB1593.namprd21.prod.outlook.com (2603:10b6:301:7c::11)
 by MW2PR2101MB1100.namprd21.prod.outlook.com (2603:10b6:302:a::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.1; Tue, 5 Oct
 2021 16:11:05 +0000
Received: from MWHPR21MB1593.namprd21.prod.outlook.com
 ([fe80::6129:c6f7:3f56:c899]) by MWHPR21MB1593.namprd21.prod.outlook.com
 ([fe80::6129:c6f7:3f56:c899%4]) with mapi id 15.20.4587.017; Tue, 5 Oct 2021
 16:11:05 +0000
From:   Michael Kelley <mikelley@microsoft.com>
To:     "Andrea Parri (Microsoft)" <parri.andrea@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>
CC:     KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>,
        "James E . J . Bottomley" <jejb@linux.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Dexuan Cui <decui@microsoft.com>
Subject: RE: [PATCH] scsi: storvsc: Fix validation for unsolicited incoming
 packets
Thread-Topic: [PATCH] scsi: storvsc: Fix validation for unsolicited incoming
 packets
Thread-Index: AQHXud3qUC3u++ARO0md/Bl+ITMuDavEkGRA
Date:   Tue, 5 Oct 2021 16:11:05 +0000
Message-ID: <MWHPR21MB15935C9A0C33A858AFF1A825D7AF9@MWHPR21MB1593.namprd21.prod.outlook.com>
References: <20211005114103.3411-1-parri.andrea@gmail.com>
In-Reply-To: <20211005114103.3411-1-parri.andrea@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=010399b2-572e-4440-bf79-258191f0a25f;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2021-10-05T16:00:05Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 100f7890-b841-4531-aaff-08d9881abbe2
x-ms-traffictypediagnostic: MW2PR2101MB1100:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MW2PR2101MB110025553375E23D19B3B52CD7AF9@MW2PR2101MB1100.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5516;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: +heY1JO4L5NPxyKDG/mgGpBaJ3+rC/ZdIM/YASE1MX1oFxNM8PUW2heedKhEWEPLpvnefI1D/rfi7+unKt8QMmHmIffruMDO+wOBzRIkhW5S4RvM70pWYEAMXnltKvYwhD7X6VqM/0zAqmD8tlxLFx+ffTPmG8+0MFA/Jbj6aYuPFTw/nq549w2j3AP/AS55R39DGHWqgweF69Ze5giKWoS6mCm4P1bC44CO3PX/Wgg92UocdqjwA0S+7toO3pqx2Q6aqEN35gr7HxwwG0Sc6X62FAr/Yd8vV4qcE7/yNV9SytXXwQSC1eh0Y7SrZ4hc+0oO6lsGy+DIzn9riMnoCs5eyPEmP6lUTfJVJIhrZ3wdPsrHLZwPTF6lr9EUUC2Xr9Pc52HUWRVpzzbGMhynL7274j9GnAXhehNoCw3IA6QPyJSdcHkQdRCR32AOk/p5rf+LXjzd418Rhyg05RWo35i+q20zvvjxQ0zklw6xq3SOC9iwUccB1RRVYI8d1dgVblWxWeIZHG6cRCr0Srx6maFGHiUNXoQUqrvXgGHOZZD2eGtRpBwWqRqMzRVFjOxGOeao+OgZQ04ecBSyBpo5B4r56UBg7itaeXwL/6dz/FccZEF+w41UtGUcyE75LnLYEEpaalHOM704Kb3YoWTQyYUzN5h3tPJ5uFEzgv1uA24wCGb2N2KdofZAJejRlfYjaWvXnppixiVk4NmXuVeL4auV7UVo0ZatHGlp0l4SzsibLnjSx+ihJvNnnigwqM82qCIcInwBZxdRFqAxV+sA8RYCVJBDTJk8TmsrSp+TWl0=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR21MB1593.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(64756008)(52536014)(66946007)(66446008)(38070700005)(54906003)(83380400001)(8676002)(8936002)(110136005)(38100700002)(55016002)(316002)(66556008)(186003)(122000001)(2906002)(107886003)(66476007)(966005)(82960400001)(7696005)(508600001)(10290500003)(5660300002)(9686003)(71200400001)(33656002)(8990500004)(26005)(76116006)(6506007)(82950400001)(86362001)(4326008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?mzDg9Z4odVLSKM/Q0DMXLCYlroJEVTofLyr7RmGy0znnRSo1BvI6kZKIk3p5?=
 =?us-ascii?Q?AwzB7W8Zavd49HyKTDjcyyczTyEscHNhouABHehrAsM9LYtujL3x/ffbi9Ia?=
 =?us-ascii?Q?S9wfR0kJJAK9YPImEoSqAXSpjHxSFuDZriJdKnFptBP4/MuGQKsEHbVXOXwa?=
 =?us-ascii?Q?EB7chkz7GOYzNKFhkr14ZQIrrKYPwl87jY2HlnNjvzef+Gn0MGQPX5VX4k1q?=
 =?us-ascii?Q?QkuVtfjnDYaPxHStwaVS4cI/O3PcoE1nAFPykBilZJS1rNNhs58tBpvxC8hu?=
 =?us-ascii?Q?Rah+NmLUWibIrzrqjhCIuZaap6fH6RHHZaOwC5A7f48ErOh961FSzYDbQTBK?=
 =?us-ascii?Q?aN5bQTNgSwQtyafDAec3DvL2bNHLgZC/wSN6vOK9/NXUslZi1zAM2Mf5kpEu?=
 =?us-ascii?Q?n+HsDpUOhfupcWJBymkwnFwbL6ydAlVcqsquhV6F35x+qhQzEK7ds06NxJDx?=
 =?us-ascii?Q?wtx247t5waiDDMrcLcBtJc0Xig4cZPtASadTwlV0PNPuibc84Pnv4OZ6BE2g?=
 =?us-ascii?Q?Pij5xM06Epn3TeLCgx12iaYdiRkDUbY5eOyUBJ+HY+qLD9iMQlTT9ul2/4mk?=
 =?us-ascii?Q?UnZQlo3E8+HtMSjRmm/PEf0NxqJIkcYEChb0AyAry+XaGAaE9UoFzhTo0jZk?=
 =?us-ascii?Q?0p/xcCkADXA4mtsXVnHg8Owiq0hbKpjwksmJwqMgcEpelN3fwD9tPyyQmK0g?=
 =?us-ascii?Q?HebWjGlSqcnCapTzVFWbpHD5xK8Rr4t4osnqcNxjx3vdIQN5yVy+l+i1BEgj?=
 =?us-ascii?Q?ie6QH8UiBprzqMcU81gosWWx6bfD/stP/wmts6R1eo3G9dpM1wAmdseo90ub?=
 =?us-ascii?Q?VV2+lPKoUYeAiKsfdPRpPkPttzmyoKYAQMWexSeF5/Wj1ETPuTi/e/lGsHqO?=
 =?us-ascii?Q?CNcSxjqjm7s3aox4ua4YkjhQXtfERIWELfAzwQSO2NcjFMW/B5WimZpACwGM?=
 =?us-ascii?Q?Q9A18RaR4lRPNTUIM+2ZVSlOpjT6sMNzVN0VZyAzKIcOOPsr/amBoQYK9Xe+?=
 =?us-ascii?Q?jl2kO85t/bIjUbWB+O5lGg97grN8Rilm8p0QISk+wUKP/l8wS2jKhUt02AEy?=
 =?us-ascii?Q?3DCzayIK7sx/Gd15IoTRh3c7gyNjRljISF/Mbl4YE89S0P0O+mLstFdsxFdd?=
 =?us-ascii?Q?Bty6tXAilHxRW8CLA4LG1wTqQfMH6fFdbnb344MrJySHmSLVQ3Wib7pDWxGp?=
 =?us-ascii?Q?4ZdqoxQJAaPyzZh68g7+uu850xAom0eTCy4FD0iS+UpO041ZZDX0E9yJsVxb?=
 =?us-ascii?Q?yF6hsQDpTLiuUZvxV2+Pa5f0e04Yukyol3aocHbEyRbemzNa5+gzT83LN9p+?=
 =?us-ascii?Q?At+kdYszWI5vvFtDgBz4VrWV?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR21MB1593.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 100f7890-b841-4531-aaff-08d9881abbe2
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Oct 2021 16:11:05.0918
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Dvust/jHQbxqdGCuvYYN/5ISipBJfHO0NaQH9rqx7fh2QbILoqcBrLLkozfZ1JdhUEdbt56TyytZXBYsOJjYuqAMCDjmtYcGZ+wp4UPvgaM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR2101MB1100
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

From: Andrea Parri (Microsoft) <parri.andrea@gmail.com> Sent: Tuesday, Octo=
ber 5, 2021 4:41 AM
>=20
> The validation on the length of incoming packets performed in
> storvsc_on_channel_callback() does not apply to unsolicited
> packets with ID of 0 sent by Hyper-V.  Adjust the validation
> for such unsolicited packets.
>=20
> Fixes: 91b1b640b834b2 ("scsi: storvsc: Validate length of incoming packet=
 in storvsc_on_channel_callback()")
> Reported-by: Dexuan Cui <decui@microsoft.com>
> Signed-off-by: Andrea Parri (Microsoft) <parri.andrea@gmail.com>
> Reviewed-by: Haiyang Zhang <haiyangz@microsoft.com>
> ---
> Changes since RFC[1]:
>   - Merge length checks (Haiyang Zhang)
>=20
> [1] https://lore.kernel.org/all/20210928163732.5908-1-parri.andrea@gmail.=
com/T/#u
>=20
>  drivers/scsi/storvsc_drv.c | 13 ++++++++++---
>  1 file changed, 10 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/scsi/storvsc_drv.c b/drivers/scsi/storvsc_drv.c
> index ebbbc1299c625..349c1071a98d4 100644
> --- a/drivers/scsi/storvsc_drv.c
> +++ b/drivers/scsi/storvsc_drv.c
> @@ -292,6 +292,9 @@ struct vmstorage_protocol_version {
>  #define STORAGE_CHANNEL_REMOVABLE_FLAG		0x1
>  #define STORAGE_CHANNEL_EMULATED_IDE_FLAG	0x2
>=20
> +/* Lower bound on the size of unsolicited packets with ID of 0 */
> +#define VSTOR_MIN_UNSOL_PKT_SIZE		48
> +

I know you have determined experimentally that Hyper-V sends
unsolicited packets with the above length, so the idea is to validate
that the guest actually gets packets at least that big.  But I wonder if
we should think about this slightly differently.

The goal is for the storvsc driver to protect itself against bad or
malicious messages from Hyper-V.  For the unsolicited messages, the
only field that this storvsc driver needs to access is the
vstor_packet->operation field.  So an alternate approach is to set
the minimum length as small as possible while ensuring that field is valid.
Then if Hyper-V later changes the size of these unsolicited packets to
some smaller size that still contains a valid "operation" field, this code
will still work.   If in a new version of the protocol Hyper-V adds fields
that this driver needs to look at, then the minimum size can be
adjusted as needed for that new protocol version.

>  struct vstor_packet {
>  	/* Requested operation type */
>  	enum vstor_packet_operation operation;
> @@ -1285,11 +1288,15 @@ static void storvsc_on_channel_callback(void *con=
text)
>  	foreach_vmbus_pkt(desc, channel) {
>  		struct vstor_packet *packet =3D hv_pkt_data(desc);
>  		struct storvsc_cmd_request *request =3D NULL;
> +		u32 pktlen =3D hv_pkt_datalen(desc);
>  		u64 rqst_id =3D desc->trans_id;
> +		u32 minlen =3D rqst_id ? sizeof(struct vstor_packet) -
> +			stor_device->vmscsi_size_delta : VSTOR_MIN_UNSOL_PKT_SIZE;
>=20
> -		if (hv_pkt_datalen(desc) < sizeof(struct vstor_packet) -
> -				stor_device->vmscsi_size_delta) {
> -			dev_err(&device->device, "Invalid packet len\n");
> +		if (pktlen < minlen) {
> +			dev_err(&device->device,
> +				"Invalid pkt: id=3D%llu, len=3D%u, minlen=3D%u\n",
> +				rqst_id, pktlen, minlen);
>  			continue;
>  		}
>=20
> --
> 2.25.1

I'm good with the rest of the code.  It's just a question of whether to per=
haps
"future-proof" the code by not requiring a packet size any bigger than the
driver actually needs to reference.

Michael
