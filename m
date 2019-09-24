Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DF181BBFA2
	for <lists+linux-hyperv@lfdr.de>; Tue, 24 Sep 2019 03:15:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2503596AbfIXBPH (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 23 Sep 2019 21:15:07 -0400
Received: from mail-eopbgr800092.outbound.protection.outlook.com ([40.107.80.92]:22448
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2392489AbfIXBPH (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 23 Sep 2019 21:15:07 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HwcmIFV/G679OXGXXo6yRdaAHCa5AHNYHyArV6rD238q9MMfYfsGrH3Wy/4LmN/F7q9A+NDCk5x4CbxiYRuFsoNBWJpPqqQ7ZRTOaiONIkhWgyd9e0DXYx/kNRSvGEQlfBtrTeGMsAiAfUDfTiwHD4bR9gyezP4bOOWODtTAopfrLjnCMZT5O2y4SlpTrQKVaxB4PjNy4QyNW/yaDBWR1v6ZXNZtOuTa2ctCUmlo+KYP88WHyp0A3oaXC95p1pmZAs16S6/jnxx2MFQR6BtQ7afZxZl+XaKvY6ukyXVJYeXQJdVV0xqVp63+fs/phBPNlBNo9mp9TcQbVTuf+T9zuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+NMbgId/Qg39Oqk8AGufYIZLQAftnBTQL3CqLfWr97g=;
 b=TK5IOT+sg/dlnAOISVtJoofiETM7SMfUtNuOoaz0m89A9A/YZKG/bFTF8GZieBjd0+867bU5vAk3DY4ens4ZN8k/K8Ir4f3yue5fYqBOjLARvGqI2uJ2vkChPftPXN5xf2tlkFcS8C7l7phUx75Qn5a/YyheODe+2nncI78wqNqKbzIp8CRm6iWNE2DBmJOXdGLzghi36yQr4gTDOuS5UEafRtoNVIlV2Pgz2+gcZT+fMsjCclliM5cS+zWMHrwqDZLFuxXQyIzlmOLX2/x+Lk5PxTPMP0I25Qhqu6sB+WO7c2AyDUidAntpTexvTjWnyAFQJslG90JtCL10Z95OQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+NMbgId/Qg39Oqk8AGufYIZLQAftnBTQL3CqLfWr97g=;
 b=Je2EIT27i9XqMHaoGZOvMoIiox4j+qSIhINuYRLYVXLiQiCOvMqWmwXN4O4b1m1luTNmbRPav/33023HfESJCFSpPd2o9DPjbtA6MCCF4mMudJcDl+YLb3IYmlTvg+NP2DQSDV9bmdQoG/2myRRCHezJf7Rae58ygFLbO52bxl0=
Received: from CY4PR21MB0741.namprd21.prod.outlook.com (10.173.189.7) by
 CY4PR21MB0824.namprd21.prod.outlook.com (10.173.192.10) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2327.4; Tue, 24 Sep 2019 01:14:24 +0000
Received: from CY4PR21MB0741.namprd21.prod.outlook.com
 ([fe80::c8f4:597b:9f3a:9fd]) by CY4PR21MB0741.namprd21.prod.outlook.com
 ([fe80::c8f4:597b:9f3a:9fd%2]) with mapi id 15.20.2327.004; Tue, 24 Sep 2019
 01:14:23 +0000
From:   Long Li <longli@microsoft.com>
To:     Long Li <longli@microsoft.com>, Sasha Levin <sashal@kernel.org>,
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
Thread-Index: AQHVZNfzh3iwmMSVZkCYZWyrh5uiJ6cfE/gAgAAXvICAGvUAAA==
Date:   Tue, 24 Sep 2019 01:14:23 +0000
Message-ID: <CY4PR21MB0741F09608817762DC2CB954CE840@CY4PR21MB0741.namprd21.prod.outlook.com>
References: <1567790660-48142-1-git-send-email-longli@linuxonhyperv.com>
 <20190906200820.GE1528@sasha-vm>
 <CY4PR21MB0741A256EEF9D8DBAF50ED03CEBA0@CY4PR21MB0741.namprd21.prod.outlook.com>
In-Reply-To: <CY4PR21MB0741A256EEF9D8DBAF50ED03CEBA0@CY4PR21MB0741.namprd21.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=longli@microsoft.com; 
x-originating-ip: [2001:4898:80e8:a:ede4:db5c:c6fe:798]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5b65a1d9-1585-47a5-8120-08d7408c8956
x-ms-office365-filtering-ht: Tenant
x-ms-traffictypediagnostic: CY4PR21MB0824:|CY4PR21MB0824:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CY4PR21MB0824AA3A4BE1E3DA82EF96B6CE840@CY4PR21MB0824.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 0170DAF08C
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(136003)(396003)(39860400002)(376002)(346002)(366004)(199004)(54534003)(189003)(6116002)(478600001)(305945005)(229853002)(6506007)(8936002)(25786009)(14454004)(86362001)(9686003)(55016002)(22452003)(2906002)(2501003)(256004)(66556008)(1511001)(81166006)(66476007)(64756008)(5660300002)(81156014)(66446008)(186003)(316002)(8676002)(10290500003)(66946007)(10090500001)(76176011)(99286004)(76116006)(4326008)(110136005)(8990500004)(71190400001)(6436002)(46003)(71200400001)(33656002)(102836004)(54906003)(7696005)(476003)(446003)(11346002)(6246003)(486006)(74316002)(52536014)(7736002);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0824;H:CY4PR21MB0741.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: aKUBe5w0flSHmAHKhAqbOftZtBJ7L5azEKB7N/ppWeQvuuylLP+5g0n6UFmGMsHK5RwvYzqVV9w+BFo/ags4x7MHylCJeBPuMYuv04ucCQZA/kAI0iBmzcI1e1K2Z52K6E6m39jnL5IO9Lcx5LoDQKL8+4YDnRo+Z/B01O5J5335SBWa9zq9Ec36zaz5PSlsv8/c/51DogdeIOrpPXtjYKSb+bg3Acg+6BGoj9o2hVm+/nX16zhU4kgrqXNgI1s6VFNmtpNoSbLEsWFs2Mcf1igUO1S/VBjQPLwAatza7XkJ1VtBSvYiJDOdSDOaEz/xE1GVCOu+FDOS+7v+w6y83yXq0n71Q+KyQSvN/tFNBf1ujUNuSMifhT42WxbkeYLNLbhRi5P/u+wGi8XgeJHf3zhvWSTBYiBBoaNRJ9P3KyA=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b65a1d9-1585-47a5-8120-08d7408c8956
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Sep 2019 01:14:23.8532
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MTPK4bAE5buBRLtLmONJTtmlORQ4kn/dv2UTknOwjevsQRkwvByrlexgy9Bdr0pLHUKThhmcSQU8b50EBqdkvw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0824
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

>Subject: RE: [Patch v4] storvsc: setup 1:1 mapping between hardware queue
>and CPU queue
>
>>Subject: Re: [Patch v4] storvsc: setup 1:1 mapping between hardware
>>queue and CPU queue
>>
>>On Fri, Sep 06, 2019 at 10:24:20AM -0700, longli@linuxonhyperv.com wrote:
>>>From: Long Li <longli@microsoft.com>
>>>
>>>storvsc doesn't use a dedicated hardware queue for a given CPU queue.
>>>When issuing I/O, it selects returning CPU (hardware queue)
>>>dynamically based on vmbus channel usage across all channels.
>>>
>>>This patch advertises num_present_cpus() as number of hardware queues.
>>>This will have upper layer setup 1:1 mapping between hardware queue
>>>and CPU queue and avoid unnecessary locking when issuing I/O.
>>>
>>>Signed-off-by: Long Li <longli@microsoft.com>

Hi Martin,

I have addressed all comments on this patch. Can you merge it to SCSI?

If there is anything else I need to change, please let me know.

Thanks

Long


>>>---
>>>
>>>Changes:
>>>v2: rely on default upper layer function to map queues. (suggested by
>>>Ming Lei
>>><tom.leiming@gmail.com>)
>>>v3: use num_present_cpus() instead of num_online_cpus(). Hyper-v
>>>doesn't support hot-add CPUs. (suggested by Michael Kelley
>>><mikelley@microsoft.com>)
>>>v4: move change logs to after Signed-of-by
>>>
>>> drivers/scsi/storvsc_drv.c | 3 +--
>>> 1 file changed, 1 insertion(+), 2 deletions(-)
>>>
>>>diff --git a/drivers/scsi/storvsc_drv.c b/drivers/scsi/storvsc_drv.c
>>>index b89269120a2d..cf987712041a 100644
>>>--- a/drivers/scsi/storvsc_drv.c
>>>+++ b/drivers/scsi/storvsc_drv.c
>>>@@ -1836,8 +1836,7 @@ static int storvsc_probe(struct hv_device *device,
>>> 	/*
>>> 	 * Set the number of HW queues we are supporting.
>>> 	 */
>>>-	if (stor_device->num_sc !=3D 0)
>>>-		host->nr_hw_queues =3D stor_device->num_sc + 1;
>>>+	host->nr_hw_queues =3D num_present_cpus();
>>
>>Just looking at the change notes for v3: why isn't this
>>num_active_cpus() then? One can still isolate CPUs on hyper-v, no?
>
>The isolated CPU can be made online at run time. For example, even
>maxcpus=3Dx is put on the boot line, individual CPUs can still be made
>online/offline.
>
>>
>>--
>>Thanks,
>>Sasha
