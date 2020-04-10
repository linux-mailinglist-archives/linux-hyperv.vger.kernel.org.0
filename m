Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 13FE61A4248
	for <lists+linux-hyperv@lfdr.de>; Fri, 10 Apr 2020 07:44:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725844AbgDJFox (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 10 Apr 2020 01:44:53 -0400
Received: from mail-eopbgr1320132.outbound.protection.outlook.com ([40.107.132.132]:26560
        "EHLO APC01-PU1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725818AbgDJFox (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 10 Apr 2020 01:44:53 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E6GsWoh+ofiQriCEHO3RYSQa/wHjzovXzTUAU7op7DI5F2yDx8PpAo5ih5QmjvyYdD7+VUravRViDdnCoHjoakxd42z2OYAw0uqbTr2EnGoavTMjsbffAFOaqyuBDEBRS5SWtYzs10P54wl1aNAZCKU7w3b9EFY/nsXuW/4vPJvNGsfSOlG6WUrUf1l3tPqrQjs8q3N5DZJIjDmq6NM0eTzj4dm1FfJMGO/+5Ar1D+6qwBYjOmM4mSY8CCWSEBkIRWoKjZ/QIhnUS49l1+9JC56V2CDGJtJ4qjhzi+DHMvma4T0u+R7jJjajxR0mYlft27W5MwAkZtUVazzcdRj2Cw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q43dVN7kLUFtAqnMN5L8WtvO0zqL5HIKmApoTvTQdnE=;
 b=emKeexgXFjnJy9ahahN6ZkKig5gy1oWOUjT10eGMhKBKocrjDMFTFCPbBL3zRzEWj2nB02tkK+9ay0cJ/KICdzuEt5VuOqQ2bJZCPEdp7EyolfcEMvejQkY0W8PyXX5jtnEuZgwrqVnMRzJHMJ8qVCGOQ4kDck7ifv2XELBIgJ4xe12U0y9IjuGWvn4W086lh7LEvLqa1cr12cTAEeOibZJnZ8A6vXicl1XC0PaQM3GuFTU9kVFpVaCcCAIzQY5YoAli/r8iyZklftDSXaDJmUqdEjJjKOIQRjkJn/8KgmFQpO5NiRjbPeI+q2csAcJ8+xnVajCnucepbISp4NCPKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q43dVN7kLUFtAqnMN5L8WtvO0zqL5HIKmApoTvTQdnE=;
 b=V+EjOMZFe7LLKVNJRMCV88jeIZ1ygp5fSFoqR0du7ZdUR9FAFSyW/JzIBp/5Zg6j+R4NWcWvNp+K9YKTK2rou72OjxPqupxlx9wSAHlMg1QnttuEZzQo6VOcvSkF7Rml/9cHef2bTtyzepseeQ2x1tcBxF7dXImBXsm//aaDbEU=
Received: from HK0P153MB0273.APCP153.PROD.OUTLOOK.COM (52.132.236.76) by
 HK0P153MB0147.APCP153.PROD.OUTLOOK.COM (52.133.156.138) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2921.4; Fri, 10 Apr 2020 05:44:18 +0000
Received: from HK0P153MB0273.APCP153.PROD.OUTLOOK.COM
 ([fe80::2d07:e045:9d5b:898a]) by HK0P153MB0273.APCP153.PROD.OUTLOOK.COM
 ([fe80::2d07:e045:9d5b:898a%2]) with mapi id 15.20.2921.009; Fri, 10 Apr 2020
 05:44:18 +0000
From:   Dexuan Cui <decui@microsoft.com>
To:     "Martin K. Petersen" <martin.petersen@oracle.com>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        Ming Lei <tom.leiming@gmail.com>,
        Long Li <longli@microsoft.com>, vkuznets <vkuznets@redhat.com>
CC:     Michael Kelley <mikelley@microsoft.com>,
        KY Srinivasan <kys@microsoft.com>,
        Olaf Hering <olaf@aepfle.de>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: SCSI low level driver: how to prevent I/O upon hibernation?
Thread-Topic: SCSI low level driver: how to prevent I/O upon hibernation?
Thread-Index: AdYO+lVJkAFfrToQQYmccjddvm2wiw==
Date:   Fri, 10 Apr 2020 05:44:18 +0000
Message-ID: <HK0P153MB0273A1B109CE3A33F0984D34BFDE0@HK0P153MB0273.APCP153.PROD.OUTLOOK.COM>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Owner=decui@microsoft.com;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2020-04-10T05:44:15.1525130Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=ce4d7679-0307-4b46-821b-1fa513484178;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Extended_MSFT_Method=Automatic
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=decui@microsoft.com; 
x-originating-ip: [2601:600:a280:7f70:d035:efe:7672:7b3f]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: ea52890c-6c25-4937-09cf-08d7dd123641
x-ms-traffictypediagnostic: HK0P153MB0147:|HK0P153MB0147:|HK0P153MB0147:
x-ms-exchange-transport-forked: True
x-ld-processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
x-microsoft-antispam-prvs: <HK0P153MB0147C71D57BCFC4F945FCF64BFDE0@HK0P153MB0147.APCP153.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-forefront-prvs: 0369E8196C
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HK0P153MB0273.APCP153.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFTY:;SFS:(10019020)(4636009)(396003)(39860400002)(346002)(366004)(376002)(136003)(6506007)(478600001)(2906002)(186003)(52536014)(7696005)(4326008)(81156014)(82960400001)(10290500003)(82950400001)(54906003)(110136005)(316002)(8936002)(8990500004)(71200400001)(9686003)(76116006)(55016002)(66446008)(66946007)(66476007)(8676002)(33656002)(66556008)(5660300002)(966005)(64756008)(86362001)(6606295002);DIR:OUT;SFP:1102;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: fiMNfim4cnb5xpQsJ3/NFJZBzVuBy0Ab/3bxJm/Mc7L1qBziyjcVccjafvHl/Xn4apPKZefSbewc82FLodmh+/9zuzCqp70hU8V29PNeDz6asfCzy/n/PhtOAfn9QLtW9PZBN/zj0PbDjpXQ7sTAjkpiQyh5wZVCiqUYEhbErVmvawzdOFaKyzUbpMXrs/2ZzYMZad/64QW3/qGAOwGgr5KI5CNaZgU/Lf/2slfYI/OEIabm8QzddUNajeYl8EEUg1v6zuUWmrn9O4dsc0veDyaQzGVHR58qlCqwiTskkXEwnGxrLxQo0gUb/ImzgzRtz60yOt5H21xG0uX4d2NLLRGtJDsI523VFiDiKCxgNRFMKbvX1ffz7824QFAunNfylgupsh0ulDqQDGQ7DQv9JzF61MwasPJjzLDDIltG0rYfzv08/NPf9dfNHh6yOPq30qSEa8+QJm9V7s9GJDVzVI6RGLDdM4sCaRXzurGP9+wSSXK2nJbGlnj0HKlyas/AAW53OgfDNzXi+Q0qtFN2LJbPceqAc+X6pA4fj2Hb2EtrqbqMj5YQ8qkfrA3m17qQ
x-ms-exchange-antispam-messagedata: lr4pAyXtsLjABukPetaTECFbAen+ty5RK4SHgmvNQ34Lj6U6URIZemfhp6Gk7pzRILdikWSCkcphqPjBjeTV6Nfe1cvgwGX/QoDzpUyCUNfP9mCGYNNP4mJpsc7PP+eGoWrRO2mSSVlUuB9twp5KKJUqxBKfbcJFX9Nw688Og1Kbna0XIdZ0wjIP4Ycet/auP5jPGKxgr+a55VDjPUqDVQ==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ea52890c-6c25-4937-09cf-08d7dd123641
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Apr 2020 05:44:18.0619
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: P8US+PdgMlUFTzIvxjgwmdlvjNiYC5qjl4wZmHCOJLM2cxTEXb8ACAK9eoCKy79uRINf1Rh1EFxFKdB5U5Hqfg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HK0P153MB0147
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Hi all,
Can you please recommend the standard way to prevent the upper layer SCSI
driver from submitting new I/O requests when the system is doing hibernatio=
n?

Actually I already asked the question on 5/30 last year:
https://marc.info/?l=3Dlinux-scsi&m=3D155918927116283&w=3D2
and I thought all the sdevs are suspended and resumed automatically in
drivers/scsi/scsi_pm.c, and the low level SCSI adapter driver (i.e. hv_stor=
vsc)
only needs to suspend/resume the state of the adapter itself. However, it l=
ooks
this is not true, because today I got such a panic in a v5.6 Linux VM runni=
ng on
Hyper-V: the 'suspend' part of the hibernation process finished without any
issue, but when the VM was trying to resume back from the 'new' kernel to t=
he
'old' kernel, these events happened:

1. the new kernel loaded the saved state from disk to memory.

2. the new kernel quiesced the devices, including the SCSI DVD device
controlled by the hv_storvsc low level SCSI driver, i.e.
drivers/scsi/storvsc_drv.c: storvsc_suspend() was called and the related vm=
bus
ringbuffer was freed.

3. However, disk_events_workfn() -> ... -> cdrom_check_events() -> ...
   -> scsi_queue_rq() -> ... -> storvsc_queuecommand() was still trying to
submit I/O commands to the freed vmbus ringbuffer, and as a result, a NULL
pointer dereference panic happened.

Can anyone please explain the symptom?

I made the below patch, with which it seems I can no longer reproduce the p=
anic.

But I don't know how scsi_block_requests() can reliably prevent new I/O req=
uests
from being issued concurrently on a different CPU -- the function only sets=
 a
flag?

Looking forward to your insights!

diff --git a/drivers/scsi/storvsc_drv.c b/drivers/scsi/storvsc_drv.c
index fb41636519ee..dcfb0a820977 100644
--- a/drivers/scsi/storvsc_drv.c
+++ b/drivers/scsi/storvsc_drv.c
@@ -1949,6 +1949,8 @@ static int storvsc_suspend(struct hv_device *hv_dev)
        struct Scsi_Host *host =3D stor_device->host;
        struct hv_host_device *host_dev =3D shost_priv(host);

+       scsi_block_requests(host);
+
        storvsc_wait_to_drain(stor_device);

        drain_workqueue(host_dev->handle_error_wq);
@@ -1968,10 +1970,14 @@ static int storvsc_suspend(struct hv_device *hv_dev=
)

 static int storvsc_resume(struct hv_device *hv_dev)
 {
+       struct storvsc_device *stor_device =3D hv_get_drvdata(hv_dev);
+       struct Scsi_Host *host =3D stor_device->host;
        int ret;

        ret =3D storvsc_connect_to_vsp(hv_dev, storvsc_ringbuffer_size,
                                     hv_dev_is_fc(hv_dev));
+       if (!ret)
+               scsi_unblock_requests(host);
        return ret;
 }


This is the log of the panic:

[    8.565615] PM: Adding info for No Bus:vcsa63
[    8.590118] Freezing user space processes ... (elapsed 0.020 seconds) do=
ne.
[    8.619143] OOM killer disabled.
[    8.645914] PM: Using 3 thread(s) for decompression
[    8.650805] PM: Loading and decompressing image data (307144 pages)...
[    8.693765] PM: Image loading progress:   0%
[    9.286720] PM: Image loading progress:  10%
[    9.541665] PM: Image loading progress:  20%
[    9.777528] PM: Image loading progress:  30%
[   10.062504] PM: Image loading progress:  40%
[   10.317178] PM: Image loading progress:  50%
[   10.588564] PM: Image loading progress:  60%
[   10.796801] PM: Image loading progress:  70%
[   11.029323] PM: Image loading progress:  80%
[   11.327868] PM: Image loading progress:  90%
[   11.650745] PM: Image loading progress: 100%
[   11.655851] PM: Image loading done
[   11.659596] PM: hibernation: Read 1228576 kbytes in 2.99 seconds (410.89=
 MB/s)
[   11.668702] input input1: type quiesce
[   11.668741] sr 0:0:0:1: bus quiesce
[   11.668804] sd 0:0:0:0: bus quiesce
[   11.672970] input input0: type quiesce
[   11.698082] scsi target0:0:0: bus quiesce
[   11.703296] scsi host0: bus quiesce
[   11.707448] alarmtimer alarmtimer.0.auto: bus quiesce
[   11.712782] rtc rtc0: class quiesce
[   11.716560] platform Fixed MDIO bus.0: bus quiesce
[   11.721911] serial8250 serial8250: bus quiesce
[   11.727220] simple-framebuffer simple-framebuffer.0: bus quiesce
[   11.734066] platform pcspkr: bus quiesce
[   11.738726] rtc_cmos 00:02: bus quiesce
[   11.743353] serial 00:01: bus quiesce
[   11.747433] serial 00:00: bus quiesce
[   11.751654] platform efivars.0: bus quiesce
[   11.756316] platform rtc-efi.0: bus quiesce
[   11.760883] platform HYPER_V_GEN_COUN:00: bus quiesce
[   11.766255] platform VMBUS:00: bus quiesce
[   11.770668] platform PNP0003:00: bus quiesce
[   11.781730] hv_storvsc bf78936f-7d8f-45ce-ab03-6c341452e55d: noirq bus q=
uiesce
[   11.796479] hv_netvsc dda5a2be-b8b8-4237-b330-be8a516a72c0: noirq bus qu=
iesce
[   11.804042] BUG: kernel NULL pointer dereference, address: 0000000000000=
090
[   11.804996] #PF: supervisor read access in kernel mode
[   11.804996] #PF: error_code(0x0000) - not-present page
[   11.804996] PGD 0 P4D 0
[   11.804996] Oops: 0000 [#1] SMP PTI
[   11.804996] CPU: 18 PID: 353 Comm: kworker/18:1 Not tainted 5.6.0+ #1
[   11.804996] Hardware name: Microsoft Corporation Virtual Machine/Virtual=
 Machine, BIOS Hyper-V UEFI Release v4.0 05/16/2019
[   11.804996] Workqueue: events_freezable_power_ disk_events_workfn
[   11.804996] RIP: 0010:storvsc_queuecommand+0x261/0x714 [hv_storvsc]
[   11.804996] Code: ...
[   11.804996] RSP: 0018:ffffa331c2347af0 EFLAGS: 00010246
[   11.804996] RAX: 0000000000000000 RBX: ffff8e6a32cec5a0 RCX: 00000000000=
00000
[   11.804996] RDX: 0000000000000012 RSI: ffff8e6a32cec3e0 RDI: ffff8e6a32c=
ec710
[   11.804996] RBP: ffff8e6b6d58c800 R08: 0000000000000010 R09: ffff8e6a32a=
a6060
[   11.804996] R10: ffffc8a8c4c81980 R11: 0000000000000000 R12: 00000000000=
00012
[   11.804996] R13: 0000000000000012 R14: ffff8e6a32cec710 R15: ffff8e6a32c=
ec3d8
[   11.804996] FS:  0000000000000000(0000) GS:ffff8e6a42c80000(0000) knlGS:=
0000000000000000
[   11.804996] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   11.804996] CR2: 0000000000000090 CR3: 000000013a428006 CR4: 00000000003=
606e0
[   11.804996] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 00000000000=
00000
[   11.804996] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 00000000000=
00400
[   11.804996] Call Trace:
[   11.804996]  scsi_queue_rq+0x593/0xa10
[   11.804996]  blk_mq_dispatch_rq_list+0x8d/0x510
[   11.804996]  blk_mq_sched_dispatch_requests+0xed/0x170
[   11.804996]  __blk_mq_run_hw_queue+0x55/0x110
[   11.804996]  __blk_mq_delay_run_hw_queue+0x141/0x160
[   11.804996]  blk_mq_sched_insert_request+0xc3/0x170
[   11.804996]  blk_execute_rq+0x4b/0xa0
[   11.804996]  __scsi_execute+0xeb/0x250
[   11.804996]  sr_check_events+0x9f/0x270 [sr_mod]
[   11.804996]  cdrom_check_events+0x1a/0x30 [cdrom]
[   11.804996]  sr_block_check_events+0xcc/0x110 [sr_mod]
[   11.804996]  disk_check_events+0x68/0x160
[   11.804996]  process_one_work+0x20c/0x3d0
[   11.804996]  worker_thread+0x2d/0x3e0
[   11.804996]  kthread+0x10c/0x130
[   11.804996]  ret_from_fork+0x35/0x40

Thanks,
-- Dexuan
