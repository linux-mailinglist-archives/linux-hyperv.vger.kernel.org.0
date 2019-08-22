Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C39E89A1A8
	for <lists+linux-hyperv@lfdr.de>; Thu, 22 Aug 2019 23:03:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404701AbfHVVBg (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 22 Aug 2019 17:01:36 -0400
Received: from mail-eopbgr710097.outbound.protection.outlook.com ([40.107.71.97]:35701
        "EHLO NAM05-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2404579AbfHVVBf (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 22 Aug 2019 17:01:35 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cB28Ue5D9jmN+omg6H955WihIT9oMARQwI3lmxaPt9JUsVR/LktLD+Mdbk+MSuvBq1QGZRK6NXUOXvGd8N2GkVs2OQmlak+AF1sA4xbI6aRgekhL6QHF6/l1ZndDqTBr0xHvbUedPrDHxlS1p8irbv04zuo4uWikM/fCIwapS67VqqBOCUdacyvwSu7Ibq0hNZWm4+DOSmjDQ9f1SdDy2N114jrIUuBZfgvD/AT5CV5pyXPMWuntilq2NJ1EHHm407meqUjOvFQyszlXFBKjUFRBU52v6fefPXjj/jbQc9OWtEJbBr56+DGcuXEJvDEJaGOMQVpiy67/vMYxc0NYMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Kk/mjx6x7INEnJ+ZA1icuvR1PZBdIPlp7N9Ot7Vsn4w=;
 b=MU+yC9buswEIAfU1Yeltl4dlHY5hENpy4zeXg6MMP2QrZJo6YGptEKS0abEdLuow521COykVYSweB+5U/ZflLh6NC9tY3TueACrY2rq2E15hbQPzMh0v+P6pIpdOj4CKFr/UyCxQx0YBsn/HKQfrsGgZH5LHi5RyPIphIJdtEjexBVOpT1jdZ/RTMiALdlsSMZX8hiWetQ9WfYEgHIL/xhWJSH57Pd8fTenzQhAM+02dHAQMII+A7rHDTZbiEHbW+BtOQo4Gj7MRmhC3zWLep1YMHiqzn2n0ndnPdAC3jV+i9awI1rUGRfiNQ3CRaHDjgKDvGsJUBoogo9B63SpxfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Kk/mjx6x7INEnJ+ZA1icuvR1PZBdIPlp7N9Ot7Vsn4w=;
 b=gcXTaWMa4kxAwfs7APCwoY117NUWnMQo6Suoq6tuI87TXvPz3G8a6Mmz/2sFMAsQm6WM7mL22iSKfjJzMPvgh9847vjTECkV8iJPOEr/r98tP1dl2z2PX4LI4DjfX3NAfUCf3Bj5NegZdHnUp1C3jBMU6iXT0pV61pgNW1yq+qE=
Received: from DM5PR21MB0137.namprd21.prod.outlook.com (10.173.173.12) by
 DM5PR21MB0283.namprd21.prod.outlook.com (10.173.174.18) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2220.3; Thu, 22 Aug 2019 21:01:33 +0000
Received: from DM5PR21MB0137.namprd21.prod.outlook.com
 ([fe80::8985:a319:f21:530e]) by DM5PR21MB0137.namprd21.prod.outlook.com
 ([fe80::c437:6219:efcc:fb8a%8]) with mapi id 15.20.2220.000; Thu, 22 Aug 2019
 21:01:32 +0000
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
Subject: RE: [Patch v2] storvsc: setup 1:1 mapping between hardware queue and
 CPU queue
Thread-Topic: [Patch v2] storvsc: setup 1:1 mapping between hardware queue and
 CPU queue
Thread-Index: AQHVWSoj7r/J+148r06XPcEVD5AXkKcHo/OQ
Date:   Thu, 22 Aug 2019 21:01:32 +0000
Message-ID: <DM5PR21MB01372B7A717EAC7F0BCF826AD7A50@DM5PR21MB0137.namprd21.prod.outlook.com>
References: <1566506543-1090-1-git-send-email-longli@linuxonhyperv.com>
In-Reply-To: <1566506543-1090-1-git-send-email-longli@linuxonhyperv.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Owner=mikelley@ntdev.microsoft.com;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2019-08-22T21:01:25.5255249Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=b830148f-8445-4448-ae01-b11c5496a8d5;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Extended_MSFT_Method=Automatic
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=mikelley@microsoft.com; 
x-originating-ip: [24.22.167.197]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2dc3a7c5-2fb4-45c3-727e-08d72743e97c
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600166)(711020)(4605104)(1401327)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:DM5PR21MB0283;
x-ms-traffictypediagnostic: DM5PR21MB0283:|DM5PR21MB0283:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM5PR21MB0283FBFAF11BFE5352963EEED7A50@DM5PR21MB0283.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-forefront-prvs: 01371B902F
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(346002)(376002)(396003)(39860400002)(366004)(136003)(189003)(199004)(33656002)(74316002)(305945005)(8676002)(8990500004)(6436002)(102836004)(8936002)(81156014)(14454004)(256004)(81166006)(64756008)(22452003)(7736002)(10090500001)(6506007)(76116006)(5660300002)(66446008)(316002)(229853002)(11346002)(66556008)(66476007)(25786009)(55016002)(186003)(26005)(2906002)(7696005)(71190400001)(2501003)(71200400001)(10290500003)(99286004)(6246003)(110136005)(9686003)(66066001)(3846002)(107886003)(86362001)(446003)(6116002)(486006)(53936002)(52536014)(476003)(2201001)(76176011)(4326008)(1511001)(66946007)(478600001)(921003)(1121003);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR21MB0283;H:DM5PR21MB0137.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: cRi4QqJN5KK1vjaQKmcoDGjYhmI3962/nk1pQrXD/tY0m6pgOEenCZjEq/4YYXbFsSQ5O7pMDRp5npxWUmh0lXJY2oUoV8WW6PRH3lV60wuIqsLoIAUzjF2X3XeoRM/rdyyelRWmKAiU8+oc9uusyjzpIZ7N5uBzUkNkFPaZcdk95M9Ais+yt2v6eGJO0uR1CQeCHaVxGBysW5SgRipYeopLTeSNgNTcX2HjSXDnqh4fuoEBUZfhU4sauLeOsLowLHihgskSKpjp+ABsVStlE9tsLD/v6wGNTCofexy5076Yfp9vppv0HO5vwOJP1Ca01dCKdjSMtyxs/BeBIHFTOWlYVT1Dh8MNVZx8Lgf9qOn/N39rAKICOK7SgkAEF+AOa5Z8XnPbU6dgKCZhQUz9R8pgf9LG3vC0GawQgee9VsQ=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2dc3a7c5-2fb4-45c3-727e-08d72743e97c
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Aug 2019 21:01:32.8014
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8/BVhargVuVcXQxsgLrtZZCH0ss4RDwHQ2g/EaHaW/qJ3Z6WkgDataAszkxMsYpg1oO2S20JP4zT0THQpArNbHCkry7IZ9oP6qMdg51al6w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR21MB0283
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

From: Long Li <longli@linuxonhyperv.com> Sent: Thursday, August 22, 2019 1:=
42 PM
>=20
> storvsc doesn't use a dedicated hardware queue for a given CPU queue. Whe=
n
> issuing I/O, it selects returning CPU (hardware queue) dynamically based =
on
> vmbus channel usage across all channels.
>=20
> This patch advertises num_possible_cpus() as number of hardware queues. T=
his
> will have upper layer setup 1:1 mapping between hardware queue and CPU qu=
eue
> and avoid unnecessary locking when issuing I/O.
>=20
> Changes:
> v2: rely on default upper layer function to map queues. (suggested by Min=
g Lei
> <tom.leiming@gmail.com>)
>=20
> Signed-off-by: Long Li <longli@microsoft.com>
> ---
>  drivers/scsi/storvsc_drv.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>=20
> diff --git a/drivers/scsi/storvsc_drv.c b/drivers/scsi/storvsc_drv.c
> index b89269120a2d..dfd3b76a4f89 100644
> --- a/drivers/scsi/storvsc_drv.c
> +++ b/drivers/scsi/storvsc_drv.c
> @@ -1836,8 +1836,7 @@ static int storvsc_probe(struct hv_device *device,
>  	/*
>  	 * Set the number of HW queues we are supporting.
>  	 */
> -	if (stor_device->num_sc !=3D 0)
> -		host->nr_hw_queues =3D stor_device->num_sc + 1;
> +	host->nr_hw_queues =3D num_possible_cpus();

For a lot of the VM sizes in Azure, num_possible_cpus() is 128, even if
the VM has only 4 or 8 or some other smaller number of vCPUs.
So I'm wondering if you really want num_present_cpus() here instead,
which would include only the vCPUs that actually exist in the VM.

Michael

>=20
>  	/*
>  	 * Set the error handler work queue.
> --
> 2.17.1

