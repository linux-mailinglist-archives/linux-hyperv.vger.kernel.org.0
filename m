Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 82DB5489AE
	for <lists+linux-hyperv@lfdr.de>; Mon, 17 Jun 2019 19:08:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726005AbfFQRI2 (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 17 Jun 2019 13:08:28 -0400
Received: from mail-eopbgr810122.outbound.protection.outlook.com ([40.107.81.122]:17216
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726424AbfFQRI1 (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 17 Jun 2019 13:08:27 -0400
ARC-Seal: i=1; a=rsa-sha256; s=testarcselector01; d=microsoft.com; cv=none;
 b=Qjn0Tsd3/eQalMpZ3Cc9FBispg3UGcDvdVhlEQII8AXmnEaolcupyNrX/MeXxR96nnLxkzQxLjsP91NuNRxoCxoUnrjpQ4d34NaetRT6dTPQyCiST3lHsvAxEr/bIcLchXiLutUKbzkVi2lOrHACqNkAaOVjbp/IjcdHSH1EYZk=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=testarcselector01;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ECqpL1vMw/xCRHC3nO/9XApAjPvVdUkpqcTzWtaSvpk=;
 b=v3uA8jovt18z/K7ZcCiZWA8ZUYN7SMzEFnSRlWZbpruPq2PrrOIl3C+6MVhC7VK4EuYBHYUENnLSTA6y4AIMv7VGciSs5/Ew7YWmcU3I2EQpHzY88sL6I1uohrDTKrXLOFPZ5WomYuMaEXs47/KMAtz9UsQN2PwE9zD75cXg/rY=
ARC-Authentication-Results: i=1; test.office365.com
 1;spf=none;dmarc=none;dkim=none;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ECqpL1vMw/xCRHC3nO/9XApAjPvVdUkpqcTzWtaSvpk=;
 b=EKdsGnYeLOgDiTrj9e4bzjmLLAFMNMVLgahrueTUmCTLBBS9jkRfjhZgyOEQxUQOPovr55O05NTVGW2q/k2EQzOMO5lSGv2ZEQp529FvbgffvoG1NjhvwVWaEVlbHADFY47xe8s0aUCd8WyWYIR8jWBzXul7zCnzXF7kfXjy6KE=
Received: from DM5PR2101MB1061.namprd21.prod.outlook.com (2603:10b6:4:9e::18)
 by DM5PR2101MB1064.namprd21.prod.outlook.com (2603:10b6:4:a2::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2008.2; Mon, 17 Jun
 2019 17:08:21 +0000
Received: from DM5PR2101MB1061.namprd21.prod.outlook.com
 ([fe80::85a5:e14e:9fad:2617]) by DM5PR2101MB1061.namprd21.prod.outlook.com
 ([fe80::85a5:e14e:9fad:2617%6]) with mapi id 15.20.2008.007; Mon, 17 Jun 2019
 17:08:21 +0000
From:   KY Srinivasan <kys@microsoft.com>
To:     Michael Kelley <mikelley@microsoft.com>,
        brandonbonaby94 <brandonbonaby94@gmail.com>,
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
Thread-Index: AQHVIwu0Rz6pHWObQkSrYAlRiuqjWqadB4QAgAMQSlA=
Date:   Mon, 17 Jun 2019 17:08:21 +0000
Message-ID: <DM5PR2101MB1061E9107B0B71FC26433BA8A0EB0@DM5PR2101MB1061.namprd21.prod.outlook.com>
References: <20190614234822.5193-1-brandonbonaby94@gmail.com>
 <BL0PR2101MB13482F73342F77866D6A6AABD7E90@BL0PR2101MB1348.namprd21.prod.outlook.com>
In-Reply-To: <BL0PR2101MB13482F73342F77866D6A6AABD7E90@BL0PR2101MB1348.namprd21.prod.outlook.com>
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
 smtp.mailfrom=kys@microsoft.com; 
x-originating-ip: [2001:4898:80e8:f:f567:9f6:48c1:a117]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: eba2fcff-e89b-4bee-f51d-08d6f34666bb
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:DM5PR2101MB1064;
x-ms-traffictypediagnostic: DM5PR2101MB1064:
x-ld-processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
x-microsoft-antispam-prvs: <DM5PR2101MB1064E1090541D96EEADBDC86A0EB0@DM5PR2101MB1064.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:800;
x-forefront-prvs: 0071BFA85B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(396003)(39860400002)(136003)(376002)(366004)(13464003)(199004)(189003)(73956011)(74316002)(102836004)(66946007)(53936002)(9686003)(71200400001)(71190400001)(316002)(46003)(6116002)(14454004)(54906003)(6436002)(52396003)(7736002)(486006)(186003)(55016002)(7696005)(4326008)(6246003)(33656002)(81166006)(8676002)(68736007)(110136005)(446003)(2906002)(10090500001)(81156014)(2501003)(8990500004)(76176011)(99286004)(305945005)(476003)(11346002)(2201001)(86362001)(478600001)(1511001)(25786009)(6506007)(14444005)(66446008)(256004)(229853002)(64756008)(66556008)(66476007)(53546011)(76116006)(8936002)(52536014)(10290500003)(5660300002)(22452003);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1064;H:DM5PR2101MB1061.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: f5U/xIrtJvUfcbDrEL5MMFqW1LgWO5sxn0Jy6p63O9feTmUbmuE8gV4yxzW5y3HetHro8JprBeMUikHA2ZgtylSIXiTL3MC+MePcJ5gUpkY4arn0sfKQ0XrpAyX0CSPRWARkf7gMo463Jv1c3XelArZHxSNAY7uKzidbdE8EAHr1cceYGNnnd/LcZ+FODInBN3u34BkJw66W5pUwUrkgjyARD4tPMmnj6kDzPwQ/L5rrIPVHhM6TuiWAFesbckm+tkBwEAcOFBqIG/RD+YNVTFz/Z2egbrRGnf5294716cJgUKrafxz4UMFHitOh9IagzNW8dMpHBdMFj7dcSWagjB6bVo/zWTrp6caJU6onWR/NG8qMROV/OrQFdeCDpGsjahnWvhKpWiTpbMDgeYj5QJOxFxPkWBzlvvqaAd+GJoY=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eba2fcff-e89b-4bee-f51d-08d6f34666bb
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jun 2019 17:08:21.5768
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kys@microsoft.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1064
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org



> -----Original Message-----
> From: Michael Kelley <mikelley@microsoft.com>
> Sent: Saturday, June 15, 2019 11:19 AM
> To: brandonbonaby94 <brandonbonaby94@gmail.com>; KY Srinivasan
> <kys@microsoft.com>; Haiyang Zhang <haiyangz@microsoft.com>; Stephen
> Hemminger <sthemmin@microsoft.com>; sashal@kernel.org;
> jejb@linux.ibm.com; martin.petersen@oracle.com
> Cc: brandonbonaby94 <brandonbonaby94@gmail.com>; linux-
> hyperv@vger.kernel.org; linux-scsi@vger.kernel.org; linux-
> kernel@vger.kernel.org
> Subject: RE: [PATCH] scsi: storvsc: Add ability to change scsi queue dept=
h
>=20
> From: Branden Bonaby <brandonbonaby94@gmail.com> Sent: Friday, June
> 14, 2019 4:48 PM
> >
> > Adding functionality to allow the SCSI queue depth to be changed,
> > by utilizing the "scsi_change_queue_depth" function.
> >
> > Signed-off-by: Branden Bonaby <brandonbonaby94@gmail.com>
> > ---
> >  drivers/scsi/storvsc_drv.c | 11 +++++++++++
> >  1 file changed, 11 insertions(+)
> >
> > diff --git a/drivers/scsi/storvsc_drv.c b/drivers/scsi/storvsc_drv.c
> > index 8472de1007ff..719ca9906fc2 100644
> > --- a/drivers/scsi/storvsc_drv.c
> > +++ b/drivers/scsi/storvsc_drv.c
> > @@ -387,6 +387,7 @@ enum storvsc_request_type {
> >
> >  static int storvsc_ringbuffer_size =3D (128 * 1024);
> >  static u32 max_outstanding_req_per_channel;
> > +static int storvsc_change_queue_depth(struct scsi_device *sdev, int
> queue_depth);
> >
> >  static int storvsc_vcpus_per_sub_channel =3D 4;
> >
> > @@ -1711,6 +1712,7 @@ static struct scsi_host_template scsi_driver =3D =
{
> >  	.dma_boundary =3D		PAGE_SIZE-1,
> >  	.no_write_same =3D	1,
> >  	.track_queue_depth =3D	1,
> > +	.change_queue_depth =3D	storvsc_change_queue_depth,
> >  };
> >
> >  enum {
> > @@ -1917,6 +1919,15 @@ static int storvsc_probe(struct hv_device
> *device,
> >  	return ret;
> >  }
> >
> > +/* Change a scsi target's queue depth */
> > +static int storvsc_change_queue_depth(struct scsi_device *sdev, int
> queue_depth)
> > +{
> > +	if (queue_depth > scsi_driver.can_queue){
> > +		queue_depth =3D scsi_driver.can_queue;
> > +	}
> > +	return scsi_change_queue_depth(sdev, queue_depth);
> > +}
> > +
> >  static int storvsc_remove(struct hv_device *dev)
> >  {
> >  	struct storvsc_device *stor_device =3D hv_get_drvdata(dev);
> > --
> > 2.17.1
>=20
> Reviewed-by: Michael Kelley <mikelley@microsoft.com>
Reviewed-by: K. Y. Srinivasan <kys@microsoft.com>

