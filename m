Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2DB3BAC04C
	for <lists+linux-hyperv@lfdr.de>; Fri,  6 Sep 2019 21:14:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406349AbfIFTOo (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 6 Sep 2019 15:14:44 -0400
Received: from mail-eopbgr780101.outbound.protection.outlook.com ([40.107.78.101]:64240
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2404511AbfIFTOl (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 6 Sep 2019 15:14:41 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N2jenu9paCEYoIC/AaspufUcLPgi8Wg53zX99gMAqB5jgdApnV7ZsET6oHHU6n1VpMsMFCiAPtAjCiNdJBtFwTiE63Pt0StRmcOyinuyuNWRoij232aScgjxlA2UPVEOc22ZfAVLrQiacd52QW3IqDRsKMIaK7euUc43CXlchsV3poGqt4nlv1h9i45kEe0RKenhk3Gb7cYKY5NMACKeUlsA5Gi3mZsWXIBDFcBlW8jYiVSIwZFSQDQ560FTLv+dte8dM1fYT3YwjboeU8eSVQuZ5CwJXWxAedd1SOt3EDGS/GX/+HNePs48U3ZaOpY8iRunvXiFxOvbl/IS9kP2jw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2T8bL8xFIBxqyRlZm/cOvET9uWHvS10GMi7u89DagrM=;
 b=oTNcU8p77OFQLd6EvfvAIo5fghB26CcVuLZMmufl5hkQ2tUKAWA7yYplmOmv/3ROIceKzvokCbZjqHCSGZSMPyLgOOHm4VPXuT+3JVmZKzF4jO09Pa2Dfd2LbPdnxstpmHqn//odCL7FhBWMuRmnYylHj+QGYItUOiUtmkFs0kbjZZN+4v47GzaDTaZeIOiCvDyvk764gnj6T61hx1EPluhU/vyajSatxeFaRg/Sxha+kYfquwCNlYtCzUK2ITZ48l+nSscrNWflCOBRxROcGvHKXPVQHR1D0GmBNeObVvOXf0JY0eCOVJzrdAUjkIsmgxz78jjuOeGXse1il5tMVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2T8bL8xFIBxqyRlZm/cOvET9uWHvS10GMi7u89DagrM=;
 b=OKn4KvcZtjBERbc0KO4NeT5ECs8CH+gowmrkomrbjZGN9G/1EegZO1jOi21wDOG7tWS3EWJdapDTj9Ok3hLuoywdkEUD9hdr71XbqNdxLFiXDCATpAPBhUko4Yco8OZpc0o38djWFsLXa+nhxW9szwUV/++ZbclhBKikJLOJWjk=
Received: from DM5PR21MB0137.namprd21.prod.outlook.com (10.173.173.12) by
 DM5PR21MB0777.namprd21.prod.outlook.com (10.173.172.147) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2263.4; Fri, 6 Sep 2019 19:14:35 +0000
Received: from DM5PR21MB0137.namprd21.prod.outlook.com
 ([fe80::c437:6219:efcc:fb8a]) by DM5PR21MB0137.namprd21.prod.outlook.com
 ([fe80::c437:6219:efcc:fb8a%7]) with mapi id 15.20.2263.004; Fri, 6 Sep 2019
 19:14:35 +0000
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
Subject: RE: [Patch v4] storvsc: setup 1:1 mapping between hardware queue and
 CPU queue
Thread-Topic: [Patch v4] storvsc: setup 1:1 mapping between hardware queue and
 CPU queue
Thread-Index: AQHVZNf5d6gqxCtgp0Wp5Wp4RKbtH6cfBJNQ
Date:   Fri, 6 Sep 2019 19:14:35 +0000
Message-ID: <DM5PR21MB01376CB3688150F0731808F8D7BA0@DM5PR21MB0137.namprd21.prod.outlook.com>
References: <1567790660-48142-1-git-send-email-longli@linuxonhyperv.com>
In-Reply-To: <1567790660-48142-1-git-send-email-longli@linuxonhyperv.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Owner=mikelley@ntdev.microsoft.com;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2019-09-06T19:14:33.3313595Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=f2571df8-af2e-443b-bbf0-eb32105d2e3b;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Extended_MSFT_Method=Automatic
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=mikelley@microsoft.com; 
x-originating-ip: [24.22.167.197]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e58c6ec7-b016-4f78-24d6-08d732fe7498
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600166)(711020)(4605104)(1401327)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:DM5PR21MB0777;
x-ms-traffictypediagnostic: DM5PR21MB0777:|DM5PR21MB0777:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM5PR21MB07776A5ABDFDBB871AD75D09D7BA0@DM5PR21MB0777.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3826;
x-forefront-prvs: 0152EBA40F
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(396003)(136003)(346002)(376002)(39860400002)(366004)(189003)(199004)(54534003)(9686003)(55016002)(52536014)(6246003)(110136005)(4326008)(7696005)(76176011)(102836004)(33656002)(76116006)(64756008)(66446008)(66556008)(66476007)(22452003)(316002)(6506007)(66946007)(107886003)(66066001)(8676002)(81156014)(81166006)(1511001)(53936002)(8936002)(86362001)(256004)(478600001)(71200400001)(71190400001)(10290500003)(2906002)(10090500001)(5660300002)(6436002)(14454004)(6116002)(3846002)(2201001)(2501003)(8990500004)(25786009)(99286004)(186003)(229853002)(446003)(11346002)(26005)(476003)(305945005)(486006)(7736002)(74316002)(921003)(1121003);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR21MB0777;H:DM5PR21MB0137.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: uuITBlqFhHU7qgph1ZoB9oznNJiO0lpFR1vmKh4HOHkXs3iqQ1rRVAsnK5ZIVJtjF+dKIwCKQabgIb/5J7q6hOmZGGrewI+OTvjLHRazV9B6jENLmR1fHrhoPkQum2Pb0GkSmq2ph6mxtGdT03QdhKy6jQHbx7cDyJufThXJzvLSMVjPvi2jlJ5LJo3AiLCoTWo8Nio9r/PMFFwO5eQByrzCX3I8JxsuDhrXuSt8+SBnM5UfgHUkAIEgdxneW5iyUzX7Ph+nPHg8WHHkX8e3UUd4jE/bXAihkufQy2UZUECNexNokzoA/DjEJihXBwO85ceymGovdTTql1mw3KuHWQSDdxn6tobLAfKGr6OREu02gHX+N8OdOU1eoYuM/2HvYK6LbstghzD83lbnZXveSi/ODVEEQT2TPq1Nd3YZTnI=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e58c6ec7-b016-4f78-24d6-08d732fe7498
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Sep 2019 19:14:35.3845
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: n+fOpl/oWaLl338BPAWLNtvLynXaq5pzOFM5SIFggvHberREg1Yzrzth2LH4ouXuk+3pm53M62hBQY8/IwubRPIDemd4Ahvk6tx7cIHJwrg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR21MB0777
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

From: Long Li <longli@microsoft.com> Sent: Friday, September 6, 2019 10:24 =
AM
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
> Signed-off-by: Long Li <longli@microsoft.com>
> ---
>=20
> Changes:
> v2: rely on default upper layer function to map queues. (suggested by Min=
g Lei
> <tom.leiming@gmail.com>)
> v3: use num_present_cpus() instead of num_online_cpus(). Hyper-v doesn't
> support hot-add CPUs. (suggested by Michael Kelley <mikelley@microsoft.co=
m>)
> v4: move change logs to after Signed-of-by
>=20
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

Reviewed-by: Michael Kelley <mikelley@microsoft.com>

