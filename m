Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5D6B8AC213
	for <lists+linux-hyperv@lfdr.de>; Fri,  6 Sep 2019 23:37:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404060AbfIFVhN (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 6 Sep 2019 17:37:13 -0400
Received: from mail-eopbgr800112.outbound.protection.outlook.com ([40.107.80.112]:2240
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731199AbfIFVhN (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 6 Sep 2019 17:37:13 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=coJ/rkKQ+M2vVGHfTJyXIxZVJ0irutTbrmEDefSLk/VTAxZ4e3GaCQTt7YYnoSRKmBc+f2tP+Chv53F3grlkGV8P+BseKbT5scRieLbBzx40RPmL6SwtTsv5Ly5OAiQ0PLNKGYrOBWFclvcRbt7NaiTRAOjGNiLbtASZ//bCHGVNowRnzvLMpvCWTMuLxauX/+6Kc8MxWzwcvoinr+SKdsUlIQZLJPqIb3FoizERFyCvC5btaHghQ8mCzBhYIgZ+Fyp/XUviUK5uxPgsoN/2+YUN1iUZ3DeuQjd9WSn2/zBbIXbDROmJ+dMsdQCmxBhyq6nTp9L1JoRWZjI4IPeDGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=17E1Gt9up4rFdm4X6yBcGi/oSJhEGKJEOJwiQe27pNw=;
 b=mb5Chu99Uc1SZ+6VWaJZ3z5ux0kObk33RRoNeGcaBvizstMgWpjiBEHy1kyXhuhODDjg8Zk9hu6nEGLzuDmrrmn3/23HC+hogHVcoXmHhrsWq3fPAs7hRdvcaOHgoZFsuxwCBy+7H2v9hKq+izUAFQj4GAYCt0UaFsZLNM1RhA7jRveY1Ul81FCdf8WGizhXoyCXCeDjyOYGLeBgfQcWkSNtDr+Pg5Xpe+no+gjWHE2DGQGeur9oalEaNXSm3QkvL/DU2AtH4bu79GVuikw2bGpbz1/pHLV6F46avEbZJ7tUSJsE7+ejNbviTuLY6uz7stqjMpPIgMqZuS7Zhq4ZRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=17E1Gt9up4rFdm4X6yBcGi/oSJhEGKJEOJwiQe27pNw=;
 b=YJZzfgdcX1ynDyT6rnYPkjAghaoi6OU0ZpFbbswO/osU05j3D3saofGhZ1idND5IcbMC3x0p4eie88370FFYQE93cJJa2XF2ZuuJPs0KyJMp5MWEr++oxCZPApShAvZej0PnZAaCuieKc9tUlNBVaj35Hr2f3Jq73DC7yf/HV9Y=
Received: from CY4PR21MB0741.namprd21.prod.outlook.com (10.173.189.7) by
 CY4PR21MB0504.namprd21.prod.outlook.com (10.172.122.14) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2263.6; Fri, 6 Sep 2019 21:37:10 +0000
Received: from CY4PR21MB0741.namprd21.prod.outlook.com
 ([fe80::5caa:ae40:7c3a:4b1d]) by CY4PR21MB0741.namprd21.prod.outlook.com
 ([fe80::5caa:ae40:7c3a:4b1d%5]) with mapi id 15.20.2263.005; Fri, 6 Sep 2019
 21:37:10 +0000
From:   Long Li <longli@microsoft.com>
To:     Sasha Levin <sashal@kernel.org>,
        "longli@linuxonhyperv.com" <longli@linuxonhyperv.com>
CC:     KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [Patch v4] storvsc: setup 1:1 mapping between hardware queue and
 CPU queue
Thread-Topic: [Patch v4] storvsc: setup 1:1 mapping between hardware queue and
 CPU queue
Thread-Index: AQHVZNfzh3iwmMSVZkCYZWyrh5uiJ6cfE/gAgAAXvIA=
Date:   Fri, 6 Sep 2019 21:37:09 +0000
Message-ID: <CY4PR21MB0741A256EEF9D8DBAF50ED03CEBA0@CY4PR21MB0741.namprd21.prod.outlook.com>
References: <1567790660-48142-1-git-send-email-longli@linuxonhyperv.com>
 <20190906200820.GE1528@sasha-vm>
In-Reply-To: <20190906200820.GE1528@sasha-vm>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=longli@microsoft.com; 
x-originating-ip: [2001:4898:80e8:f:edde:db5c:c6fe:798]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5163b9e5-65cd-4b58-45bc-08d733125f83
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600166)(711020)(4605104)(1401327)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:CY4PR21MB0504;
x-ms-traffictypediagnostic: CY4PR21MB0504:|CY4PR21MB0504:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CY4PR21MB05040E3D4389A48D42D1EC26CEBA0@CY4PR21MB0504.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-forefront-prvs: 0152EBA40F
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(136003)(366004)(346002)(396003)(39860400002)(376002)(189003)(199004)(54534003)(9686003)(52536014)(486006)(53936002)(66476007)(66946007)(66556008)(7736002)(6116002)(10290500003)(66446008)(99286004)(186003)(305945005)(46003)(14454004)(64756008)(25786009)(478600001)(2906002)(7696005)(10090500001)(11346002)(76116006)(446003)(256004)(6506007)(316002)(74316002)(76176011)(6246003)(81156014)(86362001)(81166006)(33656002)(102836004)(5660300002)(2501003)(110136005)(22452003)(6436002)(8936002)(71190400001)(71200400001)(229853002)(476003)(8990500004)(8676002)(55016002)(54906003)(4326008);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0504;H:CY4PR21MB0741.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: wZ/0UT/W2dLzOgdvX3G4/OTXOnuUngqmoPpiX3xpgGnip58pSkOtrAs0v4yzxcZ6dDHAmb39CpbuY5kTtAIabpMiQ/V+287vIT9P3mFyKuzS7OaJDZ8WQgggQf/BCaRV/EfJFDskJ4JdkglnLKkqU5AsNwrxkesALfn6NvXAjhOaVRcrs+x5MMVupqItiSxIxqPMNpXAWXMZXv9Xj6UmZmrPcXS/9ZrU55VUpTAOMTUgDpza4TszQbBbKGuuBBnD9YXf4RFfeVkwES15+JbYnpAssJwmrsFhfhbVDz/xGWlrGiqm5oBJ3ImNgAPPR894Ef67fFmJ7fFq+Tn2fTxJDKfzjLvSl/o4kfDo5gqRXrbw3tVAqtkhefRrvwMmP4NLDmCjy5ffd93WGwhm2LgxJAvLf/OP0JDTh0TL4uO9IGE=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5163b9e5-65cd-4b58-45bc-08d733125f83
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Sep 2019 21:37:09.8432
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1+1urYpNxvCSeFGwAjAL0Fyg8ckeZ8Xe3NPjO+97uOXGy98YwRST76IdO+vYrSeOcQgZOEfsUbwTcHJ7INMDRg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0504
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

>Subject: Re: [Patch v4] storvsc: setup 1:1 mapping between hardware queue
>and CPU queue
>
>On Fri, Sep 06, 2019 at 10:24:20AM -0700, longli@linuxonhyperv.com wrote:
>>From: Long Li <longli@microsoft.com>
>>
>>storvsc doesn't use a dedicated hardware queue for a given CPU queue.
>>When issuing I/O, it selects returning CPU (hardware queue) dynamically
>>based on vmbus channel usage across all channels.
>>
>>This patch advertises num_present_cpus() as number of hardware queues.
>>This will have upper layer setup 1:1 mapping between hardware queue and
>>CPU queue and avoid unnecessary locking when issuing I/O.
>>
>>Signed-off-by: Long Li <longli@microsoft.com>
>>---
>>
>>Changes:
>>v2: rely on default upper layer function to map queues. (suggested by
>>Ming Lei
>><tom.leiming@gmail.com>)
>>v3: use num_present_cpus() instead of num_online_cpus(). Hyper-v
>>doesn't support hot-add CPUs. (suggested by Michael Kelley
>><mikelley@microsoft.com>)
>>v4: move change logs to after Signed-of-by
>>
>> drivers/scsi/storvsc_drv.c | 3 +--
>> 1 file changed, 1 insertion(+), 2 deletions(-)
>>
>>diff --git a/drivers/scsi/storvsc_drv.c b/drivers/scsi/storvsc_drv.c
>>index b89269120a2d..cf987712041a 100644
>>--- a/drivers/scsi/storvsc_drv.c
>>+++ b/drivers/scsi/storvsc_drv.c
>>@@ -1836,8 +1836,7 @@ static int storvsc_probe(struct hv_device *device,
>> 	/*
>> 	 * Set the number of HW queues we are supporting.
>> 	 */
>>-	if (stor_device->num_sc !=3D 0)
>>-		host->nr_hw_queues =3D stor_device->num_sc + 1;
>>+	host->nr_hw_queues =3D num_present_cpus();
>
>Just looking at the change notes for v3: why isn't this
>num_active_cpus() then? One can still isolate CPUs on hyper-v, no?

The isolated CPU can be made online at run time. For example, even maxcpus=
=3Dx is put on the boot line, individual CPUs can still be made online/offl=
ine.

>
>--
>Thanks,
>Sasha
