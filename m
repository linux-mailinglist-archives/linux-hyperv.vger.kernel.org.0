Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8A734AAF05
	for <lists+linux-hyperv@lfdr.de>; Fri,  6 Sep 2019 01:19:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731037AbfIEXS7 (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 5 Sep 2019 19:18:59 -0400
Received: from mail-eopbgr750117.outbound.protection.outlook.com ([40.107.75.117]:58785
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725945AbfIEXS7 (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 5 Sep 2019 19:18:59 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U4NCMagsrWGWJkpKvrd8vXIOe5HQPkagPkCPitYxzhHc4r8DIgOVUHOB4X5RkQgXvq3B/gxOpoZ1LvfcB5iWIyzboeZVwpnKx6Tv1CvUCTnW2ejBnuyxbdHH65EASSNdZJMZRgWjZDsW5QNDJaw2AMRVayHHwgs+4sxrTzHByobYyX+1dvjCH2wSlowDMKWGtxsvIoAKQ1Zpe14eeI2wBdr5iL3mdzv7cT3WM9MZHvq/gPj+5mCWd1P2uN04eoK7QlHdy4PbdaKfYtPOc5ORYV6+RnzBnnTn25OELgmVdTtcOsKzayVGDKzyBca1FNTHlYkFi6uRPYtRWCqx/oXtJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g6uS68sNaERG1ondIudlSJUOg1yy0HPxx3TeaQ3RoKI=;
 b=X13etMPx2kfzXM9Ar224cHAQyOfuzULnffBYDcOrtIGQu1zg0RtMFJL4dw6v2rNnStrYXUomm3aj4EB+U4/CWDU5D3tIwNVXE4H/D2k0atcr81yYogvKyPy6wp+XP4wimYKKzAh6P6bVyIyWc8Bu0QcWEr8hVEo0DksonedsnmSjitTNK9p2Q25sa2ia+pGRXKKqMwGGTfWKcUOQjV78VEzPRZ2w7VNt79k6L+xnGl8AeNDbq967/24UWiUkQtXkS6+4BLwfWllDvNDYjic29xeU2pRadtO0k6BefMYfs5+HDWOItMqM4wTTCQduwOrf+2joIajMMFYEDWaVJdZMlQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g6uS68sNaERG1ondIudlSJUOg1yy0HPxx3TeaQ3RoKI=;
 b=lQyjSxwifL6L/LXK5mfMKgR9TmXiDCFyzjkrNt+ujMMv5/uH9Ise8+AuIpPeH+4uJXsXtyiiFQjYzmyzimkur4M5+4uTo3tCpSJE45RSH6HHq3fVLpBoz+flso/+zPEkScdNYJpJZzsqCfDBz2dLLjU3P6Yino6S7jX9cPSr4gI=
Received: from DM5PR21MB0137.namprd21.prod.outlook.com (10.173.173.12) by
 DM5PR21MB0748.namprd21.prod.outlook.com (10.173.172.14) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2263.2; Thu, 5 Sep 2019 23:18:55 +0000
Received: from DM5PR21MB0137.namprd21.prod.outlook.com
 ([fe80::c437:6219:efcc:fb8a]) by DM5PR21MB0137.namprd21.prod.outlook.com
 ([fe80::c437:6219:efcc:fb8a%7]) with mapi id 15.20.2263.004; Thu, 5 Sep 2019
 23:18:55 +0000
From:   Michael Kelley <mikelley@microsoft.com>
To:     "longli@linuxonhyperv.com" <longli@linuxonhyperv.com>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Sasha Levin <sashal@kernel.org>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Long Li <longli@microsoft.com>
Subject: RE: [Patch v3] storvsc: setup 1:1 mapping between hardware queue and
 CPU queue
Thread-Topic: [Patch v3] storvsc: setup 1:1 mapping between hardware queue and
 CPU queue
Thread-Index: AQHVZDzovSuzxYYkAEeci8JFnGV5zKcdtlHw
Date:   Thu, 5 Sep 2019 23:18:55 +0000
Message-ID: <DM5PR21MB013716CEE8942CB769E236F2D7BB0@DM5PR21MB0137.namprd21.prod.outlook.com>
References: <1567724073-30192-1-git-send-email-longli@linuxonhyperv.com>
In-Reply-To: <1567724073-30192-1-git-send-email-longli@linuxonhyperv.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Owner=mikelley@ntdev.microsoft.com;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2019-09-05T23:18:53.2998445Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=8c8ad67e-2337-47ff-9485-b53edfd6eb3e;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Extended_MSFT_Method=Automatic
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=mikelley@microsoft.com; 
x-originating-ip: [24.22.167.197]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1b420e17-6219-479c-d92b-08d732576c4b
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:DM5PR21MB0748;
x-ms-traffictypediagnostic: DM5PR21MB0748:|DM5PR21MB0748:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM5PR21MB07481E92036036268865458FD7BB0@DM5PR21MB0748.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1013;
x-forefront-prvs: 015114592F
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(346002)(376002)(39860400002)(366004)(136003)(396003)(199004)(189003)(8936002)(9686003)(8676002)(256004)(81156014)(55016002)(6436002)(71190400001)(2501003)(74316002)(305945005)(71200400001)(446003)(8990500004)(10090500001)(11346002)(7736002)(476003)(478600001)(4326008)(26005)(76176011)(81166006)(486006)(14454004)(10290500003)(7696005)(25786009)(186003)(6506007)(102836004)(5660300002)(33656002)(6116002)(110136005)(6246003)(1511001)(53936002)(107886003)(66066001)(52536014)(22452003)(3846002)(99286004)(2906002)(66476007)(64756008)(66446008)(66556008)(66946007)(76116006)(86362001)(2201001)(229853002)(316002)(921003)(1121003);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR21MB0748;H:DM5PR21MB0137.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: byA85rh9wL9RYPYIZTktMeEpHS1gMfWA07/xTY6H6u2JhzEPr/ZGw04092ugd9JtrJB6CWkhyVjyplC+b+fCkiH4uAuXLy/xo+8ksfG2sC9VRtOifrLsinHVKkV/EIUFTUgAiiDYx3p5/IQy/fXyj3np11Fut9Zfa8hf2OgUrRoj04s3S23YfT8v4GctTFko9bUq0cJugXS+kBG4kSMQwpkmWc5e2U4zhVon5G8u/ka5RMGtmn6WIZ+HTRBgoK8FjxjFb14AhE2qDVJuAvqPryCT62H7RomXxSZycuopB4EId7plt6xrTsdfMVjEh9yP2rjyXLhIfJW7xTDEie/pT7kYySMwkl2BN6nN2yDCBvth/D3O0UdbpIKkOzNynR1yaOszLeg9n4gRATEZCb1YAya58nyoVEtzklNEkfLqlKQ=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b420e17-6219-479c-d92b-08d732576c4b
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Sep 2019 23:18:55.4709
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2stSB7rM73jedR6i0hg1jJVWlGL+tjOz02oXm/pWk47/txCOnI/yhmwV68ny7zUnrZuroRoR1dFpDvjdlLktPbum86jn8sIHKQImGpkDwxE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR21MB0748
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

From: Long Li <longli@microsoft.com> Sent: Thursday, September 5, 2019 3:55=
 PM
>=20
> storvsc doesn't use a dedicated hardware queue for a given CPU queue. Whe=
n
> issuing I/O, it selects returning CPU (hardware queue) dynamically based =
on
> vmbus channel usage across all channels.
>=20
> This patch advertises num_present_cpus() as number of hardware queues. Th=
is
> will have upper layer setup 1:1 mapping between hardware queue and CPU qu=
eue
> and avoid unnecessary locking when issuing I/O.
>=20
> Changes:
> v2: rely on default upper layer function to map queues. (suggested by Min=
g Lei
> <tom.leiming@gmail.com>)
> v3: use num_present_cpus() instead of num_online_cpus(). Hyper-v doesn't
> support hot-add CPUs. (suggested by Michael Kelley <mikelley@microsoft.co=
m>)

I've mostly seen the "Changes:" section placed below the "---" so that it d=
oesn't
clutter up the commit log.  But maybe there's not a strong requirement one
way or the other as I didn't find anything called out in the "Documentation=
/process"
directory.

Michael

>=20
> Signed-off-by: Long Li <longli@microsoft.com>
> ---
>  drivers/scsi/storvsc_drv.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>=20
> diff --git a/drivers/scsi/storvsc_drv.c b/drivers/scsi/storvsc_drv.c
> index b89269120a2d..cf987712041a 100644
> --- a/drivers/scsi/storvsc_drv.c
> +++ b/drivers/scsi/storvsc_drv.c
> @@ -1836,8 +1836,7 @@ static int storvsc_probe(struct hv_device *device,
>  	/*
>  	 * Set the number of HW queues we are supporting.
>  	 */
> -	if (stor_device->num_sc !=3D 0)
> -		host->nr_hw_queues =3D stor_device->num_sc + 1;
> +	host->nr_hw_queues =3D num_present_cpus();
>=20
>  	/*
>  	 * Set the error handler work queue.
> --
> 2.17.1

