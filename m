Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D48466FA78
	for <lists+linux-hyperv@lfdr.de>; Mon, 22 Jul 2019 09:40:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728094AbfGVHkY (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 22 Jul 2019 03:40:24 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:38627 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725888AbfGVHkY (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 22 Jul 2019 03:40:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1563781224; x=1595317224;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=v8dzOTXJIPHBz0rQeEsOt/sQZbjWO90JBS6jf5/6ztA=;
  b=aiIkof8HdTzSqexS9wuGYFwIHpp/wc+eMNUveIjG/MDW87EPTMp1Fjb6
   rHUxUAf2zfYqsTpowGFTOwbNFxsZhioE8qtP+IEdS1HkkHlKXeLlvmAy4
   KhThBfsVqrCDmin+dywtgmREqxRQ1WpmV4iw+BfpwJE+Ps74otFq8tolZ
   JB4LLZ6IX1UyW/OcbSIYfISXEPFYBLdiuMbYvoviNbJRYgGHO7vyQg1X5
   CVdlCQHSrnb+WEIdy3YDtz5wODs0C/MUdniFfeuC8MsWwZkqUUvlqUd/I
   XN2DLgoX78voIHrbylZ2aotBP6an5VOQekp8okaqXIpkovRWxYPX/E4q6
   Q==;
IronPort-SDR: xCUMFOEgJD2/jHpIkZS0bmwwrXi/IL5LbTmBwtQNA7ieXxF6LC/BGweQ+r5GYF8su9ybeJuzG+
 Ug37gCKAKk6R6kID12gSUr4haHQ5cBJz0UDYhaaXfqXyNpPC5OPUsdhTm916d3y+o7e1wLlrFZ
 LWacCaXyMnOxBk+RYtXne4I3cClXEMFvfjMXkQimlzI/5LP5UzHUOwyt0XdngWGBB5cVIoJptc
 GQD0GR5USKPJ4Gik6xwZ7NyLQvpSnWqD4uCLl+qEbictAqKuVbptwfwCZd0pA2m1sVnffVBCPa
 /0A=
X-IronPort-AV: E=Sophos;i="5.64,294,1559491200"; 
   d="scan'208";a="113668412"
Received: from mail-bn3nam01lp2055.outbound.protection.outlook.com (HELO NAM01-BN3-obe.outbound.protection.outlook.com) ([104.47.33.55])
  by ob1.hgst.iphmx.com with ESMTP; 22 Jul 2019 15:40:21 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JEf1zPC9FUZuMCcHpjnJ18fOAnn93J1QtZ1QOdt0thpU2G0655MUVgjeBvH5UNwb5FLJ8JiRzgxVIy0cAgpo/sKVU1u7Hy8veKqzC6r2nOzVM3Nk11KuB4TnyViJlEOK0G0feK1Dav/G9KQ57BmRl1/ud727SCLHlt7iOp1P/mNXbvWPJFNA2O5T2pj9ItJ/AiWz6/lndWArQr3X2oTMoP4Ld78zZD70gDrUVqlYH+HvGVISD/E7vlVFD1gxgYQUVoeuE6kgW8F0rtCUxQXEPif687XBsgV43QudKZpiTaeZnCYRasrBmPAnkZ9R0D2WCG+pUlR004X2E5EAfWlmhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2lEYOv5urqb/eBiuNW1NIkJpXIqE+LOGKurXOmIMAwA=;
 b=KDxuCY0dSLZy6+QPilJtlg0ls8LBMK+Ae2+LM7kCMe8r7VFGicqlJjs+gBkDT2qtQ1GeEbC4QOBnuBrUjdadMTSkAViOhRUYT25J6hHmvrOOAMiY62By7Yuz80Ug0tXuZN8DPZQ7xHID8FssshcinOzcNjK96fFtSezzXFhUMrL4kz7B8meiA4DZQVbqjvMp7xDZroIC5v3meIkxs710KQAaGRWK9peYmwf8jcvZwsb7ZV9W+NWgaUKh1jIVDszgW0tGtDCFfZ4TWqJhyJA6Gu67stZ/aDhEE1z4wZKXBUa1+Y+uz3vkQiD7+pf55R0QWizIJifMOkjzu/QF97IQew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=wdc.com;dmarc=pass action=none header.from=wdc.com;dkim=pass
 header.d=wdc.com;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2lEYOv5urqb/eBiuNW1NIkJpXIqE+LOGKurXOmIMAwA=;
 b=YLgtscHUezWeQ5yBGtLHyIsOLLKqJBnwn/jPEn7zB3nP5EWAJA64/XYOZxx1nU0/xdIo3UPibU5+mub9lAj2SO88fBIVtXQFxNdL54K3S97q7CSnvJEwNjkXEPH6WcU5NCre6x1s49hU3G2DOWRWcc1sQb8GZAZNmR12TB3xLxQ=
Received: from BYAPR04MB5816.namprd04.prod.outlook.com (20.179.58.207) by
 BYAPR04MB5080.namprd04.prod.outlook.com (52.135.235.26) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2094.16; Mon, 22 Jul 2019 07:40:20 +0000
Received: from BYAPR04MB5816.namprd04.prod.outlook.com
 ([fe80::65a9:db0a:646d:eb1e]) by BYAPR04MB5816.namprd04.prod.outlook.com
 ([fe80::65a9:db0a:646d:eb1e%6]) with mapi id 15.20.2094.013; Mon, 22 Jul 2019
 07:40:20 +0000
From:   Damien Le Moal <Damien.LeMoal@wdc.com>
To:     Ming Lei <tom.leiming@gmail.com>,
        Bart van Assche <bvanassche@acm.org>
CC:     Christoph Hellwig <hch@lst.de>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        Max Gurtovoy <maxg@mellanox.com>,
        linux-rdma <linux-rdma@vger.kernel.org>,
        Linux SCSI List <linux-scsi@vger.kernel.org>,
        "megaraidlinux.pdl@broadcom.com" <megaraidlinux.pdl@broadcom.com>,
        "MPT-FusionLinux.pdl@broadcom.com" <MPT-FusionLinux.pdl@broadcom.com>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/8] scsi: take the DMA max mapping size into account
Thread-Topic: [PATCH 2/8] scsi: take the DMA max mapping size into account
Thread-Index: AQHVJQcp5XX723kpxUuisKfeeu1XNg==
Date:   Mon, 22 Jul 2019 07:40:20 +0000
Message-ID: <BYAPR04MB58168CBFF8B691DF33C73DDBE7C40@BYAPR04MB5816.namprd04.prod.outlook.com>
References: <20190617122000.22181-1-hch@lst.de>
 <20190617122000.22181-3-hch@lst.de>
 <5d143a03-edd5-5878-780b-45d87313a813@acm.org>
 <CACVXFVMWM3xg6EEyoyNjkLPv=8+wQKiHj6erMS_gGX25f-Ot4g@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Damien.LeMoal@wdc.com; 
x-originating-ip: [199.255.47.11]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 14c7ae80-2777-4444-e88a-08d70e77d92d
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:BYAPR04MB5080;
x-ms-traffictypediagnostic: BYAPR04MB5080:
x-microsoft-antispam-prvs: <BYAPR04MB50800A33375935164E77408AE7C40@BYAPR04MB5080.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:3631;
x-forefront-prvs: 01068D0A20
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(39860400002)(396003)(346002)(376002)(366004)(136003)(51234002)(189003)(199004)(52536014)(64756008)(66556008)(66476007)(66946007)(102836004)(6246003)(2906002)(7736002)(14454004)(305945005)(53546011)(6506007)(86362001)(3846002)(5660300002)(486006)(68736007)(99286004)(76116006)(91956017)(66066001)(66446008)(6116002)(256004)(14444005)(55016002)(316002)(110136005)(33656002)(478600001)(7696005)(6436002)(53936002)(76176011)(54906003)(71200400001)(71190400001)(8936002)(74316002)(229853002)(4326008)(476003)(186003)(25786009)(9686003)(81166006)(81156014)(7416002)(8676002)(26005)(446003);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR04MB5080;H:BYAPR04MB5816.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 4zyTbQuWrn5abfpuKymlr6bOZzzNI54ipVZZXogq1yQGIhx2hzOz114vJppkbTmp41Z++CcpnsRY2laSSMV26MZyhGKMxfXv0C9kxuOLRSdlIe6YBIPExccFF3fKcC+i3EAj6134fa/iPqi7hQA0k7YgtJEDltgWVrd5e9sGudUoYx8v0qlLoevsZKWQJt4CywmbHFG33v6AKYmcPjd+Ea9x7FBTbWQS8ZCNpSLSRvdSnSsg7KdK4sE7hc3eF/9sH558uIHd7Kz9NmKfVNHqGRoN/14g63DWJmFQrgAJwq29VcBU3joKe7XcqvLxI75n6ilw28EhCB0QSKTadxAYcQtsbb/MOUsQHN4cUA5/7BbPjDwAP//VopSYJlOsTKo563uxTXOOmH/eBfGq0IbCiIHNvcj2RCZEiMC8ryX9FYA=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 14c7ae80-2777-4444-e88a-08d70e77d92d
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jul 2019 07:40:20.0168
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Damien.LeMoal@wdc.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB5080
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On 2019/07/22 15:01, Ming Lei wrote:=0A=
> On Tue, Jun 18, 2019 at 4:57 AM Bart Van Assche <bvanassche@acm.org> wrot=
e:=0A=
>>=0A=
>> On 6/17/19 5:19 AM, Christoph Hellwig wrote:=0A=
>>> We need to limit the devices max_sectors to what the DMA mapping=0A=
>>> implementation can support.  If not we risk running out of swiotlb=0A=
>>> buffers easily.=0A=
>>>=0A=
>>> Signed-off-by: Christoph Hellwig <hch@lst.de>=0A=
>>> ---=0A=
>>>   drivers/scsi/scsi_lib.c | 2 ++=0A=
>>>   1 file changed, 2 insertions(+)=0A=
>>>=0A=
>>> diff --git a/drivers/scsi/scsi_lib.c b/drivers/scsi/scsi_lib.c=0A=
>>> index d333bb6b1c59..f233bfd84cd7 100644=0A=
>>> --- a/drivers/scsi/scsi_lib.c=0A=
>>> +++ b/drivers/scsi/scsi_lib.c=0A=
>>> @@ -1768,6 +1768,8 @@ void __scsi_init_queue(struct Scsi_Host *shost, s=
truct request_queue *q)=0A=
>>>               blk_queue_max_integrity_segments(q, shost->sg_prot_tables=
ize);=0A=
>>>       }=0A=
>>>=0A=
>>> +     shost->max_sectors =3D min_t(unsigned int, shost->max_sectors,=0A=
>>> +                     dma_max_mapping_size(dev) << SECTOR_SHIFT);=0A=
>>>       blk_queue_max_hw_sectors(q, shost->max_sectors);=0A=
>>>       if (shost->unchecked_isa_dma)=0A=
>>>               blk_queue_bounce_limit(q, BLK_BOUNCE_ISA);=0A=
>>=0A=
>> Does dma_max_mapping_size() return a value in bytes? Is=0A=
>> shost->max_sectors a number of sectors? If so, are you sure that "<<=0A=
>> SECTOR_SHIFT" is the proper conversion? Shouldn't that be ">>=0A=
>> SECTOR_SHIFT" instead?=0A=
> =0A=
> Now the patch has been committed, '<< SECTOR_SHIFT' needs to be fixed.=0A=
> =0A=
> Also the following kernel oops is triggered on qemu, and looks=0A=
> device->dma_mask is NULL.=0A=
=0A=
Just hit the exact same problem using tcmu-runner (ZBC file handler) on bar=
e=0A=
metal (no QEMU). dev->dma_mask is NULL. No problem with real disks though.=
=0A=
=0A=
> =0A=
> [    5.826483] scsi host0: Virtio SCSI HBA=0A=
> [    5.829302] st: Version 20160209, fixed bufsize 32768, s/g segs 256=0A=
> [    5.831042] SCSI Media Changer driver v0.25=0A=
> [    5.832491] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=0A=
> [    5.833332] BUG: KASAN: null-ptr-deref in=0A=
> dma_direct_max_mapping_size+0x30/0x94=0A=
> [    5.833332] Read of size 8 at addr 0000000000000000 by task kworker/u1=
7:0/7=0A=
> [    5.835506] nvme nvme0: pci function 0000:00:07.0=0A=
> [    5.833332]=0A=
> [    5.833332] CPU: 2 PID: 7 Comm: kworker/u17:0 Not tainted 5.3.0-rc1 #1=
328=0A=
> [    5.836999] ahci 0000:00:1f.2: version 3.0=0A=
> [    5.833332] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009),=0A=
> BIOS ?-20180724_192412-buildhw-07.phx4=0A=
> [    5.833332] Workqueue: events_unbound async_run_entry_fn=0A=
> [    5.833332] Call Trace:=0A=
> [    5.833332]  dump_stack+0x6f/0x9d=0A=
> [    5.833332]  ? dma_direct_max_mapping_size+0x30/0x94=0A=
> [    5.833332]  __kasan_report+0x161/0x189=0A=
> [    5.833332]  ? dma_direct_max_mapping_size+0x30/0x94=0A=
> [    5.833332]  kasan_report+0xe/0x12=0A=
> [    5.833332]  dma_direct_max_mapping_size+0x30/0x94=0A=
> [    5.833332]  __scsi_init_queue+0xd8/0x1f3=0A=
> [    5.833332]  scsi_mq_alloc_queue+0x62/0x89=0A=
> [    5.833332]  scsi_alloc_sdev+0x38c/0x479=0A=
> [    5.833332]  scsi_probe_and_add_lun+0x22d/0x1093=0A=
> [    5.833332]  ? kobject_set_name_vargs+0xa4/0xb2=0A=
> [    5.833332]  ? mutex_lock+0x88/0xc4=0A=
> [    5.833332]  ? scsi_free_host_dev+0x4a/0x4a=0A=
> [    5.833332]  ? _raw_spin_lock_irqsave+0x8c/0xde=0A=
> [    5.833332]  ? _raw_write_unlock_irqrestore+0x23/0x23=0A=
> [    5.833332]  ? ata_tdev_match+0x22/0x45=0A=
> [    5.833332]  ? attribute_container_add_device+0x160/0x17e=0A=
> [    5.833332]  ? rpm_resume+0x26a/0x7c0=0A=
> [    5.833332]  ? kobject_get+0x12/0x43=0A=
> [    5.833332]  ? rpm_put_suppliers+0x7e/0x7e=0A=
> [    5.833332]  ? _raw_spin_lock_irqsave+0x8c/0xde=0A=
> [    5.833332]  ? _raw_write_unlock_irqrestore+0x23/0x23=0A=
> [    5.833332]  ? scsi_target_destroy+0x135/0x135=0A=
> [    5.833332]  __scsi_scan_target+0x14b/0x6aa=0A=
> [    5.833332]  ? pvclock_clocksource_read+0xc0/0x14e=0A=
> [    5.833332]  ? scsi_add_device+0x20/0x20=0A=
> [    5.833332]  ? rpm_resume+0x1ae/0x7c0=0A=
> [    5.833332]  ? rpm_put_suppliers+0x7e/0x7e=0A=
> [    5.833332]  ? _raw_spin_lock_irqsave+0x8c/0xde=0A=
> [    5.833332]  ? _raw_write_unlock_irqrestore+0x23/0x23=0A=
> [    5.833332]  ? pick_next_task_fair+0x976/0xa3d=0A=
> [    5.833332]  ? mutex_lock+0x88/0xc4=0A=
> [    5.833332]  scsi_scan_channel+0x76/0x9e=0A=
> [    5.833332]  scsi_scan_host_selected+0x131/0x176=0A=
> [    5.833332]  ? scsi_scan_host+0x241/0x241=0A=
> [    5.833332]  do_scan_async+0x27/0x219=0A=
> [    5.833332]  ? scsi_scan_host+0x241/0x241=0A=
> [    5.833332]  async_run_entry_fn+0xdc/0x23d=0A=
> [    5.833332]  process_one_work+0x327/0x539=0A=
> [    5.833332]  worker_thread+0x330/0x492=0A=
> [    5.833332]  ? rescuer_thread+0x41f/0x41f=0A=
> [    5.833332]  kthread+0x1c6/0x1d5=0A=
> [    5.833332]  ? kthread_park+0xd3/0xd3=0A=
> [    5.833332]  ret_from_fork+0x1f/0x30=0A=
> [    5.833332] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=0A=
> =0A=
> =0A=
> =0A=
> Thanks,=0A=
> Ming Lei=0A=
> =0A=
=0A=
=0A=
-- =0A=
Damien Le Moal=0A=
Western Digital Research=0A=
