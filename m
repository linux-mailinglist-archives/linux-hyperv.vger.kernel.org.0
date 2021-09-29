Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8471441C5B9
	for <lists+linux-hyperv@lfdr.de>; Wed, 29 Sep 2021 15:34:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344243AbhI2Nft (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 29 Sep 2021 09:35:49 -0400
Received: from mail-oln040093003011.outbound.protection.outlook.com ([40.93.3.11]:61575
        "EHLO na01-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1344244AbhI2Nfh (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 29 Sep 2021 09:35:37 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W3od254AYQDYzYN+MPwM5X9Gp1nS4yIiKPN1VQdC+yHYs9VgnoV4drVr0FE7fXu8McPGRjDoD+EkZmg6wQ2mpMx2vPiBe2F1LjrapVWJ5ThI7ZlXT1hiV7aS/BJWqUWKVqRuCKbPS+LJKr/ZNp+FM+co2NF3uqU1g5uIBFfwtj2y1jnNvkUab9Pn4EC1n0nAsVI1+9oGNNZI5ep9MMW0bMCT6yTmmhobEYE5qaHEnPqmUzRTSYzwmWSjaP7p4p1gm7awjItyZZTFs2+JxXI6QLWb4XXUljvyTYsF8yZpARk6NdG0j1J7xse8GjvsEv87ULWXuntqev/zI8P3NHkNvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=061t1QCWU6kX5EV10oScntuWq4z8Of9cq5CQ0ei0khk=;
 b=c8EFp6hrQKyP7LpfAyqLOAZmld4vv0fEtpFmcc//sJiGdxJYMlfBNMSRAtpPWsas8QL3dnd0XkfDGbGCElTg3otHSRwOmmMLBAKhon4dNIaGBQvnIlK0k/IaGArUcxbMhO5j40OVkjSUP5F6JX840u+g6b1YmqaE3jHyZx/hSyVHSI1HwYRAplRKNYLFJu/OeijusszZho7c8zkfl2hmUVxaZ6P4V34d8m6PCjo6tRYFrKObQjh9rPb8hnLniIjgmNjoVHEL1DE/i5V1lvEVnsf7fQqvd+5hBXiBZxHKRFeJszx3SKrBsmNF2SvNykIC5aZqVxo6J0DTE4a86LMNfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=061t1QCWU6kX5EV10oScntuWq4z8Of9cq5CQ0ei0khk=;
 b=R6n388Dl4QtDZ4mizbjPlbpVs7HF8N8fujAxfvtSz5PTJE2DIQpefKQ5kCZ+hdyq3zz4epaKLMzV9fTtLgvfTC6I3oFvLVH9iQyJXeDTtAGD6pEkSADHvDlAmimkoYNmT++hDHF1eFBUkpbv/gCGEWpyZrIlW4TAYLyHiwXfX00=
Received: from BN8PR21MB1284.namprd21.prod.outlook.com (2603:10b6:408:a2::22)
 by BN6PR21MB0834.namprd21.prod.outlook.com (2603:10b6:404:9e::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.7; Wed, 29 Sep
 2021 13:33:50 +0000
Received: from BN8PR21MB1284.namprd21.prod.outlook.com
 ([fe80::f8ac:5395:a706:f38f]) by BN8PR21MB1284.namprd21.prod.outlook.com
 ([fe80::f8ac:5395:a706:f38f%3]) with mapi id 15.20.4566.009; Wed, 29 Sep 2021
 13:33:50 +0000
From:   Haiyang Zhang <haiyangz@microsoft.com>
To:     "Andrea Parri (Microsoft)" <parri.andrea@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>
CC:     KY Srinivasan <kys@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>,
        "James E . J . Bottomley" <jejb@linux.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Michael Kelley <mikelley@microsoft.com>,
        Dexuan Cui <decui@microsoft.com>
Subject: RE: [RFC PATCH] scsi: storvsc: Fix validation for unsolicited
 incoming packets
Thread-Topic: [RFC PATCH] scsi: storvsc: Fix validation for unsolicited
 incoming packets
Thread-Index: AQHXtIcuKpq91BhekkSiLD0Hct+0mau5/I/wgAEG9bA=
Date:   Wed, 29 Sep 2021 13:33:50 +0000
Message-ID: <BN8PR21MB1284DC9279AC61FE0C267C5ACAA99@BN8PR21MB1284.namprd21.prod.outlook.com>
References: <20210928163732.5908-1-parri.andrea@gmail.com>
 <BN8PR21MB128430486E2F07EA71A7FCBDCAA89@BN8PR21MB1284.namprd21.prod.outlook.com>
In-Reply-To: <BN8PR21MB128430486E2F07EA71A7FCBDCAA89@BN8PR21MB1284.namprd21.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=0ecfc4cb-be64-458c-937b-af3fb0c39c05;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2021-09-28T21:50:09Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3a239535-45a4-4dee-c1c8-08d9834dc5f3
x-ms-traffictypediagnostic: BN6PR21MB0834:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BN6PR21MB08345BAF2301F4BA66B18835CAA99@BN6PR21MB0834.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Vl3oKdaXhij0RpuMV+giCJrPVeNDozOZPYvcpRxd8cvjZ58fsJ+JHsAbwRoWVW8/CNcEC3fVWUPZsMqMl9XQLASGG6LiwCTvvvPFs5XKCE8HB1krcJpLMEgilKv7kHHl+hyF1rBUOvU2sdz5Ms7Sk5kUa5Yc+D1C+AfqxFyMD8vbPLAcTzjrKHiBg7Bro9sAN93Rs3lyEBRAAaue3xiz/n0Pt4spT1SvNIBC0tz6/LdNLnn36dS41bu6lQl3ql6KmXg/LhHeyBwQKfRdpcuE2CHqTzzMUyps5VeHmqe3BYw2arHGLKnZpgqpLkERY/CYfLbzB/RVNT4EyUdCFIpUvh6Y2Ii6A7oXTwB2eo8JtbOCvwQGil1HYq42ioLHVKPY+GqHc3A5na3kKFpulvcmrw4jVz5dx4djzjAediE+X1nka+T0RZOa1vnGCJDujg4oZFxbKU01gcDKXDsdkrfK0tiU/ctBIXiK4ria73U7qw+zEAjzZ2f4U8TbV0fmGjsOdl9kreQt0GtKv5pa8jY/ztVBDsD9f61D9rqGExy8I7CMU+50CbsOTGygXpMuIkrB7I+32XiDi42E6tg2uGUOqvax743IysNjDIARinVry3Q3vgj36O2MGWo290Iy6O2hYDOzNv5nkvo+lyZS30SlX465HrwLB4XwACJlHSPSKF5hXHJnuH5JSXFsffe3KHyJD/aeenPNBQdcE5VJV5HkhA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR21MB1284.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(83380400001)(55016002)(82960400001)(10290500003)(71200400001)(5660300002)(508600001)(2906002)(38100700002)(8936002)(76116006)(64756008)(8676002)(7696005)(52536014)(38070700005)(86362001)(53546011)(186003)(316002)(33656002)(26005)(8990500004)(110136005)(66556008)(66476007)(4326008)(66946007)(122000001)(6506007)(107886003)(9686003)(54906003)(82950400001)(66446008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?1ukX0gG+6/wHZEpXIW1B8v6c1p4hV3kkTgKkFsphdosUMWIJXvZQlbIU4QLR?=
 =?us-ascii?Q?FbpaRimBO+ZLVwVOROStkLpB4pLIyvC0rIpyY8La36FE99LADRGoQGT2Ej0p?=
 =?us-ascii?Q?rssu3t+phW3NdkQHEA5ELgX5Wh+e5ANJeaaksQ8Bd2uB9xCJBOuX5gdJRUcv?=
 =?us-ascii?Q?B97Ln2w/4ES9NnWkcNzeCE+PXwBtVBGBGjgFDBdsO6sqtJR4WhkZ8YVGsJYX?=
 =?us-ascii?Q?eAQCxziqjhffr5LaGdXYbHxlJDUBqqQvI33lHlcLjt4iuh6q1es2HX/1gftD?=
 =?us-ascii?Q?06DsIWw/2RHaJMltnBiZnkw89A469/MQ5TS0qjgPWT3et6MOOPSzPTpJAdrA?=
 =?us-ascii?Q?E+i7+i1RYmZJOz4JOe4PljMIcLxSFLfDIDhSnPejChK2qA2zwV386RtkSL8r?=
 =?us-ascii?Q?e+PNcxvcfZYsHKxLrhM/EuLfYRGQtRXrQ4GAGdefsvc+bB2UHC3TePoFUok2?=
 =?us-ascii?Q?qXlKoyUHR/3h6RIqTBaTwDqXji2DnHLMlRfn9fHhq29TAZqB5Hpvidy0h0Kr?=
 =?us-ascii?Q?XKBdgJFV5J7tqlD1JPOXCwffAtSUClim1gdJflTZ6QqGZdg+cG57XT6zgMrJ?=
 =?us-ascii?Q?v9rWlijGF0fqjuxZbD7QI+SkkrAwB8yttK63BB971uqP6lvrWDzlnI5DP4iS?=
 =?us-ascii?Q?9SD29/n04XlqcNvpLiz6i5T6tfn2Sd0HRLTfy9o5MCU3TJ/4oOxqjjTwj3sN?=
 =?us-ascii?Q?zB2LE4Tpu3Hkjvpta6zHphRfQ/dTFBanR7J+oL/wvJpkL8L3OqL8gQ0jcL71?=
 =?us-ascii?Q?hfCqb49SF9dOwM05/5G+D12PcBYxRXOITuF0Qjgk9Edd4zTCclHFnI6ZxHPO?=
 =?us-ascii?Q?A1dpWzQiBb/HmwuLhhCH315LLAKIaI+t9PexblWOqU3N/10RY4l+JRlAyBAH?=
 =?us-ascii?Q?RjTR/DdSJ/mepxq/OgKoB5dFAwLg+qQd+HTfXOfuTvV7P80Og9ASwRDAL8OR?=
 =?us-ascii?Q?XPDicdUnQIvwbvWgAETNLggpT+NvmIKGG/ajNF5r+1hnzUiUpE+tL7DIrKEn?=
 =?us-ascii?Q?LT/N9TZrQMmufwr0k82Mbes6jBclx0w2nfy9JcVtHgihVRklhVquYUwzdKsJ?=
 =?us-ascii?Q?k3W0vmWd+EvZspPW8mnEg8h5exsN/NhLbkphgTogsMMFzSSYlgAr12z0BiVH?=
 =?us-ascii?Q?VTIRqbmC3gjvG+anN+tn/Hc2MiayUVVHfn5nF4PW+tuHeBNiuPuGBMEhwkDb?=
 =?us-ascii?Q?686ZGnnPcSVReEBwi2VypC+hyMk6Noa4PiZu7MBlperc3mIsmRaxpS5sLnKx?=
 =?us-ascii?Q?l1ySXizwgDvgG5IRagbh+A92g3zbsne8iD7qO0plqADP41y/jOpLsPXIseQ0?=
 =?us-ascii?Q?dFK2XrQb86bQPNKU2BoUfZH4?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN8PR21MB1284.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a239535-45a4-4dee-c1c8-08d9834dc5f3
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Sep 2021 13:33:50.5243
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: v8qir1mvlqVf7TQcOp6mEBU3YTCYPVNH8CkocO+cynjDcTynpQVHibKAFAd3JM5MlJaF+218pgvy5tMS/BNi0Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR21MB0834
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org



> -----Original Message-----
> From: Haiyang Zhang
> Sent: Tuesday, September 28, 2021 6:06 PM
> To: Andrea Parri (Microsoft) <parri.andrea@gmail.com>; linux-
> kernel@vger.kernel.org; linux-hyperv@vger.kernel.org; linux-
> scsi@vger.kernel.org
> Cc: KY Srinivasan <kys@microsoft.com>; Stephen Hemminger
> <sthemmin@microsoft.com>; Wei Liu <wei.liu@kernel.org>; James E . J .
> Bottomley <jejb@linux.ibm.com>; Martin K . Petersen
> <martin.petersen@oracle.com>; Michael Kelley <mikelley@microsoft.com>;
> Dexuan Cui <decui@microsoft.com>
> Subject: RE: [RFC PATCH] scsi: storvsc: Fix validation for unsolicited
> incoming packets
>=20
>=20
>=20
> > -----Original Message-----
> > From: Andrea Parri (Microsoft) <parri.andrea@gmail.com>
> > Sent: Tuesday, September 28, 2021 12:38 PM
> > To: linux-kernel@vger.kernel.org; linux-hyperv@vger.kernel.org; linux-
> > scsi@vger.kernel.org
> > Cc: KY Srinivasan <kys@microsoft.com>; Haiyang Zhang
> > <haiyangz@microsoft.com>; Stephen Hemminger <sthemmin@microsoft.com>;
> > Wei Liu <wei.liu@kernel.org>; James E . J . Bottomley
> > <jejb@linux.ibm.com>; Martin K . Petersen
> > <martin.petersen@oracle.com>; Michael Kelley <mikelley@microsoft.com>;
> > Andrea Parri (Microsoft) <parri.andrea@gmail.com>; Dexuan Cui
> > <decui@microsoft.com>
> > Subject: [RFC PATCH] scsi: storvsc: Fix validation for unsolicited
> > incoming packets
> >
> > The validation on the length of incoming packets performed in
> > storvsc_on_channel_callback() does not apply to "unsolicited"
> > packets with ID of 0 sent by Hyper-V.  Adjust the validation by
> > handling such unsolicited packets separately.
> >
> > Fixes: 91b1b640b834b2 ("scsi: storvsc: Validate length of incoming
> > packet in storvsc_on_channel_callback()")
> > Reported-by: Dexuan Cui <decui@microsoft.com>
> > Signed-off-by: Andrea Parri (Microsoft) <parri.andrea@gmail.com>
> > ---
> > The (new) bound, VSTOR_MIN_UNSOL_PKT_SIZE, was "empirically derived"
> > based on testing and code auditing.  This explains the RFC tag...
> >
> >  drivers/scsi/storvsc_drv.c | 17 ++++++++++++++---
> >  1 file changed, 14 insertions(+), 3 deletions(-)
> >
> > diff --git a/drivers/scsi/storvsc_drv.c b/drivers/scsi/storvsc_drv.c
> > index ebbbc1299c625..a9bbcbbfb54ee 100644
> > --- a/drivers/scsi/storvsc_drv.c
> > +++ b/drivers/scsi/storvsc_drv.c
> > @@ -292,6 +292,9 @@ struct vmstorage_protocol_version {
> >  #define STORAGE_CHANNEL_REMOVABLE_FLAG		0x1
> >  #define STORAGE_CHANNEL_EMULATED_IDE_FLAG	0x2
> >
> > +/* Lower bound on the size of unsolicited packets with ID of 0 */
> > +#define VSTOR_MIN_UNSOL_PKT_SIZE		48
> > +
> >  struct vstor_packet {
> >  	/* Requested operation type */
> >  	enum vstor_packet_operation operation; @@ -1285,11 +1288,13 @@
> > static void storvsc_on_channel_callback(void
> > *context)
> >  	foreach_vmbus_pkt(desc, channel) {
> >  		struct vstor_packet *packet =3D hv_pkt_data(desc);
> >  		struct storvsc_cmd_request *request =3D NULL;
> > +		u32 pktlen =3D hv_pkt_datalen(desc);
> >  		u64 rqst_id =3D desc->trans_id;
> >
> > -		if (hv_pkt_datalen(desc) < sizeof(struct vstor_packet) -
> > +		/* Unsolicited packets with ID of 0 are validated separately
> > below */
> > +		if (rqst_id !=3D 0 && pktlen < sizeof(struct vstor_packet) -
> >  				stor_device->vmscsi_size_delta) {
> > -			dev_err(&device->device, "Invalid packet len\n");
> > +			dev_err(&device->device, "Invalid packet: length=3D%u\n",
> > pktlen);
> >  			continue;
> >  		}
> >
> > @@ -1298,8 +1303,14 @@ static void storvsc_on_channel_callback(void
> > *context)
> >  		} else if (rqst_id =3D=3D VMBUS_RQST_RESET) {
> >  			request =3D &stor_device->reset_request;
> >  		} else {
> > -			/* Hyper-V can send an unsolicited message with ID of 0
> > */
> >  			if (rqst_id =3D=3D 0) {
> > +				if (pktlen < VSTOR_MIN_UNSOL_PKT_SIZE) {
> > +					dev_err(&device->device,
> > +						"Invalid packet with ID of 0:
> > length=3D%u\n",
> > +						pktlen);
> > +					continue;
> > +				}
> > +
> >  				/*
> >  				 * storvsc_on_receive() looks at the vstor_packet
> in the message
> >  				 * from the ring buffer.  If the operation in the
> vstor_packet is
>=20
> The patch looks good. But for readability, I'd suggested put the length
> checks together like this:
>=20
> 	u32 minlen =3D rqst_id ? sizeof(struct vstor_packet) -
> 		stor_device->vmscsi_size_delta : VSTOR_MIN_UNSOL_PKT_SIZE;
>=20
> 	if (pktlen < minlen) {
> 		dev_err(&device->device,
> 			   "Invalid pkt: id=3D%llu, len=3D%u, minlen=3D%u\n",
> 			   rqst_id, pktlen, minlen);
> 		continue;
> 	}
>=20
> Thanks.
>=20
> Signed-off-by: Haiyang Zhang <haiyangz@microsoft.com>
The tag was meant to be:
Reviewed-by: Haiyang Zhang <haiyangz@microsoft.com>

Thanks.


