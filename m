Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E57582DE657
	for <lists+linux-hyperv@lfdr.de>; Fri, 18 Dec 2020 16:17:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726581AbgLRPQx (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 18 Dec 2020 10:16:53 -0500
Received: from mail-mw2nam12on2133.outbound.protection.outlook.com ([40.107.244.133]:15978
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725878AbgLRPQx (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 18 Dec 2020 10:16:53 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g8B/zYIEbCMWiY9J4SHYcvcq1isb3348DeTyKGHlDJn7+OUBP7F1I9091dY+suXFj90xFcPaPQiwYZ3pCGrBphpMF5rD3E+kuBnP/kvZh2W4h7olFsOOsAfcUEZWgYMi3ulVdsJAsTYiC29Z4zK7/cbAKK9lmSh8tugya6+rpV03A2ra94NT+p49XZ8W6V+X2YAtMiRMGWxoQ6WJy5nINXV2xIKthsh+bhiLIeLoH5P1lS8rfzFioeds+tXPDrqQthU72Fdr5IYnY8WVsLRdz8I1BEevqMfuZEOnpLd5QLnyQxCiB8KmnnDlkJBMYxWqLWOGJBIFySgt2t8sq19x4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qN5fI2pSNZfOk9w8DNwSTxPWwt1Xrso6Cu5OVZsysJA=;
 b=duAlg9WGu1jNyReLWcH9CajrI3fBDyywyOXFoSX6WehfsCltNoiXCwOxOAyeJD60LDQJIQ7XQpMkLipfbnpgb3XrmqvZaDMjzmSm2sJCDKDYrf3qnjdJ+e2OeE0WBn+QO0bXzi7bHftliUJS44y1ltyEUXIDgKI0Gxp+iudtKn3NWNq3dDtsxIbd/PjcR47fbxQk7E45CH1rgGguCu1jKZ4Xa/uQ87CpkjNQn+oXHYRAScBi00bbIpDcd2i8Uj+ZoVMIYfHFUK4farcicRLYgm7dhQj84Amx0vlCWpYxdPKtHkxUqYJ/OX9YgYzW4LtXxCfjSBtdFlRqCjP1fJoxpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qN5fI2pSNZfOk9w8DNwSTxPWwt1Xrso6Cu5OVZsysJA=;
 b=Dl5r4MSh5cRCqZwy7fFuU9chDITEKR03Zef2bIPGDuZdLD+Km8vdg7EoYKEUFcgYmeFMqyP+Ca/URmyvSHg8u3SXzLTlgRbkNKt/denmxsr10ZguLxhOEOyS+hMRRR6u0obN4Wljy+On8Od0AmQK2rb0o6dErnovlAdEANCXwgk=
Received: from (2603:10b6:302:a::16) by
 MWHPR21MB0144.namprd21.prod.outlook.com (2603:10b6:300:78::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3700.8; Fri, 18 Dec 2020 15:16:05 +0000
Received: from MW2PR2101MB1052.namprd21.prod.outlook.com
 ([fe80::b8f6:e748:cdf2:1922]) by MW2PR2101MB1052.namprd21.prod.outlook.com
 ([fe80::b8f6:e748:cdf2:1922%8]) with mapi id 15.20.3700.013; Fri, 18 Dec 2020
 15:16:05 +0000
From:   Michael Kelley <mikelley@microsoft.com>
To:     "Andrea Parri (Microsoft)" <parri.andrea@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>
CC:     KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
        Saruhan Karademir <skarade@microsoft.com>,
        Juan Vazquez <juvazq@microsoft.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>
Subject: RE: [PATCH 3/3] scsi: storvsc: Validate length of incoming packet in
 storvsc_on_channel_callback()
Thread-Topic: [PATCH 3/3] scsi: storvsc: Validate length of incoming packet in
 storvsc_on_channel_callback()
Thread-Index: AQHW1LPxFJqinclYSE6I9D72fpSqk6n8970w
Date:   Fri, 18 Dec 2020 15:16:05 +0000
Message-ID: <MW2PR2101MB10522786584587FBF9166DF0D7C39@MW2PR2101MB1052.namprd21.prod.outlook.com>
References: <20201217203321.4539-1-parri.andrea@gmail.com>
 <20201217203321.4539-4-parri.andrea@gmail.com>
In-Reply-To: <20201217203321.4539-4-parri.andrea@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2020-12-18T15:16:03Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=0e2278b6-2a3b-403c-b994-bc791ba3d0f4;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=microsoft.com;
x-originating-ip: [24.22.167.197]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 63bef3bf-bbc6-478d-cff2-08d8a367d6b7
x-ms-traffictypediagnostic: MWHPR21MB0144:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MWHPR21MB014401CBE009F7828A80EED7D7C39@MWHPR21MB0144.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2201;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: rRCxhlPhfewdrsAwMZ/ckshl9HyTXWYHS+Es2KedE0+2yEKNJYHGcZOICBBBvwQo+gxc0PgXZQ2UHLlWwFL2YIO6hB3pbPedhcJ5LoaTevNVhoLJbZtYXFe2kAeR+DGRwhuypKxaJGr9LQHICiB5TFtVb9mb64AjETDI8yujw+1FZLLyo4/TuKFm4c5W/wo3it+dYYavuP29cmJPzFpzPK7M21bcbK3D+MochfYfgczTVLg/LeakVXhCR/c7CW8d8TOlqz7bwm8dEz608SCyFhNGu6omKLp0PWZhm1fnapoOtUJ37xDe+eJvW0oRxwtcfsl7WSZA+imfOeAHRsYhPN7It+MPrO9m8jXamwnm6B0tqjWwp57vTDjPW92Cmp7ZfMl3P/Mi5dpvVjl4YfSdHg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR2101MB1052.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(346002)(396003)(366004)(39860400002)(136003)(33656002)(9686003)(83380400001)(55016002)(8936002)(71200400001)(8676002)(86362001)(478600001)(54906003)(66476007)(52536014)(186003)(26005)(4326008)(66556008)(5660300002)(10290500003)(64756008)(110136005)(6506007)(66946007)(316002)(8990500004)(82950400001)(66446008)(82960400001)(2906002)(76116006)(7696005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?IXeWTZxusXCRlobGCSCXn2dZ29eGPJy3VniwD4B/KVLGuJNY/bpH5YUDCaAz?=
 =?us-ascii?Q?cULmBy6HYURNz5o8r2DUU+BNjtfu2zcKLcxWMZyFAAIHhTZZKbGf5qp3Rcfl?=
 =?us-ascii?Q?wJGRDNI1XZFcN38OKdQqlMBmttv13Co6UeZbY5FMTA57a+5McqHbChOHaOrw?=
 =?us-ascii?Q?frhUgoBeOmfcNFs+LisiMZKivtsMe6b/gnDe2W8GkfelVAcjpTvRQtmP9liv?=
 =?us-ascii?Q?BfIUWfXifMnKoWQ1wcEVGMTnYThA1yWgzIjxBM40VQed1XeqjKBXp9CGvBp+?=
 =?us-ascii?Q?mABPIWhAcJEFheVxK2WjzhngnxExJFcC9CBGd+X4/GIDESryVtRBCZ7U5doH?=
 =?us-ascii?Q?v38Nq0b/fFoq+tiABXh1u55WpmJONJOwyP2+3bZM5oKhBHv9wPasGWzNlvKE?=
 =?us-ascii?Q?U4RQqyGkkX9XhNW5+nWeL6i6Xg/xgZT5e7AwbxAosYKC7kjQu56D8Uoq/uwF?=
 =?us-ascii?Q?OJzUm8X+WwfqGBLNkO9h1w6Y5S7cn9PDeNDKtWQpG6Il/sQ9ZjZZcrLPMxPo?=
 =?us-ascii?Q?3kHbf1jZyvCQ8fxuQ2NuHsOc66asdqyml8PFUaoVpz72Thl3N1KGywiy+hm7?=
 =?us-ascii?Q?heN6fGjLL5WqAce26UDvYqwWSZY2uAK0nx0z1/y3oSC4NuMdfMKKLmYiZlV8?=
 =?us-ascii?Q?mL6MHRpciSOvK5GIBYEL17GvjZfQ/2whxPVDzRUp2Lb0rgRQZUGqzDiBWcK9?=
 =?us-ascii?Q?lzhYnD82+5JaJVXQtju5mygneiF8SPvWv/4qZlVITF7FFuT6cEs3omcxVYPh?=
 =?us-ascii?Q?AFCclPByNrjGQYY7sd/i7Dbp/RJTLpDU99sGJwZEDSds02yO4s4zYrm1r0V/?=
 =?us-ascii?Q?8sWIItFP1Mdf3uFa7GkNSPTlBtuYzscMKCgvJITfHlO6a+OvkVtV6RZ1U2O3?=
 =?us-ascii?Q?vxDyg/aQVedqhNPKCvj2glxuwplzleLRZsWYRPF2S3BL8UcvO2Wqnmb7YNGb?=
 =?us-ascii?Q?hnm+bKJiTaS4nWRoOTCbmVWzxIoq4JCYaeNzZvQpgcQ=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR2101MB1052.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 63bef3bf-bbc6-478d-cff2-08d8a367d6b7
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Dec 2020 15:16:05.1105
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Bjghd1T/lQJoqRiCuivdOE6/iH8fycWLw29CkLdCly6OkfZHUTxWhLspRxOEMtbt20DO7mGqtl3jw6gzhdj82LfLx1JQy3f0dVBw9rb5+AE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR21MB0144
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

From: Andrea Parri (Microsoft) <parri.andrea@gmail.com> Sent: Thursday, Dec=
ember 17, 2020 12:33 PM
>=20
> Check that the packet is of the expected size at least, don't copy data
> past the packet.
>=20
> Reported-by: Saruhan Karademir <skarade@microsoft.com>
> Signed-off-by: Andrea Parri (Microsoft) <parri.andrea@gmail.com>
> Cc: "James E.J. Bottomley" <jejb@linux.ibm.com>
> Cc: "Martin K. Petersen" <martin.petersen@oracle.com>
> Cc: linux-scsi@vger.kernel.org
> ---
>  drivers/scsi/storvsc_drv.c | 6 ++++++
>  1 file changed, 6 insertions(+)
>=20
> diff --git a/drivers/scsi/storvsc_drv.c b/drivers/scsi/storvsc_drv.c
> index 8714355cb63e7..4b8bde2750fac 100644
> --- a/drivers/scsi/storvsc_drv.c
> +++ b/drivers/scsi/storvsc_drv.c
> @@ -1250,6 +1250,12 @@ static void storvsc_on_channel_callback(void *cont=
ext)
>  		request =3D (struct storvsc_cmd_request *)
>  			((unsigned long)desc->trans_id);
>=20
> +		if (hv_pkt_datalen(desc) < sizeof(struct vstor_packet) -
> +				stor_device->vmscsi_size_delta) {
> +			dev_err(&device->device, "Invalid packet len\n");
> +			continue;
> +		}
> +
>  		if (request =3D=3D &stor_device->init_request ||
>  		    request =3D=3D &stor_device->reset_request) {
>  			memcpy(&request->vstor_packet, packet,
> --
> 2.25.1

Reviewed-by: Michael Kelley <mikelley@microsoft.com>

