Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3CE8B4718A
	for <lists+linux-hyperv@lfdr.de>; Sat, 15 Jun 2019 20:19:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725796AbfFOSTF (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Sat, 15 Jun 2019 14:19:05 -0400
Received: from mail-eopbgr770124.outbound.protection.outlook.com ([40.107.77.124]:32075
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725270AbfFOSTF (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Sat, 15 Jun 2019 14:19:05 -0400
ARC-Seal: i=1; a=rsa-sha256; s=testarcselector01; d=microsoft.com; cv=none;
 b=wIleWJRiam4EVx3svO1CRgD0nMsPzb2/U1WekeUgmbYE4czALZirtK9cWNZT/IPGMAs13ZbasksnP+PNi9lKVCnsR2VK9GLSxcSQqlDjaYe8xg5cOPMKrtzpq7dQXsMi2v+GkrIvmmYITFZRs4/MOmmUcL6+czpsAF/LZPvK7xk=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=testarcselector01;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PqdhfVYwlPfozmgkJio+lofchHcLhfxJUW3rF/EoxK0=;
 b=QBofWH9NdlaFN+ws636TmHvIHwHP+ujOtrIfZ9Xu3bQE6FtoNapFW+pRA7wjDJ3G12XyJhWN9oAQtRqecCsJhQMAQcsgsmpsB7KBgciSLy5EEIb67tHyGESJjR8Ung9hSCnO6C6mt+XwoykbCs1JG3Y5UV/0LhEcp9vl2KW/rPQ=
ARC-Authentication-Results: i=1; test.office365.com
 1;spf=none;dmarc=none;dkim=none;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PqdhfVYwlPfozmgkJio+lofchHcLhfxJUW3rF/EoxK0=;
 b=MWGdD/K0UahKsITpZq07xF7Hij1hVH2XkSyYOHmQ6EbXtppY6pi5bJ17xVwue6U7tBfwDWSL0HLDaT3VINJSG0pnMim2nT6K62dSqO3qNa8bHStFMqMPPzVxSkciIPIjrwbwJVN9Zz7JhvKrtTHBeYDLBW3AklHDPwTaEjmci3g=
Received: from BL0PR2101MB1348.namprd21.prod.outlook.com
 (2603:10b6:208:92::22) by BL0PR2101MB1012.namprd21.prod.outlook.com
 (2603:10b6:207:37::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2008.1; Sat, 15 Jun
 2019 18:19:01 +0000
Received: from BL0PR2101MB1348.namprd21.prod.outlook.com
 ([fe80::ec20:70a:433e:a052]) by BL0PR2101MB1348.namprd21.prod.outlook.com
 ([fe80::ec20:70a:433e:a052%2]) with mapi id 15.20.2008.007; Sat, 15 Jun 2019
 18:19:01 +0000
From:   Michael Kelley <mikelley@microsoft.com>
To:     brandonbonaby94 <brandonbonaby94@gmail.com>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "sashal@kernel.org" <sashal@kernel.org>,
        "jejb@linux.ibm.com" <jejb@linux.ibm.com>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>
CC:     brandonbonaby94 <brandonbonaby94@gmail.com>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] scsi: storvsc: Add ability to change scsi queue depth
Thread-Topic: [PATCH] scsi: storvsc: Add ability to change scsi queue depth
Thread-Index: AQHVIwu2hVNRohUcjEaExf3NA7oXWKadBz2w
Date:   Sat, 15 Jun 2019 18:19:00 +0000
Message-ID: <BL0PR2101MB13482F73342F77866D6A6AABD7E90@BL0PR2101MB1348.namprd21.prod.outlook.com>
References: <20190614234822.5193-1-brandonbonaby94@gmail.com>
In-Reply-To: <20190614234822.5193-1-brandonbonaby94@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Owner=mikelley@ntdev.microsoft.com;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2019-06-15T18:18:58.2507928Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=45d65e2e-9da9-4357-aa96-bb219a120e27;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Extended_MSFT_Method=Automatic
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=mikelley@microsoft.com; 
x-originating-ip: [24.22.167.197]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 270d8398-76ce-4541-ca62-08d6f1bdf125
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:BL0PR2101MB1012;
x-ms-traffictypediagnostic: BL0PR2101MB1012:
x-ld-processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
x-microsoft-antispam-prvs: <BL0PR2101MB10129C929B439FE8EC085A8BD7E90@BL0PR2101MB1012.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2582;
x-forefront-prvs: 0069246B74
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(39860400002)(136003)(366004)(396003)(346002)(199004)(189003)(71200400001)(11346002)(446003)(486006)(66446008)(110136005)(25786009)(52536014)(316002)(66476007)(10290500003)(76116006)(66946007)(2201001)(73956011)(55016002)(64756008)(86362001)(66556008)(476003)(7736002)(68736007)(22452003)(2501003)(54906003)(4326008)(66066001)(256004)(14444005)(8990500004)(3846002)(7696005)(6116002)(52396003)(33656002)(14454004)(1511001)(2906002)(81166006)(76176011)(81156014)(9686003)(229853002)(102836004)(6506007)(8676002)(5660300002)(6436002)(99286004)(10090500001)(6246003)(53936002)(71190400001)(478600001)(74316002)(26005)(8936002)(305945005)(186003);DIR:OUT;SFP:1102;SCL:1;SRVR:BL0PR2101MB1012;H:BL0PR2101MB1348.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: j+S+WsWN8c8BpFtnesChRu7w36GPqFoArNDsNwGZFLUT6QMyoIbuZ3AiMH6H8wU1rCPWrIim9g1TotB5dAS331foO5udKDGVEbD8FcBNk9mnYN7Mziv14/KAbC7rPOPj/6Y677LUGDP8esCoU7xUZhBXuczJC3lRP6AaHkUOrqaUft882eDokkqIvtj/HWRnKstOs5foCCsaHY2Ty0QVgu+Tl0dGKO+f0vL3K+WGLzkcM4r5rzxwtohYk0LY0IYVExhIe92ND/ZcMxjV95+HX3hs6TQAxqpYWLtTYFvcs3GncH/ye/PojvGvfhONMfClZVIbNO+pUsqJnX3p7Xu0uTp7X4l5vYydkJyJji3353lccL0gpvjya/wqggrdDoxxiuzSR76v9tdtgyTeKw8TzBM3wmCBoDZ9TYxQ4giHQTk=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 270d8398-76ce-4541-ca62-08d6f1bdf125
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jun 2019 18:19:00.8556
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mikelley@ntdev.microsoft.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR2101MB1012
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

From: Branden Bonaby <brandonbonaby94@gmail.com> Sent: Friday, June 14, 201=
9 4:48 PM
>=20
> Adding functionality to allow the SCSI queue depth to be changed,
> by utilizing the "scsi_change_queue_depth" function.
>=20
> Signed-off-by: Branden Bonaby <brandonbonaby94@gmail.com>
> ---
>  drivers/scsi/storvsc_drv.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)
>=20
> diff --git a/drivers/scsi/storvsc_drv.c b/drivers/scsi/storvsc_drv.c
> index 8472de1007ff..719ca9906fc2 100644
> --- a/drivers/scsi/storvsc_drv.c
> +++ b/drivers/scsi/storvsc_drv.c
> @@ -387,6 +387,7 @@ enum storvsc_request_type {
>=20
>  static int storvsc_ringbuffer_size =3D (128 * 1024);
>  static u32 max_outstanding_req_per_channel;
> +static int storvsc_change_queue_depth(struct scsi_device *sdev, int queu=
e_depth);
>=20
>  static int storvsc_vcpus_per_sub_channel =3D 4;
>=20
> @@ -1711,6 +1712,7 @@ static struct scsi_host_template scsi_driver =3D {
>  	.dma_boundary =3D		PAGE_SIZE-1,
>  	.no_write_same =3D	1,
>  	.track_queue_depth =3D	1,
> +	.change_queue_depth =3D	storvsc_change_queue_depth,
>  };
>=20
>  enum {
> @@ -1917,6 +1919,15 @@ static int storvsc_probe(struct hv_device *device,
>  	return ret;
>  }
>=20
> +/* Change a scsi target's queue depth */
> +static int storvsc_change_queue_depth(struct scsi_device *sdev, int queu=
e_depth)
> +{
> +	if (queue_depth > scsi_driver.can_queue){
> +		queue_depth =3D scsi_driver.can_queue;
> +	}
> +	return scsi_change_queue_depth(sdev, queue_depth);
> +}
> +
>  static int storvsc_remove(struct hv_device *dev)
>  {
>  	struct storvsc_device *stor_device =3D hv_get_drvdata(dev);
> --
> 2.17.1

Reviewed-by: Michael Kelley <mikelley@microsoft.com>

