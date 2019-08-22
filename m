Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 537A59A2B6
	for <lists+linux-hyperv@lfdr.de>; Fri, 23 Aug 2019 00:22:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388965AbfHVWWO (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 22 Aug 2019 18:22:14 -0400
Received: from mail-eopbgr820102.outbound.protection.outlook.com ([40.107.82.102]:34021
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2393833AbfHVWWO (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 22 Aug 2019 18:22:14 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n84jCrtbRNaM2UsPDvqM6pvMK69CaiaButItkqX+yCvfucyrW54luvagwqlTJNrno0YfN7GGD3P2/h5nDQRVOBPQJnMifmv+ZvtjxhjRtZpomhsuGMpZcDreqkJLmPwuoycoQ1LKpViRjOgJdb8x+SdxB1c1fxni8N/WyzeshTTJA4DSKDzYlYPF8fpnNdDQ2e6NB4o71bJEN6QAgI02/clxd2xXgH2kR+ILdDrzalq+KjUWqr/M0jFdctCOM5GQrZXbrdotbtebtqajK9odkRANpU9H+iJ6qBqId97UAZ2lHTQSdU1XVn6kHYxJEyuobWR8VFg+zBMhNkv8AnH/mw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6R3LIW86inRwpGltgl8emlme5gdqNyhxVm5ix1BM/hM=;
 b=EocOiKFvAB/WFxGMT+wWlrMRN5FTepJxH6BkYbgluXkvoTF/0eULQVXLY1jVQtO7nrKVbBzbxueOJqgxKNDfLCiRbtXRYApTVZCFKYZgnN/406xsXpt+qkEnFXI5S1cGuXl19uWF+PUixNYxVojXsOrja/ZVcNhA0VmD6/1ns40TI28Rubvg8rMVkFkrqOyYKJfPpXay5X5a4V25KoleMda59MISjUQyrhKOsBoCRNUc86TVug3gObRl5yO+umiWe+UQCecwUCxsv6JeVrI5UIAivTBTgxs+jO8+MFU2l6xtkm3GSG/7rCnNpf3yw896PQJ2Utb7vPE45asUg0UBxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6R3LIW86inRwpGltgl8emlme5gdqNyhxVm5ix1BM/hM=;
 b=QBr04x1VtxyJL/BQ+CB9y4rHMyQvSTng2xOh/IScGOc5dk16FdYSUQVQi/WiV3a+dYbzUTqVZrn8lN9oEW8lFDHBwCOssEUqrekDYDpcrrXGh4t9eGjWYMfNHVcMTWpz5FQOtTwaTPGMjeqBnQ5ugbtK9+KqJyABdBHEWEBNOuY=
Received: from CY4PR21MB0741.namprd21.prod.outlook.com (10.173.189.7) by
 CY4PR21MB0183.namprd21.prod.outlook.com (10.173.193.9) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2199.9; Thu, 22 Aug 2019 22:21:32 +0000
Received: from CY4PR21MB0741.namprd21.prod.outlook.com
 ([fe80::2c62:5380:9ed8:496d]) by CY4PR21MB0741.namprd21.prod.outlook.com
 ([fe80::2c62:5380:9ed8:496d%11]) with mapi id 15.20.2220.000; Thu, 22 Aug
 2019 22:21:31 +0000
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
Thread-Index: AQHVWSojurs2/K071EGMpSV6zPYfmKcHpzgAgAAUbOA=
Date:   Thu, 22 Aug 2019 22:21:31 +0000
Message-ID: <CY4PR21MB0741D566F71F0D1E8C5B9970CEA50@CY4PR21MB0741.namprd21.prod.outlook.com>
References: <1566506543-1090-1-git-send-email-longli@linuxonhyperv.com>
 <DM5PR21MB01372B7A717EAC7F0BCF826AD7A50@DM5PR21MB0137.namprd21.prod.outlook.com>
In-Reply-To: <DM5PR21MB01372B7A717EAC7F0BCF826AD7A50@DM5PR21MB0137.namprd21.prod.outlook.com>
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
x-ms-office365-filtering-correlation-id: 9fe08954-909c-4876-1f4b-08d7274f15df
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600166)(711020)(4605104)(1401327)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:CY4PR21MB0183;
x-ms-traffictypediagnostic: CY4PR21MB0183:|CY4PR21MB0183:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CY4PR21MB0183169766DA2D33C2F28D94CEA50@CY4PR21MB0183.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-forefront-prvs: 01371B902F
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(979002)(4636009)(376002)(346002)(396003)(366004)(39860400002)(136003)(199004)(189003)(71200400001)(52536014)(478600001)(8936002)(7696005)(76176011)(229853002)(99286004)(186003)(9686003)(81156014)(8676002)(33656002)(476003)(486006)(6116002)(2906002)(305945005)(1511001)(22452003)(46003)(71190400001)(81166006)(74316002)(7736002)(2501003)(8990500004)(110136005)(316002)(10090500001)(66476007)(6506007)(66556008)(64756008)(66446008)(76116006)(102836004)(6436002)(66946007)(53936002)(2201001)(5660300002)(6246003)(86362001)(25786009)(14454004)(55016002)(446003)(11346002)(256004)(10290500003)(921003)(1121003)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0183;H:CY4PR21MB0741.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: zs8UuTRN+VKVQbaLUgVEKkIEZp7BAX4SY0JDEK5MsItWkJ24Gh37S9Mjai9QHZjkgtDk99u3vziIsPCvyDlHO2U9XYu4Csz2LZkk7PcPeWOsINe210mhXSpaPb1ThG8xzT9FnCDliJgo47Yft/OHz9/BkO6ggxDzkPkgw9uKgLlulSKMmW0MLkqLfVt5Oa5NYh0dUbeScesa6qcjC9vpbKPdA5CqLe4enCGVIn7f7up7nu21hTCf/9rZZsoev2mSFzdNb1zI/Cul9cFVIjTe+G113Ubq5LemvB8e9bpPIlYl4LqDCvivgpaP6DQqm6A4ZBWTdEYjAif6C3N/LxmuSp58YLBIvp8w/8Fze7S+c+R/556s0sjfyz+PD8n+upjBy0Gfja/SPNsgfteAmwRzPofYzNsCOh/VpYbH4O6llN4=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9fe08954-909c-4876-1f4b-08d7274f15df
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Aug 2019 22:21:31.7728
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BGspVHTVhjYKEhMfW0BqQ8X+mlTAwIPbWn8e9rmA80X5WXmvTcna4W17pbABLe4ONHUzSOnqmObQkdLiJw2MTQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0183
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

>>>Subject: RE: [Patch v2] storvsc: setup 1:1 mapping between hardware
>>>queue and CPU queue
>>>
>>>From: Long Li <longli@linuxonhyperv.com> Sent: Thursday, August 22, 2019
>>>1:42 PM
>>>>
>>>> storvsc doesn't use a dedicated hardware queue for a given CPU queue.
>>>> When issuing I/O, it selects returning CPU (hardware queue)
>>>> dynamically based on vmbus channel usage across all channels.
>>>>
>>>> This patch advertises num_possible_cpus() as number of hardware
>>>> queues. This will have upper layer setup 1:1 mapping between hardware
>>>> queue and CPU queue and avoid unnecessary locking when issuing I/O.
>>>>
>>>> Changes:
>>>> v2: rely on default upper layer function to map queues. (suggested by
>>>> Ming Lei
>>>> <tom.leiming@gmail.com>)
>>>>
>>>> Signed-off-by: Long Li <longli@microsoft.com>
>>>> ---
>>>>  drivers/scsi/storvsc_drv.c | 3 +--
>>>>  1 file changed, 1 insertion(+), 2 deletions(-)
>>>>
>>>> diff --git a/drivers/scsi/storvsc_drv.c b/drivers/scsi/storvsc_drv.c
>>>> index b89269120a2d..dfd3b76a4f89 100644
>>>> --- a/drivers/scsi/storvsc_drv.c
>>>> +++ b/drivers/scsi/storvsc_drv.c
>>>> @@ -1836,8 +1836,7 @@ static int storvsc_probe(struct hv_device
>>>*device,
>>>>  	/*
>>>>  	 * Set the number of HW queues we are supporting.
>>>>  	 */
>>>> -	if (stor_device->num_sc !=3D 0)
>>>> -		host->nr_hw_queues =3D stor_device->num_sc + 1;
>>>> +	host->nr_hw_queues =3D num_possible_cpus();
>>>
>>>For a lot of the VM sizes in Azure, num_possible_cpus() is 128, even if =
the
>>>VM has only 4 or 8 or some other smaller number of vCPUs.
>>>So I'm wondering if you really want num_present_cpus() here instead,
>>>which would include only the vCPUs that actually exist in the VM.

I think reporting num_possible_cpus() doesn't do more harm or take more res=
ources. Because block layer allocates map for all the possible CPUs.

The actual mapping is done in blk_mq_map_queues(), and it iterates all the =
possible CPUs. If we report num_present_cpus(), the rest of the CPUs also n=
eed to be mapped.

>>>
>>>Michael
>>>
>>>>
>>>>  	/*
>>>>  	 * Set the error handler work queue.
>>>> --
>>>> 2.17.1

