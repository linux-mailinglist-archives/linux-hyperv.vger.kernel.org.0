Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 35BD0332ADD
	for <lists+linux-hyperv@lfdr.de>; Tue,  9 Mar 2021 16:45:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229790AbhCIPp1 (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 9 Mar 2021 10:45:27 -0500
Received: from mail-dm6nam10on2094.outbound.protection.outlook.com ([40.107.93.94]:41760
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230466AbhCIPpS (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 9 Mar 2021 10:45:18 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bdf4IAdyqLX9kh4cNyWxsX/vbcLL1AnLuemYnohirkGq15b87kAOxeIrt4VJL3+3FfCJAtPvtwXqz/+K5oetaqma6wPnjN8nKtVwgKl65cKR7J6xN23SA4vf4UdjxrAjdbK9XdCC14KKjwt0Yur7DoL1pUhKy3vtZj6R1NCNniyVlrC8BGphaEUfrFRnZhj8RP5+CjeGQj5JoEh5tbJhjEpRhuDj0r8kkVllVpC6EdIYyiNfkq4X/nXdj6RaU++40ycRgYv370qppyJBqa9xGR6C25B88FNoIcB0fx7y3ZR4p+jFE+aN/01OsJCamdFjPpHsa3E2F2brhkYwTLcm8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Yqu3KwHptcy278xyrzunYyqu/owdD4RdOtEjGpf1pNE=;
 b=lBb9dZhLdG+Xa3IPvZ9d01ROg4s3GVhQjwEvblOC2O4xafdqDxPCcySYiQ1IEm1DP0Q0J8cWl3eY7BCfV6B+mVNrkpmyS8BAewkacK67NtgJkoMMav8qnfFfG82iG2rBJdl0+3jM+ctzvSJ1Wa0mV3SDlZI3Y5xmv6LVbnwlbfJzZWfR1I/rM1Bd8DzqHSsL7dthrwnGgbPq3U4OSGsT4qIznPICUByscpsvLproo3tiMrC4S0nnGIOG/yHODVAjFTlL30TYIQcpdqRXxu9hz/mIq69e7dQwa+TRcUrXjaPKHFChg9b89SFZDGMnCVUc5udjP81eqiiHwb/VBv6eTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Yqu3KwHptcy278xyrzunYyqu/owdD4RdOtEjGpf1pNE=;
 b=g5DOAlbiQHy60ffD/f5FcjadH09jm3rkZrGJ8uPetHsuFY3+oDHJE9eosleWKWD6zWrSqM95lyvjkAfHsRcEtOQYDPkId/ekR/PdKFLFY5z1BmHGyXOKXJ8pf/BKRUb2VmShT/vINLXMUrgf3yg/C4pnNSgN2IXiUJSZQ/IfRhY=
Received: from MWHPR21MB1593.namprd21.prod.outlook.com (2603:10b6:301:7c::11)
 by MW2PR2101MB1818.namprd21.prod.outlook.com (2603:10b6:302:12::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3955.4; Tue, 9 Mar
 2021 15:45:15 +0000
Received: from MWHPR21MB1593.namprd21.prod.outlook.com
 ([fe80::9c8:94c9:faf1:17c2]) by MWHPR21MB1593.namprd21.prod.outlook.com
 ([fe80::9c8:94c9:faf1:17c2%9]) with mapi id 15.20.3955.008; Tue, 9 Mar 2021
 15:45:15 +0000
From:   Michael Kelley <mikelley@microsoft.com>
To:     melanieplageman <melanieplageman@gmail.com>
CC:     "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "andres@anarazel.de" <andres@anarazel.de>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        "jejb@linux.ibm.com" <jejb@linux.ibm.com>,
        KY Srinivasan <kys@microsoft.com>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "wei.liu@kernel.org" <wei.liu@kernel.org>
Subject: RE: [PATCH v1] scsi: storvsc: Cap cmd_per_lun at can_queue
Thread-Topic: [PATCH v1] scsi: storvsc: Cap cmd_per_lun at can_queue
Thread-Index: AQHXEhZt+ZHc82CPuUC0eGRm1QUsMap6KhHQgAA6cACAAVtXcA==
Date:   Tue, 9 Mar 2021 15:45:15 +0000
Message-ID: <MWHPR21MB15930820BBB37CF66D991CB9D7929@MWHPR21MB1593.namprd21.prod.outlook.com>
References: <20210305232151.1531-1-melanieplageman@gmail.com>
 <MWHPR21MB1593078007256C5155ED5A86D7939@MWHPR21MB1593.namprd21.prod.outlook.com>
 <20210308175618.GA2376@goldwasser>
In-Reply-To: <20210308175618.GA2376@goldwasser>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2021-03-09T15:45:13Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=6284258a-1de3-4602-9b75-67ff5d3a8ae1;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=microsoft.com;
x-originating-ip: [24.22.167.197]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: bf8b0a2f-6c78-446a-04bc-08d8e3125589
x-ms-traffictypediagnostic: MW2PR2101MB1818:
x-ms-exchange-transport-forked: True
x-ld-processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
x-microsoft-antispam-prvs: <MW2PR2101MB1818A03542D9EAD205708B03D7929@MW2PR2101MB1818.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: mYy8Kzw2HzB1SOMlYXTI+tgRjGasA1ZTgt7f1cl78WHsaNPmraZiTnuwbY3+JkFCbrPn4FcCTG+pP1jiQxMV3oIpI4rfsx+qZe6d39zy6hn+Yn/m7Dk1vcoHI8cBZ93uHsC9TG5OCpko8uJXqFxviRZe5cj1ISPtFsDiRGSRFN/q5ehDSt3gM6nYncLep+RToabMMHoifyJdG+zuKXKMIKUMbXeJ8zdtbb59QLoKA1xZ+738+HxJYSpFkb8ed3Br/lr5CD8XsRjP68AKMIrSNtSoOKiWqjiTIOvRrwGzjuGwbpgWJaRNsoAUE+9eVVrz6/mG5Bnj2tDtXxmbRsuduD5ULSIOk0f8qr9BID1sgMTEgKPro4prBk+XqZLp2Pg0fRSeHbU7/kWaGFbXgcsVr3iNW57O1WeJ93S29TYELQHOdC5hMF5hwVsWOhR4/xNZ0cJfZ+qajQVUJGm5NXZXeAQ2571ajGfl1awmaTPt+SLI0jWZfsSiOPHn0/0gM7QF5eHpgieSqcqSU6Q79+WDiVChNeaVsM457FO+r8/cNn5LZsSLUAgPesUwolAbiuhj
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR21MB1593.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(346002)(376002)(39860400002)(366004)(136003)(83380400001)(8990500004)(66556008)(52536014)(55016002)(71200400001)(76116006)(86362001)(82960400001)(33656002)(6506007)(478600001)(66446008)(4326008)(10290500003)(2906002)(26005)(82950400001)(66476007)(186003)(54906003)(64756008)(7696005)(66946007)(316002)(8676002)(6916009)(8936002)(9686003)(5660300002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?6BhiR0qrlqZcTtF44/f2K3ToWtWp53slGBalIHS0+EuiJRBi26RLmRf6JMYv?=
 =?us-ascii?Q?+q4fF/1x+VeNpfmG7DtS1UbJs20yUTcPXwgax1Lh4DxjXGI3XGpxULieV+BB?=
 =?us-ascii?Q?TdNwIDYD85pyBzS7ezN/9xPUuSchJsx1nGe8RRRdZLVftQdAMvrpE1t7XjLp?=
 =?us-ascii?Q?SRptcdNMzUayo+vyLgY7oD9LKfPfeaG73gCXmLcoZFDo702OzFpwh/lo/vyN?=
 =?us-ascii?Q?mSLDJ0r0GDvwYxDRUCs0WNcx0rN4dazkQstXwwNcpqWLjilRjp/dX5jVl9XU?=
 =?us-ascii?Q?QZ3nHya4GEC6hneTUfeGc7kgEIA+AvoR8FxXaf3OpmOxl4XGjMEPT9qLZSSi?=
 =?us-ascii?Q?xRq6iso+3HqUwTL3t+5cKKi2HnAKT+ycdb6ipzTyRYtr3oQk8pGfnV0zobHl?=
 =?us-ascii?Q?jJpPMswrQ9u8duN5pz0eVrc2QVD1nm9TjrAro8eqSJnNDFwf1I6VgZvEqCAw?=
 =?us-ascii?Q?hK2/XyafJylPdqJalZRaRPgwwN16p996Ud0AG3WYwqEYsW810z0Clo6/BFpR?=
 =?us-ascii?Q?y63CzGkJrfaEk2Qf9ICJJQhqmSNqEC83laChIsSmcL6XgnoZu4yLvzLXX0dd?=
 =?us-ascii?Q?ynnHTfRpHjo2WQJM9Fi9Xe8LaOKqQ2dwepc+G7qcg3EaOChj7Ehx2en64J9N?=
 =?us-ascii?Q?ooogIxiKD0TQ63bbvaZPNs4A3wNfVlDvnWLrZdmT3zn2uXbcPmV6cEGD5fer?=
 =?us-ascii?Q?veAd0TKyS7VQ4XyWzWW/nKujerVoNeE9oQYuQyogPrTkegsElQogItW/jQPq?=
 =?us-ascii?Q?Ccre70ygSAHvLuYEuGxe/MZs4pvsLwiLvb3+rmckTRlvsT81RrFb8xkVewIk?=
 =?us-ascii?Q?HnIT9Dpq0PitNRLc5jRJv4xADmcpyZv0Vcz3CbPmmeRoGuKg39Peu/LpaFmg?=
 =?us-ascii?Q?aamCBJoCVLkyiuwDeXIF4dyr2rnOjZZVOi8BtUTeyjYfRiFTDPCuo/hmZUdt?=
 =?us-ascii?Q?wYCt+xpemog7E6cdQ+MEjlZbEoVGoorZeRKRDr49lQNX4oriYtgp4KwAWtcv?=
 =?us-ascii?Q?mhbZcwqSeXLvycP+k0SWD/521GdrgTzFlEJ8cAKnRFv04rn9JryP+/y27uzL?=
 =?us-ascii?Q?iCarTIIGcvuAEjyw3flalUVOUJeJAZHfMAm2hUMoVf65g2yRAdX4TRutebS9?=
 =?us-ascii?Q?zcFtHwMMsT1cCqCGXSLTra88nmPXOoCseGH3Maop9g2ZGTegxj9qm3143Kee?=
 =?us-ascii?Q?Ll5bRXSWjL8CunPY++Cqi/eBNcSQqTOcGl+z+tE+Z9zKWQbZoo2FvsWTfZtE?=
 =?us-ascii?Q?ypbguov1E08pFx+JgUiWrmRQqkcyH4UHsZZzNkliLXo0DKFdDpBhBxyDnS2S?=
 =?us-ascii?Q?xX83SJbYe2/GATCnYaJvC/3C?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR21MB1593.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bf8b0a2f-6c78-446a-04bc-08d8e3125589
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Mar 2021 15:45:15.5175
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4Uqa/OuC4+d5rm4OdqEix9UkRyD8GETsimBFxH6n8m7Iu7x+YrqjqD1tfo9G+fAVAWbhpZ4lq6gIVBK1s+/x/8Z4UebfJcZanBr8uN5Iwl4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR2101MB1818
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

From: Melanie Plageman <melanieplageman@gmail.com> Sent: Monday, March 8, 2=
021 9:56 AM
>=20
> On Mon, Mar 08, 2021 at 02:37:40PM +0000, Michael Kelley wrote:
> > From: Melanie Plageman (Microsoft) <melanieplageman@gmail.com> Sent: Fr=
iday, March
> 5, 2021 3:22 PM
> > >
> > > The scsi_device->queue_depth is set to Scsi_Host->cmd_per_lun during
> > > allocation.
> > >
> > > Cap cmd_per_lun at can_queue to avoid dispatch errors.
> > >
> > > Signed-off-by: Melanie Plageman (Microsoft) <melanieplageman@gmail.co=
m>
> > > ---
> > >  drivers/scsi/storvsc_drv.c | 2 ++
> > >  1 file changed, 2 insertions(+)
> > >
> > > diff --git a/drivers/scsi/storvsc_drv.c b/drivers/scsi/storvsc_drv.c
> > > index 6bc5453cea8a..d7953a6e00e6 100644
> > > --- a/drivers/scsi/storvsc_drv.c
> > > +++ b/drivers/scsi/storvsc_drv.c
> > > @@ -1946,6 +1946,8 @@ static int storvsc_probe(struct hv_device *devi=
ce,
> > >  				(max_sub_channels + 1) *
> > >  				(100 - ring_avail_percent_lowater) / 100;
> > >
> > > +	scsi_driver.cmd_per_lun =3D min_t(u32, scsi_driver.cmd_per_lun,
> scsi_driver.can_queue);
> > > +
> >
> > I'm not sure what you mean by "avoid dispatch errors".  Can you elabora=
te?
>=20
> The scsi_driver.cmd_per_lun is set to 2048. Which is then used to set
> Scsi_Host->cmd_per_lun in storvsc_probe().
>=20
> In storvsc_probe(), when doing scsi_scan_host(), scsi_alloc_sdev() is
> called and sets the scsi_device->queue_depth to the Scsi_Host's
> cmd_per_lun with this code:
>=20
> scsi_change_queue_depth(sdev, sdev->host->cmd_per_lun ?
>                                         sdev->host->cmd_per_lun : 1);
>=20
> During dispatch, the scsi_device->queue_depth is used in
> scsi_dev_queue_ready(), called by scsi_mq_get_budget() to determine
> whether or not the device can queue another command.
>=20
> On some machines, with the 2048 value of cmd_per_lun that was used to
> set the initial scsi_device->queue_depth, commands can be queued that
> are later not able to be dispatched after running out of space in the
> ringbuffer.
>=20
> On an 8 core Azure VM with 16GB of memory with a single 1 TiB SSD
> (running an fio workload that I can provide if needed), storvsc_do_io()
> ends up often returning SCSI_MLQUEUE_DEVICE_BUSY.
>=20
> This is the call stack:
>=20
> hv_get_bytes_to_write
> hv_ringbuffer_write
> vmbus_send_packet
> storvsc_dio_io
> storvsc_queuecommand
> scsi_dispatch_cmd
> scsi_queue_rq
> dispatch_rq_list
>=20
> > Be aware that the calculation of "can_queue" in this driver is somewhat
> > flawed -- it should not be based on the size of the ring buffer, but in=
stead on
> > the maximum number of requests Hyper-V will queue.  And even then,
> > can_queue doesn't provide the cap you might expect because the blk-mq l=
ayer
> > allocates can_queue tags for each HW queue, not as a total.
>=20
>=20
> The docs for scsi_mid_low_api document Scsi_Host can_queue this way:
>=20
>   can_queue
>   - must be greater than 0; do not send more than can_queue
>     commands to the adapter.
>=20
> I did notice that in scsi_host.h, the comment for can_queue does say
> can_queue is the "maximum number of simultaneous commands a single hw
> queue in HBA will accept."=20

Yes, this comment is correct.  The can_queue value is per HW queue.

> However, I don't see it being used this way
> in the code.
>=20
> During dispatch, In scsi_target_queue_ready(), there is this code:
>=20
>         if (busy >=3D starget->can_queue)
>                 goto starved;
>=20
> And the scsi_target->can_queue value should be coming from Scsi_host as
> mentioned in the scsi_target definition in scsi_device.h
>     /*
>       * LLDs should set this in the slave_alloc host template callout.
>       * If set to zero then there is not limit.
>       */
>     unsigned int            can_queue;
>=20
> So, I don't really see how this would be per hardware queue.

For the storvsc driver, the can_queue value in the scsi_target is initializ=
ed
to zero in scsi_alloc_target() and it remains unchanged.  Maybe I'm missing
something, but the only place I see that sets starget->can_queue to a
non-zero value is iscsi_target_alloc().  The storvsc slave_alloc() function=
 does
not set it.  So the test in scsi_target_queue_ready() for exceeding can_que=
ue
never executes.

We've run live tests, and can see that the number of requests sent to the
storvsc driver exceeds the can_queue value when the # of HW queues is
greater than 1.  That result is consistent with what I see in the code.

Michael

>=20
> >
> > I agree that the cmd_per_lun setting is also too big, but we should fix=
 that in
> > the context of getting all of these different settings working together=
 correctly,
> > and not piecemeal.
> >
>=20
> Capping Scsi_Host->cmd_per_lun to scsi_driver.can_queue during probe
> will also prevent the LUN queue_depth from being set to a value that is
> higher than it can ever be set to again by the user when
> storvsc_change_queue_depth() is invoked.
>=20
> Also in scsi_sysfs sdev_store_queue_depth() there is this check:
>=20
>           if (depth < 1 || depth > sdev->host->can_queue)
>                 return -EINVAL;
>=20
> I would also note that VirtIO SCSI in virtscsi_probe(), Scsi_Host->cmd_pe=
r_lun
> is set to the min of the configured cmd_per_lun and
> Scsi_Host->can_queue:
>=20
>     shost->cmd_per_lun =3D min_t(u32, cmd_per_lun, shost->can_queue);
>=20
> Best,
> Melanie
