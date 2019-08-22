Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 02E099A2E9
	for <lists+linux-hyperv@lfdr.de>; Fri, 23 Aug 2019 00:31:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731652AbfHVW3V (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 22 Aug 2019 18:29:21 -0400
Received: from mail-eopbgr780091.outbound.protection.outlook.com ([40.107.78.91]:37566
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730641AbfHVW3V (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 22 Aug 2019 18:29:21 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A61y/pO142+NhcdMbmXjiWmvs6HquCi+dFBAsVU0vYRMwRj7ouHbTgc4fupTJ/K1GKO6GEU+fKgLZUMzXQQAG44M5UsSROmGw8RVE64j+Lmzsl9fYATOqLSuKby93ljdR6Pbe1voV5KVrLcMcxINN+D05GG93w/tKZ+j2oChjBc+HYM2qkxhXqu5JP+v7bcggf60LO599nUvNR+7BpRLT2fYZPRjmPcUcARW6aMY4kmoGsEs88ftP5Y0o+D8GsvG69qiv03U3LPQlFJ2Q4x23Mo+GfxEcCfPfE/iO1kmPCt9AnaPLob5bQAyLLA93dmPaF+sjTC8aEy011pWa48YBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QWahqFq88NY/cXZPjklrh/eUy2K/cuEgrTHiOxer53w=;
 b=OSohk27BFXYskieaM6SaP9GO6e4LCwi/B34SS9XpoqZi3+FwKvuwISUjiGlxmsk6F5UDRgFvybcC/V1Wojw3uOhh52HC1LT7S/AOmkPLuu87jfMcIzQJdoXGBSbCqXdw6bZ4hk01xAyb4QeOW6G+gltK/xy0E1dDnxpqPtkzuJeFbpPchkXwiojIKFd3uVdLU9y4vlVMZC9JVU8wV1hMc3YEd6wpCIt4Q9pnKH2FmM0SZm/RDBO7Q0cdurMN6dlIBc2SLDyYPHLqVQghBIsGd2NNY+DAsHRwaWgzgRD0M9Q6zUpy95ezBXwHi+DpVCMd2lCt8GFy9+j5GPxZn4gbkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QWahqFq88NY/cXZPjklrh/eUy2K/cuEgrTHiOxer53w=;
 b=GvS+YhzPo5GNMNWBhty08MMVGAq5WFMo7nsyrAJ3iiqN9XDxMJT9fjIc18mMAwKYAcot/ZfG7+KmPUvTTNoE3V2XrqAVetLSyGS0oKVwdjmOfVcyheMJooj/iI/8ZHOWhUtad3XJUvIHrUARJ0o1ydAGjdJs9GqWu1dj7x5Zgfc=
Received: from CY4PR21MB0741.namprd21.prod.outlook.com (10.173.189.7) by
 CY4PR21MB0838.namprd21.prod.outlook.com (10.173.192.139) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2220.3; Thu, 22 Aug 2019 22:29:18 +0000
Received: from CY4PR21MB0741.namprd21.prod.outlook.com
 ([fe80::2c62:5380:9ed8:496d]) by CY4PR21MB0741.namprd21.prod.outlook.com
 ([fe80::2c62:5380:9ed8:496d%11]) with mapi id 15.20.2220.000; Thu, 22 Aug
 2019 22:29:18 +0000
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
Subject: RE: [Patch v2] storvsc: setup 1:1 mapping between hardware queue and
 CPU queue
Thread-Topic: [Patch v2] storvsc: setup 1:1 mapping between hardware queue and
 CPU queue
Thread-Index: AQHVWSojurs2/K071EGMpSV6zPYfmKcHpzgAgAAUbOCAAAK5IA==
Date:   Thu, 22 Aug 2019 22:29:17 +0000
Message-ID: <CY4PR21MB07411317E2AE90D70E23E2CECEA50@CY4PR21MB0741.namprd21.prod.outlook.com>
References: <1566506543-1090-1-git-send-email-longli@linuxonhyperv.com>
 <DM5PR21MB01372B7A717EAC7F0BCF826AD7A50@DM5PR21MB0137.namprd21.prod.outlook.com>
 <CY4PR21MB0741D566F71F0D1E8C5B9970CEA50@CY4PR21MB0741.namprd21.prod.outlook.com>
In-Reply-To: <CY4PR21MB0741D566F71F0D1E8C5B9970CEA50@CY4PR21MB0741.namprd21.prod.outlook.com>
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
 smtp.mailfrom=longli@microsoft.com; 
x-originating-ip: [2001:4898:80e8:7:ede6:db5c:c6fe:798]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6bab8079-6781-4af8-950e-08d727502bb7
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600166)(711020)(4605104)(1401327)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:CY4PR21MB0838;
x-ms-traffictypediagnostic: CY4PR21MB0838:|CY4PR21MB0838:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CY4PR21MB0838B0264102CDD6491C559CCEA50@CY4PR21MB0838.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-forefront-prvs: 01371B902F
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(346002)(39860400002)(376002)(396003)(366004)(136003)(199004)(189003)(53936002)(5660300002)(52536014)(10290500003)(6436002)(55016002)(2906002)(8936002)(76176011)(7696005)(9686003)(478600001)(6246003)(6116002)(66446008)(229853002)(46003)(10090500001)(446003)(11346002)(1511001)(25786009)(66556008)(66946007)(99286004)(66476007)(81156014)(81166006)(76116006)(486006)(2501003)(2940100002)(64756008)(14454004)(71190400001)(8676002)(71200400001)(6506007)(8990500004)(74316002)(186003)(305945005)(102836004)(7736002)(86362001)(2201001)(110136005)(476003)(316002)(33656002)(22452003)(256004)(921003)(1121003);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0838;H:CY4PR21MB0741.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: Wt8sQ7VJY11ASOrZgeCR8g0OGs/47DQKEAN9Yg/hQ0IERYlNOoYFSFQ8ktK1MSQv4cKoBT61sloHorRKYJWciEFfC6EBEErystwkXynbGCSXsxYcsVN/pqSmRnat9qD6f5ro+kIypljyyitdpq8Vc1AcIEX+891qiezwLWEuy8/C7F6Yl2Vg/+jqBsA5TDtPPZPrweI8QtPxUxmCotv9Q8/OPgmCXLehS8nw9ka7nwLuApwXHOsK0ip0JbPNcVbbHmPKjySJ1DWY9vo9G5c9LhW0hwCvHE7CnvOa5am7vXMjG426Eu27ElpjdUAPDOt9hdwvVlfsN/u9VqzREnoNkq6BT7quknK6VIitUhcXpXdcKVsK6gvDHkCC8rTWe7di8aCsNOOOKVU2VJ6UFbDttpAtieTCWjmQrnJdGL30hjE=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6bab8079-6781-4af8-950e-08d727502bb7
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Aug 2019 22:29:17.9243
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fiRrTtZJ7lUV8y9BiUu4m7ks3CbqXs+oh0BBbKl4PffBBiCzVeVULkR0t7XvyXBrTGxX5dp7MhPbl3HeGdj/LA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0838
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

>>>Subject: RE: [Patch v2] storvsc: setup 1:1 mapping between hardware
>>>queue and CPU queue
>>>
>>>>>>Subject: RE: [Patch v2] storvsc: setup 1:1 mapping between hardware
>>>>>>queue and CPU queue
>>>>>>
>>>>>>From: Long Li <longli@linuxonhyperv.com> Sent: Thursday, August 22,
>>>>>>2019
>>>>>>1:42 PM
>>>>>>>
>>>>>>> storvsc doesn't use a dedicated hardware queue for a given CPU
>>>queue.
>>>>>>> When issuing I/O, it selects returning CPU (hardware queue)
>>>>>>> dynamically based on vmbus channel usage across all channels.
>>>>>>>
>>>>>>> This patch advertises num_possible_cpus() as number of hardware
>>>>>>> queues. This will have upper layer setup 1:1 mapping between
>>>>>>> hardware queue and CPU queue and avoid unnecessary locking when
>>>issuing I/O.
>>>>>>>
>>>>>>> Changes:
>>>>>>> v2: rely on default upper layer function to map queues. (suggested
>>>>>>> by Ming Lei
>>>>>>> <tom.leiming@gmail.com>)
>>>>>>>
>>>>>>> Signed-off-by: Long Li <longli@microsoft.com>
>>>>>>> ---
>>>>>>>  drivers/scsi/storvsc_drv.c | 3 +--
>>>>>>>  1 file changed, 1 insertion(+), 2 deletions(-)
>>>>>>>
>>>>>>> diff --git a/drivers/scsi/storvsc_drv.c
>>>>>>> b/drivers/scsi/storvsc_drv.c index b89269120a2d..dfd3b76a4f89
>>>>>>> 100644
>>>>>>> --- a/drivers/scsi/storvsc_drv.c
>>>>>>> +++ b/drivers/scsi/storvsc_drv.c
>>>>>>> @@ -1836,8 +1836,7 @@ static int storvsc_probe(struct hv_device
>>>>>>*device,
>>>>>>>  	/*
>>>>>>>  	 * Set the number of HW queues we are supporting.
>>>>>>>  	 */
>>>>>>> -	if (stor_device->num_sc !=3D 0)
>>>>>>> -		host->nr_hw_queues =3D stor_device->num_sc + 1;
>>>>>>> +	host->nr_hw_queues =3D num_possible_cpus();
>>>>>>
>>>>>>For a lot of the VM sizes in Azure, num_possible_cpus() is 128, even
>>>>>>if the VM has only 4 or 8 or some other smaller number of vCPUs.
>>>>>>So I'm wondering if you really want num_present_cpus() here instead,
>>>>>>which would include only the vCPUs that actually exist in the VM.
>>>
>>>I think reporting num_possible_cpus() doesn't do more harm or take more
>>>resources. Because block layer allocates map for all the possible CPUs.
>>>
>>>The actual mapping is done in blk_mq_map_queues(), and it iterates all t=
he
>>>possible CPUs. If we report num_present_cpus(), the rest of the CPUs als=
o
>>>need to be mapped.

Actually I get your point, reporting num_present_cpus() will get less numbe=
r of struct blk_mq_hw_ctx created. So it saves memory.

If we don't plan to support adding/onlining CPUs, we should use num_present=
_cpus().

>>>
>>>>>>
>>>>>>Michael
>>>>>>
>>>>>>>
>>>>>>>  	/*
>>>>>>>  	 * Set the error handler work queue.
>>>>>>> --
>>>>>>> 2.17.1

