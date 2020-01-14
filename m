Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D6C9A139DC6
	for <lists+linux-hyperv@lfdr.de>; Tue, 14 Jan 2020 01:09:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729247AbgANAJQ (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 13 Jan 2020 19:09:16 -0500
Received: from mail-mw2nam10on2122.outbound.protection.outlook.com ([40.107.94.122]:30839
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729037AbgANAJQ (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 13 Jan 2020 19:09:16 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AgNPFIJj26p8JEMD1qlw24qy2/XOhKDD3etgr/gKW6Co6VlC2pZU14hRK7CDgcyrhj8yHlx1USeiSDJlqxvuBOQjS0y3k9QvA5FP6PxZjwecIBY0s2qnDllzmtn9pKfQZhBOElVONwfwGIO4Pqs9111iegOgIiYwbciS6Mm76fXDQVJdhrjbZhQgCE01q4XFG3a2lRJ5im53csfrBk0n/YT8JxIwc8mZn8jJx25dnSm2YRZVogmQDtNrs98scM9zrQAJ+kv2HifcsTfejLDDpsexkHn3Q81lMZWVf7sgdiYN20qtWiMH6tt469bKZU5pMb5r0yKtWC9QFfWnfeGlcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/r9plZLp71RQh02xobAbBVttQI7z40JfexOyUZR2Lc0=;
 b=cIX7wmaXiaFEUooEivm5bLafGdCnZhr95KOItDsSyg6/ZRBC4Eigz4y8AkZcbRHP8sc80kFJeIkuWbCeNQIhrYfB6IDwsSmGvSpMI1lM1SsANrPDd/qZJVgccCTbPJujDF1ms+eYRvOIUHmuuRkG9VU6kczZQzSCV5OewNyIhePcHNhSqTl0YtbbcHQ8WapLoLnVbZrqxAkdIISQ5la/IoKccSfUKJ7aVw6oJo2kvpRqY1fOtbv1OoOVtEDFSBR2N45uh6CmBj9zqgV4zjK1f1rr67RUwgPSPnrbzHnG9H07ElQCNnT+PP/Bipb8MHvewBxZpSrSiwAp685Jr5M9ZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/r9plZLp71RQh02xobAbBVttQI7z40JfexOyUZR2Lc0=;
 b=RCfWsjSrK4aWfntJFHAKDv8N0sxuSPJqgrgLYa9Z4xOAU7BBprlnJazVAdt33D4ABWZxVIPqnGUCVxGW6AFlEnnXzN2YMoRaZBT+54ihOSmyvXDkfGZ4rjdqUmIMNSuSZSADfansvSn4Iias5pXfxgNi+tZeT7aNsK5dX0lVJuA=
Received: from BL0PR2101MB1123.namprd21.prod.outlook.com (52.132.20.151) by
 BL0PR2101MB1123.namprd21.prod.outlook.com (52.132.20.151) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2644.1; Tue, 14 Jan 2020 00:09:14 +0000
Received: from BL0PR2101MB1123.namprd21.prod.outlook.com
 ([fe80::d1de:7b03:3f66:19fb]) by BL0PR2101MB1123.namprd21.prod.outlook.com
 ([fe80::d1de:7b03:3f66:19fb%6]) with mapi id 15.20.2644.015; Tue, 14 Jan 2020
 00:09:14 +0000
From:   Long Li <longli@microsoft.com>
To:     Michael Kelley <mikelley@microsoft.com>,
        "longli@linuxonhyperv.com" <longli@linuxonhyperv.com>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Sasha Levin <sashal@kernel.org>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] scsi: storvsc: Correctly set number of hardware queues
 for IDE disk
Thread-Topic: [PATCH] scsi: storvsc: Correctly set number of hardware queues
 for IDE disk
Thread-Index: AQHVyFeNXrmFjnrM6EqlVQHcZtw04qfnOc2AgAITGyA=
Date:   Tue, 14 Jan 2020 00:09:13 +0000
Message-ID: <BL0PR2101MB1123B1FE52EA5FEFA14BA711CE340@BL0PR2101MB1123.namprd21.prod.outlook.com>
References: <1578730634-109961-1-git-send-email-longli@linuxonhyperv.com>
 <MW2PR2101MB105213EDB40D8974CF45A8B6D73A0@MW2PR2101MB1052.namprd21.prod.outlook.com>
In-Reply-To: <MW2PR2101MB105213EDB40D8974CF45A8B6D73A0@MW2PR2101MB1052.namprd21.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Owner=mikelley@ntdev.microsoft.com;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2020-01-12T16:27:52.7146620Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=8f411da8-28a5-40b9-a091-23693cfcc31b;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Extended_MSFT_Method=Automatic
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=longli@microsoft.com; 
x-originating-ip: [2001:4898:80e8:2:edec:db5c:c6fe:798]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 8281001d-bffd-4e06-b408-08d79885fd2a
x-ms-traffictypediagnostic: BL0PR2101MB1123:|BL0PR2101MB1123:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BL0PR2101MB11233B9BCC8E22AFA3E494B3CE340@BL0PR2101MB1123.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5797;
x-forefront-prvs: 028256169F
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(376002)(346002)(136003)(366004)(396003)(39860400002)(199004)(189003)(33656002)(8990500004)(86362001)(8676002)(71200400001)(2906002)(316002)(10290500003)(52536014)(76116006)(9686003)(64756008)(478600001)(55016002)(110136005)(66946007)(5660300002)(8936002)(7696005)(81156014)(186003)(6506007)(66556008)(81166006)(66446008)(66476007)(921003)(1121003);DIR:OUT;SFP:1102;SCL:1;SRVR:BL0PR2101MB1123;H:BL0PR2101MB1123.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Ehl8C5dI/V4RjkhTapQo0ZMNcuEdZmk/sMZcnv+/HCc3Z3weDWvMEO/6a8trp4CfFx9vSx32Ds7qC/DFQOd3fVfz5ptSE4JD2Yt3DV/sYsshLcjG47m3HCWtd5J3G0u7jZxmk8bKTDJPFuFTjwIOsseiSP5+6Gj00hZY3B11vf0S5iN6WpTN7fbRMfjYKz7Ci8B6NraIAdKtYfUlVGvgbI/3xNauAiya1CF4EYN6O/ikQT+d0S8SBkhFKmMVfPp13QqoQbboqGZ1fUDrTC4wOv9TxjlvE7Bj4GLblZjaYuu9X6/jEWJXIzXHXGFZ9jrsiMEPUfi5kUtE0mF0ZYY20j2uTvCR/NuIe22U9coDSHkHx+nPd7sQ1JowyCN90SA75XlGN2jVsmq2pr3uHU7pEmRhUX4KEHQIG6mF6MRqnd///uwVIhBLtcqGPTVeyZPvL1iGdf1y1BZPYOG0l0VEgzPBk4vOyE1ik9ywe9pSivL50cIgahweVGmkkHNx/vor
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8281001d-bffd-4e06-b408-08d79885fd2a
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jan 2020 00:09:13.9722
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: S8MLL1yxuqj64Zi7ryh1X2U9m9owlZtpVhba/fsWplK74256nnqfP5myBzRxtxnmDb5K8SoZeMOruWrZF2XuyQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR2101MB1123
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

>Subject: RE: [PATCH] scsi: storvsc: Correctly set number of hardware queue=
s for
>IDE disk
>
>From: Long Li <longli@microsoft.com>  Sent: Saturday, January 11, 2020 12:=
17
>AM
>>
>> Commit 0ed881027690 ("scsi: storvsc: setup 1:1 mapping between
>> hardware queue and CPU queue") introduced a regression for disks
>> attached to IDE. For these disks the host VSP only offers one VMBUS
>> channel. Setting multiple queues can overload the VMBUS channel and
>> result in performance drop for high queue depth workload on system
>> with large number of CPUs.
>>
>> Fix it by leaving the number of hardware queues to 1 (default value)
>> for IDE disks.
>>
>> Fixes: 0ed881027690 ("scsi: storvsc: setup 1:1 mapping between
>> hardware queue and CPU
>> queue")
>> Signed-off-by: Long Li <longli@microsoft.com>
>> ---
>>  drivers/scsi/storvsc_drv.c | 4 +++-
>>  1 file changed, 3 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/scsi/storvsc_drv.c b/drivers/scsi/storvsc_drv.c
>> index f8faf8b3d965..992b28e40374 100644
>> --- a/drivers/scsi/storvsc_drv.c
>> +++ b/drivers/scsi/storvsc_drv.c
>> @@ -1842,9 +1842,11 @@ static int storvsc_probe(struct hv_device *device=
,
>>  	 */
>>  	host->sg_tablesize =3D (stor_device->max_transfer_bytes >> PAGE_SHIFT)=
;
>>  	/*
>> +	 * For non-IDE disks, the host supports multiple channels.
>>  	 * Set the number of HW queues we are supporting.
>>  	 */
>> -	host->nr_hw_queues =3D num_present_cpus();
>> +	if (dev_id->driver_data !=3D IDE_GUID)
>
>This function already has a pre-computed value of this test in
>the local variable "dev_is_ide".   It would be more consistent
>to just use it.
>
>Michael

I will send v2 to address this.

Long

>
>> +		host->nr_hw_queues =3D num_present_cpus();
>>
>>  	/*
>>  	 * Set the error handler work queue.
>> --
>> 2.20.1

