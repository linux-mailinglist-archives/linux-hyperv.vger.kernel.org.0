Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 068CAAB0FF
	for <lists+linux-hyperv@lfdr.de>; Fri,  6 Sep 2019 05:34:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731938AbfIFDep (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 5 Sep 2019 23:34:45 -0400
Received: from mail-eopbgr820133.outbound.protection.outlook.com ([40.107.82.133]:48941
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2404422AbfIFDep (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 5 Sep 2019 23:34:45 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ig/Yk1KT63O210RzwL+MGSfp8WnMROqwBn5bs+FYVA5XhuEccwZGWgFwyvzC/i0ydXPDNi2Ts5cJXlR7FQz0pCtbVPCyAunH4JSAi2wszYgCdT7fM4/AGPBG2G0kjrI7htdSTAhibFD6ocieu4eNtOak/qiXSqeWtQNfBpTsu3D6sxTwH1hiFayTQwp1Jcd1hCO9lwSWCGYF0vJ2Stc8AE/cQnBXl1ZAKW4V4AwuQE9BsizYK3Rq4RI8bl3xyG1KFu0it0wSHClmqJ75fXN8U9yFP37XcWibZ249Ycq4HjQAdmNCz2sL8gHCBhRFhni/T/bHw//1za0z7GLjFs9h3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dF24yvn3wKfXkDO9fDDJPsl7Hc6P7joJmYY0A4GS1uA=;
 b=iCYOQ/Wn19t6FTmeTVnaQTCzAwAPCqJi3UCkar152UUpiTjrBeQkJczJlwNczdz0KFJ5TUvgOkRJ2+XMssKW5vhqt4ReyVj1GK+a0mdZKjalrOZQiOFHy7LWXmJh+cFl9F2DaNLJNRKzX5C1okvJqiK/0ZfHLG8aowgduczQasODfVCkPNOPlWwJPppuqBWsd36W1lWQ7UQwrmesvOCT7l/dzjo9at4twsTWZ6GEkRc5NIpDeERBak827pmiLGrarmOomcz9Cw7Kh7C+iXzimIitulN3oSOafH8QA01c70fTHJ/XOSfK9KF+8no6PTjT6Y0DRotIRlKaDedOB7Q00g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dF24yvn3wKfXkDO9fDDJPsl7Hc6P7joJmYY0A4GS1uA=;
 b=BufWdXW+i+5zfRvRIbWAX4AN/ZcHXlDG+QMhXSWM+n2oZmDCZ9MbYT+2RwEsaUxPmus8g+evhdRZSVOqHEYqC+DHWbU6YBAx9VIsMtHQ6JO2E3i3GwABjGXBDCO17ukf8ryil+q1M5ICSVWDBRe7bxuXnEyRAFBMPV0j2tQtsGE=
Received: from CY4PR21MB0741.namprd21.prod.outlook.com (10.173.189.7) by
 CY4PR21MB0773.namprd21.prod.outlook.com (10.173.192.19) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2263.6; Fri, 6 Sep 2019 03:34:42 +0000
Received: from CY4PR21MB0741.namprd21.prod.outlook.com
 ([fe80::5caa:ae40:7c3a:4b1d]) by CY4PR21MB0741.namprd21.prod.outlook.com
 ([fe80::5caa:ae40:7c3a:4b1d%5]) with mapi id 15.20.2263.005; Fri, 6 Sep 2019
 03:34:42 +0000
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
Subject: RE: [Patch v3] storvsc: setup 1:1 mapping between hardware queue and
 CPU queue
Thread-Topic: [Patch v3] storvsc: setup 1:1 mapping between hardware queue and
 CPU queue
Thread-Index: AQHVZDzn93jlLYfrA0WwEcvaOxnAoacduBmAgAA7j0A=
Date:   Fri, 6 Sep 2019 03:34:42 +0000
Message-ID: <CY4PR21MB074110983075A3BC91D73AE4CEBA0@CY4PR21MB0741.namprd21.prod.outlook.com>
References: <1567724073-30192-1-git-send-email-longli@linuxonhyperv.com>
 <DM5PR21MB013716CEE8942CB769E236F2D7BB0@DM5PR21MB0137.namprd21.prod.outlook.com>
In-Reply-To: <DM5PR21MB013716CEE8942CB769E236F2D7BB0@DM5PR21MB0137.namprd21.prod.outlook.com>
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
 smtp.mailfrom=longli@microsoft.com; 
x-originating-ip: [2001:4898:80e8:f:edde:db5c:c6fe:798]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2ee37496-5ea3-48c6-d3b3-08d7327b27c5
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0773;
x-ms-traffictypediagnostic: CY4PR21MB0773:|CY4PR21MB0773:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CY4PR21MB07736FC323DE734FF67F62B0CEBA0@CY4PR21MB0773.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2000;
x-forefront-prvs: 0152EBA40F
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(39860400002)(366004)(396003)(346002)(376002)(136003)(199004)(189003)(66476007)(102836004)(186003)(7736002)(305945005)(8676002)(81156014)(14454004)(99286004)(6506007)(81166006)(46003)(64756008)(10290500003)(66946007)(11346002)(66446008)(66556008)(256004)(10090500001)(2501003)(74316002)(8936002)(76176011)(478600001)(486006)(446003)(229853002)(476003)(7696005)(110136005)(33656002)(6116002)(9686003)(71200400001)(2906002)(55016002)(2201001)(86362001)(25786009)(22452003)(53936002)(8990500004)(6246003)(71190400001)(316002)(6436002)(76116006)(52536014)(1511001)(5660300002)(921003)(1121003);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0773;H:CY4PR21MB0741.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: SHP7me36WnSMyR5GHUrkTsHrgiJEdcc3LbxHI6zQ0rS0JwkaTTuz3Suq2OkhJ5qBC0yckN6l/aNSvhoyWgVqCCwAdzpLdt+B5oCzAjPoKngmcOha6O9g75cFV5uOeikTWYm3VMTaDfx3SuX7ZzxyI/z3+jHALn/6b6Kqb1MktAqRg1MhJ5Aaf1/VqloCRd4dDAkuqXHlGEkL4jKC5ys/mHUJEiG+JCAEci5qWIRMyk7A/XZstIIdMJdE3e2LWAFfob17KMG1ebiH9EWHtVunfeSbn68wBAWXdnxXAXW1wKH2DzWOsPPUaPwdpMIoCidlkiP3WKAihnu5Ekc2sJid2qkC4rztDRqnEtmVvtR/NUS8+Inq1iGBiUvK/xn2D7l0YfVCIFsmqvgYSzBPjpPvv3MXeZAGA1RVtlYy8VIzLP0=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ee37496-5ea3-48c6-d3b3-08d7327b27c5
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Sep 2019 03:34:42.4617
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Tl4ByCOu1gZ2ACcVfUyJ/DTkqzb8evU7aQ9ClJGYW3VkicjxUZvF06t5q+T+Xz52Xbni62v9lMFRXzD5w24hCA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0773
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

>Subject: RE: [Patch v3] storvsc: setup 1:1 mapping between hardware queue
>and CPU queue
>
>From: Long Li <longli@microsoft.com> Sent: Thursday, September 5, 2019 3:5=
5
>PM
>>
>> storvsc doesn't use a dedicated hardware queue for a given CPU queue.
>> When issuing I/O, it selects returning CPU (hardware queue)
>> dynamically based on vmbus channel usage across all channels.
>>
>> This patch advertises num_present_cpus() as number of hardware queues.
>> This will have upper layer setup 1:1 mapping between hardware queue
>> and CPU queue and avoid unnecessary locking when issuing I/O.
>>
>> Changes:
>> v2: rely on default upper layer function to map queues. (suggested by
>> Ming Lei
>> <tom.leiming@gmail.com>)
>> v3: use num_present_cpus() instead of num_online_cpus(). Hyper-v
>> doesn't support hot-add CPUs. (suggested by Michael Kelley
>> <mikelley@microsoft.com>)
>
>I've mostly seen the "Changes:" section placed below the "---" so that it
>doesn't clutter up the commit log.  But maybe there's not a strong
>requirement one way or the other as I didn't find anything called out in t=
he
>"Documentation/process"
>directory.

Should I resubmit the patch (but keep it v3)?

>
>Michael
>
>>
>> Signed-off-by: Long Li <longli@microsoft.com>
>> ---
>>  drivers/scsi/storvsc_drv.c | 3 +--
>>  1 file changed, 1 insertion(+), 2 deletions(-)
>>
>> diff --git a/drivers/scsi/storvsc_drv.c b/drivers/scsi/storvsc_drv.c
>> index b89269120a2d..cf987712041a 100644
>> --- a/drivers/scsi/storvsc_drv.c
>> +++ b/drivers/scsi/storvsc_drv.c
>> @@ -1836,8 +1836,7 @@ static int storvsc_probe(struct hv_device *device,
>>  	/*
>>  	 * Set the number of HW queues we are supporting.
>>  	 */
>> -	if (stor_device->num_sc !=3D 0)
>> -		host->nr_hw_queues =3D stor_device->num_sc + 1;
>> +	host->nr_hw_queues =3D num_present_cpus();
>>
>>  	/*
>>  	 * Set the error handler work queue.
>> --
>> 2.17.1

